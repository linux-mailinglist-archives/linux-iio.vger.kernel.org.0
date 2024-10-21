Return-Path: <linux-iio+bounces-10871-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 013F99A693F
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2024 14:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73FEE1F2437D
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2024 12:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 638421EF0BD;
	Mon, 21 Oct 2024 12:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MJTI9eZu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD831F76C1;
	Mon, 21 Oct 2024 12:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729515393; cv=none; b=JurX7AXlWIa0DwzjWZPuilFj2C3WtsKoHyMky7J6J8/HdjShz9s9BEwhzQRF6WKOJmYDaqByF2s0riOkCkBuu1CPXHgUPoL5ezNqcfWDtNFRB+U3KNquVhgQcqwsWJ6DQ4WY/Uktk5M11WoIHtrJeeChbd1A36krptseWLQ51O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729515393; c=relaxed/simple;
	bh=lLwcWxwjDNJi83wrQWAVlHlVnJucfvYmyQRif2fP9tA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sU1VD3H4T/oBepKixuIw5Wgq1/i4AeucbLbsTbJRbGZ89Cixtm4BPG5HT7tsLUUqu2N0DDrwiTLJ1AKqynL1BtILwE6YlDpk0o4pIdvA7/5VUrTLNzsCFnCC/ayHDohfTDLQ8Kz6QGV/ciqJlgMexwZlGUHUKdbsgGQFDx3uvdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MJTI9eZu; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-37d4d1b48f3so3226067f8f.1;
        Mon, 21 Oct 2024 05:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729515389; x=1730120189; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rwzowURA7LrdNAtuervNEFmMl54ysOzLP8Fuq/kRIC8=;
        b=MJTI9eZu+KYOVcXbr/7tPzGX42O/IO3svhEdqrEbWNlAo+tjmAsr7Bw0vGeJwx6YO3
         Pl+bOfv6yPgCKcnRKwlI/jpdSuPHtIF7SJb9SnL1+fn59mL77lJHe7fai+YX0/wNWkiD
         3MLHwKImIVd8n4AXwZqeLMZ2xCNs6IxG+GfKD3MXwf9/N/6CglzwSqRfObe6WzA0oumi
         IW61RAl8iyi8daqwFREa1Hlq0p98a2/jjluOwDLCS6Wt3ByPoteEUrc66m0/nszcS2rp
         WX+9jlwmrC3oSikKvSMUYJ58+fymrc6+5sAx3iw/yyNJKl3DLadxtM+/h3mPhvsXHggN
         BV7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729515389; x=1730120189;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rwzowURA7LrdNAtuervNEFmMl54ysOzLP8Fuq/kRIC8=;
        b=XJePwiY04fkVIowBHrLs+FJil4JiL8ZAFbCbXh+augXly+RiA890eEoBulUx96A3E+
         1bH1ECyzbw9OkYTG6XFRRat7Z7IfU0CoohCsdkh9vCquYVx0sJzm4xdhhs2zr+cT1/Yp
         3Y8fKEhiG2sXJ7VM1jRJPq8EMZdpBjM0pQ+tU8kH+fSXrT6l+YFVgcwDrKf6d3k1p7+t
         MItgITxhkxM+5z/9jDD3DnovOAeHPagC+e3DqslPIL6f0jCmHc4x6z9E3QVkHg5iEo+R
         CdFwLpR1USTzmWemKZ14CwglzRTImVkplTpMbBCW0YN8xktRwQQx6o9VQKpd1bd5axO+
         i7KA==
X-Forwarded-Encrypted: i=1; AJvYcCU+WCyhsYS8ghm9SmaB/GmqiYa3SifSgyjmYlis64dSoKNvGbmBg1WGQrjP4snmEEkZtRgojroplyI=@vger.kernel.org, AJvYcCXJFcT3xEnp3yjxxaTQDpx5n3ivI3cWlZ9FU1SRNPmVmeQBA+0DWyG0KS4CwUqWUHt+mD/d4OtX0SaIH7g=@vger.kernel.org, AJvYcCXpaX/bh0fTn8bV1Twdsz1pyBM3pGifKPLtGsk1e3EDwmZEk09FM7fm9y8PhVEu5g4RAAfuA9znMTS/sg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyDfvvLUY6a39FZGds76Gpx2x9gQWkjk9uBYIj795+LyadHGkzC
	owVsiEmUkm/BilRvIC1nIYgN+OdkXFuZVfmwF/djZY85JW6mKOle
X-Google-Smtp-Source: AGHT+IE3sqIbhrRKNSwUqpOTS0bsiMboQAOmfOeXcbuKaZtHZv2GyJ7SF2BjInNbWjk1RDedJ4tbbQ==
X-Received: by 2002:a5d:5e11:0:b0:37c:d512:d427 with SMTP id ffacd0b85a97d-37edc481847mr4023498f8f.35.1729515389230;
        Mon, 21 Oct 2024 05:56:29 -0700 (PDT)
Received: from localhost (host-82-56-18-47.retail.telecomitalia.it. [82.56.18.47])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f570d86sm58173265e9.8.2024.10.21.05.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 05:56:28 -0700 (PDT)
From: Matteo Martelli <matteomartelli3@gmail.com>
Date: Mon, 21 Oct 2024 14:54:17 +0200
Subject: [PATCH v5 4/5] iio: ad7192: copy/release available filter
 frequencies to fix race
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241021-iio-read-avail-release-v5-4-b168713fab33@gmail.com>
References: <20241021-iio-read-avail-release-v5-0-b168713fab33@gmail.com>
In-Reply-To: <20241021-iio-read-avail-release-v5-0-b168713fab33@gmail.com>
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


