Return-Path: <linux-iio+bounces-20102-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A581DAC9F8A
	for <lists+linux-iio@lfdr.de>; Sun,  1 Jun 2025 19:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F356A173A96
	for <lists+linux-iio@lfdr.de>; Sun,  1 Jun 2025 17:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDCAA202C5A;
	Sun,  1 Jun 2025 17:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WfbQ6fxo"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE301FDE14;
	Sun,  1 Jun 2025 17:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748798519; cv=none; b=LaDx67Qio4YeJemAKMh6UVYkG3xUXZQr1fMYo8nUT2NLYn8AFhqZhRkjlTg/IQxeBWvCBSMBZC9cIEaNKLGjTKJprIn5Vvbb7LwtP0POAIN9R7sujsbl1JudLA2y5q4P9y54dQGIZfiyagUPIHYqNVfkc8MOeiKaxz06gLRNVYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748798519; c=relaxed/simple;
	bh=FLCiNFEJhCBqsS4uuQy/IOw+OqzT68jylHnSa8SjyoE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GimZ+W/Ssb/kGCFdATbHdGGPgtgHsqawh7WvOo2Ndg14CWXwbD8W8Ga+qtHM8aNvsOMaKqhhLARjWQoF9tClpGYu5m3KCE7KCGO2oyCCEWItEqJj6G+K69ivIOuiCLTnXOOIOmzm6vGMTl5CvQrGsQLK9zarkS99Sn6riTS0M1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WfbQ6fxo; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a4e6a0c274so469722f8f.2;
        Sun, 01 Jun 2025 10:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748798516; x=1749403316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=blweJXXwwSLiO3JnYOJAL6xAeYpzVKObXYLqYlzkNr0=;
        b=WfbQ6fxoIy1N9H4O1EnuJLc+S8/x9sec/hE7PhyoPOzlxK7KJLNKmC9JpIk1aKRYRP
         6IU1nrsYWfSF5P4XGUwO5tXq1gOkc8+0qHQwPSVA8i3Xd8bqnckAWicM0Hd92gbfC5FE
         1tFh8pkBBe+EtMzgaJiene+7omYkUMjw+iG5Yoek4ynAaNRhy7jOpMGVqADlb5unrq5U
         85kBCamM2BbhAl4E89t3TgNqOd/SswgiiUViYsFBsS4pBuw4LIP7kS49nab7M49w/kDf
         m3Zv9u1TDF+w9r3Te1zNWfSm7JnwIjm0/MeiWcRlKOtkhRPyJoG4r3nFSIKKle54V6N/
         Ooow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748798516; x=1749403316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=blweJXXwwSLiO3JnYOJAL6xAeYpzVKObXYLqYlzkNr0=;
        b=FHsz7fqM16QkwzKndtgozNMAziqOo2t/BTpNDbVY7hcDlaB1RtCjGchs6b+z1vsaxZ
         7EG/7UCpim7Euu+oCms9bgdSQyIAnxe42iXObp7ISnJ2oWJF0l6fAfXkSt0P+1xPaTg9
         BsiV7inNsUL1DOSwqThk5WdwCHL72Z7ogWp+BxVeFFTzUWx1QeNs/ri6cyDqhzxwBqCe
         KcA394+bHB15pWwZhBXFHEc3FxQOmrlev1YzpoIy/oRVV6N5IyBF0M6wdhZYwk8ab4YJ
         oGX5nU/hHFZlBAtJeID/V6HDwx/qsnfwclC1lfa9wHkwKQKe8BD9SHq8BFv8XVsF0LWP
         5Ruw==
