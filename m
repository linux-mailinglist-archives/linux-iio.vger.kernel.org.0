Return-Path: <linux-iio+bounces-8428-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5655394FB2C
	for <lists+linux-iio@lfdr.de>; Tue, 13 Aug 2024 03:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00336282475
	for <lists+linux-iio@lfdr.de>; Tue, 13 Aug 2024 01:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02BC7749C;
	Tue, 13 Aug 2024 01:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="RDodrsRD"
X-Original-To: linux-iio@vger.kernel.org
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01olkn2024.outbound.protection.outlook.com [40.92.102.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1489579C8;
	Tue, 13 Aug 2024 01:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.102.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723513198; cv=fail; b=ug9j8K/YmjRRQcgpjw9du/A1sG9WmMgDHaM7QT7QPaOB2/7z00h7FDp76SbK5Bd5xvGPfUB8xmXlK0DAmt7EGuoxdPhHDRhwxWroGR+KV0XpWh3Kd81TsnoA0ymomhR6D0rP7IJhLiekx92p/c2XNAJ2t/cCmCR9qJn0ugZejP0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723513198; c=relaxed/simple;
	bh=eVDEOrsqWHkxqeK7TpeTG4bel5IC3JAaVMFhNOgQMDE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AzQYzEyGi4En2NAH1gsoLedh/EsRPDP6VWprif9LYIazbZsmxi3tMTWJl0fsnHj1lQbKaJGhSIQBnkZLGv/NdwSF/lhFWN+YU2W+NlR+sxLKg4ESJBMhxXXwEVRC2Iu3flUNuRPS849/soLop1rcHMIo+mME37BRoeLGZQwbYZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=RDodrsRD; arc=fail smtp.client-ip=40.92.102.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oQvlFx9/vT5US3Xowvz+kbgfaeCUu1blqyy0Y5hF4yVzwtf5Y9Mr//4OIoVvMv34nBQc0eVgmFQJtr4DhhgWKpZbvvg9fsegbpNotacp8fwo8bbLXhF2mLUYJRHZvdzlsksSmp784QaZ8PoDRPF3rJGVL1flWR/QCPY2FchDpSx4i8fu2YLvZ8GvBRw1/O8pBORgW7neUB+mWpT81QQwrth6csIE8MvUX17cLLI+UltWaa90XiakYaZPjgo3tBnCwzzf0Z3jTFBefTvA3A+j59qwy1xQhrk/1Ji6sJA4Prz3G272qRQ9mfgZqxaFkAcFaJiZyAFUL6w3jIG2f9q61A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ev1YlFY2BE3lrTx30Ikty9TQ4lDzkl1yjJIWeAcuqlo=;
 b=ONPH/bozBnSPLOmmCcbaF375W+9eckZSFuKk1XTfEjMnw1THa0l7xRz9zn3vm+t4PDg2uKUflmHcesFJpeqFSsdascSqcj+sCNyBYPV57N9F33tB//TkfexOu/arxFPVxFubh8Xkzx7KAgqeh3kFtJU/qJO1WoIsvErwuVYwU5Mw6anqb0/1gyeRxbT/mCe/rfmcy/dqk9V/kCIljdvmFiGnjCqTtPjccQolCox/ZD9hw/ZPkvEKFbKk2GLQjb9eY0lopWwYuEYXatGf6r2gaQJosjMjKb7M3iAbU1WmF1oTbT7GVibJViylN0YQ+6taEiRSV0GZCQdlymjWlRgYUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ev1YlFY2BE3lrTx30Ikty9TQ4lDzkl1yjJIWeAcuqlo=;
 b=RDodrsRDj3sbMoyz0uM7+IlJQIfgUdPodD8oewtdnlglggttThWAkoV3jG/7XJQD7F2T0mIQNYfgoYjC0w67jK/bTiy0RlO2QcPEEsUw7Esp+PJKa1hJcddkc872op6mjHeQp8WjRrgfQ/84QtozGQTe5QKIhmIgJsQEkspqHh28PSjx+qTokshWYNsEx/am9g8P/EpPevZt7vY2bmra19A9t5gd9nunRSJhNfm1WcnVOb268sWCb6l/foct9B1Y02XtWZgntunlyCGamzADy6eKafR76do122ZTczDVCHMzdTeR6yCfK+nSpHIEOR+doL+I8K4yG8uB8FErDU2kNA==
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:138::5)
 by PN2P287MB0320.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:dd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Tue, 13 Aug
 2024 01:39:48 +0000
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a94:ad0a:9071:806c]) by MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a94:ad0a:9071:806c%6]) with mapi id 15.20.7849.021; Tue, 13 Aug 2024
 01:39:48 +0000
