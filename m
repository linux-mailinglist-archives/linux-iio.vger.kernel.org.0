Return-Path: <linux-iio+bounces-9980-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 485BD98C6C2
	for <lists+linux-iio@lfdr.de>; Tue,  1 Oct 2024 22:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 626971C2253A
	for <lists+linux-iio@lfdr.de>; Tue,  1 Oct 2024 20:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 112261CF5C1;
	Tue,  1 Oct 2024 20:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XZRlexeV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171541CF2BB;
	Tue,  1 Oct 2024 20:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727814118; cv=none; b=F34j3DNQEUQX4TuwGrO+dG0WSjY9/qSSziQqz3YiWxatMPD8l69BeYkkSpUFzts+cPcHf35FCV1JEiD1noZnkIbZLQyyzf6SB34bk7bHpsDmM6l7dP89yg2KP4XHyfuRGXbalWPiAvlmPb+sEFn7CWcM0mPRSeoYyIIHDEYiq7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727814118; c=relaxed/simple;
	bh=D2F2Y4S1DywiDWYkW1F7OG7AQaV3uviqxsquxVHQ4XY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u630IIaKKLWpg+0xM/r+/D3ssEG+66U3FHMD+Nb0Dz2effvmbKN5YnJlffBz5+U6us8A00Ovp5H3s02M2VCZChIlnHrRrWTfCBzoWe/KGAQkjuAhTuwCvKmi0f/WP1xt/D7vGZe092hICu0ydguW0hACrE6aGBOhDhNZxUcIojY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XZRlexeV; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42cb0f28bfbso46677625e9.1;
        Tue, 01 Oct 2024 13:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727814115; x=1728418915; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6LLIfUoLjCg8+1pCkoboZ6/Lt3e71o0HRH+OVBICLC8=;
        b=XZRlexeVkAP7miiUHx0e7znbvz5UM3TZzT4jtEfV7XS3PqmSh+d3IQW8wU3plAkIeG
         /owQulqfsBbxb1PCNoRoOCVj431QuvO8NUEd/r2DwLT4qHEpjFmq+Zl3ysPj6LUZy3kK
         Evmaoxfn7Kr2AT7xPr/gQubuG3YWM1lQ6qmo7IyUjd/P2/JnwrBCPMzdqBhThJnUyQQC
         y0ndLZp8f1iYDHf9ThzyJ9qDB7plZnLtuWvjsPeh4Xo/JIYjoiYHNTLb8AwPn1KxXxty
         zDBCNZTiIJ+gWpKWF2i04zftdAV7MhcOAAnv83umpBnECboMrngRG4BjaMH0y7KESlZB
         n9fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727814115; x=1728418915;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6LLIfUoLjCg8+1pCkoboZ6/Lt3e71o0HRH+OVBICLC8=;
        b=XfJHDOVljTtnXC1jDATB5lwAbgH0PvUWbZaUpA185lIjBjXJyGs7F3fs2XPxXb/lnO
         ujcntrTP+U0CjAQEh/IuJonRv1TkEW/y+2ismqd2Opq3vbwFyPEDmpUsASFKQ6PjVNJ2
         Pwd9mWMblJNSnH1ue26fMf8djo068WFP7M/1fi0lf1A6LTKHYgJRVcp/CkBRRd2jrffE
         Kcw1VLUjbF9TIV1a5I2NTkMwFTh6z9hyGyRYtKL9XxmtwVolRRYCjThDo7pkce1KG+in
         E+6nZHOokqCsyjGdjKrCmkOKIxA0eik66+tPFGq4HaGSCo0SK/m2tSAidC1YWt9jP3rA
         pBLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIjDwAm7xjUJlZZYibdHQEJ7gGTUTONJg0QxT5xRW/yfqcByHMdxtDqo/NyPJIuJHAeD26QQ8zPEtz@vger.kernel.org, AJvYcCXTOmSIK2RI6ui2CSlZpbdlyrLEYQLbtQNWSC8GBXTB81fpIA4oDEqcqD7RoDBnf5JURGIPhQxZZHvoN++h@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4pqpmqBhW13DgEPZk9UIQkX58NC9LJ2X2NETMI87PkuQB19dn
	sge7UaQrLaBLx8EvAk4Vu9UyDJgyaeIeebVOyCtGVAltyhX7EL/YTANxIFCt
