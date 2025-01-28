Return-Path: <linux-iio+bounces-14665-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1DEA20A18
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jan 2025 13:02:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B400E166A6D
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jan 2025 12:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB2E1A7253;
	Tue, 28 Jan 2025 12:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bTAsiK8N"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA1A1A2642;
	Tue, 28 Jan 2025 12:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738065699; cv=none; b=V8L/nZwfMGcUTNTmd4ZDWg8mPYlPLqujNPXR/JBA6AUXHQTPaYjPjfTWEcXm64/5Ri3aVkPeT1ovTEKdGzEjPIvtYAyszZLb3abL9m3ncUvxrofHmKxuYfUzBO286xuBYjZQUB5DprsVl40YBzq2tGgLWbZFQvu7zzequOqdAyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738065699; c=relaxed/simple;
	bh=ZFz+bNWBdxFwKvj5JBvO3WzvviDOLiFHaUfL5nFMdWk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GWfSRTqg4zatOBTLB+Il1OmtcPI0kT0IfCKyeZTo4+yl9YyVpiykH4tAs8Vp0LePtWm8sQykAytAA8+4PeSpOyXqJUTHivYVxArreabPkUfu6lCL+9aRRd38juEX/DFBF9A/7JoLlmcSSRQed4U2Q6ouX5tzx8AX//KC2lRYpts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bTAsiK8N; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5dbe706f94fso1294765a12.2;
        Tue, 28 Jan 2025 04:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738065696; x=1738670496; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NSksiAWnSWBTZBpd0M1uNpje3o8Xf8ZMdfKn4UpGQtU=;
        b=bTAsiK8N5NKSN0dz7eIWbJxR/L4xIX6+fzwFv7gNHJob9vLK17q+IRo+nZRC+a0Fu9
         l6RXFgbBhXWmn6exSaFCBJp4bDY4uDjsOJ20afHWBpsR//1m6StH5+8Y78JM2uPacteB
         bVYf+v6ACm+LWjri9tTt+8UL3A37S1gCk1/vPIU0aXdTZPizPM/0rABfqw8eYh0nWMIF
         0hCVROOjw5ARPKxFRS9h0qm379kQqNnSPvDCArTwD5v244DqYPK2eV4xQ0F86744tQdN
         IyWch4whdJS20fIXxkk4C+BX5/BXuX4eppPijr6p+UuutAq71pGWFguyrL9VeCNm1j6o
         aMlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738065696; x=1738670496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NSksiAWnSWBTZBpd0M1uNpje3o8Xf8ZMdfKn4UpGQtU=;
        b=sxMcFzdZwQp/x9gunaC+v4jYyvQg3YvgEogD4FsNaN667fHS8SjdFB3R0rvnZBI28j
         gGxaGmcq+06m5s2qNCEFKVcZx4b4Ab1rRv6+whs+Tr4z+xITBFwZ5U3kgk1uAH5VX0S7
         kd/k+nLwLHk1pvMd/tbcnIVYIiRwzg+y6tdVwzm+zFD7tROrD7ylo7jdK20jyytCP0/Y
         df6WAUSPQRO+rd4CGmeUPPd6YsWB//G+5mtAT5ntUbt3GXjdmAGX6Wj1+wENhQGUC1Fv
         qAHtipXCj/3ftrdQjmrvX2F5kDu5HfqDFlnip6lIA6rGulDa2tj0mxIRMBzKJPyMtDCb
         weTg==
X-Forwarded-Encrypted: i=1; AJvYcCVD9Q8SRcmFKvX21ruYW5SjWoKxxTNAY22woZA8iJE/T1lO38xx2DCEbaRyF2dyJpsdx33wc37UgJlAMxA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy30eh47+rL791Nl2LLikZYl36bT7jESlgmww4aPpA5CF+tFwqD
	S/0k7NHlS5l4Yhy7sblpBhwezpZubIuyFBOPPsNnH1FTdWMDk0gr
