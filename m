Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A653F3FB6AF
	for <lists+linux-iio@lfdr.de>; Mon, 30 Aug 2021 15:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234032AbhH3NEx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Aug 2021 09:04:53 -0400
Received: from mail-eopbgr20110.outbound.protection.outlook.com ([40.107.2.110]:46850
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231950AbhH3NEx (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 30 Aug 2021 09:04:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A+b8NnIAQk9bzuTN1G6DRygYKxVUed6PfIW5SAcM784MFPQH4RTMYk1cHENN25CA4EXUBdq5zRmVzSM+ryugAy1KgFhVwk4EQ4AAUyaehI8JknI0vdlPAwq/5ZbuliRWin5vuNJ978+alLMAz9V+/ythMV75KJHVwkyFGjnI8kuiU0VmZaioxJ/173T6c3PeiuYHzLFqgA7+ptjlzVNWaZlJXbTK9ruwESh2lHHx6OoS0RlkCA1cEYfh6iMw9WjtZyuGa9lmJnvcy2R5sKV0nKDM8uz/q9Z72/IllQncugN/KO9MPYgsf5pHThMUPIsRqXe1WC0jXeLO5CwezcQ39Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hyW7k1k2kZVLythgvm4sU3nTpw0JMQyto26CE0PrJ9g=;
 b=Y9lDPctc5S8qFvgwQmO978n09diyfK26rfbqfhCUI+jpQbjOmSkzragjnsn6jF8WTi4Tp8+vQrZtSqrDMR/yGk0OAVihGbDKxYf4VgblEX/u49lL/TLG7GV/nyDcvPxT8fyviE2eEqUq5pd06scw9GnOLu1BlBcLPowyINgxBTeB1I8ovOLK6hsgNGoyQ7meW9XwA+Ppx3gMN3I9rYctzBSGc2C0r98k5OQ8owYctB66rxXhrHQqb2A+dad797Xk8jhDzqZX92kbw6WP4z8SNSKmNTtM5ZhWsTcmUQ6r/8TssjDOuRsakkPrpp3pxpI1Mp35Q0OLWtX0zjbbY+q0Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hyW7k1k2kZVLythgvm4sU3nTpw0JMQyto26CE0PrJ9g=;
 b=hCiAm7BxLwr52I7y9phZGMUD7XvGg0vunaXnTeq+IqC79jkL7Br4FG9NiYOQVUxB73nMCRbMn/ofMu3rw5NL0Y+zPBglAcWUN7h3CXo8pDYKosQtAapHVbgGjqHwqDRv8UV/hK/x0Ra7PBzH385TRn719OUP5MRvjj9BOGYlw8c=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB9PR02MB7018.eurprd02.prod.outlook.com (2603:10a6:10:222::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17; Mon, 30 Aug
 2021 13:03:55 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::35c9:1008:f5af:55a]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::35c9:1008:f5af:55a%4]) with mapi id 15.20.4457.024; Mon, 30 Aug 2021
 13:03:55 +0000
Subject: Re: [PATCH v8 09/14] iio: afe: rescale: fix accuracy for small
To:     Liam Beguin <liambeguin@gmail.com>
Cc:     jic23@kernel.org, lars@metafoo.de, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org
References: <YSVWZcjW8QoDaSpN@shaak>
 <c63fb63f-884d-0ffb-b25c-bac591f169f7@axentia.se> <YSsP8aWU2uFBOt6M@shaak>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <d714a5ca-07d6-1e6b-53d6-3353fe24e485@axentia.se>
