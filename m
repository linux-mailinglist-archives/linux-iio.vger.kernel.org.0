Return-Path: <linux-iio+bounces-8118-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC109439CF
	for <lists+linux-iio@lfdr.de>; Thu,  1 Aug 2024 02:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7CC9285DDE
	for <lists+linux-iio@lfdr.de>; Thu,  1 Aug 2024 00:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963AF16DC07;
	Wed, 31 Jul 2024 23:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="sQoIv5i8"
X-Original-To: linux-iio@vger.kernel.org
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2065.outbound.protection.outlook.com [40.92.103.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7543314B097;
	Wed, 31 Jul 2024 23:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.103.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722470266; cv=fail; b=qcqvW+idWxfmIrXi1cee5zzRT17MJns6GQ8RIvlt1bUEaK9malBbP0jNEwMITFx47N2Eue+PE7BJNznFAr6ACq9IO7BpptkvE71P6+OkAdx4nfciYRf3emjy2PNdilz++QovHD3Nqt8ePy42DKkbZy+XmQJMoWY7alRma1VZTDg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722470266; c=relaxed/simple;
	bh=yNTDBCKtlv61BN/S5BLugGUttSYSYFNBQCewZax/lN4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WFGAJkZz0NcQFwXfSGITvgWxgzOTFbL0ZB0F+XqoXdTiIhYwicrhMnertCLj7RVaIfOsyZ5teHaWhejIud9f7jouFLhKj71MTrNW6a2it/Q7gDqS+asxBxeK7XTKprWNpKue8bBvZE48c9xTXgZz+KZe2T01n641jCmC02HkeoE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=sQoIv5i8; arc=fail smtp.client-ip=40.92.103.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dbg8MUsPD8PH/CBMbesaFLExIyi4Nk6pKrgCKOQeInp8U/NjHIHt40b4j+EKfM0j7yUZCMP6Uc9FS1FiWH/e+Pg7cBddalkDps3LQaw+vUpeQsQNkdS7kajibvNKOR0ghw5+EVK96f7kStDSGLkehveFWHDC4629UKH6XKOravCO0AS7zdUGJ1HBS+553gK6YmgHkkWIAZ9cqh/LVKJL7QggZc0js7kRgLeP8nvfxe4h6oktu/W5cANuxfVUEODOJgioN0uRO8fmrPFCkoiGoE50PsvdwMMK5VfDi9YtGgjOiKrLEOVJedhRZC/8wN7pdrrsmpQby5hE8KtbTDp0hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lqAwMZ6sF+S/VCYryeumLgFJAAgBUNYz8vYiR7O8iOU=;
 b=wtaY6WN9SP0OSPPkJ4YhC2qc9IehXk0s/XRgPOB0l5KDNtB0rAk3zMWrzFkI0cxyRssbNYFG+2mfYzJ6lx7gveLGd5+NMe4musm/2o/psQFkKhP3PU2yRpKA2WNepBrsGp5k1sUEbGaXbYBmis9oaKOIohJ7+yZyaFBngPnSIknF9aEhdqs0k+V5ARRXc8Y0lrd8stXm/EZh+dc3GN8Fvdo4tgStj5Ea7ROawPO7DcsC6HdfZsXzSxHVmGKSoUM9w7p2h4PgkLG0eCdgm9ea7dqSXs3L6YfTlTBE6sgOnpgtgMsuZcJ20+VOUxpRPF475azwesech+mnzSFHvarpgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lqAwMZ6sF+S/VCYryeumLgFJAAgBUNYz8vYiR7O8iOU=;
 b=sQoIv5i84HcJvkwWYgt+jmjKL3FBd5aIlXfkI1Dar/tw5pUI8R2nE/GGQfnvH4QdJ4V7OKOMvoJInm5kawjUZuJw+YzuX+3HO6x1oqU+KC0TAP2SEgrV7csv2/+Z+KuBT7IvhZHSGbjmkyR0AwfviILMNb+jUeh4ks/P7apYLAAJaaPFyn4yRTviEjuEEC6VLpkXRI92TOl1K1b0Kh+UdVDo/vvlIIliAiA50kRCP1D1nmuQstilOCUVfqFBv33o/awf6DrQ0nYAFeA0UN2aexxlEHmWHOhU5fiyCsIAJIBOvr2Uxz5us9l0E0E9iSG9PcMFeP5scf2GCaLEqp8bIw==
Received: from PN1P287MB2818.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:214::7)
 by PN0P287MB0462.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:122::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Wed, 31 Jul
 2024 23:57:37 +0000
