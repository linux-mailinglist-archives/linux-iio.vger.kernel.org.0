Return-Path: <linux-iio+bounces-5256-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A12CC8CE2CC
	for <lists+linux-iio@lfdr.de>; Fri, 24 May 2024 11:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 616962825BE
	for <lists+linux-iio@lfdr.de>; Fri, 24 May 2024 09:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EEEF12BF07;
	Fri, 24 May 2024 09:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m1+dL/LD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0C8129E6B;
	Fri, 24 May 2024 09:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716541249; cv=none; b=i3G8zY/CaJ2wt/katgX4dnQHNnSVGl8t53IMY2VPipcY+uTRc3eOfqgHKyMbVGK4TPrSia5x6a5EpQ2CpPsGpInnY8Ncj3JqowFdpHTnF12H7nqGKvEkTsS/1PN13Awgkj4qeZWCVATH+bN9nJpUC7bb6x9A0eOJXv2k40/pFVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716541249; c=relaxed/simple;
	bh=jCAR4f6Zew5Yk17a38hnZUQRbdbFlbcdFrBSCCJVbls=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R3S4cU+g0eTjejgJbrWmkqrSCOxXoXQcSUsmM3v8YnDMl7ErS5aJO2LblgoiaE5wOLkxyOaTIA3HDM10r08+wB8HmoFh8wUFhSGbVkCTRSwpHcVSw/Q2HqYt5nCrghVJ8jwwIsBA2KnYNgN3oK44/uE5a5elf4JFFenl7CWU9Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m1+dL/LD; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a6269885572so94640866b.1;
        Fri, 24 May 2024 02:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716541246; x=1717146046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x32ciY+mK+tuj4EeIL62kUCfxBL4vZzxMqnPQajocbg=;
        b=m1+dL/LDhV/mHygd1YsjdlYI8ryKthNEAVgHhMTJ0+zzwKkp/pIgnKsuyWqmLLRUJG
         NwUSSdiREBlaakDYuwAQa0DoXLW1dXCtunj4C480FjbNnv6ZmfW9S6AnuaOReovrkCar
         kG97QqUHPhi/03aL5bsAb8ZOiDEWLiTgLQQ4gygwAXrh/xNCPLSmHHvV4DhVvHsPwFkZ
         YMOq1OGLsck9ib/rmKSbBpHuWfpacKslnDK3nfiwtAbqUHKxGJOVXvxR9Fmn3XMc+RGf
         aPL/Wjb6t3YmjM7esa7W41NSlmbr8/TCAnV7Jd6TIvPvKGKeoA1Zvp6Cyu2HpK7MyTk8
         AXYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716541246; x=1717146046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x32ciY+mK+tuj4EeIL62kUCfxBL4vZzxMqnPQajocbg=;
        b=aSln3OcgYdPVC292HDyHKrk3lR+ao6IC6u+/nCVAFPy7MV+03C0oEdpXFeqEW2IA6D
         CKuc1F24PvtvUmfI//lS9b07A8ZEzIRhJcTuK+4WiE0Oxi2+iPHfR+iSyrg6xHWM4QnT
         eBJD37doBiQ6gxE9bLw4hGpCj4vECP+tHICe23IMFh70IkI2daZsZkq0mpimhYRH9AKq
         SLnwy+LLSPbhMJ6lP0X6/LhoLfhSz/XK1YnhwOtvVS6vF484KQc4t3mX6eVWKWHHTeH2
         NOZuhukjJAcY8jtmhdDwD2Oq29Hn7QmtOyUGyw67m203WaapTmYohWjrYidopyn6z1WZ
         zhxQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9syowq54jnaFTSKbzt//OXIUNho8GVjVHqh3rQ8PyXhK8RhGWuw7Xqeo1Gi9y4PGYTDy5klp9Nk4traa7/gLR3iWiBSayAuWCmplKlAAPyq5o+ROBYF3kVnZNwK4pT4Ygbvj82Q==
X-Gm-Message-State: AOJu0YxPF1ESvTt9b75UQVPgMM6FfB410uIdzClQIY2hSHRy1nv/sPsk
	rXgPIwew5hL4LVe3wVzqmo8tNWYHEoLIMV1CVAaNw022hw0VzlSp6xiOmdfIwQ8=
X-Google-Smtp-Source: AGHT+IFzOS5PoAZNnLTjIqKwOKNKDh5eET9yHzuc9i/fBpwE/DRmGo25O1ojHnc8V/V3TTvcphVQkQ==
X-Received: by 2002:a17:906:a287:b0:a5c:dad0:c464 with SMTP id a640c23a62f3a-a623e6d5882mr429533666b.6.1716541245544;
        Fri, 24 May 2024 02:00:45 -0700 (PDT)
Received: from rbolboac.. ([2a02:2f0e:350b:4500:dac3:9bb:ed7a:184b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626c93ae41sm97730466b.62.2024.05.24.02.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 02:00:45 -0700 (PDT)
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
Subject: [PATCH v4 06/10] drivers: iio: imu: adis16475: generic computation for sample rate
Date: Fri, 24 May 2024 12:00:27 +0300
Message-Id: <20240524090030.336427-7-ramona.bolboaca13@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240524090030.336427-1-ramona.bolboaca13@gmail.com>
References: <20240524090030.336427-1-ramona.bolboaca13@gmail.com>
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
no changes in v4
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


