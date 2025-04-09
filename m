Return-Path: <linux-iio+bounces-17843-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56AC7A81A78
	for <lists+linux-iio@lfdr.de>; Wed,  9 Apr 2025 03:24:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4F2546658F
	for <lists+linux-iio@lfdr.de>; Wed,  9 Apr 2025 01:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E8ED1632DD;
	Wed,  9 Apr 2025 01:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GUQgSVy4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5262414AD2D;
	Wed,  9 Apr 2025 01:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744161861; cv=none; b=UaIW25SYzsP702MRbqFGdDSDzwM9Rayl9LIOR8VZIHcmHoHEO1Gw0ilIipPtLWOodgYsgjbEkpBR9UwsgahHdqPo+tmgOzLbRSk9FHarUnRa5oszbCF5ZjeyV9QNb7jV4fupHH/E8R9hUpHMjnIiY32IcOM+Bz3v9oVBOBXzHwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744161861; c=relaxed/simple;
	bh=VU/quLKgdk+z52sxwo1kjQ1i+ICk1g+kje1QBmkr7HU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LbpxMXmHKu1e4yASMoI6qBHzzNWaxOiwW7RTSsBGsq0Casd3t/F2cGQkBEVY85sJ90jeb/ceSrKqcSWj5Yr6FHmPNDoNcpg3qW8Wq1H9kMOnNADPqxe4AoJAF/cV1COlTlak4CWLDaqsAlXPkPwre8zxmcUAUzUxS2Rydi/s0dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GUQgSVy4; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-227b828de00so61812575ad.1;
        Tue, 08 Apr 2025 18:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744161857; x=1744766657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tmcAVaTGDZFtij58Uwvl0TlQiGaP8kxOkFjKSkhDj54=;
        b=GUQgSVy4rDWu+dkkoWid604/q3rp+E+jxSSg3xPdp62IOSNBpCS9wzZeChAGi1EGFH
         zQrDXKZVVDxwMa/ywZ7nGJCird7XG7rOrE7/dY3pgGQpZ4xMxPCTGzeZWB3jV0PnOwrB
         3QnT2aM3nOx2BMDOP5SeqRp5EqDegqVNaHuKoLVGRyl4p9nqdMD8STfOfp92WrrtoN6K
         2k6/CezfEcLQ44n/iZoQd6okGpsJ1SWx3wObtulNWsmT90gwG36ycK1ELqHY8U3Sa55n
         ZHF36+W4CZXDrdfDmRVyEUpeFa+yOBypIHoJ/5VtbiCaF5xPKkSVKbpbnbZw644MdYnE
         iEoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744161857; x=1744766657;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tmcAVaTGDZFtij58Uwvl0TlQiGaP8kxOkFjKSkhDj54=;
        b=ikT9ixuW4JiK4+6BliRV5T2lIJ0R9TsOGD5kLRsn2ADLzzu7QfnSapbR3aYCLDLefF
         zp774YEx1BJDCV0eqjFut5xr5KrvHj1xpWoP/aiilLYT+9On3704oLiXJ9Yrtq943j23
         Q5GUhsF1U4UAjV6MNjtvZu2y7/sSL7OCrtH4RY3y+cuoqj5cOuNO9vKdz0dSXSlqevi0
         vifFn+39fGtD+yQaHySf8dEFGtFsFdyL7IMVAfiOLOHpzG48AYthZTpqYnb1mc0n0xRy
         Og10reg3r7L3Y6BFITwvXgHovrOTd2QdTeoT0wYFGDNxQRyZeWyhzGN+DDVI12GFBtcl
         9KRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaA7qXiOsiMF/tuD0yFuOrARzn7mdAXjM2j9uScM+QmnuEOo2l9V+TKMIYp9hHd+YEWf08d/7kUyxx@vger.kernel.org, AJvYcCWA/acfT0iNZQf+ylPenZGMaGVEhQS4QiOCvp+JY3arV+jKSNE7XFIMJ6iTEjK4x35i2/xn9k+zXkriVqWf@vger.kernel.org
X-Gm-Message-State: AOJu0YzN6XOuAn2AVQCY17SAt49HF8BQlyAfzhRg3qm6sWV8FqOfLLck
	F1UTDke8cQa0QRgGFu+Fy8uzosdZ9JYhNQhC9gKMvD93li37SvPN
