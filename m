Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1A793F41E4
	for <lists+linux-iio@lfdr.de>; Mon, 23 Aug 2021 00:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232921AbhHVWTt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Aug 2021 18:19:49 -0400
Received: from mail-eopbgr130113.outbound.protection.outlook.com ([40.107.13.113]:48127
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229700AbhHVWTs (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 22 Aug 2021 18:19:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jdmR+8ElyYh+9RX61i2a9RDuWN1hZilsVlStFP3I859/T0EOtQKTz6YxLZeq7QFmbtc09lXKNqPSMMi6/cP00p924adn6Q8ys7Ftw0lUnVRQ3CSfPoU1wK8YTmLVY8HawsiJjghu4md179z3hI27MbnEHI1u+LGVPCv2qhuG0EW9tOqIe5tAc4qtfPs4hOvnQM6WdfvVFPKP3dFksotc9wV2kMQqxM7xuhgCUjCHhmjdh2/mDRHCAOER1uTnyM4Mc42xR0y3CTW4hROt2CP886s3smTZURuEleqPefHm5DBSk1TYC9iCxSlIUARonCT6ueJlNpnNe8BGg0AmZorajA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pjNXu8Z/DgPq6vKU4fEwUtncg5i3ELJYdIRTw0dHdtg=;
 b=gDo+ZZ71dIK8hzY4Bh4i2/ZyokwepvPTd6BhKcs2yg+rqU4sucinFZgtikO1hg1NALY1HFrWH70fsLuvVKMqvhdQ5vtfTI//mUE/Y01YXuOuI6jOvyDRis+M+myB//Qnhu5Zl+gLUUe1JoDuL1Uyuv5b4a4Iks2eun/Lz4eYoj5A9CZDPiN2d5U65RKTK3PSuMcogdC36aRa2a3zwNOaNIZ04/TNQ6lo5oZ9WZ3Bpxwkmdg+q0pZhGO/gWH51FyNyDITlUKOo9IIUZ2/+rQYPxOHa2UTVUF3dR+8brbYXSTAD0+5gtgv8sfDwEn7ZaCMPFdMq4Ae4kqtbBJi3iwjgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pjNXu8Z/DgPq6vKU4fEwUtncg5i3ELJYdIRTw0dHdtg=;
 b=fu2KtqpYOi38jS/QZb3c+mbUvIfoRIMJZpN79R3W7UbgIj8Smo02pfYa7nl685xtaIIkK/8GmFLwCt3dsJClONhOPMdN/D61j6bhpk9Qc9gCoW7f9ezSFBM0yFmkx0Hw8vw6Eje0Tc2dPmKjyM9LpG4a8HRnowh0mKXUQ3RxAmE=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DBAPR02MB6245.eurprd02.prod.outlook.com (2603:10a6:10:19a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.22; Sun, 22 Aug
 2021 22:18:58 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::35c9:1008:f5af:55a]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::35c9:1008:f5af:55a%4]) with mapi id 15.20.4436.024; Sun, 22 Aug 2021
 22:18:58 +0000
Subject: Re: [PATCH v8 09/14] iio: afe: rescale: fix accuracy for small
 fractional scales
To:     Liam Beguin <liambeguin@gmail.com>, jic23@kernel.org,
        lars@metafoo.de
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
References: <20210820191714.69898-1-liambeguin@gmail.com>
 <20210820191714.69898-10-liambeguin@gmail.com>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <2d028a60-d1fe-7fa1-da4a-0d80f8d468ea@axentia.se>
Date:   Mon, 23 Aug 2021 00:18:55 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <20210820191714.69898-10-liambeguin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR0401CA0109.eurprd04.prod.outlook.com
 (2603:10a6:7:54::38) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.13.3] (85.229.94.233) by HE1PR0401CA0109.eurprd04.prod.outlook.com (2603:10a6:7:54::38) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Sun, 22 Aug 2021 22:18:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5911fc5e-3004-4818-b904-08d965bad61a
