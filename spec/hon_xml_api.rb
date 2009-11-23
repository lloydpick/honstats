HONXML = {
  :nick2id => {
    :xml => %{<?xml version="1.0" encoding="UTF-8" ?><accounts>
            <account_id nick='honstats_test'>12345</account_id>
            </accounts>},
    :params => {"nick[]"=>['honstats_test'], "opt"=>"nick"}
  },
  :id2nick => {
    :xml => %{<?xml version="1.0" encoding="UTF-8" ?><accounts>
                <nickname aid='12345'>honstats_test</nickname>
                </accounts>},
    :params => {"aid[]"=>[12345], "opt"=>"aid"}
  }
}
