Return-Path: <linux-iio+bounces-13372-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B411D9EDAE8
	for <lists+linux-iio@lfdr.de>; Thu, 12 Dec 2024 00:07:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 729A418873DD
	for <lists+linux-iio@lfdr.de>; Wed, 11 Dec 2024 23:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D831F2C38;
	Wed, 11 Dec 2024 23:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g3yDtt7D"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12A61EC4FF;
	Wed, 11 Dec 2024 23:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733958423; cv=none; b=ZPijx/dYjyO/2cXYB7BJbkFJYRqJYOjnursnUw27RctbelnkQVrIIQEA/yQG0AeEJbiAne1mAf+2ZE0WRU0sTO3vroFqnZilNB8KhSF63W4pWGJPW4Ya1FANWE+4+MDKHSsHm1XzLB6jeikZ71UgHMTS37snsD+dHUcvXEbYKF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733958423; c=relaxed/simple;
	bh=Cr1713WajhHzvYvE8UfeGtOFiIQNZyadluwSxA0FUrg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KchltmpCB9+F8qqZcEBDAnK3yDDalqbpZOldrZe+Gxm7GndJ1SyePdAgj9B1feyHts+eR4FayV/gt/cFktO/TeP22pUps4x8cscWQ9BoR+ezg5hDM02DQoChkTZ4s2T2KbbU9GbKh8HXTJUIo3xZzhDdTiam50bbevBCh0k/aeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g3yDtt7D; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aa6647a7556so87950666b.2;
        Wed, 11 Dec 2024 15:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733958420; x=1734563220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HYXh6GxOLbpXiurdOh608cToA5zl7Wcej6r5BOVjdKA=;
        b=g3yDtt7DUDpdKoTSGXB85LpG8etrAnurkBoOkqAfk/WeT1r5guGKTyPcy6RsCvj4Km
         IuVzu/bFxR4woy9zWeplf0O/7YW9dbn2kltVQFaE+za3U0Al7QOom5OZbGb6QPbndvkh
         Yt6t637mEI1JRBDIQ37ySkvNzhwJ/BEv286dqxMTjYVebrGd1cBomzpUS0zj9G+sL81u
         1EjmexoPeoKiMm4nKseSy+uvHB66xO7igByiHCfvCoAuIfBpWedMmg9KQVOWFnaIDYpe
         wV9dJDQ2mDOqjvB49SZGlsWeisO3yY0NFdN2zF+PJzkp5LTdwPjy3/aXoxi94aNQvt/t
         ElEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733958420; x=1734563220;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HYXh6GxOLbpXiurdOh608cToA5zl7Wcej6r5BOVjdKA=;
        b=g35UAlwJ6fzQdIAR49uyeEUbC1tOL1bbWbYIV9rlvG3OnvvFmuaO763bMA1VXPeRqe
         MN7pQdW1nKcwXz9I9e2/tFV7iJivkwzurtVVQqZWDZ4lHEBJsOsl4lAuKI49Iolbz173
         hv55mQjTJsv33JLFOx4Ray/OmZmD6uPdqFAKQQ7vLpqs0eu1hEK7DeKzkeEtpTly/e00
         cHtSlQMpbvVQ3cqjTJqTPVJDsX91vxDOs/387Jsv03tYYW5Lj4CvnZdlYn0SqbawDhoi
         YhR1hezuMSujci4WoJbKN7FfQeukup9HXve6/yEEz6B6IbF9wuxZpomWO8aVhq7Wyqxh
         b70g==
X-Forwarded-Encrypted: i=1; AJvYcCU8vrFtb1vnbdqJht4yvuYzRcFuNOg/BtEdo7HGLKF60z+etUPxW3I9PEJtg3DyG1tZoD/e5gQkeZQ=@vger.kernel.org, AJvYcCVBFP0drTIgWhkPNnb3Bb3EgXqWHN1j4cwnDJAniWo0uK0JNkI6GuxTPLIGa/AAAxLjPxZAXOPRzUuykowa@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/BX8asDKslio+ra40hikb2TK1n/B7RFuRyLpUlHyH6AnOixqd
	lTerQH16W0dO1ydCi/tdUEflRfkStLwe9DsHJOTu7Q5c8w7jxUXY
X-Gm-Gg: ASbGncujj6TeDfx4aRkDwuO0laOTPnzlUb7BN68QPWKIecjMevuB+PlbU3ITXykauw2
	GQnUolp4mVCiJEJAO31M7UV+lTn5I7QRTJ9NkvajnmuHy/vy6vJsnBbyV0spqgmtRpPObZSqUlZ
	Afs1g60slqUt8AK3hZiPoHWFAKQ8vTFW5rQl1IKrtWgHZqQ7wJ7aRmr80nbpTHXTvf5xhktFFWp
	g96FDw8mOWr7AnpBceiJvF44J9IjrgZfciQb+UPLrsKLFryUbhzAU1SjGJcuHDmHBKQ6CUWDZEK
	Y1pglIrRlsAIN/DwtP5OzEnllC4Q0mkU
X-Google-Smtp-Source: AGHT+IEFF3GX2KIaaQ+lPo1rC79c6kJOxwphBFX1Gsk71okY1+VlVIwJClchcNR/YvSE3MXuAU1tFA==
X-Received: by 2002:a17:907:7d8c:b0:aa6:9631:923f with SMTP id a640c23a62f3a-aa6b13aff95mr164687766b.12.1733958419659;
        Wed, 11 Dec 2024 15:06:59 -0800 (PST)
Received: from 34fd2088d136.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa655653d96sm747350366b.185.2024.12.11.15.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 15:06:59 -0800 (PST)
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
Subject: [PATCH v6 1/7] iio: accel: adxl345: add function to switch measuring mode
Date: Wed, 11 Dec 2024 23:06:42 +0000
Message-Id: <20241211230648.205806-2-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241211230648.205806-1-l.rubusch@gmail.com>
References: <20241211230648.205806-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the powerup / powerdown functions by a generic function to put
the sensor in STANDBY, or MEASURE mode. When configuring the FIFO for
several features of the accelerometer, it is recommended to put
measuring in STANDBY mode.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 42 +++++++++++++++++++++++---------
 1 file changed, 30 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 88df9547b..b48bc838c 100644
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
@@ -237,11 +255,11 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 				     regval, ADXL345_DEVID);
 
 	/* Enable measurement mode */
-	ret = adxl345_powerup(st->regmap);
+	ret = adxl345_set_measure_en(st, true);
 	if (ret < 0)
 		return dev_err_probe(dev, ret, "Failed to enable measurement mode\n");
 
-	ret = devm_add_action_or_reset(dev, adxl345_powerdown, st->regmap);
+	ret = devm_add_action_or_reset(dev, adxl345_powerdown, st);
 	if (ret < 0)
 		return ret;
 
-- 
2.39.5


