Return-Path: <linux-iio+bounces-15908-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED3F2A3EFAC
	for <lists+linux-iio@lfdr.de>; Fri, 21 Feb 2025 10:11:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DC5817D730
	for <lists+linux-iio@lfdr.de>; Fri, 21 Feb 2025 09:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F22C202F70;
	Fri, 21 Feb 2025 09:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NpErbirM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33492010EE;
	Fri, 21 Feb 2025 09:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740129004; cv=none; b=W5tYxedhO6OngRAFFlwEUBUNLwVVjVf1JMHNA/c570eAofUGds2W9Q0yX8kLz/U6vZwL7BlN7ug+kGd3JfcdUj47Ngkh/dg/hnZfzj8xJz0zoK7a4NxKRAbaJ/2m41CLceV8smA9WVw/ZjtnUPuUdY7RF/Kl10uk3fRmtQl7md0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740129004; c=relaxed/simple;
	bh=krh2uJQXpaDv1rt5u8S/dcAG1E8TUCs3JQrCP/51wHQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JI9m28GfoR9zNYDq9bI/OcyyyarbKXUhppxLNVmalh4fK080wwhxjSe7W2ffqlmwJmV4AhgmTnChotDzFww7+gRdTqFdSliu58cTaGM+/pKUtlhNjO5Q/LnYFXGVZ4lTGhzJ7UXoFFRKxw1B9WakJJr4Q/rrFG6UydjXNZzzZ0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NpErbirM; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-220c8f38febso38874125ad.2;
        Fri, 21 Feb 2025 01:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740129002; x=1740733802; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rVeAVPSbgAXXOGUHlFrLczPyw8KEDImJKjcWWnUOdzY=;
        b=NpErbirM+4o3gEZxhVb1vtx61s25KbhG1GL6sjkfL5Z4Qp7lWU1DCzhglwvfJJIk9m
         5Pp2MSsU0EP2zFBZnJ9JVtBmSx2isKEVdBsfJFOd1faidkHITf/u/acMLOzSykK60/6O
         H9DGN20R/jvL7YXKaq0yEgomB5uNjaG8puUjhX8oA+SJTkFWy8A6CV4w/3sSNo15j/pP
         A+xPnAiuvr6kmbF3wbGF3F4Q43qgaOzJ2icWrt/XzDPfXHXpphdNYcI7sIhHgmdaX35u
         lRsVVXwCJUED04ZsarM4/PvR1CwtGYkwaYBvdnC0MPyk7ZFwPcy4f8co0pTHugSS/Rmq
         sT3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740129002; x=1740733802;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rVeAVPSbgAXXOGUHlFrLczPyw8KEDImJKjcWWnUOdzY=;
        b=sML+q1kxfrS0WBqXTolJ/+gaGf3HYAq62p1JUz+OPDLaGp9rlulRQr/10IWClk9Fwq
         JhZufIFJ5QGB5VqBBV2iuwf7XcuX6TzC1hCDQHpcIqcK3DLAhFDpTvbAqz+5beH8iGYP
         6Xx1IkEff0+JdbpU4PAuf/0r0b0idbY0oMaf35quOP78cR5bsCw2N4noJk8gh9W6gQSZ
         IyX+TF6BukIPG2hx2B7SfpZi1Qkv8f8PKZy9cHt2/l5stcaXXQEqEOUP0dHQ78MVGBuL
         CZiLarWSTX+XZzp57ZAm6kktZamWI20OF9eTBpX9IIoUY3pQ49mEbRNbLupGkYo4fC+w
         ZmQA==
X-Forwarded-Encrypted: i=1; AJvYcCUCIMXbCF/jlyd5tVwqPoE7CxyGAfuWr8w4MUpIb/rIphy57124imIrfwcogf4ebpchjs5t8fmcl6O1@vger.kernel.org, AJvYcCV1VlQ7ARLspvC5MRLww3YJMXtK6tnAZsUstCItDGZij4fwmvJKuDVeRZ6MZJN594d/m+xeU6+AziV26OV5@vger.kernel.org, AJvYcCX8cSV7l3UWoy7p/ejRBwmt0C9sVw2ZRuhzfDaPRvBJI34ZRVWRCrVaaVLiONNMcgisQRq1XeW7SY7Z@vger.kernel.org
X-Gm-Message-State: AOJu0YygV5pQ5U/FXtmL1ki2m1SaSI9tsfA9dOENPyMC9UgV78FVcY8Z
	yORa4RF14k+0PkHgpGPqCZ1l5bjAOjojrMdKDZchF3LxK5rraCAB
X-Gm-Gg: ASbGnctjk7NmG2X8K1bZO4C2monrqbw/EjXp3lZp1miIlDfPZnokCyjV/qLeLYp0XOj
	MC89acrrM8lt0BsLrhs7VPAmDsB83ZaEUtZciA4Vj/3JfYjhFWc3U+7270WTuzNF6Y9KZYdVWqb
	4HG3E+a6kV2tBdutk6rWAYQIwqAfmQPwOCdxw98Nz+tLptvGTUk+LNQ9Zo1VTETC8xYV13lZC+h
	TeCnYKp/F66ReWQNdPaV/m65I1+8wGrOW3+BzukBw/43PCsJWINOAORhjWqwQjQhk5ivetELBs5
	a4hawsSXhH/LWKolWoq20GdiQA8shrNJ87upNkLW62Ryi32rxVO+BhYXgg==
