Return-Path: <linux-iio+bounces-4556-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F678B4544
	for <lists+linux-iio@lfdr.de>; Sat, 27 Apr 2024 11:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32B97282CA2
	for <lists+linux-iio@lfdr.de>; Sat, 27 Apr 2024 09:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4144D42AAC;
	Sat, 27 Apr 2024 09:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b="WQwUNZ4F"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C1064C
	for <linux-iio@vger.kernel.org>; Sat, 27 Apr 2024 09:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714208992; cv=none; b=WfpkSip8h+hyTA1rCccLfQKzUFmo3e44LxxcsoispxCP2cSCI75F4O2PVDakal+JJHgGhAczBThtwpZv8LaY7NBWWaojZajwA25pqoxbKS3lVLp141tPYdUjqFa12CKuQ27qf1wZYfRxs0jCBv57nVBvaA/CGIcoj6w9Lv9RnQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714208992; c=relaxed/simple;
	bh=E3WKdL8IOBMRfle/wo50Z1qqZX5pXztf7kFCkdRe6FI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TxaAMpprL4bl9JjJk34tvYA/+vUNTnRS8K2K3kIc0bj2yKvCjGcu0sVeJzO2+6UNxH5IvDGDpq6FXipdl48ullXHod/TY3lNHqKRqqatZ0uluXEdca3AMZjpS51eJxZYllz7wj9Kh8TnuFuyUm825NNkziSNn+hyBW3MDXgMsok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com; spf=pass smtp.mailfrom=tweaklogic.com; dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b=WQwUNZ4F; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tweaklogic.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1e4bf0b3e06so28644745ad.1
        for <linux-iio@vger.kernel.org>; Sat, 27 Apr 2024 02:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tweaklogic.com; s=google; t=1714208990; x=1714813790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ynRU3BokI7x+TVZ0M1ndHqpxWwtn8+UGCy+jVf6kUXE=;
        b=WQwUNZ4F/ICkm6UUMy6il8WxVgctzJZHUo/PTDqS65SK8vsMrbPW4m7ZmZZvIXlSfT
         WTuU1bJ9Ab4DXLCklwMCmRnKTF7wKpgeP/1Ezl1z5DhYsrBD4VqLko+q0i+cCKrJlXkn
         7VdIbXPMuOqDezADmPjTEE4yCsw7E98ZfThxof/kUM4Dx+JhQuACyyFxeYZEomZCaE5u
         oEnHIKLaM6BZQOz7BAdLu93JA1eYp+3NWcQxyhW7gZTRRBuWozViN1plDIe2D5j7PUrT
         QoTwPTdmz3y+vpUU+G/M/KVvrg1/eIZWeugC+DSgD7c/JZkfLxyvnvs2KoerixNXr0Qt
         ymvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714208990; x=1714813790;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ynRU3BokI7x+TVZ0M1ndHqpxWwtn8+UGCy+jVf6kUXE=;
        b=jXWRrDh5BYMkD7SaikkgZNowVU3UmzSDFAJy3lYDX5JwkStVM50dOFGzJnrQx7Ju7m
         LBa8zME2vUugODMzud9LnyNB5yRImQbGpZru9gbPl9TIIPO3yAKk/wV+ps08vh4gZnjP
         Dk+AZphFYT/jqx/UvmIbZKpEAt9G/St5TBylkmvmDbGpd4QmmYHw9361SsKyLrVwKvN6
         mZDA6wCPnLtEkg0xDiKiWCicx53tp1CRHpKkIv3LCakfEbRMTl9ufT2gXh2StzYjZIcc
         lkIw2W3HLCvIFl4qqRsHE+Dr8ModUJ6DNG3N5+pyWl6s7Tc7sUUt7uNFz+toKghsVbYB
         GNAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOC4LiwzcAgKUaZqedIch2oivHhGocLq6gafebicGCVcW/XcASsVW0eF3hdFh3FglKTvrQw6tFp74iGitM9neBgXVMByY+S4U/
X-Gm-Message-State: AOJu0YwgP+cgbZqOAK4l/jLXZSe6QO/EbNHwkpUzi1emhEJlZuTUjA7J
	xYQ52Ex0a4LKMQ9XD80LTzJyy2su7DljCTNdOHYjE7a5UewNEcTX+rYjLk1/Ky4=
