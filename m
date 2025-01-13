Return-Path: <linux-iio+bounces-14319-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 462F0A0C315
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2025 22:02:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14E3B18892E1
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2025 21:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9098D1FA251;
	Mon, 13 Jan 2025 21:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="115tGH5+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF261F9EA6
	for <linux-iio@vger.kernel.org>; Mon, 13 Jan 2025 21:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736802069; cv=none; b=O5HfxSgMKV6GjySK7orV6dtpwjF3Wk3HRjG4SKkFbVsgfNcMuedTclUNWaXcxaXBVc2lLiCw5xIyG7g4Pn8TlBLxntxwEXGR/gPZw1ipr6M0FhBuKkw6mQVCmXz77Xu0D4VQ67XmTmDBtAGTFy69lbxOZfaEJUdwWjua9KxZ58o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736802069; c=relaxed/simple;
	bh=5/ZCGTFk8qr5Qpjjmv0qoJEV9Q10DfHDZbzjSTo2suU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A+QCvYOpkBr6jvFLOirnyiGQJM5lCXxfsMAA1NL+8E4svXfhxZv7hr2O4vcUBVhxTwTfPz7ficEL+WI2T9jJruy9PcbXI/fnzOQmlRVslbzifuhSk+04/5OrAWvcORMWg6j1QcmQImydl343Ksa4IZK3F6sgWgXTOa780vQ5BPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=115tGH5+; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5f321876499so2338799eaf.1
        for <linux-iio@vger.kernel.org>; Mon, 13 Jan 2025 13:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736802065; x=1737406865; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qltVAB3O9f/S/slNVDINiHvuxo8d2MRRS1EWEiDjZ8w=;
        b=115tGH5+97QxbVS2Av5dE5Y3+hryXgxB8uhGRcmjV62ogwYJaO9wwiD2ddduxF1qqH
         UBouc4J4H6z8HyWUtY/gvNrAnpgHiVGReYCYaBpXt3a19fv8Po48wqvN54xBT5H5/hrK
         2jBgi3COoG2RL4syTvmuVgDuhJybUlMTVTGrWitib4Wz3LSvcSozkfkhnrI6TBu4PDJD
         l5SRjRVh1/ZrLs3AYPCvvnnpFTMSeqQLAFvmp9x/MNOFERXs56oIC59B7jrjk7PEVFIp
         bHOpxTcMYWZVvLO3yVIj0FExxdJ4x6AMImE2ovyAMGUCIygpK7qat7CoDW3yk1JK8EdN
         Z47Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736802065; x=1737406865;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qltVAB3O9f/S/slNVDINiHvuxo8d2MRRS1EWEiDjZ8w=;
        b=bUvPObjNR5bfbRrQHspTAkGgVyzR4ylUvVM/RXiJdlkPZx94CBksP7CWnr7CW7vdD8
         Rw4TU33zlt5mL3LirL2bYsRq2NC/k+TJnu/3ybKbf0PCtOcchfquJEQ1Qob5WLdQ+FXG
         xmhGnKc3jOvxGrLuKlLvPAreAup3iphL6X0aRifPM+rU2SKwgG05rN/1ZPNzzYbJxmG8
         9ma04LimQ1CCfQxkA08FjrGUsvbK9TQLI6R8x36ef2/apL6iAfati1nfeJGQHtqu9Vc9
         hbYr216g/13O+bccjQ+p/yz6Nx/8GPxJ8u2AtgrOm46y0Q+kGWp16jqPyW0nbOoJ+k/K
         S3qg==
X-Forwarded-Encrypted: i=1; AJvYcCUBBMt0CE9IxOWNImf+vM6M4GThXNYS/tBICSrooNXnDZ3GgslMtFbfXaTKAGE4eeTT2bkVQO7fZgM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKMFmZ7IpXithJL3QWwCzZ1u9QSgcKX9Ajpm+6koWVi8Lmb/mM
	enRIjPZF9NahMtLwjqBD4fIIc9xVe1jNFbFTi7yEynJBS+fkKr6roESGG71l5qg=
X-Gm-Gg: ASbGnctWPMfOpXxqF6DwynVCQrf47gMH6tW/ZaprehaytH6Tkoq+Ve/Z2H9s6ZPCwiI
	CdtOuQZ955gFFlBxjv3Suf+c+/vz6iQkK0gPPC17yql4lLOen23Zm9FHSJg6e8jWqjSPw/Xwhwz
	9GUBcwLvUj9EjL3lbSo3FEdl8NNS7SAU3bQBPL2oLEU+GE03cvGB+laQ8k5CIC8+vSkQN30474J
	ADEP38AfM60qyk2DMB/GNfOZ6RGbMsYhe6isSNQuhOWwZ+DiVsuGSQWnU2EHftGkLJlgPBtZQJP
	ABoz5E5JIHq6
X-Google-Smtp-Source: AGHT+IGKEOrKOpleEXbdHbH0XU6aKKIS//my+aEaBNHoAOVZdjaOG9dHKxx4rSOz0PeVIQRTTjMGzQ==
X-Received: by 2002:a4a:bf14:0:b0:5f2:c0df:7ed5 with SMTP id 006d021491bc7-5f880e0eceemr10029055eaf.3.1736802064766;
        Mon, 13 Jan 2025 13:01:04 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7231855effasm3927744a34.33.2025.01.13.13.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 13:01:04 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 13 Jan 2025 15:00:15 -0600
