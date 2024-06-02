Return-Path: <linux-iio+bounces-5633-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 996998D7633
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 16:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 472E42822B5
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 14:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3F64175A;
	Sun,  2 Jun 2024 14:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dGCN7wgL"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8E641C64;
	Sun,  2 Jun 2024 14:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717338411; cv=none; b=g8Ml/XeMLBdRVNEvsPAViPP9zPONDTKbNRPGM256UffXcWb04AQgWuqh66Xg6XnVkQ27kpktmcXLLwiffBTk3Lci4qwf6M+jyGPG1+RzsbBiwVCfJLfpnh69sU+OroqumIvNnITEciZSAZZ8lQKUId4eXhFQniCWgs82xxFOZ70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717338411; c=relaxed/simple;
	bh=ocyu4IomIF7t4vPiLb8DQ0YyaqYzMqGzF9w32xsHVPM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Oc1boryI/zmIMjpgusIPK6EtF9vVFzCmzw7gucdi7H/cV9iYFqO7TfHodZg2m5vxDpMu7QxHrysBUZD5mYI8CSJ9dIEG5z1JAyXES5ODQPHaLa997y+Z0PaFJG40OQLHP7xn1SET3xKdag0zkGzM/abYaKAgmE0iVJJts5WYjvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dGCN7wgL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD7BCC2BBFC;
	Sun,  2 Jun 2024 14:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717338411;
	bh=ocyu4IomIF7t4vPiLb8DQ0YyaqYzMqGzF9w32xsHVPM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dGCN7wgLkdB2B1takIzG4nVWgH3aRr/njEKuYlKxDuXKkCX48D35GxYgB/mteqLw0
	 TU1XR/NWbnWgA2qNF55TO3Gp7Az/BnoaBKEDuT1X1CyjUI/Vmt6Rua67JBwW7dEYBR
	 L1sW5Zv+mG/5TfGYomvVpUlogo8DBbY4FBzBYy8RPhx1BsrRuhEjB1UQUM/o4OsXb8
	 qjdpxK4ljB00MiHZoeufuZgnr3yOshOMtqdSr3ecdopauRveN1K9NXEjtErUz63xLF
	 hLyL1aqksJFdUmviKo5eFPL7q0t3UZOlUxxsPsMTriLxQ0lXNntZLAOqP+WMzrsOWH
	 83UvxSPxinp1w==
Date: Sun, 2 Jun 2024 15:26:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Yasin Lee <yasin.lee.x@outlook.com>
Cc: andy.shevchenko@gmail.com, lars@metafoo.de, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, nuno.a@analog.com, swboyd@chromium.org,
 u.kleine-koenig@pengutronix.de, yasin.lee.x@gmail.com
Subject: Re: [PATCH v3 2/2] iio:proximity:hx9023s: Add TYHX HX9023S sensor
 driver
Message-ID: <20240602152638.2c674930@jic23-huawei>
In-Reply-To: <SN7PR12MB81019AB7F38806097F2C8A34A4F22@SN7PR12MB8101.namprd12.prod.outlook.com>
References: <20240519162438.17af0ff8@jic23-huawei>
	<20240529045749.530039-1-yasin.lee.x@outlook.com>
	<SN7PR12MB81019AB7F38806097F2C8A34A4F22@SN7PR12MB8101.namprd12.prod.outlook.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 May 2024 12:57:49 +0800
Yasin Lee <yasin.lee.x@outlook.com> wrote:

> From: Yasin Lee <yasin.lee.x@gmail.com>
> 
> A SAR sensor from NanjingTianyihexin Electronics Ltd.
> 
> The device has the following entry points:
> 
> Usual frequency:
> - sampling_frequency
> 
> Instant reading of current values for different sensors:
> - in_proximity0_raw
> - in_proximity1_raw
> - in_proximity2_raw
> - in_proximity3_raw
> - in_proximity4_raw
> and associated events in events/
> 
> Signed-off-by: Yasin Lee <yasin.lee.x@gmail.com>

As you have some outstanding review comments to deal with already and
the patch is large, I'll take only a fairly superficial look this time.

As Andy pointed out, you can build a driver up in multiple steps to make
each step more reviewable.  Also worth dropping unused defines etc in
the interests of a more readable patch.  I don't want to bother checking
addresses of registers if they turn out not to be used!

Jonathan

