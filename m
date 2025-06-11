Return-Path: <linux-iio+bounces-20434-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B112AD5911
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 16:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8FAB17871D
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 14:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D5C527BF95;
	Wed, 11 Jun 2025 14:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="CM0NakH2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4438913635E
	for <linux-iio@vger.kernel.org>; Wed, 11 Jun 2025 14:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749652831; cv=none; b=lS06R7+WoZ8wrsdePyk5+nvdgX28fyDraLXclt3KFYLyKpgwpmBary7oqgY6q8XdlG9HBZcVyKFNmpKCoKlhms5qM+GBaOqBUHCX8lF/vKGSegHtbJwrGJRtUikQ7w8jybM6L8F/KCBdmCaY4wM5mCzdemU7VBrW79XbFWlEe0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749652831; c=relaxed/simple;
	bh=AoNBXfxmjiJwlJyNJTpuHiDBXjwzWldZGbKBWicfIv8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=FWTEPaAVggevP+i+VnBXO7mVSNjV9U/m5lWDSFGuaLQ8eDwGoUUPPSjOFFGU189do7Xpznf0cI+uqcdOUQE4LqqgRUi9uqcSHl4uYSZM20Jd7MBWctIiK8VuMGXULzp4ERUlZOd9+KrkS7Tm3NxnVCn46V8s441XHmkPVp6lUV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=CM0NakH2; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-735ac221670so537583a34.0
        for <linux-iio@vger.kernel.org>; Wed, 11 Jun 2025 07:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1749652828; x=1750257628; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mLrrcjxPAjeFKi7iUJTxvFP27ls+0S72xIdrAaB/V34=;
        b=CM0NakH2YsQcYV0RupCN9KJcFRRJniJNLL9imCu3TvckMZDI5ZocGq7sKkWFiBUwfz
         ZPLV7mDKfW6FqMvWBeAKqhOam3AElSqB0p7S8PdZk//p6+Zz7h/PxlTH2oMI8PBqLt+i
         AI3R+RUSzlA87zdyBsZ4AakuDcljAiKaB+Lqaat9lQBgvx67qD5X1RALP6BOCdZDV5R/
         ZyL50DQfDaVxCG1T9bXzdPVk1jStQFD1W4yeB6AUtBp7GGVutzxZkqSVHsLOluTLk2jv
         NabtAxJCPjjxV8oL92ZhIFv968nS0cNaHXnaiLBLQuv9GEwV2eC6lJuUv8x9QsIAJRcJ
         2R1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749652828; x=1750257628;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mLrrcjxPAjeFKi7iUJTxvFP27ls+0S72xIdrAaB/V34=;
        b=al9Hioa2z2P61z/3KgDIVaWQCnSrzkN1OghAl2Qb7BG+04Ywmhy3irMyuMwLar6mrV
         R77laFRM9qjaPYZ29vzsij1N5ylvgl5T47K3BebqJoXTAfC8BPp+oRcjhDabwzHQpDrm
         6vci9mFAtFjIzSLRCkXyFVIJHBkBb9CqlpZBSAQnI31MdeDQ7MxJkzaLe4ytF/gFuCXA
         JvhEPRPkKsbWmJG6HpYh5vzd6uXnt14ypGaDJLT5bq48++djHC7RW1Q3XSglx7PBhZRl
         1DYLCd1l2dM7o9t0LyOS3wRzYvNmQkk0i1anTBtIfaPSgwSfjIyrp4A8UZzROtJXKJ6+
         9sWg==
X-Gm-Message-State: AOJu0Yx9Tep9kVLvlPjk0vcRXqoT9GkQ+MgycFNRFMxbRGDhBZH9wz4y
	vF05vZxMpQIL0iyp+Bi/qei7KI+inHOv98ctvlLT6oyS4GVL4mzNH0g/5n8nZMVcd6ZhvfwpXpS
	XPFTK