Received: from PN1P287MB2818.INDP287.PROD.OUTLOOK.COM
 ([fe80::5a8a:9e40:a4e8:3e2d]) by PN1P287MB2818.INDP287.PROD.OUTLOOK.COM
 ([fe80::5a8a:9e40:a4e8:3e2d%3]) with mapi id 15.20.7828.021; Wed, 31 Jul 2024
 23:57:37 +0000
Message-ID:
 <PN0P287MB28300F19F9D5F85F3EED942EFEB12@PN0P287MB2830.INDP287.PROD.OUTLOOK.COM>
Date: Thu, 1 Aug 2024 07:57:21 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] iio: adc: sophgo-saradc: Add driver for Sophgo
 SARADC
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
References: <20240731-sg2002-adc-v3-0-5ac40a518c0a@bootlin.com>
 <20240731-sg2002-adc-v3-2-5ac40a518c0a@bootlin.com>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <20240731-sg2002-adc-v3-2-5ac40a518c0a@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [ncl/nbYVv6jzGTS9htexqRT2CD+RDygs]
X-ClientProxiedBy: SI2PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:194::7) To PN0P287MB2830.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:204::14)
X-Microsoft-Original-Message-ID:
 <640bc146-5c63-48da-b3dd-e3fd2be4b555@outlook.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN1P287MB2818:EE_|PN0P287MB0462:EE_
