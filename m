Return-Path: <linux-iio+bounces-15251-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25422A2EA62
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 12:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBAA33AB1DF
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 11:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE441E3DE0;
	Mon, 10 Feb 2025 11:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ADNyzkBW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BCC1E1C3A;
	Mon, 10 Feb 2025 11:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739185301; cv=none; b=NiFxq0SY4l61reStE+bVk13gpebSHbmq6gqjJx/FaXrnBkWqKPxBwO1Q9wIEPEL+zFLjWye5lVKdcmwyRZlkksETO+y3+xTFGwQCJV52anJJxfROEX60PlEeZySJm5KL0C2tvvNbvAOHeYYq4yRtuXYTm6iTqMZ12VZJVS75Jq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739185301; c=relaxed/simple;
	bh=wbt580DwdGlO+aiZPD7DBskEv9+63Kf3XN0LL5B0x/U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hvk54rqgxMZYrwokf2pinqfSuAWezC83Mgri6mr8XNnAbl+PHMwe/J17vcECT6sbTR+aNIroe6K1H4PUbtBGTY0fWXyqoBjtB3o6XrZqKi6BLHJXKFHDAoQqzMuzLEYL9PKlGpE3xaTgOhoAe15LhV3HaYxvNfjIDjZwyxLWMyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ADNyzkBW; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ab7b35a004aso22181766b.0;
        Mon, 10 Feb 2025 03:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739185297; x=1739790097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LIxWhxBWZqa1JG+Bdh4G1uq7jD+PXr0xdm3Jh9JZYbE=;
        b=ADNyzkBW5DmDF7NkYzude7FIBCjo9ZzO0byy7q3Rw1t58h4aLLbpAhiEbumdQo0EWw
         n3i68ahJdtWkggP/pn6jcLmSXN6cKFVUzYSqL1vn0T37R9FPmrSjjAOsJWbpLqbC+eGJ
         5q4rZpe+F7noP9hlWgIJTFzlGMEYrm+M0SBna8KA79C8CzUmC0vEHgpMQMTrGpMXj9ms
         TSl/3ByFXuUJksg1Qhn34HaCaTUTWEXvemcSQCGllhXh4UwS+1uvCDOZJlRO9OD79umQ
         LefgQjHNM1h0qMsAHuVWf84OzgGlvmUYNQFqr4xXT+NVRVhB4Ysukae/qr0ygnUy8V9l
         pzjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739185297; x=1739790097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LIxWhxBWZqa1JG+Bdh4G1uq7jD+PXr0xdm3Jh9JZYbE=;
        b=lp9e1SDgb+GQMDiF0fmnv+rPY84ZXCQoQDqkGgjkh0maYx0GjeXJn7XzKrgmjmPqNV
         Hyrr2fjFLPb7hA3+08H1Y3oMxf1lOklnXbB6TKLz4yGdWCG0BDUIErgRjpRfAIrwzcAb
         cNm1z9AirGuIrdlf+ICU4uIOw6l1SgYFqlyMqK9SYFMErlYkLDX2Gw0JXewKMiUMcq2c
         TCpP2a0oV6sW6ecH034OldgLQaEXlYwHsEViA+eD9KQhBZUvTNfPmAasYtkhWecuVPPD
         QuRC+YW1a+eSv1gSxXKlzFBasEHVgduibPBNpDYdRA5n+Ah+wSzw3EKw1DHGSVn8Mthd
         iYJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtumjBDigG1OaLxQv5UGblDZCrryZImAS66DdEhtin12z5bUQfUuJNnt0hW1DB0f94kdsURS717MSc8ao=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhK/NnPZOUqz4ukqUn0JgMw5N+qkZ4uep8wirzrz9+TGCj6aP4
	NjcldlI+111nNeHAEXyXPa7z96ugfTNvoKsBpFDsg6VlWHA+tNBH
X-Gm-Gg: ASbGnctUBQXgKzZIFxavf7CKhnLbzY2+2q+LfdQCwazhE+2r42hjliVbnJw+LHzBYlN
	1sbZvPkdk+Wq2/ODTqUdPUdcrWGm8Pgfex5vs6WModarUI/jpOnf5QywkvM5BDcytTaAjUBa/y/
	IRsb23EhHJWY/GVRF/+zGuKxjqzfKcMEF8vYQgYHzQk3u48zmkJNd41fNQaScuqjLsOD3ogMcC0
	Ulk1vziU0ONRZDSyQ/9Zok9iejAvfVGmv1OzFA5Uvx0vpAIM4M3qzIUD/ugonRiysx8q79OpOSm
	f771aKwNXnzft1yan8wh10eQDjJJSVcgTJAwQeopI4VphoG+GqPwY1pX0rmjh1DBR8/OTQ==
X-Google-Smtp-Source: AGHT+IEVaL6SBnQKinvH1sjeRcYBCzSbtrfaeDIVkCPPlbuzG+6Oky2lqauFou7N6T50ASwQlMwiXA==
X-Received: by 2002:a17:907:1c97:b0:ab7:7c28:5f0 with SMTP id a640c23a62f3a-ab789b25d55mr573000266b.1.1739185297333;
        Mon, 10 Feb 2025 03:01:37 -0800 (PST)
