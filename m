Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 570A63C33AF
	for <lists+linux-iio@lfdr.de>; Sat, 10 Jul 2021 10:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232004AbhGJIRM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 10 Jul 2021 04:17:12 -0400
Received: from mail-eopbgr00102.outbound.protection.outlook.com ([40.107.0.102]:48110
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230009AbhGJIRL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 10 Jul 2021 04:17:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jkg1maZHlQa331PBxlH10HsEAN6IGy/wbbdazPB8erWIaJN9wKWX6ZC4a2Re11n87nvPzZRzjtWYAzHxV5VaprZQHY5W8aLWPgfjpCtG9UY4Pl2xbtGQJeQxjgJEY2oXQSHvq4SrogMMljIZEGrZbFKP84H4hrfCHLqVUFOUFK7RpbXKzUjkBum7jtuiKDG8IIIL+JMiB+ovq6rRrjbf4FqDyLVKoLl4fd6bz51ts30Y5VtJlmf9o8ntdi/7YDFwdgM33eyMTHiq03R5T5RwDsf1TFpZFnja+/GnOAh4+uVXGxOMJ+ud5JkKivpq8fwA2+Lp32JhpAkF+0hcNwvduQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4+TesGfYmJRGQUFN1XDt/Fy7MvYRwzxqwxk9vrY0FUk=;
 b=hE/w7PCoOQ9SoSpbENkLMQFZiRIQnqOwkyXxjlT/jxzecxo1VZ4lCDx1M8y9+0dzFZnfHOtq8fH3PqEMRiu3FfgtNZu2ZipC2R+sDwznjboAYBNEI+Lb2Ohh80WjXqOFuDojc6iNK2OzR47I4FKQiabI21bP5hKmRM9CVx8E7I+ACgJvdKH1/3K6Fzml47HuhKbPMQutjYKGFgrpTcfcKBA9Jt7eQ+esRgb5Si7Yb/DMiJf+7ZvF9JuG4RS39LnBKS3/cf7q83Lu5MKSwoPJW0felp0mISXQywXnsFPu2OJQwHCeUcGST6lY4g6DvHXtzQ8IM4jOcVR9oNTlYJNWQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4+TesGfYmJRGQUFN1XDt/Fy7MvYRwzxqwxk9vrY0FUk=;
 b=PFn6ovgBjBV+3JobCgPPMEYxFCS2nZMHTjl0P8FV1BOsYbZTzcHb3BiAUsSsPe9cKcXMTeVQxw8bqAgORCbPuAj6+Ro5AQawX78pfgV9lFxsftHyt4o2D7cHtU7ALX+Wtvo6WHiXka/QXX0Q9vXQm/j6P3XbnNCQm2GPfdYqUEk=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB3PR0202MB3418.eurprd02.prod.outlook.com (2603:10a6:8:d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.23; Sat, 10 Jul
 2021 08:14:23 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::14ca:a41:2218:3578]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::14ca:a41:2218:3578%6]) with mapi id 15.20.4287.035; Sat, 10 Jul 2021
 08:14:23 +0000
Subject: Re: [PATCH v4 05/10] iio: afe: rescale: add INT_PLUS_{MICRO,NANO}
 support
To:     Liam Beguin <liambeguin@gmail.com>, jic23@kernel.org,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
References: <20210706160942.3181474-1-liambeguin@gmail.com>
 <20210706160942.3181474-6-liambeguin@gmail.com>
 <4be51a74-9913-291a-9dac-422ac23da3ea@axentia.se>
 <CCOUX814CQ6U.XY2CIQKFE00V@shaak>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <353ceae9-ad7a-3175-d764-a9e590d3e8d3@axentia.se>
