Return-Path: <linux-iio+bounces-18541-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F933A97A21
	for <lists+linux-iio@lfdr.de>; Wed, 23 Apr 2025 00:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 578957AA0EB
	for <lists+linux-iio@lfdr.de>; Tue, 22 Apr 2025 22:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730EB20D4F6;
	Tue, 22 Apr 2025 22:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="wwP0vpVX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCB32C2AC0
	for <linux-iio@vger.kernel.org>; Tue, 22 Apr 2025 22:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745359733; cv=none; b=adAi0u+aZW7xQzx6BkS4SbG6IJ/b3wyl3bHSvdTmsJ8SqN3stomgO61GC8IG4yNEy7nPeiEwTRHoDYDP+jK4pVbrKUcE4IImBRQe80inFxVbHMDFZHelFGsNmNjSx7W5l4ySj6cuWQ5b0t8Hnk2brcBXd/WPkfk6ltna9HEpab0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745359733; c=relaxed/simple;
	bh=bNzghGrt115+ZKNUZFU+xQJSBPkqwVs5iV+9xGBsm0g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F0KxyNA5NqnepBOOf0JufLt1iDacd89XbhgCTwpujyk4/mxGKpf+dFpfnRjdgL3MKdVgmYnvCoVxzXdntWgvAYpo16vVRne4OKz4ZmL4EHYVq9ZiRSlrA8Auc9M4xLw5NXc92eAbhKeBj9PRl1qI8W+UEBTLfMoh2Qy7vFFhufY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=wwP0vpVX; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7303d9d5edeso271007a34.1
        for <linux-iio@vger.kernel.org>; Tue, 22 Apr 2025 15:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1745359730; x=1745964530; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OcAjMtDsEwOO8O58Cs5cDx4aKARQOhUbmH4snH5r6Ms=;
        b=wwP0vpVXveZpmTzOqMCFvr2+JpZPkCrlyyBPngKI7UH1rQ3ONsXMczrsodi5+qk/oN
         YgL8aDq27iBcdk5Vm6va03r0k1viRip3K7PNbySL8DwVNhAj7nIFLvx6eHWRTCN5/dse
         K5QFJMRNv/P64JpCI3Z04l4DTy5WnU7wH8afVcPJX5pF3Wu1uCXGjuE12cP+mnsyFyMZ
         oR7LXtggDdU7ns7ACc2xOPLODQBhWMxUiYVnLbxHnHaSEMm4EkmqoczwKxdLi4c1tHyL
         bBdJvo6kR1xKPnsJb400nUD/5UeLRPOJn1FZBdxHcndiNJHiAIoT+5J2ql1uuZndc/Ld
         S34A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745359730; x=1745964530;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OcAjMtDsEwOO8O58Cs5cDx4aKARQOhUbmH4snH5r6Ms=;
        b=WBdxlrA8j87hCToxP+XZooOEZP1WjIveGPM8aF9rJOtZMWAwfA6AiM4WkiG+wEuOyq
         gqOO2a9KsvFlvcpmvQj++QDl08jVmVimnk5dgvyzY7mPSBtzLkDHq6/VDC8yBkc91PXl
         BHoV361yZ8eELi2h4tJQf3ixlFLz61YUVTIFwNsmQ099450OFEycyxODlA+ISd6SioT4
         pv7k8sb5S3UiZdNgDetAefRPDzVOPbmg4KpgQBy9WA5Zt8LwCDDt617zHw8+jcBiJluQ
         ynGg3zFwE0YKu4JFtnuxGMHbu/RRl41ra3isMzJMpY+S5Kssz1gNUaBjc+EwFwFae9kH
         F2jQ==
X-Gm-Message-State: AOJu0YzdSZtnJyQnNHaJnB65GJwM/db08YmD2Fia6LrLfCeHsLCipWzp
	cuIjr3DuinKoH/GuinqyFdf2rRHidzMFeI+FfI9GhVw5NRoH8ZItAxvLYZADdcE=
