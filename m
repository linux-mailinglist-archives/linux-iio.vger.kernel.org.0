Return-Path: <linux-iio+bounces-10877-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A0AF9A6990
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2024 15:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA64528388F
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2024 13:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879D71F12FA;
	Mon, 21 Oct 2024 13:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="B6Jhw/P7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0661F9AAA
	for <linux-iio@vger.kernel.org>; Mon, 21 Oct 2024 13:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729515770; cv=none; b=CAPHsofyoOwP4ui9r7r1dt2vhMxbWfkUjmon7KXf3pZqv+6tthuVVAsqr6/rG/T+VrFBkcAAVvbF3bEI8Xgdb+C4hIuGexnTC1OvZHOQpnUww0/M2tIDc/yra5tRXt6BfS/YOCgC6koMPKQUHrPDCQleVx24vwc4CTgNSvtcsbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729515770; c=relaxed/simple;
	bh=oGAAGK33rN6lVMDA+tGG6MD/gh3DQW+kiA2XkZMVS0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TUXyvGq+LbX9R00u9AzYpWP7+oeKjEtar7LMaaEFqJ9vhfHyTuDglTFuzYcbOB47QWVJExc2np7WjM1p6P/z1upJ3Ohgq0+2TQVdEBa4b6Evrud5M4vVE7ELRQn0QTjufpjeB2aFSmoMz8MdC+jbN/7pYvfLSAuXpmT4snSWy0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=B6Jhw/P7; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a9a0cee600aso561172166b.1
        for <linux-iio@vger.kernel.org>; Mon, 21 Oct 2024 06:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729515765; x=1730120565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FRkM0XwtKZDbCSKn99mRdzWAKJPxnYQCvEvKP5OzOgU=;
        b=B6Jhw/P77M7h8JY19BYu69NMpjC4Vr3JYCk2WPBA6j9XksQJTWNwMniyc4TkGxkYu3
         IwNhDrkuAoRMd0LCvpkuMV9Ldmuo5PnpQohpt9LZYOBpBgcjMw+KGwIOiKn5tDEOpSrB
         LmkPs5KmxesCoy57256SARssbz1fJtA63rmG1ELS3V24XHfr58ZC7mYn8NCufTR8TqBX
         CxWqsUzTAv3ezW43oEYq7HkWkcpAd0EU2dVQzoLgPkLSSAG9pe6PxXkcedWvHo3mnCdI
         rA1t64VTJI1qOSKA1SHB4BBaHzch/k0WpkSK77YElXJR3NsH5rnaCdt2BJmd5V4AlFf4
         60HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729515765; x=1730120565;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FRkM0XwtKZDbCSKn99mRdzWAKJPxnYQCvEvKP5OzOgU=;
        b=iAoJ6aeExeUHyozmIRVnjFOo4qp9Y3gXqy+scgPY5tDAAi1TKZpR3m552N3bd9PXl+
         A/FF5wOaDKskYcdYJlz+XzhMdQi3xxFOUCpp66Y0F2l8IWRyTsR102dvNm5SPY6c4fa+
         K8sF8tRExxHH+GBBlQW3nJfeYo+YQc8bf6E8ANnQR64g3Ulb3IlKflFN/a1dk/2HxpSW
         IxN46cIf0lL6D5QXaIt2FW66KGu/qMWibzGbNLYfFqbG8L+kvm56NQe3KRNvWkBqtP5o
         eMtxM8r9A0TB3ycmr8tu1Xu3MEtWUQPM/AKHT/nt3CTjq0USCRLxxDixBfjdJC1DI3kt
         YOtg==
X-Gm-Message-State: AOJu0YzpDkMtTI2Gk4PgNGHr8KXmjCchjZ8nYq/BvvBrP561drP0uB7d
	njzVVh+4s+Uswv0ZMSAVU7uX76IA3RK6pndTCcBU5ZkX5xCmbdUnsioxqLA5tM2fQX+iAAPRdbs
	mkV8=
