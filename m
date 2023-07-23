Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 998F975E16C
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jul 2023 12:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbjGWKgc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 23 Jul 2023 06:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGWKgb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 23 Jul 2023 06:36:31 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2112.outbound.protection.outlook.com [40.107.20.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FCA918C;
        Sun, 23 Jul 2023 03:36:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ol6qxJGJ0+Xg4AzcdvRkQq/1gGduXdiV61R/zWg21HcobZxOJ+BNupUXlhrZ4gXU1pnXHEMDm6zVayvIRhqTqaNUdtW6SsdnK9ukH9MHpNtsrXsy7DUZ6dnsh/NENMVcIg5TIKDCpCWO3BLPIykKpyiWtLvkBDDmTP+btVNFcormC9pk4/u27H/mxy19LJ/JBr+E9Jlw8QeOHm0rzDmF5eybw8xswI1lQc/bG3YwlwUsZeJAgE56/3pm1whahMenURNykmlu0NwlzZ+JqFUdKh2knnt2oNDQLXje1s12M26DQVlAiqGXxU3xvR0VE/EU5yfADZogXhahcZ7bzql+EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FVIq3SbNioClhYUFhzCuT6fEEPTEVvNHucs3I0C5Hd4=;
 b=aiWatQVPxX+n7Q8pJFJ9qp8ynve+bjJnEROTQNnTzY5IkBqGjtAiP69QEP1AM14JLOGpzHgOl1h9RH1eGzeAX5J51fT3/NmlkX/3z8k2P1vuHISbMDYNqeMEx2tkhye/IiX+2lHu3+qO6QioyyQvGHYeY7Zdq5AMidpPcGVeOhq2Ul7vbs/nmz7JFDEbt3UXgfTIzW+YNVhNor1TYWxJPjYA30dKRLJh9DdmaqMd+Y807fnF+F53wRC5pswXep2IzWhch0m/0erwbRWZS8nmB2mfcQ2lk4GKjMcnEeXJ4d/bbMLdwOkV/oZhZP2sujWZHzoJT+DBesspfXa/J1b0bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FVIq3SbNioClhYUFhzCuT6fEEPTEVvNHucs3I0C5Hd4=;
 b=YwUaeLWG/U+GmpqkZu780Ny1ct518f8NlLim2LKM2hSrkUXeHEDZVHYPrGgslLFwpDMj1z7CeoOm48lwejrA+D134GikYnEgKkxKQf1z7cQvxO+0SxPiJm5B6yf08ZePtWp9OoPpQydoWRe6j14NW0myb8K7dHyrIt44XEf2FBw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com (2603:10a6:208:ed::15)
 by DB4PR02MB9360.eurprd02.prod.outlook.com (2603:10a6:10:3fb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.21; Sun, 23 Jul
 2023 10:36:25 +0000
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::2a6d:c845:6c5:2aad]) by AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::2a6d:c845:6c5:2aad%4]) with mapi id 15.20.6631.023; Sun, 23 Jul 2023
 10:36:24 +0000
Message-ID: <cf71c4ab-58c4-fef8-2ce3-5ca32f9f2f91@axentia.se>
Date:   Sun, 23 Jul 2023 12:36:16 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2] iio: potentiometer: mcp4018: Use i2c_get_match_data()
Content-Language: sv-SE, en-US
To:     Biju Das <biju.das.jz@bp.renesas.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
References: <20230721071603.158114-1-biju.das.jz@bp.renesas.com>
 <6e5a099e-57bb-7eb3-212b-494b5c30e4d7@axentia.se>
 <OS0PR01MB592290B83D0EEA1928DB4D2A863DA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