X-MS-Office365-Filtering-Correlation-Id: fc5d7b9d-ce49-4713-76e8-08dcb1bc8c22
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|5072599009|8060799006|461199028|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	0JuTws2j7iK5CCg7KFhuhEQql8+44qOT+C2fJYN6SoHHBYUJT8JAoCZ7P6SEWvWD0kAbHyQzJxDGQznVeodwhjoOOlM2qseN0Dkabpsz7ake5esxpy5dIQBl5YtEsJ2iSK5YbcIflJ2nqjdi9zFdy0awEP7JaJUqIYhoBVol7fH+0tQbjRsEOV+2cRF/iIgyFPotGSz5nXu5dAbuBlO0FY4KRKTfKeOyon2uctOnLXVMH6Wo61K6npFPlBQlfgdJZmgHoJyQR5C32OkDCiWOr3rUJnFKZzFDU6pke14jekramu23xBo1DBMeIVTnPKSdhWiruZonu5pXhm2xCu9T0jGNnycEscilOart3iCWvY6cga1UrtH3+hrR4l18d2zvq3q2tXqWVMCFJiUGNn0pcDUJjFpx65JaRkaliFE0N2JJKaK04p6KZyIrWsUEQdZiTjVtlWujfPTvR7KYYYa99yV7kW594dr+MsUoRfC8YHKEdCd2lKHfEE3vdQU4Sh860gv30anAwD3vyXdzateL9TeeQjEmZiIBcBVtEPyybg9HjgVNBePwI9ZKnzxPR6KEoinb0ViQJdbS2Yzr22/vySn1gSd2ddyZNSQ/GZKm2XEY4MLVA14GxK77oX/09Dx8K5VKACxPJuvrVYf3LSDobinx+25vtLBNaaKnYTB9GGiPxHA6lf405Qc/+gKfZRb/
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NnR2c1RZOTdjUE5mLzEvUjVHUVBsRHBRdVVrTEE5WEwyZjNtWHZpelhtcm1B?=
 =?utf-8?B?ZDF4eHpFNkJ3dHp6ckxxOERiLzhPSVdlZnp2djlmL3c4aUZnczRaYXFHTENP?=
 =?utf-8?B?ZUNqL3RRaGYvTjhrSStiQXlXNEhncmVhQ1RxTzc4MEpRdzZLbFc3c1duZi8v?=
 =?utf-8?B?dzJVNlZwRUZsVTZoT1kwcEVEVU8xVnpET0piL053d1cybXRHWHdza05XdVVv?=
 =?utf-8?B?ZEtvcGRwMGlyWUJIaWlHancrOThoTUVGOGwxeHFoQ3NvYlc4QzN4MjFPUVc1?=
 =?utf-8?B?L0ZUd2Yyb2FVb0RNbGRrM0pPL1ZlZ3JRVVJsYXphcEZiZzEwVmVnODVYLzhz?=
 =?utf-8?B?M2YrdnJYV3dlSU94clZpdHBSSGVXcDhWVnBSVTM1ei9hWXlHcld1OUpKYTRk?=
 =?utf-8?B?M0xqRzZPZ0RvUG5yZTNHWjBBdkt2RGZDYUZUTWdvay9MTHB1aGhGV2JVa25q?=
 =?utf-8?B?TEtFcGh4WXBhVzVubW9kZWxzZUlJQTZwOFlsc3BkRnd4VnRIUUI1L1JGY09X?=
 =?utf-8?B?NW90UVJJU0FqSEYwRFVMT3BwNFFHejE3UHdVODFNd1E3MEhjaGxWZmJ1Uy9H?=
 =?utf-8?B?WElCblpIZGprSjUwSGhweWZ4VkJQQmUvWlpYcWJNM3E0TXE4bEtlQ1U0VEtT?=
 =?utf-8?B?WTRSajgzTm9SWis3K3I2SE5xK0ExSWRvRzJvMTJDb0k1NTNQbi8wSVdSL1gx?=
 =?utf-8?B?aXVFdnhMZFdDbktKMlN1SUhpUVpWY2tSYzhRVENVVXFFelV6UFdDMFI3WitJ?=
 =?utf-8?B?bklVcWhhTEpDS3d4NWViWm1XK016ZGtNUjBHeW1ITVRHTGVyU2NjYjAyMjZI?=
 =?utf-8?B?TFZ1NnRhdEZocFp3OXJJVEd4N0lXY0hHcGVUUVBGVjlHRm5XS05lalA1RUtz?=
 =?utf-8?B?cE5abzNnem1xb3loOWtzdzkzMnpWZlRkaTBLUXI5NTRvUlVSTW1TTWlVT09j?=
 =?utf-8?B?RC9MWXJIRE4xcEhYaHV5eEszOXhvWUNHUUVOVmlEbDJKYU1IYW9MRWxqMkZx?=
 =?utf-8?B?K0pmb3NkdzRobGdQT0QwZk8wZWZHRDBHR2FGdE12RUphcjE3elFKeGxmZ3dy?=
 =?utf-8?B?c2NjeWEyc3NpcXdPQ2hRSWRFYTdESGRxbFdRZi9IeGovcFFjRkxxNWpKcTJK?=
 =?utf-8?B?bVJFZjhGQ0pvbWFuTmdoKzhvMm0ycGd2cUF1RU5FYytoU2wwZDdhSW4zUzV1?=
 =?utf-8?B?cG91WUw3QWFETlNLWWtacmE5K1JmcDBPNGJyVHFweE9DYmhOREpNaSszNklC?=
 =?utf-8?B?Y0xLenNsdnUzZWkyL0R6ZE43bzRwb0NGWjY5Zm5yZUFQM1VRanhSWXhuazZr?=
 =?utf-8?B?K0FOQldyTEhUd2lFK251cjB0UEJ3SDdCakRXb21TYWlkVGx3QUovMlE2Yk1H?=
 =?utf-8?B?UU5VNDNlK09ZMm1wOXBPeDlhRCtMelF3cUpIS0kxeXJibjhJNEZDZjNNWnBK?=
 =?utf-8?B?SVNwUk1yM3ZNR3RIR08vZVZiS0VPcFczWGRCMG5hMG1FSDY2OXhFbmtVRjZV?=
 =?utf-8?B?UCtNYzlMVTBPL0pRRUlIQjE5OVhyR1dIMVF0RnhubnJEVmtvZCtnc1BOY3h1?=
 =?utf-8?B?WjlPRG05NW9lODQxWEoxTzBOZUhJbEFER2g5NDdIQ3FMMDJSU1h2amNvcTcx?=
 =?utf-8?B?QTRmUHdJWlhEdHR4WHlnZHRXRnhtZHd0TXJNWUNBRDhNNWxhZzBRc2lnUjVy?=
 =?utf-8?Q?tEyT2bgRJyjt7GFTduUJ?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc5d7b9d-ce49-4713-76e8-08dcb1bc8c22