X-Google-Smtp-Source: AGHT+IFCFTYPvRkNohH2NScP5QOQ8P4j7zJ8kE0hLDY5hhwiho26NPw9+Y6IaAkMsV1wcnV8+sabuQ==
X-Received: by 2002:a17:907:1b98:b0:a9a:7f34:351b with SMTP id a640c23a62f3a-a9a7f343622mr500996166b.3.1729515765413;
        Mon, 21 Oct 2024 06:02:45 -0700 (PDT)
Received: from neptune.lan ([188.27.132.100])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a91370e33sm202310366b.120.2024.10.21.06.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 06:02:45 -0700 (PDT)
From: Alexandru Ardelean <aardelean@baylibre.com>
To: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: jic23@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	lars@metafoo.de,
	michael.hennerich@analog.com,
	gstols@baylibre.com,
	dlechner@baylibre.com,
	Alexandru Ardelean <aardelean@baylibre.com>
Subject: [PATCH 4/6] iio: adc: ad7606: rework scale-available to be static
Date: Mon, 21 Oct 2024 16:02:19 +0300
Message-ID: <20241021130221.1469099-5-aardelean@baylibre.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241021130221.1469099-1-aardelean@baylibre.com>
References: <20241021130221.1469099-1-aardelean@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The main driver for this change is the AD7607 part, which has a scale of
"1.220703" for the ±10V range. The AD7607 has a resolution of 14-bits.

So, just adding the scale-available list for that part would require some
quirks to handle just that scale value.
But to do it more neatly, the best approach is to rework the scale
available lists to have the same format as it is returned to userspace.
That way, we can also get rid of the allocation for the 'scale_avail_show'
array.

Signed-off-by: Alexandru Ardelean <aardelean@baylibre.com>
---
 drivers/iio/adc/ad7606.c | 106 ++++++++++++++++++---------------------
 drivers/iio/adc/ad7606.h |   6 +--
 2 files changed, 50 insertions(+), 62 deletions(-)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index a1f0c2feb04a..115c27ae02f3 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -33,42 +33,44 @@
 
 /*
  * Scales are computed as 5000/32768 and 10000/32768 respectively,
- * so that when applied to the raw values they provide mV values
+ * so that when applied to the raw values they provide mV values.
+ * The scale arrays are kept as IIO_VAL_INT_PLUS_MICRO, so index
+ * X is the integer part and X + 1 is the fractional part.
  */
