Return-Path: <linux-iio+bounces-19842-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E8A1AC2BD3
	for <lists+linux-iio@lfdr.de>; Sat, 24 May 2025 00:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 457CD4E4BE4
	for <lists+linux-iio@lfdr.de>; Fri, 23 May 2025 22:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0A921D5A2;
	Fri, 23 May 2025 22:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZLZmJx21"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E4121C9E5;
	Fri, 23 May 2025 22:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748039762; cv=none; b=M3HuyneNrK8zhA48mODcWvF5C+Sk9GfMG+aV0wYu70rARGiCXQz3vJf76569rT+id4Z7LvOdc8OdWC1kg7ShR0/nlIWvtyjgbcmGhT0gKjPrxRjJKg03nPw+//L6T4P7kdk7cb9tJkGaYyr+YqQ6sTo/0zSYULXP8R3kKgZfnrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748039762; c=relaxed/simple;
	bh=8yjSCH8WCRpZIG5NRsSFo7Ds+NsS88x+7SYrXp6vIzQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CzPEejmNoOsJv/Bl5i0JOvgWB0NcPenQ1kMy7WlARQx6nheOMpUIikkYboTKdyhMNX+dFN6r0l4A2yYQdj0MDmWhV534m5qL37nA9gAH0cKAqdsdfNWNbwYGDuLMlJQDflUK/IKv4WB6//qFqOr/bzvtTRAmymxwe20UsxjZKdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZLZmJx21; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43d72b749dcso345705e9.1;
        Fri, 23 May 2025 15:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748039758; x=1748644558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pB2Dld8GBSiv1dFmhoAYgFczo//9ekm6Q2JYpGshXDk=;
        b=ZLZmJx21OfifH/tvJ17Qc9SVbQReyf1woCEdq7gGE9enA5rL/iIp7WkfcKq6MYdJSE
         FSSdTStkNApVi3LTw7/wxeM0/nV5vsGGD0cWUldFLhnEkxi+qVU+/x6v7PSyq7reS9PR
         2F/JtkstbKl+ydxCW5hiJUeiSW+/hMihde2eDOVtR511AKcGXDknNIpY1JlJXubBYEV+
         t8dRAgHzzL1rAgmwgpD3QGL702eCmoR2hM3A0knb2qHvWxWx1zFAef0zHuKOpEhCkw0e
         QFfMQrTCy+OxyiHefI/teLIIowFIVBvIRYK59lqDCpNy9ZexKGHAOQ4s4JooQdxesSI0
         HHSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748039758; x=1748644558;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pB2Dld8GBSiv1dFmhoAYgFczo//9ekm6Q2JYpGshXDk=;
        b=e772EOHkrjgtXywPePYOaay5L9IAsKInWqOiNb8QAiNsb6caU2Z0prxP9N+wVkqIiB
         IigmVyXdIfBDNFwphLTEt17EUxusbNmECjGkrbBGDc9CBeSNpPzZ3mHPw3z4W7fkBo6d
         lQ98RT6lc0AyRPrrMHz8/ZKSskPNxs08dMmwpGJlSxacsm43nRggiGG4a9NdsIpQPhTy
         7arorufP8V4ptSQuzzttyVN6I9H9PR3/tDdnfmkRRp8jZ/rguFP7Vb4IEYYzhOhBLGKZ
         xBqbu46E/EaFkPv6WKlT90yutp0TooPk8Ay+rz2TradHR3/fdb+TgyJMguiL/n/G8IF+
         UaGQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6afT1PKwgZi/HtcnSFZiA9xrY3wqlHzDPymKUtPzAmFZWqTLiqQKvX/ABZs+urEV2DJ0J0P+Go5Q=@vger.kernel.org, AJvYcCX8nOZlrfsYHrZxXcfoDXSVKH1R2LK+LH+xgQwHAdxAzZuQHHfejyTh3qfpYNsCIHiAGO3cimptak1RM6Xj@vger.kernel.org, AJvYcCXIRjglBmqQ8eYlqKzseBiuJ24XIMOfM+oeHlMdf/0i9oldOyv3PofpyR2GEJ/6XeRwx4E8WfVs1BC4@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2YSIZr6nERYqZUrBn5j9u2CH6UEVme6/wz6ADKPMnHjDBNsUB
	SnkfIhfr8S0zCkVJzvTUjM8MjCR7+CMqV3e6YrFr3DfutZPZ3D1bIRo+
