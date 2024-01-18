Return-Path: <linux-iio+bounces-1747-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2321C831973
	for <lists+linux-iio@lfdr.de>; Thu, 18 Jan 2024 13:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDE1E286504
	for <lists+linux-iio@lfdr.de>; Thu, 18 Jan 2024 12:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209CA25541;
	Thu, 18 Jan 2024 12:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SK1nACrN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1363B24B5D;
	Thu, 18 Jan 2024 12:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705582213; cv=none; b=D5hT4lzGLh1dqjmQ+yArs2BWKFrQmalP++Rbdie7nptKVjP9SaYOclJJChYu68a6HC+gH2vQMw427LhW/zfxW3ebnUaiRA/s9mrR4WxhJNYN2dm9nykzw4NPLHlXPUMAhVFz1QRHItR18hsqwzxRypToNDnKbPgF8ACbc1w6bA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705582213; c=relaxed/simple;
	bh=FRv6tV+h8JN795Wy9bNLiDA+PgVgK5gBwO4IRO6XpxU=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding; b=MGK/zHz1Qfhd98jAhzviuUMso5vOIyB0NHYSa3icSXB9wzjJBg9x8T7UeWTju7KYRqdFhOW6DhrMjTjRjAG2j4xNELgMu5iF/U+7eKUskH7/yf/LQFCTLKXtq0f+m46a6uXAc59LWSeJ1AJ89LZ9UENobVLpJIYJOweZJhc9YI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SK1nACrN; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-50ea9daac4cso13131333e87.3;
        Thu, 18 Jan 2024 04:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705582209; x=1706187009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lqZXQNeDKPsK6vf839narh8zlAbtEMKzACwTvFEQ5bE=;
        b=SK1nACrNT21JNCH7dLxNFbX25oQZHwNXOVGst3PHRDFtNqWXZ3GTfNPDy0AREwWVUW
         Lelf/2fAkCowOuJrn5Omj1Iuej4QMBrkiXwMQj37v7YFbTft2QMV9QG21RiOg7lQ09HA
         pjKeZA639e+mwY1C3P8oO9lb6ji7igwaGNhSuQjAq0yOVgpyVoMoKRPvbBUKo+YvIsDp
         blBiuTvmKZQlYMMoMrH5ZvObG+eTQap2hPeVK5kd2uAmolMHg6QTTIH8jxbtK1ccUf3T
         H6ZaVtvRIPb4l8N1/uJpcyLPtHdPUtlrEd3JO3PVJdBbqpZLVAAVD7Tqj2JU2JthL2rH
         Q1Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705582209; x=1706187009;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lqZXQNeDKPsK6vf839narh8zlAbtEMKzACwTvFEQ5bE=;
        b=W9Q/Wgr+xAZ+tRevNlozpa7A8vt9WqjiGEtTgfpzTZPn6KRNppZccApX0BHuM3Yh1D
         +0bFfhwcWqMtTPvlzSZ0IULbxHVCiBlSu87SksZ+N1BO1OzpAYGXyl8mAyro0bFRZzx3
         5/X3n8pOsUTUgi6xHfgh9PhFxj1popQ+YGl3bARa85kuPaMaQsHLxkh5sGiyKQLlJMO4
         5e2hI2HyGU3utz5RxAEhEEYe5zRWdxHA9/kE+eN7d+fOOEkiJjCMBjyOJK/KpWhyNVLi
         FxDFqU8QzHiCHiPrMltxZRL6IRwv8eEQaSBZXYC1lYyUtH9rfNFezSJLh9zLdk+nAlSa
         9qng==
X-Gm-Message-State: AOJu0YzUWOhSiLdhcWFRDKJU2ZIjgRPjaVOUYFDfDyuDyny+Fk8pTXS3
	p4AcSJ2YypFQIKjlWs1bTStgNxxTsKLAnwxU9C+7Azp8vai+xzPX
X-Google-Smtp-Source: AGHT+IFlG1JwB15zExfUH1NBQI7mcjoMfwFV36NHSnTU7onZcrT3rWtQIhgrQrcStja0RLutYk0ebQ==
X-Received: by 2002:a19:5e02:0:b0:50e:db6c:f014 with SMTP id s2-20020a195e02000000b0050edb6cf014mr393997lfb.48.1705582208513;
        Thu, 18 Jan 2024 04:50:08 -0800 (PST)
Received: from HYB-hhAwRlzzMZb.ad.analog.com ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id rv25-20020a17090710d900b00a26c8c70069sm9069692ejb.48.2024.01.18.04.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 04:50:08 -0800 (PST)
From: Dumitru Ceclan <mitrutzceclan@gmail.com>
To: 
Cc: linus.walleij@linaro.org,
	brgl@bgdev.pl,
	andy@kernel.org,
	linux-gpio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Walle <michael@walle.cc>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	ChiaEn Wu <chiaen_wu@richtek.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	=?UTF-8?q?Leonard=20G=C3=B6hrs?= <l.goehrs@pengutronix.de>,
	Mike Looijmans <mike.looijmans@topic.nl>,
	Haibo Chen <haibo.chen@nxp.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	David Lechner <dlechner@baylibre.com>,
	Ceclan Dumitru <dumitru.ceclan@analog.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dumitru Ceclan <mitrutzceclan@gmail.com>
Subject: [PATCH v12 2/2] iio: adc: ad7173: add AD7173 driver
Date: Thu, 18 Jan 2024 14:49:23 +0200
Message-ID: <20240118125001.12809-2-mitrutzceclan@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240118125001.12809-1-mitrutzceclan@gmail.com>
References: <20240118125001.12809-1-mitrutzceclan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The AD7173 family offer a complete integrated Sigma-Delta ADC solution
which can be used in high precision, low noise single channel
applications or higher speed multiplexed applications. The Sigma-Delta
ADC is intended primarily for measurement of signals close to DC but also
delivers outstanding performance with input bandwidths out to ~10kHz.

Reviewed-by: Andy Shevchenko <andy@kernel.org>
Reviewed-by: Michael Walle <michael@walle.cc> # for gpio-regmap
Signed-off-by: Dumitru Ceclan <mitrutzceclan@gmail.com>
---

V11-> V12
 - rename refin, refin2 to vref, vref2
