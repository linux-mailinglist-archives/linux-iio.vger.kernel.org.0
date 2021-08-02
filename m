Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5B53DD2C1
	for <lists+linux-iio@lfdr.de>; Mon,  2 Aug 2021 11:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232966AbhHBJRR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 2 Aug 2021 05:17:17 -0400
Received: from mail-db8eur05on2132.outbound.protection.outlook.com ([40.107.20.132]:41835
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232670AbhHBJRQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 2 Aug 2021 05:17:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SXk2/UwBWdR/dWeJomemy3SWUw91Y/Ar562SIQPNG6fcYH2qB6INTygnD2nBarCJT31LzNq86Wu6toT9UiFBjPNpGXUJz5xkDn6a02wZC8JhN0LhZVEFII9tgk4hv0cw0P6J8KvUl54DseDm0vzcI8TyAVGeoJrsHgL/N3X0GQxuv2Crlb8quM9ODqCxa6qH8/BKihdUymr2GTq1a/YSpxUVivY+G0W72aSVts1LKtOMdZIkw7Dc/JG+IJB6LaStto8RIzYO+AdtZ8/HFQYClp/gdNv4/pzwHcHqsMgYdxfBq68OS/dXehB85AnNXfX/AyPvbJHd3KjqCjLebO88QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DH09aWkIAz3yJzc9klFaEnvDwPx7y+G66PsEAM+4aeQ=;
 b=iHnUkCOGfYlhaGbs2Zfn6/4bDOIrQsdHT3ImopJbW9Osyi2KAu4cmmYVfnkd7KFTjBEBSrbr07YQEwr4MGD6ARPcUa4kqY/oji2pKZMnkMmO2vn3lSVSqI+xIj3Jd1nNfaph6pbJ1keYr+NzXvHVVD/mO5LOcSUw4pelGj5LuTuBMkMEJVkekPVmUqIR+zfnGJfSS7+hYzHfsYimkxUJB99wlY+VViMU/4WPrGPueVPHjkNzDOEaGjjG9rELSobBrLEZUgloNofGCa2sxiQ5vLI7ij5/N+0pYw97Gc17I87LfDoFrkyaiyjOHYEMFNiOIPRKPZD+9DouUccWfmUQ5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DH09aWkIAz3yJzc9klFaEnvDwPx7y+G66PsEAM+4aeQ=;
 b=SlmYa5kYrvMvEggF+twMr1f+GW1Cx+CkpcWXR2XcYuzyJ/udUHdAXZcTMiik0R9LoKMgkq28pEmT95uR1kSCFIz1ECYtX+IU6jzEdylL63i1Py2ItgwJC0dXnknsyWQoyV8+qhtzQjXqGZ2zd6fSTk9TmvLyBtevTRTvbTOzWmY=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB6PR0201MB2392.eurprd02.prod.outlook.com (2603:10a6:4:37::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.25; Mon, 2 Aug
 2021 09:17:04 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::14ca:a41:2218:3578]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::14ca:a41:2218:3578%6]) with mapi id 15.20.4373.026; Mon, 2 Aug 2021
 09:17:04 +0000
Subject: Re: [PATCH v7 08/13] iio: afe: rescale: fix precision on fractional
 log scale
To:     Liam Beguin <liambeguin@gmail.com>, jic23@kernel.org,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
References: <20210801194000.3646303-1-liambeguin@gmail.com>
 <20210801194000.3646303-9-liambeguin@gmail.com>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <3be0f8d4-eea3-9959-b12d-e28ddae9e23f@axentia.se>
Date:   Mon, 2 Aug 2021 11:17:01 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210801194000.3646303-9-liambeguin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BEXP281CA0007.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10::17)
 To DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.13.3] (85.229.94.233) by BEXP281CA0007.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.9 via Frontend Transport; Mon, 2 Aug 2021 09:17:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7dfc0f3f-d520-4e7a-72d2-08d955964b1c
