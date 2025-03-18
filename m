Return-Path: <linux-iio+bounces-17056-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B7BA6807D
	for <lists+linux-iio@lfdr.de>; Wed, 19 Mar 2025 00:09:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C37657A5E6D
	for <lists+linux-iio@lfdr.de>; Tue, 18 Mar 2025 23:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5D9213235;
	Tue, 18 Mar 2025 23:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jZkZYhhm"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206C7207A3A;
	Tue, 18 Mar 2025 23:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742339338; cv=none; b=kwreeMUFbDXxEiUWcQ+6tWH1b7zriprp7DmUvdohGQG2N5yzvAdxA3aFnParRds7r4HwLuVzKZC6UgurWpcAC49zeU8MA31IUgfJfxybwFrL+Sz40XwcK+UBxEdKxHjOUdbOepDxgp9DQ6Wl46avhLYXU0uM+to+UFdSs3Pz9+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742339338; c=relaxed/simple;
	bh=fM3+KC/UZ31kXPGTb5S0rsSfrRmlbZY6btYAdurQouc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nz70JJrihqHlNpbaMX0mjh8IpEPbrtSMkuL3pfAa6ig/wGpF2o9Qdvxp0A3bhUgZ6MHR+0i7b2Y0vU3Iv2EcrbFgNp86e/9XrwY7yIV3E5GChYhrrQqFPuEKlMeCoIQmchpQDeFW6gHWZjW+M9NweGSu1+qr+xqHyA2GlR8jhWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jZkZYhhm; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3912ebb8e88so839947f8f.0;
        Tue, 18 Mar 2025 16:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742339335; x=1742944135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yL1NluBLKnVOXTYYd19e7pbv7E9LsYXKQXHoL8wk6rg=;
        b=jZkZYhhmNyInlHST860hhu6ylDz8Y3OHSTtbS15/kow27vPkqDUj0djdBtpd/ErtUb
         z4FQOggzjNhNg94UbFGFtJaFxOi3NLZ/MJDoqJ3rcG8ZHMQL3uOY4EKvEHyr1qKB8AUk
         gIBRSryj0YvyiGsqZBuLFX1USEzYIsXTpp3//XbrERQNP09ydAHuD5nCHQc9N/6LvzMx
         ozIDL73Y34LwU9zROEPPSLHimxnQZx859EVrP+RQoaXzibCuwoah/NwPhAzNspcae81E
         O1PgxtAfYAXMG/67Rake1Ukb/MJqKjkUHFFuSx/XJM0ZkJe7rvqjGS+Btt9bit7SrANm
         XOrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742339335; x=1742944135;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yL1NluBLKnVOXTYYd19e7pbv7E9LsYXKQXHoL8wk6rg=;
        b=wPjLzTy3DGYSGIwrHvUbZZeEYRzbHCHKf99bDiMGiDUwiC1YfiWVpGQQnPpAEGdksM
         KtwdOstvxNusWyk/sppoBG2pffuoUppjT1Mau928j3pFeReaVig2+BiszvyM5HFQ5W/5
         K+Ub/dH/GTMjPVG3nmtQRaFO4Ki5MRvDA4TcVzVExdnQI36p4GK8jUmh+eskGcjcYJiR
         hnZeHWbC97GnbmlJFP80WP+pxETnnmWOVj2iDZ5dzclMmkTRpX5OlBDkC3a07NtMaYP/
         6Mvqzyv1jTPs+US1HSMbnRly6DT/asu2ltbJl2+JTPJ5DfLeJw8OnDCh+iTRDEW9Kxcl
         0hpg==
X-Forwarded-Encrypted: i=1; AJvYcCXc6+xPQl8INRPtddz2O9WUmSq7d3E2oIKeJ5lkHnKtg/HfW8hahGOXPDntLA8eHuEfasHv0ZZGyVERUts=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCQljSABa44sZvGoLkhGEaoHa+w+hY0gvH+Z1jXJDLLhSGwSfg
	3CnIV0l5a2jWdDHAGHzJng+vAwW2aTE48XyT2LxIWxitOP5ln3MN
