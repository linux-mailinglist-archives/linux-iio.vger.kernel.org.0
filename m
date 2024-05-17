Return-Path: <linux-iio+bounces-5081-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5401E8C81B2
	for <lists+linux-iio@lfdr.de>; Fri, 17 May 2024 09:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AF0C282520
	for <lists+linux-iio@lfdr.de>; Fri, 17 May 2024 07:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19CB22E40D;
	Fri, 17 May 2024 07:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O5dD0JYR"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268192B9D8;
	Fri, 17 May 2024 07:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715932084; cv=none; b=mcurPmBWi3X5/eOirnbe2gbZSm1gQ5j1xAIU40m5tnNQ1HyUaYqYkl5lLeNoRQ5C1t1BeOPQXZWAn9lX150yQxIPRzH733fmqGtIlCk3u+YemwfIGWBIDLpQYztb2Xb1w2iFcGBj7C7EAIXUuZUgAQorEYEcaOjqVLWoN5Na6B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715932084; c=relaxed/simple;
	bh=qrPs8pzoQiEEQ+2WlxJkaTF8LTHukfAGBXVl7LEaN+0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VQ4guKweAasRb8n87JXfDHulS2UME8/BccvoisGjGLZmLqNsJSd8/W4jqEgv4I+ix7RMDIJf5r9CHfzJchLxwM8ovQFW9yiL5pAvV2aZ5kxxT1tAY1Kdvhqbng2pppKHlFOHrbzMr+vKFEetWGJBghOhfqQ7w0rLCk9caqSVn38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O5dD0JYR; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-34db6a299b8so6822984f8f.3;
        Fri, 17 May 2024 00:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715932081; x=1716536881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ONh25RLYtcOHE0peb9x3jbUdlHltO15eKQQqQ+4uktc=;
        b=O5dD0JYRRlUjZgciP+sjTr9LdAg8kgvKvMWfDy2S0AygNY4MWhg7E/9iU2EDmrM1iQ
         JovQb63e1eslvHs7R21cT8OkRUBOgqLIG/rBzADAZZ9b8Akd0SviDl5fQO+h+xqNHdMa
         R90OUkYBaXjYoDhzuBUnFIeUljWHEz9NCsJ1aibWaWnUOy/cgh9Zy4vGMlyG10lNV4tF
         WX2zR0z95PhKgj7az25jY4OQiFmtwuDE0gGFXGP9ZSMsYyuPrXJYsqOVVj+3GEv6nUrp
         xnkgLjZPJrRIa028dbLCOEuWTA/a6cFK8wVjtNa8Y8LgWHpmtv77LGYzeu4iYDGr4ilq
         mM9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715932081; x=1716536881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ONh25RLYtcOHE0peb9x3jbUdlHltO15eKQQqQ+4uktc=;
        b=iIjuIPsldUC4wMHUOVuJKf51umPMv7AJBdpcxKPhc/TdtI3QnKvLI35TTZUDDF3zzG
         bhOAyKevBRsi3VGq+vrSqDAFeOPZEbcvSpyBhlNP9iioGYa4ATUW20Go5jBNk3iO+2pm
         1Eb0MxFq1LfZWjOxerv4Kfozu7fP6/brHnfgruOVWj4QmdVJY5A51W/w/NGlYh4H9RZP
         /IFD7OY2QA2sY//9zieLbtiyaXgnlade4lFw2trRFw0de42UTUTHC97wbkFn+9AypFGd
         ms+7iuroYbUkKNrXuTMcgVig4wYpGwltIKLElH8mg81ebZ24b/5TfKBArk2V5gq9eir5
         mZwg==
X-Forwarded-Encrypted: i=1; AJvYcCWCy8VS6GHdLIiyb9A2TvCuMEnoXKZZEw09zuRX9sbnTh4Zts8U0Fd1C5SmqEA/eZzkkMCrEVWOfz78yWlX5Vu7VmGxp5uemxaB3ffJ6mr8MVitvdcxJby9KvvcsDTdpksu67UvZA==
X-Gm-Message-State: AOJu0YybC64z41P8xdpL2zfikXgsvToRKRqW/0CKPyVDAC8k0jwPqGGN
	+OLA/LXOG5qIcfAX+3P8E0y2htWA+kUsPt8H+KObL5GvCmJE5B2EY2hgBm3hEVA=
X-Google-Smtp-Source: AGHT+IHb385/qxqs7vnJ7HSY0R40KN1Mhv6uCoAj7/Ta5PKKCffL168S9N9qHgS1HWyZVR5NJzFe1A==
X-Received: by 2002:a5d:4fc2:0:b0:34d:750c:8b9 with SMTP id ffacd0b85a97d-3504a958127mr14052233f8f.51.1715932080877;
        Fri, 17 May 2024 00:48:00 -0700 (PDT)
