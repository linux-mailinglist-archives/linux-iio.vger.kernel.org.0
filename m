Return-Path: <linux-iio+bounces-21214-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31156AF05DA
	for <lists+linux-iio@lfdr.de>; Tue,  1 Jul 2025 23:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F35653B74A8
	for <lists+linux-iio@lfdr.de>; Tue,  1 Jul 2025 21:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7573E309DB1;
	Tue,  1 Jul 2025 21:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="f9Hl3fao"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5DB3093B0
	for <linux-iio@vger.kernel.org>; Tue,  1 Jul 2025 21:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751405985; cv=none; b=k/j+OLWA2/EGjysbeaW5uA+dBUuS5ome0lQ08LfpB0oq4p0Ma7l2u1lMr2xmOgXSsO0wgLQRRVDRe2UYtomg8zQvMlx+EIVdqMb+swxT2f3qQVj45gSJswHjhbtguJD8vFkQ5w8v+n/nvGiuyZpCNZqSZna8btcHRJQBvzHowOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751405985; c=relaxed/simple;
	bh=ODK9s/KesQY1q9pgllRcE+1udpiAQ4WyUQ8s8zoiSYI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HTBLsgN0TnDUjDOTgnxMYQT814pbzadsHrJtNUcwERc8Vl4WTLWWT9YNNdE8gWzCt4PVVTxrw/CQsUyWKptLdW0xSS5vIYWBdKLT6VqiVRNOmtBU3yViQ3PjOA7COKPamnISd775jo21BVvF01UlPFISSJ8ESbxGs0iu/09+3KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=f9Hl3fao; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-4079f80ff0fso4158188b6e.1
        for <linux-iio@vger.kernel.org>; Tue, 01 Jul 2025 14:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751405982; x=1752010782; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KXbJNHObp0yLymcgJegYRlIqp8GCgqIbPNCpluvKCfU=;
        b=f9Hl3faoRtW6GfuiVCazIXVefkfvJdhdxmYRplxpftehz9Z96KNha6zCApCzSY9NZ5
         ut8Vs5GtKLdKeHXA7SXB1evYPAb07KQR4Lq0/c2acW1/6+R3SO/alA3gZoqmpErfPUuK
         JMdrUUr3MSzEmnxqNnr04XeNpn4YbjuWmzI/E+plU60TIOr1YincQaL5hHr1KS5Mrk/0
         r9qnau1sSpE6sF9nxOD2xJ5Ztm4bReR5CQi75pDf4N+BDSStIoKBJDc6nJfIFimvYEVo
         a6mxyJAnEFeTW1spcpJ8cqe/oy7+xI6CVIVpuzA242yYhg0Fjsn4pkKvDEok4Ils+jgd
         RWGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751405982; x=1752010782;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KXbJNHObp0yLymcgJegYRlIqp8GCgqIbPNCpluvKCfU=;
        b=aEn4s4y1Vxjc5XXqiXUfvbUUN0LRBZ3xJVybjrzxoJgx2/NcnsmACFg8xJ6/T2IUkz
         5fQgtKbtJKTTVq39OQ1cXKRVKMkHkMAZ7YLjv4qTP0efeKAFr3gp3Ay1CtjLOkKARzw2
         P7A4fnfqHD+gSiGXk5Oj63gyLQUMuxO/BNchvciZIpu7e/YKmKuszJsQhX0KklaK3d0b
         FDUIlGOjEis2+Ogk7AB4dsrpsw5QUHZYYR4dJb3M8gErue9eh9av0Kl7+VC125qrt9+W
         yU+v6EJiz0IB5j42/WUucRVLKgbaT15cenDXg5Fqir9LEn8K7DxPmQiKEhvZG29Pr+Ww
         u8IA==
X-Gm-Message-State: AOJu0YyZumhC6wZg6y5NDwox5xnKq8KImJKUuV7Ug7/bQFu9f85u6eXx
	qO0GUTYmwvKZ8MsXtdsWfr1zFRkI6ZKH+FgljWJRL/pD56aSs0DWcwZZigqWEAUo3Yc=