Date:   Mon, 30 Aug 2021 15:03:52 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <YSsP8aWU2uFBOt6M@shaak>
Content-Type: text/plain; charset=utf-8
Content-Language: sv-SE
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR0202CA0016.eurprd02.prod.outlook.com
 (2603:10a6:3:8c::26) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.13.3] (85.229.94.233) by HE1PR0202CA0016.eurprd02.prod.outlook.com (2603:10a6:3:8c::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.18 via Frontend Transport; Mon, 30 Aug 2021 13:03:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2eb4bfcb-adfa-4a6e-6121-08d96bb69f30
X-MS-TrafficTypeDiagnostic: DB9PR02MB7018:
X-Microsoft-Antispam-PRVS: <DB9PR02MB7018B17448595B885FA37051BCCB9@DB9PR02MB7018.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qJOBhXj7s203BOO0tn/THJILT4Bg//Wli+Snv1tz7sRkWGiIX5lTs2NrrOMsOJiCwanSIpb6b0wrC2/3cDv/gPJJWxvlwqfkmQs+BK8L2BxkMcfvI/qcZgaGnlSIWah6dKbvCk81pZvqr1rozGNyUb7T0iaZXsVRFCa6tWRV0kNw5Q89uLV/wErnE5dJDYeuwJl1EctHTTQQujFl67F6BO8ymH1aQiuZ85j+uNXcwwzVwQSqj1RTfjb4L2LfDYkcUHX5FXBb7j+mXG0h3TR3N856QsX5SKBJhIDCt2So0XBG5nXQ73IrRwct2hOIdPR78blUp/lGdJuVlmfBCSCTcLz4R82sQlNhWUykcACgCkmGDXw+t8J3Mk4h9GvGGL8yOPD82HdIkJ0Zim4nHlCv3PQWRLSPyZOe3aL53XuIswvjOCwZXCZMN2Z10uWAxoxL3+gLhUR0ZEK+xfkxiQPLHTlkaWXWlFWiLlGyafSBO05xSyuZYYWdlhH1QrM2VSMCzdsEh+pZ3EisWuAV9kOBJw1e9l8VQHJ10IZzXQDUC5sDbdhlbaAz6mxAK6fyRx5O1YnZ6sSrtA0XlXQNZOHGStKmGJ/nixpXg/rZKEyZ7arxT7BoiN06Ha4T2XE8ZThbDTtM9wllw65hhWHiMdFSSklRKEAabytc2P8OM8TeejywMMpl7zGPADwpk0ejVi+JYAh2hktnv0vMmj0WNwtE2JjUq1DCtfsK3mtgOLUWchk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(346002)(366004)(39840400004)(136003)(31686004)(5660300002)(6486002)(36756003)(66946007)(478600001)(16576012)(83380400001)(66556008)(66476007)(53546011)(316002)(2906002)(8676002)(31696002)(4326008)(2616005)(186003)(26005)(956004)(36916002)(8936002)(6916009)(38100700002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWdyMGVId05WSXYyZmhSVFEyS29WUTM0azhBU1FDYUVaSndnbWV0aDF3VlB3?=
 =?utf-8?B?ZWRjZWtSYUoya1g4bzB2b1FSdXVTM212Tmc3VmNHaHZoVXBJUDlzS2FVbUxD?=
 =?utf-8?B?aGszbFYremtoWk1MM0NMSVRPRHI2UG9DSGFFSjJ5bjArRk9aWk1RY1poYWZr?=
 =?utf-8?B?RHhyekZXbWZMNnBDcHcvTUFJZUUxdGcxYU0zQjFESmc4ZDdnN282TGF3Slhx?=
 =?utf-8?B?YjVxbWVzcENZc2hKVnRWRXRXUTVWdVh4RXZDYVdqMUZuM1RLYWJIQjJpMytn?=
 =?utf-8?B?Y1FNbFYrMm5tZzZTT0pKZU8vRS9lMVRES29sdlF3TkI3U0RPc2prYVhMajhp?=
 =?utf-8?B?OFB0REZUQ1NuRCtScGNLcVl3Nmx2NzluS2lFb3kxWlQrbzRTbnhYQ2xFT0dL?=
 =?utf-8?B?K2ZmUEFzaEFqNVZ6MUVlemN0dUoxUy9GdHBDSlo0WkQ2WndHMDRLTE03SFQ1?=
 =?utf-8?B?UENHOWYwNWpuaG84TlJNeU5pbytKQXVaZmdSV1VzZ2tkeUxhbU0wUXFEcm53?=
 =?utf-8?B?UUlsOGhiOExBU3FJQmhWNG96WFQ4ZGo2djUwa1NCa3paalk1ZjV0MitNQkxT?=
 =?utf-8?B?Zm9ndVVGeVEyOHV1RHpqZ2QxNEp3V2dGNC9FR2oxbERaOXhWcllDNDNjRmRM?=
 =?utf-8?B?SmZZejJkOG1NbDloTGlVV2R1cUhNdXllWWl1bElFMkUrbFk5TzFLTkFnK3l1?=
 =?utf-8?B?eDFTTzRqRFQvNmN1S05qV2R1MzdubzFELzgyUHhPK0ljM1ZDRmdndVpva1lp?=
 =?utf-8?B?UnZrMzYvcitIVzBrVndnVktaSHYzM1hpWUk4MkpMTTJhbjZUQzBzekJNdkwr?=
 =?utf-8?B?N0EzTU4wUG5PMVJKdG9SVVVPc0U2SXMrcmtOaTBNZTlaYWJLeFlGaUVTM2JK?=
 =?utf-8?B?N3dIRnY5QmxmWGY5ei9PRTVGeDdxMzhnMGVhU28zTFRETlhFZUl1dzZpK3RL?=
 =?utf-8?B?MFd5VjJtOFgxbkZxVHdEeUc3QzhjeWQvM3JrQk5FZ3NDcEl5VVNUOGgweGNT?=
 =?utf-8?B?LzVUb2hCSWVQZFozdEFZdE5kRXpxTXJ4WGh4UzVSNjdmNklrQitCRjVWUU02?=
 =?utf-8?B?VWlhank0TWxtV3RsSDVuZENvd0ZEZHRta3FLOW9jcTRvL2JLdjYzMEY0aDRn?=
 =?utf-8?B?ZVVhV1FQRnNkNmo5MElQZ29xWHpSV2pUclF1anJMK2pRZWordUhDdXRGdTEy?=
 =?utf-8?B?dWUwdEpBYVdtZS9qN0dRSzZWbkYwN0N1Qzhmeko1cktNZTd3SUZ0eUcxSzRC?=
 =?utf-8?B?MjVuZWRFUXJBaG12TEtsbGJvakpSL0kxaGJGR3o1WnBUbTg4dDBuUHlxemdS?=
 =?utf-8?B?YTVIRW05a3hGSFMxM081T2FKTnVsQ0ZVeVJRaURTVkY0UXRwbERlWXk3NFVl?=
 =?utf-8?B?YXhQNFRLTFBiVFQ1eW56ZitpVlpZQWhoWk9SY1BvemNnMlZxdk9mMzRjdUJK?=
 =?utf-8?B?Y2pUdUxwcVNOTVdFQlkwd3Q0Sk1ZU3Q5NXVlVmpmQ1NGdU5FNmwzNFFsZzB3?=
 =?utf-8?B?M0cxbTlQVTNOU1FIUk5peWxtZ1NhekN6RklLZ09DMEtxTU42alJFenp4d2N3?=
 =?utf-8?B?Z25jdXV3aG5BeXhhdWx3QnVDUzUreGxzcmM5dEdsUldOWFd5Q2ltTHFZa21w?=
 =?utf-8?B?eS94UnpzVmoxYll2QlNZczhtc0RkeXVhRVpVU3h5ZWp3dWJOUzdnOTM3NlAx?=
 =?utf-8?B?Vnl3bWVtOFlqVnAweGIvekZzUEUyR09LM3phUklVbVJVL0I2dWxyRG4ySjRm?=
 =?utf-8?Q?TJJ/T64vNNEEwb37wx0YXCYxZ1k9Vhf4rE+EutZ?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eb4bfcb-adfa-4a6e-6121-08d96bb69f30
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2021 13:03:55.0552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NG8COwsXbkRBtlWnhoyET4ASxNQK79XfU7z6TFuhj4sObWANQkEj42APxtY6/PbX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB7018
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 2021-08-29 06:41, Liam Beguin wrote:
> On Thu, Aug 26, 2021 at 11:53:14AM +0200, Peter Rosin wrote:
>> On 2021-08-24 22:28, Liam Beguin wrote:
>>> On Mon Aug 23, 2021 at 00:18:55 +0200, Peter Rosin wrote:
>>>> [I started to write an answer to your plans in the v7 thread, but didn't
>>>> have time to finish before v8 appeared...]
>>>>
>>>> On 2021-08-20 21:17, Liam Beguin wrote:
>>>>> From: Liam Beguin <lvb@xiphos.com>
>>>>>
>>>>> The approximation caused by integer divisions can be costly on smaller
>>>>> scale values since the decimal part is significant compared to the
>>>>> integer part. Switch to an IIO_VAL_INT_PLUS_NANO scale type in such
>>>>> cases to maintain accuracy.
>>>>
>>>
>>> Hi Peter,
>>>
>>> Thanks for taking time to look at this in detail again. I really
>>> appreciate all the feedback you've provided.
>>>
>>>> The conversion to int-plus-nano may also carry a cost of accuracy.
>>>>
>>>> 90/1373754273 scaled by 261/509 is 3.359e-8, the old code returns 3.348e-8,
>>>> but the new one gets you 3.3e-8 (0.000000033, it simply cannot provide more
>>>> digits). So, in this case you lose precision with the new code.
>>>>
>>>> Similar problem with 100 / 2^30 scaled by 3782/7000. It is 5.032e-8, the old
>>>> code returns 5.029e-8, but the new one gets you the inferior 5.0e-8.
>>>>
>>>
>>> I see what you mean here.
>>> I added test cases with these values to see exactly what we get.
>>
>> Excellent!
>>
>>>
>>> Expected rel_ppm < 0, but
>>>     rel_ppm == 1000000
>>>
>>>      real=0.000000000
>>>  expected=0.000000033594
>>> # iio_rescale_test_scale: not ok 42 - v8 - 90/1373754273 scaled by 261/509
>>> Expected rel_ppm < 0, but
>>>     rel_ppm == 1000000
>>>
>>>      real=0.000000000
>>>  expected=0.000000050318
>>> # iio_rescale_test_scale: not ok 43 - v8 - 100/1073741824 scaled by 3782/7000
>>>
>>>
>>> The main issue is that the first two examples return 0 which night be worst
>>> that loosing a little precision.
>>
>> They shouldn't return zero?
>>
>> Here's the new code quoted from the test robot (and assuming
>> a 64-bit machine, thus ignoring the 32-bit problem on line 56).
>>
>>     36		case IIO_VAL_FRACTIONAL:
>>     37		case IIO_VAL_FRACTIONAL_LOG2:
>>     38			tmp = (s64)*val * 1000000000LL;
>>     39			tmp = div_s64(tmp, rescale->denominator);
>>     40			tmp *= rescale->numerator;
>>     41	
>>     42			tmp = div_s64_rem(tmp, 1000000000LL, &rem);
>>     43			*val = tmp;
>>     44	
>>     45			/*
>>     46			 * For small values, the approximation can be costly,
>>     47			 * change scale type to maintain accuracy.
>>     48			 *
>>     49			 * 100 vs. 10000000 NANO caps the error to about 100 ppm.
>>     50			 */
>>     51			if (scale_type == IIO_VAL_FRACTIONAL)
>>     52				tmp = *val2;
>>     53			else
>>     54				tmp = 1 << *val2;
>>     55	
>>   > 56			 if (abs(rem) > 10000000 && abs(*val / tmp) < 100) {
>>     57				 *val = div_s64_rem(*val, tmp, &rem2);
>>     58	
>>     59				 *val2 = div_s64(rem, tmp);
>>     60				 if (rem2)
>>     61					 *val2 += div_s64(rem2 * 1000000000LL, tmp);
>>     62	
>>     63				 return IIO_VAL_INT_PLUS_NANO;
>>     64			 }
>>     65	
>>     66			return scale_type;
>>
>> When I go through the above manually, I get:
>>
>> line 
>> 38: tmp = 90000000000    ; 90 * 1000000000
>> 39: tmp = 176817288      ; 90000000000 / 509
>> 40: tmp = 46149312168    ; 176817288 * 261
>> 42: rem = 149312168      ; 46149312168 % 1000000000
>>     tmp = 46             ; 46149312168 / 1000000000
>> 43: *val = 46
>> 51: if (<fractional>) [yes]
>> 52: tmp = 1373754273
>> 56: if (149312168 > 10000000 && 46/1373754273 < 100) [yes && yes]
>> 57: rem2 = 46            ; 46 % 1373754273
>>     *val = 0             ; 46 / 1373754273
>> 59: *val2 = 0            ; 149312168 / 1373754273
>> 60: if 46 [yes]
>> 61: *val2 = 33           ; 0 + 46 * 1000000000 / 1373754273
>> 63: return <int-plus-nano> [0.000000033]
>>
>> and
>>
>> line 
>> 38: tmp = 100000000000   ; 100 * 1000000000
>> 39: tmp = 14285714       ; 100000000000 / 7000
>> 40: tmp = 54028570348    ; 176817288 * 3782
>> 42: rem = 28570348       ; 54028570348 % 1000000000
>>     tmp = 54             ; 54028570348 / 1000000000
>> 43: *val = 54
>> 51: if (<fractional>) [no]
>> 54: tmp = 1073741824     ; 1 << 30
>> 56: if (28570348 > 10000000 && 54/1073741824 < 100) [yes && yes]
>> 57: rem2 = 54            ; 54 % 1073741824
>>     *val = 0             ; 54 / 1073741824
>> 59: *val2 = 0            ; 28570348 / 1073741824
>> 60: if 46 [yes]
>> 61: *val2 = 50           ; 0 + 54 * 1000000000 / 1073741824
>> 63: return <int-plus-nano> [0.000000050]
>>
>> Why do you get zero, what am I missing?
> 
> So... It turns out, I swapped schan and rescaler values which gives us:

