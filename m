Return-Path: <linux-iio+bounces-13807-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6799D9FC8BD
	for <lists+linux-iio@lfdr.de>; Thu, 26 Dec 2024 06:54:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4B0A7A1981
	for <lists+linux-iio@lfdr.de>; Thu, 26 Dec 2024 05:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 994D515DBBA;
	Thu, 26 Dec 2024 05:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FWLEA2xn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FFF1865E1;
	Thu, 26 Dec 2024 05:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735192420; cv=none; b=tip3MIysaycraxPcCMNSM37mFLVT7mflko36MnEHFmci2H9Kzomac5iCagyKtfp8fW8Ho/nql9idvWACqSCzKk8/CZAlVixSCbjFulEWpxuycYGG70Sor6/9DIGJSxEUfCvQo4/Fnta9qkfYFaQ1W/uK6z0GBa4Z/6aMzUkD+3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735192420; c=relaxed/simple;
	bh=o0FrrGaGMhS9hGa4VLvorp6+/8EgEPyG2pq2b/Fp2YU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Wp1SpKzvKDofbGZLXgrsC5lOrOYD9XMTII6YY2g8sa1L0QZoArcZEbCyWXy0/HkH09tUBMzz313cRVsj99qNu+7t4Vql3mR1feKdRtc3JrpsnbbTRImYPBc7BL5pOXdznfZ2/KPIuRiDsR+grbRFvVrCLvI/G5TQNA+vPFEPpZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FWLEA2xn; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21654fdd5daso67068835ad.1;
        Wed, 25 Dec 2024 21:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735192417; x=1735797217; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iME034rfAdvC6Oc6Zo4UlGAybCc+y1bamQ3H77fNS/A=;
        b=FWLEA2xnatO0Zy3DobgJVsY9K8rtIWQVBladd90/KzkCh5V4XtRi6KxiuAcN0OFBXY
         gC60P7iMaxodynAYl2aftIcUOneTJEgFfyccpn5YUwPY7PEOoqiwFJ6P/zTdg7XmDqUN
         uqvqBaR70Q7eH9HFvuHjW/UKryzaBsC1pRuvlTD9z36WjOfHYsM6FZSaiyv44VVCbagn
         kWd5XXJuW4HJhpzts5ZIPQxlbvyJ3TC+KK8w7P9phAWPd+xGpVOukXF3/v3dJ3LR6H8i
         l/Cy/vvHZWEPhd76ACtHqtK+R2Ui9Drv/3NE3w4yKck+PYdL0g2++i0rBtI9Au01Kr5b
         0Smg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735192417; x=1735797217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iME034rfAdvC6Oc6Zo4UlGAybCc+y1bamQ3H77fNS/A=;
        b=KAf3/JJ/4BpxyA3F1wNXXtdN9KFG3ZCVzgaDd7rYu5gqZP+tQa6VXSeH6rqkArlQee
         VzpyjwQy4eDhzhZ6jAXT0YEk1Z+bprAVEoxr22pB3CrBbyQGes7hgBCXUwzmuihF0c02
         ptZ/pgwZGyY/t1isifg5Qno4E56QLWW8JSi/FzRs02dBbuBbIkUsULl+tj5fO0Qn6NeB
         1NttmHhEKiJOe3To77Zfa5COa/BUT3S1YuX8oIePfnfdc+uCqoEioPupzIGIOuk+0A7j
         R5auhej4U80Ck+1+rrZ26y4nyoYrZfrAZDQzTWW8TrHXrdyTgJtvtwXsEMY5TXwFi9Hk
         56OQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEWp5MN7H/2KFGx2+ZaW3L83OnMFEXrhd2414F1FA81WUEPaSJdsYvqqRp0nL6LGFoztyLRdndF42/DdGH@vger.kernel.org, AJvYcCWmwp1ZWfRutU218RNJaThkb9uf8JzjmrIyzwVEbuWqygxeFfxqAFo1oVxzS+DHUzT54iGhtyYcu+w3@vger.kernel.org, AJvYcCX8vrDTINK+iTZscBplI26d/LQxYlzYE/jVpxRrUzXdFPNbW2rnkyAWp8BdFEg0ASqE4R0SpSbYUcPI@vger.kernel.org
