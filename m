Return-Path: <linux-iio+bounces-24911-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A6EBCDD8E
	for <lists+linux-iio@lfdr.de>; Fri, 10 Oct 2025 17:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F1A614FF9A1
	for <lists+linux-iio@lfdr.de>; Fri, 10 Oct 2025 15:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5694E25A323;
	Fri, 10 Oct 2025 15:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="kOe8I1kZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292672FB616
	for <linux-iio@vger.kernel.org>; Fri, 10 Oct 2025 15:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760111103; cv=none; b=ErCTrv3Z4DvnabcoZL9e+d150t4ziSAQFaxByFuK1CZA48zf7AVY1IdaxR/Pmbe432a4zYpWefHiiFUmwel/QwN3/K3TGuopw1GQSltmD+XEn5uBxcBtiwozO392yoCllZNJ/J7aqoYNyYMnjpQb3QS10JggSisrmcKu6ZuLvC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760111103; c=relaxed/simple;
	bh=QKS4puind1Hws4Fkj8Bknp+M1UP2qskwWYb41VBUG5k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=a9zqQKvEn7uEZNX16/fs6nHalr0r2OUn4aO0fiKlty+FSSox3jr84BGWzHTQjEHqqCueeDGc6KDNODIBHIZF+Qs1Ntj/WcvN4Aym0ZRVuYgeRaygeL/MGGeDKNlStboQKvjvhabBzWRaEk/N1gKJGD/kJeh36Zmj8nwRIOzcSRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=kOe8I1kZ; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-64e3e259f93so1119565eaf.3
        for <linux-iio@vger.kernel.org>; Fri, 10 Oct 2025 08:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1760111099; x=1760715899; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7RNbFN6Pb19G5qsWCgJJs11kMSx198ewO/+S27H86/8=;
        b=kOe8I1kZEWO5axLQPIEc/39XmNzDGiKD2gMaPTm/+tlNCyk/KvTig35oBM+4NjQ2cY
         LLXPl+vT4ClMMAIPH6h3ukcB7vMaFmPtoDilfe6I9tCZ3KRBhO/QZ6B7xDN51JnR9Y/4
         dunLfgfbQiPqGMc5cLCmWj7FKkG4bTFgGLZYkQiPuwvFhT+aaxnnXBMT5eLtrp1kUlvc
         amJDjtWbPPf1XYgoxLFQnOH9xXvF/jbnaDUSXNf3ZM6xImyVN230GMD/lwWSnCt1DLkT
         Cuu9a0nIMqoVf5G0TcW59zN11CFG8JSZaq+Mj3qzAcJTxk0BW95NWNz6cgHao86tdYeR
         BWiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760111099; x=1760715899;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7RNbFN6Pb19G5qsWCgJJs11kMSx198ewO/+S27H86/8=;
        b=cE70InYxmDZA1xUs5dWLFQf1cOPR8vHHhMKV/2jt9Yb9RxVATuQXzFiK2cWYZpEzFC
         6pOyBbAOHFw1/fThzzFhHy/cNQXFPBeL7tcICjbQ/bFXWVaeCLnppRNFtL/DXw0K+HWl
         tAScC+8zynbZ0Flj9iLRTzmvoPpqUh4sk/twNXRy4TeyuNyd6b8S4hushwTwJYmnoMaF
         pyeKE6ouNw/YhVrFCHVql8uUGfiqkvsqAU3y6O6AHXfh02xTXJzRwQ5bci6MsV6/Gn/A
         K9Nb88Q+EfsZWbASlIkrF+jv1EmDACt3Z5s59l4odjWnkzZnmBoXMv99YNMssNwhzeP0
         4YkQ==
X-Forwarded-Encrypted: i=1; AJvYcCXoZo5dkYIBLJs0bKblHI0kBZBdq7hHLFvVCaIKixIWHpUx0bNwYl2MJOTbfYMIAz1K0k7Fp0uVytg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtPWPU94l3ylccktQWSu72WQcm1ktNDLOVCde352878LdBcvIU
	k+DhBuFcxFFA4tSA9iQVRj5Ewknk3ihOFjtRPhiPK9KWs6iYWpEJt7bskivoVhHsQro=
