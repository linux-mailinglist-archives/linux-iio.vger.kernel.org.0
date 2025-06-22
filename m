Return-Path: <linux-iio+bounces-20852-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85CA3AE2FE0
	for <lists+linux-iio@lfdr.de>; Sun, 22 Jun 2025 14:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C4F0171044
	for <lists+linux-iio@lfdr.de>; Sun, 22 Jun 2025 12:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF76C1EFFB2;
	Sun, 22 Jun 2025 12:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AoqfHo4t"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7D71E7660;
	Sun, 22 Jun 2025 12:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750595390; cv=none; b=hoxmOB9Kw764JVDNLSMba4610FkMDHrTiU38p+fGbl69+ge98VSUEOjClqWtl7V22DtJgTkFbOT9jqbnXUoQbnMV9lwJd1owDHmKrQmJIJ2+LRmHMTOyQRW44iyJ/o8XqzVQYLjvaowM0RuEg+C5TtCTss0JhWR5Tf3Hiw9isaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750595390; c=relaxed/simple;
	bh=V6SULSuNhoVPBdjDT0FWYzZCo5UzfHrUJy3y2K9faAY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Pg11JByly3vsyzP/1qAYPCKkbCKe3sRAR4ATntnB1Nnffs7NQTytyknz1p+yFYTc+PJ9/GHATLfQG2eGMWwiy6wEpr3foU1QcWNGNKuSIVyXPlCVGjdTxPHQViZ7cIztnCSyLKC950x89xe05TKBC6cDgqILxisSZh99JL0StI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AoqfHo4t; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-608964359f9so549003a12.1;
        Sun, 22 Jun 2025 05:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750595387; x=1751200187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LMZoP0GLC2kHFths+JzZF27Jj5owFN9ALATO5Vnv0z4=;
        b=AoqfHo4t8j0WzKg5aro6MGiSpu4kHiBY8CnOy4TqGZ3GwV1Lh4pPx/Ey6eFyQmJSwL
         giqXYEXTv96WlM8EUEx8jqxwQLMQXlFMUpbgwZuoYS/xaNSD3viWcDIMpSekFgpdiO+N
         Bw+XLEkLVZPBr4ONWOJPeYU7g/csdyRg+405DGOuXYf2s9mo8+eye79MgXDxa0EWFoKC
         3QnPe7HeEF7Hm1ouMN57PNpoyxopJTFLayAse1xEc/EiQbViKxiC89nQRrdoOnwU2n1a
         49QoKISF5QlnvDIY2sduBPX9p2GHaFlP7OKMNr3Y0aj+e7f+ijPYJOUR2o6ulo5xN+18
         Tngg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750595387; x=1751200187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LMZoP0GLC2kHFths+JzZF27Jj5owFN9ALATO5Vnv0z4=;
        b=HgvTpl7iNYXYokHGdcTpvJDScdV5EEtXmLIYOu54r3EFNd/9N3hLYRBRQrbP7fRTlV
         2T4Ii70NkHoXJ9RV8HoY4/kKdjy2sNIjHG0q3w1NhrZ5d2AKF9i8gYELLj2VVyQF5TtC
         E4pXjUUAiwRfb7QaYtbjPJC+0nChQk66tytNnUsWH0sd9+fbqf2y7RUpM4dAhtwNREo/
         RuG6PB+arwY8DevwcIrpXYQrmciyPFGM2JoiUVWBhY82ojeAb0BGoj70s1ncn9lGfQj9
         Sad5KTRViPe6qZhvPINia2wlDGebCjzDN+6SwP1MdqjiKY+SuYlCKSIL4coy8xgVOI84
         u/Kw==
