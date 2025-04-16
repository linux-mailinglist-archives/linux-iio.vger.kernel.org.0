Return-Path: <linux-iio+bounces-18161-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7FF5A8B348
	for <lists+linux-iio@lfdr.de>; Wed, 16 Apr 2025 10:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B93941905EC8
	for <lists+linux-iio@lfdr.de>; Wed, 16 Apr 2025 08:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B94231CA5;
	Wed, 16 Apr 2025 08:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W0NNY8nd"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7EA235C1E;
	Wed, 16 Apr 2025 08:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744791480; cv=none; b=on0psYYtXfNS6dCi+qDK6F+C6QT/Xo+E7xLEAa97YDphUFOKugno0RGRc5YOUFFK0D14u+jC06OCH7dWnUHGBxeRqwJBT535+jXSWlnueOEUM6D312wN6gXvWlpSIP5RbriKxnoxZpQ+jf33bETbUpZWforvy2/fxujuQf79Auc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744791480; c=relaxed/simple;
	bh=Shp7cyzS9e3mJoMpxxvhyNuT8kM9XTqOje+X3zjbiDQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BW4UZ+YlbSSTASu6ZmvpvL1nE5Jc3vkwlPJuZcBjGemgWoKxNBIO0n7vacygGtRaE75OQMpz35vDdunk8SRqWYnMcNnmEKD1bWUuO/jWuaSNyup6No/QYjGIBQ/V0MKzmBfMqsAmce4swlbv8ZfuoR6apGIQvXlVN6yf8uUzUCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W0NNY8nd; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-22c33e5013aso4438605ad.0;
        Wed, 16 Apr 2025 01:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744791477; x=1745396277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=azWk2svO/ZP0MJCaop58tNeXPirHI6uJ7eNOxtrqnro=;
        b=W0NNY8ndm5DRZjYOn0uEDu8mX5SGUGBtGBdyUR3M1zp2OLawK2wreypUi7Vjss0Jtp
         pwuSMZJAIFTC4sYq62sw/j01kjCYMrBsN1ssVzZ16mwPXX7PmuLwlstABmCn5fqyloNz
         3Pa0mvBE1ras9mt57MPKVcaZ2u3ZNHNKegoG5jeAQvjhkruq1MqoH0bNc1PjwbhUYYg3
         iCkghqDgJWOycm9nuJBDatFCaDMjQU4wudHCLZobbrgxc6FgLcjde2DIdARz2AkDIkS6
         S930UCMjFAFVnzyeAMAn//ChfRxXeVYLXAOOEoPjGRAEPavymSxNgILEbOWl1v84kxqY
         m4Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744791477; x=1745396277;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=azWk2svO/ZP0MJCaop58tNeXPirHI6uJ7eNOxtrqnro=;
        b=vVfkBYa+GrZsE3Hxfnn5YZ+A84CP/f6k9mSYNx3MdoICA8ejL6AT+Koa8EFNO/dF24
         5d/+kvEIG8Xbe+cLVqPqQhRIkjX2U44XDMBrIlGz5cJlbQPDi8LgFJZoY3e3ZT15OcCj
         xj1yZcf0ZpGPnXK3PTMjBT8j/rRAG0EDmtAtZVNSVmcI7Ae1vCgWv+7R0x3xL9Dyt/Zi
         OTGOMQBFmIZRt3slxVrG4ulA6p5lczKIt69HBGbQKblkTYRhI96T7fSgxj7ue87VJ6db
         7Tl5Fbyqsh9Xn1tqwO3/mURvfnvPO4HhLZyK4RdSoYRU/VTrOrsuV1tbcdqFyW8nfGpf
         6QUA==
X-Forwarded-Encrypted: i=1; AJvYcCUNp31wsXjJU6fuBefk4HWikDqKx4/TLZnX9HkuZfjbOcGzii89fQ7UKmz9VVQ5NwovQZNVwKoMgMt6vuGZ@vger.kernel.org, AJvYcCXafqFSKuSwMGgPBTa8BfUR6vHBiwR0Pu7UiXlXXaQ6SQ8MtHxHuxBsT8fjX2de5+mzCGRARo7ZNsN5@vger.kernel.org
X-Gm-Message-State: AOJu0YxlG7vsVNDIczlUlb+s207NrC1nHRhV1xpB/FZn1KM4alwSfqkt
	P9avLosNp5gJbIU3OitGlVZdR3pTQSPf8HlSbe/Uu0IXA9ubZ5zE