From:   Peter Rosin <peda@axentia.se>
In-Reply-To: <OS0PR01MB592290B83D0EEA1928DB4D2A863DA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0110.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::26) To AM0PR02MB4436.eurprd02.prod.outlook.com
 (2603:10a6:208:ed::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR02MB4436:EE_|DB4PR02MB9360:EE_
X-MS-Office365-Filtering-Correlation-Id: 4eddb48b-2388-413e-1fa8-08db8b68a9e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xYBOGjSldC7uDU2p7/ipdVhKo0sbOnCG2agdifr6J4Y60vNRIhkZQ9vfDlGAoKIvhOUFyE/0KulJkIJWoEb6iMHnejZJir1NdPinxDkoOMp0hIxlQclr2MjDyjdQCQbQGR7PDk5GRkTmlkqaCL9Wzgcey+N8MqCX9t5GqjtCq8h+VbH8/Yq26dDymeMn/3z/TntleliZGVI8Bl2MnygskKynwXlqzevuANYJ2xOkSfr7BkLABZaZmCOgBDTV2lz5tWoXoIHi8nrfQiBrd3eJuII6/gwW7csUozwzjR9NS79/Pw+HByzpucwDs79EPwAgTPjxhccrPOWc1bqq8xzHo1NPcNpoAI+w3zW+6Qa8W6EErKX4+2rAj+W+5vOJD/hQfzPVY0Mvl7gvb40Ha1EQaph4iLh2zeDsQxEw5AFeD6G0e0THeyDzymV1zd0bVwDqiVTd1aMIXD59cXXOVHIri8zA5QjlCbvR/FvjLx3d4dSeuzmE1sqeLPKPHSbFfQ3bj+WnB8caTukKzqNoJAQswRzefnTiUm5uLz27TMLjhI5djwUVq3TfpeyBzAcUJTqSoc7WJZdIRuWDiblvE2EPxNVglC1IBNJtBN3z+5V0SKnfkS4Sc3Tn5eqzWyKLzA5TtFtu+HjO8SL21BVVaHaNqA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB4436.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(376002)(396003)(39830400003)(366004)(451199021)(8936002)(8676002)(316002)(5660300002)(4326008)(66476007)(66556008)(66946007)(110136005)(38100700002)(54906003)(31686004)(26005)(41300700001)(6506007)(83380400001)(478600001)(186003)(2906002)(966005)(6512007)(31696002)(36756003)(86362001)(6486002)(6666004)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NzF2RVRHeWM3YUdKVFNSV1BVVEZqRXZxbTJXZW1veFVTQ1dnRjZFQTZOTW5Z?=
 =?utf-8?B?emhqZDBzYzRSZWJWTm1kKzk0ZEluUFozLzdyWjRlRjlDc0g2ZXFhMms5RWxX?=
 =?utf-8?B?TjQxdUx4ZWhyTitXbzkwY0xJUEpnZFh1Q3FDR1FQY0VaUFQ3cWl3eENCRmlU?=
 =?utf-8?B?SXdxcUlmWXZUNkVoS3NBZHVsK2FCbndQcGc2UktEckV5WlNNMnRkOTE2N1da?=
 =?utf-8?B?eEVRbDFpZ2tzaUU4OERrVlBXR0RBdDhURjQxRXVZK2I2R05McWlHc3RCTUNo?=
 =?utf-8?B?OFhIYjZyNkJBSUUzN2tlc0Z1SFByTndQMXdXL1NvR0RHdDMvRTN4bk5XNlJ2?=
 =?utf-8?B?UEYyRnMveU4zaTBHQk5pcHpYT2VVY3g4eENFOEZNckdwdlVkWnBTbDhnVW83?=
 =?utf-8?B?QlJ1ZkNHMSsvVHdNNUZROXZ0ZGkvV01KcWtyWDM2cVYrOFVCa0tqalhPRGw2?=
 =?utf-8?B?RHVvSE8yS1pkSUdneVR1Ni9MSDAzbWYyMHhuTnhXN0Q3dVlmWXZSTVJBNUtU?=
 =?utf-8?B?L244VXZOa09LRWoxajZ0ekd0NUVUamFpRVFQVzlJSkdtL3ZzWjA5NkNtbldZ?=
 =?utf-8?B?Ujd6MG5QRmVtRmZHWkZUSVBqRVhBNG1Uem03Z1pHU3NnS1dWV2pUUDZDZzYw?=
 =?utf-8?B?WEVZS2c5K0RiN2JnTWpSYXY3aHRSOTdnejdnWTM1bTBuaUlheU1LcHQyL3lj?=
 =?utf-8?B?L213NmVaZTdCMDZldUxIb3pidXBTcXAzZVZSMFpSSlNkRVlFK2kxTHdyYWxv?=
 =?utf-8?B?Vk0rd01rSVVZM3U0bmlzT245TUZteCs5WmxsMC9KVUhUVEpqWHQ0UUowcExT?=
 =?utf-8?B?eVRjZUlMRlJUUUQzSml1VXc1Q2FFaENLczBoaWkrWnlkcVhnUGVIRHFGQ3FT?=
 =?utf-8?B?OGJXQ2IyOXFkTVQ0RWl5SXNTcEZmdkVJQTRaVUp0R2dZMzdqdit0VXI0NlJW?=
 =?utf-8?B?VFpXZHdGVFVNSGRubmt2YzJJUFlCT0lyNzZnM00wbm9hNk0rczJ0U1djd2t5?=
 =?utf-8?B?NVZGZ3Z6cEpyZXpzQzBkMW5QMktWVFBSS3J5UDk1alV5V2VUdHZhYXBldkkz?=
 =?utf-8?B?TzVmOFVmeDlPTWszU29FK2JweXMvZ2ZsMzdySExrampMWmxITkVwREdxNTho?=
 =?utf-8?B?WnZ1bm1UN2JrRFN5S01Bbjl5WTVwZEhBNEl1bjdlSFFIYXBLdUlYNDBEYmRm?=
 =?utf-8?B?bm9VL3U4R1BvL2RZOVdvQzVzSUJ4QjZkU0xXSitackxMUHdpamFldkoxV0dp?=
 =?utf-8?B?d0xVRWV1UDRnalhxNVViTVlKbnVpeXdkQXA0c1h5Zy9tRnpkZ1kxRExLWDVl?=
 =?utf-8?B?UStJR1p3VDFiY2JRdkxuNVJEMnUybzFEVU8zaXNEMG9nb3NmZWxQZE5IUW9X?=
 =?utf-8?B?a2RXemN6TEdnM0ZzVWd3TlUvaTAvZnFWcDV6RUJmRkdsOWtpeFV1eWYwTUdt?=
 =?utf-8?B?amZoTXoxekJ6YzQxUXZDODFnYVNLTUFhU1krQ1NJTUc3cEIrMEtLMU1CZy9N?=
 =?utf-8?B?SW15aWcvUXl3bndjclN1NjIyOVIzbXdsbkFSLzF6ZlRTU0NSSk9WeG5QTzd4?=
 =?utf-8?B?QjIwcEQvcmdRU3RSTFpXai9peEpvb2RXZ2lMR1dtKzVmRmhOZkRXRVErRld2?=
 =?utf-8?B?T1ZQajgzVUZCcXhpSmxuZmlEallLQlhnWVlSMjVmU3pWT0NFYzd4RFNuZFhZ?=
 =?utf-8?B?aVpUQ1pweGxsNWUzb3IyQ0x0SElJSkZVVGxDYUM0Z1ozazdPZm5zdlVQWW5z?=
 =?utf-8?B?RzNPc3hkVGhSeHFmY1RKbkFXWThnWE9QTkhNdC9WcE9nZTFOQ215UE5pZWtj?=
 =?utf-8?B?TG5nOHRYRFJHTGhIenN6d05hTGNyWFN6K1AyVERrVWlBNEVNRS91YVNSVElS?=
 =?utf-8?B?ZHVMZUc4TVQ5Vk9IN1NNS3NZSUQ0aXd1dGsyMVo1NXh6YXY2VGlveVhpTkFm?=
 =?utf-8?B?NU00YjVocTZJNVhicWRldVEzNEZ1cXBRdUZEZkpUeVZIUnVoOVZLMG82M2sw?=
 =?utf-8?B?ZmN4MTBURlpMZGVNQXhCb015NXlmVnViTDhWUVM3WVJTUndpYmFZZFlmV01E?=
 =?utf-8?B?RmtIUThaNTNPYkxsU0VZVkpFbjNodnhFQlNIaGF1VndyNTdOeWlCSWhzSXAy?=
 =?utf-8?Q?XbhEi97Lr8s9lbytOnHU9YZUv?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eddb48b-2388-413e-1fa8-08db8b68a9e8
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB4436.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2023 10:36:24.8233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H1IOVKSvdk3YR32JYLy4o0lAtzBPdP2Bck0m8sIjzXJcFExbfFfVrQjgCif7ZhXV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR02MB9360
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi!

2023-07-23 at 08:12, Biju Das wrote:
> Hi Peter Rosin,
> 
> Thanks for the feedback.
> 
>> Subject: Re: [PATCH v2] iio: potentiometer: mcp4018: Use
>> i2c_get_match_data()
>>
>> Hi!
>>
>> 2023-07-21 at 09:16, Biju Das wrote:
>>> Replace of_device_get_match_data() and i2c_match_id() by i2c_get_match
>>> _data() by making similar I2C and DT-based matching table.
>>>
>>> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
>>> ---
>>> v1->v2:
>>>  * Added similar similar I2C and DT-based matching table.
>>>  * Fixed typo i2c_get_match_data(dev)->i2c_get_match_data(client).
>>>  * Dropped error check as all tables have data pointers.
>>>
>>> Note:
>>>  This patch is only compile tested.
>>> ---
>>>  drivers/iio/potentiometer/mcp4018.c | 34
>>> +++++++++++++++--------------
>>>  1 file changed, 18 insertions(+), 16 deletions(-)
>>>
>>> diff --git a/drivers/iio/potentiometer/mcp4018.c
>>> b/drivers/iio/potentiometer/mcp4018.c
>>> index 89daecc90305..b064e86ecce8 100644
>>> --- a/drivers/iio/potentiometer/mcp4018.c
>>> +++ b/drivers/iio/potentiometer/mcp4018.c
>>> @@ -99,20 +99,24 @@ static const struct iio_info mcp4018_info = {
>>>  	.write_raw = mcp4018_write_raw,
>>>  };
>>>
>>> +#define MCP4018_ID_TABLE(name, cfg) {				\
>>> +	name, .driver_data = (kernel_ulong_t)&mcp4018_cfg[cfg],	\
>>> +}
>>
>> It is inconsistent to have a named field for .driver_data but not for
>> .name. Also, I dislike the cast and wonder if the trivial simplification
>> in probe() is really worth this churn when that ugly cast is needed? 
> 
> It saving lines of code and better than, &mcp4018_cfg[i2c_match_id(mcp4018_id, client)>driver_data]; right??