X-Google-Smtp-Source: AGHT+IGQEk5Zw6aF/QNo3iK9HBDsJ5FFF60+RPQzz3216JAyqycMw0wnPz6q/NeG7tqmLQMvQ+y9CA==
X-Received: by 2002:a05:600c:5254:b0:42c:de9b:a1b5 with SMTP id 5b1f17b1804b1-42f778f37cfmr4326925e9.32.1727814114989;
        Tue, 01 Oct 2024 13:21:54 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-41f4-a392-01d5-d74d.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:41f4:a392:1d5:d74d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e96a55336sm188680935e9.47.2024.10.01.13.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 13:21:52 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Tue, 01 Oct 2024 22:21:18 +0200
Subject: [PATCH v3 5/9] iio: light: veml6030: use read_avail() for
 available attributes
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241001-veml6035-v3-5-d789f6ff147c@gmail.com>
References: <20241001-veml6035-v3-0-d789f6ff147c@gmail.com>
In-Reply-To: <20241001-veml6035-v3-0-d789f6ff147c@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Rishi Gupta <gupt21@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727814089; l=5305;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=D2F2Y4S1DywiDWYkW1F7OG7AQaV3uviqxsquxVHQ4XY=;
 b=hXJKqdrjgIAaCIRAJUQ+NpEd12SdHlxmxgpvGFxly7Hh88Uts36QbU4LofS/D/YRgvWl14RfX
 yqW0f8ET+LGCEcDRkXmiO/o34QukAozPI7QSwXSJpoFPaxHempjIifB
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

Drop custom attributes by using the standard read_avail() callback to
read scale and integration time. When at it, add the integration time
and scale attributes fro the WHITE channel, as they modify its value as
well. To avoid breaking the current ABI, these attributes must be kept
as separate for both channels even though they are shared under the
hood.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/light/veml6030.c | 82 +++++++++++++++++++++++++-------------------
 1 file changed, 47 insertions(+), 35 deletions(-)

diff --git a/drivers/iio/light/veml6030.c b/drivers/iio/light/veml6030.c
index 72c1988e48e6..fe6d2f9a2e01 100644
--- a/drivers/iio/light/veml6030.c
+++ b/drivers/iio/light/veml6030.c
@@ -58,25 +58,24 @@ struct veml6030_data {
 	int cur_integration_time;
 };
 
-/* Integration time available in seconds */
-static IIO_CONST_ATTR(in_illuminance_integration_time_available,
-				"0.025 0.05 0.1 0.2 0.4 0.8");
+static const int veml6030_it_times[][2] = {
+	{ 0, 25000 },
+	{ 0, 50000 },
+	{ 0, 100000 },
+	{ 0, 200000 },
+	{ 0, 400000 },
+	{ 0, 800000 },
+};
 
 /*
  * Scale is 1/gain. Value 0.125 is ALS gain x (1/8), 0.25 is
  * ALS gain x (1/4), 1.0 = ALS gain x 1 and 2.0 is ALS gain x 2.
  */
