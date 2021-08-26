Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB0883F8390
	for <lists+linux-iio@lfdr.de>; Thu, 26 Aug 2021 10:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240155AbhHZIMM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 26 Aug 2021 04:12:12 -0400
Received: from mail-eopbgr60098.outbound.protection.outlook.com ([40.107.6.98]:1074
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233052AbhHZIML (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 26 Aug 2021 04:12:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jnRaFvxP18zzsoRkm6m5jmAlP8xSmkw++qt5mqJwapo6qWQ2ZTK2tUKrYIFvxDAM6LLoQj3ZlX52B0H70jSWqsi6f0K9T1ZsqlZIE52Mm7loSHgkD/bF5yEZJ4oVQJcy39Mweu6bGMhbdRJ5nZjLDrbzftZhh484Kl874u47r0IqnCfDAqvLRi0V3vesz89UJr5P69qjwZTliYccgdauW/jjyX/c2Cm2lIW4kyhFK6pMS0TiR2XD6OZbC39sdWSCqW/7q6q4y79MsAsAO95DNh8AIboQmFbFSR+jkArt8zONHc5bwnw2RN3sasil8qPWnSkP+1oz0gIYOSBu4fOFgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D8YVeAiqEcEdAshbFcF5VxCINWaUgyGwmUXoFi4NpN8=;
 b=PWd+uwrpiUEfPWSB8X7WxBZ6qoP6rpcA+egIDydq2ovuWU0zuAm+7hVIp1fvFD0CJG2KvlvB3x/2Fg50pWxXRfsBEGZnZZgv25gDp0lLa+v1m3EN6au/Ly45w5OPONa82M7zl4IHy3cRjCV+tI1+im8VZAcePg1SHRjzyLasg4aR+zLyftvmydeFUiWOHI86aGFtQZtFaCx4rqkafo9k1oBaFig+4kICTZAAqnJUhTzy4Fzr9xF04czYoJVP2kaT27osaY08D18BFVaPgsUT7WW3BRK1By/L8NfbDCL3HB98GhF+jnHg5nTuEoYGFZFEyM45lvJf5bvTNR1/PT1PgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D8YVeAiqEcEdAshbFcF5VxCINWaUgyGwmUXoFi4NpN8=;
 b=WhTuUPpljTRfX+vScqI8dETU/zUp/KoYmXxFx3laP7A/M/C6tVep53wGAEZ/vybgaKkqrt6pdjqnrCkns1zWflhFMBODwXiXoy57qqblHbvuroyP9C3i6ZW1ys5/3GcrtNuJW3Dw169biaiYFs6IhPg8XK32+BDLBt7PvgYV2s8=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB7PR02MB5003.eurprd02.prod.outlook.com (2603:10a6:10:30::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17; Thu, 26 Aug
 2021 08:11:21 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::35c9:1008:f5af:55a]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::35c9:1008:f5af:55a%4]) with mapi id 15.20.4457.020; Thu, 26 Aug 2021
 08:11:21 +0000
Subject: Re: [PATCH v8 05/14] iio: afe: rescale: add INT_PLUS_{MICRO,NANO}
 support
To:     Liam Beguin <liambeguin@gmail.com>, jic23@kernel.org,
        lars@metafoo.de
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
References: <20210820191714.69898-1-liambeguin@gmail.com>
 <20210820191714.69898-6-liambeguin@gmail.com>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <9a7aa55f-0dd0-3fc7-13a4-5cb9c5d0a252@axentia.se>
