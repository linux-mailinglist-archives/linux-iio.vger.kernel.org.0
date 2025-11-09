Return-Path: <linux-iio+bounces-26072-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5146C43FD6
	for <lists+linux-iio@lfdr.de>; Sun, 09 Nov 2025 15:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A510188AA1B
	for <lists+linux-iio@lfdr.de>; Sun,  9 Nov 2025 14:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB462FDC35;
	Sun,  9 Nov 2025 14:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fGlzUjV5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5472FD698
	for <linux-iio@vger.kernel.org>; Sun,  9 Nov 2025 14:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762697521; cv=none; b=MTZH/tCeFKSa6+4qppFEidvCXyEH74/uaWstoHessNGasWfGxiorHCgnGw3dY1MvE2hPYW22RrH42/0SUzJEoBx5+x7un+A/SPc8WL2Nyr1/nehvm+gEgl9FRN6zwGVdME6C4sF1Lgw0nqFwC+B3yBC9tlLN5VzkrzVswgqF6vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762697521; c=relaxed/simple;
	bh=oYtjh3ZY5bMHpb19+BZfZyNBePXBT/kZX0WUJLKXyGk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Tp/r2ZR+7OhfG5FuVfMks77XZSVRX34JMAPnBVEX+a50g4Q6LsOBO1yrSseConWr0BbC6YW+QiYoWRd19elC2AK3rWqlREQ8+ivTSLYHsTbz1vV04hqLcswwQomKycrYa6nYcVgaKbE3umUEe5GEQtvBrG83cuj4CwyZSUVKVAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fGlzUjV5; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-34374febdefso1021726a91.0
        for <linux-iio@vger.kernel.org>; Sun, 09 Nov 2025 06:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762697518; x=1763302318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ztbfH7bsLfbaqxULo40H+BpvRfVXGaQrJ5iJfyEsH1Y=;
        b=fGlzUjV5+K9JOpFqg5uLykmWVUSD6lcdF4dVNeJ7NqwwABgvbedyKw1n2JhJmBhu+e
         bYon09lXXZSp2aKALId3/IFoCfNsD0sfT5lqclBEEtsYT46ItfNofZ/Fxkn5P/WxvxM6
         w6geatw7GcxJjiJnMJ6A4k0rhE1GPRMtw5wELTTzgN0BkBEvgOzwWAEs0gY0pJaeRLtA
         1wBWiWv7EunvqPywxVa00MTyKQb+eX9F/r1vQypCglgHZowXbdH+snIs7gfFTVBULP9R
         1EEfUHby/jlQQnxhGrmXKTP2Kr6wVtG6ysH4NyA9HxLL2daFyImXXdPxQkAMIS98uZcQ
         umwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762697518; x=1763302318;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ztbfH7bsLfbaqxULo40H+BpvRfVXGaQrJ5iJfyEsH1Y=;
        b=g9j2WJphh8XQOoyce3b1+uRrTWvU+Hw5Q14/GBQ3XFjvkWeCE4hTtXz0s/j/esnWBW
         DtKSkDvcjNhQwhZ6EeB7fBbBAMMfpYHo4j/+aOeZUNdpdiI1t+ZC5KXMT9Hrx38sYS0W
         QFf17dC3Mw2Z74E+GjRMvbABGlDuu3ZIxIyCe4wo6ThVjuvku8ABadJgMJwcv40KwL1M
         pxARrNBlebgvei4GKobz/pexjxlBFK/dH+FIICJZ7yg9LAhPMppFx72TUAzpXiZ7FaJX
         zDnvlQ9hNJ8pgDOi84blMYbG1+17XqHTN86QRnRA9rQ/jILyI9TxRLfh+eJB2VBNW3YS
         r1qQ==
X-Forwarded-Encrypted: i=1; AJvYcCVb2zMUD+T5kd6YsGD8bPh9o4qVsefvkqaEVMgxEDD0vrVlmK/2fixRCXHEt0ZKWGLxNKNA7TIAL9g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEV5ogDqiOt7JsRJb+jjaKvWWUsCjgsKTihqglRXIFuhU/jFoA
	U+1/FWigWJfCCppMZkUqCaBtdnrSTGePmOL8euWOTjkjAhonIj9Mj5cB
