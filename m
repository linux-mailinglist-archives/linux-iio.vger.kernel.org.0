Return-Path: <linux-iio+bounces-19162-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88026AA9C84
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 21:24:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5896016E87E
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 19:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415FF277035;
	Mon,  5 May 2025 19:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="nd4kXVwp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5F2275103
	for <linux-iio@vger.kernel.org>; Mon,  5 May 2025 19:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746472954; cv=none; b=EixYKoLOvzYlJLh7rqA+ACWQLaJ+v09HX3WVoIAJGaWLMbY2Dd11qYqHcKIsXpy8VeFYDP18LiYoz2/tWzbMQWc/5n8eyJm2GxXqwd2wRNiCIriCIx5PIJ6SXbnR8XdR1Tfw744UfvBGyXgHiNIZ1oBNW4wSE+TYktK2qASWicU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746472954; c=relaxed/simple;
	bh=HhuJvr4lalxa4cL7EyheRX13cWi4YNcmz+jCOHUx1dU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=knZBpJHw0c0q5IYmNTogo3DvaenJuY59RUb/E3snV33WQcIgEJVhrddULD6Hvfms3hMm9szzjMrDg04/RrwSnD0pzN70DvfoKAaLAnv/vbicP9mArQaA0cIVBhFanZ2WGQedV4NLuzd3MNcrvsg5VtTtoLaN1Ws0awHWTF9Ico4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=nd4kXVwp; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3f8ae3ed8adso3495248b6e.3
        for <linux-iio@vger.kernel.org>; Mon, 05 May 2025 12:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746472952; x=1747077752; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g5vRbztogp78gX3UhwiBcx3pR0HNWrm1kEsoNgwVf5M=;
        b=nd4kXVwpvq6rnA0m4qUfyiDQYfBV4NTRNqzcoRhaSvlbtNzPu+3ad4yqfIzh3s5vjN
         YR2bsy6W+o5wUGPIAVnUdJdtxdS/FtLjqax1dIvpMnqq4Mu72khYgpAwMK6ixPeTXwnM
         wZwGGIofjdPDdNbaf77ZCjcBWyAdmxaJqEWNIRwWqBNYoSxf5voeaIoQIGBqciAbvUUn
         pnxj6IvS09COz42K/ZeyH4lmEImZQVlYWLsilmwyfqrfn1dJvWeG59ez6pgXAghzJrlO
         xlPbFmQftk8zcVk3SNBodQew8Ypx5roGeSrB9Z+MIEpteCy258lquq/+kZxvkg0Sf3Kv
         DOGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746472952; x=1747077752;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g5vRbztogp78gX3UhwiBcx3pR0HNWrm1kEsoNgwVf5M=;
        b=h9BFBv8z6W3R7b5EtAypTLI+3DUKW6PxZVi86Qj0tklQJTAm7kuOn8lpUzOo7BweGZ
         bdGD6rWTMr4y/TuT8AMSI8W08LKZdWQYv+f/x7OqCvUGONaWaTmGXwo8P4JPAFsney4f
         99LAUGLSHKCiNOL7x0PaI8pjqtfvcP+/hsDL7/aB0PnIoRQg9JjqQxYc6IC5gj/2beYZ
         SQrJEsNbJ0hdUJ3dD5PNYXNeZhjkI59dpiRghHfpf1643nEtzHJB+OqJGIYumpCGcxQz
         eDKb7hWATloRpr8LdKL4sRY3UH9+h6djXo1vhNGF+0izX5HNkOWNODQVw1bZUfc4FzGq
         ZvNQ==
X-Gm-Message-State: AOJu0YzeDcr9NqoK/b6wVSzRmpMPFkOyG4pjSzKCzxnQCXGfD1IHdibp
	ykUQ5dr6ipmzVx/dFD102CVR2kVhan9a29RZIhFm+EicUeJIVpSjIit3cqbVPe8=
X-Gm-Gg: ASbGncvfzRDyMKrgKPSACMampG6/cLi1criRV9M5GC+LX+eBuxzAzwEVNLXM3/j40hB
	slmmNwM3frdeCZLxnuzXvBHjs3CVspU1kVFc6jetNQnptjamF7jWsPBoLCCZ2lSZNKiEbfsDrnb
	wKBydbFsbkCrAjyPoSP/aHPRJU8u7svNjrgjwX5xSfSbJVaMOQ7sTQFAfM2z/yJYW9aTHgnqZ09
	uIbubziNSnV0Itq1lE5BME9EnIFSFshw2jS1b5K9iXqQxHFAxKezw1roCYP08/8vhtqjYhCYd5C
	NHDXMAgggomyafZuA8XA75yHLjSeU283yOuOfhMpUcpvjA==
