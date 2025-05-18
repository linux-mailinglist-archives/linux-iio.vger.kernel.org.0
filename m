Return-Path: <linux-iio+bounces-19621-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E77ABAFC7
	for <lists+linux-iio@lfdr.de>; Sun, 18 May 2025 13:15:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AFB416A515
	for <lists+linux-iio@lfdr.de>; Sun, 18 May 2025 11:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D1CA21C9E4;
	Sun, 18 May 2025 11:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mrvz7OBe"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2791721ADD1;
	Sun, 18 May 2025 11:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747566825; cv=none; b=sDrRXAaLXDa5JUYS/9r5ClCN8D6vtIuCZ04XGzpU1XeVgUynQ1ThDXzm3w5BzOLwBt655T6ksaaMo94x23jOOnUSEkle8NISykSaLzB9Go1B+5O6b5/wO4HITnA6furkeWjuuDpCiL67B62IqQZsB+KYHc27RJGJueFVLbMxDSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747566825; c=relaxed/simple;
	bh=ldeNTf8VOnUl06RqM9EXPcLn7OFwGX8FOsCAo8ge+hs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AUQZq0ZkghLDlm5xlrveIbTbv4GqFXnEFsOk2rtYOgYL9lUpZcayjhQCeKKnxXpwgN28GXr/nfjtS+kYyQqrOx6qXoGv7YniVJwqqrxioRX3uVdyhrJNyU3Fde+8Rdr6M8c4aUfa9BX71y+gFsScLnHEov55d+7TnqhBM6ZNNh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mrvz7OBe; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a208a76272so273975f8f.3;
        Sun, 18 May 2025 04:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747566821; x=1748171621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nmCkTqTykN9jQe4NnVf8Ml7pN41CxU8lMiO10tHdtxM=;
        b=mrvz7OBe6QxgX/QqsYNvmhZe3eMtVF+PGzkhNRdTAFN+SOPEE98OFFELqkcW9duZFQ
         TfL7ya1gxhIfJwdHGGGSdmCxtQpOgmYptLgjnYpo/mc8JZHPow4+sy2yO1P+Flpe4Laq
         YJy+0yf9ZarrM0aEk9yPpW6IzASQDhfgfV6cXsgO1YlrV3V8wU0ZupsR/Q+dbkLp+TgJ
         N9RsV1VcQlI0BU7UtWyvrKQYMoay15hTUA1FJ6OnI8bIYtlZG7rTzj6NTHCW4RfbQ6qa
         5atWbDufJEzs6OInuJJWUSYYIqFEapQEcAv4zh0VCaJbXP4d7urcr2sfNmz+toAxcE+F
         JNwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747566821; x=1748171621;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nmCkTqTykN9jQe4NnVf8Ml7pN41CxU8lMiO10tHdtxM=;
        b=ZYwgV4AaLj8A3BuKKUpWlTtpMfK4HwyJNOrIrSvKoz+l7lk6WdxDUuwr0YDQh4q4pU
         J6/Ez8brBb1tYlN3whHRVNTLqTFlWENIOkjec9U0SCt0rQMq60uUUJ8VL/5cUygU02us
         M7psRm4OGuQdWzvcFapwn+rTZuVQLIYSkIOhW8MRARFA6iE6IfiN+z3t75n7VY4t7A6k
         ZZRXemcl/e9WQJ04uEYPiY3tCzaebG8kIngoJYfGHSO0m2+53t2xfp/3JGcwtmywPNIH
         kjQg/egdYjWMzIlyvaQTtpv1nr4xiMiSJJ5JsJoMCkcCMYnKqjRWPi1gA4EUQv/zBJfP
         JjrA==
X-Forwarded-Encrypted: i=1; AJvYcCUITcgL7/pPwdIwIp5ridhOetGyq2LnLA5MY3OD7V4GCC3HDSPSM/kiLYvqH0LbFZOS/x7w8YFH0Fg=@vger.kernel.org, AJvYcCUXlfW+HAgaq+fCvefiZwx+PFK/r9t81A8g9kqsFjemZkY4iH+KRAh3w09UpVWbMQk/w2c177SUKEOzVJvI@vger.kernel.org
X-Gm-Message-State: AOJu0YwQlgTygQpIIzaCPXYOHA/zDLSR2w2GJ2sOSEQq5GN+5ULV3K7/
	q9I0Z6ezgesFUY/5/ebQPybadqVLYuKtXWGauDqtFn4F0yqID5hPhdAw
X-Gm-Gg: ASbGncstYPDwFy0t+C64Vct9vTXPCWHYzWhwykH2aQjyx9Qn/27ZWGz0Aa/tZ2yvGSx
	cI4mSv54O6JFNlVbQG8hTnnrCc7796lsaXLnqu6YQvHM9VWzLhACXAhH6+OVwMA0ljkl87ckHv4
	kbUr17es4dkH3mQ/d1QnEXkURwjuIyZoXxlyI+0kAag666CxOuls4R1UTRvY5YPCQecz4AZ0rYf
	EeyWaCt9fc9p9843+km7hEhHVOPGZ0r/AjpRMc6+JZqEViCtZcqFC35cZ1nit5qFrBSuAri2AB+
	ZbfRd6oyXtUjbzp5EHRoXvvHEOSMZ2o2CN7hTU3mACpB6NM4j42FN96/+6Cyi+DolhFn3lPBm5/
	jOxwhrIYfzaF85GxWsWnk5A==
X-Google-Smtp-Source: AGHT+IFnXoYFhAZS1h+89+s1tNCPQjkhTODl/4wJvtNWsJcdFD/YItEYMVOhhRVh/+P2S+vub98KHg==
X-Received: by 2002:a5d:64cb:0:b0:3a3:6ab0:8863 with SMTP id ffacd0b85a97d-3a36ab089b0mr670243f8f.16.1747566821249;
        Sun, 18 May 2025 04:13:41 -0700 (PDT)
Received: from localhost.localdomain (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca4d1dfsm9287446f8f.18.2025.05.18.04.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 May 2025 04:13:40 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	corbet@lwn.net,
	lucas.p.stankus@gmail.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com
Cc: linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lothar Rubusch <l.rubusch@gmail.com>
Subject: [PATCH v1 06/12] iio: accel: adxl313: prepare interrupt handling
Date: Sun, 18 May 2025 11:13:15 +0000
Message-Id: <20250518111321.75226-7-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250518111321.75226-1-l.rubusch@gmail.com>
References: <20250518111321.75226-1-l.rubusch@gmail.com>
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
index 244fb2ec0b79..05e99708c2c1 100644
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
 
+#define ADXL313_INT_NONE			0
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
+	if (int_line) {
+		/* FIFO_STREAM mode */
+		regval = int_line == ADXL313_INT2 ?  0xff : 0;
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