Ahh, good. The explanation is simple!

> 
> numerator = 90
> denominator = 1373754273
> schan_val = 261
> schan_val2 = 509
> 
> line
> 38: tmp = 261000000000   ; 261 * 1000000000
> 39: tmp = 189            ; 261000000000 / 1373754273
> 40: tmp = 17010          ; 189 * 90
> 42: rem = 17010          ; 17010 % 1000000000
>     tmp = 0              ; 17010 / 1000000000
> 43: *val = 0
> 51: if (<fractional>) [yes]
> 52: tmp = 509
> 56: if (17010 > 10000000 && 0/509 < 100) [no && yes]
> 66: *val = 0
>     *val2 = 509
>     return <fractional> [0.000000000]
> 
> Swapping back the values, I get the same results as you!
> 
> Also, replacing line 56 from the snippet above with
> 
> 	- if (abs(rem) > 10000000 && abs(div64_s64(*val, tmp)) < 100) {
> 	+ if (abs(rem)) {
> 
> Fixes these precision errors. It also prevents us from returning
> different scales if we swap the two divisions (schan and rescaler
> parameters).

No, it doesn't fix the precision problems. Not really, it only reduces
them. See below.

*snip*

>>> Considering these null values and the possible issue of not always having the
>>> same scale type, would it be better to always return an IIO_VAL_INT_PLUS_NANO
>>> scale?
>>
>> No, that absolutely kills the precision for small values that are much
>> better off as-is. The closer you get to zero, the more the conversion
>> to int-plus-nano hurts, relatively speaking.
> 
> I'm not sure I understand what you mean. The point of switching to
> IIO_VAL_INT_PLUS_NANO at the moment is to get more precision on small
> values. Am I missing something?

Yes, apparently :-) We always sacrifice accuracy by going to
IIO_VAL_INT_PLUS_NANO. More is lost with smaller numbers, relatively.
That is an inherent property of fix-point style representations such
as IIO_VAL_INT_PLUS_NANO. Unless we get lucky and just happen to be
able to represent the desired number exactly of course, but that tends
to be both non-interesting and the exception.

Let's go back to the example from my response to the 8/14 patch, i.e.
5/32768 scaled by 3/10000. With the current code this yields

15 / 327680000 (0.0000000457763671875)

Note, the above is /exact/. With IIO_VAL_INT_PLUS_NANO we instead get
the truncated 0.000000045

The relative error introduced by the IIO_VAL_INT_PLUS_NANO conversion
is almost 1.7% in this case. Sure, rounding instead of truncating
would reduce that to 0.5%, but that's not really a significant
improvement if you compare to /no/ error. Besides, there are many
smaller numbers with even bigger relative conversion "noise".

And remember, this function is used to rescale the scale of the
raw values. We are going to multiply the scale and the raw values
at some point. If we have rounding errors in the scale, they will
multiply with the raw values. It wouldn't look too good if something
that should be able to reach 3V with a lot of accuracy (ca 26 bits)
instead caps out at 2.94912V (or hits 3.014656V) because of accuracy
issues with the scaling (1.7% too low or 0.5% too high).

It's impossible to do better than exact, which is what we have now for
IIO_VAL_FRACTIONAL and IIO_VAL_INT (for IIO_VAL_FRACTIONAL_LOG2, not
so much...). At least as long as there's no overflow.

Cheers,
Peter
