Return-Path: <linux-iio+bounces-7186-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E00924CB2
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2024 02:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58745B21115
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2024 00:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A3810E3;
	Wed,  3 Jul 2024 00:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="gPNxC/Wp"
X-Original-To: linux-iio@vger.kernel.org
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01olkn2096.outbound.protection.outlook.com [40.92.102.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DED2621;
	Wed,  3 Jul 2024 00:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.102.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719965920; cv=fail; b=CXM1zm7CtPah6hRC65ERcygUHS3ebUlD7+eJxxWXmEcjhWoGn6E6v5bMkIUAElsPInZ787wxqEXJPB082UlULJoUOZUCMJv9yVzhS7ddCidtoZ9GN1vQ65Hy/Lxb+9C0OASlxhY89HawsZttNgcU0g/AQnTp+xuQ5oWoJSG/aJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719965920; c=relaxed/simple;
	bh=tELbtsTPF3ZujpVIHo5w1q6EfTBF1FPIeLNIp4BHWs0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pOCde8WrND2AHWekXMmSsIAWm3iSgcf2oZ4eHApUrha3W+et7EDKlHgkwGJ0VRnG01W4nkvhUusYc2A5GbYkW3TI1vVoW98tsyUhLhxwCFy84x5P0exp/yfDYfCW/CIyQNV/bPSpioVhTuNLfpcnu/Kj1EIUoMIwTOGlafWq5nA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=gPNxC/Wp; arc=fail smtp.client-ip=40.92.102.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aAB8wnig5zbxtFhaXJoPKGwas2F8/ZovERkSiKhSW2wz2PVtnCgsxWPqd2Wi6vaDO8voZSWqxf51SS4VmcQCfPbhClL/WttGiCZoqlpVayl7qn5wsUArOIJexePSCD/3v+4i9mNGZwiQ3K98Jm1E8jVAMfs0Z03/DCMuNbf245Y+4vZOwIdTnxqsPH3Kvt0/mwvZuKdHv786/fuiEYPyQBKIR/36YyGkX07gbMvNFmj6yIQHauI/ev4vF1FPZh6o2QTK2+IQNcuVzSVgtSRzbbgGkBYIExZeXZ4/2lHQn8KMfT5xHejBqWPFeGuhNTZ8j+IXOANlnWvj7GNOgTpEng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=coZ61vzd69LhhCu9qdITtdW5+b4E6lfGCWU9drL0pNM=;
 b=fXjacyHk5C/CVioyQ8xwTmArwQH2Siiauvwr2Qp5o4CDPp60bzPwRwTKkykAwfDMqkbNQc/Mf1WHNDKj7/VX+al+sKNUVx5ZpQqp2A7K+Oz4vwZCJpDuqRyvphswhbvyVEBaXzAbUFuoM8DeSN3l4Ag7fxAwMsBVFUu8alQS+b84N2H2hu3HSjLl3PnXauD2qVqxkST8cgbihh3HKutnbI/ioxhPpQVo5c/gjvd4HIvP1J2Wtt/bgBCak2t6/E/MHlcPDC+evpwR8zFYM9fm5nXv7syXLDMFhkYJzvf6QjQfbylR7vzrwwm/T1MWVIJ77Q4cGbaztFAjTy7Mr9RjKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=coZ61vzd69LhhCu9qdITtdW5+b4E6lfGCWU9drL0pNM=;
 b=gPNxC/WpuOHsSt6PVjXoDNYshBUeGhvAIIW/dD+g9EsXwzXjtv/vV2TEg4txNp4s1DkH6crXlg01oZoq+ekjEeYuvzkbuYY5dBUIjeI2xx+xTPdJWJtCJgnRTSSeBe9Sp9G+CQv1uMwgdvAYS32BJGd57NNrGGdngXPVvH9oc2SFvJxTWzDSfD9qZT7HcN+D3Pi5b2OHHMUcJemb40Z8nzZwp3ti/wZS/ypxG4YMhs+jCSHleOGL/iAp/bTtUG6Tql4f4U4NoeQeP5NkxYTf1rukPchBC04hxgKDCZoyHRkSG3uoBG0tGEyGFqb6cxHvJkSgL9F6ORSXfhgvZNmnLQ==
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:138::5)
 by PN2P287MB2064.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:1c7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Wed, 3 Jul
 2024 00:18:31 +0000
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a94:ad0a:9071:806c]) by MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a94:ad0a:9071:806c%3]) with mapi id 15.20.7741.017; Wed, 3 Jul 2024
 00:18:30 +0000
