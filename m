Return-Path: <linux-iio+bounces-19416-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF9CAB25A9
	for <lists+linux-iio@lfdr.de>; Sun, 11 May 2025 00:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EB9D1B60DC2
	for <lists+linux-iio@lfdr.de>; Sat, 10 May 2025 22:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7BF223335;
	Sat, 10 May 2025 22:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CbGBJNeb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC1E213E8E;
	Sat, 10 May 2025 22:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746917090; cv=none; b=C5+uGwW0RlYH6sLDltIOyx35uZkALy5oHPSkp1qZhLJ75H7zjoUj1hpCZ9g0Bh1BSaXYTNRgMhw3dT4c8SmIpYUahLuR4eQYU7tOaAOKcdzqNiV0LXPGuPvyR2ArobxWrjadhnkW+OTNAVNyjHOLxnz9/WUcOlPhpc5G7JLC4PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746917090; c=relaxed/simple;
	bh=4cCrXv7PqnLYXsDYHVGS4wgMfsUAbmAFmbPpeLAblRg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DY1dokuITTj8S8j3us3f+w0CfyAQX9THR7DpThVEMbbEI1zo3fb03ZN8YfGbti3mmjOoT8A6I/mXYkR+C7Ab0yDQwH/zE1Xp/hPTXItEEi/F526oUrn7fwKSmEoebHeGRAMIXcY0NGKwVTfN54vRibGL3mMdEIVCg82yxIvUsCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CbGBJNeb; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a0b201faedso317717f8f.0;
        Sat, 10 May 2025 15:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746917087; x=1747521887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lqzm7oJMiOVQKzBfgE1ECHlMCNzrhjvmVtbI/5TygPE=;
        b=CbGBJNeb2ujoo2BDqS0xwe2ONWqnEn4onS/+SbCloAjy36BlyCxRR2jbteF2vLVofD
         JRT7CWPdepXncvbW7ybtMr/kuRTnRvWOqk7rARNs7TSaXJuHGEn0AU84hq2TnM4v7v/Y
         Fc40EOJjd/umy4kIlITjtgvloStjPHwTpE6rM2l46hl6JPBbjctaDAsZrOuSjQ53XuSQ
         X/HjWT1YGDjPdNA155lb4NsyGAtERjxnv9y2NzdmEFQVoVGu0Fw2aYN888wdY9dNJeEK
         rwpOUfwtyaPcMI3gghRlg6+dQfKyu3FnWqHTeWAXKSQzxaFY1hdNj5sLPjm6+udyTCtv
         jgmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746917087; x=1747521887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lqzm7oJMiOVQKzBfgE1ECHlMCNzrhjvmVtbI/5TygPE=;
        b=Bx38xS/EyhJBW7qMFaCsWJYQ8nW9OFRMcMlDopzCv5Fp9wQP3S4hAQAsOlHA1YObH+
         EIib/mB4fw5KhwCzPaQRYlkMmXdmnDwaVitDHQYj597OnsXA9bZt8DW2F60GXBdFXwQA
         ST260AAA3hCic8VG5lk0d1clC2ggtQv+ee2s7gOI2VVQLXx+LrGvW5RtWDVOyxAdZL/n
         fOgqFaAWmb1uzMRyxqCplYfoW/zYUnqPL1/qLwizd22OGifjRSt79CKFX+/1y88JIVm5
         gtgD+bh3ipJKDzV/Pyes2OIgozCu0jnVJpOnHd1H7F0gRP/HWm7JU9E59lC0oTPStqOB
         nLXA==
X-Forwarded-Encrypted: i=1; AJvYcCVgrnSQ27TTR1alJ2feU37HJCLRn4HzcXrHvedQb6h/MKKa67Ut4JZQhGBMI8YXnmrEMvWiY2kxlaXb3c4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR4d9uDcGl26+Aq+0GzuEFqqUc3G981YNXKbtpxH8cgdv5JpBw
	joE49an3Gurpcp92vnEYNSzqKzFDFDbCkg2m6NMD2zeusgZqEFYpON9jVg/f