Message-ID:
 <MA0P287MB28221B0A8EF6F853D8B871E2FE862@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Date: Tue, 13 Aug 2024 09:39:42 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] iio: adc: sophgo-saradc: Add driver for Sophgo
 CV18XX series SARADC
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
References: <20240812-sg2002-adc-v4-0-599bdb67592f@bootlin.com>
 <20240812-sg2002-adc-v4-2-599bdb67592f@bootlin.com>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <20240812-sg2002-adc-v4-2-599bdb67592f@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [6ovH3cxrmcK0X9HnqwMZllyzIwFY9SN1]
X-ClientProxiedBy: SI2PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:4:196::15) To MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:138::5)
X-Microsoft-Original-Message-ID:
 <3a92f13e-b8c7-4579-a13f-159451dce2d3@outlook.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB2822:EE_|PN2P287MB0320:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ef7c4b4-2e25-4b95-91a9-08dcbb38d0e9
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|15080799003|5072599009|8060799006|19110799003|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	8EXPbWpu7w3CRsl4BJK3jUC0GPjA6TpYglY90LYNKxHVdBweNqmQ3te4FffRy7dSQeXPcWpZmEYVN4wltDyMCXl0ulbRa1niEW6YHBeYCWoVVzctwuHdA73q5Exzskodi7Rn1JuXAR0sXbh58zwWsazxgNG/sEAiwyCwftpWm4synpUhXrM7rtgJ+N6lcp9qrhQOqMP+eAEYD+HpSjV/Ygx+RzGeQK1UxKUx+75sgCOn3ksFsNGFPlhNdT1NN1fcBp0RalkFyJ0HF1o+MJFUAjIu1p75L5j+bCBmSDXzUQoqA3vPsz9+Fg1+bkP6mIDvlQf6VfBeAQFCq6L0hzWR53KDVCdPU3QSgVpV3e3UksvEpeRsN4AHMhEqJWiNvZGckiOybsr5SGLYyYcyoNNX61xAqUEQJ8nogYx6zLH5tENwHZ5BA082RBfySsDAlOY1k/mD1q68AUVp8t1jjyP07lDHn2Pjj+9BYX79JFsh7PqwMHrdNPwIDxNl7LKyR8AlNsSrGnD3fsW8miMpF9GHD7YE7qV4VeSx3wteUPx1qrofCS6M8XuWyB/dYMD0g1V6ZVKADlyFc+kbduxDiStSmqzYZBCifRCrcehVzGW/rIlj3qkU6BkynuIBa43WB8C6ALGh7wq4ROPw0Pt68sLyLN4HHtYC95ey7XhuYdtcNsXOwFmYvXOEAgVbNmPLExYyIPLHq3i97lqC+plrgZJ+aA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dXhMVnpaT1A5Unh1TUpERXF6ekhCZUlUSUthREs1ai9NaEMvQkNlMUs0WmYy?=
 =?utf-8?B?R1BrUzUra2NzZWxHazBWZzVkZFRpejJJU0FHbXFPem00bXNteEFKc0Z1WTUv?=
 =?utf-8?B?RHpVWURJbUsvRnM0VDRnbXdNRHFUbFMvZkZCdlJ2VUFSb1MzZkpkOXRMUlBv?=
 =?utf-8?B?TUNrSFVSbDRxaGV3KzVidW91UEZZdVJydVY0UFQ0MDNyTlZ1OU0yNnhXVzAz?=
 =?utf-8?B?aURZZTRDQVphV1kwWFFFTDV4NHNsRmdoMlNpUXBsYUkrcnZFeEJKVzFMR2NZ?=
 =?utf-8?B?U0tKT0kyRVlDZDJIbWRZL1Zwbm4ySFprdjMrQ1JDbkhsOVNDZXJzZTFxR29X?=
 =?utf-8?B?VWJkdDhvNmxRRDNCZXhLdkJJQ2FlTCtIdmJJVTVmdEJ0alhHS2hMNkFKbE15?=
 =?utf-8?B?WmlBMTlLdFJNZVB1dGF3OXRIa0orUGxQL29TbnZabUlJNGV1UDdWZUJzSlF6?=
 =?utf-8?B?Z1hhL09ubUpFYU1GUk9TU1hFUXVOeWpDNjh3cXJjZ3ZIMWVsQXFDY1RwaDRZ?=
 =?utf-8?B?NXR2YTJ6YWE3ZHhhNWNUTVdVWDlrVGFlVEZ2UlJCOXVBc3dNc25NMkI3dzRm?=
 =?utf-8?B?SW0vN1ZPVXphU2JTejJMYmVFaFJJa0E4QUtTRDVzR09MQ21CZzlSNkhHTklm?=
 =?utf-8?B?L1cydVVSQVlSWWFoSFRrc3BWL21WK1dmRVhjY0V5aVhGa3hiMUNSMWlLbyt6?=
 =?utf-8?B?MWw4K3lIN0xlODBURDhvamJTOHROVEdmZEFpcml0bDBmU2ZkcnZWbHMzT1Bo?=
 =?utf-8?B?Z2Z5TWZVcVBaVFhQSFAra3h1eGpQUzV6QkJYT0daWjhQaTF5SjNZL3J0c1pN?=
 =?utf-8?B?a0RGTUoxbkNlbmdpS3BFb010TDNTN1JyWmtMWDVDOW1XU2JuS3crUHBTNVlB?=
 =?utf-8?B?QXF0TFFxbzBKSVpNMmhhdWJSMHdzcnVXS1RtdU5hUW1qM2dIbGFwOUk5ZFhI?=
 =?utf-8?B?Sm9XS1FBSXBMSUk4Vy9ZSy91cXo3S2ZNeGx3VHlELzM1SWI3N0ZZSnJ3VGNO?=
 =?utf-8?B?K25yMlpWRnZaazRJbEdJSEJDUUJBL0dud093SWRSNm4xelYvV3Bib29CVFlZ?=
 =?utf-8?B?MkZ3ZDJYRVlVL3JPRDRhZ0Zhd0Y5YzlRUzRpYldvQXd6MzczQk8zMHMwcC8w?=
 =?utf-8?B?dG53ZGFsTFpRMjl0NWt3ZTFqcU83YzdJOS9lak5kWlVUUFlFRFJZejVLR1V0?=
 =?utf-8?B?UFZjVWx6VTQvazEyS1BzSFhwNVl3ZE81U214RnM3QURrMGRmOGF1WnB3ajN6?=
 =?utf-8?B?eVU2ZnhIc0NFZnllTU5qYndYeFZBTkw1a3BUK09IclBhUG9wdDlHRmdFNDhL?=
 =?utf-8?B?Qy9qem5USk9EbUc5dllaR09weW1oSFBacmUzOTF3MFRKa2JyVFU3OTZHVlQr?=
 =?utf-8?B?VGNMSTBwUXBZVUh4eThrUXMzKzd5TmliK0U0cmRSRVp3OGFMSWJKRjcwN28z?=
 =?utf-8?B?ZGdyV0I1a3d5VnF2N0Rma2R5enEwTERycUJWZ1RJVUtmL1hkMUNGK24wcnBC?=
 =?utf-8?B?RmttZEgzdGNvMlprdXBjbUpsTUVxUjJpM0hiWmZ6aSt6QUxTSjIzQUgyZ00v?=
 =?utf-8?B?UGppUEs4bTJLKzBFT0tQOGZ6cFVLWExjTlVEaVNIckgxTUNvNWpmOUFZN0k5?=
 =?utf-8?B?SkJtWU5lZDkvT25oczJPVFVRVjExeTNqZEdCSWNSSGsyWFFHU2xZeVQ0REd0?=
 =?utf-8?Q?oRFlsmqSCXx569E0PjJZ?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ef7c4b4-2e25-4b95-91a9-08dcbb38d0e9
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 01:39:47.9893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2P287MB0320