X-Forwarded-Encrypted: i=1; AJvYcCUcZWr+6YzK+kyfBQ2VI9/z7bx5KkYlzDR1dT/ltencnzkC8BTk3D+Uuq0Lrez0ejJg5kl3kYJayPySDGH9@vger.kernel.org, AJvYcCVeRfSUa710ZnTUwo23YD7GPVaWairvVyISwfbIikNlyPvsiQH9iPLJbgN5sit0uemXa4A9ydHyayav@vger.kernel.org, AJvYcCVgWm1uICOoDRhd/klppx+zPRILXQpsyiL0ay/PQFiE4vBdCUdESapBVdTOWLTH9EZGC9OHAP31q6U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxA20SHEqrW0GOIrqUD+za2SNKqB6NiB2JLXMW6woLKLhC7EiGt
	i63Q/ASM1BNXKn244Y1Gb1vsGpMUDJGQXpBfn+ykOPExqkTBF2GuQwu6
X-Gm-Gg: ASbGncv2Fl0ya934IwK3xCCVMTkK1AB/x5wKar5JnLys/iWAkOdjvxA6XBSQncaKSQx
	9YGL41hrpAAmk8/Dak0vD860VeY1oyVmznkKDzs1JEYqubYaCxgFePVTBvNR+aHYWZoVpV7JXeN
	k5KtDi1jI+Ed6Ce4R0d/rgDfWNfg/RmB9wY5p0F/qm5hZnYqLT5bS0IenLzsAsJa0ND0uoYvh41
	Ulkt21vI2EPZns7Fp47tjudIkVSXRMSFIJWHEhtQrLykqAOiMlamQbNbZ6PbQyiCHxO94qfbj6I
	+5wRRCSeTUrqyzlRGezZIZtJutkN/fN1NPKF1KaYg7GuNTojTVdli9poJgYiQEf0JmZdr4stL5z
	tk/8DaXxmce7ipqtLKRTEcv8vdoapa435MZ2fSzSaYoo=
X-Google-Smtp-Source: AGHT+IFunybjhodzz7pRltHxCmkjsMIpRvcCX8BUgoZXMCccEt/CiHZmYtcgQGrHD9b/u4uvJ3L5Sg==
X-Received: by 2002:a17:906:9c82:b0:ad8:a43f:305 with SMTP id a640c23a62f3a-ae057927a19mr277025166b.8.1750595386473;
        Sun, 22 Jun 2025 05:29:46 -0700 (PDT)
Received: from localhost.localdomain (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae053edc0e9sm533917566b.54.2025.06.22.05.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jun 2025 05:29:46 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	corbet@lwn.net,
	lucas.p.stankus@gmail.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	bagasdotme@gmail.com
Cc: l.rubusch@gmail.com,
	linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 5/8] iio: accel: adxl313: add inactivity sensing
Date: Sun, 22 Jun 2025 12:29:34 +0000
Message-Id: <20250622122937.156930-6-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250622122937.156930-1-l.rubusch@gmail.com>
References: <20250622122937.156930-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enhance the interrupt handler to process inactivity events. Introduce
functions to configure the threshold and period registers for
inactivity detection, as well as to enable or disable the inactivity
feature. Extend the fake IIO channel to handle inactivity events by
combining the x, y, and z axes using a logical AND operation.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl313.h      |   2 +
 drivers/iio/accel/adxl313_core.c | 116 ++++++++++++++++++++++++++++++-
 2 files changed, 116 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/adxl313.h b/drivers/iio/accel/adxl313.h
index 4f4a9fd39f6d..d7e8cb44855b 100644
--- a/drivers/iio/accel/adxl313.h
+++ b/drivers/iio/accel/adxl313.h
@@ -18,6 +18,8 @@
 #define ADXL313_REG_SOFT_RESET		0x18
 #define ADXL313_REG_OFS_AXIS(index)	(0x1E + (index))
 #define ADXL313_REG_THRESH_ACT		0x24
+#define ADXL313_REG_THRESH_INACT	0x25
+#define ADXL313_REG_TIME_INACT		0x26
 #define ADXL313_REG_ACT_INACT_CTL	0x27
 #define ADXL313_REG_BW_RATE		0x2C
 #define ADXL313_REG_POWER_CTL		0x2D
