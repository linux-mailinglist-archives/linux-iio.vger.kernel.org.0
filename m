Return-Path: <linux-iio+bounces-25295-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CBBF8BF35C8
	for <lists+linux-iio@lfdr.de>; Mon, 20 Oct 2025 22:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3CB793418B5
	for <lists+linux-iio@lfdr.de>; Mon, 20 Oct 2025 20:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32812E1C6F;
	Mon, 20 Oct 2025 20:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ftDzgrxF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CB12DCC05
	for <linux-iio@vger.kernel.org>; Mon, 20 Oct 2025 20:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760991463; cv=none; b=pBm1/ojV30jdop2Jq9vIrGxrSV0kicR9x48ZGvx1SCsSeJ+I9cN7ogZrboUfS5Gu9C94SWfsMLkF9CDoNs6EBq8dYOEKmO8r/fZ/Wdt32c8kjtSZ3pHta9trDlpuvOr/4Gl6jHzXhh8MyVbMW1cp959g7SnlTsIqs0roVFOyOjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760991463; c=relaxed/simple;
	bh=1WRhBSbclDvrVVgwK+g58YJcFcb3Bhe37HfEQREtH5A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NwFIfd0TG2lsBhx/bwW+vK2P9MHVX8hsoeNAzkRMT/H+fXEkGPYxA53c2Q/Tno98e/ejVrXh1796ew0RWADfDa8kjUjVRGcJKUjP9NdbQIFaYwQhc2amo/bU5TNtH+8QdnIL20qhVak3VvF8TwRtv6cD4JHxwjpAj0f1WYChi98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ftDzgrxF; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7a213c3c3f5so6176213b3a.3
        for <linux-iio@vger.kernel.org>; Mon, 20 Oct 2025 13:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760991461; x=1761596261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2HiIag4gojntGeG3Lt/25yjUryhrv0nCmHlT9/AhVAY=;
        b=ftDzgrxFcEIVZOqIIFnyeM/Jh0OWV2QDJ0CgNAGnUVeE9D3gY0q7yvGznlEOZnYHv4
         3+fRlReI7OjxzQMAieF+41QyJPq2AvFb1tAyGW6QqGKgqfyASXBs7pt19PtQMQvbKIfu
         8yR6/hNI4a/1hnmBSEl7BfapJE/UFFlDCYAPpvSIvk3QWEMXwHWdT/M9qh5p5AY/HYXj
         HPQ2juV9PWfeYWgsgOvPKIgr2UfaKf/QeL1cXkB+clBI1Do9/1jeEbjlOzDoaUcfYvZS
         kbrBWGe0QJ4SVl7OoLY3HeCoN2jDn0lXO1sZ9k2bqiAt3ttVQn2MTAb5dwERKJSbUiWJ
         Ic8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760991461; x=1761596261;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2HiIag4gojntGeG3Lt/25yjUryhrv0nCmHlT9/AhVAY=;
        b=iJ6weupOHeMf+mLycYd458zU5FAAbHsll8IToF8yhglgrmkt4BcSHPhyIgwwYQn/a7
         HXl/7LbLYg1CzYuhlHFeJTXpj/Ge7fvzQt/W20nXchJwGz7jdHUFEUdCPqAx/xrRLCTq
         9jMJeNM3zaADE6rPmf/nOV52XJBjQaSjbO7lPPv/tckJP+lQ3+uWNUufZbdBOCvd/X3w
         nEiEDuuHozkmU84vr9HChGR00zY4EcU1+2nxNhWE3GIQAoDc8WNUL3ANGpc6eBjThj4b
         FKpjwbYNv03O3w6Y99lG3o9Z3xtBVHWgGCQqPJ8lAfO6gr/JLELxE2o1XL4WCBC6pJLA
         se1g==
X-Forwarded-Encrypted: i=1; AJvYcCVarEApg7XaSrnn9YJQVGbjg1tqhgbCsEFl00I4orP6tjVC+2GFqCweBDCx7Zq5Fzk2UPUO/58FId0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2VRKOIgqMsOQUR66xyS6sifhSKY3TkcpA53OZMjcF+QshI+39
	rA6qw2e36U72Wpp7hOQsuw9E8qRoEWvUyAR83RaA0lWOKfqRSc9YYWpn
