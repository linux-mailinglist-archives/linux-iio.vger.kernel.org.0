Return-Path: <linux-iio+bounces-12491-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FCDD9D5E38
	for <lists+linux-iio@lfdr.de>; Fri, 22 Nov 2024 12:34:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2028B1F22863
	for <lists+linux-iio@lfdr.de>; Fri, 22 Nov 2024 11:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4611A1DEFEC;
	Fri, 22 Nov 2024 11:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="yP6fEfFl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F6A1DE2D2
	for <linux-iio@vger.kernel.org>; Fri, 22 Nov 2024 11:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732275255; cv=none; b=LoHCWChNjbL+MmK1Uiop5bT6m3oRz//L5489UDP7/rjzvg3SEYlMFHOkIoDyEwHlG4Z0eBnGRq6K5YYhnZ8DhQKcByQAs33NB2FB8QTZCFtTrjoo/CdYGxdXKEyzIiQk2ak+mUwQIg+SrhEWW0CQL8l4SOY3AxsUdimRPtOv1yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732275255; c=relaxed/simple;
	bh=PI4yG6hlMtn0hGT5tdLHdWzfD1TnQ5AET3d93n7IC0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CQjeUOS4iVR/ycbRQQbkKH6D63F5QqPaGNI3D+/u7P2FnJRPPvPMDAY+h2VP5/UM0C7LWEcY9RgXJYmUi6/6U+MPCwHOVEQd38idqH5wwagSwdH0K4nKY8jXF2AG2qOWnBF/aM4qoOPQEkWOrsfCKtZq8Eywiz//s5/XpiYo9wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=yP6fEfFl; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4315c1c7392so17770555e9.1
        for <linux-iio@vger.kernel.org>; Fri, 22 Nov 2024 03:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732275251; x=1732880051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aImMVIoDCJV/necVEO2W3Ydiej1efSt7pClu8GIF/kY=;
        b=yP6fEfFluByaVcpJyrQl67HXR+SXnYlJtkxp1b9wAsi6yk9ZDFTgc5vhpQqkX0i9vQ
         iHv8xtgXSHjuqRcAVgb3Tp8IeeJZwp6ZSi+Svz9DflInlPcDftUBXY7oG2qoJwHPhuAl
         pK4+ihueudUFSwigwPPu+spTPhoG0OHElLzeN3PoVByc43hMj+UkSWBychNl5xhdKlXb
         J0oSAgmaY7k7Og9vEyUayI65E/xfM+y7st2I+oj5i6y/arkq81NM3wVmAhZ7p0QZK4Tq
         47tQJks1oxPM6QTZNroZ4tL7sZ1Vj1fPsgS2Um+Sz94zH8p3QFSukWQAtl+g8FcUo8Nj
         D4Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732275251; x=1732880051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aImMVIoDCJV/necVEO2W3Ydiej1efSt7pClu8GIF/kY=;
        b=TpQD6x1bYUZ5zgsWrI4B6Ss5W4ClZMBaXmR+nEnsZiRHg4MIEfLptOU5zhlgX1uIw7
         jmMiz+BlZnvXnrnky6nlUDFV/G9gK/A+e8wI13MKFDKCDS3ZaUe8TnhT4KGyjtaMiiSt
         JbvRajIHXz1v5n8cS6ad3oI6wADdo6QRfWk2w06ytyuyk2xXkeGA4Yhpw9DcicsrQsMx
         o2/gItvnLrxOJKAc9SHjmhksaqVADYFM/0qDrUmNjg45TrrEQ+mwuUBTs4ahM8nw9/EZ
         0w7q4gcAIeQczP5wgM+J8Jw+6rc7GzIs1xDunUYU7gQEIXL2TbZHz7+Xk5Br7xOi1gEN
         EHWw==
X-Forwarded-Encrypted: i=1; AJvYcCXqP5AmfTC3IBZD66R993dT2gKrqMBHbMfSQ9yi3mfSvrbjrnexCqQK/no6RlJ2NZuchp8N+zgiqxY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEYAYJkGFa8504YTQER00SJNYR+9WlSg8InqpVhGYXE17SU376
	irfo3uK7gXCWLToL3R9sbfXjbFSJ4icCYQzcn/cVrI0qVKWZaZKedauYbBAuK5E=
X-Gm-Gg: ASbGncsnDHJcy7HigCRjThjLggHSQEYQz+5rVWlYIzAnNWSCeAZES+aJdKPZ9Cvfh4V
	sug2ZTRwc76hHpOxqWCpJnld27nGzTShRF29UijWA5NcFjRDKUM19mhtKFEZNN0APRJY+2jrl5d
	h5KR3WRpjT/rZI44YNkL/4fVGHrquUvzCNB+pFtWMnOBmnsiutjvigN7upqL4F5t+bz3HQ6f23y
	/lmq7W8wWRtt+CQnum0szTZLTLe5MliRR4Oq5LsdRsuivUu1yD8+ObBJvDKVkkQS6G5qwjP1Wa+
	HFU=
