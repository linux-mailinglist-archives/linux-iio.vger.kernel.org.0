Return-Path: <linux-iio+bounces-13094-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2389E4351
	for <lists+linux-iio@lfdr.de>; Wed,  4 Dec 2024 19:26:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4D652828ED
	for <lists+linux-iio@lfdr.de>; Wed,  4 Dec 2024 18:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431741F03E0;
	Wed,  4 Dec 2024 18:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kAhAkTat"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD3C1A8F82;
	Wed,  4 Dec 2024 18:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733336712; cv=none; b=RVDdxeJu3u87Q2D18pHhVOBQcswJIwxzN2+ZVcr+rVnYapl3FppQXG8QcwmRn/YJ3RspmyNOn/A2Z45R3aPhwHhr2YcnEmTpK50a2qUj8w2s5ybc6IFwH73hjPeUh28SYddqzx0QiCxcPD9PhNRCPO64UrPTvzXhm3PXKVCi8bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733336712; c=relaxed/simple;
	bh=rxiKIZQkPVzmr99j0RAua0ES27Pg7Fg0w4gEPFpU3jA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CK9zE6viZOjlxO2DhgAWkOuyk0NZIzRSj56iwNsI38yBclnW5ml1j0Qvq0Z8+68akdgAJOaK+EWSgIE/wFJb9dZhdUYBASTiD6XgAmYHAE4iVLrlZbsgQwqgZnq4WhINEn15ugN4PnwA2zJb20lgj+qLaVGqL1PKw65eeReyt7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kAhAkTat; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-434975a1fb1so98745e9.0;
        Wed, 04 Dec 2024 10:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733336708; x=1733941508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h7JIjZWbIOMoe/2eSa/rWUO+LqGQL2t9BFTUB/CwynY=;
        b=kAhAkTatqIA5j0lWn+VoFfIZCoY875WxcFqcTjQMcs+RSacu2lGxg3lAygF4+caMkC
         CgN/XIDcXfZN514+M79ufimkotvA2DABL5mkUhJBXZS1nV97mkvjpQgfSVSkb+2y2PZl
         yBJCKSDNbu3ZKB72GaGWOABQ951Kh86uMr78PGegnco3JFGRfP7A2ixVm47b6zGjIEN0
         UOJX08T7BdHfyBeWJA2mO7Cl37SvEJq0p6yoSTsvj0IhNsFSU40lIgPiNkDsob4GGO8H
         eGVmrahndbsnkZRssdUBJU+dmBrOVI+vbeShAzM/9g4i9OZOJmJNGig5G/bBXIW5mIOp
         5aKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733336708; x=1733941508;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h7JIjZWbIOMoe/2eSa/rWUO+LqGQL2t9BFTUB/CwynY=;
        b=SYvo7O97uRAxHuWk/vjp5DVMRtYOnXNMx66IrxW+IuK6EdyyU7bSOq4iiM6gRRjM4m
         bE6GKYBHQaLGuiYtUwjaBi0Rkz4B+xTQn7CyMASiOJOWoPv7Hn2Gaq9Gbj4ItDifdBz0
         6Ic3Pf7wO/AxGFXdhNcKbNQAEzKg8X9ZFSUwNmjhHnGIZnZDC4ucNYxiahTqX+a+ZTcw
         +jOaT9F0xH4FKeSnUW9NA6/mHUl0SOOVfG9WmGfL0oO5ulUhhz0Il8NtSnwHzkl9/A1Z
         ptg/toEH6WBSeZDRdcWMFGDo162PL015DYCjZzrCY1tXwTN0E2h828Fl34aVZxA79sHY
         DvCA==
X-Forwarded-Encrypted: i=1; AJvYcCVT6hUuVryXqVmRnhKkuuN9MyfDuLedz8YhGKhBT8IjXDiD2KqHKn9El+que990PC/+fv58F9Bc0NPgTTPF@vger.kernel.org, AJvYcCWXGv72RMR4MBNH8bmc0+v1JjI66TLHc2qjssG+B2IkYEVebZOp+q5SLz6ygX+0ZwNKqXsqOWt2Tnk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ2Nnq0aEzHOQQkjsJxjpzhC068ooqcQbIxF0sKS2eQDX/Rapk
	UGu6HW9GshF7+i9ck/kU0Gjcz0I0uT5dFTXjqxnvy2/OBSaTS8eJ
