Return-Path: <linux-iio+bounces-21272-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1CE7AF65F6
	for <lists+linux-iio@lfdr.de>; Thu,  3 Jul 2025 01:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BDC91C2337D
	for <lists+linux-iio@lfdr.de>; Wed,  2 Jul 2025 23:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B24782D780C;
	Wed,  2 Jul 2025 23:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NDsWE6ku"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9F22571BC;
	Wed,  2 Jul 2025 23:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751497709; cv=none; b=KSnisUD8cug3ivFtyQSmra76d6FyPqCM0Lk9LoB2Bfdaj/i9Kmwb6VpGG59kgr+R4TNtzeovuxXWUrn/OEDrVUGifpQnR7FeRmgPr4McwV9h7jWv819p7hnvDe6V+bQF1joKRAMrFRI6BSAsBXUwDk50Rvz1ETSKqKhAR7XSCfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751497709; c=relaxed/simple;
	bh=PQAXr6S0XgAhcSXyOgP43eWGaYqusaaZxS53WQKRVDM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=odfoaDvLESiAgTsF8BJ1VzNIDH0OS5T8n6IyYFAtJaJBm8DoQiPssP7F0uTr18EcIsoBx6IZZKSgWtDl41bYl9VoSX+z26wXp5oaThKxK6y//hnJeUlRstrCkleOANxlGAGfOakSZ0cpbhngg9FyugQd//IpH5AymPR+hooLTlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NDsWE6ku; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ae3521a129aso92911066b.3;
        Wed, 02 Jul 2025 16:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751497706; x=1752102506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w59lrAsElaWPPoAR9eeFoQ8em27eHSnFV7gwNhlMmW0=;
        b=NDsWE6kuFHw9WKwQxtWGghDXWMpyIBVixtpU+vYFyQz1sRmvFf48QYnbp/7wz7jO2h
         NKLAHQuomWgyWJTS4qEkz5aQunRBJUtMvVwtDqAiVDZmaRoISSFaWwFDfW/DrstZzGmx
         39v2IA4XgMm86F/tsBirL9JYgC7rnu3EIhLdt3tQD1OODykF9F5pF462RpjstvGbLxos
         0SWF8/yNShi7jKr1O8AmPIhdm9eF4bxV894PNJNoFhCAcLgSIxh2Jzj2u9fNLDh0mFF6
         FL1GqxDvAjhHnvgtkKbMYTCgsPiLZ3yr+gBF9CcLHCvEqB6GEe/LkqFYXiDPnSd8gmzC
         fzgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751497706; x=1752102506;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w59lrAsElaWPPoAR9eeFoQ8em27eHSnFV7gwNhlMmW0=;
        b=lT7byqnJNCemb6q47eG2pCDq48sOLC7MsIsRM0seh0Zt+dSWCZB443QRo6M4+ZexHk
         IZU38/BvyGc9lv+/L+xnGZKRfz7zQ44BIl0D5FlPby6nm9fjhzb8+DAXat45TRwPCOgn
         0L3wUMGMOeSx8UavijNf3bHF7ALtr52kXYdHhEvg8r2HsQHr+5HayNEx5NoiAexwulIV
         dmTWAdpgh2HWVlX8ETxUlDnMOFZO258vBvPKpDBLmPgGm8aP1VQTrJkYtW9hjBife0Wv
         HpyOfEWA9OK58AFl4RTPFWaAmuiknN8QE1dA8/GnlpLks6tPH+wKy8QQgcQAVGc2zs0/
         doqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxEJpLJgP8QFy88PE6OhC+bdA5gflfh+R1PUcx/MOVH8Q24fbq4+poG6FrVewLQF56J0VXV2FMby4VH7w4@vger.kernel.org, AJvYcCXSZaCndCVnRAyqmTNgNmQ3AvFirugwTJiDrweiqqd/ma3MtI4N/Y0TM4OsRcRwGfQ5zyZsEvlqj1c=@vger.kernel.org, AJvYcCXrFJscaAOpgSyrq51SphvVX2l5a961J4gUd0MnWfrfS66rgbQn8RczAlKw0Tg50VzLNyOTzwGTXvAB@vger.kernel.org
X-Gm-Message-State: AOJu0YyxwIz/U8OVzgf2LeKIclvZUlj4zvGMLE6UzOlU0F8ZNo9MRwLP
	C+1qT0DyA72j8pnLFdYjNIg0TqvOVpDu2BdYbT/tN5hMuDCDwf6/Zh9Q
