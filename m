Return-Path: <linux-iio+bounces-27950-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EECD5D3A4E6
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 11:24:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 19571300D916
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 10:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9043C3563E5;
	Mon, 19 Jan 2026 10:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="RuwU6LYG"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6856B2D838A
	for <linux-iio@vger.kernel.org>; Mon, 19 Jan 2026 10:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768818204; cv=none; b=uuV3cp9fnj+EoX6fFR3XEWXv4r0eKQSa9fkV188JpMUcbtWjga2AIsNf3fLWIcVQuypglnE1IcATWLiozElm6iGcLBSM9KkexPBOY1m5OQVGyi6TXJEhZFmDOxj93wAtBWw+s/N+ZR+mabzma4HvXHlfWorOZyP1T+Z/TjjBhTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768818204; c=relaxed/simple;
	bh=b6in0Ht1436ypEjKdmBzGtAzQIUtZlNjgIlaQ/Kz8dU=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p7Y3QBffZnG7ngPm0LoSaKnUA5LjDpecEavMl1MM5U7lRiyHbVFs2VNxBxtzWE9USeHOKh3epDwR8tVH2zNdiIhLm/1gWDFvTARUi4T98TXrMsrot7JKpRVH2pkuEXhtJHJJGPe+7Ep3CWFjY+dKGemvJvi4R1A9czosGy5c4Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=RuwU6LYG; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-652fdd043f9so7680550a12.1
        for <linux-iio@vger.kernel.org>; Mon, 19 Jan 2026 02:23:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1768818201; x=1769423001; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D7eVDtNz1S15iD4VZqEhzSlov8EZT29gxIYBEknUL5A=;
        b=RuwU6LYGs2JWIeZN8UKH1hE5GWjyRdcsC/OQe81Yx0SFmsGquHNfC1FCEsZPgAM9T6
         R5BWPggVy3GYZabY1ezPczMiIQR2qehV8nswgVW8+CXC9fkexd0xlG//j6mddROC5QWQ
         3TxUUxRbig9eM0Gx3hydgLL2S21vBGXYlvaHL4h+OYjIhB0oVSrGDWLtUByoUdEL6tj5
         sYwwNCdOSa5YryvUdoNbg/aodB1d35MjnK6JE/94Ud1/S0mqnwATV2S+Jor1YAnaArD9
         G+dDUIZpBYflA2QMErFedHuXdBC59eti9cfmoZORZSKFxYl7wpScCAqlsuxTKx8/QtLB
         DZVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768818201; x=1769423001;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=D7eVDtNz1S15iD4VZqEhzSlov8EZT29gxIYBEknUL5A=;
        b=lZ8JwdVCBG+mgJbEmZG8R9+HiMnfHk/Eb8MhKItkpN4ws+0MeIvQZw3w5lOjMyiZUM
         q22GUjeI4Bie9afmd2QXydfRRUmvNuXZGfAW96KCcJ9qxxsU0gIxmUNp2BD21B2cGM/j
         gxTvc1JwU9dyTtGCstvcuyYKMB93w364vU/uIkPcIuhmQJH1ez+0GNQuSFATkV4dzNHn
         BdUs52yoCfadIQ+LShPC1DwqmaINZbpq3EzcRrVcD2Rqv/gD9SByyWyFHYfuWNCOLnim
         xgyYjPTc/AvfvPhIkKovB+N4eVHq8+gdGBfWL1PNybZRgZlAlJEkyw2mEN54y23YlZB0
         jZtQ==
X-Forwarded-Encrypted: i=1; AJvYcCXO1AtCJYXDmFVq08JJi3Gv7oZ4K47yGMhXud0YD9W4O8LF1LMGmEWHTbs1h7JH8B70rk/RxWk9mxQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8koPH0Lcy06hxumkZQUQ2NWZuPCd9VEUKeaXBMdb8E88cbUpC
	fGKyr4xI3nKCPhf8s6fZtP5/JOii+yA1ZrwkhdBWEpQiDgEazsI+vVYJycspDuijU4Y=
X-Gm-Gg: AY/fxX79N/tsEplfu2xh7zTFHe0EsnVAk9hJbSc9vn03BLm2LhL3vnpIFeoWNBYRKS3
	osB1uTFoyuhQ0oWHEqBDJXWn0i4+pxSUzbDmFy35MTB+ysV0b/anxiYxwiLDf251MeM0A9eJUDC
	bHVLEIjjejVah0TvU8zHjZjBqEQhPPfJMfH/IPa+ZAu7WXf3mJ016VbHtija4iciwgS6USiV1gH
	PyNTNVRTK5WGZ2cHcyb1T1QmS3OI744ovZK4E8TzSdUjW4hHsH/LyIOHCwg+65vKD82cpGlMhzK
	JXeh4K+QlJ2JfmqstpbtuBZI6/DpYCQrlwYqAgPiLwSKUFzYXNLV1dRsp0tdksLySlLALS0P0xF
	q2deUUdrhtzN/24TSIU3LFVAb3fTg/EFksH/UucenNuvWdNJp/fx//t0=
