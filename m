Return-Path: <linux-iio+bounces-13048-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF589E2DA1
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2024 21:54:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97446165DBA
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2024 20:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC9D20ADCA;
	Tue,  3 Dec 2024 20:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ya8N23bL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780B4207A1F;
	Tue,  3 Dec 2024 20:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733259193; cv=none; b=QKXh8sfYVOaHBadFykNz7WBQZBm28l2d7eItf2Npzp8M28KEZtfqcWD34Fot0VxoHAXvUhN2jlmP+bS4i+uuiHuEVQ8YuMLvFRgcEIw2+fwtnc52MdUhNYRt+vYt5ItjBHmt3YKO93SgRBx1K+Tn4p/wrHJdMeR+X/qdAXauGgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733259193; c=relaxed/simple;
	bh=o/lpI9Fd+uyjmqbC3M5WpJqu5Nkn3HEhk7znZmdrG90=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Mj65jkO/tJpNINOknxASBqDb3p2so8AXV3tGYpcSCIpCdVyRnEXYLSJR85avzZdIzJ58q2yZHmUZSWoZstUU5yjphQUASumi5EUhrsmuhJ5y+6M6J1EdbRzSuRRwKAqbPsxNtX+QolW9K/iXdj5M1YoCVwabhueX77SqFz2KBaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ya8N23bL; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4348f65e373so7054315e9.2;
        Tue, 03 Dec 2024 12:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733259190; x=1733863990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P0SeLMeajdOsD9tUkvbsJQTKmVK5v3TGj4Il/E1cJl0=;
        b=Ya8N23bL+hjzkJiRmRZQGemyDU0MJc9C2sdojBN1LPgRjVw/d894cig9KC1IJWK942
         F6SLRCrJhSAhXlSB+Gc8nYsnCiWIvEB4i1zYa821BSS2LMMx5VXZ2V1RpHtGhkNM74R7
         aLJz5l3lWgrshm6ZAOFqDoQx3YXpPmaRH55/rV3vR0qbWJImaLCWqxP35a8VghJg32NX
         y0r70Kf3ztR0n95qaDEQmF5TgESXtNiAzaQ7yPQCa+Wm/rDJpKJJgydXfj1VQVIYYlCN
         b+Mk9/hktMUZOXNzgyb+PWcJiufe8i1VOM0PkItzjrj+rbnwpiKEBnRjjnUESglycP/d
         FvYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733259190; x=1733863990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P0SeLMeajdOsD9tUkvbsJQTKmVK5v3TGj4Il/E1cJl0=;
        b=K865vB3lac1SuFpQfpUNKNsnUeg6AjMlO0VzYZQlHWNjnl9bNXdAItCTEEhkuW4aEe
         F8gKpNsnxEEGDcOnsh9HfdBYNBb9aupeexYCu9j8EenTettmUSaom+cxbWfCqIws/Ae8
         pV9RYt5XLt8lAVgGgzKR88puVyPywb2xCg/jFgroAfFpdYyFIxvg+WG03ENScjZ733G3
         fH7+jeXJtsHF0QiHWJ4/yfqQP39SGz2GQ0q4oCIjvY6y8Aqmfy2oDvnJfEJB/y+M5XKg
         wYvmbCdlUEZfyWjfBoksNll2dq9pp5Bj/aQkkruTJFOt9MioTDKqlR6DQztL+8/B6hjY
         G7tA==
X-Forwarded-Encrypted: i=1; AJvYcCV/xvYoJ9g7a1uAOlgTloIredzNgbLnQA+/NSg2QKnorzTmeWVJie5NcNOrgEHw8oESuBkXQ3aGANg=@vger.kernel.org, AJvYcCWCI/43OQxwuX5ynpv4JV1Qll9PZlL/7ZQWeNjdA5xd1bGrVJRtXylH5rRGoTcVF0dtmqtOzHeyisV1RWE/@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2ttrbbQfQJEwKuf0xvithTbvp3vJcldeVe2wINGn9gioc5SCC
	znZiiMEUOUde5YoobmzWx+CEBOCJrN204EE4yw8bNQVCNTaXzHb3ECCeyw==
X-Gm-Gg: ASbGnctPDyOkPMWdWByWSuLOYKlcfyzIlSA0aWMcv5/qLpA/+nSOEc6kpnpFeg8N7Eh
	KXD6IQBu/A3hz8QOSzSoewCYYVHnslVOgKK+d/VI3JqUsJlWshXXADRTdK+Z/kp/C8mMCpC4vGa
	rJe6HIBtvey+10ERPdgcLTvfBGdwm45girUTHOj2PsHld8G8AHEtQXoh5X68VDS2bfPKVyqj1ZK
	esj+Ld1EHMj7JxuZs1iy7Hf5z70LC4bqZHvFOJX0PMUO8vnyyaOZu5b0jMND058/9iR2TNREEti
	CzCdD5zJpfaedPhVVaD0KtI+6hSc
X-Google-Smtp-Source: AGHT+IGD6ZPOpR8AqIvu2pWgIl8eW2InmZPbtk93t30ynomOzynLmktqEl1UxTwRpizJhTJWWvrK2A==
X-Received: by 2002:a05:600c:1c02:b0:431:4a7e:a121 with SMTP id 5b1f17b1804b1-434d0a38d88mr14284985e9.9.1733259189703;
        Tue, 03 Dec 2024 12:53:09 -0800 (PST)
Received: from 7b58d44c4ff6.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ebaf3bccsm9042750f8f.68.2024.12.03.12.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 12:53:09 -0800 (PST)
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
Subject: [PATCH v3 04/10] iio: accel: adxl345: add function to switch measuring
Date: Tue,  3 Dec 2024 20:52:35 +0000
Message-Id: <20241203205241.48077-5-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241203205241.48077-1-l.rubusch@gmail.com>
References: <20241203205241.48077-1-l.rubusch@gmail.com>
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
index 11eb0ceef39..0bb2c653e13 100644
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
2.39.5