X-Gm-Gg: ASbGncuh6eSJJo3QXvqnlclHTB9fE9aM2HUdJ2v76uBXE3Wc4zp9SB/Z2RqhG5EAV/G
	P6Cczm6Zk/xejC1UKcTnqeTZHC3HCphn2iEgUs8AccV4lBg1MmnhiEKfaisCLZEz0h3tgaVnqwZ
	f3CtWUpmoW/1oeTas3Poqe7qnOZn0PSiTVuKhwQ8DiGEaqOL3Hxg3VFQ7ZFJNJcC6KHr5U8aGlp
	1PHLvlPXSJXVw0VVj2BSnTnR5N+u+fVSCy7sujFXi4IIgLFvtR+r7TAe1iHOOrlQiCbeZRP10t5
	Xo2nDHYDrZqpLxkxiF1QI21h1++weM23iXEssFm8792nM/uJzzfq/cjvLD1QGrcWH0o3WiMlWrT
	wXJb8966ioVlnZbJrf8agcQ==
X-Google-Smtp-Source: AGHT+IHKt4cl/uRCK734vJ5oz76OO1YaoHLf6CAFIzQ97HzIskdNskzY7EDjTPEQ0YI2kLEsrKwdxg==
X-Received: by 2002:a05:6000:40e0:b0:3a3:6273:7ff6 with SMTP id ffacd0b85a97d-3a4cb4999admr254831f8f.11.1748039758175;
        Fri, 23 May 2025 15:35:58 -0700 (PDT)
Received: from localhost.localdomain (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f6b29672sm165202375e9.3.2025.05.23.15.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 15:35:57 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	corbet@lwn.net,
	lucas.p.stankus@gmail.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com
Cc: l.rubusch@gmail.com,
	linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 06/12] iio: accel: adxl313: prepare interrupt handling
Date: Fri, 23 May 2025 22:35:17 +0000
Message-Id: <20250523223523.35218-7-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250523223523.35218-1-l.rubusch@gmail.com>
References: <20250523223523.35218-1-l.rubusch@gmail.com>
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
 drivers/iio/accel/adxl313.h      |  8 ++++++++
 drivers/iio/accel/adxl313_core.c | 31 +++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/drivers/iio/accel/adxl313.h b/drivers/iio/accel/adxl313.h
index 9bf2facdbf87..ab109d1c359e 100644
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
@@ -45,6 +47,11 @@
 #define ADXL313_SPI_3WIRE		BIT(6)
 #define ADXL313_I2C_DISABLE		BIT(6)
 
+#define ADXL313_REG_FIFO_CTL_MODE_MSK		GENMASK(7, 6)
+
+#define ADXL313_FIFO_BYPASS			0
+#define ADXL313_FIFO_STREAM			2
+
 extern const struct regmap_access_table adxl312_readable_regs_table;
 extern const struct regmap_access_table adxl313_readable_regs_table;
 extern const struct regmap_access_table adxl314_readable_regs_table;
@@ -65,6 +72,7 @@ struct adxl313_data {
 	struct regmap	*regmap;
 	const struct adxl313_chip_info *chip_info;
 	struct mutex	lock; /* lock to protect transf_buf */
+	int irq;
 	__le16		transf_buf __aligned(IIO_DMA_MINALIGN);
 };
 
diff --git a/drivers/iio/accel/adxl313_core.c b/drivers/iio/accel/adxl313_core.c
index 6170c9daa30f..9db318a03eea 100644
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
@@ -436,6 +442,7 @@ int adxl313_core_probe(struct device *dev,
 {
 	struct adxl313_data *data;
 	struct iio_dev *indio_dev;
+	u8 int_line;
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
@@ -461,6 +468,30 @@ int adxl313_core_probe(struct device *dev,
 		return ret;
 	}
 
+	int_line = ADXL313_INT1;
+	data->irq = fwnode_irq_get_byname(dev_fwnode(dev), "INT1");
+	if (data->irq < 0) {
+		int_line = ADXL313_INT2;
+		data->irq = fwnode_irq_get_byname(dev_fwnode(dev), "INT2");
+		if (data->irq < 0)
+			int_line = ADXL313_INT_NONE;
+	}
+
+	if (int_line == ADXL313_INT1 || int_line == ADXL313_INT2) {
+		/* FIFO_STREAM mode */
+		ret = regmap_assign_bits(data->regmap, ADXL313_REG_INT_MAP,
+					 0xff, int_line == ADXL313_INT2);
+		if (ret)
+			return ret;
+	} else {
+		/* FIFO_BYPASSED mode */
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