X-Gm-Gg: ASbGncumpXyMlSP/h1G1RonBBUvkaFLD8AoL3KuwHI1zIgiWEMdx2jdaP8lJAE4qxGS
	U6CRH+qVmD7pPUmE9iEZw3pXnqcMUuGzhHtqjArZCoK5vk2hSaJnOBUHK0vSWES4U+GkoLuqHfu
	SZxRQ0jxRauShsU7d+Z+D2i89EA5a6fZS5XYdViQT1bsJ7jmRs8ckYT1MD/rv3EZa/A44688NsU
	P/4lGOqdafx9cDqysDOongcguZ9qrK/en/RI6cbXSlMxDxi0remc/dRUX4RLV4AIs5fldVvXfZG
	z4rFv4EwZQ92wPDJW+ADnDTTTS+8GK73Nzuvgr2iiQ5OYrERbK7QbUQXW6N0pckdbb4d
X-Google-Smtp-Source: AGHT+IFSICywf5bWBOPamju0WA7wIyhluWkzttRu9z5id5CRQeysZo2qvdLXqEZmvJHwm6ndE3fOkA==
X-Received: by 2002:a05:6808:4f1f:b0:406:69b5:36da with SMTP id 5614622812f47-40b8aabd9f3mr157850b6e.16.1751405981676;
        Tue, 01 Jul 2025 14:39:41 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:70a7:ca49:a250:f1d5])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40b3243deeesm2288335b6e.48.2025.07.01.14.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 14:39:41 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 01 Jul 2025 16:37:58 -0500
Subject: [PATCH v3 10/12] spi: offload trigger: add ADI Util Sigma-Delta
 SPI driver
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250701-iio-adc-ad7173-add-spi-offload-support-v3-10-42abb83e3dac@baylibre.com>
References: <20250701-iio-adc-ad7173-add-spi-offload-support-v3-0-42abb83e3dac@baylibre.com>
In-Reply-To: <20250701-iio-adc-ad7173-add-spi-offload-support-v3-0-42abb83e3dac@baylibre.com>
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Mark Brown <broonie@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-spi@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4356; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=ODK9s/KesQY1q9pgllRcE+1udpiAQ4WyUQ8s8zoiSYI=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoZFV9xeYLLeB0HZi/XyTdaJ2M2m8jxczPEsMWe
 2lsSTjigEiJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaGRVfQAKCRDCzCAB/wGP
 wJv9CACborVMse/liFlC7Ut9b03+zhxm0nqzlgwfdEp+Q9qYaXvEGHwNlKfRENLS6CiW0+kLx49
 YijGeDsUs3DUguHEFD1FhN8ntHvckuv4BNtPGtdcalA54FXimf588P4wOkVz2mUnVOv8IUJBUr3
 JtJ7ZVXIcsa5RSOBAY2A2C23/GBHgayDKQ7KaW1Z4S6KPC3fvPGDksmTI/oq72DYJIMWbYDHMg5
 x+Xi7rUxoLgzTV7bQKmwxIWhLwg76FKXwXm7nD4xaYb/QBGyPUpSb+IJOjVZDowdzmt/9jTpA/m
 uq8wAB+x/dT0LbzZnQsQvYyqAK7FUnkS1te3Iyrij1V8AgIZ
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add a new driver for the ADI Util Sigma-Delta SPI FPGA IP core.

This is used to trigger a SPI offload based on a RDY signal from an ADC
while masking out other signals on the same line.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 MAINTAINERS                                        |  2 +-
 drivers/spi/Kconfig                                |  5 ++
 drivers/spi/Makefile                               |  1 +
 .../spi/spi-offload-trigger-adi-util-sigma-delta.c | 62 ++++++++++++++++++++++
 4 files changed, 69 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 60ba572be7f5b48c0ab1d0d9724e19e335e8761b..4ed4977deb6ddc545be39b5c1d5e9959e9fe64cf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23357,7 +23357,7 @@ F:	include/linux/mtd/spi-nor.h
 
 SPI OFFLOAD
 R:	David Lechner <dlechner@baylibre.com>
