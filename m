Return-Path: <linux-iio+bounces-4924-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE188C2213
	for <lists+linux-iio@lfdr.de>; Fri, 10 May 2024 12:26:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70B411C20C1A
	for <lists+linux-iio@lfdr.de>; Fri, 10 May 2024 10:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF6A168AEC;
	Fri, 10 May 2024 10:26:50 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB91130E39
	for <linux-iio@vger.kernel.org>; Fri, 10 May 2024 10:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715336809; cv=none; b=XJncgk+GL7vfyxD13z8F8T027+KHjvkljRHaFop7MOgW+cUqqUJW38+HxtGC6LscJ7E5+OlCZWHPIrJ4er01BYz2egMOENeMWMv5UIOlqebH1A7eCjnB7ajteYGRgga/f+eVysf9Vl7B17+5zVxh6jzHmEhLehZidmC+IY9YO9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715336809; c=relaxed/simple;
	bh=fSIC0rdaNMcUO2D7/5z6/xnbxH3Vla7rKBxCjklOxCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Os6V9vHVLUuL9ewB2KvhK1YFDG3Dc8/TG8HJd7ML2GO5/futkGUbytYd+/HoV8KtrR0qCMyaZ+whuhLLMSUeerp2aw9pxsIez3fWRtZKvJMxwG7lVxlzybTWbvoNpOvbPFFqC3qG3uYvcyW0KveGSDe8GF5BqNhcoOrao02bcuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1s5NSY-0004uv-U2; Fri, 10 May 2024 12:26:38 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1s5NSX-000cDm-6W; Fri, 10 May 2024 12:26:37 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1s5NSX-001uvc-0L;
	Fri, 10 May 2024 12:26:37 +0200
Date: Fri, 10 May 2024 12:26:36 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Yasin Lee <yasin.lee.x@outlook.com>
Cc: jic23@kernel.org, lars@metafoo.de, swboyd@chromium.org, 
	nuno.a@analog.com, andy.shevchenko@gmail.com, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, yasin.lee.x@gmail.com
Subject: Re: [PATCH] iio:proximity:hx9031as: Add TYHX HX9031AS/HX9023S sensor
 driver
Message-ID: <2hcbvnykofspgrn47u56qfan767qiifkyf2agq76npg6lkvx3u@dwagb7j5jx3x>
References: <SN7PR12MB8101EDFA7F91A59761095A28A4E72@SN7PR12MB8101.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dxs6cnfvpdosjuek"
Content-Disposition: inline
In-Reply-To: <SN7PR12MB8101EDFA7F91A59761095A28A4E72@SN7PR12MB8101.namprd12.prod.outlook.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org


--dxs6cnfvpdosjuek
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

there are quite some checkpatch warnings that trigger for your patch:

	$ curl -s https://lore.kernel.org/all/SN7PR12MB8101EDFA7F91A59761095A28A4E=
72@SN7PR12MB8101.namprd12.prod.outlook.com/raw | scripts/checkpatch.pl  -
	...
	total: 1 errors, 95 warnings, 2179 lines checked

Mostly line length and spelling mistakes.

A few more notes in the quote below:=20

On Fri, May 10, 2024 at 05:37:32PM +0800, Yasin Lee wrote:
> diff --git a/drivers/iio/proximity/Makefile b/drivers/iio/proximity/Makef=
ile
> index f36598380446..cf020d74f761 100644
> --- a/drivers/iio/proximity/Makefile
> +++ b/drivers/iio/proximity/Makefile
> @@ -21,4 +21,5 @@ obj-$(CONFIG_SX_COMMON) 	+=3D sx_common.o
>  obj-$(CONFIG_SX9500)		+=3D sx9500.o
>  obj-$(CONFIG_VCNL3020)		+=3D vcnl3020.o
>  obj-$(CONFIG_VL53L0X_I2C)	+=3D vl53l0x-i2c.o
> +obj-$(CONFIG_HX9031AS)		+=3D hx9031as.o
> =20
> diff --git a/drivers/iio/proximity/hx9031as.c b/drivers/iio/proximity/hx9=
031as.c
> new file mode 100644
> index 000000000000..fa129e19452d
> --- /dev/null
> +++ b/drivers/iio/proximity/hx9031as.c
> @@ -0,0 +1,2142 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2024 NanjingTianyihexin Electronics Ltd.
> + * http://www.tianyihexin.com
> + *
> + * Driver for NanjingTianyihexin HX9031AS & HX9023S Cap Sensor
> + * Author: Yasin Lee <yasin.lee.x@gmail.com>
> + *

This line can/should be dropped.

