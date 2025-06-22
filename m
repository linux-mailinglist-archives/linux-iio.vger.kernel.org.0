Return-Path: <linux-iio+bounces-20874-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7920BAE3096
	for <lists+linux-iio@lfdr.de>; Sun, 22 Jun 2025 17:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 649D67A5D25
	for <lists+linux-iio@lfdr.de>; Sun, 22 Jun 2025 15:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7B61F4180;
	Sun, 22 Jun 2025 15:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HIC1POCJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9B01AF0C8;
	Sun, 22 Jun 2025 15:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750607419; cv=none; b=eXhz5FYsUU9OIjrlIwzRvlVXwb4TT/WO3tcgq/ThSMto0TU/l1MJdNwVprlsoWyvQO1QEXl9aDGIKacDg8V5QTbPA5DC6Cozogw2oLv0OjtTjYqHqiuTl2ruGhsKMGWf3fMOt6UstbBF6B60bJZlCxYUhGKE1rTdViGdFCpn+ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750607419; c=relaxed/simple;
	bh=ydgCnLipKVTUj6twIc8q705fS0jiwcTDmecnkO84tUw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KfvrSlHUIbd57UIM1CgRt/mjUTDS6qdt0X8q6l5er3iL4zVYvvAnoDJvzFTC/nWNl/xqzYkZ5TxniS7+tkZmWhxEkdJNnhd7sEPLP7U87shXiV2htfGNBNZm7wcdrtQdcrhWTEnznD+rKOMviDzITFQ6HcPzxaZPgL9j8p6bsHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HIC1POCJ; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-606b39b19b6so746845a12.1;
        Sun, 22 Jun 2025 08:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750607416; x=1751212216; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=86cTLjMIiPRxzeY6qqdXZaoqO74rsoMKFoqJkm2eOc0=;
        b=HIC1POCJdBWCaI1sAaJzzmqhNyfab+3ga9bT4dkBqIooPiV9bokXjvOK2QDgM4rexg
         pRyrfOqXvNH+U+0i3wYPMfH53DmkKwZtZy+6tCoJLswoLGILoG2gyjXm3tI9O9bVbxFT
         XgZFMfPdAR/J/7KWI9VrtlOFmmn+dNz9/aLRRk2T/YXtCd9PSJcWdawntvVGIGw+4QBh
         Po1uM+Zc+4LMqU1WUFYtBZuQ7cSRM9uGapi9yrIzUuJXLPpzvY3fsHGSx+m+hCimm5q2
         C4dIYPduZehzb1zQvIFQMelRT9MTl2rhXDHRb/V4USG82wXnouOZrav8nZuHcT0YCE+s
         V+Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750607416; x=1751212216;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=86cTLjMIiPRxzeY6qqdXZaoqO74rsoMKFoqJkm2eOc0=;
        b=uDAjemPo2QTOeZc1uVl47lWF7KCE4ahSyXwStGKOgfVPHOk9jvB5raCU/NxmwlTL2d
         n4k2hjdCct1tl+KRGcnHvfQ9sKnIt4NALrhc578blly2WeTHymy6CaISEcyi5lIEIXiJ
         +YqBmlpLwYmkp2Arzj+ghAHybGC9C6W7iFueEanISDgT0KdUU3+WWVT3lBDnQ0kJGIgu
         WFW+Rpbsv3lnNZN7Bun0FVmxyV67ORq5sMc7KbFCIeXJDExbUnLM9fDT1O8ieedE7tWz
         vEzTt85RxVS6RdO406dXggYMgI07tBNXQhbgDSAd31svlY2iW0eHRMPvtarHmweAxC8h
         WXuw==
X-Forwarded-Encrypted: i=1; AJvYcCU9IwrPDD7umuCL4qj179jScZEYpGYUUflinVAGdmSO4kMadQWLgPhHumzwg1GgklkD6Zp/dlhJ3g4=@vger.kernel.org, AJvYcCW8Bq9AgZuZ7gcYiXzlcD0HcEgjzFG0vpyXRzD7u5p7pYNUMsb15uSQBoihkDuHaVkqdPasPiflNw3TARk1@vger.kernel.org
X-Gm-Message-State: AOJu0Yzhg6//EJ3coIIwPh4VUI03WUMhhpoLThoYw27chtz9F6FH8/ET
	mOK+6kF2H05lnOrR5YMr4Moh9hRq3V+BO1ZP80RTDSPCSrzfsdRMzhKO
X-Gm-Gg: ASbGncv5vhTBR0QkXDdFmEwOcHnx9WDiSpGGYZvL+tw/sumYUPtA28m6BpFXzldtUX2
	IXiO3fBuoRalKI/+ddya3IqfJMVOnuJpM/pYgavheezeVjca0VEIgkflZh9uBwW4yEYgbWpp+Cd
	vfC+kgk2yLWD6yrhYToDQu1A14+GRsqShlr84ZP1G+CbCuJyGXZ8rE7Q36vYesCUoRh0JYcRlBT
	edLsd5lm9HCphiW82usNEbzbXDmhaMyGRDLLX2jkDSVmN6G6un14th79CyLb1DuNj8R4BE+iMOa
	ruEw7QtveX1D/1OBwnqSokHSf+ovrSdNf43gWdwGzEAtVP8b3FpfP+TYpBsXhTKBWxY518+v8gg
	JJo+kJ1X8eEPLh4bWeubMT1cRCrkcLuLI
X-Google-Smtp-Source: AGHT+IGQY9fkS1+Z+xDeRFps+Oef+vuNDVKW5BXKo7lx2nmKqtM7xXAjbnrfSXJM6nCo/YBwJiCxMw==
X-Received: by 2002:a17:907:e2e2:b0:ad8:a2d0:8f8a with SMTP id a640c23a62f3a-ae057b9a320mr282676066b.16.1750607416299;
        Sun, 22 Jun 2025 08:50:16 -0700 (PDT)
Received: from localhost.localdomain (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae053ecbd9esm552781966b.38.2025.06.22.08.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jun 2025 08:50:15 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	corbet@lwn.net
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v10 2/7] iio: accel: adxl345: simplify reading the FIFO
Date: Sun, 22 Jun 2025 15:50:05 +0000
Message-Id: <20250622155010.164451-3-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250622155010.164451-1-l.rubusch@gmail.com>
References: <20250622155010.164451-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Bulk FIFO reading can be streamlined by eliminating redundant variables and
simplifying the process of reading x-, y-, and z-axis measurement sets.

This is a refactoring change with no expected impact on functionality.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 6c493272a5b0..3821fe7cf2a0 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -885,15 +885,12 @@ static int adxl345_get_samples(struct adxl345_state *st)
  */
 static int adxl345_fifo_transfer(struct adxl345_state *st, int samples)
 {
-	size_t count;
 	int i, ret = 0;
 
-	/* count is the 3x the fifo_buf element size, hence 6B */
-	count = sizeof(st->fifo_buf[0]) * ADXL345_DIRS;
 	for (i = 0; i < samples; i++) {
-		/* read 3x 2 byte elements from base address into next fifo_buf position */
 		ret = regmap_bulk_read(st->regmap, ADXL345_REG_XYZ_BASE,
-				       st->fifo_buf + (i * count / 2), count);
+				       st->fifo_buf + (i * ADXL345_DIRS),
+				       sizeof(st->fifo_buf[0]) * ADXL345_DIRS);
 		if (ret)
 			return ret;
 
-- 
2.39.5


