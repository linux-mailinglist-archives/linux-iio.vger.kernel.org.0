Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02D03460567
	for <lists+linux-iio@lfdr.de>; Sun, 28 Nov 2021 10:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234512AbhK1JXO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 28 Nov 2021 04:23:14 -0500
Received: from mail-eopbgr80118.outbound.protection.outlook.com ([40.107.8.118]:47586
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1343737AbhK1JVO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 28 Nov 2021 04:21:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=deoIPeuv9tCOgTjqjbXLIAlk8TOcVLAA4A92yPFcgnRPTGEFZAKrQZohiuQa96lh+RkIVO8JmvOyP1hcVpSAof87lbSQLCgxrDmWqdcgj3T+9LYjiuBWWsKZO7epmZ3Il9Nla9DaJQ3IGL9+ES9ohH4govusoZvud2tbmdNGtWK0L9q2Ki7mJNRDmzjfW/NlSFmdFdjnm41n4nmH/OcOfSfU2yKpNeqDWOnb4xd215aeAkovnbP6PYZ1LxWlS0C80QwWWTSNEI6wU84tk0Ls2dlYKhEAl2yCeaJki5Wzg/P9hjtO0GKGZKJKx5b1eVB7KgsNwVs6hitUQQlqGaxAfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X096dXD9oOmFlXbNdC7Xf24wJccpXsSdkrmj3bfQQc8=;
 b=nbUphHjgMUze3fLrV918ZrbGqr79t+TLjxuevSTIju1clavdSO3zDYczw3jTbeevZd6+Pu22J4aZ8mx6Bin5iyH63Svy/UXnJT7/j8lgNFWbP0TLixuXy0D41iVwzCvANNA4X7UCf4N5c9HRWkq7pZVRbHeIxuAfxd16lPrBeLm9ScbEEXDxIS01/SwtP1dLXBp4n0A5/gpuJPXsRDoimZcoUCnxD8lp7wJ4ixHIqknXMir85GXK1Ca5dpNJjhKkVWsEhYK57VjUY4s3D69tLlsR601yuz339i1KN2Rh3jLYcvo6Faudv6qBQ9Z0K2OOcAmRLkF88lKIPpBn+C5FfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X096dXD9oOmFlXbNdC7Xf24wJccpXsSdkrmj3bfQQc8=;
 b=KqaFNHiMy5u8sVaUM+gfqud1qtDZetgo9D3DOcy4wk0SIqBx9RwUwOTlqNUw2FZZC1LkTUc+b/zpF68m44qYbdPTeK1eL+WBLX10D3oeS/nYegO4mapWkYDbB5VPMtFNL1Dpz2vnN/C0jaWRyz8pnc4eB68seNLLOJlgvFXIEg0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB9PR02MB7372.eurprd02.prod.outlook.com (2603:10a6:10:240::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Sun, 28 Nov
 2021 09:17:55 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::7519:c72c:98b1:a39]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::7519:c72c:98b1:a39%4]) with mapi id 15.20.4734.023; Sun, 28 Nov 2021
 09:17:55 +0000
Message-ID: <b9e1e804-fb59-660f-a9b8-ad6e20dd41aa@axentia.se>
Date:   Sun, 28 Nov 2021 10:17:50 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v9 00/14] iio: afe: add temperature rescaling support
Content-Language: en-US
To:     Liam Beguin <liambeguin@gmail.com>
Cc:     jic23@kernel.org, lars@metafoo.de, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org
References: <20211115034334.1713050-1-liambeguin@gmail.com>
 <156bc2fa-6754-2350-4a12-ff25b23ae8a2@axentia.se> <YaKUmha11ft6gip2@shaak>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