Received: from d9dabf0abd47.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7a5a78369sm486987266b.136.2025.02.10.03.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 03:01:37 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v2 04/14] iio: accel: adxl345: refac set_interrupts and IRQ map
Date: Mon, 10 Feb 2025 11:01:09 +0000
Message-Id: <20250210110119.260858-5-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250210110119.260858-1-l.rubusch@gmail.com>
References: <20250210110119.260858-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Split the current set_interrupts() functionality. Separate writing the
interrupt map from writing the interrupt enable register.

Move writing the interrupt map into the probe(). The interrupt map will
setup which event finally will go over the INT line. Thus, all events
are mapped to this interrupt line now once at the beginning.

On the other side the function set_interrupts() will now be focussed on
enabling interrupts for event features. Thus it will be renamed to
write_interrupts() to better distinguish from further usage of get/set
in the conext of the sensor features.

Also, add the missing initial reset of the interrupt enable register.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 46 +++++++++++++++-----------------
 1 file changed, 22 insertions(+), 24 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 2928c1c0760f..910ad21279ed 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -14,10 +14,10 @@
 #include <linux/regmap.h>
 #include <linux/units.h>
 
-#include <linux/iio/iio.h>
-#include <linux/iio/sysfs.h>
 #include <linux/iio/buffer.h>
+#include <linux/iio/iio.h>
 #include <linux/iio/kfifo_buf.h>
+#include <linux/iio/sysfs.h>
 
 #include "adxl345.h"
 
@@ -96,26 +96,6 @@ static int adxl345_set_measure_en(struct adxl345_state *st, bool en)
 	return regmap_write(st->regmap, ADXL345_REG_POWER_CTL, val);
 }
 
-static int adxl345_set_interrupts(struct adxl345_state *st)
-{
-	int ret;
-	unsigned int int_enable = st->int_map;
-	unsigned int int_map;
-
-	/*
-	 * Any bits set to 0 in the INT map register send their respective
-	 * interrupts to the INT1 pin, whereas bits set to 1 send their respective
-	 * interrupts to the INT2 pin. The intio shall convert this accordingly.
-	 */
-	int_map = st->intio ? st->int_map : ~st->int_map;
-
-	ret = regmap_write(st->regmap, ADXL345_REG_INT_MAP, int_map);
-	if (ret)
-		return ret;
-
-	return regmap_write(st->regmap, ADXL345_REG_INT_ENABLE, int_enable);
-}
-
 static int adxl345_read_raw(struct iio_dev *indio_dev,
 			    struct iio_chan_spec const *chan,
 			    int *val, int *val2, long mask)
@@ -376,7 +356,7 @@ static int adxl345_buffer_postenable(struct iio_dev *indio_dev)
 	struct adxl345_state *st = iio_priv(indio_dev);
 	int ret;
 
-	ret = adxl345_set_interrupts(st);
+	ret = regmap_write(st->regmap, ADXL345_REG_INT_ENABLE, st->int_map);
 	if (ret < 0)
 		return ret;
 
@@ -395,7 +375,7 @@ static int adxl345_buffer_predisable(struct iio_dev *indio_dev)
 		return ret;
 
 	st->int_map = 0x00;
-	return adxl345_set_interrupts(st);
+	return regmap_write(st->regmap, ADXL345_REG_INT_ENABLE, st->int_map);
 }
 
 static const struct iio_buffer_setup_ops adxl345_buffer_ops = {
@@ -514,6 +494,8 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 		return -ENODEV;
 	st->fifo_delay = fifo_delay_default;
 
+	st->int_map = 0x00;			/* reset interrupts */
+
 	indio_dev->name = st->info->name;
 	indio_dev->info = &adxl345_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
@@ -521,6 +503,11 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 	indio_dev->num_channels = ARRAY_SIZE(adxl345_channels);
 	indio_dev->available_scan_masks = adxl345_scan_masks;
 
+	/* Reset interrupts at start up */
+	ret = regmap_write(st->regmap, ADXL345_REG_INT_ENABLE, st->int_map);
+	if (ret)
+		return ret;
+
 	if (setup) {
 		/* Perform optional initial bus specific configuration */
 		ret = setup(dev, st->regmap);
@@ -571,6 +558,17 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 	}
 
 	if (st->intio != ADXL345_INT_NONE) {
+		/*
+		 * Any bits set to 0 in the INT map register send their respective
+		 * interrupts to the INT1 pin, whereas bits set to 1 send their respective
+		 * interrupts to the INT2 pin. The intio shall convert this accordingly.
+		 */
+		regval = st->intio ? 0xff : 0;
+
+		ret = regmap_write(st->regmap, ADXL345_REG_INT_MAP, regval);
+		if (ret)
+			return ret;
+
 		/* FIFO_STREAM mode is going to be activated later */
 		ret = devm_iio_kfifo_buffer_setup(dev, indio_dev, &adxl345_buffer_ops);
 		if (ret)
-- 
2.39.5