X-Gm-Gg: ASbGnctFKp1n62mDHuufktea6ZumDhDZYOiOQRsajpgDMXyFayuM5yEYB+zkn9lVp1+
	H+NTkFkvty4FuYThnPTvsAqjmrq+UE0yjX2nqkWwKhhx9ksXj3wpMpUZrCbpPn9GU/KvjgR9e3W
	Hu2LIvDXY0AsRh+QaxzGbzWE/LvFt+XWBu6IemoxFGLlDar6tkIib527zWhEN8+O1N2moLMhGz6
	F4sVtQQ93q/bR1u4p8OwCPy/mLzuaXkSfhTbx8GNr1e8MMqdd5OFkZSHw0kdkd3za53dKacj020
	LtwYyV35/QB/u5rHZok7hgRskVXRUWkP0YdDdYvzDXYQ1XznDdd18LqRgb3WBf5LtpAtD6tYpnE
	TIDD8EtTNO05oujNrH7Ag9Q==
X-Google-Smtp-Source: AGHT+IGOoGKVI9My26N4X2o7qC0/7+Tn1hXKo7wzVGhHRzdNRMkwTzgd2WCEhkLC/4nVJSemV/lVvw==
X-Received: by 2002:a05:6000:2011:b0:39c:1efb:ee87 with SMTP id ffacd0b85a97d-3a1f648123fmr2195792f8f.12.1746917086865;
        Sat, 10 May 2025 15:44:46 -0700 (PDT)
Received: from localhost.localdomain (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f58f2f65sm7701015f8f.55.2025.05.10.15.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 May 2025 15:44:45 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v8 6/7] iio: accel: adxl345: add freefall feature
Date: Sat, 10 May 2025 22:44:04 +0000
Message-Id: <20250510224405.17910-7-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250510224405.17910-1-l.rubusch@gmail.com>
References: <20250510224405.17910-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the freefall detection of the sensor together with a threshold and
time parameter. A freefall magnitude event is detected if the measuring
signal falls below the threshold.

Introduce a freefall threshold stored in regmap cache, and a freefall
time, having the scaled time value stored as a member variable in the
state instance.

The generated IIO event is a magnitude event on x&y&z and thus identical
to what inactivity (with DC-coupling default) would generate. Thus a
separate set of sysfs handles are setup to configure and enable freefall
events.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 226 +++++++++++++++++++++++++++++++
 1 file changed, 226 insertions(+)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index c6f75d6b0db9..c35a5727852c 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -193,6 +193,7 @@ struct adxl345_state {
 	u32 tap_duration_us;
 	u32 tap_latent_us;
 	u32 tap_window_us;
+	u32 ff_time_ms;
 
 	__le16 fifo_buf[ADXL345_DIRS * ADXL345_FIFO_SIZE + 1] __aligned(IIO_DMA_MINALIGN);
 };
@@ -825,6 +826,63 @@ static int adxl345_set_tap_latent(struct adxl345_state *st, u32 val_int,
 	return _adxl345_set_tap_time(st, ADXL345_TAP_TIME_LATENT, val_fract_us);
 }
 