Received: from rbolboac.. ([2a02:2f0e:350b:4500:569e:359d:dfe4:922e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502baacef2sm21104207f8f.85.2024.05.17.00.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 00:48:00 -0700 (PDT)
From: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
To: linux-kernel@vger.kernel.org,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	conor+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	robh@kernel.org,
	nuno.sa@analog.com
Cc: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
Subject: [PATCH v3 6/9] drivers: iio: imu: adis16475: generic computation for sample rate
Date: Fri, 17 May 2024 10:47:47 +0300
Message-Id: <20240517074750.87376-7-ramona.bolboaca13@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240517074750.87376-1-ramona.bolboaca13@gmail.com>
References: <20240517074750.87376-1-ramona.bolboaca13@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently adis16475 supports a sample rate between 1900 and 2100 Hz.
This patch changes the setting of sample rate from hardcoded values to
a generic computation based on the internal clock frequency.
This is a preparatory patch for adding support for adis1657x family
devices which allow sample rates between 3900 and 4100 Hz.

Signed-off-by: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
---
no changes in v3
 drivers/iio/imu/adis16475.c | 39 +++++++++++++++++++++----------------
 1 file changed, 22 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/imu/adis16475.c b/drivers/iio/imu/adis16475.c
index ab955efdad92..c589f214259b 100644
--- a/drivers/iio/imu/adis16475.c
+++ b/drivers/iio/imu/adis16475.c
@@ -310,6 +310,9 @@ static int adis16475_set_freq(struct adis16475 *st, const u32 freq)
 	u16 dec;
 	int ret;
 	u32 sample_rate = st->clk_freq;
+	/* The optimal sample rate for the supported IMUs is between int_clk - 100 and int_clk + 100. */
+	u32 max_sample_rate =  st->info->int_clk * 1000 + 100000;
+	u32 min_sample_rate =  st->info->int_clk * 1000 - 100000;

 	if (!freq)
 		return -EINVAL;
@@ -317,8 +320,9 @@ static int adis16475_set_freq(struct adis16475 *st, const u32 freq)
 	adis_dev_lock(&st->adis);
 	/*
 	 * When using sync scaled mode, the input clock needs to be scaled so that we have
-	 * an IMU sample rate between (optimally) 1900 and 2100. After this, we can use the
-	 * decimation filter to lower the sampling rate in order to get what the user wants.
+	 * an IMU sample rate between (optimally) int_clk - 100 and int_clk + 100.
+	 * After this, we can use the decimation filter to lower the sampling rate in order
+	 * to get what the user wants.
 	 * Optimally, the user sample rate is a multiple of both the IMU sample rate and
 	 * the input clock. Hence, calculating the sync_scale dynamically gives us better
 	 * chances of achieving a perfect/integer value for DEC_RATE. The math here is:
@@ -336,23 +340,24 @@ static int adis16475_set_freq(struct adis16475 *st, const u32 freq)
 		 * solution. In this case, we get the highest multiple of the input clock
 		 * lower than the IMU max sample rate.
 		 */
-		if (scaled_rate > 2100000)
-			scaled_rate = 2100000 / st->clk_freq * st->clk_freq;
+		if (scaled_rate > max_sample_rate)
+			scaled_rate = max_sample_rate / st->clk_freq * st->clk_freq;
 		else
-			scaled_rate = 2100000 / scaled_rate * scaled_rate;
+			scaled_rate = max_sample_rate / scaled_rate * scaled_rate;

 		/*
 		 * This is not an hard requirement but it's not advised to run the IMU
-		 * with a sample rate lower than 1900Hz due to possible undersampling
-		 * issues. However, there are users that might really want to take the risk.
-		 * Hence, we provide a module parameter for them. If set, we allow sample
-		 * rates lower than 1.9KHz. By default, we won't allow this and we just roundup
-		 * the rate to the next multiple of the input clock bigger than 1.9KHz. This
-		 * is done like this as in some cases (when DEC_RATE is 0) might give
-		 * us the closest value to the one desired by the user...
+		 * with a sample rate lower than internal clock frequency, due to possible
+		 * undersampling issues. However, there are users that might really want
+		 * to take the risk. Hence, we provide a module parameter for them. If set,
+		 * we allow sample rates lower than internal clock frequency.
+		 * By default, we won't allow this and we just roundup the rate to the next
+		 *  multiple of the input clock. This is done like this as in some cases
+		 * (when DEC_RATE is 0) might give us the closest value to the one desired
+		 * by the user...
 		 */
-		if (scaled_rate < 1900000 && !low_rate_allow)
-			scaled_rate = roundup(1900000, st->clk_freq);
+		if (scaled_rate < min_sample_rate && !low_rate_allow)
+			scaled_rate = roundup(min_sample_rate, st->clk_freq);

 		sync_scale = scaled_rate / st->clk_freq;
 		ret = __adis_write_reg_16(&st->adis, ADIS16475_REG_UP_SCALE, sync_scale);
@@ -1359,6 +1364,7 @@ static int adis16475_config_sync_mode(struct adis16475 *st)
 	struct device *dev = &st->adis.spi->dev;
 	const struct adis16475_sync *sync;
 	u32 sync_mode;
+	u16 max_sample_rate = st->info->int_clk + 100;

 	/* default to internal clk */
 	st->clk_freq = st->info->int_clk * 1000;
@@ -1398,10 +1404,9 @@ static int adis16475_config_sync_mode(struct adis16475 *st)
 			/*
 			 * In sync scaled mode, the IMU sample rate is the clk_freq * sync_scale.
 			 * Hence, default the IMU sample rate to the highest multiple of the input
-			 * clock lower than the IMU max sample rate. The optimal range is
-			 * 1900-2100 sps...
+			 * clock lower than the IMU max sample rate.
 			 */
-			up_scale = 2100 / st->clk_freq;
+			up_scale = max_sample_rate / st->clk_freq;

 			ret = __adis_write_reg_16(&st->adis,
 						  ADIS16475_REG_UP_SCALE,
--
2.34.1