V10-> V11 <no changes>
V9 -> V10 <no changes>
V8 -> V9
 - Add '(x)' to some macro's definition to reduce NO of checks
 - Use reg 0 constant definition in debug_reg_access()
 - Rename  channels_st_priv_arr to chans_st_arr
 - Remove unnecessary u32 cast from read_raw()
 - Compute read_raw() offset instead of constant
 - Add offset comments to data rate arrays
 - Removed redundant newline in _parse_channel_config()
V7 -> V8
 - remove Kconfig commas
 - reorder include <...gpio/regmap.h>
 - GPO12_DATA(x)  from BIT(x) -> BIT(x+0)
 - use the same pointer to dev in ad7173_setup()
 - rewrite temp channel read_raw scale for better readability
 - add comment to explain temp channel offset
 - follow multi-line comment style
 - change ref_sel type to signed int
 - use fwnode_property_match_property_string()
V6 -> V7
 - format Kconfig supported models using '-'
 - include types.h instead of stddef.h
 - change device_info->num_gpios type to u8
 - reorder fields in ad7173_state, place ad_sigma_delta
 - reorder fields in ad7173_device_info, group by type
 - add default case in read_raw()
 - rename ad7173_debug() to ad7173_debug_reg_access()
 - remove explicit u8 cast
 - remove return 0; for offset in read_raw()
 - add '\n' to error messages
 - reorder probe variables -> reversed xmas tree
 - remove redundant inner commas in of_match and id_table
 - simplify selected reference code by setting default value and ignoring
   fwnode_property_read_string() error
 - use match_string() for finding selected reference
 - err on no channels specified
 - add missing fwnode_handle_put(child) on err return branches
 - remove spi_set_drvdata() from probe
 - remove offset variable from find_live_config(), not used
 - add comment showing a generic LRU implementation might be used if one
   will exist
 - MISC:  add blank line to chanel_config struct, trailing comma ref_sel_str[],
   remove blank line in update_scan_mode(), add spaces around '/'
V5->V6 <no changes>
V4 -> V5
 - List Kconfig supported models one per line
 - Include <array_size.h> and <container_of.h>
 - Remove bits.h and kernel.h include
 - Add spaces before '\' on multi-line definitions
 - Change constant definition name from "..._MICROV" to "..._uV"
 - Change ad7173_channel_config attributes order for grouping by type
 - Remove redundant {} in ad7173_gpio_init()
 - Add array with reference select strings
 - Change parsing of device tree adi,reference-select from integer to string
 - Change indentation  for ad7173_find_live_config() header
 - Use struct_group() in config struct
 - Use offsetofend() and sizeof_field() in ad7173_find_live_config()
 - Split line on logic operator in ad7173_find_live_config() at configs comparison
 - Use IDA for config slots allocation
 - Reverse xmas tree order for probe local variables
 - Use BIT() for computing bipolar channels offset
 - Change (MICRO/MILLI) to MILLI in read_raw for integer part of sampling frequency
 - MISC: remove blank line, use 0 value dirrectly, one line statement devm_kcalloc()
V3 -> V4
 - cleaned up includes
 - add ad7173_gpio_disable(), include to devm actions
 - remove iio_device_claim_direct_mode() from update_scan_mode()
 - always set differential iio_chan attribute to true, retain bipolar info only in private struct
 - store multiple regulators in state for voltage references
 - compute read_raw offset depending on channel used reference
 - configure channel setup using selected reference
 - add ad7173_get_ref_voltage_milli() 
 - clean up ad7173_fw_sparse_channel_config() changing array access of channel structs to pointers
 - retain chip name in st->info structure
 - use spi_device_get_match_data() in probe
V2 -> V3
 - change Kconfig GPIO_REGMAP and REGMAP_SPI to be conditioned by GPIOLIB
 - cast chip info to (kernel_ulong_t) to suppress warnings
 - adjust copyright year to reflect the out-of-tree history
 - remove unused sysfs and trigger header files
 - clean up defined macros by using FIELD_PREP( ) inline
 - use DECLARE_BITMAP( ) for defiining cfg_slots_status
 - use clear/set _bit instead of assign_bit
 - rename state field regmap to reg_gpiocon_regmap to better represent usage
 - replace container_of( ) usages to ad_sigma_delta_to_ad7173( )
 - improve readability of sampling frequency conversion in write_raw( )
				specifying conversion from Micro to Milli
 - use iio_device_claim_direct_mode( ) correctly in write_raw( )
 - flip logic in write_raw( ) to reduce line length
 - pass only state struct to gpio_init function
 - remove else branch at end of probe
 - remove comma after list terminator for of_match and id_table arrays
 - clarify write_raw( ) realbits 32 bit size check in a comment
 - change parsed fw property 'adi,bipolar' to 'bipolar' to matched referenced adc.yaml 
 - use reg_set_base for gpio regmap xlate 
V1 -> V2
 - keep original out-of-tree AD7173 naming
 - remove gpio_cleanup
 - handle 32bit realbits offset case
 - use iio_device_claim_direct_mode, drop own mutex
 - use dev_err_probe
 - cleanup headers include
 - use GENMASK() and FIELD_PREP()
 - use HZ_PER_MHZ
 - change #ifdef GPIOLIB to if( IS_ENABLED(CONFIG_GPIOLIB)) 
 - use gpio-regmap
 - change boolean flag in info struct to number of gpios
 - NIH memset64
 - use struct pointers for config comparison
 - use spi_write_then_read for ADC reset
 - use stack allocated buffer for reset
 - define constant for reset sequence size
 - use kcalloc instead of kzalloc
 - change of naming to fw of dt parse function
 - change de-referencing chain to local variable dev in multiple locations
 - drop write_raw_get_fmt
 - add driver private data to spi_device_id table
 - use fsleep() instead of usleep_range()
 - put config value inline
 - align read/write raw arguments
 - remove zeroed values from channel templates structure
 - define constants for temperature sensor positive and negative inputs
 - always enable temperature channel
 - configure spi clock phase and polarity from driver
 misc changes (test bit, return disable all, indentation fix, change statements to single line)

 drivers/iio/adc/Kconfig  |  17 +
 drivers/iio/adc/Makefile |   1 +
 drivers/iio/adc/ad7173.c | 974 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 992 insertions(+)
 create mode 100644 drivers/iio/adc/ad7173.c

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 3b73c509bd68..c32054afdfc4 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -70,6 +70,23 @@ config AD7124
 	  To compile this driver as a module, choose M here: the module will be
 	  called ad7124.
 