X-Gm-Gg: ASbGncvqIfA1METo2v6g3rACJdKtWsVIDFBB4+B6TYkofjhlYb9g6S2n4BzA+2ro1dT
	APXND0dEVe8zAab9gUsrrXTVt2JXyrcOdZh5zpej6P4DHP88bL9zejmpFnBXE1RIJoYBL/jKqwi
	QAQ59ZCcJdIhfX0RNjHYo+n7l5nUdwYEKxUskp7b9+U/uYHtHoMt6HryjYmyiRuYOOz94BvIaDC
	Np8tS6Ffto+1yCC/ZAQ/sivbz16YfQppVlhMBGABWsjFsegZW3tCm0F+GTgyzlnJ/BFpb/CaAT9
	TsyN/+e0+TFLPf+914FPg0FuaF8rzQm0XPhGb2hTOBy3e10IbAA0biWDnY5Ao7nsCbY=
X-Google-Smtp-Source: AGHT+IFr6GLRVZwQuuEJUWf6+gPiIRd12h4YaeLZ8Ur4iNPV4hBUvhA1RQPoqix09J2XDOWzvZobxA==
X-Received: by 2002:a9d:7d85:0:b0:72b:7dbb:e39d with SMTP id 46e09a7af769-73a0652151bmr1588147a34.1.1749652828260;
        Wed, 11 Jun 2025 07:40:28 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:eb6c:30d1:632b:494])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73a06faa7a4sm330735a34.7.2025.06.11.07.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 07:40:27 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 11 Jun 2025 09:40:16 -0500
Subject: [PATCH] iio: adc: ad7173: check return value of spi_setup()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250611-iio-adc-ad7173-check-spi_setup-return-v1-1-4d6f9ef0a2e4@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAE+VSWgC/x2NQQrCQAxFr1KyNjCZoQ54FREpaWqDMB0SFaH07
 gYX78Pb/LeDi6k4XIYdTD7qurUQOg3A69QegjqHQ055TGciVN1wmjmoVAvyKvxE73p3eb07Wqw
 1TDUnqrmMS2GIr26y6Pffud6O4wfDhGBkdwAAAA==
X-Change-ID: 20250611-iio-adc-ad7173-check-spi_setup-return-072017235f3c
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1097; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=AoNBXfxmjiJwlJyNJTpuHiDBXjwzWldZGbKBWicfIv8=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoSZVR9M0Y2yJvw8Y3W1UqUwM2S92STPmFTqFkv
 /YhRZ3r+W2JATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaEmVUQAKCRDCzCAB/wGP
 wF2KCACFPxTMDj4CL5i7akxNe1PjAzgkhUg2vFq9o2g5vSBsA4+H7uJ4QTe7QtnrkK29QKm/kk9
 K59OyZcHOm3ggA7wQkgWtqtEZ2w084F5bFrMR3kMc6zitxnVxoIo4ESfiU+HsP/wHFekncHaEzt
 UVYgLReJyxkbxtjRSBc4BjBPwnngiDHocpSF2IbN3d+5mYI2t/py9MveadvUr+Bv4sh9EBz5qPQ
 b/jMmCC3krjSWRGuXn6vgKmNVAu3lpr3FGEPAAYig4AGEF4zK/i6L9MSpUZ4DUXSF8z/heeVDs6
 oh6t/dZ8al2+1+O5dnRvDU4vUNckEeo9WpD8BYdKBdp3Mzp4
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Check the return value of spi_setup() and propagate the error in the
ad7173_probe() function. This is unlikely to happen since virtually
every SPI controller supports SPI_MODE_3, but still always a good idea
to check the return value.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad7173.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
index 69de5886474ce2f700bf277ce707b15637113564..911001be368302fb9d7d6e8da3783751fe0f61c5 100644
--- a/drivers/iio/adc/ad7173.c
+++ b/drivers/iio/adc/ad7173.c
@@ -1775,7 +1775,9 @@ static int ad7173_probe(struct spi_device *spi)
 	indio_dev->info = &ad7173_info;
 
 	spi->mode = SPI_MODE_3;
-	spi_setup(spi);
+	ret = spi_setup(spi);
+	if (ret)
+		return ret;
 
 	ret = ad_sd_init(&st->sd, indio_dev, spi, st->info->sd_info);
 	if (ret)

---
base-commit: aff301f37e220970c2f301b5c65a8bfedf52058e
change-id: 20250611-iio-adc-ad7173-check-spi_setup-return-072017235f3c

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