> diff --git a/drivers/iio/proximity/Makefile b/drivers/iio/proximity/Makefile
> index f36598380446..81144ac47845 100644
> --- a/drivers/iio/proximity/Makefile
> +++ b/drivers/iio/proximity/Makefile
> @@ -6,6 +6,7 @@
>  # When adding new entries keep the list in alphabetical order
>  obj-$(CONFIG_AS3935)		+= as3935.o
>  obj-$(CONFIG_CROS_EC_MKBP_PROXIMITY) += cros_ec_mkbp_proximity.o
> +obj-$(CONFIG_HX9023S)		+= hx9023s.o
>  obj-$(CONFIG_IRSD200)		+= irsd200.o
>  obj-$(CONFIG_ISL29501)		+= isl29501.o
>  obj-$(CONFIG_LIDAR_LITE_V2)	+= pulsedlight-lidar-lite-v2.o
> @@ -21,4 +22,3 @@ obj-$(CONFIG_SX_COMMON) 	+= sx_common.o
>  obj-$(CONFIG_SX9500)		+= sx9500.o
>  obj-$(CONFIG_VCNL3020)		+= vcnl3020.o
>  obj-$(CONFIG_VL53L0X_I2C)	+= vl53l0x-i2c.o
> -
Stray change. Make sure to not do this sort of thing by taking a careful
look at your patches before sending.
> diff --git a/drivers/iio/proximity/hx9023s.c b/drivers/iio/proximity/hx9023s.c
> new file mode 100644
> index 000000000000..037665227d24
> --- /dev/null
> +++ b/drivers/iio/proximity/hx9023s.c
> @@ -0,0 +1,1428 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2024 NanjingTianyihexin Electronics Ltd.
> + * http://www.tianyihexin.com
> + *
> + * Driver for NanjingTianyihexin HX9023S Cap Sensor
> + * Author: Yasin Lee <yasin.lee.x@gmail.com>
> + */
> +
> +#include <linux/i2c.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/events.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/triggered_buffer.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/regmap.h>
> +
> +#include <asm-generic/unaligned.h>
> +
> +#define HX9023S_CHIP_ID 0x1D
> +#define HX9023S_CH_NUM 5
> +#define CH_DATA_2BYTES 2
> +#define CH_DATA_3BYTES 3
> +#define CH_DATA_BYTES_MAX CH_DATA_3BYTES
> +#define HX9023S_ODR_MS 200
> +#define TYHX_DELAY_MS(x) msleep(x)
> +
> +#define HX9023S_GLOBAL_CTRL0                   0x00
> +#define HX9023S_PRF_CFG                        0x02
> +#define HX9023S_CH0_CFG_7_0                    0x03
> +#define HX9023S_CH0_CFG_9_8                    0x04
> +#define HX9023S_CH1_CFG_7_0                    0x05
> +#define HX9023S_CH1_CFG_9_8                    0x06
> +#define HX9023S_CH2_CFG_7_0                    0x07
> +#define HX9023S_CH2_CFG_9_8                    0x08
> +#define HX9023S_CH3_CFG_7_0                    0x09
> +#define HX9023S_CH3_CFG_9_8                    0x0A
> +#define HX9023S_CH4_CFG_7_0                    0x0B
> +#define HX9023S_CH4_CFG_9_8                    0x0C
> +#define HX9023S_RANGE_7_0                      0x0D
> +#define HX9023S_RANGE_9_8                      0x0E
> +#define HX9023S_RANGE_18_16                    0x0F
> +#define HX9023S_AVG0_NOSR0_CFG                 0x10
> +#define HX9023S_NOSR12_CFG                     0x11
> +#define HX9023S_NOSR34_CFG                     0x12
> +#define HX9023S_AVG12_CFG                      0x13
> +#define HX9023S_AVG34_CFG                      0x14
> +#define HX9023S_OFFSET_DAC0_7_0                0x15
> +#define HX9023S_OFFSET_DAC0_9_8                0x16
> +#define HX9023S_OFFSET_DAC1_7_0                0x17
> +#define HX9023S_OFFSET_DAC1_9_8                0x18
> +#define HX9023S_OFFSET_DAC2_7_0                0x19
> +#define HX9023S_OFFSET_DAC2_9_8                0x1A
> +#define HX9023S_OFFSET_DAC3_7_0                0x1B
> +#define HX9023S_OFFSET_DAC3_9_8                0x1C
> +#define HX9023S_OFFSET_DAC4_7_0                0x1D
> +#define HX9023S_OFFSET_DAC4_9_8                0x1E
> +#define HX9023S_SAMPLE_NUM_7_0                 0x1F
> +#define HX9023S_SAMPLE_NUM_9_8                 0x20
> +#define HX9023S_INTEGRATION_NUM_7_0            0x21
> +#define HX9023S_INTEGRATION_NUM_9_8            0x22
> +#define HX9023S_GLOBAL_CTRL2                   0x23
> +#define HX9023S_CH_NUM_CFG                     0x24
> +#define HX9023S_LP_ALP_4_CFG                   0x29
> +#define HX9023S_LP_ALP_1_0_CFG                 0x2A
> +#define HX9023S_LP_ALP_3_2_CFG                 0x2B
> +#define HX9023S_UP_ALP_1_0_CFG                 0x2C
> +#define HX9023S_UP_ALP_3_2_CFG                 0x2D
> +#define HX9023S_DN_UP_ALP_0_4_CFG              0x2E
> +#define HX9023S_DN_ALP_2_1_CFG                 0x2F
> +#define HX9023S_DN_ALP_4_3_CFG                 0x30
> +#define HX9023S_RAW_BL_RD_CFG                  0x38
> +#define HX9023S_INTERRUPT_CFG                  0x39
> +#define HX9023S_INTERRUPT_CFG1                 0x3A
> +#define HX9023S_CALI_DIFF_CFG                  0x3B
> +#define HX9023S_DITHER_CFG                     0x3C
> +#define HX9023S_DEVICE_ID                      0x60
> +#define HX9023S_PROX_STATUS                    0x6B
> +#define HX9023S_PROX_INT_HIGH_CFG              0x6C
> +#define HX9023S_PROX_INT_LOW_CFG               0x6D
> +#define HX9023S_PROX_HIGH_DIFF_CFG_CH0_0       0x80
> +#define HX9023S_PROX_HIGH_DIFF_CFG_CH0_1       0x81
> +#define HX9023S_PROX_HIGH_DIFF_CFG_CH1_0       0x82
> +#define HX9023S_PROX_HIGH_DIFF_CFG_CH1_1       0x83
> +#define HX9023S_PROX_HIGH_DIFF_CFG_CH2_0       0x84
> +#define HX9023S_PROX_HIGH_DIFF_CFG_CH2_1       0x85
> +#define HX9023S_PROX_HIGH_DIFF_CFG_CH3_0       0x86
> +#define HX9023S_PROX_HIGH_DIFF_CFG_CH3_1       0x87
> +#define HX9023S_PROX_LOW_DIFF_CFG_CH0_0        0x88
> +#define HX9023S_PROX_LOW_DIFF_CFG_CH0_1        0x89
> +#define HX9023S_PROX_LOW_DIFF_CFG_CH1_0        0x8A
> +#define HX9023S_PROX_LOW_DIFF_CFG_CH1_1        0x8B
> +#define HX9023S_PROX_LOW_DIFF_CFG_CH2_0        0x8C
> +#define HX9023S_PROX_LOW_DIFF_CFG_CH2_1        0x8D
> +#define HX9023S_PROX_LOW_DIFF_CFG_CH3_0        0x8E
> +#define HX9023S_PROX_LOW_DIFF_CFG_CH3_1        0x8F
> +#define HX9023S_PROX_HIGH_DIFF_CFG_CH4_0       0x9E
> +#define HX9023S_PROX_HIGH_DIFF_CFG_CH4_1       0x9F
> +#define HX9023S_PROX_LOW_DIFF_CFG_CH4_0        0xA2
> +#define HX9023S_PROX_LOW_DIFF_CFG_CH4_1        0xA3
> +#define HX9023S_PROX_THRES_SHIFT_CFG0          0xA8
> +#define HX9023S_PROX_THRES_SHIFT_CFG1          0xA9
> +#define HX9023S_PROX_THRES_SHIFT_CFG2          0xAA
> +#define HX9023S_PROX_THRES_SHIFT_CFG3          0xAB
> +#define HX9023S_PROX_THRES_SHIFT_CFG4          0xAC
> +#define HX9023S_CH10_SCAN_FACTOR               0xC0
> +#define HX9023S_CH32_SCAN_FACTOR               0xC1
> +#define HX9023S_CH10_DOZE_FACTOR               0xC4
> +#define HX9023S_CH32_DOZE_FACTOR               0xC5
> +#define HX9023S_CH4_FACTOR_CTRL                0xC7
> +#define HX9023S_DSP_CONFIG_CTRL1               0xC8
> +#define HX9023S_DSP_CONFIG_CTRL2               0xC9
> +#define HX9023S_DSP_CONFIG_CTRL3               0xCA
> +#define HX9023S_RAW_BL_CH0_0                   0xE8
> +#define HX9023S_RAW_BL_CH0_1                   0xE9
> +#define HX9023S_RAW_BL_CH0_2                   0xEA
> +#define HX9023S_RAW_BL_CH1_0                   0xEB
> +#define HX9023S_RAW_BL_CH1_1                   0xEC
> +#define HX9023S_RAW_BL_CH1_2                   0xED
> +#define HX9023S_RAW_BL_CH2_0                   0xEE
> +#define HX9023S_RAW_BL_CH2_1                   0xEF
> +#define HX9023S_RAW_BL_CH2_2                   0xF0
> +#define HX9023S_RAW_BL_CH3_0                   0xF1
> +#define HX9023S_RAW_BL_CH3_1                   0xF2
> +#define HX9023S_RAW_BL_CH3_2                   0xF3
> +#define HX9023S_RAW_BL_CH4_0                   0xB5
> +#define HX9023S_RAW_BL_CH4_1                   0xB6
> +#define HX9023S_RAW_BL_CH4_2                   0xB7
> +#define HX9023S_LP_DIFF_CH0_0                  0xF4
> +#define HX9023S_LP_DIFF_CH0_1                  0xF5

