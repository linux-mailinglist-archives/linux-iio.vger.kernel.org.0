Return-Path: <linux-iio+bounces-21061-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D252AEC8D8
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 18:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5057189A34D
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 16:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4C02356B9;
	Sat, 28 Jun 2025 16:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="wQ4iIAc5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2B71C8604
	for <linux-iio@vger.kernel.org>; Sat, 28 Jun 2025 16:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751129287; cv=none; b=nIt660cKlvxQhwU9ClekJG16U3wcjGsJ5nP5mKVnBeVJcZ4KhAuJ2sDGG0IawLHWPoLyllda/UWk+eAmJXPsVrn4E31OR4xhWIX24HV6iOmEZ7MwfhvrBboTtX95JB9Ypdffun/O0VdNY6LVz/kMm4/rZBQV2wT5YTszIZMQm/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751129287; c=relaxed/simple;
	bh=HZ//Y2K0uLB5kUzMtO2XZBj9R2SSfFnWS2P7z4FMbnQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=g66HQnLxEYmrI+m+kDctLfv6Zya3SsKEBqaBuKmkiqrd8b5t1j2P8oKH+mUL1/LbIBxhF2V6KnNgdm7xz5aA22SXZACWCGhn6rTk+97yTGKz0pwxc6sP2TB+LRK/6JczfUQ7CrHyRKt0EsOCowy3Tk6/VggqXJZOTnOsC2JfPYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=wQ4iIAc5; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-40a8013d961so1046976b6e.0
        for <linux-iio@vger.kernel.org>; Sat, 28 Jun 2025 09:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751129284; x=1751734084; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gmlFpqHEoG7G1XXNLWfY8kop+YPpWJd3ItpRxDsXJ2k=;
        b=wQ4iIAc5fHmz4gSbX7oPpz8eMUoQZKqZ7FIdppDpxsPOzhTGQId0JFlvoda+PV63Mw
         s7I2FnXbbQIPayeuvyBSDYDLfRGXh4crkU3VEs60+utpLecYubJISOoVm4NDqhK8jyp/
         lBWDfIQ42FdnoQQy+lZHD0GCTG617SfWO5q5tqG7cGs+5q+Rki//BgOAn7rJUXrJUjNA
         07dLOpewnH7YeFJ4wRPXvHynh19m+nRyNOS7WUD6LuuGRf9Yn7FMfDfxdEK5P3Mgx6gW
         o/U2oG4idQWmTIdA3TucC3FO77ADlsy2PAbXl+6TqhE7tNveoCYzI3t2q/xsGAK2erIr
         hazg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751129284; x=1751734084;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gmlFpqHEoG7G1XXNLWfY8kop+YPpWJd3ItpRxDsXJ2k=;
        b=GfWIZoX1CPHBRbtA+RyFcvl1B1mpwX64QxmeZu9NqU8u1EfQbzBiX94f+nyRJ+W5YO
         w8vzhVICeyv9yYXZYHOpWUE1+FjGXGKst1GO6jZNHoPyXiAZEeXab0r10QawbVHQo8FV
         Oq9aC6H/zMHMpgOeYNTk2ObRieOZSYE70+VO+kK6dfkXSpioVO3zwzMjlpbLKOcbIFpA
         Gfbg4e0vsQIjDPdvP33/1lUNnAnnREVhTn8ZJsZs/uiMCK+1pQoS75HrogkeRI94fihY
         yhovf81yb+wcjam0xNkgOEh+sX4oQy0qRI6wKWtMKhStqSISPg501J6MVaiQEE7gdSt3
         TZTQ==
X-Gm-Message-State: AOJu0YwJT2O/MTo5GfGqR38I1lbUn8ca+gs91JVNCmXlB1O1VJiWDiUe
	aJiRuO9C1drP1KW7AgSpiPRLnYRYzTS5f3h+EiPoVJ47KulLYbhZKxiwINjXmQ4meBxJJSMx0P5
	9KvGFJLQ=
X-Gm-Gg: ASbGnctNCP/hs+W6xIpqp08OW6pwzzSUiNhi2bXFiiAiujta+aa64/6VHAQsi7ZOLDi
	LRfc/42GAJld5OxdqWKvSeEPwvE/VaufzHZi8/9VzFrouFMowrhkiKrIT2lgTBIzr4Jlt9IwEtA
	Y/v6fLDjvodDwmmvKRjsfZPGpUXE4HR3fYpcsf1NySFJWf+vWD8t3FYu/LWGKmhC7svlAUNqaLM
	gV0O9/HfwacxmhpDejOJEWKfWot2LDWePcd7aLDztPmWpPPmJ+wV1gYNr/ymtnD9Gogw8oUZl1o
	6yicAaqFxaHoZ6ayRfuw3dR6HkY3/TNa1AKEIFKA+IPBeXYeLgWWRN0dxS6NVnkGs+hV
X-Google-Smtp-Source: AGHT+IGPhXDekeKt3kh/YkCyfn9XUuo4x3XOBxDW2r6ba/CZMKwPz/iz381Hxp6O2yGCdHwM0lGHZA==
X-Received: by 2002:a05:6808:23c3:b0:3f9:8b5b:294c with SMTP id 5614622812f47-40b33e49e69mr5400146b6e.31.1751129284179;
        Sat, 28 Jun 2025 09:48:04 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:3092:a48c:b0c6:cbf4])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40b322ae48esm876826b6e.13.2025.06.28.09.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Jun 2025 09:48:02 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Sat, 28 Jun 2025 11:47:53 -0500
