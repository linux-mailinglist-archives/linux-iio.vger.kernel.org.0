Return-Path: <linux-iio+bounces-7897-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C723793CB15
	for <lists+linux-iio@lfdr.de>; Fri, 26 Jul 2024 01:11:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A2022821D6
	for <lists+linux-iio@lfdr.de>; Thu, 25 Jul 2024 23:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3DFC14A091;
	Thu, 25 Jul 2024 23:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GDBUr8jp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C787149C76;
	Thu, 25 Jul 2024 23:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721949052; cv=none; b=Y96EGsHQZZTyW+cLpdqgCaZagl+M1NxbDCecZFBmWHLEUIVff1JkxxsrBaD/YR3TUSKqnYqSIjvsdUmbAlAX7E0tiXPiiOO4xRW8FHkOdYGfNhmNXSOw+R4IiSOc9eLufMOZITKoC7vatKCbXBla6a64bWbatJwnDJ7ZnPvSWBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721949052; c=relaxed/simple;
	bh=rJAiuV9xx9FMZGrsIzqR6PXw570zKjEmwwuD7DwG4j8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ekXusQzb+j0w3AB5QJGa/qP7jyzKcmQzS2dSq4hy7oLdLimkLOK3iXpITGhbdflyVTOiD+XRZZPs3xOMXp7sIddVPfBm19ucFcNtteE1kYTQEow4sKanbrlkvql2XzJKf0zVJwemBtq7FrTVKInXC0giWzWrhrudQsoskxYkqG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GDBUr8jp; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4266dc7591fso10563875e9.0;
        Thu, 25 Jul 2024 16:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721949049; x=1722553849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Ha6q96XujnRfh9y64ZqiYgBLoCWejUjagA6iayTCJI=;
        b=GDBUr8jp5mPI4pZiucXsk/8V+9H0/17EIO/pSuz1x50IJ71WoqXo3lAOtFtiYcUwKi
         ap+/cGXaStKF8Y7KEjbRUmiiMErcqgVmo7jt21pxB3/3z/uA0FIb0bvQF4MDAqkizo1h
         BFllzh2Jpib/k0Mqf0V0dC3e4DWkMPQQdyqOyOGM8hAVJbNrm/Eb2YQslk9z8IETXjLz
         xcDStsKL8gi2qIIqGxf3GlpGqjzJrtPlqp8A+gXjHB+fSjHGRvZ/vEyTG5osXaS4YIK2
         DqOpbgkhqwSdamgDd6gMnYB/g52oIC0VAFoegieAE9LwvsP2H3tlCLCGvP/zHO6nk/J8
         /UdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721949049; x=1722553849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Ha6q96XujnRfh9y64ZqiYgBLoCWejUjagA6iayTCJI=;
        b=t7g43Ff+woSGpy6MeDfsNqVI3u8nGhy+Z95bVhvyqLiMNfgW+dvlnUz+3sOPw0C7+S
         neN1gDs1YnNSbVaR1RD3SuYKHNPvFg+kuEgDgu2AIFYNf6zaBhVEBXHVtoXEVKzLh+n7
         2YoPEwCb0ZlC6uDzRjuA3tuqrNNDVYWgp4aHo883kROf03zxS95u+aofGsMg4x3YJ9i3
         G/QnM479H8kxovwrFVeAiDbmtiOqgOxT/Z9Vt+siA+V0j7np1PSEpi9nwLZChr01iMqH
         BJBgq1H6+rzThwGP6jRrCAUktt2GWY4CpEfyq/K/vbSqh+b8mTowrQpc+eBH0C/FoSTm
         dmAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQZNdkFBuIs8HoH+h1X/vuIF4bSV99h7kv1l3cuKeCrNJJ7Gw6nuPlgod+DxOVnK0CKqnwvMB1pwBNNPm6XSGYuQPglO/PCNnsKI9z4obO19IFYpMuplJ948a/iqL1DIXqsOE+yQeIwA02FNxYs0YncdYN9j4kHKQa5EEU+e4WWgDOvQ==
X-Gm-Message-State: AOJu0YwZNoi0TFV10fX2B7nVnNtJt2FmdOktrPGJO1MQ+5qrOPm6JNAt
	TBVaNWkMYoL2EgP6f4D5HxFVLdvbpZMuyeInv5YFqnlzjpB49DvO