X-Google-Smtp-Source: AGHT+IEn3wYs3MYkMZmX5fVCTc3Eqh6Gg34f/k0seLI4MOsQgal1jgfR5yN6+szsFIBfCCTdhAgrQw==
X-Received: by 2002:a17:902:db10:b0:212:996:3536 with SMTP id d9443c01a7336-2219ff828admr41562505ad.10.1740129001926;
        Fri, 21 Feb 2025 01:10:01 -0800 (PST)
Received: from openbmc.. (211-23-34-211.hinet-ip.hinet.net. [211.23.34.211])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d5367e8csm133593115ad.67.2025.02.21.01.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 01:10:01 -0800 (PST)
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
	gstols@baylibre.com,
	olivier.moysan@foss.st.com,
	mitrutzceclan@gmail.com,
	tgamblin@baylibre.com,
	matteomartelli3@gmail.com,
	marcelo.schmitt@analog.com,
	alisadariana@gmail.com,
	joao.goncalves@toradex.com,
	thomas.bonnefille@bootlin.com,
	ramona.nechita@analog.com,
	herve.codina@bootlin.com,
	chanh@os.amperecomputing.com,
	KWLIU@nuvoton.com,
	yhyang2@nuvoton.com
Cc: openbmc@lists.ozlabs.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eason Yang <j2anfernee@gmail.com>
Subject: [PATCH v4 2/2] iio: adc: add support for Nuvoton NCT7201
Date: Fri, 21 Feb 2025 17:09:18 +0800
Message-Id: <20250221090918.1487689-3-j2anfernee@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250221090918.1487689-1-j2anfernee@gmail.com>
References: <20250221090918.1487689-1-j2anfernee@gmail.com>
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
 drivers/iio/adc/Kconfig   |  11 +
 drivers/iio/adc/Makefile  |   1 +
 drivers/iio/adc/nct7201.c | 487 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 500 insertions(+)
 create mode 100644 drivers/iio/adc/nct7201.c

diff --git a/MAINTAINERS b/MAINTAINERS
index fdc4aa5c7eff..389cbbdae1a7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2838,6 +2838,7 @@ F:	arch/arm/mach-npcm/
 F:	arch/arm64/boot/dts/nuvoton/
 F:	drivers/*/*/*npcm*
 F:	drivers/*/*npcm*
+F:	drivers/iio/adc/nct7201.c
 F:	drivers/rtc/rtc-nct3018y.c
 F:	include/dt-bindings/clock/nuvoton,npcm7xx-clock.h
 F:	include/dt-bindings/clock/nuvoton,npcm845-clk.h
diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 849c90203071..d97eccb1c685 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1048,6 +1048,17 @@ config NAU7802
 	  To compile this driver as a module, choose M here: the
 	  module will be called nau7802.
 
+config NCT7201
+        tristate "Nuvoton NCT7201 and NCT7202 Power Monitor"
+        depends on I2C
+        select REGMAP_I2C
+        help
+          Say yes here to build support for Nuvoton NCT7201 and NCT7202
+          Voltage Monitor.
+
+          This driver can also be built as a module. If so, the module
+          will be called nct7201.
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
index 000000000000..c5d1540bcc00
--- /dev/null
+++ b/drivers/iio/adc/nct7201.c
@@ -0,0 +1,487 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Driver for Nuvoton nct7201 and nct7202 power monitor chips.
+ *
+ * Copyright (c) 2024-2025 Nuvoton Technology corporation.
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
+#define NCT7201_REG_BUSY_STATUS				0x1E
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
+	struct mutex access_lock;
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
+		*val = FIELD_GET(NCT7201_REG_VIN_MASK, volt);
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
+		err = regmap_read(chip->regmap16, NCT7201_REG_VIN_LOW_LIMIT(chan->address),
+				  &value);
+		if (err < 0)
+			return err;
+		volt = value;
+	} else {
+		err = regmap_read(chip->regmap16, NCT7201_REG_VIN_HIGH_LIMIT(chan->address),
+				  &value);
+		if (err < 0)
+			return err;
+		volt = value;
+	}
+
+	*val = FIELD_GET(NCT7201_REG_VIN_MASK, volt);
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
+
+	if (chan->type != IIO_VOLTAGE)
+		return -EOPNOTSUPP;
+
+	if (info != IIO_EV_INFO_VALUE)
+		return -EOPNOTSUPP;
+
+	if (dir == IIO_EV_DIR_FALLING)
+		regmap_write(chip->regmap16, NCT7201_REG_VIN_LOW_LIMIT(chan->address),
+			     FIELD_PREP(NCT7201_REG_VIN_MASK, val));
+	else
+		regmap_write(chip->regmap16, NCT7201_REG_VIN_HIGH_LIMIT(chan->address),
+			     FIELD_PREP(NCT7201_REG_VIN_MASK, val));
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
+	if (chip->num_vin_channels <= 8)
+		regmap_write(chip->regmap, NCT7201_REG_CHANNEL_ENABLE_1, chip->vin_mask);
+	else
+		regmap_bulk_write(chip->regmap, NCT7201_REG_CHANNEL_ENABLE_1,
+				  &chip->vin_mask, sizeof(chip->vin_mask));
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
+					    "Failed to write NCT7201_REG_CHANNEL_ENABLE_1 and NCT7201_REG_CHANNEL_ENABLE_2\n");
+	}
+
+	value = get_unaligned_le16(data);
+	chip->vin_mask = value;
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


