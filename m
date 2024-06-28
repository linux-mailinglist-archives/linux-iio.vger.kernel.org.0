Return-Path: <linux-iio+bounces-7011-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A05A191C194
	for <lists+linux-iio@lfdr.de>; Fri, 28 Jun 2024 16:49:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3C181C235B0
	for <lists+linux-iio@lfdr.de>; Fri, 28 Jun 2024 14:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162501C6885;
	Fri, 28 Jun 2024 14:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="sdjG6zKE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E051C6889
	for <linux-iio@vger.kernel.org>; Fri, 28 Jun 2024 14:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719586126; cv=none; b=f1Di7JGr1/gLDBzW1xjFF8SoObN0C50Tll4ueKHnCe6EyjjJXoy1pq41ERXLHZOrGT/3ha4X8G/LCv8F0EqWqe3bfrvRJQWxNBzYqplxMCKujn402jf9bSyj/aoiRBEM+VG10+m4y+gfOJHRtj/VW3wu+Xg5L0YyL45Vesf16sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719586126; c=relaxed/simple;
	bh=RRVxrhmiJTmhlGYh89+GPwU4++bLSJaxdW8aC4AKucw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d27EkJ+QinO8caYnYYSlEKAqKCmhlelC5MDCnkBKBGGrPmop9e6RGtHWTFoKvf4aLIJ42i/q+jwzrJKv+AVbeNbkpD4a/qqjkBERi0oWBguWXVUF8ersg2bvse6h5iR5qZ5xCvYZFaFPKHVtGQsljwjaCYJr2vliGRinX1BwcRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=sdjG6zKE; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52cdea1387eso771867e87.0
        for <linux-iio@vger.kernel.org>; Fri, 28 Jun 2024 07:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719586122; x=1720190922; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IfIReJIeFXvHpoiQHEHuzoccsHNqOqmDnyW69xYvlNI=;
        b=sdjG6zKEGCjpZZT3n+bLMSLi1LVhn7HvOK5Gl7RAFAXoTsqxR1Gkmuq9wPrfbMl1qj
         dN8ASkjCFr90cCyn4U1AJQAs52aB9ew+F1xev3bPX7hTrV9+G+Ag4YT98JA3wrXvict1
         HkzOkfqaeGMWi+Zeh0n1rK8faoZQpBopzW4+oNjo/QnbLglPxinal/n8EdUHgCIF4z5S
         qa5Qnr8MVQRLyQ4qLKrE40A63KYXuRiB4Yu8NsCjsCln2jBtRT9dT0tzV8d9sZGke0eP
         rf4KJL0KhRxTEE55+Jn8r/NxCenmYCaSCwYqwpkC/cYfG3ZFsxIZ26/2DXKPSFgmacZf
         4Ohg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719586122; x=1720190922;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IfIReJIeFXvHpoiQHEHuzoccsHNqOqmDnyW69xYvlNI=;
        b=wAEgVE48Fsvae1Sr/8wxWlhZAJbooVjwdqZa2iBbTTWgCpTwA2u5j/JeKFu3nxXz7j
         1Gi6Th+ZqdnzADZLKwRDr58+iQ5XL1mbVK1E2cwDOA9gsL/KzSQK+yCGihvHBAsjYIcX
         4KGAURNZ9XwHv0NmkZ/Uljm/pXdCjI6SeV8+oR2UAlmxC3gv+t5yG15LuGozds6/oSJZ
         +hHwXKJOeHaeC8xdqx6jpzileQA73NPs83C+zvCZg5f7SHCqApgqKASx+V2FHg04HKik
         cVfUcSrX6juFsowwPfgqLE1zq52SGzeGTNPyE7+mVT29fxhIsmexZSJrkkYjqvNygjZg
         4z5g==
X-Gm-Message-State: AOJu0YyasDwEV6JcK8y5DjkD+tw+lfUsQrfqkof+leHETalTjirbKSlC
	TTWSyD1EeUZtDHtoB9LLGSE0mxvv28ytzyHVemjX/tHzxAZJDzMZ/bMX68WS93E=