X-MS-Exchange-CrossTenant-AuthSource: PN0P287MB2830.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 23:57:37.2574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0P287MB0462


On 2024/7/31 20:24, Thomas Bonnefille wrote:
> This adds a driver for the common Sophgo SARADC.
>
> Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
> ---
>   drivers/iio/adc/Kconfig             |  10 ++
>   drivers/iio/adc/Makefile            |   1 +
>   drivers/iio/adc/sophgo-cv18xx-adc.c | 206 ++++++++++++++++++++++++++++++++++++
>   3 files changed, 217 insertions(+)
>
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index f60fe85a30d5..10d6570233f5 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -1156,6 +1156,16 @@ config SC27XX_ADC
>   	  This driver can also be built as a module. If so, the module
>   	  will be called sc27xx_adc.
>   
> +config SOPHGO_CV18XX_ADC
> +	tristate "Sophgo CV18XX series SARADC"
> +	depends on ARCH_SOPHGO || COMPILE_TEST
> +	help
> +	  Say yes here to build support for the SARADC integrated inside
> +	  the Sophgo CV18XX series SoCs.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called sophgo_adc.

"sophgo_adc"? or "sophgo-cv18xx-adc"

> +
>   config SPEAR_ADC
>   	tristate "ST SPEAr ADC"
>   	depends on PLAT_SPEAR || COMPILE_TEST
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index d370e066544e..24c241b12ef0 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -105,6 +105,7 @@ obj-$(CONFIG_ROCKCHIP_SARADC) += rockchip_saradc.o
>   obj-$(CONFIG_RZG2L_ADC) += rzg2l_adc.o
>   obj-$(CONFIG_SC27XX_ADC) += sc27xx_adc.o
>   obj-$(CONFIG_SD_ADC_MODULATOR) += sd_adc_modulator.o
> +obj-$(CONFIG_SOPHGO_CV18XX_ADC) += sophgo-cv18xx-adc.o
>   obj-$(CONFIG_SPEAR_ADC) += spear_adc.o
>   obj-$(CONFIG_STM32_ADC_CORE) += stm32-adc-core.o
>   obj-$(CONFIG_STM32_ADC) += stm32-adc.o
> diff --git a/drivers/iio/adc/sophgo-cv18xx-adc.c b/drivers/iio/adc/sophgo-cv18xx-adc.c
> new file mode 100644
> index 000000000000..27e1aac9560f
> --- /dev/null
> +++ b/drivers/iio/adc/sophgo-cv18xx-adc.c
> @@ -0,0 +1,206 @@
> [......]
> +
> +static const struct of_device_id cv18xx_adc_match[] = {
> +	{ .compatible = "sophgo,cv1800b-saradc", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, cv18xx_adc_match);
> +
> +static struct platform_driver cv18xx_adc_driver = {
> +	.driver	= {
> +		.name		= "sophgo-saradc",
Add product name to differ other sogho soc. You can refer to 
drivers/iio/adc/ti_am335x_adc.c.
> +		.of_match_table	= cv18xx_adc_match,
> +	},
> +	.probe = cv18xx_adc_probe,
> +};
> +module_platform_driver(cv18xx_adc_driver);
> +
> +MODULE_AUTHOR("Thomas Bonnefille <thomas.bonnefille@bootlin.com>");
> +MODULE_DESCRIPTION("Sophgo SARADC driver");
Add product name to differ, don't use general name.
> +MODULE_LICENSE("GPL");
>