X-MS-TrafficTypeDiagnostic: DBAPR02MB6245:
X-Microsoft-Antispam-PRVS: <DBAPR02MB6245A083E1F2A522264757E7BCC39@DBAPR02MB6245.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mJdgRyUX4gzFsYyrJmb7mCPgnnwFbg5/YAoMFfd9X5yxTzD8O0yg424XPkaV5AKcUsoR52Rwwmb5Q6en6PKNVEcnmY5LARESUkTUjlf0xmWQNeytQiu4S3k0Kfc36+YyUhSaOCwm40TRLbEl3UBfiAjbuUIALXxfv9w6PbjfsKZF+kczcjJH32uA62lPvR8k+D0Kbq4sZpVV0KvC594xey0uX+wlRbzEJgIlY8DpDg3jn5cMlRiiGM7kStweHIpU8nwBI2h+UpQOKH5TsFIZsaH45prAQ9gXkPST/wW90wM/o6mpVL3jN5LBzPxji3JQNk8gtIyxTShPE1TdDGYViSDwwTCwpdC7UooY1xIoiqNSgzDg0NTeN80WIlY2uP0Vz8dMoUSTUDwjxEVqgq5OMqH2S9nD3RjIigdAtHcYqHz66giXwEZUaNryWZ6fqt9lz/1ZeQT3JsHqCOm2EtiuF5yv/zxK9imS1O11aWdcE4GtSQGcF6MMvP/4hiAdH7mopdIaauP3dWGie8Za4Hwj4KNMR+STd9yIWvqpQ5IzcJNB92gpClbsbtfh6SggxdKtBW6YxqcE5OKq2wHD26D4qccPkSSQcwKkeXv3pSaIiN+qtDpc6YXBDehGxS0Zly75o+4H5g6y59nc7tN23dxY2EhvEE6ISaNATJ1ga98JCt/XFa7/o+0LAvTEhyLL7at/nMRxwFLdc98E2Ap5mCHa2RE8Y18j9UoFhajMVSn8Vh4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(39830400003)(376002)(396003)(366004)(346002)(136003)(26005)(186003)(6486002)(5660300002)(31686004)(31696002)(2616005)(956004)(8676002)(66946007)(4326008)(16576012)(478600001)(8936002)(316002)(66556008)(36756003)(66476007)(83380400001)(36916002)(53546011)(86362001)(2906002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDBqYXpEY3pBQXR6MXBpYVlRZXdSNVNFMFAxOG1qTWdlb1ZkODVsOUxoWTVz?=
 =?utf-8?B?Qkg0c2NZT0ZCZlVmK3ptRmhkb0k5YWFzRnRaSXdKY29BM3FsNllYbXNMVDJG?=
 =?utf-8?B?WDNYYjNZVGdVbC9Qa2ozbnFFeXV1MDFPK0xPWkl0UmdmMVh5Uld5b01vQVFJ?=
 =?utf-8?B?cng2dXgwazVBYWo0MFg1b1ZDcGxqMjNTbytjODJrdzIzdnJNT0pRZWhETmUz?=
 =?utf-8?B?b2tnaWNkN0FURjc4NTFOSExpclpuVkJNbTlFMmpTdVlGbTN5WmxtUHVkMkw2?=
 =?utf-8?B?RlM4LzhzRnhhVTVTdVlGdWU1THB3Z05kZ1VCOEh0a3hoNHhrbnNFMXMrbi8y?=
 =?utf-8?B?UlF0Z0JqM0JiK1gzdU9MbWVLZkhDaXJpWHZGR25WVzZ5NUlNL2pkWXRVd2Z6?=
 =?utf-8?B?Ym9mYWc2NUozaVBOOTBROGIvMEFOUit0QXpRdVRRSjVRY05PYWpFWm8zelFr?=
 =?utf-8?B?RmJRVWNrQ0xQMGJlVzVLbDBwQlVBYkY2MVJMcjhlQzB2bWtmbzV3QWh5ejBL?=
 =?utf-8?B?MkN3NkZnOHVCQXpaMjFEazN0R0VmaCtKNW1JWFErSlU3d1NnSURnRmEwa1dX?=
 =?utf-8?B?QlE0WjRaUU9qbm5wK09UQmgySDh0ME9lYW9HdzMwNGlZNFEwd1BqMUcySkI4?=
 =?utf-8?B?QWZVNnJNeE4xUk05clUrNC8zMWpRSnBEaW85dVhtSGlRWE5qOUxZV1lTNnBB?=
 =?utf-8?B?cGEyU0lPaHk4SDF6RU1zYWc3ZjF4TUp4VjBBRTNLWk1RT3FpOEtMcXFFbnp6?=
 =?utf-8?B?M3JpZVM3MXFzbnVINW9zZFA1ek9rRklHZytDNVdPZkc2YmU4TURnb0ZhQzBM?=
 =?utf-8?B?N2JBUHVFTVMzbU5LbUVLeVZ1RzB0R1pCTnlKbE84d1lTaHVuMXFPMDNoNXVl?=
 =?utf-8?B?NHdsWGpjMkIrdmNzcmtoVmxRS3RhQmpaOUE4Z1g0Mll2Q3cyb01MRnVpTit5?=
 =?utf-8?B?Y3JVaitFZDRwOGZDUTAyQmJmU0k3QWhYQkRLUG1sbEthWkdMZVEvRlcyaCt1?=
 =?utf-8?B?UGtCUjJNb0ZnTnBhK3NLTVdGRUVCYXEzTUNaN3BaS3hINUo0QVpURi9aMzgy?=
 =?utf-8?B?RHg5ckRYNkl5SzNocjcyOElNUmFDZTBpSVl1eHZHVFZqcTZCdCthUituQWN0?=
 =?utf-8?B?QTVtZmlMQXF5bWcwTnhHcnpBS1NwMkVEdnk1bVA5aVNhdG9HcENST0d1MTlk?=
 =?utf-8?B?SU9BU1FseTdkaCtYbko2UWJCZUprYXJheTVhbHBWVW9HMy93eXdKUC9hUzJB?=
 =?utf-8?B?SGJMSTdDbDg1MFFOY1BLbmhGSGpLbmFCNWNjR0dWbWs0MHZPZ2hjNjJ3ZTZP?=
 =?utf-8?B?VXlJTllkektQNGtEZnhURWhRWVg0UVpoL2h3Y0dpcTFxWXdaVTNLcnBxTzJT?=
 =?utf-8?B?SzdLZDUzNEp6T0ZCbnBVRW1qNE8vWXRxWm9IeGR1OWpHR2lQUUtyV1N1U1RL?=
 =?utf-8?B?UjByZ1gyVXplbGJVR1hNblViZFdRR3pZM1UzNklFZG1uZ01GbHRTQ1dlZm8v?=
 =?utf-8?B?WkVtanBMQnN1RDFnNUlISzQ3dkF4WEJLcVlGeHowdzA1UG13UGtOTDNwTHhW?=
 =?utf-8?B?U1NKODl0enZGVmlCQjE3NkUyUU52TGlMNldReXM1MDhqTmxLeStTbWtwaEFo?=
 =?utf-8?B?UEwzV3NRZmxSVStlK2FqTDIyZ0NEZ3U2ekV6MDhJc1AwaWw4RTF3MnFGdWdO?=
 =?utf-8?B?RGZNdTVyU3RSbEh6M1d4WEs1NGpLZWVBcDc1RWxSQWxITmV3TWpid0Vjcjhz?=
 =?utf-8?Q?Y7S08KfxxCyPNPvMQWeBN1DhkgKZm3POSdWQnfI?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 5911fc5e-3004-4818-b904-08d965bad61a
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2021 22:18:58.1792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CK7RVVy46UcB50nJyVxZWaIwVh2HILZ0mbctsW8UDloVTDH7c7HUhSVCM9c9vks0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR02MB6245
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

[I started to write an answer to your plans in the v7 thread, but didn't
have time to finish before v8 appeared...]

On 2021-08-20 21:17, Liam Beguin wrote:
> From: Liam Beguin <lvb@xiphos.com>
> 
> The approximation caused by integer divisions can be costly on smaller
> scale values since the decimal part is significant compared to the
> integer part. Switch to an IIO_VAL_INT_PLUS_NANO scale type in such
> cases to maintain accuracy.

The conversion to int-plus-nano may also carry a cost of accuracy.

90/1373754273 scaled by 261/509 is 3.359e-8, the old code returns 3.348e-8,
but the new one gets you 3.3e-8 (0.000000033, it simply cannot provide more
digits). So, in this case you lose precision with the new code.

Similar problem with 100 / 2^30 scaled by 3782/7000. It is 5.032e-8, the old
code returns 5.029e-8, but the new one gets you the inferior 5.0e-8.

I'm also wondering if it is wise to not always return the same scale type?
What happens if we want to extend this driver to scale a buffered channel?
Honest question! I don't know, but I fear that this patch may make that
step more difficult to take??

Jonathan, do you have any input on that?

Some more examples of problematic properties of this patch:

21837/24041 scaled by 427/24727 is 0.01568544672, you get 0.015685446. Ok.
But if you reduce the input number, gcd(21837, 24041) -> 29, you have:
753/829 scaled by 427/24727 which still is 0.01568544672 of course, but in
this case you get 0.01568154403. Which is less precise. It is unfortunate
that input that should be easier to scale may yield worse results.

760/1373754273 scaled by 427/2727 is 8.662580e-8, and 8.662393e-8 is
returned. Which is perhaps not great accuracy, but such is life. However.
761/1373754273 scaled by 427/2727 is 8.673978e-8, which is of course
greater, but 8.6e-8 is returned. Which is less than what was returned for
the smaller 760/1373754273 value above.

Some of these objections are related to what I talked about in v7, i.e.:

    Also, changing the calculation so that you get more precision whenever that is
    possible feels dangerous. I fear linearity breaks and that bigger input cause
    smaller output due to rounding if the bigger value has to be rounded down, but
    that this isn't done carefully enough. I.e. attempting to return an exact
    fraction and only falling back to the old code when that is not possible is
    still not safe since the old code isn't careful enough about rounding. I think
    it is really important that bigger input cause bigger (or equal) output.
    Otherwise you might trigger instability in feedback loops should a rescaler be
    involved in a some regulator function.

Sadly, I see no elegant solution to your problem.

One way forward may be to somehow provide information on the expected
input range, and then determine the scaling method based on that
instead of the individual values. But, as indicated, there's no real
elegance in that. It can't be automated...

> Signed-off-by: Liam Beguin <lvb@xiphos.com>
> ---
>  drivers/iio/afe/iio-rescale.c | 27 +++++++++++++++++++++++++--
>  1 file changed, 25 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
> index c408c4057c08..7304306c9806 100644
> --- a/drivers/iio/afe/iio-rescale.c
> +++ b/drivers/iio/afe/iio-rescale.c
> @@ -22,7 +22,7 @@ int rescale_process_scale(struct rescale *rescale, int scale_type,
>  			  int *val, int *val2)
>  {
>  	s64 tmp;
> -	s32 rem;
> +	s32 rem, rem2;
>  	u32 mult;
>  	u32 neg;
>  
> @@ -38,8 +38,31 @@ int rescale_process_scale(struct rescale *rescale, int scale_type,
>  		tmp = (s64)*val * 1000000000LL;
>  		tmp = div_s64(tmp, rescale->denominator);
>  		tmp *= rescale->numerator;
> -		tmp = div_s64(tmp, 1000000000LL);
> +
> +		tmp = div_s64_rem(tmp, 1000000000LL, &rem);
>  		*val = tmp;
> +
> +		/*
> +		 * For small values, the approximation can be costly,
> +		 * change scale type to maintain accuracy.
> +		 *
> +		 * 100 vs. 10000000 NANO caps the error to about 100 ppm.
> +		 */
> +		if (scale_type == IIO_VAL_FRACTIONAL)
> +			tmp = *val2;
> +		else
> +			tmp = 1 << *val2;
> +
> +		 if (abs(rem) > 10000000 && abs(*val / tmp) < 100) {
> +			 *val = div_s64_rem(*val, tmp, &rem2);
> +
> +			 *val2 = div_s64(rem, tmp);
> +			 if (rem2)
> +				 *val2 += div_s64(rem2 * 1000000000LL, tmp);

rem2 is 32-bit. Might 1000000000LL also be 32-bit on a small machine
where 64-bit arithmetic is really expensive? In that case, the above
is broken. The safe route is to do these things as in the existing
code with a cast to s64. But maybe that's just cargo cult crap?

Cheers,
Peter

> +
> +			 return IIO_VAL_INT_PLUS_NANO;
> +		 }
> +
>  		return scale_type;
>  	case IIO_VAL_INT_PLUS_NANO:
>  	case IIO_VAL_INT_PLUS_MICRO:
> 
