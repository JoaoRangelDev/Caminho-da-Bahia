const env = 'local';

String returnEnv(env) {
  if (env == 'prd') {
    return 'Ambiente de produção';
  } else if (env == 'local') {
    return 'http://10.0.2.2:8080/api';
  } else {
    return 'Ambiente não localizado';
  }
}



class Api {
  static String key = 'AIzaSyCZJvXD4IzfoNZExq-hr3xhBtsHbZkwltE';

}


