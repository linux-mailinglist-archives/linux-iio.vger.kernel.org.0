Return-Path: <linux-iio+bounces-4881-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36DBD8BFE28
	for <lists+linux-iio@lfdr.de>; Wed,  8 May 2024 15:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E26A5285F2A
	for <lists+linux-iio@lfdr.de>; Wed,  8 May 2024 13:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA5184E18;
	Wed,  8 May 2024 13:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HjRQl7ZN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7472684A39;
	Wed,  8 May 2024 13:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715174005; cv=none; b=G2yKYvftoaQxdoqolCocSnC1zknrzgCI2h5fyobMWPRbIMQpeZSKXrOfD6HGIUDqNaSpifOsAnO0EN/gUs1wIXQjuC3I7a2xvOW2Q651g1/cq4u/qK/klSMrXvvsZcrfU3n+h2RkZnRZRt0ZoEaDqSEJ2FiiPfD/EXFvVIBXMRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715174005; c=relaxed/simple;
	bh=DxuztM5+j6nac1APTOoaKArZlnbI+0NO9/kXQn4MppU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dG8OeTNVhPd2Sj520f2LgrzQE9np6zecNhranmk/ReVz05txpmj6X2wa5S1IfnOgCOPyGkA8htuRiR6/fIl/UyhIpi2aaFQbCii1BBnQa7TPpFScI8TwzO0vMJEcxQ5Fn+amRqi32mgYXE78/kcX/Ad5NHywT7yFVGf15Ep+Fd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HjRQl7ZN; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2e3e18c23f9so33779551fa.3;
        Wed, 08 May 2024 06:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715174001; x=1715778801; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bA/WbFSY3RF63tkLESgPXqoWCWDmxvouNTqO5wkompE=;
        b=HjRQl7ZNBi/nA40H7BbBmspjdFkbNe/vgfHU3IGVYXGYQH1SrNibcfGJfLq3gPIBkV
         0THW2EUvu9qqbH43sOEf5FlhCPe1BzE+Zl4Dg0Vw7htjLVDGEKI6Y0zJbAHc3sA1llx2
         EJxRbyvsVjy/XZmGkjhngZAMBXaD2gTkPNOklQB3A1uUdPy6mG5hrWarnsHJnTPJSWnS
         Y8CwhE4Roj4uUiEXr/nSzsoW3neOXM76qkczhkh7YCrjS4btAxKUXUOyAD0YBTEATRUv
         3DwuqClJibdNXul5y4riH1qh6EjxqeVb5uiYSpS6IQxQgtYqrY1B5wJx/ctmUZi07VkB
         ym9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715174001; x=1715778801;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bA/WbFSY3RF63tkLESgPXqoWCWDmxvouNTqO5wkompE=;
        b=PUKRY5xDiZet8f1v5EA2yKXmY9jEz0PORrsEpgJ84rSqrYvNTjpLPqpMIu320PbR7d
         BP9IscgecWnEdpWxiD+99kT6CmouKzoOG8A5hnNOB2MOD802rz9R6wApig9t36PJ1Lz2
         Oat4r0XwrsKCM3kuzfWXi22yokFoGeIkc1OG4tl+mfpLj1j8Y7yLbtEJvM3CGrA31da+
         W+ts1wE6SHkw31Gf8jAMFI4LXQkhw7HvV5D9RoKua0QOM5f5E3sQ3MayrHevODLzpIYk
         Pn46tcCsJGxSm2Av698AZ9vSC2Mz6UfklxTX+hHu3+9zc6nq6/Rx5nvqM87w9Hn5vsL3
         v9Qg==
X-Forwarded-Encrypted: i=1; AJvYcCXWQrCFdDwATfg8Zqp17LZOPEN1crkK83e7OlMUAbVwvskfYa4kv/c7OtCTjYZUDYcCFrCDclNV4AdG/mAQbhcfuNzHEi8uHqP7dZtLff5dhfZCJDjJKp5YzkbJoerwRhmLvfLjkQ==
X-Gm-Message-State: AOJu0Yy1+b9ltZvzcbKdYIr2aHcE4RXgbCFxZrEdWzAp913WqJ80Ux8g
	rc7F9rDNxXUg4Q9YdGIHBCg4Tt3YqZfb4FbF4LPj8zIEGH40nxJV/LVRJjMeVEQ=
X-Google-Smtp-Source: AGHT+IFetLSuS6EOFk/5ZISvmhcTIP6y7eOnIujEnOT+TaXxj00+sk5NF/0KMG6pZx8Dq1CEyZMbtw==
X-Received: by 2002:a2e:a54c:0:b0:2e2:a0f0:4e74 with SMTP id 38308e7fff4ca-2e4477b4e16mr20835421fa.52.1715174001006;
        Wed, 08 May 2024 06:13:21 -0700 (PDT)
Received: from rbolboac.. ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41f88110f3esm22848365e9.29.2024.05.08.06.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 06:13:20 -0700 (PDT)
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
Subject: [PATCH v2 6/8] drivers: iio: imu: adis16475: generic computation for sample rate
Date: Wed,  8 May 2024 16:13:08 +0300
Message-Id: <20240508131310.880479-7-ramona.bolboaca13@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240508131310.880479-1-ramona.bolboaca13@gmail.com>
References: <20240508131310.880479-1-ramona.bolboaca13@gmail.com>
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
changes in v2:
 - new patch
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