Subject: [PATCH] iio: adc: ti-adc081c: drop use of model array
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250628-iio-const-data-11-v1-1-268189459192@baylibre.com>
X-B4-Tracking: v=1; b=H4sIALgcYGgC/x3MQQqAIBBA0avErBtQIbGuEi1Mp5qNhkoE4t2Tl
 m/xf4VMiSnDMlRI9HDmGDrkOIC7bDgJ2XeDEmoSWhlkjuhiyAW9LRalROn0PpMy1pOH3t2JDn7
 /57q19gGOiqoWYwAAAA==
X-Change-ID: 20250628-iio-const-data-11-1c6b9e28aded
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2833; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=HZ//Y2K0uLB5kUzMtO2XZBj9R2SSfFnWS2P7z4FMbnQ=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoYBy6uLICagDefVxEIgZfMwEUhPN1xFLCpmfmR
 zLOgJD11WCJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaGAcugAKCRDCzCAB/wGP
 wKELB/95Z85oOsmtBUIwe8GrPfyyxbYD7DOg4KITLqlr23Y0eQeWxoH0B9QUUPhPUDpR9obQF9n
 lbSIFIRoXZm4QZwns6wF3vlFD/SnkmigfGIVUuUq9XluJtFYfj8qF2nDoDFGpd3L3WzarzgYsWg
 6U1XG/Nm6c6365q/0yFeIZ0Z2rtu+wP9fKS8BIzSDm4xl8Brnt8ZhoomP2EDhW1zUtspCi0LDZy
 4UikqnV0Pa/AMpcoivZMQdXHgrF92Ng2jKqRF05dImiWrWvVZuMCDZTn42o3sfcKXxn5dZSi40w
 rUZqrYgZyAIAXSs/HU2CqnudNsYfxQibTgK0IenuaSmUS4Uv
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Change the ti-adc081c driver to use individual model structures instead
of an array. This reduces the verbosity of the code. Also, the data is
now const as it should have been in the first place.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ti-adc081c.c | 29 ++++++++++-------------------
 1 file changed, 10 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/adc/ti-adc081c.c b/drivers/iio/adc/ti-adc081c.c
index 4f514db5c26ea803660087ae02b2cf8ec71911e4..c09f41e8867c45a44a98f4409946c3256d34280f 100644
--- a/drivers/iio/adc/ti-adc081c.c
+++ b/drivers/iio/adc/ti-adc081c.c
@@ -112,18 +112,9 @@ DEFINE_ADCxx1C_CHANNELS(adc081c,  8);
 DEFINE_ADCxx1C_CHANNELS(adc101c, 10);
 DEFINE_ADCxx1C_CHANNELS(adc121c, 12);
 
-/* Model ids are indexes in _models array */
-enum adcxx1c_model_id {
-	ADC081C = 0,
-	ADC101C = 1,
-	ADC121C = 2,
-};
-
-static struct adcxx1c_model adcxx1c_models[] = {
-	ADCxx1C_MODEL(adc081c,  8),
-	ADCxx1C_MODEL(adc101c, 10),
-	ADCxx1C_MODEL(adc121c, 12),
-};
+static const struct adcxx1c_model adc081c_model = ADCxx1C_MODEL(adc081c,  8);
+static const struct adcxx1c_model adc101c_model = ADCxx1C_MODEL(adc101c, 10);
+static const struct adcxx1c_model adc121c_model = ADCxx1C_MODEL(adc121c, 12);
 
 static const struct iio_info adc081c_info = {
 	.read_raw = adc081c_read_raw,
@@ -203,24 +194,24 @@ static int adc081c_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id adc081c_id[] = {
-	{ "adc081c", (kernel_ulong_t)&adcxx1c_models[ADC081C] },
-	{ "adc101c", (kernel_ulong_t)&adcxx1c_models[ADC101C] },
-	{ "adc121c", (kernel_ulong_t)&adcxx1c_models[ADC121C] },
+	{ "adc081c", (kernel_ulong_t)&adc081c_model },
+	{ "adc101c", (kernel_ulong_t)&adc101c_model },
+	{ "adc121c", (kernel_ulong_t)&adc121c_model },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, adc081c_id);
 
 static const struct acpi_device_id adc081c_acpi_match[] = {
 	/* Used on some AAEON boards */
-	{ "ADC081C", (kernel_ulong_t)&adcxx1c_models[ADC081C] },
+	{ "ADC081C", (kernel_ulong_t)&adc081c_model },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, adc081c_acpi_match);
 
 static const struct of_device_id adc081c_of_match[] = {
-	{ .compatible = "ti,adc081c", .data = &adcxx1c_models[ADC081C] },
-	{ .compatible = "ti,adc101c", .data = &adcxx1c_models[ADC101C] },
-	{ .compatible = "ti,adc121c", .data = &adcxx1c_models[ADC121C] },
+	{ .compatible = "ti,adc081c", .data = &adc081c_model },
+	{ .compatible = "ti,adc101c", .data = &adc101c_model },
+	{ .compatible = "ti,adc121c", .data = &adc121c_model },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, adc081c_of_match);

---
base-commit: 14071b9cf2d751ff9bc8b5e43fa94fbf08aceea1
change-id: 20250628-iio-const-data-11-1c6b9e28aded

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