X-Gm-Gg: ASbGncvG64DWPk6AfGdoB6Mqf3wAoiNbblkd09FjL0G+IQCWqv5laOjHK/6f5e73VxT
	L56CquAcJQemEPMomjwq4xpaEBE6peYMmTupz3ocgl52MqkVj7gsNAX/UeDFb/UtP5QHTkDz1YY
	aWO7LL+vkNkUO2r/OEPvsa+zluNfxXqp4aMpTzHlHDsQwgWNuti7JWIsdQLFNeCUPvO4KTs3W2g
	qzhYGl9SoMCZWeuddzndwmRJ8In5jZcXMGPAcHXCqoILXlXfZAExvP2vzBiXieFmAgj8beVbsnY
	U6v1Y5HtJPY/3i962o2x3a3uJWnetMVrhz/XTyor0QKqkfwRIKqce1v12m0xCWEnA2x70q+l/IQ
	T
X-Google-Smtp-Source: AGHT+IF93fFwXOOjGS5BCCnriRkuPA585JbtZQN7zLxbBdZpn+Nl6koFxsrVkj4rgXTrniH1+jGCZA==
X-Received: by 2002:a17:902:cecb:b0:220:c813:dfce with SMTP id d9443c01a7336-22ac2a1de96mr15335325ad.39.1744161857252;
        Tue, 08 Apr 2025 18:24:17 -0700 (PDT)
Received: from openbmc.. (211-23-34-211.hinet-ip.hinet.net. [211.23.34.211])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7b6288asm20865ad.9.2025.04.08.18.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 18:24:16 -0700 (PDT)
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
	tgamblin@baylibre.com,
	alisadariana@gmail.com,
	antoniu.miclaus@analog.com,
	eblanc@baylibre.com,
	andriy.shevchenko@linux.intel.com,
	jstephan@baylibre.com,
	matteomartelli3@gmail.com,
	angelogioacchino.delregno@collabora.com,
	herve.codina@bootlin.com,
	marcelo.schmitt@analog.com,
	chanh@os.amperecomputing.com,
	KWLIU@nuvoton.com,
	yhyang2@nuvoton.com
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eason Yang <j2anfernee@gmail.com>
Subject: [PATCH v5 2/2] iio: adc: add support for Nuvoton NCT7201
Date: Wed,  9 Apr 2025 09:23:51 +0800
Message-Id: <20250409012351.2543450-3-j2anfernee@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250409012351.2543450-1-j2anfernee@gmail.com>
References: <20250409012351.2543450-1-j2anfernee@gmail.com>
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
independent alarm signals, and all the threshold values could be set for
system protection without any timing delay. It also supports reset input
RSTIN# to recover system from a fault condition.

Currently, only single-edge mode conversion and threshold events are
supported.

Signed-off-by: Eason Yang <j2anfernee@gmail.com>
---
 MAINTAINERS               |   1 +
 drivers/iio/adc/Kconfig   |  11 +
 drivers/iio/adc/Makefile  |   1 +
 drivers/iio/adc/nct7201.c | 488 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 501 insertions(+)
 create mode 100644 drivers/iio/adc/nct7201.c

