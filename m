Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B22F3DB3E0
	for <lists+linux-iio@lfdr.de>; Fri, 30 Jul 2021 08:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237463AbhG3GuI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 30 Jul 2021 02:50:08 -0400
Received: from mail-eopbgr80097.outbound.protection.outlook.com ([40.107.8.97]:7379
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230236AbhG3GuI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 30 Jul 2021 02:50:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fABEuQE1pARyTfzm/MXOMOhLsKfjuXqmmVvkyka5xLCUomOs8/V3bX784slCnsDvGQqO51FY5AiyLBcZ2vOKv8nnkuZbfm9t3Uc9ll9igOfErRs3TVgEt2/ZVQa/gmcEVUi6Ca1Yne37wjUN/zeYxkur9kRVsP6nAlg9lGMBBHQPHoV+IFRLrXq1NHUp2G/N5bvoL5rw0DYI1WNNg9za/NL+izu1DyRK6pyO1k4IoYZcx9CdGMHllziNuSYRgLTEXHLwDIWWkZJfmGNMUd6AyKYrpN7E+73kGkc/HWdGGNemLZt29SauTKXjl6o4I0gQcB4AxmC7dPjJmil6uwzpng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dYVoU4bP5MxA3+Sot0iydBRBP+6np9ggIKad9tk9dbs=;
 b=jYCNZuSmGbY6wmnkK9Xg6PLnn2Kz8JluaGjV3ogEGt8FdaqKJ00NYfkqHsn5U3ZWVqyOtr0fqrfgYFR+tbtLCRqonNmmss/iDDz/uIkT/qujaO2LD0QM+Yo3ZUVU02hUeSv2iVj7TwXeCFnV0RcxO+DDkEgRwOD5KWp0vOceUyNNqieJMTXYEsRBTqd3sIRtaLa9mrrqEex0wPWcg5jSCJXWuMddQZrmoYEOnz4UGw+DX3AxaYPbhyqrE4iZAnpCdRgnccG9c3BsVc9RoLMi2TF9mqnrZAPQ/BsvQgRraqeLiC97DNtoVP4xHNwF4xKrKK6NlYTyknEq9RD8m3msVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dYVoU4bP5MxA3+Sot0iydBRBP+6np9ggIKad9tk9dbs=;
 b=gEI4/0uoV+CAqVUctOG4Oc7KE6I02W7Kef56NOzM6NzVARqHN6609t0bIlXI1Fu3i2t0Lo/wRf8QOy70OKvMKgL3ZeTlBDVkQvNZd1LKg5FoztWNN0gBnheh1IdZABVKuucIPnZu/8tgwG/9Mbu4Idx0YrWKQ1vM7H+p6vSAEL8=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB9PR02MB6890.eurprd02.prod.outlook.com (2603:10a6:10:21b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Fri, 30 Jul
 2021 06:49:59 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::14ca:a41:2218:3578]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::14ca:a41:2218:3578%6]) with mapi id 15.20.4373.021; Fri, 30 Jul 2021
 06:49:59 +0000
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
 <18f749be-284f-3342-a6d2-b42aa39fc13a@axentia.se>
 <CD5QWB9MW1H5.3SSPWGD5DR6J5@shaak>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <a77e7a18-67dc-5bc5-427b-89d6b1e82b85@axentia.se>
