Return-Path: <linux-iio+bounces-13310-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D3B9EAE93
	for <lists+linux-iio@lfdr.de>; Tue, 10 Dec 2024 11:50:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BA991889EFE
	for <lists+linux-iio@lfdr.de>; Tue, 10 Dec 2024 10:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A496226544;
	Tue, 10 Dec 2024 10:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="eDjCtYxK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482642253F7
	for <linux-iio@vger.kernel.org>; Tue, 10 Dec 2024 10:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733827613; cv=none; b=AJzZulnHJL+ILOPpWy6En0y2QtSYIN3xlpnHfriDyi+D5b5Smvz/J9mjoSleWKB3nwvytCJgwvD2aS/8gzYsubLwrsI8HjD9mzeemMW69aqxIk9CrkKVEpmWIa7bhOimtFsasq87PVE8KB2L+Ye/g1GFYJZitHY4aSTY5BFNQtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733827613; c=relaxed/simple;
	bh=dl8B5isqs0cpK6+0Gxa9yBzmXpvsMpKpjWXkbfyzLUU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FFISI3Eig/Xe9+HH7iQCjsgk9ChXrhkdmdUz6HdymmTrQ66Yuk02YVRMd5GgTyltsp1urE4jEBfvVPAjvzTSQZ917EyCakwC8moBcJj5O1O0GlNNaeIZUHnGm8YtI/6pL5PpM6PvXl+G4faOvG3HzPb+SRrOiAgc2nWFS/FdWPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=eDjCtYxK; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-434a736518eso59267135e9.1
        for <linux-iio@vger.kernel.org>; Tue, 10 Dec 2024 02:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733827609; x=1734432409; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MuYGelgUrcsjYaOSYK7sVWvHM7X1ualsJkTR9ux60ho=;
        b=eDjCtYxKacZyE6kNw8e3RiwYdXFmztfLnTykuujmicGuiAbw7FNXQilCpd3vnhGicT
         AM6tpVmCCuQ4XVZuiZsatsrzZLqdsvFPB2F2CephvYXFXWZA3FxlMEa6UZ0y0PCT/E7v
         be3PyauExg5wy4R0/e+D9YvyTkoObYSZSezKbzj2vKrscU5ZZa/J04oCgm3/Za07Bd1u
         wqkS/lVWBNRkmCCGbNP4EPUSFPp4W+AO4SJlEFWwFJwcecGSykyOjECFdFxNbTGLkfUx
         WZ7+3HM3s5H0Z5a1ixdTzqc2EtmjdNHaOeejOYsWHNe6WK+gK4xJosNAi5WDh1qRtBpH
         obPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733827609; x=1734432409;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MuYGelgUrcsjYaOSYK7sVWvHM7X1ualsJkTR9ux60ho=;
        b=cvPuDKk56zPIcCcSrOAX/NQt6Ow9TUmXHUl6MgEgCRg58xyUXPLLS80Q4hLJ9TyTd9
         1BNjtOfNg/ZbHg/j4WkmnXXZFZ5E663MjYWTz9pVuEbZmwGLhGJxrHQEZttUJ7y5d467
         QQUoA4VgDCzOkYZjH9iSWKw022Olh+wMiGys65hj58ifLPfNUVXjq8F64/R/0tt3hrB9
         4InsABMk/kNyN5PyBHrqB5uvyrpTMXisByV7Nl68/87JeGQ+t6pl4vYD2OwF9jDsAHxS
         EJWzv4RTT0zKzO8VbyISnyzH14nJitQRsW/ZkjoWtZ7Q3xJMIppsUPI+0UHoQJXz9ll2
         NrMA==
X-Forwarded-Encrypted: i=1; AJvYcCU1dfH2vNUnpqxOVpRqT05jqt35Pyqe2cX2ZjCEAxrfFwzejJD4S9/26lZF6n0UvILPxQd8VaQHcE0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/Okycswi29Go6NaoVLoeihF+DMDABo418+GFkj/kt6p30rS+S
	vP7Mz7QD+KJ+wtlSZZvg62ivpGDUnpCTpMGUOHoHx+N3w8Yo9eeHBdvYuumER2k=
X-Gm-Gg: ASbGnctry5C4PTqaC6vVYUm9pe5uHCpCpD6p63a+9On93cV7hhfe+2UTIQ2f+AFfiYY
	/wqBhJRxzKGEutjiAf0eqUK07iqg3QLEbPOb0Cv7bfHEu7wdIgIptA/RTF0CIly4uYmLTa0Ad1k
	cOUMMnIc+kZjyGzp0uKl3R8BTVELFvv2r5fUAeO8QHyrRCB/zqK+J+PggVWMzBnat7QJ9oJCxaN
	BQTjSxak42fFOmAmtaO3ri8NwNXMBu+yBN7G6We071H2o1iSuk4McVa7qmmiyMsp4vREUZgzwat
	CA==