X-Gm-Message-State: AOJu0YxanR6S3OxCnRM4zHVt107VbF1K8jvIMmXyaLbC9lqg/oZtHljB
	NHy9L94wVvJ7LSHW0yYKIHdd3IrThi0ooUZATDM9+Yq8q4l43imt
X-Gm-Gg: ASbGncssweYA0Y0BTTEGatTOXrO/rbS5scSMQ/Hl/jbJ6NFXUpJxvnpHVi8Q0fUnHLW
	ucyUbKLtNy27xpG6YH5sxDPt0x265lrsMpnQ+6aWhoTKyupZg+7OxFQwWAbnF3eUe2ZhKtRUDRP
	r5ySmL2pmYEJEmL0ZjbbSVGcH+vvCiIHg9suahHn7dOX9VO/bxJ2pmH6RFl+pKUJqdk6AErJIry
	WHsmKvSBwr/DyTuQ7lDZoPO3QudbH7dWiow9Bn6fGlJl0xTHpImGfH4Asnq0K6CB4M07BxYvXmd
	IZn5AXb+csjf7FQ9UvwD1Q==
X-Google-Smtp-Source: AGHT+IEaMDfh1YognyqbMwkqmbzJ6ptCtH031YYnq+sVyxzTo9YTKZG7i16CkFlr3kKgR0pmt1rlNA==
X-Received: by 2002:a17:903:41c1:b0:215:b45a:6a63 with SMTP id d9443c01a7336-219e6ec0883mr313588145ad.32.1735192417555;
        Wed, 25 Dec 2024 21:53:37 -0800 (PST)
