Return-Path: <linux-iio+bounces-12795-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD9659DBC94
	for <lists+linux-iio@lfdr.de>; Thu, 28 Nov 2024 20:35:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FFE5164829
	for <lists+linux-iio@lfdr.de>; Thu, 28 Nov 2024 19:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C181E1C2334;
	Thu, 28 Nov 2024 19:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZOSMgGrh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC281C1F37;
	Thu, 28 Nov 2024 19:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732822531; cv=none; b=ltSsE2MVJKdNoUmlX/a5PPlR0jbEp/P0xz4z9qe31MVcgFKF2p8Ij+qyUTAJLo+KPjVFlCw2KdekW2gq+QI6nmo7RCJRAip7NRNRRRqr6cj7qx2utWtT+Hs1h2Q6l9UWNIRWlKP6xmmkw2XJkgyXinKvEpQIDIrpmVng/kc2ib8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732822531; c=relaxed/simple;
	bh=Cc8gJalAXrCRqYvBPujCbTC/GHQ4xhpjecL3nw4UQLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FXiJ5ohouCzVGcQL86kgoM3zwRTZ0lZuTIgBtgsviawW2LCNbbNhB6F7zHV+yfuES1iZ3KB+ThyfyO1vOAaraFRT9hvnaMZaSDZEf3B+1OhG9JJGVDWyB74ElECw7rBku2wNOeLJusx+fJ+M7FnnoE3DGmhXgbYZIZioK36ncWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZOSMgGrh; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-53dde5262fdso1337589e87.2;
        Thu, 28 Nov 2024 11:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732822525; x=1733427325; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6efIUg3gkIzcL0aDa+rqfd759JDnbz5x18n/GiNPIQo=;
        b=ZOSMgGrhObf56Bsg/G8wE4iqQYY9d1DTDnXXvwehmPfr/mkkwq8kWRz3fWz5lX4Cmx
         ZrTrHhmCDN12h57ufc7AL8WpMMp8rn7De0KGZtKPgh46mX69OaCodL2xfl7D0FRCjV9j
         VtB2BTb3kFdR7KBRil/xo1kingSYlI6gKcv8Esvqh81ZTa6KiHNIbRFRovduxKFTDi8X
         e7MwWYFFKeYIjljckFgi8BMG3LTbPZ4khDKb18xVcj873R1JbMJo7IqOGakn/wuobo6N
         jkpADVsN/j2nR7c2fMAMHECjH0ylP5+63WZAftE05z4sosDJMcXWVFFE/k54758imCFM
         KIsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732822525; x=1733427325;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6efIUg3gkIzcL0aDa+rqfd759JDnbz5x18n/GiNPIQo=;
        b=axYDzVkSTB7bzneM6aWqPN7psCdc6aSFcIAIABrqL2YE7tZuF93nHvntkCWSez/LRF
         J5f0owW4v3IILfvyYmjGWp5/vQxmXbEz14Uoj7VZFTu2pCcolxnKZB3tTXDQ1JyhPImV
         wyEZEM8ij8dylpK+ZmgQ+Xu96kNElBLc/FVoKCh+ZHoyeJB1rnj4Y8WLJ6yWRy+6qER0
         4MMFK9A8jAj8Eem5lqbKX1m5oMEQJ/kU79BLyufsc6c6drrpXkitT+IQI5eCeOh5oadH
         V8DHS/xRYvGxdVubRhMUjGYKcIsb9fX5mu7O60GvO/5rxdAQMYkFY4lph2sFPpXH6QEQ
         NVfA==
X-Forwarded-Encrypted: i=1; AJvYcCUvjCyt63ldAv2cbFYNEqVXBuznehBAy3R+icuOZsqKjXEX2eQsY1cGJBYSKbG8y+I/S0RmgmnGUbCuZrkx@vger.kernel.org, AJvYcCV/QG4LHDfB0lWukjEVt9yCes/ZLq1Tw5/aXZ8DynVoZCoInGAMAVxbiKV8sshCKtWTpuFIrzfhDzli@vger.kernel.org, AJvYcCX4LMelXW2kcyXgGlscE9dLq+39qh08zOgB7tSYGHq1mIAEhJuhOGujwMVrf1xDRuSAQe/cNluEhoc+@vger.kernel.org
X-Gm-Message-State: AOJu0YySc0hG+biBxTvd/wW+HFLdBaJRHUUJjO6YQx5rgoyWQ0ZVsJxb
	ZZO96lCHuRGmmfafnOgfHan8DNiKPzjGl30JsAQxnoYbr1vXA71s
X-Gm-Gg: ASbGncu1tVIQazDe8kuHGmvmXlbMm156NZcpLqICG+iF9v3vkxSYO42GVdNbM1MoQ9p
	zrxi/VsH7xntdIsfQPT4SkF50sdIkFFvPBbLk5Xr6zsW0/2+yoRP1ecv/2f7+V0T4mGQzafZu+p
	RF2UwGLjgLNuaGBUPrAUMGPGa7LyazkzsRsHWC23mfXKeWvXvN7tg+H4SeSAIA0uv03S1uGz7+J
	1SaDLNxolP2fVQvfGHcgWoyJPx8Nykp79k3VP1JtHWMcLvnzwpvVnL+
X-Google-Smtp-Source: AGHT+IHIIW2GwO0m6GKqXMn4pExgzvGceIAjkrZk75t0mQ0FVyk9G9AkCHika3twHozZlYBFWeexvA==
X-Received: by 2002:a05:6512:32c9:b0:52c:dc97:45d1 with SMTP id 2adb3069b0e04-53df00c789cmr4872244e87.10.1732822524386;
        Thu, 28 Nov 2024 11:35:24 -0800 (PST)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df649f6f2sm259448e87.246.2024.11.28.11.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 11:35:22 -0800 (PST)
Date: Thu, 28 Nov 2024 21:35:18 +0200
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Arthur Becker <arthur.becker@sentec.com>,
	Emil Gedenryd <emil.gedenryd@axis.com>, Marek Vasut <marex@denx.de>,
	Mudit Sharma <muditsharma.info@gmail.com>,
	Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] iio: light: Drop BU27008 and BU27010
Message-ID: <f4d0aa31f29f160a06cba4856a034fa5636d3372.1732819203.git.mazziesaccount@gmail.com>
References: <cover.1732819203.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="eT1uhLza7d2CeyD/"
Content-Disposition: inline
In-Reply-To: <cover.1732819203.git.mazziesaccount@gmail.com>


--eT1uhLza7d2CeyD/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The ROHM BU27008 and BU27010 RGB sensors got cancelled. I was informed
they never reached mass production stage.

Keeping the drivers around is waste of maintenance resources. Drop the
drivers.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
 MAINTAINERS                      |    1 -
 drivers/iio/light/Kconfig        |   16 -
 drivers/iio/light/Makefile       |    1 -
 drivers/iio/light/rohm-bu27008.c | 1635 ------------------------------
 4 files changed, 1653 deletions(-)
 delete mode 100644 drivers/iio/light/rohm-bu27008.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 3fd398d6e64f..932a113ffed2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20038,7 +20038,6 @@ ROHM BU270xx LIGHT SENSOR DRIVERs
 M:	Matti Vaittinen <mazziesaccount@gmail.com>
 L:	linux-iio@vger.kernel.org
 S:	Supported
-F:	drivers/iio/light/rohm-bu27008.c
 F:	drivers/iio/light/rohm-bu27034.c
=20
 ROHM MULTIFUNCTION BD9571MWV-M PMIC DEVICE DRIVERS
diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index 29ffa8491927..074caa5597c7 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -329,22 +329,6 @@ config JSA1212
 	  To compile this driver as a module, choose M here:
 	  the module will be called jsa1212.
=20
-config ROHM_BU27008
-	tristate "ROHM BU27008 color (RGB+C/IR) sensor"
-	depends on I2C
-	select REGMAP_I2C
-	select IIO_GTS_HELPER
-	select IIO_BUFFER
-	select IIO_TRIGGERED_BUFFER
-	help
-	  Enable support for the ROHM BU27008 color sensor.
-	  The ROHM BU27008 is a sensor with 5 photodiodes (red, green,
-	  blue, clear and IR) with four configurable channels. Red and
-	  green being always available and two out of the rest three
-	  (blue, clear, IR) can be selected to be simultaneously measured.
-	  Typical application is adjusting LCD backlight of TVs,
-	  mobile phones and tablet PCs.
-
 config ROHM_BU27034
 	tristate "ROHM BU27034 ambient light sensor"
 	depends on I2C
diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
index f14a37442712..56beb324f34f 100644
--- a/drivers/iio/light/Makefile
+++ b/drivers/iio/light/Makefile
@@ -43,7 +43,6 @@ obj-$(CONFIG_NOA1305)		+=3D noa1305.o
 obj-$(CONFIG_OPT3001)		+=3D opt3001.o
 obj-$(CONFIG_OPT4001)		+=3D opt4001.o
 obj-$(CONFIG_PA12203001)	+=3D pa12203001.o
-obj-$(CONFIG_ROHM_BU27008)	+=3D rohm-bu27008.o
 obj-$(CONFIG_ROHM_BU27034)	+=3D rohm-bu27034.o
 obj-$(CONFIG_RPR0521)		+=3D rpr0521.o
 obj-$(CONFIG_SI1133)		+=3D si1133.o
