Return-Path: <linux-iio+bounces-19272-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3FA0AAED40
	for <lists+linux-iio@lfdr.de>; Wed,  7 May 2025 22:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC0611B66039
	for <lists+linux-iio@lfdr.de>; Wed,  7 May 2025 20:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96BD328FA8E;
	Wed,  7 May 2025 20:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="cBnxvw/p"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF66F290095
	for <linux-iio@vger.kernel.org>; Wed,  7 May 2025 20:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746650635; cv=none; b=Of5/okbP/NtrszmVsMK2Xe2CpcxeRtV7Thb7eX5Ik2mkc5FrCh42UVty01cH7SAQ65oE0cSG8+WyaSQ+tT+kOpNcndxWKiBZgvvco+B14ly6gREZn1zBTpaMlu7uFMPwLQ2vgXkumD5eZVQVy6luBSLS3UhM/E5BSJMOJ8do74k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746650635; c=relaxed/simple;
	bh=E9PIAfLoyJ0RJi3D/ewNgK6tsUeqLYCSdDUrepVzsaE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HsFuHVtnbpyr/pWJbdvCrDYeZAkGBddC85YqyBrnAsaaKKIwGA8dXfjn5TLQtCCq+3OjkMWREAp8OkKQuOSCRr0PfUAs8VJnavBNbeUtpKm//PLTvxrQJ7lb1nBh8dAQcLpH0WN3uvRMB6JvuP1AXNhdWmWWxfQWc1hq/BXOjkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=cBnxvw/p; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-2cc57330163so305382fac.2
        for <linux-iio@vger.kernel.org>; Wed, 07 May 2025 13:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746650633; x=1747255433; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AkEEnGIyeDiVPJ1Vchg86i4F6EdVT5nAWBfWqQhvCKc=;
        b=cBnxvw/pK9M+OgCA9fecZ6Qj6seCy+4+ZfudiWK0UfdFC+AgrKZrR+T8DKCBirFM43
         DZ90jmVifHGRTiVRtYSuda1E4RteaU0+4ItZgxlDMAk6nFkTBa1bof42yjH4LzHZKx3+
         Y/uSLRDbdn/q8Pqg1qmWOoCNAV+bSORgYnYxiWGc8fExRXqUqkTt5XgtvUSF/LhkTMEl
         oHfgQ5m5xDGwLPjvL3Z+MjbUbJSRKaVB/UFz1XnX+4tWbwSBROe1FYmEp8wuplenjAux
         fk1lm/Q3qm1QhxmKKhbbdaWgv/iVMMFUbptLdC3TOcA/Fb6rKZK7adlQF/0A0La+xF6a
         CgEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746650633; x=1747255433;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AkEEnGIyeDiVPJ1Vchg86i4F6EdVT5nAWBfWqQhvCKc=;
        b=cW2yDN7jHu+c2kMNYLlhfA/Fr3xp7Gxp6elFF2vpTKU4ZmLQV0pEO/68DPMfCQpB7J
         hH50xEtQpd1iaidP9rc0PaNdAdaPIXznu0Tn9m6DQV9JEyC5c02J+hUwiN+PvhOkzk8v
         wzyYZN+JQ8bVU8RL/rlBU2eHZ64T/1G7H1TYKawyV9n3ru8c1B8QQUGajebU1tRGx+6y
         xZX3phYm/IkzkH9bvGZH3h4TIs70Ecsk9ufrhTDHkJghnWngoy17BBqBsdW3FFi4X0+/
         jDK+tAGb0sI4TNBk67NRtcbb7hqaX6blqmWuRGoErVNpOS7HkfX7Ozy2j7kME+FTiPDo
         NE3w==
X-Gm-Message-State: AOJu0YzFm3EUafZI5eRn51N09R4NunpriKrd8oCpcpmzJI8Sf01CUs8R
	+6NE+cCOohqhQJdANmKEJ1mHlRsItFwM2n3HPUVnWt7Q4OktI6+6FvkdsUvliRM=
X-Gm-Gg: ASbGncuoOsgjk9z2ojVCXkVpRZvit8qFsPQB/97cfva+Z3Ap8+rBBAzZR2UXWXgR4qZ
	6w1twT+5+qMeR+6LP8q5It5GdAWPtqxfBso4csz796XzfP3GzPpRegu9BWGGlBKA/wRWl7dN5eh
	hoNZrA9S4eJ31nqKW6IzMVeYnIasAZLVO757bRkyopff7VOfd58cx2Ze2Df7lV1kSlXd7K2IelV
	yW+LRjbAGuuQ093PNO+7WRaZz+oPIWXDJ5zjb+hyrJwoqq1sa3m5/nweK0Jb10PRHCJvf7zdWFF
	oUu5yfnOcQNQK9rS69DiIRGWbKN9Z01C6uVbHSHvDRj+0A==