X-Gm-Gg: ASbGncuevYf1vhbNj8eHzQPmvs5ruuCEcNaarjY/6xPpT3m89J1Wr3iaFj3G25wvpjz
	QH02Ujc7NXuxIGFIQvrUR0vP1S9GOEPaVmcw+CJrL9kBpRwu8hkH3lk+l3CxYTBEYodRLpYNJ4G
	Lv4Wqr6KSy18bFRqZw4xuCiN9HBzE4wrmJyogjlEwf47huN4YNH5MDMpBq4rX39+Ug5VQBO2kAb
	RmJJEzvG61EqZz7ImSMS3Eoob9OS5JdILSwb7oxzObRWj6gGMMtjALghzS9+c3OAn39d9Y69kjD
	Fa16wtP8UAhowhEWlq616CcMQyRD/HtIEtConQ8pgRWsCT1vJGdBq0oRS9bIp1guukYmYk03/uf
	X9KaCzLEHsGq4EcCbx4cdKiYjzXpZtNnbjNU04G6fg4t2GEA3xPfJhinc6O2yKRC7obS9wwoPiG
	y46S3HGMe/CKKE+RYZr868TnzzQ9B0lQEW80zzg7dXcYkBkEMEfhCPNuI6H9cciqU8JXMaK1Lpi
	Z7Rgf2IG04cHJmYwX6dHb1kj2JCw3+mOy9BaOxx45IyXBHnUdn19nCJ
X-Google-Smtp-Source: AGHT+IEitMphxIYDRR/Zf0bmqxDWW2t6m43EhmEqr9zox09ujAce5mXSGqku3w3Ioen/LTL+VasJVw==
X-Received: by 2002:a17:90b:528d:b0:340:2a38:d45f with SMTP id 98e67ed59e1d1-3436cbad416mr7983890a91.16.1762697518290;
        Sun, 09 Nov 2025 06:11:58 -0800 (PST)
Received: from ajianan-Latitude-5591.. ([2402:e280:21d3:2:5455:eccf:e73:de96])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bad33c801d1sm6582780a12.7.2025.11.09.06.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 06:11:58 -0800 (PST)
From: Ajith Anandhan <ajithanandhan0406@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ajith Anandhan <ajithanandhan0406@gmail.com>
Subject: [PATCH v2 2/2] iio: adc: Add support for TI ADS1120
Date: Sun,  9 Nov 2025 19:41:19 +0530
Message-Id: <20251109141119.561756-3-ajithanandhan0406@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251109141119.561756-1-ajithanandhan0406@gmail.com>
References: <20251109141119.561756-1-ajithanandhan0406@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add driver for the Texas Instruments ADS1120, a precision 16-bit
analog-to-digital converter with an SPI interface.

The driver supports:
- Differential and single-ended input channels
- Configurable gain (1-128 for differential, 1-4 for single-ended)
- Internal 2.048V reference
- Single-shot conversion mode

Also update MAINTAINER document.

Signed-off-by: Ajith Anandhan <ajithanandhan0406@gmail.com>
---
 MAINTAINERS                  |   7 +
 drivers/iio/adc/Kconfig      |  10 +
 drivers/iio/adc/Makefile     |   1 +
 drivers/iio/adc/ti-ads1120.c | 631 +++++++++++++++++++++++++++++++++++
 4 files changed, 649 insertions(+)
 create mode 100644 drivers/iio/adc/ti-ads1120.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 3da2c26a7..1efe88fc9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25613,6 +25613,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/iio/adc/ti,ads1119.yaml
 F:	drivers/iio/adc/ti-ads1119.c
 
+TI ADS1120 ADC DRIVER
+M:	Ajith Anandhan <ajithanandhan0406@gmail.com>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/adc/ti,ads1120.yaml
+F:	drivers/iio/adc/ti-ads1120.c
+
 TI ADS7924 ADC DRIVER
 M:	Hugo Villeneuve <hvilleneuve@dimonoff.com>
 L:	linux-iio@vger.kernel.org
diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 58a14e683..afb7895dd 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1655,6 +1655,16 @@ config TI_ADS1119
          This driver can also be built as a module. If so, the module will be
          called ti-ads1119.
 