Date:   Thu, 26 Aug 2021 10:11:18 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210820191714.69898-6-liambeguin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: sv-SE
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR06CA0127.eurprd06.prod.outlook.com
 (2603:10a6:7:16::14) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.13.3] (85.229.94.233) by HE1PR06CA0127.eurprd06.prod.outlook.com (2603:10a6:7:16::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.20 via Frontend Transport; Thu, 26 Aug 2021 08:11:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b5fc8b8-a9c1-44ad-94dc-08d9686916c3
X-MS-TrafficTypeDiagnostic: DB7PR02MB5003:
X-Microsoft-Antispam-PRVS: <DB7PR02MB5003286504283120E1736195BCC79@DB7PR02MB5003.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W+OPQ3zwdpNS7RbLHwvepFnnCXE2uzL2qQ3KLhKukB/EdmtSR2bXj797FHo7Jmn/JFnDC9JjGhaQnfTM+/KUCQ1kgctGBfl7lMJBVvIzH4sLBj/aU8d1Eell6re+VwCh97wkuSuvrNlEIi+V4Iu4YB9Pen7y2KQ5gMdot+CJb2v9j9IiNg9W1If3r5c5QWw+1OspjgLqKyOgX6ik7ELEHC9eoDXc35uoCB1CVl1HN47asPtkeDTga2+3N+baQI8/my69GDv84BGShMbPXEXowo5D367JeXE9t2xPs/iZUSDNaxRWLE6TeQdsDp4GNwoB63hL7fHAkWDEmzSAs8RN51viz3gE2DKyowIShhvvCDK1faYriflVEJQy6+umyKR9jixZNIss1bo0tg2piiSw8immjKoyB6seAQpUcNyVLLu4eUBA5PCsR5RwzGQnXNtp7u1Kn4Xhn2b2JIzXVLM84MyT+rTSTPLCCp7BBsDdgA/Daw/licQK8S5KKszoRN6SidLWLacsyh4Al8BhNkmppz9Z/FL+pT+VdGzZDKoiVMLnIuyHWXEPgPnzMVubmNyoHNxyfQrG6dxx467oBzeEHVS1St4bYRMKaqPewAZcE5wCBzBgj4RLQFrx55EI7TZvjg5ixfsu04cp6BguZI6NoEo5Cp2N5UolnyEF7evVeELPVgLbABwtutO/iWzZRCq0UNQRSfiDsmbHdnqspeYiA9jUmidFplTs36bEe5BNNpo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39830400003)(346002)(396003)(136003)(366004)(53546011)(26005)(38100700002)(186003)(86362001)(478600001)(36756003)(8676002)(8936002)(31696002)(36916002)(956004)(4326008)(66476007)(6486002)(2616005)(16576012)(316002)(5660300002)(31686004)(66556008)(2906002)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWZpZzJNTmZJVG9hN2hIVXVqZUJ6SUgxRVNIaTYzUmE5bVdyZEVJWEwwVEF1?=
 =?utf-8?B?OVlYZ0ZaVCtWUkVlTi9hZDIvemhKcHZ5Tk5pNFd4WHkrTVlobmxlczFqeFYw?=
 =?utf-8?B?M0xRZTJvRWJBZklLakc4cjRrYUwwcnZraS9vdklLMnFoam1DSGxPUUhsZmxZ?=
 =?utf-8?B?NjlqaUl0SEdMTEcreG5GeDcwYVFzanZlem1Oc3dQc1Y0YUpYa1FWRHpxaDNu?=
 =?utf-8?B?M1F4OThCbHNUdUFqUWdvc2VPN1UzVC9XVTJkMWN0SDMwdjZiTW5iOG9Fc2Vi?=
 =?utf-8?B?eHZ4TnZDU3ZVbGFyN3hReEJLUGpielY0dlhlQXFlL0dDTUx0VVFSWnlRSnFT?=
 =?utf-8?B?bjhJRTdUTlFuaEFhUXlzajhmUkhYeC9mcCsyZU9JSmNUUXNPekVTR2FXRXNr?=
 =?utf-8?B?ZE41NWtuMnlsTmlxMURFTDlvRldUeE9xSnB4dTI3QkxRNklPUHFhekJzQXVO?=
 =?utf-8?B?aUpZS0tPcXZITlNSQWpyNUoxM1Myb2lyZlhEODRMUDVkUTMwUXRwNUUwYlds?=
 =?utf-8?B?c1NFd21KQXNxQ3J4K1pLWk9LUVRIY3NTd1JSY21NakVyRUVkNUFRVVFUZldD?=
 =?utf-8?B?UE0rZTB0U21WaHpPZE9wcFV6OGhxYTNQR1g5d2RMamdmZnVPOGJETWd4M1Yv?=
 =?utf-8?B?YmRTQmY4ZkVwUXpkQ1lLejE0eXBJUmFUQmt4bnBDbUszQnBFWmU5cklMRGVM?=
 =?utf-8?B?d0dPQ0tBcVd5Ry9veTloeTdWeDcxcFlyUVdxdTFSNjZUVGdkR2I5S1VWYndV?=
 =?utf-8?B?VEdSTGxXTGFVT2xoZ1plVmpJYmdrbTQxL1RKdW5XeGVWK2VKK1FJZ2ZFMFMr?=
 =?utf-8?B?VmNNdjIzL1MwMDE0L3JIV05xTW1lUHEzNGxIOWNhcGM2RUlvNjZsdlZZR2pG?=
 =?utf-8?B?dTcwcE5RWU9ZTWk5TGM5clJlSTBUblE2M3BPSmZtUWpkK3dNZWlUTkJaOWtO?=
 =?utf-8?B?L0NSSmlJa3lpZzJCa01nYWJ6bi9jQ0RNL25CM0xwSVlpVFRRNE5YVjVYd2Z3?=
 =?utf-8?B?eGNIMUFDVWhhNTYxam1QZ2xKcnRLMG9vdUsyRUhpanhrQ0hFaE5RZjFGOEhT?=
 =?utf-8?B?dUFwRVZmR3JMWEtvVS8rMHhwVHlQK1g0bW4yUDhDRGVuU3NZVlREZmI3ZUhH?=
 =?utf-8?B?Z0FvSjZEd3l0OVNHaHBDd0xnZXdaUjgvWFRsODVxUnY5aDRPUzlMK05yNGMy?=
 =?utf-8?B?YTZyazYxeDJITStGdVJ1NzlEd05YQ1JrSUpYcEtxY0gvVjlKSGQzRnZpc3ZI?=
 =?utf-8?B?aFB0Yi9ZNHpRMFROTlJUOVhsQ2cwaGV1cnE1QXl6Um1vT0RBWHpYd0tEL0Vn?=
 =?utf-8?B?d1lxc2hwREMvRURaUENmcG00Z2JjZnhPTEdkU2ZpUitKWU1DZmxFYk1iQ2kv?=
 =?utf-8?B?Z3hDUVpaTHdhZlpzOHZ4M0FSYWJ6Uk1PK3hqZm8ya09RNlhMaUp5WlFRZ3JG?=
 =?utf-8?B?dmEzMXRScHN0N1cwdVZEcjgvbmk5VVRKRnZCK2ZmV2JGL25SemdBU3Y1TzFh?=
 =?utf-8?B?b0FCa2tvL2kwQU9FQzE5Qkdod1ZSak9JYVhnd2hNT1NvNEpXVUY2NE0xWWRP?=
 =?utf-8?B?YWVXVVhJRDdLTnFsdHpOUWlZVFpXYWNKbGVFQ2RaeG9kN0svb1NPd2NVL0VE?=
 =?utf-8?B?TXVMQTF4ODBZVmR6Sm5nMGVYWFJWd092aWE3OUpCSFVaWHpnclQrRmtzNWU4?=
 =?utf-8?B?MEMvRXBqSnRsdW5uSG9xcEZOSDlTOFBacXNJTDRTSnloSThGbFY3QUJNdGh3?=
 =?utf-8?Q?t6EskHtzFDnq/hUwXtNdjNeZyMmMElwijFVdXcP?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b5fc8b8-a9c1-44ad-94dc-08d9686916c3
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2021 08:11:21.4995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BjCIcFP/bD4LzNJ4pAcwfJx4/xzUvz/LTm/cT7mN43ygOBqD0Fpne+lS2CX6h5mA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR02MB5003
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 2021-08-20 21:17, Liam Beguin wrote:
> From: Liam Beguin <lvb@xiphos.com>
> 
> Some ADCs use IIO_VAL_INT_PLUS_{NANO,MICRO} scale types.
> Add support for these to allow using the iio-rescaler with them.
> 
> Signed-off-by: Liam Beguin <lvb@xiphos.com>
> ---
>  drivers/iio/afe/iio-rescale.c | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
> index d0669fd8eac5..8488f1d83527 100644
> --- a/drivers/iio/afe/iio-rescale.c
> +++ b/drivers/iio/afe/iio-rescale.c
> @@ -22,6 +22,9 @@ int rescale_process_scale(struct rescale *rescale, int scale_type,
>  			  int *val, int *val2)
>  {
>  	unsigned long long tmp;
> +	s32 rem;
> +	u32 mult;
> +	u32 neg;
>  
>  	switch (scale_type) {
>  	case IIO_VAL_FRACTIONAL:
> @@ -40,6 +43,38 @@ int rescale_process_scale(struct rescale *rescale, int scale_type,
>  		tmp *= rescale->numerator;
>  		do_div(tmp, 1000000000LL);
>  		*val = tmp;
> +		return scale_type;
> +	case IIO_VAL_INT_PLUS_NANO:
> +	case IIO_VAL_INT_PLUS_MICRO:
> +		if (scale_type == IIO_VAL_INT_PLUS_NANO)
> +			mult = 1000000000LL;
> +		else
> +			mult = 1000000LL;
> +		/*
> +		 * For IIO_VAL_INT_PLUS_{MICRO,NANO} scale types if *val OR
> +		 * *val2 is negative the schan scale is negative

The last line doesn't parse for me. It doesn't end with a period either, so
it looks like you moved on before you finished it?

Cheers,
Peter

> +		 */
> +		neg = *val < 0 || *val2 < 0;
> +
> +		tmp = (s64)abs(*val) * abs(rescale->numerator);
> +		*val = div_s64_rem(tmp, abs(rescale->denominator), &rem);
> +
> +		tmp = (s64)rem * mult + (s64)abs(*val2) * abs(rescale->numerator);
> +		tmp = div_s64(tmp, abs(rescale->denominator));
> +
> +		*val += div_s64_rem(tmp, mult, val2);
> +
> +		/*
> +		 * If only one of the rescaler elements or the schan scale is
> +		 * negative, the combined scale is negative.
> +		 */
> +		if (neg ^ ((rescale->numerator < 0) ^ (rescale->denominator < 0))) {
> +			if (*val)
> +				*val = -*val;
> +			else
> +				*val2 = -*val2;
> +		}
> +
>  		return scale_type;
>  	default:
>  		return -EOPNOTSUPP;
> 
