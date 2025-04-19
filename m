Return-Path: <linux-iio+bounces-18351-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5540A945FC
	for <lists+linux-iio@lfdr.de>; Sun, 20 Apr 2025 01:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4B59177157
	for <lists+linux-iio@lfdr.de>; Sat, 19 Apr 2025 23:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F101E1308;
	Sat, 19 Apr 2025 23:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UrfLERND"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3140B1B87E8
	for <linux-iio@vger.kernel.org>; Sat, 19 Apr 2025 23:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745104913; cv=none; b=PNT3E5Gx5yPC5fixQJ6YPGLsSAppXidPzot0jq6CSurkIaTvnOOjgGeQdS3JP4YuNOfmNFEyTv85l7FylrYpQQMCL+U6nFuFP5cNL7zaR//eg4jEOcB1hxiGnb4SKZQ3M0nvgkaEcMVbzq1Ctn5ffBt0XvGvVwZNo8gV/D5gWL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745104913; c=relaxed/simple;
	bh=JRymKY/HR1nlMkC0HkBpqYj3UGRnKoEGQ6LjZbFrK5k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ttq2c8sLj9V7sIdclgo/G+Mu/7ndUgA587YCJyaRwtYtedzEpQuou4ZUFVSy0Z8aD0rnxQO57iUuulHaE0lq7oVeUkIlziI4fxkWrFnrDp2rEvZgmj/EmI5Ir5KWhSFBd0MXs0xPSVVBrYNXRrzJTjoD4R0FWhXkh50/NG+QstY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UrfLERND; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-226185948ffso32824975ad.0
        for <linux-iio@vger.kernel.org>; Sat, 19 Apr 2025 16:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745104911; x=1745709711; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FlolQ4vItklUXwm2iVKthwPO48o+ol/fXEy7e/ZQ9uQ=;
        b=UrfLERND2D8WjtbyhyymPSxlfX7zEdN9bkV7MwiazT798bB8PS7+QJQQ+dYexiRC9B
         RiabURpszP0+MLAqZuFFsAHdbY9tIpX6ZMR0M22ZePs398XxwFbc+MHLAV2b1oYAoD9P
         X1Vf7+UWxncXnUZP9FfI+j3x2Hwh4adzUbDZrr9aeAu+Qo3c8FYWcNG49WbU/DioQKJx
         ZJsmZkVLRo2PAtkbVCLigwUx2hcjYiHaO1SKFoEtJ0w52cGyF1hOqZceYGrpQEndfpox
         c2LzkaOyWowDtTYuZf3Jq8DlwqSfBaDXd9CZP6lAh23cDb5ovyCED5T9vN9gsJUSytea
         YDYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745104911; x=1745709711;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FlolQ4vItklUXwm2iVKthwPO48o+ol/fXEy7e/ZQ9uQ=;
        b=h1oMCtaGKZwg0LBap5tacmIxwhD1l8j7b5uvNSh09MnOrF8lz1F+twX6Ifjz1XwmvI
         gBIvv5mlcp6YrxU9+ClsYMYpcOpeaIYNJCWKvrbVZc/S1xpG4z6U7qdeUcN45cBo6M9P
         dEe7Y7xBCFdn0aB/YRQlHgnEhJFTJ5r0qoZS9WaoW1Y9pw0OuLuhzoMadMeuojcTOqa6
         i3YW62Y0YlrXBjq0vWiQddGLdTvqyo3xIYWaFPAyxNRvQMy9AyvSnHjB137HHiicCFdD
         nnnuj6ALJA1GVuXxueyASO+W/STtp4V1JEvYx+IhBwUblev38hbEDtlviPR4wddiH4o3
         5/XA==
X-Forwarded-Encrypted: i=1; AJvYcCW+tFrgg8+JVazEklzsO7tCnyh0aqI+KqiewDCqY0cohn1TuXZAjK+nyK+g86g9LtE2DJzIEc5YoRc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY80g8uHsGkIs2c86/qEhcEo1FYyXmp0j9aPm4Wih1rVuWMqru
	11/3xTpqXobqt+dZnh1A0LDZf5o0rTUQtvyZA47QQpMyGtyL9bW3
X-Gm-Gg: ASbGncuGComVZYMQ98zlB2HvA/dMu1xBwXGsI/m4sYFcYs9y9jSQvZUyGb/8PCK+gHP
	5v8BcKrkQYMoBha25hxxdOZ5tgkvgFQ3AVVMwLCkaYkP+jzwCn7qg3cmIA4DdVTJlfYUiPF0KQH
	oMvsxObAEHgPBQ4JG5Qsce6QI5SVXdiMdEb9aGQbqHkexwp67QwYX1MeugXlu9RaMNocnkNACEj
	jF9sEgGQ/4qAdKWoWvRIkmgZoz0JyxhYaiocLippi1xsxp5Fd0PBHH4BL82Ww1wECOFBeWgdjHW
	8bDztDo6Wii2FQpt/023IWsVkPTxth8NAZJnVBXMJ6ifRmgZ+waJdN72mRsWyka0jYE08jgo+ZO
	Yve4rBZMb7kTXxHIY49DryWQl5VNZItcYhuB1vwXujmqKvE4=
