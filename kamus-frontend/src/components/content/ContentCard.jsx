import React from 'react';

const ContentCard = ({ title, description }) => {
  return (
    <div style={{ border: '1px solid #ccc', padding: '15px', marginBottom: '15px', borderRadius: '5px' }}>
      <h3>{title}</h3>
      <p>{description}</p>
    </div>
  );
};

export default ContentCard;
