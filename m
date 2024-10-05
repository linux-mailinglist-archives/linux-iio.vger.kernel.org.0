Return-Path: <linux-iio+bounces-10173-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A26A99917F8
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2024 17:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C68481C21630
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2024 15:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FEF8156F28;
	Sat,  5 Oct 2024 15:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WaL2tGqy"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C217C156C71;
	Sat,  5 Oct 2024 15:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728143584; cv=none; b=mC8gc3ExjyUe2q2NzmYomr35fFk5VDyfgOmpbgmChTsQG3Nu6jfexdUR5gEx1R6S06LLJg93U4/qHsTudFUNOmUraZbyrKpoRUmRIt7Fx3dO4Fha2Dc+41XSqVb6rEdAQMFZxxAHG1v3N3wghLCzQvPE7qu9Ohq0bN9jJdwJR8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728143584; c=relaxed/simple;
	bh=YM+iaVcsEE3ZAS7IL3uC3MHg8FPw65HssdDPUopdi3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MPTR1Ur07Dl6ZSV6sQG6UJ0UsYGd0lmUsnsKDTLnVA/SxBNrz/7zS2a8tIZ7xLMTFUGLAyEV7RuF8lnAydqJU+uZlzUutkmBn2WnS98RFkL/2gCs1vZ6K0E+vlaObftJbUJHi/WPB8IN+V3zjOdzCoWflAj2hFbnmFbN88hB4kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WaL2tGqy; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20b7463dd89so34009935ad.2;
        Sat, 05 Oct 2024 08:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728143581; x=1728748381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nlFeKsIuSxzj6ce1JKc3eZHCtZGbmTVgezzcVvunKfA=;
        b=WaL2tGqykQZ3OCmanzXyUk6khSyiu0kX4Q/IHLqDgV/KNNpVmA6XrRcUMrsn3G1TnN
         wbs6txZ1cfups+Ljqa2ZffUjr+lXPBlUdPZoJ0qrtVtx2CPZVCgaE3WZo3hfHZQN7l97
         vBx0BPWAJFgiPqqsuy4uf0G1xFBgNfctu3eAB/7IPf5XF3oX97TrGQDLg79GkVoKOdCA
         chWlKc88yrsuJimwDhF7GbbWStbiVmW6sMxOlK3nBw9S08+BIsxW5Z1XDIIZJBvNjnPX
         o3jgtBI4IdL9Gsk04w9cDGOKiwAzgw6zDLasc6aF4mMDO4E0tWkhV8jxMmrPtxOqT4fJ
         1GnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728143581; x=1728748381;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nlFeKsIuSxzj6ce1JKc3eZHCtZGbmTVgezzcVvunKfA=;
        b=o8aIWIVe+NzwXVSlIRckZWhRuokCu9rBNdNtyRl8tHvcc5deQuJFxLpUmOR8ZoYxHU
         pJs/JbKYzt1nlfBe1ankJ9yrvTRKUvrI5vzOIabXnsZmY4KTmPcEgv7iYCr4isOamws4
         7Y9qgiOTgiuMEwWCGvkMNuX5rRakFuG8vEph7lOgejRfVAlNfXMdhx48rdt145OqrLjB
         3Komv4GjhiM0YUOxZoINHTFM1dW2uYDTghAGNhQUUZFsM89Dyxb48xPLwU1gQUF2ic2W
         foL8i+QMJJ3mCMx3PsGS8mvDbG8HJoQJgXC+mRX0cqZmqsuiAfiiuXi5VXp7sXSn7krO
         aHyw==
X-Forwarded-Encrypted: i=1; AJvYcCVkGjAwWlALOOVkmVqNzI/qVexmlyl4vkxIm+m/Umw8Mv84MXSeWY+eG7dE0iC3eLNihlBEAAHdqz6RT4E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQmkS1XDYHspDnzuFAcshcfVQHACmzRAOcAcNBsttNrJ4zUe05
	+OG9RcJFGWP5EJEkP9X4dSSHzS7rSH1Tk8zvxzaUxGhw5tZlWJNSunyuBhVzUeI=