X-Gm-Gg: ASbGncucqfudYAgOrinEzA3Dc67zfNyyFuuGOIW4hjZLlMMsHA+GNvdg0CfIuyTXC5T
	WCv8vjfooCwEER66emTg0wjmnOU9OuTZeNjGnZsaghSYj5QybvtDn5EUBHlLq1Hvgv/JXtgsgLx
	P7xw+Q+VCYYcrMEcYiVdPWBB3YBBlPAB8chJ3M7YMfh+1c4L0nLvjOSpqLMudeQZu/hgj/0EKHA
	0bJvdXl4gnZEE/mmGLSa+05WwF/5vyrCAOQi4HO6QROSSlbVMkK4yzsNsqfWJQBWdEmMhhBHub9
	ERNZnOwG7IO4bVt7yQWMYJjSkoIxvl8YpS79UZbVugFxvw/auNozUL74RfF5BFDbaTFfraRB441
	ufFJKQBmHiYQYg4umHq5R/QA=
X-Google-Smtp-Source: AGHT+IH28s3Q9PxrRlA0g5h6AlhKffP4S7eRBc+J04iyS3O3vq2Feu1VNoRmsobYiDGkTvXom+mzfA==
X-Received: by 2002:a05:600c:5250:b0:43d:301b:5508 with SMTP id 5b1f17b1804b1-43d43782e4cmr1113115e9.2.1742339335217;
        Tue, 18 Mar 2025 16:08:55 -0700 (PDT)
Received: from 0e1b0684397b.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d440ed793sm1113455e9.39.2025.03.18.16.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 16:08:54 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v5 01/11] iio: accel: adxl345: introduce adxl345_push_event function
Date: Tue, 18 Mar 2025 23:08:33 +0000
Message-Id: <20250318230843.76068-2-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250318230843.76068-1-l.rubusch@gmail.com>
References: <20250318230843.76068-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the fifo handling into a separate function. This is a preparation
for a generic handling of the interrupt status register results. The
function is supposed to handle particular sensor events, and later to
forward them to the iio channel. This is needed to read out the interrupt
status register.

The function shall return occurring errors, if any, or 0 in case of
handled events or read fifo content. Thus migrate fifo read-out and push
fifo content to iio channels into this function to be built up with
additional event handling.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 1b4d9e60c87d..a98fb7fc748e 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -416,6 +416,23 @@ static int adxl345_fifo_push(struct iio_dev *indio_dev,
 	return 0;
 }
 
+static int adxl345_push_event(struct iio_dev *indio_dev, int int_stat)
+{
+	struct adxl345_state *st = iio_priv(indio_dev);
+	int samples;
+
+	if (FIELD_GET(ADXL345_INT_WATERMARK, int_stat)) {
+		samples = adxl345_get_samples(st);
+		if (samples < 0)
+			return -EINVAL;
+
+		if (adxl345_fifo_push(indio_dev, samples) < 0)
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
 /**
  * adxl345_irq_handler() - Handle irqs of the ADXL345.
  * @irq: The irq being handled.
@@ -428,19 +445,12 @@ static irqreturn_t adxl345_irq_handler(int irq, void *p)
 	struct iio_dev *indio_dev = p;
 	struct adxl345_state *st = iio_priv(indio_dev);
 	int int_stat;
-	int samples;
 
 	if (regmap_read(st->regmap, ADXL345_REG_INT_SOURCE, &int_stat))
 		return IRQ_NONE;
 
-	if (FIELD_GET(ADXL345_INT_WATERMARK, int_stat)) {
-		samples = adxl345_get_samples(st);
-		if (samples < 0)
-			goto err;
-
-		if (adxl345_fifo_push(indio_dev, samples) < 0)
-			goto err;
-	}
+	if (adxl345_push_event(indio_dev, int_stat))
+		goto err;
 
 	if (FIELD_GET(ADXL345_INT_OVERRUN, int_stat))
 		goto err;
-- 
2.39.5


