Return-Path: <linux-iio+bounces-20851-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C12A8AE2FDC
	for <lists+linux-iio@lfdr.de>; Sun, 22 Jun 2025 14:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5025E17108E
	for <lists+linux-iio@lfdr.de>; Sun, 22 Jun 2025 12:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68AC1EE01A;
	Sun, 22 Jun 2025 12:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UZksuU9o"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FC91E51F6;
	Sun, 22 Jun 2025 12:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750595389; cv=none; b=f7u8JEX8VZKlJODlEdd/yWbdkljbFdmZvepxr8SO17jKeuV7/QOfUbUuVL8OvUCFTQPlJLA3dAANsjoVHq6RJPJ/lCX2/RVWr4F0OJHcvre/JaF2DyVohMkiJYRzlmEnKYucVm0pP2MWAeM1Ql5x4Yx77FwdG73nUlOCPaoYbVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750595389; c=relaxed/simple;
	bh=3PoDOckA6GAwKZmOJr93WpM3yDCvhMs2mH3kSrT6B5c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Upa6j261oMyumeG1oJlEnGXRvx81bEUhdppMx1z5bsZK8Vfr2tJDts5zO54Iy45qWUAqFpKkUc/gUxg3/Dd6kXn8/mYWSwXDbS5ta2OZO/CJC2VWxOiFwAxEFtMQKwRIpKGTNxw4/IAghfLpr4bHAtq1mXx4RnhPVKFJhAtif48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UZksuU9o; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-606a269d440so736809a12.2;
        Sun, 22 Jun 2025 05:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750595385; x=1751200185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QHc0u+m8MkMq43EquiBQUz6onUQttHIOsfhVTlhke+Q=;
        b=UZksuU9oI6Cncmjv33bg6eZiQt8T9rxUme1Y9Tz1of7bzCxtzAjclnei97J1G1gLyn
         xH9G0EII2WpkkcKfTDmJV0otNpwm8KznF4TnN0idtVbTkydOv2SdYRrl+6vwU52AC+dm
         aHZLrnoWbruWlr/uHvdRtKx9o2u6pfzAkLuSDkGGdgdFRfOyN9jW0N3KNy/+f7QHE2PP
         GsaUVQJS1MWP3WVh/omqtOuG6jBE4vpgvBbPgHFtYm+9AvxxAX+lJMk8Jzg3fuh5a03l
         F9x/EkkbP56mJrRgQOrGqIYRTRCeMNZHgR5b2GLJ1YHqeL4vRuZ1s7pZatTlNcv0enHO
         eqZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750595385; x=1751200185;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QHc0u+m8MkMq43EquiBQUz6onUQttHIOsfhVTlhke+Q=;
        b=VH+JrRTxzGAPaOsBOKt183VAQ8k9YQFe6Fl12jyunwkFUBkw6zlx+ndNcuMWAx/iSE
         0icJj5f4uSaWWhcrgiD6l3CuUGjtFsWw68U9ilIIim3ayiyGhdGmPs/hzUiK5j/2sBQB
         ZuRxvWDmLp7V1BPX237sMjEquAwQwkQaRc09l1/4yHrjXDwvNEU03R90vkQi5mr+eWU3
         8ykI+Whg634ZZ0Gmm3Cr9HHL71P32Sa1X7eL1cf7XuBfJ42lZUI6bQ+q8XWg5G0om2ZP
         khQL+v3PsuQxvbwQYWjkSN5swQoTHauQJcM2j4aIwLqRv5x8cUzPh6D1QbgG3YWFKEZN
         w/Xw==
X-Forwarded-Encrypted: i=1; AJvYcCUV+x8/mfPSPCi1XOB+fYO2Oi6wlY56syKQoYD0dIsZwLjM8s/NiPQepwFXzVrSQAw/a4NFk8hg4rI=@vger.kernel.org, AJvYcCW8p/+ba/gxAhK5rFni58Fy5puIn7T6qjDNnJfln0U+QYkqnCrUKVJGl/dtwgSZSgYGBVQL05/XGYgxmPZw@vger.kernel.org, AJvYcCWgA7mTCIQvvDEJyJm1KAu4BVBEeRdZkB9xGIs6qUUfLTnEzoryVOAJ9Fq/bl2AE8tIlYM8sg6ZgcB6@vger.kernel.org
X-Gm-Message-State: AOJu0YzxmHgCoZqcIHy6GUvGXwSkhlq3vcNNg8oq91CIJfVmBlcIuqxp
	mWRVd02Nd5KLrmKK1IbxOCKci0lEHaiIKpOn47RPue9QKIsmcNWoNB2D
