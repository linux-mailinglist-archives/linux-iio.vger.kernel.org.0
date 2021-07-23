Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D27783D4204
	for <lists+linux-iio@lfdr.de>; Fri, 23 Jul 2021 23:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbhGWUg1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 23 Jul 2021 16:36:27 -0400
Received: from mail-eopbgr40108.outbound.protection.outlook.com ([40.107.4.108]:23107
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229648AbhGWUg1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 23 Jul 2021 16:36:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CWFu6d6mlXuaHBnpUpLgZy0oTL16x2TXyt+fgAxpy5XlI2cvDa2EHAvb9PEshPzGdwhjdZGbft1D/zskOiQesM+oobLp/yPOm80mm5fYNw87PuJ+zJEnr5XiXQln0XpMm2+M2fGe+PhfpndFyO6FIH6I7GJLz0yxrHAprrvDJAHRe5wMvRAf4g6u/d4RLIheDEjpFkrISJVrtbsLa0YiemFygyA5fTLKiwpjVFY2Aovva1DMwET1XHvOM75GFFgJrzJjTbq3pSk3+lGFL2NaWQCf5wA/CApdISiGT4nrOS2Im+VjjXXX/9COO+iv80GkXg3y0kTHXmRhb7sfuSI7HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S5Savn5lKyr7Ob5tpIFCf+s7i0d6Q25vYuwA8NmYrO4=;
 b=QEwHyWz9EDnHdBC/ZLh+hd4t1bHktPCS4J3tT4CO6s2o/VoLQrg838uRHEaXtmgz/eci8fuxhYvUwrBBNEPTxt0tzcb7sfaztaDLiLoqzGhSlukrT47Ch+Umndn/bxRT+DZUf9CT5EVTHDuPHZROTuh0mHa7EInLtv70h9Kmw7arPGTi+uVKC0+LiYPrmwyejYHPGHhCz/qfT9zFbkHifBg/v2+rYILyoQ3WVEvyqKYmQaETWQcSBUwMa/OGAzop7tv/KMouawTkGaEG3aGPb8f/toMeqmvJ4yUAEIPdLiikJfqq5nOZzBu3k42CzqooaWfBY7yneuDfyDWRM8mO3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S5Savn5lKyr7Ob5tpIFCf+s7i0d6Q25vYuwA8NmYrO4=;
 b=S/iR3HJUe4QwNa+ZyVAxOhFcCG5lWFa7Ejr0JU9FMpcayr02K2eYitxxRvaD3bdbZJuCDvhf0PI12NfJQemCWqJMd/JhQXRmwoAwi6wNrR2rVDFsPcZeyk8+szGoVKc66Hc8Yr+5hp0zUL76usbnzbb54UzQiz+cAcp/OkrWtDo=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB9PR02MB6747.eurprd02.prod.outlook.com (2603:10a6:10:1fb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.24; Fri, 23 Jul
 2021 21:16:57 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::14ca:a41:2218:3578]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::14ca:a41:2218:3578%6]) with mapi id 15.20.4352.029; Fri, 23 Jul 2021
 21:16:57 +0000
Subject: Re: [PATCH v6 05/13] iio: afe: rescale: add INT_PLUS_{MICRO,NANO}
 support
To:     Liam Beguin <liambeguin@gmail.com>, jic23@kernel.org,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
References: <20210721030613.3105327-1-liambeguin@gmail.com>
 <20210721030613.3105327-6-liambeguin@gmail.com>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <c9d77dc0-7f4c-0df0-cce1-8cb30074e115@axentia.se>
