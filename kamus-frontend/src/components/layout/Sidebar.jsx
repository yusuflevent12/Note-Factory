import React from 'react';

const Sidebar = () => {
  return (
    <aside style={{ width: '200px', padding: '20px', background: '#f8f8f8', borderRight: '1px solid #ccc' }}>
      <h3>Dersler</h3>
      <ul>
        <li>Yazılım Mühendisliği</li>
        <li>Veri Yapıları</li>
        <li>Algoritmalar</li>
      </ul>
    </aside>
  );
};

export default Sidebar;