X-Google-Smtp-Source: AGHT+IF81L4/up6bPW02mm70ucgyml0B1zImJ0pYtdBOId4ZIEAeB4DjvRZW4P6xwugwAET/wtM+1Q==
X-Received: by 2002:a05:6512:2254:b0:52c:e17c:3753 with SMTP id 2adb3069b0e04-52ce18320e6mr12902911e87.5.1719586122396;
        Fri, 28 Jun 2024 07:48:42 -0700 (PDT)
Received: from [127.0.1.1] (frhb82016ds.ikexpress.com. [185.246.87.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256af55c0asm37972575e9.15.2024.06.28.07.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 07:48:42 -0700 (PDT)
From: Guillaume Stols <gstols@baylibre.com>
Date: Fri, 28 Jun 2024 14:48:26 +0000
Subject: [PATCH v2 08/10] iio: adc: ad7606: fix oversampling gpio array
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240628-cleanup-ad7606-v2-8-96e02f90256d@baylibre.com>
References: <20240628-cleanup-ad7606-v2-0-96e02f90256d@baylibre.com>
In-Reply-To: <20240628-cleanup-ad7606-v2-0-96e02f90256d@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Beniamin Bia <beniamin.bia@analog.com>, 
 Stefan Popa <stefan.popa@analog.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Guillaume Stols <gstols@baylibre.com>, jstephan@baylibre.com, 
 dlechner@baylibre.com
X-Mailer: b4 0.14.0

gpiod_set_array_value was misused here: the implementation relied on the
assumption that an unsigned long was required for each gpio, while the
function expects a bit array stored in "as much unsigned long as needed
for storing one bit per GPIO", i.e it is using a bit field.

Fixes: d2a415c86c6b ("iio: adc: ad7606: Add support for AD7606B ADC")
Signed-off-by: Guillaume Stols <gstols@baylibre.com>
---
 drivers/iio/adc/ad7606.c     | 4 ++--
 drivers/iio/adc/ad7606_spi.c | 5 +++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index 3a417595294f..8cce1fad9763 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -236,9 +236,9 @@ static int ad7606_write_os_hw(struct iio_dev *indio_dev, int val)
 	struct ad7606_state *st = iio_priv(indio_dev);
 	DECLARE_BITMAP(values, 3);
 
-	values[0] = val;
+	values[0] = val & GENMASK(2, 0);
 
-	gpiod_set_array_value(ARRAY_SIZE(values), st->gpio_os->desc,
+	gpiod_set_array_value(st->gpio_os->ndescs, st->gpio_os->desc,
 			      st->gpio_os->info, values);
 
 	/* AD7616 requires a reset to update value */
diff --git a/drivers/iio/adc/ad7606_spi.c b/drivers/iio/adc/ad7606_spi.c
index 263a778bcf25..287a0591533b 100644
--- a/drivers/iio/adc/ad7606_spi.c
+++ b/drivers/iio/adc/ad7606_spi.c
@@ -249,8 +249,9 @@ static int ad7616_sw_mode_config(struct iio_dev *indio_dev)
 static int ad7606B_sw_mode_config(struct iio_dev *indio_dev)
 {
 	struct ad7606_state *st = iio_priv(indio_dev);
-	unsigned long os[3] = {1};
+	DECLARE_BITMAP(os, 3);
 
+	bitmap_fill(os, 3);
 	/*
 	 * Software mode is enabled when all three oversampling
 	 * pins are set to high. If oversampling gpios are defined
@@ -258,7 +259,7 @@ static int ad7606B_sw_mode_config(struct iio_dev *indio_dev)
 	 * otherwise, they must be hardwired to VDD
 	 */
 	if (st->gpio_os) {
-		gpiod_set_array_value(ARRAY_SIZE(os),
+		gpiod_set_array_value(st->gpio_os->ndescs,
 				      st->gpio_os->desc, st->gpio_os->info, os);
 	}
 	/* OS of 128 and 256 are available only in software mode */

-- 
2.34.1