In-Reply-To: <YaKUmha11ft6gip2@shaak>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3P280CA0034.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:9::31) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
Received: from [192.168.13.3] (185.178.140.238) by GV3P280CA0034.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:9::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22 via Frontend Transport; Sun, 28 Nov 2021 09:17:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6fdd42f7-4daf-44d5-301b-08d9b24ff5f0
X-MS-TrafficTypeDiagnostic: DB9PR02MB7372:
X-Microsoft-Antispam-PRVS: <DB9PR02MB737223334E57442CB6E54469BC659@DB9PR02MB7372.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uKcfKcEBpEkc4/+mCRrobJFOGWGmfZ5ISnc6FlDim0NLuDcXs4Zm4TqtupDRhtuJ3UFuHsRbnHgHLav/Ysi28CKGooKXwPsWuXYOLrwBxlZFmRHUJEEKt5QbPaxtkuyemO5yopVbvStbt9KPcZtoY75oBjMum4grBKppgqNQWmN0S2ZUWR34j9VK9ui29187P35eX9nlnNK4UYF2zMsI2sTGRcIEM8MpVKvNr3Usou7NiKGA5XRFPEoEf7X4evyDwDWos5sHEWg8iVByQZit2ftS4ANy3JtE3+KE31Fsibm0+bqb2IuxfBBTzKZW4d8mNI+ybGIveW3orVgAHGUkVjVwqpNlAYhaTp84VWjUV6JpDEo5sGu5fzLcYdAoySuobyyaxF4OGKuXue7WHHmQuFhaQFqd82U2GMofJ2YFrKvsGUtugmoGiTeuNrn7KYA7H+gvSDpkBmmvUfnOvwZn8d+r7qQxAcjcMPTqZbg6jQVfXjTmPAcM8JsAOwita6V/GnArBHJFSLM5/Gquo+aXwFfVtwcicMAYUOcQW5XzHmfQPjJgpV50rKlQg4ot7Kvf+HC8MEWOVZTf+aW3IPwEZsPRGYqi5xVPoC4vkwS5Nd0tTug6q1BeSuZiQvinlTlyxhBNz2oYIhhDz1nlCiUzmyB977imIBdx57VfxnQv7CKP3NwyghOp/7v3hLP0fMQWn7Rn5GyGNNIQAejlAYBIbeKKTT031JONoPHOpgTHUq0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39830400003)(346002)(376002)(366004)(396003)(38100700002)(86362001)(6916009)(2616005)(956004)(36756003)(186003)(508600001)(66476007)(316002)(5660300002)(26005)(31696002)(31686004)(16576012)(66556008)(4001150100001)(66946007)(53546011)(6486002)(83380400001)(36916002)(4326008)(8676002)(8936002)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFU0ZS9KSTBxZitZb0N3VzhvYzkwcElwK2NPQ2dPS040Q24wSTlRZS9SM3Fi?=
 =?utf-8?B?cWV2Y2ZiL3pTSzFSd2dwUkdNa2VYRWpUb1prempCZ0tXL0VibjB2ZEpwTUdm?=
 =?utf-8?B?MkFHL1ZlV2VOc3FoZC8vbUUzbTVlcXNNUzdXMGdQd05hTGpVMHl1bElNMTdt?=
 =?utf-8?B?ekZ0c3hQbzF5U20wZHM0aXNkZHBOUnNMRVpId2RYMDgzKytnVHRwVVV6T1Bt?=
 =?utf-8?B?N3hCQys2NmdPVlEzTkxOM2VYMzZCb1djS1lMR20xTzdQdlByUjBId1RmMXlp?=
 =?utf-8?B?ZnVWL3NFS1plaHhyWWxFUG9kYXVuVlZWRm1RTEY0Tko0Q1dLcG4rOGpnUzVp?=
 =?utf-8?B?VjBNQUxxcEFNd09ITXpzM1QydlNHVmMrLzRlZUVUbzRyTExjNjlpZE9pRkYx?=
 =?utf-8?B?d1g3U2ZTNDREV3dOYUhtYlBabkhSQ3o3MnJCOWtMeHh5N3JYZlJEc1FNM3Bs?=
 =?utf-8?B?c3FjWUUwTkpXdmc0R1l3QldoZ2pqcUhuL3hhSUtiemFCSGNjd1lMNzZCQUR0?=
 =?utf-8?B?cm1tMGpEVDJnZWlNQ2xFWFJYTzY1UWNVU3V1WmwrZ2ZWcUJ6eHpVVDFsNW1v?=
 =?utf-8?B?SDArbVlZTll5cC95SzNRcGlySm9kVVZHRjVqSEtEUHErbVpkN0k0TnlDWlZz?=
 =?utf-8?B?U0gvV2wrUkl5dEh1Q1FmeHhVTEF3THc2cUM4T0hLRzRMNFUxTi9XT0JDa3J0?=
 =?utf-8?B?MmxSWnN3d2pEa0dCeFFRL2VLTStjRys1VDRRR1B4MzdqeEpJaWlFWVIzbmdl?=
 =?utf-8?B?aWR5UmhYaWYzZEdlOE9peTJSMVZGUUVkL3pQMWdrY0lFeHJoWWpRZG5CYStv?=
 =?utf-8?B?SFoxYW5OTERRb2k2UG9JTTh0bE0raGdVL1pielFpdGtFNGNLMkRyMjc4RkE1?=
 =?utf-8?B?Z0laM1VjREFTc0ZJbUhXVDNoNkpKM2lQT0RvS1lMZWY5YWhMQ3Jpb2VCQUcw?=
 =?utf-8?B?MFA4b2h0cUpnWWQyZE00d21oeGVrbmNBR0c5TW50bXowSXY1eStZZ0hEbE13?=
 =?utf-8?B?dFJUMVJ2REJRUDVtQng0a1VJSkJKLzZpK0lQZURTUGxDU0RBczdycy80ODRL?=
 =?utf-8?B?ZlIrbEdxNWFDaWV0dmVsSm5LcUdLNlAzOHA0RUpqQ01HZ2RQV01HdU1aeito?=
 =?utf-8?B?VHNRdnpMS29JVW03dXZVbnhHc1c0M1kzMUt1OVpsZjREa2JQNnQ1Nzd6czJF?=
 =?utf-8?B?KzZ1YVBPczZkWnlvR0VlSEFmMmM1RWVrMnA2cUU4RUg5UEIwTkx5eENuM0Rs?=
 =?utf-8?B?d0lyRi9DMkJmcVEzdHErRmlaR1ZYbGNUS1Y3aFV5U1M1MFdzZWlzWENTbTJy?=
 =?utf-8?B?YjVPeVNVNFVQYU9NazN2c05iVFltamV6Q2IrU3FvV3JVWndOUlNJRTd6Z1Nu?=
 =?utf-8?B?MnVkbEhQMWJncWFpVm9lZVFiWUNVWktXbWhjR1h3em9nMWlGblZkT2dUZTRG?=
 =?utf-8?B?ckt6ZDFJd1NJYkliSTVIZ2M3OTRXempKZ0ZpcThBQmtlNTVOTkRQUEJubVFs?=
 =?utf-8?B?TzdJeGFHRHZwMm84Z3dCN29rQkFTRFU4QmFMV0RlSnJzZURyemhKVVJSV3VJ?=
 =?utf-8?B?WjNXY0twMndIL2hvbDJmR3NsWkRZMDhBcnVVV1c5clY2VjRJa1FLUFR2elhW?=
 =?utf-8?B?dFZnbEhZTGFnYkMwVjBJSTdEY2o2SXcrMkNPckh2T0h2SkRYdDlDdDR4V2xl?=
 =?utf-8?B?eE9sQnZYZVU4a3BWSlJwVVJJTlF5NjBMRVhjQ2hZTVNqcFplNE1HVDd6cThK?=
 =?utf-8?B?ZEZ5RnNTNjBwRlNQc25qVTdqK3NIT21SZVlmbjhRVlcwL0pLTWs4U2h2M2hG?=
 =?utf-8?B?TXkxVWpDRDcrTGlNMTBXUXNoc1JBLzVDUlVPd2lCczI0N0NOT0RVT1lzbTNK?=
 =?utf-8?B?eGZMYVhtT1ZjcGd4OTNmYmlxa09Fb1h5OWFPNGt4KytldE5kZUttVFFLNUgr?=
 =?utf-8?B?NDlWNURjR1owVEZVSW1KVVE0ZlFlQmwrZEhLTFAvaW1ZL1ljOVhSdlhIVTVX?=
 =?utf-8?B?VEtuTUdGQ2VuZk45S1hTZ0pnZHJIdmUrdFRtU1R1aFZubFV6dUN3WklDVzVu?=
 =?utf-8?B?bFBpdkQvanc5Y2ZwaFE4MTFlaVNSek82alVmOS91dXJYakJHNW0zY1o2djk2?=
 =?utf-8?Q?l35o=3D?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fdd42f7-4daf-44d5-301b-08d9b24ff5f0
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2021 09:17:54.9434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J1N+NbhnZQ1EGlDKR3nq2mhaLE1p217DCPAZirtTlTopnwDmGkukjuJZ3Wdjtsxl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB7372
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi!