X-Gm-Gg: ASbGncuCl2ZX63/4iKakNrZQkCes3+IiT70kJZdMv7mixHeZdp/2B/Br63Ka1am46BD
	x0cRT3R+EAeYNZ99xu5LeazHw87b6hyFkUuM9ez1nQbnYnSqKolnbyafz/7FQ9PP0yeymNFLlEF
	tYGiz0lAVjnZJh9bvCu39Yig+dH62jtyl96iN0GfGYeGNTpRsEmyUpMu4mYjOUEso53ZMWaYZhf
	EFjEgt+HnkzMwPUSrbeH2bdCl7fuhn14/vfdbDlD1m8UiiEmpTQW37pnZSmdA2WJ4V/hGmcd2Hu
	2mJ/Gvn0YXkXWO5juTlmHkzzkYlP3zu4qJdPhawlQnhniys=
X-Google-Smtp-Source: AGHT+IHzzwKW3y0fInhdjWSpsuJ5JmWctR16v6GWhHHGSelSclI2sxPnML9dTnb8TnnyDMSSFW1wDQ==
X-Received: by 2002:a05:6830:61cb:b0:72a:1dfc:c981 with SMTP id 46e09a7af769-730063304edmr11661860a34.25.1745359730406;
        Tue, 22 Apr 2025 15:08:50 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:c8d1:e0ed:ce8b:96a3])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-730048848dfsm2265938a34.52.2025.04.22.15.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 15:08:50 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 22 Apr 2025 17:07:51 -0500
Subject: [PATCH v2 6/6] iio: adc: at91-sama5d2: use
 IIO_DECLARE_BUFFER_WITH_TS
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250422-iio-introduce-iio_declare_buffer_with_ts-v2-6-3fd36475c706@baylibre.com>
References: <20250422-iio-introduce-iio_declare_buffer_with_ts-v2-0-3fd36475c706@baylibre.com>
In-Reply-To: <20250422-iio-introduce-iio_declare_buffer_with_ts-v2-0-3fd36475c706@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1674; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=bNzghGrt115+ZKNUZFU+xQJSBPkqwVs5iV+9xGBsm0g=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoCBNjAzzt1sRYLcJPXzefhzYxHcbR4XNJFDKvZ
 JN6D57NVvyJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaAgTYwAKCRDCzCAB/wGP
 wFKfB/45NebbapbIP3t4eBe7IDDKz2IX0X7vuL1EOiu0sCj5YLzAqoCos3aGbC3nAYBmnTV/9hu
 cGfDIiEMSXlDgH7ASvPN7SFQ/ANjGO2xc896/FcMxGq/kyx3dOp33a9ienXD+mFjne9N1/PXWIg
 oO+XPo6f+HtvNvjb/uyALdwB822D7BpmRJ2i765kt5mysIPkY5yd1SBIXUu4sT9gLI9lMfV+oIo
 MqxuocA4UYA0VEMFVRssN3TAOhlHC5i+k06k7VuE04rpLH+kqyuHDcLJvBuDJnsLBOsic2D2h+q
 5Kbts705K+v72L/z4sznTI1YwjSMGRe0UILK+jAPLEOzrS4u
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Use IIO_DECLARE_BUFFER_WITH_TS to declare the buffer that gets used with
iio_push_to_buffers_with_ts(). This makes the code a bit easier to read
and understand.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
This is an alternative to [1].

[1]: https://lore.kernel.org/linux-iio/20250418-iio-prefer-aligned_s64-timestamp-v1-2-4c6080710516@baylibre.com/
---
 drivers/iio/adc/at91-sama5d2_adc.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index 414610afcb2c4128a63cf76767803c32cb01ac5e..4ebaeb41aa4568e2461506471af0540af9d1a041 100644
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
+	/* We assume 32 channels for now, has to be increased if needed.*/
+	IIO_DECLARE_BUFFER_WITH_TS(u16, buffer, 32);
 	/*
 	 * lock to prevent concurrent 'single conversion' requests through
 	 * sysfs.

-- 
2.43.0


