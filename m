Return-Path: <linux-iio+bounces-19163-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3878CAA9C86
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 21:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 181711A80F39
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 19:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C6B277814;
	Mon,  5 May 2025 19:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="EEw2oHPX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016E5275877
	for <linux-iio@vger.kernel.org>; Mon,  5 May 2025 19:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746472955; cv=none; b=emYMcUaiPsFVE7C2Ww5ou2spQoMGAYX9Kg7hB5vKWT9DacqMm5ApgaXCbq4E4SLjcZ8ecdNTvG88GNdBQjAe2Z2N38Lq7rTA/f6xUrCBq5Q6F5Lh8mA3y9oo7F+6coLk10+ueoYztkwSybhCrNhoByqIiynXTAcOLtuUA5bi1ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746472955; c=relaxed/simple;
	bh=jrCObBxJKv9tIVhbgjvEUpczmzN+Bcao1ZmDaqGISb0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mSMSmqb4AdSPaC/r0npbTdG9SAExAAymUBksu+MlpuSToFVuUicsZYN3CJZ0Mtzt+VEVN+fxBCBzkMBTbvLZ6QUp6UdpPe9zDMuFtFMKWkoW6lVQ06qxArWBTPC68NS9S3+LP8NYSfLDKybpUJ3mtL+thANPRS3e7P1lGjbkuCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=EEw2oHPX; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-72ecc0eeb8bso1245671a34.0
        for <linux-iio@vger.kernel.org>; Mon, 05 May 2025 12:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746472953; x=1747077753; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FjlHMGmD7O66AcEXs2QFVwIdTZWiqeZIRBQnSBbXW9E=;
        b=EEw2oHPX/W3iFnpbUaw1gB+i2lFrkgqYFamY2cWRHvVBQ4VPMZqtn7TNbIsWgYGU56
         yqZ7m6CJtyP84uII9f2vBPx6O+8swC6RBf4lKPLE7SawVsj8FaMnjWO+wGyjnvTX8hg2
         AKhwCrWQ9ImQ9GKDcB/E9DI7yQdg8i3irRPUuxNGqf6p4PGm36kFUVp4o32wi5UMeqQm
         LIM7fI76qkOfll1ujZMAE3bvd0r0nlbtkOI9NBK0SJ1ZTTSXDu30IRvIV235SnbFuSJn
         Zfy9cUBZzrTNmM4X3UdMYPTXVFiFtEfNjl7pxOuMFqQl2PUhcBC208P0ij9mTwBBhfm4
         FzGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746472953; x=1747077753;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FjlHMGmD7O66AcEXs2QFVwIdTZWiqeZIRBQnSBbXW9E=;
        b=LQFIny5w1vdQQe+n12ISn+h/HY+DAUtcv0B+6DEkYLX8FJ4j8WqDluQyGyFrySR6z2
         lhscNd5+Mzh7VOGmRtqLe5BOBsqABuDQDPG2i7cGTurexjRhiG0xO8fQrTz6mllMmiNd
         QLscZuF56VEC8KFYQM3C1dTul5gssfl1dYo2kR6GpPen6ehzUyUWd3V+ozZA8bqB3S3z
         JJNlV36JP1V5P46iosfVY0sYhDKtdL8JRdEuksRV1FSbt5frtfIH1uokNPawHYkPH3zk
         9ZldxBmXAHCGFnYWNIIrKxrSvQMbBPYrBToBnB2cR6L/QA1teb3DCmox5Mlr6YPbZfOr
         AbRg==
X-Gm-Message-State: AOJu0YzTCtd2o5zPWVIN3kU25OOPTmNcbE/bC2nAeidns8hilFBgy3tp
	vZ8TG+NRp0yQ/SPXcJo5CBPYHt+3xoPOsdRntyNf3ZOtSAhPkvUiPrICkgVR3X8=
