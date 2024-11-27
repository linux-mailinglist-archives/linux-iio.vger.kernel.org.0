Return-Path: <linux-iio+bounces-12744-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8CFB9DAA4A
	for <lists+linux-iio@lfdr.de>; Wed, 27 Nov 2024 16:00:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AFEFB22953
	for <lists+linux-iio@lfdr.de>; Wed, 27 Nov 2024 15:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00461FCFD9;
	Wed, 27 Nov 2024 15:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="T5BF6rFo"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960361442E8
	for <linux-iio@vger.kernel.org>; Wed, 27 Nov 2024 15:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732719624; cv=none; b=SpUD0Rqu6zTGxfjCVKaJEQiNV9Xe7GSvNqywlDx8d5e9NblUPQA7stL6GSMSDux4VPJpF0IT0SY/2ZwAs4WTBObTQSiFyuKzrl0LfNUid0nrOXraDd9W7tm7dYGtxUlLbcktjW5ESI0MROg0N5k06CQgBmnQT7Nl3ZlDjGFLKN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732719624; c=relaxed/simple;
	bh=FybxynUJ1Yba5Z5OIHqiV3cKww2mtZhnPNftNTVUYCk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fHYOAm3KvdsqTYPa8u6NvlRJj9deXfQQG27myfn1WCCy5w3n+0wX4ksqZ27J6PlFsKeqXvpyo0UYolT4PIyvKbjs756weAlw4f1MnNG+zak5Rlqvy9XL3XhMXf9hPUw1JjscOjOYHuGi1u0aD2P0TNG7DGuHgCwxHQSREtnPH4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=T5BF6rFo; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-434a752140eso15744835e9.3
        for <linux-iio@vger.kernel.org>; Wed, 27 Nov 2024 07:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732719621; x=1733324421; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=91eRYaFTdN1PNWbZ3zglyGnbkpzfISIP1MPsAUMjxGw=;
        b=T5BF6rFoTXoi80szurEsPTKa76GKvaFn+FhRIiAAZ1tCdjRk0ylwzO/YK/40h5juzb
         DfhyIsjkEgPs5/9WT5F5kr586bZ76q5uWTJnvhhTRkoJxpIzS+158qFnra2tsuZ+Z+ty
         uTGtWlNt3WEhLBnufplplczw2U+768P4mpEDSA6Zgn9dcNzV/jo/do2tnFARpABtE6Qh
         HimniABAdW7JLlwdt28A4A+lzUg80nkghIQfu5/SVxerxNIVN7jVW/hLlGlAXHLKVtG8
         abFyJK9IAojrPY4fFHCh5idcrpgEwAn8jhCuxvTAdlkHp0xA+wOIs/y7ZKn0gbYq2VDZ
         Wtww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732719621; x=1733324421;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=91eRYaFTdN1PNWbZ3zglyGnbkpzfISIP1MPsAUMjxGw=;
        b=b0dFDGaYrKuRV6ctIDcp4VVVqECct46f0BDybTqd2kNYUWKzjAroHGAphlpfNNCQEp
         XSYAVPW0N9Xoddo9JsxWFCAs5qftXdAtFM4bGNSt1AL7DLXOyoq9ewM0nRRRFc2wui5b
         xlzJZ2FLXox9DU95P32gUrAGe5gVEAFLJ6VK+uJbveVmk/u18iC3PnBSbkbBpUmb8v3X
         stSCcYJnGIGZdfl6JCFQK5wYxzgIuSj5zHf8vINpLORsuTdQyHEZL2Fp3aBSKp7+L+Ey
         QClMTtRRX4eO7M7CfuBKBSIMQ62fLTMc2SHxg6dUM9pzZfttCEZEu5DJcT4R3kFHVUuq
         S57g==
X-Forwarded-Encrypted: i=1; AJvYcCV6KyEwrNgEYN6S5ENhaXlaMYZqnM4nbYdXk+HmD55bjcIrNbpTvQVqiR92huJu/hQ/eQapZ5apQFU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJIeXKBkFNRnDhXQiD+4xAUT/jf9znXSmKsigLvdyHZPLTz066
	uTP+t4U9HhnSbghHicdRBJ5WvOq+w4/VUce4uFBtHaqk4TOai17xHQagmGfyMxY=
X-Gm-Gg: ASbGnctIWwwx+7HnO7bNF/1JxYC2ayfSDj7oRn8pJc6oFyfmESmRqz1cmflKrFxaDfT
	DWMDSnKnrLDPv0AGDzo5rhfK3gtiuXcgmTY/c2Ean6Zj6jHKrUfuLRczDuVu9p58rcHDLdvfTNa
	DtzD6cWmT1D0vMA/yl7O3vc3az9BOulwIw/6RDCN0I9Rap0D0WWMIZwkF3D9Nu2v38JktV2flxt
	lfHoz8E/5zhOXK92r0uNezVvpDEtIXGR43EVy/HA0jkdqSZnWmBSBmxfcpXGv6a7T5Aqqbmrmha
	I1o6
X-Google-Smtp-Source: AGHT+IEon23hwGon37Cs26pApOor+Kj7RGM+9zcYxjFXNvz1Qgsn/I1bC/HGKwvjRCGfevQzKXiHlQ==
X-Received: by 2002:a05:600c:5012:b0:434:a396:9474 with SMTP id 5b1f17b1804b1-434a9dd0586mr32853085e9.18.1732719620846;
        Wed, 27 Nov 2024 07:00:20 -0800 (PST)
Received: from localhost (p5dc6838f.dip0.t-ipconnect.de. [93.198.131.143])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434a5d64d28sm39762705e9.0.2024.11.27.07.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 07:00:20 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	linux-iio@vger.kernel.org,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Nuno Sa <nuno.sa@analog.com>
Subject: [PATCH v4 10/10] iio: adc: ad7124: Implement temperature measurement
Date: Wed, 27 Nov 2024 15:59:39 +0100
Message-ID: <20241127145929.679408-22-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241127145929.679408-12-u.kleine-koenig@baylibre.com>
References: <20241127145929.679408-12-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=5420; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=FybxynUJ1Yba5Z5OIHqiV3cKww2mtZhnPNftNTVUYCk=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBnRzPscGpDvRPiqpsUIoTHWFah0zv2tvCLpVYIQ LJJqqepVvOJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZ0cz7AAKCRCPgPtYfRL+ TjWGCACLBPyFFaGtq1NkOPlVCWF2b5QeUHyVHVnDAU0cQNMunlAcWMZfY1m2/NAydhHrejLohUq yLCbIskwKweT92dwHk9DGkoaQlBc5uQYabFRL4urnCVjTWopYxvt7M08CDqC5PGAhWmls+EDSOD NOhX787as6eJCSc4+7Quyn3VVNk/sErFafb72VpKG/wMVpG9S7f8Pa3W7UUdcLUqPQPhdZt7Taq Ct6WhBfHT6wFTTIwjWUZQ09AA5m8ZO0XlhBPocXZ9grctIRb04e6ynVAMMWSz1LLbKmwyKbYv4M nJEbGETZSESdcZlIBw2rLzE1HIWER7r17ak1sUVJT6JQatqr
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

If the maximal count of channels the driver supports isn't fully
utilized, add an attribute providing the internal temperature.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/iio/adc/ad7124.c | 112 +++++++++++++++++++++++++++++++--------
 1 file changed, 91 insertions(+), 21 deletions(-)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index 50b8ffa2dbe5..3b95e5a22473 100644
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


