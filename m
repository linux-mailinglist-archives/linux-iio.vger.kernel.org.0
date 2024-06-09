Return-Path: <linux-iio+bounces-6132-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 760819018BE
	for <lists+linux-iio@lfdr.de>; Mon, 10 Jun 2024 01:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DABABB20DE8
	for <lists+linux-iio@lfdr.de>; Sun,  9 Jun 2024 23:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E1D78C9E;
	Sun,  9 Jun 2024 23:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GOvSRHzZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC027711B;
	Sun,  9 Jun 2024 23:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717976329; cv=none; b=WVFPeRH0RXeuqRoyJ1TzwSJNL3MChT1E776wCxtdHz/9bB/QwnLnTS/5qJ+eNjUIX/CX6YliDu01Rk+SRR/sFtPD3HRTwdZq3KkeeTdgOcfzsIaZOqbG7JnW81Rpb2md6uFRQJOno/kUz/pteM7jb7gE920EY2e7oxoGFx7WD/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717976329; c=relaxed/simple;
	bh=pyZuPXm2ItgrGo2VXzIW1bQXYmpwhbi7eJKFUlZlLF8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tTvd2Un2qPAUpk/3GqkFv83flZTsM0goVJQsvjOME8xL0O6zbIjfgUGoy0cZKOzP+SpvPJ2vBoL7MO+E2ezhQtAJ3UmpnVDiDc+lUQAplZR2ZDbt59geYmX3Up36Tf3izZJR6zH//4yvzP/GVF21k+OGcvmIEv3ClqFfD6GXIeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GOvSRHzZ; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a626919d19dso872201866b.0;
        Sun, 09 Jun 2024 16:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717976326; x=1718581126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OZdGB+N8Qb/Ym+/tq2ItIDp+gfuN/NoNCXBQdBAKy9M=;
        b=GOvSRHzZOz/aWW+ZYQpqODk3SAiN9NShgFLC0rJlRaEyyTVZ3eI1KSL2sX2o1Q+jum
         1j41dtqZvka4fwTe+LUg2P+DM/f4t4BuFPRusUmmPCKsa1WzthQxu+TVmpIVtcfDBGKb
         hQCvMrPp0bMlyhVntBQxtFJsgN0fWUPmXh1KlrOOCgekFonNd+DnZ5U1OcfRzbTdLsiI
         qtiaSqWJsnaBiBLlPcmlmYoK4sjsNsfKIghjipokDovlPzZi7ZS7wlb2v05hrtQAnVkh
         Dcr/+rgYvqs3sCA778sDVKxXerdizxvlOQEuz1OzCZrgTPd5zACbkpbrMajmtjQ0Nh7d
         8m3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717976326; x=1718581126;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OZdGB+N8Qb/Ym+/tq2ItIDp+gfuN/NoNCXBQdBAKy9M=;
        b=UtOIdM/MVCWYklgqOlER43FED0X3rLMjXF6ZIsWTAA3pSYiV0g+AYqWCntjYYzcfuJ
         ASQzFzdoNLBcuhoMgwB849GFF+hSgbsSUu2wlpleH6xz5jXJRv4wRbDZrKObZOBoK3Jb
         Wyd0NgBJ3O9po5xH98EkbRCb+338QqN7Nb0KT+5Ec1fQy6rqkw7Mo9Xf0KIXjJ7F8k0I
         JtmsZdkVJi3/K6pv7Yo7UrVybqZ3p4Qgtcngd+TFDBLSiNDHyg5iGsu35TBPxdNy98rr
         85VXmwICwG78t7/ByKC8rXTC4mFsOmplo99WqJGgR6ayg2IG9g1qJPDEilQQk4ZjGVKl
         iQwA==
