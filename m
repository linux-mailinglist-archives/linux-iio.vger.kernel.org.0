Return-Path: <linux-iio+bounces-18144-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADC88A8A6DC
	for <lists+linux-iio@lfdr.de>; Tue, 15 Apr 2025 20:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F4973BD5B4
	for <lists+linux-iio@lfdr.de>; Tue, 15 Apr 2025 18:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5483C226CF6;
	Tue, 15 Apr 2025 18:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XKOLlz8c"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB0922157E;
	Tue, 15 Apr 2025 18:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744742122; cv=none; b=Jn+CNrTcq2Z3+r4Xu9n6XdR8iR+0og5xXStiLHHs7JMUvcp+80VMbtYhctlHbacMv4I7eg72qArdNbbg7/QJqWrlG7PCP/ipti990VxAD0V+lpYGtiF0DlR5uR7T2pnwfLzMGBMTHkDOwiWPm6BEfEakjCpWZMZazu5O6NpH0aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744742122; c=relaxed/simple;
	bh=m0ngbikheMR+1AzBKdPAopMMX2/FHuoyguBS+J0KTQw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O3cmTumJrR+hvLZyp2rK7Ljldba6PL/EfarcJB7+XM42SGJuBiFBgQ4GsbqGt9hWD0pV6UhXrsXLLuzVV4Jgdk+k3Lmf6S18Ym+2RpIqzavDCOFYQaho2haa+jXjjGmp0YXDec1gjVZJJGnVMpR33H8OGnNJnNGRn3B8TZ3ojac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XKOLlz8c; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7c5568355ffso484251185a.0;
        Tue, 15 Apr 2025 11:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744742118; x=1745346918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=97X8AfJzSEM+SJ3Sxi/vdcxd/nCQ6ViCFDXjOmjTF6E=;
        b=XKOLlz8ce2zSa/PiJfDoEzUMJhOzgAO6FXqTozX1v4jD3DMeKIm8vUdQmzDrVi41sc
         MyYLp4Ev+vpjQRzLv4YR+TARtlxAy6UPMfU/BxhsD+PKro5eFDqafzvP8oI1604jqgDr
         kHynkwQITmr+dS6a/549eNYr9chHBUv0iL6TDmW3LMuTuAiiLEBiE59py05Lf9UIUtQU
         bXM3Db6NQ2Qbux3qvBKzIWsJ5Yfc0iRn3o+1nWrjvCjrIwUH2cGGvcGAnbTZ+bfA25oU
         h2k5XYwozB3OPmejlkk4S3h2UT9eBX5yylva1AfgOGLYLTi7ddQLcLLrJmAJcgbjc3ON
         Gc2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744742118; x=1745346918;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=97X8AfJzSEM+SJ3Sxi/vdcxd/nCQ6ViCFDXjOmjTF6E=;
        b=v9/ZrlREWPY7JnYk/BzJqoKsnXq7wIlbsfAj7ZN/DSof/RM/w/bkM3rLm6vGp/5Esl
         +DuCyzDN9EImmsLm6VH8H//1DGm/NaJ3E6alp2MYbrKgp6NENSk1VNoggCDgMnGggLLX
         2dp/EfjvoE6EfEhn0eeijd8Z1wEAS8wwktxrhDed0bJVUxQY7uHFV7sRMw3fmTVuCJMp
         iCVu80r3/wDC627qabfLpx1O+PbwB+OIPeH8gZgE39PIa2tljR+GlcZC/VltCWhBmSNB
         NMPyiacIER4Ktig92bLocFQFkCQ+BLShe3o54OI1zlZSVDbJYTtAuv0YPWXCbwo1sdLk
         LtSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNn7YZb9vuIjNlYWyyUKKyWVOfuPimW/GUb3HqM0VSBs1Xd++B9AEqgydf/OFFi6wLAeJNs+Wd+ck=@vger.kernel.org, AJvYcCXASDhFMqM5v6bnTR2bz73QNuPz8VfuYf5ChuILPyr95b3zBIz144VMz3ysgTTlF/QLrcEtfzHJ@vger.kernel.org, AJvYcCXKrU/U4CzG4x8BDfHKV4EfYW+c+q+bxU7okDm3p6iCbYAdmDeggJCDnxTmu+Qj4qnyDxXZk1dkVKd/i0Sn@vger.kernel.org
