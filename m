Return-Path: <linux-iio+bounces-10285-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD537993104
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2024 17:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C8531F20F52
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2024 15:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BDB01D2F78;
	Mon,  7 Oct 2024 15:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eTQ7uTkU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793A71D86DC;
	Mon,  7 Oct 2024 15:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728314559; cv=none; b=IVcM3sW6WGHtKViHhlX8+eyGMYC14CsYv9m1sB4Z1ojqdiUNZsZga/8217u3W7daSIM911Rmj9uUFcPmvfyKoQv1HegLacWlAbEw4r2eza13kbateVRpUNYaxc6ruOefXMYPqJiPcrbWCOhLQc1TjBlSwmI2zrXrUKq07Hfpx0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728314559; c=relaxed/simple;
	bh=T+QYja7LUJzkV7RCgdEgVqVceSPVINzxqOOsbiHlAtM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RKG9Fscqlb9lh1+gVbtszCRNi8HopT5gdXpPq1OT45FeGYTZKKZJAJXShlpXtMRCMjtk0kWcpApl7zQJPGGKH8rOm8eHMcwUfajDobc0w+W034KAvc2NHVGJZ505vGvB/E/pNDLnv/FVlos51EeS2tcGL21MnBKZS52bHxXj8go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eTQ7uTkU; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7e6ed072cdaso2773301a12.0;
        Mon, 07 Oct 2024 08:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728314557; x=1728919357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yUspM/VMPEO1Kn2QXTO9UIPl/J9+OPnNBwBdWZtkysA=;
        b=eTQ7uTkUoyAb9kodJrJUyR3J6l58/8eLICEzEeN0BLYADx5jfQ2iXrIl7Cib5IniC5
         vY8V9DVYqiAasLCNsDTFW+5UXIjuG6TBFVwa3CwVYgNkqR3WaGiUi5+AVghMQ9QJWLv4
         l2zsq9Vs1QFFlmEIWsqcohbpfcqpymU6AtJb5ASmcoiycFUusKMufOqfaGyuoouRyrCK
         UrwieCP8ahFSY/rCB8hw3+e2XlBWHmBLo4GOutMxWxAu8r1qIBRAus2ebj2m1HcnYqRh
         j+eywaxDAG9BB9Xo1ABFYdKOPpiKOT54XEQpKLPnQP3NYWF2kMAGc9rHOpyqzmthX7Sl
         kYsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728314557; x=1728919357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yUspM/VMPEO1Kn2QXTO9UIPl/J9+OPnNBwBdWZtkysA=;
        b=JTHqvmkpZlmTpMGh1GfK14kWt1yoITeZXkc2ZJ/l5I2g141lYwXZ1K8Js409k7MErV
         DgUvCcjQBG/4sgs8pg0bIIpZ6eU/6g0rS9AheoNMjOvOeipbJoiQcssZ/0aSN/uE0Uu9
         sm+KKvo80ll4KbX3rtFN5GivxNtsqCMSELunV1BRRzS9hfmBi+lfbfG2Bck2RqnGaLUu
         h2tqvNln/9M+HxCAVc4vetRnPBOB/HRCn0fjSiL4UC3vnXnn8KtLPF6zv6TMdoGsNFcg
         8cBf7wTnV+496cTcaaENLm1vfrj/DJ1RuWcruDawMTS77qcic99FB4M+nypACvT3sZ/V
         fpnA==
X-Forwarded-Encrypted: i=1; AJvYcCW7johFox95zu2xIj+OfOnWdLmOBicNFpBvhsA/meLSjhTDqf21vy8rMkVsAvTCjkjLaJJax0nNVV9o8iE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTE1p7YFlI/6/eX3BvH7+LCsC+PEID3NEfjrsZi7NgIAon6gda
	XFnKlfAFHuC96+VV3Vs3wsPjKqCuWKnBlJElRa3x3fz/v5/pW8uSqoMWUJlmwME=
X-Google-Smtp-Source: AGHT+IEo33uhP8Qe+gkII6XmDg9VWsgUkTeBSKRjSDsxhzvkAU617wQwO8pfQSWqTxffdaE06eaDeA==
X-Received: by 2002:a17:90a:983:b0:2d3:caeb:a9ad with SMTP id 98e67ed59e1d1-2e1e6321935mr14441440a91.31.1728314556959;
        Mon, 07 Oct 2024 08:22:36 -0700 (PDT)
Received: from abhash-IdeaPad-L340-15IRH-Gaming.. ([136.233.9.100])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2e20ae7169esm5573934a91.10.2024.10.07.08.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 08:22:36 -0700 (PDT)
From: Abhash Jha <abhashkumarjha123@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	lars@metafoo.de,
	linux-kernel@vger.kernel.org,
	Abhash Jha <abhashkumarjha123@gmail.com>
Subject: [PATCH v3 1/3] iio: light: vl6180: Add configurable inter-measurement period support
Date: Mon,  7 Oct 2024 20:52:21 +0530
Message-ID: <20241007152223.59008-2-abhashkumarjha123@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241007152223.59008-1-abhashkumarjha123@gmail.com>
References: <20241007152223.59008-1-abhashkumarjha123@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Expose the IIO_CHAN_INFO_SAMP_FREQ attribute as a way to configure the
inter-measurement period for both the IIO_DISTANCE and IIO_LIGHT
channels. The inter-measurement period must be given in milihertz.