X-Google-Smtp-Source: AGHT+IHpbyCu6rFkjCEMdh9DbxkkhaEuterkVGU7E7W9/k0mzj66nhE7f/8g1m/RBBD9U4aVMBrUhQ==
X-Received: by 2002:a17:902:f68d:b0:20b:bad4:5b95 with SMTP id d9443c01a7336-20bfdfb10b7mr88305535ad.13.1728143580813;
        Sat, 05 Oct 2024 08:53:00 -0700 (PDT)
Received: from abhash-IdeaPad-L340-15IRH-Gaming.. ([136.233.9.100])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2e20aebc40csm2008370a91.23.2024.10.05.08.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 08:53:00 -0700 (PDT)
From: Abhash Jha <abhashkumarjha123@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	lars@metafoo.de,
	linux-kernel@vger.kernel.org,
	Abhash Jha <abhashkumarjha123@gmail.com>
Subject: [PATCH v2 1/3] iio: light: vl6180: Add configurable inter-measurement period support
Date: Sat,  5 Oct 2024 21:22:23 +0530
Message-ID: <20241005155225.9239-2-abhashkumarjha123@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241005155225.9239-1-abhashkumarjha123@gmail.com>
References: <20241005155225.9239-1-abhashkumarjha123@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Expose the IIO_CHAN_INFO_SAMP_FREQ attribute as a way to configure the
inter-measurement period for both the IIO_DISTANCE and IIO_LIGHT
channels. The inter-measurement period must be given in miliseconds.

Signed-off-by: Abhash Jha <abhashkumarjha123@gmail.com>
---
 drivers/iio/light/vl6180.c | 66 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 64 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/vl6180.c b/drivers/iio/light/vl6180.c
index a1b2b3c0b..401f13411 100644
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
@@ -412,12 +430,24 @@ static int vl6180_set_it(struct vl6180_data *data, int val, int val2)
 	return ret;
 }
 
+static int vl6180_meas_reg_val_from_ms(unsigned int period)
+{
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
 
+	guard(mutex)(&data->lock);
 	switch (mask) {
 	case IIO_CHAN_INFO_INT_TIME:
 		return vl6180_set_it(data, val, val2);
@@ -427,6 +457,22 @@ static int vl6180_write_raw(struct iio_dev *indio_dev,
 			return -EINVAL;
 
 		return vl6180_set_als_gain(data, val, val2);
+
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		switch (chan->type) {
+		case IIO_DISTANCE:
+			data->range_meas_rate = val;
+			reg_val = vl6180_meas_reg_val_from_ms(val);
+			return vl6180_write_byte(data->client,
+				VL6180_RANGE_INTER_MEAS_TIME, reg_val);
+
+		case IIO_LIGHT:
+			data->als_meas_rate = val;
+			reg_val = vl6180_meas_reg_val_from_ms(val);
+			return vl6180_write_byte(data->client,
+				VL6180_ALS_INTER_MEAS_TIME, reg_val);
+		}
+
 	default:
 		return -EINVAL;
 	}
@@ -473,6 +519,22 @@ static int vl6180_init(struct vl6180_data *data)
 	if (ret < 0)
 		return ret;
 
+	/* Default Range inter-measurement time: 50ms
+	 * reg_val = (50 / 10 - 1) = 4
+	 */
+	ret = vl6180_write_byte(client, VL6180_RANGE_INTER_MEAS_TIME, 4);
+	if (ret < 0)
+		return ret;
+	data->range_meas_rate = 50;
+
+	/* Default ALS inter-measurement time: 10ms
+	 * reg_val = (10 / 10 - 1) = 0
+	 */
+	ret = vl6180_write_byte(client, VL6180_ALS_INTER_MEAS_TIME, 0);
+	if (ret < 0)
+		return ret;
+	data->als_meas_rate = 10;
+
 	/* ALS integration time: 100ms */
 	data->als_it_ms = 100;
 	ret = vl6180_write_word(client, VL6180_ALS_IT, VL6180_ALS_IT_100);
-- 
2.43.0


