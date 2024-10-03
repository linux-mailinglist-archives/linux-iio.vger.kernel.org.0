Return-Path: <linux-iio+bounces-10076-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69CC598F548
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 19:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3C0E1F22620
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 17:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B721182A0;
	Thu,  3 Oct 2024 17:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IaRETnWh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9583C1AAE37;
	Thu,  3 Oct 2024 17:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727976886; cv=none; b=urChykO8Len1hvmyuUJBJAHHImbHBVbQu2njr/81XZikeQpdV1uOAISUa9BzZQA59oA4qVrgoshRfCdruEEXy7kqoPPRV9yJc9g1c+f3uPPEMrjTCFF8K+VlKpDWB4wg0+IXejk7khESTpM+7kUwEi9ApSsrfazzSYZfNYBgPyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727976886; c=relaxed/simple;
	bh=cNg176BYetOGo2MpF+NBbDgUNyJwivGqccecDk2ywTU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S6C0B0VvwqfBTdCJo6x1RbNJrntNy6KAJlEDrGe2DoHSTK5u12JFocXrmjaeb0ZA7gfGQiVe4ls4nQh6qjt71QzYDXP5TGYf+2YUmrTdI6McTG/1yCKnI/XjDw07aDjd50OFNgrn6QoebmTNibfKfa8a4yOFArHOvnvQn2FeS5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IaRETnWh; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42cd74c0d16so12261635e9.1;
        Thu, 03 Oct 2024 10:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727976883; x=1728581683; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gYEu7vJAEzzRAf4hNdfGGtBas1po8e0YLUji+g4IAZE=;
        b=IaRETnWh+BMUXZcCFdAbtwdPtgEBswwTEwqU/DMuGFywJNhRduJdEBmdIMFgceTICg
         iqDHC8M1UqfOf7uaJ5ZCZ++sYZkGEfzgOnQI3iV+Te7+pT4Z31MF3m6C3TjHUc7WFvTv
         lAvO1pRMGu5+rA7KqePfm0GZzF8V6Zd0dTu3mpYYXaBdPGre4uZ+L0m2/7bda0daSC71
         RfGXd4EU9Yi1kmvDzU3WVPxr5MVFyMyrkud4DC4N6LObZjq9PX1A75yniK/BFwcYGzJW
         srGXu8PuGGPji49dxopXMZi3zAfxWYkSSrun2mmC+IQg66ydsDCKJYPr3dlfmeqHba+l
         HufA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727976883; x=1728581683;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gYEu7vJAEzzRAf4hNdfGGtBas1po8e0YLUji+g4IAZE=;
        b=eBvYTXQJI88TDI4qgOzEV5+nR7CP2HnzPhwGPlzCp8vUaYwNxgU1e2kB+uS84RI6gJ
         j8u6FAuDCh5opBzHYmo4RCn0fQXVw4cShv+lrl8VautlHPOVD+ChCNJTB6PhdYdjLNDZ
         SnqPrGIsk/euY3G/v6qIWBONJcy7xwP+5Zs6AieARdZ+5g0mARsdFxric30o+lZCW8ig
         et0dPJB3fH0h2cqONxEheU9Y0kAjCzrSk5JT6/5UzEN+DQVooAq8WfW0Mc11Vp3EYcVy
         5XRMBKz5OHH8wpFTgIoia7gmwF+FiYYZY3gzPb+WXVWuORW0j+99bj1i9y+TpbKp7nTg
         UhKw==
X-Forwarded-Encrypted: i=1; AJvYcCUz39CMTNXxEfIFHBFbgKhegTklAF3oXGKiipvQRRnEVyvCCRclO6WS3yvi6swxLPjbCKf5erhCu+tSHQ==@vger.kernel.org, AJvYcCWtk6tbr+shKXGBuJgpO8ely0TcdEaKm7ZkJK1ztx0eK/JZGwYflPQGOin7ko6L51ChkDj/ykZBycI=@vger.kernel.org, AJvYcCXEQM5ODlbtpFJvpN5YzF2p0xuxqxQkbCBdvctz1jKB3Cqut8/YJT6F6apbjZnMxtjbR5PoXJ2PtuIlEls=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7HS3CdfJ2HUkZQfJH6jGpVp8yDSTbn/nKwQ+68/d4emWpdX1P
	9R/ouz/eMlPMXsmRPusnttxSAa3S/EFYw/aXJb+oED8oPWh+Q6tx