Date:   Sat, 10 Jul 2021 10:14:20 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <CCOUX814CQ6U.XY2CIQKFE00V@shaak>
Content-Type: text/plain; charset=utf-8
Content-Language: sv-SE
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR05CA0201.eurprd05.prod.outlook.com
 (2603:10a6:3:f9::25) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.13.3] (85.229.94.233) by HE1PR05CA0201.eurprd05.prod.outlook.com (2603:10a6:3:f9::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend Transport; Sat, 10 Jul 2021 08:14:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 511d16c2-bb5a-47b5-4d1e-08d9437aba13
X-MS-TrafficTypeDiagnostic: DB3PR0202MB3418:
X-Microsoft-Antispam-PRVS: <DB3PR0202MB3418D9030F205B21FDA2F1A1BC179@DB3PR0202MB3418.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zba70Jq/oS1GmLnyq9DlwC0hmTdfCLTqvXWRcepIY7e1Std14NavZ2ebVG7ptvCwDaLdX4YL4PMvNwvx+x4ikzbFYOk59yREVOFCLog7YVOycFKQd7d9ZbOVxDKiwwy6hSZai7TLylJKkvYf59UV83yBFJPA7vxml4Kaeiqn2+0SUxWvgO9Gw2o6ArEzoF+YsMxk0I0hxYFre/8ZIx/IpirpEdtLjfGZPev91yL0x7z9l2uv/02qupRL1jUZnU27f5mwQWeX7fOr8wDVsejF6QpEKsTORWVUWFaoxQeiNbup8sqVLHWpCqg/WwP1HjWkLXgHIxSENwSz1wuVpDZbjzgHpwY/088LlzvlAxjpIF/xAIKJqeJNqv0bntaatezPtVNgfrUB3i2cNCTHWXJAHuV6ZazkbslXvfBKM2iV0O/2hnSmmBJEkI8rj25jG+fR4bEyGO25F1RlSxe5+S6u3IF3bAlEu3r3fZ+4twlxbRdVW2E8XjN6TtsqM3beUDWhN3p1cUbxopmug4452afnO8v8lAVB1v/B8iEdhflsMLUnekP7h/eHgE1oYAQXS/ikoWCgZGXCsB9AygvhBk2kEMvLTXbbRc0VYRZhciGRqIISm0tRXFDbCigi87X0czKkT5vn1KbmwPNYRW42mW4DTBhrJuGNIQlNjUFDp2lP72XOPjr5+qocAYaRfrZbnnax5MpNcxhpiiLhyTtc9ss+ShKxxhZEEesIHzVj0WitL6w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(346002)(376002)(136003)(39830400003)(8936002)(6486002)(8676002)(16576012)(36756003)(186003)(956004)(38100700002)(316002)(478600001)(26005)(36916002)(31696002)(31686004)(66556008)(2906002)(2616005)(66946007)(86362001)(53546011)(66476007)(5660300002)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tzl0ME91Wm9KQ1lRZXFMMlRNWXFlV0NudmpmVEo4UGhqNS9ZR0tvMW1ZWHgy?=
 =?utf-8?B?dmgyN2FxdEJyeEZCcHlRSmhxajYwRHJwdjZyZk1MMmwyeXpsMzFUbE9MUEw4?=
 =?utf-8?B?UjhGNlpWQWhvck5Ka2ZHRjlHSG84OHdTa2dhUnByZmRQeER0Rml0MVJPOFlv?=
 =?utf-8?B?M1BlOUk4OHVaL21YRzE2VUtSZUVHcG1vSEZtdnhGTmgwczNaMWxhbDNkMGwz?=
 =?utf-8?B?YnpKeEJJYXZXTlJiaVZTNTc4RWw5dTVTcUZDWDB0Q3RYNVhoNksvVXdYbnBw?=
 =?utf-8?B?MUdGS1d0d0N5bHovVm55Q0k1dys3MDJCK2hFbXJEVGZkbjNIVFdrUnp1cU9V?=
 =?utf-8?B?K3NCdyt1ejVtTlc1SzMvNkJkZzJmYWpKUnAyK011QzhqaGZXK2xMeUpGRko4?=
 =?utf-8?B?cUdHd3BiZ292MjhreVFrOTFZNmQ4TmFwL3lWdGNmVVM1MklrZHlseVYzVldN?=
 =?utf-8?B?RGluTkVndFBZNS9yUzF4cGxPZitNeWpMY3J3Y3pvMXBUL0w2c0FRMXFqTGwz?=
 =?utf-8?B?bUtJUXROdUQ2ODkxZ0dQYjBYNStZT3ZJV0FGaWpiZ2cwWFRSTVdZRVJwQmJq?=
 =?utf-8?B?M0RQTm53MnJ2TUo5Zmhnd2o2UkF3aVBqNWtFTGtYTVJCbzJwbXI3WGFZaGJi?=
 =?utf-8?B?NkwrZzV2Y3hqUDJyTlJOZzRrSkxoakszdEtydHFreCtNajk2V3NNc1VHT1hi?=
 =?utf-8?B?VFYzWWkwR0s1V0ZrZVFKZXg2dFVqVTVDdVpZekpsTG01YXAvY01STjRXdHZk?=
 =?utf-8?B?SzRrd005Tnk0dXc3RHFDSWkzcVRVRzlQTENCR1QwVENOaWxpSHNyNkR3aHRq?=
 =?utf-8?B?ZXpYdmF0SlJEaEhDTkxYazEweHl1Zjg0V05nd3JlUTY2NTJvL1NZSmU1RDRQ?=
 =?utf-8?B?Vy80b3RjUWxKQktWRys1NllhanBVd05FTEs2aFdHdmYrdFpjTU1SN3NzME1y?=
 =?utf-8?B?VTJFSjNkcC96Q3lSMDFkRnl4QlVNU1MwOXZPd1BtVjlGRlRXdnFHQ0hwMmRW?=
 =?utf-8?B?MlREbE90dUxqK2pvN1JhL2p5UzhuYVpUQmM0MkMveWVBWm1MZFZOdGFTUkoy?=
 =?utf-8?B?eldUR2EwNXp0UDZYNEwrNzZmL0F2SG9tbEJQU01kdFhnQmxVOVp0b3l4L1Zz?=
 =?utf-8?B?TjNqeVliY3FoNjJVUmZwbGhlTERvTUN1Mk5WdzRVNFE4azF2Wm1FQ2tyUGww?=
 =?utf-8?B?bDE2N0ZFRlE2bGcwbTl4ZCtXYnB1TEtBSnBaaTBzaWlMTng0NGM5dEhLdURn?=
 =?utf-8?B?VXE1QnV1WDN0dzhXUjNRdlZqNzlTYmJGaHhZcnVDalRjRTkrZ2lnOTdYeHMr?=
 =?utf-8?B?ZVp0ZWw4UG9xcUdFajlBbjhXZXgydWlSbVVDQm9kVFdsWHpKWFVTZ09HL3o1?=
 =?utf-8?B?SG1rK3g3S0QxcEpFZEdZS1FMM3VaVFpFZHQwa1NUNjVOT0plb2wvRk1MWmVn?=
 =?utf-8?B?aWwwMDVHSzRpZjNGaGpsb25sQUhka2tRNUtwK2UzdzBHZVBVWmxnTzNSbWRo?=
 =?utf-8?B?Q1Y0K1BNNkk4S0xCbC9Dcm9OOGtqZmJ6WFlzQXhDcW5BSFlXUCt5UDZxd1Za?=
 =?utf-8?B?Q0V0Mzh1YVF5Z2ptT05QUjZIcXViQXZreUIvTnA3MGlsekdvaE1OZEN5US9a?=
 =?utf-8?B?VHIxY0sxc0Zqd3pwTXFTSmNlMHJYeHc3V0hDSndDVC92Q2FCb1hYS3lBTnp4?=
 =?utf-8?B?WTdTdll3bzJ6VnNybHN2UDg2ZEdVNU83N1VKME9PQTBEYUxZYkEwREFJck0y?=
 =?utf-8?Q?7dEvEP21Y/n8HDv84sTGHAfrt9/rV8iHepixPAt?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 511d16c2-bb5a-47b5-4d1e-08d9437aba13
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2021 08:14:23.7733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QL4u9l2b/h2fw1Ug9CrM3Q4rMPDfV57RhW8k/x16WvIf56dLTYn9yk+v3StWl+dp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0202MB3418
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 2021-07-09 21:30, Liam Beguin wrote:
> On Fri Jul 9, 2021 at 12:29 PM EDT, Peter Rosin wrote:
>>
>>
>> On 2021-07-06 18:09, Liam Beguin wrote:
>>> From: Liam Beguin <lvb@xiphos.com>
>>>
>>> Add IIO_VAL_INT_PLUS_{NANO,MICRO} scaling support.
>>> Scale the integer part and the decimal parts individually and keep the
>>> original scaling type.
>>>
>>> Signed-off-by: Liam Beguin <lvb@xiphos.com>
>>> ---
>>>  drivers/iio/afe/iio-rescale.c | 8 ++++++++
>>>  1 file changed, 8 insertions(+)
>>>
>>> diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
>>> index ba3bdcc69b16..1d0e24145d87 100644
>>> --- a/drivers/iio/afe/iio-rescale.c
>>> +++ b/drivers/iio/afe/iio-rescale.c
>>> @@ -89,7 +89,15 @@ static int rescale_read_raw(struct iio_dev *indio_dev,
>>>  			do_div(tmp, 1000000000LL);
>>>  			*val = tmp;
>>>  			return ret;
>>> +		case IIO_VAL_INT_PLUS_NANO:
>>> +		case IIO_VAL_INT_PLUS_MICRO:
>>> +			tmp = (s64)*val * rescale->numerator;
>>> +			*val = div_s64(tmp, rescale->denominator);
>>> +			tmp = (s64)*val2 * rescale->numerator;
>>> +			*val2 = div_s64(tmp, rescale->denominator);
>>
> 
> Hi Peter,
> 
>> Hi!
>>
>> You are losing precision, and you are not mormalising after the
>> calculation.
> 
> Can you elaborate a little on what you mean here?
> 
> Do you mean that I should make sure that *val2, the PLUS_{NANO,MICRO}
> part, doesn't contain an integer part? And if so transfer that part back
> to *val?

Yes. On 32-bit, you will easily wrap, especially for PLUS_NANO. You'd
only need a scale factor of 10 or so and a fractional part above .5 to
hit the roof (10 * 500000000 > 2^32).

But I also mean that you are losing precision when you are scaling
the integer part and the fractional part separately. That deserves
at least a comment, but ideally it should be handled correctly.

>> I think it's better to not even attempt this given that the results can
>> be
>> really poor.
> 
> Unfortunatelly, I'm kinda stuck with this as some of my ADC use these
> types.

Ok. Crap. :-)

Cheers,
Peter