Date:   Fri, 30 Jul 2021 08:49:57 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <CD5QWB9MW1H5.3SSPWGD5DR6J5@shaak>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR06CA0143.eurprd06.prod.outlook.com
 (2603:10a6:7:16::30) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.13.3] (85.229.94.233) by HE1PR06CA0143.eurprd06.prod.outlook.com (2603:10a6:7:16::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend Transport; Fri, 30 Jul 2021 06:49:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b18e7e0d-a52d-42f0-d02a-08d953263fd4
X-MS-TrafficTypeDiagnostic: DB9PR02MB6890:
X-Microsoft-Antispam-PRVS: <DB9PR02MB68908478ED851669DECE9F1EBCEC9@DB9PR02MB6890.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +6pNwkbCpW0WKHBMI03b9Ros7TusvAsLzIUXE9RU8th3UZfbz8/mpzddp1kVpMdAY0roCdzp61GT8xhP2OSyKLPgglR+g4a6C5IqB7ztjrPApk+VO+B43udNTzABSXb2QpZnOpj64qgSl5SNs7G1J7U+gngk8sMNOfLFwEWQY95W8DS06r8uDkxrrU69kWmX7uaywsnq1/Adr0hpahU+ZVZ5hNSSM3mkf+rALvPzaooeyZFvjBZ1iSO572m0fX1+y8OTEgXZo2BGao//xUHTeSdvMRUlxyOFOlV/66anD9uhREm6pkCKW3JJa+K89r8wBV9zDhjwxAFBXBzmInY6huhyYKRLyNa5d+7Zu4pQBlk7aUVy1PiJ30k8pX2b14SaVjfQm/hcDA9GSLHUlR4QguHCFlCpvtZOzhcVsU4hjX0BRnAKVMHoyfTzt2Di4EgCMTSfkKXr/DrUz8Vl4SSAkKL0phiJ3mh18/uoCzAp4Y9Ykk2rOIbkszwro0/GU4x0RYUkWdtbayMBqLPtp1ptUqZ8wcuLasD8W7Cy8UGattOuFOYPss/trPPTunT+VpC47CBPTHjCD4Wj9bgKZqnLX7e2o00AplncEslJq1EImTYZTXd476iQ5dEEF6tj4+Np1KWA3s1K/pC9GkafhUD88XT9dCMP2Wej4P7MPrnyT/vGy25hP8LM+RqW/AP9CAUpXsgAN+foffTPc/LUYWfAZBlBwaQQqnL6aI+a83vxLWY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(39830400003)(346002)(366004)(136003)(26005)(2906002)(31686004)(66476007)(66946007)(38100700002)(66556008)(8676002)(31696002)(53546011)(186003)(6486002)(86362001)(36916002)(478600001)(5660300002)(36756003)(956004)(2616005)(8936002)(16576012)(316002)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dlNmWDZMNVJYRFBQb3pHbC9FQ1dMQyt6b1dTaGs1OEJBUk5tOUpnUElRVWNC?=
 =?utf-8?B?VUJMMUNyYTBZTVRBRmlLcnh4UkdwZXpkY3Q3NVM0dkI4TEowTGNrNitOekN4?=
 =?utf-8?B?QzVVbnMxY1VxWmt2R2xzeGRaajBtVHJnQVB0cUV1dndodFE1azlEZGprcXpx?=
 =?utf-8?B?R1VxMXRUQVR6bW0vYUxNZ2FhOGhGYnh4QjhzaWZsT3RKaEFUUGtXQ3c0Q0kv?=
 =?utf-8?B?aGpKcVFqSUFvWHJZQ0Jnb0xYZkFPTFFVcUJNYUNuYnZDVTZRVlh6OVlqRHFk?=
 =?utf-8?B?L3QxWWFjYzVHRWdISEN6K0d3ZktzMS9GQTVoOHBIVGFtZHI1WlBnUnJXYUlE?=
 =?utf-8?B?TEJYYWdBd0VmbGpOK2hBM0VaM3JNTGlPK2dlSHBEOWEraDQrWWVyTjhJMmhJ?=
 =?utf-8?B?bTI1dCtLNjdRUGdVRXIzUm5TNS9ja3o1MXVoUTJUdFVhdFJhU1NMNW9yUExB?=
 =?utf-8?B?M0kwa0NRVFNEaTdlWU1FYzNGYnNWbnpOQitMVURNUU5lQjVGMVNoQ1VDYjBs?=
 =?utf-8?B?akhpUUVETWRoZHFnMFNCTjJnbXpKeFRUaGVBTmYrMTAySTd1cTlWS29NMkVq?=
 =?utf-8?B?ZXlZMkgwV2p3RktrUTJaQlNzQTJYUWVzOFE4ZS9Fd08xd3FhNzBxYklPUk5Z?=
 =?utf-8?B?WVc4YmpqbGtSMXZYOFp1azZSWlJVRTZxemN3bURzT1oxRVZVa2Q2THN2MFEy?=
 =?utf-8?B?Z204c1lWTmRFWFVNSVBIZ05WVlErcHcxbFZBVHpXUXVyZVpFODdXdGxPeTJW?=
 =?utf-8?B?NkdyZEhVWStRY1dwejBaZy9TbFZhT282bnN3SUM5WmtzdHhjQnBGT3JwUWZO?=
 =?utf-8?B?ZmRTMUJFQjFDT0lmZkFLSmhRMXpIY2IvNlZXZTY4a1JienRUOGE1QVJYYUw0?=
 =?utf-8?B?NVhSM0VSOW1lWGhHT3ZIYjBIUDh4eGVOMEZLazQ1akxFazN4T2lBaUx4bTdT?=
 =?utf-8?B?UmpnUGhvZGUweWE5dm1nNUtId1NWUXEzK1RvRzVtOFJRUENmOGRneVpYRU5p?=
 =?utf-8?B?M0dRQzdKYldWNTdLdVlQRlc2am5yUkpqWmU4Q0xObC9zZnh2YnZ1WDVPQjFQ?=
 =?utf-8?B?NXBiT2xVaXZiUFJVUUw3Tk5Jb01ZOE9rQTJ6Yi9uWFNZcHMvdVRhR1RJbTNu?=
 =?utf-8?B?K09PaDBYaWNNbVR3Qi9leXdKdzdsd1lJK1kxWXVRTU8yRXVLSDIvZ01Rd0R5?=
 =?utf-8?B?MWZqYkVUb20xdHZuVndGc0NmaXpYUzlCMC91NkFveWlrUnpKc0NyQ056d2F0?=
 =?utf-8?B?YzYrY0RDS1gycCtESVdSMFBZZS9CNjJaT294a0lRRVBKSmZsVVlsMGRYeGtr?=
 =?utf-8?B?NExycmJObm5vRmNjL001UUcvRHhOZjRoU2tuZlRHSm53VXBGMFVaem9tT0xx?=
 =?utf-8?B?U2ppY1ZabnFmejJUOVliUGd3Q0VzQmxERm5nK1orRnB0R2ZMQUpjMzlmazAr?=
 =?utf-8?B?ZTdrMVA1dS9DcnFFajU0ZTcwZFJUNTh4UTYvU2FSaDNPdHNLcXovOEt3QXJi?=
 =?utf-8?B?cTNXSjhzVzBGYXk0Q0ZHR0dXd0prakkydXNwMG5KQnRrdUNiaDZuYTJsYVRz?=
 =?utf-8?B?dHMxSmd5bzRvUVFyRmtCTCtJdm85MXdKWWZQN3FPcnVZbkJHdEdTSGxrODNR?=
 =?utf-8?B?OURiQy9Hb2RWZTBUTzk2K2tGMmtKV0pMeDcrVTgvTzhMT2Q3Y2tlSTlKMzFt?=
 =?utf-8?B?OUgwbDJkaGtnUE5WZ05Gam9zdHFQQnhvNnZJcWhHQ0Z0eSt4RnpJVXFuNHBj?=
 =?utf-8?Q?iRFjH/NE2poSrN3qsXVmVqwlDro/eozG4m5J4m0?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: b18e7e0d-a52d-42f0-d02a-08d953263fd4
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2021 06:49:59.6558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rzwBulYITZg/4R2Y8VPTvqTFvKrGFt+8wWK/qKoL2M6cVLA/mLJOYSka0hO6pHlg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB6890
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 2021-07-29 17:56, Liam Beguin wrote:
> On Wed Jul 28, 2021 at 3:19 AM EDT, Peter Rosin wrote:
>> On 2021-07-28 02:21, Liam Beguin wrote:
>>> On Fri Jul 23, 2021 at 5:16 PM EDT, Peter Rosin wrote:
>>>> On 2021-07-21 05:06, Liam Beguin wrote:
>>>>> From: Liam Beguin <lvb@xiphos.com>
>>>>>
>>>>> Some ADCs use IIO_VAL_INT_PLUS_{NANO,MICRO} scale types.
>>>>> Add support for these to allow using the iio-rescaler with them.
>>>>>
>>>>> Signed-off-by: Liam Beguin <lvb@xiphos.com>
>>>>> ---
>>>>>  drivers/iio/afe/iio-rescale.c | 14 ++++++++++++++
>>>>>  1 file changed, 14 insertions(+)
>>>>>
>>>>> diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
>>>>> index d0669fd8eac5..2b73047365cc 100644
>>>>> --- a/drivers/iio/afe/iio-rescale.c
>>>>> +++ b/drivers/iio/afe/iio-rescale.c
>>>>> @@ -41,6 +41,20 @@ int rescale_process_scale(struct rescale *rescale, int scale_type,
>>>>>  		do_div(tmp, 1000000000LL);
>>>>>  		*val = tmp;
>>>>>  		return scale_type;
>>>>> +	case IIO_VAL_INT_PLUS_NANO:
>>>>> +		tmp = ((s64)*val * 1000000000LL + *val2) * rescale->numerator;
>>>>> +		tmp = div_s64(tmp, rescale->denominator);
>>>>> +
>>>>> +		*val = div_s64(tmp, 1000000000LL);
>>>>> +		*val2 = tmp - *val * 1000000000LL;
>>>>> +		return scale_type;
>>>
>>> Hi Peter,
>>>
>>>>
>>>> Hi!
>>>>
>>>> My objection from v5 still stands. Did you forget or did you simply send
>>>> the
>>>> wrong patch?
>>>
>>> Apologies, again I didn't mean to make it seem like I ignored your comments.
>>> I tried your suggestion, but had issues when *val2 would overflow into
>>> the integer part.
> 
> Hi Peter,
> 
>>
>> Not saying anything about it not working does indeed make it seem like
>> you
>> ignored it :-) Or did I just miss where you said this? Anyway, no
>> problem,
>> it can be a mess dealing with a string of commits when there are
>> numerous
>> things to take care of between each iteration. And it's very easy to
>> burn
>> out and just back away. Please don't do that!
> 
> It was my mistake. Thanks for the encouragement :-)
> 
>>
>>> Even though what I has was more prone to integer overflow with the first
>>> multiplication, I thought it was still a valid solution as it passed the
>>> tests.
>>
>> I did state that you'd need to add overflow handling from the fraction
>> calculation and handling for negative values, so it was no surprise that
>> my original sketchy suggestion didn't work as-is.
>>
>>>
>>>>
>>>> Untested suggestion, this time handling negative values and
>>>> canonicalizing any
>>>> overflow from the fraction calculation.
>>>>
>>>> neg = *val < 0 || *val2 < 0;
>>>> tmp = (s64)abs(*val) * rescale->numerator;
>>>> rem = do_div(tmp, rescale->denominator);
>>>> *val = tmp;
>>>> tmp = rem * 1000000000LL + (s64)abs(*val2) * rescale->numerator;
>>>> do_div(tmp, rescale->denominator);
>>>> *val2 = do_div(tmp, 1000000000LL);
>>>> *val += tmp;
>>>> if (neg) {
>>>> if (*val < 0)
>>>> *val = -*val;
>>>> else
>>>> *val2 = -*val;
>>
>> This last line should of course be *val2 = -*val2;
>> Sorry.
>>
>>>
>>> I'll look into this suggestion.
>>
>> Thanks!
>>
> 
> Starting from what you suggested, here's what I came up with.
> I also added a few test cases to cover corner cases.
> 
> 	if (scale_type == IIO_VAL_INT_PLUS_NANO)
> 		mult = 1000000000LL;
> 	else
> 		mult = 1000000LL;
> 	/*
> 	 * For IIO_VAL_INT_PLUS_{MICRO,NANO} scale types if *val OR
> 	 * *val2 is negative the schan scale is negative
> 	 */
> 	neg = *val < 0 || *val2 < 0;
> 
> 	tmp = (s64)abs(*val) * (s32)abs(rescale->numerator);

Small nit, but I think abs() returns a signed type compatible
with the argument type. I.e. (s32)abs(rescale->...) where both
numerator and denominator are already s32 could just as well
be written without the cast as plain old abs(rescale->...)


> 	*val = div_s64_rem(tmp, (s32)abs(rescale->denominator), &rem);
> 
> 	tmp = (s64)rem * mult +
> 		(s64)abs(*val2) * (s32)abs(rescale->numerator);
> 	tmp = div_s64(tmp, (s32)abs(rescale->denominator));
> 
> 	*val += div_s64_rem(tmp, mult, val2);
> 
> 	/*
> 	 * If the schan scale or only one of the rescaler elements is
> 	 * negative, the combined scale is negative.
> 	 */
> 	if (neg || ((rescale->numerator < 0) ^ (rescale->denominator < 0)))
> 		*val = -*val;

Unconditionally negating *val doesn't negate the combined value when
*val is zero and *val2 isn't. My test "if (*val < 0)" above attempting
to take care of this case is clearly not right. It should of course be
"if (*val > 0)" since *val is not yet negated. Duh!

In fact, I think a few tests scaling to/from the [-1,1] interval
would be benefitial for this exact reason.

Cheers,
Peter