diff --git a/drivers/iio/accel/adxl313_core.c b/drivers/iio/accel/adxl313_core.c
index d2c625f27555..36cfd23d2e3c 100644
--- a/drivers/iio/accel/adxl313_core.c
+++ b/drivers/iio/accel/adxl313_core.c
@@ -28,18 +28,22 @@
 #define ADXL313_REG_XYZ_BASE			ADXL313_REG_DATA_AXIS(0)
 
 #define ADXL313_ACT_XYZ_EN			GENMASK(6, 4)
+#define ADXL313_INACT_XYZ_EN			GENMASK(2, 0)
 
 /* activity/inactivity */
 enum adxl313_activity_type {
 	ADXL313_ACTIVITY,
+	ADXL313_INACTIVITY,
 };
 
 static const unsigned int adxl313_act_int_reg[] = {
 	[ADXL313_ACTIVITY] = ADXL313_INT_ACTIVITY,
+	[ADXL313_INACTIVITY] = ADXL313_INT_INACTIVITY,
 };
 
 static const unsigned int adxl313_act_thresh_reg[] = {
 	[ADXL313_ACTIVITY] = ADXL313_REG_THRESH_ACT,
+	[ADXL313_INACTIVITY] = ADXL313_REG_THRESH_INACT,
 };
 
 static const struct regmap_range adxl312_readable_reg_range[] = {
@@ -253,6 +257,17 @@ static const struct iio_event_spec adxl313_activity_events[] = {
 	},
 };
 
+static const struct iio_event_spec adxl313_inactivity_events[] = {
+	{
+		/* inactivity */
+		.type = IIO_EV_TYPE_MAG,
+		.dir = IIO_EV_DIR_FALLING,
+		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
+		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE) |
+			BIT(IIO_EV_INFO_PERIOD),
+	},
+};
+
 enum adxl313_chans {
 	chan_x, chan_y, chan_z,
 };
@@ -269,6 +284,14 @@ static const struct iio_chan_spec adxl313_channels[] = {
 		.event_spec = adxl313_activity_events,
 		.num_event_specs = ARRAY_SIZE(adxl313_activity_events),
 	},
+	{
+		.type = IIO_ACCEL,
+		.modified = 1,
+		.channel2 = IIO_MOD_X_AND_Y_AND_Z,
+		.scan_index = -1, /* Fake channel for axis AND'ing */
+		.event_spec = adxl313_inactivity_events,
+		.num_event_specs = ARRAY_SIZE(adxl313_inactivity_events),
+	},
 };
 
 static const unsigned long adxl313_scan_masks[] = {
@@ -331,6 +354,15 @@ static int adxl313_read_freq_avail(struct iio_dev *indio_dev,
 	}
 }
 
