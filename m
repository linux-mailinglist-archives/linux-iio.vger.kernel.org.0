Return-Path: <linux-iio+bounces-10281-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECAC69930F3
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2024 17:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B3831C22316
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2024 15:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F3F1D88CA;
	Mon,  7 Oct 2024 15:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j5axIN50"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7421D88C1;
	Mon,  7 Oct 2024 15:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728314418; cv=none; b=FWHNHUbOg/BmLafD6YDP0mpXWJztqhCuaOhyFWtrHTnsxrV1lfaG1aZhbzoRTROc3ctUeNCXky/QrWq2qaq6z7KXbR3hq+xfW8lGa/xWpLI5apq350esSrlujHRMzphfFfrdCJQ0yW3551VAsJFW8ZHJKAoRdGMLuVmiV5sE5LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728314418; c=relaxed/simple;
	bh=T+QYja7LUJzkV7RCgdEgVqVceSPVINzxqOOsbiHlAtM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MU1BwcW8JSRNNqsEldeKOQiTALbaxBgINrZyen7Ki8S7i5zCauxLmFNyXF98irz2LoGynmzORwefd01s236/RuCXFPcQAge7xKUE/tlD4PlOZG99ZRupsEptM5H5S2Tzpuytcnf6EmpOqZqj7SwCc397LgtxNbXjfItQ9e7FTFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j5axIN50; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20b8be13cb1so48968385ad.1;
        Mon, 07 Oct 2024 08:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728314415; x=1728919215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yUspM/VMPEO1Kn2QXTO9UIPl/J9+OPnNBwBdWZtkysA=;
        b=j5axIN50mguAA6yZUAb0kv7TX6TOQL8bEjOoTX3FrFxR61pZRw7PYXay8gLVtV6+ST
         u5E6e3KGuzeHXgHKj1bdlhovIXML89yxElG4lZtUyZ1bxrPBF6po/ozrV/NSjeq7TFov
         82Sq4lgkJ/buEUBnlBXMj+Vai0r9qYrDvYpstq+H0KqoudbjyBmMasvSAQTgHIjOhTQN
         m/hXryR4ZBzt89bUcSBk6d3hJafucDymyi+UwcB679BjUOyc4pE+VOdTVqPu7jLLRHLg
         bv68tBjcAxma6Do9xlFAUA8qniBOnCFr2piVjNGtEODN6atJd7SjsO64qTbiSULYIa1T
         voPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728314415; x=1728919215;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yUspM/VMPEO1Kn2QXTO9UIPl/J9+OPnNBwBdWZtkysA=;
        b=CH0UlAHm1vfec9tvatRSq4iyTPoM8T2++/MCD0XDfTdde41no2Biw6/KONK6JYyNu0
         79/RBBOk51C2PO3PJaZOoQDuMq3TJbyed8b5/zb+VSTxhfzk9nX3RHVEu36QhOj3nrG1
         GAHjG40eT81abHzf+FoydI3/nui+lpmVo2VqXY3m32V7xe0ZGrU1KZBcNgEOSGCGrEY8
         M2mEbgVYqAGPcAhh0KVgcGb5NOXB7f88vP72AJeKMDbsDkllABZ97LZxzwfvn6OFgJ38
         2FWqfAo90IlmITmHADu68xdWA+dY5P5lPJv/SNcplQUBAamQ7IDzpTo+Q0qD8opUUiUl
         SThQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIPQ4kYEUlUa9jIkwOlBVraubcMKJnxcYCskCfR9K3jO3EqhbvxSVAZrZB46E3yLbARlOfDIdjHd4uLwg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoDDmdPQO32jVokCIgqeB1a+cVtsBNrtd1ReSQ/meGZFNstN5W
	IBDM3CmwFzW6tsc4LLhUw1iNPiuNEq8NGSV1YmlZ9Cn5RKPMdFQ+/a0ftZNOyFQ=
X-Google-Smtp-Source: AGHT+IGv6vbD0vJYQ8PyEEPLjhzoNFhVfuDsNUlr/rmEZWCXQq1pD8nx8hsECFkyRcsEWQedDMdfdA==
X-Received: by 2002:a17:902:fc4e:b0:202:4666:f018 with SMTP id d9443c01a7336-20bfdfd2693mr202680265ad.15.1728314415059;
        Mon, 07 Oct 2024 08:20:15 -0700 (PDT)
Received: from abhash-IdeaPad-L340-15IRH-Gaming.. ([136.233.9.100])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-20c138b1395sm41000755ad.3.2024.10.07.08.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 08:20:14 -0700 (PDT)
From: Abhash Jha <abhashkumarjha123@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	lars@metafoo.de,
	linux-kernel@vger.kernel.org,
	Abhash Jha <abhashkumarjha123@gmail.com>
Subject: [PATCH v3 1/3] iio: light: vl6180: Add configurable inter-measurement period support
Date: Mon,  7 Oct 2024 20:49:45 +0530
Message-ID: <20241007151947.58828-2-abhashkumarjha123@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241007151947.58828-1-abhashkumarjha123@gmail.com>
References: <20241007151947.58828-1-abhashkumarjha123@gmail.com>
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