X-Forwarded-Encrypted: i=1; AJvYcCUG6tc4C8FYlcjxUuDuO7QriN+HzZ3l0/iD53iLFZRtEf/8QttG+oHaj4iIYm7Vxwy2XlD3LV2sGJI=@vger.kernel.org, AJvYcCWgRP38jocqgUX9DA762FQDRwWU5A0XUe/Icb3QqN8f6WIzGZL8vMPiUITuIeiO9bUxlo0G7lm4R0/NXLB/@vger.kernel.org, AJvYcCXV5v/da1vY+iRaP2dXzs1rAVFKQ33GjiSUo63u3Q5SgY85gu2tL3VgmvMWmXCsrtynI1HqB8yyjkRO@vger.kernel.org
X-Gm-Message-State: AOJu0YyBrx3T1ZofxukC9gRb8WXOLmawivkGEb+s4jzik77UW7FXQbkr
	APluJ4o0nBf5XjW60Mho6O8avq0oAp5YakjXpDYTQmHu9HLQclnF/DNJ
X-Gm-Gg: ASbGncv/iWW03WOpsDfApE6aQ1WuY+zrCDaBwpzTtV3OQQeI7FMhydeMX58OxZ0zYii
	BE2TywGZvD/fOauF/9uReIjQabVt7tGA4n9iksxfKCazkl907vVaPE4pJKe5BhHr5F1o5bMwlXw
	nDC6h1GXewUAImLlIphiFiOeCmr3QEfbgrmrGUnMtB5KUWIy24cwTlkG+rOUUExPNjVlLhIN24I
	36FB6JAcPiRmF3VpzF2Iy16pnP4KIg78E++d+HSjssEnxbQvntLazb4Gs08AunnkDl0XihESwM1
	A2uIBKgQdLiMSrW6oc/69JRWumqnXrjMPAAV9K68lvPkD6THE34C0RlcB18bInIulmE9S4FPyCM
	9JGgA1DpF470HyR+LQq/LpA==
X-Google-Smtp-Source: AGHT+IFMHynzR/JIyE0nXoBYpaMteY30D9dIfPggxHAsSAKB+ojoT4LJ60VB700RM2TBXmo6bGrzrw==
X-Received: by 2002:a05:6000:3113:b0:3a3:6ab0:8863 with SMTP id ffacd0b85a97d-3a4f7ac570amr2931587f8f.16.1748798515835;
        Sun, 01 Jun 2025 10:21:55 -0700 (PDT)
Received: from localhost.localdomain (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4f009f9d6sm11890444f8f.84.2025.06.01.10.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Jun 2025 10:21:55 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	corbet@lwn.net,
	lucas.p.stankus@gmail.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	bagasdotme@gmail.com
Cc: l.rubusch@gmail.com,
	linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 05/11] iio: accel: adxl313: prepare interrupt handling
Date: Sun,  1 Jun 2025 17:21:33 +0000
Message-Id: <20250601172139.59156-6-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250601172139.59156-1-l.rubusch@gmail.com>
References: <20250601172139.59156-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Evaluate the devicetree property for an optional interrupt line, and
configure the interrupt mapping accordingly. When no interrupt line
is defined in the devicetree, keep the FIFO in bypass mode as before.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl313.h      | 13 +++++++++
 drivers/iio/accel/adxl313_core.c | 49 +++++++++++++++++++++++++++++++-
 2 files changed, 61 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/adxl313.h b/drivers/iio/accel/adxl313.h
index 9bf2facdbf87..ab6b9e11fde4 100644
--- a/drivers/iio/accel/adxl313.h
+++ b/drivers/iio/accel/adxl313.h
@@ -21,7 +21,9 @@
 #define ADXL313_REG_ACT_INACT_CTL	0x27
 #define ADXL313_REG_BW_RATE		0x2C
 #define ADXL313_REG_POWER_CTL		0x2D
+#define ADXL313_REG_INT_ENABLE		0x2E
 #define ADXL313_REG_INT_MAP		0x2F
+#define ADXL313_REG_INT_SOURCE		0x30
 #define ADXL313_REG_DATA_FORMAT		0x31
 #define ADXL313_REG_DATA_AXIS(index)	(0x32 + ((index) * 2))
 #define ADXL313_REG_FIFO_CTL		0x38
@@ -45,6 +47,17 @@
 #define ADXL313_SPI_3WIRE		BIT(6)
 #define ADXL313_I2C_DISABLE		BIT(6)
 
