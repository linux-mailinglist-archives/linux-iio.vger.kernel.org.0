Return-Path: <linux-iio+bounces-10710-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 107029A3B2C
	for <lists+linux-iio@lfdr.de>; Fri, 18 Oct 2024 12:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DB31B26D45
	for <lists+linux-iio@lfdr.de>; Fri, 18 Oct 2024 10:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F79520263C;
	Fri, 18 Oct 2024 10:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V0et5gkD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6D22022CE;
	Fri, 18 Oct 2024 10:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729246624; cv=none; b=XQtstmv9upVLWO+3TKedl6IGclC9AHbxrCtw/MOQxd6551j9DjGPmWLzhQeyLGs3lVJ9xqGT7RzEuze68XxDnI9uFKUqUbZ32lyp6WX3KXnDOyxfIgJaY7EsH9tBjBADfX3GAwppO/BTzP2oOoC2esShLI1fQ2UEMoFEY4RT3eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729246624; c=relaxed/simple;
	bh=lLwcWxwjDNJi83wrQWAVlHlVnJucfvYmyQRif2fP9tA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aTrB8XcUyMrM4shX26uKcoqu1CejHJoD4jOl1NK/I5jpHeT/rtX1mO/ddm9DaKSBB2athv1mULuni5+p077cm6Jf582HAuCUlWxrPn/gIXk3chdA53hKwisEmrpywWTZUQe7tk2eJI2p6+Dd7zDfuaheIGP6/+apkqVXhWUrEZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V0et5gkD; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-37d49a7207cso1359468f8f.0;
        Fri, 18 Oct 2024 03:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729246621; x=1729851421; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rwzowURA7LrdNAtuervNEFmMl54ysOzLP8Fuq/kRIC8=;
        b=V0et5gkDbUjGDH43nGDlNmoFBpKq4Q6Z/jsn4Of8jhubqHnbSfZPw3G77D95fLouyz
         HTRtVPMRuNF1csLp6QELOrtZiRTnVL8TCblkbfSvNYoDDhdNrAaavAuzKBw3MjNAMFhj
         IIp5C74Z1KJSAMWdZ1qJMMueOgA/iaA5OtNTiHnSyIR6oFpcX6ORUkZVPBAL8blmhKds
         zdD3HSfCHdXtb3YT03V46Z/zn0LhGc0hUWANB0teCeL9t2Nl+m9O7qPw38y0josThqZA
         uKOAqhHExvd81LXnvZCqd3Yur5+dOF58/VaOtFFCVjj+m1rR4Yh+6DE7NFooRZ4yuOBW
         TEJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729246621; x=1729851421;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rwzowURA7LrdNAtuervNEFmMl54ysOzLP8Fuq/kRIC8=;
        b=UvjT3bsXwWFFLwmff1tDIzOTmKHvtvrbJIebdJHParWrWbnVvyKW54IwpmSm5kQw6A
         X2FVXJuuphg0n7ub0IvO0b+vWMqpL9Bi030rs9AYmCDW4iTWZyMNF+W6eEqPOeckojcL
         QOQ5zepCkfJXLMxpdyQd/1vl+LCHudpK852Kd8aHYCqVsoDLtZWqOOswYfDqHgYllAON
         Xcne/IDvwmyv1LDyeKdh71nHVw3CeXAfwJu8B7P+2EpwOPjAMQVHOUsU+kwe8QTdE9JJ
         BwgqTbyTR1WY5Us8mLKb67ZSXRl7X9pPHT/uMgWMdqgHFJiw7Di+t16bjWom8eHR8v6G
         mJ9w==
X-Forwarded-Encrypted: i=1; AJvYcCV/Zas7VPD2f5OOjIafr8GZuIjwtE3qgdAuB0zrk8RzRMbmQN9ACoIZEWr2nMiTBZO64s/cbGNOu55J7g==@vger.kernel.org, AJvYcCVv7MR7unSxfDAZ9L2EVp73vA5YuTVDPH06baKRZRF3B4M+wObwLEeEZVFsqdOgg+HsjUl4ZslJyPc=@vger.kernel.org, AJvYcCWnnF9ZiXeMMiCx5kdJ1U+oDjpdrUt9LijteVxpIE5COVecqmSc521XoPzQoGkKBsG6C+2vnTSbKodxqNE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz19u+rOiTg6kwdOaDEGD677GCfIKT+lL+BqR87kkKIEnzT1K3j
	zEuvX35M0YGMRyki6xjaxgB93c1ik7i54ak4JPXXkNpXZ9TY8JCM
X-Google-Smtp-Source: AGHT+IHlbRgeDtSiwkVImTXi6eLGA0djtvQh25VEd8vaYpE2W6OyXUpc7iS8UBuQTPmhk1FJ6BJcKg==
X-Received: by 2002:a5d:554a:0:b0:37d:43f1:57fd with SMTP id ffacd0b85a97d-37ea213717emr1388681f8f.6.1729246620727;
        Fri, 18 Oct 2024 03:17:00 -0700 (PDT)