diff --git a/drivers/iio/light/rohm-bu27008.c b/drivers/iio/light/rohm-bu27=
008.c
deleted file mode 100644
index 0f010eff1981..000000000000
--- a/drivers/iio/light/rohm-bu27008.c
+++ /dev/null
@@ -1,1635 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * ROHM Colour Sensor driver for
- * - BU27008 RGBC sensor
- * - BU27010 RGBC + Flickering sensor
- *
- * Copyright (c) 2023, ROHM Semiconductor.
- */
-
-#include <linux/bitfield.h>
-#include <linux/bitops.h>
-#include <linux/device.h>
-#include <linux/i2c.h>
-#include <linux/interrupt.h>
-#include <linux/module.h>
-#include <linux/property.h>
-#include <linux/regmap.h>
-#include <linux/regulator/consumer.h>
-#include <linux/units.h>
-
-#include <linux/iio/iio.h>
-#include <linux/iio/iio-gts-helper.h>
-#include <linux/iio/trigger.h>
-#include <linux/iio/trigger_consumer.h>
-#include <linux/iio/triggered_buffer.h>
-
-/*
- * A word about register address and mask definitions.
- *
- * At a quick glance to the data-sheet register tables, the BU27010 has al=
l the
- * registers that the BU27008 has. On top of that the BU27010 adds couple =
of new
- * ones.
- *
- * So, all definitions BU27008_REG_* are there also for BU27010 but none o=
f the
- * BU27010_REG_* are present on BU27008. This makes sense as BU27010 just =
adds
- * some features (Flicker FIFO, more power control) on top of the BU27008.
- *
- * Unfortunately, some of the wheel has been re-invented. Even though the =
names
- * of the registers have stayed the same, pretty much all of the functiona=
lity
- * provided by the registers has changed place. Contents of all MODE_CONTR=
OL
- * registers on BU27008 and BU27010 are different.
- *
- * Chip-specific mapping from register addresses/bits to functionality is =
done
- * in bu27_chip_data structures.
- */
-#define BU27008_REG_SYSTEM_CONTROL	0x40
-#define BU27008_MASK_SW_RESET		BIT(7)
-#define BU27008_MASK_PART_ID		GENMASK(5, 0)
-#define BU27008_ID			0x1a
-#define BU27008_REG_MODE_CONTROL1	0x41
-#define BU27008_MASK_MEAS_MODE		GENMASK(2, 0)
-#define BU27008_MASK_CHAN_SEL		GENMASK(3, 2)
-
-#define BU27008_REG_MODE_CONTROL2	0x42
-#define BU27008_MASK_RGBC_GAIN		GENMASK(7, 3)
-#define BU27008_MASK_IR_GAIN_LO		GENMASK(2, 0)
-#define BU27008_SHIFT_IR_GAIN		3
-
-#define BU27008_REG_MODE_CONTROL3	0x43
-#define BU27008_MASK_VALID		BIT(7)
-#define BU27008_MASK_INT_EN		BIT(1)
-#define BU27008_INT_EN			BU27008_MASK_INT_EN
-#define BU27008_INT_DIS			0
-#define BU27008_MASK_MEAS_EN		BIT(0)
-#define BU27008_MEAS_EN			BIT(0)
-#define BU27008_MEAS_DIS		0
-
-#define BU27008_REG_DATA0_LO		0x50
-#define BU27008_REG_DATA1_LO		0x52
-#define BU27008_REG_DATA2_LO		0x54
-#define BU27008_REG_DATA3_LO		0x56
-#define BU27008_REG_DATA3_HI		0x57
-#define BU27008_REG_MANUFACTURER_ID	0x92
-#define BU27008_REG_MAX BU27008_REG_MANUFACTURER_ID
-
-/* BU27010 specific definitions */
-
-#define BU27010_MASK_SW_RESET		BIT(7)
-#define BU27010_ID			0x1b
-#define BU27010_REG_POWER		0x3e
-#define BU27010_MASK_POWER		BIT(0)
-
-#define BU27010_REG_RESET		0x3f
-#define BU27010_MASK_RESET		BIT(0)
-#define BU27010_RESET_RELEASE		BU27010_MASK_RESET
-
-#define BU27010_MASK_MEAS_EN		BIT(1)
-
-#define BU27010_MASK_CHAN_SEL		GENMASK(7, 6)
-#define BU27010_MASK_MEAS_MODE		GENMASK(5, 4)
-#define BU27010_MASK_RGBC_GAIN		GENMASK(3, 0)
-
-#define BU27010_MASK_DATA3_GAIN		GENMASK(7, 6)
-#define BU27010_MASK_DATA2_GAIN		GENMASK(5, 4)
-#define BU27010_MASK_DATA1_GAIN		GENMASK(3, 2)
-#define BU27010_MASK_DATA0_GAIN		GENMASK(1, 0)
-
-#define BU27010_MASK_FLC_MODE		BIT(7)
-#define BU27010_MASK_FLC_GAIN		GENMASK(4, 0)
-
-#define BU27010_REG_MODE_CONTROL4	0x44
-/* If flicker is ever to be supported the IRQ must be handled as a field */
-#define BU27010_IRQ_DIS_ALL		GENMASK(1, 0)
-#define BU27010_DRDY_EN			BIT(0)
-#define BU27010_MASK_INT_SEL		GENMASK(1, 0)
-
-#define BU27010_REG_MODE_CONTROL5	0x45
-#define BU27010_MASK_RGB_VALID		BIT(7)
-#define BU27010_MASK_FLC_VALID		BIT(6)
-#define BU27010_MASK_WAIT_EN		BIT(3)
-#define BU27010_MASK_FIFO_EN		BIT(2)
-#define BU27010_MASK_RGB_EN		BIT(1)
-#define BU27010_MASK_FLC_EN		BIT(0)
-
-#define BU27010_REG_DATA_FLICKER_LO	0x56
-#define BU27010_MASK_DATA_FLICKER_HI	GENMASK(2, 0)
-#define BU27010_REG_FLICKER_COUNT	0x5a
-#define BU27010_REG_FIFO_LEVEL_LO	0x5b
-#define BU27010_MASK_FIFO_LEVEL_HI	BIT(0)
-#define BU27010_REG_FIFO_DATA_LO	0x5d
-#define BU27010_REG_FIFO_DATA_HI	0x5e
-#define BU27010_MASK_FIFO_DATA_HI	GENMASK(2, 0)
-#define BU27010_REG_MANUFACTURER_ID	0x92
-#define BU27010_REG_MAX BU27010_REG_MANUFACTURER_ID
-
-/**
- * enum bu27008_chan_type - BU27008 channel types
- * @BU27008_RED:	Red channel. Always via data0.
- * @BU27008_GREEN:	Green channel. Always via data1.
- * @BU27008_BLUE:	Blue channel. Via data2 (when used).
- * @BU27008_CLEAR:	Clear channel. Via data2 or data3 (when used).
- * @BU27008_IR:		IR channel. Via data3 (when used).
- * @BU27008_LUX:	Illuminance channel, computed using RGB and IR.
- * @BU27008_NUM_CHANS:	Number of channel types.
- */
-enum bu27008_chan_type {
-	BU27008_RED,
-	BU27008_GREEN,
-	BU27008_BLUE,
-	BU27008_CLEAR,
-	BU27008_IR,
-	BU27008_LUX,
-	BU27008_NUM_CHANS
-};
-
-/**
- * enum bu27008_chan - BU27008 physical data channel
- * @BU27008_DATA0:		Always red.
- * @BU27008_DATA1:		Always green.
- * @BU27008_DATA2:		Blue or clear.
- * @BU27008_DATA3:		IR or clear.
- * @BU27008_NUM_HW_CHANS:	Number of physical channels
- */
-enum bu27008_chan {
-	BU27008_DATA0,
-	BU27008_DATA1,
-	BU27008_DATA2,
-	BU27008_DATA3,
-	BU27008_NUM_HW_CHANS
-};
-
-/* We can always measure red and green at same time */
-#define ALWAYS_SCANNABLE (BIT(BU27008_RED) | BIT(BU27008_GREEN))
-
-/* We use these data channel configs. Ensure scan_masks below follow them =
too */
-#define BU27008_BLUE2_CLEAR3		0x0 /* buffer is R, G, B, C */
-#define BU27008_CLEAR2_IR3		0x1 /* buffer is R, G, C, IR */
-#define BU27008_BLUE2_IR3		0x2 /* buffer is R, G, B, IR */
-
-static const unsigned long bu27008_scan_masks[] =3D {
-	/* buffer is R, G, B, C */
-	ALWAYS_SCANNABLE | BIT(BU27008_BLUE) | BIT(BU27008_CLEAR),
-	/* buffer is R, G, C, IR */
-	ALWAYS_SCANNABLE | BIT(BU27008_CLEAR) | BIT(BU27008_IR),
-	/* buffer is R, G, B, IR */
-	ALWAYS_SCANNABLE | BIT(BU27008_BLUE) | BIT(BU27008_IR),
-	/* buffer is R, G, B, IR, LUX */
-	ALWAYS_SCANNABLE | BIT(BU27008_BLUE) | BIT(BU27008_IR) | BIT(BU27008_LUX),
-	0
-};
-
-/*
- * Available scales with gain 1x - 1024x, timings 55, 100, 200, 400 mS
- * Time impacts to gain: 1x, 2x, 4x, 8x.
- *
- * =3D> Max total gain is HWGAIN * gain by integration time (8 * 1024) =3D=
 8192
- *
- * Max amplification is (HWGAIN * MAX integration-time multiplier) 1024 * 8
- * =3D 8192. With NANO scale we get rid of accuracy loss when we start wit=
h the
- * scale 16.0 for HWGAIN1, INT-TIME 55 mS. This way the nano scale for MAX
- * total gain 8192 will be 1953125
- */
-#define BU27008_SCALE_1X 16
-
-/*
- * On BU27010 available scales with gain 1x - 4096x,
- * timings 55, 100, 200, 400 mS. Time impacts to gain: 1x, 2x, 4x, 8x.
- *
- * =3D> Max total gain is HWGAIN * gain by integration time (8 * 4096)
- *
- * Using NANO precision for scale we must use scale 64x corresponding gain=
 1x
- * to avoid precision loss.
- */
-#define BU27010_SCALE_1X 64
-
-/* See the data sheet for the "Gain Setting" table */
-#define BU27008_GSEL_1X		0x00
-#define BU27008_GSEL_4X		0x08
-#define BU27008_GSEL_8X		0x09
-#define BU27008_GSEL_16X	0x0a
-#define BU27008_GSEL_32X	0x0b
-#define BU27008_GSEL_64X	0x0c
-#define BU27008_GSEL_256X	0x18
-#define BU27008_GSEL_512X	0x19
-#define BU27008_GSEL_1024X	0x1a
-
-static const struct iio_gain_sel_pair bu27008_gains[] =3D {
-	GAIN_SCALE_GAIN(1, BU27008_GSEL_1X),
-	GAIN_SCALE_GAIN(4, BU27008_GSEL_4X),
-	GAIN_SCALE_GAIN(8, BU27008_GSEL_8X),
-	GAIN_SCALE_GAIN(16, BU27008_GSEL_16X),
-	GAIN_SCALE_GAIN(32, BU27008_GSEL_32X),
-	GAIN_SCALE_GAIN(64, BU27008_GSEL_64X),
-	GAIN_SCALE_GAIN(256, BU27008_GSEL_256X),
-	GAIN_SCALE_GAIN(512, BU27008_GSEL_512X),
-	GAIN_SCALE_GAIN(1024, BU27008_GSEL_1024X),
-};
-
-static const struct iio_gain_sel_pair bu27008_gains_ir[] =3D {
-	GAIN_SCALE_GAIN(2, BU27008_GSEL_1X),
-	GAIN_SCALE_GAIN(4, BU27008_GSEL_4X),
-	GAIN_SCALE_GAIN(8, BU27008_GSEL_8X),
-	GAIN_SCALE_GAIN(16, BU27008_GSEL_16X),
-	GAIN_SCALE_GAIN(32, BU27008_GSEL_32X),
-	GAIN_SCALE_GAIN(64, BU27008_GSEL_64X),
-	GAIN_SCALE_GAIN(256, BU27008_GSEL_256X),
-	GAIN_SCALE_GAIN(512, BU27008_GSEL_512X),
-	GAIN_SCALE_GAIN(1024, BU27008_GSEL_1024X),
-};
-
-#define BU27010_GSEL_1X		0x00	/* 000000 */
-#define BU27010_GSEL_4X		0x08	/* 001000 */
-#define BU27010_GSEL_16X	0x09	/* 001001 */
-#define BU27010_GSEL_64X	0x0e	/* 001110 */
-#define BU27010_GSEL_256X	0x1e	/* 011110 */
-#define BU27010_GSEL_1024X	0x2e	/* 101110 */
-#define BU27010_GSEL_4096X	0x3f	/* 111111 */
-
-static const struct iio_gain_sel_pair bu27010_gains[] =3D {
-	GAIN_SCALE_GAIN(1, BU27010_GSEL_1X),
-	GAIN_SCALE_GAIN(4, BU27010_GSEL_4X),
-	GAIN_SCALE_GAIN(16, BU27010_GSEL_16X),
-	GAIN_SCALE_GAIN(64, BU27010_GSEL_64X),
-	GAIN_SCALE_GAIN(256, BU27010_GSEL_256X),
-	GAIN_SCALE_GAIN(1024, BU27010_GSEL_1024X),
-	GAIN_SCALE_GAIN(4096, BU27010_GSEL_4096X),
-};
-
-static const struct iio_gain_sel_pair bu27010_gains_ir[] =3D {
-	GAIN_SCALE_GAIN(2, BU27010_GSEL_1X),
-	GAIN_SCALE_GAIN(4, BU27010_GSEL_4X),
-	GAIN_SCALE_GAIN(16, BU27010_GSEL_16X),
-	GAIN_SCALE_GAIN(64, BU27010_GSEL_64X),
-	GAIN_SCALE_GAIN(256, BU27010_GSEL_256X),
-	GAIN_SCALE_GAIN(1024, BU27010_GSEL_1024X),
-	GAIN_SCALE_GAIN(4096, BU27010_GSEL_4096X),
-};
-
-#define BU27008_MEAS_MODE_100MS		0x00
-#define BU27008_MEAS_MODE_55MS		0x01
-#define BU27008_MEAS_MODE_200MS		0x02
-#define BU27008_MEAS_MODE_400MS		0x04
-
-#define BU27010_MEAS_MODE_100MS		0x00
-#define BU27010_MEAS_MODE_55MS		0x03
-#define BU27010_MEAS_MODE_200MS		0x01
-#define BU27010_MEAS_MODE_400MS		0x02
-
-#define BU27008_MEAS_TIME_MAX_MS	400
-
-static const struct iio_itime_sel_mul bu27008_itimes[] =3D {
-	GAIN_SCALE_ITIME_US(400000, BU27008_MEAS_MODE_400MS, 8),
-	GAIN_SCALE_ITIME_US(200000, BU27008_MEAS_MODE_200MS, 4),
-	GAIN_SCALE_ITIME_US(100000, BU27008_MEAS_MODE_100MS, 2),
-	GAIN_SCALE_ITIME_US(55000, BU27008_MEAS_MODE_55MS, 1),
-};
-
-static const struct iio_itime_sel_mul bu27010_itimes[] =3D {
-	GAIN_SCALE_ITIME_US(400000, BU27010_MEAS_MODE_400MS, 8),
-	GAIN_SCALE_ITIME_US(200000, BU27010_MEAS_MODE_200MS, 4),
-	GAIN_SCALE_ITIME_US(100000, BU27010_MEAS_MODE_100MS, 2),
-	GAIN_SCALE_ITIME_US(55000, BU27010_MEAS_MODE_55MS, 1),
-};
-
-/*
- * All the RGBC channels share the same gain.
- * IR gain can be fine-tuned from the gain set for the RGBC by 2 bit, but =
this
- * would yield quite complex gain setting. Especially since not all bit
- * compinations are supported. And in any case setting GAIN for RGBC will
- * always also change the IR-gain.
- *
- * On top of this, the selector '0' which corresponds to hw-gain 1X on RGB=
C,
- * corresponds to gain 2X on IR. Rest of the selctors correspond to same g=
ains
- * though. This, however, makes it not possible to use shared gain for all
- * RGBC and IR settings even though they are all changed at the one go.
- */
-#define BU27008_CHAN(color, data, separate_avail)				\
-{										\
-	.type =3D IIO_INTENSITY,							\
-	.modified =3D 1,								\
-	.channel2 =3D IIO_MOD_LIGHT_##color,					\
-	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |				\
-			      BIT(IIO_CHAN_INFO_SCALE),				\
-	.info_mask_separate_available =3D (separate_avail),			\
-	.info_mask_shared_by_all =3D BIT(IIO_CHAN_INFO_INT_TIME),			\
-	.info_mask_shared_by_all_available =3D BIT(IIO_CHAN_INFO_INT_TIME),	\
-	.address =3D BU27008_REG_##data##_LO,					\
-	.scan_index =3D BU27008_##color,						\
-	.scan_type =3D {								\
-		.sign =3D 'u',							\
-		.realbits =3D 16,							\
-		.storagebits =3D 16,						\
-		.endianness =3D IIO_LE,						\
-	},									\
-}
-
-/* For raw reads we always configure DATA3 for CLEAR */
-static const struct iio_chan_spec bu27008_channels[] =3D {
-	BU27008_CHAN(RED, DATA0, BIT(IIO_CHAN_INFO_SCALE)),
-	BU27008_CHAN(GREEN, DATA1, BIT(IIO_CHAN_INFO_SCALE)),
-	BU27008_CHAN(BLUE, DATA2, BIT(IIO_CHAN_INFO_SCALE)),
-	BU27008_CHAN(CLEAR, DATA2, BIT(IIO_CHAN_INFO_SCALE)),
-	/*
-	 * We don't allow setting scale for IR (because of shared gain bits).
-	 * Hence we don't advertise available ones either.
-	 */
-	BU27008_CHAN(IR, DATA3, 0),
-	{
-		.type =3D IIO_LIGHT,
-		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
-				      BIT(IIO_CHAN_INFO_SCALE),
-		.channel =3D BU27008_LUX,
-		.scan_index =3D BU27008_LUX,
-		.scan_type =3D {
-			.sign =3D 'u',
-			.realbits =3D 64,
-			.storagebits =3D 64,
-			.endianness =3D IIO_CPU,
-		},
-	},
-	IIO_CHAN_SOFT_TIMESTAMP(BU27008_NUM_CHANS),
-};
-
-struct bu27008_data;
-
-struct bu27_chip_data {
-	const char *name;
-	int (*chip_init)(struct bu27008_data *data);
-	int (*get_gain_sel)(struct bu27008_data *data, int *sel);
-	int (*write_gain_sel)(struct bu27008_data *data, int sel);
-	const struct regmap_config *regmap_cfg;
-	const struct iio_gain_sel_pair *gains;
-	const struct iio_gain_sel_pair *gains_ir;
-	const struct iio_itime_sel_mul *itimes;
-	int num_gains;
-	int num_gains_ir;
-	int num_itimes;
-	int scale1x;
-
-	int drdy_en_reg;
-	int drdy_en_mask;
-	int meas_en_reg;
-	int meas_en_mask;
-	int valid_reg;
-	int chan_sel_reg;
-	int chan_sel_mask;
-	int int_time_mask;
-	u8 part_id;
-};
-
-struct bu27008_data {
-	const struct bu27_chip_data *cd;
-	struct regmap *regmap;
-	struct iio_trigger *trig;
-	struct device *dev;
-	struct iio_gts gts;
-	struct iio_gts gts_ir;
-	int irq;
-
-	/*
-	 * Prevent changing gain/time config when scale is read/written.
-	 * Similarly, protect the integration_time read/change sequence.
-	 * Prevent changing gain/time when data is read.
-	 */
-	struct mutex mutex;
-};
-
-static const struct regmap_range bu27008_volatile_ranges[] =3D {
-	{
-		.range_min =3D BU27008_REG_SYSTEM_CONTROL,	/* SWRESET */
-		.range_max =3D BU27008_REG_SYSTEM_CONTROL,
-	}, {
-		.range_min =3D BU27008_REG_MODE_CONTROL3,		/* VALID */
-		.range_max =3D BU27008_REG_MODE_CONTROL3,
-	}, {
-		.range_min =3D BU27008_REG_DATA0_LO,		/* DATA */
-		.range_max =3D BU27008_REG_DATA3_HI,
-	},
-};
-
-static const struct regmap_range bu27010_volatile_ranges[] =3D {
-	{
-		.range_min =3D BU27010_REG_RESET,			/* RSTB */
-		.range_max =3D BU27008_REG_SYSTEM_CONTROL,	/* RESET */
-	}, {
-		.range_min =3D BU27010_REG_MODE_CONTROL5,		/* VALID bits */
-		.range_max =3D BU27010_REG_MODE_CONTROL5,
-	}, {
-		.range_min =3D BU27008_REG_DATA0_LO,
-		.range_max =3D BU27010_REG_FIFO_DATA_HI,
-	},
-};
-
-static const struct regmap_access_table bu27008_volatile_regs =3D {
-	.yes_ranges =3D &bu27008_volatile_ranges[0],
-	.n_yes_ranges =3D ARRAY_SIZE(bu27008_volatile_ranges),
-};
-
-static const struct regmap_access_table bu27010_volatile_regs =3D {
-	.yes_ranges =3D &bu27010_volatile_ranges[0],
-	.n_yes_ranges =3D ARRAY_SIZE(bu27010_volatile_ranges),
-};
-
-static const struct regmap_range bu27008_read_only_ranges[] =3D {
-	{
-		.range_min =3D BU27008_REG_DATA0_LO,
-		.range_max =3D BU27008_REG_DATA3_HI,
-	}, {
-		.range_min =3D BU27008_REG_MANUFACTURER_ID,
-		.range_max =3D BU27008_REG_MANUFACTURER_ID,
-	},
-};
-
-static const struct regmap_range bu27010_read_only_ranges[] =3D {
-	{
-		.range_min =3D BU27008_REG_DATA0_LO,
-		.range_max =3D BU27010_REG_FIFO_DATA_HI,
-	}, {
-		.range_min =3D BU27010_REG_MANUFACTURER_ID,
-		.range_max =3D BU27010_REG_MANUFACTURER_ID,
-	}
-};
-
-static const struct regmap_access_table bu27008_ro_regs =3D {
-	.no_ranges =3D &bu27008_read_only_ranges[0],
-	.n_no_ranges =3D ARRAY_SIZE(bu27008_read_only_ranges),
-};
-
-static const struct regmap_access_table bu27010_ro_regs =3D {
-	.no_ranges =3D &bu27010_read_only_ranges[0],
-	.n_no_ranges =3D ARRAY_SIZE(bu27010_read_only_ranges),
-};
-
-static const struct regmap_config bu27008_regmap =3D {
-	.reg_bits =3D 8,
-	.val_bits =3D 8,
-	.max_register =3D BU27008_REG_MAX,
-	.cache_type =3D REGCACHE_RBTREE,
-	.volatile_table =3D &bu27008_volatile_regs,
-	.wr_table =3D &bu27008_ro_regs,
-	/*
-	 * All register writes are serialized by the mutex which protects the
-	 * scale setting/getting. This is needed because scale is combined by
-	 * gain and integration time settings and we need to ensure those are
-	 * not read / written when scale is being computed.
-	 *
-	 * As a result of this serializing, we don't need regmap locking. Note,
-	 * this is not true if we add any configurations which are not
-	 * serialized by the mutex and which may need for example a protected
-	 * read-modify-write cycle (eg. regmap_update_bits()). Please, revise
-	 * this when adding features to the driver.
-	 */
-	.disable_locking =3D true,
-};
-
-static const struct regmap_config bu27010_regmap =3D {
-	.reg_bits	=3D 8,
-	.val_bits	=3D 8,
-
-	.max_register	=3D BU27010_REG_MAX,
-	.cache_type	=3D REGCACHE_RBTREE,
-	.volatile_table =3D &bu27010_volatile_regs,
-	.wr_table	=3D &bu27010_ro_regs,
-	.disable_locking =3D true,
-};
-
-static int bu27008_write_gain_sel(struct bu27008_data *data, int sel)
-{
-	int regval;
-
-	regval =3D FIELD_PREP(BU27008_MASK_RGBC_GAIN, sel);
-
-	/*
-	 * We do always set also the LOW bits of IR-gain because othervice we
-	 * would risk resulting an invalid GAIN register value.
-	 *
-	 * We could allow setting separate gains for RGBC and IR when the
-	 * values were such that HW could support both gain settings.
-	 * Eg, when the shared bits were same for both gain values.
-	 *
-	 * This, however, has a negligible benefit compared to the increased
-	 * software complexity when we would need to go through the gains
-	 * for both channels separately when the integration time changes.
-	 * This would end up with nasty logic for computing gain values for
-	 * both channels - and rejecting them if shared bits changed.
-	 *
-	 * We should then build the logic by guessing what a user prefers.
-	 * RGBC or IR gains correctly set while other jumps to odd value?
-	 * Maybe look-up a value where both gains are somehow optimized
-	 * <what this somehow is, is ATM unknown to us>. Or maybe user would
-	 * expect us to reject changes when optimal gains can't be set to both
-	 * channels w/given integration time. At best that would result
-	 * solution that works well for a very specific subset of
-	 * configurations but causes unexpected corner-cases.
-	 *
-	 * So, we keep it simple. Always set same selector to IR and RGBC.
-	 * We disallow setting IR (as I expect that most of the users are
-	 * interested in RGBC). This way we can show the user that the scales
-	 * for RGBC and IR channels are different (1X Vs 2X with sel 0) while
-	 * still keeping the operation deterministic.
-	 */
-	regval |=3D FIELD_PREP(BU27008_MASK_IR_GAIN_LO, sel);
-
-	return regmap_update_bits(data->regmap, BU27008_REG_MODE_CONTROL2,
-				  BU27008_MASK_RGBC_GAIN, regval);
-}
-
-static int bu27010_write_gain_sel(struct bu27008_data *data, int sel)
-{
-	unsigned int regval;
-	int ret, chan_selector;
-
-	/*
-	 * Gain 'selector' is composed of two registers. Selector is 6bit value,
-	 * 4 high bits being the RGBC gain fieild in MODE_CONTROL1 register and
-	 * two low bits being the channel specific gain in MODE_CONTROL2.
-	 *
-	 * Let's take the 4 high bits of whole 6 bit selector, and prepare
-	 * the MODE_CONTROL1 value (RGBC gain part).
-	 */
-	regval =3D FIELD_PREP(BU27010_MASK_RGBC_GAIN, (sel >> 2));
-
-	ret =3D regmap_update_bits(data->regmap, BU27008_REG_MODE_CONTROL1,
-				  BU27010_MASK_RGBC_GAIN, regval);
-	if (ret)
-		return ret;
-
-	/*
-	 * Two low two bits of the selector must be written for all 4
-	 * channels in the MODE_CONTROL2 register. Copy these two bits for
-	 * all channels.
-	 */
-	chan_selector =3D sel & GENMASK(1, 0);
-
-	regval =3D FIELD_PREP(BU27010_MASK_DATA0_GAIN, chan_selector);
-	regval |=3D FIELD_PREP(BU27010_MASK_DATA1_GAIN, chan_selector);
-	regval |=3D FIELD_PREP(BU27010_MASK_DATA2_GAIN, chan_selector);
-	regval |=3D FIELD_PREP(BU27010_MASK_DATA3_GAIN, chan_selector);
-
-	return regmap_write(data->regmap, BU27008_REG_MODE_CONTROL2, regval);
-}
-
-static int bu27008_get_gain_sel(struct bu27008_data *data, int *sel)
-{
-	int ret;
-
-	/*
-	 * If we always "lock" the gain selectors for all channels to prevent
-	 * unsupported configs, then it does not matter which channel is used
-	 * we can just return selector from any of them.
-	 *
-	 * This, however is not true if we decide to support only 4X and 16X
-	 * and then individual gains for channels. Currently this is not the
-	 * case.
-	 *
-	 * If we some day decide to support individual gains, then we need to
-	 * have channel information here.
-	 */
-
-	ret =3D regmap_read(data->regmap, BU27008_REG_MODE_CONTROL2, sel);
-	if (ret)
-		return ret;
-
-	*sel =3D FIELD_GET(BU27008_MASK_RGBC_GAIN, *sel);
-
-	return 0;
-}
-
-static int bu27010_get_gain_sel(struct bu27008_data *data, int *sel)
-{
-	int ret, tmp;
-
-	/*
-	 * We always "lock" the gain selectors for all channels to prevent
-	 * unsupported configs. It does not matter which channel is used
-	 * we can just return selector from any of them.
-	 *
-	 * Read the channel0 gain.
-	 */
-	ret =3D regmap_read(data->regmap, BU27008_REG_MODE_CONTROL2, sel);
-	if (ret)
-		return ret;
-
-	*sel =3D FIELD_GET(BU27010_MASK_DATA0_GAIN, *sel);
-
-	/* Read the shared gain */
-	ret =3D regmap_read(data->regmap, BU27008_REG_MODE_CONTROL1, &tmp);
-	if (ret)
-		return ret;
-
-	/*
-	 * The gain selector is made as a combination of common RGBC gain and
-	 * the channel specific gain. The channel specific gain forms the low
-	 * bits of selector and RGBC gain is appended right after it.
-	 *
-	 * Compose the selector from channel0 gain and shared RGBC gain.
-	 */
-	*sel |=3D FIELD_GET(BU27010_MASK_RGBC_GAIN, tmp) << fls(BU27010_MASK_DATA=
0_GAIN);
-
-	return ret;
-}
-
-static int bu27008_chip_init(struct bu27008_data *data)
-{
-	int ret;
-
-	ret =3D regmap_write_bits(data->regmap, BU27008_REG_SYSTEM_CONTROL,
-				BU27008_MASK_SW_RESET, BU27008_MASK_SW_RESET);
-	if (ret)
-		return dev_err_probe(data->dev, ret, "Sensor reset failed\n");
-
-	/*
-	 * The data-sheet does not tell how long performing the IC reset takes.
-	 * However, the data-sheet says the minimum time it takes the IC to be
-	 * able to take inputs after power is applied, is 100 uS. I'd assume
-	 * > 1 mS is enough.
-	 */
-	msleep(1);
-
-	ret =3D regmap_reinit_cache(data->regmap, data->cd->regmap_cfg);
-	if (ret)
-		dev_err(data->dev, "Failed to reinit reg cache\n");
-
-	return ret;
-}
-
-static int bu27010_chip_init(struct bu27008_data *data)
-{
-	int ret;
-
-	ret =3D regmap_write_bits(data->regmap, BU27008_REG_SYSTEM_CONTROL,
-				BU27010_MASK_SW_RESET, BU27010_MASK_SW_RESET);
-	if (ret)
-		return dev_err_probe(data->dev, ret, "Sensor reset failed\n");
-
-	msleep(1);
-
-	/* Power ON*/
-	ret =3D regmap_write_bits(data->regmap, BU27010_REG_POWER,
-				BU27010_MASK_POWER, BU27010_MASK_POWER);
-	if (ret)
-		return dev_err_probe(data->dev, ret, "Sensor power-on failed\n");
-
-	msleep(1);
-
-	/* Release blocks from reset */
-	ret =3D regmap_write_bits(data->regmap, BU27010_REG_RESET,
-				BU27010_MASK_RESET, BU27010_RESET_RELEASE);
-	if (ret)
-		return dev_err_probe(data->dev, ret, "Sensor powering failed\n");
-
-	msleep(1);
-
-	/*
-	 * The IRQ enabling on BU27010 is done in a peculiar way. The IRQ
-	 * enabling is not a bit mask where individual IRQs could be enabled but
-	 * a field which values are:
-	 * 00 =3D> IRQs disabled
-	 * 01 =3D> Data-ready (RGBC/IR)
-	 * 10 =3D> Data-ready (flicker)
-	 * 11 =3D> Flicker FIFO
-	 *
-	 * So, only one IRQ can be enabled at a time and enabling for example
-	 * flicker FIFO would automagically disable data-ready IRQ.
-	 *
-	 * Currently the driver does not support the flicker. Hence, we can
-	 * just treat the RGBC data-ready as single bit which can be enabled /
-	 * disabled. This works for as long as the second bit in the field
-	 * stays zero. Here we ensure it gets zeroed.
-	 */
-	return regmap_clear_bits(data->regmap, BU27010_REG_MODE_CONTROL4,
-				 BU27010_IRQ_DIS_ALL);
-}
-
-static const struct bu27_chip_data bu27010_chip =3D {
-	.name =3D "bu27010",
-	.chip_init =3D bu27010_chip_init,
-	.get_gain_sel =3D bu27010_get_gain_sel,
-	.write_gain_sel =3D bu27010_write_gain_sel,
-	.regmap_cfg =3D &bu27010_regmap,
-	.gains =3D &bu27010_gains[0],
-	.gains_ir =3D &bu27010_gains_ir[0],
-	.itimes =3D &bu27010_itimes[0],
-	.num_gains =3D ARRAY_SIZE(bu27010_gains),
-	.num_gains_ir =3D ARRAY_SIZE(bu27010_gains_ir),
-	.num_itimes =3D ARRAY_SIZE(bu27010_itimes),
-	.scale1x =3D BU27010_SCALE_1X,
-	.drdy_en_reg =3D BU27010_REG_MODE_CONTROL4,
-	.drdy_en_mask =3D BU27010_DRDY_EN,
-	.meas_en_reg =3D BU27010_REG_MODE_CONTROL5,
-	.meas_en_mask =3D BU27010_MASK_MEAS_EN,
-	.valid_reg =3D BU27010_REG_MODE_CONTROL5,
-	.chan_sel_reg =3D BU27008_REG_MODE_CONTROL1,
-	.chan_sel_mask =3D BU27010_MASK_CHAN_SEL,
-	.int_time_mask =3D BU27010_MASK_MEAS_MODE,
-	.part_id =3D BU27010_ID,
-};
-
-static const struct bu27_chip_data bu27008_chip =3D {
-	.name =3D "bu27008",
-	.chip_init =3D bu27008_chip_init,
-	.get_gain_sel =3D bu27008_get_gain_sel,
-	.write_gain_sel =3D bu27008_write_gain_sel,
-	.regmap_cfg =3D &bu27008_regmap,
-	.gains =3D &bu27008_gains[0],
-	.gains_ir =3D &bu27008_gains_ir[0],
-	.itimes =3D &bu27008_itimes[0],
-	.num_gains =3D ARRAY_SIZE(bu27008_gains),
-	.num_gains_ir =3D ARRAY_SIZE(bu27008_gains_ir),
-	.num_itimes =3D ARRAY_SIZE(bu27008_itimes),
-	.scale1x =3D BU27008_SCALE_1X,
-	.drdy_en_reg =3D BU27008_REG_MODE_CONTROL3,
-	.drdy_en_mask =3D BU27008_MASK_INT_EN,
-	.valid_reg =3D BU27008_REG_MODE_CONTROL3,
-	.meas_en_reg =3D BU27008_REG_MODE_CONTROL3,
-	.meas_en_mask =3D BU27008_MASK_MEAS_EN,
-	.chan_sel_reg =3D BU27008_REG_MODE_CONTROL3,
-	.chan_sel_mask =3D BU27008_MASK_CHAN_SEL,
-	.int_time_mask =3D BU27008_MASK_MEAS_MODE,
-	.part_id =3D BU27008_ID,
-};
-
-#define BU27008_MAX_VALID_RESULT_WAIT_US	50000
-#define BU27008_VALID_RESULT_WAIT_QUANTA_US	1000
-
-static int bu27008_chan_read_data(struct bu27008_data *data, int reg, int =
*val)
-{
-	int ret, valid;
-	__le16 tmp;
-
-	ret =3D regmap_read_poll_timeout(data->regmap, data->cd->valid_reg,
-				       valid, (valid & BU27008_MASK_VALID),
-				       BU27008_VALID_RESULT_WAIT_QUANTA_US,
-				       BU27008_MAX_VALID_RESULT_WAIT_US);
-	if (ret)
-		return ret;
-
-	ret =3D regmap_bulk_read(data->regmap, reg, &tmp, sizeof(tmp));
-	if (ret)
-		dev_err(data->dev, "Reading channel data failed\n");
-
-	*val =3D le16_to_cpu(tmp);
-
-	return ret;
-}
-
-static int bu27008_get_gain(struct bu27008_data *data, struct iio_gts *gts=
, int *gain)
-{
-	int ret, sel;
-
-	ret =3D data->cd->get_gain_sel(data, &sel);
-	if (ret)
-		return ret;
-
-	ret =3D iio_gts_find_gain_by_sel(gts, sel);
-	if (ret < 0) {
-		dev_err(data->dev, "unknown gain value 0x%x\n", sel);
-		return ret;
-	}
-
-	*gain =3D ret;
-
-	return 0;
-}
-
-static int bu27008_set_gain(struct bu27008_data *data, int gain)
-{
-	int ret;
-
-	ret =3D iio_gts_find_sel_by_gain(&data->gts, gain);
-	if (ret < 0)
-		return ret;
-
-	return data->cd->write_gain_sel(data, ret);
-}
-
-static int bu27008_get_int_time_sel(struct bu27008_data *data, int *sel)
-{
-	int ret, val;
-
-	ret =3D regmap_read(data->regmap, BU27008_REG_MODE_CONTROL1, &val);
-	if (ret)
-		return ret;
-
-	val &=3D data->cd->int_time_mask;
-	val >>=3D ffs(data->cd->int_time_mask) - 1;
-
-	*sel =3D val;
-
-	return 0;
-}
-
-static int bu27008_set_int_time_sel(struct bu27008_data *data, int sel)
-{
-	sel <<=3D ffs(data->cd->int_time_mask) - 1;
-
-	return regmap_update_bits(data->regmap, BU27008_REG_MODE_CONTROL1,
-				  data->cd->int_time_mask, sel);
-}
-
-static int bu27008_get_int_time_us(struct bu27008_data *data)
-{
-	int ret, sel;
-
-	ret =3D bu27008_get_int_time_sel(data, &sel);
-	if (ret)
-		return ret;
-
-	return iio_gts_find_int_time_by_sel(&data->gts, sel);
-}
-
-static int _bu27008_get_scale(struct bu27008_data *data, bool ir, int *val,
-			      int *val2)
-{
-	struct iio_gts *gts;
-	int gain, ret;
-
-	if (ir)
-		gts =3D &data->gts_ir;
-	else
-		gts =3D &data->gts;
-
-	ret =3D bu27008_get_gain(data, gts, &gain);
-	if (ret)
-		return ret;
-
-	ret =3D bu27008_get_int_time_us(data);
-	if (ret < 0)
-		return ret;
-
-	return iio_gts_get_scale(gts, gain, ret, val, val2);
-}
-
-static int bu27008_get_scale(struct bu27008_data *data, bool ir, int *val,
-			     int *val2)
-{
-	int ret;
-
-	mutex_lock(&data->mutex);
-	ret =3D _bu27008_get_scale(data, ir, val, val2);
-	mutex_unlock(&data->mutex);
-
-	return ret;
-}
-
-static int bu27008_set_int_time(struct bu27008_data *data, int time)
-{
-	int ret;
-
-	ret =3D iio_gts_find_sel_by_int_time(&data->gts, time);
-	if (ret < 0)
-		return ret;
-
-	return bu27008_set_int_time_sel(data, ret);
-}
-
-/* Try to change the time so that the scale is maintained */
-static int bu27008_try_set_int_time(struct bu27008_data *data, int int_tim=
e_new)
-{
-	int ret, old_time_sel, new_time_sel,  old_gain, new_gain;
-
-	mutex_lock(&data->mutex);
-
-	ret =3D bu27008_get_int_time_sel(data, &old_time_sel);
-	if (ret < 0)
-		goto unlock_out;
-
-	if (!iio_gts_valid_time(&data->gts, int_time_new)) {
-		dev_dbg(data->dev, "Unsupported integration time %u\n",
-			int_time_new);
-
-		ret =3D -EINVAL;
-		goto unlock_out;
-	}
-
-	/* If we already use requested time, then we're done */
-	new_time_sel =3D iio_gts_find_sel_by_int_time(&data->gts, int_time_new);
-	if (new_time_sel =3D=3D old_time_sel)
-		goto unlock_out;
-
-	ret =3D bu27008_get_gain(data, &data->gts, &old_gain);
-	if (ret)
-		goto unlock_out;
-
-	ret =3D iio_gts_find_new_gain_sel_by_old_gain_time(&data->gts, old_gain,
-				old_time_sel, new_time_sel, &new_gain);
-	if (ret) {
-		int scale1, scale2;
-		bool ok;
-
-		_bu27008_get_scale(data, false, &scale1, &scale2);
-		dev_dbg(data->dev,
-			"Can't support time %u with current scale %u %u\n",
-			int_time_new, scale1, scale2);
-
-		if (new_gain < 0)
-			goto unlock_out;
-
-		/*
-		 * If caller requests for integration time change and we
-		 * can't support the scale - then the caller should be
-		 * prepared to 'pick up the pieces and deal with the
-		 * fact that the scale changed'.
-		 */
-		ret =3D iio_find_closest_gain_low(&data->gts, new_gain, &ok);
-		if (!ok)
-			dev_dbg(data->dev, "optimal gain out of range\n");
-
-		if (ret < 0) {
-			dev_dbg(data->dev,
-				 "Total gain increase. Risk of saturation");
-			ret =3D iio_gts_get_min_gain(&data->gts);
-			if (ret < 0)
-				goto unlock_out;
-		}
-		new_gain =3D ret;
-		dev_dbg(data->dev, "scale changed, new gain %u\n", new_gain);
-	}
-
-	ret =3D bu27008_set_gain(data, new_gain);
-	if (ret)
-		goto unlock_out;
-
-	ret =3D bu27008_set_int_time(data, int_time_new);
-
-unlock_out:
-	mutex_unlock(&data->mutex);
-
-	return ret;
-}
-
-static int bu27008_meas_set(struct bu27008_data *data, bool enable)
-{
-	if (enable)
-		return regmap_set_bits(data->regmap, data->cd->meas_en_reg,
-				       data->cd->meas_en_mask);
-	return regmap_clear_bits(data->regmap, data->cd->meas_en_reg,
-				 data->cd->meas_en_mask);
-}
-
-static int bu27008_chan_cfg(struct bu27008_data *data,
-			    struct iio_chan_spec const *chan)
-{
-	int chan_sel;
-
-	if (chan->scan_index =3D=3D BU27008_BLUE)
-		chan_sel =3D BU27008_BLUE2_CLEAR3;
-	else
-		chan_sel =3D BU27008_CLEAR2_IR3;
-
-	/*
-	 * prepare bitfield for channel sel. The FIELD_PREP works only when
-	 * mask is constant. In our case the mask is assigned based on the
-	 * chip type. Hence the open-coded FIELD_PREP here. We don't bother
-	 * zeroing the irrelevant bits though - update_bits takes care of that.
-	 */
-	chan_sel <<=3D ffs(data->cd->chan_sel_mask) - 1;
-
-	return regmap_update_bits(data->regmap, data->cd->chan_sel_reg,
-				  BU27008_MASK_CHAN_SEL, chan_sel);
-}
-
-static int bu27008_read_one(struct bu27008_data *data, struct iio_dev *ide=
v,
-			    struct iio_chan_spec const *chan, int *val, int *val2)
-{
-	int ret, int_time;
-
-	ret =3D bu27008_chan_cfg(data, chan);
-	if (ret)
-		return ret;
-
-	ret =3D bu27008_meas_set(data, true);
-	if (ret)
-		return ret;
-
-	ret =3D bu27008_get_int_time_us(data);
-	if (ret < 0)
-		int_time =3D BU27008_MEAS_TIME_MAX_MS;
-	else
-		int_time =3D ret / USEC_PER_MSEC;
-
-	msleep(int_time);
-
-	ret =3D bu27008_chan_read_data(data, chan->address, val);
-	if (!ret)
-		ret =3D IIO_VAL_INT;
-
-	if (bu27008_meas_set(data, false))
-		dev_warn(data->dev, "measurement disabling failed\n");
-
-	return ret;
-}
-
-#define BU27008_LUX_DATA_RED	0
-#define BU27008_LUX_DATA_GREEN	1
-#define BU27008_LUX_DATA_BLUE	2
-#define BU27008_LUX_DATA_IR	3
-#define LUX_DATA_SIZE (BU27008_NUM_HW_CHANS * sizeof(__le16))
-
-static int bu27008_read_lux_chans(struct bu27008_data *data, unsigned int =
time,
-				  __le16 *chan_data)
-{
-	int ret, chan_sel, tmpret, valid;
-
-	chan_sel =3D BU27008_BLUE2_IR3 << (ffs(data->cd->chan_sel_mask) - 1);
-
-	ret =3D regmap_update_bits(data->regmap, data->cd->chan_sel_reg,
-				 data->cd->chan_sel_mask, chan_sel);
-	if (ret)
-		return ret;
-
-	ret =3D bu27008_meas_set(data, true);
-	if (ret)
-		return ret;
-
-	msleep(time / USEC_PER_MSEC);
-
-	ret =3D regmap_read_poll_timeout(data->regmap, data->cd->valid_reg,
-				       valid, (valid & BU27008_MASK_VALID),
-				       BU27008_VALID_RESULT_WAIT_QUANTA_US,
-				       BU27008_MAX_VALID_RESULT_WAIT_US);
-	if (ret)
-		goto out;
-
-	ret =3D regmap_bulk_read(data->regmap, BU27008_REG_DATA0_LO, chan_data,
-			       LUX_DATA_SIZE);
-	if (ret)
-		goto out;
-out:
-	tmpret =3D bu27008_meas_set(data, false);
-	if (tmpret)
-		dev_warn(data->dev, "Stopping measurement failed\n");
-
-	return ret;
-}
-
-/*
- * Following equation for computing lux out of register values was given by
- * ROHM HW colleagues;
- *
- * Red =3D RedData*1024 / Gain * 20 / meas_mode
- * Green =3D GreenData* 1024 / Gain * 20 / meas_mode
- * Blue =3D BlueData* 1024 / Gain * 20 / meas_mode
- * IR =3D IrData* 1024 / Gain * 20 / meas_mode
- *
- * where meas_mode is the integration time in mS / 10
- *
- * IRratio =3D (IR > 0.18 * Green) ? 0 : 1
- *
- * Lx =3D max(c1*Red + c2*Green + c3*Blue,0)
- *
- * for
- * IRratio 0: c1 =3D -0.00002237, c2 =3D 0.0003219, c3 =3D -0.000120371
- * IRratio 1: c1 =3D -0.00001074, c2 =3D 0.000305415, c3 =3D -0.000129367
- */
-
-/*
- * The max chan data is 0xffff. When we multiply it by 1024 * 20, we'll get
- * 0x4FFFB000 which still fits in 32-bit integer. This won't overflow.
- */
-#define NORM_CHAN_DATA_FOR_LX_CALC(chan, gain, time) (le16_to_cpu(chan) * \
-				   1024 * 20 / (gain) / (time))
-static u64 bu27008_calc_nlux(struct bu27008_data *data, __le16 *lux_data,
-		unsigned int gain, unsigned int gain_ir, unsigned int time)
-{
-	unsigned int red, green, blue, ir;
-	s64 c1, c2, c3, nlux;
-
-	time /=3D 10000;
-	ir =3D NORM_CHAN_DATA_FOR_LX_CALC(lux_data[BU27008_LUX_DATA_IR], gain_ir,=
 time);
-	red =3D NORM_CHAN_DATA_FOR_LX_CALC(lux_data[BU27008_LUX_DATA_RED], gain, =
time);
-	green =3D NORM_CHAN_DATA_FOR_LX_CALC(lux_data[BU27008_LUX_DATA_GREEN], ga=
in, time);
-	blue =3D NORM_CHAN_DATA_FOR_LX_CALC(lux_data[BU27008_LUX_DATA_BLUE], gain=
, time);
-
-	if ((u64)ir * 100LLU > (u64)green * 18LLU) {
-		c1 =3D -22370;
-		c2 =3D 321900;
-		c3 =3D -120371;
-	} else {
-		c1 =3D -10740;
-		c2 =3D 305415;
-		c3 =3D -129367;
-	}
-	nlux =3D c1 * red + c2 * green + c3 * blue;
-
-	return max_t(s64, 0, nlux);
-}
-
-static int bu27008_get_time_n_gains(struct bu27008_data *data,
-		unsigned int *gain, unsigned int *gain_ir, unsigned int *time)
-{
-	int ret;
-
-	ret =3D bu27008_get_gain(data, &data->gts, gain);
-	if (ret < 0)
-		return ret;
-
-	ret =3D bu27008_get_gain(data, &data->gts_ir, gain_ir);
-	if (ret < 0)
-		return ret;
-
-	ret =3D bu27008_get_int_time_us(data);
-	if (ret < 0)
-		return ret;
-
-	/* Max integration time is 400000. Fits in signed int. */
-	*time =3D ret;
-
-	return 0;
-}
-
-struct bu27008_buf {
-	__le16 chan[BU27008_NUM_HW_CHANS];
-	u64 lux __aligned(8);
-	s64 ts __aligned(8);
-};
-
-static int bu27008_buffer_fill_lux(struct bu27008_data *data,
-				   struct bu27008_buf *raw)
-{
-	unsigned int gain, gain_ir, time;
-	int ret;
-
-	ret =3D bu27008_get_time_n_gains(data, &gain, &gain_ir, &time);
-	if (ret)
-		return ret;
-
-	raw->lux =3D bu27008_calc_nlux(data, raw->chan, gain, gain_ir, time);
-
-	return 0;
-}
-
-static int bu27008_read_lux(struct bu27008_data *data, struct iio_dev *ide=
v,
-			    struct iio_chan_spec const *chan,
-			    int *val, int *val2)
-{
-	__le16 lux_data[BU27008_NUM_HW_CHANS];
-	unsigned int gain, gain_ir, time;
-	u64 nlux;
-	int ret;
-
-	ret =3D bu27008_get_time_n_gains(data, &gain, &gain_ir, &time);
-	if (ret)
-		return ret;
-
-	ret =3D bu27008_read_lux_chans(data, time, lux_data);
-	if (ret)
-		return ret;
-
-	nlux =3D bu27008_calc_nlux(data, lux_data, gain, gain_ir, time);
-	*val =3D (int)nlux;
-	*val2 =3D nlux >> 32LLU;
-
-	return IIO_VAL_INT_64;
-}
-
-static int bu27008_read_raw(struct iio_dev *idev,
-			   struct iio_chan_spec const *chan,
-			   int *val, int *val2, long mask)
-{
-	struct bu27008_data *data =3D iio_priv(idev);
-	int busy, ret;
-
-	switch (mask) {
-	case IIO_CHAN_INFO_RAW:
-		busy =3D iio_device_claim_direct_mode(idev);
-		if (busy)
-			return -EBUSY;
-
-		mutex_lock(&data->mutex);
-		if (chan->type =3D=3D IIO_LIGHT)
-			ret =3D bu27008_read_lux(data, idev, chan, val, val2);
-		else
-			ret =3D bu27008_read_one(data, idev, chan, val, val2);
-		mutex_unlock(&data->mutex);
-
-		iio_device_release_direct_mode(idev);
-
-		return ret;
-
-	case IIO_CHAN_INFO_SCALE:
-		if (chan->type =3D=3D IIO_LIGHT) {
-			*val =3D 0;
-			*val2 =3D 1;
-			return IIO_VAL_INT_PLUS_NANO;
-		}
-		ret =3D bu27008_get_scale(data, chan->scan_index =3D=3D BU27008_IR,
-					val, val2);
-		if (ret)
-			return ret;
-
-		return IIO_VAL_INT_PLUS_NANO;
-
-	case IIO_CHAN_INFO_INT_TIME:
-		ret =3D bu27008_get_int_time_us(data);
-		if (ret < 0)
-			return ret;
-
-		*val =3D 0;
-		*val2 =3D ret;
-
-		return IIO_VAL_INT_PLUS_MICRO;
-
-	default:
-		return -EINVAL;
-	}
-}
-
-/* Called if the new scale could not be supported with existing int-time */
-static int bu27008_try_find_new_time_gain(struct bu27008_data *data, int v=
al,
-					  int val2, int *gain_sel)
-{
-	int i, ret, new_time_sel;
-
-	for (i =3D 0; i < data->gts.num_itime; i++) {
-		new_time_sel =3D data->gts.itime_table[i].sel;
-		ret =3D iio_gts_find_gain_sel_for_scale_using_time(&data->gts,
-					new_time_sel, val, val2, gain_sel);
-		if (!ret)
-			break;
-	}
-	if (i =3D=3D data->gts.num_itime) {
-		dev_err(data->dev, "Can't support scale %u %u\n", val, val2);
-
-		return -EINVAL;
-	}
-
-	return bu27008_set_int_time_sel(data, new_time_sel);
-}
-
-static int bu27008_set_scale(struct bu27008_data *data,
-			     struct iio_chan_spec const *chan,
-			     int val, int val2)
-{
-	int ret, gain_sel, time_sel;
-
-	if (chan->scan_index =3D=3D BU27008_IR)
-		return -EINVAL;
-
-	mutex_lock(&data->mutex);
-
-	ret =3D bu27008_get_int_time_sel(data, &time_sel);
-	if (ret < 0)
-		goto unlock_out;
-
-	ret =3D iio_gts_find_gain_sel_for_scale_using_time(&data->gts, time_sel,
-						val, val2, &gain_sel);
-	if (ret) {
-		ret =3D bu27008_try_find_new_time_gain(data, val, val2, &gain_sel);
-		if (ret)
-			goto unlock_out;
-
-	}
-	ret =3D data->cd->write_gain_sel(data, gain_sel);
-
-unlock_out:
-	mutex_unlock(&data->mutex);
-
-	return ret;
-}
-
-static int bu27008_write_raw_get_fmt(struct iio_dev *indio_dev,
-				     struct iio_chan_spec const *chan,
-				     long mask)
-{
-
-	switch (mask) {
-	case IIO_CHAN_INFO_SCALE:
-		return IIO_VAL_INT_PLUS_NANO;
-	case IIO_CHAN_INFO_INT_TIME:
-		return IIO_VAL_INT_PLUS_MICRO;
-	default:
-		return -EINVAL;
-	}
-}
-
-static int bu27008_write_raw(struct iio_dev *idev,
-			     struct iio_chan_spec const *chan,
-			     int val, int val2, long mask)
-{
-	struct bu27008_data *data =3D iio_priv(idev);
-	int ret;
-
-	/*
-	 * Do not allow changing scale when measurement is ongoing as doing so
-	 * could make values in the buffer inconsistent.
-	 */
-	ret =3D iio_device_claim_direct_mode(idev);
-	if (ret)
-		return ret;
-
-	switch (mask) {
-	case IIO_CHAN_INFO_SCALE:
-		ret =3D bu27008_set_scale(data, chan, val, val2);
-		break;
-	case IIO_CHAN_INFO_INT_TIME:
-		if (val) {
-			ret =3D -EINVAL;
-			break;
-		}
-		ret =3D bu27008_try_set_int_time(data, val2);
-		break;
-	default:
-		ret =3D -EINVAL;
-		break;
-	}
-	iio_device_release_direct_mode(idev);
-
-	return ret;
-}
-
-static int bu27008_read_avail(struct iio_dev *idev,
-			      struct iio_chan_spec const *chan, const int **vals,
-			      int *type, int *length, long mask)
-{
-	struct bu27008_data *data =3D iio_priv(idev);
-
-	switch (mask) {
-	case IIO_CHAN_INFO_INT_TIME:
-		return iio_gts_avail_times(&data->gts, vals, type, length);
-	case IIO_CHAN_INFO_SCALE:
-		if (chan->channel2 =3D=3D IIO_MOD_LIGHT_IR)
-			return iio_gts_all_avail_scales(&data->gts_ir, vals,
-							type, length);
-		return iio_gts_all_avail_scales(&data->gts, vals, type, length);
-	default:
-		return -EINVAL;
-	}
-}
-
-static int bu27008_update_scan_mode(struct iio_dev *idev,
-				    const unsigned long *scan_mask)
-{
-	struct bu27008_data *data =3D iio_priv(idev);
-	int chan_sel;
-
-	/* Configure channel selection */
-	if (test_bit(BU27008_BLUE, idev->active_scan_mask)) {
-		if (test_bit(BU27008_CLEAR, idev->active_scan_mask))
-			chan_sel =3D BU27008_BLUE2_CLEAR3;
-		else
-			chan_sel =3D BU27008_BLUE2_IR3;
-	} else {
-		chan_sel =3D BU27008_CLEAR2_IR3;
-	}
-
-	chan_sel <<=3D ffs(data->cd->chan_sel_mask) - 1;
-
-	return regmap_update_bits(data->regmap, data->cd->chan_sel_reg,
-				  data->cd->chan_sel_mask, chan_sel);
-}
-
-static const struct iio_info bu27008_info =3D {
-	.read_raw =3D &bu27008_read_raw,
-	.write_raw =3D &bu27008_write_raw,
-	.write_raw_get_fmt =3D &bu27008_write_raw_get_fmt,
-	.read_avail =3D &bu27008_read_avail,
-	.update_scan_mode =3D bu27008_update_scan_mode,
-	.validate_trigger =3D iio_validate_own_trigger,
-};
-
-static int bu27008_trigger_set_state(struct iio_trigger *trig, bool state)
-{
-	struct bu27008_data *data =3D iio_trigger_get_drvdata(trig);
-	int ret;
-
-
-	if (state)
-		ret =3D regmap_set_bits(data->regmap, data->cd->drdy_en_reg,
-				      data->cd->drdy_en_mask);
-	else
-		ret =3D regmap_clear_bits(data->regmap, data->cd->drdy_en_reg,
-					data->cd->drdy_en_mask);
-	if (ret)
-		dev_err(data->dev, "Failed to set trigger state\n");
-
-	return ret;
-}
-
-static void bu27008_trigger_reenable(struct iio_trigger *trig)
-{
-	struct bu27008_data *data =3D iio_trigger_get_drvdata(trig);
-
-	enable_irq(data->irq);
-}
-
-static const struct iio_trigger_ops bu27008_trigger_ops =3D {
-	.set_trigger_state =3D bu27008_trigger_set_state,
-	.reenable =3D bu27008_trigger_reenable,
-};
-
-static irqreturn_t bu27008_trigger_handler(int irq, void *p)
-{
-	struct iio_poll_func *pf =3D p;
-	struct iio_dev *idev =3D pf->indio_dev;
-	struct bu27008_data *data =3D iio_priv(idev);
-	struct bu27008_buf raw;
-	int ret, dummy;
-
-	memset(&raw, 0, sizeof(raw));
-
-	/*
-	 * After some measurements, it seems reading the
-	 * BU27008_REG_MODE_CONTROL3 debounces the IRQ line
-	 */
-	ret =3D regmap_read(data->regmap, data->cd->valid_reg, &dummy);
-	if (ret < 0)
-		goto err_read;
-
-	ret =3D regmap_bulk_read(data->regmap, BU27008_REG_DATA0_LO, &raw.chan,
-			       sizeof(raw.chan));
-	if (ret < 0)
-		goto err_read;
-
-	if (test_bit(BU27008_LUX, idev->active_scan_mask)) {
-		ret =3D bu27008_buffer_fill_lux(data, &raw);
-		if (ret)
-			goto err_read;
-	}
-
-	iio_push_to_buffers_with_timestamp(idev, &raw, pf->timestamp);
-err_read:
-	iio_trigger_notify_done(idev->trig);
-
-	return IRQ_HANDLED;
-}
-
-static int bu27008_buffer_preenable(struct iio_dev *idev)
-{
-	struct bu27008_data *data =3D iio_priv(idev);
-
-	return bu27008_meas_set(data, true);
-}
-
-static int bu27008_buffer_postdisable(struct iio_dev *idev)
-{
-	struct bu27008_data *data =3D iio_priv(idev);
-
-	return bu27008_meas_set(data, false);
-}
-
-static const struct iio_buffer_setup_ops bu27008_buffer_ops =3D {
-	.preenable =3D bu27008_buffer_preenable,
-	.postdisable =3D bu27008_buffer_postdisable,
-};
-
-static irqreturn_t bu27008_data_rdy_poll(int irq, void *private)
-{
-	/*
-	 * The BU27008 keeps IRQ asserted until we read the VALID bit from
-	 * a register. We need to keep the IRQ disabled until then.
-	 */
-	disable_irq_nosync(irq);
-	iio_trigger_poll(private);
-
-	return IRQ_HANDLED;
-}
-
-static int bu27008_setup_trigger(struct bu27008_data *data, struct iio_dev=
 *idev)