X-Google-Smtp-Source: AGHT+IGyt7szAWkUqQfKtP4sBu8OZGgViQ1pDVvv3FvDKH7P0KHSCkcwfMnKhr4UXqohrf6Z8q5P6g==
X-Received: by 2002:a05:600c:46c8:b0:431:52a3:d9d9 with SMTP id 5b1f17b1804b1-433ce39b925mr21997975e9.0.1732275251636;
        Fri, 22 Nov 2024 03:34:11 -0800 (PST)
Received: from localhost (p509159f1.dip0.t-ipconnect.de. [80.145.89.241])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-433b01e117bsm91858495e9.8.2024.11.22.03.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 03:34:11 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>
Cc: Alexandru Ardelean <aardelean@baylibre.com>,
	Alisa-Dariana Roman <alisa.roman@analog.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Dumitru Ceclan <dumitru.ceclan@analog.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Nuno Sa <nuno.sa@analog.com>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH v3 10/10] iio: adc: ad7124: Implement temperature measurement
Date: Fri, 22 Nov 2024 12:33:29 +0100
Message-ID: <20241122113322.242875-22-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241122113322.242875-12-u.kleine-koenig@baylibre.com>
References: <20241122113322.242875-12-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=6041; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=PI4yG6hlMtn0hGT5tdLHdWzfD1TnQ5AET3d93n7IC0Q=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBnQGwcygvvHUQoY2gIX3Lsj1HCS5QV6OXd/RTPZ Z3EnW8IbfyJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZ0BsHAAKCRCPgPtYfRL+ Tt+6CACFtALW3JPtRrnnVLi1m0reiUzmHrypibIP3qZUq65zb4S4HQkXa4MoL/1QoTem8D7vLuJ 1sPab9hWaC+Z+9OyGsHlz7wd/S+cjqWkuEhEVHeHv7tygU7qE1AEUCZ1ZoA2i/gIWqwTavMYSGP OZyrFERagsFc+qcp4+Dhwc2vOTS+MGuFpdVgA4/wz8xIK28ERlx8DnYdbk++mL6fmqZ6W1ZwcRq v5SpxpngrMRV7ZAHnLokh+Fukjuk7otdbtxAXpsr+2RC5OVGmeiVgGAXNiDOdBODBInGK4Xo0/G fnGXLVlFkbCHz1r3u0Ao2bPwsINXp8SL37qJcrgKQ6CkKbiN
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

If the maximal count of channels the driver supports isn't fully
utilized, add an attribute providing the internal temperature.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/iio/adc/ad7124.c | 112 +++++++++++++++++++++++++++++++--------
 1 file changed, 91 insertions(+), 21 deletions(-)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index fdbe2806bf11..3eff156b9c00 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -95,6 +95,10 @@
 #define AD7124_MAX_CONFIGS	8
 #define AD7124_MAX_CHANNELS	16
 
