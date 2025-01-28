Return-Path: <linux-iio+bounces-14667-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C44FBA20A1C
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jan 2025 13:02:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F3EA166C4B
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jan 2025 12:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62A281A265E;
	Tue, 28 Jan 2025 12:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q7Cp1xDH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE381A704B;
	Tue, 28 Jan 2025 12:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738065701; cv=none; b=SZGZgZ7oCnlpYdxjxcqO3csn4GP+w5qe0jToQ9eJq+9LbSj1oxvl/jYTHSsKB5fnx0iClFZ2bF604WmXi10ee+1Xop2w8t33xCUuDsZB3aJNDH6Uj6MnNUjlSnsnEBZLqU9ET3UDDq6fALVhfU4g99FPDGLHec6Lhg8sSteBb1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738065701; c=relaxed/simple;
	bh=1ZzeU4vvT5hrrqqFWlVujd5Ofhi42mGcESIFn3eGmb8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mzuinKMkJb1EuF7Htl7a6NYX1HHjI1wH+8lBX1IoD29v/t34m4JqLUBnNtRXJh584iWhnRSvF2blui43vil+E5GrQh/ZunUROWYwglU2CdoVaDhZJe+71BYM981YVM8fk4d6icWhwhOj8Pk7lblmDFFMjpJVniNLzItqVnqFCOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q7Cp1xDH; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aa6954ec439so64939366b.1;
        Tue, 28 Jan 2025 04:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738065697; x=1738670497; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rJzvPQN10ih5ynVfzQ0LEvRXOTLdbTFiXrE5gCxL/vc=;
        b=Q7Cp1xDHQ4kLDboYpPoydFB5kr+ggQBa78wQQRJ5byhQv3Vuzs55FOIRKQHLQC0hhn
         xcvN5+tYsC4E/gAmfG4SPkdKgSYPlEo/XeiypkrwFMhzcRUaO5rw0A4fqnD7YOrwyR70
         Qa8HTP1FRJO5iiKGp/xo4kpw07CZkQ9/VjLNkXgDRe+9j6RSS19J9Om/aHMRRoHuHqjL
         wTpHKgiaLCzljPzCZRpR1qAUfrUR09c2rkucktc/83STkMG94whXqA0Iim22oRUL07tB
         NE1lEwQuVC0kHLW+LbVs4LUz/2pUsvvk4NTJbK6Vkvh8aoX2LKPeTVSpPrjkJE5unsfe
         J7LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738065697; x=1738670497;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rJzvPQN10ih5ynVfzQ0LEvRXOTLdbTFiXrE5gCxL/vc=;
        b=iyYAlUzw/cc+Mo1NOGudQIAUj+0CJyb+Gs5I+OZM0DowGc0Qcv8igeVikqoR8lwGBU
         mdJciHKJH0F2+LX7cfvHTCoJlOSbJGaKZUqN9lIQwLDAD0fcg3CLC5ue4LOglgbEQKm9
         GzoDLj+y+sd1x0ObyyWu+Qc2NEIXY3qFnra4kXZO83eLYi1lgNwivLogW27ofKlAK+SU
         6ApigmsyoCBvu0Jn9N3HCNAJhddxYobutsjcTXNeNHuUFUctTtbV+NJsYCV2TcOy6BgW
         Ys2mLAmAnSoIuaJjIEfpqUaBe2cuziyjrk2zjRqQacYqs0BGB+g/CGXFgfkiUK4pjlI9
         dmvg==
X-Forwarded-Encrypted: i=1; AJvYcCXInzVYI+sOLYvOYhuPiVMC8ITXMLe6IT5hwMtfjALaZszJRHiBu6UPYIC6l88NBPvxTKxt2xcnJgLaamg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG2D1tDQZgBQTrMGfdY/XL8rJiDKK6gT9ufxYLEZpvckH0g0yt
	budVcmG1h1wP7qo6RUWs4qp5qkThJncL2D6/RF3nrdWCwRxBqK60kR0gow==
X-Gm-Gg: ASbGncsuiDjEcayuBIKi7SM08sTtMaRv2G2uasQxip3KQc5Xw9r1FlolmzfhYYJSBsh
	BOihOVZfI3QBpcr+WJ9j/69HZOdoybp8yvi1Dq/vMgD9LwblY54/Ht1OickoSMFeDBvGEw9KiUf
	72FV4+J5F00LT3Jsz5Do69fZtFTQVo3Y+kCL3WMC1nCnpbhlCoibbQOeiEQXtfzhxgaZt4wao74
	5uwjXYPl10ZJ4EfHPlea/DaFtuJUGSX3etMFi26V6uMqtltjDFR3jn1QtZOpbwBeivphOEudRg0
	2KpCkzI4wLuR9qYnHtq9dkIeu4pc4+PvcIliL4xfjKkdX7awvP7PnV5mp7fNHBIxvjFb3w==