Message-ID:
 <MA0P287MB282240D38A2D9B0F2D1ED186FEDD2@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Date: Wed, 3 Jul 2024 08:18:27 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] iio: adc: sophgo-saradc: Add driver for Sophgo SARADC
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
References: <20240702-sg2002-adc-v1-0-ac66e076a756@bootlin.com>
 <20240702-sg2002-adc-v1-2-ac66e076a756@bootlin.com>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <20240702-sg2002-adc-v1-2-ac66e076a756@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [9YuLmH2OZDwm4w62j6QQ09I14yfT6nEM]
X-ClientProxiedBy: SI1PR02CA0042.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::17) To MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:138::5)
X-Microsoft-Original-Message-ID:
 <0d1dbf4c-e3d1-4577-b9a1-b299da80ca68@outlook.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB2822:EE_|PN2P287MB2064:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d4ba0e6-fb3c-4526-dff4-08dc9af5aaf4
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|8060799006|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	UdyozPnMFko5MOMu/43eobMwPJnDIqlCY9grhvGEvg5G7PIwjT7YdjHxM/Mc01mIZJUJFQnEPKpDKJzvnYEo30kI7Cl1VKpWvgXVowkwCYYCkHs4CfnYFWQPHiYDf5jpQ/SpI+kZan+4w/7yAqfRhmfLvH+1BWp+tnsjmNfurXsGkoADjafjT2JAPVnubdFC1fVpQkwcYCw7hcgVkrW6ioCw6AYCC5/9FcQHN026QgKzgtaNxqIVlfKX/fGLXjr25lAY1/2xLJBs4HcGbottIBLPt77iY39ZaCaOLokX4tnVeBM/0noWcIq6ht2fzGdFBxsIJEAwRcDe5UrZyil9c0V3i3+heoko+wLcjO6ZkU1TJhQeyo8YhDDNAjHRGBoHJCvMs6OSfW/fadieZnAa0fhyegOsDt2WcZbPRNl8mykYy6C5aIb1opW/SaGpRtJLzHF6lpunPMGOWTPPdMXcHOVj8BWD1KPG902bzRc/5fsFa+/SVbREnSKAmFTIgC2jVkEyq5UbX/wyZe9w3GLIDK6/ZT3vVUGDt8KkP7XRcydnBVqSZ55ejGW3BrMiOTJPDmov6m2/OgEOI6R3ZSmTmPqH0Ce5zcDZauWAIZ0atZI=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N0pqZm9FZXA0SERmaDNrRDc1WU1LakNBSGlIQ3BwQ1ZjK1IyZmg5SjJLT2hm?=
 =?utf-8?B?V0VqL05WU0FxM0g0endPZUhJUUJmRWl6TkVMbEhDVS90UG4vdE9tSEU5by9N?=
 =?utf-8?B?VkJORWtidDVTbEtHUERHb0c4S3c4Rm42NDdzNXgvZ0I4VDA5azRNV1N3cU9X?=
 =?utf-8?B?UHlPNk5QVE55MmlmMUlubU5OSU9uV0FkNnNWZW82azB1WkMwenN6M2pKU3pS?=
 =?utf-8?B?aXNKLyt6WkV5WDBnRWhibk0yNkZyUXJrdEtvaFk5VHphbVp1d21RbndBTkR4?=
 =?utf-8?B?VVZOOS9nTEtUNTRVdVIrajgwV2czeHlubmNFL0JYc290SzRWVUlGN0pwVDMw?=
 =?utf-8?B?b2JUMFcxMFlscXg4cTUzRDhUTVpRT1lQb3cwaGtuRHJBTFljTEFkZXBqQWJW?=
 =?utf-8?B?dEczVDZwdFVSWE5RWXFnWjRoOXlBSW9tTGxQWjZMbVRlTUNwTHcwNytVd3kx?=
 =?utf-8?B?RkMvM3Zxd09QTkFoV056VVg4WnRZRXFKZzFWSkcvRzhNMVFkSldHRXhDMHBk?=
 =?utf-8?B?bzEwTERza3J5WExzeVQ4WkppTThsYURlemRtckdrUnMxNU5XSnl4cmxZcUFO?=
 =?utf-8?B?d1JKV010UDFDSnRWU2dJU3dvZzBNdEdBL0pYVkJZSTBRaWNWeFlzWVFGMzha?=
 =?utf-8?B?WWx2Q2VTU3lDNlRVenpxTEpHTVJ6ZDZlWExJQTE2MDRvNDRrMjdJUzhia3h5?=
 =?utf-8?B?VlJGSHh2bWxUbkFMQXdhZ1FRUXV0NFVNUThGU1cydFdDVDhhTnlJT2NZU09m?=
 =?utf-8?B?YzVBRno1dG92Y0ZnOTRLUjRaaU9mV1VZS0F4cGJYUjBsYVFlV2VwT3BoZWJm?=
 =?utf-8?B?NUIwRWk3VTUzb1B3NUQ1eTBYczUyMCtUM1k0RWJ6dWcxenplZ0xLWmVmUmg1?=
 =?utf-8?B?aEJwZEsrdmxpeFlLc0phUzJPZHVkUTJSL3dVQ2dkOC9xNWZaV1BQK1VrcWRP?=
 =?utf-8?B?Y2NmbzdCbTE3MUJIZkhkZVN6Q3V2QUZvRXVyYWpyQWRZZHlyOHdhZzI4Nm1l?=
 =?utf-8?B?YUREdmJrbFNSSmtFc0RSb21hWFJST0hQSGhVdUZzQTlsVDQrUHcwWGdqTTdW?=
 =?utf-8?B?QzhoY0hYZXB6S2ZXWWRSVkxsek0rWUU3Z0NqcGN1RnFSSDZZbm1RbFBSYUcv?=
 =?utf-8?B?dTZ6endqcDJzV3ZyQXU5N0ZDVE5uMHR4NXBVN0JqNnNwcTZxT0llRlhiSHJo?=
 =?utf-8?B?N0FpRVRFWmFlZWwrSXdMUHhMeEVNSnk3eTR6UWtGT3pKZFJGVVkxRXNER2dk?=
 =?utf-8?B?QXVYeEE0UldRVDhOWXhjY01VR0hmR2JIWVNyUTRzNEFWOUcwWDNxeGM4cHdP?=
 =?utf-8?B?ZjVIVHF0enp5VkpMZTNQVnF4cFpNWTlRbkZYTDBjem9VdlA1MEpSYzFOYS92?=
 =?utf-8?B?TVJETUFJNlpzbkRuM1FwKytBajBiVjhFTENIRGxocmtac2JVSFdibm9IOHhz?=
 =?utf-8?B?TmhXSkYwbDNkYjlKUTZRUFhNR0ZaR3VWMkJTK1FIRXczaEwyMkgzVkQxczU4?=
 =?utf-8?B?OWFwY3QzNUViaDN0NVVLUFF5aUR5OUlORVJoTXFYaXFzYUFvM1N6VlRjTDdK?=
 =?utf-8?B?Uk5KeGNXQjBITjNyK1RSajdLYmx1QTFmU0NTeFoyc1hMUjlEYTFXN0lPOGtM?=
 =?utf-8?B?SGZoajJ4OUFlcGNTdE5KNmxRNURDVmhFSEVkcWVlM1VaQnM2OHNhQUErMWNL?=
 =?utf-8?Q?y9ZPnyXngc63417PLrlP?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d4ba0e6-fb3c-4526-dff4-08dc9af5aaf4
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 00:18:30.7790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2P287MB2064