Don't bother with defines for register addresses you don't
directly use.  If future changes need them, then defines
can be added at that point.

> +#define HX9023S_LP_DIFF_CH0_2                  0xF6
> +#define HX9023S_LP_DIFF_CH1_0                  0xF7
> +#define HX9023S_LP_DIFF_CH1_1                  0xF8
> +#define HX9023S_LP_DIFF_CH1_2                  0xF9
> +#define HX9023S_LP_DIFF_CH2_0                  0xFA
> +#define HX9023S_LP_DIFF_CH2_1                  0xFB
> +#define HX9023S_LP_DIFF_CH2_2                  0xFC
> +#define HX9023S_LP_DIFF_CH3_0                  0xFD
> +#define HX9023S_LP_DIFF_CH3_1                  0xFE
> +#define HX9023S_LP_DIFF_CH3_2                  0xFF
> +#define HX9023S_LP_DIFF_CH4_0                  0xB8
> +#define HX9023S_LP_DIFF_CH4_1                  0xB9
> +#define HX9023S_LP_DIFF_CH4_2                  0xBA
> +
> +#define HX9023S_DATA_LOCK_MASK BIT(4)
> +#define HX9023S_INTERRUPT_MASK GENMASK(9, 0)
> +#define HX9023S_PROX_DEBOUNCE_MASK GENMASK(3, 0)
> +
> +struct hx9023s_threshold {
> +	int near;
> +	int far;
> +};
> +
> +struct hx9023s_addr_val_pair {
> +	uint8_t addr;
> +	uint8_t val;
> +};
> +
> +struct hx9023s_channel_info {
> +	bool enabled;
> +	bool used;
> +	int state;
> +};
> +

const?

