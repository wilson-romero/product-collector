import { useContext, useEffect } from 'react';
import { useRouter } from 'next/router';
import { TrendContext } from '../context/trend-context';

import Page from '../components/page';
import CompareKeywords from '../components/compare-keywords';
import Filters from '../components/filters';
import DashBoard from '../components/dashboard';
import Test from '../components/test';

export default function ExplorePage() {
  const router = useRouter();
  const { keywords, setKeywords } = useContext(TrendContext);

  useEffect(() => {
    const { search } = router.query;
    search && setKeywords(search.split(','));
  }, [router.query.search]);

  return (
    <Page>
      <>
        <CompareKeywords />
        <Filters />
        <DashBoard />
        {/* <div>Gráfico - Cantidad Productos vendidos (?)</div> */}
        {/* <div>Gráfico - Precio Promedio - Por País</div> */}
        {/* <div>Gráfico - Búsquedas - Por País</div> */}
        {/* <div>Lista - Productos relacionados</div> */}
        {/* <hr/> */}
        {/* <Test /> */}
      </>
    </Page>
  );
}
