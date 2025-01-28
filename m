Return-Path: <linux-iio+bounces-14664-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED73A20A16
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jan 2025 13:01:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 988CA3A513B
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jan 2025 12:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99AE41A2645;
	Tue, 28 Jan 2025 12:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I4mBYaGJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57491A2391;
	Tue, 28 Jan 2025 12:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738065697; cv=none; b=lFmWjXGpF6plS/cJhqxk6/UKESJGYHyQQxuKFZJXrOY+v515d4zTMKLMoVBVHdMGQtVrmMYqN/kNLqDPOwlrDpIWjYALd1iUqUb6ZzHj8tQF++ofXZq8BZBo7Ae6g9WaFqvLbUFahQtTOLEM+2FjZ7RpSzkUQGw5c3KyLQfnz34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738065697; c=relaxed/simple;
	bh=32pxGww22uXNRSE1h4GEPFMYm4JjozUP+kLSK2TuVGU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qDZ7zDqXXbNu/u0wntLmBzCgLBLLx3oQd8X11qFVd1HNGXI+itMHD3bXZ2CJh7KN+P26UnkCKL6KddYuAJYpV2AoA0spTSpdx+SaJM/gLV7SeAm5KcLf2McbSoc9i4wUD7c67owebUkT76/Zfef9sVmarvnvzCtMJly8hxxXD/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I4mBYaGJ; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5dbf7d45853so1281251a12.1;
        Tue, 28 Jan 2025 04:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738065694; x=1738670494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iy4p7JxJyU0LbLEs05esQZqH8h+c7Oo1QTLQ6nSQRv8=;
        b=I4mBYaGJEykNjEh4xr/1gfiHEuwbLBTNeOwPiz9nCCG+OsFTjdlU7OgbO7xSR+GA6l
         h3WvptPz6VDr9R91TyATEU7YsN1viS1ddniMtmU0wcqoiFGlx7EJn3t93YJ3h+hn4VkN
         Dbkq1DJxtgzwhDKvU1Lkz8RmU+mdqleWygqtIRJWYuYk6KWvYVsTTOLN222sjSqhm7ft
         9xCoAW88AjlHIY4KJp9nd9zlePK0rztUSyZJ3mDFGMosMS4r+QQ3eOA8jD4TJg/YGbOw
         8Yn0uOwiPaqTmddHWvCGMcN93bxDJax4XXSdELWRJgihZruBUTsFoNmPsh+Xe2lXaE7l
         4wlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738065694; x=1738670494;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iy4p7JxJyU0LbLEs05esQZqH8h+c7Oo1QTLQ6nSQRv8=;
        b=DWp1rJz3hIvqWG1fWzKhmTR+m/LiPISt+65jiHPqsz+xuERgAFEZT9OlIgrQu6yH4E
         0PLYXMXVGkEVo3w8TBZiCG2VN18sK6GGh6aOn1TtlRBZ6ChFvOJfqErEd/3ksL6/9Bp7
         QzrjvJT+vCe7h69vGcFIjNlcjs9ZhfLIjQteeNspp48mjYLWhv6uIRt9nBcGJXJDQAOK
         Xbn0HokvlQ070qRbXOCKqndKmy1xu80s/hL3BkQHrGRznWgggDq4ZjENKU3JYb7HnxDd
         8waqz+mMD9QH5CIo2rUBkzuEhDBmjwcrte1G7HoS0YbJPq6r8N2e9FX/RIxATlRgewJp
         6Inw==
X-Forwarded-Encrypted: i=1; AJvYcCUwkFWfnqDt9BYyD/zLa38CCx07qducJzsD+HGjJp9DONqLLH13ERoobN2aSC0G6YDMQkM/cNSUTuSmqnY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzabJNJhoBQdAh0ehXWbbkpaF3Q6KGJ/KCUR7jcm8wLu+Qy/ofr
	tXwPdiOVC0RjNm2duPbYYWMW09UB/LAOX3kp6vW1FS7r5fohaMp5
X-Gm-Gg: ASbGncuvN/SdU08+aVRDWoAxeL690OXwlM67sOx7tBHObswwo4Z6n2pUubfExxHQH30
	fK24Yc8BISK/ifYWS4Ln/LiXF966SB0I0Ht2O6XLO8Uuqxj7UCXsnzNzOA8FSAvAYEZobY5j26X
	aVA84VZsRT9OXUUPN1eGJPGqRQjjSDDgzEZZ/hgHGGSY9Y7ouLHnI598U0DwKZCzgq6ALjHmHPa
	2WfbLPpVisBp5LGsmxAaJNK33v3WuYNYdrKuwZe2ya4sPltmfGx70A5szvl656Ed8DuZRJTQaqv
	UQa7X7opZQTDDYQDC3CYjU2SAqYjqdPdWY+w0tYevt+HcgsmZ3QuHeqNfZoo43VQsWlxvg==
X-Google-Smtp-Source: AGHT+IEKXV7QElYUwfDqVcH7rzpBecIFcCv5h8XU4S7HREeyCDvE9mj6Omi5cxRHVFagSHCjM2dc5Q==
X-Received: by 2002:a17:907:9715:b0:ab6:b8e0:4f25 with SMTP id a640c23a62f3a-ab6b8e05026mr150998666b.4.1738065693484;
        Tue, 28 Jan 2025 04:01:33 -0800 (PST)
Received: from d9dabf0abd47.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab69f8555b7sm418865966b.71.2025.01.28.04.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2025 04:01:33 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v1 02/12] iio: accel: adxl345: reorganize measurement enable
Date: Tue, 28 Jan 2025 12:00:50 +0000
Message-Id: <20250128120100.205523-3-l.rubusch@gmail.com>
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

In order to have this function generically available a position at the
top makes more sense. In upcomming patches for particular features the
function needs to be available, to turn off measuring while changing
settings, and turn it on again afterwards.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 54 ++++++++++++++++----------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index ffdb03ed7a25..142f12117627 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -163,6 +163,33 @@ static const unsigned long adxl345_scan_masks[] = {
 	0
 };
 
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
+	unsigned int val = en ? ADXL345_POWER_CTL_MEASURE : ADXL345_POWER_CTL_STANDBY;
+
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
 static int adxl345_set_interrupts(struct adxl345_state *st)
 {
 	int ret;
@@ -301,33 +328,6 @@ static int adxl345_write_raw_get_fmt(struct iio_dev *indio_dev,
 	}
 }
 
-/**
- * adxl345_set_measure_en() - Enable and disable measuring.
- *
- * @st: The device data.
- * @en: Enable measurements, else standby mode.
- *
- * For lowest power operation, standby mode can be used. In standby mode,
- * current consumption is supposed to be reduced to 0.1uA (typical). In this
- * mode no measurements are made. Placing the device into standby mode
- * preserves the contents of FIFO.
- *
- * Return: Returns 0 if successful, or a negative error value.
- */
-static int adxl345_set_measure_en(struct adxl345_state *st, bool en)
-{
-	unsigned int val = en ? ADXL345_POWER_CTL_MEASURE : ADXL345_POWER_CTL_STANDBY;
-
-	return regmap_write(st->regmap, ADXL345_REG_POWER_CTL, val);
-}
-
-static void adxl345_powerdown(void *ptr)
-{
-	struct adxl345_state *st = ptr;
-
-	adxl345_set_measure_en(st, false);
-}
-
 static IIO_CONST_ATTR_SAMP_FREQ_AVAIL(
 "0.09765625 0.1953125 0.390625 0.78125 1.5625 3.125 6.25 12.5 25 50 100 200 400 800 1600 3200"
 );
-- 
2.39.5