> +static struct hx9023s_addr_val_pair hx9023s_reg_init_list[] = {
> +	{ HX9023S_CH_NUM_CFG,                 0x00 },
> +	{ HX9023S_GLOBAL_CTRL0,               0x00 },
> +	{ HX9023S_GLOBAL_CTRL2,               0x00 },
> +
> +	{ HX9023S_PRF_CFG,                    0x17 },
> +	{ HX9023S_RANGE_7_0,                  0x11 },
> +	{ HX9023S_RANGE_9_8,                  0x02 },
> +	{ HX9023S_RANGE_18_16,                0x00 },
> +
> +	{ HX9023S_AVG0_NOSR0_CFG,             0x71 },
> +	{ HX9023S_NOSR12_CFG,                 0x44 },
> +	{ HX9023S_NOSR34_CFG,                 0x00 },
> +	{ HX9023S_AVG12_CFG,                  0x33 },
> +	{ HX9023S_AVG34_CFG,                  0x00 },
> +
> +	{ HX9023S_SAMPLE_NUM_7_0,             0x65 },
> +	{ HX9023S_INTEGRATION_NUM_7_0,        0x65 },
> +
> +	{ HX9023S_LP_ALP_1_0_CFG,             0x22 },
> +	{ HX9023S_LP_ALP_3_2_CFG,             0x22 },
> +	{ HX9023S_LP_ALP_4_CFG,               0x02 },
> +	{ HX9023S_UP_ALP_1_0_CFG,             0x88 },
> +	{ HX9023S_UP_ALP_3_2_CFG,             0x88 },
> +	{ HX9023S_DN_UP_ALP_0_4_CFG,          0x18 },
> +	{ HX9023S_DN_ALP_2_1_CFG,             0x11 },
> +	{ HX9023S_DN_ALP_4_3_CFG,             0x11 },
> +
> +	{ HX9023S_RAW_BL_RD_CFG,              0xF0 },
> +	{ HX9023S_INTERRUPT_CFG,              0xFF },
> +	{ HX9023S_INTERRUPT_CFG1,             0x3B },
> +	{ HX9023S_CALI_DIFF_CFG,              0x07 },
> +	{ HX9023S_DITHER_CFG,                 0x21 },
> +	{ HX9023S_PROX_INT_HIGH_CFG,          0x01 },
> +	{ HX9023S_PROX_INT_LOW_CFG,           0x01 },
> +
> +	{ HX9023S_PROX_HIGH_DIFF_CFG_CH0_0,   0x0A },
> +	{ HX9023S_PROX_HIGH_DIFF_CFG_CH0_1,   0x00 },
> +	{ HX9023S_PROX_HIGH_DIFF_CFG_CH1_0,   0x0A },
> +	{ HX9023S_PROX_HIGH_DIFF_CFG_CH1_1,   0x00 },
> +	{ HX9023S_PROX_HIGH_DIFF_CFG_CH2_0,   0x0A },
> +	{ HX9023S_PROX_HIGH_DIFF_CFG_CH2_1,   0x00 },
> +	{ HX9023S_PROX_HIGH_DIFF_CFG_CH3_0,   0x0A },
> +	{ HX9023S_PROX_HIGH_DIFF_CFG_CH3_1,   0x00 },
> +	{ HX9023S_PROX_HIGH_DIFF_CFG_CH4_0,   0x0A },
> +	{ HX9023S_PROX_HIGH_DIFF_CFG_CH4_1,   0x00 },
> +	{ HX9023S_PROX_LOW_DIFF_CFG_CH0_0,    0x08 },
> +	{ HX9023S_PROX_LOW_DIFF_CFG_CH0_1,    0x00 },
> +	{ HX9023S_PROX_LOW_DIFF_CFG_CH1_0,    0x08 },
> +	{ HX9023S_PROX_LOW_DIFF_CFG_CH1_1,    0x00 },
> +	{ HX9023S_PROX_LOW_DIFF_CFG_CH2_0,    0x08 },
> +	{ HX9023S_PROX_LOW_DIFF_CFG_CH2_1,    0x00 },
> +	{ HX9023S_PROX_LOW_DIFF_CFG_CH3_0,    0x08 },
> +	{ HX9023S_PROX_LOW_DIFF_CFG_CH3_1,    0x00 },
> +	{ HX9023S_PROX_LOW_DIFF_CFG_CH4_0,    0x08 },
> +	{ HX9023S_PROX_LOW_DIFF_CFG_CH4_1,    0x00 },
> +
> +	{ HX9023S_PROX_THRES_SHIFT_CFG0,      0x00 },
> +	{ HX9023S_PROX_THRES_SHIFT_CFG1,      0x00 },
> +	{ HX9023S_PROX_THRES_SHIFT_CFG2,      0x00 },
> +	{ HX9023S_PROX_THRES_SHIFT_CFG3,      0x00 },
> +	{ HX9023S_PROX_THRES_SHIFT_CFG4,      0x00 },
> +
> +	{ HX9023S_CH10_SCAN_FACTOR,           0x00 },
> +	{ HX9023S_CH32_SCAN_FACTOR,           0x00 },
> +	{ HX9023S_CH10_DOZE_FACTOR,           0x00 },
> +	{ HX9023S_CH32_DOZE_FACTOR,           0x00 },
> +	{ HX9023S_CH4_FACTOR_CTRL,            0x00 },
> +	{ HX9023S_DSP_CONFIG_CTRL1,           0x00 },
> +	{ HX9023S_DSP_CONFIG_CTRL3,           0x00 },
> +};
> +
> +struct hx9023s_data {
> +	struct mutex mutex;
> +	struct i2c_client *client;
> +	struct iio_trigger *trig;
> +	struct regmap *regmap;
> +	unsigned long chan_prox_stat;
> +	bool trigger_enabled;
> +	struct {
> +		__be16 channels[HX9023S_CH_NUM];
> +
Drop this blank line.
> +		s64 ts __aligned(8);
> +
and this one.
> +	} buffer;
but add one here and before the struct.

> +	unsigned long chan_read;
> +	unsigned long chan_event;
> +
> +	struct hx9023s_threshold thres[HX9023S_CH_NUM];
> +	struct hx9023s_channel_info *chs_info;
> +	unsigned long ch_en_stat;
> +	unsigned int prox_state_reg;
> +	unsigned int accuracy;
> +	unsigned long channel_used_flag;
> +	unsigned int cs_position[HX9023S_CH_NUM];
> +	unsigned int channel_positive[HX9023S_CH_NUM];
> +	unsigned int channel_negative[HX9023S_CH_NUM];
> +	int raw[HX9023S_CH_NUM];
> +	int lp[HX9023S_CH_NUM]; /*low pass*/

Call it low_pass[] and base_line[] etc so
no need for the comments.

> +	int bl[HX9023S_CH_NUM]; /*base line*/
> +	int diff[HX9023S_CH_NUM]; /*lp - bl*/

If those docs mean this is just the difference of previous
two parameter then don't store this - compute it when needed.
If it is something else then the docs are misleading currently.

> +	uint16_t dac[HX9023S_CH_NUM];
> +	bool sel_bl[HX9023S_CH_NUM];
> +	bool sel_raw[HX9023S_CH_NUM];
> +	bool sel_diff[HX9023S_CH_NUM];
> +	bool sel_lp[HX9023S_CH_NUM];
> +	unsigned int odr;
> +	unsigned int integration_sample;
> +	unsigned int osr[HX9023S_CH_NUM];
> +	unsigned int avg[HX9023S_CH_NUM];
> +	unsigned int lp_alpha[HX9023S_CH_NUM];

I would group the per channel data and consider a structure for that

> +};