X-Gm-Gg: ASbGncslviBjEtpKxLRpIW+M3mLm9FCSgH9pSWpBJWcqc0JVADeKh/Gn5KaiZIV8HRS
	kGmYLJOQ1OTWPXhIOPdVM0wOzDSeWcVVGHvflTY8FxSEIyVV5uLMLNmiACIcMruFbBLlG7wKrQT
	OgZ57sRY0eWxmouiXnWlRZ+8oEWXcT3E1XV/Wr0GxaDPLOMl9cVO55vgTS15a/FsALafDGu5sVq
	m8TWMdxy1Rssmp6fwdwYX1kNNb+CIkfFilalG1S/yuc1TIRhJrb8XI9NNT57FXvLYUfZwQJt+oI
	TKKpniXMnb8D6yeS3IL9V1zTIlqUIv0Pt4vB7SeM+3lTVCzzzQq4hHk9RgjgrIRCIPA29dmHp6T
	ZUGJVs0+E4VOFABKqkihuH+Y718i4UCYw
X-Google-Smtp-Source: AGHT+IFcnWT8M3ZLiDsb8h9PbHQQ/QKV82O0Diex11Jx9L44sLpvIwp5jwJxu6CsosMO/YUGTRftNQ==
X-Received: by 2002:a17:906:ef07:b0:ad8:7eed:44e8 with SMTP id a640c23a62f3a-ae0578f8113mr304491566b.5.1750595385377;
        Sun, 22 Jun 2025 05:29:45 -0700 (PDT)
Received: from localhost.localdomain (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae053edc0e9sm533917566b.54.2025.06.22.05.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jun 2025 05:29:45 -0700 (PDT)
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
Subject: [PATCH v6 4/8] iio: accel: adxl313: add activity sensing
Date: Sun, 22 Jun 2025 12:29:33 +0000
Message-Id: <20250622122937.156930-5-l.rubusch@gmail.com>
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

Add support for configuring an activity detection threshold. Extend the
interrupt handler to process activity-related interrupts, and provide
functions to set the threshold as well as to enable or disable activity
sensing. Additionally, introduce a virtual channel that represents the
logical AND of the x, y, and z axes in the IIO channel.

This patch serves as a preparatory step; some definitions and functions
introduced here are intended to be extended later to support inactivity
detection.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl313_core.c | 326 +++++++++++++++++++++++++++++++
 1 file changed, 326 insertions(+)

diff --git a/drivers/iio/accel/adxl313_core.c b/drivers/iio/accel/adxl313_core.c
index ac4cc16399fc..d2c625f27555 100644
--- a/drivers/iio/accel/adxl313_core.c
+++ b/drivers/iio/accel/adxl313_core.c
@@ -13,8 +13,10 @@
 #include <linux/overflow.h>
 #include <linux/property.h>
 #include <linux/regmap.h>
+#include <linux/units.h>
 
 #include <linux/iio/buffer.h>
+#include <linux/iio/events.h>
 #include <linux/iio/kfifo_buf.h>
 
 #include "adxl313.h"
@@ -25,6 +27,21 @@
 
 #define ADXL313_REG_XYZ_BASE			ADXL313_REG_DATA_AXIS(0)
 
+#define ADXL313_ACT_XYZ_EN			GENMASK(6, 4)
+
+/* activity/inactivity */
+enum adxl313_activity_type {
+	ADXL313_ACTIVITY,
+};
+
+static const unsigned int adxl313_act_int_reg[] = {
+	[ADXL313_ACTIVITY] = ADXL313_INT_ACTIVITY,
+};
+
+static const unsigned int adxl313_act_thresh_reg[] = {
+	[ADXL313_ACTIVITY] = ADXL313_REG_THRESH_ACT,
+};
+
 static const struct regmap_range adxl312_readable_reg_range[] = {
 	regmap_reg_range(ADXL313_REG_DEVID0, ADXL313_REG_DEVID0),
 	regmap_reg_range(ADXL313_REG_OFS_AXIS(0), ADXL313_REG_OFS_AXIS(2)),
@@ -227,6 +244,15 @@ static const int adxl313_odr_freqs[][2] = {
 	},								\
 }
 
+static const struct iio_event_spec adxl313_activity_events[] = {
+	{
+		.type = IIO_EV_TYPE_MAG,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
+		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE),
+	},
+};
+
 enum adxl313_chans {
 	chan_x, chan_y, chan_z,
 };
