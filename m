Return-Path: <linux-iio+bounces-10617-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E612099E515
	for <lists+linux-iio@lfdr.de>; Tue, 15 Oct 2024 13:07:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90F761F241F3
	for <lists+linux-iio@lfdr.de>; Tue, 15 Oct 2024 11:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C451EBFF1;
	Tue, 15 Oct 2024 11:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZdvpNqlX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6674A1EABB3;
	Tue, 15 Oct 2024 11:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728990416; cv=none; b=eoZ7UK622Rwd4HY571SXGi0PhxBaJY+kg04D/uubaxG8AU/JrDZ8JTV6ft2G2zcozrUWg32wTPW2UrzTdzCsRm0WQmgqq+MIuJWj0k+HkVceVnBwg2M43sMxUeMGHhSIi9nc7GaOMAIUSNLdfJ/rOKAc627jcZsCagS1J2XiehM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728990416; c=relaxed/simple;
	bh=lLwcWxwjDNJi83wrQWAVlHlVnJucfvYmyQRif2fP9tA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LwyqShea14UTcXC0Il3baxpxniUP5c6RaNWcODR29MNgVcOcw1Ey22flayfyzV/qn3V/n6JliSrm/ALCl2PO/yrKQbzoebYqm90uQZ9V+2tevxToVTLwl+5LIlAbWprQkMi/2wvSmZHseX4AZF45g8Xxi7xu93HRnpqN0UoZtiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZdvpNqlX; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37d325beee2so3185121f8f.2;
        Tue, 15 Oct 2024 04:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728990412; x=1729595212; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rwzowURA7LrdNAtuervNEFmMl54ysOzLP8Fuq/kRIC8=;
        b=ZdvpNqlXSpIQeqpRSbFlqd3CR6MDoc2Fr3TXLSzAhsxh8JvMJ19lvKNnJhCyyV6qqw
         TZfCiYG9zz8++mH3Re1Wv1VmugVeRclsu2BJ6/N6e9H9cig59To5kxFTj3cZsI5nBym3
         gncgtyJyZgJT6vc1NYx6ozvFT0djw70qZ+JBbPU9eUb+Jma/dfyjPs71Wj5/ncMsVT23
         y96nFhOOujSLviZFOz+2LhSXsbvg8WbXHMNrKMi6m0q3jsw3Tx1SULDxTzQEs/Rs+og1
         bnwJnPBUZgyznl6zuuRnZEdm0zOlydcb/7QXF6d+l1pvp6qJ9Jq53U+9K9lzxL1XZHWT
         +WAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728990412; x=1729595212;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rwzowURA7LrdNAtuervNEFmMl54ysOzLP8Fuq/kRIC8=;
        b=FmdGUBf20yhC1m7CCyRYe/fRoov05KFCcPiFJKmabaX+qHkeL5vJKx+zIJGyEn2j/U
         ixpPCb2UpLNGqzBt7gxCrfSgMww1JfYJ7hKphw06e6HIYspuYdAtUTPUgPAS26nGbRGv
         P5xlutxwiRskm4Tz7Suz8UEiPtMYlnRNL4ml5Nf9I5tRpLm470dgJZgV3/tmFDxb4eZp
         8E5PojAWqLwggMd8u2TWRyciOTxI04tzHGT+IuOvujg3MsGFWamxrpW+6J0cHq8Nb7nt
         InThrv0iVN0sgxfMhp9KcAK2fTgsbsxeCnHyK7/MfF7goG7QaMwdb+etUO7uVd5P/sWC
         jvCA==
X-Forwarded-Encrypted: i=1; AJvYcCUQnerg60fS3MgLPLV2cGbsl2C5SZEID67Ix/UUS8FtBTqxg2hP5dqreFEgMXw7ZLlST3Js6P5m4Lg=@vger.kernel.org, AJvYcCWjeFE57ji1FTUlBu9ukLntLI7dsQ7n7zlk9O2uhC7FKY7+0U7XQQ9kXT4AiMcTpvPaiX2meUc+TIDGIQ==@vger.kernel.org, AJvYcCXiigWTQMaAyZMdnD1MS6rlK4Y8QoCs51RArYXcYxCv6I2zAUMrlWcKGtq2oBOB6KsekZVVV517MJZgH5M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5KXmwPzZO8xFIpwYDX8z6cDWl8QOVP3oYA3+5t8OFt1DU1X5c
	IVvGLskEvSwh0CqEkp2WY4FrxASwykQfz1vhEfcky1ZgbXjiXYU1
X-Google-Smtp-Source: AGHT+IGimy5Up107eFlhSpVKC0Sm2j66ke58pEfclfBPpXVKCcjVZOm35BOwZtCXFrioz6OjXfgVNA==
X-Received: by 2002:adf:ec92:0:b0:37d:4dcc:7fb4 with SMTP id ffacd0b85a97d-37d5fec8d04mr7811001f8f.10.1728990412396;
        Tue, 15 Oct 2024 04:06:52 -0700 (PDT)
Received: from localhost (host-79-18-120-72.retail.telecomitalia.it. [79.18.120.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fa7a118sm1304744f8f.4.2024.10.15.04.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 04:06:52 -0700 (PDT)
From: Matteo Martelli <matteomartelli3@gmail.com>
Date: Tue, 15 Oct 2024 13:06:37 +0200
Subject: [PATCH v3 4/5] iio: ad7192: copy/release available filter
 frequencies to fix race
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241015-iio-read-avail-release-v3-4-ac3e08f25cb3@gmail.com>
References: <20241015-iio-read-avail-release-v3-0-ac3e08f25cb3@gmail.com>
In-Reply-To: <20241015-iio-read-avail-release-v3-0-ac3e08f25cb3@gmail.com>
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