X-Google-Smtp-Source: AGHT+IFyW6rQNXo0Ny2uhwpJhbK3Sp5sDIEIf/a6FYrk1ZEAWpFVZIm9PemZcuBaqaqQuSQAAh6JYQ==
X-Received: by 2002:a05:600c:3503:b0:434:f739:7cd9 with SMTP id 5b1f17b1804b1-434fff3dd22mr39545355e9.9.1733827609252;
        Tue, 10 Dec 2024 02:46:49 -0800 (PST)
Received: from [127.0.1.1] (frhb82016ds.ikexpress.com. [185.246.87.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434f2d08564sm94543645e9.12.2024.12.10.02.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 02:46:48 -0800 (PST)
From: Guillaume Stols <gstols@baylibre.com>
Date: Tue, 10 Dec 2024 10:46:46 +0000
Subject: [PATCH v2 6/9] iio: adc: adi-axi-adc: Add support for AD7606
 register writing
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241210-ad7606_add_iio_backend_software_mode-v2-6-6619c3e50d81@baylibre.com>
References: <20241210-ad7606_add_iio_backend_software_mode-v2-0-6619c3e50d81@baylibre.com>
In-Reply-To: <20241210-ad7606_add_iio_backend_software_mode-v2-0-6619c3e50d81@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Nuno Sa <nuno.sa@analog.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 devicetree@vger.kernel.org, dlechner@baylibre.com, jstephan@baylibre.com, 
 aardelean@baylibre.com, adureghello@baylibre.com, 
 Guillaume Stols <gstols@baylibre.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733827603; l=5558;
 i=gstols@baylibre.com; s=20240417; h=from:subject:message-id;
 bh=dl8B5isqs0cpK6+0Gxa9yBzmXpvsMpKpjWXkbfyzLUU=;
 b=4n0W5kzyku2wLD8xi8+1pDXXO992R7e2WDCfxngNm+yKusBtmHCG2Iresog+mp2k4gSMf89bx
 5Hcml4eWaXKCUFe0/E5ZVBSKZGw/lgKmneYUXOGlRScm1oq0r3ITF3C
X-Developer-Key: i=gstols@baylibre.com; a=ed25519;
 pk=XvMm5WHuV67sGYOJZqIYzXndbaJOlNd8Q6li6vnb4Cs=

Since we must access the bus parallel bus using a custom procedure,
let's add a specialized compatible, and define specialized callbacks for
writing the registers using the parallel interface.

Signed-off-by: Guillaume Stols <gstols@baylibre.com>
---
 drivers/iio/adc/ad7606_bi.h   |  16 +++++++
 drivers/iio/adc/adi-axi-adc.c | 100 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 116 insertions(+)

diff --git a/drivers/iio/adc/ad7606_bi.h b/drivers/iio/adc/ad7606_bi.h
new file mode 100644
index 000000000000..9ade23ec61dd
--- /dev/null
+++ b/drivers/iio/adc/ad7606_bi.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (c) 2010-2024 Analog Devices Inc.
+ * Copyright (c) 2024 Baylibre, SAS
+ */
+#ifndef __LINUX_PLATFORM_DATA_AD7606_H__
+#define __LINUX_PLATFORM_DATA_AD7606_H__
+
+#include <linux/iio/backend.h>
+
+struct ad7606_platform_data {
+	int (*bus_reg_read)(struct iio_backend *back, u32 reg, u32 *val);
+	int (*bus_reg_write)(struct iio_backend *back, u32 reg, u32 val);
+};
+
+#endif /* __LINUX_PLATFORM_DATA_AD7606_H__ */
diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
index 7ff636643e56..b8bcf89417b0 100644
--- a/drivers/iio/adc/adi-axi-adc.c
+++ b/drivers/iio/adc/adi-axi-adc.c
@@ -27,6 +27,7 @@
 #include <linux/iio/buffer.h>
 #include <linux/iio/iio.h>
 
+#include "ad7606_bi.h"
 /*
  * Register definitions:
  *   https://wiki.analog.com/resources/fpga/docs/axi_adc_ip#register_map
@@ -73,6 +74,12 @@
 #define ADI_AXI_ADC_REG_DELAY(l)		(0x0800 + (l) * 0x4)
 #define   AXI_ADC_DELAY_CTRL_MASK		GENMASK(4, 0)
 
+#define ADI_AXI_REG_CONFIG_WR			0x0080
+#define ADI_AXI_REG_CONFIG_RD			0x0084
+#define ADI_AXI_REG_CONFIG_CTRL			0x008c
+#define   ADI_AXI_REG_CONFIG_CTRL_READ		0x03
+#define   ADI_AXI_REG_CONFIG_CTRL_WRITE		0x01
+
 #define ADI_AXI_ADC_MAX_IO_NUM_LANES		15
 
 #define ADI_AXI_REG_CHAN_CTRL_DEFAULTS		\
@@ -80,6 +87,11 @@
 	 ADI_AXI_REG_CHAN_CTRL_FMT_EN |		\
 	 ADI_AXI_REG_CHAN_CTRL_ENABLE)
 
+/* AD7606's specific */
+#define AD7606_REG_READ_BIT			0x8000
+#define AD7606_REG_ADDRESS_MASK			0xff00
+#define AD7606_REG_VALUE_MASK			0x00ff
+
 struct axi_adc_info {
 	unsigned int version;
 	const struct iio_backend_info *backend_info;
@@ -313,6 +325,80 @@ static struct iio_buffer *axi_adc_request_buffer(struct iio_backend *back,
 	return iio_dmaengine_buffer_setup(st->dev, indio_dev, dma_name);
 }
 
+static int axi_adc_raw_write(struct iio_backend *back, void *buf, unsigned int len)
+{
+	struct adi_axi_adc_state *st = iio_backend_get_priv(back);
+	u32 data;
+	u32 *bdata = buf;
+
+	data = *bdata;
+	regmap_write(st->regmap, ADI_AXI_REG_CONFIG_WR, data);
+	regmap_write(st->regmap, ADI_AXI_REG_CONFIG_CTRL,
+		     ADI_AXI_REG_CONFIG_CTRL_WRITE);
+	usleep_range(50, 100);
+	regmap_write(st->regmap, ADI_AXI_REG_CONFIG_CTRL, 0x00);
+	usleep_range(50, 100);
+
+	return 0;
+}
+
+static int axi_adc_raw_read(struct iio_backend *back, void *buf, unsigned int len)
+{
+	struct adi_axi_adc_state *st = iio_backend_get_priv(back);
+	u32 *bdata = buf;
+
+	regmap_write(st->regmap, ADI_AXI_REG_CONFIG_CTRL,
+		     ADI_AXI_REG_CONFIG_CTRL_READ);
+	usleep_range(50, 100);
+	regmap_read(st->regmap, ADI_AXI_REG_CONFIG_RD, bdata);
+	regmap_write(st->regmap, ADI_AXI_REG_CONFIG_CTRL, 0x00);
+	usleep_range(50, 100);
+
+	return 0;
+}
+
+static int ad7606_bi_reg_read(struct iio_backend *back, u32 reg, u32 *val)
+{
+	struct adi_axi_adc_state *st = iio_backend_get_priv(back);
+	u32 buf;
+
+	guard(mutex)(&st->lock);
+
+	/*
+	 * The address is written on the highest weight byte, and the MSB set at 1
+	 * indicates a read operation.
+	 */
+	buf = FIELD_PREP(AD7606_REG_ADDRESS_MASK, reg) | AD7606_REG_READ_BIT;
+	axi_adc_raw_write(back, &buf, sizeof(buf));
+	axi_adc_raw_read(back, val, 4);
+
+	/* Write 0x0 on the bus to get back to ADC mode */
+	buf = 0;
+	axi_adc_raw_write(back, &buf, sizeof(buf));
+	return 0;
+}
+
+static int ad7606_bi_reg_write(struct iio_backend *back, u32 reg, u32 val)
+{
+	struct adi_axi_adc_state *st = iio_backend_get_priv(back);
+	u32 buf;
+
+	guard(mutex)(&st->lock);
+
+	/* Read any register to switch to register mode */
+	buf = 0xaf00;
+	axi_adc_raw_write(back, &buf, sizeof(buf));
+
+	buf = FIELD_PREP(AD7606_REG_ADDRESS_MASK, reg) | FIELD_PREP(AD7606_REG_VALUE_MASK, val);
+	axi_adc_raw_write(back, &buf, sizeof(buf));
+
+	/* Write 0x0 on the bus to get back to ADC mode */
+	buf = 0;
+	axi_adc_raw_write(back, &buf, sizeof(buf));
+
+	return 0;
+}
+
 static void axi_adc_free_buffer(struct iio_backend *back,
 				struct iio_buffer *buffer)
 {
@@ -487,9 +573,23 @@ static const struct axi_adc_info adc_generic = {
 	.backend_info = &adi_axi_adc_generic,
 };
 
+static const struct ad7606_platform_data ad7606_pdata = {
+	.bus_reg_read = ad7606_bi_reg_read,
+	.bus_reg_write = ad7606_bi_reg_write,
+};
+
+static const struct axi_adc_info adc_ad7606 = {
+	.version = ADI_AXI_PCORE_VER(10, 0, 'a'),
+	.backend_info = &adi_axi_adc_generic,
+	.bus_controller = true,
+	.pdata = &ad7606_pdata,
+	.pdata_sz = sizeof(ad7606_pdata),
+};
+
 /* Match table for of_platform binding */
 static const struct of_device_id adi_axi_adc_of_match[] = {
 	{ .compatible = "adi,axi-adc-10.0.a", .data = &adc_generic },
+	{ .compatible = "adi,axi-ad7606x", .data = &adc_ad7606 },
 	{ /* end of list */ }
 };
 MODULE_DEVICE_TABLE(of, adi_axi_adc_of_match);

-- 
2.34.1


