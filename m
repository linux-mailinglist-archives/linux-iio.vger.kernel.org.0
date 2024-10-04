Return-Path: <linux-iio+bounces-10134-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF6D990705
	for <lists+linux-iio@lfdr.de>; Fri,  4 Oct 2024 17:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CFB8B218C8
	for <lists+linux-iio@lfdr.de>; Fri,  4 Oct 2024 15:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1DD1C303D;
	Fri,  4 Oct 2024 15:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VnOIpLCF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFF41AA786;
	Fri,  4 Oct 2024 15:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728054155; cv=none; b=J9k1nnUHn7uBinwfdKny62yfxwhn7+LT0e3sZOZKpuX4AdZDtRzN6plmkDiXlsyXPuvCKlxI34ymBnlWTtsFpK4KL6ZPrnSTq1lcnvJcD9MYjdnSs1IkihzVD8PKB41t7nVFzfNa8sdazr+s6MmV9Xi7st66YFSNsJKIScGFCdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728054155; c=relaxed/simple;
	bh=8/jtRzU96krvO9eHA+xFxGTA0v868jE3gyBfKdrRvus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nw8wDWwnCbIhDPOi33dAepU2yKng1V31NYmzUEDYfyltTS8SdqxzO1z6egayobEJfj/6DtEG+0qS53FRwv3upEPD1VHAEQVh7pPTOfCXfiNbaD+sCSQyTVonVoJKFsnmjm0HASQfdFjynbv5jR5vBfhwoOT5HzGweD83qe372W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VnOIpLCF; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2e091682cfbso1735607a91.0;
        Fri, 04 Oct 2024 08:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728054153; x=1728658953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hV/Shy1FZi7iJzQidTCMmnMOcmxQOiJp03mXnsnRSps=;
        b=VnOIpLCF7QZQdFQO1SJw51omFVQIaTYASormddjP2wh9LL7dLicokhfW1/+0NjdQ2T
         D+dKfYshBLxMi9+ogNzp/FMX1j+6jKYUGPmxKh6rhcQNmImNQqgKCj7cRZjpkWDQBpD4
         WfLtSa3JnUg5e0CrN5qq5rTCEtPXLeEQyLMXeUZo6ufkocl7KSvdW1aOh13m0pzF48sd
         ujGNIx/+qgugD23xZen1yw6meT/cqrHM+7khRekt9TKfsK09AJLYTGC+fceE/lS7+IqE
         kME/dhjCKWykNgFQZdzJNtIb7YEMlatHgqs0cekq/Mv2wTxRQp0D8zlAAx2nUNr7R2vv
         5bAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728054153; x=1728658953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hV/Shy1FZi7iJzQidTCMmnMOcmxQOiJp03mXnsnRSps=;
        b=rBubNfRjnvH3Uq4lQk/JkWmwkNVDiqukWM6nmhHZAq51XF26Qm59jAd5r3aECGJofU
         ZtObg4isG0f1YtDRIsagVDUhMoTkYqrg0/X1+M+EgbYbD6Sw2rncb9cFgQLLWfLl0ANE
         9bkl+hokN/iQqvjLnv2MGxqwEvcEYjb/nSSKztNKJTtVB+lzXXeiFtWddKz8AgfHNqOX
         juJqCB6nkf8xjsosvIazgQnG6aAdeaEKI1xaGeIppMWkxv9YaRO8wkfe+zy7bo3RyYlG
         AWvJErYngXbcbj8b3ak0pabHGc7MskapFAHkiExVf45KKIbF+82SVVGnuwSl/hepJn5L
         xbzw==
X-Forwarded-Encrypted: i=1; AJvYcCWgkcs7hgix2KxHdO6aufIrzUciadwuVZGeOvSXkZ/NT7NH7hTIoVd8X6Y6z7mCU7KQJKrL6AEoHQYVCSI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWVhcCDZzOLMRXsPn84am8bJjwbZGCC/5G4V5uZowL5mQHqiZC
	XC1YzGevaQ7W75f1HlyFu9t76vYG9GRnkO7ss/m5mnsDajxA3Kx7+3ZFFucL5DU=
X-Google-Smtp-Source: AGHT+IHXipJ4bjOkO8pnstOlhRfaqvic/Ya/BiH+1xmQ7oSN1dLW23K6+PVztgtZoVvN9CuOBds/Yg==
X-Received: by 2002:a17:90a:bf0c:b0:2e0:8536:4f53 with SMTP id 98e67ed59e1d1-2e1e621151amr3899667a91.3.1728054153079;
        Fri, 04 Oct 2024 08:02:33 -0700 (PDT)
Received: from abhash-IdeaPad-L340-15IRH-Gaming.. ([136.233.9.100])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-7e9f6c34127sm19979a12.67.2024.10.04.08.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 08:02:32 -0700 (PDT)
From: Abhash Jha <abhashkumarjha123@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	lars@metafoo.de,
	linux-kernel@vger.kernel.org,
	Abhash Jha <abhashkumarjha123@gmail.com>
Subject: [PATCH 1/3] iio: light: vl6180: Add configurable inter-measurement period support
Date: Fri,  4 Oct 2024 20:31:46 +0530
Message-ID: <20241004150148.14033-2-abhashkumarjha123@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004150148.14033-1-abhashkumarjha123@gmail.com>
References: <20241004150148.14033-1-abhashkumarjha123@gmail.com>
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
 drivers/iio/light/vl6180.c | 67 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 65 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/vl6180.c b/drivers/iio/light/vl6180.c
index a1b2b3c0b..52a837644 100644
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
@@ -412,11 +430,22 @@ static int vl6180_set_it(struct vl6180_data *data, int val, int val2)
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
 
 	switch (mask) {
 	case IIO_CHAN_INFO_INT_TIME:
@@ -427,6 +456,24 @@ static int vl6180_write_raw(struct iio_dev *indio_dev,
 			return -EINVAL;
 
 		return vl6180_set_als_gain(data, val, val2);
+
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		guard(mutex)(&data->lock);
+		switch (chan->type) {
+		case IIO_DISTANCE:
+			data->range_meas_rate = val;
+			reg_val = vl6180_meas_reg_val_from_ms(val);
+			return vl6180_write_byte(data->client, VL6180_RANGE_INTER_MEAS_TIME, reg_val);
+
+		case IIO_LIGHT:
+			data->als_meas_rate = val;
+			reg_val = vl6180_meas_reg_val_from_ms(val);
+			return vl6180_write_byte(data->client, VL6180_ALS_INTER_MEAS_TIME, reg_val);
+
+		default:
+			return -EINVAL;
+		}
+
 	default:
 		return -EINVAL;
 	}
@@ -473,6 +520,22 @@ static int vl6180_init(struct vl6180_data *data)
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