X-Gm-Gg: ASbGncsOOFp9L7lj2SkUbPu9H7wvM4+kDXv2e4n6QcBi7MpzJ7MG4YWmIlhsFQciG/A
	hg79rZxDbqHmlJrLOzx7KWY3uKHtwQJl4CqlbSIy62e1zXP3J69yDWIxIkMyC5Lo+X3SJ3V7W5J
	a+ZXE/ZIABpysSVTAQ0VnBb9l9IP8s95oiRYAlBojEIyK4h655CQHFQcksytF6yj9peDd77mRHJ
	mJvsCjrbWAASviki/rNjnNmd2/zhfedRnbjF/SSKKz3CrJYL+txg3Pfd2vF5S/mxJG8sF66yQIv
	8QWmMG1bMLSBBr63Tzn1zb9T/Az3ZNW8Mps2zn/b4rYT96hbgKr1hqgFB3WAKC3WHrzn4bBbbvv
	u0OosvR0BZPCCveM0QNQuGTlilPaA+AMTb6skbe+GazfBwd1x7ytFjTy2sp8ZfQ1b4Zyi5IOpTh
	5E
X-Google-Smtp-Source: AGHT+IEvd5nURSzwvSsvWjh5RX4S5kfjpUNPVi8RB0b2/CoVUy3A5JGhmyGLHB+ukqu3imN65zC+bA==
X-Received: by 2002:a05:6a00:21c5:b0:771:fdd9:efa0 with SMTP id d2e1a72fcca58-7a220d232a7mr20401061b3a.15.1760991460664;
        Mon, 20 Oct 2025 13:17:40 -0700 (PDT)
Received: from pop-os.. ([106.222.200.146])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a23010df83sm9104263b3a.59.2025.10.20.13.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 13:17:40 -0700 (PDT)
From: Aditya Dutt <duttaditya18@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Frank Zago <frank@zago.net>
Cc: Aditya Dutt <duttaditya18@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH 2/2] iio: position: Add support for ams AS5600 angle sensor
Date: Tue, 21 Oct 2025 01:46:53 +0530
Message-Id: <20251020201653.86181-3-duttaditya18@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251020201653.86181-1-duttaditya18@gmail.com>
References: <20251020201653.86181-1-duttaditya18@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The AS5600 is a Hall-based rotary magnetic position sensor using
planar sensors that convert the magnetic field component perpendicular
to the surface of the chip into a voltage, or a numerical value
available through i2c.

The driver registers the chip as an IIO_ANGL device.
It also exposes the raw registers through debugfs for further configuration.

Datasheet: https://ams-osram.com/products/sensor-solutions/position-sensors/ams-as5600-position-sensor
Co-developed-by: Frank Zago <frank@zago.net>
Signed-off-by: Frank Zago <frank@zago.net>
Signed-off-by: Aditya Dutt <duttaditya18@gmail.com>
---
 Documentation/iio/as5600.rst  |  84 ++++++++
 Documentation/iio/index.rst   |   1 +
 MAINTAINERS                   |   8 +
 drivers/iio/position/Kconfig  |  10 +
 drivers/iio/position/Makefile |   1 +
 drivers/iio/position/as5600.c | 373 ++++++++++++++++++++++++++++++++++
 6 files changed, 477 insertions(+)
 create mode 100644 Documentation/iio/as5600.rst
 create mode 100644 drivers/iio/position/as5600.c