+static int adxl313_set_inact_time_s(struct adxl313_data *data,
+				    unsigned int val_s)
+{
+	unsigned int max_boundary = U8_MAX; /* by register size */
+	unsigned int val = min(val_s, max_boundary);
+
+	return regmap_write(data->regmap, ADXL313_REG_TIME_INACT, val);
+}
+
 static int adxl313_is_act_inact_en(struct adxl313_data *data,
 				   enum adxl313_activity_type type)
 {
@@ -348,6 +380,10 @@ static int adxl313_is_act_inact_en(struct adxl313_data *data,
 		if (!FIELD_GET(ADXL313_ACT_XYZ_EN, axis_ctrl))
 			return false;
 		break;
+	case ADXL313_INACTIVITY:
+		if (!FIELD_GET(ADXL313_INACT_XYZ_EN, axis_ctrl))
+			return false;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -366,6 +402,7 @@ static int adxl313_set_act_inact_en(struct adxl313_data *data,
 {
 	unsigned int axis_ctrl;
 	unsigned int threshold;
+	unsigned int inact_time_s;
 	int ret;
 
 	if (cmd_en) {
@@ -377,6 +414,18 @@ static int adxl313_set_act_inact_en(struct adxl313_data *data,
 
 		if (!threshold) /* Just ignore the command if threshold is 0 */
 			return 0;
+
+		/* When turning on inactivity, check if inact time is valid */
+		if (type == ADXL313_INACTIVITY) {
+			ret = regmap_read(data->regmap,
+					  ADXL313_REG_TIME_INACT,
+					  &inact_time_s);
+			if (ret)
+				return ret;
+
+			if (!inact_time_s)
+				return 0;
+		}
 	}
 
 	/* Start modifying configuration registers */
@@ -389,6 +438,9 @@ static int adxl313_set_act_inact_en(struct adxl313_data *data,
 	case ADXL313_ACTIVITY:
 		axis_ctrl = ADXL313_ACT_XYZ_EN;
 		break;
+	case ADXL313_INACTIVITY:
+		axis_ctrl = ADXL313_INACT_XYZ_EN;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -481,11 +533,14 @@ static int adxl313_write_raw(struct iio_dev *indio_dev,
 
 static int adxl313_read_mag_config(struct adxl313_data *data,
 				   enum iio_event_direction dir,
-				   enum adxl313_activity_type type_act)
+				   enum adxl313_activity_type type_act,
+				   enum adxl313_activity_type type_inact)
 {
 	switch (dir) {
 	case IIO_EV_DIR_RISING:
 		return !!adxl313_is_act_inact_en(data, type_act);
+	case IIO_EV_DIR_FALLING:
+		return !!adxl313_is_act_inact_en(data, type_inact);
 	default:
 		return -EINVAL;
 	}
@@ -494,11 +549,14 @@ static int adxl313_read_mag_config(struct adxl313_data *data,
 static int adxl313_write_mag_config(struct adxl313_data *data,
 				    enum iio_event_direction dir,
 				    enum adxl313_activity_type type_act,
+				    enum adxl313_activity_type type_inact,
 				    bool state)
 {
 	switch (dir) {
 	case IIO_EV_DIR_RISING:
 		return adxl313_set_act_inact_en(data, type_act, state);
+	case IIO_EV_DIR_FALLING:
+		return adxl313_set_act_inact_en(data, type_inact, state);
 	default:
 		return -EINVAL;
 	}
@@ -514,7 +572,8 @@ static int adxl313_read_event_config(struct iio_dev *indio_dev,
 	switch (type) {
 	case IIO_EV_TYPE_MAG:
 		return adxl313_read_mag_config(data, dir,
-					       ADXL313_ACTIVITY);
+					       ADXL313_ACTIVITY,
+					       ADXL313_INACTIVITY);
 	default:
 		return -EINVAL;
 	}
@@ -532,6 +591,7 @@ static int adxl313_write_event_config(struct iio_dev *indio_dev,
 	case IIO_EV_TYPE_MAG:
 		return adxl313_write_mag_config(data, dir,
 						ADXL313_ACTIVITY,
+						ADXL313_INACTIVITY,
 						state);
 	default:
 		return -EINVAL;
@@ -541,6 +601,7 @@ static int adxl313_write_event_config(struct iio_dev *indio_dev,
 static int _adxl313_read_mag_value(struct adxl313_data *data,
 				   enum iio_event_direction dir,
 				   enum adxl313_activity_type type_act,
+				   enum adxl313_activity_type type_inact,
 				   int *val, int *val2)
 {
 	unsigned int threshold;
@@ -556,6 +617,15 @@ static int _adxl313_read_mag_value(struct adxl313_data *data,
 		*val = threshold * 15625;
 		*val2 = MICRO;
 		return IIO_VAL_FRACTIONAL;
+	case IIO_EV_DIR_FALLING:
+		ret = regmap_read(data->regmap,
+				  adxl313_act_thresh_reg[type_inact],
+				  &threshold);
+		if (ret)
+			return ret;
+		*val = threshold * 15625;
+		*val2 = MICRO;
+		return IIO_VAL_FRACTIONAL;
 	default:
 		return -EINVAL;
 	}
@@ -564,6 +634,7 @@ static int _adxl313_read_mag_value(struct adxl313_data *data,
 static int _adxl313_write_mag_value(struct adxl313_data *data,
 				    enum iio_event_direction dir,
 				    enum adxl313_activity_type type_act,
+				    enum adxl313_activity_type type_inact,
 				    int val, int val2)
 {
 	unsigned int regval;
@@ -575,6 +646,10 @@ static int _adxl313_write_mag_value(struct adxl313_data *data,
 		return regmap_write(data->regmap,
 				    adxl313_act_thresh_reg[type_act],
 				    regval);
+	case IIO_EV_DIR_FALLING:
+		return regmap_write(data->regmap,
+				    adxl313_act_thresh_reg[type_inact],
+				    regval);
 	default:
 		return -EINVAL;
 	}
@@ -584,13 +659,25 @@ static int adxl313_read_mag_value(struct adxl313_data *data,
 				  enum iio_event_direction dir,
 				  enum iio_event_info info,
 				  enum adxl313_activity_type type_act,
+				  enum adxl313_activity_type type_inact,
 				  int *val, int *val2)
 {
+	unsigned int period;
+	int ret;
+
 	switch (info) {
 	case IIO_EV_INFO_VALUE:
 		return _adxl313_read_mag_value(data, dir,
 					       type_act,
+					       type_inact,
 					       val, val2);
+	case IIO_EV_INFO_PERIOD:
+		ret = regmap_read(data->regmap, ADXL313_REG_TIME_INACT,
+				  &period);
+		if (ret)
+			return ret;
+		*val = period;
+		return IIO_VAL_INT;
 	default:
 		return -EINVAL;
 	}
@@ -600,13 +687,17 @@ static int adxl313_write_mag_value(struct adxl313_data *data,
 				   enum iio_event_direction dir,
 				   enum iio_event_info info,
 				   enum adxl313_activity_type type_act,
+				   enum adxl313_activity_type type_inact,
 				   int val, int val2)
 {
 	switch (info) {
 	case IIO_EV_INFO_VALUE:
 		return _adxl313_write_mag_value(data, dir,
 						type_act,
+						type_inact,
 						val, val2);
+	case IIO_EV_INFO_PERIOD:
+		return adxl313_set_inact_time_s(data, val);
 	default:
 		return -EINVAL;
 	}
@@ -625,6 +716,7 @@ static int adxl313_read_event_value(struct iio_dev *indio_dev,
 	case IIO_EV_TYPE_MAG:
 		return adxl313_read_mag_value(data, dir, info,
 					      ADXL313_ACTIVITY,
+					      ADXL313_INACTIVITY,
 					      val, val2);
 	default:
 		return -EINVAL;
@@ -644,6 +736,7 @@ static int adxl313_write_event_value(struct iio_dev *indio_dev,
 	case IIO_EV_TYPE_MAG:
 		return adxl313_write_mag_value(data, dir, info,
 					       ADXL313_ACTIVITY,
+					       ADXL313_INACTIVITY,
 					       val, val2);
 	default:
 		return -EINVAL;
@@ -804,6 +897,17 @@ static int adxl313_push_events(struct iio_dev *indio_dev, int int_stat)
 			return ret;
 	}
 
+	if (FIELD_GET(ADXL313_INT_INACTIVITY, int_stat)) {
+		ret = iio_push_event(indio_dev,
+				     IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
+							IIO_MOD_X_AND_Y_AND_Z,
+							IIO_EV_TYPE_MAG,
+							IIO_EV_DIR_FALLING),
+				     ts);
+		if (ret)
+			return ret;
+	}
+
 	return ret;
 }
 
@@ -1009,6 +1113,14 @@ int adxl313_core_probe(struct device *dev,
 		if (ret)
 			return ret;
 
+		ret = regmap_write(data->regmap, ADXL313_REG_TIME_INACT, 5);
+		if (ret)
+			return ret;
+
+		ret = regmap_write(data->regmap, ADXL313_REG_THRESH_INACT, 0x4f);
+		if (ret)
+			return ret;
+
 		ret = regmap_write(data->regmap, ADXL313_REG_THRESH_ACT, 0x52);
 		if (ret)
 			return ret;
-- 
2.39.5


