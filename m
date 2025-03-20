Return-Path: <linux-iio+bounces-17143-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A184A6A142
	for <lists+linux-iio@lfdr.de>; Thu, 20 Mar 2025 09:24:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DEE43BE879
	for <lists+linux-iio@lfdr.de>; Thu, 20 Mar 2025 08:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7681C2139C8;
	Thu, 20 Mar 2025 08:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gY9B4eZ1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D39221325F;
	Thu, 20 Mar 2025 08:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742458933; cv=none; b=TjfXV62gugJRb/WiNdgWZGyCWhY4sQ7h+QUn2FztMceekYb+shqe/kofMayBUrsKYM1NK4t/qyRUqw1LCJfceaKVDotT45H5fG6fSu9RDJ5uOyD1c6DIGsIM2l5qfTxwQojBKaQJeyi7A4RWqqdI/8xrizI4dQtTwlyhRG36Svs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742458933; c=relaxed/simple;
	bh=SN2uvD3izNZuKEhGlvj89RK33n8iUslkvU8Wq4mipkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uSWtAG/Uw++nsxru/hxOhbCVEaSXElb/sLEvaCZKCUmfeYN9GlqqoCBvkf5tXojLyiSbjGBQelNEDgS4Ht1XFfUfukGZ7YBdcZAH+wlAiHti3M0lgTsIm9wqzT0MnCe4DqZE9ntefhQ2u25zcaKp3sI6L9wu1EffRdvf32HLGSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gY9B4eZ1; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-30bfd4d4c63so5611851fa.2;
        Thu, 20 Mar 2025 01:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742458928; x=1743063728; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OxQAaB8Yz41KD1jdn7keLA/hWjsaKMcGv+T1iV5fG+c=;
        b=gY9B4eZ1VAshOJIQRD0cVI0JZ28LYnUvptZSt8IPrLfNfJ0myGi9YpqDHVNpYLRBzL
         NfS+4NrBZRMNo7n+hWxYELDSmvQrcsCH98TIhj1kP8hnSsnCRqZrwoM2itQXCTgODURo
         7Z81Vv+l/IQE+yzfm8ICwAYnkNEKGblKr2brhMVggjJlbuJA20vLWIXBFNjvSrUKygA/
         JzziMXMz5WAun6+d8pWQv6RBshIaUkStbI4Hp78j4pMhrFDcArUhzvHXOkjgb3HsIoZR
         496wSQxCyP+zJZBU1QjmwA2SY+Bs+5qR2t+r8AAbUBj5w+OYIv9vI7m7NDBtlqeKF7Xs
         RYtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742458928; x=1743063728;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OxQAaB8Yz41KD1jdn7keLA/hWjsaKMcGv+T1iV5fG+c=;
        b=oFp27lCyfTWuB6zvndiTmAx+nZUwVnrSt3dm3PqSObfZNbXumT3Qp/z50EwthNt+oM
         8GL6rr1ohfXm8hMuGLy0wHbCMnZP4ecom1LVf1uaaBVe7aM7lXXOQjCK08JIyQ4SaLcK
         NsyuI/RC/UquTxsPEDAcuz1ZNCJ9NCAm0ndUtWqnuO9C1cgrMeqSB7fy84fzAgSP4GBc
         kHvv5BEKtGPrMzAX57Fdqx5T9SdzDzUeX1anBC7PyTZgryO3hfa9vp/YIg7zt0vlqhzg
         y4Iio4gUB8wLXtxm3Ip9XMkuWhmnyvbTlj1VuzX+RxbB74AHUa5GCwGlt4T0JwUd/mow
         mDxg==
X-Forwarded-Encrypted: i=1; AJvYcCWl2T51PnxEbRftMVJgPvKAG2hbakh6enEYGLVah4SdqHSKtCBYq3qhj1y9rkUiJr3sz5c7/qX4Y4o=@vger.kernel.org, AJvYcCWm9DOZkqG99Cd3/WOWY7b03XrxXrJT11fePXCkFxSbQPWJfIMvyvofzQqu2mMdVHWdmi2Tk6zie0pNs/dk@vger.kernel.org
X-Gm-Message-State: AOJu0Yzgl4ARU+gkP421JAf5aJqhaUvRXNIjlbQRvZX7Lq7Px5EK/reX
	j2+zuD3PqJt2+NOoOdj1o2bi/nnSCZbj+sNQkQhLVIvN7Wuyzpfd
