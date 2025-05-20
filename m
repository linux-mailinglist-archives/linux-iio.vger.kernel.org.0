Return-Path: <linux-iio+bounces-19753-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4A4ABE78C
	for <lists+linux-iio@lfdr.de>; Wed, 21 May 2025 00:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 279F97B056A
	for <lists+linux-iio@lfdr.de>; Tue, 20 May 2025 22:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0694B262FE0;
	Tue, 20 May 2025 22:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ty6azu8k"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D6D261589;
	Tue, 20 May 2025 22:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747781446; cv=none; b=JqmJw54AENElHTIIBJwmhikSlih0FJh5SRTzxIvNb9QN+Kh+hIVqKCA8mNJ78W54kjElL3RDXY6JggWP8u6jgG7QuPN2Cu9XIEXbWoYwaZ+m6kfr/G1BMXFmX3erFOgIPVlpWp1NN5Xx5kBn/8jkDly5M9ArZJjr1Qetk4khZEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747781446; c=relaxed/simple;
	bh=dJuzyT2cPjhxdkSJR3vGlhk/I/qIXxpsswNmy//9gmA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PevMjaMgpGNrNgJ3ANcpAUTcdVh18/b9SebjezuwKfpTmTC8p9jhbpOXSxgbQYBrzKj2y8P7533a76mMhO7+NUpMvTJKxF+RFce83pJfxbWIajFmCAHaU5M3NHVO04mlomndpF73gRAfns4GXx4OI695U79CCcReIrSeGqOrTXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ty6azu8k; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a368259589so550558f8f.3;
        Tue, 20 May 2025 15:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747781443; x=1748386243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oex9G36S3nzEms12jgBxKInuwuHURjBQv9cLpSGu7fc=;
        b=Ty6azu8kTylZZM38PbhoxQOPWStGvGGYvZ2vbC/6w8CP+ecovPFX1RlJpJsj9lCwNi
         543Bc2w83bDdLip/Cmw1VlFg58Xk+oaV/2AGpoucnDOVYKZGlHB/bFL0P2pemndRMn0k
         /41Ee4qQqzQgHY/ShxxMLi/DMkZ16UeXxC3LoSRwAO6mOqJoVzO6jN9/D1PmdQH17Qwk
         8UzN5BJB161HiDnSwssHDtEP03RWy2eJeFe4IvKXptj83O5iMX1zXZCKnY6krUnbcVny
         mDwjWnaeKOCVU3hYd1Vq1kWlNGeDOKDMw8gK/ZGxdSrGBWpkURTYBRC1+DI51FIPyX/Q
         /nzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747781443; x=1748386243;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oex9G36S3nzEms12jgBxKInuwuHURjBQv9cLpSGu7fc=;
        b=PmlDIyduZ9/eB5oTfYlDmwCNJ4yccqp+aydXYEO6sfrR2Z3ED2CXECAVXjiHi8FU8f
         Pg2qW1CuH8QrTgfV3/8YSRbuISqx/iFvc/YwO3Zqo70DVX7hpIPE2vx6Wb9Sr4A98nuJ
         tvslsiVHoOtZYk8sR9ul6XXla/N9GmPhITSj6AMaQNyd3BE5aSJjxjpNGo0AzH1gxwme
         HudcsqLnDNsScdK6Ac5HZqG11l16PAHTVi1Do4aGLC8OaMQXNzH9/qY6ytzb6xbhKhho
         G6TAY7ul0okB3o2LnGJ/wGtSwK+XYhfgpzob4XsyX+cxDzsIDLkPnShLidR/kmLNaf0P
         AB1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUEDbncL+8XczHigJHtFYkd/dCo0z8X+rq6cajizkFrLQxKQTrCz6JLpjh2lg7kzt756p541Z3osNX3lnKh@vger.kernel.org, AJvYcCVCC10yOjlxVpGfvmRr7Y/T0V02rJTmx0PMIhgmeWLrSLBhLchuX6fQOH0ZEB2ZZffJiOPnuFg8oJM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxInpCq1guOyPI+pLlmPLCGl+SHCeEjPYfJ+1Ut2BsJBDS3FAWN
	FWOGTi6PlqUvdmbDrosWjsHfkMojsLL7w+pkxdRJ0STUTMuDowt5xBM1
X-Gm-Gg: ASbGncsYhjAu6LbLs5oG3+XLAzSjQkX0GeHlCn6ktOhErFg8nvm7xVKB8RT+PgXwzzA
	FXvfkfXL+l/fEyfEJuieMtR0xw37sfc7kYkhLlSZ8YlB9okxbyiwuqeXoHy46skD6XUSXIgEgdE
	3VPRDoZJgt+Jtln73NJz0Yv3mVjhjYn9akyZpnDwUCiS1HxGZblrS867pciqGsHbCeu5srT4msU
	PGX7NBaSWwYWYHMJjFTVOIGnwiwoLRagZs+wQ4f6lPvFNWJFq/1z2EQ+q+FwNEcjn78CrZDJnxu
	eKTN2jYcC7KAnPyB92sofZJJXxdGhrY4WQHoFND1cNI/XYNtZM+QoNOHBG05Lysq1QE1TTwI3KP
	6m05odd26a+GyZakXkkj1tQ==
X-Google-Smtp-Source: AGHT+IFoo/GKfDc0RuvQtESamWYdnGPf2LOjG2Hn58At/4eW6nxb5r1+AXAETmxx/37EyMiOv5aJLA==
X-Received: by 2002:a05:6000:184d:b0:3a0:75ff:2d94 with SMTP id ffacd0b85a97d-3a35c80b638mr5791432f8f.1.1747781443289;
        Tue, 20 May 2025 15:50:43 -0700 (PDT)
Received: from localhost.localdomain (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca4d105sm18101588f8f.11.2025.05.20.15.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 15:50:42 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	corbet@lwn.net,
	lucas.p.stankus@gmail.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	l.rubusch@gmail.com
Cc: linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 06/12] iio: accel: adxl313: prepare interrupt handling
Date: Tue, 20 May 2025 22:50:01 +0000
Message-Id: <20250520225007.10990-7-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250520225007.10990-1-l.rubusch@gmail.com>
References: <20250520225007.10990-1-l.rubusch@gmail.com>
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
 drivers/iio/accel/adxl313_core.c | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/drivers/iio/accel/adxl313.h b/drivers/iio/accel/adxl313.h
index ba5b5d53a0ea..c5673f1934fb 100644
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
@@ -47,6 +49,11 @@
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
@@ -67,6 +74,7 @@ struct adxl313_data {
 	struct regmap	*regmap;
 	const struct adxl313_chip_info *chip_info;
 	struct mutex	lock; /* lock to protect transf_buf */
+	int irq;
 	__le16		transf_buf __aligned(IIO_DMA_MINALIGN);
 };
 
diff --git a/drivers/iio/accel/adxl313_core.c b/drivers/iio/accel/adxl313_core.c
index 6c9d99650fc2..52fb10680939 100644
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
@@ -438,6 +444,8 @@ int adxl313_core_probe(struct device *dev,
 {
 	struct adxl313_data *data;
 	struct iio_dev *indio_dev;
+	unsigned int regval;
+	u8 int_line;
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
@@ -463,6 +471,30 @@ int adxl313_core_probe(struct device *dev,
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
+		regval = int_line == ADXL313_INT2 ? 0xff : 0;
+		ret = regmap_write(data->regmap, ADXL313_REG_INT_MAP, regval);
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


