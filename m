Return-Path: <linux-iio+bounces-7456-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2985692AE08
	for <lists+linux-iio@lfdr.de>; Tue,  9 Jul 2024 04:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC4841F21DA8
	for <lists+linux-iio@lfdr.de>; Tue,  9 Jul 2024 02:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB0D3A1DB;
	Tue,  9 Jul 2024 02:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="uphFvTIz"
X-Original-To: linux-iio@vger.kernel.org
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01olkn2096.outbound.protection.outlook.com [40.92.102.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1033C2F;
	Tue,  9 Jul 2024 02:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.102.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720491022; cv=fail; b=hwmDd8MVworWdLmiPQ5fINeuuTzRExVg/p7HVXQeqzeOFGdQU0i7BDI52Jh4YFvoyh8lehVeeRvsx0Q+gACCAx3sYFIe8B5uwIHlpeCYQQSid5UcuvordEGvXQm/Vrasm0x2l7IWy5Ic9fuApq+wX7MbR84WXuOCdYIbnqDAA8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720491022; c=relaxed/simple;
	bh=l4O2NTjLG+RneBp3w9AQcAk1hYe0qkWIMPNrdK4/9vc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LZNbKuLc3Hu0ao+xfIlbacHZtI+0PMw2loaV4wvdVoxr6aUnEnWen2j/TKOLijPBMPUZoDBMBR9gWVsuw1TW2SSZgQ+eRfHwJOheQnrOX9/RsMr0/hkiciWWOK/HRE0voGwqCFkWQabrziCdIvNBjCqqcRsJKoViQFFOAWrVIio=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=uphFvTIz; arc=fail smtp.client-ip=40.92.102.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BwSGdkr761r2FFiuY0WZ3AXB7SLs0PeM/Z3o9adfzvad2puRTuCzcDC17Tij85OLkwDZAX04kgTcDAi+/t7gyrj9GvaQDLT6Q6qxgTnWLq9Y5ldgtBalC21/ezDakMZmGropZBzlq8+vh0cFQvuFukvAi8Cr4Oih4dSg2b9dU0CiyahW/M0JApRwA75QOM9g31iMm6l43DTXQiyMpUDp2w1xACGH0gn8aGdP1L12xpN4f2eS3lfmY9l/M3AqcL3wbRftCsReEIVOBYOQkWxVx5iN4eKSkTG1NQ4HlHpja7lX4w1S2goMhdLu5rB2rdrRuvoqev7OgPx71wlcYqU3Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5jSUFOy5gntemettzw+w6U96soX7OTyjJRTws4IYIW0=;
 b=obN79v2HvbFm0++VGV1jGugc1XCuV7qXaAYoHgI751COhYuusNrTbOro58yVQ/S8rtQ/zMtVeKVPEUTv1Gvh9rDJrVmOvK5DLrUaJWhpsIVCc2ZMG5EkPn4sabhiM2vy77+JjGi5g+h3MDcKydk88p5InDZZF+kCKwiQHTpjIwhz7qxpodjSOgfT1OwM6z5CeoUOVi6PsKDFy7y1WDm9bLz/ppHYeEJuoCO2Zd0xk40gfOMJmg4o3pq4hBVH97M418QNqJ2BIQ5blK8a+0hwDPqYGWH7P+4Rm9RtAQaMGAgzSby0C5oY7ln+UuNWGCWsyeQOwQ09BidBUOacN+rbvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5jSUFOy5gntemettzw+w6U96soX7OTyjJRTws4IYIW0=;
 b=uphFvTIzs79vtxROLST6SM565GdMGS3LmglEezsZH1bprpoIIHe02afPrk3AAGF3WF21BbpnOs1wDMfc40mIwqhJgMXV0NNhFvM2oFSyu6zgYp8ZtijDgK4DkNs1bums+jYc1KawtjMCJbDNYWSJX3M5p0+5InecVcC5X83dK0p+qe6xXOK9t5iasBwWbMKWZ1W6aD+gvh55/xGDNeNN3V2y14jm7GkaoF2JDNdaFI1Geo68DlTun/e2iybBJ17OecjPAmIFdtF6RVVc4tiYMQcvArP8wHSI3dwT7i6CjhW3E5sbTNHZMXurUtJUtyMwguXhp+LK/+6CgqEMIRFgEA==
Received: from PN1P287MB2818.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:214::7)
 by PN0P287MB1971.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:1bb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Tue, 9 Jul
 2024 02:10:13 +0000