+#define ADXL313_INT_OVERRUN		BIT(0)
+#define ADXL313_INT_WATERMARK		BIT(1)
+#define ADXL313_INT_INACTIVITY		BIT(3)
+#define ADXL313_INT_ACTIVITY		BIT(4)
+#define ADXL313_INT_DREADY		BIT(7)
+
+#define ADXL313_REG_FIFO_CTL_MODE_MSK		GENMASK(7, 6)
+
+#define ADXL313_FIFO_BYPASS			0
+#define ADXL313_FIFO_STREAM			2
+
 extern const struct regmap_access_table adxl312_readable_regs_table;
 extern const struct regmap_access_table adxl313_readable_regs_table;
 extern const struct regmap_access_table adxl314_readable_regs_table;
diff --git a/drivers/iio/accel/adxl313_core.c b/drivers/iio/accel/adxl313_core.c
index 6170c9daa30f..31ce1b218488 100644
--- a/drivers/iio/accel/adxl313_core.c
+++ b/drivers/iio/accel/adxl313_core.c
@@ -8,11 +8,17 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/interrupt.h>
 #include <linux/module.h>
+#include <linux/property.h>
 #include <linux/regmap.h>
 
 #include "adxl313.h"
 
+#define ADXL313_INT_NONE			U8_MAX
+#define ADXL313_INT1				1
+#define ADXL313_INT2				2
+
 static const struct regmap_range adxl312_readable_reg_range[] = {
 	regmap_reg_range(ADXL313_REG_DEVID0, ADXL313_REG_DEVID0),
 	regmap_reg_range(ADXL313_REG_OFS_AXIS(0), ADXL313_REG_OFS_AXIS(2)),
@@ -436,7 +442,9 @@ int adxl313_core_probe(struct device *dev,
 {
 	struct adxl313_data *data;
 	struct iio_dev *indio_dev;
-	int ret;
+	u8 int_line;
+	u8 int_map_msk;
+	int irq, ret;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
 	if (!indio_dev)
@@ -461,6 +469,45 @@ int adxl313_core_probe(struct device *dev,
 		return ret;
 	}
 
+	int_line = ADXL313_INT1;
+	irq = fwnode_irq_get_byname(dev_fwnode(dev), "INT1");
+	if (irq < 0) {
+		int_line = ADXL313_INT2;
+		irq = fwnode_irq_get_byname(dev_fwnode(dev), "INT2");
+		if (irq < 0)
+			int_line = ADXL313_INT_NONE;
+	}
+
+	if (int_line != ADXL313_INT_NONE) {
+		/* FIFO_STREAM mode */
+		int_map_msk = ADXL313_INT_DREADY | ADXL313_INT_ACTIVITY |
+			ADXL313_INT_INACTIVITY | ADXL313_INT_WATERMARK |
+			ADXL313_INT_OVERRUN;
+		ret = regmap_assign_bits(data->regmap, ADXL313_REG_INT_MAP,
+					 int_map_msk, int_line == ADXL313_INT2);
+		if (ret)
+			return ret;
+	} else {
+		/*
+		 * FIFO_BYPASSED mode
+		 *
+		 * When no interrupt lines are specified, the driver falls back
+		 * to use the sensor in FIFO_BYPASS mode. This means turning off
+		 * internal FIFO and interrupt generation (since there is no
+		 * line specified). Unmaskable interrupts such as overrun or
+		 * data ready won't interfere. Even that a FIFO_STREAM mode w/o
+		 * connected interrupt line might allow for obtaining raw
+		 * measurements, a fallback to disable interrupts when no
+		 * interrupt lines are connected seems to be the cleaner
+		 * solution.
+		 */
+		ret = regmap_write(data->regmap, ADXL313_REG_FIFO_CTL,
+				   FIELD_PREP(ADXL313_REG_FIFO_CTL_MODE_MSK,
+					      ADXL313_FIFO_BYPASS));
+		if (ret)
+			return ret;
+	}
+
 	return devm_iio_device_register(dev, indio_dev);
 }
 EXPORT_SYMBOL_NS_GPL(adxl313_core_probe, IIO_ADXL313);
-- 
2.39.5


