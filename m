Return-Path: <linux-iio+bounces-4963-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 209488C3258
	for <lists+linux-iio@lfdr.de>; Sat, 11 May 2024 18:02:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C63E72819CE
	for <lists+linux-iio@lfdr.de>; Sat, 11 May 2024 16:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 708A056B63;
	Sat, 11 May 2024 16:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LIPOYnij"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1758838DD3;
	Sat, 11 May 2024 16:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715443315; cv=none; b=ViCP9Zl/2WJmjqppRqvfXHoRO8Iv6yOCB+j8X3GioUSj5+F0g8cN7zxwczThCq1PJr7iWNvVkJrX083Om7N4VkwfnhbVSGVjcwaSP8NaRtbyFp8122Xq6F1cdQ4MAt0kzXxaJSv0Kkc/rr8+03NcXCvgYnQBsdv+XO2CHYW8nL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715443315; c=relaxed/simple;
	bh=BpueLsrOfYx8flgw7StrsCVJEjPLrf0Ly7AnYUS1bqI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kXTVK9DpPDNsE4cS6azQQ0g5zycowkk0alOSfrw+PU33i/cBwcMIL3kAg3stOEneo54qOy3pqa6Ei1FVqQ728+8Yf47q3UYVWwrwfp/ALntoAK6W6/E8xA6bxdyda1F/dUPr/Mu5zaMvSGp6VjXkCn6QHQfGhtWXI3r6dhE+dHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LIPOYnij; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22122C2BBFC;
	Sat, 11 May 2024 16:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715443314;
	bh=BpueLsrOfYx8flgw7StrsCVJEjPLrf0Ly7AnYUS1bqI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LIPOYnij+4aFWctzLB7x8QaqbUSCS+IWk67ba8i/IlA5rObOxvWtyPPFimrBMeORD
	 4ztOBuy5H8oyg4STIXBZf1p7BB+qIktHSDrF/hqD0bsAc3AEiL/APpbLtMcL78uZc1
	 jYpQlXaqSadvlaD2OliN2O30wJltYMwGgzefTkSijm4d4Hmeg43IV19K8CIO2s3qg1
	 b+3hpOLL8ckH6AAum59IeXZOoAQxb31N7qzWF1n6ZfXMB4lWvYpaMgdw3TogZ6prbg
	 zloDkWBGkXWiS3tGOCrdRiIPHFeLipwMCwvcg0/XehM+5CEzkZC/X1mgimvS91u5Ch
	 V1mbtamYKcLZA==
Date: Sat, 11 May 2024 17:01:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Yasin Lee <yasin.lee.x@outlook.com>
Cc: lars@metafoo.de, swboyd@chromium.org, nuno.a@analog.com,
 andy.shevchenko@gmail.com, u.kleine-koenig@pengutronix.de,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 yasin.lee.x@gmail.com
Subject: Re: [PATCH] iio:proximity:hx9031as: Add TYHX HX9031AS/HX9023S
 sensor driver
Message-ID: <20240511170143.7ca6a410@jic23-huawei>
In-Reply-To: <SN7PR12MB8101EDFA7F91A59761095A28A4E72@SN7PR12MB8101.namprd12.prod.outlook.com>
References: <SN7PR12MB8101EDFA7F91A59761095A28A4E72@SN7PR12MB8101.namprd12.prod.outlook.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 10 May 2024 17:37:32 +0800
Yasin Lee <yasin.lee.x@outlook.com> wrote:

> From: Yasin Lee <yasin.lee.x@gmail.com>
>=20
> A SAR sensor from NanjingTianyihexin Electronics Ltd.
>=20
> The device has the following entry points:
>=20
> Usual frequency:
> - sampling_frequency
> - sampling_frequency_available
>=20
> Instant reading of current values for different sensors:
> - in_proximity0_ch0_raw
> - in_proximity1_ch1_raw
> - in_proximity2_ch2_raw
> - in_proximity3_ch3_raw
> - in_proximity4_ch4_raw
> and associated events in events/
>=20
> Debug fs:
> - /sys/kernel/debug/hx9031as
>=20
> Signed-off-by: Yasin Lee <yasin.lee.x@gmail.com>
Hi Yasin,

Welcome to IIO.  This driver unfortunately needed considerable cleaning up
before posting. I've given it a first review, but there is a lot of noise
in here that makes that challenging so I'll have to take a fresh look after
you have cleaned it up. Whilst this may seem rather fussy, remember reviewe=
rs
read a lot of code and if you want to get things merged, make their lives
easy!

Please drop all the debugfs stuff.  That can come back in a later patch
but for now it is adding a lot of code to review, most of which I suspect
is not necessary or is providing interfaces that should be provided via
sysfs.  I'd expect the next version of this driver to be at least 25% short=
er,
probably 50% which will make it more manageable to review.

Jonathan