diff --git a/Documentation/iio/as5600.rst b/Documentation/iio/as5600.rst
new file mode 100644
index 000000000000..d74c4052e590
--- /dev/null
+++ b/Documentation/iio/as5600.rst
@@ -0,0 +1,84 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+=================
+ams AS5600 driver
+=================
+
+
+Overview
+========
+
+The ams AS5600 is a 12-Bit Programmable Contactless Potentiometer. Its
+i2c address is 0x36.
+
+For more information, see the datasheet at
+
+  https://ams-osram.com/products/sensor-solutions/position-sensors/ams-as5600-position-sensor
+
+
+Channels
+========
+
+The driver provides **two channels**:
+
+- **Channel 0**: raw, unscaled angle measurement
+- **Channel 1**: scaled angle measurement according to the configured
+  ``ZPOS`` / ``MPOS`` range
+
+``ZPOS`` and ``MPOS`` let a user restrict the angle returned, which improves
+the precision returned, since the angle returned is still in the 0 to
+4095 range. The minimal angle recommended is 18 degrees.
+
+The following files are exposed under ``/sys/bus/iio/devices/iio:deviceX``
+where X is the IIO index of the device.
+
++----------------+-------------------------------------------------+
+| File           | Description                                     |
++================+=================================================+
+| in_angl0_raw   | Raw angle measurement                           |
++----------------+-------------------------------------------------+
+| in_angl0_scale | Scale for channel 0                             |
++----------------+-------------------------------------------------+
+| in_angl1_raw   | Adjusted angle measurement, scaled by ZPOS/MPOS |
++----------------+-------------------------------------------------+
+| in_angl1_scale | Scale for channel 1                             |
++----------------+-------------------------------------------------+
+
+
+Accessing the device registers
+==============================
+
+The driver exposes direct register access via debugfs. This allows reading and
+writing I2C registers for debugging or configuration.
+
+Assuming the device is iio:deviceX, its debugfs path will be:
+
+.. code-block:: sh
+
+  $ AS5600=/sys/kernel/debug/iio/iio:deviceX/direct_reg_access
+
+Locate the index of a register to access in the datasheet, then use
+the following commands to read a value:
+
+.. code-block:: sh
+
+  $ echo <reg> > $AS5600/direct_reg_access
+  $ cat $AS5600/direct_reg_access
+
+or this to write a value:
+
+.. code-block:: sh
+
+  $ echo <reg> <value> > $AS5600/direct_reg_access
+
+For instance, this would return the lower byte of RAW ANGLE.
+
+.. code-block:: sh
+
+  $ echo 0x0D > $AS5600/direct_reg_access
+  $ cat $AS5600/direct_reg_access
+
+.. warning::
+
+   Register ``BURN`` (0xFF) permanently modifies device behavior.
+   Use with caution after reading the datasheet carefully.
diff --git a/Documentation/iio/index.rst b/Documentation/iio/index.rst
index 315ae37d6fd4..14d097f753f1 100644
--- a/Documentation/iio/index.rst
+++ b/Documentation/iio/index.rst
@@ -35,6 +35,7 @@ Industrial I/O Kernel Drivers
    adxl313
    adxl380
    adxl345
+   as5600
    bno055
    ep93xx_adc
    opt4060
diff --git a/MAINTAINERS b/MAINTAINERS
index 46126ce2f968..ffef001ea7c4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1368,6 +1368,14 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/media/amphion,vpu.yaml
 F:	drivers/media/platform/amphion/
 
+AMS AS5600 DRIVER
+M:	Aditya Dutt <duttaditya18@gmail.com>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/position/ams,as5600.yaml
+F:	Documentation/iio/as5600.rst
+F:	drivers/iio/position/as5600.c
+
 AMS AS73211 DRIVER
 M:	Christian Eggers <ceggers@arri.de>
 L:	linux-iio@vger.kernel.org
diff --git a/drivers/iio/position/Kconfig b/drivers/iio/position/Kconfig
index 1576a6380b53..111ed551ae79 100644
--- a/drivers/iio/position/Kconfig
+++ b/drivers/iio/position/Kconfig
@@ -6,6 +6,16 @@
 
 menu "Linear and angular position sensors"
 
+config AS5600
+	tristate "ams AS5600 angular position sensor"
+	depends on I2C
+	help
+	  Say Y here if you want to build support for the ams 5600
+	  12-Bit Programmable Contactless Potentiometer.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called as5600.
+
 config IQS624_POS
 	tristate "Azoteq IQS624/625 angular position sensors"
 	depends on MFD_IQS62X || COMPILE_TEST
diff --git a/drivers/iio/position/Makefile b/drivers/iio/position/Makefile
index d70902f2979d..53930681e6a4 100644
--- a/drivers/iio/position/Makefile
+++ b/drivers/iio/position/Makefile
@@ -4,5 +4,6 @@
 
 # When adding new entries keep the list in alphabetical order
 
+obj-$(CONFIG_AS5600)		+= as5600.o
 obj-$(CONFIG_HID_SENSOR_CUSTOM_INTEL_HINGE) += hid-sensor-custom-intel-hinge.o
 obj-$(CONFIG_IQS624_POS)	+= iqs624-pos.o
