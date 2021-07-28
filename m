Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3193D88BD
	for <lists+linux-iio@lfdr.de>; Wed, 28 Jul 2021 09:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234154AbhG1HUG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 28 Jul 2021 03:20:06 -0400
Received: from mail-eopbgr00105.outbound.protection.outlook.com ([40.107.0.105]:8270
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233303AbhG1HUG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 28 Jul 2021 03:20:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T2w4O49Mh/2shSC0jRJQSwC7ZQ5ugDl/pXPQJ9JKfkTu6EXCjdFUcRIuywqXNnPFpIRmlosi8VHWfoGFcPTfcAAL0bBbc27NKZI/Qvk0i7saiLmxHBFvpNwth0ZWHdVClJZbiaxRcBmDEhnSCbbq95jKxAuC0QqrXY3lCWDgIcmlS/ju6IZZX1u9VT43oRmuoQ11Gs/x7rO2ewhh7LOa6ReOTBvzBsw7qUqxMyYkUmqwBzXkC5d/gTS8mxXI6VrNmxDIr8MWq/ZtEPT3C2LqdG1bxdWIi3d9TVBAyeXnD41Gf3eP6sdBkRAGu/Ti5FmQdsydBnx7qp4VLTovg/GwEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FgdxVLQ1uNK8BJXfn26nuFVzZ1wvvJuDTq5siChJOeU=;
 b=OLEO71nEYCK5xFkED7dLUuiKd7ZunxIrRT4VEUdPxzDE6kG9bJsLDarQml4FByg8/u9PYroMl7AsI0Yx1imOZqSbtMcWuGbrXM8N+DWU2NJ0lL4o8PDH8HoFW5juonqzOtF1nnjm1bFdH9eCQ7xi+E2jT26fKd1z3ECCFcSQDjT2M8jM2for04veRagUPQ4/n3+CAxMMuBNKxkhM/641N2GHLa6yHL+7ZuxYs/xtoC/ti0WryaQbUArCc5ci/Xxf4M03LIqpqHPoj+cYqS3IJ7x6M+TuAJsT7GjQHQVwT44xay6njoGOAD7TEyaoqotLUSF4JMlo6LSzD5TmM8FP6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FgdxVLQ1uNK8BJXfn26nuFVzZ1wvvJuDTq5siChJOeU=;
 b=Jw6rKdJXkBfCNdHSn9IHGlolYQ2BtJvfBPg1l4XDwth7PPsj/4OKn9HSzqkF1ZOJ+RRD8qnWbbgp/P5lOiQ1MUDzbIJxpALLZ4BSIVIkyTDzVDrmtXbemZx+s+a6ySEkQ82s0stRvbF8tJBiH1VPRdHEZ1w9uWLTCdnoQOCVN5A=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB9PR02MB6747.eurprd02.prod.outlook.com (2603:10a6:10:1fb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Wed, 28 Jul
 2021 07:20:02 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::14ca:a41:2218:3578]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::14ca:a41:2218:3578%6]) with mapi id 15.20.4352.031; Wed, 28 Jul 2021
 07:20:02 +0000
Subject: Re: [PATCH v6 05/13] iio: afe: rescale: add INT_PLUS_{MICRO,NANO}
 support
To:     Liam Beguin <liambeguin@gmail.com>, jic23@kernel.org,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
References: <20210721030613.3105327-1-liambeguin@gmail.com>
 <20210721030613.3105327-6-liambeguin@gmail.com>
 <c9d77dc0-7f4c-0df0-cce1-8cb30074e115@axentia.se>
 <CD4CE5OQT5TJ.2BFPBRYK7FCOW@shaak>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <18f749be-284f-3342-a6d2-b42aa39fc13a@axentia.se>