-{
-	struct iio_trigger *itrig;
-	char *name;
-	int ret;
-
-	ret =3D devm_iio_triggered_buffer_setup(data->dev, idev,
-					      &iio_pollfunc_store_time,
-					      bu27008_trigger_handler,
-					      &bu27008_buffer_ops);
-	if (ret)
-		return dev_err_probe(data->dev, ret,
-			     "iio_triggered_buffer_setup_ext FAIL\n");
-
-	itrig =3D devm_iio_trigger_alloc(data->dev, "%sdata-rdy-dev%d",
-				       idev->name, iio_device_id(idev));
-	if (!itrig)
-		return -ENOMEM;
-
-	data->trig =3D itrig;
-
-	itrig->ops =3D &bu27008_trigger_ops;
-	iio_trigger_set_drvdata(itrig, data);
-
-	name =3D devm_kasprintf(data->dev, GFP_KERNEL, "%s-bu27008",
-			      dev_name(data->dev));
-
-	ret =3D devm_request_irq(data->dev, data->irq,
-			       &bu27008_data_rdy_poll,
-			       0, name, itrig);
-	if (ret)
-		return dev_err_probe(data->dev, ret, "Could not request IRQ\n");
-
-	ret =3D devm_iio_trigger_register(data->dev, itrig);
-	if (ret)
-		return dev_err_probe(data->dev, ret,
-				     "Trigger registration failed\n");
-
-	/* set default trigger */
-	idev->trig =3D iio_trigger_get(itrig);
-
-	return 0;
-}
-
-static int bu27008_probe(struct i2c_client *i2c)
-{
-	struct device *dev =3D &i2c->dev;
-	struct bu27008_data *data;
-	struct regmap *regmap;
-	unsigned int part_id, reg;
-	struct iio_dev *idev;
-	int ret;
-
-	idev =3D devm_iio_device_alloc(dev, sizeof(*data));
-	if (!idev)
-		return -ENOMEM;
-
-	ret =3D devm_regulator_get_enable(dev, "vdd");
-	if (ret)
-		return dev_err_probe(dev, ret, "Failed to get regulator\n");
-
-	data =3D iio_priv(idev);
-
-	data->cd =3D device_get_match_data(&i2c->dev);
-	if (!data->cd)
-		return -ENODEV;
-
-	regmap =3D devm_regmap_init_i2c(i2c, data->cd->regmap_cfg);
-	if (IS_ERR(regmap))
-		return dev_err_probe(dev, PTR_ERR(regmap),
-				     "Failed to initialize Regmap\n");
-
-
-	ret =3D regmap_read(regmap, BU27008_REG_SYSTEM_CONTROL, &reg);
-	if (ret)
-		return dev_err_probe(dev, ret, "Failed to access sensor\n");
-
-	part_id =3D FIELD_GET(BU27008_MASK_PART_ID, reg);
-
-	if (part_id !=3D data->cd->part_id)
-		dev_warn(dev, "unknown device 0x%x\n", part_id);
-
-	ret =3D devm_iio_init_iio_gts(dev, data->cd->scale1x, 0, data->cd->gains,
-				    data->cd->num_gains, data->cd->itimes,
-				    data->cd->num_itimes, &data->gts);
-	if (ret)
-		return ret;
-
-	ret =3D devm_iio_init_iio_gts(dev, data->cd->scale1x, 0, data->cd->gains_=
ir,
-				    data->cd->num_gains_ir, data->cd->itimes,
-				    data->cd->num_itimes, &data->gts_ir);
-	if (ret)
-		return ret;
-
-	mutex_init(&data->mutex);
-	data->regmap =3D regmap;
-	data->dev =3D dev;
-	data->irq =3D i2c->irq;
-
-	idev->channels =3D bu27008_channels;
-	idev->num_channels =3D ARRAY_SIZE(bu27008_channels);
-	idev->name =3D data->cd->name;
-	idev->info =3D &bu27008_info;
-	idev->modes =3D INDIO_DIRECT_MODE;
-	idev->available_scan_masks =3D bu27008_scan_masks;
-
-	ret =3D data->cd->chip_init(data);
-	if (ret)
-		return ret;
-
-	if (i2c->irq) {
-		ret =3D bu27008_setup_trigger(data, idev);
-		if (ret)
-			return ret;
-	} else {
-		dev_info(dev, "No IRQ, buffered mode disabled\n");
-	}
-
-	ret =3D devm_iio_device_register(dev, idev);
-	if (ret)
-		return dev_err_probe(dev, ret,
-				     "Unable to register iio device\n");
-
-	return 0;
-}
-
-static const struct of_device_id bu27008_of_match[] =3D {
-	{ .compatible =3D "rohm,bu27008", .data =3D &bu27008_chip },
-	{ .compatible =3D "rohm,bu27010", .data =3D &bu27010_chip },
-	{ }
-};
-MODULE_DEVICE_TABLE(of, bu27008_of_match);
-
-static struct i2c_driver bu27008_i2c_driver =3D {
-	.driver =3D {
-		.name =3D "bu27008",
-		.of_match_table =3D bu27008_of_match,
-		.probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
-	},
-	.probe =3D bu27008_probe,
-};
-module_i2c_driver(bu27008_i2c_driver);
-
-MODULE_DESCRIPTION("ROHM BU27008 and BU27010 colour sensor driver");
-MODULE_AUTHOR("Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>");
-MODULE_LICENSE("GPL");
-MODULE_IMPORT_NS(IIO_GTS_HELPER);
--=20
2.47.0


--eT1uhLza7d2CeyD/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmdIxfUACgkQeFA3/03a
ocVAAAf8DNNRszQ1jSOerGqeKmW1tLwXWSbO/zV1Eg+ZYC4iZQ+kHzHGTP6GJc9n
kKGUC1UzIsf6PrEzJtSsUubmFzN+EB9CB9+SyDl1ilVxt3FffpaOqEbbzpl5A8wo
CDerjwrOOjz6H8CYlfR6cCdWl3ZwHFotOyorlhiySmALkylU5P8+WPJ2hQ50wHq2
2Yh9+lhGPXdUXZr/E3pwgBfDEXz82cKNGBbONpCCGCpXcwYVmIaRjQRplBU/xdAh
izKXZuU5LFr3rD5ZNo9+Czd+LHzZwqDVdmR1WmYU97OmM5huq9gtiGyBipAWzykK
DOlwRdrrNU35JP0MRehKLZJK4PNfRw==
=c1Ub
-----END PGP SIGNATURE-----

--eT1uhLza7d2CeyD/--