> + */
> +
> +#include <linux/module.h>
> +#include <linux/i2c.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/interrupt.h>
> +#include <linux/version.h>
> +#include <linux/of.h>
> +#include <linux/of_gpio.h>
> +#include <linux/irq.h>
> +#include <linux/acpi.h>
> +#include <linux/bitfield.h>
> +#include <linux/kernel.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/pm.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/slab.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/events.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/triggered_buffer.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/debugfs.h>
> +
> +#define HX9031AS_DRIVER_VER "iio-1.0"
> +#define ENTER \
> +dev_info(hx9031as_pdata.pdev, "[%04d][%s]\n", __LINE__, __func__)
> +#define PRINT_DBG(format, x...) \
> +dev_info(hx9031as_pdata.pdev, "[%04d][%s] " format, __LINE__, __func__, =
## x)
> +#define PRINT_INF(format, x...) \
> +dev_info(hx9031as_pdata.pdev, "[%04d][%s] " format, __LINE__, __func__, =
## x)
> +#define PRINT_ERR(format, x...) \
> +dev_err(hx9031as_pdata.pdev, "[%04d][%s] " format, __LINE__, __func__, #=
# x)

I personally find those disturbing. Not only is dev_info too verbose
(use dev_dbg), but also the call sides looks strange and add a burden to
the reader.

> +
> +#define HX9031AS_TEST_CHS_EN 0             //test

test? Don't use C++ style comments.

> +#define HX9023S_ON_BOARD 0
> +#define HX9031AS_ON_BOARD 1
> +#define HX9031AS_DRIVER_NAME "hx9031as"    //i2c addr: HX9031AS=3D0x28
> +#define HX9031AS_CHIP_ID 0x1D
> +#define HX9031AS_CH_NUM 5
> +#define HX9031AS_CH_USED 0x1F
> +#define HX9031AS_DATA_LOCK 1
> +#define HX9031AS_DATA_UNLOCK 0
> +#define CH_DATA_2BYTES 2
> +#define CH_DATA_3BYTES 3
> +#define CH_DATA_BYTES_MAX CH_DATA_3BYTES
> +#define HX9031AS_ODR_MS 200
> +#define TYHX_DELAY_MS(x) msleep(x)
> +#define BUF_SIZE 512
> +
> +#define RW_00_GLOBAL_CTRL0                   0x00
> +#define RW_01_GLOBAL_CTRL1                   0x01
> +#define RW_02_PRF_CFG                        0x02
> +#define RW_03_CH0_CFG_7_0                    0x03
> +#define RW_04_CH0_CFG_9_8                    0x04
> +#define RW_05_CH1_CFG_7_0                    0x05
> +#define RW_06_CH1_CFG_9_8                    0x06
> +#define RW_07_CH2_CFG_7_0                    0x07
> +#define RW_08_CH2_CFG_9_8                    0x08
> +#define RW_09_CH3_CFG_7_0                    0x09
> +#define RW_0A_CH3_CFG_9_8                    0x0A
> +#define RW_0B_CH4_CFG_7_0                    0x0B
> +#define RW_0C_CH4_CFG_9_8                    0x0C
> +#define RW_0D_RANGE_7_0                      0x0D
> +#define RW_0E_RANGE_9_8                      0x0E
> +#define RW_0F_RANGE_18_16                    0x0F
> +#define RW_10_AVG0_NOSR0_CFG                 0x10
> +#define RW_11_NOSR12_CFG                     0x11
> +#define RW_12_NOSR34_CFG                     0x12
> +#define RW_13_AVG12_CFG                      0x13
> +#define RW_14_AVG34_CFG                      0x14
> +#define RW_15_OFFSET_DAC0_7_0                0x15
> +#define RW_16_OFFSET_DAC0_9_8                0x16
> +#define RW_17_OFFSET_DAC1_7_0                0x17
> +#define RW_18_OFFSET_DAC1_9_8                0x18
> +#define RW_19_OFFSET_DAC2_7_0                0x19
> +#define RW_1A_OFFSET_DAC2_9_8                0x1A
> +#define RW_1B_OFFSET_DAC3_7_0                0x1B
> +#define RW_1C_OFFSET_DAC3_9_8                0x1C
> +#define RW_1D_OFFSET_DAC4_7_0                0x1D
> +#define RW_1E_OFFSET_DAC4_9_8                0x1E
> +#define RW_1F_SAMPLE_NUM_7_0                 0x1F
> +#define RW_20_SAMPLE_NUM_9_8                 0x20
> +#define RW_21_INTEGRATION_NUM_7_0            0x21
> +#define RW_22_INTEGRATION_NUM_9_8            0x22
> +#define RW_23_GLOBAL_CTRL2                   0x23
> +#define RW_24_CH_NUM_CFG                     0x24
> +#define RW_25_DAC_SWAP_CFG                   0x25
> +#define RW_28_MOD_RST_CFG                    0x28
> +#define RW_29_LP_ALP_4_CFG                   0x29
> +#define RW_2A_LP_ALP_1_0_CFG                 0x2A
> +#define RW_2B_LP_ALP_3_2_CFG                 0x2B
> +#define RW_2C_UP_ALP_1_0_CFG                 0x2C
> +#define RW_2D_UP_ALP_3_2_CFG                 0x2D
> +#define RW_2E_DN_UP_ALP_0_4_CFG              0x2E
> +#define RW_2F_DN_ALP_2_1_CFG                 0x2F
> +#define RW_30_DN_ALP_4_3_CFG                 0x30
> +#define RW_31_INT_CAP_CFG                    0x31
> +#define RW_33_NDL_DLY_4_CFG                  0x33
> +#define RW_35_FORCE_NO_UP_CFG                0x35
> +#define RW_38_RAW_BL_RD_CFG                  0x38
> +#define RW_39_INTERRUPT_CFG                  0x39
> +#define RW_3A_INTERRUPT_CFG1                 0x3A
> +#define RW_3B_CALI_DIFF_CFG                  0x3B
> +#define RW_3C_DITHER_CFG                     0x3C
> +#define RW_40_ANALOG_MEM0_WRDATA_7_0         0x40
> +#define RW_41_ANALOG_MEM0_WRDATA_15_8        0x41
> +#define RW_42_ANALOG_MEM0_WRDATA_23_16       0x42
> +#define RW_43_ANALOG_MEM0_WRDATA_31_24       0x43
> +#define RW_48_ANALOG_PWE_PULSE_CYCLE7_0      0x48
> +#define RW_49_ANALOG_PWE_PULSE_CYCLE12_8     0x49
> +#define RW_4A_ANALOG_MEM_GLOBAL_CTRL         0x4A
> +#define RO_4B_DEBUG_MEM_ADC_FSM              0x4B
> +#define RW_4C_ANALOG_MEM_GLOBAL_CTRL1        0x4C
> +#define RO_5F_VERION_ID                      0x5F
> +#define RO_60_DEVICE_ID                      0x60
> +#define RO_61_TC_FSM                         0x61
> +#define RO_66_FLAG_RD                        0x66
> +#define RO_6A_CONV_TIMEOUT_CNT               0x6A
> +#define RO_6B_PROX_STATUS                    0x6B
> +#define RW_6C_PROX_INT_HIGH_CFG              0x6C
> +#define RW_6D_PROX_INT_LOW_CFG               0x6D
> +#define RW_6E_CAP_INI_CFG                    0x6E
> +#define RW_6F_INT_WIDTH_CFG0                 0x6F
> +#define RW_70_INT_WIDTH_CFG1                 0x70
> +#define RO_71_INT_STATE_RD0                  0x71
> +#define RO_72_INT_STATE_RD1                  0x72
> +#define RO_73_INT_STATE_RD2                  0x73
> +#define RO_74_INT_STATE_RD3                  0x74
> +#define RW_80_PROX_HIGH_DIFF_CFG_CH0_0       0x80
> +#define RW_81_PROX_HIGH_DIFF_CFG_CH0_1       0x81
> +#define RW_82_PROX_HIGH_DIFF_CFG_CH1_0       0x82
> +#define RW_83_PROX_HIGH_DIFF_CFG_CH1_1       0x83
> +#define RW_84_PROX_HIGH_DIFF_CFG_CH2_0       0x84
> +#define RW_85_PROX_HIGH_DIFF_CFG_CH2_1       0x85
> +#define RW_86_PROX_HIGH_DIFF_CFG_CH3_0       0x86
> +#define RW_87_PROX_HIGH_DIFF_CFG_CH3_1       0x87
> +#define RW_88_PROX_LOW_DIFF_CFG_CH0_0        0x88
> +#define RW_89_PROX_LOW_DIFF_CFG_CH0_1        0x89
> +#define RW_8A_PROX_LOW_DIFF_CFG_CH1_0        0x8A
> +#define RW_8B_PROX_LOW_DIFF_CFG_CH1_1        0x8B
> +#define RW_8C_PROX_LOW_DIFF_CFG_CH2_0        0x8C
> +#define RW_8D_PROX_LOW_DIFF_CFG_CH2_1        0x8D
> +#define RW_8E_PROX_LOW_DIFF_CFG_CH3_0        0x8E
> +#define RW_8F_PROX_LOW_DIFF_CFG_CH3_1        0x8F
> +#define RW_9E_PROX_HIGH_DIFF_CFG_CH4_0       0x9E
> +#define RW_9F_PROX_HIGH_DIFF_CFG_CH4_1       0x9F
> +#define RW_A2_PROX_LOW_DIFF_CFG_CH4_0        0xA2
> +#define RW_A3_PROX_LOW_DIFF_CFG_CH4_1        0xA3
> +#define RW_91_DSP_CONFIG_CTRL4               0x91
> +#define RW_93_DSP_CONFIG_CTRL6               0x93
> +#define RW_94_DSP_CONFIG_CTRL7               0x94
> +#define RW_95_DSP_CONFIG_CTRL8               0x95
> +#define RW_96_DSP_CONFIG_CTRL9               0x96
> +#define RW_97_DSP_CONFIG_CTRL10              0x97
> +#define RW_98_DSP_CONFIG_CTRL11              0x98
> +#define RW_A0_LP_OUT_DELTA_THRES_CH1_CFG0    0xA0
> +#define RW_A1_LP_OUT_DELTA_THRES_CH1_CFG1    0xA1
> +#define RW_A4_LP_OUT_DELTA_THRES_CH3_CFG0    0xA4
> +#define RW_A5_LP_OUT_DELTA_THRES_CH3_CFG1    0xA5
> +#define RW_A6_LP_OUT_DELTA_THRES_CH4_CFG0    0xA6
> +#define RW_A7_LP_OUT_DELTA_THRES_CH4_CFG1    0xA7
> +#define RW_A8_PROX_THRES_SHIFT_CFG0          0xA8
> +#define RW_A9_PROX_THRES_SHIFT_CFG1          0xA9
> +#define RW_AA_PROX_THRES_SHIFT_CFG2          0xAA
> +#define RW_AB_PROX_THRES_SHIFT_CFG3          0xAB
> +#define RW_AC_PROX_THRES_SHIFT_CFG4          0xAC
> +#define RW_AD_BL_IN_NO_UP_NUM_SEL0           0xAD
> +#define RW_AE_BL_IN_NO_UP_NUM_SEL1           0xAE
> +#define RW_AF_BL_IN_NO_UP_NUM_SEL2           0xAF
> +#define RW_B2_BL_ALPHA_UP_DN_SEL             0xB2
> +#define RW_BF_CH0_SAMP_CFG                   0xBF
> +#define RW_C0_CH10_SCAN_FACTOR               0xC0
> +#define RW_C1_CH32_SCAN_FACTOR               0xC1
> +#define RW_C2_OFFSET_CALI_CTRL               0xC2
> +#define RW_90_OFFSET_CALI_CTRL1              0x90
> +#define RW_C3_DSP_CONFIG_CTRL0               0xC3
> +#define RW_92_DSP_CONFIG_CTRL5               0x92
> +#define RW_C4_CH10_DOZE_FACTOR               0xC4
> +#define RW_C5_CH32_DOZE_FACTOR               0xC5
> +#define RW_C6_CH10_PROX_FACTOR               0xC6
> +#define RW_C7_CH4_FACTOR_CTRL                0xC7
> +#define RW_C8_DSP_CONFIG_CTRL1               0xC8
> +#define RW_C9_DSP_CONFIG_CTRL2               0xC9
> +#define RW_CA_DSP_CONFIG_CTRL3               0xCA
> +#define RO_CB_DEC_DATA0                      0xCB
> +#define RO_CC_DEC_DATA1                      0xCC
> +#define RO_CD_DEC_DATA2                      0xCD
> +#define RO_CE_DEC_DATA3                      0xCE
> +#define RO_E0_CAP_INI_CH0_0                  0xE0
> +#define RO_E1_CAP_INI_CH0_1                  0xE1
> +#define RO_99_CAP_INI_CH0_2                  0x99
> +#define RO_E2_CAP_INI_CH1_0                  0xE2
> +#define RO_E3_CAP_INI_CH1_1                  0xE3
> +#define RO_9A_CAP_INI_CH1_2                  0x9A
> +#define RO_E4_CAP_INI_CH2_0                  0xE4
> +#define RO_E5_CAP_INI_CH2_1                  0xE5
> +#define RO_9B_CAP_INI_CH2_2                  0x9B
> +#define RO_E6_CAP_INI_CH3_0                  0xE6
> +#define RO_E7_CAP_INI_CH3_1                  0xE7
> +#define RO_9C_CAP_INI_CH3_2                  0x9C
> +#define RO_B3_CAP_INI_CH4_0                  0xB3
> +#define RO_B4_CAP_INI_CH4_1                  0xB4
> +#define RO_9D_CAP_INI_CH4_2                  0x9D
> +#define RO_E8_RAW_BL_CH0_0                   0xE8
> +#define RO_E9_RAW_BL_CH0_1                   0xE9
> +#define RO_EA_RAW_BL_CH0_2                   0xEA
> +#define RO_EB_RAW_BL_CH1_0                   0xEB
> +#define RO_EC_RAW_BL_CH1_1                   0xEC
> +#define RO_ED_RAW_BL_CH1_2                   0xED
> +#define RO_EE_RAW_BL_CH2_0                   0xEE
> +#define RO_EF_RAW_BL_CH2_1                   0xEF
> +#define RO_F0_RAW_BL_CH2_2                   0xF0
> +#define RO_F1_RAW_BL_CH3_0                   0xF1
> +#define RO_F2_RAW_BL_CH3_1                   0xF2
> +#define RO_F3_RAW_BL_CH3_2                   0xF3
> +#define RO_B5_RAW_BL_CH4_0                   0xB5
> +#define RO_B6_RAW_BL_CH4_1                   0xB6
> +#define RO_B7_RAW_BL_CH4_2                   0xB7
> +#define RO_F4_LP_DIFF_CH0_0                  0xF4
> +#define RO_F5_LP_DIFF_CH0_1                  0xF5
> +#define RO_F6_LP_DIFF_CH0_2                  0xF6
> +#define RO_F7_LP_DIFF_CH1_0                  0xF7
> +#define RO_F8_LP_DIFF_CH1_1                  0xF8
> +#define RO_F9_LP_DIFF_CH1_2                  0xF9
> +#define RO_FA_LP_DIFF_CH2_0                  0xFA
> +#define RO_FB_LP_DIFF_CH2_1                  0xFB
> +#define RO_FC_LP_DIFF_CH2_2                  0xFC
> +#define RO_FD_LP_DIFF_CH3_0                  0xFD
> +#define RO_FE_LP_DIFF_CH3_1                  0xFE
> +#define RO_FF_LP_DIFF_CH3_2                  0xFF
> +#define RO_B8_LP_DIFF_CH4_0                  0xB8
> +#define RO_B9_LP_DIFF_CH4_1                  0xB9
> +#define RO_BA_LP_DIFF_CH4_2                  0xBA
> +#define RW_50_REG_TO_ANA2                    0x50
> +#define RW_51_REG_TO_ANA3                    0x51
> +#define RW_52_REG_TO_ANA4                    0x52
> +#define RW_53_REG_TO_ANA5                    0x53
> +#define RW_82_REG_TO_ANA6                    0x82
> +
> +struct hx9031as_threshold {
> +	int32_t near;
> +	int32_t far;
> +};
> +
> +struct hx9031as_addr_val_pair {
> +	uint8_t addr;
> +	uint8_t val;
> +};
> +
> +struct hx9031as_channel_info {
> +	char name[20];
> +	bool enabled;
> +	bool used;
> +	int state;
> +};
> +
> +struct hx9031as_platform_data {
> +	struct i2c_client *i2c_client;
> +	struct hx9031as_data *iio_data;
> +	uint8_t chip_select;
> +	uint8_t ch_en_stat;
> +	int polling_period_ms;
> +	int32_t raw[HX9031AS_CH_NUM];
> +	int32_t diff[HX9031AS_CH_NUM];
> +	int32_t lp[HX9031AS_CH_NUM];
> +	int32_t bl[HX9031AS_CH_NUM];
> +	uint16_t dac[HX9031AS_CH_NUM];
> +	uint8_t accuracy;
> +	atomic_t polling_flag;
> +	atomic_t irq_en;
> +	struct hx9031as_threshold thres[HX9031AS_CH_NUM];
> +
> +	struct device *pdev;
> +	struct delayed_work polling_work;
> +	struct hx9031as_channel_info *chs_info;
> +	uint32_t channel_used_flag;
> +	int irq;
> +	int irq_gpio;
> +	char irq_disabled;
> +	uint32_t prox_state_reg;
> +	bool sel_bl[HX9031AS_CH_NUM];
> +	bool sel_raw[HX9031AS_CH_NUM];
> +	bool sel_diff[HX9031AS_CH_NUM];
> +	bool sel_lp[HX9031AS_CH_NUM];
> +
> +	uint8_t chs_en_flag;
> +	uint8_t cali_en_flag;
> +	uint8_t device_id;
> +	uint8_t version_id;
> +
> +	struct dentry *debugfs_dir;
> +};

Please double check if you really need all these. E.g. debugfs_dir is
only used in hx9031as_debug_for_iio().

> +
> +static struct hx9031as_addr_val_pair hx9031as_reg_init_list[] =3D {
> +	{RW_24_CH_NUM_CFG,                 0x00},
> +	{RW_00_GLOBAL_CTRL0,               0x00},
> +	{RW_23_GLOBAL_CTRL2,               0x00},
> +
> +	{RW_02_PRF_CFG,                    0x17},
> +	{RW_0D_RANGE_7_0,                  0x11},
> +	{RW_0E_RANGE_9_8,                  0x02},
> +	{RW_0F_RANGE_18_16,                0x00},
> +
> +	{RW_10_AVG0_NOSR0_CFG,             0x71},
> +	{RW_11_NOSR12_CFG,                 0x44},
> +	{RW_12_NOSR34_CFG,                 0x00},
> +	{RW_13_AVG12_CFG,                  0x33},
> +	{RW_14_AVG34_CFG,                  0x00},
> +
> +	{RW_1F_SAMPLE_NUM_7_0,             0x65},
> +	{RW_21_INTEGRATION_NUM_7_0,        0x65},
> +
> +	{RW_2A_LP_ALP_1_0_CFG,             0x22},
> +	{RW_2B_LP_ALP_3_2_CFG,             0x22},
> +	{RW_29_LP_ALP_4_CFG,               0x02},
> +	{RW_2C_UP_ALP_1_0_CFG,             0x88},
> +	{RW_2D_UP_ALP_3_2_CFG,             0x88},
> +	{RW_2E_DN_UP_ALP_0_4_CFG,          0x18},
> +	{RW_2F_DN_ALP_2_1_CFG,             0x11},
> +	{RW_30_DN_ALP_4_3_CFG,             0x11},
> +
> +	{RW_38_RAW_BL_RD_CFG,              0xF0},
> +	{RW_39_INTERRUPT_CFG,              0xFF},
> +	{RW_3A_INTERRUPT_CFG1,             0x3B},
> +	{RW_3B_CALI_DIFF_CFG,              0x07},
> +	{RW_3C_DITHER_CFG,                 0x21},
> +	{RW_6C_PROX_INT_HIGH_CFG,          0x01},
> +	{RW_6D_PROX_INT_LOW_CFG,           0x01},
> +
> +	{RW_80_PROX_HIGH_DIFF_CFG_CH0_0,   0x40},
> +	{RW_81_PROX_HIGH_DIFF_CFG_CH0_1,   0x00},
> +	{RW_82_PROX_HIGH_DIFF_CFG_CH1_0,   0x40},
> +	{RW_83_PROX_HIGH_DIFF_CFG_CH1_1,   0x00},
> +	{RW_84_PROX_HIGH_DIFF_CFG_CH2_0,   0x40},
> +	{RW_85_PROX_HIGH_DIFF_CFG_CH2_1,   0x00},
> +	{RW_86_PROX_HIGH_DIFF_CFG_CH3_0,   0x40},
> +	{RW_87_PROX_HIGH_DIFF_CFG_CH3_1,   0x00},
> +	{RW_9E_PROX_HIGH_DIFF_CFG_CH4_0,   0x40},
> +	{RW_9F_PROX_HIGH_DIFF_CFG_CH4_1,   0x00},
> +	{RW_88_PROX_LOW_DIFF_CFG_CH0_0,    0x20},
> +	{RW_89_PROX_LOW_DIFF_CFG_CH0_1,    0x00},
> +	{RW_8A_PROX_LOW_DIFF_CFG_CH1_0,    0x20},
> +	{RW_8B_PROX_LOW_DIFF_CFG_CH1_1,    0x00},
> +	{RW_8C_PROX_LOW_DIFF_CFG_CH2_0,    0x20},
> +	{RW_8D_PROX_LOW_DIFF_CFG_CH2_1,    0x00},
> +	{RW_8E_PROX_LOW_DIFF_CFG_CH3_0,    0x20},
> +	{RW_8F_PROX_LOW_DIFF_CFG_CH3_1,    0x00},
> +	{RW_A2_PROX_LOW_DIFF_CFG_CH4_0,    0x20},
> +	{RW_A3_PROX_LOW_DIFF_CFG_CH4_1,    0x00},
> +
> +	{RW_A8_PROX_THRES_SHIFT_CFG0,      0x00},
> +	{RW_A9_PROX_THRES_SHIFT_CFG1,      0x00},
> +	{RW_AA_PROX_THRES_SHIFT_CFG2,      0x00},
> +	{RW_AB_PROX_THRES_SHIFT_CFG3,      0x00},
> +	{RW_AC_PROX_THRES_SHIFT_CFG4,      0x00},
> +
> +	{RW_C0_CH10_SCAN_FACTOR,           0x00},
> +	{RW_C1_CH32_SCAN_FACTOR,           0x00},
> +	{RW_C4_CH10_DOZE_FACTOR,           0x00},
> +	{RW_C5_CH32_DOZE_FACTOR,           0x00},
> +	{RW_C7_CH4_FACTOR_CTRL,            0x00},
> +	{RW_C8_DSP_CONFIG_CTRL1,           0x00},
> +	{RW_CA_DSP_CONFIG_CTRL3,           0x00},
> +};
> +
> +static struct hx9031as_platform_data hx9031as_pdata =3D {
> +	.i2c_client =3D NULL,
> +	.ch_en_stat =3D 0x00,
> +	.polling_period_ms =3D 0,
> +	.accuracy =3D 16,
> +	.polling_flag =3D ATOMIC_INIT(0),
> +	.irq_en =3D ATOMIC_INIT(0),
> +	.thres =3D {
> +		{.near =3D 320, .far =3D 320},
> +		{.near =3D 320, .far =3D 320},
> +		{.near =3D 640, .far =3D 640},
> +		{.near =3D 640, .far =3D 640},
> +		{.near =3D 960, .far =3D 960}
> +	}
> +};
> +
> +static DEFINE_MUTEX(hx9031as_ch_en_mutex);
> +static DEFINE_MUTEX(hx9031as_cali_mutex);
> +
> +struct hx9031as_data {
> +	struct mutex mutex;
> +	struct i2c_client *client;
> +	struct iio_trigger *trig;
> +	struct regmap *regmap;
> +	struct regulator_bulk_data supplies[1];
> +	unsigned long chan_prox_stat;
> +	bool trigger_enabled;
> +	struct {
> +		__be16 channels[HX9031AS_CH_NUM];
> +
> +		s64 ts __aligned(8);
> +
> +	} buffer;
> +	unsigned long chan_read;
> +	unsigned long chan_event;  //channel en bit
> +};
> +
> +static const struct iio_event_spec hx9031as_events[] =3D {
> +	{
> +		.type =3D IIO_EV_TYPE_THRESH,
> +		.dir =3D IIO_EV_DIR_EITHER,
> +		.mask_separate =3D BIT(IIO_EV_INFO_ENABLE),
> +	},
> +};
> +
> +#define HX9031AS_NAMED_CHANNEL(idx, name)                    \
> +{                                                            \
> +	.type =3D IIO_PROXIMITY,                                   \
> +	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),            \
> +	.info_mask_shared_by_all =3D BIT(IIO_CHAN_INFO_SAMP_FREQ), \
> +	.indexed =3D 1,                                            \
> +	.channel =3D idx,                                          \
> +	.extend_name =3D name,                                     \
> +	.address =3D 0,                                            \
> +	.event_spec =3D hx9031as_events,                           \
> +	.num_event_specs =3D ARRAY_SIZE(hx9031as_events),          \
> +	.scan_index =3D idx,                                       \
> +	.scan_type =3D {                                           \
> +		.sign =3D 's',                                         \
> +		.realbits =3D 12,                                      \
> +		.storagebits =3D 16,                                   \
> +		.endianness =3D IIO_BE,                                \
> +	},                                                       \
> +}
> +
> +static const struct iio_chan_spec hx9031as_channels[] =3D {
> +	HX9031AS_NAMED_CHANNEL(0, "ch0"),
> +	HX9031AS_NAMED_CHANNEL(1, "ch1"),
> +	HX9031AS_NAMED_CHANNEL(2, "ch2"),
> +	HX9031AS_NAMED_CHANNEL(3, "ch3"),
> +	HX9031AS_NAMED_CHANNEL(4, "ch4"),
> +	IIO_CHAN_SOFT_TIMESTAMP(5),
> +};
> +
> +static const uint32_t hx9031as_samp_freq_table[] =3D {
> +	2, 2, 4, 6, 8, 10, 14, 18, 22, 26,
> +	30, 34, 38, 42, 46, 50, 56, 62, 68, 74,
> +	80, 90, 100, 200, 300, 400, 600, 800, 1000, 2000,
> +	3000, 4000
> +};
> +
> +static const struct regmap_config hx9031as_regmap_config =3D {
> +	.reg_bits =3D 8,
> +	.val_bits =3D 8,
> +	.cache_type =3D REGCACHE_NONE,
> +};
> +
> +static int hx9031as_read(uint8_t addr, uint8_t *rxbuf, int count)
> +{
> +	return regmap_bulk_read(hx9031as_pdata.iio_data->regmap, addr, rxbuf, c=
ount);
> +}
> +
> +static int hx9031as_write(uint8_t addr, uint8_t *txbuf, int count)
> +{
> +	return regmap_bulk_write(hx9031as_pdata.iio_data->regmap, addr, txbuf, =
count);
> +}
> +
> +static void hx9031as_data_lock(uint8_t lock_flag)
> +{
> +	int ret =3D -1;
> +	uint8_t rx_buf[1] =3D {0};
> +
> +	if (lock_flag =3D=3D HX9031AS_DATA_LOCK) {
> +		ret =3D hx9031as_read(RW_C8_DSP_CONFIG_CTRL1, rx_buf, 1);
> +		if (ret !=3D 0)
> +			PRINT_ERR("hx9031as_read failed\n");
> +
> +		rx_buf[0] =3D rx_buf[0] | 0x10;
> +		ret =3D hx9031as_write(RW_C8_DSP_CONFIG_CTRL1, rx_buf, 1);
> +		if (ret !=3D 0)
> +			PRINT_ERR("hx9031as_write failed\n");
> +	} else if (lock_flag =3D=3D HX9031AS_DATA_UNLOCK) {
> +		ret =3D hx9031as_read(RW_C8_DSP_CONFIG_CTRL1, rx_buf, 1);
> +		if (ret !=3D 0)
> +			PRINT_ERR("hx9031as_read failed\n");
> +
> +		rx_buf[0] =3D rx_buf[0] & 0xE7;
> +		ret =3D hx9031as_write(RW_C8_DSP_CONFIG_CTRL1, rx_buf, 1);
> +		if (ret !=3D 0)
> +			PRINT_ERR("hx9031as_write failed\n");
> +	} else {
> +		PRINT_ERR("ERROR!!! wrong para. now do data unlock!\n");
> +		ret =3D hx9031as_read(RW_C8_DSP_CONFIG_CTRL1, rx_buf, 1);
> +		if (ret !=3D 0)
> +			PRINT_ERR("hx9031as_read failed\n");
> +
> +		rx_buf[0] =3D rx_buf[0] & 0xE7;
> +		ret =3D hx9031as_write(RW_C8_DSP_CONFIG_CTRL1, rx_buf, 1);
> +		if (ret !=3D 0)
> +			PRINT_ERR("hx9031as_write failed\n");
> +	}
> +}
> +
> +static int hx9031as_id_check(void)
> +{
> +	int ret =3D -1;
> +	uint8_t rxbuf[1] =3D {0};
> +
> +	ret =3D hx9031as_read(RO_60_DEVICE_ID, rxbuf, 1);
> +	if (ret < 0) {
> +		PRINT_ERR("hx9031as_read failed\n");
> +		return ret;
> +	}
> +	hx9031as_pdata.device_id =3D rxbuf[0];
> +	rxbuf[0] =3D 0;
> +
> +	if (hx9031as_pdata.device_id =3D=3D HX9031AS_CHIP_ID) {

There is no way this check could fail today, is there? If you agree,
please drop this (until more variants are added?).

> +		ret =3D hx9031as_read(RO_5F_VERION_ID, rxbuf, 1);
> +		if (ret < 0)
> +			PRINT_ERR("hx9031as_read failed\n");
> +		hx9031as_pdata.version_id =3D rxbuf[0];
> +		PRINT_INF("success! device_id=3D0x%02X(HX9031AS) version_id=3D0x%02X\n=
",
> +				hx9031as_pdata.device_id, hx9031as_pdata.version_id);
> +	} else {
> +		PRINT_ERR("failed! device_id=3D0x%02X(UNKNOW_CHIP_ID) version_id=3D0x%=
02X\n",
> +				hx9031as_pdata.device_id, hx9031as_pdata.version_id);
> +		return -1;

Huh, even if this if branch is only theoretic, a function should *never*
return -1 if other exit paths return an errno (from hx9031as_read()
above).

> +	}
> +	return 0;
> +}
> +
> +static void hx9031as_ch_cfg(uint8_t chip_select)
> +{
> +	int ret =3D -1;
> +	int ii =3D 0;
> +	uint16_t ch_cfg =3D 0;
> +	uint8_t cfg[HX9031AS_CH_NUM * 2] =3D {0};
> +
> +	uint8_t cs0 =3D 0;
> +	uint8_t cs1 =3D 0;
> +	uint8_t cs2 =3D 0;
> +	uint8_t cs3 =3D 0;
> +	uint8_t cs4 =3D 0;
> +	uint8_t na =3D 16;

Ist there a more speaking name for "na"?=20

> +	uint8_t ch0_pos =3D na;
> +	uint8_t ch0_neg =3D na;
> +	uint8_t ch1_pos =3D na;
> +	uint8_t ch1_neg =3D na;
> +	uint8_t ch2_pos =3D na;
> +	uint8_t ch2_neg =3D na;
> +	uint8_t ch3_pos =3D na;
> +	uint8_t ch3_neg =3D na;
> +	uint8_t ch4_pos =3D na;
> +	uint8_t ch4_neg =3D na;
> +
> +	ENTER;
> +	if (chip_select =3D=3D HX9023S_ON_BOARD) {
> +		cs0 =3D 0; //Lshift0
> +		cs1 =3D 2; //Lshift2
> +		cs2 =3D 4; //Lshift4
> +		cs3 =3D 6; //Lshift6
> +		cs4 =3D 8; //Lshift8
> +		na =3D 16; //Lshift16
> +		PRINT_INF("HX9023S_ON_BOARD\n");
> +	} else if (chip_select =3D=3D HX9031AS_ON_BOARD) {
> +		cs0 =3D 4; //Lshift4
> +		cs1 =3D 2; //Lshift2
> +		cs2 =3D 6; //Lshift6
> +		cs3 =3D 0; //Lshift0
> +		cs4 =3D 8; //Lshift8
> +		na =3D 16; //Lshift16
> +		PRINT_INF("HX9031AS_ON_BOARD\n");
> +	}
> +
> +	ch0_pos =3D cs0;
> +	ch0_neg =3D na;
> +	ch1_pos =3D cs1;
> +	ch1_neg =3D na;
> +	ch2_pos =3D cs2;
> +	ch2_neg =3D na;
> +	ch3_pos =3D cs3;
> +	ch3_neg =3D na;
> +	ch4_pos =3D cs4;
> +	ch4_neg =3D na;

na got initialized with =3D 16, then in both if branches got reassigned =3D
16 and then several variables that were already assigned =3D na above the
"ENTER" get reassigned =3D na? This is hard to follow.

> +	ch_cfg =3D (uint16_t)((0x03 << ch0_pos) + (0x02 << ch0_neg));

This looks as if it should be wrapped in a macro or static inline
function.

> +	cfg[ii++] =3D (uint8_t)(ch_cfg);
> +	cfg[ii++] =3D (uint8_t)(ch_cfg >> 8);
> +
> +	ch_cfg =3D (uint16_t)((0x03 << ch1_pos) + (0x02 << ch1_neg));
> +	cfg[ii++] =3D (uint8_t)(ch_cfg);
> +	cfg[ii++] =3D (uint8_t)(ch_cfg >> 8);
> +
> +	ch_cfg =3D (uint16_t)((0x03 << ch2_pos) + (0x02 << ch2_neg));
> +	cfg[ii++] =3D (uint8_t)(ch_cfg);
> +	cfg[ii++] =3D (uint8_t)(ch_cfg >> 8);
> +
> +	ch_cfg =3D (uint16_t)((0x03 << ch3_pos) + (0x02 << ch3_neg));
> +	cfg[ii++] =3D (uint8_t)(ch_cfg);
> +	cfg[ii++] =3D (uint8_t)(ch_cfg >> 8);
> +
> +	ch_cfg =3D (uint16_t)((0x03 << ch4_pos) + (0x02 << ch4_neg));
> +	cfg[ii++] =3D (uint8_t)(ch_cfg);
> +	cfg[ii++] =3D (uint8_t)(ch_cfg >> 8);
> +
> +	ret =3D hx9031as_write(RW_03_CH0_CFG_7_0, cfg, HX9031AS_CH_NUM * 2);
> +	if (ret !=3D 0)
> +		PRINT_ERR("hx9031as_write failed\n");
> +}
> +
> +static void hx9031as_reg_init(void)
> +{
> +	int ii =3D 0;
> +	int ret =3D -1;
> +
> +	while (ii < (int)ARRAY_SIZE(hx9031as_reg_init_list)) {
> +		ret =3D hx9031as_write(hx9031as_reg_init_list[ii].addr, &hx9031as_reg_=
init_list[ii].val, 1);
> +		if (ret !=3D 0)
> +			PRINT_ERR("hx9031as_write failed\n");
> +		ii++;
> +	}

Should a failure from hx9031as_write better be propagated to the caller?

> +}
> [...]
> +static int hx9031as_probe(struct i2c_client *client)
> +{
> +	int ret;
> +	struct device *dev =3D &client->dev;
> +	struct iio_dev *indio_dev;
> +	struct hx9031as_data *data;
> +
> +	PRINT_INF("driver version:%s\n", HX9031AS_DRIVER_VER);
> +	PRINT_INF("client->name=3D%s, client->addr=3D0x%02X, client->irq=3D%d\n=
",
> +				client->name, client->addr, client->irq);
> +
> +	indio_dev =3D devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data =3D iio_priv(indio_dev);
> +	data->client =3D client;
> +	data->supplies[0].supply =3D "vdd";
> +	mutex_init(&data->mutex);
> +
> +	data->regmap =3D devm_regmap_init_i2c(client, &hx9031as_regmap_config);
> +	if (IS_ERR(data->regmap))
> +		return PTR_ERR(data->regmap);
> +	hx9031as_pdata.iio_data =3D data;

Having a global variable assumes there is only a single instance of this
chip. If there are two (or more) this yields all kind of surprises.

> +	ret =3D devm_regulator_bulk_get(dev, ARRAY_SIZE(data->supplies), data->=
supplies);
> +	if (ret) {
> +		PRINT_ERR("regulator bulk get failed\n");
> +		return ret;
> +	}
> +
> +	ret =3D regulator_bulk_enable(ARRAY_SIZE(data->supplies), data->supplie=
s);
> +	if (ret) {
> +		PRINT_ERR("regulator bulk enable failed\n");
> +		return ret;
> +	}
> +
> +	/* Must wait for Tpor time after initial power up */
> +	usleep_range(1000, 1100);
> +
> +	ret =3D devm_add_action_or_reset(dev, hx9031as_regulator_disable, data);
> +	if (ret)
> +		return ret;
> +
> +	hx9031as_debug_for_iio(client);
> +
> +	ret =3D hx9031as_id_check();
> +	if (ret !=3D 0) {
> +		PRINT_ERR("hx9031as_id_check failed\n");
> +		return ret;
> +	}
> +
> +	indio_dev->channels =3D hx9031as_channels;
> +	indio_dev->num_channels =3D ARRAY_SIZE(hx9031as_channels);
> +	indio_dev->info =3D &hx9031as_info;
> +	indio_dev->modes =3D INDIO_DIRECT_MODE;
> +	indio_dev->name =3D HX9031AS_DRIVER_NAME;
> +	i2c_set_clientdata(client, indio_dev);
> +
> +	ret =3D hx9031as_init_device(indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	if (client->irq) {
> +		ret =3D devm_request_threaded_irq(dev, client->irq,
> +										hx9031as_irq_handler,
> +										hx9031as_irq_thread_handler,
> +										IRQF_ONESHOT,
> +										"hx9031as_event", indio_dev);
> +		if (ret)
> +			return ret;
> +		atomic_set(&hx9031as_pdata.irq_en, 1);
> +
> +		data->trig =3D devm_iio_trigger_alloc(dev, "%s-dev%d",
> +											indio_dev->name,
> +											iio_device_id(indio_dev));
> +		if (!data->trig)
> +			return -ENOMEM;
> +
> +		data->trig->dev.parent =3D dev;
> +		data->trig->ops =3D &hx9031as_trigger_ops;
> +		iio_trigger_set_drvdata(data->trig, indio_dev);
> +
> +		ret =3D devm_iio_trigger_register(dev, data->trig);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret =3D devm_iio_triggered_buffer_setup(dev, indio_dev,
> +										iio_pollfunc_store_time,
> +										hx9031as_trigger_handler,
> +										&hx9031as_buffer_setup_ops);
> +	if (ret)
> +		return ret;
> +
> +	return devm_iio_device_register(dev, indio_dev);

I suggest error messages in the error paths of this function.

> +}
> +
> +static int __maybe_unused hx9031as_suspend(struct device *dev)
> +{
> +	//struct iio_dev *indio_dev =3D i2c_get_clientdata(to_i2c_client(dev));
> +	//struct hx9031as_data *data =3D iio_priv(indio_dev);

Drop these comments.

> +
> +	ENTER;
> +	hx9031as_disable_irq(hx9031as_pdata.irq);
> +	return 0;
> +}
> +
> +static int __maybe_unused hx9031as_resume(struct device *dev)
> +{
> +	//struct iio_dev *indio_dev =3D i2c_get_clientdata(to_i2c_client(dev));
> +	//struct hx9031as_data *data =3D iio_priv(indio_dev);
> +
> +	ENTER;
> +	hx9031as_enable_irq(hx9031as_pdata.irq);
> +	return 0;
> +}
> +
> +static SIMPLE_DEV_PM_OPS(hx9031as_pm_ops, hx9031as_suspend, hx9031as_res=
ume);

SIMPLE_DEV_PM_OPS is deprecated. Use DEFINE_SIMPLE_DEV_PM_OPS() and drop
the __maybe_unused for the related functions.

> +
> +static const struct acpi_device_id hx9031as_acpi_match[] =3D {
> +	{ HX9031AS_DRIVER_NAME, HX9031AS_CHIP_ID },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(acpi, hx9031as_acpi_match);
> +
> +static const struct of_device_id hx9031as_of_match[] =3D {
> +	{ .compatible =3D "tyhx,hx9031as", (void *)HX9031AS_CHIP_ID },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, hx9031as_of_match);
> +
> +static const struct i2c_device_id hx9031as_id[] =3D {
> +	{ HX9031AS_DRIVER_NAME, HX9031AS_CHIP_ID },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(i2c, hx9031as_id);

Can you please initialize these device_id structs with named
designators. (i.e.

	{ .name =3D HX9031AS_DRIVER_NAME, .driver_data =3D HX9031AS_CHIP_ID },

)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--dxs6cnfvpdosjuek
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmY99lwACgkQj4D7WH0S
/k6OYQf/RyVkaLue9RXnCq80WeJ6ityi/eOGzKobFYSx3KiKx3hn7yb3C/WcNiRp
rxczjIzD7b571C/meesQGh6gJ0d4LWe3Q4K372m1WsSs5LgiHoAH6gJUCS4QIfg2
Z94L7dd4H+3oaUl0ClNWf1SiDnscFvdh2wNTglmBTPbXcysPcK+d9yS3RxHoEKSa
g4drGotvuyXqcBGoQp3xo4LMIeUFCHZF1PclGFmq0Yl0RNvx177C64O7xBS7Mc3H
uha4iJ/YSLV9jqPsHJyRhv7Gvd39P90D+pKMchGTwZ4y5wv75+F2u890xnn6zvxt
rVG9uodXr6FCdMfzbLilQ/R/vFcBfA==
=ziQ8
-----END PGP SIGNATURE-----

--dxs6cnfvpdosjuek--