X-Gm-Gg: ASbGncuDqxkbquYLx9BMoi33A5chSm/f8WVOMNdbqVj2r7+WA7tYzDBgeNhlvgwpuLs
	4m87HIoQBJ6ugh0UcLLBzE1YTO7yo0Gwt4FtBaun9nj9VUSq/1N35iyRP5r2KVFiONMZ0SKi6jd
	I+10MS/5UpE2ygd0kn3OJVvO2OzLdCnjSXst0fSn2Iim+7k7jURJ32PtHjhyOJ4+upBMK13qVz8
	6iheRnuziaCBWIt/v4XOtgTJ2kS/2+Tn+iA33eDCaL5oNjKkhHSmfBOhloQoPhaQgbKpzIMK2gA
	Tut3O94RSlx53a176+99L7vdou6treChZXu53NogQPuxUoOn9UI=
X-Google-Smtp-Source: AGHT+IF1h+r7TIw7m2KcmzUyJMRxEA8ffO1++JOPUZ81jF28ylLGPy1VOZFDOc0iCvw5ewKQfqnV9Q==
X-Received: by 2002:a05:6512:3b10:b0:545:2e5d:f3f3 with SMTP id 2adb3069b0e04-54acb223dddmr1955802e87.46.1742458927569;
        Thu, 20 Mar 2025 01:22:07 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba864d7dsm2141770e87.130.2025.03.20.01.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 01:22:05 -0700 (PDT)
Date: Thu, 20 Mar 2025 10:22:00 +0200
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Nuno Sa <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Guillaume Stols <gstols@baylibre.com>,
	Dumitru Ceclan <mitrutzceclan@gmail.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Matteo Martelli <matteomartelli3@gmail.com>,
	Alisa-Dariana Roman <alisadariana@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	=?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: [PATCH v9 6/8] iio: adc: Support ROHM BD79124 ADC
Message-ID: <544371135e5ff5647c3cd4bce6d21e1b278ac183.1742457420.git.mazziesaccount@gmail.com>
References: <cover.1742457420.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lZgPgQk5qxxdP0Gn"
Content-Disposition: inline
In-Reply-To: <cover.1742457420.git.mazziesaccount@gmail.com>


--lZgPgQk5qxxdP0Gn
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

Thus do not support the BD79124's manual measurement mode but implement
the measurements using automatic measurement mode, relying on the
BD79124's ability of storing latest measurements into register.

Support also configuring the threshold events for detecting the
out-of-window events.

The BD79124 keeps asserting IRQ for as long as the measured voltage is
out of the configured window. Thus, prevent the user-space from choking
on the events and mask the received event for a fixed duration (1 second)
when an event is handled.

The ADC input pins can be also configured as general purpose outputs.
Make those pins which don't have corresponding ADC channel node in the
device-tree controllable as GPO.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
Revision history:
v8 =3D> v9:
 - Include asm/byteorder.h instead of linux/byteorder/generic.h
 - Fix the race in event value setting and event being suppressed
 - Styling
v7 =3D> v8:
 - Use unsigned for regmap values
 - Commit message fine tuning
 - Check devm_mutex_init() return value
 - Typofixes
 - Styling as suggested by Andy
 - Handle cases where all pins are ADCs or GPOs
 - Report 1 to user to indicate enabled event, regardless the direction.
v6 =3D> v7:
 - Styling
v5 =3D> v6:
 - Styling as suggested by Jonathan