diff --git a/drivers/iio/position/as5600.c b/drivers/iio/position/as5600.c
new file mode 100644
index 000000000000..fe716d521548
--- /dev/null
+++ b/drivers/iio/position/as5600.c
@@ -0,0 +1,373 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * ams AS5600 -- 12-Bit Programmable Contactless Potentiometer
+ *
+ * Copyright (c) 2021 Frank Zago
+ * Copyright (c) 2025 Aditya Dutt
+ *
+ * datasheet
+ *    https://ams-osram.com/products/sensor-solutions/position-sensors/ams-as5600-position-sensor
+ *
+ * The rotating magnet is installed from 0.5mm to 3mm parallel to and
+ * above the chip.
+ *
+ * The raw angle value returned by the chip is [0..4095]. The channel
+ * 0 (in_angl0_raw) returns the unscaled and unmodified angle, always
+ * covering the 360 degrees. The channel 1 returns the chip adjusted
+ * angle, covering from 18 to 360 degrees, as modified by its
+ * ZPOS/MPOS/MANG values,
+ *
+ * ZPOS and MPOS can be programmed through their debugfs entries. The
+ * MANG register doesn't appear to be programmable without flashing
+ * the chip.
+ *
+ * If the DIR pin is grounded, angles will increase when the magnet is
+ * turned clockwise. If DIR is connected to Vcc, it will be the opposite.
+ *
+ * The i2c address of the device is 0x36.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/iio/iio.h>
+#include <linux/module.h>
+
+/* Register definitions */
+#define AS5600_REG_ZMCO              0x00
+#define     AS5600_MASK_ZMCO         GENMASK(1, 0)
+#define AS5600_REG_ZPOS_H            0x01
+#define     AS5600_MASK_ZPOS_H       GENMASK(3, 0) /* bits 11:8 */
+#define AS5600_REG_ZPOS_L            0x02
+#define AS5600_REG_MPOS_H            0x03
+#define     AS5600_MASK_MPOS_H       GENMASK(3, 0) /* bits 11:8 */
+#define AS5600_REG_MPOS_L            0x04
+#define AS5600_REG_MANG_H            0x05
+#define     AS5600_MASK_MANG_H       GENMASK(3, 0) /* bits 11:8 */
+#define AS5600_REG_MANG_L            0x06
+#define AS5600_REG_CONF_H            0x07
+#define     AS5600_MASK_CONF_H       GENMASK(5, 0)
+#define     AS5600_MASK_SF           GENMASK(1, 0)
+#define     AS5600_MASK_FTH          GENMASK(4, 2)
+#define     AS5600_MASK_WD           BIT(5)
+#define AS5600_REG_CONF_L            0x08
+#define     AS5600_MASK_PM           GENMASK(1, 0)
+#define     AS5600_MASK_HYST         GENMASK(3, 2)
+#define     AS5600_MASK_OUTS         GENMASK(5, 4)
+#define     AS5600_MASK_PWMF         GENMASK(7, 6)
+#define AS5600_REG_STATUS            0x0B
+#define     AS5600_MASK_STATUS       GENMASK(5, 3)
+#define     AS5600_MASK_MH           BIT(3)
+#define     AS5600_MASK_ML           BIT(4)
+#define     AS5600_MASK_MD           BIT(5)
+#define AS5600_REG_RAW_ANGLE_H       0x0C
+#define     AS5600_MASK_RAW_ANGLE_H  GENMASK(3, 0) /* bits 11:8 */
+#define AS5600_REG_RAW_ANGLE_L       0x0D
+#define AS5600_REG_ANGLE_H           0x0E
+#define     AS5600_MASK_ANGLE_H      GENMASK(3, 0) /* bits 11:8 */
+#define AS5600_REG_ANGLE_L           0x0F
+#define AS5600_REG_AGC               0x1A
+#define AS5600_REG_MAGN_H            0x1B
+#define     AS5600_MASK_MAGN_H       GENMASK(3, 0) /* bits 11:8 */
+#define AS5600_REG_MAGN_L            0x1C
+#define AS5600_REG_BURN              0xFF
+
+/* Combined 16-bit register addresses for clarity */
+#define AS5600_REG_ZPOS              0x01
+#define AS5600_REG_MPOS              0x03
+#define AS5600_REG_RAW_ANGLE         0x0C
+#define AS5600_REG_ANGLE             0x0E
+
+/* Field masks for the entire 2 byte */
+#define AS5600_FIELD_ZPOS            GENMASK(11, 0)
+#define AS5600_FIELD_MPOS            GENMASK(11, 0)
+#define AS5600_FIELD_RAW_ANGLE       GENMASK(11, 0)
+#define AS5600_FIELD_ANGLE           GENMASK(11, 0)
+
+struct as5600_priv {
+	struct i2c_client *client;
+	struct mutex lock;
+	u16 zpos;
+	u16 mpos;
+};
+
+static int as5600_read_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan,
+			   int *val, int *val2, long mask)
+{
+	struct as5600_priv *priv = iio_priv(indio_dev);
+	u16 bitmask;
+	s32 ret;
+	u16 reg;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		if (chan->channel == 0) {
+			reg = AS5600_REG_RAW_ANGLE;
+			bitmask = AS5600_FIELD_RAW_ANGLE;
+		} else {
+			reg = AS5600_REG_ANGLE;
+			bitmask = AS5600_FIELD_ANGLE;
+		}
+		ret = i2c_smbus_read_word_swapped(priv->client, reg);
+
+		if (ret < 0)
+			return ret;
+		*val = ret & bitmask;
+
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_SCALE:
+		/* Always 4096 steps, but angle range varies between
+		 * 18 and 360 degrees.
+		 */
+		if (chan->channel == 0) {
+			/* Whole angle range = 2*pi / 4096 */
+			*val = 2 * 3141592;
+			*val2 = 4096000000;
+		} else {
+			s32 range;
+
+			/* MPOS - ZPOS defines the active angle selection */
+			/* Partial angle = (range / 4096) * (2*pi / 4096) */
+			mutex_lock(&priv->lock);
+			range = priv->mpos - priv->zpos;
+			mutex_unlock(&priv->lock);
+			if (range <= 0)
+				range += 4096;
+
+			*val = range * 2 * 314159;
+			*val /= 4096;
+			*val2 = 409600000;
+		}
+
+		return IIO_VAL_FRACTIONAL;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static ssize_t as5600_reg_access_read(struct as5600_priv *priv,
+				      unsigned int reg, unsigned int *val)
+{
+	int ret;
+	u8 mask;
+
+	switch (reg) {
+	case AS5600_REG_ZMCO:
+		mask = AS5600_MASK_ZMCO;
+		break;
+	case AS5600_REG_ZPOS_H:
+		mask = AS5600_MASK_ZPOS_H;
+		break;
+	case AS5600_REG_MPOS_H:
+		mask = AS5600_MASK_MPOS_H;
+		break;
+	case AS5600_REG_MANG_H:
+		mask = AS5600_MASK_MANG_H;
+		break;
+	case AS5600_REG_CONF_H:
+		mask = AS5600_MASK_CONF_H;
+		break;
+	case AS5600_REG_STATUS:
+		mask = AS5600_MASK_STATUS;
+		break;
+	case AS5600_REG_RAW_ANGLE_H:
+		mask = AS5600_MASK_RAW_ANGLE_H;
+		break;
+	case AS5600_REG_ANGLE_H:
+		mask = AS5600_MASK_ANGLE_H;
+		break;
+	case AS5600_REG_MAGN_H:
+		mask = AS5600_MASK_MAGN_H;
+		break;
+	case AS5600_REG_ZPOS_L:
+	case AS5600_REG_MPOS_L:
+	case AS5600_REG_MANG_L:
+	case AS5600_REG_CONF_L:
+	case AS5600_REG_RAW_ANGLE_L:
+	case AS5600_REG_ANGLE_L:
+	case AS5600_REG_AGC:
+	case AS5600_REG_MAGN_L:
+		mask = 0xFF;
+		break;
+	default:
+		/* Not a readable register */
+		return -EINVAL;
+	}
+
+
+	ret = i2c_smbus_read_byte_data(priv->client, reg);
+	if (ret < 0)
+		return ret;
+
+	/* because the chip may return garbage data in the unused bits */
+	*val = ret & mask;
+	return 0;
+}
+
+static ssize_t as5600_reg_access_write(struct as5600_priv *priv,
+				       unsigned int reg, unsigned int writeval)
+{
+	int ret;
+	u8 mask;
+
+	if (writeval > 0xFF)
+		return -EINVAL;
+
+	switch (reg) {
+	case AS5600_REG_ZPOS_H:
+		mask = AS5600_MASK_ZPOS_H;
+		break;
+	case AS5600_REG_MPOS_H:
+		mask = AS5600_MASK_MPOS_H;
+		break;
+	case AS5600_REG_MANG_H:
+		mask = AS5600_MASK_MANG_H;
+		break;
+	case AS5600_REG_CONF_H:
+		mask = AS5600_MASK_CONF_H;
+		break;
+	case AS5600_REG_ZPOS_L:
+	case AS5600_REG_MPOS_L:
+	case AS5600_REG_MANG_L:
+	case AS5600_REG_CONF_L:
+	case AS5600_REG_BURN:
+		mask = 0xFF;
+		break;
+	default:
+		/* Not a writable register */
+		return -EINVAL;
+	}
+
+	ret = i2c_smbus_write_byte_data(priv->client, reg, writeval & mask);
+	if (ret < 0)
+		return ret;
+
+	/* update priv->zpos and priv->mpos */
+	mutex_lock(&priv->lock);
+	switch (reg) {
+	case AS5600_REG_ZPOS_H:
+		priv->zpos = (priv->zpos & 0x00FF) | ((writeval & mask) << 8);
+		break;
+	case AS5600_REG_ZPOS_L:
+		priv->zpos = (priv->zpos & 0xFF00) | (writeval & mask);
+		break;
+	case AS5600_REG_MPOS_H:
+		priv->mpos = (priv->mpos & 0x00FF) | ((writeval & mask) << 8);
+		break;
+	case AS5600_REG_MPOS_L:
+		priv->mpos = (priv->mpos & 0xFF00) | (writeval & mask);
+		break;
+	}
+	mutex_unlock(&priv->lock);
+	return 0;
+}
+
+static int as5600_reg_access(struct iio_dev *indio_dev, unsigned int reg,
+			     unsigned int writeval, unsigned int *readval)
+{
+	struct as5600_priv *priv = iio_priv(indio_dev);
+	int ret;
+
+	if (readval) {
+		ret = as5600_reg_access_read(priv, reg, readval);
+	} else {
+		ret = as5600_reg_access_write(priv, reg, writeval);
+	}
+
+	return ret;
+}
+
+static const struct iio_chan_spec as5600_channels[] = {
+	{
+		.type = IIO_ANGL,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+			BIT(IIO_CHAN_INFO_SCALE),
+		.indexed = 1,
+		.channel = 0,
+	},
+	{
+		.type = IIO_ANGL,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+			BIT(IIO_CHAN_INFO_SCALE),
+		.indexed = 1,
+		.channel = 1,
+	},
+};
+
+static const struct iio_info as5600_info = {
+	.read_raw = &as5600_read_raw,
+	.debugfs_reg_access = &as5600_reg_access,
+};
+
+static int as5600_probe(struct i2c_client *client)
+{
+	struct as5600_priv *priv;
+	struct iio_dev *indio_dev;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*priv));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	priv = iio_priv(indio_dev);
+	i2c_set_clientdata(client, indio_dev);
+	priv->client = client;
+	mutex_init(&priv->lock);
+
+	indio_dev->info = &as5600_info;
+	indio_dev->name = "as5600";
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = as5600_channels;
+	indio_dev->num_channels = ARRAY_SIZE(as5600_channels);
+
+	ret = i2c_smbus_read_byte_data(client, AS5600_REG_STATUS);
+	if (ret < 0)
+		return ret;
+
+	/* No magnet present could be a problem. */
+	if ((ret & AS5600_MASK_MD) == 0)
+		dev_warn(&client->dev, "Magnet not detected\n");
+
+	ret = i2c_smbus_read_word_swapped(client, AS5600_REG_ZPOS);
+	if (ret < 0)
+		return ret;
+	priv->zpos = ret & AS5600_FIELD_ZPOS;
+
+	ret = i2c_smbus_read_word_swapped(client, AS5600_REG_MPOS);
+	if (ret < 0)
+		return ret;
+	priv->mpos = ret & AS5600_FIELD_MPOS;
+
+	return devm_iio_device_register(&client->dev, indio_dev);
+}
+
+static const struct i2c_device_id as5600_id[] = {
+	{ "as5600" },
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, as5600_id);
+
+static const struct of_device_id as5600_match[] = {
+	{ .compatible = "ams,as5600" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, as5600_match);
+
+static struct i2c_driver as5600_driver = {
+	.driver = {
+		.name = "as5600",
+		.of_match_table = as5600_match,
+	},
+	.probe = as5600_probe,
+	.id_table   = as5600_id,
+};
+
+module_i2c_driver(as5600_driver);
+
+MODULE_AUTHOR("Frank Zago <frank@zago.net>");
+MODULE_AUTHOR("Aditya Dutt <duttaditya18@gmail.com>");
+MODULE_DESCRIPTION("ams AS5600 Position Sensor");
+MODULE_LICENSE("GPL");
-- 
2.34.1