X-Gm-Gg: ASbGncv8FWaeKEiy/Sgu6y41n3TO+qOqFiGjuxK2rmrHnr0qZePipx5tLLjKft/mmYO
	LWanCHwkH/piDs/7jo5yPe9yZ05TVzOt/QnmTzNwqd29QQhSbbtRs2VNQ/7ZmT+VFGbmL5BRd12
	UL7AdCnd4l6QHSacZSbaJsH2PPH7tSxz3pIczYJr61Bbe71qdVhY0Seb1SLYH7Q4UjFKq/MFTVf
	b4QQ4WrwawYQ/NBEGrVUmG1KbR33fO7UULG4zvrgxERds7cFAq3y/YmtMKias3Dw2qDnGr8BKvL
	6UjklWgjUS3T6rLafDqe9+J2Z/a8dqfpwRc/LsnDtg2tDv9vy51ozW4FWj5E7/TFSTQZGcgk2jq
	38drYZHnLKivLM1AA0AMHJ7FmhKomG8jyfuUUtWJzUeS0P5nZw6pBAoVk
X-Google-Smtp-Source: AGHT+IEowqnjFNk2SMDGNBQ7/rWYKGwr7JvacbcVw43nyMdMwwbXs1/wLxCgvDkG0souDgxaV2Oo/Q==
X-Received: by 2002:a05:6820:238e:b0:63c:b999:f8a3 with SMTP id 006d021491bc7-64fffab8d69mr4686181eaf.0.1760111099185;
        Fri, 10 Oct 2025 08:44:59 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:6d3b:e3bd:4210:32e2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c0f915f53asm933666a34.37.2025.10.10.08.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 08:44:58 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 10 Oct 2025 10:44:45 -0500
Subject: [PATCH] iio: adc: ad7280a: fix ad7280_store_balance_timer()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251010-iio-adc-ad7280a-fix-ad7280_store_balance_timer-v1-1-e11746735192@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAOwp6WgC/y2N2woCMQxEf2XJs4G0uN5+RaSk3agBbSVdRFj23
 w3iw8CchzOzQBdT6XAaFjB5a9dWHcJmgHLnehPUyRkixTFQIFRtyFPx7OOBGK/6+ffU52aSMj+
 4FkmzPsUwxF0uY96KHAl89GXixu/wfFnXL2kvVryAAAAA
X-Change-ID: 20251010-iio-adc-ad7280a-fix-ad7280_store_balance_timer-126bc5b4ee90
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1237; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=QKS4puind1Hws4Fkj8Bknp+M1UP2qskwWYb41VBUG5k=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBo6SnvgIT0W1cfGXR0CP2Xv4IlR5KOwiCLl19jw
 6/u4+Kg9FiJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaOkp7wAKCRDCzCAB/wGP
 wNtXB/9/LZIEn30rqQaTd6Znvy1Kd+1aCYoNIXF+0+4eDOdkwsa95ztcktWJY43dKPwuiet5vsO
 yeXmP7Xf5Tyd948+LqDYFotZb+ApO+mNCc1vp7biIk6I7JKaqIL6agLYNVrtVV2Dp1i/V7ic12B
 J5jMjUtDLm4rCdk7Y9n6RSN8Av24YC+MiX8S+1CrowTZPBvj7p/59CZnOPsDsL7w98lYm4RAI5T
 OGqq23SbdTgYx9xV7Nkp/aJqKnRIs5Nqm5kq45F8iwEX4tVLmn6T9yofLKZ6oQVgQaeCVNbZccO
 1G2sVJJCk9c15Wtv/1GuE2TXydO+ysloLVimfiLYTJQ9pGc6
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Use correct argument to iio_str_to_fixpoint() to parse 3 decimal places.

iio_str_to_fixpoint() has a bit of an unintuitive API where the
fract_mult parameter is the multiplier of the first decimal place as if
it was already an integer.  So to get 3 decimal places, fract_mult must
be 100 rather than 1000.

Fixes: 96ccdbc07a74 ("staging:iio:adc:ad7280a: Standardize extended ABI naming")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad7280a.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7280a.c b/drivers/iio/adc/ad7280a.c
index dda2986ccda075fbfa04851a1ceac7a186b47537..50a6ff7c8b1c73905fabdef119d41204c32b590c 100644
--- a/drivers/iio/adc/ad7280a.c
+++ b/drivers/iio/adc/ad7280a.c
@@ -541,7 +541,7 @@ static ssize_t ad7280_store_balance_timer(struct iio_dev *indio_dev,
 	int val, val2;
 	int ret;
 
-	ret = iio_str_to_fixpoint(buf, 1000, &val, &val2);
+	ret = iio_str_to_fixpoint(buf, 100, &val, &val2);
 	if (ret)
 		return ret;
 

---
base-commit: a9682f53c2d1678b93a123cdaa260e955430bc5c
change-id: 20251010-iio-adc-ad7280a-fix-ad7280_store_balance_timer-126bc5b4ee90

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