+/* AD7124 input sources */
+#define AD7124_INPUT_TEMPSENSOR	16
+#define AD7124_INPUT_AVSS	17
+
 enum ad7124_ids {
 	ID_AD7124_4,
 	ID_AD7124_8,
@@ -588,39 +592,75 @@ static int ad7124_read_raw(struct iio_dev *indio_dev,
 			return ret;
 
 		return IIO_VAL_INT;
+
 	case IIO_CHAN_INFO_SCALE:
-		mutex_lock(&st->cfgs_lock);
+		switch (chan->type) {
+		case IIO_VOLTAGE:
+			mutex_lock(&st->cfgs_lock);
 
-		idx = st->channels[chan->address].cfg.pga_bits;
-		*val = st->channels[chan->address].cfg.vref_mv;
-		if (st->channels[chan->address].cfg.bipolar)
-			*val2 = chan->scan_type.realbits - 1 + idx;
-		else
-			*val2 = chan->scan_type.realbits + idx;
+			idx = st->channels[chan->address].cfg.pga_bits;
+			*val = st->channels[chan->address].cfg.vref_mv;
+			if (st->channels[chan->address].cfg.bipolar)
+				*val2 = chan->scan_type.realbits - 1 + idx;
+			else
+				*val2 = chan->scan_type.realbits + idx;
+
+			mutex_unlock(&st->cfgs_lock);
+			return IIO_VAL_FRACTIONAL_LOG2;
+
+		case IIO_TEMP:
+			/*
+			 * According to the data sheet
+			 *   Temperature (°C)
+			 * = ((Conversion − 0x800000)/13584) − 272.5
+			 * = (Conversion − 0x800000 - 13584 * 272.5) / 13584
+			 * = (Conversion − 12090248) / 13584
+			 * So scale with 1000/13584 to yield °mC. Reduce by 8 to
+			 * 125/1698.
+			 */
+			*val = 125;
+			*val2 = 1698;
+			return IIO_VAL_FRACTIONAL;
+
+		default:
+			return -EINVAL;
+		}
 
-		mutex_unlock(&st->cfgs_lock);
-		return IIO_VAL_FRACTIONAL_LOG2;
 	case IIO_CHAN_INFO_OFFSET:
-		mutex_lock(&st->cfgs_lock);
-		if (st->channels[chan->address].cfg.bipolar)
-			*val = -(1 << (chan->scan_type.realbits - 1));
-		else
-			*val = 0;
+		switch (chan->type) {
+		case IIO_VOLTAGE:
+			mutex_lock(&st->cfgs_lock);
+			if (st->channels[chan->address].cfg.bipolar)
+				*val = -(1 << (chan->scan_type.realbits - 1));
+			else
+				*val = 0;
+
+			mutex_unlock(&st->cfgs_lock);
+			return IIO_VAL_INT;
+
+		case IIO_TEMP:
+			/* see calculation above */
+			*val = -12090248;
+			return IIO_VAL_INT;
+
+		default:
+			return -EINVAL;
+		}
 
-		mutex_unlock(&st->cfgs_lock);
-		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		mutex_lock(&st->cfgs_lock);
 		*val = st->channels[chan->address].cfg.odr;
 		mutex_unlock(&st->cfgs_lock);
 
 		return IIO_VAL_INT;
+
 	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
 		mutex_lock(&st->cfgs_lock);
 		*val = ad7124_get_3db_filter_freq(st, chan->scan_index);
 		mutex_unlock(&st->cfgs_lock);
 
 		return IIO_VAL_INT;
+
 	default:
 		return -EINVAL;
 	}
@@ -645,6 +685,7 @@ static int ad7124_write_raw(struct iio_dev *indio_dev,
 
 		ad7124_set_channel_odr(st, chan->address, val);
 		break;
+
 	case IIO_CHAN_INFO_SCALE:
 		if (val != 0) {
 			ret = -EINVAL;
@@ -666,6 +707,7 @@ static int ad7124_write_raw(struct iio_dev *indio_dev,
 
 		st->channels[chan->address].cfg.pga_bits = res;
 		break;
+
 	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
 		if (val2 != 0) {
 			ret = -EINVAL;
@@ -825,11 +867,10 @@ static int ad7124_parse_channel_config(struct iio_dev *indio_dev,
 	struct ad7124_channel *channels;
 	struct iio_chan_spec *chan;
 	unsigned int ain[2], channel = 0, tmp;
+	unsigned int num_channels;
 	int ret;
 
-	st->num_channels = device_get_child_node_count(dev);
-	if (!st->num_channels)
-		return dev_err_probe(dev, -ENODEV, "no channel children\n");
+	num_channels = device_get_child_node_count(dev);
 
 	/*
 	 * The driver assigns each logical channel defined in the device tree
@@ -838,9 +879,12 @@ static int ad7124_parse_channel_config(struct iio_dev *indio_dev,
 	 * CHANNEL_15) as an additional channel register. The driver could be
 	 * improved to lift this limitation.
 	 */
-	if (st->num_channels > AD7124_MAX_CHANNELS)
+	if (num_channels > AD7124_MAX_CHANNELS)
 		return dev_err_probe(dev, -EINVAL, "Too many channels defined\n");
 
+	/* Add one for temperature */
+	st->num_channels = min(num_channels + 1, AD7124_MAX_CHANNELS);
+
 	chan = devm_kcalloc(indio_dev->dev.parent, st->num_channels,
 			    sizeof(*chan), GFP_KERNEL);
 	if (!chan)
@@ -861,7 +905,7 @@ static int ad7124_parse_channel_config(struct iio_dev *indio_dev,
 			return dev_err_probe(dev, ret,
 					     "Failed to parse reg property of %pfwP\n", child);
 
-		if (channel >= indio_dev->num_channels)
+		if (channel >= num_channels)
 			return dev_err_probe(dev, -EINVAL,
 					     "Channel index >= number of channels in %pfwP\n", child);
 
@@ -901,6 +945,32 @@ static int ad7124_parse_channel_config(struct iio_dev *indio_dev,
 		chan[channel].channel2 = ain[1];
 	}
 
+	if (num_channels < AD7124_MAX_CHANNELS) {
+		st->channels[num_channels] = (struct ad7124_channel) {
+			.nr = num_channels,
+			.ain = AD7124_CHANNEL_AINP(AD7124_INPUT_TEMPSENSOR) |
+				AD7124_CHANNEL_AINM(AD7124_INPUT_AVSS),
+			.cfg = {
+				.bipolar = true,
+			},
+		};
+
+		chan[num_channels] = (struct iio_chan_spec) {
+			.type = IIO_TEMP,
+			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_OFFSET) |
+				BIT(IIO_CHAN_INFO_SAMP_FREQ),
+			.scan_type = {
+				.sign = 'u',
+				.realbits = 24,
+				.storagebits = 32,
+				.endianness = IIO_BE,
+			},
+			.address = num_channels,
+			.scan_index = num_channels,
+		};
+	};
+
 	return 0;
 }
 
-- 
2.45.2