v4 =3D> v5:
 - Drop unused interval defines
 - Append unit to interval define and drop a comment
 - Drop parenthesis around bitwise negation operation ~
 - Use proper block comment style
 - Improve the documentation of the re-enabling the events by moving
   comment explaining early return to the point of the return, and
   by adding own comment for the reason of locking before calling the
   re-enabling
 - Indenting
 - Drop unused struct bd79124_reg_init
 - Drop bd79124_init_mux() wrapper and call the regmap_write() directly
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
 drivers/iio/adc/rohm-bd79124.c | 1138 ++++++++++++++++++++++++++++++++
 3 files changed, 1151 insertions(+)
 create mode 100644 drivers/iio/adc/rohm-bd79124.c

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 0993008a1586..74d749c0cd8f 100644
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
index 000000000000..9cfa9052d3eb
--- /dev/null
+++ b/drivers/iio/adc/rohm-bd79124.c
@@ -0,0 +1,1138 @@
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
+#include <asm/byteorder.h>
+
+#include <linux/iio/events.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/adc-helpers.h>
+
+#define BD79124_I2C_MULTI_READ		0x30
+#define BD79124_I2C_MULTI_WRITE		0x28
+#define BD79124_REG_MAX			0xaf
+
+#define BD79124_REG_SYSTEM_STATUS	0x00
+#define BD79124_REG_GEN_CFG		0x01
+#define BD79124_REG_OPMODE_CFG		0x04
+#define BD79124_REG_PINCFG		0x05
+#define BD79124_REG_GPO_VAL		0x0B
+#define BD79124_REG_SEQ_CFG		0x10
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
+
+/* Masks for the BD79124_REG_OPMODE_CFG */
+#define BD79124_MSK_CONV_MODE GENMASK(6, 5)
+#define BD79124_CONV_MODE_MANSEQ 0
+#define BD79124_CONV_MODE_AUTO 1
+#define BD79124_MSK_AUTO_INTERVAL GENMASK(1, 0)
+#define BD79124_INTERVAL_750_US 0
+
+/* Masks for the BD79124_REG_GEN_CFG */
+#define BD79124_MSK_DWC_EN BIT(4)
+#define BD79124_MSK_STATS_EN BIT(5)
+
+/* Masks for the BD79124_REG_SEQ_CFG */
+#define BD79124_MSK_SEQ_START BIT(4)
+#define BD79124_MSK_SEQ_MODE GENMASK(1, 0)
+#define BD79124_MSK_SEQ_MANUAL 0
+#define BD79124_MSK_SEQ_SEQ 1
+
+#define BD79124_MSK_HYSTERESIS GENMASK(3, 0)
+#define BD79124_LOW_LIMIT_MIN 0
+#define BD79124_HIGH_LIMIT_MAX GENMASK(11, 0)
+
+/*
+ * The high limit, low limit and last measurement result are each stored in
+ * 2 consequtive registers. 4 bits are in the high bits of the first regis=
ter
+ * and 8 bits in the next register.
+ *
+ * These macros return the address of the first reg for the given channel.
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
+				    unsigned long *bits)
+{
+	unsigned int val;
+	int ret;
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
+	u8 val_bit0_3; /* Is set in high bits of the byte */
+	u8 val_bit4_11;
+};
+#define BD79124_RAW_TO_INT(r) ((r.val_bit4_11 << 4) | (r.val_bit0_3 >> 4))
+#define BD79124_INT_TO_RAW(val) {					\
+	.val_bit4_11 =3D (val) >> 4,					\
+	.val_bit0_3 =3D (val) << 4,					\
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
+ * The value bits [11:4] are stored in the next register.
+ *
+ * Convert the integer to register format and write it using rmw cycle.
+ */
+static int bd79124_write_int_to_reg(struct bd79124_data *data, int reg,
+				    unsigned int val)
+{
+	struct bd79124_raw raw =3D BD79124_INT_TO_RAW(val);
+	unsigned int tmp;
+	int ret;
+
+	ret =3D regmap_read(data->map, reg, &tmp);
+	if (ret)
+		return ret;
+
+	raw.val_bit0_3 |=3D (tmp & 0xf);
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
+
+		*val &=3D BD79124_MSK_HYSTERESIS;
+		/*
+		 * The data-sheet says the hysteresis register value needs to be
+		 * sifted left by 3.
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
+	unsigned int val, regval;
+	int ret;
+
+	/* See if already started */
+	ret =3D regmap_read(data->map, BD79124_REG_AUTO_CHANNELS, &val);
+	if (val & BIT(chan))
+		return 0;
+
+	/*
+	 * The sequencer must be stopped when channels are added/removed from
+	 * the list of the measured channels to ensure the new channel
+	 * configuration is used.
+	 */
+	ret =3D regmap_clear_bits(data->map, BD79124_REG_SEQ_CFG,
+				BD79124_MSK_SEQ_START);
+	if (ret)
+		return ret;
+
+	ret =3D regmap_write(data->map, BD79124_REG_AUTO_CHANNELS, val | BIT(chan=
));
+	if (ret)
+		return ret;
+
+	ret =3D regmap_set_bits(data->map, BD79124_REG_SEQ_CFG,
+			      BD79124_MSK_SEQ_START);
+	if (ret)
+		return ret;
+
+	/*
+	 * Start the measurement at the background. Don't bother checking if
+	 * it was started, regmap has cache.
+	 */
+	regval =3D FIELD_PREP(BD79124_MSK_CONV_MODE, BD79124_CONV_MODE_AUTO);
+
+	return regmap_update_bits(data->map, BD79124_REG_OPMODE_CFG,
+				BD79124_MSK_CONV_MODE, regval);
+}
+
+static int bd79124_stop_measurement(struct bd79124_data *data, int chan)
+{
+	unsigned int enabled_chans;
+	int ret;
+
+	/* See if already stopped */
+	ret =3D regmap_read(data->map, BD79124_REG_AUTO_CHANNELS, &enabled_chans);
+	if (!(enabled_chans & BIT(chan)))
+		return 0;
+
+	ret =3D regmap_clear_bits(data->map, BD79124_REG_SEQ_CFG,
+				BD79124_MSK_SEQ_START);
+
+	/* Clear the channel from the measured channels */
+	enabled_chans &=3D ~BIT(chan);
+	ret =3D regmap_write(data->map, BD79124_REG_AUTO_CHANNELS,
+			   enabled_chans);
+	if (ret)
+		return ret;
+
+	/*
+	 * Stop background conversion for power saving if it was the last
+	 * channel.
+	 */
+	if (!enabled_chans) {
+		int regval =3D FIELD_PREP(BD79124_MSK_CONV_MODE,
+					BD79124_CONV_MODE_MANSEQ);
+
+		ret =3D regmap_update_bits(data->map, BD79124_REG_OPMODE_CFG,
+					 BD79124_MSK_CONV_MODE, regval);
+		if (ret)
+			return ret;
+	}
+
+	return regmap_set_bits(data->map, BD79124_REG_SEQ_CFG,
+			       BD79124_MSK_SEQ_START);
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
+	return !!(data->alarm_monitored[chan->channel] & BIT(dir));
+}
+
+static int bd79124_disable_event(struct bd79124_data *data,
+				 enum iio_event_direction dir, int channel)
+{
+	int dir_bit =3D BIT(dir);
+	int reg;
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
+	data->alarm_monitored[channel] &=3D ~dir_bit;
+	/*
+	 * Stop measurement if there is no more events to monitor.
+	 * We don't bother checking the retval because the limit
+	 * setting should in any case effectively disable the alarm.
+	 */
+	if (!data->alarm_monitored[channel]) {
+		bd79124_stop_measurement(data, channel);
+		regmap_clear_bits(data->map, BD79124_REG_ALERT_CH_SEL,
+				  BIT(channel));
+	}
+
+	return bd79124_write_int_to_reg(data, reg, limit);
+}
+
+static int bd79124_enable_event(struct bd79124_data *data,
+				enum iio_event_direction dir,
+				unsigned int channel)
+{
+	int dir_bit =3D BIT(dir);
+	int reg, ret;
+	u16 *limit;
+
+	guard(mutex)(&data->mutex);
+	ret =3D bd79124_start_measurement(data, channel);
+	if (ret)
+		return ret;
+
+	data->alarm_monitored[channel] |=3D dir_bit;
+
+	/* Add the channel to the list of monitored channels */
+	ret =3D regmap_set_bits(data->map, BD79124_REG_ALERT_CH_SEL, BIT(channel)=
);
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
+	/*
+	 * Don't write the new limit to the hardware if we are in the
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
+				      BD79124_MSK_DWC_EN);
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
+	{
+		guard(mutex)(&data->mutex);
+
+		if (dir =3D=3D IIO_EV_DIR_RISING) {
+			data->alarm_r_limit[chan->channel] =3D val;
+			reg =3D BD79124_GET_HIGH_LIMIT_REG(chan->channel);
+		} else if (dir =3D=3D IIO_EV_DIR_FALLING) {
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
+	}
+	case IIO_EV_INFO_HYSTERESIS:
+		reg =3D BD79124_GET_HYSTERESIS_REG(chan->channel);
+		val >>=3D 3;
+
+		return regmap_update_bits(data->map, reg, BD79124_MSK_HYSTERESIS,
+					  val);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int bd79124_single_chan_seq(struct bd79124_data *data, int chan, un=
signed int *old)
+{
+	int ret;
+
+	ret =3D regmap_clear_bits(data->map, BD79124_REG_SEQ_CFG,
+				BD79124_MSK_SEQ_START);
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
+	return regmap_set_bits(data->map, BD79124_REG_SEQ_CFG,
+			       BD79124_MSK_SEQ_START);
+}
+
+static int bd79124_single_chan_seq_end(struct bd79124_data *data, unsigned=
 int old)
+{
+	int ret;
+
+	ret =3D regmap_clear_bits(data->map, BD79124_REG_SEQ_CFG,
+				BD79124_MSK_SEQ_START);
+	if (ret)
+		return ret;
+
+	ret =3D regmap_write(data->map, BD79124_REG_AUTO_CHANNELS, old);
+	if (ret)
+		return ret;
+
+	return regmap_set_bits(data->map, BD79124_REG_SEQ_CFG,
+			       BD79124_MSK_SEQ_START);
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
+		unsigned int old_chan_cfg, regval;
+		int tmp;
+
+		guard(mutex)(&data->mutex);
+
+		/*
+		 * Start the automatic conversion. This is needed here if no
+		 * events have been enabled.
+		 */
+		regval =3D FIELD_PREP(BD79124_MSK_CONV_MODE,
+				    BD79124_CONV_MODE_AUTO);
+		ret =3D regmap_update_bits(data->map, BD79124_REG_OPMODE_CFG,
+					 BD79124_MSK_CONV_MODE, regval);
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
+			BD79124_GET_RECENT_RES_REG(chan->channel), val);
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
+	/*
+	 * We should not re-enable the event if user has disabled it while
+	 * rate-limiting was enabled.
+	 */
+	if (!(data->alarm_suppressed[channel] & evbit))
+		return;
+
+	data->alarm_suppressed[channel] &=3D ~evbit;
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
+	/*
+	 * We should not re-enable the event if user has disabled it while
+	 * rate-limiting was enabled.
+	 */
+	if (!(data->alarm_suppressed[channel] & evbit))
+		return;
+
+	data->alarm_suppressed[channel] &=3D ~evbit;
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
+	/* Take the mutex so there is no race with user disabling the alarm */
+	guard(mutex)(&data->mutex);
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
+	schedule_delayed_work(&data->alm_enable_work, msecs_to_jiffies(1000));
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
+	unsigned int i_hi, i_lo;
+	int i, ret;
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
+						     IIO_EV_TYPE_THRESH,
+						     IIO_EV_DIR_RISING);
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
+						     IIO_EV_TYPE_THRESH,
+						     IIO_EV_DIR_FALLING);
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
+static int bd79124_chan_init(struct bd79124_data *data, int channel)
+{
+	int ret;
+
+	ret =3D regmap_write(data->map, BD79124_GET_HIGH_LIMIT_REG(channel),
+			   BD79124_HIGH_LIMIT_MAX);
+	if (ret)
+		return ret;
+
+	return regmap_write(data->map, BD79124_GET_LOW_LIMIT_REG(channel),
+			    BD79124_LOW_LIMIT_MIN);
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
+		gpio_channels &=3D ~BIT(cs[i].channel);
+
+	return gpio_channels;
+}
+
+static int bd79124_hw_init(struct bd79124_data *data)
+{
+	unsigned int regval;
+	int ret, i;
+
+	for (i =3D 0; i < BD79124_MAX_NUM_CHANNELS; i++) {
+		ret =3D bd79124_chan_init(data, i);
+		if (ret)
+			return ret;
+		data->alarm_r_limit[i] =3D BD79124_HIGH_LIMIT_MAX;
+	}
+	/* Stop auto sequencer */
+	ret =3D regmap_clear_bits(data->map, BD79124_REG_SEQ_CFG,
+				BD79124_MSK_SEQ_START);
+	if (ret)
+		return ret;
+
+	/* Enable writing the measured values to the regsters */
+	ret =3D regmap_set_bits(data->map, BD79124_REG_GEN_CFG,
+			      BD79124_MSK_STATS_EN);
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
+	regval =3D FIELD_PREP(BD79124_MSK_AUTO_INTERVAL, BD79124_INTERVAL_750_US);
+	ret =3D regmap_update_bits(data->map, BD79124_REG_OPMODE_CFG,
+				 BD79124_MSK_AUTO_INTERVAL, regval);
+	if (ret)
+		return ret;
+
+	/* Sequencer mode to auto */
+	ret =3D regmap_set_bits(data->map, BD79124_REG_SEQ_CFG,
+			      BD79124_MSK_SEQ_SEQ);
+	if (ret)
+		return ret;
+
+	/* Don't start the measurement */
+	regval =3D FIELD_PREP(BD79124_MSK_CONV_MODE, BD79124_CONV_MODE_MANSEQ);
+	return regmap_update_bits(data->map, BD79124_REG_OPMODE_CFG,
+				  BD79124_MSK_CONV_MODE, regval);
+}
+
+static int bd79124_probe(struct i2c_client *i2c)
+{
+	struct bd79124_data *data;
+	struct iio_dev *iio_dev;
+	const struct iio_chan_spec *template;
+	struct iio_chan_spec *cs;
+	struct device *dev =3D &i2c->dev;
+	unsigned int gpio_pins;
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
+
+	ret =3D devm_mutex_init(dev, &data->mutex);
+	if (ret)
+		return ret;
+
+	ret =3D devm_iio_adc_device_alloc_chaninfo_se(dev, template,
+		BD79124_MAX_NUM_CHANNELS - 1, &cs);
+	if (ret < 0) {
+		/* Register all pins as GPOs if there are no ADC channels */
+		if (ret =3D=3D -ENOENT)
+			goto register_gpios;
+		return ret;
+	}
+	iio_dev->channels =3D cs;
+	iio_dev->num_channels =3D ret;
+	iio_dev->info =3D &bd79124_info;
+	iio_dev->name =3D "bd79124";
+	iio_dev->modes =3D INDIO_DIRECT_MODE;
+
+	ret =3D bd79124_hw_init(data);
+	if (ret)
+		return ret;
+
+	if (i2c->irq > 0) {
+		ret =3D devm_request_threaded_irq(dev, i2c->irq,
+			bd79124_irq_handler, &bd79124_event_handler,
+			IRQF_ONESHOT, "adc-thresh-alert", iio_dev);
+		if (ret)
+			return dev_err_probe(data->dev, ret,
+					     "Failed to register IRQ\n");
+	}
+
+	ret =3D devm_iio_device_register(data->dev, iio_dev);
+	if (ret)
+		return dev_err_probe(data->dev, ret, "Failed to register ADC\n");
+
+register_gpios:
+	gpio_pins =3D bd79124_get_gpio_pins(iio_dev->channels,
+					  iio_dev->num_channels);
+
+	/*
+	 * The mux should default to "all ADCs", but better to not trust it.
+	 * Thus we do set the mux even when we have only ADCs and no GPOs.
+	 */
+	ret =3D regmap_write(data->map, BD79124_REG_PINCFG, gpio_pins);
+	if (ret)
+		return ret;
+
+	/* No GPOs if all channels are reserved for ADC, so we're done. */
+	if (!gpio_pins)
+		return 0;
+
+	data->gpio_valid_mask =3D gpio_pins;
+	data->gc =3D bd79124gpo_chip;
+	data->gc.parent =3D dev;
+
+	return devm_gpiochip_add_data(dev, &data->gc, data);
+}
+
+static const struct of_device_id bd79124_of_match[] =3D {
+	{ .compatible =3D "rohm,bd79124" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, bd79124_of_match);
+
+static const struct i2c_device_id bd79124_id[] =3D {
+	{ "bd79124" },
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


--lZgPgQk5qxxdP0Gn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmfb0CgACgkQeFA3/03a
ocWOswf/cU4ODF510ZAlDXAWE3vsTPOx2/WSgil2E0puW8Hz8tetb4ypqolndG+s
4eHV2OZy4YUmQPID/nMCGYPNuOsJAPRlIbPzY8sws6rtIb+iGMbRuj4qGfJmmqmA
InsZ8WIZcsrGK8ZnFylxyfQNX7AaHB7wjRNV5FH4gYVE0HkybzUTO3zhpLS3pv7R
w1+xiA5pi2dOXTkvtoboERcJtpoo7ZN+x4H8+OGM9+3ULYcuih1PsGV4Zg1sJ5MC
ItLBrGx04Dy3pI4wcYlPTAb/4C66CpZ+63FCW3yXKg+XOyRloiTMwWxjfCnslzN5
XwPGDP/Ybre4GxDUnOFuYxS8VZFFFQ==
=S63u
-----END PGP SIGNATURE-----

--lZgPgQk5qxxdP0Gn--