Signed-off-by: Abhash Jha <abhashkumarjha123@gmail.com>
---
 drivers/iio/light/vl6180.c | 70 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 68 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/vl6180.c b/drivers/iio/light/vl6180.c
index a1b2b3c0b..67aa2f101 100644
--- a/drivers/iio/light/vl6180.c
+++ b/drivers/iio/light/vl6180.c
@@ -38,7 +38,9 @@
 #define VL6180_OUT_OF_RESET 0x016
 #define VL6180_HOLD 0x017
 #define VL6180_RANGE_START 0x018
+#define VL6180_RANGE_INTER_MEAS_TIME 0x01b
 #define VL6180_ALS_START 0x038
+#define VL6180_ALS_INTER_MEAS_TIME 0x03e
 #define VL6180_ALS_GAIN 0x03f
 #define VL6180_ALS_IT 0x040
 
@@ -86,6 +88,8 @@ struct vl6180_data {
 	struct mutex lock;
 	unsigned int als_gain_milli;
 	unsigned int als_it_ms;
+	unsigned int als_meas_rate;
+	unsigned int range_meas_rate;
 };
 
 enum { VL6180_ALS, VL6180_RANGE, VL6180_PROX };
@@ -261,12 +265,14 @@ static const struct iio_chan_spec vl6180_channels[] = {
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
 			BIT(IIO_CHAN_INFO_INT_TIME) |
 			BIT(IIO_CHAN_INFO_SCALE) |
-			BIT(IIO_CHAN_INFO_HARDWAREGAIN),
+			BIT(IIO_CHAN_INFO_HARDWAREGAIN) |
+			BIT(IIO_CHAN_INFO_SAMP_FREQ),
 	}, {
 		.type = IIO_DISTANCE,
 		.address = VL6180_RANGE,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
-			BIT(IIO_CHAN_INFO_SCALE),
+			BIT(IIO_CHAN_INFO_SCALE) |
+			BIT(IIO_CHAN_INFO_SAMP_FREQ),
 	}, {
 		.type = IIO_PROXIMITY,
 		.address = VL6180_PROX,
@@ -333,6 +339,18 @@ static int vl6180_read_raw(struct iio_dev *indio_dev,
 
 		return IIO_VAL_FRACTIONAL;
 
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		switch (chan->type) {
+		case IIO_DISTANCE:
+			*val = data->range_meas_rate;
+			return IIO_VAL_INT;
+		case IIO_LIGHT:
+			*val = data->als_meas_rate;
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
+
 	default:
 		return -EINVAL;
 	}
@@ -412,11 +430,23 @@ static int vl6180_set_it(struct vl6180_data *data, int val, int val2)
 	return ret;
 }
 
+static int vl6180_meas_reg_val_from_mhz(unsigned int mhz)
+{
+	unsigned int period = DIV_ROUND_CLOSEST(1000 * 1000, mhz);
+	unsigned int reg_val = 0;
+
+	if (period > 10)
+		reg_val = period < 2550 ? (DIV_ROUND_CLOSEST(period, 10) - 1) : 254;
+
+	return reg_val;
+}
+
 static int vl6180_write_raw(struct iio_dev *indio_dev,
 			     struct iio_chan_spec const *chan,
 			     int val, int val2, long mask)
 {
 	struct vl6180_data *data = iio_priv(indio_dev);
+	unsigned int reg_val;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_INT_TIME:
@@ -427,6 +457,28 @@ static int vl6180_write_raw(struct iio_dev *indio_dev,
 			return -EINVAL;
 
 		return vl6180_set_als_gain(data, val, val2);
+
+	case IIO_CHAN_INFO_SAMP_FREQ:
+	{
+		guard(mutex)(&data->lock);
+		switch (chan->type) {
+		case IIO_DISTANCE:
+			data->range_meas_rate = val;
+			reg_val = vl6180_meas_reg_val_from_mhz(val);
+			return vl6180_write_byte(data->client,
+				VL6180_RANGE_INTER_MEAS_TIME, reg_val);
+
+		case IIO_LIGHT:
+			data->als_meas_rate = val;
+			reg_val = vl6180_meas_reg_val_from_mhz(val);
+			return vl6180_write_byte(data->client,
+				VL6180_ALS_INTER_MEAS_TIME, reg_val);
+
+		default:
+			return -EINVAL;
+		}
+	}
+
 	default:
 		return -EINVAL;
 	}
@@ -473,6 +525,20 @@ static int vl6180_init(struct vl6180_data *data)
 	if (ret < 0)
 		return ret;
 
+	/* Default Range inter-measurement time: 50ms or 20000 mHz */
+	ret = vl6180_write_byte(client, VL6180_RANGE_INTER_MEAS_TIME,
+				vl6180_meas_reg_val_from_mhz(20000));
+	if (ret < 0)
+		return ret;
+	data->range_meas_rate = 20000;
+
+	/* Default ALS inter-measurement time: 10ms or 100000 mHz */
+	ret = vl6180_write_byte(client, VL6180_ALS_INTER_MEAS_TIME,
+				vl6180_meas_reg_val_from_mhz(100000));
+	if (ret < 0)
+		return ret;
+	data->als_meas_rate = 100000;
+
 	/* ALS integration time: 100ms */
 	data->als_it_ms = 100;
 	ret = vl6180_write_word(client, VL6180_ALS_IT, VL6180_ALS_IT_100);
-- 
2.43.0


