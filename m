Return-Path: <linux-iio+bounces-21558-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEAFEB00F2B
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jul 2025 01:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B210A1C44C9C
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jul 2025 23:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D7829B8E2;
	Thu, 10 Jul 2025 23:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="od829Ylq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA7B236A79
	for <linux-iio@vger.kernel.org>; Thu, 10 Jul 2025 23:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752188419; cv=none; b=dzXHhJAKgIi7G7o4GuTRhp3wNkCqW8EhO5pM/Mi6UuSB1QCcgE9Xxmh1bvieU5602SFM+dKaO7j+ctxr8PP5kyyT79/bC/X+AaF7l0+rehnZj+s+yMSVCOGAkeActHHtXPq59Rm6TSeqfRC9nk3udM43PdA/JPw9LPQ7aGuoEMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752188419; c=relaxed/simple;
	bh=Ga360paPXSh6ueJRgO9R8YPVrNY0pUaCx9Cm7uh2lsk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=PKOc5WXPGFd5XriRm6eQROQbH3lnThYAOVmJzjDedCGdbpRRzce+bBIjrRfEm+1aqObWEwUyf0BP9eVYpOjRpNNvuA9FpuqpgGZtWk0WyM6krZky++Cvnem+hx09qe4BikJLGdjemf9orJjJ9Tw9YfATsqJss8M47ha+Yw+srk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=od829Ylq; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-2cc89c59cc0so1398031fac.0
        for <linux-iio@vger.kernel.org>; Thu, 10 Jul 2025 16:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1752188415; x=1752793215; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8uyKZwVLw2YawVW7YHnf1uYvsNPR1ElqQhqV5KaztNI=;
        b=od829YlqzY5DArwaDYQ2nuCyjjD7D14KD3uthftnQAoSaMNPAWHGLABfp5zJua2Kd9
         qCC5k3zN9Y31NilPIYQU25IpAdMiiA6V/g3wZVWgqPkzpzzWDoKbEg1mVev0rfRx8+q+
         n3RlMqjMpbWkJJ9gO+9RfrXDOIpQGRMbOkmyLEHI1vcZauoTKjoRnE17VRnsO/+dpKXn
         mDyBMuS0fw4DHn8qgv9kRvvgyvhaTqiObJTINk24m3OVDvVg6+dDfTvCGCs/Ueqd3J1J
         AUAWb1jiF9qX47QBJsfOALsobLeqHd3hFHTiYo/xeJRqLwsdtvNbyACwwJbsHYSx2qRn
         iveA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752188415; x=1752793215;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8uyKZwVLw2YawVW7YHnf1uYvsNPR1ElqQhqV5KaztNI=;
        b=CJdRpckdaXzdDTgbcR4avsQtpnyCDU3axMD37CpE6/XqomtOr/CYy6Wxl004iXRkDZ
         Z8bUK+a1LLMNEUAtI/ZhcUrjpRTTp0yrVgNbdZQN1MbS3QaMG8uQK8pitUcs86chK9wN
         IF3LLUK0lRcMuQcuhAIw9F12u7jMRIVMQTCpJtX5vTbs8AzpVizfjO41dglMUkpdGzcQ
         VmisPM9ycXO+ZW5OIu4NIcgABFiH86mOFeEchUaiky5yoEgrSihVEqwIhQ8YBgY8xTcL
         lbPm0+tJQMRiMdqqWQXtPurNSscgYEWTjmycpfzawD20kETDIWSMQnLySZqn5/Z+l6J+
         p9Xw==
X-Gm-Message-State: AOJu0YwT3pISSU+F38uWxfsVCzPaN6025tkXZ/89EikkQkeMrU+DCdrP
	M33MWg3LDW8VUB9lPafgJm18RVpVe/lN2eOXV5cKdo7V2y/UeTUATUGKPxhXQmoXMFM=
X-Gm-Gg: ASbGncvB2y6KusdJ0a6KJmvAwItwH2XPZrl0i3Mamcq5W1IHDuYFULVhTD6xWcAJj2+
	nlMDJ7cl0/0HJRb5SsIynzYk92mwaTnViXI/ZprqfySSBri4uGU+ZeVf8Y3gHtyclBPZmcokylj
	yry90MXe4N/K6ymH2QJiMKuF4MZAZUIQcIB07FHgnTpFUj9dxgJuGI/5aHjPe0hfxTzQjRD3nZO
	Y8fBUzJjfjblhGOuGT+O5yw2dQXnv7LnRzcHZxrCB1efQLErXNw0+bXj+uryTHzGbi9BVL106K0
	g9z2X8jjOSTU43NW0wWbntwrOYXANSLKy66xmNDPKkYECukXW84DOi01GnX9LT8gnSKO4PH23Oo
	Yovc5vKgszigRYZDeFRk0G9GYPw==