X-Google-Smtp-Source: AGHT+IHTPFOFNPN3BeckBHKcogONqJyh8WuQeJEfQQzsuoj40NUYhsA6Ja/Wd7KXoljDjmnGp5wiHA==
X-Received: by 2002:a05:600c:1551:b0:42c:ac9f:b528 with SMTP id 5b1f17b1804b1-42f778f5ba5mr51635555e9.35.1727976882600;
        Thu, 03 Oct 2024 10:34:42 -0700 (PDT)
Received: from localhost (host-79-19-52-27.retail.telecomitalia.it. [79.19.52.27])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f79c67c5csm50718505e9.0.2024.10.03.10.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 10:34:41 -0700 (PDT)
From: Matteo Martelli <matteomartelli3@gmail.com>
Date: Thu, 03 Oct 2024 19:34:07 +0200
Subject: [PATCH 2/7] iio: pac1921: use read_avail+release APIs instead of
 custom ext_info
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241003-iio-read-avail-release-v1-2-c70cc7d9c2e0@gmail.com>
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

The pac1921 driver was exposing the available scale info via an ad-hoc
ext_info attribute instead of using the read_avail API. This to avoid a
possible race condition: while the available current scales were being
printed to sysfs by iio core (iio_read_channel_info_avail), the shunt
resistor might have been changed concurrently.

Switch to the read_avail+release APIs now that the race condition has
been addressed.

Signed-off-by: Matteo Martelli <matteomartelli3@gmail.com>
---
 drivers/iio/adc/pac1921.c | 128 ++++++++++++++++------------------------------
 1 file changed, 45 insertions(+), 83 deletions(-)

diff --git a/drivers/iio/adc/pac1921.c b/drivers/iio/adc/pac1921.c
index 4c2a1c07bc399028f0334885fc9cd4552d5892b1..f491a4923380ef9b406a68f8cc413df873869e3e 100644
--- a/drivers/iio/adc/pac1921.c
+++ b/drivers/iio/adc/pac1921.c
@@ -445,11 +445,52 @@ static int pac1921_read_avail(struct iio_dev *indio_dev,
 		*vals = pac1921_int_num_samples;
 		*length = ARRAY_SIZE(pac1921_int_num_samples);
 		return IIO_AVAIL_LIST;
+	case IIO_CHAN_INFO_SCALE:
+		switch (chan->channel) {
+		case PAC1921_CHAN_VBUS:
+			*vals = (const int *)pac1921_vbus_scales;
+			*length = ARRAY_SIZE(pac1921_vbus_scales) * 2;
+			*type = IIO_VAL_INT_PLUS_NANO;
+			return IIO_AVAIL_LIST;
+
+		case PAC1921_CHAN_VSENSE:
+			*vals = (const int *)pac1921_vsense_scales;
+			*length = ARRAY_SIZE(pac1921_vsense_scales) * 2;
+			*type = IIO_VAL_INT_PLUS_NANO;
+			return IIO_AVAIL_LIST;
+
+		case PAC1921_CHAN_CURRENT: {
+			struct pac1921_priv *priv = iio_priv(indio_dev);
+
+			*length = ARRAY_SIZE(priv->current_scales) * 2;
+			*type = IIO_VAL_INT_PLUS_NANO;
+
+			guard(mutex)(&priv->lock);
+
+			*vals = kmemdup_array((int *)priv->current_scales,
+					      *length, sizeof(int), GFP_KERNEL);
+			if (!*vals)
+				return -ENOMEM;
+
+			return IIO_AVAIL_LIST;
+		}
+		default:
+			return -EINVAL;
+		}
 	default:
 		return -EINVAL;
 	}
 }
 