@@ -235,6 +261,14 @@ static const struct iio_chan_spec adxl313_channels[] = {
 	ADXL313_ACCEL_CHANNEL(0, chan_x, X),
 	ADXL313_ACCEL_CHANNEL(1, chan_y, Y),
 	ADXL313_ACCEL_CHANNEL(2, chan_z, Z),
+	{
+		.type = IIO_ACCEL,
+		.modified = 1,
+		.channel2 = IIO_MOD_X_OR_Y_OR_Z,
+		.scan_index = -1, /* Fake channel for axis OR'ing */
+		.event_spec = adxl313_activity_events,
+		.num_event_specs = ARRAY_SIZE(adxl313_activity_events),
+	},
 };
 
 static const unsigned long adxl313_scan_masks[] = {
@@ -297,6 +331,81 @@ static int adxl313_read_freq_avail(struct iio_dev *indio_dev,
 	}
 }
 
+static int adxl313_is_act_inact_en(struct adxl313_data *data,
+				   enum adxl313_activity_type type)
+{
+	unsigned int axis_ctrl;
+	unsigned int regval;
+	int ret;
+
+	ret = regmap_read(data->regmap, ADXL313_REG_ACT_INACT_CTL, &axis_ctrl);
+	if (ret)
+		return ret;
+
+	/* Check if axis for activity are enabled */
+	switch (type) {
+	case ADXL313_ACTIVITY:
+		if (!FIELD_GET(ADXL313_ACT_XYZ_EN, axis_ctrl))
+			return false;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* Check if specific interrupt is enabled */
+	ret = regmap_read(data->regmap, ADXL313_REG_INT_ENABLE, &regval);
+	if (ret)
+		return ret;
+
+	return adxl313_act_int_reg[type] & regval;
+}
+
+static int adxl313_set_act_inact_en(struct adxl313_data *data,
+				    enum adxl313_activity_type type,
+				    bool cmd_en)
+{
+	unsigned int axis_ctrl;
+	unsigned int threshold;
+	int ret;
+
+	if (cmd_en) {
+		/* When turning on, check if threshold is valid */
+		ret = regmap_read(data->regmap, adxl313_act_thresh_reg[type],
+				  &threshold);
+		if (ret)
+			return ret;
+
+		if (!threshold) /* Just ignore the command if threshold is 0 */
+			return 0;
+	}
+
+	/* Start modifying configuration registers */
+	ret = adxl313_set_measure_en(data, false);
+	if (ret)
+		return ret;
+
+	/* Enable axis according to the command */
+	switch (type) {
+	case ADXL313_ACTIVITY:
+		axis_ctrl = ADXL313_ACT_XYZ_EN;
+		break;
+	default:
+		return -EINVAL;
+	}
+	ret = regmap_assign_bits(data->regmap, ADXL313_REG_ACT_INACT_CTL,
+				 axis_ctrl, cmd_en);
+	if (ret)
+		return ret;
+
+	/* Enable the interrupt line, according to the command */
+	ret = regmap_assign_bits(data->regmap, ADXL313_REG_INT_ENABLE,
+				 adxl313_act_int_reg[type], cmd_en);
+	if (ret)
+		return ret;
+
+	return adxl313_set_measure_en(data, true);
+}
+
 static int adxl313_read_raw(struct iio_dev *indio_dev,
 			    struct iio_chan_spec const *chan,
 			    int *val, int *val2, long mask)
@@ -370,6 +479,177 @@ static int adxl313_write_raw(struct iio_dev *indio_dev,
 	}
 }
 