> +
> +static int hx9023s_interrupt_en(struct hx9023s_data *data, bool en)
Given the two code paths are totally different, just have two function
hx9023s_interrupt_enable() and hx9023s_interrupt_disable()

> +{
> +	int ret;
> +
> +	if (en) {
> +		ret = regmap_update_bits(data->regmap, HX9023S_INTERRUPT_CFG,
> +					HX9023S_INTERRUPT_MASK, HX9023S_INTERRUPT_MASK);
> +		if (ret < 0) {
> +			dev_err(&data->client->dev, "i2c read failed\n");
> +			return ret;
> +		}
> +	} else {
> +		ret = regmap_update_bits(data->regmap, HX9023S_INTERRUPT_CFG,
> +					HX9023S_INTERRUPT_MASK, 0x00);
> +		if (ret < 0) {
> +			dev_err(&data->client->dev, "i2c read failed\n");
> +			return ret;
> +		}
> +	}
> +
> +	return ret;
> +}
> +
> +static int hx9023s_data_lock(struct hx9023s_data *data, bool locked)
> +{
> +	int ret;
> +
> +	if (locked) {
> +		ret = regmap_update_bits(data->regmap, HX9023S_DSP_CONFIG_CTRL1,
> +					HX9023S_DATA_LOCK_MASK, HX9023S_DATA_LOCK_MASK);

Seems odd to set one bit but clear two? Perhaps this should be setting one of bits 3-4?

> +		if (ret < 0) {
> +			dev_err(&data->client->dev, "i2c read failed\n");
> +			return ret;
> +		}
> +	} else {
> +		ret = regmap_update_bits(data->regmap, HX9023S_DSP_CONFIG_CTRL1,
> +					GENMASK(4, 3), 0x00);
> +		if (ret < 0) {
> +			dev_err(&data->client->dev, "i2c read failed\n");
> +			return ret;
> +		}
> +	}
> +
> +	return ret;
> +}
> +
> +static int hx9023s_get_id(struct hx9023s_data *data)
> +{
> +	int ret;
> +	unsigned int rxbuf[1];
> +
> +	ret = regmap_read(data->regmap, HX9023S_DEVICE_ID, rxbuf);

This wrapper seems unnecessary just do the read directly at the callsite.
It is pretty self documenting given the register name.

> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "i2c read failed\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int hx9023s_para_cfg(struct hx9023s_data *data)
> +{
> +	int ret;
> +	uint8_t buf[3];
> +
> +	ret = regmap_bulk_write(data->regmap, HX9023S_PRF_CFG, &data->odr, 1);
> +	if (ret) {
> +		dev_err(&data->client->dev, "i2c write failed\n");
> +		return ret;
> +	}
> +
> +	buf[0] = data->integration_sample & 0xFF;
> +	buf[1] = data->integration_sample >> 8;

That's an unaligned_put_le16() I think.

> +	ret = regmap_bulk_write(data->regmap, HX9023S_SAMPLE_NUM_7_0, buf, 2);
> +	if (ret) {
> +		dev_err(&data->client->dev, "i2c write failed\n");
> +		return ret;
> +	}
> +
> +	ret = regmap_bulk_write(data->regmap, HX9023S_INTEGRATION_NUM_7_0, buf, 2);
> +	if (ret) {
> +		dev_err(&data->client->dev, "i2c write failed\n");
> +		return ret;
> +	}
> +
> +	buf[0] = (data->avg[2] << 4) | data->avg[1];
> +	buf[1] = (data->avg[4] << 4) | data->avg[3];
> +	ret = regmap_bulk_write(data->regmap, HX9023S_AVG12_CFG, buf, 2);
> +	if (ret) {
> +		dev_err(&data->client->dev, "i2c write failed\n");
> +		return ret;
> +	}
> +
> +	buf[0] = (data->osr[2] << 4) | data->osr[1];
> +	buf[1] = (data->osr[4] << 4) | data->osr[3];
> +	ret = regmap_bulk_write(data->regmap, HX9023S_NOSR12_CFG, buf, 2);
> +	if (ret) {
> +		dev_err(&data->client->dev, "i2c write failed\n");
> +		return ret;
> +	}
> +
> +	ret = regmap_update_bits(data->regmap, HX9023S_AVG0_NOSR0_CFG, GENMASK(7, 2),
> +				((data->avg[0] << 5) | (data->osr[0] << 2)));
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "i2c read failed\n");
> +		return ret;
> +	}
> +
> +	buf[0] = data->lp_alpha[4];
> +	buf[1] = (data->lp_alpha[1] << 4) | data->lp_alpha[0];

Probably a place where FIELD_PREP() with appropriately defined masks
will be more readable by making it explicit that these don't overlap.


