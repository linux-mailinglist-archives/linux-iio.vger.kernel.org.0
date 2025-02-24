Return-Path: <linux-iio+bounces-16032-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B89A42B84
	for <lists+linux-iio@lfdr.de>; Mon, 24 Feb 2025 19:35:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65FFC178416
	for <lists+linux-iio@lfdr.de>; Mon, 24 Feb 2025 18:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63FEA266183;
	Mon, 24 Feb 2025 18:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hJCEs2FH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4AB265CBC;
	Mon, 24 Feb 2025 18:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740422082; cv=none; b=YCFE8cnfZGD7nMNx82503B+EIaZPTXfo6Y1p1kLlddgGrtaKivL4sQQ60mdScuD61EqEBM3md84f1TwY6dZOAU6ykvx3gXMwDE1TbV8wVNBHP76nT2cIwOstWHot5U0UNezX9+YQgb3HDMfpguWXXlEDjcTlKddYyROzCCr+APw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740422082; c=relaxed/simple;
	bh=yNeR9rKQonhLPntxcfImN9f1plZgHoJKZx++P2qKpZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YZlOKtPrI69IghxPfKFcRZarfd4uEdxfbcOHEcDbpHENUfqL1Xs1uHl313S3zfKPGpS1/bIG2vovivjs3GiSpT+gMp2BC/+gLXtyEmREa16sI/XZA7FI45SYva8A5VgKPaDAg94kCCz4KuISdgmUbzC+2K2ENA55PmO/yFpn7jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hJCEs2FH; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-54524740032so4999072e87.3;
        Mon, 24 Feb 2025 10:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740422077; x=1741026877; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=buHH90ReAfKMuPjfAlkI7RzTSkaQo1eKFWDc0/jro5c=;
        b=hJCEs2FHt+lbW7H7UbyhSSMBka14TfpHK8fLMEdD55vP3m0kAXJfQ5/Zo0ugA+9DJq
         M8TdC96RMpUFSiNU5xsS6P38rlo1R8pS9T2lGURXiXfdZdMu+o0MMKXW3/rEhtMutn8U
         5StTUwmhLhMmc3qLvsYFotrpyzdUG7llriF++hmCDesjEWtQltAoOVUW5Gozyz45qx6s
         12gs+fCm19GnYQFTwLswziolbkRI1mGbduu2tAmjqcuL/5eM0wvIEjEAXZS5fDuvGxRo
         /ttl3YQVIZSStzHbfL6lu1DrJpS6avqyu0xo49Z0K1MTJwP3eBIu84wqtoD66tyvrFNp
         WkXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740422077; x=1741026877;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=buHH90ReAfKMuPjfAlkI7RzTSkaQo1eKFWDc0/jro5c=;
        b=VnN5OEATtYSwxXgqqdYHVAbhJMzH3TmdEdW1VLpRBm2/1ze4EvRidnsWIIhUwXe4AT
         70gim4+1Wg4QrRP427d7UZVjvITu5SVBjzRQn0hzcOkG6tD2g1zY1WuEmnW69Squu21n
         k5lJ3DnMH70HW2D0RW1lYb7rm8E/iTBgN7GNbcvxzDwdb2p2jotkGDjyuT8dqbKt5Q8B
         EIY/syuSxUeHwGQopAY+VsBqVRJT23UtrFr2vwfRekLK1M4wqUnCR72Kfx06Hs5/hurO
         KgJHCi+x8sy8ZCFFoTELJp9mpTuUjhTAN/A47+YKFRHH3vW36mihyjH2ByIXwzDBGzC2
         +JPQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+zRvL3+mQfCcI9wM8bqimfErcE34KEAD6rIfvOdBLTubUB/ROcyyBcmnABCC9PqEL06+k8HYVnvtamzyQ@vger.kernel.org, AJvYcCW3+v5yG0YsIS2lqPE8KttUr9VgZ7rCUKMYC0Ax8iRMEreBX+2IyVxCyd1zCTfEU/18vr8YxGeUZavm@vger.kernel.org, AJvYcCWNevEohbK9iJaxNyEandYXLG8Y4qeQtXJ6mkZAQW4FdveQQh9/hFN5C/SbyFpZeAtyVtVDUoVYfJ5j@vger.kernel.org, AJvYcCXJYfS/n6tWQvgeR0uWGm1FvPYWnvfKDMT8fBAuiA9/iAS/ovycS3+W+m0AY8bv4M0OwB0EOor5mQTk+PiBDaRNsac=@vger.kernel.org, AJvYcCXt7WlxHz6SgJ1kbh2ZvsS0MCvOxd9SKtociSjPMqImvssNbW5KnLsWAYBgsZby5qT9XKIT0VVsADe74g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxiPGb3QgihJSskj8VcOzUiEIGAmHOW4vFcFCz+FJ3M8jbqPmkM
	+HPRyka3lRWvN+nSHSHBL9TKZwZmtWuqh4LN/sf0GWmxgpZNwLtL