X-Forwarded-Encrypted: i=1; AJvYcCVc0bYd4mTBkq0fZcU33ks18dyJvNOxBAVMjvUgXVzeaalcctLDES4etzjFJKPetPt2gr3+aPESzwZdP7rPtXjKfSHHDuz3/Nt+rW+zBr6k8uG4FxBd0NC+yMIdnZ1n8POinj1lyP/w
X-Gm-Message-State: AOJu0Ywqmo9CLOQH14SaDSTR9Z9Bv+eWfK+3n0hGfA/w2elhrhuGDbO+
	CKf4mu/Yd/l/5lcXQWYaJyGS3tYICGvMylehwAlXKs0QWev+pGDR
X-Google-Smtp-Source: AGHT+IFY3lQ64flh1OTu3wq0lj8diCwLRjAxKHIbSd9pPSFHaZpDXyDzARpEX9M7FMbTG/EhKMUHDw==
X-Received: by 2002:a17:906:6bd0:b0:a6e:ff5b:8051 with SMTP id a640c23a62f3a-a6eff5b8527mr313151966b.6.1717976326303;
        Sun, 09 Jun 2024 16:38:46 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:635a:738f:880f:9ea5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f20bb1abesm46063366b.172.2024.06.09.16.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 16:38:45 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org
Cc: dpfrey@gmail.com,
	himanshujha199640@gmail.com,
	lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mike.looijmans@topic.nl,
	vassilisamir@gmail.com
Subject: [PATCH v3 14/15] iio: chemical: bme680: Move forced mode setup in ->read_raw()
Date: Mon, 10 Jun 2024 01:38:25 +0200
Message-Id: <20240609233826.330516-15-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240609233826.330516-1-vassilisamir@gmail.com>
References: <20240609233826.330516-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Whenever the sensor is set to forced mode, a TPHG cycle is triggered and
the values of temperature, pressure, humidity and gas become ready to be
read.

The setup of the forced mode to trigger measurements was located inside
the read_{temp/gas}() functions. This was not posing a functional problem
since read_{humid/press}() are internally calling read_temp() so the
forced mode is set through this call.

This is not very clear and it is kind of hidden that regardless of the
measurement, the setup of the forced mode needs to happen before any
measurement.

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/chemical/bme680_core.c | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
index d08f32ecd139..3785b4d014db 100644
--- a/drivers/iio/chemical/bme680_core.c
+++ b/drivers/iio/chemical/bme680_core.c
@@ -572,15 +572,6 @@ static int bme680_read_temp(struct bme680_data *data, int *val)
 	u32 adc_temp;
 	s16 comp_temp;
 
-	/* set forced mode to trigger measurement */
-	ret = bme680_set_mode(data, true);
-	if (ret < 0)
-		return ret;
-
-	ret = bme680_wait_for_eoc(data);
-	if (ret)
-		return ret;
-
 	ret = regmap_bulk_read(data->regmap, BME680_REG_TEMP_MSB,
 			       data->buf, BME680_TEMP_NUM_BYTES);
 	if (ret < 0) {
@@ -683,15 +674,6 @@ static int bme680_read_gas(struct bme680_data *data,
 	u16 adc_gas_res, gas_regs_val;
 	u8 gas_range;
 
-	/* set forced mode to trigger measurement */
-	ret = bme680_set_mode(data, true);
-	if (ret < 0)
-		return ret;
-
-	ret = bme680_wait_for_eoc(data);
-	if (ret)
-		return ret;
-
 	ret = regmap_read(data->regmap, BME680_REG_MEAS_STAT_0, &data->check);
 	if (data->check & BME680_GAS_MEAS_BIT) {
 		dev_err(dev, "gas measurement incomplete\n");
@@ -730,9 +712,19 @@ static int bme680_read_raw(struct iio_dev *indio_dev,
 			   int *val, int *val2, long mask)
 {
 	struct bme680_data *data = iio_priv(indio_dev);
+	int ret;
 
 	guard(mutex)(&data->lock);
 
+	/* set forced mode to trigger measurement */
+	ret = bme680_set_mode(data, true);
+	if (ret < 0)
+		return ret;
+
+	ret = bme680_wait_for_eoc(data);
+	if (ret)
+		return ret;
+
 	switch (mask) {
 	case IIO_CHAN_INFO_PROCESSED:
 		switch (chan->type) {
-- 
2.25.1