> +	buf[2] = (data->lp_alpha[3] << 4) | data->lp_alpha[2];
> +	ret = regmap_bulk_write(data->regmap, HX9023S_LP_ALP_4_CFG, buf, 3);
> +	if (ret) {
> +		dev_err(&data->client->dev, "i2c write failed\n");
> +		return ret;
drop this or return 0 below.

> +	}
> +
> +	return ret;
> +}
> +
> +static int hx9023s_ch_cfg(struct hx9023s_data *data)
> +{
> +	int ret;
> +	int i;
> +	uint16_t reg;
> +	uint8_t reg_list[HX9023S_CH_NUM * 2];
> +	uint8_t ch_pos[HX9023S_CH_NUM];
> +	uint8_t ch_neg[HX9023S_CH_NUM];
> +
> +	for (i = 0; i < HX9023S_CH_NUM; i++) {
> +		if (data->channel_positive[i] == 255)
> +			ch_pos[i] = 16;
> +		else
> +			ch_pos[i] = data->cs_position[data->channel_positive[i]];
> +		if (data->channel_negative[i] == 255)
> +			ch_neg[i] = 16;
> +		else
> +			ch_neg[i] = data->cs_position[data->channel_negative[i]];
> +	}
> +
> +	for (i = 0; i < HX9023S_CH_NUM; i++) {
> +		reg = (uint16_t)((0x03 << ch_pos[i]) | (0x02 << ch_neg[i]));
> +		reg_list[i * 2] = (uint8_t)(reg);
> +		reg_list[i * 2 + 1] = (uint8_t)(reg >> 8);

looks like an opencoded unaligned put

> +	}
> +
> +	ret = regmap_bulk_write(data->regmap, HX9023S_CH0_CFG_7_0, reg_list, HX9023S_CH_NUM * 2);
> +	if (ret)
> +		dev_err(&data->client->dev, "i2c write failed\n");
> +
> +	return ret;
> +}

> +static int hx9023s_sample(struct hx9023s_data *data)
> +{
> +	int ret;
> +	int i;
> +	uint8_t data_size;
> +	uint8_t offset_data_size;
> +	int value;
> +	uint8_t rx_buf[HX9023S_CH_NUM * CH_DATA_BYTES_MAX];
> +
> +	hx9023s_data_lock(data, true);
> +	hx9023s_data_select(data);
> +
> +	data_size = CH_DATA_3BYTES;
> +
> +	/*ch0~ch3*/

	/* ch0-ch3 */
type formatting preferred.

> +	ret = regmap_bulk_read(data->regmap, HX9023S_RAW_BL_CH0_0, rx_buf,
> +				(HX9023S_CH_NUM * data_size) - data_size);
> +	if (ret) {
> +		dev_err(&data->client->dev, "i2c read failed\n");
> +		return ret;
> +	}
> +
> +	/*ch4*/
> +	ret = regmap_bulk_read(data->regmap, HX9023S_RAW_BL_CH4_0,
> +				rx_buf + ((HX9023S_CH_NUM * data_size) - data_size), data_size);
> +	if (ret) {
> +		dev_err(&data->client->dev, "i2c read failed\n");
> +		return ret;
> +	}
> +
> +	for (i = 0; i < HX9023S_CH_NUM; i++) {
> +		if (data->accuracy == 16) {
> +			value = get_unaligned_le16(&rx_buf[i * data_size + 1]);
> +			value = sign_extend32(value, 15);
> +		} else {
> +			value = get_unaligned_le24(&rx_buf[i * data_size]);
> +			value = sign_extend32(value, 23);
> +		}
> +		data->raw[i] = 0;
> +		data->bl[i] = 0;
> +		if (true == data->sel_raw[i])
> +			data->raw[i] = value;
> +		if (true == data->sel_bl[i])
> +			data->bl[i] = value;
> +	}
> +
> +	/*ch0~ch3*/
> +	ret = regmap_bulk_read(data->regmap, HX9023S_LP_DIFF_CH0_0, rx_buf,
> +				(HX9023S_CH_NUM * data_size) - data_size);
> +	if (ret) {
> +		dev_err(&data->client->dev, "i2c read failed\n");
> +		return ret;
> +	}
> +
> +	/*ch4*/
> +	ret = regmap_bulk_read(data->regmap, HX9023S_LP_DIFF_CH4_0,
> +				rx_buf + ((HX9023S_CH_NUM * data_size) - data_size), data_size);
> +	if (ret) {
> +		dev_err(&data->client->dev, "i2c read failed\n");
> +		return ret;
> +	}
> +
> +	for (i = 0; i < HX9023S_CH_NUM; i++) {
> +		if (data->accuracy == 16) {
> +			value = get_unaligned_le16(&rx_buf[i * data_size + 1]);
> +			value = sign_extend32(value, 15);
> +		} else {
> +			value = get_unaligned_le24(&rx_buf[i * data_size]);
> +			value = sign_extend32(value, 23);
> +		}
> +		data->lp[i] = 0;
> +		data->diff[i] = 0;
> +		if (true == data->sel_lp[i])
> +			data->lp[i] = value;
> +		if (true == data->sel_diff[i])
> +			data->diff[i] = value;
> +	}
> +
> +	for (i = 0; i < HX9023S_CH_NUM; i++) {
> +		if (true == data->sel_lp[i] && true == data->sel_bl[i])
> +			data->diff[i] = data->lp[i] - data->bl[i];
> +	}
> +
> +	/*offset dac*/
> +	offset_data_size = CH_DATA_2BYTES;
> +	ret = regmap_bulk_read(data->regmap, HX9023S_OFFSET_DAC0_7_0, rx_buf,
> +				(HX9023S_CH_NUM * offset_data_size));
> +	if (ret) {
> +		dev_err(&data->client->dev, "i2c read failed\n");
> +		return ret;
> +	}
> +
> +	for (i = 0; i < HX9023S_CH_NUM; i++) {
> +		value = get_unaligned_le16(&rx_buf[i * offset_data_size]);
> +		value = value & 0xFFF;

Use GENMASK for that 0xFFF and similar masks.

> +		data->dac[i] = value;
> +	}
> +
> +	hx9023s_data_lock(data, false);
> +	return ret;
> +}

