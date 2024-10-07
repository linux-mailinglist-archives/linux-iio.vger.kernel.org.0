Return-Path: <linux-iio+bounces-10267-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD08992729
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2024 10:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61F701C2233C
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2024 08:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC6718C34D;
	Mon,  7 Oct 2024 08:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DHq2kuUU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37C018C010;
	Mon,  7 Oct 2024 08:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728290285; cv=none; b=t1QFe1AgUVvQDSJbhy61HO8W+0il8JCjne7HsS8mljZmHw2pZAYuvr9w/hduJufvhm4KuA0Fua6wldO+nMAl+zUE27MtnYzwyw0Joet6a2DdK1GhYNejEppS/L2+HTWLBG/CbxqHkNvuBROJQ8K477+YVKczKSAzldhstIAH/1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728290285; c=relaxed/simple;
	bh=2/hMSftv+3dvVX2Wa2Ap1k9j9lysmFSfimPuu4XRnro=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AflMu8lrq97c5kKRORIEr9OWMAZGs1eWZ73J60vyrw00MMlERGhnF3XxLmk2bJ/pfy9+Ckt3ftqM1hPEza6ByGPWtC4LQDsFzFbOx/Uwu44IpUmKCcdXsOc1eH/2S13pn05YL+N0frcB0aNen6iIsZL9prYnDLqX7sFwx+dM2+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DHq2kuUU; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a995ec65c35so44586966b.1;
        Mon, 07 Oct 2024 01:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728290282; x=1728895082; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MTXdcjBlauvr7yxzI4HI4Dpu0RqCMP0lDL0VjxoSP1k=;
        b=DHq2kuUUV3BZFac8NoBYfwmYd42aEAswQeUbhvEMGmfV5TSt7UIRWFeu8ZzH+wEjuD
         qD+SGuaoh4+s3ML9r0LB5sY0p68KChRy7jf/AQWk12yYdQJcW9w7xWs8K4zmLCHh1dSI
         8Ne43nc/IyXLk53VvQXIYW41Zlq9HhCMoXhsLNHROs1OjTPBUWUTxPuaN/ex9Vrb/6HZ
         MLAkrLy7jQyehRShYXzhmal3oUyUp5xN2fho5gW04o0K7CZlg7q8IMsErEVx5PVQqcl6
         PTIWCYSIhnHJlb9IVX5sct8CrOpnpTGjXs4QMTf87CSaf93x/GSoES+PzLD4XGbwcNWo
         0FaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728290282; x=1728895082;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MTXdcjBlauvr7yxzI4HI4Dpu0RqCMP0lDL0VjxoSP1k=;
        b=FtqDoA7UIkYaQ9BE5xqTur7AeetFWXIDN4ew/XyHila2Nmr7uMat1rqNMLIHcy22Jc
         iai0XeTxffsJAnMTAmfZTS1pE0BsqAhFaBS4NeJLJcQfAwvtDmwri0vPS82MefQVtmcq
         4q+Ir/1QShzPCRRC7OLfRvoWXQd8CoXaGCWwaDfrwf/B0wDxk2NVcj0hbE/V2T0gDlRM
         b4sg9dqyQXdHEp5r63+C86uWf2xuINTGBkACifDoFp/ebnLdiJUiJNtb37Qw9NN7DrbX
         Ebl9TmOYVdYwX1RW6XMffhFKWeULMvbJVZvkxO1BGnr0QLhKGW5Tg375CuHmoVes0LkE
         +xgA==
X-Forwarded-Encrypted: i=1; AJvYcCU1OBRG6yM1SffIe2kslSo9+jmwRjT1kaUYeiL0ioiVYsudhsQdCJI+ChRlVSQLfEPgcHRKkdj/dYc=@vger.kernel.org, AJvYcCUrYlAuBR9SCRjyIZSGz12kEZa4xTCWhIeGhoh9x+MYtLS8lmggQq3Iv9O4MPz7fHcfA+53sq37/LhzMzU=@vger.kernel.org, AJvYcCV9wXJqz0UWZTLLU6wjm6uIQrrvDBesCzXWcuJhyDDhahUeQqLbfSqqjE6CDB2z/y44gd+7er02YmVHYg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyIHJzOJJZlaBi/JeNkRFsN1PWzZr+A8usu2LrcluxEiBIg7Gbk
	hYKHNlUVPAyuryxx1NVKvaBk3ZFqKlnYy703vN3j8JMpFNZ3jtRq
X-Google-Smtp-Source: AGHT+IELlVxbtYI0i+pPyXAVWrLkI+Xdhk8y8wiB6riSCOvuDysWcJUQjy87E4cTcQRY6Whlrv7dqA==
X-Received: by 2002:a17:907:7e92:b0:a99:4c71:704 with SMTP id a640c23a62f3a-a994c7108famr517619166b.26.1728290281692;
        Mon, 07 Oct 2024 01:38:01 -0700 (PDT)
Received: from localhost (host-79-19-52-27.retail.telecomitalia.it. [79.19.52.27])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99420bcc1esm261387766b.199.2024.10.07.01.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 01:38:01 -0700 (PDT)
From: Matteo Martelli <matteomartelli3@gmail.com>
Date: Mon, 07 Oct 2024 10:37:12 +0200
Subject: [PATCH v2 3/7] iio: ad7192: copy/release available filter
 frequencies to fix race
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241007-iio-read-avail-release-v2-3-245002d5869e@gmail.com>
References: <20241007-iio-read-avail-release-v2-0-245002d5869e@gmail.com>
In-Reply-To: <20241007-iio-read-avail-release-v2-0-245002d5869e@gmail.com>
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
2.46.2