X-Google-Smtp-Source: AGHT+IFv9/lwSfeqqxrnWeC2Lb3fTYoOfdj8WDrV1djbCLjHfaiWSRE1YF1jLbIdYdNWncmdHjrl4g==
X-Received: by 2002:a05:6870:47a8:b0:2b7:f8d9:d5f7 with SMTP id 586e51a60fabf-2db5becfba8mr2933835fac.19.1746650632817;
        Wed, 07 May 2025 13:43:52 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:3356:f6f6:bf76:a32])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2db5cd716d3sm898642fac.21.2025.05.07.13.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 13:43:51 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 07 May 2025 15:42:46 -0500
Subject: [PATCH v6 7/7] iio: adc: at91-sama5d2: use
 IIO_DECLARE_BUFFER_WITH_TS
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250507-iio-introduce-iio_declare_buffer_with_ts-v6-7-4aee1b9f1b89@baylibre.com>
References: <20250507-iio-introduce-iio_declare_buffer_with_ts-v6-0-4aee1b9f1b89@baylibre.com>
In-Reply-To: <20250507-iio-introduce-iio_declare_buffer_with_ts-v6-0-4aee1b9f1b89@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Eugen Hristev <eugen.hristev@linaro.org>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1780; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=E9PIAfLoyJ0RJi3D/ewNgK6tsUeqLYCSdDUrepVzsaE=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoG8XzuxRWPot5Lj1UBI0PQHvKcH+S/2Js7bWDC
 MwB352L8NCJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaBvF8wAKCRDCzCAB/wGP
 wC1JB/0Qrc6VwdlpFKuZ/ZskSEubr5JpckDQsyuLEoWu5pHwj3LfH2VhLa8WVcMwLPGyWbNbyQA
 33488s4yfq3TNY1UOh5vaoWaqGkVmfSzeS24yx8k0aSi0KKfUJWNZparRvnuBocE6/6fF/dQKGX
 9DTINk3cX+Nsrl+Ohqa0A8MU114uOBom9yKi0ukZKc3ue+pkKI/LKWU1lUYP6CPz9/Tmo0Aiom0
 kXxkWMtUU0ZBWlzv8u3nQ67fLe/pKlrlRh8noB2RDIK1ucNK8cgf3PgyZi8pm+NVMw2MWx8OOQl
 dlVuaTnCVHdp0ACpYSrD2WYk9ahopTw10uq3rJEVjmBWh2/N
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Use IIO_DECLARE_BUFFER_WITH_TS() to declare the buffer that gets used
with iio_push_to_buffers_with_ts(). This makes the code a bit easier to
read and understand.

Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v5 changes:
* Fixed missing space at end of comment.

This is an alternative to [1].

[1]: https://lore.kernel.org/linux-iio/20250418-iio-prefer-aligned_s64-timestamp-v1-2-4c6080710516@baylibre.com/
---
 drivers/iio/adc/at91-sama5d2_adc.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index 414610afcb2c4128a63cf76767803c32cb01ac5e..c3450246730e08cdacc975ed19f46044dc76848f 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -586,15 +586,6 @@ struct at91_adc_temp {
 	u16				saved_oversampling;
 };
 
-/*
- * Buffer size requirements:
- * No channels * bytes_per_channel(2) + timestamp bytes (8)
- * Divided by 2 because we need half words.
- * We assume 32 channels for now, has to be increased if needed.
- * Nobody minds a buffer being too big.
- */
-#define AT91_BUFFER_MAX_HWORDS ((32 * 2 + 8) / 2)
-
 struct at91_adc_state {
 	void __iomem			*base;
 	int				irq;
@@ -616,8 +607,8 @@ struct at91_adc_state {
 	struct at91_adc_temp		temp_st;
 	struct iio_dev			*indio_dev;
 	struct device			*dev;
-	/* Ensure naturally aligned timestamp */
-	u16				buffer[AT91_BUFFER_MAX_HWORDS] __aligned(8);
+	/* We assume 32 channels for now, has to be increased if needed. */
+	IIO_DECLARE_BUFFER_WITH_TS(u16, buffer, 32);
 	/*
 	 * lock to prevent concurrent 'single conversion' requests through
 	 * sysfs.

-- 
2.43.0