+static int adxl313_read_mag_config(struct adxl313_data *data,
+				   enum iio_event_direction dir,
+				   enum adxl313_activity_type type_act)
+{
+	switch (dir) {
+	case IIO_EV_DIR_RISING:
+		return !!adxl313_is_act_inact_en(data, type_act);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int adxl313_write_mag_config(struct adxl313_data *data,
+				    enum iio_event_direction dir,
+				    enum adxl313_activity_type type_act,
+				    bool state)
+{
+	switch (dir) {
+	case IIO_EV_DIR_RISING:
+		return adxl313_set_act_inact_en(data, type_act, state);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int adxl313_read_event_config(struct iio_dev *indio_dev,
+				     const struct iio_chan_spec *chan,
+				     enum iio_event_type type,
+				     enum iio_event_direction dir)
+{
+	struct adxl313_data *data = iio_priv(indio_dev);
+
+	switch (type) {
+	case IIO_EV_TYPE_MAG:
+		return adxl313_read_mag_config(data, dir,
+					       ADXL313_ACTIVITY);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int adxl313_write_event_config(struct iio_dev *indio_dev,
+				      const struct iio_chan_spec *chan,
+				      enum iio_event_type type,
+				      enum iio_event_direction dir,
+				      bool state)
+{
+	struct adxl313_data *data = iio_priv(indio_dev);
+
+	switch (type) {
+	case IIO_EV_TYPE_MAG:
+		return adxl313_write_mag_config(data, dir,
+						ADXL313_ACTIVITY,
+						state);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int _adxl313_read_mag_value(struct adxl313_data *data,
+				   enum iio_event_direction dir,
+				   enum adxl313_activity_type type_act,
+				   int *val, int *val2)
+{
+	unsigned int threshold;
+	int ret;
+
+	switch (dir) {
+	case IIO_EV_DIR_RISING:
+		ret = regmap_read(data->regmap,
+				  adxl313_act_thresh_reg[type_act],
+				  &threshold);
+		if (ret)
+			return ret;
+		*val = threshold * 15625;
+		*val2 = MICRO;
+		return IIO_VAL_FRACTIONAL;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int _adxl313_write_mag_value(struct adxl313_data *data,
+				    enum iio_event_direction dir,
+				    enum adxl313_activity_type type_act,
+				    int val, int val2)
+{
+	unsigned int regval;
+
+	/* Scale factor 15.625 mg/LSB */
+	regval = DIV_ROUND_CLOSEST(MICRO * val + val2, 15625);
+	switch (dir) {
+	case IIO_EV_DIR_RISING:
+		return regmap_write(data->regmap,
+				    adxl313_act_thresh_reg[type_act],
+				    regval);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int adxl313_read_mag_value(struct adxl313_data *data,
+				  enum iio_event_direction dir,
+				  enum iio_event_info info,
+				  enum adxl313_activity_type type_act,
+				  int *val, int *val2)
+{
+	switch (info) {
+	case IIO_EV_INFO_VALUE:
+		return _adxl313_read_mag_value(data, dir,
+					       type_act,
+					       val, val2);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int adxl313_write_mag_value(struct adxl313_data *data,
+				   enum iio_event_direction dir,
+				   enum iio_event_info info,
+				   enum adxl313_activity_type type_act,
+				   int val, int val2)
+{
+	switch (info) {
+	case IIO_EV_INFO_VALUE:
+		return _adxl313_write_mag_value(data, dir,
+						type_act,
+						val, val2);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int adxl313_read_event_value(struct iio_dev *indio_dev,
+				    const struct iio_chan_spec *chan,
+				    enum iio_event_type type,
+				    enum iio_event_direction dir,
+				    enum iio_event_info info,
+				    int *val, int *val2)
+{
+	struct adxl313_data *data = iio_priv(indio_dev);
+
+	switch (type) {
+	case IIO_EV_TYPE_MAG:
+		return adxl313_read_mag_value(data, dir, info,
+					      ADXL313_ACTIVITY,
+					      val, val2);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int adxl313_write_event_value(struct iio_dev *indio_dev,
+				     const struct iio_chan_spec *chan,
+				     enum iio_event_type type,
+				     enum iio_event_direction dir,
+				     enum iio_event_info info,
+				     int val, int val2)
+{
+	struct adxl313_data *data = iio_priv(indio_dev);
+
+	switch (type) {
+	case IIO_EV_TYPE_MAG:
+		return adxl313_write_mag_value(data, dir, info,
+					       ADXL313_ACTIVITY,
+					       val, val2);
+	default:
+		return -EINVAL;
+	}
+}
+
 static int adxl313_set_watermark(struct iio_dev *indio_dev, unsigned int value)
 {
 	struct adxl313_data *data = iio_priv(indio_dev);
@@ -508,6 +788,25 @@ static int adxl313_fifo_push(struct iio_dev *indio_dev, int samples)
 	return 0;
 }
 
+static int adxl313_push_events(struct iio_dev *indio_dev, int int_stat)
+{
+	s64 ts = iio_get_time_ns(indio_dev);
+	int ret = -ENOENT;
+
+	if (FIELD_GET(ADXL313_INT_ACTIVITY, int_stat)) {
+		ret = iio_push_event(indio_dev,
+				     IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
+							IIO_MOD_X_OR_Y_OR_Z,
+							IIO_EV_TYPE_MAG,
+							IIO_EV_DIR_RISING),
+				     ts);
+		if (ret)
+			return ret;
+	}
+
+	return ret;
+}
+
 static irqreturn_t adxl313_irq_handler(int irq, void *p)
 {
 	struct iio_dev *indio_dev = p;
@@ -517,6 +816,16 @@ static irqreturn_t adxl313_irq_handler(int irq, void *p)
 	if (regmap_read(data->regmap, ADXL313_REG_INT_SOURCE, &int_stat))
 		return IRQ_NONE;
 
+	/*
+	 * In cases of sensor events not handled (still not implemented) by
+	 * this driver, the FIFO needs to be drained to become operational
+	 * again. In general the sensor configuration only should issue events
+	 * which were configured by this driver. Anyway a miss-configuration
+	 * easily might end up in a hanging sensor FIFO.
+	 */
+	if (adxl313_push_events(indio_dev, int_stat))
+		goto err;
+
 	if (FIELD_GET(ADXL313_INT_WATERMARK, int_stat)) {
 		samples = adxl313_get_samples(data);
 		if (samples < 0)
@@ -550,6 +859,10 @@ static int adxl313_reg_access(struct iio_dev *indio_dev, unsigned int reg,
 static const struct iio_info adxl313_info = {
 	.read_raw	= adxl313_read_raw,
 	.write_raw	= adxl313_write_raw,
+	.read_event_config = adxl313_read_event_config,
+	.write_event_config = adxl313_write_event_config,
+	.read_event_value = adxl313_read_event_value,
+	.write_event_value = adxl313_write_event_value,
 	.read_avail	= adxl313_read_freq_avail,
 	.hwfifo_set_watermark = adxl313_set_watermark,
 	.debugfs_reg_access = &adxl313_reg_access,
@@ -687,6 +1000,19 @@ int adxl313_core_probe(struct device *dev,
 		if (ret)
 			return ret;
 
+		/*
+		 * Reset or configure the registers with reasonable default
+		 * values. As having 0 in most cases may result in undesirable
+		 * behavior if the interrupts are enabled.
+		 */
+		ret = regmap_write(data->regmap, ADXL313_REG_ACT_INACT_CTL, 0x00);
+		if (ret)
+			return ret;
+
+		ret = regmap_write(data->regmap, ADXL313_REG_THRESH_ACT, 0x52);
+		if (ret)
+			return ret;
+
 		ret = devm_iio_kfifo_buffer_setup(dev, indio_dev,
 						  &adxl313_buffer_ops);
 		if (ret)
-- 
2.39.5


