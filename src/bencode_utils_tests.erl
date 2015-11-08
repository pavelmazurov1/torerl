-module(bencode_utils_tests).
-compile(export_all).

run_all_tests()->
	test_makes(),
	test_simple_presintation(),
	test_dict_find(),
	ok.

test_makes()->
	{bytestring, 8, <<"announce">>} = bencode_utils:make_bytestring(<<"announce">>).
	
test_simple_presintation()->
	<<"announce">> = bencode_utils:get_simple_presintation({bytestring, 8, <<"announce">>}),
	42 = bencode_utils:get_simple_presintation({number, 42}),
	[<<"publisher">>, <<"rutor.org">>] = bencode_utils:get_simple_presintation({list, [{bytestring,9,<<"publisher">>},
        {bytestring,9,<<"rutor.org">>}]}),
	[<<"announce">>, <<"udp://bt.rutor.org:2710">>] 
		= bencode_utils:get_simple_presintation({dict,
				[{bytestring,8,<<"announce">>},
				{bytestring,23,<<"udp://bt.rutor.org:2710">>}]
			}).
			
test_dict_find()->
	Dict = {dict,
				[{bytestring,8,<<"announce">>},
				{bytestring,23,<<"udp://bt.rutor.org:2710">>}]
			},
	{ok, {bytestring,23,<<"udp://bt.rutor.org:2710">>}} = bencode_utils:dict_find_by_key(<<"announce">>, Dict).