X-MS-TrafficTypeDiagnostic: DB6PR0201MB2392:
X-Microsoft-Antispam-PRVS: <DB6PR0201MB239264A7B21ECEC022FDCAD4BCEF9@DB6PR0201MB2392.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jg+n0wuWhPNqvb+iSK2kw7mV67YU+abqkmO1Wid3zyHYVMr+A/hYEbZ+TH9Id8xOsPRVvA56gvcAanu5XbFarZsbNF+lZdfHzcePhElPj4lUbCn0Vn+A5G8yycS36A0Ppr4oRMqT5R0AVLpuDdw2Yla6sDv4o3i+CPuqhSdd28N6w888kpE31Wokn7yqa0ry8+qHTMhNRCZZ7JHBjxhO6vVG2/jv092DL6VRRmybGk9KK7WHMoTI76E3+EVyd+0yqPVwchPthQTLnTsv1jZM//X0EmcFlFeOOj5pGf8wY9Tys5OjthIsGAmNgdXdoUqAmSjIkkUXNtugUpGAQP8SRFMgWiOgVv/h95FtqCn2WG7LZNt4CCUe1bDmnilCbC+cT4y53c3Dae9gAIJyNOpmpg0N6aAMFt0rRTubjYN70FBSWNzT93F6PSVMtaGmeSGN2+u41G8qIXC7bby1a/mZvSwwLzqyXDeY4EB+j1KOGyN07wHRQDS9IDCDXpFtFTtGoE3O6v2c9P64RnuwfJltZFQnhxcmU8SjMVdXU2pFlYXPjYIiodFBxFa1+k7kLiHG202mgyJNvvm9jKOFiGxv71QrxfwrzTF+xPsGlDKDIyvJNtBvvr4uinUjDNxRwkYP98sBcOCSdX8DA1T5LEo4yV/W1/bv5vkm3twcFM7sJXj/dcXnHt23L1Yi/f8rKOfRM2GbUs/8nrVb/afcJp5woEJt415xmSAvOGeVR7gvdto=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39830400003)(346002)(136003)(396003)(366004)(6486002)(5660300002)(478600001)(26005)(316002)(31686004)(36756003)(86362001)(66476007)(31696002)(66946007)(2616005)(16576012)(186003)(66556008)(8676002)(83380400001)(4326008)(36916002)(53546011)(8936002)(38100700002)(956004)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1A1YW1ycE5UT1NRR3dpREIyQjBLN200YmRrY01LaFp2NlphNitFWkZMQVpP?=
 =?utf-8?B?QlpER25pZll3WDhhakwrSVF3RnM0TkRFSEVjR2FtNE96U0VsMWREWnl0ejN2?=
 =?utf-8?B?amVWd0ZWRWhFTFBUalpuaEVQSkRPUitPTm40U0V6WnEzcjNkS2E1VGxRdHJX?=
 =?utf-8?B?bm55Rmw1NkZmRndXVTIvMlA2dXo0TkR0dkxCbzgwd0d6TWVrejM2dk83UG5K?=
 =?utf-8?B?V0Yxb0djQ244OVlTODdkUUlLUGJ5VTFScmsxKzgyOHBTNW50UjBjbHVrYUVs?=
 =?utf-8?B?T3BveHppcDV2UlNiZ1VUbG1HZzZWU3ZkaXFQUUVvWDNFTUwvVm5oTTJLcjY3?=
 =?utf-8?B?VFhBSnUyZVNNdjAxenB6NUZXL2lZd2NWdlYvbUhIT1QyM0ttYlRqamc3eVVH?=
 =?utf-8?B?YWZRcUdNR0hoQjZSR09PR1lGc3I1ZEs0b2ZwUzRqRll2Tm5KSm9oYWJnMmM5?=
 =?utf-8?B?MmlMR3BXSXN0UW9mLzM4TERRWUFON3JZWTVnYnlhRmFzbm85d2xucXFra1lY?=
 =?utf-8?B?a0g2RlVId0NqQm51Szd0RTZKakFQd3YxM0huY3FiV2x5eVhmOWlTUllPQkJ5?=
 =?utf-8?B?S2pvb0ZpaWJiMFo4WGJUdURGcHhidDdhSzRvU291Q0ZIOG1NY0p6YjZESzA5?=
 =?utf-8?B?MFdlWTNsM3lRS1I4UjFYSEY2RnVCdXRZMnFXM1hVdHc4bnRoRVlKTVRMVW03?=
 =?utf-8?B?bmlDWjFBQmN0eG1lcFZ3aEVPYXZKUFN0cDVkaDd3cVlFL3o5Rlp0ZnBnWlda?=
 =?utf-8?B?a25wanc0cFl2anE1Mm1OdVlESXBhRXFVeUM2THU4Z20wQmJOakVIeGpQanVC?=
 =?utf-8?B?bnhuMXNkaENqVXV1T09FU0VWa0NaTnk1cVVmSE9WR1UrQnhpTllVMzBzSm52?=
 =?utf-8?B?VitPTElYdlJOdlUyS3BZREdlRDN3Q2d6QWMwWUFsNndlS05wS1BMNjBxMzFL?=
 =?utf-8?B?SmZKVklnVldQQVN6eDVZSGxhS3RaVlQyWVBxUElvUlN3VkFCUllsT3FxUE90?=
 =?utf-8?B?NjlrejVPWXhDb0dKM0VJVS9uaDRSVWh1QkNBRU1HZnRTNDZSdjVIWCtWTHBG?=
 =?utf-8?B?aWZUMGduUjB3bS9haG1BZTdOU2Npa1RPK1l2bUlWeWRaeG82dTFSN2k4Mk5v?=
 =?utf-8?B?OElPa0JGUlhINjBIcE1PQ2Q3eit0WGxNemdKVStNQkkzdjFnd05oNEhnbTNX?=
 =?utf-8?B?MGpRSFhjTGRES25TQlZrTE54cUNNYUxaek9RZjAvWE9YWlZueE1WRW42bTRj?=
 =?utf-8?B?dXRZNkxDbXhOWG5UbUlPT21VUlRhb2h5NmRkWHZDT2x5bUZiYzlYbXEvV0Fs?=
 =?utf-8?B?VjJoakx3cVBLMFBGUXlWa1JCWUY1N3JRQmZldTV2MXhKMW1BZW5KclhnYWV0?=
 =?utf-8?B?eXA5RDhwc2VIdll2bnppM0JCV2R5M3ZoVUowTENBcnYvTVR2VHlkSFR3djUv?=
 =?utf-8?B?NUczRWtLeHpBNGVoYzNFUVVXK0MrZDRGOUE1WGVBcmJiNmdVUFJtekRuY0lU?=
 =?utf-8?B?dzRxYkpFc3lMa2J0TURDY1NZMUhCMnhPblNXdVE2alFIZHZ1cGN4K2RTRWZC?=
 =?utf-8?B?a01SNldsV01GdC9aSm14OUdDb2dwVVhSTlk3ZDk3UkRHWU5VbXpKaEJQS0tq?=
 =?utf-8?B?ZythSU4xQU5ucXlrcGVVeDU0N0ZleWU1c1krWjFrTGt1MkEwVnBzRVhqZEtR?=
 =?utf-8?B?SDZvSE1ORHNvaHppWGdUT2RNcFRQV0hqcS9Ic3FOMGlkSlI0MVhGbS9sKzhC?=
 =?utf-8?Q?zArj3RE20epk0qroka9WmVaep71UIDHc6EEweSg?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dfc0f3f-d520-4e7a-72d2-08d955964b1c
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2021 09:17:04.5635
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t88IZ9MXOqfCoRgBljuI9tdhBIyBfkm/E9UJpbGeVzQXededot081qfCQAG9TfS0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0201MB2392
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 2021-08-01 21:39, Liam Beguin wrote:
> From: Liam Beguin <lvb@xiphos.com>
> 
> The IIO_VAL_FRACTIONAL_LOG2 scale type doesn't return the expected
> scale. Update the case so that the rescaler returns a fractional type
> and a more precise scale.
> 
> Signed-off-by: Liam Beguin <lvb@xiphos.com>
> ---
>  drivers/iio/afe/iio-rescale.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
> index abd7ad73d1ce..e37a9766080c 100644
> --- a/drivers/iio/afe/iio-rescale.c
> +++ b/drivers/iio/afe/iio-rescale.c
> @@ -47,12 +47,17 @@ int rescale_process_scale(struct rescale *rescale, int scale_type,
>  		*val2 = rescale->denominator;
>  		return IIO_VAL_FRACTIONAL;
>  	case IIO_VAL_FRACTIONAL_LOG2:
> -		tmp = *val * 1000000000LL;
> -		do_div(tmp, rescale->denominator);
> -		tmp *= rescale->numerator;
> -		do_div(tmp, 1000000000LL);
> +		if (check_mul_overflow(*val, rescale->numerator, (s32 *)&tmp) ||
> +		    check_mul_overflow(rescale->denominator, (1 << *val2), (s32 *)&tmp2)) {
> +			tmp = (s64)*val * rescale->numerator;
> +			tmp2 = (s64)rescale->denominator * (1 << *val2);
> +			factor = gcd(abs(tmp), abs(tmp2));
> +			tmp = div_s64(tmp, factor);
> +			tmp2 = div_s64(tmp2, factor);

The case I really worry about is when trying to get an exact result by using
gcd() really doesn't improve the situation, and the only way to avoid overflow
is to reduce the precision. A perhaps contrived example:

scale numerator   1,220,703,125    i.e. 5 ^ 13
scale denominator 1,162,261,467    i.e. 3 ^ 19
*val              1,129,900,996    i.e. 7 ^ 10  *  2 ^ 2
*val2             2                i.e. value = 7 ^ 10

Then you get overflow for both the calls to check_mul_overflow(). But when gcd()
returns 1 (or something too small) the overflow is "returned" as-is.

With the old code you get something that is at least not completely wrong, just
not as accurate as is perhaps possible:
*val   1,186,715,480
*val2  2
Or 1,186,715,480 / 2^2 = 296,678,870.

With this patch the above makes you attempt to return the fraction:
*val   1,379,273,676,757,812,500
*val2  4,649,045,868
Or 296,678,870.443403528 (or something like that, not 100% sure about all the
fractional digits, but they are not really important for my argument)

While the latter is more correct, truncation to 32-bit clobbers the result so
in reality this is returned:
*val   -281,918,188
*val2  354,078,572
Or -0.796202341

So, while it might seem unlucky that gcd() will not find a big enough factor,
it is certainly possible. And I also worry that when this happens it will only
happen once in a while, and that the resulting bad values might be extremely
unexpected and difficult to track down. Things that happen once in a blue moon
are simply not fun to debug.

I.e. I worry that small islands of input will cause failures. With the old code
there are no such islands. The scale factor alone determines the precision, and
if you get poor precision you get poor precision throughout the range. And any
problem will therefore be "stable" and much easier to debug for "innocent" 3rd
party users that may not even be aware that the rescaler is involved at all.

This is also an issue I have with patch 7/13, but there the only thing that is
sacrificed is CPU cycles. But nonetheless, I'm dubious if patch 7/13 is wise
precisely because it might cause issues that are intermittent and therefore
difficult to debug.

Also, changing the calculation so that you get more precision whenever that is
possible feels dangerous. I fear linearity breaks and that bigger input cause
smaller output due to rounding if the bigger value has to be rounded down, but
that this isn't done carefully enough. I.e. attempting to return an exact
fraction and only falling back to the old code when that is not possible is
still not safe since the old code isn't careful enough about rounding. I think
it is really important that bigger input cause bigger (or equal) output.
Otherwise you might trigger instability in feedback loops should a rescaler be
involved in a some regulator function.

Cheers,
Peter

> +		}
>  		*val = tmp;
> -		return scale_type;
> +		*val2 = tmp2;
> +		return IIO_VAL_FRACTIONAL;
>  	case IIO_VAL_INT_PLUS_NANO:
>  	case IIO_VAL_INT_PLUS_MICRO:
>  		if (scale_type == IIO_VAL_INT_PLUS_NANO)
> 