+static void pac1921_read_avail_release_res(struct iio_dev *indio_dev,
+					   struct iio_chan_spec const *chan,
+					   const int *vals, long mask)
+{
+	if (mask == IIO_CHAN_INFO_SCALE &&
+	    chan->channel == PAC1921_CHAN_CURRENT)
+		kfree(vals);
+}
+
 /*
  * Perform configuration update sequence: set the device into read state, then
  * write the config register and set the device back into integration state.
@@ -749,6 +790,7 @@ static int pac1921_read_event_value(struct iio_dev *indio_dev,
 static const struct iio_info pac1921_iio = {
 	.read_raw = pac1921_read_raw,
 	.read_avail = pac1921_read_avail,
+	.read_avail_release_resource = pac1921_read_avail_release_res,
 	.write_raw = pac1921_write_raw,
 	.write_raw_get_fmt = pac1921_write_raw_get_fmt,
 	.read_label = pac1921_read_label,
@@ -806,88 +848,7 @@ static ssize_t pac1921_write_shunt_resistor(struct iio_dev *indio_dev,
 	return len;
 }
 
-/*
- * Emit on sysfs the list of available scales contained in scales_tbl
- *
- * TODO:: this function can be replaced with iio_format_avail_list() if the
- * latter will ever be exported.
- *
- * Must be called with lock held if the scales_tbl can change runtime (e.g. for
- * the current scales table)
- */
-static ssize_t pac1921_format_scale_avail(const int (*const scales_tbl)[2],
-					  size_t size, char *buf)
-{
-	ssize_t len = 0;
-
-	for (unsigned int i = 0; i < size; i++) {
-		if (i != 0) {
-			len += sysfs_emit_at(buf, len, " ");
-			if (len >= PAGE_SIZE)
-				return -EFBIG;
-		}
-		len += sysfs_emit_at(buf, len, "%d.%09d", scales_tbl[i][0],
-				     scales_tbl[i][1]);
-		if (len >= PAGE_SIZE)
-			return -EFBIG;
-	}
-
-	len += sysfs_emit_at(buf, len, "\n");
-	return len;
-}
-
-/*
- * Read available scales for a specific channel
- *
- * NOTE: using extended info insted of iio.read_avail() because access to
- * current scales must be locked as they depend on shunt resistor which may
- * change runtime. Caller of iio.read_avail() would access the table unlocked
- * instead.
- */
-static ssize_t pac1921_read_scale_avail(struct iio_dev *indio_dev,
-					uintptr_t private,
-					const struct iio_chan_spec *chan,
-					char *buf)
-{
-	struct pac1921_priv *priv = iio_priv(indio_dev);
-	const int (*scales_tbl)[2];
-	size_t size;
-
-	switch (chan->channel) {
-	case PAC1921_CHAN_VBUS:
-		scales_tbl = pac1921_vbus_scales;
-		size = ARRAY_SIZE(pac1921_vbus_scales);
-		return pac1921_format_scale_avail(scales_tbl, size, buf);
-
-	case PAC1921_CHAN_VSENSE:
-		scales_tbl = pac1921_vsense_scales;
-		size = ARRAY_SIZE(pac1921_vsense_scales);
-		return pac1921_format_scale_avail(scales_tbl, size, buf);
-
-	case PAC1921_CHAN_CURRENT: {
-		guard(mutex)(&priv->lock);
-		scales_tbl = priv->current_scales;
-		size = ARRAY_SIZE(priv->current_scales);
-		return pac1921_format_scale_avail(scales_tbl, size, buf);
-	}
-	default:
-		return -EINVAL;
-	}
-}
-
-#define PAC1921_EXT_INFO_SCALE_AVAIL {					\
-	.name = "scale_available",					\
-	.read = pac1921_read_scale_avail,				\
-	.shared = IIO_SEPARATE,						\
-}
-
-static const struct iio_chan_spec_ext_info pac1921_ext_info_voltage[] = {
-	PAC1921_EXT_INFO_SCALE_AVAIL,
-	{}
-};
-
 static const struct iio_chan_spec_ext_info pac1921_ext_info_current[] = {
-	PAC1921_EXT_INFO_SCALE_AVAIL,
 	{
 		.name = "shunt_resistor",
 		.read = pac1921_read_shunt_resistor,
@@ -911,6 +872,7 @@ static const struct iio_chan_spec pac1921_channels[] = {
 		.type = IIO_VOLTAGE,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
 				      BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_separate_available = BIT(IIO_CHAN_INFO_SCALE),
 		.info_mask_shared_by_all =
 			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO) |
 			BIT(IIO_CHAN_INFO_SAMP_FREQ),
@@ -928,12 +890,12 @@ static const struct iio_chan_spec pac1921_channels[] = {
 		.indexed = 1,
 		.event_spec = pac1921_overflow_event,
 		.num_event_specs = ARRAY_SIZE(pac1921_overflow_event),
-		.ext_info = pac1921_ext_info_voltage,
 	},
 	{
 		.type = IIO_VOLTAGE,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
 				      BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_separate_available = BIT(IIO_CHAN_INFO_SCALE),
 		.info_mask_shared_by_all =
 			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO) |
 			BIT(IIO_CHAN_INFO_SAMP_FREQ),
@@ -951,12 +913,12 @@ static const struct iio_chan_spec pac1921_channels[] = {
 		.indexed = 1,
 		.event_spec = pac1921_overflow_event,
 		.num_event_specs = ARRAY_SIZE(pac1921_overflow_event),
-		.ext_info = pac1921_ext_info_voltage,
 	},
 	{
 		.type = IIO_CURRENT,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
 				      BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_separate_available = BIT(IIO_CHAN_INFO_SCALE),
 		.info_mask_shared_by_all =
 			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO) |
 			BIT(IIO_CHAN_INFO_SAMP_FREQ),

-- 
2.46.2


