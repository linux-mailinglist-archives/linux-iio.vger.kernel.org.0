Return-Path: <linux-iio+bounces-15780-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F6C7A3BE1E
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2025 13:32:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0EAC1785B2
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2025 12:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD191E04BE;
	Wed, 19 Feb 2025 12:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e6ndQ2Uq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302871D52B;
	Wed, 19 Feb 2025 12:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739968254; cv=none; b=JVCQRcBZAcZ89pQ+jO9G1VbFb0XgXrmix/3syOFILEeTxzP1Fcalaa1IbGx1UXd/ekPTnaJYvrMFLX2IAc6Abh6dGoYEVj6o+03BTmPjeRiqLdsxDLXWCmIDmh1YBYdGJPhGfc+RhnXHWNnHq34WoPIojfJKQxK1LKJKyBRnPKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739968254; c=relaxed/simple;
	bh=d9JhYXsnghcz2/KgqFgHowXqg7hEZF+JzXfMfoHMC50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=diK6ry8ml/4cBSkqR7UufhiBTRKJyd+8Z0xEU6uwNBrDy0Cr7Pq6ISfaPEfv2id6SqwkJyxM09F6PYdtz2XqShFNmx4w2sz6NIaorR7OxZINoD+30vNs6JYBU+Uadui/vrjzqt0C8AzbEf9ifiktvYrJZ6RMuXePpOoABt2iuTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e6ndQ2Uq; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-307d1ab59c6so69334671fa.1;
        Wed, 19 Feb 2025 04:30:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739968249; x=1740573049; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WeZIae6i5fqo6f26wLpjChgiIOLzZTNNStJ9CeilpHA=;
        b=e6ndQ2UqDu1AN9RuHEit40N7rhbuktSleJicOf6M5OyPUPM+ZntwO8Z7bRIoxTeWs4
         +d2z6XUGBjRoUKSbmSYrH3SHGc9c2RttZcElHPfTgE0zi+rPoyDZimoxmyhIZj1HPNVg
         /lVFWKTgbkYGkCNTcoehI+Kl2qh1GFjfTTIGtShE+jKX7Oy+teN+KIeE1hA5m247zSyg
         O6JPnPpMzzmUls6siSbUWR1M9+HFVxTvy510+ywmSbzf307lvr1brxAuHMpV/oAPKWJZ
         O2mPZ59CYJXxlqJa40ZLvkc5tb/vB6Q7kSXCAVHYTzL9vUhCcZCCiYWkecG6ZaF4Ivxo
         iaUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739968249; x=1740573049;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WeZIae6i5fqo6f26wLpjChgiIOLzZTNNStJ9CeilpHA=;
        b=xGrH6HxJ+pN8Monr0bH4n/oWC22XCw3BTuEF8PRY8Vdjxm+0BHft16RlcrL6leFZfi
         rYot/3S5j03qwlf+jgFF6ngXDeXOJc+esTlvFfH3Lb7acd4IlIfLm1SGEelKcrPeMVtB
         H+RWrOC1YWbFk/08JPfQkV07iJfEVr5oba8BcSy0Iz/aSDtvX2IckPnKoi6yObE29ptz
         j5CjQRUFcf1cdsWCaOzjdg64bnhhaRVd/EQU7BM/mRA0clQBhvKfleBzD0/LatmTAJdo
         u1NUOhcCBAZvqvrATgZabuKcORTZ9Z3sa81/BMutpqkL3jtwTYd3q5XfirxQz6KbVICP
         bP8w==
X-Forwarded-Encrypted: i=1; AJvYcCUmNpQ7c+HCATjeGMXxkKjlpaF4mC6/TCHNPc5H7XpqQphyz1RaVICINyQ83fBIC4nxr2LumRClq78G/o2kbgELfjA=@vger.kernel.org, AJvYcCVF8SBahETrtxRIgdUKYQUJfIKmGhwOaAgxM5qA44k+gvvm9dKgzPJ/z905V+PteX48gJdfkytAWYMh@vger.kernel.org, AJvYcCWmxALlpOtYCfGaKEFy+hE9s4T8Mob+OPtSpZjQDcGOTdrwV480sD1mP4QmgKB8B8Lt8Yhd+FhGlRNVpX6Z@vger.kernel.org, AJvYcCXny2wKnGgGx7XFrHm9dIv7TwWTK+sSw31uPb4QHjnKF76s70jES60F1C7uxWcje6xMzYdLOixkvRhG@vger.kernel.org
X-Gm-Message-State: AOJu0YyExNePtBgO/eSNem8K1A39INQVEyVvuLReepIntwrNTWqaTEHq
	qID7pq8koIDnQngVuLtqdVqQccW+9p9mKNjiCNWXDxJiA1yqde5+
X-Gm-Gg: ASbGncuPUbpLEd+NpLJz2RIlZCPQMD3LBKCwTl1GN+0arhq107mjDZwafs1TM8e7sBc
	b64oK7lH2XuLRYqI4uIgLiOcCD/zmLyHTIxQBHaGyI8zIGDqIzSdc7OP4xbYtddfYRHCftlyuTH
	gUyQZV1L7LPsbqxJPqRRcnWyOlayGHSw38uQ2vnUlWXCCSBnPPfIbB+zlEtO+ies0afZS91OQVu
	jPMrv1lBlDZeqxNjxip+DHUVGo1T3Uk5lF6MkpbUgKPzexj39doTlFti26fHwS5rzQYA9p3C6/d
	SvL/nVV4fHBbKseo2LdJuQ==
X-Google-Smtp-Source: AGHT+IGTaJj8u1LcvL8BuKsGXZMBSiCm3qLQBrpBq0Nmi0BjPPHFUYblnxDkNMNFCesuFVIfv7JMCA==
X-Received: by 2002:a05:6512:3195:b0:545:aa5:d451 with SMTP id 2adb3069b0e04-5462eef47d6mr1245794e87.25.1739968248680;
        Wed, 19 Feb 2025 04:30:48 -0800 (PST)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5452d4fe147sm1715642e87.182.2025.02.19.04.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 04:30:47 -0800 (PST)
Date: Wed, 19 Feb 2025 14:30:43 +0200
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Nuno Sa <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v3 3/9] iio: adc: Support ROHM BD79124 ADC
Message-ID: <67b7713724d7591f6321a8f5dfef8cd711f38d34.1739967040.git.mazziesaccount@gmail.com>
References: <cover.1739967040.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Zz7rcAroFuTg3TKM"
Content-Disposition: inline
In-Reply-To: <cover.1739967040.git.mazziesaccount@gmail.com>


--Zz7rcAroFuTg3TKM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The ROHM BD79124 is a 12-bit, 8-channel, SAR ADC. The ADC supports
an automatic measurement mode, with an alarm interrupt for out-of-window
measurements. The window is configurable for each channel.

The I2C protocol for manual start of the measurement and data reading is
somewhat peculiar. It requires the master to do clock stretching after
sending the I2C slave-address until the slave has captured the data.
Needless to say this is not well suopported by the I2C controllers.

