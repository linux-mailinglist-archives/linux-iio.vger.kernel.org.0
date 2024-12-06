Return-Path: <linux-iio+bounces-13177-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84C619E7763
	for <lists+linux-iio@lfdr.de>; Fri,  6 Dec 2024 18:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40F23287311
	for <lists+linux-iio@lfdr.de>; Fri,  6 Dec 2024 17:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 968E0203D45;
	Fri,  6 Dec 2024 17:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="fDgvlGke"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EA6203D51
	for <linux-iio@vger.kernel.org>; Fri,  6 Dec 2024 17:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733506173; cv=none; b=AB65VDYlYjDqyl1fzPjOPQ1jAS0SLBdz4ywfnfhUDfKqB6GPNMgUTJ2sEEdYzklp1wKpbYXskJey6R4+pfoxwqewEoLYE2ooCKmichkxISN9z9soGUpsRXqg1FbyzqDaa2q/MQPwlMwK1mp9B77w7yupBBqsLtg2QLFSoO0DGOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733506173; c=relaxed/simple;
	bh=PzIORblitgR8o9Wn8H59N3kcmZSxmQXU/hVecY0uC2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l7OoAsJmrSr2BlkUCI+cRjTlU6jQ0w9a2bUK7BHR3dbDveanc/nGDF8p6JjXWa3YQ69usQ6BtFBfTSoUWuOcaC+MlQQgbhlAkCNOQoE2C6zY871VdEEQeay75a2AZotSvBnWXYiF2Lal77b366AgeJ/8jmohwWdr/SELhnGP72U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=fDgvlGke; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4349cc45219so22995045e9.3
        for <linux-iio@vger.kernel.org>; Fri, 06 Dec 2024 09:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733506170; x=1734110970; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aseOZ/ig8fHd/fQ9eVD49B+jZ1dXmCphPlgyXXsphrs=;
        b=fDgvlGkewMVvV9fB0BtoUhqvLI+Ol4B+BBHNGXKiWFMZloToVjYWnqzysmhGPjmj97
         BygcUctRa80bE4t6KKkl3CeNi7T72fa1vfGS2mPBrxcY1fH93R/1ZtyaW947aZAjGxBM
         KwhDGdu/o+MlwFRAPz0n9Nkz9HoZr03jRqdlv7crp+C6LJbW3hNlxWSaO4POVyGlgTs3
         4l5RxB6OlEXvc7mRqlU2I+pJgScXeO2l6F2wLnfPRwwA5clo2G0u7hrlFws5TjiK1A82
         U3Ws8SoXkFzKRuY61WDM55mVTIK/LjFc69YcWLqwnJ1BRYfBusaqvdg3E49ePnyBDcF4
         C5eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733506170; x=1734110970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aseOZ/ig8fHd/fQ9eVD49B+jZ1dXmCphPlgyXXsphrs=;
        b=gODu9i6f3LW2LsHHMZS8OdgCRcS8eQhICSALsrfqv8nN4koYUfqDjy2NVVSpjepPhP
         CBhslUgw3usOz3UaQsnL0m2MmPw3L8SkmUVTzgZRNeMB1DAKy+qt87e/dMzK7u2ej/MX
         CSRqZQW1kuVhdGY6UecuVnIRYKW9TDRS/TzF+Skf9Zgq/ccDcA8tdz60yJNDz+AlZKSz
         uikXw9CTHeOzunfQ2b2pfDFQbizQz1gmeIjPZW1SIlYd29T9ST9af2+zjw6qblirR4xT
         h0aFODS3siMvuxQNVoLxQHsWhyZHmpegtzyNqBUH2ln4sjRWqAri3jgW74Opb/ns3GYa
         MXMg==
X-Forwarded-Encrypted: i=1; AJvYcCVH3Uc7dAA0DIU/1TuTQDy31fBcCz8YfT6LJvDbTU+l4zc0kaASCcvFHnbGFABmmr83bmWjPThsFfo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2D92FI/l9cQNbfxi2A+hN+JQc6Y+V57WD9TKwI/ZAh8Lecirt
	CkTgi6NnhMcun8mYDTFJVZKC2jSMof+pLd+NRE71BCx86VDf7TECDdpViYSS842TUIzp2rt2BrM
	omLU=