X-Gm-Message-State: AOJu0YwpvY8nILG14W268eOzyKtnLw1KMKyqKnjGxyd8zifMet4SDHMb
	XGpMaHUJ5xMsx06u/cQ4zsXf0nxbERJqLw3POumimxAopxWWgcrT
X-Gm-Gg: ASbGncvlfJM7o/3bSYJC8kmehRPjF4dxc4aFmu4CLMla9evRaeUMEsTHIuIH9x23Tcg
	ItAaaV7UIndUrYn8To1XMS/XZRV+YLKwwx8Ftvb7x+XJ9274q6ZdVAQjHtUNSQeHx56YEbq3CzA
	swjNk5IhAafkOYwZ+l/T8uvCrvstBSp2xYpOOpfsJ5pt80hqYO4GgXK9UgzShqiYCy2srrViq3u
	b7dtg5mSFQuiU8TdyHVZ41TQqEFibg4cot9BcEn67BjO3dPKM1mONLS+7Vjk3nKVgE1YswKcg3o
	YS+lq2F3J34xULV4Zr/Ll6b/RC95ve2yRfqEZBItJxfLazaHUNPNLvM=
X-Google-Smtp-Source: AGHT+IFDLnaf693CbcJqHa7n4MDj3QAjiwK9YeW53EEizGcBL+eM4f0LfY8bkzMCvFDj4Hto48V/uA==
X-Received: by 2002:a05:620a:2991:b0:7c7:a59b:4b07 with SMTP id af79cd13be357-7c91419a469mr70542485a.3.1744742118218;
        Tue, 15 Apr 2025 11:35:18 -0700 (PDT)
Received: from theriatric.mshome.net ([73.123.232.110])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c7a8a0de11sm936533185a.101.2025.04.15.11.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 11:35:17 -0700 (PDT)
From: Gabriel Shahrouzi <gshahrouzi@gmail.com>
To: gregkh@linuxfoundation.org,
	jic23@kernel.org,
	lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev,
	Michael.Hennerich@analog.com,
	sonic.zhang@analog.com,
	vapier@gentoo.org
Cc: gshahrouzi@gmail.com,
	skhan@linuxfoundation.org,
	kernelmentees@lists.linuxfoundation.org,
	stable@vger.kernel.org
Subject: [PATCH] iio: adc: Revoke valid channel for error path
Date: Tue, 15 Apr 2025 14:20:38 -0400
Message-ID: <20250415182038.523186-1-gshahrouzi@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to the datasheet on page 9 under the channel selection table,
all devices (AD7816/7/8) are able to use the channel marked as 7. This
channel is used for diagnostic purposes by routing the internal 1.23V
bandgap source through the MUX to the input of the ADC.

Replace checking for string equality with checking for the same chip ID
to reduce time complexity.

Group invalid channels for all devices together because they are
processed the same way.

Fixes: 7924425db04a ("staging: iio: adc: new driver for AD7816 devices")
Cc: stable@vger.kernel.org
Signed-off-by: Gabriel Shahrouzi <gshahrouzi@gmail.com>
---
 drivers/staging/iio/adc/ad7816.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
index 6c14d7bcdd675..d880fe0257697 100644
--- a/drivers/staging/iio/adc/ad7816.c
+++ b/drivers/staging/iio/adc/ad7816.c
@@ -186,17 +186,12 @@ static ssize_t ad7816_store_channel(struct device *dev,
 	if (ret)
 		return ret;
 
-	if (data > AD7816_CS_MAX && data != AD7816_CS_MASK) {
-		dev_err(&chip->spi_dev->dev, "Invalid channel id %lu for %s.\n",
-			data, indio_dev->name);
-		return -EINVAL;
-	} else if (strcmp(indio_dev->name, "ad7818") == 0 && data > 1) {
-		dev_err(&chip->spi_dev->dev,
-			"Invalid channel id %lu for ad7818.\n", data);
-		return -EINVAL;
-	} else if (strcmp(indio_dev->name, "ad7816") == 0 && data > 0) {
+	if (data != AD7816_CS_MASK &&
+	    (data > AD7816_CS_MAX ||
+	    (chip->id == ID_AD7818 && data > 1) ||
+	    (chip->id == ID_AD7816 && data > 0))) {
 		dev_err(&chip->spi_dev->dev,
-			"Invalid channel id %lu for ad7816.\n", data);
+			"Invalid channel id %lu for %s.\n", data, indio_dev->name);
 		return -EINVAL;
 	}
 
-- 
2.43.0


