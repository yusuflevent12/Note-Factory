import React from 'react';
import { NavLink } from 'react-router-dom';

/**
 * Sol tarafta yer alacak ve genellikle ana navigasyon öğelerini (dersler, kategoriler vb.)
 * içerecek olan kenar çubuğu (sidebar) bileşeni.
 * MVP aşamasında daha basit tutulabilir ve ileride geliştirilebilir.
 */
const Sidebar = () => {
  // Örnek Hiyerarşi Verisi (Bu veri normalde API'den gelir)
  const hierarchy = [
    {
      university: 'Erciyes Üniversitesi',
      faculties: [
        {
          name: 'Mühendislik Fakültesi',
          departments: [
            { name: 'Yazılım Mühendisliği', id: 1 },
            { name: 'Bilgisayar Mühendisliği', id: 2 },
          ],
        },
      ],
    },
  ];

  return (
    <aside className="w-64 bg-gray-50 p-4 border-r border-gray-200">
      <h2 className="text-lg font-semibold text-gray-800 mb-4">
        {hierarchy[0].university}
      </h2>
      <nav>
        <ul>
          {hierarchy[0].faculties.map((faculty) => (
            <li key={faculty.name} className="mb-4">
              <h3 className="font-semibold text-gray-700">{faculty.name}</h3>
              <ul className="mt-2 pl-2 border-l border-gray-300">
                {faculty.departments.map((dept) => (
                  <li key={dept.id}>
                    <NavLink
                      to={`/course/${dept.id}`} // Bu URL yapısı App.jsx'te tanımlanacak
                      className={({ isActive }) =>
                        `block py-1 px-2 rounded-md text-sm ${
                          isActive
                            ? 'bg-blue-100 text-blue-700'
                            : 'text-gray-600 hover:bg-gray-100'
                        }`
                      }
                    >
                      {dept.name}
                    </NavLink>
                  </li>
                ))}
              </ul>
            </li>
          ))}
        </ul>
      </nav>
    </aside>
  );
};

export default Sidebar;