X-Google-Smtp-Source: AGHT+IElSJTJahY2gj5/r6X0EORAGMmWE/sgZuNRZ0T9V6IP9W/0e9Hq5EMhpY8f2Hy+mJg4FZlvJQ==
X-Received: by 2002:a05:6870:8a22:b0:2d5:2dfd:e11c with SMTP id 586e51a60fabf-2ff26455f7emr841617fac.7.1752188415561;
        Thu, 10 Jul 2025 16:00:15 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:891b:7836:c92:869])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2ff116d22easm494104fac.33.2025.07.10.16.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 16:00:14 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 10 Jul 2025 18:00:05 -0500
Subject: [PATCH] iio: accel: bma180: use stack allocated buffer for scan
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-iio-use-more-iio_declare_buffer_with_ts-v1-1-df6498f54095@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAPRFcGgC/x3NWw6CMBBG4a2QeXaSUrygWzGmwfavTKLUTEFIC
 Hu3+vi9nLNShgoyXaqVFB/JkoaCeleR77vhAZZQTNbYgznVhkUSTxn8SoofXIB/dgp3n2KEuln
 G3o2Zzdnum9aGpvVHKrW3IsryP11v2/YFaeTiX3kAAAA=
X-Change-ID: 20250710-iio-use-more-iio_declare_buffer_with_ts-0924382d38c6
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1790; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=Ga360paPXSh6ueJRgO9R8YPVrNY0pUaCx9Cm7uh2lsk=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBocEX2Cp+CaOJ12mqg+Xq/3er3A81nbq4XuuPLl
 dM0uBZ3WbeJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaHBF9gAKCRDCzCAB/wGP
 wI0GB/0RzkFbDCbiaJRVyafu8x5tvAUHNDzhfqM/I8J1aQyElAWivffVZGLvyIEmtst4MFolnHp
 B4PEHfha2qqfLialu5NZwQFTb0f9dHiIugS/pn05xf1iZf8ITVcIXcU1qppixw1/Hwglj2RinXS
 xIPF49xYBbJ3W4y9r2QUhqESs+tufkPujAJbBqOUs8QfmykIeLsxuiqAmGvvVfeG4swjEgVuZc9
 HQ4qeW9ZhfkJPr2yEMnqTElqku/SxiZWc7jh2p6tfg7M713AxKf2BqC57BDsLCmgewFCspuIcyl
 3zeOAiMuIn+tnHdKg08MDuy5w5T1F/82IXihg5+TfhSBXNHg
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Use IIO_DECLARE_BUFFER_WITH_TS() to declare a stack allocated buffer
in bma180_trigger_handler(). Since the scan buffer isn't used outside
of this function, it doesn't need to be in struct bma180_data.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/accel/bma180.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
index 4fccbcb76e0423bee37463a72c637af80e356a19..d83d5becca6fc72b855310a31c3de5443e4e2311 100644
--- a/drivers/iio/accel/bma180.c
+++ b/drivers/iio/accel/bma180.c
@@ -139,11 +139,6 @@ struct bma180_data {
 	int scale;
 	int bw;
 	bool pmode;
-	/* Ensure timestamp is naturally aligned */
-	struct {
-		s16 chan[4];
-		aligned_s64 timestamp;
-	} scan;
 };
 
 enum bma180_chan {
@@ -865,6 +860,7 @@ static const struct bma180_part_info bma180_part_info[] = {
 
 static irqreturn_t bma180_trigger_handler(int irq, void *p)
 {
+	IIO_DECLARE_BUFFER_WITH_TS(s16, scan, 4);
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct bma180_data *data = iio_priv(indio_dev);
@@ -879,12 +875,12 @@ static irqreturn_t bma180_trigger_handler(int irq, void *p)
 			mutex_unlock(&data->mutex);
 			goto err;
 		}
-		data->scan.chan[i++] = ret;
+		scan[i++] = ret;
 	}
 
 	mutex_unlock(&data->mutex);
 
-	iio_push_to_buffers_with_ts(indio_dev, &data->scan, sizeof(data->scan), time_ns);
+	iio_push_to_buffers_with_ts(indio_dev, scan, sizeof(scan), time_ns);
 err:
 	iio_trigger_notify_done(indio_dev->trig);
 

---
base-commit: f8f559752d573a051a984adda8d2d1464f92f954
change-id: 20250710-iio-use-more-iio_declare_buffer_with_ts-0924382d38c6

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


