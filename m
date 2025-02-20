Return-Path: <linux-iio+bounces-15832-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F689A3D714
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 11:44:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63C6E7A65F7
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 10:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF811F3B94;
	Thu, 20 Feb 2025 10:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hjIyOIIh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4F61F192E;
	Thu, 20 Feb 2025 10:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740048167; cv=none; b=rOSlHG5JL9pPPpno2dzP/L4HetJq5BbCrvsZUIK3PU9YH+tBeMHO+JEcsLucvIOnElGmC1jzQsBB/T6U5i4VgPB+tjO5uRsewVjJyzS/MZVAuK4B68ce1Z9JgELjcM2v5QSCI5I+vG35X+BvDl+tqGkvvfJnn99D2tqAbaCaJlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740048167; c=relaxed/simple;
	bh=D3VACXGiA5izsC3aCkszrBj/SfbyrNkl6NaOpPR6//8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k17TlzcFRPOc8IEDUm18TpA5zmfh1vx99FiCgYG3Pa8KW5ObIVMPipor0VWtt9mVxBr9TfozjNEm6FktYJNZ9SarIDt9dtIK9LKyW+THHIOlTqEUH0v8IUjSNlc8Wb9ZNtD3r2WxzuQQ12RRQvXzkquqJf/5gMv9ijCOXV5scSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hjIyOIIh; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-abb4944fa73so11432666b.3;
        Thu, 20 Feb 2025 02:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740048164; x=1740652964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ofVa9GTeq7YIn1WTJeqPRtWjrDFNSHYQYgeM+emWUQ8=;
        b=hjIyOIIhLZf9C4YlO0y2X3raHVXuWO/TLBFZL9heH7bElYrFAXDFn9RI7x3lEjgkaj
         X+y5YDy11QSJH7h70xYgI2qX+H5gDU2Knw1rBUZLZjE0toGQkWzdtamIAWIIqOvdqKcs
         I50wR8mz0XwvLbDVliqVUW30p+/9HNIXL6eZ2iGZaOIs3uz5wjIf8HIjjt9Ocb+YSxFZ
         77FAoIKKa8TbfVv6bm/2JopCX+SAh0IbsxO2IS1KUX7Lo3fV2dkSIIj3FcBdyMCaNBzQ
         tubOnujH0tc0QLVM3FqHEXC2Dq/i3oHMgvSTyuQXa0gsm9s5nphCTYP6E4ZvkXiX9JCt
         4fwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740048164; x=1740652964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ofVa9GTeq7YIn1WTJeqPRtWjrDFNSHYQYgeM+emWUQ8=;
        b=E0WsMBCfhV3NEdpqGoCj9g1Swlcyqn4+N/3m6QKCoex/0oj1sTX7hJxDtw7109V+Bh
         YAASQEw3GwK8p/Wk6Hu/bBjKpfr7lstRGrspSis+Rxq3yy0ph2pLMCWgFiPUltpcCoqK
         enTgOe9+NxmsMpNIepvOvbFOY6MwTLYVdavBmb4BTITcJ/Uu0Q+k/o7DVd1Htp2VhOTa
         7GVM/nBnlfSeV2RRH7CqQpHakPlwOAljqpDggfj3Rgf1cIZPKpNeB7imKD7q/JXQTPAD
         pWMlQSghMBARrndGw7+rTjybqTgq579Nb1y0gQA5WVoLxDftMMCOk2AmkxwXLjA2q/PF
         tIRA==
X-Forwarded-Encrypted: i=1; AJvYcCXa7Vg//vUr+R+JOc84F/846sI8ZxqY5dHLU13YS2FhOPEH1YQM3bJijN9DhGoeyCjzwqCtuIZRce6zTMM=@vger.kernel.org
X-Gm-Message-State: AOJu0YygvPPlFoJEQFj98LZqS9axqsikPBMsljRa5Opu/fQDNNmAW2hC
	TGeYQLGMulC3o1qUxVe6J0suFQkswhKACHKOftiu2wlLV2bQ1mxx
X-Gm-Gg: ASbGncvQ+4SKr40JDRgSTnf3K6mGUw5mfOlr9LPay2w55j73nZRs7vN+8Y1yqrmVoeI
	EGMZ4yL1FVvdiNHLfLRsK0E0oXqwSjvIf2zUs8OVqrv9VXXFHrvHoGZ56GQrm0wjJtJobZxDrKr
	VQSy1uOm3ZSuweeWG0dUHw0DmwtO+6Hw4X3jpd511snZa4cjNJwdHzm8NhlnVUjbKE563IRy8s7
	pWe9fxSGlsfcgWfs7FuB7zNC+oC65/gcB54FVP1MNRppW9RT1WwytLDvZ1C1o9gZqUXgo9dGXhj
	CgjXXcX9uab3XHG5pdcP9sCxfCGT14pWnw8y3iC3LDGe1h8qMVf1JRmKpXwGUz0Wv4sx4g==