+config AD7173
+	tristate "Analog Devices AD7173 driver"
+	depends on SPI_MASTER
+	select AD_SIGMA_DELTA
+	select GPIO_REGMAP if GPIOLIB
+	select REGMAP_SPI if GPIOLIB
+	help
+	  Say yes here to build support for Analog Devices AD7173 and similar ADC
+	  Currently supported models:
+	   - AD7172-2
+	   - AD7173-8
+	   - AD7175-2
+	   - AD7176-2
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called ad7173.
+
 config AD7192
 	tristate "Analog Devices AD7190 AD7192 AD7193 AD7195 ADC driver"
 	depends on SPI
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index d2fda54a3259..dd4210a3634f 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_AD7091R) += ad7091r-base.o
 obj-$(CONFIG_AD7091R5) += ad7091r5.o
 obj-$(CONFIG_AD7091R8) += ad7091r8.o
 obj-$(CONFIG_AD7124) += ad7124.o
+obj-$(CONFIG_AD7173) += ad7173.o
 obj-$(CONFIG_AD7192) += ad7192.o
 obj-$(CONFIG_AD7266) += ad7266.o
 obj-$(CONFIG_AD7280) += ad7280a.o
diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
new file mode 100644
index 000000000000..6d3e04423969
--- /dev/null
+++ b/drivers/iio/adc/ad7173.c
@@ -0,0 +1,974 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * AD7172-2/AD7173-8/AD7175-2/AD7176-2 SPI ADC driver
+ * Copyright (C) 2015, 2023 Analog Devices, Inc.
+ */
+
+#include <linux/array_size.h>
+#include <linux/bitfield.h>
+#include <linux/bitmap.h>
+#include <linux/container_of.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/gpio/driver.h>
+#include <linux/gpio/regmap.h>
+#include <linux/idr.h>
+#include <linux/interrupt.h>
+#include <linux/math64.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/slab.h>
+#include <linux/spi/spi.h>
+#include <linux/types.h>
+#include <linux/units.h>
+
+#include <linux/iio/buffer.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
+
+#include <linux/iio/adc/ad_sigma_delta.h>
+
+#define AD7173_REG_COMMS		0x00
+#define AD7173_REG_ADC_MODE		0x01
+#define AD7173_REG_INTERFACE_MODE	0x02
+#define AD7173_REG_CRC			0x03
+#define AD7173_REG_DATA			0x04
+#define AD7173_REG_GPIO			0x06
+#define AD7173_REG_ID			0x07
+#define AD7173_REG_CH(x)		(0x10 + (x))
+#define AD7173_REG_SETUP(x)		(0x20 + (x))
+#define AD7173_REG_FILTER(x)		(0x28 + (x))
+#define AD7173_REG_OFFSET(x)		(0x30 + (x))
+#define AD7173_REG_GAIN(x)		(0x38 + (x))
+
+#define AD7173_RESET_LENGTH		BITS_TO_BYTES(64)
+
+#define AD7173_CH_ENABLE		BIT(15)
+#define AD7173_CH_SETUP_SEL_MASK	GENMASK(14, 12)
+#define AD7173_CH_SETUP_AINPOS_MASK	GENMASK(9, 5)
+#define AD7173_CH_SETUP_AINNEG_MASK	GENMASK(4, 0)
+
+#define AD7173_CH_ADDRESS(pos, neg) \
+	(FIELD_PREP(AD7173_CH_SETUP_AINPOS_MASK, pos) | \
+	 FIELD_PREP(AD7173_CH_SETUP_AINNEG_MASK, neg))
+#define AD7173_AIN_TEMP_POS	17
+#define AD7173_AIN_TEMP_NEG	18
+
+#define AD7172_ID			0x00d0
+#define AD7173_ID			0x30d0
+#define AD7175_ID			0x0cd0
+#define AD7176_ID			0x0c90
+#define AD7173_ID_MASK			GENMASK(15, 4)
+
+#define AD7173_ADC_MODE_REF_EN		BIT(15)
+#define AD7173_ADC_MODE_SING_CYC	BIT(13)
+#define AD7173_ADC_MODE_MODE_MASK	GENMASK(6, 4)
+#define AD7173_ADC_MODE_CLOCKSEL_MASK	GENMASK(3, 2)
+
+#define AD7173_GPIO_PDSW	BIT(14)
+#define AD7173_GPIO_OP_EN2_3	BIT(13)
+#define AD7173_GPIO_MUX_IO	BIT(12)
+#define AD7173_GPIO_SYNC_EN	BIT(11)
+#define AD7173_GPIO_ERR_EN	BIT(10)
+#define AD7173_GPIO_ERR_DAT	BIT(9)
+#define AD7173_GPIO_GP_DATA3	BIT(7)
+#define AD7173_GPIO_GP_DATA2	BIT(6)
+#define AD7173_GPIO_IP_EN1	BIT(5)
+#define AD7173_GPIO_IP_EN0	BIT(4)
+#define AD7173_GPIO_OP_EN1	BIT(3)
+#define AD7173_GPIO_OP_EN0	BIT(2)
+#define AD7173_GPIO_GP_DATA1	BIT(1)
+#define AD7173_GPIO_GP_DATA0	BIT(0)
+
+#define AD7173_GPO12_DATA(x)	BIT((x) + 0)
+#define AD7173_GPO23_DATA(x)	BIT((x) + 4)
+#define AD7173_GPO_DATA(x)	((x) < 2 ? AD7173_GPO12_DATA(x) : AD7173_GPO23_DATA(x))
+
+#define AD7173_INTERFACE_DATA_STAT	BIT(6)
+#define AD7173_INTERFACE_DATA_STAT_EN(x) \
+	FIELD_PREP(AD7173_INTERFACE_DATA_STAT, x)
+
+#define AD7173_SETUP_BIPOLAR		BIT(12)
+#define AD7173_SETUP_AREF_BUF_MASK	GENMASK(11, 10)
+#define AD7173_SETUP_AIN_BUF_MASK	GENMASK(9, 8)
+
+#define AD7173_SETUP_REF_SEL_MASK	GENMASK(5, 4)
+#define AD7173_SETUP_REF_SEL_AVDD1_AVSS	0x3
+#define AD7173_SETUP_REF_SEL_INT_REF	0x2
+#define AD7173_SETUP_REF_SEL_EXT_REF2	0x1
+#define AD7173_SETUP_REF_SEL_EXT_REF	0x0
+#define AD7173_VOLTAGE_INT_REF_uV	2500000
+#define AD7173_TEMP_SENSIIVITY_uV_per_C	477
+
+#define AD7173_FILTER_ODR0_MASK		GENMASK(5, 0)
+#define AD7173_MAX_CONFIGS		8
+
+enum ad7173_ids {
+	ID_AD7172_2,
+	ID_AD7173_8,
+	ID_AD7175_2,
+	ID_AD7176_2,
+};
+
+struct ad7173_device_info {
+	const unsigned int *sinc5_data_rates;
+	unsigned int num_sinc5_data_rates;
+	unsigned int num_channels;
+	unsigned int num_configs;
+	unsigned int num_inputs;
+	unsigned int clock;
+	unsigned int id;
+	char *name;
+	bool has_temp;
+	u8 num_gpios;
+};
+
+struct ad7173_channel_config {
+	u8 cfg_slot;
+	bool live;
+
+	/* Following fields are used to compare equality. */
+	struct_group(config_props,
+		bool bipolar;
+		bool input_buf;
+		u8 odr;
+		u8 ref_sel;
+	);
+};
+
+struct ad7173_channel {
+	unsigned int chan_reg;
+	unsigned int ain;
+	struct ad7173_channel_config cfg;
+};
+
+struct ad7173_state {
+	struct ad_sigma_delta sd;
+	const struct ad7173_device_info *info;
+	struct ad7173_channel *channels;
+	struct regulator_bulk_data regulators[3];
+	unsigned int adc_mode;
+	unsigned int interface_mode;
+	unsigned int num_channels;
+	struct ida cfg_slots_status;
+	unsigned long long config_usage_counter;
+	unsigned long long *config_cnts;
+#if IS_ENABLED(CONFIG_GPIOLIB)
+	struct regmap *reg_gpiocon_regmap;
+	struct gpio_regmap *gpio_regmap;
+#endif
+};
+
+static const unsigned int ad7173_sinc5_data_rates[] = {
+	6211000, 6211000, 6211000, 6211000, 6211000, 6211000, 5181000, 4444000,	/*  0-7  */
+	3115000, 2597000, 1007000, 503800,  381000,  200300,  100500,  59520,	/*  8-15 */
+	49680,	 20010,	  16333,   10000,   5000,    2500,    1250,		/* 16-22 */
+};
+
+static const unsigned int ad7175_sinc5_data_rates[] = {
+	50000000, 41667000, 31250000, 27778000,	/*  0-3  */
+	20833000, 17857000, 12500000, 10000000,	/*  4-7  */
+	5000000,  2500000,  1000000,  500000,	/*  8-11 */
+	397500,   200000,   100000,   59920,	/* 12-15 */
+	49960,    20000,    16666,    10000,	/* 16-19 */
+	5000,					/* 20    */
+};
+
+static const struct ad7173_device_info ad7173_device_info[] = {
+	[ID_AD7172_2] = {
+		.name = "ad7172-2",
+		.id = AD7172_ID,
+		.num_inputs = 5,
+		.num_channels = 4,
+		.num_configs = 4,
+		.num_gpios = 2,
+		.has_temp = true,
+		.clock = 2 * HZ_PER_MHZ,
+		.sinc5_data_rates = ad7173_sinc5_data_rates,
+		.num_sinc5_data_rates = ARRAY_SIZE(ad7173_sinc5_data_rates),
+	},
+	[ID_AD7173_8] = {
+		.name = "ad7173-8",
+		.id = AD7173_ID,
+		.num_inputs = 17,
+		.num_channels = 16,
+		.num_configs = 8,
+		.num_gpios = 4,
+		.has_temp = true,
+		.clock = 2 * HZ_PER_MHZ,
+		.sinc5_data_rates = ad7173_sinc5_data_rates,
+		.num_sinc5_data_rates = ARRAY_SIZE(ad7173_sinc5_data_rates),
+	},
+	[ID_AD7175_2] = {
+		.name = "ad7175-2",
+		.id = AD7175_ID,
+		.num_inputs = 5,
+		.num_channels = 4,
+		.num_configs = 4,
+		.num_gpios = 2,
+		.has_temp = true,
+		.clock = 16 * HZ_PER_MHZ,
+		.sinc5_data_rates = ad7175_sinc5_data_rates,
+		.num_sinc5_data_rates = ARRAY_SIZE(ad7175_sinc5_data_rates),
+	},
+	[ID_AD7176_2] = {
+		.name = "ad7176-2",
+		.id = AD7176_ID,
+		.num_inputs = 5,
+		.num_channels = 4,
+		.num_configs = 4,
+		.num_gpios = 2,
+		.has_temp = false,
+		.clock = 16 * HZ_PER_MHZ,
+		.sinc5_data_rates = ad7175_sinc5_data_rates,
+		.num_sinc5_data_rates = ARRAY_SIZE(ad7175_sinc5_data_rates),
+	},
+};
+
+static const char *const ad7173_ref_sel_str[] = {
+	[AD7173_SETUP_REF_SEL_EXT_REF]    = "vref",
+	[AD7173_SETUP_REF_SEL_EXT_REF2]   = "vref2",
+	[AD7173_SETUP_REF_SEL_INT_REF]    = "refout-avss",
+	[AD7173_SETUP_REF_SEL_AVDD1_AVSS] = "avdd",
+};
+
+#if IS_ENABLED(CONFIG_GPIOLIB)
+
+static const struct regmap_range ad7173_range_gpio[] = {
+	regmap_reg_range(AD7173_REG_GPIO, AD7173_REG_GPIO),
+};
+
+static const struct regmap_access_table ad7173_access_table = {
+	.yes_ranges = ad7173_range_gpio,
+	.n_yes_ranges = ARRAY_SIZE(ad7173_range_gpio),
+};
+
+static const struct regmap_config ad7173_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 16,
+	.rd_table = &ad7173_access_table,
+	.wr_table = &ad7173_access_table,
+	.read_flag_mask = BIT(6),
+};
+
+static int ad7173_mask_xlate(struct gpio_regmap *gpio, unsigned int base,
+			     unsigned int offset, unsigned int *reg,
+			     unsigned int *mask)
+{
+	*mask = AD7173_GPO_DATA(offset);
+	*reg = base;
+	return 0;
+}
+
+static void ad7173_gpio_disable(void *data)
+{
+	struct ad7173_state *st = data;
+	unsigned int mask;
+
+	mask = AD7173_GPIO_OP_EN0 | AD7173_GPIO_OP_EN1 | AD7173_GPIO_OP_EN2_3;
+	regmap_update_bits(st->reg_gpiocon_regmap, AD7173_REG_GPIO, mask, ~mask);
+}
+
+static int ad7173_gpio_init(struct ad7173_state *st)
+{
+	struct gpio_regmap_config gpio_regmap = {};
+	struct device *dev = &st->sd.spi->dev;
+	unsigned int mask;
+	int ret;
+
+	st->reg_gpiocon_regmap = devm_regmap_init_spi(st->sd.spi, &ad7173_regmap_config);
+	ret = PTR_ERR_OR_ZERO(st->reg_gpiocon_regmap);
+	if (ret)
+		return dev_err_probe(dev, ret, "Unable to init regmap\n");
+
+	mask = AD7173_GPIO_OP_EN0 | AD7173_GPIO_OP_EN1 | AD7173_GPIO_OP_EN2_3;
+	regmap_update_bits(st->reg_gpiocon_regmap, AD7173_REG_GPIO, mask, mask);
+
+	ret = devm_add_action_or_reset(dev, ad7173_gpio_disable, st);
+	if (ret)
+		return ret;
+
+	gpio_regmap.parent = dev;
+	gpio_regmap.regmap = st->reg_gpiocon_regmap;
+	gpio_regmap.ngpio = st->info->num_gpios;
+	gpio_regmap.reg_set_base = AD7173_REG_GPIO;
+	gpio_regmap.reg_mask_xlate = ad7173_mask_xlate;
+
+	st->gpio_regmap = devm_gpio_regmap_register(dev, &gpio_regmap);
+	ret = PTR_ERR_OR_ZERO(st->gpio_regmap);
+	if (ret)
+		return dev_err_probe(dev, ret, "Unable to init gpio-regmap\n");
+
+	return 0;
+}
+
+#endif /* CONFIG_GPIOLIB */
+
+static struct ad7173_state *ad_sigma_delta_to_ad7173(struct ad_sigma_delta *sd)
+{
+	return container_of(sd, struct ad7173_state, sd);
+}
+
+static void ad7173_ida_destroy(void *data)
+{
+	struct ad7173_state *st = data;
+
+	ida_destroy(&st->cfg_slots_status);
+}
+
+static void ad7173_reset_usage_cnts(struct ad7173_state *st)
+{
+	memset64(st->config_cnts, 0, st->info->num_configs);
+	st->config_usage_counter = 0;
+}
+
+static struct ad7173_channel_config *
+ad7173_find_live_config(struct ad7173_state *st, struct ad7173_channel_config *cfg)
+{
+	struct ad7173_channel_config *cfg_aux;
+	ptrdiff_t cmp_size;
+	int i;
+
+	cmp_size = sizeof_field(struct ad7173_channel_config, config_props);
+	for (i = 0; i < st->num_channels; i++) {
+		cfg_aux = &st->channels[i].cfg;
+
+		if (cfg_aux->live &&
+		    !memcmp(&cfg->config_props, &cfg_aux->config_props, cmp_size))
+			return cfg_aux;
+	}
+	return NULL;
+}
+
+/* Could be replaced with a generic LRU implementation */
+static int ad7173_free_config_slot_lru(struct ad7173_state *st)
+{
+	int i, lru_position = 0;
+
+	for (i = 1; i < st->info->num_configs; i++)
+		if (st->config_cnts[i] < st->config_cnts[lru_position])
+			lru_position = i;
+
+	for (i = 0; i < st->num_channels; i++)
+		if (st->channels[i].cfg.cfg_slot == lru_position)
+			st->channels[i].cfg.live = false;
+
+	ida_free(&st->cfg_slots_status, lru_position);
+	return ida_alloc(&st->cfg_slots_status, GFP_KERNEL);
+}
+
+/* Could be replaced with a generic LRU implementation */
+static int ad7173_load_config(struct ad7173_state *st,
+			      struct ad7173_channel_config *cfg)
+{
+	unsigned int config;
+	int free_cfg_slot, ret;
+
+	free_cfg_slot = ida_alloc_range(&st->cfg_slots_status, 0,
+					st->info->num_configs - 1, GFP_KERNEL);
+	if (free_cfg_slot < 0)
+		free_cfg_slot = ad7173_free_config_slot_lru(st);
+
+	cfg->cfg_slot = free_cfg_slot;
+	config = FIELD_PREP(AD7173_SETUP_REF_SEL_MASK, cfg->ref_sel);
+
+	if (cfg->bipolar)
+		config |= AD7173_SETUP_BIPOLAR;
+
+	if (cfg->input_buf)
+		config |= AD7173_SETUP_AIN_BUF_MASK;
+
+	ret = ad_sd_write_reg(&st->sd, AD7173_REG_SETUP(free_cfg_slot), 2, config);
+	if (ret)
+		return ret;
+
+	return ad_sd_write_reg(&st->sd, AD7173_REG_FILTER(free_cfg_slot), 2,
+			       AD7173_FILTER_ODR0_MASK & cfg->odr);
+}
+
+static int ad7173_config_channel(struct ad7173_state *st, int addr)
+{
+	struct ad7173_channel_config *cfg = &st->channels[addr].cfg;
+	struct ad7173_channel_config *live_cfg;
+	int ret;
+
+	if (!cfg->live) {
+		live_cfg = ad7173_find_live_config(st, cfg);
+		if (live_cfg) {
+			cfg->cfg_slot = live_cfg->cfg_slot;
+		} else {
+			ret = ad7173_load_config(st, cfg);
+			if (ret)
+				return ret;
+			cfg->live = true;
+		}
+	}
+
+	if (st->config_usage_counter == U64_MAX)
+		ad7173_reset_usage_cnts(st);
+
+	st->config_usage_counter++;
+	st->config_cnts[cfg->cfg_slot] = st->config_usage_counter;
+
+	return 0;
+}
+
+static int ad7173_set_channel(struct ad_sigma_delta *sd, unsigned int channel)
+{
+	struct ad7173_state *st = ad_sigma_delta_to_ad7173(sd);
+	unsigned int val;
+	int ret;
+
+	ret = ad7173_config_channel(st, channel);
+	if (ret)
+		return ret;
+
+	val = AD7173_CH_ENABLE |
+	      FIELD_PREP(AD7173_CH_SETUP_SEL_MASK, st->channels[channel].cfg.cfg_slot) |
+	      st->channels[channel].ain;
+
+	return ad_sd_write_reg(&st->sd, AD7173_REG_CH(channel), 2, val);
+}
+
+static int ad7173_set_mode(struct ad_sigma_delta *sd,
+			   enum ad_sigma_delta_mode mode)
+{
+	struct ad7173_state *st = ad_sigma_delta_to_ad7173(sd);
+
+	st->adc_mode &= ~AD7173_ADC_MODE_MODE_MASK;
+	st->adc_mode |= FIELD_PREP(AD7173_ADC_MODE_MODE_MASK, mode);
+
+	return ad_sd_write_reg(&st->sd, AD7173_REG_ADC_MODE, 2, st->adc_mode);
+}
+
+static int ad7173_append_status(struct ad_sigma_delta *sd, bool append)
+{
+	struct ad7173_state *st = ad_sigma_delta_to_ad7173(sd);
+	unsigned int interface_mode = st->interface_mode;
+	int ret;
+
+	interface_mode |= AD7173_INTERFACE_DATA_STAT_EN(append);
+	ret = ad_sd_write_reg(&st->sd, AD7173_REG_INTERFACE_MODE, 2, interface_mode);
+	if (ret)
+		return ret;
+
+	st->interface_mode = interface_mode;
+
+	return 0;
+}
+
+static int ad7173_disable_all(struct ad_sigma_delta *sd)
+{
+	struct ad7173_state *st = ad_sigma_delta_to_ad7173(sd);
+	int ret;
+	int i;
+
+	for (i = 0; i < st->num_channels; i++) {
+		ret = ad_sd_write_reg(sd, AD7173_REG_CH(i), 2, 0);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
+
+static struct ad_sigma_delta_info ad7173_sigma_delta_info = {
+	.set_channel = ad7173_set_channel,
+	.append_status = ad7173_append_status,
+	.disable_all = ad7173_disable_all,
+	.set_mode = ad7173_set_mode,
+	.has_registers = true,
+	.addr_shift = 0,
+	.read_mask = BIT(6),
+	.status_ch_mask = GENMASK(3, 0),
+	.data_reg = AD7173_REG_DATA,
+	.irq_flags = IRQF_TRIGGER_FALLING,
+};
+
+static int ad7173_setup(struct iio_dev *indio_dev)
+{
+	struct ad7173_state *st = iio_priv(indio_dev);
+	u8 buf[AD7173_RESET_LENGTH];
+	unsigned int id;
+	int ret;
+
+	/* reset the serial interface */
+	memset(buf, 0xff, AD7173_RESET_LENGTH);
+	ret = spi_write_then_read(st->sd.spi, buf, sizeof(buf), NULL, 0);
+	if (ret < 0)
+		return ret;
+
+	/* datasheet recommends a delay of at least 500us after reset */
+	fsleep(500);
+
+	ret = ad_sd_read_reg(&st->sd, AD7173_REG_ID, 2, &id);
+	if (ret)
+		return ret;
+
+	id &= AD7173_ID_MASK;
+	if (id != st->info->id)
+		dev_warn(&st->sd.spi->dev,
+			 "Unexpected device id: 0x%04X, expected: 0x%04X\n",
+			 id, st->info->id);
+
+	st->adc_mode |= AD7173_ADC_MODE_SING_CYC;
+	st->interface_mode = 0x0;
+
+	st->config_usage_counter = 0;
+	st->config_cnts = devm_kcalloc(&st->sd.spi->dev, st->info->num_configs,
+				       sizeof(u64), GFP_KERNEL);
+	if (!st->config_cnts)
+		return -ENOMEM;
+
+	/* All channels are enabled by default after a reset */
+	return ad7173_disable_all(&st->sd);
+}
+
+static unsigned int ad7173_get_ref_voltage_milli(struct ad7173_state *st,
+						 u8 reference_select)
+{
+	int vref;
+
+	switch (reference_select) {
+	case AD7173_SETUP_REF_SEL_EXT_REF:
+		vref = regulator_get_voltage(st->regulators[0].consumer);
+		break;
+
+	case AD7173_SETUP_REF_SEL_EXT_REF2:
+		vref = regulator_get_voltage(st->regulators[1].consumer);
+		break;
+
+	case AD7173_SETUP_REF_SEL_INT_REF:
+		vref = AD7173_VOLTAGE_INT_REF_uV;
+		break;
+
+	case AD7173_SETUP_REF_SEL_AVDD1_AVSS:
+		vref = regulator_get_voltage(st->regulators[2].consumer);
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	if (vref < 0)
+		return vref;
+
+	return vref / (MICRO / MILLI);
+}
+
+static int ad7173_read_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan,
+			   int *val, int *val2, long info)
+{
+	struct ad7173_state *st = iio_priv(indio_dev);
+	struct ad7173_channel *ch = &st->channels[chan->address];
+	unsigned int reg;
+	u64 temp;
+	int ret;
+
+	switch (info) {
+	case IIO_CHAN_INFO_RAW:
+		ret = ad_sigma_delta_single_conversion(indio_dev, chan, val);
+		if (ret < 0)
+			return ret;
+
+		/* disable channel after single conversion */
+		ret = ad_sd_write_reg(&st->sd, AD7173_REG_CH(chan->address), 2, 0);
+		if (ret < 0)
+			return ret;
+
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		if (chan->type == IIO_TEMP) {
+			temp = AD7173_VOLTAGE_INT_REF_uV * MILLI;
+			temp /= AD7173_TEMP_SENSIIVITY_uV_per_C;
+			*val = temp;
+			*val2 = chan->scan_type.realbits;
+		} else {
+			*val = ad7173_get_ref_voltage_milli(st, ch->cfg.ref_sel);
+			*val2 = chan->scan_type.realbits - !!(ch->cfg.bipolar);
+		}
+		return IIO_VAL_FRACTIONAL_LOG2;
+	case IIO_CHAN_INFO_OFFSET:
+		if (chan->type == IIO_TEMP) {
+			/* 0 Kelvin -> raw sample */
+			temp   = -ABSOLUTE_ZERO_MILLICELSIUS;
+			temp  *= AD7173_TEMP_SENSIIVITY_uV_per_C;
+			temp <<= chan->scan_type.realbits;
+			temp   = DIV_U64_ROUND_CLOSEST(temp,
+						       AD7173_VOLTAGE_INT_REF_uV *
+						       MILLI);
+			*val   = -temp;
+		} else {
+			*val = -BIT(chan->scan_type.realbits - 1);
+		}
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		reg = st->channels[chan->address].cfg.odr;
+
+		*val = st->info->sinc5_data_rates[reg] / MILLI;
+		*val2 = (st->info->sinc5_data_rates[reg] % MILLI) * (MICRO / MILLI);
+
+		return IIO_VAL_INT_PLUS_MICRO;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ad7173_write_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int val, int val2, long info)
+{
+	struct ad7173_state *st = iio_priv(indio_dev);
+	struct ad7173_channel_config *cfg;
+	unsigned int freq, i, reg;
+	int ret;
+
+	ret = iio_device_claim_direct_mode(indio_dev);
+	if (ret)
+		return ret;
+
+	switch (info) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		freq = val * MILLI + val2 / MILLI;
+		for (i = 0; i < st->info->num_sinc5_data_rates - 1; i++)
+			if (freq >= st->info->sinc5_data_rates[i])
+				break;
+
+		cfg = &st->channels[chan->address].cfg;
+		cfg->odr = i;
+
+		if (!cfg->live)
+			break;
+
+		ret = ad_sd_read_reg(&st->sd, AD7173_REG_FILTER(cfg->cfg_slot), 2, &reg);
+		if (ret)
+			break;
+		reg &= ~AD7173_FILTER_ODR0_MASK;
+		reg |= FIELD_PREP(AD7173_FILTER_ODR0_MASK, i);
+		ret = ad_sd_write_reg(&st->sd, AD7173_REG_FILTER(cfg->cfg_slot), 2, reg);
+		break;
+
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	iio_device_release_direct_mode(indio_dev);
+	return ret;
+}
+
+static int ad7173_update_scan_mode(struct iio_dev *indio_dev,
+				   const unsigned long *scan_mask)
+{
+	struct ad7173_state *st = iio_priv(indio_dev);
+	int i, ret;
+
+	for (i = 0; i < indio_dev->num_channels; i++) {
+		if (test_bit(i, scan_mask))
+			ret = ad7173_set_channel(&st->sd, i);
+		else
+			ret = ad_sd_write_reg(&st->sd, AD7173_REG_CH(i), 2, 0);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int ad7173_debug_reg_access(struct iio_dev *indio_dev, unsigned int reg,
+				   unsigned int writeval, unsigned int *readval)
+{
+	struct ad7173_state *st = iio_priv(indio_dev);
+	u8 reg_size;
+
+	if (reg == AD7173_REG_COMMS)
+		reg_size = 1;
+	else if (reg == AD7173_REG_CRC || reg == AD7173_REG_DATA ||
+		 reg >= AD7173_REG_OFFSET(0))
+		reg_size = 3;
+	else
+		reg_size = 2;
+
+	if (readval)
+		return ad_sd_read_reg(&st->sd, reg, reg_size, readval);
+
+	return ad_sd_write_reg(&st->sd, reg, reg_size, writeval);
+}
+
+static const struct iio_info ad7173_info = {
+	.read_raw = &ad7173_read_raw,
+	.write_raw = &ad7173_write_raw,
+	.debugfs_reg_access = &ad7173_debug_reg_access,
+	.validate_trigger = ad_sd_validate_trigger,
+	.update_scan_mode = ad7173_update_scan_mode,
+};
+
+static const struct iio_chan_spec ad7173_channel_template = {
+	.type = IIO_VOLTAGE,
+	.indexed = 1,
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+		BIT(IIO_CHAN_INFO_SCALE),
+	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
+	.scan_type = {
+		.sign = 'u',
+		.realbits = 24,
+		.storagebits = 32,
+		.endianness = IIO_BE,
+	},
+};
+
+static const struct iio_chan_spec ad7173_temp_iio_channel_template = {
+	.type = IIO_TEMP,
+	.indexed = 1,
+	.channel = AD7173_AIN_TEMP_POS,
+	.channel2 = AD7173_AIN_TEMP_NEG,
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+		BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_OFFSET),
+	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
+	.scan_type = {
+		.sign = 'u',
+		.realbits = 24,
+		.storagebits = 32,
+		.endianness = IIO_BE,
+	},
+};
+
+static void ad7173_disable_regulators(void *data)
+{
+	struct ad7173_state *st = data;
+
+	regulator_bulk_disable(ARRAY_SIZE(st->regulators), st->regulators);
+}
+
+static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
+{
+	struct ad7173_channel *chans_st_arr, *chan_st_priv;
+	struct ad7173_state *st = iio_priv(indio_dev);
+	struct device *dev = indio_dev->dev.parent;
+	struct iio_chan_spec *chan_arr, *chan;
+	struct fwnode_handle *child;
+	unsigned int ain[2], chan_index = 0;
+	unsigned int num_channels;
+	int ref_sel;
+	int ret;
+
+	st->regulators[0].supply = ad7173_ref_sel_str[AD7173_SETUP_REF_SEL_EXT_REF];
+	st->regulators[1].supply = ad7173_ref_sel_str[AD7173_SETUP_REF_SEL_EXT_REF2];
+	st->regulators[2].supply = ad7173_ref_sel_str[AD7173_SETUP_REF_SEL_AVDD1_AVSS];
+
+	/*
+	 * If a regulator is not available, it will be set to a dummy regulator.
+	 * Each channel reference is checked with regulator_get_voltage() before
+	 * setting attributes so if any channel uses a dummy supply the driver
+	 * probe will fail.
+	 */
+	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(st->regulators),
+				      st->regulators);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to get regulators\n");
+
+	ret = regulator_bulk_enable(ARRAY_SIZE(st->regulators), st->regulators);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to enable regulators\n");
+
+	ret = devm_add_action_or_reset(dev, ad7173_disable_regulators, st);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to add regulators disable action\n");
+
+	num_channels = device_get_child_node_count(dev);
+
+	if (st->info->has_temp)
+		num_channels++;
+
+	if (num_channels == 0)
+		return dev_err_probe(dev, -EINVAL, "No channels specified\n");
+	st->num_channels = num_channels;
+
+	chan_arr = devm_kcalloc(dev, sizeof(*chan_arr), num_channels, GFP_KERNEL);
+	if (!chan_arr)
+		return -ENOMEM;
+
+	chans_st_arr = devm_kcalloc(dev, num_channels, sizeof(*chans_st_arr),
+				    GFP_KERNEL);
+	if (!chans_st_arr)
+		return -ENOMEM;
+
+	indio_dev->channels = chan_arr;
+	indio_dev->num_channels = num_channels;
+	st->channels = chans_st_arr;
+
+	if (st->info->has_temp) {
+		chan_arr[chan_index] = ad7173_temp_iio_channel_template;
+		chan_st_priv = &chans_st_arr[chan_index];
+		chan_st_priv->ain =
+			AD7173_CH_ADDRESS(chan_arr[chan_index].channel, chan_arr[chan_index].channel2);
+		chan_st_priv->cfg.bipolar = false;
+		chan_st_priv->cfg.input_buf = true;
+		chan_st_priv->cfg.ref_sel = AD7173_SETUP_REF_SEL_INT_REF;
+		st->adc_mode |= AD7173_ADC_MODE_REF_EN;
+
+		chan_index++;
+	}
+
+	device_for_each_child_node(dev, child) {
+		chan = &chan_arr[chan_index];
+		chan_st_priv = &chans_st_arr[chan_index];
+		ret = fwnode_property_read_u32_array(child, "diff-channels",
+						     ain, ARRAY_SIZE(ain));
+		if (ret) {
+			fwnode_handle_put(child);
+			return ret;
+		}
+
+		if (ain[0] >= st->info->num_inputs ||
+		    ain[1] >= st->info->num_inputs) {
+			fwnode_handle_put(child);
+			return dev_err_probe(dev, -EINVAL,
+					     "Input pin number out of range for pair (%d %d).\n",
+					     ain[0], ain[1]);
+		}
+
+		ret = fwnode_property_match_property_string(child,
+							    "adi,reference-select",
+							    ad7173_ref_sel_str,
+							    ARRAY_SIZE(ad7173_ref_sel_str));
+		if (ret < 0)
+			ref_sel = AD7173_SETUP_REF_SEL_INT_REF;
+		else
+			ref_sel = ret;
+
+		if (ref_sel == AD7173_SETUP_REF_SEL_EXT_REF2 &&
+		    st->info->id != AD7173_ID) {
+			fwnode_handle_put(child);
+			return dev_err_probe(dev, -EINVAL, "External reference 2 is only available on ad7173-8\n");
+		}
+
+		ret = ad7173_get_ref_voltage_milli(st, ref_sel);
+		if (ret < 0) {
+			fwnode_handle_put(child);
+			return dev_err_probe(dev, ret,
+					     "Cannot use reference %u\n", ref_sel);
+		}
+		if (ref_sel == AD7173_SETUP_REF_SEL_INT_REF)
+			st->adc_mode |= AD7173_ADC_MODE_REF_EN;
+		chan_st_priv->cfg.ref_sel = ref_sel;
+
+		*chan = ad7173_channel_template;
+		chan->address = chan_index;
+		chan->scan_index = chan_index;
+		chan->channel = ain[0];
+		chan->channel2 = ain[1];
+		chan->differential = true;
+
+		chan_st_priv->ain = AD7173_CH_ADDRESS(ain[0], ain[1]);
+		chan_st_priv->chan_reg = chan_index;
+		chan_st_priv->cfg.input_buf = true;
+		chan_st_priv->cfg.odr = 0;
+
+		chan_st_priv->cfg.bipolar = fwnode_property_read_bool(child, "bipolar");
+		if (chan_st_priv->cfg.bipolar)
+			chan->info_mask_separate |= BIT(IIO_CHAN_INFO_OFFSET);
+
+		chan_index++;
+	}
+
+	return 0;
+}
+
+static int ad7173_probe(struct spi_device *spi)
+{
+	struct device *dev = &spi->dev;
+	struct ad7173_state *st;
+	struct iio_dev *indio_dev;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	st = iio_priv(indio_dev);
+	st->info = spi_get_device_match_data(spi);
+	if (!st->info)
+		return -ENODEV;
+
+	ida_init(&st->cfg_slots_status);
+	ret = devm_add_action_or_reset(dev, ad7173_ida_destroy, st);
+	if (ret)
+		return ret;
+
+	indio_dev->name = st->info->name;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->info = &ad7173_info;
+
+	spi->mode = SPI_MODE_3;
+
+	ad7173_sigma_delta_info.num_slots = st->info->num_configs;
+	ret = ad_sd_init(&st->sd, indio_dev, spi, &ad7173_sigma_delta_info);
+	if (ret)
+		return ret;
+
+	ret = ad7173_fw_parse_channel_config(indio_dev);
+	if (ret)
+		return ret;
+
+	ret = devm_ad_sd_setup_buffer_and_trigger(dev, indio_dev);
+	if (ret)
+		return ret;
+
+	ret = ad7173_setup(indio_dev);
+	if (ret)
+		return ret;
+
+	ret = devm_iio_device_register(dev, indio_dev);
+	if (ret)
+		return ret;
+
+	if (IS_ENABLED(CONFIG_GPIOLIB))
+		return ad7173_gpio_init(st);
+
+	return 0;
+}
+
+static const struct of_device_id ad7173_of_match[] = {
+	{ .compatible = "adi,ad7172-2",
+	  .data = &ad7173_device_info[ID_AD7172_2]},
+	{ .compatible = "adi,ad7173-8",
+	  .data = &ad7173_device_info[ID_AD7173_8]},
+	{ .compatible = "adi,ad7175-2",
+	  .data = &ad7173_device_info[ID_AD7175_2]},
+	{ .compatible = "adi,ad7176-2",
+	  .data = &ad7173_device_info[ID_AD7176_2]},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ad7173_of_match);
+
+static const struct spi_device_id ad7173_id_table[] = {
+	{ "ad7172-2", (kernel_ulong_t)&ad7173_device_info[ID_AD7172_2]},
+	{ "ad7173-8", (kernel_ulong_t)&ad7173_device_info[ID_AD7173_8]},
+	{ "ad7175-2", (kernel_ulong_t)&ad7173_device_info[ID_AD7175_2]},
+	{ "ad7176-2", (kernel_ulong_t)&ad7173_device_info[ID_AD7176_2]},
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, ad7173_id_table);
+
+static struct spi_driver ad7173_driver = {
+	.driver = {
+		.name	= "ad7173",
+		.of_match_table = ad7173_of_match,
+	},
+	.probe		= ad7173_probe,
+	.id_table	= ad7173_id_table,
+};
+module_spi_driver(ad7173_driver);
+
+MODULE_AUTHOR("Lars-Peter Clausen <lars@metafo.de>");
+MODULE_AUTHOR("Dumitru Ceclan <dumitru.ceclan@analog.com>");
+MODULE_DESCRIPTION("Analog Devices AD7172/AD7173/AD7175/AD7176 ADC driver");
+MODULE_LICENSE("GPL");
-- 
2.42.0