X-Received: by 2002:a17:907:702:b0:b87:2cf8:f7b2 with SMTP id a640c23a62f3a-b879324c7c0mr1047597666b.56.1768818200709;
        Mon, 19 Jan 2026 02:23:20 -0800 (PST)
Received: from localhost ([151.37.196.5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b87959fb973sm1041021866b.53.2026.01.19.02.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 02:23:20 -0800 (PST)
From: Francesco Lavra <flavra@baylibre.com>
To: Ramona Gradinariu <ramona.gradinariu@analog.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] iio: accel: adxl380: Optimize reading of FIFO entries in interrupt handler
Date: Mon, 19 Jan 2026 11:23:17 +0100
Message-Id: <20260119102317.1565417-3-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260119102317.1565417-1-flavra@baylibre.com>
References: <20260119102317.1565417-1-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1332; i=flavra@baylibre.com; h=from:subject; bh=b6in0Ht1436ypEjKdmBzGtAzQIUtZlNjgIlaQ/Kz8dU=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBpbgX+f/Fu5JWFdXqfTUi8b0UQeUZZQLtzByfcW hGTcFBhIdSJAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCaW4F/gAKCRDt8TtzzpQ2 X9BDC/9LBzlxQ8Y54d/g5Wr06Tf4A6RQi5kePBMrUK06u/lYJXHr9CRhXr9756L6TgzJ9Y7amPU bzu57EKr+1UFpfCF9dMyf8eaxFT/0d8VDxVkPI7vWyf23yV3ygQlis6qtdevQwnR0KE8RP/oVvL DjJg+6CmsCn/b6KEapQ4JUwhM3X+kAEsG1fNFVDnSsugoO3DahMuM3I2DHHUUIUBn+gqr54LVBW k0rhiANhXbLAC8XCbdomvl80DAYxqpiRhUOv84R1QT+Zsf5d+Z5TBpKmuQKNZLJnq0P6Sl0CJ7S EpGv2et7KDAXiyZcYPVYq8ABLsQGCBya9twScFoXT3xcOowcV+L7SI2LKdh05W98uKFzu677Ilv RHFjjzio58IieEtUT8bDJGWYykYeiW5YOdoj2n527pR7xEryEciCgMzQa7GDY08jvExxRFm/JxB i4DSDtH2WW7tDxn3xju5fBLlZmY48Bz4JbyCoyxFiBwal2/fRquuFXVrysTUb9KJKtntc=
X-Developer-Key: i=flavra@baylibre.com; a=openpgp; fpr=8657854F953BDCA31EC314E6EDF13B73CE94365F
Content-Transfer-Encoding: 8bit

In order to minimize the time required for transferring FIFO data from the
sensor to the host machine, perform the read from the FIFO in a single call
to regmap_bulk_read().
This allows reading acceleration data for all 3 axes at 16 kHz
sampling frequency using a 1MHz I2C bus frequency.

Signed-off-by: Francesco Lavra <flavra@baylibre.com>
---
 drivers/iio/accel/adxl380.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/accel/adxl380.c b/drivers/iio/accel/adxl380.c
index 650cdbffd4a7..e3e6b182eb3d 100644
--- a/drivers/iio/accel/adxl380.c
+++ b/drivers/iio/accel/adxl380.c
@@ -965,14 +965,12 @@ static irqreturn_t adxl380_irq_handler(int irq, void  *p)
 		return IRQ_HANDLED;
 
 	fifo_entries = rounddown(fifo_entries, st->fifo_set_size);
-	for (i = 0; i < fifo_entries; i += st->fifo_set_size) {
-		ret = regmap_noinc_read(st->regmap, ADXL380_FIFO_DATA,
-					&st->fifo_buf[i],
-					2 * st->fifo_set_size);
-		if (ret)
-			return IRQ_HANDLED;
+	ret = regmap_noinc_read(st->regmap, ADXL380_FIFO_DATA, &st->fifo_buf,
+				sizeof(*st->fifo_buf) * fifo_entries);
+	if (ret)
+		return IRQ_HANDLED;
+	for (i = 0; i < fifo_entries; i += st->fifo_set_size)
 		iio_push_to_buffers(indio_dev, &st->fifo_buf[i]);
-	}
 
 	return IRQ_HANDLED;
 }
-- 
2.39.5