Received: from PN1P287MB2818.INDP287.PROD.OUTLOOK.COM
 ([fe80::5a8a:9e40:a4e8:3e2d]) by PN1P287MB2818.INDP287.PROD.OUTLOOK.COM
 ([fe80::5a8a:9e40:a4e8:3e2d%4]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 02:10:13 +0000
Message-ID:
 <PN1P287MB2818CC5CE8A26FEB1CE8E7F3FEDB2@PN1P287MB2818.INDP287.PROD.OUTLOOK.COM>
Date: Tue, 9 Jul 2024 10:10:04 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] Add SARADC support on Sophgo SoC
To: Thomas Bonnefille <thomas.bonnefille@bootlin.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Inochi Amaoto <inochiama@outlook.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <20240705-sg2002-adc-v2-0-83428c20a9b2@bootlin.com>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <20240705-sg2002-adc-v2-0-83428c20a9b2@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [amChUlooZz09YflTWRNrhGx3U/q8mCAa]
X-ClientProxiedBy: TY2PR02CA0045.apcprd02.prod.outlook.com
 (2603:1096:404:a6::33) To PN1P287MB2818.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:214::7)
X-Microsoft-Original-Message-ID:
 <2eeeb22a-500c-46b3-9730-dae0a469182d@outlook.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN1P287MB2818:EE_|PN0P287MB1971:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d148850-a7ce-4eb4-e73c-08dc9fbc4432
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|461199028|19110799003|4302099013|440099028|3412199025|56899033|1602099012;
X-Microsoft-Antispam-Message-Info:
	u+8HLC9gBNVvYry6JYWGXFVKWKFhvatwjhkDSSY8VOm9mpffJ/un6Rw9znNDgwbtw9Rb5VZgZUYxpu3HCkABqJbiBOdv6bvwuqSrv1ysSPWHDu+4ENAJOQVNVbntmpNG3P9riQRcoXlBqzFj40u6OFq9/imh+pTvTeAcHpUWXpjyarOK9Ofzuqhh4CuLSh1eqmI3lTNJXvjuM/GFV/2lEydvM0gDba9oYbZv4Hi4g1HNXu+M2fdPSxZ9N9Cu5o0pwGtHtFe+jARgllLY54ecy+XXhL0chv6glJOIbV0WACqhTZvLAyvIw6/mMQatXnMZXIdPpLXrCt3ygUynk1NOp6V39+tkwG/+sNy3/pT5LkwLxtM3KYdfRyqbp8Vt2u8ZIn3WZCLZAtZBLOdfdHRyKX5lpmTKHSDL2LGiNZTwZo9ED91uEBpFTI2WhMGFEKdm0Ld4gKwVw21orvMdU4qZ/+b9fDSCm2WjrczVDUk+bJAJO1gHJ2uTqSztta1AmrFK1fn0Wra7lBJWQFkDqszdMFicXKz+D/KL+VKwfwmOGMUXad146zNUITkQ3yo6xOJxJe5q5c7/5r7GB+FTRmP0p5SBTzuDEwGGhcsyX67rCmNZoOo60nekAq0Ctywb3PIgv25uqAqBJxnz0ckJYvs5Pv44Pr6BR9ljVKl9yUOuhdtKNfxJIPiwL27SvCsAubYDtt0LuZJ2qYETXTyoeysKQwi1/C6AjDGWEDDdg0CbBdhxiLi1lH8AW91VPtdOk9yOLGEto4FJW/edQX7ZuqwJ8Q==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZTR4OVFPWHlUZlhMVFk2QkxGd1U4S01JaTRMT0duWlVwbng0VDNVczl2ZWtH?=
 =?utf-8?B?YmJlci93Z3ZrNDdOUWZxdVI1VWFkbmVORjhWTGJmVmdRSy81VFNOdzFMZndB?=
 =?utf-8?B?ODNYSm1vdHg1ay9pdGFrQTJoYUFYS2tlWkZBcHdzUWNNSW5xRGtVdU9WWmhm?=
 =?utf-8?B?c2hkQlRycVoxYUVHYnhvWEdJaGdKY0RTVUxwcHFlY2tIQStwZjIxbks0MThx?=
 =?utf-8?B?cXFFa3VsZUt3ak1nM3VCNCtWdE5mbW1ueXcxWjI0Vzk0Rm4wRWpJbXdXWGZC?=
 =?utf-8?B?TmhIdFBEUFo2L2RKVk9CQzI0bTBkUERvUml3TmFXcXRuQ1ZrdjZhRWJjMisy?=
 =?utf-8?B?ckQ1VU5lME1qdnluYzJqUnVuYWRrVWpnWGM4ZjFwSzZHditJUldPeXJmWVE3?=
 =?utf-8?B?Nkx1NHVpYTZueXM5elMrdERuY21qTEFtMDB1MmJmYUpPb2Z0eGg5Tm04bXcw?=
 =?utf-8?B?MXRrR1NoeTJiN2lPcFdTbWVuQkFQRWFWKzYwMGFXR3pEMHA4SHZSdFZRK0Ey?=
 =?utf-8?B?cFU3dUlPdHYwUE5iRTQxOXhWdWxOeWhtMG9jbmJGTjhVNExScVkrYWpHSG9u?=
 =?utf-8?B?a2pkMVZnSzJReUNGRUJ0ZTljdHRtd3psOFBWdzlSbC9YM1JQR3plR2lEajBL?=
 =?utf-8?B?amxDT2JkM3haVWlrdXNMUGpSUzVyQlJ6ZVhlaEhXZCtNUWtnMGpKSE4wd2hS?=
 =?utf-8?B?UG5lMVArSmQ3VjNXbVowelFyd0RLb1prUTE4TDdGSjhYVTFYeGloYWE2UmpS?=
 =?utf-8?B?UitaVjQwOUZnd3liNW1CeVhDdjdoSWRnZjd4QkRPa0IvcmpYOTVRT2dZby9s?=
 =?utf-8?B?YTNGeGQ0SjY2OGtJaXJaQXpZRHRYREx1ak40YXBwdXBFSXVTdXZGRUYvUVAy?=
 =?utf-8?B?YlQrcUFvd1B5M0ViTnFzVWlaOHY3cTFWTzFWNlRnOUVqZ1VWN3RKT1JQSllR?=
 =?utf-8?B?bzlmWjAvZHU1TmExbmJsTGVrS3JtWTBKekpCOTBaZGdHOUkvMjd0Y2R6N01k?=
 =?utf-8?B?Z1VHRWdKQndKdEtWY09SQUI4cmtqcDNFLzFJRDFlbldpa3pKVUh6bmYwVEt4?=
 =?utf-8?B?ZHNxQ2FIWmNENGVHa3hjUmhyS3huQm5PME1IQXRsNS9lN2pvb29WRE9lUFFi?=
 =?utf-8?B?RmgxTnlnV1RpNnl4NEZMa1dQaW9tWHNMajhQd2srWFN5OWh0WmExNWZLUFBF?=
 =?utf-8?B?TkRaaWV4K01jNmp0OHJyTDF1RGFyMjlPT0pPdU1GU1g2R1g1Y25LcVBVWlNo?=
 =?utf-8?B?M3NrWDVXNVZVN1c3SXpYMHRqV1pxYjlpTCs1SE8rTmh2ekVxeTFZNVhSdFdy?=
 =?utf-8?B?ekk5SXE4MDNJU3ZLTGNhR0pldkRjN0ZwN3VFYjE2a1FSSHROd211aFpON0Mz?=
 =?utf-8?B?TTJ2MGQ2NkpDNjhSUjNmSGFrVXN4c3JrNkw1cUZ4aGtGZlhMMklYWGtIZ3lD?=
 =?utf-8?B?b01sUCt0OHRVV2hDazFmdEtONHZKSDdxTXMxMklHRC9aTS9OdFpEemRpSmpT?=
 =?utf-8?B?MEw2N0FqbWxvRGZVaStScnhSQisrNno2bE9MWUxyRG9sM0JRNkJrWHEvWHN4?=
 =?utf-8?B?dnNaSWVsL2NxT2JrSUQwSDQxRFFpVHRrQjVNS3FFbXhmVlFyY0s3VnUxOXdH?=
 =?utf-8?B?TmJyUjFvN1VTSEJFd3NUWnM5ZHlnWG1QYTlUbFpIU1VuaUJOVzlsWVlrMzVa?=
 =?utf-8?Q?F5Fxu6CrZlzCMEjxhYVA?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d148850-a7ce-4eb4-e73c-08dc9fbc4432
