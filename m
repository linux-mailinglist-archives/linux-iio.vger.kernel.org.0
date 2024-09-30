Return-Path: <linux-iio+bounces-9944-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C72DA98AE30
	for <lists+linux-iio@lfdr.de>; Mon, 30 Sep 2024 22:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 773D32825E8
	for <lists+linux-iio@lfdr.de>; Mon, 30 Sep 2024 20:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDEE51A254B;
	Mon, 30 Sep 2024 20:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BYj+weW8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0A519922D;
	Mon, 30 Sep 2024 20:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727727848; cv=none; b=TvDgaOM0gmHiwKZ52O/E4v750NI2XaaKIoT6jkaDSI7G4c75BuNAooSFpEpiaCgIpPTaMIu4T59gGkUJzV3hWu6wemcLZLU6fRXZ6xnFpbhN4vLR7RO/JYZ9d8LXeboBFuWSs6lo/kIv8jpfjDkqhluoM0JsOEcriVw7RIEOQeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727727848; c=relaxed/simple;
	bh=2dn2X/NNMtx/iHtMaH61vP7bvPFO7xJZhLbe0Ph4rFw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q+avuVBuqBGrpS9rmMr4+pzROGymNp1QxE+O0UAD+a7dosh3gqmnDLRwjzl4fBKM5bFfW/Efc/qU8lozBK+N+3sNctMc0GHdRqSVQezJTQgMjLn81W4Pa2nW99IMlG1sQoDKxLRUspV549zZkcqZvJkzRriX/kvURnzW6zQONBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BYj+weW8; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42cb57f8b41so59307715e9.0;
        Mon, 30 Sep 2024 13:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727727845; x=1728332645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g3ANjQP1ppTlWluml2iZxIJPKl4y/kaQbfY+Kx5CtqE=;
        b=BYj+weW8nLThCNb/pRFemX8NJAeSwUDt5Ft2tQYNfzKBeEMA7iJy0VrDZZddZeAi9z
         eXIZ1WBAQONnBg02BuOpOzectKxNHiezo1uc+NkQ39Dl7M2NRJq8povHjG2/RFRuW4mN
         cfD/UaSDb07ddqyJtl9+e1CP8BdKhivP6ayDECRZ5qc2syHbrHF4pJGJY0rdavXgqS3c
         pmgbJf2q/JA64SUPlrxOGGYFIERazMdP3hhlxJO0B1cP8chi3OM9EGfuU5mhwbAzbv6J
         vrU0YB0Nma4t5tSbF1TRi9lxc4MTEou7rxvO8c5g8k3Bl0fqcpiPXemL+cBMjNgDK+X8
         TFew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727727845; x=1728332645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g3ANjQP1ppTlWluml2iZxIJPKl4y/kaQbfY+Kx5CtqE=;
        b=XVUXct/nlG0AbhAry9EvL5KpoIkHN4IcjgeaDkc9yqCMNZ2vg6YIE4p22tyZdB/g53
         5WJWX5nhevQrRvlZqC7sl2/LF/RZnWRQhP1vIN6tVA4kqD0Qovz5k7dq0SJb7Ys1N5Xw
         2Kw23FstEMOuDHcubz5FSUu2FVgKrZVfGQqVMbsNS/5sTrAwaOsztSbOi7A7+bRirxgT
         6/Q49C8NZrfRePx+0NQ+mSUOO/eatztz3u3k3m+e7AK5D8oBqbSeimWMFbLb0cLy9FTK
         kTh5qWJ+nR5oj6WBFwKECaUombQy5nyrmU6Ji2I8f0cI1TTcDsB0csjr7xJ7UYJpP9OS
         8ttA==
X-Forwarded-Encrypted: i=1; AJvYcCV4No1HdcQkKK77WH8tgIE7SZwZz/y//caUak6FWfled/OjhEaYVt0L8Wsty+gkk4shGBFf8W4HtJA=@vger.kernel.org, AJvYcCWZOuBm3LTxDXaTFl3SDAQzCPOV9tpJlmBgEA+vWbyBx7R27oTe6gcuMAI+rAesdHAVOkskwB+a+9Rjs+oX@vger.kernel.org
X-Gm-Message-State: AOJu0YyMTHZb9HwRo14E19Pj5M0wox+dU8G3CkFF7jjhyxSvSVqtVbmh
	pGvDD+XzhhKe4Grvaij+hpR+dYgkvF2B/UQgcVNrbugEjVe3pTtH
X-Google-Smtp-Source: AGHT+IF1R4BLZJtEdwNFYI+Jdz10jlUCKpwoFqhh3mjZ32Xw8C7tPgJdvgHlA70QQHgMRpWyy2bE0w==
X-Received: by 2002:a05:6000:45:b0:37c:d1c6:7e45 with SMTP id ffacd0b85a97d-37cd5b04439mr11414558f8f.40.1727727845078;
        Mon, 30 Sep 2024 13:24:05 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:89eb:9ac0:8a4a:319b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd56e65e4sm10064052f8f.61.2024.09.30.13.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 13:24:04 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org
Cc: dan.carpenter@linaro.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vasileios Amoiridis <vassilisamir@gmail.com>
Subject: [PATCH v3 1/2] iio: pressure: bmp280: Use unsigned type for raw values
Date: Mon, 30 Sep 2024 22:23:52 +0200
Message-Id: <20240930202353.38203-2-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240930202353.38203-1-vassilisamir@gmail.com>
References: <20240930202353.38203-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The adc values coming directly from the sensor in the BM{E,P}{2,3}xx
sensors are unsigned values so treat them as such.

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/pressure/bmp280-core.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 6c2606f34ec4..472a6696303b 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -1023,7 +1023,8 @@ static irqreturn_t bmp280_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct bmp280_data *data = iio_priv(indio_dev);
-	s32 adc_temp, adc_press, t_fine;
+	u32 adc_temp, adc_press;
+	s32 t_fine;
 	int ret;
 
 	guard(mutex)(&data->lock);
@@ -1137,7 +1138,8 @@ static irqreturn_t bme280_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct bmp280_data *data = iio_priv(indio_dev);
-	s32 adc_temp, adc_press, adc_humidity, t_fine;
+	u32 adc_temp, adc_press, adc_humidity;
+	s32 t_fine;
 	int ret;
 
 	guard(mutex)(&data->lock);
@@ -1616,7 +1618,8 @@ static irqreturn_t bmp380_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct bmp280_data *data = iio_priv(indio_dev);
-	s32 adc_temp, adc_press, t_fine;
+	u32 adc_temp, adc_press;
+	s32 t_fine;
 	int ret;
 
 	guard(mutex)(&data->lock);
-- 
2.25.1