-static const unsigned int ad7606_16bit_hw_scale_avail[2] = {
-	152588, 305176
+static const unsigned int ad7606_16bit_hw_scale_avail[2][2] = {
+	{ 0, 152588 }, { 0, 305176 }
 };
 
-static const unsigned int ad7606_18bit_hw_scale_avail[2] = {
-	38147, 76294
+static const unsigned int ad7606_18bit_hw_scale_avail[2][2] = {
+	{ 0, 38147 }, { 0, 76294 }
 };
 
-static const unsigned int ad7606c_16bit_single_ended_unipolar_scale_avail[3] = {
-	76294, 152588, 190735,
+static const unsigned int ad7606c_16bit_single_ended_unipolar_scale_avail[3][2] = {
+	{ 0, 76294 }, { 0, 152588 }, { 0, 190735 }
 };
 
-static const unsigned int ad7606c_16bit_single_ended_bipolar_scale_avail[5] = {
-	76294, 152588, 190735, 305176, 381470
+static const unsigned int ad7606c_16bit_single_ended_bipolar_scale_avail[5][2] = {
+	{ 0, 76294 }, { 0, 152588 }, { 0, 190735 }, { 0, 305176 }, { 0, 381470 }
 };
 
-static const unsigned int ad7606c_16bit_differential_bipolar_scale_avail[4] = {
-	152588, 305176, 381470, 610352
+static const unsigned int ad7606c_16bit_differential_bipolar_scale_avail[4][2] = {
+	{ 0, 152588 }, { 0, 305176 }, { 0, 381470 }, { 0, 610352 }
 };
 
-static const unsigned int ad7606c_18bit_single_ended_unipolar_scale_avail[3] = {
-	19073, 38147, 47684
+static const unsigned int ad7606c_18bit_single_ended_unipolar_scale_avail[3][2] = {
+	{ 0, 19073 }, { 0, 38147 }, { 0, 47684 }
 };
 
-static const unsigned int ad7606c_18bit_single_ended_bipolar_scale_avail[5] = {
-	19073, 38147, 47684, 76294, 95367
+static const unsigned int ad7606c_18bit_single_ended_bipolar_scale_avail[5][2] = {
+	{ 0, 19073 }, { 0, 38147 }, { 0, 47684 }, { 0, 76294 }, { 0, 95367 }
 };
 
-static const unsigned int ad7606c_18bit_differential_bipolar_scale_avail[4] = {
-	38147, 76294, 95367, 152588
+static const unsigned int ad7606c_18bit_differential_bipolar_scale_avail[4][2] = {
+	{ 0, 38147 }, { 0, 76294 }, { 0, 95367 }, { 0, 152588 }
 };
 
-static const unsigned int ad7606_16bit_sw_scale_avail[3] = {
-	76293, 152588, 305176
+static const unsigned int ad7606_16bit_sw_scale_avail[3][2] = {
+	{ 0, 76293 }, { 0, 152588 }, { 0, 305176 }
 };
 
 static const unsigned int ad7606_oversampling_avail[7] = {
@@ -663,8 +665,8 @@ static int ad7606_read_raw(struct iio_dev *indio_dev,
 		if (st->sw_mode_en)
 			ch = chan->address;
 		cs = &st->chan_scales[ch];
-		*val = 0;
-		*val2 = cs->scale_avail[cs->range];
+		*val = cs->scale_avail[cs->range][0];
+		*val2 = cs->scale_avail[cs->range][1];
 		return IIO_VAL_INT_PLUS_MICRO;
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
 		*val = st->oversampling;
@@ -681,21 +683,6 @@ static int ad7606_read_raw(struct iio_dev *indio_dev,
 	return -EINVAL;
 }
 
-static ssize_t ad7606_show_avail(char *buf, const unsigned int *vals,
-				 unsigned int n, bool micros)
-{
-	size_t len = 0;
-	int i;
-
-	for (i = 0; i < n; i++) {
-		len += scnprintf(buf + len, PAGE_SIZE - len,
-			micros ? "0.%06u " : "%u ", vals[i]);
-	}
-	buf[len - 1] = '\n';
-
-	return len;
-}
-
 static ssize_t in_voltage_scale_available_show(struct device *dev,
 					       struct device_attribute *attr,
 					       char *buf)
@@ -703,8 +690,16 @@ static ssize_t in_voltage_scale_available_show(struct device *dev,
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ad7606_state *st = iio_priv(indio_dev);
 	struct ad7606_chan_scale *cs = &st->chan_scales[0];
+	const unsigned int (*vals)[2] = cs->scale_avail;
+	unsigned int i;
+	size_t len = 0;
 
-	return ad7606_show_avail(buf, cs->scale_avail, cs->num_scales, true);
+	for (i = 0; i < cs->num_scales; i++)
+		len += scnprintf(buf + len, PAGE_SIZE - len, "%u.%06u ",
+				 vals[i][0], vals[i][1]);
+	buf[len - 1] = '\n';
+
+	return len;
 }
 
 static IIO_DEVICE_ATTR_RO(in_voltage_scale_available, 0);
@@ -742,6 +737,7 @@ static int ad7606_write_raw(struct iio_dev *indio_dev,
 			    long mask)
 {
 	struct ad7606_state *st = iio_priv(indio_dev);
+	unsigned int scale_avail[AD760X_MAX_SCALES];
 	struct ad7606_chan_scale *cs;
 	int i, ret, ch = 0;
 
@@ -752,7 +748,12 @@ static int ad7606_write_raw(struct iio_dev *indio_dev,
 		if (st->sw_mode_en)
 			ch = chan->address;
 		cs = &st->chan_scales[ch];
-		i = find_closest(val2, cs->scale_avail, cs->num_scales);
+		for (i = 0; i < cs->num_scales; i++) {
+			scale_avail[i] = cs->scale_avail[i][0] * 1000000 +
+					 cs->scale_avail[i][1];
+		}
+		val = val * 1000000 + val2;
+		i = find_closest(val, scale_avail, cs->num_scales);
 		ret = st->write_scale(indio_dev, ch, i + cs->reg_offset);
 		if (ret < 0)
 			return ret;
@@ -788,9 +789,15 @@ static ssize_t ad7606_oversampling_ratio_avail(struct device *dev,
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ad7606_state *st = iio_priv(indio_dev);
+	const unsigned int *vals = st->oversampling_avail;
+	unsigned int i;
+	size_t len = 0;
 
-	return ad7606_show_avail(buf, st->oversampling_avail,
-				 st->num_os_ratios, false);
+	for (i = 0; i < st->num_os_ratios; i++)
+		len += scnprintf(buf + len, PAGE_SIZE - len, "%u ", vals[i]);
+	buf[len - 1] = '\n';
+
+	return len;
 }
 
 static IIO_DEVICE_ATTR(oversampling_ratio_available, 0444,
@@ -944,8 +951,8 @@ static int ad7606_read_avail(struct iio_dev *indio_dev,
 			ch = chan->address;
 
 		cs = &st->chan_scales[ch];
-		*vals = cs->scale_avail_show;
-		*length = cs->num_scales * 2;
+		*vals = (int *)cs->scale_avail;
+		*length = cs->num_scales;
 		*type = IIO_VAL_INT_PLUS_MICRO;
 
 		return IIO_AVAIL_LIST;
@@ -1068,24 +1075,9 @@ static int ad7606_chan_scales_setup(struct iio_dev *indio_dev)
 	indio_dev->channels = chans;
 
 	for (ch = 0; ch < num_channels; ch++) {
-		struct ad7606_chan_scale *cs;
-		int i;
-
 		ret = st->chip_info->scale_setup_cb(st, &chans[ch + 1], ch);
 		if (ret)
 			return ret;
-
-		cs = &st->chan_scales[ch];
-
-		if (cs->num_scales * 2 > AD760X_MAX_SCALE_SHOW)
-			return dev_err_probe(st->dev, -ERANGE,
-					"Driver error: scale range too big");
-
-		/* Generate a scale_avail list for showing to userspace */
-		for (i = 0; i < cs->num_scales; i++) {
-			cs->scale_avail_show[i * 2] = 0;
-			cs->scale_avail_show[i * 2 + 1] = cs->scale_avail[i];
-		}
 	}
 
 	return 0;
diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
index 2c629a15cc33..32c6f776c5df 100644
--- a/drivers/iio/adc/ad7606.h
+++ b/drivers/iio/adc/ad7606.h
@@ -103,8 +103,6 @@ struct ad7606_chip_info {
 /**
  * struct ad7606_chan_scale - channel scale configuration
  * @scale_avail		pointer to the array which stores the available scales
- * @scale_avail_show	a duplicate of 'scale_avail' which is readily formatted
- *			such that it can be read via the 'read_avail' hook
  * @num_scales		number of elements stored in the scale_avail array
  * @range		voltage range selection, selects which scale to apply
  * @reg_offset		offset for the register value, to be applied when
@@ -112,9 +110,7 @@ struct ad7606_chip_info {
  */
 struct ad7606_chan_scale {
 #define AD760X_MAX_SCALES		16
-#define AD760X_MAX_SCALE_SHOW		(AD760X_MAX_SCALES * 2)
-	const unsigned int		*scale_avail;
-	int				scale_avail_show[AD760X_MAX_SCALE_SHOW];
+	const unsigned int		(*scale_avail)[2];
 	unsigned int			num_scales;
 	unsigned int			range;
 	unsigned int			reg_offset;
-- 
2.46.1