> ---
>  .../ABI/testing/sysfs-bus-iio-hx9031as        |   16 +
>  drivers/iio/proximity/Kconfig                 |   12 +
>  drivers/iio/proximity/Makefile                |    1 +
>  drivers/iio/proximity/hx9031as.c              | 2142 +++++++++++++++++
>  4 files changed, 2171 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-hx9031as
>  create mode 100644 drivers/iio/proximity/hx9031as.c
>=20
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-hx9031as b/Documenta=
tion/ABI/testing/sysfs-bus-iio-hx9031as
> new file mode 100644
> index 000000000000..2356bcef84f4
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-hx9031as
> @@ -0,0 +1,16 @@
> +What:		/sys/bus/iio/devices/iio:deviceX/in_proximity<id>_ch<id>_raw
Why is this not 5 channels of standard form
in_proximityY_raw
and sets of differential channels
in_proximityY-proximityZ_raw (this one will need added to the main ABI/test=
ing/sysfs-bus-iio
as we haven't had a differential proximity sensor before).

You need a very strong reason to define ABI that is inconsistent with the
main IIO ABI definitions.  Extending to differential proximity channels
is fine, but not inventing something new.

> +Date:		May 2024
> +KernelVersion:	6.9.0
> +Contact:	Yasin Lee <yasin.lee.x@gmail>
> +Description:
> +		HX9031AS supports up to five sensor inputs, CS0, CS1, CS2,
> +		CS3 and CS4. This chip supports 2 selectable I2C addresses,=20
> +		controlled by floating or grounding CS0(floating: 0x28 GND: 0x2C)
Why is the I2C address in these docs?
> +
> +		This chip has 5 CSs for sensing terminals and 5 logical channels
> +		for data processing. Any sensing terminal can be mapped to these
> +		five logical channels, and two sensing terminals can also be mapped
> +		to the same logical channel to achieve differential data output.
> +
> +		The output of the node in_proximity<id>_ch<id>_raw is the
> +		differential data of channel<id>.


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
As mentioned below and by Uwe
> +
> +#define HX9031AS_TEST_CHS_EN 0             //test
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

All register names and fields etc need to be namespace by prefixing with HX=
9031AS_
Also, don't include the register index in the name or indeed if it is RW.
HX9031AS_GLOBAL_CTLR0_REG or similar.

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
> +
> +static struct hx9031as_addr_val_pair hx9031as_reg_init_list[] =3D {
> +	{RW_24_CH_NUM_CFG,                 0x00},

Space after { and before }

Regmap supports writing default registers in etc.  Perhaps it is better
to use that infrastructure than it is to roll your own.
The datasheet seems to list defaults for these that match some of those
you have here. In those cases why are the needed here?

> +	{RW_00_GLOBAL_CTRL0,               0x00},
> +	{RW_23_GLOBAL_CTRL2,               0x00},

This one isn't on the datasheet I found.  Can you include a link to
a datasheet that you are using if possible?

> +
> +	{RW_02_PRF_CFG,                    0x17},
> +	{RW_0D_RANGE_7_0,                  0x11},

Called RANGE_1_0 on the datasheet google gave me.
Makes more sense as it's the range for CH0 and CH1

I got bored trying to line them up.  Ideally replace the values with regist=
er
field combinations with suitable field names and FIELD_PREP() etc.

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

You can't have global data unless it is constant.  What happens if someone =
wires
up 2 of this device?

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
These need to be device instance specific not global.

> +
> +struct hx9031as_data {
> +	struct mutex mutex;

All locks need a comment telling us what data they are protecting.

> +	struct i2c_client *client;
> +	struct iio_trigger *trig;
> +	struct regmap *regmap;
> +	struct regulator_bulk_data supplies[1];

As below, don't handle 1 supply via bulk registration as it makes
the code more complex than it needs to be.

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

I don't understand the comment. Is it a bitmask of which channels
are enabled?

> +};
> +
> +static const struct iio_event_spec hx9031as_events[] =3D {
> +	{
> +		.type =3D IIO_EV_TYPE_THRESH,
> +		.dir =3D IIO_EV_DIR_EITHER,
> +		.mask_separate =3D BIT(IIO_EV_INFO_ENABLE),

no threshold controls?

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

Extend name is very rarely something you should be using in a driver.
It was there for some specific cases of power monitoring a long time
back and is now mostly deprecated in favour of labels.

> +	.address =3D 0,                                            \

If you aren't using it, let C standard deal with setting it to 0.

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
Don't add these wrappers. They make the code harder to read and hide
that for a lot of cases you can use other regmap calls to update particular=
 bits
for example.  Just call regmap directly inline.

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

Defines for these lock fields in the register.
As above, use regmap directly. It has nice functions for RMW cycles
to update particular bits in registers like you are doing here.

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

This will never happen unless you have a bug?  So get rid of it.
Probably make your lock_flag a boolean so it clearly only has lock and unlo=
ck
and not any additional values.


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
Use linux error code. -EINVAL; probably.
However, you should not fail to probe a driver because of an ID register mi=
smatch.
That breaks the use of Device Tree fallback compatibles which rely on new d=
evices
being compatible with earlier ones, and hence the driver from an earlier ke=
rnel working.
The most this should do is print a warning that we have an unknown ID.

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

Use some arrays instead of lots an separate variables.

> +	uint8_t na =3D 16;

Don't do this as it is hard to read. If you need an ignore
value then use a define to give that a name.

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
> +
> +	ch_cfg =3D (uint16_t)((0x03 << ch0_pos) + (0x02 << ch0_neg));
> +	cfg[ii++] =3D (uint8_t)(ch_cfg);
> +	cfg[ii++] =3D (uint8_t)(ch_cfg >> 8);

put_unaligned_le16() for each of these.  Once you are using arrays
for the various parts, you can use a loop for this.

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
If it failed, return an error.

> +}

> +
> +static void hx9031as_manual_offset_calibration_all_chs(void)
> +{
> +	int ret =3D -1;
> +	uint8_t buf[2] =3D {0};
> +
> +	mutex_lock(&hx9031as_cali_mutex);
> +	ret =3D hx9031as_read(RW_C2_OFFSET_CALI_CTRL, &buf[0], 1);
> +	if (ret !=3D 0)
> +		PRINT_ERR("hx9031as_read failed\n");
> +	ret =3D hx9031as_read(RW_90_OFFSET_CALI_CTRL1, &buf[1], 1);
> +	if (ret !=3D 0)
> +		PRINT_ERR("hx9031as_read failed\n");
> +
> +	buf[0] |=3D 0xF0;
> +	buf[1] |=3D 0x10;
You are setting particular bits. Name the fields via defines so we
can immediate see what this is setting.

> +
> +	ret =3D hx9031as_write(RW_C2_OFFSET_CALI_CTRL, &buf[0], 1);
> +	if (ret !=3D 0)
> +		PRINT_ERR("hx9031as_write failed\n");
> +	ret =3D hx9031as_write(RW_90_OFFSET_CALI_CTRL1, &buf[1], 1);
> +	if (ret !=3D 0)
> +		PRINT_ERR("hx9031as_write failed\n");
> +
> +	PRINT_INF("channels will calibrate in next convert cycle (ODR=3D%dms)\n=
", HX9031AS_ODR_MS);
> +	TYHX_DELAY_MS(HX9031AS_ODR_MS);
> +	mutex_unlock(&hx9031as_cali_mutex);
> +}

> +
> +static int32_t hx9031as_set_thres_far(uint8_t ch, int32_t val)
> +{
> +	int ret =3D -1;
> +	uint8_t buf[2];
> +
> +	val /=3D 32;
> +	buf[0] =3D val & 0xFF;
> +	buf[1] =3D (val >> 8) & 0x03;

Mask the value first, then do an unaligned_put_le16()

> +	hx9031as_pdata.thres[ch].far =3D (val & 0x03FF) * 32;
> +
> +	if (ch =3D=3D 4) {
> +		ret =3D hx9031as_write(RW_A2_PROX_LOW_DIFF_CFG_CH4_0, buf, 2);
> +		if (ret !=3D 0)
> +			PRINT_ERR("hx9031as_write failed\n");
Error out in all these cases, don't continue.

> +	} else {
> +		ret =3D hx9031as_write(RW_88_PROX_LOW_DIFF_CFG_CH0_0 + (ch * CH_DATA_2=
BYTES), buf, 2);
> +		if (ret !=3D 0)
> +			PRINT_ERR("hx9031as_write failed\n");
> +	}
> +
> +	PRINT_INF("hx9031as_pdata.thres[%d].far=3D%d\n", ch, hx9031as_pdata.thr=
es[ch].far);
> +	return hx9031as_pdata.thres[ch].far;
> +}
> +

..

> +static void hx9031as_data_select(void)
> +{
> +	int ret =3D -1;
> +	int ii =3D 0;
> +	uint8_t buf[1] =3D {0};
> +
> +	ret =3D hx9031as_read(RW_38_RAW_BL_RD_CFG, buf, 1);
> +	if (ret !=3D 0)
> +		PRINT_ERR("hx9031as_read failed\n");
> +
> +	for (ii =3D 0; ii < 4; ii++) { //ch0~sh3
> +		hx9031as_pdata.sel_diff[ii] =3D buf[0] & (0x01 << ii);
> +		hx9031as_pdata.sel_lp[ii] =3D !hx9031as_pdata.sel_diff[ii];
> +		hx9031as_pdata.sel_bl[ii] =3D buf[0] & (0x10 << ii);
> +		hx9031as_pdata.sel_raw[ii] =3D !hx9031as_pdata.sel_bl[ii];
> +	}
> +
> +	ret =3D hx9031as_read(RW_3A_INTERRUPT_CFG1, buf, 1);
> +	if (ret !=3D 0)
> +		PRINT_ERR("hx9031as_read failed\n");
> +
> +	//ch4
> +	hx9031as_pdata.sel_diff[4] =3D buf[0] & (0x01 << 2);
> +	hx9031as_pdata.sel_lp[4] =3D !hx9031as_pdata.sel_diff[4];
> +	hx9031as_pdata.sel_bl[4] =3D buf[0] & (0x01 << 3);
> +	hx9031as_pdata.sel_raw[4] =3D !hx9031as_pdata.sel_bl[4];
> +}
> +
> +static void hx9031as_sample(void)
> +{
> +	int ret =3D -1;

Always set below. Don't initialize ehre.

> +	int ii =3D 0;
> +	uint8_t bytes_per_channel =3D 0;

Why set to 0 and reset to something else just below?

> +	uint8_t bytes_all_channels =3D 0;

Same comment.

> +	uint8_t rx_buf[HX9031AS_CH_NUM * CH_DATA_BYTES_MAX] =3D {0};
> +	int32_t data =3D 0;
> +
> +	hx9031as_data_lock(HX9031AS_DATA_LOCK);
> +	hx9031as_data_select();
> +
> +	bytes_per_channel =3D CH_DATA_3BYTES;
> +	bytes_all_channels =3D HX9031AS_CH_NUM * bytes_per_channel;
> +	ret =3D hx9031as_read(RO_E8_RAW_BL_CH0_0, rx_buf, bytes_all_channels - =
bytes_per_channel);
> +	if (ret !=3D 0)
	if (ret)

> +		PRINT_ERR("hx9031as_read failed\n");

Add some blank lines after blocks of related code. It will help readability.
Also, don't carry on if you got an error just give up cleanly.


> +	ret =3D hx9031as_read(RO_B5_RAW_BL_CH4_0, rx_buf + (bytes_all_channels =
- bytes_per_channel), bytes_per_channel);

Very long line. Keep to 80 chars unless readability is hurt. Event then 100=
 is the max.

> +	if (ret !=3D 0)
> +		PRINT_ERR("hx9031as_read failed\n");
> +	for (ii =3D 0; ii < HX9031AS_CH_NUM; ii++) {

Use i as the index variable. It's a lot more common than ii so what
people expect to see.

> +		if (hx9031as_pdata.accuracy =3D=3D 16) {
> +			data =3D ((rx_buf[ii * bytes_per_channel + 2] << 8) | (rx_buf[ii * by=
tes_per_channel + 1]));

looks like get_unaligned_le16() use that instead. (or the be variant if I r=
ead this wrong)

> +			data =3D (data > 0x7FFF) ? (data - (0xFFFF + 1)) : data;
Is this sign extending? Use sign_extend32(data, xx)

> +		} else {
> +			data =3D ((rx_buf[ii * bytes_per_channel + 2] << 16) | (rx_buf[ii * b=
ytes_per_channel + 1] << 8)
> +					| (rx_buf[ii * bytes_per_channel]));

	get_unaligned_le24()

> +			data =3D (data > 0x7FFFFF) ? (data - (0xFFFFFF + 1)) : data;
sign_extend32(data, xx)

> +		}
> +		hx9031as_pdata.raw[ii] =3D 0;
> +		hx9031as_pdata.bl[ii] =3D 0;
> +		if (true =3D=3D hx9031as_pdata.sel_raw[ii])
if (hx9031as_pdata.sel_raw[i])
etc but without that being global data.  It should be in the iio_priv()
allocation for each device instance.

> +			hx9031as_pdata.raw[ii] =3D data;
> +		if (true =3D=3D hx9031as_pdata.sel_bl[ii])
> +			hx9031as_pdata.bl[ii] =3D data;
> +	}
> +
> +	bytes_per_channel =3D CH_DATA_3BYTES;
> +	bytes_all_channels =3D HX9031AS_CH_NUM * bytes_per_channel;

Same comments apply as above. Reusing these variables isn't helping readabi=
lity.
Maths is simple, I'd just use it inline so we can see what is happening in =
each case.


> +	ret =3D hx9031as_read(RO_F4_LP_DIFF_CH0_0, rx_buf, bytes_all_channels -=
 bytes_per_channel);
> +	if (ret !=3D 0)
> +		PRINT_ERR("hx9031as_read failed\n");
> +	ret =3D hx9031as_read(RO_B8_LP_DIFF_CH4_0, rx_buf + (bytes_all_channels=
 - bytes_per_channel), bytes_per_channel);
> +	if (ret !=3D 0)
> +		PRINT_ERR("hx9031as_read failed\n");
> +	for (ii =3D 0; ii < HX9031AS_CH_NUM; ii++) {
> +		if (hx9031as_pdata.accuracy =3D=3D 16) {
> +			data =3D ((rx_buf[ii * bytes_per_channel + 2] << 8) | (rx_buf[ii * by=
tes_per_channel + 1]));
> +			data =3D (data > 0x7FFF) ? (data - (0xFFFF + 1)) : data;
> +		} else {
> +			data =3D ((rx_buf[ii * bytes_per_channel + 2] << 16) | (rx_buf[ii * b=
ytes_per_channel + 1] << 8)
> +					| (rx_buf[ii * bytes_per_channel]));
> +			data =3D (data > 0x7FFFFF) ? (data - (0xFFFFFF + 1)) : data;
> +		}
> +		hx9031as_pdata.lp[ii] =3D 0;
> +		hx9031as_pdata.diff[ii] =3D 0;
> +		if (true =3D=3D hx9031as_pdata.sel_lp[ii])
> +			hx9031as_pdata.lp[ii] =3D data;
> +		if (true =3D=3D hx9031as_pdata.sel_diff[ii])
> +			hx9031as_pdata.diff[ii] =3D data;
> +	}
> +
> +	for (ii =3D 0; ii < HX9031AS_CH_NUM; ii++) {
> +		if (true =3D=3D hx9031as_pdata.sel_lp[ii] && true =3D=3D hx9031as_pdat=
a.sel_bl[ii])
> +			hx9031as_pdata.diff[ii] =3D hx9031as_pdata.lp[ii] - hx9031as_pdata.bl=
[ii];
> +	}
> +
> +	bytes_per_channel =3D CH_DATA_2BYTES;
> +	bytes_all_channels =3D HX9031AS_CH_NUM * bytes_per_channel;
> +	ret =3D hx9031as_read(RW_15_OFFSET_DAC0_7_0, rx_buf, bytes_all_channels=
);
> +	if (ret !=3D 0)
> +		PRINT_ERR("hx9031as_read failed\n");
> +	for (ii =3D 0; ii < HX9031AS_CH_NUM; ii++) {
> +		data =3D ((rx_buf[ii * bytes_per_channel + 1] << 8) | (rx_buf[ii * byt=
es_per_channel]));
> +		data =3D data & 0xFFF;//12=E4=BD=8D
> +		hx9031as_pdata.dac[ii] =3D data;
> +	}
> +
> +	hx9031as_data_lock(HX9031AS_DATA_UNLOCK);
> +
> +	PRINT_DBG("accuracy=3D%d\n", hx9031as_pdata.accuracy);
> +	PRINT_DBG("DIFF  , %-8d, %-8d, %-8d, %-8d, %-8d\n",
> +				hx9031as_pdata.diff[0], hx9031as_pdata.diff[1], hx9031as_pdata.diff[=
2],
> +				hx9031as_pdata.diff[3], hx9031as_pdata.diff[4]);
> +	PRINT_DBG("RAW   , %-8d, %-8d, %-8d, %-8d, %-8d\n",
> +				hx9031as_pdata.raw[0], hx9031as_pdata.raw[1], hx9031as_pdata.raw[2],
> +				hx9031as_pdata.raw[3], hx9031as_pdata.raw[4]);
> +	PRINT_DBG("OFFSET, %-8d, %-8d, %-8d, %-8d, %-8d\n",
> +				hx9031as_pdata.dac[0], hx9031as_pdata.dac[1], hx9031as_pdata.dac[2],
> +				hx9031as_pdata.dac[3], hx9031as_pdata.dac[4]);
> +	PRINT_DBG("BL    , %-8d, %-8d, %-8d, %-8d, %-8d\n",
> +				hx9031as_pdata.bl[0], hx9031as_pdata.bl[1], hx9031as_pdata.bl[2],
> +				hx9031as_pdata.bl[3], hx9031as_pdata.bl[4]);
> +	PRINT_DBG("LP    , %-8d, %-8d, %-8d, %-8d, %-8d\n",
> +				hx9031as_pdata.lp[0], hx9031as_pdata.lp[1], hx9031as_pdata.lp[2],
> +				hx9031as_pdata.lp[3], hx9031as_pdata.lp[4]);

All this debug should go.  It's useful when developing a driver, but not fo=
r an upstream
version of that driver.

> +}
> +
> +static void hx9031as_disable_irq(unsigned int irq)
> +{
> +	if (irq =3D=3D 0) {
> +		PRINT_ERR("wrong irq number!\n");
> +		return;
> +	}
> +
> +	if (atomic_read(&hx9031as_pdata.irq_en) =3D=3D 1) {
> +		disable_irq_nosync(hx9031as_pdata.irq);
> +		atomic_set(&hx9031as_pdata.irq_en, 0);
> +		PRINT_DBG("irq_%d is disabled!\n", irq);
> +	} else {
> +		PRINT_ERR("irq_%d is disabled already!\n", irq);
> +	}
> +}
> +
> +static void hx9031as_enable_irq(unsigned int irq)
> +{
> +	if (irq =3D=3D 0) {
> +		PRINT_ERR("wrong irq number!\n");
Do that check at point of retrieving the ID from firmware not
in a call deep in the driver.
> +		return;
> +	}
> +
> +	if (atomic_read(&hx9031as_pdata.irq_en) =3D=3D 0) {
> +		enable_irq(hx9031as_pdata.irq);
If you disable this device side that would be a much better plan.

> +		atomic_set(&hx9031as_pdata.irq_en, 1);

Not sure why this reference counting is needed. Looks like it is
simply a flag that is either 1 or 0.

> +		PRINT_DBG("irq_%d is enabled!\n", irq);

Clean all these out.

> +	} else {
> +		PRINT_ERR("irq_%d is enabled already!\n", irq);
> +	}
> +}
> +
> +#if HX9031AS_TEST_CHS_EN

Get rid of conditional sections of code. Either it belongs in finished
driver or it doesn't (in which case delete it).

> +static int hx9031as_ch_en(uint8_t ch_id, uint8_t en)
> +{
> +	int ret =3D -1;
> +	uint8_t tx_buf[1] =3D {0};
> +
> +	en =3D !!en;
> +	if (ch_id >=3D HX9031AS_CH_NUM) {
> +		PRINT_ERR("channel index over range!!! hx9031as_pdata.ch_en_stat=3D0x%=
02X (ch_id=3D%d, en=3D%d)\n",
> +					hx9031as_pdata.ch_en_stat, ch_id, en);
> +		return -1;
> +	}
> +
> +	if (en =3D=3D 1) {
> +		if (hx9031as_pdata.ch_en_stat =3D=3D 0) {
> +			hx9031as_pdata.prox_state_reg =3D 0;
> +			tx_buf[0] =3D hx9031as_pdata.channel_used_flag;
> +			ret =3D hx9031as_write(RW_24_CH_NUM_CFG, tx_buf, 1);
> +			if (ret !=3D 0) {
> +				PRINT_ERR("hx9031as_write failed\n");
> +				return -1;
> +			}
> +		}
> +		hx9031as_pdata.ch_en_stat |=3D (1 << ch_id);
> +		PRINT_INF("hx9031as_pdata.ch_en_stat=3D0x%02X (ch_%d enabled)\n", hx90=
31as_pdata.ch_en_stat, ch_id);
> +	} else {
> +		hx9031as_pdata.ch_en_stat &=3D ~(1 << ch_id);
> +		if (hx9031as_pdata.ch_en_stat =3D=3D 0) {
> +			tx_buf[0] =3D 0x00;
> +			ret =3D hx9031as_write(RW_24_CH_NUM_CFG, tx_buf, 1);
> +			if (ret !=3D 0) {
> +				PRINT_ERR("hx9031as_write failed\n");
> +				return -1;
> +			}
> +		}
> +		PRINT_INF("hx9031as_pdata.ch_en_stat=3D0x%02X (ch_%d disabled)\n", hx9=
031as_pdata.ch_en_stat, ch_id);
> +	}
> +	return 0;
> +}
> +
> +#else
> +
> +static int hx9031as_ch_en(uint8_t ch_id, uint8_t en)
> +{
> +	int ret =3D -1;
> +	uint8_t rx_buf[1] =3D {0};
> +	uint8_t tx_buf[1] =3D {0};
> +
> +	en =3D !!en;
> +	if (ch_id >=3D HX9031AS_CH_NUM) {
> +		PRINT_ERR("channel index over range!!! hx9031as_pdata.ch_en_stat=3D0x%=
02X (ch_id=3D%d, en=3D%d)\n",
> +					hx9031as_pdata.ch_en_stat, ch_id, en);
> +		return -1;
> +	}
> +
> +	ret =3D hx9031as_read(RW_24_CH_NUM_CFG, rx_buf, 1);
> +	if (ret !=3D 0) {
> +		PRINT_ERR("hx9031as_read failed\n");
> +		return -1;
> +	}
> +	hx9031as_pdata.ch_en_stat =3D rx_buf[0];
> +
> +	if (en =3D=3D 1) {
> +		if (hx9031as_pdata.ch_en_stat =3D=3D 0)
> +			hx9031as_pdata.prox_state_reg =3D 0;
> +		hx9031as_pdata.ch_en_stat |=3D (1 << ch_id);
> +		tx_buf[0] =3D hx9031as_pdata.ch_en_stat;
> +		ret =3D hx9031as_write(RW_24_CH_NUM_CFG, tx_buf, 1);
> +		if (ret !=3D 0) {
> +			PRINT_ERR("hx9031as_write failed\n");
> +			return -1;
> +		}
> +		PRINT_INF("hx9031as_pdata.ch_en_stat=3D0x%02X (ch_%d enabled)\n", hx90=
31as_pdata.ch_en_stat, ch_id);
> +		TYHX_DELAY_MS(10);
> +	} else {
> +		hx9031as_pdata.ch_en_stat &=3D ~(1 << ch_id);
> +		tx_buf[0] =3D hx9031as_pdata.ch_en_stat;
> +		ret =3D hx9031as_write(RW_24_CH_NUM_CFG, tx_buf, 1);
> +		if (ret !=3D 0) {
> +			PRINT_ERR("hx9031as_write failed\n");
> +			return -1;
> +		}
> +		PRINT_INF("hx9031as_pdata.ch_en_stat=3D0x%02X (ch_%d disabled)\n", hx9=
031as_pdata.ch_en_stat, ch_id);
> +	}
> +	return 0;
> +}
> +#endif


> +
> +static int hx9031as_debug_for_iio(struct i2c_client *client)
> +{
Keep debugfs usage to a minimum. It is still ABI even if we relax
the rules on stability etc a little.  For now I'd consider this
unnecessary noise in an already substantial driver. If there is
useful stuff in here once you have the rest of the driver ready, then
add it in a separate patch.  As such I'm not going to look closely
at any of this debugfs stuff now.

> +	int ret =3D 0;
> +	int ii =3D 0;
> +	struct dentry *debugfs_file;
> +
> +	PRINT_INF("i2c address:0x%02X\n", client->addr);
> +	hx9031as_pdata.i2c_client =3D client;
> +	hx9031as_pdata.pdev =3D &client->dev;
> +	hx9031as_pdata.irq =3D client->irq;
> +	hx9031as_pdata.channel_used_flag =3D 0x1F;
> +	hx9031as_pdata.chip_select =3D HX9023S_ON_BOARD;
> +
> +	hx9031as_pdata.chs_info =3D devm_kzalloc(&client->dev,
> +											sizeof(struct hx9031as_channel_info) * HX9031AS_CH_NUM,
> +											GFP_KERNEL);
> +	if (hx9031as_pdata.chs_info =3D=3D NULL) {

As below. Just return if this happens.

> +		PRINT_ERR("devm_kzalloc failed\n");
> +		ret =3D -ENOMEM;
> +		goto failed_devm_kzalloc;
> +	}
> +
> +	for (ii =3D 0; ii < HX9031AS_CH_NUM; ii++) {
> +		snprintf(hx9031as_pdata.chs_info[ii].name,
> +					sizeof(hx9031as_pdata.chs_info[ii].name),
> +					"hx9031as_ch%d",
> +					ii);
> +		PRINT_DBG("name of ch_%d:\"%s\"\n", ii, hx9031as_pdata.chs_info[ii].na=
me);
> +		hx9031as_pdata.chs_info[ii].used =3D false;
> +		hx9031as_pdata.chs_info[ii].enabled =3D false;
> +		if ((hx9031as_pdata.channel_used_flag >> ii) & 0x1) {
> +			hx9031as_pdata.chs_info[ii].used =3D true;
> +			hx9031as_pdata.chs_info[ii].state =3D 0;
> +		}
> +	}
> +
> +	INIT_DELAYED_WORK(&hx9031as_pdata.polling_work, hx9031as_polling_work_f=
unc);
> +
> +	hx9031as_pdata.debugfs_dir =3D debugfs_create_dir(HX9031AS_DRIVER_NAME,=
 NULL);
> +	if (hx9031as_pdata.debugfs_dir !=3D NULL) {
> +		debugfs_file =3D debugfs_create_file("raw_data", 0644, hx9031as_pdata.=
debugfs_dir, NULL, &hx9031as_raw_data_fops);
> +		if (!debugfs_file)
> +			goto failed_create_file;
> +		debugfs_file =3D debugfs_create_file("reg_write", 0644, hx9031as_pdata=
.debugfs_dir, NULL, &hx9031as_reg_write_fops);
> +		if (!debugfs_file)
> +			goto failed_create_file;
> +		debugfs_file =3D debugfs_create_file("reg_read", 0644, hx9031as_pdata.=
debugfs_dir, NULL, &hx9031as_reg_read_fops);

IIO has standard callback for debug access to registers - use that rather t=
han spinning a new one.

> +		if (!debugfs_file)
> +			goto failed_create_file;
> +		debugfs_file =3D debugfs_create_file("channel_en", 0644, hx9031as_pdat=
a.debugfs_dir, NULL, &hx9031as_channel_en_fops);
> +		if (!debugfs_file)
> +			goto failed_create_file;
> +		debugfs_file =3D debugfs_create_file("calibrate", 0644, hx9031as_pdata=
.debugfs_dir, NULL,
> &hx9031as_manual_offset_calibration_fops);

This doesn't sound like a debug function.

> +		if (!debugfs_file)
> +			goto failed_create_file;
> +		debugfs_file =3D debugfs_create_file("prox_state", 0644, hx9031as_pdat=
a.debugfs_dir, NULL, &hx9031as_prox_state_fops);
> +		if (!debugfs_file)
> +			goto failed_create_file;
> +		debugfs_file =3D debugfs_create_file("polling_period", 0644, hx9031as_=
pdata.debugfs_dir, NULL, &hx9031as_polling_fops);
> +		if (!debugfs_file)
> +			goto failed_create_file;
> +		debugfs_file =3D debugfs_create_file("threshold", 0644, hx9031as_pdata=
.debugfs_dir, NULL, &hx9031as_threshold_fops);

Likewise. This belongs on the normal ABI.

> +		if (!debugfs_file)
> +			goto failed_create_file;
> +		debugfs_file =3D debugfs_create_file("accuracy", 0644, hx9031as_pdata.=
debugfs_dir, NULL, &hx9031as_accuracy_fops);
> +		if (!debugfs_file)
> +			goto failed_create_file;
> +		debugfs_file =3D debugfs_create_file("dump", 0644, hx9031as_pdata.debu=
gfs_dir, NULL, &hx9031as_dump_fops);
> +		if (!debugfs_file)
> +			goto failed_create_file;
> +		debugfs_file =3D debugfs_create_file("offset_dac", 0644, hx9031as_pdat=
a.debugfs_dir, NULL, &hx9031as_offset_dac_fops);
> +		if (!debugfs_file)
> +			goto failed_create_file;
> +		PRINT_INF("debugfs_create_dir success\n");
> +	} else {
> +		PRINT_INF("debugfs_create_dir failed\n");
> +		//return -ENODEV;
> +	}
> +
> +	return 0;
> +
> +failed_create_file:
> +	PRINT_INF("debugfs_create_file failed\n");
> +	debugfs_remove_recursive(hx9031as_pdata.debugfs_dir);
> +	return 0;
> +
> +failed_devm_kzalloc:
> +	PRINT_ERR("debug init failed\n");
If devm_kzalloc failed, just return - don't use a goto.

> +	return ret;
> +}


Get rid of this. We shouldn't see any commented out code in a patch submiss=
ion.

> + * static int hx9031as_get_read_channel(struct hx9031as_data *data, int =
channel)
> + * {
> + * return hx9031as_update_chan_en(data, data->chan_read | BIT(channel), =
data->chan_event);
> + * }
> + *
> + * static int hx9031as_put_read_channel(struct hx9031as_data *data, int =
channel)
> + * {
> + * return hx9031as_update_chan_en(data, data->chan_read & ~BIT(channel),=
 data->chan_event);
> + * }
> + *
> + * static int hx9031as_get_event_channel(struct hx9031as_data *data, int=
 channel)
> + * {
> + * return hx9031as_update_chan_en(data, data->chan_read, data->chan_even=
t | BIT(channel));
> + * }
> + *
> + * static int hx9031as_put_event_channel(struct hx9031as_data *data, int=
 channel)
> + * {
> + * return hx9031as_update_chan_en(data, data->chan_read, data->chan_even=
t & ~BIT(channel));
> + * }
> + */




> +static int hx9031as_write_event_config(struct iio_dev *indio_dev,
> +										const struct iio_chan_spec *chan,
> +										enum iio_event_type type,
> +										enum iio_event_direction dir, int state)
> +{
> +	struct hx9031as_data *data =3D iio_priv(indio_dev);
> +
> +	PRINT_INF("befor:chan_event=3D0x%016lX\n", data->chan_event);
> +	if ((hx9031as_pdata.channel_used_flag >> chan->channel) & 0x1) {
> +		hx9031as_ch_en_hal(chan->channel, !!state);
> +		if (hx9031as_pdata.chs_info[chan->channel].enabled =3D=3D 1)

		if (*.enabled)

> +			data->chan_event =3D (data->chan_event | BIT(chan->channel));
> +		else
> +			data->chan_event =3D (data->chan_event & ~BIT(chan->channel));
> +	}
> +	PRINT_INF("after:chan_event=3D0x%016lX(ch%d updated)\n", data->chan_eve=
nt, chan->channel);
> +	return 0;
> +}
> +
> +static struct attribute *hx9031as_attributes[] =3D {
> +	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
> +	NULL
> +};

Use the info_mask_shared_by_all_available bitmap and the read_avail
callback. No need for a custom attribute for this.

> +
> +static const struct iio_trigger_ops hx9031as_trigger_ops =3D {
> +	.set_trigger_state =3D hx9031as_set_trigger_state,
> +};
> +
> +static irqreturn_t hx9031as_trigger_handler(int irq, void *private)
> +{
> +	struct iio_poll_func *pf =3D private;
> +	struct iio_dev *indio_dev =3D pf->indio_dev;
> +	struct hx9031as_data *data =3D iio_priv(indio_dev);
> +	__be16 val;
> +	int bit =3D 0;
No need to set.

> +	int ii =3D 0;
> +
> +	ENTER;
> +	mutex_lock(&data->mutex);
> +
> +	hx9031as_sample();
> +	hx9031as_get_prox_state();
> +
> +	for_each_set_bit(bit, indio_dev->active_scan_mask, indio_dev->masklengt=
h) {
> +		val =3D hx9031as_pdata.diff[indio_dev->channels[bit].channel];
> +		data->buffer.channels[ii++] =3D val;
> +		PRINT_INF("bit=3D%d, ii=3D%d, val=3D%d\n", bit, ii - 1, val);
Get rid of this print.  We are pushing the data to where userspace can get =
it.
Then you also can get rid of local variable val that is making the rest
of the code harder to read.

> +	}
> +
> +	iio_push_to_buffers_with_timestamp(indio_dev, &data->buffer, pf->timest=
amp);
> +	mutex_unlock(&data->mutex);
> +
> +	iio_trigger_notify_done(indio_dev->trig);
> +	return IRQ_HANDLED;
> +}
> +
> +static int hx9031as_buffer_preenable(struct iio_dev *indio_dev)
> +{
> +	struct hx9031as_data *data =3D iio_priv(indio_dev);
> +	unsigned long channels =3D 0;
> +	int bit =3D 0;
> +
> +	ENTER;
> +	mutex_lock(&data->mutex);

guard(mutex)(&data->mutex);
appropriate here and in similar places.

> +	for_each_set_bit(bit, indio_dev->active_scan_mask, indio_dev->masklengt=
h) {
> +		__set_bit(indio_dev->channels[bit].channel, &channels);
> +	}

no {} for a loop with a single line statement.

> +
> +	hx9031as_update_chan_en(data, channels, data->chan_event);
> +	mutex_unlock(&data->mutex);
> +	return 0;
> +}
> +
> +static int hx9031as_buffer_postdisable(struct iio_dev *indio_dev)
> +{
> +	struct hx9031as_data *data =3D iio_priv(indio_dev);
> +
> +	ENTER;
> +	mutex_lock(&data->mutex);
> +	hx9031as_update_chan_en(data, 0, data->chan_event);
> +	mutex_unlock(&data->mutex);
> +	return 0;
> +}
> +
> +static const struct iio_buffer_setup_ops hx9031as_buffer_setup_ops =3D {
> +	.preenable =3D hx9031as_buffer_preenable,
> +	.postdisable =3D hx9031as_buffer_postdisable,
> +};

> +
> +static void hx9031as_regulator_disable(void *_data)
> +{
> +	struct hx9031as_data *data =3D _data;
> +
> +	ENTER;
> +	regulator_bulk_disable(ARRAY_SIZE(data->supplies), data->supplies);

As below - don't need this for a single entry + there is a
suitable function that will handle this for you without any driver
specific code.

> +}
> +
> +static int hx9031as_probe(struct i2c_client *client)
> +{
> +	int ret;
> +	struct device *dev =3D &client->dev;
> +	struct iio_dev *indio_dev;
> +	struct hx9031as_data *data;
> +
> +	PRINT_INF("driver version:%s\n", HX9031AS_DRIVER_VER);

Linux drivers do not carry version numbers.  They are fragile and people fo=
rget
to update them.  So Linux rules are you never break the userspace ABI.  Hen=
ce
why do you need a version number?

> +	PRINT_INF("client->name=3D%s, client->addr=3D0x%02X, client->irq=3D%d\n=
",
> +				client->name, client->addr, client->irq);
This is noise that does not belong in a driver submission.

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
> +
> +	ret =3D devm_regulator_bulk_get(dev, ARRAY_SIZE(data->supplies), data->=
supplies);
Not very 'bulk' with 1. =20
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
	devm_regulator_get_enabled() and no need to handle disabling yourself.

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

	if (ret)
	All errors in probe that you want to log do via
		return dev_err_probe(dev, reg, "id check failed\n"); etc


> +		PRINT_ERR("hx9031as_id_check failed\n");
> +		return ret;
> +	}
> +
> +	indio_dev->channels =3D hx9031as_channels;
> +	indio_dev->num_channels =3D ARRAY_SIZE(hx9031as_channels);
> +	indio_dev->info =3D &hx9031as_info;
> +	indio_dev->modes =3D INDIO_DIRECT_MODE;
> +	indio_dev->name =3D HX9031AS_DRIVER_NAME;
As in other cases. Put the string inline.

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

I'll guess that your tabs aren't 8 spaces in your editor?  Fix that and fix
the alignment.  scripts/checkpatch.pl would have pointed this out for you.

> +		if (ret)
> +			return ret;
> +		atomic_set(&hx9031as_pdata.irq_en, 1);
As mentioned elsewhere this seems unnecessary.  If you have an interrupt
you will probably know it's state at all places you are enabling or disabli=
ng anyway.
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
> +}
> +
> +static int __maybe_unused hx9031as_suspend(struct device *dev)
> +{
> +	//struct iio_dev *indio_dev =3D i2c_get_clientdata(to_i2c_client(dev));
> +	//struct hx9031as_data *data =3D iio_priv(indio_dev);
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
Clean up.
> +
> +	ENTER;

All stuff like this needs to go before sending upstream.

> +	hx9031as_enable_irq(hx9031as_pdata.irq);
> +	return 0;
> +}
> +
> +static SIMPLE_DEV_PM_OPS(hx9031as_pm_ops, hx9031as_suspend, hx9031as_res=
ume);
> +
> +static const struct acpi_device_id hx9031as_acpi_match[] =3D {
> +	{ HX9031AS_DRIVER_NAME, HX9031AS_CHIP_ID },
Don't use defines like this.  I want to see what that *_CHIP_ID is right
here and the HX9031AS_DRIVER_NAME is not a valid ACPI ID.
My guess is that you didn't gets this and added it without knowing
if any devices use this device ID.  For reference, ACPI ID are either

AAAA1234 where AAAA is an assigned manufacturer ID and 1234 is that
manufacturers decision for a hex ID for this particular device.


> +	{}
> +};
> +MODULE_DEVICE_TABLE(acpi, hx9031as_acpi_match);
> +
> +static const struct of_device_id hx9031as_of_match[] =3D {
> +	{ .compatible =3D "tyhx,hx9031as", (void *)HX9031AS_CHIP_ID },

DT binding document needed.

Also, why have driver data for a driver supporting on device.
Finally if you do, it wants to a be a pointer to some device type
specific data in a suitable static const structure.


> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, hx9031as_of_match);
> +
> +static const struct i2c_device_id hx9031as_id[] =3D {
> +	{ HX9031AS_DRIVER_NAME, HX9031AS_CHIP_ID },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(i2c, hx9031as_id);
> +
> +static struct i2c_driver hx9031as_driver =3D {
> +	.driver =3D {
> +		.name =3D HX9031AS_DRIVER_NAME,

Whilst this string is used in a number of places, there isn't any particular
reason they should be consistent and in some cases it will become oddly inc=
onsistent
if you add support for additional patches. I'd rather see the string used d=
irectly
at the call sites and this define dropped.

> +		.acpi_match_table =3D hx9031as_acpi_match,
> +		.of_match_table =3D hx9031as_of_match,
> +		.pm =3D &hx9031as_pm_ops,
> +		.probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
> +	},
> +	.probe =3D hx9031as_probe,
> +	.id_table =3D hx9031as_id,
> +};
> +module_i2c_driver(hx9031as_driver);
> +
> +MODULE_AUTHOR("Yasin Lee <yasin.lee.x@gmail.com>");
> +MODULE_DESCRIPTION("Driver for TYHX HX9031AS/HX9023S SAR sensor");
> +MODULE_LICENSE("GPL v2");