X-Google-Smtp-Source: AGHT+IHGRIiu0mrBHT7FfHi01HRyvN+SLp0Aefqt3iwlMU4ugkpcTAyz8Cl7hgoP1RuiE1BRliGzqA==
X-Received: by 2002:a17:907:1c8b:b0:ab7:cb76:1ae3 with SMTP id a640c23a62f3a-abb70930221mr805324366b.2.1740048163426;
        Thu, 20 Feb 2025 02:42:43 -0800 (PST)
Received: from 0f997e1ceb21.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abbdfcaed55sm246474866b.137.2025.02.20.02.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 02:42:43 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v3 05/15] iio: accel: adxl345: move INT enable to regmap cache
Date: Thu, 20 Feb 2025 10:42:24 +0000
Message-Id: <20250220104234.40958-6-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250220104234.40958-1-l.rubusch@gmail.com>
References: <20250220104234.40958-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the interrupt enable member variable to the regmap cache. This
makes the function set_interrupts() obsolete. The interrupt enable
register is written when the driver is probed. Thus it is perfectly
cacheable.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index c4cff74a5d10..0cee81bc1877 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -36,7 +36,6 @@ struct adxl345_state {
 	struct regmap *regmap;
 	bool fifo_delay; /* delay: delay is needed for SPI */
 	int irq;
-	u8 int_map;
 	u8 watermark;
 	u8 fifo_mode;
 	__le16 fifo_buf[ADXL345_DIRS * ADXL345_FIFO_SIZE + 1] __aligned(IIO_DMA_MINALIGN);
@@ -113,11 +112,6 @@ static int adxl345_set_measure_en(struct adxl345_state *st, bool en)
 	return regmap_write(st->regmap, ADXL345_REG_POWER_CTL, val);
 }
 
-static int adxl345_set_interrupts(struct adxl345_state *st)
-{
-	return regmap_write(st->regmap, ADXL345_REG_INT_ENABLE, st->int_map);
-}
-
 static int adxl345_read_raw(struct iio_dev *indio_dev,
 			    struct iio_chan_spec const *chan,
 			    int *val, int *val2, long mask)
@@ -216,7 +210,7 @@ static int adxl345_reg_access(struct iio_dev *indio_dev, unsigned int reg,
 static int adxl345_set_watermark(struct iio_dev *indio_dev, unsigned int value)
 {
 	struct adxl345_state *st = iio_priv(indio_dev);
-	unsigned int fifo_mask = 0x1F;
+	const unsigned int fifo_mask = 0x1F, watermark_mask = 0x02;
 	int ret;
 
 	value = min(value, ADXL345_FIFO_SIZE - 1);
@@ -226,7 +220,10 @@ static int adxl345_set_watermark(struct iio_dev *indio_dev, unsigned int value)
 		return ret;
 
 	st->watermark = value;
-	st->int_map |= ADXL345_INT_WATERMARK;
+	ret = regmap_update_bits(st->regmap, ADXL345_REG_INT_ENABLE, watermark_mask,
+				 ADXL345_INT_WATERMARK);
+	if (ret)
+		return ret;
 
 	return 0;
 }
@@ -380,11 +377,6 @@ static void adxl345_fifo_reset(struct adxl345_state *st)
 static int adxl345_buffer_postenable(struct iio_dev *indio_dev)
 {
 	struct adxl345_state *st = iio_priv(indio_dev);
-	int ret;
-
-	ret = adxl345_set_interrupts(st);
-	if (ret < 0)
-		return ret;
 
 	st->fifo_mode = ADXL345_FIFO_STREAM;
 	return adxl345_set_fifo(st);
@@ -400,8 +392,7 @@ static int adxl345_buffer_predisable(struct iio_dev *indio_dev)
 	if (ret < 0)
 		return ret;
 
-	st->int_map = 0x00;
-	return adxl345_set_interrupts(st);
+	return regmap_write(st->regmap, ADXL345_REG_INT_ENABLE, 0x00);
 }
 
 static const struct iio_buffer_setup_ops adxl345_buffer_ops = {
@@ -523,6 +514,11 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 	indio_dev->num_channels = ARRAY_SIZE(adxl345_channels);
 	indio_dev->available_scan_masks = adxl345_scan_masks;
 
+	/* Reset interrupts at start up */
+	ret = regmap_write(st->regmap, ADXL345_REG_INT_ENABLE, 0x00);
+	if (ret)
+		return ret;
+
 	if (setup) {
 		/* Perform optional initial bus specific configuration */
 		ret = setup(dev, st->regmap);
-- 
2.39.5


