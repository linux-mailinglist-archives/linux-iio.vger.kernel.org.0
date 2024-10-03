Return-Path: <linux-iio+bounces-10077-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9D698F54D
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 19:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1C2B1C21C46
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 17:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434651AB6DA;
	Thu,  3 Oct 2024 17:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MxGq9tQh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7CC1AB53A;
	Thu,  3 Oct 2024 17:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727976889; cv=none; b=mdEKsJdCWlUSzZ5kKB9n26MVa7KJjGGF2seqv8EYVMnUq1GC7jXbyy0MzHVt8bOTJGtjwD4H9T00Lp17fmy371SenAL/6KNByASNssUU2PWVtbTcdUFDjdayV1a6b1G/xSL5VaA/ZPhbMxm25vPZnDq9Qb5o9A4PEif2vR1KngE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727976889; c=relaxed/simple;
	bh=2/hMSftv+3dvVX2Wa2Ap1k9j9lysmFSfimPuu4XRnro=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JPRrCQl2KtYA9iKlqINxbdf7MTnoKQWiOTzagBosNrhVbnAElCowcSQvZoUSlGbyQuCY3v3kLAE/tqtWZFWJcS0gvoWdtFcOvg1l5KK+eXXh9VzdsTxrZDuqgtXh9mhLFGItqDNIIskXbP4c2q4hY367l/e/RgI8rgMUxMp4Ayg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MxGq9tQh; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42cb5b3c57eso11706975e9.2;
        Thu, 03 Oct 2024 10:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727976886; x=1728581686; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MTXdcjBlauvr7yxzI4HI4Dpu0RqCMP0lDL0VjxoSP1k=;
        b=MxGq9tQhXI+DrfmUcZVXhtSBWJY5fQgH8UBmUV7kPegnQcMRisLJIm/LZnj5t4WZB4
         Xsrt+DLlfj6QkIXsACokxLLsVV2qlGO2NvKxHE1YaycS8MECBNeWOXLkyZLOcm5aY6Zt
         RbXVBeh87df6rhWZXglzoj+hs2EmZE8lZSTD1YdHKezrxnLqcXECWB3HG+VU+MAoSSGV
         YSSO3leL+si09yagwyXtZT1RYppI1uPCXmCAZKkUx89wBdFGEQYfwHhQn9j3//mTuy/u
         Uo2u52CgMsZyc9c71PA9QgzNb+fZgTRrGLJEomaRXq9/3KnM/+3JQa5Ep8FHCqhahHVh
         8UfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727976886; x=1728581686;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MTXdcjBlauvr7yxzI4HI4Dpu0RqCMP0lDL0VjxoSP1k=;
        b=ktjr0zDj2d/GhpZ/aiOZHedi0WeWM1kfVerVzprNE8bLWZWB9amNiIv8v3nyb/Ywy5
         B9C39p3iVUh0SBk+4CTWaT3O/NSWyO7Q0b3YwLd1nx63dHnPH3RL6+s+mkdNg9ALxvJJ
         KXG+SG6+HZj+4ofoOgHkL7YAqLYYf9L82UIcy98tBvFceEBTHi2ReuahH5/fpzsHJ1GD
         D6H3IJ8bxspi/NCETcQlbqfihr0pIwzCRbEBtUclv6pIgnRPturfBX7vEZU/KrneR6Mm
         vAA6FiXEoc2edH46xFpMLZGFCvheVjq/52TpBAyVg5jaH9lDU9Uj9MHxfZkF/lL4N1Nt
         jVVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqDLoxPAqgazf+LA+TahULT6Ns/dZvO8v4keJZMFJ+P4JgYha3j/v0sPL9zNl7QeGIAZ5Ggz5Fc/E=@vger.kernel.org, AJvYcCVLoEiLOaa5z7RWo+bp4aYFF8Pnxk4XSxStO6BkbTw628IhdJk2uLrBh55HMx2SumiD4Ire4APgPb+8E2k=@vger.kernel.org, AJvYcCXzZgLcPLmZ4JBPvHAl/gc4ZVZtVxZAYDhQcM766R9NxgTEZOvI16IYCzH8ztR3yRnyyPAK1vjcnrN71A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyIwMuPGsaeJnQqTos2wvKHpMDzZOJGWc6gf8x5t5I8Xg/bVnTF
	K7VcIJC32YxiFwsjEOa9KJn/011MFPWWqX/F/e+G1D1km1zqHfKw
X-Google-Smtp-Source: AGHT+IHn6LdeRuDWE8fHAt/wjcTUVQYdBz6//TPcMWsGZOuJa319SrxzZL9LhUsa2CXPwqGuJroUHA==
X-Received: by 2002:a05:600c:3b8a:b0:42c:b309:8d1a with SMTP id 5b1f17b1804b1-42f777bac51mr58068895e9.13.1727976885467;
        Thu, 03 Oct 2024 10:34:45 -0700 (PDT)
Received: from localhost (host-79-19-52-27.retail.telecomitalia.it. [79.19.52.27])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f8025b50bsm20382895e9.17.2024.10.03.10.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 10:34:43 -0700 (PDT)
From: Matteo Martelli <matteomartelli3@gmail.com>
Date: Thu, 03 Oct 2024 19:34:08 +0200
Subject: [PATCH 3/7] iio: ad7192: copy/release available filter frequencies
 to fix race
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241003-iio-read-avail-release-v1-3-c70cc7d9c2e0@gmail.com>
References: <20241003-iio-read-avail-release-v1-0-c70cc7d9c2e0@gmail.com>
In-Reply-To: <20241003-iio-read-avail-release-v1-0-c70cc7d9c2e0@gmail.com>
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