X-Google-Smtp-Source: AGHT+IEEiXGrx3rJ4ol7shqMfJimM2yt0nqTJgl+uTZ/z9E5T/dnGerABXS608N4LLRxS2sCePGq2A==
X-Received: by 2002:a17:907:9803:b0:aa5:163c:69cb with SMTP id a640c23a62f3a-ab38b49a5cbmr1452806166b.12.1738065697260;
        Tue, 28 Jan 2025 04:01:37 -0800 (PST)
Received: from d9dabf0abd47.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab69f8555b7sm418865966b.71.2025.01.28.04.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2025 04:01:36 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v1 05/12] iio: accel: adxl345: improve access to the interrupt enable register
Date: Tue, 28 Jan 2025 12:00:53 +0000
Message-Id: <20250128120100.205523-6-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250128120100.205523-1-l.rubusch@gmail.com>
References: <20250128120100.205523-1-l.rubusch@gmail.com>
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
 drivers/iio/accel/adxl345_core.c | 43 +++++++++++++++++---------------
 1 file changed, 23 insertions(+), 20 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 7ee50a0b23ea..b55f6774b1e9 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -190,25 +190,9 @@ static void adxl345_powerdown(void *ptr)
 	adxl345_set_measure_en(st, false);
 }
 
-static int adxl345_set_interrupts(struct adxl345_state *st)
+static inline int adxl345_write_interrupts(struct adxl345_state *st)
 {
-	int ret;
-	unsigned int int_enable = st->int_map;
-	unsigned int int_map;
-
-	/*
-	 * Any bits set to 0 in the INT map register send their respective
-	 * interrupts to the INT1 pin, whereas bits set to 1 send their respective
-	 * interrupts to the INT2 pin. The intio shall convert this accordingly.
-	 */
-	int_map = FIELD_GET(ADXL345_REG_INT_SOURCE_MSK,
-			    st->intio ? st->int_map : ~st->int_map);
-
-	ret = regmap_write(st->regmap, ADXL345_REG_INT_MAP, int_map);
-	if (ret)
-		return ret;
-
-	return regmap_write(st->regmap, ADXL345_REG_INT_ENABLE, int_enable);
+	return regmap_write(st->regmap, ADXL345_REG_INT_ENABLE, st->int_map);
 }
 
 static int adxl345_read_raw(struct iio_dev *indio_dev,
@@ -464,7 +448,7 @@ static int adxl345_buffer_postenable(struct iio_dev *indio_dev)
 	struct adxl345_state *st = iio_priv(indio_dev);
 	int ret;
 
-	ret = adxl345_set_interrupts(st);
+	ret = adxl345_write_interrupts(st);
 	if (ret < 0)
 		return ret;
 
@@ -483,7 +467,7 @@ static int adxl345_buffer_predisable(struct iio_dev *indio_dev)
 		return ret;
 
 	st->int_map = 0x00;
-	return adxl345_set_interrupts(st);
+	return adxl345_write_interrupts(st);
 }
 
 static const struct iio_buffer_setup_ops adxl345_buffer_ops = {
@@ -602,6 +586,8 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 		return -ENODEV;
 	st->fifo_delay = fifo_delay_default;
 
+	st->int_map = 0x00;			/* reset interrupts */
+
 	indio_dev->name = st->info->name;
 	indio_dev->info = &adxl345_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
@@ -609,6 +595,11 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 	indio_dev->num_channels = ARRAY_SIZE(adxl345_channels);
 	indio_dev->available_scan_masks = adxl345_scan_masks;
 
+	/* Reset interrupts at start up */
+	ret = adxl345_write_interrupts(st);
+	if (ret)
+		return ret;
+
 	if (setup) {
 		/* Perform optional initial bus specific configuration */
 		ret = setup(dev, st->regmap);
@@ -659,6 +650,18 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 	}
 
 	if (st->intio != ADXL345_INT_NONE) {
+		/*
+		 * Any bits set to 0 in the INT map register send their respective
+		 * interrupts to the INT1 pin, whereas bits set to 1 send their respective
+		 * interrupts to the INT2 pin. The intio shall convert this accordingly.
+		 */
+		regval = st->intio ? ADXL345_REG_INT_SOURCE_MSK
+			: ~ADXL345_REG_INT_SOURCE_MSK;
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


