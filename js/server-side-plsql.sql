-- Created on 4/16/2015 by IDRENSKI
DECLARE
   -- Local variables here
   -- JSON test

/*
 {"result":[
            {"account":"9182989357","currency":"RON","origin":"ATL"},
            {"account":"9182989365","currency":"RON","origin":"ATL"}
            ]
        }
 */

   obj_json json;
   obj_list json_list;
   obj_json_value json_value;

BEGIN
   -- Test statements here
   obj_json := json();
   obj_list := json_list();

   FOR va IN (SELECT a.acc_acct_no, a.acc_curr_code, a.acc_origin
                FROM ibank.accounts a
               WHERE ROWNUM <= 2)
   LOOP
      obj_json := json();
      obj_json.put('account',va.acc_acct_no);
      obj_json.put('currency',va.acc_curr_code);
      obj_json.put('origin',va.acc_origin);

      obj_list.append(obj_json.to_json_value);

   END LOOP;

   obj_json := json();
   obj_json.put('result',obj_list.to_json_value);

   /* below is a check if can access the data
   */
   obj_json_value := obj_list.get(2);

   obj_json.print(spaces => TRUE, chars_per_line => 100, jsonp => '');
   dbms_output.put_line('************************************');
   dbms_output.put_line('number of elements: ' || obj_list.count);

   dbms_output.put_line('value of second element is: ');
   obj_json_value.print(spaces => TRUE, chars_per_line => 100, jsonp => '');

END;
