Return-Path: <linux-iio+bounces-10266-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A748992723
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2024 10:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 181501F2107C
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2024 08:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748C918C02E;
	Mon,  7 Oct 2024 08:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aDGTSUeM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD7018BC1A;
	Mon,  7 Oct 2024 08:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728290284; cv=none; b=r4RfYt2itcsdTDB1tlTujaTuPPycHdGlNULFKOBo5BgBSCcL2u5K0t5vpZu+LJ3WiA5v0J41Sp1PzuHuc3VE0VaHkjLgzW4yrb2D9T/pN9vWn98aDlc7lJ4kyY5wE0bw2022KAwvw0gTumquIlUkK6xnCfOjZ7WpYZQDZx1rMLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728290284; c=relaxed/simple;
	bh=cNg176BYetOGo2MpF+NBbDgUNyJwivGqccecDk2ywTU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ov42G4VVlMkEhy93hc936yWsyDjzFzgL+ORu8ZLzPcCxuiHW78Cmwz3BhzNqtai0h1NlTDCfMz9ShfLSNfHRKVL2JLNC6oEl2wq/rP7zDacVNvDN+6DFbWymYhqVqkR98j+FXE5MUj36yJ4y5PQxTMRSfgzRH71DBnO04GR2j0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aDGTSUeM; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c718bb04a3so5823297a12.3;
        Mon, 07 Oct 2024 01:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728290281; x=1728895081; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gYEu7vJAEzzRAf4hNdfGGtBas1po8e0YLUji+g4IAZE=;
        b=aDGTSUeMYmxen5dnpZb+UNFGj46i1jYAt8Q8w36p3VKFydSph0Q0TpbPSgamvL9RL4
         22OB46LHvxDaWHxI+Oq5luWdon0rOHievZRQUhr0XfxzVRGLB0GMYhlwzSDdsQiudyZ9
         YQj92Z61BypPEfzRLoMR1cVsHUR3TBlFfx/v7mnSrDYLG/JLurm9d+LfUp4yTW6bdUJn
         WVyCwt04uraXZH/mUe+gb/+JOKo9fuLveIW+dzB0X2yZV51ABVca1Xg7pK3XCBjZJPvG
         VChJeeh5sjD5nD9MQEXroZioj9Nx8jE6sfGXAzlqDuGL1Mu0MgaFWUSCYA8lwYPLorux
         m7Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728290281; x=1728895081;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gYEu7vJAEzzRAf4hNdfGGtBas1po8e0YLUji+g4IAZE=;
        b=nc6/bEi+NSU4sVkDsoKfkPWwgvQjX/7+nLHPOZvvQxSI9YL1DoNK0mt6Hw2Fs793ZP
         1CTBqocZc6xZ6q+QbBKM2Jh/1P46roO/nlRsEj/Z8GY5imkfPynjNl538ku9uU+OWMe6
         GsS9gIb0npjB9bP+fzbfwUTEEAZuIhdTrB6/zOVt4bqjA2k3QKThGvXYaeBl8bWfd6Cm
         84wHUNSgoS8uLG3aE3x9iR/7YbIZUjFEz3yhWr2sHNvV0LsYudt0AWOQRIiYd8DmdGcr
         fSeF/fo5gL11F2fCw6CQTs2k9QZKCsWBlpue3qYUhOks8zWrRdSsom637B7wnXPb0PSP
         AHOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsIjPalc0fvDUlv6ns2LmxO3CUr1fVY51Ycz2y8PAT3HOs+G//ENjfPr+xhly5/7257vH/8oFpYB8zz7Q=@vger.kernel.org, AJvYcCVx0iS/6GTSuKBcaQ+Cm4xuN29Ls1uVQfQ4nbBvmp0t42Jl1Ylan9o02D4EjdsxagqFAfJEgBMmGNZgcA==@vger.kernel.org, AJvYcCW0u9umG/Ehpo7JgA9AQkR+08nlCvMlG7xaE0ju66JfffL6BHlNJwx+YnDcNbn2QbqBcheZsAGp4fw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi9Bj5At8aat4Efn1Di6yP826jKJ1MukaGr2a4aVT3ZFAraf1b
	6Uja3HmpIVQMehJ4h2wp5Y+ytUzI3aya5iTocTvBA2bSak3X7QKv
X-Google-Smtp-Source: AGHT+IEUmlMfRDe3veYeB4Xt1to9N5WazOnYhbrVmiLPifEvgtZ6WsZt65nVRvQalMjBfDO6SH7M5Q==
X-Received: by 2002:a05:6402:34d4:b0:5c5:b8bd:c873 with SMTP id 4fb4d7f45d1cf-5c8d2e3004emr7792145a12.16.1728290280460;
        Mon, 07 Oct 2024 01:38:00 -0700 (PDT)
Received: from localhost (host-79-19-52-27.retail.telecomitalia.it. [79.19.52.27])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c8e05a9297sm2917925a12.33.2024.10.07.01.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 01:38:00 -0700 (PDT)
From: Matteo Martelli <matteomartelli3@gmail.com>
Date: Mon, 07 Oct 2024 10:37:11 +0200
Subject: [PATCH v2 2/7] iio: pac1921: use read_avail+release APIs instead
 of custom ext_info
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241007-iio-read-avail-release-v2-2-245002d5869e@gmail.com>
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