On 2024/8/12 23:00, Thomas Bonnefille wrote:
> This adds a driver for the common Sophgo SARADC.
Not common. Please double check the whole patchset.
>
> Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
> ---
>   drivers/iio/adc/Kconfig             |  10 ++
>   drivers/iio/adc/Makefile            |   1 +
>   drivers/iio/adc/sophgo-cv18xx-adc.c | 208 ++++++++++++++++++++++++++++++++++++
>   3 files changed, 219 insertions(+)
>
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index f60fe85a30d5..b10bf26d8e86 100644
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
> +	  will be called sophgo_cv18xx_adc.
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
> index 000000000000..ab7ee0f482cc
> --- /dev/null
> +++ b/drivers/iio/adc/sophgo-cv18xx-adc.c
> @@ -0,0 +1,208 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + *  Sophgo CV18XX series SARADC Driver
> + *
> + *  Copyright (C) Bootlin 2024
> + *  Author: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
> + */
> +
> +#include "linux/err.h"
<linux/err.h> ? And please sort with the file name alphabeta.
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/completion.h>
> +#include <linux/dev_printk.h>
> +#include <linux/interrupt.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iopoll.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/platform_device.h>
> +
> +#define CV18XX_ADC_CTRL_REG				0x04
> +#define		CV18XX_ADC_EN				BIT(0)