X-Gm-Gg: ASbGncugDgh+MhFxQn5+F6Wen/zxJz5eTAZTl0hyWa/zxZu0xJhjnyI3E9GrYL7zXwc
	RlQfTW2ZWAYxRVXhzfH36aMOD0Of8a52LsUsv9k2q/XdwKsKeDa6P1yYPYEEhN1zKOwfUHOVkLj
	DVlFRmBIRukBg/fDXNBeWfwSzVk9uxRWnVQjoYVdgM2FBOM7oSZ3W0FfouGdB2DHXOywrnPvyCF
	XN/5vdd+ySjimOVHTvmGY2CygdQ0bOTZ5mQnP1QqyvT9YUnYCOnmsNo4i8d/igqfYzApTQ6Crwm
	B4OB5lopjM3OK0PTBNjf2Ylx6w5LcNcBu8Q0uE4iEKhWpw==
X-Google-Smtp-Source: AGHT+IF5fTx5HV2XtDt6NVvms4pSO/ssGCHP4ozR82sDsJsCgcDsziE7PABwx/K8pagPSLCOf+y/qw==
X-Received: by 2002:a05:6830:6f85:b0:727:3664:ca25 with SMTP id 46e09a7af769-73206cf95f3mr133430a34.0.1746472953043;
        Mon, 05 May 2025 12:22:33 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:2151:6806:9b7:545d])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-731d34daaedsm1683415a34.51.2025.05.05.12.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 12:22:32 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 05 May 2025 14:20:36 -0500
Subject: [PATCH 09/14] iio: imu: adis: remove bits_per_word = 8
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250505-iio-remove-bits_per_word-8-v1-9-341f85fcfe11@baylibre.com>
References: <20250505-iio-remove-bits_per_word-8-v1-0-341f85fcfe11@baylibre.com>
In-Reply-To: <20250505-iio-remove-bits_per_word-8-v1-0-341f85fcfe11@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Esteban Blanc <eblanc@baylibre.com>, Jonathan Cameron <jic23@kernel.org>, 
 Andy Shevchenko <andy@kernel.org>, Oleksij Rempel <o.rempel@pengutronix.de>, 
 kernel@pengutronix.de, Song Qiang <songqiang1304521@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3529; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=jrCObBxJKv9tIVhbgjvEUpczmzN+Bcao1ZmDaqGISb0=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoGQ/FFVKgiEp5xCm3newXCAFFh+qJ8sseOpnhW
 wcnAqx7MDWJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaBkPxQAKCRDCzCAB/wGP
 wO4ZB/9U8N/UCpYQuCMlXlrx4XA2mUOimAI5+OG01YuLb+77Z0rlMdYCDRvlGgRPgyuoPwfhe+E
 ptG2qAfgm4NsGzMSVHOP03kB1tyTh1GdWcsjJs8DYyOo98SnqOXRUn9i5HfGtR+Q1+txTs8jMlW
 RrJU/hhK+ezY88+cmqAhbZKm6FhHeDwwVg5sqgyDALPVY+QqardRDcNxtuXDNNGuMj9N326SFXB
 jNBuERTzHtT267lN0sHlUrDiDddqbGSauZaTvCmTnfLQ8Sf5UnnaXV384SQBFScRz7kBtLot/eq
 vs4i6ICh56nWayw8/LrU6CIIMmrVP4QgpO9x+mwcMl4r60UV
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Remove setting bits_per_word = 8 from the adis driver. This is the
default value for SPI transfers, so it is not necessary to explicitly
set it.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/imu/adis.c        | 9 ---------
 drivers/iio/imu/adis_buffer.c | 3 ---
 2 files changed, 12 deletions(-)