X-MS-Exchange-CrossTenant-AuthSource: PN1P287MB2818.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 02:10:12.9682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0P287MB1971

Thank you Thomas for your contribution and welcome.

Just FYI, we are maintaining and tracking all PR status about Sophgo 
products here at https://github.com/sophgo/linux/wiki.

Regards,

Chen

On 2024/7/5 21:42, Thomas Bonnefille wrote:
> This patchset adds initial ADC support for Sophgo SoC. This driver can
> work with or without interrupt and in "Active" and "No-Die" domains
> depending on if a clock is provided.
>
> Link: https://github.com/sophgo/sophgo-doc/releases/download/sg2002-trm-v1.0/sg2002_trm_en.pdf
>
> Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
> ---
> Changes in v2:
> - Drop modifications in MAINTAINERS file
> - Rename the ADC from "sophgo-adc" to "sophgo-cv18xx-adc" to avoid
>    conflict with ADCs available in future Sophgo SoCs.
> - Reorder nodes in DT to match DTS coding style
> - Switch from including <linux/of.h> to <linux/mod_devicetable.h>
> - Use scoped_guard instead of mutex_lock/unlock
> - Check IRQ Status in the handler
> - Change IIO device name
> - Use devm_clk_get_optional_enabled instead of a clock variable
> - Init completion before the IRQ request
> - Removed unnecessary iio_info structure in the private data of the
>    driver
> - Use SoC specific compatible in the bindings and device trees
> - Link to v1: https://lore.kernel.org/r/20240702-sg2002-adc-v1-0-ac66e076a756@bootlin.com
>
> ---
> Thomas Bonnefille (3):
>        dt-bindings: iio: adc: sophgo,cv18xx-saradc.yaml: Add Sophgo SARADC binding documentation
>        iio: adc: sophgo-saradc: Add driver for Sophgo SARADC
>        riscv: dts: sophgo: Add SARADC configuration
>
>   .../bindings/iio/adc/sophgo,cv18xx-saradc.yaml     |  63 +++++++
>   arch/riscv/boot/dts/sophgo/cv1800b.dtsi            |   8 +
>   arch/riscv/boot/dts/sophgo/cv18xx.dtsi             |  14 ++
>   drivers/iio/adc/Kconfig                            |  10 ++
>   drivers/iio/adc/Makefile                           |   1 +
>   drivers/iio/adc/sophgo-cv18xx-adc.c                | 195 +++++++++++++++++++++
>   6 files changed, 291 insertions(+)
> ---
> base-commit: d20f6b3d747c36889b7ce75ee369182af3decb6b
> change-id: 20240527-sg2002-adc-924b862cd3f2
>
> Best regards,