X-Google-Smtp-Source: AGHT+IFMzHjUONUFxHjSGIWInmN0ck++EqwcEb673Pomon7xLQ0+t5v6UOlVNyoYfvDE8G/DDbt5cg==
X-Received: by 2002:a17:902:cecb:b0:224:216e:332f with SMTP id d9443c01a7336-22c536204b2mr100937055ad.48.1745104911313;
        Sat, 19 Apr 2025 16:21:51 -0700 (PDT)
Received: from mintNaitss.meuintelbras.local (187.103.56.177.redfoxtelecom.com.br. [187.103.56.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50eb4ba5sm38988605ad.120.2025.04.19.16.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Apr 2025 16:21:50 -0700 (PDT)
From: nattan <nattanferreira58@gmail.com>
To: subhajit.ghosh@tweaklogic.com,
	jic23@kernel.org
Cc: lucasantonio.santos@usp.br,
	Nattan Ferreira <nattanferreira58@gmail.com>,
	linux-iio@vger.kernel.org
Subject: [PATCH] iio: light: apds9306: Refactor threshold get/set functions to
Date: Sat, 19 Apr 2025 20:21:28 -0300
Message-Id: <20250419232128.35759-1-nattanferreira58@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nattan Ferreira <nattanferreira58@gmail.com>

Refactor the apds9306_event_thresh_get and apds9306_event_thresh_set functions
to use a helper function (get_thresh_reg) for obtaining the correct register
based on the direction of the event. This improves code readability,
minimize the number of lines  and maintains consistency in accessing
threshold registers.

Signed-off-by: Nattan Ferreira <nattanferreira58@gmail.com>
Co-developed-by: Lucas Antonio <lucasantonio.santos@usp.br>
Signed-off-by: Lucas Antonio <lucasantonio.santos@usp.br>
---
 drivers/iio/light/apds9306.c | 38 ++++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/light/apds9306.c b/drivers/iio/light/apds9306.c
index 69a0d609c..8e1cdaeb0 100644
--- a/drivers/iio/light/apds9306.c
+++ b/drivers/iio/light/apds9306.c
@@ -6,7 +6,6 @@
  *
  * Copyright (C) 2024 Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
  */
-
 #include <linux/bits.h>
 #include <linux/cleanup.h>
 #include <linux/delay.h>
@@ -744,20 +743,28 @@ static int apds9306_event_period_set(struct apds9306_data *data, int val)
 	return regmap_field_write(rf->int_persist_val, val);
 }
 
-static int apds9306_event_thresh_get(struct apds9306_data *data, int dir,
-				     int *val)
+static int get_thresh_reg(int dir)
 {
-	int var, ret;
-	u8 buff[3];
-
 	if (dir == IIO_EV_DIR_RISING)
-		var = APDS9306_ALS_THRES_UP_0_REG;
+		return  APDS9306_ALS_THRES_UP_0_REG;
 	else if (dir == IIO_EV_DIR_FALLING)
-		var = APDS9306_ALS_THRES_LOW_0_REG;
+		return APDS9306_ALS_THRES_LOW_0_REG;
 	else
 		return -EINVAL;
+}
+
+static int apds9306_event_thresh_get(struct apds9306_data *data, int dir,
+				     int *val)
+{
+	int reg, ret;
+	u8 buff[3];
+
+	reg = get_thresh_reg(dir);
 
-	ret = regmap_bulk_read(data->regmap, var, buff, sizeof(buff));
+	if (reg == -EINVAL)
+		return reg;
+
+	ret = regmap_bulk_read(data->regmap, reg, buff, sizeof(buff));
 	if (ret)
 		return ret;
 
@@ -769,22 +776,19 @@ static int apds9306_event_thresh_get(struct apds9306_data *data, int dir,
 static int apds9306_event_thresh_set(struct apds9306_data *data, int dir,
 				     int val)
 {
-	int var;
+	int reg;
 	u8 buff[3];
+	reg = get_thresh_reg(dir);
 
-	if (dir == IIO_EV_DIR_RISING)
-		var = APDS9306_ALS_THRES_UP_0_REG;
-	else if (dir == IIO_EV_DIR_FALLING)
-		var = APDS9306_ALS_THRES_LOW_0_REG;
-	else
-		return -EINVAL;
+	if (reg == -EINVAL)
+		return reg;
 
 	if (!in_range(val, 0, APDS9306_ALS_THRES_VAL_MAX))
 		return -EINVAL;
 
 	put_unaligned_le24(val, buff);
 
-	return regmap_bulk_write(data->regmap, var, buff, sizeof(buff));
+	return regmap_bulk_write(data->regmap, reg, buff, sizeof(buff));
 }
 
 static int apds9306_event_thresh_adaptive_get(struct apds9306_data *data, int *val)
-- 
2.34.1


