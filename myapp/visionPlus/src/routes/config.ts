import React, { lazy } from 'react';

export interface IRoute {
  name: string;
  path: string;
  component: React.LazyExoticComponent<React.FC<any>>;
}

const config: Array<IRoute> = [
  {
    name: 'index',
    path: '/',
    component: lazy(() => import('../pages/Index')),
  }
];

export default config;
