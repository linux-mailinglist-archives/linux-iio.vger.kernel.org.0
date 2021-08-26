Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C91E13F843A
	for <lists+linux-iio@lfdr.de>; Thu, 26 Aug 2021 11:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240893AbhHZJOb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 26 Aug 2021 05:14:31 -0400
Received: from mail-eopbgr80108.outbound.protection.outlook.com ([40.107.8.108]:24802
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240758AbhHZJOa (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 26 Aug 2021 05:14:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j4lJRPufaP84Gvmy2+qudNVWUuA9AmOp0n4wkIUEksYMK/Ccmj1jiTqpU6CewJ6d482w0hfMryr/X4+5SeNcXonng32GEA64oqcZfYYZDXH2+n9IM3BRWya52rmvpOqRMpKGZ64jmAnzy+F7c81JSAdumtYIrsPrGDt8BVQgzu5uo8uYJvKy42As8/FWiz2uQuebc8hlb4KAmWNoWxrJXNmXuQaJ9o/goVJ+jtFCHWUKCWO8DRAIU3pkU/Oap44g6C5evl++H97zhCBRt8iVIvOINiB5F60FhJ4J1Mb7vMT7GyxTy9abimoOjKewmrI4ILiEfQeEl3Epvpwg1+L3OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x6htx2JXNRQfqCnBEwCOgmXJL9UFlR/4coQgm6z0aP8=;
 b=VBOk85oJ99r1IiKqgxSNVFI+YbMT2jcqauT/RNhPuf2GiMpiYAD515nCOoKYcsYpjmEGMAApKQZNilsZVRJ+mSf+r5Wfm3CxdrLvvOCdGzRfRUoaW8cyiX8QGkS0XXQAE6wBwAdkqOs9kWwyuOtJgSFU1plo5G9CqToYCjUQEUXV94aHV9doxhnsCO3g7DyHDxIPaQAHrkjsAU3+qcH3FwED728uwlDT3ThLGvFagjXwe6QtGApGJpHvrxoolkrofbwOHGOlD1PZHj+vAcfxPWKhnMNRr/H+1AtnTsp1zQ7RlKJI1zjQILRfAk3gIG85IHpydeYh/P8+jwXLAmbGzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x6htx2JXNRQfqCnBEwCOgmXJL9UFlR/4coQgm6z0aP8=;
 b=YCMEYBhpOfSwKuLVk4tt5oPVD04UOeNRih9U3ROwcwbqrxshtYeV11/RHWeG9bysOWyzMDWzMFy7LxXjzDvAYLQ77VCAH5tOCCr1KdQgRjzRwgMrvKGkziYwQuCo3lCp1lMnE7vG7zDVaN2IKBXBNMtqUk9dA88XBUFD74pjtNs=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB9PR02MB6890.eurprd02.prod.outlook.com (2603:10a6:10:21b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17; Thu, 26 Aug
 2021 09:13:41 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::35c9:1008:f5af:55a]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::35c9:1008:f5af:55a%4]) with mapi id 15.20.4457.020; Thu, 26 Aug 2021
 09:13:41 +0000
Subject: Re: [PATCH v8 08/14] iio: afe: rescale: reduce risk of integer
 overflow
To:     Liam Beguin <liambeguin@gmail.com>, jic23@kernel.org,
        lars@metafoo.de
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
References: <20210820191714.69898-1-liambeguin@gmail.com>
 <20210820191714.69898-9-liambeguin@gmail.com>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <1e18e5b3-9335-ca55-3506-4b4cb19d5661@axentia.se>