X-Google-Smtp-Source: AGHT+IH7ua5Ao5J24ZFCCVb0Cu/qLBOIMfKM7dk+iqMb85u4GLyG/lqkVcoFHKJyg+qjG6lwv5JWGQ==
X-Received: by 2002:a05:6808:1649:b0:3f9:f923:cc46 with SMTP id 5614622812f47-403419cdf7fmr8958474b6e.9.1746472952240;
        Mon, 05 May 2025 12:22:32 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:2151:6806:9b7:545d])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-731d34daaedsm1683415a34.51.2025.05.05.12.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 12:22:31 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 05 May 2025 14:20:35 -0500
Subject: [PATCH 08/14] iio: gyro: adxrs450: remove bits_per_word = 8
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250505-iio-remove-bits_per_word-8-v1-8-341f85fcfe11@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1417; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=HhuJvr4lalxa4cL7EyheRX13cWi4YNcmz+jCOHUx1dU=;
 b=kA0DAAoBwswgAf8Bj8AByyZiAGgZD76gouxd3BB2ZBKvhw4llQdUhHn9jxHlwwZEm//ToiJG3
 IkBMwQAAQoAHRYhBOwY2Z5iDoPWnNhomMLMIAH/AY/ABQJoGQ++AAoJEMLMIAH/AY/AUdwH/3XR
 UokTKjy+AeZ2EpP1EFiCmWhI8pRImAvPtmgkmzm6YbuYutMxg5j9yV/YrEwGbZWrfVGPWWmE6NO
 bkh6LoFsYJ4jfXAsCynMovzKzB5NQYGRQP9Mo5usxhCGmr0G9/6kUgD+gb9gLaWBQxLluvMOr1j
 rlxL7nGP9q88/7of0R2a1DLX6gQveGO4MWyWJDLtJENpRpALwNrNOumZWT3GWYEPggo5qEzZcYZ
 yKmEamdJhEeqZ94T7EeeUsjDLqWJ8JlSXtTWstVMOWq5jUiuxSTSHKvkfSEC7CzB0BuGCSSxtr5
 3JJ5voiLzz36TTeQoRFWvJk8qviDdy+a82GTO9s=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Remove setting bits_per_word = 8 from the adxrs450 driver. This is the
default value for SPI transfers, so it is not necessary to explicitly
set it.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/gyro/adxrs450.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/iio/gyro/adxrs450.c b/drivers/iio/gyro/adxrs450.c
index 5dadb88a4d92c27b4bcba121660198311c50150b..a1d8d3cb301b26a1b15fca2f6bb9bb1494ffce79 100644
--- a/drivers/iio/gyro/adxrs450.c
+++ b/drivers/iio/gyro/adxrs450.c
@@ -95,12 +95,10 @@ static int adxrs450_spi_read_reg_16(struct iio_dev *indio_dev,
 	struct spi_transfer xfers[] = {
 		{
 			.tx_buf = &st->tx,
-			.bits_per_word = 8,
 			.len = sizeof(st->tx),
 			.cs_change = 1,
 		}, {
 			.rx_buf = &st->rx,
-			.bits_per_word = 8,
 			.len = sizeof(st->rx),
 		},
 	};
@@ -169,12 +167,10 @@ static int adxrs450_spi_sensor_data(struct iio_dev *indio_dev, s16 *val)
 	struct spi_transfer xfers[] = {
 		{
 			.tx_buf = &st->tx,
-			.bits_per_word = 8,
 			.len = sizeof(st->tx),
 			.cs_change = 1,
 		}, {
 			.rx_buf = &st->rx,
-			.bits_per_word = 8,
 			.len = sizeof(st->rx),
 		},
 	};
@@ -209,7 +205,6 @@ static int adxrs450_spi_initial(struct adxrs450_state *st,
 	struct spi_transfer xfers = {
 		.tx_buf = &st->tx,
 		.rx_buf = &st->rx,
-		.bits_per_word = 8,
 		.len = sizeof(st->tx),
 	};
 

-- 
2.43.0