X-Gm-Gg: ASbGncuu1YILHEZ2wxBa4kE5JFKdm9Iu2c+OVBxw39Xba10qg8/8VTqwCoiq+BN4c/r
	ETIeLk69DLO6gS0MFvnX/l2DHXfTqqh2WlvuDBW4ZdvX/X+laswq8Yl9Rj68uj3OWQNhRafuM9+
	iyLyjLG9RdRMWqUfuhoo1WtK7EpRIevdf4zRLQGYVtnpwX0vdljaGY05LYcNW+R3Hw9UwY5M2wF
	YF0bnyepeb0e9LMvqUUbA7JH8aUXSyW7nP79Rpf/aiP6MaGj9apOR/M8AQs86B/XKGg/NNouYcx
	zTabn36LEO5py61XVFazMgGKZQgG7+fO
X-Google-Smtp-Source: AGHT+IEwPd7V3DuZhCUYJUCWKv9yz82USqNjLXyyDPCW8me8mAN1vtlenDqvbheqk3knGvmVORLeCg==
X-Received: by 2002:a05:6512:3b8d:b0:545:2474:2c98 with SMTP id 2adb3069b0e04-548510dba39mr34866e87.23.1740422076563;
        Mon, 24 Feb 2025 10:34:36 -0800 (PST)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5451f105c2fsm3510203e87.117.2025.02.24.10.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 10:34:34 -0800 (PST)
Date: Mon, 24 Feb 2025 20:34:30 +0200
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Nuno Sa <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Guillaume Stols <gstols@baylibre.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Dumitru Ceclan <mitrutzceclan@gmail.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Matteo Martelli <matteomartelli3@gmail.com>,
	Alisa-Dariana Roman <alisadariana@gmail.com>,
	Ramona Alexandra Nechita <ramona.nechita@analog.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v4 08/10] iio: adc: Support ROHM BD79124 ADC
Message-ID: <4d1bf5df8f3b0f760422b6b67fcc8245ebf520e0.1740421249.git.mazziesaccount@gmail.com>
References: <cover.1740421248.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qdCRB7ASNQQkrLSh"
Content-Disposition: inline
In-Reply-To: <cover.1740421248.git.mazziesaccount@gmail.com>


--qdCRB7ASNQQkrLSh
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
v3 =3D> v4:
 - Adapt to 'drop diff-channel support' changes to ADC-helpers
 - Don't parse fwnode in GPIO valid-mask callback but use pin config
   cached at probe()
 - Drop use of iio_adc_device_channels_by_property()
 - Open code the bd79124_reg_init loop (as suggested by Jonathan)
 - Use devm variant of mutex_init()
 - Styling
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
 drivers/iio/adc/rohm-bd79124.c | 1114 ++++++++++++++++++++++++++++++++
 3 files changed, 1127 insertions(+)
 create mode 100644 drivers/iio/adc/rohm-bd79124.c

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index d16082ac2e1f..357214bc5024 100644
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
index 1c410f483029..3e10af9ec4c4 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -109,6 +109,7 @@ obj-$(CONFIG_QCOM_VADC_COMMON) +=3D qcom-vadc-common.o
 obj-$(CONFIG_RCAR_GYRO_ADC) +=3D rcar-gyroadc.o
 obj-$(CONFIG_RICHTEK_RTQ6056) +=3D rtq6056.o
 obj-$(CONFIG_RN5T618_ADC) +=3D rn5t618-adc.o
+obj-$(CONFIG_ROHM_BD79124) +=3D rohm-bd79124.o
 obj-$(CONFIG_ROCKCHIP_SARADC) +=3D rockchip_saradc.o
 obj-$(CONFIG_RZG2L_ADC) +=3D rzg2l_adc.o
 obj-$(CONFIG_SC27XX_ADC) +=3D sc27xx_adc.o