+config TI_ADS1120
+	tristate "Texas Instruments ADS1120"
+	depends on SPI
+	help
+	  Say yes here to build support for Texas Instruments ADS1120
+	  4-channel, 2kSPS, 16-bit delta-sigma ADC.
+
+	  This driver can also be built as module. If so, the module
+	  will be called ti-ads1120.
+
 config TI_ADS124S08
 	tristate "Texas Instruments ADS124S08"
 	depends on SPI
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index d008f78dc..49c56b459 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -144,6 +144,7 @@ obj-$(CONFIG_TI_ADC161S626) += ti-adc161s626.o
 obj-$(CONFIG_TI_ADS1015) += ti-ads1015.o
 obj-$(CONFIG_TI_ADS1100) += ti-ads1100.o
 obj-$(CONFIG_TI_ADS1119) += ti-ads1119.o
+obj-$(CONFIG_TI_ADS1120) += ti-ads1120.o
 obj-$(CONFIG_TI_ADS124S08) += ti-ads124s08.o
 obj-$(CONFIG_TI_ADS1298) += ti-ads1298.o
 obj-$(CONFIG_TI_ADS131E08) += ti-ads131e08.o
diff --git a/drivers/iio/adc/ti-ads1120.c b/drivers/iio/adc/ti-ads1120.c
new file mode 100644
index 000000000..1e1871b74
--- /dev/null
+++ b/drivers/iio/adc/ti-ads1120.c
@@ -0,0 +1,631 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * TI ADS1120 4-channel, 2kSPS, 16-bit delta-sigma ADC
+ *
+ * Datasheet: https://www.ti.com/lit/gpn/ads1120
+ *
+ * Copyright (C) 2025 Ajith Anandhan <ajithanandhan0406@gmail.com>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/cleanup.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/spi/spi.h>
+#include <linux/unaligned.h>
+
+#include <linux/iio/iio.h>
+
+
+/* Commands */
+#define ADS1120_CMD_RESET		0x06
+#define ADS1120_CMD_START		0x08
+#define ADS1120_CMD_PWRDWN		0x02
+#define ADS1120_CMD_RDATA		0x10
+#define ADS1120_CMD_RREG		0x20
+#define ADS1120_CMD_WREG		0x40
+
+/* Registers */
+#define ADS1120_REG_CONFIG0		0x00
+#define ADS1120_REG_CONFIG1		0x01
+#define ADS1120_REG_CONFIG2		0x02
+#define ADS1120_REG_CONFIG3		0x03
+
+/* Config Register 0 bit definitions */
+#define ADS1120_CFG0_MUX_MASK		GENMASK(7, 4)
+/* Differential inputs */
+#define ADS1120_CFG0_MUX_AIN0_AIN1	0
+#define ADS1120_CFG0_MUX_AIN0_AIN2	1
+#define ADS1120_CFG0_MUX_AIN0_AIN3	2
+#define ADS1120_CFG0_MUX_AIN1_AIN2	3
+#define ADS1120_CFG0_MUX_AIN1_AIN3	4
+#define ADS1120_CFG0_MUX_AIN2_AIN3	5
+#define ADS1120_CFG0_MUX_AIN1_AIN0	6
+#define ADS1120_CFG0_MUX_AIN3_AIN2	7
+/* Single-ended inputs */
+#define ADS1120_CFG0_MUX_AIN0_AVSS	8
+#define ADS1120_CFG0_MUX_AIN1_AVSS	9
+#define ADS1120_CFG0_MUX_AIN2_AVSS	10
+#define ADS1120_CFG0_MUX_AIN3_AVSS	11
+/* Diagnostic inputs */
+#define ADS1120_CFG0_MUX_REFP_REFN_4	12
+#define ADS1120_CFG0_MUX_AVDD_AVSS_4	13
+#define ADS1120_CFG0_MUX_SHORTED	14
+
+#define ADS1120_CFG0_GAIN_MASK		GENMASK(3, 1)
+#define ADS1120_CFG0_GAIN_1		0
+#define ADS1120_CFG0_GAIN_2		1
+#define ADS1120_CFG0_GAIN_4		2
+#define ADS1120_CFG0_GAIN_8		3
+#define ADS1120_CFG0_GAIN_16		4
+#define ADS1120_CFG0_GAIN_32		5
+#define ADS1120_CFG0_GAIN_64		6
+#define ADS1120_CFG0_GAIN_128		7
+
+#define ADS1120_CFG0_PGA_BYPASS		BIT(0)
+
+/* Config Register 1 bit definitions */
+#define ADS1120_CFG1_DR_MASK		GENMASK(7, 5)
+#define ADS1120_CFG1_DR_20SPS		0
+#define ADS1120_CFG1_DR_45SPS		1
+#define ADS1120_CFG1_DR_90SPS		2
+#define ADS1120_CFG1_DR_175SPS		3
+#define ADS1120_CFG1_DR_330SPS		4
+#define ADS1120_CFG1_DR_600SPS		5
+#define ADS1120_CFG1_DR_1000SPS		6
+
+#define ADS1120_CFG1_MODE_MASK		GENMASK(4, 3)
+#define ADS1120_CFG1_MODE_NORMAL	0
+#define ADS1120_CFG1_MODE_DUTY		1
+#define ADS1120_CFG1_MODE_TURBO		2
+
+#define ADS1120_CFG1_CM_MASK		BIT(2)
+#define ADS1120_CFG1_CM_SINGLE		0
+#define ADS1120_CFG1_CM_CONTINUOUS	1
+
+#define ADS1120_CFG1_TS_EN		BIT(1)
+#define ADS1120_CFG1_BCS_EN		BIT(0)
+
+/* Config Register 2 bit definitions */
+#define ADS1120_CFG2_VREF_MASK		GENMASK(7, 6)
+#define ADS1120_CFG2_VREF_INTERNAL	0
+#define ADS1120_CFG2_VREF_EXT_REFP0	1
+#define ADS1120_CFG2_VREF_EXT_AIN0	2
+#define ADS1120_CFG2_VREF_AVDD		3
+
+#define ADS1120_CFG2_REJECT_MASK	GENMASK(5, 4)
+#define ADS1120_CFG2_REJECT_OFF		0
+#define ADS1120_CFG2_REJECT_50_60	1
+#define ADS1120_CFG2_REJECT_50		2
+#define ADS1120_CFG2_REJECT_60		3
+
+#define ADS1120_CFG2_PSW_EN		BIT(3)
+
+#define ADS1120_CFG2_IDAC_MASK		GENMASK(2, 0)
+#define ADS1120_CFG2_IDAC_OFF		0
+#define ADS1120_CFG2_IDAC_10UA		1
+#define ADS1120_CFG2_IDAC_50UA		2
+#define ADS1120_CFG2_IDAC_100UA		3
+#define ADS1120_CFG2_IDAC_250UA		4
+#define ADS1120_CFG2_IDAC_500UA		5
+#define ADS1120_CFG2_IDAC_1000UA	6
+#define ADS1120_CFG2_IDAC_1500UA	7
+
+/* Config Register 3 bit definitions */
+#define ADS1120_CFG3_IDAC1_MASK		GENMASK(7, 5)
+#define ADS1120_CFG3_IDAC1_DISABLED	0
+#define ADS1120_CFG3_IDAC1_AIN0		1
+#define ADS1120_CFG3_IDAC1_AIN1		2
+#define ADS1120_CFG3_IDAC1_AIN2		3
+#define ADS1120_CFG3_IDAC1_AIN3		4
+#define ADS1120_CFG3_IDAC1_REFP0	5
+#define ADS1120_CFG3_IDAC1_REFN0	6
+
+#define ADS1120_CFG3_IDAC2_MASK		GENMASK(4, 2)
+#define ADS1120_CFG3_IDAC2_DISABLED	0
+#define ADS1120_CFG3_IDAC2_AIN0		1
+#define ADS1120_CFG3_IDAC2_AIN1		2
+#define ADS1120_CFG3_IDAC2_AIN2		3
+#define ADS1120_CFG3_IDAC2_AIN3		4
+#define ADS1120_CFG3_IDAC2_REFP0	5
+#define ADS1120_CFG3_IDAC2_REFN0	6
+
+#define ADS1120_CFG3_DRDYM_MASK		BIT(1)
+#define ADS1120_CFG3_DRDYM_DRDY_ONLY	0
+#define ADS1120_CFG3_DRDYM_BOTH		1
+
+/* Conversion time for 20 SPS */
+#define ADS1120_CONV_TIME_MS		51
+
+/* Internal reference voltage in millivolts */
+#define ADS1120_VREF_INTERNAL_MV	2048
+
+
+struct ads1120_state {
+	struct spi_device	*spi;
+	struct regmap		*regmap;
+	/*
+	 * Protects chip configuration and ADC reads to ensure
+	 * consistent channel/gain settings during conversions.
+	 */
+	struct mutex		lock;
+
+	int vref_mv;
+
+	/* DMA-safe buffer for SPI transfers */
+	u8 data[4] __aligned(IIO_DMA_MINALIGN);
+};
+
+
+static const int ads1120_gain_values[] = { 1, 2, 4, 8, 16, 32, 64, 128 };
+static const int ads1120_low_gain_values[] = { 1, 2, 4 };
+
+/* Differential channel macro */
+#define ADS1120_DIFF_CHANNEL(index, chan1, chan2)		\
+{								\
+	.type = IIO_VOLTAGE,					\
+	.indexed = 1,						\
+	.channel = chan1,					\
+	.channel2 = chan2,					\
+	.differential = 1,					\
+	.address = index,					\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		\
+			      BIT(IIO_CHAN_INFO_SCALE),		\
+	.info_mask_separate_available = BIT(IIO_CHAN_INFO_SCALE), \
+}
+
+/* Single-ended channel macro */
+#define ADS1120_SINGLE_CHANNEL(index, chan)			\
+{								\
+	.type = IIO_VOLTAGE,					\
+	.indexed = 1,						\
+	.channel = chan,					\
+	.address = index,					\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		\
+			      BIT(IIO_CHAN_INFO_SCALE),		\
+	.info_mask_separate_available = BIT(IIO_CHAN_INFO_SCALE), \
+}
+
+/* Diagnostic channel macro */
+#define ADS1120_DIAG_CHANNEL(index, label)			\
+{								\
+	.type = IIO_VOLTAGE,					\
+	.indexed = 1,						\
+	.channel = index,					\
+	.address = index,					\
+	.extend_name = label,					\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		\
+			      BIT(IIO_CHAN_INFO_SCALE),		\
+	.info_mask_separate_available = BIT(IIO_CHAN_INFO_SCALE), \
+}
+
+static const struct iio_chan_spec ads1120_channels[] = {
+	/* Differential inputs */
+	ADS1120_DIFF_CHANNEL(ADS1120_CFG0_MUX_AIN0_AIN1, 0, 1),
+	ADS1120_DIFF_CHANNEL(ADS1120_CFG0_MUX_AIN0_AIN2, 0, 2),
+	ADS1120_DIFF_CHANNEL(ADS1120_CFG0_MUX_AIN0_AIN3, 0, 3),
+	ADS1120_DIFF_CHANNEL(ADS1120_CFG0_MUX_AIN1_AIN2, 1, 2),
+	ADS1120_DIFF_CHANNEL(ADS1120_CFG0_MUX_AIN1_AIN3, 1, 3),
+	ADS1120_DIFF_CHANNEL(ADS1120_CFG0_MUX_AIN2_AIN3, 2, 3),
+	ADS1120_DIFF_CHANNEL(ADS1120_CFG0_MUX_AIN1_AIN0, 1, 0),
+	ADS1120_DIFF_CHANNEL(ADS1120_CFG0_MUX_AIN3_AIN2, 3, 2),
+	/* Single-ended inputs */
+	ADS1120_SINGLE_CHANNEL(ADS1120_CFG0_MUX_AIN0_AVSS, 0),
+	ADS1120_SINGLE_CHANNEL(ADS1120_CFG0_MUX_AIN1_AVSS, 1),
+	ADS1120_SINGLE_CHANNEL(ADS1120_CFG0_MUX_AIN2_AVSS, 2),
+	ADS1120_SINGLE_CHANNEL(ADS1120_CFG0_MUX_AIN3_AVSS, 3),
+	/* Diagnostic inputs */
+	ADS1120_DIAG_CHANNEL(ADS1120_CFG0_MUX_REFP_REFN_4, "ref_div4"),
+	ADS1120_DIAG_CHANNEL(ADS1120_CFG0_MUX_AVDD_AVSS_4, "avdd_div4"),
+	ADS1120_DIAG_CHANNEL(ADS1120_CFG0_MUX_SHORTED, "shorted"),
+};
+
+static bool ads1120_is_differential_channel(const struct iio_chan_spec *chan)
+{
+	return chan->address <= ADS1120_CFG0_MUX_AIN3_AIN2;
+}
+
+static int ads1120_write_cmd(struct ads1120_state *st, u8 cmd)
+{
+	st->data[0] = cmd;
+	return spi_write(st->spi, st->data, sizeof(st->data[0]));
+}
+
+static int ads1120_reset(struct ads1120_state *st)
+{
+	int ret;
+
+	ret = ads1120_write_cmd(st, ADS1120_CMD_RESET);
+	if (ret)
+		return ret;
+
+	/*
+	 * Datasheet specifies reset takes 50us + 32 * t(CLK)
+	 * where t(CLK) = 1/4.096MHz (~0.24us).
+	 * 50us + 32 * 0.24us = ~58us. Use 200us to be safe.
+	 */
+	fsleep(200);
+
+	regcache_mark_dirty(st->regmap);
+
+	return 0;
+}
+
+static int ads1120_set_mux(struct ads1120_state *st, u8 mux_val)
+{
+	if (mux_val > ADS1120_CFG0_MUX_SHORTED)
+		return -EINVAL;
+
+	return regmap_update_bits(st->regmap, ADS1120_REG_CONFIG0,
+				  ADS1120_CFG0_MUX_MASK,
+				  FIELD_PREP(ADS1120_CFG0_MUX_MASK, mux_val));
+}
+
+static int ads1120_set_gain(struct ads1120_state *st, int gain_val)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(ads1120_gain_values); i++) {
+		if (ads1120_gain_values[i] == gain_val)
+			break;
+	}
+
+	if (i == ARRAY_SIZE(ads1120_gain_values))
+		return -EINVAL;
+
+	return regmap_update_bits(st->regmap, ADS1120_REG_CONFIG0,
+				  ADS1120_CFG0_GAIN_MASK,
+				  FIELD_PREP(ADS1120_CFG0_GAIN_MASK, i));
+}
+
+static int ads1120_get_gain(struct ads1120_state *st)
+{
+	unsigned int val;
+	int ret;
+
+	ret = regmap_read(st->regmap, ADS1120_REG_CONFIG0, &val);
+	if (ret)
+		return ret;
+
+	return ads1120_gain_values[FIELD_GET(ADS1120_CFG0_GAIN_MASK, val)];
+}
+
+static int ads1120_read_raw_adc(struct ads1120_state *st, int *val)
+{
+	int ret;
+	struct spi_transfer xfer[2] = {
+		{
+			.tx_buf = st->data,
+			.len = 1,
+		}, {
+			.rx_buf = st->data,
+			.len = 2,
+		}
+	};
+
+	st->data[0] = ADS1120_CMD_RDATA;
+
+	ret = spi_sync_transfer(st->spi, xfer, ARRAY_SIZE(xfer));
+	if (ret)
+		return ret;
+
+	*val = sign_extend32(get_unaligned_be16(st->data), 15);
+
+	return 0;
+}
+
+static int ads1120_read_measurement(struct ads1120_state *st,
+				    const struct iio_chan_spec *chan, int *val)
+{
+	int ret;
+
+	ret = ads1120_set_mux(st, chan->address);
+	if (ret)
+		return ret;
+
+	ret = ads1120_write_cmd(st, ADS1120_CMD_START);
+	if (ret)
+		return ret;
+
+	msleep(ADS1120_CONV_TIME_MS);
+
+	return ads1120_read_raw_adc(st, val);
+}
+
+static int ads1120_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int *val, int *val2, long mask)
+{
+	struct ads1120_state *st = iio_priv(indio_dev);
+	int ret, gain;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		guard(mutex)(&st->lock);
+		ret = ads1120_read_measurement(st, chan, val);
+		if (ret)
+			return ret;
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_SCALE:
+		/*
+		 * Scale = Vref / (gain * 2^15)
+		 * Return in format: val / 2^val2
+		 */
+		gain = ads1120_get_gain(st);
+		if (gain < 0)
+			return gain;
+
+		*val = st->vref_mv;
+		*val2 = gain * 15;
+		return IIO_VAL_FRACTIONAL_LOG2;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ads1120_write_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     int val, int val2, long mask)
+{
+	struct ads1120_state *st = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		/*
+		 * Validate gain for single-ended and diagnostic channels.
+		 * These channels require PGA bypass and support only
+		 * gains 1, 2, and 4.
+		 */
+		if (!ads1120_is_differential_channel(chan) && val > 4)
+			return -EINVAL;
+
+		guard(mutex)(&st->lock);
+		return ads1120_set_gain(st, val);
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ads1120_read_avail(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      const int **vals, int *type, int *length,
+			      long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		if (ads1120_is_differential_channel(chan)) {
+			*vals = ads1120_gain_values;
+			*length = ARRAY_SIZE(ads1120_gain_values);
+		} else {
+			*vals = ads1120_low_gain_values;
+			*length = ARRAY_SIZE(ads1120_low_gain_values);
+		}
+		*type = IIO_VAL_INT;
+		return IIO_AVAIL_LIST;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info ads1120_info = {
+	.read_raw = ads1120_read_raw,
+	.write_raw = ads1120_write_raw,
+	.read_avail = ads1120_read_avail,
+};
+
+/* Regmap read function for ADS1120 */
+static int ads1120_regmap_read(void *context, const void *reg_buf,
+			       size_t reg_size, void *val_buf, size_t val_size)
+{
+	struct ads1120_state *st = context;
+	u8 reg = *(u8 *)reg_buf;
+	u8 *val = val_buf;
+	int ret;
+	struct spi_transfer xfer[2] = {
+		{
+			.tx_buf = st->data,
+			.len = 1,
+		}, {
+			.rx_buf = val,
+			.len = val_size,
+		}
+	};
+
+	if (reg > ADS1120_REG_CONFIG3)
+		return -EINVAL;
+
+	/* RREG command: 0010rr00 where rr is register address */
+	st->data[0] = ADS1120_CMD_RREG | (reg << 2);
+
+	ret = spi_sync_transfer(st->spi, xfer, ARRAY_SIZE(xfer));
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+/* Regmap write function for ADS1120 */
+static int ads1120_regmap_write(void *context, const void *data, size_t count)
+{
+	struct ads1120_state *st = context;
+	const u8 *buf = data;
+
+	if (count != 2)
+		return -EINVAL;
+
+	/* WREG command: 0100rr00 where rr is register address */
+	st->data[0] = ADS1120_CMD_WREG | (buf[0] << 2);
+	st->data[1] = buf[1];
+
+	return spi_write(st->spi, st->data, 2);
+}
+
+static const struct regmap_bus ads1120_regmap_bus = {
+	.read = ads1120_regmap_read,
+	.write = ads1120_regmap_write,
+	.reg_format_endian_default = REGMAP_ENDIAN_BIG,
+	.val_format_endian_default = REGMAP_ENDIAN_BIG,
+};
+
+static const struct regmap_config ads1120_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = ADS1120_REG_CONFIG3,
+	.cache_type = REGCACHE_FLAT,
+};
+
+static int ads1120_init(struct ads1120_state *st)
+{
+	int ret;
+
+	ret = ads1120_reset(st);
+	if (ret)
+		return dev_err_probe(&st->spi->dev, ret,
+					"Failed to reset device\n");
+
+	/*
+	 * Configure Register 0:
+	 * - Input MUX: AIN0/AVSS
+	 * - Gain: 1
+	 * - PGA bypass enabled. When gain is set > 4, this bit is
+	 *   automatically ignored by the hardware and PGA is enabled,
+	 *   so it's safe to leave it set.
+	 */
+	ret = regmap_write(st->regmap, ADS1120_REG_CONFIG0,
+			   FIELD_PREP(ADS1120_CFG0_MUX_MASK,
+				      ADS1120_CFG0_MUX_AIN0_AVSS) |
+			   FIELD_PREP(ADS1120_CFG0_GAIN_MASK,
+				      ADS1120_CFG0_GAIN_1) |
+			   ADS1120_CFG0_PGA_BYPASS);
+	if (ret)
+		return ret;
+
+	/*
+	 * Configure Register 1:
+	 * - Data rate: 20 SPS (for single-shot mode)
+	 * - Operating mode: Normal
+	 * - Conversion mode: Single-shot
+	 * - Temperature sensor: Disabled
+	 * - Burnout current: Disabled
+	 */
+	ret = regmap_write(st->regmap, ADS1120_REG_CONFIG1,
+			   FIELD_PREP(ADS1120_CFG1_DR_MASK,
+				      ADS1120_CFG1_DR_20SPS) |
+			   FIELD_PREP(ADS1120_CFG1_MODE_MASK,
+				      ADS1120_CFG1_MODE_NORMAL) |
+			   FIELD_PREP(ADS1120_CFG1_CM_MASK,
+				      ADS1120_CFG1_CM_SINGLE) |
+			   FIELD_PREP(ADS1120_CFG1_TS_EN, 0) |
+			   FIELD_PREP(ADS1120_CFG1_BCS_EN, 0));
+	if (ret)
+		return ret;
+
+	/*
+	 * Configure Register 2:
+	 * - Voltage reference: Internal 2.048V
+	 * - 50/60Hz rejection: Off
+	 * - Power switch: Disabled
+	 * - IDAC current: Off
+	 */
+	ret = regmap_write(st->regmap, ADS1120_REG_CONFIG2,
+			   FIELD_PREP(ADS1120_CFG2_VREF_MASK,
+				      ADS1120_CFG2_VREF_INTERNAL) |
+			   FIELD_PREP(ADS1120_CFG2_REJECT_MASK,
+				      ADS1120_CFG2_REJECT_OFF) |
+			   FIELD_PREP(ADS1120_CFG2_PSW_EN, 0) |
+			   FIELD_PREP(ADS1120_CFG2_IDAC_MASK,
+				      ADS1120_CFG2_IDAC_OFF));
+	if (ret)
+		return ret;
+
+	/*
+	 * Configure Register 3:
+	 * - IDAC1: Disabled
+	 * - IDAC2: Disabled
+	 * - DRDY mode: Only reflects data ready status
+	 */
+	ret = regmap_write(st->regmap, ADS1120_REG_CONFIG3,
+			   FIELD_PREP(ADS1120_CFG3_IDAC1_MASK,
+				      ADS1120_CFG3_IDAC1_DISABLED) |
+			   FIELD_PREP(ADS1120_CFG3_IDAC2_MASK,
+				      ADS1120_CFG3_IDAC2_DISABLED) |
+			   FIELD_PREP(ADS1120_CFG3_DRDYM_MASK,
+				      ADS1120_CFG3_DRDYM_DRDY_ONLY));
+	if (ret)
+		return ret;
+
+	st->vref_mv = ADS1120_VREF_INTERNAL_MV;
+
+	return 0;
+}
+
+static int ads1120_probe(struct spi_device *spi)
+{
+	struct device *dev = &spi->dev;
+	struct iio_dev *indio_dev;
+	struct ads1120_state *st;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	st = iio_priv(indio_dev);
+	st->spi = spi;
+
+	ret = devm_mutex_init(dev, &st->lock);
+	if (ret)
+		return ret;
+
+	st->regmap = devm_regmap_init(dev, &ads1120_regmap_bus, st,
+				      &ads1120_regmap_config);
+	if (IS_ERR(st->regmap))
+		return dev_err_probe(dev, PTR_ERR(st->regmap),
+					"Failed to initialize regmap\n");
+
+	indio_dev->name = "ads1120";
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = ads1120_channels;
+	indio_dev->num_channels = ARRAY_SIZE(ads1120_channels);
+	indio_dev->info = &ads1120_info;
+
+	ret = ads1120_init(st);
+	if (ret)
+		return dev_err_probe(dev, ret,
+					"Failed to initialize device\n");
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+static const struct of_device_id ads1120_of_match[] = {
+	{ .compatible = "ti,ads1120" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ads1120_of_match);
+
+static const struct spi_device_id ads1120_id[] = {
+	{ "ads1120" },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, ads1120_id);
+
+static struct spi_driver ads1120_driver = {
+	.driver = {
+		.name = "ads1120",
+		.of_match_table = ads1120_of_match,
+	},
+	.probe = ads1120_probe,
+	.id_table = ads1120_id,
+};
+module_spi_driver(ads1120_driver);
+
+MODULE_AUTHOR("Ajith Anandhan <ajithanandhan0406@gmail.com>");
+MODULE_DESCRIPTION("Texas Instruments ADS1120 ADC driver");
+MODULE_LICENSE("GPL");
-- 
2.34.1