X-Google-Smtp-Source: AGHT+IHDSfPhmfbTnKDzdWE2s3vNyOy722FZtFV8IstpuXIcCd1h7ZDHrXpv0HS8rK8uklIo7GYYSg==
X-Received: by 2002:a05:6000:cca:b0:368:37d5:3f2e with SMTP id ffacd0b85a97d-36b36445604mr2175914f8f.32.1721949049084;
        Thu, 25 Jul 2024 16:10:49 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:4b59:cba2:6db8:9f30])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acab236e3sm115429266b.25.2024.07.25.16.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 16:10:48 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andriy.shevchenko@linux.intel.com
Cc: vassilisamir@gmail.com,
	ang.iglesiasg@gmail.com,
	linus.walleij@linaro.org,
	biju.das.jz@bp.renesas.com,
	javier.carrasco.cruz@gmail.com,
	semen.protsenko@linaro.org,
	579lpy@gmail.com,
	ak@it-klinger.de,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/7] iio: pressure: bmp280: Remove config error check for IIR filter updates
Date: Fri, 26 Jul 2024 01:10:35 +0200
Message-Id: <20240725231039.614536-4-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240725231039.614536-1-vassilisamir@gmail.com>
References: <20240725231039.614536-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When there is a change in the configuration of the BMP3xx device, several
steps take place. These steps include:

1) Update the OSR settings and check if there was an update
2) Update the ODR settings and check if there was an update
3) Update the IIR settings and check if there was an update
4) Check if there was an update with the following procedure:
	a) Set sensor to SLEEP mode and after to NORMAL mode to trigger
	   a new measurement.
	b) Wait the maximum amount possible depending on the OSR settings
	c) Check the configuration error register if there was an error
	   during the configuration of the sensor.

This check is necessary, because there could be a case where the OSR is
too high for the requested ODR so either the ODR needs to be slower or the
OSR needs to be less. This is something that is checked internally by the
sensor when it runs in NORMAL mode.

In the BMP58x devices the previous steps are done internally by the sensor.

The IIR filter settings do not depend on the OSR or ODR settings, and there
is no need to run a check in case they change.

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/pressure/bmp280-core.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index acbc33aacc09..431fbe9f3ee9 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -1553,14 +1553,12 @@ static int bmp380_chip_config(struct bmp280_data *data)
 	change = change || aux;
 
 	/* Set filter data */
-	ret = regmap_update_bits_check(data->regmap, BMP380_REG_CONFIG, BMP380_FILTER_MASK,
-				       FIELD_PREP(BMP380_FILTER_MASK, data->iir_filter_coeff),
-				       &aux);
+	ret = regmap_update_bits(data->regmap, BMP380_REG_CONFIG, BMP380_FILTER_MASK,
+				 FIELD_PREP(BMP380_FILTER_MASK, data->iir_filter_coeff));
 	if (ret) {
 		dev_err(data->dev, "failed to write config register\n");
 		return ret;
 	}
-	change = change || aux;
 
 	if (change) {
 		/*
@@ -2149,15 +2147,13 @@ static int bmp580_chip_config(struct bmp280_data *data)
 	reg_val = FIELD_PREP(BMP580_DSP_IIR_PRESS_MASK, data->iir_filter_coeff) |
 		  FIELD_PREP(BMP580_DSP_IIR_TEMP_MASK, data->iir_filter_coeff);
 
-	ret = regmap_update_bits_check(data->regmap, BMP580_REG_DSP_IIR,
-				       BMP580_DSP_IIR_PRESS_MASK |
-				       BMP580_DSP_IIR_TEMP_MASK,
-				       reg_val, &aux);
+	ret = regmap_update_bits(data->regmap, BMP580_REG_DSP_IIR,
+				 BMP580_DSP_IIR_PRESS_MASK |
+				 BMP580_DSP_IIR_TEMP_MASK, reg_val);
 	if (ret) {
 		dev_err(data->dev, "failed to write config register\n");
 		return ret;
 	}
-	change = change || aux;
 
 	/* Restore sensor to normal operation mode */
 	ret = regmap_write_bits(data->regmap, BMP580_REG_ODR_CONFIG,
-- 
2.25.1