Thus the driver does not support the BD79124's manual measurement mode
but implements the measurements using automatic measurement mode relying
on the BD79124's ability of storing latest measurements into register.

The driver does also support configuring the threshold events for
detecting the out-of-window events.

The BD79124 keeps asserting IRQ for as long as the measured voltage is
out of the configured window. Thus the driver masks the received event
for a fixed duration (1 second) when an event is handled. This prevents
the user-space from choking on the events

The ADC input pins can be also configured as general purpose outputs.
Those pins which don't have corresponding ADC channel node in the
device-tree will be controllable as GPO.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
Revision history:
v2 =3D> v3:
 - Fix uninitialized return value reported by the kernel test robot
 - Fix indent
 - Adapt to adc-helper changes supporting also single-ended and
   differential channels
RFC v1 =3D> v2:
 - Add event throttling (constant delay of 1 sec)
 - rename variable 'd' to 'data'
 - Use ADC helpers to detect pins used for ADC
 - bd79124 drop MFD and pinmux && handle GPO in this driver
 - Drop adc suffix from the IIO file name
---
 drivers/iio/adc/Kconfig        |   12 +
 drivers/iio/adc/Makefile       |    1 +
 drivers/iio/adc/rohm-bd79124.c | 1162 ++++++++++++++++++++++++++++++++
 3 files changed, 1175 insertions(+)
 create mode 100644 drivers/iio/adc/rohm-bd79124.c

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 37b70a65da6f..a2a36a4ec644 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1191,6 +1191,18 @@ config RN5T618_ADC
 	  This driver can also be built as a module. If so, the module
 	  will be called rn5t618-adc.
=20
+config ROHM_BD79124
+	tristate "Rohm BD79124 ADC driver"
+	depends on I2C
+	select REGMAP_I2C
+	select IIO_ADC_HELPER
+	help
+	  Say yes here to build support for the ROHM BD79124 ADC. The
+	  ROHM BD79124 is a 12-bit, 8-channel, SAR ADC. The ADC supports
+	  also an automatic measurement mode, with an alarm interrupt for
+	  out-of-window measurements. The window is configurable for each
+	  channel.
+
 config ROCKCHIP_SARADC
 	tristate "Rockchip SARADC driver"
 	depends on ARCH_ROCKCHIP || COMPILE_TEST
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 956c121a7544..43f159aba390 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -108,6 +108,7 @@ obj-$(CONFIG_QCOM_VADC_COMMON) +=3D qcom-vadc-common.o
 obj-$(CONFIG_RCAR_GYRO_ADC) +=3D rcar-gyroadc.o
 obj-$(CONFIG_RICHTEK_RTQ6056) +=3D rtq6056.o
 obj-$(CONFIG_RN5T618_ADC) +=3D rn5t618-adc.o
+obj-$(CONFIG_ROHM_BD79124) +=3D rohm-bd79124.o
 obj-$(CONFIG_ROCKCHIP_SARADC) +=3D rockchip_saradc.o
 obj-$(CONFIG_RZG2L_ADC) +=3D rzg2l_adc.o
 obj-$(CONFIG_SC27XX_ADC) +=3D sc27xx_adc.o
diff --git a/drivers/iio/adc/rohm-bd79124.c b/drivers/iio/adc/rohm-bd79124.c
new file mode 100644
index 000000000000..5e23bc8d9ce2
--- /dev/null
+++ b/drivers/iio/adc/rohm-bd79124.c
@@ -0,0 +1,1162 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * ROHM ADC driver for BD79124 ADC/GPO device
+ * https://fscdn.rohm.com/en/products/databook/datasheet/ic/data_converter=
/dac/bd79124muf-c-e.pdf
+ *
+ * Copyright (c) 2025, ROHM Semiconductor.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bitmap.h>
+#include <linux/bits.h>
+#include <linux/byteorder/generic.h>
+#include <linux/device.h>
+#include <linux/delay.h>
+#include <linux/devm-helpers.h>
+#include <linux/err.h>
+#include <linux/gpio/driver.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/irqreturn.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/regmap.h>
+#include <linux/types.h>
+
+#include <linux/iio/events.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/adc-helpers.h>
+
+#define BD79124_I2C_MULTI_READ		0x30
+#define BD79124_I2C_MULTI_WRITE		0x28
+#define BD79124_REG_MAX			0xaf
+
+#define BD79124_REG_SYSTEM_STATUS	0x0
+#define BD79124_REG_GEN_CFG		0x01
+#define BD79124_REG_OPMODE_CFG		0x04
+#define BD79124_REG_PINCFG		0x05
+#define BD79124_REG_GPO_VAL		0x0B
+#define BD79124_REG_SEQUENCE_CFG	0x10
+#define BD79124_REG_MANUAL_CHANNELS	0x11
+#define BD79124_REG_AUTO_CHANNELS	0x12
+#define BD79124_REG_ALERT_CH_SEL	0x14
+#define BD79124_REG_EVENT_FLAG		0x18
+#define BD79124_REG_EVENT_FLAG_HI	0x1a
+#define BD79124_REG_EVENT_FLAG_LO	0x1c
+#define BD79124_REG_HYSTERESIS_CH0	0x20
+#define BD79124_REG_EVENTCOUNT_CH0	0x22
+#define BD79124_REG_RECENT_CH0_LSB	0xa0
+#define BD79124_REG_RECENT_CH7_MSB	0xaf
+
+#define BD79124_ADC_BITS 12
+#define BD79124_MASK_CONV_MODE GENMASK(6, 5)
+#define BD79124_MASK_AUTO_INTERVAL GENMASK(1, 0)
+#define BD79124_CONV_MODE_MANSEQ 0
+#define BD79124_CONV_MODE_AUTO 1
+#define BD79124_INTERVAL_075 0
+#define BD79124_INTERVAL_150 1
+#define BD79124_INTERVAL_300 2
+#define BD79124_INTERVAL_600 3
+
+#define BD79124_MASK_DWC_EN BIT(4)
+#define BD79124_MASK_STATS_EN BIT(5)
+#define BD79124_MASK_SEQ_START BIT(4)
+#define BD79124_MASK_SEQ_MODE GENMASK(1, 0)
+#define BD79124_MASK_SEQ_MANUAL 0
+#define BD79124_MASK_SEQ_SEQ 1
+
+#define BD79124_MASK_HYSTERESIS GENMASK(3, 0)
+#define BD79124_LOW_LIMIT_MIN 0
+#define BD79124_HIGH_LIMIT_MAX GENMASK(11, 0)
+
+/*
+ * The high limit, low limit and last measurement result are each stored in
+ * 2 consequtive registers. 4 bits are in the high bits of the 1.st regist=
er
+ * and 8 bits in the next register.
+ *
+ * These macros return the address of the 1.st reg for the given channel
+ */
+#define BD79124_GET_HIGH_LIMIT_REG(ch) (BD79124_REG_HYSTERESIS_CH0 + (ch) =
* 4)
+#define BD79124_GET_LOW_LIMIT_REG(ch) (BD79124_REG_EVENTCOUNT_CH0 + (ch) *=
 4)