If saving lines is your goal, you have failed with this +18-16 patch,
even with this compressed way of expressing things that could be
expressed more clearly with an extra line. Not that a couple of extra
lines would have mattered if the change would have otherwise been an
improvement. And no, I don't think the cast is better than the
existing code. We could of course argue about that, but it quickly
descends into a bikeshed discussion.

My point is that this patch trades one ugliness for another while
bringing in no real change. It is thus not a clear improvement to me,
and I question its value. What is the point?

Why not work on something that is going to make a real difference,
such as unifying the module device tables so that drivers don't
need to add almost-duplicated tables, or something, instead of only
doing minor syntax changes for expressing the same thing? With a
single unified table, it would be very natural to have the same match
data everywhere...

> 
>> The
>> reason the two tables differ and do not both have pointers already is
>> precisely my dislike for that cast.
> 
>>
>> Anyway, something like this instead? Or _name instead of id?
>> Whatever...
> 
> OK, will use _name.
> 
>>
>> #define MCP4018_ID_TABLE(id, cfg) {				\
>> 	.name = id,						\
>> 	.driver_data = (kernel_ulong_t)&mcp4018_cfg[cfg],	\
>> }
>>
>>> +
>>>  static const struct i2c_device_id mcp4018_id[] = {
>>> -	{ "mcp4017-502", MCP4018_502 },
>>> -	{ "mcp4017-103", MCP4018_103 },
>>> -	{ "mcp4017-503", MCP4018_503 },
>>> -	{ "mcp4017-104", MCP4018_104 },
>>> -	{ "mcp4018-502", MCP4018_502 },
>>> -	{ "mcp4018-103", MCP4018_103 },
>>> -	{ "mcp4018-503", MCP4018_503 },
>>> -	{ "mcp4018-104", MCP4018_104 },
>>> -	{ "mcp4019-502", MCP4018_502 },
>>> -	{ "mcp4019-103", MCP4018_103 },
>>> -	{ "mcp4019-503", MCP4018_503 },
>>> -	{ "mcp4019-104", MCP4018_104 },
>>> -	{}
>>> +	MCP4018_ID_TABLE("mcp4017-502", MCP4018_502),
>>> +	MCP4018_ID_TABLE("mcp4017-103", MCP4018_103),
>>> +	MCP4018_ID_TABLE("mcp4017-503", MCP4018_503),
>>> +	MCP4018_ID_TABLE("mcp4017-104", MCP4018_104),
>>> +	MCP4018_ID_TABLE("mcp4018-502", MCP4018_502),
>>> +	MCP4018_ID_TABLE("mcp4018-103", MCP4018_103),
>>> +	MCP4018_ID_TABLE("mcp4018-503", MCP4018_503),
>>> +	MCP4018_ID_TABLE("mcp4018-104", MCP4018_104),
>>> +	MCP4018_ID_TABLE("mcp4019-502", MCP4018_502),
>>> +	MCP4018_ID_TABLE("mcp4019-103", MCP4018_103),
>>> +	MCP4018_ID_TABLE("mcp4019-503", MCP4018_503),
>>> +	MCP4018_ID_TABLE("mcp4019-104", MCP4018_104),
>>> +	{ /* sentinel */ }
>>>  };
>>>  MODULE_DEVICE_TABLE(i2c, mcp4018_id);
>>>
>>> @@ -157,9 +161,7 @@ static int mcp4018_probe(struct i2c_client
>> *client)
>>>  	i2c_set_clientdata(client, indio_dev);
>>>  	data->client = client;
>>>
>>> -	data->cfg = device_get_match_data(dev);
>>> -	if (!data->cfg)
>>> -		data->cfg = &mcp4018_cfg[i2c_match_id(mcp4018_id, client)-
>>> driver_data];
>>> +	data->cfg = i2c_get_match_data(client);
>>
>> NULL-check here? I know the original i2c_match_id call is not checked
>> for non-matches, but that feels like a simpler function than
>> i2c_get_match_data. And less prone to changes.
>>
>> Same comments of course applies to the mcp4531 patch as well.
> 
> Some subsystem people doesn't want error check as all tables have data pointers. See [1]
> 
> [1] https://lore.kernel.org/linux-renesas-soc/20230717145623.473cffca@booty/
> 
> I am leaving subsystem maintainer to take final word on this.
> 
> The new API is very simple [2]
> [2] https://elixir.bootlin.com/linux/v6.5-rc2/source/drivers/i2c/i2c-core-base.c#L124

I have of course read that already. Even if it is simple, the new
API is decidedly more complex than old, since the new API wraps
the old and adds stuff around it.

But do note that I am not pushing hard for adding a NULL-check.

Cheers,
Peter

> 
> Cheers,
> Biju
> 
>>>
>>>  	indio_dev->info = &mcp4018_info;
>>>  	indio_dev->channels = &mcp4018_channel;
