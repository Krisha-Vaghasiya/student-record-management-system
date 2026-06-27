<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Student Record Management System</title>
<style>
  :root {
    --navy:#1a2744; --blue:#2563eb; --blue-light:#eff6ff;
    --green:#16a34a; --green-light:#f0fdf4;
    --red:#dc2626; --red-light:#fef2f2;
    --amber:#d97706;
    --gray-50:#f9fafb; --gray-100:#f3f4f6; --gray-200:#e5e7eb;
    --gray-400:#9ca3af; --gray-600:#4b5563; --gray-800:#1f2937;
    --radius:8px;
  }
  * { box-sizing:border-box; margin:0; padding:0; }
  body { font-family:'Segoe UI',system-ui,sans-serif; background:var(--gray-50); color:var(--gray-800); }
  .header { background:var(--navy); color:white; padding:0 2rem; display:flex; align-items:center; justify-content:space-between; height:56px; }
  .brand { display:flex; align-items:center; gap:10px; font-weight:600; font-size:16px; }
  .brand-icon { width:30px; height:30px; background:var(--blue); border-radius:6px; display:flex; align-items:center; justify-content:center; }
  .container { max-width:1100px; margin:0 auto; padding:1.5rem 1rem; }
  .stats { display:grid; grid-template-columns:repeat(4,1fr); gap:12px; margin-bottom:1.5rem; }
  .stat { background:white; border-radius:var(--radius); padding:1rem 1.25rem; border:1px solid var(--gray-200); }
  .stat-label { font-size:12px; color:var(--gray-600); font-weight:500; text-transform:uppercase; letter-spacing:.05em; margin-bottom:4px; }
  .stat-val { font-size:26px; font-weight:700; color:var(--navy); }
  .toolbar { display:flex; align-items:center; justify-content:space-between; margin-bottom:1rem; gap:12px; }
  .search-form { display:flex; gap:8px; }
  .search-input { border:1px solid var(--gray-200); border-radius:var(--radius); padding:8px 12px; font-size:14px; width:260px; }
  .btn { display:inline-flex; align-items:center; gap:6px; padding:8px 16px; border-radius:var(--radius); font-size:14px; font-weight:500; cursor:pointer; border:none; text-decoration:none; }
  .btn-primary { background:var(--blue); color:white; }
  .btn-ghost { background:white; color:var(--gray-600); border:1px solid var(--gray-200); }
  .btn-sm { padding:5px 10px; font-size:13px; }
  .btn-danger { background:var(--red-light); color:var(--red); border:1px solid #fecaca; }
  .table-wrap { background:white; border-radius:var(--radius); border:1px solid var(--gray-200); overflow:hidden; }
  table { width:100%; border-collapse:collapse; }
  thead th { background:var(--gray-50); padding:11px 16px; text-align:left; font-size:12px; font-weight:600; color:var(--gray-600); text-transform:uppercase; letter-spacing:.05em; border-bottom:1px solid var(--gray-200); }
  tbody tr { border-bottom:1px solid var(--gray-100); }
  tbody tr:hover { background:var(--blue-light); }
  tbody td { padding:12px 16px; font-size:14px; }
  .badge { display:inline-block; padding:2px 8px; border-radius:4px; font-size:12px; font-weight:500; }
  .badge-MCA { background:#ede9fe; color:#6d28d9; }
  .badge-BCA { background:#dcfce7; color:#166534; }
  .badge-BTECH,.badge-BE { background:#dbeafe; color:#1e40af; }
  .actions { display:flex; gap:6px; }
  .alert { padding:10px 16px; border-radius:var(--radius); margin-bottom:1rem; font-size:14px; font-weight:500; }
  .alert-success { background:var(--green-light); color:var(--green); border:1px solid #bbf7d0; }
  .alert-error { background:var(--red-light); color:var(--red); border:1px solid #fecaca; }
  .empty { padding:3rem; text-align:center; color:var(--gray-400); }
</style>
</head>
<body>
<header class="header">
  <div class="brand">
    <div class="brand-icon">🎓</div>
    Student Record Management System
  </div>
  <span style="font-size:13px;color:rgba(255,255,255,0.6)">Java + JDBC + MySQL</span>
</header>

<div class="container">

  <%-- Flash message --%>
  <c:if test="${not empty sessionScope.message}">
    <div class="alert alert-${sessionScope.messageType}">${sessionScope.message}</div>
    <c:remove var="message" scope="session"/>
    <c:remove var="messageType" scope="session"/>
  </c:if>

  <%-- Stats row --%>
  <div class="stats">
    <div class="stat">
      <div class="stat-label">Total Students</div>
      <div class="stat-val" style="color:var(--blue)">${totalCount}</div>
    </div>
    <div class="stat">
      <div class="stat-label">Showing</div>
      <div class="stat-val">${students.size()}</div>
    </div>
    <div class="stat">
      <div class="stat-label">Search</div>
      <div class="stat-val" style="font-size:16px;padding-top:4px">${not empty searchQuery ? '"'.concat(searchQuery).concat('"') : 'All'}</div>
    </div>
    <div class="stat">
      <div class="stat-label">Status</div>
      <div class="stat-val" style="color:var(--green);font-size:16px;padding-top:4px">● Live</div>
    </div>
  </div>

  <%-- Toolbar --%>
  <div class="toolbar">
    <form class="search-form" method="get" action="students">
      <input type="hidden" name="action" value="search">
      <input class="search-input" type="text" name="q" placeholder="Search by name…"
             value="${not empty searchQuery ? searchQuery : ''}">
      <button class="btn btn-ghost" type="submit">Search</button>
      <c:if test="${not empty searchQuery}">
        <a class="btn btn-ghost" href="students?action=list">Clear</a>
      </c:if>
    </form>
    <a class="btn btn-primary" href="students?action=showAdd">+ Add Student</a>
  </div>

  <%-- Table --%>
  <div class="table-wrap">
    <table>
      <thead>
        <tr>
          <th>#</th><th>Name</th><th>Email</th><th>Course</th>
          <th>Semester</th><th>CGPA</th><th>Phone</th><th>Actions</th>
        </tr>
      </thead>
      <tbody>
        <c:choose>
          <c:when test="${empty students}">
            <tr><td colspan="8"><div class="empty">No students found.</div></td></tr>
          </c:when>
          <c:otherwise>
            <c:forEach var="s" items="${students}" varStatus="st">
              <tr>
                <td style="color:var(--gray-400)">${st.index + 1}</td>
                <td><strong>${s.name}</strong></td>
                <td style="color:var(--gray-600)">${s.email}</td>
                <td><span class="badge badge-${s.course}">${s.course}</span></td>
                <td style="text-align:center">${s.semester}</td>
                <td><strong>${s.cgpa}</strong>/10</td>
                <td style="color:var(--gray-600)">${s.phone}</td>
                <td>
                  <div class="actions">
                    <a class="btn btn-ghost btn-sm" href="students?action=showEdit&id=${s.id}">✏️ Edit</a>
                    <a class="btn btn-danger btn-sm"
                       href="students?action=delete&id=${s.id}"
                       onclick="return confirm('Delete ${s.name}?')">🗑️</a>
                  </div>
                </td>
              </tr>
            </c:forEach>
          </c:otherwise>
        </c:choose>
      </tbody>
    </table>
  </div>
</div>
</body>
</html>