diff --git a/drivers/iio/imu/adis.c b/drivers/iio/imu/adis.c
index 0ea072a4c966994ff8b1a6c7572bfe979ada43a1..d160147cce0ba7586ac7df69af58816b413bbd46 100644
--- a/drivers/iio/imu/adis.c
+++ b/drivers/iio/imu/adis.c
@@ -39,34 +39,29 @@ int __adis_write_reg(struct adis *adis, unsigned int reg, unsigned int value,
 	struct spi_transfer xfers[] = {
 		{
 			.tx_buf = adis->tx,
-			.bits_per_word = 8,
 			.len = 2,
 			.cs_change = 1,
 			.delay.value = adis->data->write_delay,
 			.delay.unit = SPI_DELAY_UNIT_USECS,
 		}, {
 			.tx_buf = adis->tx + 2,
-			.bits_per_word = 8,
 			.len = 2,
 			.cs_change = 1,
 			.delay.value = adis->data->write_delay,
 			.delay.unit = SPI_DELAY_UNIT_USECS,
 		}, {
 			.tx_buf = adis->tx + 4,
-			.bits_per_word = 8,
 			.len = 2,
 			.cs_change = 1,
 			.delay.value = adis->data->write_delay,
 			.delay.unit = SPI_DELAY_UNIT_USECS,
 		}, {
 			.tx_buf = adis->tx + 6,
-			.bits_per_word = 8,
 			.len = 2,
 			.delay.value = adis->data->write_delay,
 			.delay.unit = SPI_DELAY_UNIT_USECS,
 		}, {
 			.tx_buf = adis->tx + 8,
-			.bits_per_word = 8,
 			.len = 2,
 			.delay.value = adis->data->write_delay,
 			.delay.unit = SPI_DELAY_UNIT_USECS,
@@ -133,14 +128,12 @@ int __adis_read_reg(struct adis *adis, unsigned int reg, unsigned int *val,
 	struct spi_transfer xfers[] = {
 		{
 			.tx_buf = adis->tx,
-			.bits_per_word = 8,
 			.len = 2,
 			.cs_change = 1,
 			.delay.value = adis->data->write_delay,
 			.delay.unit = SPI_DELAY_UNIT_USECS,
 		}, {
 			.tx_buf = adis->tx + 2,
-			.bits_per_word = 8,
 			.len = 2,
 			.cs_change = 1,
 			.delay.value = adis->data->read_delay,
@@ -148,14 +141,12 @@ int __adis_read_reg(struct adis *adis, unsigned int reg, unsigned int *val,
 		}, {
 			.tx_buf = adis->tx + 4,
 			.rx_buf = adis->rx,
-			.bits_per_word = 8,
 			.len = 2,
 			.cs_change = 1,
 			.delay.value = adis->data->read_delay,
 			.delay.unit = SPI_DELAY_UNIT_USECS,
 		}, {
 			.rx_buf = adis->rx + 2,
-			.bits_per_word = 8,
 			.len = 2,
 			.delay.value = adis->data->read_delay,
 			.delay.unit = SPI_DELAY_UNIT_USECS,
diff --git a/drivers/iio/imu/adis_buffer.c b/drivers/iio/imu/adis_buffer.c
index fdfc0538734c5e781be9fd5b7183f3dfb51830b9..cd3db2388164b558b82c5da67423bd2ca142858b 100644
--- a/drivers/iio/imu/adis_buffer.c
+++ b/drivers/iio/imu/adis_buffer.c
@@ -49,12 +49,10 @@ static int adis_update_scan_mode_burst(struct iio_dev *indio_dev,
 	tx[1] = 0;
 
 	adis->xfer[0].tx_buf = tx;
-	adis->xfer[0].bits_per_word = 8;
 	adis->xfer[0].len = 2;
 	if (adis->data->burst_max_speed_hz)
 		adis->xfer[0].speed_hz = adis->data->burst_max_speed_hz;
 	adis->xfer[1].rx_buf = adis->buffer;
-	adis->xfer[1].bits_per_word = 8;
 	adis->xfer[1].len = burst_length;
 	if (adis->data->burst_max_speed_hz)
 		adis->xfer[1].speed_hz = adis->data->burst_max_speed_hz;
@@ -100,7 +98,6 @@ int adis_update_scan_mode(struct iio_dev *indio_dev,
 	spi_message_init(&adis->msg);
 
 	for (j = 0; j <= scan_count; j++) {
-		adis->xfer[j].bits_per_word = 8;
 		if (j != scan_count)
 			adis->xfer[j].cs_change = 1;
 		adis->xfer[j].len = 2;

-- 
2.43.0