-static IIO_CONST_ATTR(in_illuminance_scale_available,
-				"0.125 0.25 1.0 2.0");
-
-static struct attribute *veml6030_attributes[] = {
-	&iio_const_attr_in_illuminance_integration_time_available.dev_attr.attr,
-	&iio_const_attr_in_illuminance_scale_available.dev_attr.attr,
-	NULL
-};
-
-static const struct attribute_group veml6030_attr_group = {
-	.attrs = veml6030_attributes,
+static const int veml6030_scale_vals[][2] = {
+	{ 0, 125000 },
+	{ 0, 250000 },
+	{ 1, 0 },
+	{ 2, 0 },
 };
 
 /*
@@ -200,6 +199,8 @@ static const struct iio_chan_spec veml6030_channels[] = {
 				BIT(IIO_CHAN_INFO_PROCESSED) |
 				BIT(IIO_CHAN_INFO_INT_TIME) |
 				BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME) |
+						     BIT(IIO_CHAN_INFO_SCALE),
 		.event_spec = veml6030_event_spec,
 		.num_event_specs = ARRAY_SIZE(veml6030_event_spec),
 	},
@@ -209,7 +210,11 @@ static const struct iio_chan_spec veml6030_channels[] = {
 		.modified = 1,
 		.channel2 = IIO_MOD_LIGHT_BOTH,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
-				BIT(IIO_CHAN_INFO_PROCESSED),
+				BIT(IIO_CHAN_INFO_PROCESSED) |
+				BIT(IIO_CHAN_INFO_INT_TIME) |
+				BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME) |
+						     BIT(IIO_CHAN_INFO_SCALE),
 	},
 };
 
@@ -555,37 +560,44 @@ static int veml6030_read_raw(struct iio_dev *indio_dev,
 			return -EINVAL;
 		}
 	case IIO_CHAN_INFO_INT_TIME:
-		if (chan->type == IIO_LIGHT)
-			return veml6030_get_intgrn_tm(indio_dev, val, val2);
-		return -EINVAL;
+		return veml6030_get_intgrn_tm(indio_dev, val, val2);
 	case IIO_CHAN_INFO_SCALE:
-		if (chan->type == IIO_LIGHT)
-			return veml6030_get_als_gain(indio_dev, val, val2);
-		return -EINVAL;
+		return veml6030_get_als_gain(indio_dev, val, val2);
 	default:
 		return -EINVAL;
 	}
 }
 
+static int veml6030_read_avail(struct iio_dev *indio_dev,
+			       struct iio_chan_spec const *chan,
+			       const int **vals, int *type, int *length,
+			       long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_INT_TIME:
+		*vals = (int *)&veml6030_it_times;
+		*length = 2 * ARRAY_SIZE(veml6030_it_times);
+		*type = IIO_VAL_INT_PLUS_MICRO;
+		return IIO_AVAIL_LIST;
+	case IIO_CHAN_INFO_SCALE:
+		*vals = (int *)&veml6030_scale_vals;
+		*length = 2 * ARRAY_SIZE(veml6030_scale_vals);
+		*type = IIO_VAL_INT_PLUS_MICRO;
+		return IIO_AVAIL_LIST;
+	}
+
+	return -EINVAL;
+}
+
 static int veml6030_write_raw(struct iio_dev *indio_dev,
 				struct iio_chan_spec const *chan,
 				int val, int val2, long mask)
 {
 	switch (mask) {
 	case IIO_CHAN_INFO_INT_TIME:
-		switch (chan->type) {
-		case IIO_LIGHT:
-			return veml6030_set_intgrn_tm(indio_dev, val, val2);
-		default:
-			return -EINVAL;
-		}
+		return veml6030_set_intgrn_tm(indio_dev, val, val2);
 	case IIO_CHAN_INFO_SCALE:
-		switch (chan->type) {
-		case IIO_LIGHT:
-			return veml6030_set_als_gain(indio_dev, val, val2);
-		default:
-			return -EINVAL;
-		}
+		return veml6030_set_als_gain(indio_dev, val, val2);
 	default:
 		return -EINVAL;
 	}
@@ -684,19 +696,19 @@ static int veml6030_write_interrupt_config(struct iio_dev *indio_dev,
 
 static const struct iio_info veml6030_info = {
 	.read_raw  = veml6030_read_raw,
+	.read_avail  = veml6030_read_avail,
 	.write_raw = veml6030_write_raw,
 	.read_event_value = veml6030_read_event_val,
 	.write_event_value	= veml6030_write_event_val,
 	.read_event_config = veml6030_read_interrupt_config,
 	.write_event_config	= veml6030_write_interrupt_config,
-	.attrs = &veml6030_attr_group,
 	.event_attrs = &veml6030_event_attr_group,
 };
 
 static const struct iio_info veml6030_info_no_irq = {
 	.read_raw  = veml6030_read_raw,
+	.read_avail  = veml6030_read_avail,
 	.write_raw = veml6030_write_raw,
-	.attrs = &veml6030_attr_group,
 };
 
 static irqreturn_t veml6030_event_handler(int irq, void *private)

-- 
2.43.0