On 2021-11-27 21:27, Liam Beguin wrote:
> Hi Peter,
> 
> On Mon, Nov 22, 2021 at 01:53:44AM +0100, Peter Rosin wrote:
>> Hi Liam!
>>
>> On 2021-11-15 04:43, Liam Beguin wrote:
>>> Hi Jonathan, Peter,

snip

>>> - keep IIO_VAL_FRACTIONAL scale when possible, if not default to fixed
>>>   point
>>
>> This is not what is going on. Patch 9/14 will convert all fractional
>> scales to fixed point. But I would really like if you in the "reduce
>> risk of integer overflow" patch (8/14) would hold true to the above
>> and keep the fractional scale when possible and only fall back to
>> the less precise fractional-log case if any of the multiplications
>> needed for an exact fractional scale causes overflow.
> 
> Thanks for looking at these patches again.
> 
>> The v8 discussion concluded that this was a valid approach, right?
> 
> Yes, I remember you saying that you'd be more comfortable keeping the
> IIO_VAL_FRACTIONAL.
> 
>> I know you also said that the core exposes the scale with nano
>> precision in sysfs anyway, but that is not true for in-kernel
>> consumers. They have an easier time reading the "real" scale value
>> compared to going via the string representation of fixed point
>> returned from iio_format_value. At least the rescaler itself does so,
>> which means that chaining rescalers might suffer needless accuracy
>> degradation.
> 
> Agreed, that makes total sense.
> 
> If I'm not mistaken, the first condition in the case, if (!rem), will
> return IIO_VAL_FRACTIONAL if the division is exact, keeping all the
> precision. No?

Only if the resulting scale fits in nine decimals. That's never the
case if you have primes other than 2 and 5 in the denominator (after
eliminating gcd of course). Which mean that if you chain one rescaler
doing 1/3 and one doing 3/1, you would get a combined scale of
0.999999999 instead of 3/3 if we take the approach of these patches.

So, what I'm after is that - for IIO_VAL_FRACTIONAL - not take the
multiply-by-1e9 code path /unless/ the existing fractional approach
overflows in either numerator or denominator (or both).

Side note: The same could be done for IIO_VAL_INT when the numerator
overflows (since the denominator cannot overflow), but I guess that
can be done later.

Cheers,
Peter
