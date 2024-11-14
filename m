Return-Path: <linux-iio+bounces-12283-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B009C95ED
	for <lists+linux-iio@lfdr.de>; Fri, 15 Nov 2024 00:14:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D4001F22E44
	for <lists+linux-iio@lfdr.de>; Thu, 14 Nov 2024 23:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7931C173C;
	Thu, 14 Nov 2024 23:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CU2azQWk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42791C07D9;
	Thu, 14 Nov 2024 23:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731625834; cv=none; b=sSCy0TFYkHOaHhMLfDBsvjtojjxfcU/SAuDQwhX80dkt9F/N9jcAcESWlP0Wr3kKjHBnJt2zLstCzUhJWgspmkLyekRwmFNaMeq100W1dtzwVCU8Hf/MCNtL4ch+sHznKM7jFydFM75vq8uGF/dJLWK0glOSI9Yyv4qcXovWHU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731625834; c=relaxed/simple;
	bh=FYtcqjQShpDDoo5l9S/bvpOPxAEPAmNqverQq+5wlGU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F+U+5Lb7/AffEN6DQFncFbXAwpm82T6JNTJ04kflLBy28YqApa/hvLGkeZtnNluWdn6gYIUOuK56G1hxyfGXzvPJYYmvgNLHFVPI2jMWWxQ5q1XQjMS9hYJs4bHt5CR/5opqJrhm3kxNuCWsz4KwfQvZA8tndheAfyJPsXuSV1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CU2azQWk; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-37d4ee8d15aso63665f8f.2;
        Thu, 14 Nov 2024 15:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731625831; x=1732230631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QWT/eem4w+KatBeCaD6Tg/CeKVsKpn15/8QuQoUGEWs=;
        b=CU2azQWk+OP9KT1Lu/kg8O0mLsM+WioLfvXVZiibGHHnt1Fpbkq+20tJec2AtoP33d
         eSYGgHCUAPUMs/6JEzSZxEM3e3brVCzPwRYxckJe67+9w88lDdQYp18e39AsdkQYPvFz
         97qTUv/wx2+0anboiW4zQmnOzrn3MnAZsnVU61oI0KvjyHrhpidaU918zjIPwJYSRZPt
         kI1bSayrfDIwpr1a5OGxrTfbXXbNJbHHczBuT7/5QxWZF+T3/MH1je73ovx07f9H746T
         NpikSLOry3w3ftV/PpFCmfiW7ZoOjnhymZlVBxxfJrsdc77Ebs5HUR0RkzGLNkARud4n
         IpZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731625831; x=1732230631;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QWT/eem4w+KatBeCaD6Tg/CeKVsKpn15/8QuQoUGEWs=;
        b=EVqKXZkoJxGuzw7XZ2orZKDAE7vBRmi4RTuKlWGUfJDOJrniYBj6Lqdrax+psh/iCJ
         zSFSMTFNHetuPhINF5rET2hi92AHdOs9caRYpaaswcb77NWfxbNOwSytlOlOclOeTnkb
         XlGE2tcfPPeVHMEDTkoxYreTyFjAC0Ks4N4VfTP+73IkRD3Hw6zSpG5Z3p6ay/dL4mPF
         dw4aCzUqPAteCcDQ+2k2Q5M4rpgP5Mexe+IbyjLa0yOcWiGpsOJP/btk/D6DCANULpI5
         u0j69Su2YRd5+E0uM2+n8twBKNZfj+GCsrdNp25hnTxQ8Cbh6f/WoE6UFTZt/jOqvm7k
         zkyg==
X-Forwarded-Encrypted: i=1; AJvYcCVHUfrzUyRJTc2+peZxC2SX7MmurCbuH0LLh1bJ5xT7fscrVZzPHXd/ZCryuJgYV0WGdQEST1z2WK/gcmVL@vger.kernel.org, AJvYcCVe78C9HjLkZKX0ou8d5lIWY4n7jZkpTZr6UYqqNY4TzgAi7IR9vEe7GL+EfKDEmA7cCyE3UGbPQqE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhH+b/cdWZfjI0+DFmVEmTtl61EemSmGJZ0hP8kDDzcSY8m9Sf
	pum+h/CbbSaIRJCvgdHxzQ3uylV8n2JWdhO7HjmNo9aSxb/8bGSM
X-Google-Smtp-Source: AGHT+IGTsIWmVqyzSz6WpSL8m6dJCl3rUSBDrg+GOCAYR8JmtaXnIo0QA7h1SPe5TfTS2fOzeSF5rQ==
X-Received: by 2002:a05:600c:4710:b0:42c:ba6c:d9a7 with SMTP id 5b1f17b1804b1-432df7878bcmr1571135e9.4.1731625831163;
        Thu, 14 Nov 2024 15:10:31 -0800 (PST)