+/* free-fall */
+
+static int adxl345_is_ff_en(struct adxl345_state *st, bool *en)
+{
+	int ret;
+	unsigned int regval;
+
+	ret = regmap_read(st->regmap, ADXL345_REG_INT_ENABLE, &regval);
+	if (ret)
+		return ret;
+
+	*en = FIELD_GET(ADXL345_INT_FREE_FALL, regval) > 0;
+
+	return 0;
+}
+
+static int adxl345_set_ff_en(struct adxl345_state *st, bool cmd_en)
+{
+	unsigned int regval, ff_threshold;
+	bool en;
+	int ret;
+
+	ret = regmap_read(st->regmap, ADXL345_REG_THRESH_FF, &ff_threshold);
+	if (ret)
+		return ret;
+
+	en = cmd_en && ff_threshold > 0 && st->ff_time_ms > 0;
+
+	regval = en ? ADXL345_INT_FREE_FALL : 0x00;
+
+	return regmap_update_bits(st->regmap, ADXL345_REG_INT_ENABLE,
+				  ADXL345_INT_FREE_FALL, regval);
+}
+
+static int adxl345_set_ff_time(struct adxl345_state *st, u32 val_int,
+			       u32 val_fract_us)
+{
+	unsigned int regval;
+	int val_ms;
+
+	/*
+	 * max value is 255 * 5000 us = 1.275000 seconds
+	 *
+	 * Note: the scaling is similar to the scaling in the ADXL380
+	 */
+	if (1000000 * val_int + val_fract_us > 1275000)
+		return -EINVAL;
+
+	val_ms = val_int * 1000 + DIV_ROUND_UP(val_fract_us, 1000);
+	st->ff_time_ms = val_ms;
+
+	regval = DIV_ROUND_CLOSEST(val_ms, 5);
+
+	/* Values between 100ms and 350ms (0x14 to 0x46) are recommended. */
+	return regmap_write(st->regmap, ADXL345_REG_TIME_FF, min(regval, 0xff));
+}
+
 static int adxl345_find_odr(struct adxl345_state *st, int val,
 			    int val2, enum adxl345_odr *odr)
 {
@@ -1689,6 +1747,17 @@ static int adxl345_push_event(struct iio_dev *indio_dev, int int_stat,
 			return ret;
 	}
 
+	if (FIELD_GET(ADXL345_INT_FREE_FALL, int_stat)) {
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
 	if (FIELD_GET(ADXL345_INT_WATERMARK, int_stat)) {
 		samples = adxl345_get_samples(st);
 		if (samples < 0)
@@ -1763,7 +1832,156 @@ static irqreturn_t adxl345_irq_handler(int irq, void *p)
 	return IRQ_HANDLED;
 }
 
+/* free-fall sysfs */
+
+static ssize_t in_accel_mag_freefall_en_show(struct device *dev,
+					     struct device_attribute *attr,
+					     char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct adxl345_state *st = iio_priv(indio_dev);
+	bool en;
+	int val, ret;
+
+	ret = adxl345_is_ff_en(st, &en);
+	if (ret)
+		return ret;
+
+	val = en ? 1 : 0;
+
+	return iio_format_value(buf, IIO_VAL_INT, 1, &val);
+}
+
+static ssize_t in_accel_mag_freefall_en_store(struct device *dev,
+					      struct device_attribute *attr,
+					      const char *buf, size_t len)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct adxl345_state *st = iio_priv(indio_dev);
+	int val, ret;
+
+	ret = kstrtoint(buf, 0, &val);
+	if (ret)
+		return ret;
+
+	ret = adxl345_set_measure_en(st, false);
+	if (ret)
+		return ret;
+
+	ret = adxl345_set_ff_en(st, val > 0);
+	if (ret)
+		return ret;
+
+	ret = adxl345_set_measure_en(st, true);
+	if (ret)
+		return ret;
+
+	return len;
+}
+static IIO_DEVICE_ATTR_RW(in_accel_mag_freefall_en, 0);
+
+static ssize_t in_accel_mag_freefall_value_show(struct device *dev,
+						struct device_attribute *attr,
+						char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct adxl345_state *st = iio_priv(indio_dev);
+	unsigned int val;
+	int ret;
+
+	ret = regmap_read(st->regmap, ADXL345_REG_THRESH_FF, &val);
+	if (ret)
+		return ret;
+
+	return iio_format_value(buf, IIO_VAL_INT, 1, &val);
+}
+
+static ssize_t in_accel_mag_freefall_value_store(struct device *dev,
+						 struct device_attribute *attr,
+						 const char *buf, size_t len)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct adxl345_state *st = iio_priv(indio_dev);
+	int val, ret;
+
+	ret = kstrtoint(buf, 0, &val);
+	if (ret)
+		return ret;
+
+	if (val < 0 || val > 255)
+		return -EINVAL;
+
+	ret = adxl345_set_measure_en(st, false);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(st->regmap, ADXL345_REG_THRESH_FF, val);
+	if (ret)
+		return ret;
+
+	ret = adxl345_set_measure_en(st, true);
+	if (ret)
+		return ret;
+
+	return len;
+}
+static IIO_DEVICE_ATTR_RW(in_accel_mag_freefall_value, 0);
+
+static ssize_t in_accel_mag_freefall_period_show(struct device *dev,
+						 struct device_attribute *attr,
+						 char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct adxl345_state *st = iio_priv(indio_dev);
+	int vals[2];
+
+	vals[0] = st->ff_time_ms;
+	vals[1] = 1000;
+
+	return iio_format_value(buf, IIO_VAL_FRACTIONAL, 2, vals);
+}
+
+static ssize_t in_accel_mag_freefall_period_store(struct device *dev,
+						  struct device_attribute *attr,
+						  const char *buf, size_t len)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct adxl345_state *st = iio_priv(indio_dev);
+	int val_int, val_fract_us, ret;
+
+	ret = iio_str_to_fixpoint(buf, 100000, &val_int, &val_fract_us);
+	if (ret)
+		return ret;
+
+	ret = adxl345_set_measure_en(st, false);
+	if (ret)
+		return ret;
+
+	ret = adxl345_set_ff_time(st, val_int, val_fract_us);
+	if (ret)
+		return ret;
+
+	ret = adxl345_set_measure_en(st, true);
+	if (ret)
+		return ret;
+
+	return len;
+}
+static IIO_DEVICE_ATTR_RW(in_accel_mag_freefall_period, 0);
+
+static struct attribute *adxl345_event_attrs[] = {
+	&iio_dev_attr_in_accel_mag_freefall_en.dev_attr.attr,
+	&iio_dev_attr_in_accel_mag_freefall_value.dev_attr.attr,
+	&iio_dev_attr_in_accel_mag_freefall_period.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group adxl345_event_attrs_group = {
+	.attrs = adxl345_event_attrs,
+};
+
 static const struct iio_info adxl345_info = {
+	.event_attrs    = &adxl345_event_attrs_group,
 	.read_raw	= adxl345_read_raw,
 	.write_raw	= adxl345_write_raw,
 	.read_avail	= adxl345_read_avail,
@@ -1806,6 +2024,7 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 					 ADXL345_DATA_FORMAT_FULL_RES |
 					 ADXL345_DATA_FORMAT_SELF_TEST);
 	unsigned int tap_threshold;
+	unsigned int ff_threshold;
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
@@ -1825,6 +2044,9 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 	st->tap_window_us = 64;			/*   64 [0x40] -> .080    */
 	st->tap_latent_us = 16;			/*   16 [0x10] -> .020    */
 
+	ff_threshold = 8;			/*    8 [0x08]            */
+	st->ff_time_ms = 32;			/*   32 [0x20] -> 0.16    */
+
 	indio_dev->name = st->info->name;
 	indio_dev->info = &adxl345_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
@@ -1936,6 +2158,10 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 		if (ret)
 			return ret;
 
+		ret = regmap_write(st->regmap, ADXL345_REG_THRESH_FF, ff_threshold);
+		if (ret)
+			return ret;
+
 		/* FIFO_STREAM mode is going to be activated later */
 		ret = devm_iio_kfifo_buffer_setup(dev, indio_dev, &adxl345_buffer_ops);
 		if (ret)
-- 
2.39.5