Subject: [PATCH v7 10/17] iio: adc: ad7944: don't use storagebits for
 sizing
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250113-dlech-mainline-spi-engine-offload-2-v7-10-e0860c81caae@baylibre.com>
References: <20250113-dlech-mainline-spi-engine-offload-2-v7-0-e0860c81caae@baylibre.com>
In-Reply-To: <20250113-dlech-mainline-spi-engine-offload-2-v7-0-e0860c81caae@baylibre.com>
To: Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Cc: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, David Jander <david@protonic.nl>, 
 Martin Sperl <kernel@martin.sperl.org>, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2

Replace use of storagebits with realbits for determining the number of
bytes needed for SPI transfers.

When adding SPI offload support, storagebits will always be 32 rather
than 16 for 16-bit 16-bit chips so we can no longer rely on storagebits
being the correct size expected by the SPI framework (it always uses
4 bytes for > 16-bit xfers and 2 bytes for > 8-bit xfers). Instead,
derive the correct size from realbits since it will always be correct
even when SPI offloading is used.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-vy: Nuno Sa <nuno.sa@analog.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v7 changes:
* Make commit message more specific about numbers.

v6 changes: none

v5 changes: none

v4 changes: new patch in v4
---
 drivers/iio/adc/ad7944.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/ad7944.c b/drivers/iio/adc/ad7944.c
index 0ec9cda10f5f8f61727581b152fb921f2e0b4bff..abfababcea10152fe1faa8afc2ec1ea2dc40ae52 100644
--- a/drivers/iio/adc/ad7944.c
+++ b/drivers/iio/adc/ad7944.c
@@ -98,6 +98,9 @@ struct ad7944_chip_info {
 	const struct iio_chan_spec channels[2];
 };
 
+/* get number of bytes for SPI xfer */
+#define AD7944_SPI_BYTES(scan_type) ((scan_type).realbits > 16 ? 4 : 2)
+
 /*
  * AD7944_DEFINE_CHIP_INFO - Define a chip info structure for a specific chip
  * @_name: The name of the chip
@@ -164,7 +167,7 @@ static int ad7944_3wire_cs_mode_init_msg(struct device *dev, struct ad7944_adc *
 
 	/* Then we can read the data during the acquisition phase */
 	xfers[2].rx_buf = &adc->sample.raw;
-	xfers[2].len = BITS_TO_BYTES(chan->scan_type.storagebits);
+	xfers[2].len = AD7944_SPI_BYTES(chan->scan_type);
 	xfers[2].bits_per_word = chan->scan_type.realbits;
 
 	spi_message_init_with_transfers(&adc->msg, xfers, 3);
@@ -193,7 +196,7 @@ static int ad7944_4wire_mode_init_msg(struct device *dev, struct ad7944_adc *adc
 	xfers[0].delay.unit = SPI_DELAY_UNIT_NSECS;
 
 	xfers[1].rx_buf = &adc->sample.raw;
-	xfers[1].len = BITS_TO_BYTES(chan->scan_type.storagebits);
+	xfers[1].len = AD7944_SPI_BYTES(chan->scan_type);
 	xfers[1].bits_per_word = chan->scan_type.realbits;
 
 	spi_message_init_with_transfers(&adc->msg, xfers, 2);
@@ -228,7 +231,7 @@ static int ad7944_chain_mode_init_msg(struct device *dev, struct ad7944_adc *adc
 	xfers[0].delay.unit = SPI_DELAY_UNIT_NSECS;
 
 	xfers[1].rx_buf = adc->chain_mode_buf;
-	xfers[1].len = BITS_TO_BYTES(chan->scan_type.storagebits) * n_chain_dev;
+	xfers[1].len = AD7944_SPI_BYTES(chan->scan_type) * n_chain_dev;
 	xfers[1].bits_per_word = chan->scan_type.realbits;
 
 	spi_message_init_with_transfers(&adc->msg, xfers, 2);
@@ -274,12 +277,12 @@ static int ad7944_single_conversion(struct ad7944_adc *adc,
 		return ret;
 
 	if (adc->spi_mode == AD7944_SPI_MODE_CHAIN) {
-		if (chan->scan_type.storagebits > 16)
+		if (chan->scan_type.realbits > 16)
 			*val = ((u32 *)adc->chain_mode_buf)[chan->scan_index];
 		else
 			*val = ((u16 *)adc->chain_mode_buf)[chan->scan_index];
 	} else {
-		if (chan->scan_type.storagebits > 16)
+		if (chan->scan_type.realbits > 16)
 			*val = adc->sample.raw.u32;
 		else
 			*val = adc->sample.raw.u16;
@@ -409,8 +412,7 @@ static int ad7944_chain_mode_alloc(struct device *dev,
 	/* 1 word for each voltage channel + aligned u64 for timestamp */
 
 	chain_mode_buf_size = ALIGN(n_chain_dev *
-		BITS_TO_BYTES(chan[0].scan_type.storagebits), sizeof(u64))
-		+ sizeof(u64);
+		AD7944_SPI_BYTES(chan[0].scan_type), sizeof(u64)) + sizeof(u64);
 	buf = devm_kzalloc(dev, chain_mode_buf_size, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;

-- 
2.43.0