X-Gm-Gg: ASbGncuLfZZYZZG95SyX2ikz+URwYmg/yShp2UVdAT5hlwVgNoJo8236aM5HH3eNsc3
	YGBBVq2/VbKE4TLMX5pD9IiovO5EauPCeTbzZa5m8xzfZDA5SiahqHdW/2THg3bzFH54hsvWW8h
	ZCpbBu5f+ZvZltJ9Dq9E8iMPZkMoIS4QTQl/pnGLIobikdt4UzkzX5UJccJpXTwEFt9g75ZOBE7
	4A5hOxEU8gsmi0xX7RSCXScr1S4/2VgTVqIlV9YOHFF4xF+DtiAywSQdXgqrfKpbzwohMp3A3go
	3Zv/tPxfTBW9MWYf4vInGtTasgQTOVHVLTBTBs3AsbjMEP5bRvKc2N5OlybiHMnhzHebqn5SpLW
	WStnjvCYAI1pcZTyappndMRwIowdoXaHm
X-Google-Smtp-Source: AGHT+IHgbc0eU93Rys9qxb7O4vEqYNJOnowhFeldLswrvAa+eYchLBwyICmMgYOlmvXcTbPVEATEaA==
X-Received: by 2002:a05:6402:321c:b0:60c:45fe:c6de with SMTP id 4fb4d7f45d1cf-60e764fc980mr20734a12.0.1751497705855;
        Wed, 02 Jul 2025 16:08:25 -0700 (PDT)
Received: from localhost.localdomain (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae353ca18bbsm1158355566b.151.2025.07.02.16.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 16:08:25 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	corbet@lwn.net,
	lucas.p.stankus@gmail.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	bagasdotme@gmail.com
Cc: l.rubusch@gmail.com,
	linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 2/8] iio: accel: adxl313: add function to enable measurement
Date: Wed,  2 Jul 2025 23:08:13 +0000
Message-Id: <20250702230819.19353-3-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250702230819.19353-1-l.rubusch@gmail.com>
References: <20250702230819.19353-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Refactor the control of measurement and standby modes for the sensor.
Instead of directly writing to the register, encapsulate this operation
in a dedicated function that handles enabling and disabling measurement.
This approach will reduce code duplication wherever sensor configuration
changes are required. In subsequent patches, measurement mode will be
set to standby as part of this process.

Additionally, simplify the control mask to include only the measurement
bit. The sleep bit governs a different behavior—putting the sensor into
sleep mode, not just standby for configuration—and is currently unused.
Therefore, there's no need to include both the sleep and measurement
bits in the same mask.

Reviewed-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl313.h      |  3 +--
 drivers/iio/accel/adxl313_core.c | 10 +++++++---
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/accel/adxl313.h b/drivers/iio/accel/adxl313.h
index 2bc86ac8ffd4..6958a00f5e8f 100644
--- a/drivers/iio/accel/adxl313.h
+++ b/drivers/iio/accel/adxl313.h
@@ -37,8 +37,7 @@
 #define ADXL313_RATE_MSK		GENMASK(3, 0)
 #define ADXL313_RATE_BASE		6
 
-#define ADXL313_POWER_CTL_MSK		GENMASK(3, 2)
-#define ADXL313_MEASUREMENT_MODE	BIT(3)
+#define ADXL313_POWER_CTL_MSK		BIT(3)
 
 #define ADXL313_RANGE_MSK		GENMASK(1, 0)
 #define ADXL313_RANGE_MAX		3
diff --git a/drivers/iio/accel/adxl313_core.c b/drivers/iio/accel/adxl313_core.c
index dc5f04b17b29..1be4e867f4b2 100644
--- a/drivers/iio/accel/adxl313_core.c
+++ b/drivers/iio/accel/adxl313_core.c
@@ -64,6 +64,12 @@ bool adxl313_is_volatile_reg(struct device *dev, unsigned int reg)
 }
 EXPORT_SYMBOL_NS_GPL(adxl313_is_volatile_reg, "IIO_ADXL313");
 
+static int adxl313_set_measure_en(struct adxl313_data *data, bool en)
+{
+	return regmap_assign_bits(data->regmap, ADXL313_REG_POWER_CTL,
+				  ADXL313_POWER_CTL_MSK, en);
+}
+
 static int adxl312_check_id(struct device *dev,
 			    struct adxl313_data *data)
 {
@@ -398,9 +404,7 @@ static int adxl313_setup(struct device *dev, struct adxl313_data *data,
 	}
 
 	/* Enables measurement mode */
-	return regmap_update_bits(data->regmap, ADXL313_REG_POWER_CTL,
-				  ADXL313_POWER_CTL_MSK,
-				  ADXL313_MEASUREMENT_MODE);
+	return adxl313_set_measure_en(data, true);
 }
 
 /**
-- 
2.39.5