X-Gm-Gg: ASbGncs9e1DOD6zediowNBQ2IcyHZRczwczblTZnXXmxoQEnETtGBzFm0hCU8x/bb7h
	MMMgnw/P+4sI8BEPguO8CYy5ggkoBpyuNqaVuWZmRkEQtpTAvfj1SuF2k7R1wFvkImfVEcKvd0F
	KNgva85QNItecmDJABCem5WjQNgVLfc25evlxkuKEsI80Hq6h3uTwMACisx/47iUljHsvdcuDqE
	tcWjGTUTwB6rHR5ulFsmu3IIFn5sY7TTnRB8451W8du9ecZZeL2oYXtAo1NsUsBOySNaHFP2Iku
	SI/F
X-Google-Smtp-Source: AGHT+IGELOOmBK++qIV+dBdqEd115rUXvj7wwAwxvuuL4Lz6mYpw9ILKBXwFcFuv4+KcW6yJqosIRQ==
X-Received: by 2002:a05:600c:1d85:b0:434:a902:97d0 with SMTP id 5b1f17b1804b1-434dded2340mr32992055e9.29.1733506169955;
        Fri, 06 Dec 2024 09:29:29 -0800 (PST)
Received: from localhost (p5dc6838f.dip0.t-ipconnect.de. [93.198.131.143])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d52c12a4sm100751225e9.30.2024.12.06.09.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 09:29:29 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Alexandru Ardelean <aardelean@baylibre.com>,
	Alisa-Dariana Roman <alisa.roman@analog.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Ceclan Dumitru <dumitru.ceclan@analog.com>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Renato Lui Geh <renatogeh@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Trevor Gamblin <tgamblin@baylibre.com>
Subject: [PATCH v6 10/10] iio: adc: ad7124: Implement temperature measurement
Date: Fri,  6 Dec 2024 18:28:42 +0100
Message-ID:  <433211af8ac3f02dee58586ecb51d2e98246a095.1733504533.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1733504533.git.u.kleine-koenig@baylibre.com>
References: <cover.1733504533.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=5420; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=PzIORblitgR8o9Wn8H59N3kcmZSxmQXU/hVecY0uC2M=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBnUzRfHBNHUkT6nB5k0c8aZVXPXbDComThxc8Vs 1ErW6rVUsKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZ1M0XwAKCRCPgPtYfRL+ Tk58CAClWEqXeqSI2Ca1vpvssFVhuJPMf0keKbY8s0bo0NZmUaUwL7yP1DUsfk6Ptic3K1ZeHNK +07ZiMOJdLDBER3RJpe5dSOlmQM157Ri4rYvdUywlFQAu3rrcZBgnsFERlpTe7TpF39I92IcSoR ge+TNCQU22L51cqNajZrnOmekPoCDckUlCMcsbbjxN2zwNlku6J3NKfVbQUow3Ye+iLyrxCZD1v eF14Mmm/mwch/NJPhCnsKhfZ4KaNDK6hBsHxb1AF7spgqCiLupIESu/vGdRiSj+bE3ck6k+akAh pDoYE81G1LWvqxwy6bnMl+D1/xFj8X+tSn4/gRaaSUaU1VNH
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

If the maximal count of channels the driver supports isn't fully
utilized, add an attribute providing the internal temperature.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/iio/adc/ad7124.c | 112 +++++++++++++++++++++++++++++++--------
 1 file changed, 91 insertions(+), 21 deletions(-)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index 9405cb579324..d858bffd2628 100644
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
@@ -589,26 +593,59 @@ static int ad7124_read_raw(struct iio_dev *indio_dev,
 
 		return IIO_VAL_INT;
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
@@ -826,11 +863,10 @@ static int ad7124_parse_channel_config(struct iio_dev *indio_dev,
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
@@ -839,9 +875,12 @@ static int ad7124_parse_channel_config(struct iio_dev *indio_dev,
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
@@ -862,7 +901,7 @@ static int ad7124_parse_channel_config(struct iio_dev *indio_dev,
 			return dev_err_probe(dev, ret,
 					     "Failed to parse reg property of %pfwP\n", child);
 
-		if (channel >= indio_dev->num_channels)
+		if (channel >= num_channels)
 			return dev_err_probe(dev, -EINVAL,
 					     "Channel index >= number of channels in %pfwP\n", child);
 
@@ -902,6 +941,37 @@ static int ad7124_parse_channel_config(struct iio_dev *indio_dev,
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
+				/*
+				 * You might find it strange that a bipolar
+				 * measurement yields an unsigned value, but
+				 * this matches the device's manual.
+				 */
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