-F:	drivers/spi/spi-offload-trigger-pwm.c
+F:	drivers/spi/spi-offload-trigger-*.c
 F:	drivers/spi/spi-offload.c
 F:	include/linux/spi/offload/
 K:	spi_offload
diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index c51da3fc3604977b05388687e5e64a58370186c4..e69f060d3875c168a2dc701a372e47b8ffd33268 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -1355,6 +1355,11 @@ if SPI_OFFLOAD
 
 comment "SPI Offload triggers"
 
+config SPI_OFFLOAD_TRIGGER_ADI_UTIL_SD
+	tristate "SPI offload trigger using ADI sigma-delta utility"
+	help
+	  SPI offload trigger from ADI sigma-delta utility FPGA IP block.
+
 config SPI_OFFLOAD_TRIGGER_PWM
 	tristate "SPI offload trigger using PWM"
 	depends on PWM
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 4ea89f6fc531625060255ecff237470927e1f041..51f9f16ed734424ff10672a04f2ec166dc637e0b 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -170,3 +170,4 @@ obj-$(CONFIG_SPI_SLAVE_SYSTEM_CONTROL)	+= spi-slave-system-control.o
 
 # SPI offload triggers
 obj-$(CONFIG_SPI_OFFLOAD_TRIGGER_PWM)	+= spi-offload-trigger-pwm.o
+obj-$(CONFIG_SPI_OFFLOAD_TRIGGER_ADI_UTIL_SD) += spi-offload-trigger-adi-util-sigma-delta.o
diff --git a/drivers/spi/spi-offload-trigger-adi-util-sigma-delta.c b/drivers/spi/spi-offload-trigger-adi-util-sigma-delta.c
new file mode 100644
index 0000000000000000000000000000000000000000..8468c773713a3d203b2e668f340ee3f477b8fb6c
--- /dev/null
+++ b/drivers/spi/spi-offload-trigger-adi-util-sigma-delta.c
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2025 Analog Devices Inc.
+ * Copyright (C) 2025 BayLibre, SAS
+ */
+
+#include <linux/clk.h>
+#include <linux/dev_printk.h>
+#include <linux/err.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+#include <linux/spi/offload/provider.h>
+#include <linux/spi/offload/types.h>
+#include <linux/types.h>
+
+static bool adi_util_sigma_delta_match(struct spi_offload_trigger *trigger,
+				       enum spi_offload_trigger_type type,
+				       u64 *args, u32 nargs)
+{
+	return type == SPI_OFFLOAD_TRIGGER_DATA_READY && nargs == 0;
+}
+
+static const struct spi_offload_trigger_ops adi_util_sigma_delta_ops = {
+	.match = adi_util_sigma_delta_match,
+};
+
+static int adi_util_sigma_delta_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct spi_offload_trigger_info info = {
+		.fwnode = dev_fwnode(dev),
+		.ops = &adi_util_sigma_delta_ops,
+	};
+	struct clk *clk;
+
+	clk = devm_clk_get_enabled(dev, NULL);
+	if (IS_ERR(clk))
+		return dev_err_probe(dev, PTR_ERR(clk), "Failed to get clock\n");
+
+	return devm_spi_offload_trigger_register(dev, &info);
+}
+
+static const struct of_device_id adi_util_sigma_delta_of_match_table[] = {
+	{ .compatible = "adi,util-sigma-delta-spi", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, adi_util_sigma_delta_of_match_table);
+
+static struct platform_driver adi_util_sigma_delta_driver = {
+	.probe  = adi_util_sigma_delta_probe,
+	.driver = {
+		.name = "adi-util-sigma-delta-spi",
+		.of_match_table = adi_util_sigma_delta_of_match_table,
+	},
+};
+module_platform_driver(adi_util_sigma_delta_driver);
+
+MODULE_AUTHOR("David Lechner <dlechner@baylibre.com>");
+MODULE_DESCRIPTION("ADI Sigma-Delta SPI offload trigger utility driver");
+MODULE_LICENSE("GPL");

-- 
2.43.0