Date:   Fri, 23 Jul 2021 23:16:53 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210721030613.3105327-6-liambeguin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR0701CA0090.eurprd07.prod.outlook.com
 (2603:10a6:3:64::34) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.13.3] (85.229.94.233) by HE1PR0701CA0090.eurprd07.prod.outlook.com (2603:10a6:3:64::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.7 via Frontend Transport; Fri, 23 Jul 2021 21:16:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 358fa80d-0d60-4022-3c09-08d94e1f33c4
X-MS-TrafficTypeDiagnostic: DB9PR02MB6747:
X-Microsoft-Antispam-PRVS: <DB9PR02MB6747F674EDB922F186BCF1E9BCE59@DB9PR02MB6747.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k1jvVlRQoxp7e33bmgz7xm8BvHOjnleE6PxEj0bOe36zId2VtZryFBAqGYE1dpYHADGPAMruQtux6sqDYo/GMKSTQup015HdPWdPCZEc+Ga1spZ8Nn96X3QZ2Q8F20qliTfdHK/kn3zU8lkw+fWfEAMCzXFEfZbFnOzQLz4sD8mk2xg6DGM81GIjGGUepST1qQlVM4ZlIzyJeiRyyn048/U2A5k7Iw3aqyhrvkWVkktKsBmEStef5YnANaVmQ3ZTo+UQxNUgIDFK64Ld2rEJhr3y6kQlc3rmwFMhHDBsurZB0gI/6bHqvOhxBJd4+zKm4fT6/bR7rsQTM59ybYluxxkim/FoWTRO/BRFXfZqcCT8Xf4KCALyTXVQ0OQGLUdnZFRx3w2RsF3LbCrdqwWh9gpvHw6bhvcoC14SJew2cfyGtQDHttzJNILWiBkcZ35I+crUZhCVqGM9wCeAnAWGQECsalkHe5PKuo97hP02kzYxneVn4ztdJzFwimiljLyBPaIAVdWY7T1RX6PIXb3l95ITtddfgGH3mP6pw7U+xf41Ck+Ayn7KaLMqWrdd7pc8b4Bs01WglZjjNAqTcsQSi5fcun0I/Uo9euuNa0zBJZN5+b5SPyYu3VWTy2Fw3IwfORyEvCEtw2dQ6VOpHMhtu9rX8N0kJAVCKVOoGTT3isjNF0RrOR5zTV6f1rpkA9XqcGEoE8zWKXfV7aVWhZ7chck8rWJwBDYQIYR+29PuTIc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(39830400003)(366004)(376002)(136003)(396003)(346002)(478600001)(956004)(16576012)(5660300002)(316002)(36756003)(2906002)(31686004)(53546011)(36916002)(8936002)(2616005)(4326008)(86362001)(8676002)(66476007)(66556008)(6666004)(31696002)(66946007)(186003)(6486002)(26005)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UnpzMzZvN3hNaDdldTRKcU5GbHRiTkp3VmYwb3hncUE1bHEyamFHbnhKbTZX?=
 =?utf-8?B?RmdYVWlaeUpIV1h2ek85dnk1U09aS0ZSam5RN1NqdlZGeEtPVHNlTVB5cmxN?=
 =?utf-8?B?ZjNJWXBiUVE3MWJFeHZKWkxuNU1zQjFaRThJc2N2bU1wcFBlYlJRaGxVVURD?=
 =?utf-8?B?YkdRWlVFaHFvUzJqT1psb25wVUxYMTJtZXR0R3hVb3lFb1ZSbHYvYXFFSkpL?=
 =?utf-8?B?cFVoc3ZJUi9mY1JQKzFLbVMwM0NtMDJHWkdvbEZuTDJnYk93dHJKdldxbXFS?=
 =?utf-8?B?TnpkSUhPaHkzOGdUUEppd2ZqYmcvNkVmMVNKUWFZazZQUlRpNlRMbGwzOExZ?=
 =?utf-8?B?bHRCR1FEZmVlcTR6TmhsMnNnd1hFTS8vN2Npd2l5YXJrb1lNU1B1VlBtb3Ro?=
 =?utf-8?B?cUEwSlRCZGlWYk1tYVZYS1ZIMUtCeVhFMG16b0p5U0h5MVFTTXBoRjZlUU9S?=
 =?utf-8?B?SENtTkY4U2VCK2VRRERiRHJqOFVSVk5BUW1iTmE0K3d3WjRUQ1VqSXZFOTJF?=
 =?utf-8?B?RlBIZWpaejE4Z0N0OGc3aVRPSkZUYjlGQ251d2pESHlUZjNabzRDVHFEekxI?=
 =?utf-8?B?OTJXM0ZEb1FCRnZxekQzTUZJcmRBYm5FT0VaVmgyYnRIUnRBOHc3NWd5eDhU?=
 =?utf-8?B?K1RxT1U1Rk5JNWwxQXMwVmpsek91WDJKdCtYTmw0T2pUUmIya0dQbmpLcW1r?=
 =?utf-8?B?dnNwdjRiTkF5d0E0MTl4QVJSdlJsMGNGbkU4L2hJODJPaFQzbStRSGhKTm9q?=
 =?utf-8?B?OTZUS3hKd1hadWs4VUJ0WmdHZ3RhZTRwczdONGh2Tk10QzJTR2ZLVjdFN1Uy?=
 =?utf-8?B?ZlUwMWlRZXFPdW1VR1d3MEl6eUJIamhZdTdxakRlUmhyay9tZ0s0MzA5TkJy?=
 =?utf-8?B?TTUxcFh3cXJZVVpVekVON3dPNlNnVUR0eGhkdEdOeWN6NEJRbHp4ejhzOENY?=
 =?utf-8?B?Ym1Hbng3TG1lNHY1STFRNVBMSmZQTlNSZWhNZTNiNWwyNGkrZXErVTJhWklO?=
 =?utf-8?B?QzRLaTg3MHNxaTdsWWJYWDh6cS9sdnFNTEdxb3VSbURMUXN0Wis0bnlhZXRq?=
 =?utf-8?B?eHVPOEFIQTlmZHZYUGFYcCt6L3c4QWZHN2JyVy9RZGRNVzAwT3VVN0M5czZD?=
 =?utf-8?B?QnkwdTF4aFB1YU1QQWZ2TGVzNE5JYkxhdGJta1FOSXZhbmpQbnlUR0l3Mjdp?=
 =?utf-8?B?VTlNZlZFNEdOZmFaRU44dnN6dTJISk44VkNmOXJEVE4rTGNrQzc0eE1NYWlo?=
 =?utf-8?B?c1F0WHFwTmx5WitiK1R5MS8za2V1ZWhORDBvZ3plSVdoNjRxUUdKUklhVXhT?=
 =?utf-8?B?VVJEYWJLVXhOcmVvYmhnVmZIb1FpNCtJRmtTRDhGSnhoaFRPYVFuUUZIQTRI?=
 =?utf-8?B?ei92Z3ovcUwwU1FZcXpJYjdPMGFhKzhxdHh4SXRlZXl0ZUJJTUNFSlhSR1Vs?=
 =?utf-8?B?NU1JUVNrdldRU1MwRENhK0hja1Uvb0R3bFZuQjBzOHdYZS9vRkFLQzNKRGpR?=
 =?utf-8?B?RUdlK3FRc0prM1h1OENKZHNwZ2V1WEJQYndWRDhyZTNMTW93NXFhdGlJVXNS?=
 =?utf-8?B?ZVlIQzYvdWNHcGtWeHZFKzYxQkkxZnA5Ym9Ma21jN0VrT3kxcUdVNXR6MzV0?=
 =?utf-8?B?VTY4cEc0d3pYSlRxSFBZM3h0SWFwZ25Cd0VVbGsyZEVwZ2pPU3hUcm0xaGNj?=
 =?utf-8?B?dHUyblRlV0pBN2Nlc0lvVEZDbUdMbFh5UzdMZ0pQRTg5RGN4Y0xOOVJ0dm4w?=
 =?utf-8?Q?igPHT0TlsUdiHYTH+hsiM2rvKk4ItjF2fJf5twz?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 358fa80d-0d60-4022-3c09-08d94e1f33c4
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2021 21:16:57.1075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R8tfDSGvWjOm3bSRf1V+ASiJ7fj36OTANgL0b19PvvFwzJjn7MXww+a17NpHuUn2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB6747
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 2021-07-21 05:06, Liam Beguin wrote:
> From: Liam Beguin <lvb@xiphos.com>
> 
> Some ADCs use IIO_VAL_INT_PLUS_{NANO,MICRO} scale types.
> Add support for these to allow using the iio-rescaler with them.
> 
> Signed-off-by: Liam Beguin <lvb@xiphos.com>
> ---
>  drivers/iio/afe/iio-rescale.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
> index d0669fd8eac5..2b73047365cc 100644
> --- a/drivers/iio/afe/iio-rescale.c
> +++ b/drivers/iio/afe/iio-rescale.c
> @@ -41,6 +41,20 @@ int rescale_process_scale(struct rescale *rescale, int scale_type,
>  		do_div(tmp, 1000000000LL);
>  		*val = tmp;
>  		return scale_type;
> +	case IIO_VAL_INT_PLUS_NANO:
> +		tmp = ((s64)*val * 1000000000LL + *val2) * rescale->numerator;
> +		tmp = div_s64(tmp, rescale->denominator);
> +
> +		*val = div_s64(tmp, 1000000000LL);
> +		*val2 = tmp - *val * 1000000000LL;
> +		return scale_type;

Hi!

My objection from v5 still stands. Did you forget or did you simply send the
wrong patch?

Untested suggestion, this time handling negative values and canonicalizing any
overflow from the fraction calculation.

	neg = *val < 0 || *val2 < 0;
	tmp = (s64)abs(*val) * rescale->numerator;
	rem = do_div(tmp, rescale->denominator);
	*val = tmp;
	tmp = rem * 1000000000LL + (s64)abs(*val2) * rescale->numerator;
	do_div(tmp, rescale->denominator);
	*val2 = do_div(tmp, 1000000000LL);
	*val += tmp;
	if (neg) {
		if (*val < 0)
			*val = -*val;
		else
			*val2 = -*val;
	}

> +	case IIO_VAL_INT_PLUS_MICRO:
> +		tmp = ((s64)*val * 1000000LL + *val2) * rescale->numerator;
> +		tmp = div_s64(tmp, rescale->denominator);
> +
> +		*val = div_s64(tmp, 1000000);

Why do you not have the LL suffix here?

Cheers,
Peter

> +		*val2 = tmp - *val * 1000000;
> +		return scale_type;
>  	default:
>  		return -EOPNOTSUPP;
>  	}
> 