X-Gm-Gg: ASbGncurqVcl+9GXo6Sj2wXTikaTFUynDWY6LTTN6unfTDNV9hpSL5gE/BY9i0SLxsC
	Z3u+zdMY8V/sLuVzh6Krhi6utWpX/qBHfZG+Xv3JEEmQ8jWvOyr7oaT3mAecMadbEoz7ENR6enG
	2F9crzOUjtZw2ECXvcoH3t5z8Ifh5Ltx2gAfBshLAyMdNz4QFYuL2dHHQY/qgo8vrWmFQF3ZF9L
	Q0pRrh5IvL5dJI2Cyv0a7mA6Ygm8UVjtMTRUIGasra9L+ydIxQh1lS/EeOqApYOysveJdXP81f1
	R+YX1D5EC4CK1vHACTGIeVCAFKLbPlkKaKXX5qO7HTPZi9lIl4Zi7ssCMxYZrs/XNpvWSA==
X-Google-Smtp-Source: AGHT+IHA9mxdm48PiQgAzgx9xYQ6pmLui4qTn/LtbVMF20kQadgBYdTwi8ZbGp7T+Psix4WfCtQB2A==
X-Received: by 2002:a17:907:948a:b0:aa6:6792:8bce with SMTP id a640c23a62f3a-ab38b1b6f43mr1423110066b.3.1738065695477;
        Tue, 28 Jan 2025 04:01:35 -0800 (PST)
Received: from d9dabf0abd47.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab69f8555b7sm418865966b.71.2025.01.28.04.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2025 04:01:35 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v1 04/12] iio: accel: adxl345: reorganize irq handler
Date: Tue, 28 Jan 2025 12:00:52 +0000
Message-Id: <20250128120100.205523-5-l.rubusch@gmail.com>
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

Reorganize the IRQ handler. Move the overrun handling to the bottom.
Overrun leads to reset the interrupt register. This also happens at
evaluation of a particular interrupt event. So, actually it makes more
sense to evaluate the event if possible, and only fall back to pure
overrun handling as a last resort. Further simplify fetching the
interrupt status function. Both is in preparation to build interrupt
handling up for the handling of different detected events, implemented
in follow up patches.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 8fbf0a43746f..7ee50a0b23ea 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -491,16 +491,9 @@ static const struct iio_buffer_setup_ops adxl345_buffer_ops = {
 	.predisable = adxl345_buffer_predisable,
 };
 
-static int adxl345_get_status(struct adxl345_state *st)
+static int adxl345_get_status(struct adxl345_state *st, unsigned int *int_stat)
 {
-	int ret;
-	unsigned int regval;
-
-	ret = regmap_read(st->regmap, ADXL345_REG_INT_SOURCE, &regval);
-	if (ret < 0)
-		return ret;
-
-	return FIELD_GET(ADXL345_REG_INT_SOURCE_MSK, regval);
+	return regmap_read(st->regmap, ADXL345_REG_INT_SOURCE, int_stat);
 }
 
 static int adxl345_fifo_push(struct iio_dev *indio_dev,
@@ -536,14 +529,10 @@ static irqreturn_t adxl345_irq_handler(int irq, void *p)
 	int int_stat;
 	int samples;
 
-	int_stat = adxl345_get_status(st);
-	if (int_stat <= 0)
+	if (adxl345_get_status(st, &int_stat))
 		return IRQ_NONE;
 
-	if (int_stat & ADXL345_INT_OVERRUN)
-		goto err;
-
-	if (int_stat & ADXL345_INT_WATERMARK) {
+	if (FIELD_GET(ADXL345_INT_WATERMARK, int_stat)) {
 		samples = adxl345_get_samples(st);
 		if (samples < 0)
 			goto err;
@@ -551,6 +540,10 @@ static irqreturn_t adxl345_irq_handler(int irq, void *p)
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