Date:   Wed, 28 Jul 2021 09:19:58 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <CD4CE5OQT5TJ.2BFPBRYK7FCOW@shaak>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR0701CA0083.eurprd07.prod.outlook.com
 (2603:10a6:3:64::27) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.13.3] (85.229.94.233) by HE1PR0701CA0083.eurprd07.prod.outlook.com (2603:10a6:3:64::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.7 via Frontend Transport; Wed, 28 Jul 2021 07:20:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a52a9f54-efdc-4e50-4139-08d951981d57
X-MS-TrafficTypeDiagnostic: DB9PR02MB6747:
X-Microsoft-Antispam-PRVS: <DB9PR02MB6747CBDB4AE77F69A8306F34BCEA9@DB9PR02MB6747.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wDELmms/GhPwpKuxcU0WqDcpIfqWrt9VvsDIH2+IWLKe/CfCikPWbv9Hz6y3lkVkTb93oHBMNoLKH/EZPBS4Nq6KMmJ1+fc2gjQtHoehCYgdi2vW+piXXGZBvF1P06+q2Nk8z5Fe00Eu7W9CNMr15DD6JQpVEHo5p/2/8cdjcAqsg8Rh+KHbqzm39U28gum2nU4BKHZTCCuJ3ePCqigdDeJ0+4H10z/O26ncSIimccnJXrAsuEGiROqfq9bbQaPfxf67Sjz12yi6UNU5JQ9S/mlR8gymivzWRjONUDD2pi4pz20uUNeMbxtpJ7mfSLh+qt7BvqY0ohXYZnu1QLt4iZJtk5qK68uBpcNf3pDO9ZVyS+m0eFi+TrXxICBQahgZZCOmiQL6hnE9GhOJgCi7aNBwiwvLxdLYeREIN/VvIK+hkx2ibYijAa/xtJjYLsMv+wrYUiC4uZPcQ/XA+YhppFf9oqAqvgbHoSoPrWHFgxaLr8lEFEPrB2jXJnwkI4BnDWAQCWYMcSvlROs/pbTkc3T54C7GJ2of37YWh5kYzK2Te9/+ypJWFTa7sn/6PgXvoHupZERTVZLwLPYtw4qDx2YH86PMkl69qVUqpjD9BFDLZ8bK7X8xy7nyZdovXvmcoSk/WmlAzpKaC1Jltn7Nsz7bWt8ULF0B9o5PZJ6vWY5va+7crPyvV4nPFPRNTbGmylC0AOgyVxBiXl/1JGzPMWyN6I472YRre3b2tb7lXC8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(39830400003)(396003)(376002)(136003)(366004)(346002)(8676002)(53546011)(2616005)(316002)(16576012)(4326008)(38100700002)(956004)(31696002)(26005)(66946007)(5660300002)(6486002)(2906002)(86362001)(186003)(6666004)(66556008)(478600001)(8936002)(66476007)(36916002)(31686004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWdrK2ljTCtEOHN3eGVXZ3BXMnBsSVRGK2dZaVRYV1lMS3QwTVRHSWpuWGpz?=
 =?utf-8?B?SmZTbXdZUGRkQzRoM2Z3UmZQZVRYSzBVamtxMmxTUU9PSytlK0VTbC9POGhl?=
 =?utf-8?B?MDRzV3FGaUZCSlAzZ2NTMzBjT0M5YTVsOHpmL0JOa2M2aUNVeVhPY1BUMzJq?=
 =?utf-8?B?T2svaUFXeEhWRFJTa3IyVXlzKzBNWXN1ZTRLOHNGbE9xbEhIOTY4ODZKbkIx?=
 =?utf-8?B?Z3pvYlk2NmR1L3VIN3hxMXFmV3VJVDM4aXorKzZSVWpRRi8rZy9ZbExYTkZK?=
 =?utf-8?B?dm1WVWQwdmh2WlFFMVhhdit6c3F3a2lHRWVnVHIvQ1l6YTc5Mk1PbDZsZFRV?=
 =?utf-8?B?bnVFYTZ3a0FDZjl5V2xtWGgzSWxxNmU2a1pNRnAycTNnRGtGcU5OWURmUEdX?=
 =?utf-8?B?eEg2eDVxUm5DVlNTSlpJcGxBRHNsN0pCYWlXY3pteERzSWcwemVzQlNzTVJN?=
 =?utf-8?B?eFhTYnRlTXVueUZQOWM4a1dyd096RGFOVlhxa2JqWktEa0t2L3h1Zm1MKzRV?=
 =?utf-8?B?aC9vbVJWZ21LWTJMVnBXYUNjYUQyRUlSTjJQVWx3azlLcUxTbHRGUnJRS1Zu?=
 =?utf-8?B?MVBQSVlKRm81TVF4Vlh6aHQ2akpIcldyL0N2MnhZeEwxVlFTTXFtMVZJRjlW?=
 =?utf-8?B?RERoL0Q5b2dMUERnRWxYOG5ES1lvTElTQS9xS0RMVFFmVnZpVnorRXNPQTA0?=
 =?utf-8?B?WmIzbkNiMDl3NUh5eThZdTZZVVo4WDViMi9mWDZGNVRIbzVEOXVvakphSDZX?=
 =?utf-8?B?TEg5cVU1eUY1MWQwMnluNkxjdEo4N1FjUERCRlQ5S05ZU1FEZjdrT2R3QnN3?=
 =?utf-8?B?QXpRT1o4Vy9idmdwYTlhcXZVS3dGeW1IQXdYcUFyY2JGajR6MFNwNmFkOUJ3?=
 =?utf-8?B?b3ZxRmdzNXBnQkh1b1lBREUzYzM5eTc0cnB6RlN2VFliMFJBYVNnTEhaUVJM?=
 =?utf-8?B?NTBpdUxMQUx5cXJ3S3oxaER1TnJneFliZnUwNXg4MFZSeWdQM0tEc0hCbm05?=
 =?utf-8?B?b05Fd0wvRXMyYjZRZDVpajlnMDFSdUsvd2xDQ0VxMjNsOHhHRnB5YXpyaTRa?=
 =?utf-8?B?R0pQclVPK3pqZTFYa1diUnI2YVFuaTRnaVRFT200d2xrdjdQYXJrclkwZVRP?=
 =?utf-8?B?Rmc4Zk02L2p6Q2gxcU8vMDg5aXErQWF4ZDFKNDlsdWgwR2JqU0Q1Rm45bTh6?=
 =?utf-8?B?T2Y1UzdzZ2JpVVZndU1zcjhiTm1hSWNRM1NzeSsyOW5raTI2Z3lESkpEMUhr?=
 =?utf-8?B?MVg5dGFLM0F4dGZEZ3BkM0s1RGI2SmpjbWJoNnk3OVU0TGFsUm5kVk5IRTZq?=
 =?utf-8?B?QXFBa1dGa05NWGR0K0dPbEZKQ3MwaitmWEJvWUd0Q1VGc1pXSU5idktrWFFW?=
 =?utf-8?B?TkliSnNmRVg1MUxGKzhjOGUxUUJkNDdjUFk5UjZZN2RuVi9tdWJOUDFnYVFw?=
 =?utf-8?B?MjhBclBGRGRpMytad0pWZVZnSGd3OVBCeGFQUjEwWHhsQnIxUXhuMG10STEv?=
 =?utf-8?B?NXhkUjRTWEZYZlFhZVVlTldrSzNyajF5TmVJTnJEdm11RlVPejJhNTJKQ3VT?=
 =?utf-8?B?WEtWSDQxbWwxUDRDeHBwclJTemcwQzJ0WW5POFBrWEx2Mzk0Q2lSb2E3STd6?=
 =?utf-8?B?cUlJeG9LQk43S1A0NW1PMkFSbkR0aUM4YnFJZkhkODZ3LzdiN0txZkVJa0Qw?=
 =?utf-8?B?cWo1eUZ0UitpTXVqY1NhZE5HVDNLcXBaUjY0UDVSSmg2MVJpMUYyVVBxcHAw?=
 =?utf-8?Q?ctIxxEQYtsmU6IOtJ54wO1qLUwLqWDCQ1SdoPkJ?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: a52a9f54-efdc-4e50-4139-08d951981d57
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2021 07:20:01.9901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0QEKuLqvrRKPLiWlkt9U1ckgTh8hsVpRX5ZVk+69cMvFF4hm1/KDE5koGhFlQzWX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB6747
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 2021-07-28 02:21, Liam Beguin wrote:
> On Fri Jul 23, 2021 at 5:16 PM EDT, Peter Rosin wrote:
>> On 2021-07-21 05:06, Liam Beguin wrote:
>>> From: Liam Beguin <lvb@xiphos.com>
>>>
>>> Some ADCs use IIO_VAL_INT_PLUS_{NANO,MICRO} scale types.
>>> Add support for these to allow using the iio-rescaler with them.
>>>
>>> Signed-off-by: Liam Beguin <lvb@xiphos.com>
>>> ---
>>>  drivers/iio/afe/iio-rescale.c | 14 ++++++++++++++
>>>  1 file changed, 14 insertions(+)
>>>
>>> diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
>>> index d0669fd8eac5..2b73047365cc 100644
>>> --- a/drivers/iio/afe/iio-rescale.c
>>> +++ b/drivers/iio/afe/iio-rescale.c
>>> @@ -41,6 +41,20 @@ int rescale_process_scale(struct rescale *rescale, int scale_type,
>>>  		do_div(tmp, 1000000000LL);
>>>  		*val = tmp;
>>>  		return scale_type;
>>> +	case IIO_VAL_INT_PLUS_NANO:
>>> +		tmp = ((s64)*val * 1000000000LL + *val2) * rescale->numerator;
>>> +		tmp = div_s64(tmp, rescale->denominator);
>>> +
>>> +		*val = div_s64(tmp, 1000000000LL);
>>> +		*val2 = tmp - *val * 1000000000LL;
>>> +		return scale_type;
> 
> Hi Peter,
> 
>>
>> Hi!
>>
>> My objection from v5 still stands. Did you forget or did you simply send
>> the
>> wrong patch?
> 
> Apologies, again I didn't mean to make it seem like I ignored your comments.
> I tried your suggestion, but had issues when *val2 would overflow into
> the integer part.

Not saying anything about it not working does indeed make it seem like you
ignored it :-)  Or did I just miss where you said this? Anyway, no problem,
it can be a mess dealing with a string of commits when there are numerous
things to take care of between each iteration. And it's very easy to burn
out and just back away. Please don't do that!

> Even though what I has was more prone to integer overflow with the first
> multiplication, I thought it was still a valid solution as it passed the
> tests.

I did state that you'd need to add overflow handling from the fraction
calculation and handling for negative values, so it was no surprise that
my original sketchy suggestion didn't work as-is.

> 
>>
>> Untested suggestion, this time handling negative values and
>> canonicalizing any
>> overflow from the fraction calculation.
>>
>> neg = *val < 0 || *val2 < 0;
>> tmp = (s64)abs(*val) * rescale->numerator;
>> rem = do_div(tmp, rescale->denominator);
>> *val = tmp;
>> tmp = rem * 1000000000LL + (s64)abs(*val2) * rescale->numerator;
>> do_div(tmp, rescale->denominator);
>> *val2 = do_div(tmp, 1000000000LL);
>> *val += tmp;
>> if (neg) {
>> if (*val < 0)
>> *val = -*val;
>> else
>> *val2 = -*val;

This last line should of course be *val2 = -*val2;
Sorry.

> 
> I'll look into this suggestion.

Thanks!

> 
>> }
>>
>>> +	case IIO_VAL_INT_PLUS_MICRO:
>>> +		tmp = ((s64)*val * 1000000LL + *val2) * rescale->numerator;
>>> +		tmp = div_s64(tmp, rescale->denominator);
>>> +
>>> +		*val = div_s64(tmp, 1000000);
>>
>> Why do you not have the LL suffix here?
> 
> Doesnt' LL make it into a 64 bit integer?
> I left it out because the second parameter of div_s64() should be s32.

It just looked really odd with 1000000000LL for all instances, but then
1000000LL only for some. The lack of symmetry bothered me.

To me, it seems as if we either need to support old/small crap with
int being 16-bit, or we don't. If we don't need support for 16-bit,
then we don't need any LL suffix, since 1000000000 fits just fine in
32-bit. If we do need 16-bit support, then we need LL (or something)
all over since neither 1000000 nor 1000000000 fit in 16-bit.

I think the compiler looks at the value of the constant and not the
size of its type when selecting how big values the mul/add/whatever
needs handle. So, adding LL feels like the safe option. Further, I
guesstimate that the runtime cost of adding LL is zero and that the
compile time cost is negligible.

But maybe I'm missing something?

Cheers,
Peter

> 
> Thanks,
> Liam
> 
>>
>> Cheers,
>> Peter
>>
>>> +		*val2 = tmp - *val * 1000000;
>>> +		return scale_type;
>>>  	default:
>>>  		return -EOPNOTSUPP;
>>>  	}
>>>
> 