Should be one space between "#define" and macro-name. Please check this 
for the whole file.

Run "./scripts/checkpatch.pl --strict" if it can help you check this 
format error?

> +#define		CV18XX_ADC_SEL(x)			BIT((x) + 5)
> +#define CV18XX_ADC_STATUS_REG				0x08
> +#define		CV18XX_ADC_BUSY				BIT(0)
> +#define CV18XX_ADC_CYC_SET_REG				0x0C
> +/* The default cycle configuration is set to maximize the accuracy */
> +#define		CV18XX_ADC_DEF_STARTUP_CYCLE_MASK	0x1F
> +#define		CV18XX_ADC_DEF_SAMPLE_WINDOW_MASK	0xF00
> +#define		CV18XX_ADC_DEF_CLOCK_DIVIDER_MASK	0xF000
> +#define		CV18XX_ADC_DEF_COMPARE_CYCLE_MASK	0xF0000
> +#define CV18XX_ADC_CH_RESULT_REG(x)			(0x14 + 4 * (x))
> +#define		CV18XX_ADC_CH_RESULT			GENMASK(11, 0)
> +#define		CV18XX_ADC_CH_VALID			BIT(15)
> +#define CV18XX_ADC_INTR_EN_REG				0x20
> +#define CV18XX_ADC_INTR_CLR_REG				0x24
> +#define		CV18XX_ADC_INTR_CLR_BIT			BIT(0)
> +#define CV18XX_ADC_INTR_STA_REG				0x28
> +#define		CV18XX_ADC_INTR_STA_BIT			BIT(0)
> +
> +#define CV18XX_ADC_CHANNEL(index)					\
> +	{								\
> +		.type = IIO_VOLTAGE,					\
> +		.indexed = 1,						\
> +		.channel = index,					\
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
> +		.scan_index = index,					\
> +	}
> +
> +struct cv18xx_adc {
> +	struct completion completion;
> +	void __iomem *regs;
> +	struct mutex lock; /* ADC Control and Result register */
> +	int irq;
> +};
> +
> +static const struct iio_chan_spec sophgo_channels[] = {
> +	CV18XX_ADC_CHANNEL(0),
> +	CV18XX_ADC_CHANNEL(1),
> +	CV18XX_ADC_CHANNEL(2),
> +};
> +
> +static void cv18xx_adc_start_measurement(struct cv18xx_adc *saradc,
> +					    int channel)
> +{
> +	writel(0, saradc->regs + CV18XX_ADC_CTRL_REG);
> +	writel(CV18XX_ADC_SEL(channel) | CV18XX_ADC_EN,
> +	       saradc->regs + CV18XX_ADC_CTRL_REG);
> +}
> +
> +static int cv18xx_adc_wait(struct cv18xx_adc *saradc)
> +{
> +	if (saradc->irq < 0) {
> +		u32 reg;
> +
> +		return readl_poll_timeout(saradc->regs + CV18XX_ADC_STATUS_REG,
> +					  reg, !(reg & CV18XX_ADC_BUSY),
> +					  500, 1000000);
> +	}
> +	return wait_for_completion_timeout(&saradc->completion,
> +					  msecs_to_jiffies(1000)) > 0
> +					  ? 0 : -ETIMEDOUT;
> +}
> +
> +static int cv18xx_adc_read_raw(struct iio_dev *indio_dev,
> +				  struct iio_chan_spec const *chan,
> +				  int *val, int *val2, long mask)
> +{
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:{
> +		struct cv18xx_adc *saradc = iio_priv(indio_dev);
> +		u32 sample;
> +
> +		scoped_guard(mutex, &saradc->lock) {
> +			int ret;
> +
> +			cv18xx_adc_start_measurement(saradc, chan->scan_index);
> +			ret = cv18xx_adc_wait(saradc);
> +			if (ret < 0)
> +				return ret;
> +
> +			sample = readl(saradc->regs + CV18XX_ADC_CH_RESULT_REG(chan->scan_index));
> +		}
> +		if (!(sample & CV18XX_ADC_CH_VALID))
> +			return -ENODATA;
> +
> +		*val = sample & CV18XX_ADC_CH_RESULT;
> +		return IIO_VAL_INT;
> +		}
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = 3300;
> +		*val2 = 12;
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static irqreturn_t cv18xx_adc_interrupt_handler(int irq, void *private)
> +{
> +	struct cv18xx_adc *saradc = private;
> +
> +	if (!(FIELD_GET(CV18XX_ADC_INTR_STA_BIT,
> +			readl(saradc->regs + CV18XX_ADC_INTR_STA_REG))))
> +		return IRQ_NONE;
> +
> +	writel(CV18XX_ADC_INTR_CLR_BIT, saradc->regs + CV18XX_ADC_INTR_CLR_REG);
> +	complete(&saradc->completion);
> +	return IRQ_HANDLED;
> +}
> +
> +static const struct iio_info cv18xx_adc_info = {
> +	.read_raw = &cv18xx_adc_read_raw,
> +};
> +
> +static int cv18xx_adc_probe(struct platform_device *pdev)
> +{
> +	struct cv18xx_adc *saradc;
> +	struct iio_dev *indio_dev;
> +	struct clk *clk;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*saradc));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	saradc = iio_priv(indio_dev);
> +	indio_dev->name = "sophgo-cv18xx-adc";
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->info = &cv18xx_adc_info;
> +	indio_dev->num_channels = ARRAY_SIZE(sophgo_channels);
> +	indio_dev->channels = sophgo_channels;
> +
> +	clk = devm_clk_get_enabled(&pdev->dev, NULL);
> +	if (IS_ERR(clk))
> +		return PTR_ERR(clk);
> +
> +	saradc->regs = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(saradc->regs))
> +		return PTR_ERR(saradc->regs);
> +
> +	saradc->irq = platform_get_irq_optional(pdev, 0);
> +	if (saradc->irq >= 0) {
> +		init_completion(&saradc->completion);
> +		ret = devm_request_irq(&pdev->dev, saradc->irq,
> +				       cv18xx_adc_interrupt_handler, 0,
> +				       dev_name(&pdev->dev), saradc);
> +		if (ret)
> +			return ret;
> +
> +		writel(1, saradc->regs + CV18XX_ADC_INTR_EN_REG);
> +	}
> +
> +	ret = devm_mutex_init(&pdev->dev, &saradc->lock);
> +	if (ret)
> +		return ret;
> +
> +	platform_set_drvdata(pdev, indio_dev);
> +	writel(FIELD_PREP(CV18XX_ADC_DEF_STARTUP_CYCLE_MASK, 0xF) |
> +	       FIELD_PREP(CV18XX_ADC_DEF_SAMPLE_WINDOW_MASK, 0xF) |
> +	       FIELD_PREP(CV18XX_ADC_DEF_CLOCK_DIVIDER_MASK, 0x1) |
> +	       FIELD_PREP(CV18XX_ADC_DEF_COMPARE_CYCLE_MASK, 0xF),
> +	       saradc->regs + CV18XX_ADC_CYC_SET_REG);
> +
> +	return devm_iio_device_register(&pdev->dev, indio_dev);
> +}
> +
> +static const struct of_device_id cv18xx_adc_match[] = {
> +	{ .compatible = "sophgo,cv1800b-saradc", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, cv18xx_adc_match);
> +
> +static struct platform_driver cv18xx_adc_driver = {
> +	.driver	= {
> +		.name		= "sophgo-cv18xx-saradc",
> +		.of_match_table	= cv18xx_adc_match,
> +	},
> +	.probe = cv18xx_adc_probe,
> +};
> +module_platform_driver(cv18xx_adc_driver);
> +
> +MODULE_AUTHOR("Thomas Bonnefille <thomas.bonnefille@bootlin.com>");
> +MODULE_DESCRIPTION("Sophgo CV18XX series SARADC driver");
> +MODULE_LICENSE("GPL");
>

