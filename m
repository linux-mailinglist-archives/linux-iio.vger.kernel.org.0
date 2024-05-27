Return-Path: <linux-iio+bounces-5332-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 527FC8D04F7
	for <lists+linux-iio@lfdr.de>; Mon, 27 May 2024 16:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E76528C3D5
	for <lists+linux-iio@lfdr.de>; Mon, 27 May 2024 14:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4D017556E;
	Mon, 27 May 2024 14:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lL2C8H2p"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23826174EDE;
	Mon, 27 May 2024 14:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716819993; cv=none; b=C87db/cQgNayl1bqfMA6SpIkU2PoW1hmr1yYD+93sxpccUn8t9nrHKtOTpWsoVkwZ+2pL776o4hbO7/dR/OmJIlrWPqWBveVT9D8/+cbmH/KGSlc6g6Arny6lvGRfFKfwOhhjprvmKU0cl+Wd2jdJYKHv2LuDynjjrbAEOpWFNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716819993; c=relaxed/simple;
	bh=BH2CoSHmpvFu18FCQ6+njmK8cCe9ldOZLR73CUTyLk4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RxL+bmNCuShEh4NRWR66j5QKWHK1KodXdqu70Wb5dDOEKaLqIBL9ww3EpNEpAoK219ZlSNlpOfRQfB2xUdAkRqYlB3k6GQ71ZadqMO1qkKG69OmPvuqDl0Rs/CYILNvSPw+3vHXNQWR+J9uvwJmGxzMIgnqZsIdOuHxoogBqxXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lL2C8H2p; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-351d309bbecso8400844f8f.2;
        Mon, 27 May 2024 07:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716819990; x=1717424790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wPGHhK1Cp+7Ofc0LuMsph5CLZwGhIdmtihVxp6Eh99g=;
        b=lL2C8H2p3iZVRdf98VdLvV/zWm2z8QWrRhc1ins60C3R6wYIVF7rsBuhp7ArBR+YIE
         aRyJM20skXMVPsjwXGM8IhU19h59xirFw3L59ZH96HpPh6vnWGKO7Au+0jwizmGeB7sq
         35JC65SV5PzRYFBNGzzBKuPa774PXJUNQWDozAdP30ulYTO5nXjapI40ugeGy8z8S2t6
         Ixib+y6vFR2TtOGutCW6jUeRBkQV4vvG8bGnsQ3GtFKQum7x0Gf7/kWW32y0uhbny2/M
         frYiKE+CByp2MoCmawyP9VthQdF9Z3nbeP6GJtw4Z8gfeSwclGQuFLaWF+SsryJx3r7h
         Ddcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716819990; x=1717424790;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wPGHhK1Cp+7Ofc0LuMsph5CLZwGhIdmtihVxp6Eh99g=;
        b=xLv/JYMbKgBpkVDTD0WBZQfKZz/M5sDxNZ4Xokw4LQOTjGZxF9xI5kwwhDIIgts4JG
         qg7P6KnMKwRvOzhJG5vF33Nw/is6VuWOjOMrn8GHJWKjgutPhj1TLR8BG0Rj7WU5CFm3
         CRh+/h4XfzwB+ynv4seuYhmkv3ztQXyv20+pqRklUJACJ7w431d6G8FlVaZ7C0MPsndx
         seC0UuYs8OdRBYEKWy3PjUNHkg52x3hKKwtYJz8qS/AHZ2U4tpWwCg92N+WB6bDKfEGY
         3iAPvEjerYpK8ZwXY1mW15I7eU13r0hFpo8nVesrmmUuQPkPUEstrYYuWPaXyIh6xanI
         7nCA==
X-Forwarded-Encrypted: i=1; AJvYcCWM0IAwkcwVmxtPMIl0sJb+bpIQn6UFujGSnhv5id+0VvGn94rjiPsL4ot8eZbbyYESbcdvcSRr4sAs9qt6bKh0a8bmU2DW9YmZqB83ZcaLktcpv0vB2p5Rxw/NLpTiy5Xlrte4Vw==
X-Gm-Message-State: AOJu0Yy17wUFoexXbkVfGBmATJ+qKvNaiLTR5nr1jPzOiISa/ldgcXxx
	ihWdi/f0p5NKBNc8/5yp2JeGdniOFurTN00Hjc7wyvtQNrLUxoiLoeZD/bXBHZ0=
X-Google-Smtp-Source: AGHT+IGy7U00w22RJXbDrlSf3tHgjES9cbfc6XxZ1yagDC9k33LRU54rZ76tM5XaG0t/Iy1D/aN7/A==
X-Received: by 2002:adf:e64c:0:b0:354:de8e:b66b with SMTP id ffacd0b85a97d-3552fe02b74mr8239274f8f.52.1716819990228;
        Mon, 27 May 2024 07:26:30 -0700 (PDT)
Received: from rbolboac.. ([2a02:2f0e:350b:4500:9c9:f6ef:e79b:45ce])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421089ae976sm110537875e9.38.2024.05.27.07.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 07:26:29 -0700 (PDT)
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
Subject: [PATCH v5 5/9] drivers: iio: imu: adis16475: generic computation for sample rate
Date: Mon, 27 May 2024 17:26:14 +0300
Message-Id: <20240527142618.275897-6-ramona.bolboaca13@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527142618.275897-1-ramona.bolboaca13@gmail.com>
References: <20240527142618.275897-1-ramona.bolboaca13@gmail.com>
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

Reviewed-by: Nuno Sa <nuno.sa@analog.com>
Signed-off-by: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
---
no changes in v5
 drivers/iio/imu/adis16475.c | 39 +++++++++++++++++++++----------------
 1 file changed, 22 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/imu/adis16475.c b/drivers/iio/imu/adis16475.c
index 64c8bdaba4c5..b1def85b6f90 100644
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
@@ -1317,6 +1322,7 @@ static int adis16475_config_sync_mode(struct adis16475 *st)
 	struct device *dev = &st->adis.spi->dev;
 	const struct adis16475_sync *sync;
 	u32 sync_mode;
+	u16 max_sample_rate = st->info->int_clk + 100;

 	/* default to internal clk */
 	st->clk_freq = st->info->int_clk * 1000;
@@ -1356,10 +1362,9 @@ static int adis16475_config_sync_mode(struct adis16475 *st)
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


