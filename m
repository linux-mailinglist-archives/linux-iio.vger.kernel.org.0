Return-Path: <linux-iio+bounces-26528-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B76C90B87
	for <lists+linux-iio@lfdr.de>; Fri, 28 Nov 2025 04:14:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE1753A7FA5
	for <lists+linux-iio@lfdr.de>; Fri, 28 Nov 2025 03:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6055D2D2383;
	Fri, 28 Nov 2025 03:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="Zj+neGqM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A0229E0E7;
	Fri, 28 Nov 2025 03:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764299641; cv=none; b=WlyM5mHjPJbm6T2Q2vbX0N2T+GJnUZfCDXm9I5Cp6S3r8rVRJIZiZsp+vdbglklyK1w2hMf1yljocf1lmCR62hEbp0S45uyd/k8yzLfPXl433lGsVEZ3IeNifjhdNjynqHDm9uMH88Q/LvQnoGUheNudgNXIdNaZzuPz0ymbJ6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764299641; c=relaxed/simple;
	bh=phmdhq4xHF6buUfu9oRhHXl8v+viJpAEPVbOrA0acoo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HShyU6U4QQkM3yw3FDOH8Fu/I72ybPKt7bviEmxDZHjGEpGCl5J2guH3CDRXBvFdITCX37wqGo6Ckh68pNDo3Czc92FNsh57erDEuDnPkvtEx2C6bdWqLYuTuApbbPP6eO5v44dysES/ueLY+7iEgmxDXr8SZTjBDLgPVI8he6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=Zj+neGqM; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from sunspire.home.arpa (unknown [IPv6:2a02:2f0e:3402:a400:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 1FD1016020B;
	Fri, 28 Nov 2025 05:13:56 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1764299636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/1BuqTBYzXGxe2vIwjHMHyfw9KtPzmpEjOn+eL4kL/s=;
	b=Zj+neGqMnwgIVI1Ok/+uTR6PkMBheay44F8Nem20WaR9SZd3K49Gx64/Nluopfl890RtOc
	eAeB/7ge4UXBQBA2/4XYPCnmGg0aK7nuqHnNYCAdsNXTQYvNnM7HgFdcIxoQXnQSccmhiW
	KrUxUDVln5UDncqsKlIWZ4ghZxsEM+tnwEqb//583JykgzXym/Hl6sTxpXzTjo9rnXAmOh
	3Oe0c4fZ8sABOU9hQjoydLY2xAZMIzkJQDXhHK+pNwzp7Sd7fT258417to3SaleFJh+e/1
	iGzBlG4BHYF+csHlcl9OG+yse5jhSQwopacc3B80kNdOdgAFpA4NKz+w8ujEyg==
From: Petre Rodan <petre.rodan@subdimension.ro>
Date: Fri, 28 Nov 2025 05:13:27 +0200
Subject: [PATCH v2 2/2] iio: pressure: add Honeywell ABP2 driver
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251128-honeywell_abp2_driver-v2-2-7053748aecf7@subdimension.ro>
References: <20251128-honeywell_abp2_driver-v2-0-7053748aecf7@subdimension.ro>
In-Reply-To: <20251128-honeywell_abp2_driver-v2-0-7053748aecf7@subdimension.ro>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=31860;
 i=petre.rodan@subdimension.ro; h=from:subject:message-id;
 bh=phmdhq4xHF6buUfu9oRhHXl8v+viJpAEPVbOrA0acoo=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFwTDlrQTBEQUFvQmRDc25wM
 k02U1dNQnl5WmlBR2twRTNDMFViTTdpeVY3SlAyTy9mRi9nckg0CmZZK0JRNEZNak9yenRiTVN4
 amJqWElrQ013UUFBUW9BSFJZaEJCb2ltQncrRGJ4UXBFNmlkM1FySjZkak9rbGoKQlFKcEtSTnd
 BQW9KRUhRcko2ZGpPa2xqblM4UUFLc29MYnJWZUU4dHBlVlFJdWVxUU5BNnQ2YWZWV3pOM1NUZA
 pYVVFjdklIRDBmTXlCSnF2VnJyeTZhK1Azc0hweit4VVVOUkxWRGZJTitQTkUxN1llVUFyWi9pN
 mpsS21kYnYzCjMzUGsvMDMwTkNNRlFnOExJZjlpdzRLVHpiWHU4RnJZdU5sOW1zU1RicmFYWEo3
 R3FuWDVJYkxGcEQzOEszMUkKaUdBSjd5MnZmaFlCNDVyN0pjZWFpWWZxUlR6dWpCT3ZIR0xaZDQ
 4NWV2bW1LS2dVSG96UXpobDBkZUtabXdxOApWUEhuUDhJeDhwYVQ3SlFmOU1TaFlsblBRUzlHOW
 1zb2MwbDJ3ZWhrWVdCbHc2WkFYWVg0RitQNk9OS0tycDNrCjh2OFQvS0paYXVkNDUvSllsSzBmc
 1hGNFNDNEJTYWNmQ2paUEhmWlRYNGxUT3FrZVovdERrK1h0aCtPZ3ZEVzgKR0V0S2o2RFg4dlJF
 dlp5T2Vnc0s5VHQ2U3g2RENGWVVXTjJXUzgzWjNHemVQZjBmY1BzNThMN1BwYXY3RlMwdwo4S3R
 ZOHBTRXYrUVUvR1NIWWZteFN1STZxR3U1eWdLaWZVUytuL0VHUUVhYmE2dmhvVWVOenhnNzdnTV
 JWd3g3Ck0zeXY3V1JBM0l2M1k5NUIyLzRIT1lhZFRacEZ1WENaVldJLzdKOFlQazMxSmJLYzBhS
 TFSSkVoeGdVSXE0YjgKemg0VVJhbXBzS0N1TVlXMklKbmRGZDZOMVdJSGRDQ2ZQaVVlaUV5SXFQ
 UEhZY2E1Zm1BTkpWMCtnQ1FrZ0ZlVgpjNGcrUlY5MTJNVlQ4QllyY2h6Nk1YNkRFS2RYSld4Yi9
 UdTd3QndDT1A3SlU1VzJBSFY4a1BCRUpGMWF1aTNKCld0ZTl4NHdnU2xRc1l3PT0KPW1WZjgKLS
 0tLS1FTkQgUEdQIE1FU1NBR0UtLS0tLQo=
X-Developer-Key: i=petre.rodan@subdimension.ro; a=openpgp;
 fpr=D80A7FC176151935EC3E5FA9CF269999844E7F30

Adds driver for digital Honeywell ABP2 series of board mount
pressure and temperature sensors.

This driver covers 113 different pressure ranges and units on
both i2c and SPI buses.

The communication protocol involves sending two simple commands
to the sensor and there is no register access or a memory map.
For this reason the regmap API was not used.

The i2c address is hardcoded and depends on the part number.

Optional end of conversion interrupt control is present on the
i2c variants of the chips.
The EOC can also be defined for the SPI variants if a non-ABP2
but compatible chip is to be driven.

Tested on two different sensors.

Datasheet: https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/board-mount-pressure-sensors/basic-abp2-series/documents/sps-siot-abp2-series-datasheet-32350268-en.pdf
Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
v1 -> v2
 commit msg:
    - Datasheet tag
    - mention the lack of regmap use
 Kconfig:
    - user can nicely select bus drivers separately
 abp2030pa.c:
    - add a few includes
    - blank line trimming
    - enum without assignments
    - use the recommended trailing in the arrays
    - less const
    - comment for the 5 * USEC_PER_MSEC fsleep()
    - curly braces for else branch
    - improved error codes
    - remove INDIO_DIRECT_MODE line
    - remove call to _ops->init
 abp2030pa.h:
    - add completion header
    - remove a few structs
    - rename buffer -> rx_buf in abp2_data struct
    - add tx_buf to abp2_data struct
 abp2030pa_i2c.c, abp2030pa_spi.c:
    - remove _init() ops
    - remove redundant else
    - remove device.h include from _spi.c
@Jonathan:
    please comment about the rx_buf, tx_buf alignment
---
 MAINTAINERS                          |   1 +
 drivers/iio/pressure/Kconfig         |  31 ++
 drivers/iio/pressure/Makefile        |   3 +
 drivers/iio/pressure/abp2030pa.c     | 538 +++++++++++++++++++++++++++++++++++
 drivers/iio/pressure/abp2030pa.h     |  77 +++++
 drivers/iio/pressure/abp2030pa_i2c.c |  87 ++++++
 drivers/iio/pressure/abp2030pa_spi.c |  67 +++++
 7 files changed, 804 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 15b92300acbc..0aa9cba68137 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11409,6 +11409,7 @@ M:	Petre Rodan <petre.rodan@subdimension.ro>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/iio/pressure/honeywell,abp2030pa.yaml
+F:	drivers/iio/pressure/abp2030pa*
 
 HONEYWELL HSC030PA PRESSURE SENSOR SERIES IIO DRIVER
 M:	Petre Rodan <petre.rodan@subdimension.ro>
diff --git a/drivers/iio/pressure/Kconfig b/drivers/iio/pressure/Kconfig
index 2fe9dc90cceb..f47269f7e73c 100644
--- a/drivers/iio/pressure/Kconfig
+++ b/drivers/iio/pressure/Kconfig
@@ -16,6 +16,37 @@ config ABP060MG
 	  To compile this driver as a module, choose M here: the module
 	  will be called abp060mg.
 
+config ABP2030PA
+	tristate
+
+config ABP2030PA_I2C
+	tristate "Honeywell ABP2 pressure sensor series I2C driver"
+	depends on I2C
+	select ABP2030PA
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
+	help
+	  Say Y here to build I2C bus support for the Honeywell ABP2
+	  series pressure and temperature digital sensor.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called abp2030pa_i2c and you will also get abp2030pa
+	  for the core module.
+
+config ABP2030PA_SPI
+	tristate "Honeywell ABP2 pressure sensor series SPI driver"
+	depends on SPI_MASTER
+	select ABP2030PA
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
+	help
+	  Say Y here to build I2C bus support for the Honeywell ABP2
+	  series pressure and temperature digital sensor.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called abp2030pa_spi and you will also get abp2030pa
+	  for the core module.
+
 config ROHM_BM1390
 	tristate "ROHM BM1390GLV-Z pressure sensor driver"
 	depends on I2C
diff --git a/drivers/iio/pressure/Makefile b/drivers/iio/pressure/Makefile
index a21443e992b9..bc0d11a20acc 100644
--- a/drivers/iio/pressure/Makefile
+++ b/drivers/iio/pressure/Makefile
@@ -5,6 +5,9 @@
 
 # When adding new entries keep the list in alphabetical order
 obj-$(CONFIG_ABP060MG) += abp060mg.o
+obj-$(CONFIG_ABP2030PA) += abp2030pa.o
+obj-$(CONFIG_ABP2030PA_I2C) += abp2030pa_i2c.o
+obj-$(CONFIG_ABP2030PA_SPI) += abp2030pa_spi.o
 obj-$(CONFIG_ADP810) += adp810.o
 obj-$(CONFIG_ROHM_BM1390) += rohm-bm1390.o
 obj-$(CONFIG_BMP280) += bmp280.o
diff --git a/drivers/iio/pressure/abp2030pa.c b/drivers/iio/pressure/abp2030pa.c
new file mode 100644
index 000000000000..04a4494a74d2
--- /dev/null
+++ b/drivers/iio/pressure/abp2030pa.c
@@ -0,0 +1,538 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Honeywell ABP2 series pressure sensor driver
+ *
+ * Copyright (c) 2025 Petre Rodan <petre.rodan@subdimension.ro>
+ *
+ * Datasheet: https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/board-mount-pressure-sensors/basic-abp2-series/documents/sps-siot-abp2-series-datasheet-32350268-en.pdf
+ */
+
+#include <linux/array_size.h>
+#include <linux/bits.h>
+#include <linux/completion.h>
+#include <linux/delay.h>
+#include <linux/dev_printk.h>
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/export.h>
+#include <linux/gpio/consumer.h>
+#include <linux/interrupt.h>
+#include <linux/jiffies.h>
+#include <linux/math64.h>
+#include <linux/module.h>
+#include <linux/property.h>
+#include <linux/regulator/consumer.h>
+#include <linux/string.h>
+#include <linux/time.h>
+#include <linux/types.h>
+#include <linux/unaligned.h>
+#include <linux/units.h>
+
+#include <linux/iio/buffer.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
+
+#include "abp2030pa.h"
+
+/* status byte flags */
+#define ABP2_ST_POWER     BIT(6) /* 1 if device is powered */
+#define ABP2_ST_BUSY      BIT(5) /* 1 if device is busy */
+
+struct abp2_func_spec {
+	u32 output_min;
+	u32 output_max;
+};
+
+/* transfer function A: 10%   to 90%   of 2^24 */
+static const struct abp2_func_spec abp2_func_spec[] = {
+	[ABP2_FUNCTION_A] = { .output_min = 1677722, .output_max = 15099494 },
+};
+
+enum abp2_variants {
+	ABP2001BA, ABP21_6BA, ABP22_5BA, ABP2004BA, ABP2006BA, ABP2008BA,
+	ABP2010BA, ABP2012BA, ABP2001BD, ABP21_6BD, ABP22_5BD, ABP2004BD,
+	ABP2001BG, ABP21_6BG, ABP22_5BG, ABP2004BG, ABP2006BG, ABP2008BG,
+	ABP2010BG, ABP2012BG, ABP2001GG, ABP21_2GG, ABP2100KA, ABP2160KA,
+	ABP2250KA, ABP2001KD, ABP21_6KD, ABP22_5KD, ABP2004KD, ABP2006KD,
+	ABP2010KD, ABP2016KD, ABP2025KD, ABP2040KD, ABP2060KD, ABP2100KD,
+	ABP2160KD, ABP2250KD, ABP2400KD, ABP2001KG, ABP21_6KG, ABP22_5KG,
+	ABP2004KG, ABP2006KG, ABP2010KG, ABP2016KG, ABP2025KG, ABP2040KG,
+	ABP2060KG, ABP2100KG, ABP2160KG, ABP2250KG, ABP2400KG, ABP2600KG,
+	ABP2800KG, ABP2250LD, ABP2600LD, ABP2600LG, ABP22_5MD, ABP2006MD,
+	ABP2010MD, ABP2016MD, ABP2025MD, ABP2040MD, ABP2060MD, ABP2100MD,
+	ABP2160MD, ABP2250MD, ABP2400MD, ABP2600MD, ABP2006MG, ABP2010MG,
+	ABP2016MG, ABP2025MG, ABP2040MG, ABP2060MG, ABP2100MG, ABP2160MG,
+	ABP2250MG, ABP2400MG, ABP2600MG, ABP2001ND, ABP2002ND, ABP2004ND,
+	ABP2005ND, ABP2010ND, ABP2020ND, ABP2030ND, ABP2002NG, ABP2004NG,
+	ABP2005NG, ABP2010NG, ABP2020NG, ABP2030NG, ABP2015PA, ABP2030PA,
+	ABP2060PA, ABP2100PA, ABP2150PA, ABP2175PA, ABP2001PD, ABP2005PD,
+	ABP2015PD, ABP2030PD, ABP2060PD, ABP2001PG, ABP2005PG, ABP2015PG,
+	ABP2030PG, ABP2060PG, ABP2100PG, ABP2150PG, ABP2175PG,
+	ABP2_VARIANTS_MAX
+};
+
+static const char * const abp2_triplet_variants[ABP2_VARIANTS_MAX] = {
+	[ABP2001BA] = "001BA", [ABP21_6BA] = "1.6BA", [ABP22_5BA] = "2.5BA",
+	[ABP2004BA] = "004BA", [ABP2006BA] = "006BA", [ABP2008BA] = "008BA",
+	[ABP2010BA] = "010BA", [ABP2012BA] = "012BA", [ABP2001BD] = "001BD",
+	[ABP21_6BD] = "1.6BD", [ABP22_5BD] = "2.5BD", [ABP2004BD] = "004BD",
+	[ABP2001BG] = "001BG", [ABP21_6BG] = "1.6BG", [ABP22_5BG] = "2.5BG",
+	[ABP2004BG] = "004BG", [ABP2006BG] = "006BG", [ABP2008BG] = "008BG",
+	[ABP2010BG] = "010BG", [ABP2012BG] = "012BG", [ABP2001GG] = "001GG",
+	[ABP21_2GG] = "1.2GG", [ABP2100KA] = "100KA", [ABP2160KA] = "160KA",
+	[ABP2250KA] = "250KA", [ABP2001KD] = "001KD", [ABP21_6KD] = "1.6KD",
+	[ABP22_5KD] = "2.5KD", [ABP2004KD] = "004KD", [ABP2006KD] = "006KD",
+	[ABP2010KD] = "010KD", [ABP2016KD] = "016KD", [ABP2025KD] = "025KD",
+	[ABP2040KD] = "040KD", [ABP2060KD] = "060KD", [ABP2100KD] = "100KD",
+	[ABP2160KD] = "160KD", [ABP2250KD] = "250KD", [ABP2400KD] = "400KD",
+	[ABP2001KG] = "001KG", [ABP21_6KG] = "1.6KG", [ABP22_5KG] = "2.5KG",
+	[ABP2004KG] = "004KG", [ABP2006KG] = "006KG", [ABP2010KG] = "010KG",
+	[ABP2016KG] = "016KG", [ABP2025KG] = "025KG", [ABP2040KG] = "040KG",
+	[ABP2060KG] = "060KG", [ABP2100KG] = "100KG", [ABP2160KG] = "160KG",
+	[ABP2250KG] = "250KG", [ABP2400KG] = "400KG", [ABP2600KG] = "600KG",
+	[ABP2800KG] = "800KG", [ABP2250LD] = "250LD", [ABP2600LD] = "600LD",
+	[ABP2600LG] = "600LG", [ABP22_5MD] = "2.5MD", [ABP2006MD] = "006MD",
+	[ABP2010MD] = "010MD", [ABP2016MD] = "016MD", [ABP2025MD] = "025MD",
+	[ABP2040MD] = "040MD", [ABP2060MD] = "060MD", [ABP2100MD] = "100MD",
+	[ABP2160MD] = "160MD", [ABP2250MD] = "250MD", [ABP2400MD] = "400MD",
+	[ABP2600MD] = "600MD", [ABP2006MG] = "006MG", [ABP2010MG] = "010MG",
+	[ABP2016MG] = "016MG", [ABP2025MG] = "025MG", [ABP2040MG] = "040MG",
+	[ABP2060MG] = "060MG", [ABP2100MG] = "100MG", [ABP2160MG] = "160MG",
+	[ABP2250MG] = "250MG", [ABP2400MG] = "400MG", [ABP2600MG] = "600MG",
+	[ABP2001ND] = "001ND", [ABP2002ND] = "002ND", [ABP2004ND] = "004ND",
+	[ABP2005ND] = "005ND", [ABP2010ND] = "010ND", [ABP2020ND] = "020ND",
+	[ABP2030ND] = "030ND", [ABP2002NG] = "002NG", [ABP2004NG] = "004NG",
+	[ABP2005NG] = "005NG", [ABP2010NG] = "010NG", [ABP2020NG] = "020NG",
+	[ABP2030NG] = "030NG", [ABP2015PA] = "015PA", [ABP2030PA] = "030PA",
+	[ABP2060PA] = "060PA", [ABP2100PA] = "100PA", [ABP2150PA] = "150PA",
+	[ABP2175PA] = "175PA", [ABP2001PD] = "001PD", [ABP2005PD] = "005PD",
+	[ABP2015PD] = "015PD", [ABP2030PD] = "030PD", [ABP2060PD] = "060PD",
+	[ABP2001PG] = "001PG", [ABP2005PG] = "005PG", [ABP2015PG] = "015PG",
+	[ABP2030PG] = "030PG", [ABP2060PG] = "060PG", [ABP2100PG] = "100PG",
+	[ABP2150PG] = "150PG", [ABP2175PG] = "175PG",
+};
+
+/**
+ * struct abp2_range_config - list of pressure ranges based on nomenclature
+ * @pmin: lowest pressure that can be measured
+ * @pmax: highest pressure that can be measured
+ */
+struct abp2_range_config {
+	s32 pmin;
+	s32 pmax;
+};
+
+/* All min max limits have been converted to pascals */
+static const struct abp2_range_config abp2_range_config[ABP2_VARIANTS_MAX] = {
+	[ABP2001BA] = { .pmin =       0, .pmax =  100000 },
+	[ABP21_6BA] = { .pmin =       0, .pmax =  160000 },
+	[ABP22_5BA] = { .pmin =       0, .pmax =  250000 },
+	[ABP2004BA] = { .pmin =       0, .pmax =  400000 },
+	[ABP2006BA] = { .pmin =       0, .pmax =  600000 },
+	[ABP2008BA] = { .pmin =       0, .pmax =  800000 },
+	[ABP2010BA] = { .pmin =       0, .pmax = 1000000 },
+	[ABP2012BA] = { .pmin =       0, .pmax = 1200000 },
+	[ABP2001BD] = { .pmin = -100000, .pmax =  100000 },
+	[ABP21_6BD] = { .pmin = -160000, .pmax =  160000 },
+	[ABP22_5BD] = { .pmin = -250000, .pmax =  250000 },
+	[ABP2004BD] = { .pmin = -400000, .pmax =  400000 },
+	[ABP2001BG] = { .pmin =       0, .pmax =  100000 },
+	[ABP21_6BG] = { .pmin =       0, .pmax =  160000 },
+	[ABP22_5BG] = { .pmin =       0, .pmax =  250000 },
+	[ABP2004BG] = { .pmin =       0, .pmax =  400000 },
+	[ABP2006BG] = { .pmin =       0, .pmax =  600000 },
+	[ABP2008BG] = { .pmin =       0, .pmax =  800000 },
+	[ABP2010BG] = { .pmin =       0, .pmax = 1000000 },
+	[ABP2012BG] = { .pmin =       0, .pmax = 1200000 },
+	[ABP2001GG] = { .pmin =       0, .pmax = 1000000 },
+	[ABP21_2GG] = { .pmin =       0, .pmax = 1200000 },
+	[ABP2100KA] = { .pmin =       0, .pmax =  100000 },
+	[ABP2160KA] = { .pmin =       0, .pmax =  160000 },
+	[ABP2250KA] = { .pmin =       0, .pmax =  250000 },
+	[ABP2001KD] = { .pmin =   -1000, .pmax =    1000 },
+	[ABP21_6KD] = { .pmin =   -1600, .pmax =    1600 },
+	[ABP22_5KD] = { .pmin =   -2500, .pmax =    2500 },
+	[ABP2004KD] = { .pmin =   -4000, .pmax =    4000 },
+	[ABP2006KD] = { .pmin =   -6000, .pmax =    6000 },
+	[ABP2010KD] = { .pmin =  -10000, .pmax =   10000 },
+	[ABP2016KD] = { .pmin =  -16000, .pmax =   16000 },
+	[ABP2025KD] = { .pmin =  -25000, .pmax =   25000 },
+	[ABP2040KD] = { .pmin =  -40000, .pmax =   40000 },
+	[ABP2060KD] = { .pmin =  -60000, .pmax =   60000 },
+	[ABP2100KD] = { .pmin = -100000, .pmax =  100000 },
+	[ABP2160KD] = { .pmin = -160000, .pmax =  160000 },
+	[ABP2250KD] = { .pmin = -250000, .pmax =  250000 },
+	[ABP2400KD] = { .pmin = -400000, .pmax =  400000 },
+	[ABP2001KG] = { .pmin =       0, .pmax =    1000 },
+	[ABP21_6KG] = { .pmin =       0, .pmax =    1600 },
+	[ABP22_5KG] = { .pmin =       0, .pmax =    2500 },
+	[ABP2004KG] = { .pmin =       0, .pmax =    4000 },
+	[ABP2006KG] = { .pmin =       0, .pmax =    6000 },
+	[ABP2010KG] = { .pmin =       0, .pmax =   10000 },
+	[ABP2016KG] = { .pmin =       0, .pmax =   16000 },
+	[ABP2025KG] = { .pmin =       0, .pmax =   25000 },
+	[ABP2040KG] = { .pmin =       0, .pmax =   40000 },
+	[ABP2060KG] = { .pmin =       0, .pmax =   60000 },
+	[ABP2100KG] = { .pmin =       0, .pmax =  100000 },
+	[ABP2160KG] = { .pmin =       0, .pmax =  160000 },
+	[ABP2250KG] = { .pmin =       0, .pmax =  250000 },
+	[ABP2400KG] = { .pmin =       0, .pmax =  400000 },
+	[ABP2600KG] = { .pmin =       0, .pmax =  600000 },
+	[ABP2800KG] = { .pmin =       0, .pmax =  800000 },
+	[ABP2250LD] = { .pmin =    -250, .pmax =     250 },
+	[ABP2600LD] = { .pmin =    -600, .pmax =     600 },
+	[ABP2600LG] = { .pmin =       0, .pmax =     600 },
+	[ABP22_5MD] = { .pmin =    -250, .pmax =     250 },
+	[ABP2006MD] = { .pmin =    -600, .pmax =     600 },
+	[ABP2010MD] = { .pmin =   -1000, .pmax =    1000 },
+	[ABP2016MD] = { .pmin =   -1600, .pmax =    1600 },
+	[ABP2025MD] = { .pmin =   -2500, .pmax =    2500 },
+	[ABP2040MD] = { .pmin =   -4000, .pmax =    4000 },
+	[ABP2060MD] = { .pmin =   -6000, .pmax =    6000 },
+	[ABP2100MD] = { .pmin =  -10000, .pmax =   10000 },
+	[ABP2160MD] = { .pmin =  -16000, .pmax =   16000 },
+	[ABP2250MD] = { .pmin =  -25000, .pmax =   25000 },
+	[ABP2400MD] = { .pmin =  -40000, .pmax =   40000 },
+	[ABP2600MD] = { .pmin =  -60000, .pmax =   60000 },
+	[ABP2006MG] = { .pmin =       0, .pmax =     600 },
+	[ABP2010MG] = { .pmin =       0, .pmax =    1000 },
+	[ABP2016MG] = { .pmin =       0, .pmax =    1600 },
+	[ABP2025MG] = { .pmin =       0, .pmax =    2500 },
+	[ABP2040MG] = { .pmin =       0, .pmax =    4000 },
+	[ABP2060MG] = { .pmin =       0, .pmax =    6000 },
+	[ABP2100MG] = { .pmin =       0, .pmax =   10000 },
+	[ABP2160MG] = { .pmin =       0, .pmax =   16000 },
+	[ABP2250MG] = { .pmin =       0, .pmax =   25000 },
+	[ABP2400MG] = { .pmin =       0, .pmax =   40000 },
+	[ABP2600MG] = { .pmin =       0, .pmax =   60000 },
+	[ABP2001ND] = { .pmin =    -249, .pmax =     249 },
+	[ABP2002ND] = { .pmin =    -498, .pmax =     498 },
+	[ABP2004ND] = { .pmin =    -996, .pmax =     996 },
+	[ABP2005ND] = { .pmin =   -1245, .pmax =    1245 },
+	[ABP2010ND] = { .pmin =   -2491, .pmax =    2491 },
+	[ABP2020ND] = { .pmin =   -4982, .pmax =    4982 },
+	[ABP2030ND] = { .pmin =   -7473, .pmax =    7473 },
+	[ABP2002NG] = { .pmin =       0, .pmax =     498 },
+	[ABP2004NG] = { .pmin =       0, .pmax =     996 },
+	[ABP2005NG] = { .pmin =       0, .pmax =    1245 },
+	[ABP2010NG] = { .pmin =       0, .pmax =    2491 },
+	[ABP2020NG] = { .pmin =       0, .pmax =    4982 },
+	[ABP2030NG] = { .pmin =       0, .pmax =    7473 },
+	[ABP2015PA] = { .pmin =       0, .pmax =  103421 },
+	[ABP2030PA] = { .pmin =       0, .pmax =  206843 },
+	[ABP2060PA] = { .pmin =       0, .pmax =  413685 },
+	[ABP2100PA] = { .pmin =       0, .pmax =  689476 },
+	[ABP2150PA] = { .pmin =       0, .pmax = 1034214 },
+	[ABP2175PA] = { .pmin =       0, .pmax = 1206583 },
+	[ABP2001PD] = { .pmin =   -6895, .pmax =    6895 },
+	[ABP2005PD] = { .pmin =  -34474, .pmax =   34474 },
+	[ABP2015PD] = { .pmin = -103421, .pmax =  103421 },
+	[ABP2030PD] = { .pmin = -206843, .pmax =  206843 },
+	[ABP2060PD] = { .pmin = -413685, .pmax =  413685 },
+	[ABP2001PG] = { .pmin =       0, .pmax =    6895 },
+	[ABP2005PG] = { .pmin =       0, .pmax =   34474 },
+	[ABP2015PG] = { .pmin =       0, .pmax =  103421 },
+	[ABP2030PG] = { .pmin =       0, .pmax =  206843 },
+	[ABP2060PG] = { .pmin =       0, .pmax =  413685 },
+	[ABP2100PG] = { .pmin =       0, .pmax =  689476 },
+	[ABP2150PG] = { .pmin =       0, .pmax = 1034214 },
+	[ABP2175PG] = { .pmin =       0, .pmax = 1206583 },
+};
+
+static int abp2_get_measurement(struct abp2_data *data)
+{
+	struct device *dev = data->dev;
+	int ret;
+
+	memset(data->rx_buf, 0, sizeof(data->rx_buf));
+	reinit_completion(&data->completion);
+
+	ret = data->ops->write(data, ABP2_CMD_SYNC, ABP2_PKT_SYNC_LEN);
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * either use the EOC interrupt if it was enabled or
+	 * wait 5ms for the conversion
+	 */
+	if (data->irq > 0) {
+		ret = wait_for_completion_timeout(&data->completion, HZ);
+		if (!ret) {
+			dev_err(dev, "timeout waiting for EOC interrupt\n");
+			return -ETIMEDOUT;
+		}
+	} else {
+		fsleep(5 * USEC_PER_MSEC);
+	}
+
+	ret = data->ops->read(data, ABP2_CMD_NOP, ABP2_PKT_NOP_LEN);
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * status byte flags
+	 *  bit7 SANITY_CHK     - must always be 0
+	 *  bit6 ABP2_ST_POWER  - 1 if device is powered
+	 *  bit5 ABP2_ST_BUSY   - 1 if device has no new conversion ready
+	 *  bit4 SANITY_CHK     - must always be 0
+	 *  bit3 SANITY_CHK     - must always be 0
+	 *  bit2 MEMORY_ERR     - 1 if integrity test has failed
+	 *  bit1 SANITY_CHK     - must always be 0
+	 *  bit0 MATH_ERR       - 1 during internal math saturation err
+	 */
+
+	if (data->rx_buf[0] == (ABP2_ST_POWER | ABP2_ST_BUSY))
+		return -EBUSY;
+
+	if (data->rx_buf[0] != ABP2_ST_POWER) {
+		dev_err(data->dev,
+			"unexpected status byte 0x%02x\n", data->rx_buf[0]);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static irqreturn_t abp2_eoc_handler(int irq, void *private)
+{
+	struct abp2_data *data = private;
+
+	complete(&data->completion);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t abp2_trigger_handler(int irq, void *private)
+{
+	int ret;
+	struct iio_poll_func *pf = private;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct abp2_data *data = iio_priv(indio_dev);
+
+	ret = abp2_get_measurement(data);
+	if (ret < 0)
+		goto err;
+
+	data->scan.chan[0] = get_unaligned_be24(&data->rx_buf[1]);
+	data->scan.chan[1] = get_unaligned_be24(&data->rx_buf[4]);
+
+	iio_push_to_buffers_with_ts(indio_dev, &data->scan, sizeof(data->scan),
+				    iio_get_time_ns(indio_dev));
+
+err:
+	iio_trigger_notify_done(indio_dev->trig);
+
+	return IRQ_HANDLED;
+}
+
+/*
+ * IIO ABI expects
+ * value = (conv + offset) * scale
+ *
+ * datasheet provides the following formula for determining the temperature
+ * temp[C] = conv * a + b
+ *   where a = 200/16777215; b = -50
+ *
+ *  temp[C] = (conv + (b/a)) * a * (1000)
+ *  =>
+ *  scale = a * 1000 = .0000119209296 * 1000 = .01192092966562
+ *  offset = b/a = -50 * 16777215 / 200 = -4194303.75
+ *
+ *  based on the datasheet
+ *  pressure = (conv - Omin) * Q + Pmin =
+ *          ((conv - Omin) + Pmin/Q) * Q
+ *  =>
+ *  scale = Q = (Pmax - Pmin) / (Omax - Omin)
+ *  offset = Pmin/Q - Omin = Pmin * (Omax - Omin) / (Pmax - Pmin) - Omin
+ */
+static int abp2_read_raw(struct iio_dev *indio_dev,
+			 struct iio_chan_spec const *channel, int *val,
+			 int *val2, long mask)
+{
+	struct abp2_data *data = iio_priv(indio_dev);
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = abp2_get_measurement(data);
+		if (ret < 0)
+			return ret;
+
+		switch (channel->type) {
+		case IIO_PRESSURE:
+			*val = get_unaligned_be24(&data->rx_buf[1]);
+			return IIO_VAL_INT;
+		case IIO_TEMP:
+			*val = get_unaligned_be24(&data->rx_buf[4]);
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_SCALE:
+		switch (channel->type) {
+		case IIO_TEMP:
+			*val = 0;
+			*val2 = 11920929;
+			return IIO_VAL_INT_PLUS_NANO;
+		case IIO_PRESSURE:
+			*val = data->p_scale;
+			*val2 = data->p_scale_dec;
+			return IIO_VAL_INT_PLUS_NANO;
+		default:
+			return -EINVAL;
+		}
+
+	case IIO_CHAN_INFO_OFFSET:
+		switch (channel->type) {
+		case IIO_TEMP:
+			*val = -4194304;
+			return IIO_VAL_INT;
+		case IIO_PRESSURE:
+			*val = data->p_offset;
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info abp2_info = {
+	.read_raw = &abp2_read_raw,
+};
+
+static const struct iio_chan_spec abp2_channels[] = {
+	{
+		.type = IIO_PRESSURE,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+					BIT(IIO_CHAN_INFO_SCALE) |
+					BIT(IIO_CHAN_INFO_OFFSET),
+		.scan_index = 0,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 24,
+			.storagebits = 32,
+			.endianness = IIO_CPU,
+		},
+	},
+	{
+		.type = IIO_TEMP,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE) |
+				      BIT(IIO_CHAN_INFO_OFFSET),
+		.scan_index = 1,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 24,
+			.storagebits = 32,
+			.endianness = IIO_CPU,
+		},
+	},
+	IIO_CHAN_SOFT_TIMESTAMP(2),
+};
+
+int abp2_common_probe(struct device *dev, const struct abp2_ops *ops, int irq)
+{
+	int ret;
+	struct abp2_data *data;
+	struct iio_dev *indio_dev;
+	const char *triplet;
+	s64 tmp;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	data = iio_priv(indio_dev);
+	data->dev = dev;
+	data->ops = ops;
+	data->irq = irq;
+
+	init_completion(&data->completion);
+
+	indio_dev->name = "abp2030pa";
+	indio_dev->info = &abp2_info;
+	indio_dev->channels = abp2_channels;
+	indio_dev->num_channels = ARRAY_SIZE(abp2_channels);
+
+	ret = devm_regulator_get_enable(dev, "vdd");
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "can't get and enable vdd supply\n");
+
+	ret = device_property_read_string(dev, "honeywell,pressure-triplet",
+					  &triplet);
+	if (ret) {
+		ret = device_property_read_u32(dev, "honeywell,pmin-pascal",
+					       &data->pmin);
+		if (ret)
+			return dev_err_probe(dev, ret,
+				   "honeywell,pmin-pascal could not be read\n");
+
+		ret = device_property_read_u32(dev, "honeywell,pmax-pascal",
+					       &data->pmax);
+		if (ret)
+			return dev_err_probe(dev, ret,
+				   "honeywell,pmax-pascal could not be read\n");
+	} else {
+		ret = device_property_match_property_string(dev,
+						   "honeywell,pressure-triplet",
+						   abp2_triplet_variants,
+						   ABP2_VARIANTS_MAX);
+		if (ret < 0)
+			return dev_err_probe(dev, -EINVAL,
+				     "honeywell,pressure-triplet is invalid\n");
+
+		data->pmin = abp2_range_config[ret].pmin;
+		data->pmax = abp2_range_config[ret].pmax;
+	}
+
+	if (data->pmin >= data->pmax)
+		return dev_err_probe(dev, -EINVAL,
+				     "pressure limits are invalid\n");
+
+	data->outmin = abp2_func_spec[data->function].output_min;
+	data->outmax = abp2_func_spec[data->function].output_max;
+
+	tmp = div_s64(((s64)(data->pmax - data->pmin)) * NANO,
+		      data->outmax - data->outmin);
+	data->p_scale = div_s64_rem(tmp, NANO, &data->p_scale_dec);
+
+	tmp = div_s64((s64)data->pmin * (s64)(data->outmax - data->outmin),
+		      (s64)(data->pmax - data->pmin)) - (s64)(data->outmin);
+	data->p_offset = tmp;
+
+	if (data->irq > 0) {
+		ret = devm_request_irq(dev, data->irq, abp2_eoc_handler,
+				       IRQF_TRIGGER_RISING,
+				       dev_name(dev),
+				       data);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					  "request irq %d failed\n", data->irq);
+	}
+
+	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
+					      abp2_trigger_handler, NULL);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "iio triggered buffer setup failed\n");
+
+	ret = devm_iio_device_register(dev, indio_dev);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "unable to register iio device\n");
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(abp2_common_probe, "IIO_HONEYWELL_ABP2030PA");
+
+MODULE_AUTHOR("Petre Rodan <petre.rodan@subdimension.ro>");
+MODULE_DESCRIPTION("Honeywell ABP2 pressure sensor core driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/iio/pressure/abp2030pa.h b/drivers/iio/pressure/abp2030pa.h
new file mode 100644
index 000000000000..5c1de390dbdd
--- /dev/null
+++ b/drivers/iio/pressure/abp2030pa.h
@@ -0,0 +1,77 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Honeywell ABP2 series pressure sensor driver
+ *
+ * Copyright (c) 2025 Petre Rodan <petre.rodan@subdimension.ro>
+ */
+
+#ifndef _ABP2030PA_H
+#define _ABP2030PA_H
+
+#include <linux/completion.h>
+#include <linux/types.h>
+
+#include <linux/iio/iio.h>
+
+#define ABP2_MEASUREMENT_RD_SIZE 7
+#define ABP2_CMD_NOP      0xf0
+#define ABP2_CMD_SYNC     0xaa
+#define ABP2_PKT_NOP_LEN  ABP2_MEASUREMENT_RD_SIZE
+#define ABP2_PKT_SYNC_LEN 3
+
+struct device;
+
+struct abp2_data;
+struct abp2_ops;
+
+enum abp2_func_id {
+	ABP2_FUNCTION_A,
+};
+
+/**
+ * struct abp2_data
+ * @dev: current device structure
+ * @ops: pointers for bus specific read and write functions
+ * @pmin: minimal pressure in pascal
+ * @pmax: maximal pressure in pascal
+ * @outmin: minimum raw pressure in counts (based on transfer function)
+ * @outmax: maximum raw pressure in counts (based on transfer function)
+ * @function: transfer function
+ * @p_scale: pressure scale
+ * @p_scale_dec: pressure scale, decimal number
+ * @p_offset: pressure offset
+ * @irq: end of conversion - applies only to the i2c sensor
+ * @completion: handshake from irq to read
+ * @scan: channel values for buffered mode
+ * @tx_buf: transmit buffer used during the SPI communication
+ * @rx_buf: raw data provided by sensor
+ */
+struct abp2_data {
+	struct device *dev;
+	const struct abp2_ops *ops;
+	s32 pmin;
+	s32 pmax;
+	u32 outmin;
+	u32 outmax;
+	enum abp2_func_id function;
+	int p_scale;
+	int p_scale_dec;
+	int p_offset;
+	int irq;
+	struct completion completion;
+	struct {
+		u32 chan[2];
+		aligned_s64 timestamp;
+	} scan;
+	u8 tx_buf[ABP2_MEASUREMENT_RD_SIZE] __aligned(IIO_DMA_MINALIGN);
+	u8 rx_buf[ABP2_MEASUREMENT_RD_SIZE] __aligned(IIO_DMA_MINALIGN);
+};
+
+struct abp2_ops {
+	int (*read)(struct abp2_data *data, u8 cmd, u8 nbytes);
+	int (*write)(struct abp2_data *data, u8 cmd, u8 nbytes);
+};
+
+int abp2_common_probe(struct device *dev, const struct abp2_ops *ops, int irq);
+
+#endif
diff --git a/drivers/iio/pressure/abp2030pa_i2c.c b/drivers/iio/pressure/abp2030pa_i2c.c
new file mode 100644
index 000000000000..f29a5494869c
--- /dev/null
+++ b/drivers/iio/pressure/abp2030pa_i2c.c
@@ -0,0 +1,87 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Honeywell ABP2 series pressure sensor driver
+ *
+ * Copyright (c) 2025 Petre Rodan <petre.rodan@subdimension.ro>
+ */
+
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/i2c.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/types.h>
+
+#include "abp2030pa.h"
+
+static int abp2_i2c_read(struct abp2_data *data, u8 unused, u8 nbytes)
+{
+	struct i2c_client *client = to_i2c_client(data->dev);
+	int ret;
+
+	if (nbytes > ABP2_MEASUREMENT_RD_SIZE)
+		return -EOVERFLOW;
+
+	ret = i2c_master_recv(client, data->rx_buf, nbytes);
+	if (ret < 0)
+		return ret;
+	if (ret != nbytes)
+		return -EIO;
+
+	return 0;
+}
+
+static int abp2_i2c_write(struct abp2_data *data, u8 cmd, u8 unused)
+{
+	struct i2c_client *client = to_i2c_client(data->dev);
+	u8 wdata[ABP2_PKT_SYNC_LEN] = { cmd };
+	int ret;
+
+	ret = i2c_master_send(client, wdata, ABP2_PKT_SYNC_LEN);
+	if (ret < 0)
+		return ret;
+	if (ret != ABP2_PKT_SYNC_LEN)
+		return -EIO;
+
+	return 0;
+}
+
+static const struct abp2_ops abp2_i2c_ops = {
+	.read = abp2_i2c_read,
+	.write = abp2_i2c_write,
+};
+
+static int abp2_i2c_probe(struct i2c_client *client)
+{
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
+		return -EOPNOTSUPP;
+
+	return abp2_common_probe(&client->dev, &abp2_i2c_ops, client->irq);
+}
+
+static const struct of_device_id abp2_i2c_match[] = {
+	{ .compatible = "honeywell,abp2030pa" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, abp2_i2c_match);
+
+static const struct i2c_device_id abp2_i2c_id[] = {
+	{ "abp2030pa" },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, abp2_i2c_id);
+
+static struct i2c_driver abp2_i2c_driver = {
+	.driver = {
+		.name = "abp2030pa",
+		.of_match_table = abp2_i2c_match,
+	},
+	.probe = abp2_i2c_probe,
+	.id_table = abp2_i2c_id,
+};
+module_i2c_driver(abp2_i2c_driver);
+
+MODULE_AUTHOR("Petre Rodan <petre.rodan@subdimension.ro>");
+MODULE_DESCRIPTION("Honeywell ABP2 pressure sensor i2c driver");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("IIO_HONEYWELL_ABP2030PA");
diff --git a/drivers/iio/pressure/abp2030pa_spi.c b/drivers/iio/pressure/abp2030pa_spi.c
new file mode 100644
index 000000000000..924fcb2fb690
--- /dev/null
+++ b/drivers/iio/pressure/abp2030pa_spi.c
@@ -0,0 +1,67 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Honeywell ABP2 series pressure sensor driver
+ *
+ * Copyright (c) 2025 Petre Rodan <petre.rodan@subdimension.ro>
+ */
+
+#include <linux/errno.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/spi/spi.h>
+#include <linux/types.h>
+
+#include "abp2030pa.h"
+
+static int abp2_spi_xfer(struct abp2_data *data, u8 cmd, u8 nbytes)
+{
+	struct spi_device *spi = to_spi_device(data->dev);
+	struct spi_transfer xfer;
+
+	if (nbytes > ABP2_MEASUREMENT_RD_SIZE)
+		return -EOVERFLOW;
+
+	data->tx_buf[0] = cmd;
+	xfer.tx_buf = data->tx_buf;
+	xfer.rx_buf = data->rx_buf;
+	xfer.len = nbytes;
+
+	return spi_sync_transfer(spi, &xfer, 1);
+}
+
+static const struct abp2_ops abp2_spi_ops = {
+	.read = abp2_spi_xfer,
+	.write = abp2_spi_xfer,
+};
+
+static int abp2_spi_probe(struct spi_device *spi)
+{
+	return abp2_common_probe(&spi->dev, &abp2_spi_ops, spi->irq);
+}
+
+static const struct of_device_id abp2_spi_match[] = {
+	{ .compatible = "honeywell,abp2030pa" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, abp2_spi_match);
+
+static const struct spi_device_id abp2_spi_id[] = {
+	{ "abp2030pa" },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, abp2_spi_id);
+
+static struct spi_driver abp2_spi_driver = {
+	.driver = {
+		.name = "abp2030pa",
+		.of_match_table = abp2_spi_match,
+	},
+	.probe = abp2_spi_probe,
+	.id_table = abp2_spi_id,
+};
+module_spi_driver(abp2_spi_driver);
+
+MODULE_AUTHOR("Petre Rodan <petre.rodan@subdimension.ro>");
+MODULE_DESCRIPTION("Honeywell ABP2 pressure sensor spi driver");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("IIO_HONEYWELL_ABP2030PA");

-- 
2.51.0