diff --git a/MAINTAINERS b/MAINTAINERS
index f9ec68d4d8b4..d155780e5ee0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17307,6 +17307,7 @@ M:	Eason Yang <j2anfernee@gmail.com>
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
index 000000000000..fe1ac8a28ab6
--- /dev/null
+++ b/drivers/iio/adc/nct7201.c
@@ -0,0 +1,488 @@
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
+#define NCT7201_VIN_MAX				12
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
+	regmap_reg_range(NCT7201_REG_VIN(0), NCT7201_REG_VIN(NCT7201_VIN_MAX - 1)),
+	regmap_reg_range(NCT7201_REG_VIN_HIGH_LIMIT(0),
+			 NCT7201_REG_VIN_LOW_LIMIT(NCT7201_VIN_MAX - 1)),
+};
+
+static const struct regmap_access_table nct7201_readable_vin_regs_tbl = {
+	.yes_ranges = nct7201_read_vin_reg_range,
+	.n_yes_ranges = ARRAY_SIZE(nct7201_read_vin_reg_range),
+};
+
+static const struct regmap_range nct7201_write_vin_reg_range[] = {
+	regmap_reg_range(NCT7201_REG_VIN_HIGH_LIMIT(0),
+			 NCT7201_REG_VIN_LOW_LIMIT(NCT7201_VIN_MAX - 1)),
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
+	struct i2c_client *client;
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
+		if (err < 0)
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
+	if (dir == IIO_EV_DIR_FALLING) {
+		err = regmap_read(chip->regmap16, NCT7201_REG_VIN_LOW_LIMIT(chan->address),
+				  &value);
+		if (err < 0)
+			return err;
+	} else {
+		err = regmap_read(chip->regmap16, NCT7201_REG_VIN_HIGH_LIMIT(chan->address),
+				  &value);
+		if (err < 0)
+			return err;
+	}
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
+	int  err = 0;
+
+	if (chan->type != IIO_VOLTAGE)
+		return -EOPNOTSUPP;
+
+	if (info != IIO_EV_INFO_VALUE)
+		return -EOPNOTSUPP;
+
+	if (dir == IIO_EV_DIR_FALLING) {
+		err = regmap_write(chip->regmap16, NCT7201_REG_VIN_LOW_LIMIT(chan->address),
+				   FIELD_PREP(NCT7201_REG_VIN_MASK, val));
+		if (err < 0)
+			return err;
+	} else {
+		err = regmap_write(chip->regmap16, NCT7201_REG_VIN_HIGH_LIMIT(chan->address),
+				   FIELD_PREP(NCT7201_REG_VIN_MASK, val));
+		if (err < 0)
+			return err;
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
+	if (chip->num_vin_channels <= 8) {
+		err = regmap_write(chip->regmap, NCT7201_REG_CHANNEL_ENABLE_1,
+				   chip->vin_mask);
+		if (err < 0)
+			return err;
+	} else {
+		err = regmap_bulk_write(chip->regmap, NCT7201_REG_CHANNEL_ENABLE_1,
+					&chip->vin_mask, sizeof(chip->vin_mask));
+		if (err < 0)
+			return err;
+	}
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
+	u8 data[2] = {0};
+	unsigned int value;
+	int err;
+
+	err = regmap_write(chip->regmap, NCT7201_REG_CONFIGURATION,
+			   NCT7201_BIT_CONFIGURATION_RESET);
+	if (err < 0)
+		return dev_err_probe(&chip->client->dev, -EIO,
+				     "Failed to write NCT7201_REG_CONFIGURATION\n");
+
+	/*
+	 * After about 25 msecs, the device should be ready and then the Power
+	 * Up bit will be set to 1. If not, wait for it.
+	 */
+	mdelay(25);
+	err = regmap_read(chip->regmap, NCT7201_REG_BUSY_STATUS, &value);
+	if (err < 0)
+		return err;
+	if (!(value & NCT7201_BIT_PWR_UP))
+		return dev_err_probe(&chip->client->dev, -EIO,
+				     "Failed to power up after reset\n");
+
+	/* Enable Channel */
+	if (chip->num_vin_channels <= 8) {
+		data[0] = NCT7201_REG_CHANNEL_ENABLE_1_MASK;
+		err = regmap_write(chip->regmap, NCT7201_REG_CHANNEL_ENABLE_1, data[0]);
+		if (err < 0)
+			return dev_err_probe(&chip->client->dev, -EIO,
+					     "Failed to write NCT7201_REG_CHANNEL_ENABLE_1\n");
+	} else {
+		data[0] = NCT7201_REG_CHANNEL_ENABLE_1_MASK;
+		data[1] = NCT7201_REG_CHANNEL_ENABLE_2_MASK;
+		err = regmap_bulk_write(chip->regmap, NCT7201_REG_CHANNEL_ENABLE_1,
+					data, ARRAY_SIZE(data));
+		if (err < 0)
+			return dev_err_probe(&chip->client->dev, -EIO,
+					     "Failed to write NCT7201_REG_CHANNEL_ENABLE_1 and NCT7201_REG_CHANNEL_ENABLE_2\n");
+	}
+	chip->vin_mask = get_unaligned_le16(data);
+
+	/* Start monitoring if needed */
+	err = regmap_read(chip->regmap, NCT7201_REG_CONFIGURATION, &value);
+	if (err < 0)
+		return dev_err_probe(&chip->client->dev, -EIO,
+				     "Failed to read NCT7201_REG_CONFIGURATION\n");
+
+	regmap_set_bits(chip->regmap, NCT7201_REG_CONFIGURATION, NCT7201_BIT_CONFIGURATION_START);
+
+	return 0;
+}
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
+				     "Failed to init regmap\n");
+
+	chip->regmap16 = devm_regmap_init_i2c(client, &nct7201_regmap16_config);
+	if (IS_ERR(chip->regmap16))
+		return dev_err_probe(&client->dev, PTR_ERR(chip->regmap16),
+				     "Failed to init regmap16\n");
+
+	chip->num_vin_channels = model_data->num_vin_channels;
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