Received: from localhost (host-79-18-120-72.retail.telecomitalia.it. [79.18.120.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ecf089d52sm1543397f8f.61.2024.10.18.03.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 03:17:00 -0700 (PDT)
From: Matteo Martelli <matteomartelli3@gmail.com>
Date: Fri, 18 Oct 2024 12:16:43 +0200
Subject: [PATCH v4 4/5] iio: ad7192: copy/release available filter
 frequencies to fix race
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241018-iio-read-avail-release-v4-4-53c8ac618585@gmail.com>
References: <20241018-iio-read-avail-release-v4-0-53c8ac618585@gmail.com>
In-Reply-To: <20241018-iio-read-avail-release-v4-0-53c8ac618585@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Alisa-Dariana Roman <alisa.roman@analog.com>, 
 Christian Eggers <ceggers@arri.de>, Peter Rosin <peda@axentia.se>, 
 Paul Cercueil <paul@crapouillou.net>, Sebastian Reichel <sre@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mips@vger.kernel.org, linux-pm@vger.kernel.org, 
 Matteo Martelli <matteomartelli3@gmail.com>
X-Mailer: b4 0.14.2

While available filter frequencies are being printed to sysfs by iio
core (iio_read_channel_info_avail), the sampling frequency might be
changed. This could cause the buffer shared with iio core to be
corrupted. To prevent it, make a copy of the filter frequencies buffer
and free it in the read_avail_release_resource callback.

Signed-off-by: Matteo Martelli <matteomartelli3@gmail.com>
---
 drivers/iio/adc/ad7192.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index 7042ddfdfc03ee5ea58ca07fb1943feb6538175b..acf625ced0b21db8d44f77929e8a875b3c10e1b1 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -1056,12 +1056,19 @@ static int ad7192_read_avail(struct iio_dev *indio_dev,
 		*length = ARRAY_SIZE(st->scale_avail) * 2;
 
 		return IIO_AVAIL_LIST;
-	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
-		*vals = (int *)st->filter_freq_avail;
+	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY: {
 		*type = IIO_VAL_FRACTIONAL;
 		*length = ARRAY_SIZE(st->filter_freq_avail) * 2;
 
+		guard(mutex)(&st->lock);
+
+		*vals = kmemdup_array((int *)st->filter_freq_avail, *length,
+				      sizeof(int), GFP_KERNEL);
+		if (!*vals)
+			return -ENOMEM;
+
 		return IIO_AVAIL_LIST;
+	}
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
 		*vals = (int *)st->oversampling_ratio_avail;
 		*type = IIO_VAL_INT;
@@ -1073,6 +1080,14 @@ static int ad7192_read_avail(struct iio_dev *indio_dev,
 	return -EINVAL;
 }
 
+static void ad7192_read_avail_release_res(struct iio_dev *indio_dev,
+					  struct iio_chan_spec const *chan,
+					  const int *vals, long mask)
+{
+	if (mask == IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY)
+		kfree(vals);
+}
+
 static int ad7192_update_scan_mode(struct iio_dev *indio_dev, const unsigned long *scan_mask)
 {
 	struct ad7192_state *st = iio_priv(indio_dev);
@@ -1098,6 +1113,7 @@ static const struct iio_info ad7192_info = {
 	.write_raw = ad7192_write_raw,
 	.write_raw_get_fmt = ad7192_write_raw_get_fmt,
 	.read_avail = ad7192_read_avail,
+	.read_avail_release_resource = ad7192_read_avail_release_res,
 	.attrs = &ad7192_attribute_group,
 	.validate_trigger = ad_sd_validate_trigger,
 	.update_scan_mode = ad7192_update_scan_mode,
@@ -1108,6 +1124,7 @@ static const struct iio_info ad7194_info = {
 	.write_raw = ad7192_write_raw,
 	.write_raw_get_fmt = ad7192_write_raw_get_fmt,
 	.read_avail = ad7192_read_avail,
+	.read_avail_release_resource = ad7192_read_avail_release_res,
 	.validate_trigger = ad_sd_validate_trigger,
 };
 
@@ -1116,6 +1133,7 @@ static const struct iio_info ad7195_info = {
 	.write_raw = ad7192_write_raw,
 	.write_raw_get_fmt = ad7192_write_raw_get_fmt,
 	.read_avail = ad7192_read_avail,
+	.read_avail_release_resource = ad7192_read_avail_release_res,
 	.attrs = &ad7195_attribute_group,
 	.validate_trigger = ad_sd_validate_trigger,
 	.update_scan_mode = ad7192_update_scan_mode,

-- 
2.47.0