X-Gm-Gg: ASbGnctNTymsZ2qciHJB2hButZLY3j/oUL817Ck8bXbrk+E5eIla8e14Su29Nb74rkW
	4N/xN5XJeppxFrVssWHjXV43E3K7h52IGKG/5gmaGcblZfSLgmVvlaupeyzMHG2uG4QToDGQTqf
	urWUV0SsifZVU2F9mg12ADSvK7EvLouUv/F23lbqlL9ZqRoXp8zIERrVQ8VJw+7X4IrAouqzWiy
	KOQTBHWkBRTVa/Y1R7CxpTzWOwN/w/kqo0ic4fOGieHlor0aLwAxuNkBCsovrbLms1WymHNador
	zye5r4xG6Wd/RYY518xnR2r4vXbTxNtcW7Vs/fyGRNJeaEKV9ktA2LPfwgArm38QJ/aZxXYXJ1r
	8LBZ5UYY=
X-Google-Smtp-Source: AGHT+IFLJSML7xlHZdMY97remwdra5mFv/CAP/vCzfQTe2ZFxCvL/FSwGcxB1VRJLshDAFGozjiJkg==
X-Received: by 2002:a17:903:238a:b0:224:6ee:ad with SMTP id d9443c01a7336-22c35983a95mr19013555ad.44.1744791477247;
        Wed, 16 Apr 2025 01:17:57 -0700 (PDT)
Received: from openbmc.. (211-23-34-211.hinet-ip.hinet.net. [211.23.34.211])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c33faac6fsm8190925ad.124.2025.04.16.01.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 01:17:56 -0700 (PDT)
From: Eason Yang <j2anfernee@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	javier.carrasco.cruz@gmail.com,
	gstols@baylibre.com,
	alisadariana@gmail.com,
	tgamblin@baylibre.com,
	olivier.moysan@foss.st.com,
	antoniu.miclaus@analog.com,
	eblanc@baylibre.com,
	andriy.shevchenko@linux.intel.com,
	joao.goncalves@toradex.com,
	tobias.sperling@softing.com,
	marcelo.schmitt@analog.com,
	angelogioacchino.delregno@collabora.com,
	thomas.bonnefille@bootlin.com,
	herve.codina@bootlin.com,
	chanh@os.amperecomputing.com,
	KWLIU@nuvoton.com,
	yhyang2@nuvoton.com
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eason Yang <j2anfernee@gmail.com>
Subject: [PATCH v6 2/2] iio: adc: add support for Nuvoton NCT7201
Date: Wed, 16 Apr 2025 16:17:34 +0800
Message-Id: <20250416081734.563111-3-j2anfernee@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250416081734.563111-1-j2anfernee@gmail.com>
References: <20250416081734.563111-1-j2anfernee@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Nuvoton NCT7201/NCT7202 system voltage monitor 12-bit ADC driver

NCT7201/NCT7202 supports up to 12 analog voltage monitor inputs and up
to 4 SMBus addresses by ADDR pin. Meanwhile, ALERT# hardware event pins
for independent alarm signals, and all the threshold values could be set
for system protection without any timing delay. It also supports reset
input RSTIN# to recover system from a fault condition.

Currently, only single-edge mode conversion and threshold events are
supported.

Signed-off-by: Eason Yang <j2anfernee@gmail.com>
---
 MAINTAINERS               |   1 +
 drivers/iio/adc/Kconfig   |  11 +
 drivers/iio/adc/Makefile  |   1 +
 drivers/iio/adc/nct7201.c | 471 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 484 insertions(+)
 create mode 100644 drivers/iio/adc/nct7201.c

diff --git a/MAINTAINERS b/MAINTAINERS
index cc0dd650c447..ae242fb15ef5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17309,6 +17309,7 @@ M:	Eason Yang <j2anfernee@gmail.com>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/iio/adc/nuvoton,nct7201.yaml
+F:	drivers/iio/adc/nct7201.c
 
 NVIDIA (rivafb and nvidiafb) FRAMEBUFFER DRIVER
 M:	Antonino Daplas <adaplas@gmail.com>
diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 6529df1a498c..6d6af1b51b5e 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1092,6 +1092,17 @@ config NAU7802
 	  To compile this driver as a module, choose M here: the
 	  module will be called nau7802.
 