Date:   Thu, 26 Aug 2021 11:13:38 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210820191714.69898-9-liambeguin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR0101CA0023.eurprd01.prod.exchangelabs.com
 (2603:10a6:3:77::33) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.13.3] (85.229.94.233) by HE1PR0101CA0023.eurprd01.prod.exchangelabs.com (2603:10a6:3:77::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.20 via Frontend Transport; Thu, 26 Aug 2021 09:13:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 57ca55f8-fa8f-4aae-0677-08d96871cbd1
X-MS-TrafficTypeDiagnostic: DB9PR02MB6890:
X-Microsoft-Antispam-PRVS: <DB9PR02MB689018C313D83DF6B74A7127BCC79@DB9PR02MB6890.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VT54qzOHnEz+Z93k9qVNeQJWQgOZc5RbmnH3fyn1WTanX/z6dQF0bC6rnjOQu9/egNPkiG1+ctU7CFm3QH/xJtbYEN5g1TD76Q/TMuy0/N6bNF6h+TewOVjAtjApml/1jId0TJ7nJKvI+alnE/+HEGF2V1kniYR0YK3O9VSLGT0uZDvTrnCcgYI/6yEzk+2q3BOZ6PHNciU3wErHkcS3CevKL8TQP2eKIish/gM/zW+sS+LI00esw6vDPqVTXiMaac0EU8+Np2yx6pgYJ6JgeVVBUrbFUnRxDO6JyR6gtO67ejyOIN30VtMiHZUfN60iD/Mns5RHF7Mwx0u/PD3lgcWHkZsXKTX1y4oJipXFFFxycsu6QfUY6ogjmVzQMldaznnEsmhTKGdRUdGVLPDxs+Tq/8LNWPicoWoSdgDKKQb7jgzzVvxQNht96phfHgQlWXnWb8V6J8ir3wyYtf7w/FUmRpmQrqOSavr78gSU/UmHsMEuH6SUmf3R/fmDjCPc/9vMHZUjvYyVxnHGuzfQWuJVaQUeVeIgdXi6Gd0i7iAshH7kcUwOYBMtu6f9l+3TobX+SX2PcO9UpAVtRcTFb3zEqY4JgDP+nJ1uLWugrNkfeW7OWHNjkj31FS1bGHiiGctsUy3m4nLyytWnNsn3FY/wgm3Ac0BKZmhQoqcJk4Woxys/HDCJxwIpqdGJHZnYP6Lm6E6JrVRGoGIGlCpl8Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(366004)(136003)(396003)(39830400003)(36756003)(38100700002)(31686004)(16576012)(83380400001)(316002)(36916002)(31696002)(66476007)(66556008)(53546011)(2906002)(8676002)(5660300002)(6486002)(4326008)(956004)(2616005)(8936002)(86362001)(478600001)(66946007)(186003)(26005)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1JiUzNiZW1vRjM0SUFISjRaSWx4akIwemMyRW1wSXk1RGdvU3FvU0dOODht?=
 =?utf-8?B?SkRpY253dm5hTkRRZUp1eUVvSmRpcHZtKzdlVE54MkRpQmhNcFo1cUs1OEcw?=
 =?utf-8?B?MWErcms5ZWV0czJGZ29QMU8wWGd6UjFFZUdaTVpwQW9wNWV2QklHTm4rNXVG?=
 =?utf-8?B?Yzd4ajEraElhbFZUdkVmcUdsQlJjZlFkVThHM1pXY2xIS2FoUkZIUFp4VEpj?=
 =?utf-8?B?elZRZGZFTXBrQnB4elVyTXZLMGV2K3BDZDd0UC82TlEvcEJvUlFMRkJ4ejJx?=
 =?utf-8?B?cXo0RjVWTjlWNkhKcVdoS3QrY0w3TDNSdFRjdTlnaVpUdTJ3MDlUdEUzbURl?=
 =?utf-8?B?NHZLV1hDTTJwenhUd1RTNjBpc2ZJTnZZUnJIZjRqbng5QWY4TE9jeHkvN1pY?=
 =?utf-8?B?VThoM01yQ2NZVm1tcHhvZGs2azBNZkMveGFCUXUxamJTWHF3eWhieXdCOEFo?=
 =?utf-8?B?L1orTzlmZjdEdWFma05zbVJFcjNXdWFLR3ZpQ25oLzMyQ2hpWXdtRXhZNDdI?=
 =?utf-8?B?b011Q3BVRjNmOVFleWRqRWg5NlVxVVI5KzhMSnNQbTBJa0VSTVMrS3ZacjA5?=
 =?utf-8?B?Q0Z0TmJ2WDJhYnNYYUsybHYrczJRL1BaWUVvM2gwQ2VsUXlzT0JDRFJGRExr?=
 =?utf-8?B?NGlEVzNlTVZSOWg4TGZHLzNQcnQyVTZIeTMwYU9ReWJVbzlwSW1QaGN1RUQx?=
 =?utf-8?B?cStJYkdxOTI3ekhieWlEa0xSVHo5RDJhelovS2FYK0lqNlh2bW4rYXFiNXBT?=
 =?utf-8?B?V21lY014c2xyeWlRVFQ5Umw0ZDdRR1NqeW5ZNEhoUUdTMUFsclIzNjZ6RHVs?=
 =?utf-8?B?TDlSL3pKZGhZVWdER3pvMjZ3aEw2cVBaT01BejNOZWtCLzF0bmVPcWZLR0h4?=
 =?utf-8?B?TzQwcndWVHFiNDFUWFd4cXVPQkU5ZmdLcXlrOU1ocFJkcE5SVzlIQjZKcURD?=
 =?utf-8?B?aUxlOHViVUtERFZ2QmF3Vk1BZS9SL3l5dnFYcVNNRlQzTE9zeGdpK25sVHVZ?=
 =?utf-8?B?cjJlRHplVThhQk1ZWDNBWk5qZXZ4WlZlNUZJSk9vUzVsdk1TR2hYaDMxVFMx?=
 =?utf-8?B?bkZYSGU1UlRZbmVOS0kwWHhoUlF6QnBoWC90K1FlaENoNWhiZWowYzdCZGZ0?=
 =?utf-8?B?SElyM0VIMHFSMGdUem5wT0o0L3prZ3lYQzNtZmIwMkNKVWoxNVkrRzFGSVhO?=
 =?utf-8?B?SGExOHZLRWNxUmk5MkVISzc1MXRkcUJBa3J2SUU0SG4yUFlPSjgwcG1sbXVv?=
 =?utf-8?B?aE9TOE9YVjA1VU10a1pVKzNzSWM5UUdZQTZFb3g0Q0RPc29Ja3VyL2VyQXZu?=
 =?utf-8?B?aFRMMFV1ZW1Cdzd5cnpTdE1pOVh5VENOWFZJdGRPSDRoazV5amJrSk5iNjYr?=
 =?utf-8?B?L2Q5Y0U5cTRNQnIyenFrV29RcjIzY05zakZXY2JtcUlyUHErV0pvS3g2MDFy?=
 =?utf-8?B?ZFVoNi82NmZEUzF5Ky9DdnE1TlhiNElMSk9WMXlDUXVCSmM1YVIwakE4R3Vl?=
 =?utf-8?B?L1Q0cjVZeENVN3ZjSUkzbWJrUDZaUTludEx6QURYdkEzSG9DS25KN1Z2NU15?=
 =?utf-8?B?TkVWK3lnb3JCdjBNWkxaQkZMb21KcjFUdTllb0dKZm1ITlhFQk91ckNZeWFH?=
 =?utf-8?B?b1p4QndReHVNN1FtRVEvOEMvemZ1TEV1N1gvOVFrQkl6YldMRkpwNmZUZUpS?=
 =?utf-8?B?Y0V0RXpMUXpTMGNqdlZob2VKSjVLM2pKUGZLY2loRkNLeGtnUlowRXdKRVQ4?=
 =?utf-8?Q?Y3tR25oCbIRMJcnmN7CE6fN+pGjyfLdNpKwRqVF?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 57ca55f8-fa8f-4aae-0677-08d96871cbd1
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2021 09:13:41.1381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UzRfxKc7vT3mWT010E5KhygacdzY2V1sEHKW0uPWpDs9FvpEZhTUbjq9tI5R0H/t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB6890
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 2021-08-20 21:17, Liam Beguin wrote:
> From: Liam Beguin <lvb@xiphos.com>
> 
> Reduce the risk of integer overflow by doing the scale calculation on
> a 64-bit integer. Since the rescaling is only performed on *val, reuse
> the IIO_VAL_FRACTIONAL_LOG2 case.

While this patch certainly helps with overflow problems, it also
potentially kills precision in some cases where there currently are
no overflow issues.

E.g. this patch transforms 5/32768 scaled by 3/10000 from the exact

15 / 327680000 (0.0000000457763671875)

to the heavily truncated plain old sorry "zero".

Sure, 9/14 improves the situation, but patch 9/14 simply cannot
make this example any better than returning 2 significant digits
since the value is so small.

Side note, there is also the same type of risk of overflow for
IIO_VAL_INT. Why does that case not get the same treatment as
IIO_VAL_FRACTIONAL?

But again, I see no elegant solution. The best I can think of is the
inelegant solution to provide extra info on the input range, the
exact desired scaling method, the desired output type, some mix of
all of the above or something else that helps determining the
appropriate scaling method w/o looking at the individual number.

Cheers,
Peter

> Signed-off-by: Liam Beguin <lvb@xiphos.com>
> ---
>  drivers/iio/afe/iio-rescale.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
> index 809e966f7058..c408c4057c08 100644
> --- a/drivers/iio/afe/iio-rescale.c
> +++ b/drivers/iio/afe/iio-rescale.c
> @@ -27,16 +27,13 @@ int rescale_process_scale(struct rescale *rescale, int scale_type,
>  	u32 neg;
>  
>  	switch (scale_type) {
> -	case IIO_VAL_FRACTIONAL:
> -		*val *= rescale->numerator;
> -		*val2 *= rescale->denominator;
> -		return scale_type;
>  	case IIO_VAL_INT:
>  		*val *= rescale->numerator;
>  		if (rescale->denominator == 1)
>  			return scale_type;
>  		*val2 = rescale->denominator;
>  		return IIO_VAL_FRACTIONAL;
> +	case IIO_VAL_FRACTIONAL:
>  	case IIO_VAL_FRACTIONAL_LOG2:
>  		tmp = (s64)*val * 1000000000LL;
>  		tmp = div_s64(tmp, rescale->denominator);
> 