Received: from 5dfbf0f66296.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dab789fasm36464265e9.18.2024.11.14.15.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 15:10:30 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: l.rubusch@gmx.ch,
	Lothar Rubusch <l.rubusch@gmail.com>
Subject: [PATCH 15/22] iio: accel: adxl345: reset the FIFO on error
Date: Thu, 14 Nov 2024 23:09:55 +0000
Message-Id: <20241114231002.98595-16-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241114231002.98595-1-l.rubusch@gmail.com>
References: <20241114231002.98595-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a function to empty the FIFO and reset the INT_SOURCE register.
Reading out is used to reset the fifo again. For cleanup also a read
on the INT_SOURCE register is needed to allow the adxl345 to issue
interrupts again. Without clearing the fields no further interrupts
will happen.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 70 ++++++++++++++++++++++++++++----
 1 file changed, 62 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 57bca112ea..ece28825fb 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -344,6 +344,56 @@ static int adxl345_get_fifo_entries(struct adxl34x_state *st, int *fifo_entries)
 	return 0;
 }
 
+/**
+ * Read fifo_entries number of elements into *st
+ *
+ * It is recommended that a multiple-byte read of all registers be
+ * performed to prevent a change in data between reads of sequential
+ * registers.
+ * That is to read out the data registers X0, X1, Y0, Y1, Z0, Z1 at once.
+ *
+ * @st: The instance of the state object of this sensor.
+ * @fifo_entries: The number of lines in the FIFO referred to as fifo_entry,
+ * a fifo_entry has 3 elements for X, Y and Z direction of 2 bytes each.
+ */
+static int adxl345_read_fifo_elements(struct adxl34x_state *st, int fifo_entries)
+{
+	size_t count, ndirs = 3;
+	int i, ret;
+
+	count = 2 * ndirs; /* 2 byte per direction */
+	for (i = 0; i < fifo_entries; i++) {
+		ret = regmap_noinc_read(st->regmap, ADXL345_REG_XYZ_BASE,
+				st->fifo_buf + (i * count / 2), count);
+		if (ret) {
+			pr_warn("%s(): regmap_noinc_read() failed\n", __func__);
+			return -EFAULT;
+		}
+	}
+
+	return 0;
+}
+
+/**
+ * Empty the fifo. This is needed also in case of overflow or error handling.
+ * Read out all remaining elements and reset the fifo_entries counter.
+ *
+ * @st: The instance to the state object of the sensor.
+ */
+void adxl345_empty_fifo(struct adxl34x_state *st)
+{
+	int regval;
+	int fifo_entries;
+
+	/* In case the HW is not "clean" just read out remaining elements */
+	adxl345_get_fifo_entries(st, &fifo_entries);
+	if (fifo_entries > 0)
+		adxl345_read_fifo_elements(st, fifo_entries);
+
+	/* Reset the INT_SOURCE register by reading the register */
+	regmap_read(st->regmap, ADXL345_REG_INT_SOURCE, &regval);
+}
+
 static const struct iio_buffer_setup_ops adxl345_buffer_ops = {
 };
 
@@ -390,30 +440,34 @@ static irqreturn_t adxl345_trigger_handler(int irq, void *p)
 
 	ret = adxl345_get_status(st, &int_stat);
 	if (ret < 0)
-		goto done;
+		goto err;
 
 	/* Ignore already read event by reissued too fast */
 	if (int_stat == 0x0)
-		goto done;
+		goto err;
 
 	/* evaluation */
 
 	if (int_stat & ADXL345_INT_OVERRUN) {
 		pr_debug("%s(): OVERRUN event detected\n", __func__);
-		goto done;
+		goto err;
 	}
 
 	if (int_stat & (ADXL345_INT_DATA_READY | ADXL345_INT_WATERMARK)) {
 		pr_debug("%s(): WATERMARK or DATA_READY event detected\n", __func__);
 		if (adxl345_get_fifo_entries(st, &fifo_entries) < 0)
-			goto done;
-	}
-	goto done;
-done:
+			goto err;
 
-	if (indio_dev)
 		iio_trigger_notify_done(indio_dev->trig);
+	}
 
+	goto done;
+err:
+	iio_trigger_notify_done(indio_dev->trig);
+	adxl345_empty_fifo(st);
+	return IRQ_NONE;
+
+done:
 	return IRQ_HANDLED;
 }
 
-- 
2.39.2