Received: from hcdev-d520mt.. (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc96312asm112679455ad.21.2024.12.25.21.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Dec 2024 21:53:36 -0800 (PST)
From: Eason Yang <j2anfernee@gmail.com>
To: avifishman70@gmail.com,
	tmaimon77@gmail.com,
	tali.perry1@gmail.com,
	venture@google.com,
	yuenn@google.com,
	benjaminfair@google.com,
	jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	nuno.sa@analog.com,
	dlechner@baylibre.com,
	javier.carrasco.cruz@gmail.com,
	andriy.shevchenko@linux.intel.com,
	marcelo.schmitt@analog.com,
	olivier.moysan@foss.st.com,
	mitrutzceclan@gmail.com,
	tgamblin@baylibre.com,
	matteomartelli3@gmail.com,
	alisadariana@gmail.com,
	gstols@baylibre.com,
	thomas.bonnefille@bootlin.com,
	herve.codina@bootlin.com,
	chanh@os.amperecomputing.com,
	KWLIU@nuvoton.com,
	yhyang2@nuvoton.com
Cc: openbmc@lists.ozlabs.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eason Yang <j2anfernee@gmail.com>
Subject: [PATCH v3 2/2] iio: adc: add Nuvoton NCT7201 ADC driver
Date: Thu, 26 Dec 2024 13:53:13 +0800
Message-Id: <20241226055313.2841977-3-j2anfernee@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241226055313.2841977-1-j2anfernee@gmail.com>
References: <20241226055313.2841977-1-j2anfernee@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Nuvoton NCT7201/NCT7202 system voltage monitor 12-bit ADC driver

NCT7201/NCT7202 supports up to 12 analog voltage monitor inputs and up to
4 SMBus addresses by ADDR pin. Meanwhile, ALERT# hardware event pins for
independent alarm signals, and the all threshold values could be set for
system protection without any timing delay. It also supports reset input
RSTIN# to recover system from a fault condition.

Currently, only single-edge mode conversion and threshold events support.

Signed-off-by: Eason Yang <j2anfernee@gmail.com>
---
 MAINTAINERS               |   1 +
 drivers/iio/adc/Kconfig   |  10 +
 drivers/iio/adc/Makefile  |   1 +
 drivers/iio/adc/nct7201.c | 449 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 461 insertions(+)
 create mode 100644 drivers/iio/adc/nct7201.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 9c5328cbef17..592ccca88f04 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2799,6 +2799,7 @@ F:	arch/arm/mach-npcm/
 F:	arch/arm64/boot/dts/nuvoton/
 F:	drivers/*/*/*npcm*
 F:	drivers/*/*npcm*
+F:	drivers/iio/adc/nct7201.c
 F:	drivers/rtc/rtc-nct3018y.c
 F:	include/dt-bindings/clock/nuvoton,npcm7xx-clock.h
 F:	include/dt-bindings/clock/nuvoton,npcm845-clk.h
diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 849c90203071..abd8b21fdbac 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1048,6 +1048,16 @@ config NAU7802
 	  To compile this driver as a module, choose M here: the
 	  module will be called nau7802.
 
+config NCT7201
+	tristate "Nuvoton Instruments NCT7201 and NCT7202 Power Monitor"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  If you say yes here you get support for the Nuvoton NCT7201 and
+	  NCT7202 Voltage Monitor.
+	  This driver can also be built as a module. If so, the module
+	  will be called nct7201.
+
 config NPCM_ADC
 	tristate "Nuvoton NPCM ADC driver"
 	depends on ARCH_NPCM || COMPILE_TEST
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index ee19afba62b7..0108472e141c 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -94,6 +94,7 @@ obj-$(CONFIG_MESON_SARADC) += meson_saradc.o
 obj-$(CONFIG_MP2629_ADC) += mp2629_adc.o
 obj-$(CONFIG_MXS_LRADC_ADC) += mxs-lradc-adc.o
 obj-$(CONFIG_NAU7802) += nau7802.o
+obj-$(CONFIG_NCT7201) += nct7201.o
 obj-$(CONFIG_NPCM_ADC) += npcm_adc.o
 obj-$(CONFIG_PAC1921) += pac1921.o
 obj-$(CONFIG_PAC1934) += pac1934.o
diff --git a/drivers/iio/adc/nct7201.c b/drivers/iio/adc/nct7201.c
new file mode 100644
index 000000000000..9ad4d2919461
--- /dev/null
+++ b/drivers/iio/adc/nct7201.c
@@ -0,0 +1,449 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Driver for Nuvoton nct7201 and nct7202 power monitor chips.
+ *
+ * Copyright (c) 2024 Nuvoton Inc.
+ */
+
+#include <linux/array_size.h>
+#include <linux/bits.h>
+#include <linux/cleanup.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/init.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/regmap.h>
+#include <linux/types.h>
+#include <linux/unaligned.h>
+
+#include <linux/iio/events.h>
+#include <linux/iio/iio.h>
+
+#define NCT7201_VIN_MAX					12	/* Counted from 1 */
+#define NCT7201_IN_SCALING				4995
+#define NCT7201_IN_SCALING_FACTOR			10000
+
+#define NCT7201_REG_INTERRUPT_STATUS_1			0x0C
+#define NCT7201_REG_INTERRUPT_STATUS_2			0x0D
+#define NCT7201_REG_VOLT_LOW_BYTE			0x0F
+#define NCT7201_REG_CONFIGURATION			0x10
+#define  NCT7201_BIT_CONFIGURATION_START		BIT(0)
+#define  NCT7201_BIT_CONFIGURATION_ALERT_MSK		BIT(1)
+#define  NCT7201_BIT_CONFIGURATION_CONV_RATE		BIT(2)
+#define  NCT7201_BIT_CONFIGURATION_RESET		BIT(7)
+
+#define NCT7201_REG_ADVANCED_CONFIGURATION		0x11
+#define  NCT7201_BIT_ADVANCED_CONF_MOD_ALERT		BIT(0)
+#define  NCT7201_BIT_ADVANCED_CONF_MOD_STS		BIT(1)
+#define  NCT7201_BIT_ADVANCED_CONF_FAULT_QUEUE		BIT(2)
+#define  NCT7201_BIT_ADVANCED_CONF_EN_DEEP_SHUTDOWN	BIT(4)
+#define  NCT7201_BIT_ADVANCED_CONF_EN_SMB_TIMEOUT	BIT(5)
+#define  NCT7201_BIT_ADVANCED_CONF_MOD_RSTIN		BIT(7)
+
+#define NCT7201_REG_CHANNEL_INPUT_MODE			0x12
+#define NCT7201_REG_CHANNEL_ENABLE_1			0x13
+#define  NCT7201_REG_CHANNEL_ENABLE_1_MASK		GENMASK(7, 0)
+#define NCT7201_REG_CHANNEL_ENABLE_2			0x14
+#define  NCT7201_REG_CHANNEL_ENABLE_2_MASK		GENMASK(3, 0)
+#define NCT7201_REG_INTERRUPT_MASK_1			0x15
+#define NCT7201_REG_INTERRUPT_MASK_2			0x16
+#define NCT7201_REG_BUSY_STATUS				0x1E
+#define  NCT7201_BIT_BUSY				BIT(0)
+#define  NCT7201_BIT_PWR_UP				BIT(1)
+#define NCT7201_REG_ONE_SHOT				0x1F
+#define NCT7201_REG_SMUS_ADDRESS			0xFC
+#define NCT7201_REG_VIN_LIMIT_LSB_MASK			GENMASK(4, 0)
+
+#define NCT7201_REG_VIN(i)				(i)
+#define NCT7201_REG_VIN_HIGH_LIMIT(i)			(0x20 + (i) * 2)
+#define NCT7201_REG_VIN_LOW_LIMIT(i)			(0x21 + (i) * 2)
+#define NCT7201_REG_VIN_HIGH_LIMIT_LSB(i)		(0x40 + (i) * 2)
+#define NCT7201_REG_VIN_LOW_LIMIT_LSB(i)		(0x41 + (i) * 2)
+
+struct nct7201_chip_info {
+	struct i2c_client *client;
+	struct mutex access_lock;	/* for multi-byte read and write operations */
+	struct regmap *regmap;
+	struct regmap *regmap16;
+	int num_vin_channels;
+	u32 vin_mask;
+};
+
+struct nct7201_adc_model_data {
+	const char *model_name;
+	const struct iio_chan_spec *channels;
+	const int num_channels;
+	int num_vin_channels;
+};
+
+static const struct iio_event_spec nct7201_events[] = {
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
+				 BIT(IIO_EV_INFO_ENABLE),
+	}, {
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_FALLING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
+				 BIT(IIO_EV_INFO_ENABLE),
+	},
+};
+
+#define NCT7201_VOLTAGE_CHANNEL(chan, addr)				\
+	{								\
+		.type = IIO_VOLTAGE,					\
+		.indexed = 1,						\
+		.channel = chan,					\
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
+		.address = addr,					\
+		.event_spec = nct7201_events,				\
+		.num_event_specs = ARRAY_SIZE(nct7201_events),		\
+	}
+
+static const struct iio_chan_spec nct7201_channels[] = {
+	NCT7201_VOLTAGE_CHANNEL(1, 0),
+	NCT7201_VOLTAGE_CHANNEL(2, 1),
+	NCT7201_VOLTAGE_CHANNEL(3, 2),
+	NCT7201_VOLTAGE_CHANNEL(4, 3),
+	NCT7201_VOLTAGE_CHANNEL(5, 4),
+	NCT7201_VOLTAGE_CHANNEL(6, 5),
+	NCT7201_VOLTAGE_CHANNEL(7, 6),
+	NCT7201_VOLTAGE_CHANNEL(8, 7),
+};
+
+static const struct iio_chan_spec nct7202_channels[] = {
+	NCT7201_VOLTAGE_CHANNEL(1, 0),
+	NCT7201_VOLTAGE_CHANNEL(2, 1),
+	NCT7201_VOLTAGE_CHANNEL(3, 2),
+	NCT7201_VOLTAGE_CHANNEL(4, 3),
+	NCT7201_VOLTAGE_CHANNEL(5, 4),
+	NCT7201_VOLTAGE_CHANNEL(6, 5),
+	NCT7201_VOLTAGE_CHANNEL(7, 6),
+	NCT7201_VOLTAGE_CHANNEL(8, 7),
+	NCT7201_VOLTAGE_CHANNEL(9, 8),
+	NCT7201_VOLTAGE_CHANNEL(10, 9),
+	NCT7201_VOLTAGE_CHANNEL(11, 10),
+	NCT7201_VOLTAGE_CHANNEL(12, 11),
+};
+
+static int nct7201_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int *val, int *val2, long mask)
+{
+	u16 volt;
+	unsigned int value;
+	int err;
+	struct nct7201_chip_info *chip = iio_priv(indio_dev);
+
+	if (chan->type != IIO_VOLTAGE)
+		return -EOPNOTSUPP;
+
+	guard(mutex)(&chip->access_lock);
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		err = regmap_read(chip->regmap16, NCT7201_REG_VIN(chan->address), &value);
+		if (err < 0)
+			return err;
+		volt = value;
+		*val = volt >> 3;
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		/* From the datasheet, we have to multiply by 0.0004995 */
+		*val = 0;
+		*val2 = 499500;
+		return IIO_VAL_INT_PLUS_NANO;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int nct7201_read_event_value(struct iio_dev *indio_dev,
+				    const struct iio_chan_spec *chan,
+				    enum iio_event_type type,
+				    enum iio_event_direction dir,
+				    enum iio_event_info info,
+				    int *val, int *val2)
+{
+	struct nct7201_chip_info *chip = iio_priv(indio_dev);
+	u16 volt;
+	unsigned int value;
+	int err;
+
+	if (chan->type != IIO_VOLTAGE)
+		return -EOPNOTSUPP;
+
+	if (info != IIO_EV_INFO_VALUE)
+		return -EINVAL;
+
+	if (dir == IIO_EV_DIR_FALLING) {
+		err = regmap_read(chip->regmap16, NCT7201_REG_VIN_LOW_LIMIT(chan->address), &value);
+		if (err < 0)
+			return err;
+		volt = value;
+	} else {
+		err = regmap_read(chip->regmap16, NCT7201_REG_VIN_HIGH_LIMIT(chan->address), &value);
+		if (err < 0)
+			return err;
+		volt = value;
+	}
+
+	*val = volt >> 3;
+
+	return IIO_VAL_INT;
+}
+
+static int nct7201_write_event_value(struct iio_dev *indio_dev,
+				     const struct iio_chan_spec *chan,
+				     enum iio_event_type type,
+				     enum iio_event_direction dir,
+				     enum iio_event_info info,
+				     int val, int val2)
+{
+	struct nct7201_chip_info *chip = iio_priv(indio_dev);
+	long v1, v2;
+
+	v1 = val >> 5;
+	v2 = FIELD_PREP(NCT7201_REG_VIN_LIMIT_LSB_MASK, val) << 3;
+
+	if (chan->type != IIO_VOLTAGE)
+		return -EOPNOTSUPP;
+
+	if (info == IIO_EV_INFO_VALUE) {
+		guard(mutex)(&chip->access_lock);
+		if (dir == IIO_EV_DIR_FALLING) {
+			regmap_write(chip->regmap, NCT7201_REG_VIN_LOW_LIMIT(chan->address), v1);
+			regmap_write(chip->regmap, NCT7201_REG_VIN_LOW_LIMIT_LSB(chan->address), v2);
+		} else {
+			regmap_write(chip->regmap, NCT7201_REG_VIN_HIGH_LIMIT(chan->address), v1);
+			regmap_write(chip->regmap, NCT7201_REG_VIN_HIGH_LIMIT_LSB(chan->address), v2);
+		}
+	}
+
+	return 0;
+}
+
+static int nct7201_read_event_config(struct iio_dev *indio_dev,
+				     const struct iio_chan_spec *chan,
+				     enum iio_event_type type,
+				     enum iio_event_direction dir)
+{
+	struct nct7201_chip_info *chip = iio_priv(indio_dev);
+
+	if (chan->type != IIO_VOLTAGE)
+		return -EOPNOTSUPP;
+
+	return !!(chip->vin_mask & BIT(chan->address));
+}
+
+static int nct7201_write_event_config(struct iio_dev *indio_dev,
+				      const struct iio_chan_spec *chan,
+				      enum iio_event_type type,
+				      enum iio_event_direction dir,
+				      bool state)
+{
+	struct nct7201_chip_info *chip = iio_priv(indio_dev);
+	unsigned int mask;
+
+	if (chan->type != IIO_VOLTAGE)
+		return -EOPNOTSUPP;
+
+	mask = BIT(chan->address);
+
+	if (!state && (chip->vin_mask & mask))
+		chip->vin_mask &= ~mask;
+	else if (state && !(chip->vin_mask & mask))
+		chip->vin_mask |= mask;
+
+	guard(mutex)(&chip->access_lock);
+	regmap_write(chip->regmap, NCT7201_REG_CHANNEL_ENABLE_1,
+		     chip->vin_mask & NCT7201_REG_CHANNEL_ENABLE_1_MASK);
+	if (chip->num_vin_channels == 12)
+		regmap_write(chip->regmap, NCT7201_REG_CHANNEL_ENABLE_2,
+			     chip->vin_mask & NCT7201_REG_CHANNEL_ENABLE_2_MASK);
+
+	return 0;
+}
+
+static const struct iio_info nct7201_info = {
+	.read_raw = nct7201_read_raw,
+	.read_event_config = nct7201_read_event_config,
+	.write_event_config = nct7201_write_event_config,
+	.read_event_value = nct7201_read_event_value,
+	.write_event_value = nct7201_write_event_value,
+};
+
+static const struct iio_info nct7201_info_no_irq = {
+	.read_raw = nct7201_read_raw,
+};
+
+static const struct nct7201_adc_model_data nct7201_model_data = {
+	.model_name = "nct7201",
+	.channels = nct7201_channels,
+	.num_channels = ARRAY_SIZE(nct7201_channels),
+	.num_vin_channels = 8,
+};
+
+static const struct nct7201_adc_model_data nct7202_model_data = {
+	.model_name = "nct7202",
+	.channels = nct7202_channels,
+	.num_channels = ARRAY_SIZE(nct7202_channels),
+	.num_vin_channels = 12,
+};
+
+static int nct7201_init_chip(struct nct7201_chip_info *chip)
+{
+	u8 data[2];
+	unsigned int value;
+	int err;
+
+	regmap_write(chip->regmap, NCT7201_REG_CONFIGURATION,
+		     NCT7201_BIT_CONFIGURATION_RESET);
+
+	/*
+	 * After about 25 msecs, the device should be ready and then
+	 * the Power Up bit will be set to 1. If not, wait for it.
+	 */
+	mdelay(25);
+	err = regmap_read(chip->regmap, NCT7201_REG_BUSY_STATUS, &value);
+	if (err < 0)
+		return err;
+	if (!(value & NCT7201_BIT_PWR_UP))
+		return dev_err_probe(&chip->client->dev, -EIO, "failed to power up after reset\n");
+
+	/* Enable Channel */
+	guard(mutex)(&chip->access_lock);
+	regmap_write(chip->regmap, NCT7201_REG_CHANNEL_ENABLE_1,
+		     NCT7201_REG_CHANNEL_ENABLE_1_MASK);
+	if (chip->num_vin_channels == 12)
+		regmap_write(chip->regmap, NCT7201_REG_CHANNEL_ENABLE_2,
+			     NCT7201_REG_CHANNEL_ENABLE_2_MASK);
+
+	err = regmap_read(chip->regmap, NCT7201_REG_CHANNEL_ENABLE_1, &value);
+	if (err < 0)
+		return err;
+	data[0] = value;
+
+	err = regmap_read(chip->regmap, NCT7201_REG_CHANNEL_ENABLE_2, &value);
+	if (err < 0)
+		return err;
+	data[1] = value;
+
+	value = get_unaligned_le16(data);
+	chip->vin_mask = value;
+
+	/* Start monitoring if needed */
+	err = regmap_read(chip->regmap, NCT7201_REG_CONFIGURATION, &value);
+	if (err < 0) {
+		dev_err_probe(&chip->client->dev, -EIO, "Failed to read REG_CONFIGURATION\n");
+		return value;
+	}
+
+	value |= NCT7201_BIT_CONFIGURATION_START;
+	regmap_write(chip->regmap, NCT7201_REG_CONFIGURATION, value);
+
+	return 0;
+}
+
+static const struct regmap_config nct7201_regmap8_config = {
+	.name = "vin-data-read-byte",
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = 0xff,
+};
+
+static const struct regmap_config nct7201_regmap16_config = {
+	.name = "vin-data-read-word",
+	.reg_bits = 8,
+	.val_bits = 16,
+	.max_register = 0xff,
+};
+
+static int nct7201_probe(struct i2c_client *client)
+{
+	const struct nct7201_adc_model_data *model_data;
+	struct nct7201_chip_info *chip;
+	struct iio_dev *indio_dev;
+	int ret;
+
+	model_data = i2c_get_match_data(client);
+	if (!model_data)
+		return -EINVAL;
+
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*chip));
+	if (!indio_dev)
+		return -ENOMEM;
+	chip = iio_priv(indio_dev);
+
+	chip->regmap = devm_regmap_init_i2c(client, &nct7201_regmap8_config);
+	if (IS_ERR(chip->regmap))
+		return dev_err_probe(&client->dev, PTR_ERR(chip->regmap),
+			"Failed to init regmap\n");
+
+	chip->regmap16 = devm_regmap_init_i2c(client, &nct7201_regmap16_config);
+	if (IS_ERR(chip->regmap16))
+		return dev_err_probe(&client->dev, PTR_ERR(chip->regmap16),
+			"Failed to init regmap16\n");
+
+	chip->num_vin_channels = model_data->num_vin_channels;
+
+	ret = devm_mutex_init(&client->dev, &chip->access_lock);
+	if (ret)
+		return ret;
+
+	chip->client = client;
+
+	ret = nct7201_init_chip(chip);
+	if (ret < 0)
+		return ret;
+
+	indio_dev->name = model_data->model_name;
+	indio_dev->channels = model_data->channels;
+	indio_dev->num_channels = model_data->num_channels;
+	if (client->irq)
+		indio_dev->info = &nct7201_info;
+	else
+		indio_dev->info = &nct7201_info_no_irq;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	return devm_iio_device_register(&client->dev, indio_dev);
+}
+
+static const struct i2c_device_id nct7201_id[] = {
+	{ .name = "nct7201", .driver_data = (kernel_ulong_t)&nct7201_model_data },
+	{ .name = "nct7202", .driver_data = (kernel_ulong_t)&nct7202_model_data },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, nct7201_id);
+
+static const struct of_device_id nct7201_of_match[] = {
+	{
+		.compatible = "nuvoton,nct7201",
+		.data = &nct7201_model_data,
+	},
+	{
+		.compatible = "nuvoton,nct7202",
+		.data = &nct7202_model_data,
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, nct7201_of_match);
+
+static struct i2c_driver nct7201_driver = {
+	.driver = {
+		.name	= "nct7201",
+		.of_match_table = nct7201_of_match,
+	},
+	.probe = nct7201_probe,
+	.id_table = nct7201_id,
+};
+module_i2c_driver(nct7201_driver);
+
+MODULE_AUTHOR("Eason Yang <j2anfernee@gmail.com>");
+MODULE_DESCRIPTION("Nuvoton NCT7201 voltage monitor driver");
+MODULE_LICENSE("GPL");
-- 
2.34.1