diff --git a/drivers/iio/adc/rohm-bd79124.c b/drivers/iio/adc/rohm-bd79124.c
new file mode 100644
index 000000000000..b3ef0e0c9a3a
--- /dev/null
+++ b/drivers/iio/adc/rohm-bd79124.c
@@ -0,0 +1,1114 @@
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
+	u8 gpio_valid_mask;
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
+	struct bd79124_data *data =3D gpiochip_get_data(gc);
+
+	*valid_mask =3D data->gpio_valid_mask;
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
+	guard(mutex)(&data->mutex);
+	data->alarm_suppressed[channel] |=3D BIT(IIO_EV_DIR_RISING);
+
+	return __bd79124_event_ratelimit(data,
+					 BD79124_GET_HIGH_LIMIT_REG(channel),
+					 BD79124_HIGH_LIMIT_MAX);
+}
+
+static int bd79124_event_ratelimit_lo(struct bd79124_data *data,
+				      unsigned int channel)
+{
+	guard(mutex)(&data->mutex);
+	data->alarm_suppressed[channel] |=3D BIT(IIO_EV_DIR_FALLING);
+
+	return __bd79124_event_ratelimit(data,
+					 BD79124_GET_LOW_LIMIT_REG(channel),
+					 BD79124_LOW_LIMIT_MIN);
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
+	int ret;
+
+	ret =3D regmap_write(data->map, BD79124_GET_HIGH_LIMIT_REG(channel), 4095=
);
+	if (ret)
+		return ret;
+
+	return regmap_write(data->map, BD79124_GET_LOW_LIMIT_REG(channel), 0);
+}
+
+static int bd79124_get_gpio_pins(const struct iio_chan_spec *cs, int num_c=
hannels)
+{
+	int i, gpio_channels;
+
+	/*
+	 * Let's initialize the mux config to say that all 8 channels are
+	 * GPIOs. Then we can just loop through the iio_chan_spec and clear the
+	 * bits for found ADC channels.
+	 */
+	gpio_channels =3D GENMASK(7, 0);
+	for (i =3D 0; i < num_channels; i++)
+		gpio_channels &=3D (~BIT(cs[i].channel));
+
+	return gpio_channels;
+}
+
+static int bd79124_init_mux(struct bd79124_data *data, int gpio_pins)
+{
+	return regmap_write(data->map, BD79124_REG_PINCFG, gpio_pins);
+}
+
+static int bd79124_hw_init(struct bd79124_data *data, int gpio_pins)
+{
+	int ret, regval, i;
+
+	ret =3D bd79124_init_mux(data, gpio_pins);
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
+				 BD79124_MASK_AUTO_INTERVAL, regval);
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
+	return regmap_update_bits(data->map, BD79124_REG_OPMODE_CFG,
+				  BD79124_MASK_CONV_MODE, regval);
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
+	int gpio_pins, ret;
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
+	ret =3D devm_iio_adc_device_alloc_chaninfo_se(dev, template,
+					BD79124_MAX_NUM_CHANNELS - 1, &cs);
+	if (ret < 0)
+		return ret;
+
+	iio_dev->channels =3D cs;
+	iio_dev->num_channels =3D ret;
+	iio_dev->info =3D &bd79124_info;
+	iio_dev->name =3D "bd79124";
+	iio_dev->modes =3D INDIO_DIRECT_MODE;
+
+	gpio_pins =3D bd79124_get_gpio_pins(iio_dev->channels,
+					  iio_dev->num_channels);
+	ret =3D bd79124_hw_init(data, gpio_pins);
+	if (ret)
+		return ret;
+
+	data->gpio_valid_mask =3D gpio_pins;
+	data->gc =3D bd79124gpo_chip;
+	data->gc.parent =3D dev;
+	devm_mutex_init(dev, &data->mutex);
+
+	ret =3D devm_gpiochip_add_data(dev, &data->gc, data);
+	if (ret)
+		return dev_err_probe(dev, ret, "gpio init Failed\n");
+
+	if (i2c->irq > 0) {
+		ret =3D devm_request_threaded_irq(dev, i2c->irq,
+				bd79124_irq_handler, &bd79124_event_handler,
+				IRQF_ONESHOT, "adc-thresh-alert", iio_dev);
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
+MODULE_IMPORT_NS("IIO_DRIVER");
--=20
2.48.1


--qdCRB7ASNQQkrLSh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAme8u7YACgkQeFA3/03a
ocVmZAgAnvY3ZzXpnAkClmvjBukXq4yjrRBECxfckTTrc7xKRVL35y1P0HIygjGW
FNqPQaRK2O5SoafX0p0aouZIDl7hz73GyZ1F1LlLr/sVTCc+aL5sj1m0dne7oRSv
pQwIsZXXMlieA2hJMuGOSBFCS0xfjVo+U9yMF7/3g8Ww3GnUN2DOiJwbwRUog+Dj
Vu7KPjtSw6kGTRmr3UzwN/46Z85+X9be5BTzY1vGqRCVtdyDfh/LWJSIFnnzmCWl
RJABl89WdboIWgrNQ/UHMGxNQ9tSJf0wqA8NgbjrUAkV1dudggC8ANKNY+6LH34x
JuT9vRjE/fY6KerRa6JmrO2EqhxAcw==
=kB1E
-----END PGP SIGNATURE-----

--qdCRB7ASNQQkrLSh--

