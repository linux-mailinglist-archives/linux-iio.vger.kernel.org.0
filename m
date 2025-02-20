Return-Path: <linux-iio+bounces-15830-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09102A3D70E
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 11:43:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05C2A189B649
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 10:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD331F1908;
	Thu, 20 Feb 2025 10:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JdPrcW0N"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFA01F1501;
	Thu, 20 Feb 2025 10:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740048165; cv=none; b=LqJhhr9GgDMPpLLCpWXQKOpEFY1rwSIpYli7+MiXslJubaegSnwPnix6ceSJpTe3u7l1hnqyxjyRty0ErmJxs2tQj/dfhkPIAAYXpP8Gh2QSye4Ms3yXNgAowT/D2ye/hCTfZCRaVGLzkf8WufBVG8wyVWtEjUispWwQ8xodv/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740048165; c=relaxed/simple;
	bh=wbxfX09TzoIBMSmBgptsO5WWrSNdjcsVRR4ZDcDUhbo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s/GOesY69MhzXk9e2kUpkcxrJaCvFvHAbTAPLCajEV4bo1WdhsCFAYzTB5b/hOmzE8RhFum3HTWaFgkH7pVXt0NmZ3MSf9/M9q5HMUi1dKU27Aao254NZMOwgm6psx/z+2zNJsVohjA66wJ0aIGnD1devuY/eyc6Sq1ROgtvcd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JdPrcW0N; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-abb7d5a6577so8420866b.2;
        Thu, 20 Feb 2025 02:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740048162; x=1740652962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8K2ZzOa2Uc4cWyjff2Lb5mmcv1j444GezcCQd7LSPuE=;
        b=JdPrcW0NdMSc6cF0y+WxeUw1v/V/nBohnjF6jrcVsDuPKKYEQCaaJK9l+Bje/A1r8b
         f9XNpLjk4pm3YqjeJ6FDyJw/2JCTWZCcIVYLu6XbJRkG/5y6jcoJpjGoi+P2k7GBpy2o
         h7yJINV6qaZEOiaSp5I+kOo1J+XiZBEd3HclG9i+XqRlGxeyg08unbEykxprvhVJpt8k
         BJEXtg2lU28o6bWEznmUIf0lFytTmQeHl99BUXNeYHBSIRbK1+d9wJccB82BGiym1Ago
         bQ6VZEg3bRFCccbtRKPnHzy9CHe8J7jsM78cpxeZsoPVZtS0gIMS0H2DHXUMfgkT7IQK
         62hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740048162; x=1740652962;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8K2ZzOa2Uc4cWyjff2Lb5mmcv1j444GezcCQd7LSPuE=;
        b=DMtDPQS2KH7HyVb+QZ4K1rv8DbYM7uPQgiDcKuwpReWRXHzusGiuyOMnF1YLzN2xbH
         rZ3FDm83nwv2SkMQPo17B7tjR65M9xw2CIumGWnAlTl0yAex4ZiZImADH+6vpMRmxO14
         r9wQ/Zl80XIAXibufBwe/VkQmT7RgPDryIq8MAH6LW3v87n8LEJYFZbRZ+541hVpdV9+
         nz2vdaAiF+9ytbHj3KropEPldOkP0vyZQ2U2zXwa2BOTL5Td35kymZ1GnN3UE+bI0+N4
         7FzjqnjWyoABbElKTlndPsYR/HkSORhRyWBqQsfkLza32c6CD7SsLRezq1gmZ8+86dLG
         j5Nw==
X-Forwarded-Encrypted: i=1; AJvYcCU6y749zyZUnNMn2VH+20wAykL9zX5Sz5E0B22x04/WngZ2t5b+U/GLoFrcVRZ0AMCxZQFskW4uOo+y9Uk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu3WiyzXkXew1qiYgZjAUYKtvJT7W+6FL/fFpnewGcCT4gjTCu
	Kn2k/BZW/6RYpJpPQFwyMYcJxFGaBu50RzsoYlJtcu1Ijm6Eb1tK
X-Gm-Gg: ASbGncuhV9Fe7nrHRzjzwgapHb6pcitDAnxXbttg9PPEyDS5L1nRTkXJ897gFb1zhdk
	uFGM5o8Vm+DqR44Nt8/s52ANW13HwG9LlGb13j5PBBxetGoGXRo53gonuRlbMW5QTQZdGoGz/Yf
	dFHqqoCScFldmHc10qgYGCMU4kENa5OX3GWpkbht7Eg/f0oW4QBwMZzv6Xa7lmKowoYMnMLD4LY
	6u3URu8bxOAiK+q9W+4IIoqGADctzW3Gq9vyrY6vulwPeq8I2OzIXbFqdSeM5WwTj+ozDCuGMUc
	/aUThUbf0EA8F7RDf2hubRWyZrefGhu6lmGmnYWAG1vK7+LiWs1/gsSKkxgo0p8s6RqZTQ==