+#define BD79124_GET_LIMIT_REG(ch, dir) ((dir) =3D=3D IIO_EV_DIR_RISING ?		\
+		BD79124_GET_HIGH_LIMIT_REG(ch) : BD79124_GET_LOW_LIMIT_REG(ch))
+#define BD79124_GET_RECENT_RES_REG(ch) (BD79124_REG_RECENT_CH0_LSB + (ch) =
* 2)
+
+/*
+ * The hysteresis for a channel is stored in the same register where the
+ * 4 bits of high limit reside.
+ */
+#define BD79124_GET_HYSTERESIS_REG(ch) BD79124_GET_HIGH_LIMIT_REG(ch)
+
+#define BD79124_MAX_NUM_CHANNELS 8
+
+/*
+ * We require the "reg" property and allow no other
+ * channel specifiers for the BD79124.
+ */
+static const struct iio_adc_props expected_props =3D {
+	.required =3D IIO_ADC_CHAN_PROP_TYPE_REG,
+};
+
+struct bd79124_data {
+	s64 timestamp;
+	struct regmap *map;
+	struct device *dev;
+	int vmax;
+	/*
+	 * Keep measurement status so read_raw() knows if the measurement needs
+	 * to be started.
+	 */
+	int alarm_monitored[BD79124_MAX_NUM_CHANNELS];
+	/*
+	 * The BD79124 does not allow disabling/enabling limit separately for
+	 * one direction only. Hence, we do the disabling by changing the limit
+	 * to maximum/minimum measurable value. This means we need to cache
+	 * the limit in order to maintain it over the time limit is disabled.
+	 */
+	u16 alarm_r_limit[BD79124_MAX_NUM_CHANNELS];
+	u16 alarm_f_limit[BD79124_MAX_NUM_CHANNELS];
+	/* Bitmask of disabled events (for rate limiting) for each channel. */
+	int alarm_suppressed[BD79124_MAX_NUM_CHANNELS];
+	/*
+	 * The BD79124 is configured to run the measurements in the background.
+	 * This is done for the event monitoring as well as for the read_raw().
+	 * Protect the measurement starting/stopping using a mutex.
+	 */
+	struct mutex mutex;
+	struct delayed_work alm_enable_work;
+	struct gpio_chip gc;
+};
+
+/* Read-only regs */
+static const struct regmap_range bd79124_ro_ranges[] =3D {
+	{
+		.range_min =3D BD79124_REG_EVENT_FLAG,
+		.range_max =3D BD79124_REG_EVENT_FLAG,
+	}, {
+		.range_min =3D BD79124_REG_RECENT_CH0_LSB,
+		.range_max =3D BD79124_REG_RECENT_CH7_MSB,
+	},
+};
+
+static const struct regmap_access_table bd79124_ro_regs =3D {
+	.no_ranges	=3D &bd79124_ro_ranges[0],
+	.n_no_ranges	=3D ARRAY_SIZE(bd79124_ro_ranges),
+};
+
+static const struct regmap_range bd79124_volatile_ranges[] =3D {
+	{
+		.range_min =3D BD79124_REG_RECENT_CH0_LSB,
+		.range_max =3D BD79124_REG_RECENT_CH7_MSB,
+	}, {
+		.range_min =3D BD79124_REG_EVENT_FLAG,
+		.range_max =3D BD79124_REG_EVENT_FLAG,
+	}, {
+		.range_min =3D BD79124_REG_EVENT_FLAG_HI,
+		.range_max =3D BD79124_REG_EVENT_FLAG_HI,
+	}, {
+		.range_min =3D BD79124_REG_EVENT_FLAG_LO,
+		.range_max =3D BD79124_REG_EVENT_FLAG_LO,
+	}, {
+		.range_min =3D BD79124_REG_SYSTEM_STATUS,
+		.range_max =3D BD79124_REG_SYSTEM_STATUS,
+	},
+};
+
+static const struct regmap_access_table bd79124_volatile_regs =3D {
+	.yes_ranges	=3D &bd79124_volatile_ranges[0],
+	.n_yes_ranges	=3D ARRAY_SIZE(bd79124_volatile_ranges),
+};
+
+static const struct regmap_range bd79124_precious_ranges[] =3D {
+	{
+		.range_min =3D BD79124_REG_EVENT_FLAG_HI,
+		.range_max =3D BD79124_REG_EVENT_FLAG_HI,
+	}, {
+		.range_min =3D BD79124_REG_EVENT_FLAG_LO,
+		.range_max =3D BD79124_REG_EVENT_FLAG_LO,
+	},
+};
+
+static const struct regmap_access_table bd79124_precious_regs =3D {
+	.yes_ranges	=3D &bd79124_precious_ranges[0],
+	.n_yes_ranges	=3D ARRAY_SIZE(bd79124_precious_ranges),
+};
+
+static const struct regmap_config bd79124_regmap =3D {
+	.reg_bits		=3D 16,
+	.val_bits		=3D 8,
+	.read_flag_mask		=3D BD79124_I2C_MULTI_READ,
+	.write_flag_mask	=3D BD79124_I2C_MULTI_WRITE,
+	.max_register		=3D BD79124_REG_MAX,
+	.cache_type		=3D REGCACHE_MAPLE,
+	.volatile_table		=3D &bd79124_volatile_regs,
+	.wr_table		=3D &bd79124_ro_regs,
+	.precious_table		=3D &bd79124_precious_regs,
+};
+
+static int bd79124gpo_direction_get(struct gpio_chip *gc, unsigned int off=
set)
+{
+	return GPIO_LINE_DIRECTION_OUT;
+}
+
+static void bd79124gpo_set(struct gpio_chip *gc, unsigned int offset, int =
value)
+{
+	struct bd79124_data *data =3D gpiochip_get_data(gc);
+
+	if (value)
+		regmap_set_bits(data->map, BD79124_REG_GPO_VAL, BIT(offset));
+	else
+		regmap_clear_bits(data->map, BD79124_REG_GPO_VAL, BIT(offset));
+}
+
+static void bd79124gpo_set_multiple(struct gpio_chip *gc, unsigned long *m=
ask,
+				   unsigned long *bits)
+{
+	int ret, val;
+	struct bd79124_data *data =3D gpiochip_get_data(gc);
+
+	/* Ensure all GPIOs in 'mask' are set to be GPIOs */
+	ret =3D regmap_read(data->map, BD79124_REG_PINCFG, &val);
+	if (ret)
+		return;
+
+	if ((val & *mask) !=3D *mask) {
+		dev_dbg(data->dev, "Invalid mux config. Can't set value.\n");
+		/* Do not set value for pins configured as ADC inputs */
+		*mask &=3D val;
+	}
+
+	regmap_update_bits(data->map, BD79124_REG_GPO_VAL, *mask, *bits);
+}
+
+static int bd79124_init_valid_mask(struct gpio_chip *gc,
+				   unsigned long *valid_mask,
+				   unsigned int ngpios)
+{
+	int adc_channels[BD79124_MAX_NUM_CHANNELS];
+	int ret, num_channels, gpo_chan, j;
+
+	*valid_mask =3D 0;
+
+	ret =3D iio_adc_device_channels_by_property(gc->parent, adc_channels,
+						  BD79124_MAX_NUM_CHANNELS,
+						  &expected_props);
+	if (ret < 0)
+		return ret;
+
+	num_channels =3D ret;
+
+	for (gpo_chan =3D 0; gpo_chan < BD79124_MAX_NUM_CHANNELS; gpo_chan++) {
+		for (j =3D 0; j < num_channels; j++) {
+			if (adc_channels[j] =3D=3D gpo_chan)
+				break;
+		}
+		if (j =3D=3D num_channels)
+			*valid_mask |=3D BIT(gpo_chan);
+	}
+
+	return 0;
+}
+
+/* Template for GPIO chip */
+static const struct gpio_chip bd79124gpo_chip =3D {
+	.label			=3D "bd79124-gpo",
+	.get_direction		=3D bd79124gpo_direction_get,
+	.set			=3D bd79124gpo_set,
+	.set_multiple		=3D bd79124gpo_set_multiple,
+	.init_valid_mask	=3D bd79124_init_valid_mask,
+	.can_sleep		=3D true,
+	.ngpio			=3D 8,
+	.base			=3D -1,
+};
+
+struct bd79124_raw {
+	u8 bit0_3; /* Is set in high bits of the byte */
+	u8 bit4_11;
+};
+#define BD79124_RAW_TO_INT(r) ((r.bit4_11 << 4) | (r.bit0_3 >> 4))
+
+/*
+ * The high and low limits as well as the recent result values are stored =
in
+ * the same way in 2 consequent registers. The first register contains 4 b=
its
+ * of the value. These bits are stored in the high bits [7:4] of register,=
 but
+ * they represent the low bits [3:0] of the value.
+ * The value bits [11:4] are stored in the next register.
+ *
+ * Read data from register and convert to integer.
+ */
+static int bd79124_read_reg_to_int(struct bd79124_data *data, int reg,
+				   unsigned int *val)
+{
+	int ret;
+	struct bd79124_raw raw;
+
+	ret =3D regmap_bulk_read(data->map, reg, &raw, sizeof(raw));
+	if (ret) {
+		dev_dbg(data->dev, "bulk_read failed %d\n", ret);
+
+		return ret;
+	}
+
+	*val =3D BD79124_RAW_TO_INT(raw);
+
+	return 0;
+}
+
+/*
+ * The high and low limits as well as the recent result values are stored =
in
+ * the same way in 2 consequent registers. The first register contains 4 b=
its
+ * of the value. These bits are stored in the high bits [7:4] of register,=
 but
+ * they represent the low bits [3:0] of the value.
+ * The value bits [11:4] are stored in the next regoster.
+ *
+ * Conver the integer to register format and write it using rmw cycle.
+ */
+static int bd79124_write_int_to_reg(struct bd79124_data *data, int reg,
+				    unsigned int val)
+{
+	struct bd79124_raw raw;
+	int ret, tmp;
+
+	raw.bit4_11 =3D (u8)(val >> 4);
+	raw.bit0_3 =3D (u8)(val << 4);
+
+	ret =3D regmap_read(data->map, reg, &tmp);
+	if (ret)
+		return ret;
+
+	raw.bit0_3 |=3D (0xf & tmp);
+
+	return regmap_bulk_write(data->map, reg, &raw, sizeof(raw));
+}
+
+static const struct iio_event_spec bd79124_events[] =3D {
+	{
+		.type =3D IIO_EV_TYPE_THRESH,
+		.dir =3D IIO_EV_DIR_RISING,
+		.mask_separate =3D BIT(IIO_EV_INFO_VALUE) |
+				 BIT(IIO_EV_INFO_ENABLE),
+	},
+	{
+		.type =3D IIO_EV_TYPE_THRESH,
+		.dir =3D IIO_EV_DIR_FALLING,
+		.mask_separate =3D BIT(IIO_EV_INFO_VALUE) |
+				 BIT(IIO_EV_INFO_ENABLE),
+	},
+	{
+		.type =3D IIO_EV_TYPE_THRESH,
+		.dir =3D IIO_EV_DIR_EITHER,
+		.mask_separate =3D BIT(IIO_EV_INFO_HYSTERESIS),
+	},
+};
+
+static const struct iio_chan_spec bd79124_chan_template_noirq =3D {
+	.type =3D IIO_VOLTAGE,
+	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),
+	.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE),
+	.indexed =3D 1,
+};
+
+static const struct iio_chan_spec bd79124_chan_template =3D {
+	.type =3D IIO_VOLTAGE,
+	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),
+	.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE),
+	.indexed =3D 1,
+	.event_spec =3D bd79124_events,
+	.num_event_specs =3D ARRAY_SIZE(bd79124_events),
+};
+
+static int bd79124_read_event_value(struct iio_dev *iio_dev,
+				    const struct iio_chan_spec *chan,
+				    enum iio_event_type type,
+				    enum iio_event_direction dir,
+				    enum iio_event_info info, int *val,
+				    int *val2)
+{
+	struct bd79124_data *data =3D iio_priv(iio_dev);
+	int ret, reg;
+
+	if (chan->channel >=3D BD79124_MAX_NUM_CHANNELS)
+		return -EINVAL;
+
+	switch (info) {
+	case IIO_EV_INFO_VALUE:
+		if (dir =3D=3D IIO_EV_DIR_RISING)
+			*val =3D data->alarm_r_limit[chan->channel];
+		else if (dir =3D=3D IIO_EV_DIR_FALLING)
+			*val =3D data->alarm_f_limit[chan->channel];
+		else
+			return -EINVAL;
+
+		return IIO_VAL_INT;
+
+	case IIO_EV_INFO_HYSTERESIS:
+		reg =3D BD79124_GET_HYSTERESIS_REG(chan->channel);
+		ret =3D regmap_read(data->map, reg, val);
+		if (ret)
+			return ret;
+		/* Mask the non hysteresis bits */
+		*val &=3D BD79124_MASK_HYSTERESIS;
+		/*
+		 * The data-sheet says the hysteresis register value needs to be
+		 * sifted left by 3 (or multiplied by 8, depending on the
+		 * page :] )
+		 */
+		*val <<=3D 3;
+
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int bd79124_start_measurement(struct bd79124_data *data, int chan)
+{
+	int val, ret, regval;
+
+	/* See if already started */
+	ret =3D regmap_read(data->map, BD79124_REG_AUTO_CHANNELS, &val);
+	if (val & BIT(chan))
+		return 0;
+
+	ret =3D regmap_clear_bits(data->map, BD79124_REG_SEQUENCE_CFG,
+				BD79124_MASK_SEQ_START);
+	if (ret)
+		return ret;
+
+	/* Add the channel to measured channels */
+	ret =3D regmap_write(data->map, BD79124_REG_AUTO_CHANNELS, val | BIT(chan=
));
+	if (ret)
+		return ret;
+
+	ret =3D regmap_set_bits(data->map, BD79124_REG_SEQUENCE_CFG,
+			      BD79124_MASK_SEQ_START);
+	if (ret)
+		return ret;
+
+	/*
+	 * Start the measurement at the background. Don't bother checking if
+	 * it was started, regmap has cache.
+	 */
+	regval =3D FIELD_PREP(BD79124_MASK_CONV_MODE, BD79124_CONV_MODE_AUTO);
+
+	return regmap_update_bits(data->map, BD79124_REG_OPMODE_CFG,
+				BD79124_MASK_CONV_MODE, regval);
+}
+
+static int bd79124_stop_measurement(struct bd79124_data *data, int chan)
+{
+	int val, ret;
+
+	/* See if already stopped */
+	ret =3D regmap_read(data->map, BD79124_REG_AUTO_CHANNELS, &val);
+	if (!(val & BIT(chan)))
+		return 0;
+
+	ret =3D regmap_clear_bits(data->map, BD79124_REG_SEQUENCE_CFG,
+				BD79124_MASK_SEQ_START);
+
+	/* Clear the channel from the measured channels */
+	ret =3D regmap_write(data->map, BD79124_REG_AUTO_CHANNELS,
+			   (~BIT(chan)) & val);
+	if (ret)
+		return ret;
+
+	/*
+	 * Stop background conversion for power saving if it was the last
+	 * channel
+	 */
+	if (!((~BIT(chan)) & val)) {
+		int regval =3D FIELD_PREP(BD79124_MASK_CONV_MODE,
+					BD79124_CONV_MODE_MANSEQ);
+
+		ret =3D regmap_update_bits(data->map, BD79124_REG_OPMODE_CFG,
+					 BD79124_MASK_CONV_MODE, regval);
+		if (ret)
+			return ret;
+	}
+
+	return regmap_set_bits(data->map, BD79124_REG_SEQUENCE_CFG,
+			       BD79124_MASK_SEQ_START);
+}
+
+static int bd79124_read_event_config(struct iio_dev *iio_dev,
+				     const struct iio_chan_spec *chan,
+				     enum iio_event_type type,
+				     enum iio_event_direction dir)
+{
+	struct bd79124_data *data =3D iio_priv(iio_dev);
+
+	if (chan->channel >=3D BD79124_MAX_NUM_CHANNELS)
+		return -EINVAL;
+
+	return (data->alarm_monitored[chan->channel] & BIT(dir));
+}
+
+static int bd79124_disable_event(struct bd79124_data *data,
+			enum iio_event_direction dir, int channel)
+{
+	int dir_bit =3D BIT(dir), reg;
+	unsigned int limit;
+
+	guard(mutex)(&data->mutex);
+	/*
+	 * Set thresholds either to 0 or to 2^12 - 1 as appropriate to prevent
+	 * alerts and thus disable event generation.
+	 */
+	if (dir =3D=3D IIO_EV_DIR_RISING) {
+		reg =3D BD79124_GET_HIGH_LIMIT_REG(channel);
+		limit =3D BD79124_HIGH_LIMIT_MAX;
+	} else if (dir =3D=3D IIO_EV_DIR_FALLING) {
+		reg =3D BD79124_GET_LOW_LIMIT_REG(channel);
+		limit =3D BD79124_LOW_LIMIT_MIN;
+	} else {
+		return -EINVAL;
+	}
+
+	data->alarm_monitored[channel] &=3D (~dir_bit);
+	/*
+	 * Stop measurement if there is no more events to monitor.
+	 * We don't bother checking the retval because the limit
+	 * setting should in any case effectively disable the alarm.
+	 */
+	if (!data->alarm_monitored[channel]) {
+		bd79124_stop_measurement(data, channel);
+		regmap_clear_bits(data->map, BD79124_REG_ALERT_CH_SEL,
+			       BIT(channel));
+	}
+
+	return bd79124_write_int_to_reg(data, reg, limit);
+}
+
+static int bd79124_enable_event(struct bd79124_data *data,
+		enum iio_event_direction dir, unsigned int channel)
+{
+	int dir_bit =3D BIT(dir);
+	int reg;
+	u16 *limit;
+	int ret;
+
+	guard(mutex)(&data->mutex);
+	/* Set channel to be measured */
+	ret =3D bd79124_start_measurement(data, channel);
+	if (ret)
+		return ret;
+
+	data->alarm_monitored[channel] |=3D dir_bit;
+
+	/* Add the channel to the list of monitored channels */
+	ret =3D regmap_set_bits(data->map, BD79124_REG_ALERT_CH_SEL,
+			      BIT(channel));
+	if (ret)
+		return ret;
+
+	if (dir =3D=3D IIO_EV_DIR_RISING) {
+		limit =3D &data->alarm_f_limit[channel];
+		reg =3D BD79124_GET_HIGH_LIMIT_REG(channel);
+	} else {
+		limit =3D &data->alarm_f_limit[channel];
+		reg =3D BD79124_GET_LOW_LIMIT_REG(channel);
+	}
+	/* Don't write the new limit to the hardware if we are in the
+	 * rate-limit period. The timer which re-enables the event will set
+	 * the limit.
+	 */
+	if (!(data->alarm_suppressed[channel] & dir_bit)) {
+		ret =3D bd79124_write_int_to_reg(data, reg, *limit);
+		if (ret)
+			return ret;
+	}
+
+	/*
+	 * Enable comparator. Trust the regmap cache, no need to check
+	 * if it was already enabled.
+	 *
+	 * We could do this in the hw-init, but there may be users who
+	 * never enable alarms and for them it makes sense to not
+	 * enable the comparator at probe.
+	 */
+	return regmap_set_bits(data->map, BD79124_REG_GEN_CFG,
+				      BD79124_MASK_DWC_EN);
+
+}
+
+static int bd79124_write_event_config(struct iio_dev *iio_dev,
+				      const struct iio_chan_spec *chan,
+				      enum iio_event_type type,
+				      enum iio_event_direction dir, bool state)
+{
+	struct bd79124_data *data =3D iio_priv(iio_dev);
+
+	if (chan->channel >=3D BD79124_MAX_NUM_CHANNELS)
+		return -EINVAL;
+
+	if (state)
+		return bd79124_enable_event(data, dir, chan->channel);
+
+	return bd79124_disable_event(data, dir, chan->channel);
+}
+
+static int bd79124_write_event_value(struct iio_dev *iio_dev,
+				     const struct iio_chan_spec *chan,
+				     enum iio_event_type type,
+				     enum iio_event_direction dir,
+				     enum iio_event_info info, int val,
+				     int val2)
+{
+	struct bd79124_data *data =3D iio_priv(iio_dev);
+	int reg;
+
+	if (chan->channel >=3D BD79124_MAX_NUM_CHANNELS)
+		return -EINVAL;
+
+	switch (info) {
+	case IIO_EV_INFO_VALUE:
+		if (dir =3D=3D IIO_EV_DIR_RISING) {
+			guard(mutex)(&data->mutex);
+
+			data->alarm_r_limit[chan->channel] =3D val;
+			reg =3D BD79124_GET_HIGH_LIMIT_REG(chan->channel);
+		} else if (dir =3D=3D IIO_EV_DIR_FALLING) {
+			guard(mutex)(&data->mutex);
+
+			data->alarm_f_limit[chan->channel] =3D val;
+			reg =3D BD79124_GET_LOW_LIMIT_REG(chan->channel);
+		} else {
+			return -EINVAL;
+		}
+		/*
+		 * We don't want to enable the alarm if it is not enabled or
+		 * if it is suppressed. In that case skip writing to the
+		 * register.
+		 */
+		if (!(data->alarm_monitored[chan->channel] & BIT(dir)) ||
+		    data->alarm_suppressed[chan->channel] & BIT(dir))
+			return 0;
+
+		return bd79124_write_int_to_reg(data, reg, val);
+
+	case IIO_EV_INFO_HYSTERESIS:
+		reg =3D BD79124_GET_HYSTERESIS_REG(chan->channel);
+		val >>=3D 3;
+
+		return regmap_update_bits(data->map, reg, BD79124_MASK_HYSTERESIS,
+					  val);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int bd79124_single_chan_seq(struct bd79124_data *data, int chan, in=
t *old)
+{
+	int ret;
+
+	ret =3D regmap_clear_bits(data->map, BD79124_REG_SEQUENCE_CFG,
+				BD79124_MASK_SEQ_START);
+	if (ret)
+		return ret;
+
+	/*
+	 * It may be we have some channels monitored for alarms so we want to
+	 * cache the old config and return it when the single channel
+	 * measurement has been completed.
+	 */
+	ret =3D regmap_read(data->map, BD79124_REG_AUTO_CHANNELS, old);
+	if (ret)
+		return ret;
+
+	ret =3D regmap_write(data->map, BD79124_REG_AUTO_CHANNELS, BIT(chan));
+	if (ret)
+		return ret;
+
+	/* Restart the sequencer */
+	return regmap_set_bits(data->map, BD79124_REG_SEQUENCE_CFG,
+			      BD79124_MASK_SEQ_START);
+}
+
+static int bd79124_single_chan_seq_end(struct bd79124_data *data, int old)
+{
+	int ret;
+
+	ret =3D regmap_clear_bits(data->map, BD79124_REG_SEQUENCE_CFG,
+				BD79124_MASK_SEQ_START);
+	if (ret)
+		return ret;
+
+	ret =3D regmap_write(data->map, BD79124_REG_AUTO_CHANNELS, old);
+	if (ret)
+		return ret;
+
+	return regmap_set_bits(data->map, BD79124_REG_SEQUENCE_CFG,
+			      BD79124_MASK_SEQ_START);
+}
+
+static int bd79124_read_raw(struct iio_dev *iio_dev,
+			    struct iio_chan_spec const *chan,
+			    int *val, int *val2, long m)
+{
+	struct bd79124_data *data =3D iio_priv(iio_dev);
+	int ret;
+
+	if (chan->channel >=3D BD79124_MAX_NUM_CHANNELS)
+		return -EINVAL;
+
+	switch (m) {
+	case IIO_CHAN_INFO_RAW:
+	{
+		int old_chan_cfg, tmp;
+		int regval;
+
+		guard(mutex)(&data->mutex);
+
+		/*
+		 * Start the automatic conversion. This is needed here if no
+		 * events have been enabled.
+		 */
+		regval =3D FIELD_PREP(BD79124_MASK_CONV_MODE,
+				    BD79124_CONV_MODE_AUTO);
+		ret =3D regmap_update_bits(data->map, BD79124_REG_OPMODE_CFG,
+					 BD79124_MASK_CONV_MODE, regval);
+		if (ret)
+			return ret;
+
+		ret =3D bd79124_single_chan_seq(data, chan->channel, &old_chan_cfg);
+		if (ret)
+			return ret;
+
+		/* The maximum conversion time is 6 uS. */
+		udelay(6);
+
+		ret =3D bd79124_read_reg_to_int(data,
+				BD79124_GET_RECENT_RES_REG(chan->channel),
+				val);
+		/*
+		 * Return the old chan config even if data reading failed in
+		 * order to re-enable the event monitoring.
+		 */
+		tmp =3D bd79124_single_chan_seq_end(data, old_chan_cfg);
+		if (tmp)
+			dev_err(data->dev,
+				"Failed to return config. Alarms may be disabled\n");
+
+		if (ret)
+			return ret;
+
+		return IIO_VAL_INT;
+	}
+	case IIO_CHAN_INFO_SCALE:
+		*val =3D data->vmax / 1000;
+		*val2 =3D BD79124_ADC_BITS;
+		return IIO_VAL_FRACTIONAL_LOG2;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info bd79124_info =3D {
+	.read_raw =3D bd79124_read_raw,
+	.read_event_config =3D &bd79124_read_event_config,
+	.write_event_config =3D &bd79124_write_event_config,
+	.read_event_value =3D &bd79124_read_event_value,
+	.write_event_value =3D &bd79124_write_event_value,
+};
+
+static void bd79124_re_enable_lo(struct bd79124_data *data, unsigned int c=
hannel)
+{
+	int ret, evbit =3D BIT(IIO_EV_DIR_FALLING);
+
+	if (!(data->alarm_suppressed[channel] & evbit))
+		return;
+
+	data->alarm_suppressed[channel] &=3D (~evbit);
+
+	if (!(data->alarm_monitored[channel] & evbit))
+		return;
+
+	ret =3D bd79124_write_int_to_reg(data, BD79124_GET_LOW_LIMIT_REG(channel),
+				       data->alarm_f_limit[channel]);
+	if (ret)
+		dev_warn(data->dev, "Low limit enabling failed for channel%d\n",
+			 channel);
+}
+
+static void bd79124_re_enable_hi(struct bd79124_data *data, unsigned int c=
hannel)
+{
+	int ret, evbit =3D BIT(IIO_EV_DIR_RISING);
+
+	if (!(data->alarm_suppressed[channel] & evbit))
+		return;
+
+	data->alarm_suppressed[channel] &=3D (~evbit);
+
+	if (!(data->alarm_monitored[channel] & evbit))
+		return;
+
+	ret =3D bd79124_write_int_to_reg(data, BD79124_GET_HIGH_LIMIT_REG(channel=
),
+				       data->alarm_r_limit[channel]);
+	if (ret)
+		dev_warn(data->dev, "High limit enabling failed for channel%d\n",
+			 channel);
+}
+
+static void bd79124_alm_enable_worker(struct work_struct *work)
+{
+	int i;
+	struct bd79124_data *data =3D container_of(work, struct bd79124_data,
+						 alm_enable_work.work);
+
+	guard(mutex)(&data->mutex);
+	/*
+	 * We should not re-enable the event if user has disabled it while
+	 * rate-limiting was enabled.
+	 */
+	for (i =3D 0; i < BD79124_MAX_NUM_CHANNELS; i++) {
+		bd79124_re_enable_hi(data, i);
+		bd79124_re_enable_lo(data, i);
+	}
+}
+
+static int __bd79124_event_ratelimit(struct bd79124_data *data, int reg,
+				     unsigned int limit)
+{
+	int ret;
+
+	if (limit > BD79124_HIGH_LIMIT_MAX)
+		return -EINVAL;
+
+	ret =3D bd79124_write_int_to_reg(data, reg, limit);
+	if (ret)
+		return ret;
+
+	/*
+	 * We use 1 sec 'grace period'. At the moment I see no reason to make
+	 * this user configurable. We need an ABI for this if configuration is
+	 * needed.
+	 */
+	schedule_delayed_work(&data->alm_enable_work,
+			      msecs_to_jiffies(1000));
+
+	return 0;
+}
+
+static int bd79124_event_ratelimit_hi(struct bd79124_data *data,
+				      unsigned int channel)
+{
+	int reg, limit;
+
+	guard(mutex)(&data->mutex);
+	data->alarm_suppressed[channel] |=3D BIT(IIO_EV_DIR_RISING);
+
+	reg =3D BD79124_GET_HIGH_LIMIT_REG(channel);
+	limit =3D BD79124_HIGH_LIMIT_MAX;
+
+	return __bd79124_event_ratelimit(data, reg, limit);
+}
+
+static int bd79124_event_ratelimit_lo(struct bd79124_data *data,
+				      unsigned int channel)
+{
+	int reg, limit;
+
+	guard(mutex)(&data->mutex);
+	data->alarm_suppressed[channel] |=3D BIT(IIO_EV_DIR_FALLING);
+
+	reg =3D BD79124_GET_LOW_LIMIT_REG(channel);
+	limit =3D BD79124_LOW_LIMIT_MIN;
+
+	return __bd79124_event_ratelimit(data, reg, limit);
+}
+
+static irqreturn_t bd79124_event_handler(int irq, void *priv)
+{
+	int ret, i_hi, i_lo, i;
+	struct iio_dev *iio_dev =3D priv;
+	struct bd79124_data *data =3D iio_priv(iio_dev);
+
+	/*
+	 * Return IRQ_NONE if bailing-out without acking. This allows the IRQ
+	 * subsystem to disable the offending IRQ line if we get a hardware
+	 * problem. This behaviour has saved my poor bottom a few times in the
+	 * past as, instead of getting unusably unresponsive, the system has
+	 * spilled out the magic words "...nobody cared".
+	 */
+	ret =3D regmap_read(data->map, BD79124_REG_EVENT_FLAG_HI, &i_hi);
+	if (ret)
+		return IRQ_NONE;
+
+	ret =3D regmap_read(data->map, BD79124_REG_EVENT_FLAG_LO, &i_lo);
+	if (ret)
+		return IRQ_NONE;
+
+	if (!i_lo && !i_hi)
+		return IRQ_NONE;
+
+	for (i =3D 0; i < BD79124_MAX_NUM_CHANNELS; i++) {
+		u64 ecode;
+
+		if (BIT(i) & i_hi) {
+			ecode =3D IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE, i,
+					IIO_EV_TYPE_THRESH, IIO_EV_DIR_RISING);
+
+			iio_push_event(iio_dev, ecode, data->timestamp);
+			/*
+			 * The BD79124 keeps the IRQ asserted for as long as
+			 * the voltage exceeds the threshold. It causes the IRQ
+			 * to keep firing.
+			 *
+			 * Disable the event for the channel and schedule the
+			 * re-enabling the event later to prevent storm of
+			 * events.
+			 */
+			ret =3D bd79124_event_ratelimit_hi(data, i);
+			if (ret)
+				return IRQ_NONE;
+		}
+		if (BIT(i) & i_lo) {
+			ecode =3D IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE, i,
+					IIO_EV_TYPE_THRESH, IIO_EV_DIR_FALLING);
+
+			iio_push_event(iio_dev, ecode, data->timestamp);
+			ret =3D bd79124_event_ratelimit_lo(data, i);
+			if (ret)
+				return IRQ_NONE;
+		}
+	}
+
+	ret =3D regmap_write(data->map, BD79124_REG_EVENT_FLAG_HI, i_hi);
+	if (ret)
+		return IRQ_NONE;
+
+	ret =3D regmap_write(data->map, BD79124_REG_EVENT_FLAG_LO, i_lo);
+	if (ret)
+		return IRQ_NONE;
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t bd79124_irq_handler(int irq, void *priv)
+{
+	struct iio_dev *iio_dev =3D priv;
+	struct bd79124_data *data =3D iio_priv(iio_dev);
+
+	data->timestamp =3D iio_get_time_ns(iio_dev);
+
+	return IRQ_WAKE_THREAD;
+}
+
+struct bd79124_reg_init {
+	int reg;
+	int val;
+};
+
+static int bd79124_chan_init(struct bd79124_data *data, int channel)
+{
+	struct bd79124_reg_init inits[] =3D {
+		{ .reg =3D BD79124_GET_HIGH_LIMIT_REG(channel), .val =3D 4095 },
+		{ .reg =3D BD79124_GET_LOW_LIMIT_REG(channel), .val =3D 0 },
+	};
+	int i, ret;
+
+	for (i =3D 0; i < ARRAY_SIZE(inits); i++) {
+		ret =3D regmap_write(data->map, inits[i].reg, inits[i].val);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static bool bd79124_is_in_array(int *arr, int num_items, int val)
+{
+	int i;
+
+	for (i =3D 0; i < num_items; i++)
+		if (arr[i] =3D=3D val)
+			return true;
+
+	return false;
+}
+
+static int bd79124_mux_init(struct bd79124_data *data)
+{
+	int adc_chans[BD79124_MAX_NUM_CHANNELS];
+	int num_adc, chan, regval =3D 0;
+
+	num_adc =3D iio_adc_device_channels_by_property(data->dev, &adc_chans[0],
+						      BD79124_MAX_NUM_CHANNELS,
+						      &expected_props);
+	if (num_adc < 0)
+		return num_adc;
+
+	/*
+	 * Set a mux register bit for each pin which is free to be used as
+	 * a GPO.
+	 */
+	for (chan =3D 0; chan < BD79124_MAX_NUM_CHANNELS; chan++)
+		if (!bd79124_is_in_array(&adc_chans[0], num_adc, chan))
+			regval |=3D BIT(chan);
+
+	return regmap_write(data->map, BD79124_REG_PINCFG, regval);
+}
+
+static int bd79124_hw_init(struct bd79124_data *data)
+{
+	int ret, regval, i;
+
+	ret =3D bd79124_mux_init(data);
+	if (ret)
+		return ret;
+
+	for (i =3D 0; i < BD79124_MAX_NUM_CHANNELS; i++) {
+		ret =3D bd79124_chan_init(data, i);
+		if (ret)
+			return ret;
+		data->alarm_r_limit[i] =3D 4095;
+	}
+	/* Stop auto sequencer */
+	ret =3D regmap_clear_bits(data->map, BD79124_REG_SEQUENCE_CFG,
+				BD79124_MASK_SEQ_START);
+	if (ret)
+		return ret;
+
+	/* Enable writing the measured values to the regsters */
+	ret =3D regmap_set_bits(data->map, BD79124_REG_GEN_CFG,
+			      BD79124_MASK_STATS_EN);
+	if (ret)
+		return ret;
+
+	/* Set no channels to be auto-measured */
+	ret =3D regmap_write(data->map, BD79124_REG_AUTO_CHANNELS, 0x0);
+	if (ret)
+		return ret;
+
+	/* Set no channels to be manually measured */
+	ret =3D regmap_write(data->map, BD79124_REG_MANUAL_CHANNELS, 0x0);
+	if (ret)
+		return ret;
+
+	/* Set the measurement interval to 0.75 mS */
+	regval =3D FIELD_PREP(BD79124_MASK_AUTO_INTERVAL, BD79124_INTERVAL_075);
+	ret =3D regmap_update_bits(data->map, BD79124_REG_OPMODE_CFG,
+			BD79124_MASK_AUTO_INTERVAL, regval);
+	if (ret)
+		return ret;
+
+	/* Sequencer mode to auto */
+	ret =3D regmap_set_bits(data->map, BD79124_REG_SEQUENCE_CFG,
+			      BD79124_MASK_SEQ_SEQ);
+	if (ret)
+		return ret;
+
+	/* Don't start the measurement */
+	regval =3D FIELD_PREP(BD79124_MASK_CONV_MODE, BD79124_CONV_MODE_MANSEQ);
+
+	return regmap_update_bits(data->map, BD79124_REG_OPMODE_CFG,
+			BD79124_MASK_CONV_MODE, BD79124_CONV_MODE_MANSEQ);
+
+}
+
+static int bd79124_probe(struct i2c_client *i2c)
+{
+	struct bd79124_data *data;
+	struct iio_dev *iio_dev;
+	const struct iio_chan_spec *template;
+	struct iio_chan_spec *cs;
+	struct device *dev =3D &i2c->dev;
+	int ret;
+
+	iio_dev =3D devm_iio_device_alloc(dev, sizeof(*data));
+	if (!iio_dev)
+		return -ENOMEM;
+
+	data =3D iio_priv(iio_dev);
+	data->dev =3D dev;
+	data->map =3D devm_regmap_init_i2c(i2c, &bd79124_regmap);
+	if (IS_ERR(data->map))
+		return dev_err_probe(dev, PTR_ERR(data->map),
+				     "Failed to initialize Regmap\n");
+
+	ret =3D devm_regulator_get_enable_read_voltage(dev, "vdd");
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to get the Vdd\n");
+
+	data->vmax =3D ret;
+
+	ret =3D devm_regulator_get_enable(dev, "iovdd");
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to enable I/O voltage\n");
+
+	ret =3D devm_delayed_work_autocancel(dev, &data->alm_enable_work,
+					   bd79124_alm_enable_worker);
+	if (ret)
+		return ret;
+
+	if (i2c->irq) {
+		template =3D &bd79124_chan_template;
+	} else {
+		template =3D &bd79124_chan_template_noirq;
+		dev_dbg(dev, "No IRQ found, events disabled\n");
+	}
+	ret =3D devm_iio_adc_device_alloc_chaninfo(dev, template, &cs,
+						 &expected_props);
+	if (ret < 0)
+		return ret;
+
+	iio_dev->channels =3D cs;
+	iio_dev->num_channels =3D ret;
+	iio_dev->info =3D &bd79124_info;
+	iio_dev->name =3D "bd79124";
+	iio_dev->modes =3D INDIO_DIRECT_MODE;
+
+	data->gc =3D bd79124gpo_chip;
+	data->gc.parent =3D dev;
+
+	mutex_init(&data->mutex);
+
+	ret =3D bd79124_hw_init(data);
+	if (ret)
+		return ret;
+
+	ret =3D devm_gpiochip_add_data(data->dev, &data->gc, data);
+	if (ret)
+		return dev_err_probe(data->dev, ret, "gpio init Failed\n");
+
+	if (i2c->irq > 0) {
+		ret =3D devm_request_threaded_irq(data->dev, i2c->irq,
+					bd79124_irq_handler,
+					&bd79124_event_handler, IRQF_ONESHOT,
+					"adc-thresh-alert", iio_dev);
+		if (ret)
+			return dev_err_probe(data->dev, ret,
+					     "Failed to register IRQ\n");
+	}
+
+	return devm_iio_device_register(data->dev, iio_dev);
+}
+
+static const struct of_device_id bd79124_of_match[] =3D {
+	{ .compatible =3D "rohm,bd79124" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, bd79124_of_match);
+
+static const struct i2c_device_id bd79124_id[] =3D {
+	{ "bd79124", },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, bd79124_id);
+
+static struct i2c_driver bd79124_driver =3D {
+	.driver =3D {
+		.name =3D "bd79124",
+		.of_match_table =3D bd79124_of_match,
+	},
+	.probe =3D bd79124_probe,
+	.id_table =3D bd79124_id,
+};
+module_i2c_driver(bd79124_driver);
+
+MODULE_AUTHOR("Matti Vaittinen <mazziesaccount@gmail.com>");
+MODULE_DESCRIPTION("Driver for ROHM BD79124 ADC");
+MODULE_LICENSE("GPL");
--=20
2.48.1


--Zz7rcAroFuTg3TKM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAme1zvMACgkQeFA3/03a
ocVSWgf+Oo3cJNv3+N+7P595LSio+rfCxYYJyv7eLTzpb6ylE2n2q/X8Kc1mh7SL
MdQAdzvLdHlAir2rjTMYM+6FxlrptCDFfp3rLs3dCX029ZzcilNVY7PZSbvCRFwh
OMk36lTVxd6kSQn9ci+8VRV4oxs5LIwOUseHHDtlsBEmVDOiIBKePLuDPCGxG9WA
mIfdmQyUbUy+sYalvrr/dCcqHMQT5wz+LQtkpOjlXvQTMVNnkknrPiYWYvstd+3y
7nWBbYWGL0ewLp7av6IuMht2WLm7kCkq384qrYB47WMjGsnK5ewbHmS6cTlLkyxJ
nM1cK+IwYxHBjPOahj2myboY5iNfow==
=AO/h
-----END PGP SIGNATURE-----

--Zz7rcAroFuTg3TKM--