X-Gm-Gg: ASbGncsjbZzlOCQ7g4/qrdWezWXUNCnPxkagMQfpZ4CaUSo3Kwa6xMd9MMSg4w0wae3
	7p575YNiBJ7DWPRDQVd54MkeO83pmNsHUxUTwfIq/rRBVtw0rkNRXEibbXEq0SRT3AcWE0hyVVe
	Ey4anHRmXo2a6qSEL47/hSHM3EE59TIBea2BjJe1Hg3jIE2+ETmrkN7CR8Y7lEZnZ9+kj6f5sii
	KV2rMdzFm1U9cL58vnS3OzeUnArs8ThczKT78sU+yaZ0L5IYachf8jrGMf2iNIxHj+DhKu5mPxV
	tvymU+W//6lcfum2IUYt/2n24nbj
X-Google-Smtp-Source: AGHT+IGtG+e3RRn6to6WOvlt3yydehGRfNTspWCra9KsGGxPBs0vozSgJFL0cKOEbWlzAVddBhe61w==
X-Received: by 2002:a05:600c:3594:b0:434:a1e4:d32d with SMTP id 5b1f17b1804b1-434d08eef18mr26824655e9.0.1733336708315;
        Wed, 04 Dec 2024 10:25:08 -0800 (PST)
Received: from 7b58d44c4ff6.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d52cbf57sm31959755e9.39.2024.12.04.10.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 10:25:07 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v4 04/10] iio: accel: adxl345: add function to switch measuring
Date: Wed,  4 Dec 2024 18:24:45 +0000
Message-Id: <20241204182451.144381-5-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241204182451.144381-1-l.rubusch@gmail.com>
References: <20241204182451.144381-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the powerup / powerdown functions by a generic function to put
the sensor in STANDBY, or MEASURE mode. This is needed for several
features of the accelerometer. It allows to change e.g. FIFO settings.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 44 ++++++++++++++++++++++----------
 1 file changed, 31 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 98ff37271f1..1d020b0d79c 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -138,6 +138,34 @@ static int adxl345_write_raw_get_fmt(struct iio_dev *indio_dev,
 	}
 }
 
+/**
+ * adxl345_set_measure_en() - Enable and disable measuring.
+ *
+ * @st: The device data.
+ * @en: Enable measurements, else standby mode.
+ *
+ * For lowest power operation, standby mode can be used. In standby mode,
+ * current consumption is supposed to be reduced to 0.1uA (typical). In this
+ * mode no measurements are made. Placing the device into standby mode
+ * preserves the contents of FIFO.
+ *
+ * Return: Returns 0 if successful, or a negative error value.
+ */
+static int adxl345_set_measure_en(struct adxl345_state *st, bool en)
+{
+	unsigned int val = 0;
+
+	val = (en) ? ADXL345_POWER_CTL_MEASURE : ADXL345_POWER_CTL_STANDBY;
+	return regmap_write(st->regmap, ADXL345_REG_POWER_CTL, val);
+}
+
+static void adxl345_powerdown(void *ptr)
+{
+	struct adxl345_state *st = ptr;
+
+	adxl345_set_measure_en(st, false);
+}
+
 static IIO_CONST_ATTR_SAMP_FREQ_AVAIL(
 "0.09765625 0.1953125 0.390625 0.78125 1.5625 3.125 6.25 12.5 25 50 100 200 400 800 1600 3200"
 );
@@ -158,16 +186,6 @@ static const struct iio_info adxl345_info = {
 	.write_raw_get_fmt	= adxl345_write_raw_get_fmt,
 };
 
-static int adxl345_powerup(void *regmap)
-{
-	return regmap_write(regmap, ADXL345_REG_POWER_CTL, ADXL345_POWER_CTL_MEASURE);
-}
-
-static void adxl345_powerdown(void *regmap)
-{
-	regmap_write(regmap, ADXL345_REG_POWER_CTL, ADXL345_POWER_CTL_STANDBY);
-}
-
 /**
  * adxl345_core_probe() - Probe and setup for the accelerometer.
  * @dev:	Driver model representation of the device
@@ -236,13 +254,13 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 				     regval, ADXL345_DEVID);
 
 	/* Enable measurement mode */
-	ret = adxl345_powerup(st->regmap);
+	ret = adxl345_set_measure_en(st, true);
 	if (ret < 0)
 		return dev_err_probe(dev, ret, "Failed to enable measurement mode\n");
 
-	ret = devm_add_action_or_reset(dev, adxl345_powerdown, st->regmap);
+	ret = devm_add_action_or_reset(dev, adxl345_powerdown, st);
 	if (ret < 0)
-		return ret;
+		return dev_err_probe(dev, ret, "Failed to add action or reset\n");
 
 	return devm_iio_device_register(dev, indio_dev);
 }
-- 
2.39.2