X-Google-Smtp-Source: AGHT+IGT+/snrJ81C+C5modsjEmsHXltWHyhfaacH0dJK/NVjdAEeW5BTNpL5U6oVcNgkPtQke1sEw==
X-Received: by 2002:a17:907:3f9a:b0:ab6:d660:c84a with SMTP id a640c23a62f3a-abb70ab8c2dmr829701366b.4.1740048161507;
        Thu, 20 Feb 2025 02:42:41 -0800 (PST)
Received: from 0f997e1ceb21.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abbdfcaed55sm246474866b.137.2025.02.20.02.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 02:42:41 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v3 03/15] iio: accel: adxl345: reorganize irq handler
Date: Thu, 20 Feb 2025 10:42:22 +0000
Message-Id: <20250220104234.40958-4-l.rubusch@gmail.com>
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

Reorganize the IRQ handler. Move the overrun handling to the bottom.
Overrun leads to reset the interrupt register. This also happens at
evaluation of a particular interrupt event. First evaluate an event
if possible, then fall back to overrun handling. Additionally simplify
fetching the interrupt status function.

Both is in preparation to build interrupt handling up for the handling
of different detected events, implemented in follow up patches.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345.h      |  1 -
 drivers/iio/accel/adxl345_core.c | 27 +++++++--------------------
 2 files changed, 7 insertions(+), 21 deletions(-)

diff --git a/drivers/iio/accel/adxl345.h b/drivers/iio/accel/adxl345.h
index 517e494ba555..bc6d634bd85c 100644
--- a/drivers/iio/accel/adxl345.h
+++ b/drivers/iio/accel/adxl345.h
@@ -43,7 +43,6 @@
 #define ADXL345_REG_INT_ENABLE		0x2E
 #define ADXL345_REG_INT_MAP		0x2F
 #define ADXL345_REG_INT_SOURCE		0x30
-#define ADXL345_REG_INT_SOURCE_MSK	0xFF
 #define ADXL345_REG_DATA_FORMAT		0x31
 #define ADXL345_REG_XYZ_BASE		0x32
 #define ADXL345_REG_DATA_AXIS(index)				\
diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 468d562de227..22c5a9c08459 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -107,8 +107,7 @@ static int adxl345_set_interrupts(struct adxl345_state *st)
 	 * interrupts to the INT1 pin, whereas bits set to 1 send their respective
 	 * interrupts to the INT2 pin. The intio shall convert this accordingly.
 	 */
-	int_map = FIELD_GET(ADXL345_REG_INT_SOURCE_MSK,
-			    st->intio ? st->int_map : ~st->int_map);
+	int_map = st->intio ? st->int_map : ~st->int_map;
 
 	ret = regmap_write(st->regmap, ADXL345_REG_INT_MAP, int_map);
 	if (ret)
@@ -404,18 +403,6 @@ static const struct iio_buffer_setup_ops adxl345_buffer_ops = {
 	.predisable = adxl345_buffer_predisable,
 };
 
-static int adxl345_get_status(struct adxl345_state *st)
-{
-	int ret;
-	unsigned int regval;
-
-	ret = regmap_read(st->regmap, ADXL345_REG_INT_SOURCE, &regval);
-	if (ret < 0)
-		return ret;
-
-	return FIELD_GET(ADXL345_REG_INT_SOURCE_MSK, regval);
-}
-
 static int adxl345_fifo_push(struct iio_dev *indio_dev,
 			     int samples)
 {
@@ -449,14 +436,10 @@ static irqreturn_t adxl345_irq_handler(int irq, void *p)
 	int int_stat;
 	int samples;
 
-	int_stat = adxl345_get_status(st);
-	if (int_stat <= 0)
+	if (regmap_read(st->regmap, ADXL345_REG_INT_SOURCE, &int_stat))
 		return IRQ_NONE;
 
-	if (int_stat & ADXL345_INT_OVERRUN)
-		goto err;
-
-	if (int_stat & ADXL345_INT_WATERMARK) {
+	if (FIELD_GET(ADXL345_INT_WATERMARK, int_stat)) {
 		samples = adxl345_get_samples(st);
 		if (samples < 0)
 			goto err;
@@ -464,6 +447,10 @@ static irqreturn_t adxl345_irq_handler(int irq, void *p)
 		if (adxl345_fifo_push(indio_dev, samples) < 0)
 			goto err;
 	}
+
+	if (FIELD_GET(ADXL345_INT_OVERRUN, int_stat))
+		goto err;
+
 	return IRQ_HANDLED;
 
 err:
-- 
2.39.5