X-Google-Smtp-Source: AGHT+IFj0p54QW6trZ1NiIVeWEcAQ2Yu9bZvfW40jHrqJGc4ZGPDqks08m4uRvizV7dJKtdhMpkaHw==
X-Received: by 2002:a17:903:1212:b0:1e3:999a:9726 with SMTP id l18-20020a170903121200b001e3999a9726mr5929362plh.29.1714208990174;
        Sat, 27 Apr 2024 02:09:50 -0700 (PDT)
Received: from localhost.localdomain ([180.150.112.31])
        by smtp.gmail.com with ESMTPSA id w17-20020a1709029a9100b001e2a4663179sm16726519plp.258.2024.04.27.02.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Apr 2024 02:09:49 -0700 (PDT)
From: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Dan Carpenter <dan.carpenter@linaro.org>
Cc: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: light: apds9306: Fix input arguments to in_range()
Date: Sat, 27 Apr 2024 18:39:14 +0930
Message-Id: <20240427090914.37274-1-subhajit.ghosh@tweaklogic.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Third input argument to in_range() function requires the number of
values in range, not the last value in that range. Update macro for
persistence and adaptive threshold to reflect number of values
supported instead of the maximum values supported.

Fixes: 620d1e6c7a3f ("iio: light: Add support for APDS9306 Light Sensor")
Signed-off-by: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
---
 drivers/iio/light/apds9306.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/light/apds9306.c b/drivers/iio/light/apds9306.c
index 46c647ccd44c..d6627b3e6000 100644
--- a/drivers/iio/light/apds9306.c
+++ b/drivers/iio/light/apds9306.c
@@ -55,8 +55,8 @@
 #define APDS9306_ALS_DATA_STAT_MASK	BIT(3)
 
 #define APDS9306_ALS_THRES_VAL_MAX	(BIT(20) - 1)
-#define APDS9306_ALS_THRES_VAR_VAL_MAX	(BIT(3) - 1)
-#define APDS9306_ALS_PERSIST_VAL_MAX	(BIT(4) - 1)
+#define APDS9306_ALS_THRES_VAR_NUM_VALS	8
+#define APDS9306_ALS_PERSIST_NUM_VALS	16
 #define APDS9306_ALS_READ_DATA_DELAY_US	(20 * USEC_PER_MSEC)
 #define APDS9306_NUM_REPEAT_RATES	7
 #define APDS9306_INT_SRC_CLEAR	0
@@ -726,7 +726,7 @@ static int apds9306_event_period_get(struct apds9306_data *data, int *val)
 	if (ret)
 		return ret;
 
-	if (!in_range(period, 0, APDS9306_ALS_PERSIST_VAL_MAX))
+	if (!in_range(period, 0, APDS9306_ALS_PERSIST_NUM_VALS))
 		return -EINVAL;
 
 	*val = period;
@@ -738,7 +738,7 @@ static int apds9306_event_period_set(struct apds9306_data *data, int val)
 {
 	struct apds9306_regfields *rf = &data->rf;
 
-	if (!in_range(val, 0, APDS9306_ALS_PERSIST_VAL_MAX))
+	if (!in_range(val, 0, APDS9306_ALS_PERSIST_NUM_VALS))
 		return -EINVAL;
 
 	return regmap_field_write(rf->int_persist_val, val);
@@ -796,7 +796,7 @@ static int apds9306_event_thresh_adaptive_get(struct apds9306_data *data, int *v
 	if (ret)
 		return ret;
 
-	if (!in_range(thr_adpt, 0, APDS9306_ALS_THRES_VAR_VAL_MAX))
+	if (!in_range(thr_adpt, 0, APDS9306_ALS_THRES_VAR_NUM_VALS))
 		return -EINVAL;
 
 	*val = thr_adpt;
@@ -808,7 +808,7 @@ static int apds9306_event_thresh_adaptive_set(struct apds9306_data *data, int va
 {
 	struct apds9306_regfields *rf = &data->rf;
 
-	if (!in_range(val, 0, APDS9306_ALS_THRES_VAR_VAL_MAX))
+	if (!in_range(val, 0, APDS9306_ALS_THRES_VAR_NUM_VALS))
 		return -EINVAL;
 
 	return regmap_field_write(rf->int_thresh_var_val, val);

base-commit: b80ad8e3cd2712b78b98804d1f59199680d8ed91
-- 
2.34.1