On 2024/7/2 19:52, Thomas Bonnefille wrote:

[......]

>   SOUND
>   M:	Jaroslav Kysela <perex@perex.cz>
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 8db68b80b391..826871a2e61a 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -1122,6 +1122,15 @@ config SC27XX_ADC
>   	  This driver can also be built as a module. If so, the module
>   	  will be called sc27xx_adc.
>   
> +config SOPHGO_ADC
> +	tristate "Sophgo ADC"
> +	depends on ARCH_SOPHGO || COMPILE_TEST
> +	help
> +	  Say yes here to build support for the ADC integrated in Sophgo SoCs.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called sophgo_adc.
> +

I believe this adc driver is only for sophgo cv18xx, sophgo has other 
soc chipset, such as sg2024 etc., so it's better use add more limitation 
for this.

>   config SPEAR_ADC
>   	tristate "ST SPEAr ADC"
>   	depends on PLAT_SPEAR || COMPILE_TEST
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index edb32ce2af02..106a83d50d01 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -102,6 +102,7 @@ obj-$(CONFIG_ROCKCHIP_SARADC) += rockchip_saradc.o
>   obj-$(CONFIG_RICHTEK_RTQ6056) += rtq6056.o
>   obj-$(CONFIG_RZG2L_ADC) += rzg2l_adc.o
>   obj-$(CONFIG_SC27XX_ADC) += sc27xx_adc.o
> +obj-$(CONFIG_SOPHGO_ADC) += sophgo-adc.o
>   obj-$(CONFIG_SPEAR_ADC) += spear_adc.o
>   obj-$(CONFIG_SUN4I_GPADC) += sun4i-gpadc-iio.o
>   obj-$(CONFIG_SUN20I_GPADC) += sun20i-gpadc-iio.o
> diff --git a/drivers/iio/adc/sophgo-adc.c b/drivers/iio/adc/sophgo-adc.c

As I mentioned upon, soghgo has many other product code, and 
"sophgo-cv18xx-adc.c" should be more accurate.

[......]