> +}
> +
> +static int hx9023s_ch_en_hal(struct hx9023s_data *data, uint8_t ch_id, bool en)
> +{
> +	int ret;
> +
> +	guard(mutex)(&data->mutex);
> +	if (en) {
> +		ret = hx9023s_ch_en(data, ch_id, en);
These two legs are very similar.  Can you combine them?
Looks like all you need is to use en for the lone line that differs.

	data->chs_info[ch_id].enabled = en;
> +		if (ret) {
> +			dev_err(&data->client->dev, "channel enable failed\n");
> +			return ret;
> +		}
> +		data->chs_info[ch_id].state = 0;
> +		data->chs_info[ch_id].enabled = true;
> +	} else {
> +		ret = hx9023s_ch_en(data, ch_id, en);
> +		if (ret) {
> +			dev_err(&data->client->dev, "channel enable failed\n");
> +			return ret;
> +		}
> +		data->chs_info[ch_id].state = 0;
> +		data->chs_info[ch_id].enabled = false;
> +	}
> +
> +	return 0;
> +}
> +
> +static int hx9023s_dts_phase(struct hx9023s_data *data)
> +{
> +	int ret;
> +	struct device_node *np = data->client->dev.of_node;
> +	unsigned int channel_used_flag;
> +
> +	ret = of_property_read_u32(np, "odr", &data->odr);

Use generic firmware parsing from property.h throughout not this of_ only
version.
Also rename function to hx9023s_firmware_parse() or similar to reflect that
it will be more general than currently.


> +	if (ret) {
return dev_err_probe() for all of these.

> +		dev_err(&data->client->dev, "Failed to read odr property\n");
> +		return ret;
> +	}
> +
> +	ret = of_property_read_u32(np, "integration-sample", &data->integration_sample);
> +	if (ret) {
> +		dev_err(&data->client->dev, "Failed to read integration_sample property\n");
> +		return ret;
> +	}
> +
> +	ret = of_property_read_u32_array(np, "osr", data->osr, HX9023S_CH_NUM);
> +	if (ret) {
> +		dev_err(&data->client->dev, "Failed to read osr property\n");
> +		return ret;
> +	}
> +
> +	ret = of_property_read_u32_array(np, "avg", data->avg, HX9023S_CH_NUM);
> +	if (ret) {
> +		dev_err(&data->client->dev, "Failed to read avg property\n");
> +		return ret;
> +	}
> +
> +	ret = of_property_read_u32_array(np, "lp-alpha", data->lp_alpha, HX9023S_CH_NUM);
> +	if (ret) {
> +		dev_err(&data->client->dev, "Failed to read lp_alpha property\n");
> +		return ret;
> +	}
> +
> +	ret = of_property_read_u32(np, "accuracy", &data->accuracy);
> +	if (ret) {
> +		dev_err(&data->client->dev, "Failed to read accuracy property\n");
> +		return ret;
> +	}
> +
> +	ret = of_property_read_u32(np, "channel-used-flag", &channel_used_flag);
> +	if (ret) {
> +		dev_err(&data->client->dev, "Failed to read channel-used-flag property\n");
> +		return ret;
> +	}
> +	data->channel_used_flag = channel_used_flag;
> +
> +	ret = of_property_read_u32_array(np, "cs-position", data->cs_position, HX9023S_CH_NUM);
> +	if (ret) {
> +		dev_err(&data->client->dev, "Failed to read cs-position property\n");
> +		return ret;
> +	}
> +
> +	ret = of_property_read_u32_array(np, "channel-positive", data->channel_positive,
> +					HX9023S_CH_NUM);
> +	if (ret) {
> +		dev_err(&data->client->dev, "Failed to read channel-positive property\n");
> +		return ret;
> +	}
> +
> +	ret = of_property_read_u32_array(np, "channel-negative", data->channel_negative,
> +					HX9023S_CH_NUM);
> +	if (ret) {
> +		dev_err(&data->client->dev, "Failed to read channel-negative property\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
>
> +static int hx9023s_get_samp_freq(struct hx9023s_data *data, int *val, int *val2)
> +{
> +	int ret;
> +	unsigned int odr;
> +	unsigned int buf[1];

unsigned int buf and use &buf inline.

> +
> +	ret = regmap_read(data->regmap, HX9023S_PRF_CFG, buf);
> +	if (ret)
> +		dev_err(&data->client->dev, "i2c read failed\n");
> +
> +	odr = hx9023s_samp_freq_table[buf[0]];
> +	*val = 1000 / odr;
> +	*val2 = ((1000 % odr) * 1000000ULL) / odr;
> +
> +	return IIO_VAL_INT_PLUS_MICRO;
> +}

> +static irqreturn_t hx9023s_irq_handler(int irq, void *private)
> +{
> +	struct iio_dev *indio_dev = private;
> +	struct hx9023s_data *data = iio_priv(indio_dev);
> +
> +	if (data->trigger_enabled)
> +		iio_trigger_poll(data->trig);
> +
> +	return IRQ_WAKE_THREAD;

You could check if any events are enabled and only wake the thread if
there are some.

> +}
> +
> +static void hx9023s_push_events(struct iio_dev *indio_dev)
> +{
> +	struct hx9023s_data *data = iio_priv(indio_dev);
> +	s64 timestamp = iio_get_time_ns(indio_dev);
> +	unsigned long prox_changed;
> +	unsigned int chan;
> +
> +	hx9023s_sample(data);
> +	hx9023s_get_prox_state(data);
> +
> +	prox_changed = (data->chan_prox_stat ^ data->prox_state_reg) & data->chan_event;
> +
> +	for_each_set_bit(chan, &prox_changed, HX9023S_CH_NUM) {
> +		int dir;
> +
> +		dir = (data->prox_state_reg & BIT(chan)) ? IIO_EV_DIR_FALLING : IIO_EV_DIR_RISING;
> +
> +		iio_push_event(indio_dev,
> +			IIO_UNMOD_EVENT_CODE(IIO_PROXIMITY, chan, IIO_EV_TYPE_THRESH, dir),
> +			timestamp);
> +	}
> +	data->chan_prox_stat = data->prox_state_reg;
> +}


> +
> +static const struct iio_buffer_setup_ops hx9023s_buffer_setup_ops = {
> +	.preenable = hx9023s_buffer_preenable,
> +	.postdisable = hx9023s_buffer_postdisable,
> +};
> +
> +static int hx9023s_probe(struct i2c_client *client)
> +{
> +	int ret;
> +	int i;

	int ret, i;
is fine for variables of same t ype.

> +	struct device *dev = &client->dev;
> +	struct iio_dev *indio_dev;
> +	struct hx9023s_data *data;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(struct hx9023s_data));
> +	if (!indio_dev)
> +		return dev_err_probe(&client->dev, -ENOMEM, "device alloc failed\n");
> +
> +	data = iio_priv(indio_dev);
> +	data->client = client;
> +	mutex_init(&data->mutex);
> +
> +	ret = hx9023s_dts_phase(data);
> +	if (ret)
> +		return dev_err_probe(&data->client->dev, ret, "dts phase failed\n");
> +
> +	data->chs_info = devm_kzalloc(&data->client->dev,
> +				sizeof(struct hx9023s_channel_info) * HX9023S_CH_NUM, GFP_KERNEL);
sizeof(*data->chs_info) then we don't have to go look for the type.
devm_kcalloc() preferred as it is an array of structures.


> +	if (data->chs_info == NULL)

if (!data->chs_info) sufficient for null pointer check.

> +		return dev_err_probe(&data->client->dev, -ENOMEM, "channel info alloc failed\n");

		return dev_err_probe(dev, 
that is, use the local variable.

> +
> +	for (i = 0; i < HX9023S_CH_NUM; i++)
> +		if (test_bit(i, &data->channel_used_flag))
> +			data->chs_info[i].used = true;
> +
> +	data->regmap = devm_regmap_init_i2c(client, &hx9023s_regmap_config);
> +	if (IS_ERR(data->regmap)) {
> +		ret = PTR_ERR(data->regmap);

Put that inline in the dev_err_probe() parameters.

> +		return dev_err_probe(&data->client->dev, ret, "regmap init failed\n");
> +	}
> +
> +	ret = devm_regulator_get_enable(&data->client->dev, "vdd");
> +	if (ret)
> +		return dev_err_probe(&data->client->dev, ret, "regulator get failed\n");
> +
> +	usleep_range(1000, 1100);
> +
> +	ret = hx9023s_get_id(data);
> +	if (ret)
> +		return dev_err_probe(&data->client->dev, ret, "id check failed\n");
> +
> +	indio_dev->channels = hx9023s_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(hx9023s_channels);
> +	indio_dev->info = &hx9023s_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->name = "hx9023s";
> +	i2c_set_clientdata(client, indio_dev);
> +
> +	ret = hx9023s_reg_init(data);
> +	if (ret)
> +		return dev_err_probe(&data->client->dev, ret, "device init failed\n");
> +
> +	ret = hx9023s_ch_cfg(data);
> +	if (ret)
> +		return dev_err_probe(&data->client->dev, ret, "channel config failed\n");
> +
> +	ret = hx9023s_para_cfg(data);
> +	if (ret)
> +		return dev_err_probe(&data->client->dev, ret, "parameter config failed\n");
> +
> +	if (client->irq) {
> +		ret = devm_request_threaded_irq(dev, client->irq, hx9023s_irq_handler,
> +						hx9023s_irq_thread_handler, IRQF_ONESHOT,
> +						"hx9023s_event", indio_dev);
> +		if (ret)
> +			return dev_err_probe(&data->client->dev, ret, "irq request failed\n");
> +
> +		data->trig = devm_iio_trigger_alloc(dev, "%s-dev%d", indio_dev->name,
> +						iio_device_id(indio_dev));
> +		if (!data->trig)
> +			return dev_err_probe(&data->client->dev, -ENOMEM,
> +					"iio trigger alloc failed\n");
> +
> +		data->trig->ops = &hx9023s_trigger_ops;
> +		iio_trigger_set_drvdata(data->trig, indio_dev);
> +
> +		ret = devm_iio_trigger_register(dev, data->trig);
> +		if (ret)
> +			return dev_err_probe(&data->client->dev, ret,
> +					"iio trigger register failed\n");
> +	}
> +
> +	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, iio_pollfunc_store_time,
> +					hx9023s_trigger_handler, &hx9023s_buffer_setup_ops);
> +	if (ret)
> +		return dev_err_probe(&data->client->dev, ret,
> +				"iio triggered buffer setup failed\n");
> +
> +	ret = devm_iio_device_register(dev, indio_dev);
> +	if (ret)
> +		return dev_err_probe(&data->client->dev, ret, "iio device register failed\n");
> +
> +	return 0;
> +}

...


> +MODULE_DEVICE_TABLE(acpi, hx9023s_acpi_match);
> +
> +static const struct of_device_id hx9023s_of_match[] = {
> +	{ .compatible = "tyhx,hx9023s", (void *)HX9023S_CHIP_ID },

For now delete the data part. It is much better to bring that in
with a patch adding support for a second device.

If you are planning to add such support, this should be a pointer
to a device specific structure instance, not an ID value.

> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, hx9023s_of_match);
> +
> +static const struct i2c_device_id hx9023s_id[] = {
> +	{ .name = "hx9023s", .driver_data = HX9023S_CHIP_ID },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(i2c, hx9023s_id);
> +
> +static struct i2c_driver hx9023s_driver = {
> +	.driver = {
> +		.name = "hx9023s",
> +		.acpi_match_table = hx9023s_acpi_match,
> +		.of_match_table = hx9023s_of_match,
> +		.pm = &hx9023s_pm_ops,
> +		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
Add a comment on why. Typically it's because startup involves waiting
for some time.  It is useful to document that here because async probe
can cause problems and it is good to provide info to anyone considering
turning it on or off.

> +	},
> +	.probe = hx9023s_probe,
> +	.id_table = hx9023s_id,
> +};
> +module_i2c_driver(hx9023s_driver);
> +
> +MODULE_AUTHOR("Yasin Lee <yasin.lee.x@gmail.com>");
> +MODULE_DESCRIPTION("Driver for TYHX HX9023S SAR sensor");
> +MODULE_LICENSE("GPL");