+config NCT7201
+	tristate "Nuvoton Instruments NCT7201 and NCT7202 Power Monitor"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  If you say yes here you get support for the Nuvoton NCT7201 and
+	  NCT7202 Voltage Monitor.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called nct7201.
+
 config NPCM_ADC
 	tristate "Nuvoton NPCM ADC driver"
 	depends on ARCH_NPCM || COMPILE_TEST
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 3e918c3eec69..54e8a7541af6 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -97,6 +97,7 @@ obj-$(CONFIG_MESON_SARADC) += meson_saradc.o
 obj-$(CONFIG_MP2629_ADC) += mp2629_adc.o
 obj-$(CONFIG_MXS_LRADC_ADC) += mxs-lradc-adc.o
 obj-$(CONFIG_NAU7802) += nau7802.o
+obj-$(CONFIG_NCT7201) += nct7201.o
 obj-$(CONFIG_NPCM_ADC) += npcm_adc.o
 obj-$(CONFIG_PAC1921) += pac1921.o
 obj-$(CONFIG_PAC1934) += pac1934.o
diff --git a/drivers/iio/adc/nct7201.c b/drivers/iio/adc/nct7201.c
new file mode 100644
index 000000000000..e9217a664ee0
--- /dev/null
+++ b/drivers/iio/adc/nct7201.c
@@ -0,0 +1,471 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Driver for Nuvoton nct7201 and nct7202 power monitor chips.
+ *
+ * Copyright (c) 2024-2025 Nuvoton Technology corporation.
+ */
+
+#include <linux/array_size.h>
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/types.h>
+#include <linux/unaligned.h>
+
+#include <linux/iio/events.h>
+#include <linux/iio/iio.h>
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
+#define  NCT7201_REG_CHANNEL_ENABLE_MASK		GENMASK(11, 0)
+#define NCT7201_REG_INTERRUPT_MASK_1			0x15
+#define NCT7201_REG_INTERRUPT_MASK_2			0x16
+#define NCT7201_REG_BUSY_STATUS			0x1E
+#define  NCT7201_BIT_BUSY				BIT(0)
+#define  NCT7201_BIT_PWR_UP				BIT(1)
+#define NCT7201_REG_ONE_SHOT				0x1F
+#define NCT7201_REG_SMUS_ADDRESS			0xFC
+#define NCT7201_REG_VIN_MASK				GENMASK(15, 3)
+
+#define NCT7201_REG_VIN(i)				(i)
+#define NCT7201_REG_VIN_HIGH_LIMIT(i)			(0x20 + (i) * 2)
+#define NCT7201_REG_VIN_LOW_LIMIT(i)			(0x21 + (i) * 2)
+#define NCT7201_MAX_CHANNEL				12
+
+static const struct regmap_range nct7201_read_reg_range[] = {
+	regmap_reg_range(NCT7201_REG_INTERRUPT_STATUS_1, NCT7201_REG_BUSY_STATUS),
+	regmap_reg_range(NCT7201_REG_SMUS_ADDRESS, NCT7201_REG_SMUS_ADDRESS),
+};
+
+static const struct regmap_access_table nct7201_readable_regs_tbl = {
+	.yes_ranges = nct7201_read_reg_range,
+	.n_yes_ranges = ARRAY_SIZE(nct7201_read_reg_range),
+};
+
+static const struct regmap_range nct7201_write_reg_range[] = {
+	regmap_reg_range(NCT7201_REG_CONFIGURATION, NCT7201_REG_INTERRUPT_MASK_2),
+	regmap_reg_range(NCT7201_REG_ONE_SHOT, NCT7201_REG_ONE_SHOT),
+};
+
+static const struct regmap_access_table nct7201_writeable_regs_tbl = {
+	.yes_ranges = nct7201_write_reg_range,
+	.n_yes_ranges = ARRAY_SIZE(nct7201_write_reg_range),
+};
+
+static const struct regmap_range nct7201_read_vin_reg_range[] = {
+	regmap_reg_range(NCT7201_REG_VIN(0), NCT7201_REG_VIN(NCT7201_MAX_CHANNEL - 1)),
+	regmap_reg_range(NCT7201_REG_VIN_HIGH_LIMIT(0),
+			 NCT7201_REG_VIN_LOW_LIMIT(NCT7201_MAX_CHANNEL - 1)),
+};
+
+static const struct regmap_access_table nct7201_readable_vin_regs_tbl = {
+	.yes_ranges = nct7201_read_vin_reg_range,
+	.n_yes_ranges = ARRAY_SIZE(nct7201_read_vin_reg_range),
+};
+
+static const struct regmap_range nct7201_write_vin_reg_range[] = {
+	regmap_reg_range(NCT7201_REG_VIN_HIGH_LIMIT(0),
+			 NCT7201_REG_VIN_LOW_LIMIT(NCT7201_MAX_CHANNEL - 1)),
+};
+
+static const struct regmap_access_table nct7201_writeable_vin_regs_tbl = {
+	.yes_ranges = nct7201_write_vin_reg_range,
+	.n_yes_ranges = ARRAY_SIZE(nct7201_write_vin_reg_range),
+};
+
+static const struct regmap_config nct7201_regmap8_config = {
+	.name = "vin-data-read-byte",
+	.reg_bits = 8,
+	.val_bits = 8,
+	.use_single_read = true,
+	.use_single_write = true,
+	.max_register = 0xff,
+	.rd_table = &nct7201_readable_regs_tbl,
+	.wr_table = &nct7201_writeable_regs_tbl,
+};
+
+static const struct regmap_config nct7201_regmap16_config = {
+	.name = "vin-data-read-word",
+	.reg_bits = 8,
+	.val_bits = 16,
+	.max_register = 0xff,
+	.rd_table = &nct7201_readable_vin_regs_tbl,
+	.wr_table = &nct7201_writeable_vin_regs_tbl,
+};
+
+struct nct7201_chip_info {
+	struct device *dev;
+	struct regmap *regmap;
+	struct regmap *regmap16;
+	int num_vin_channels;
+	u16 vin_mask;
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
+#define NCT7201_VOLTAGE_CHANNEL(num)					\
+	{								\
+		.type = IIO_VOLTAGE,					\
+		.indexed = 1,						\
+		.channel = (num + 1),					\
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
+		.address = num,						\
+		.event_spec = nct7201_events,				\
+		.num_event_specs = ARRAY_SIZE(nct7201_events),		\
+	}
+
+static const struct iio_chan_spec nct7201_channels[] = {
+	NCT7201_VOLTAGE_CHANNEL(0),
+	NCT7201_VOLTAGE_CHANNEL(1),
+	NCT7201_VOLTAGE_CHANNEL(2),
+	NCT7201_VOLTAGE_CHANNEL(3),
+	NCT7201_VOLTAGE_CHANNEL(4),
+	NCT7201_VOLTAGE_CHANNEL(5),
+	NCT7201_VOLTAGE_CHANNEL(6),
+	NCT7201_VOLTAGE_CHANNEL(7),
+};
+
+static const struct iio_chan_spec nct7202_channels[] = {
+	NCT7201_VOLTAGE_CHANNEL(0),
+	NCT7201_VOLTAGE_CHANNEL(1),
+	NCT7201_VOLTAGE_CHANNEL(2),
+	NCT7201_VOLTAGE_CHANNEL(3),
+	NCT7201_VOLTAGE_CHANNEL(4),
+	NCT7201_VOLTAGE_CHANNEL(5),
+	NCT7201_VOLTAGE_CHANNEL(6),
+	NCT7201_VOLTAGE_CHANNEL(7),
+	NCT7201_VOLTAGE_CHANNEL(8),
+	NCT7201_VOLTAGE_CHANNEL(9),
+	NCT7201_VOLTAGE_CHANNEL(10),
+	NCT7201_VOLTAGE_CHANNEL(11),
+};
+
+static int nct7201_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int *val, int *val2, long mask)
+{
+	struct nct7201_chip_info *chip = iio_priv(indio_dev);
+	unsigned int value;
+	int err;
+
+	if (chan->type != IIO_VOLTAGE)
+		return -EOPNOTSUPP;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		err = regmap_read(chip->regmap16, NCT7201_REG_VIN(chan->address), &value);
+		if (err)
+			return err;
+		*val = FIELD_GET(NCT7201_REG_VIN_MASK, value);
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
+	unsigned int value;
+	int err;
+
+	if (chan->type != IIO_VOLTAGE)
+		return -EOPNOTSUPP;
+
+	if (info != IIO_EV_INFO_VALUE)
+		return -EINVAL;
+
+	if (dir == IIO_EV_DIR_FALLING)
+		err = regmap_read(chip->regmap16, NCT7201_REG_VIN_LOW_LIMIT(chan->address),
+				  &value);
+	else
+		err = regmap_read(chip->regmap16, NCT7201_REG_VIN_HIGH_LIMIT(chan->address),
+				  &value);
+	if (err)
+		return err;
+
+	*val = FIELD_GET(NCT7201_REG_VIN_MASK, value);
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
+	int  err;
+
+	if (chan->type != IIO_VOLTAGE)
+		return -EOPNOTSUPP;
+
+	if (info != IIO_EV_INFO_VALUE)
+		return -EOPNOTSUPP;
+
+	if (dir == IIO_EV_DIR_FALLING)
+		err = regmap_write(chip->regmap16, NCT7201_REG_VIN_LOW_LIMIT(chan->address),
+				   FIELD_PREP(NCT7201_REG_VIN_MASK, val));
+	else
+		err = regmap_write(chip->regmap16, NCT7201_REG_VIN_HIGH_LIMIT(chan->address),
+				   FIELD_PREP(NCT7201_REG_VIN_MASK, val));
+	if (err)
+		return err;
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
+	int err;
+
+	if (chan->type != IIO_VOLTAGE)
+		return -EOPNOTSUPP;
+
+	mask = BIT(chan->address);
+
+	if (state)
+		chip->vin_mask |= mask;
+	else
+		chip->vin_mask &= ~mask;
+
+	if (chip->num_vin_channels <= 8)
+		err = regmap_write(chip->regmap, NCT7201_REG_CHANNEL_ENABLE_1,
+				   chip->vin_mask);
+	else
+		err = regmap_bulk_write(chip->regmap, NCT7201_REG_CHANNEL_ENABLE_1,
+					&chip->vin_mask, sizeof(chip->vin_mask));
+	if (err)
+		return err;
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
+	struct device *dev = chip->dev;
+	__le16 data = cpu_to_le16(NCT7201_REG_CHANNEL_ENABLE_MASK);
+	unsigned int value;
+	int err;
+
+	err = regmap_write(chip->regmap, NCT7201_REG_CONFIGURATION,
+			   NCT7201_BIT_CONFIGURATION_RESET);
+	if (err)
+		return dev_err_probe(dev, err, "Failed to reset chip\n");
+
+	/*
+	 * After about 25 msecs, the device should be ready and then the Power
+	 * Up bit will be set to 1. If not, wait for it.
+	 */
+	fsleep(25000);
+	err = regmap_read(chip->regmap, NCT7201_REG_BUSY_STATUS, &value);
+	if (err)
+		return dev_err_probe(dev, err, "Failed to read busy status\n");
+	if (!(value & NCT7201_BIT_PWR_UP))
+		return dev_err_probe(dev, -EIO, "Failed to power up after reset\n");
+
+	/* Enable Channel */
+	if (chip->num_vin_channels <= 8)
+		err = regmap_write(chip->regmap, NCT7201_REG_CHANNEL_ENABLE_1,
+				   NCT7201_REG_CHANNEL_ENABLE_MASK);
+	else
+		err = regmap_bulk_write(chip->regmap, NCT7201_REG_CHANNEL_ENABLE_1,
+					&data, sizeof(data));
+	if (err)
+		return dev_err_probe(dev, err, "Failed to enable channel\n");
+
+	err = regmap_bulk_read(chip->regmap, NCT7201_REG_CHANNEL_ENABLE_1,
+			       &chip->vin_mask, sizeof(chip->vin_mask));
+	if (err)
+		return dev_err_probe(dev, err,
+				     "Failed to read channel enable register\n");
+
+	/* Start monitoring if needed */
+	err = regmap_set_bits(chip->regmap, NCT7201_REG_CONFIGURATION,
+			      NCT7201_BIT_CONFIGURATION_START);
+	if (err)
+		return dev_err_probe(dev, err, "Failed to start monitoring\n");
+
+	return 0;
+}
+
+static int nct7201_probe(struct i2c_client *client)
+{
+	const struct nct7201_adc_model_data *model_data;
+	struct device *dev = &client->dev;
+	struct nct7201_chip_info *chip;
+	struct iio_dev *indio_dev;
+	int ret;
+
+	model_data = i2c_get_match_data(client);
+	if (!model_data)
+		return -ENODEV;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*chip));
+	if (!indio_dev)
+		return -ENOMEM;
+	chip = iio_priv(indio_dev);
+
+	chip->regmap = devm_regmap_init_i2c(client, &nct7201_regmap8_config);
+	if (IS_ERR(chip->regmap))
+		return dev_err_probe(dev, PTR_ERR(chip->regmap),
+				     "Failed to init regmap\n");
+
+	chip->regmap16 = devm_regmap_init_i2c(client, &nct7201_regmap16_config);
+	if (IS_ERR(chip->regmap16))
+		return dev_err_probe(dev, PTR_ERR(chip->regmap16),
+				     "Failed to init regmap16\n");
+
+	chip->num_vin_channels = model_data->num_vin_channels;
+
+	chip->dev = dev;
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
+	return devm_iio_device_register(dev, indio_dev);
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


