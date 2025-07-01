Return-Path: <linux-iio+bounces-21211-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D7CAF05C6
	for <lists+linux-iio@lfdr.de>; Tue,  1 Jul 2025 23:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BC954483E2
	for <lists+linux-iio@lfdr.de>; Tue,  1 Jul 2025 21:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE094307ADC;
	Tue,  1 Jul 2025 21:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="RIsvOkDF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582B32701B8
	for <linux-iio@vger.kernel.org>; Tue,  1 Jul 2025 21:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751405980; cv=none; b=kXAvRe3EBM9Q8lkZ5knRGKt3Sj+jalhQTeO5zKb1wjWpQWKTapTwwXTQoW8TzwJ6J363fXJvuXk7AHjRB2YNHo9NdQSOsgRV1Qv3xLWRAb+HZcA5/YaRMkdRqusOR6lGDNdNSKjQn5Hqi5iOLqxvghzat6m0zpgwStTVr9OcgBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751405980; c=relaxed/simple;
	bh=ri+GV8hDbxQKdegUY+Asy/ciZDUtvEJCgrkaZk0M59E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OIlHLfU7MDD0tVXDNp2XTAWZYOhjp1XaI8TnqsC9UFEXTMVFcT3usDVfNRDY//Opw6PlMBnVpIdECpmY15caF2bZO+BBrGn9bJ1SiSUeiLhPhR+RgIgNplAKAHtyPsjCHBI0bKXet/vI+s6g55FCJvZAapwkL8r9uTjsdsQWf+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=RIsvOkDF; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-40af40aee93so3950238b6e.0
        for <linux-iio@vger.kernel.org>; Tue, 01 Jul 2025 14:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751405977; x=1752010777; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LoGkdeBhqcrBQnH+/S0/qj4I6O0imtl9FrWlFxhByvM=;
        b=RIsvOkDFlXrUcuBEjwGKjoBkQQnVsS/k5kA549BzP2MQ5grqUYwuJ+UyiR8/W6fl9g
         RSKQplCnQt1CwhZjAed34sMPAXeGQ05p4Fhv6YX5/SrAUdb57j3CN25DEWNM8Mmb/L5c
         ikrcRUXJGpy87jH+CgjrK2iMFtdSLu3UJ3zjTXOFXDDDSrPnNGGb4ht+puunLuegsm5A
         /emZW8kVSGct+l+04MAWuuqdqpvch1FAqSlFCBNxfvx/X2uM4+vE8YscTs7SLWNGMr9P
         ARIHl+/L2gq4+Km+UC5pg2PP/l8+rdakessOm3cL9N0M9vI3vMkfhPO5Ni7Q84Dy36Fa
         Qd0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751405977; x=1752010777;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LoGkdeBhqcrBQnH+/S0/qj4I6O0imtl9FrWlFxhByvM=;
        b=BUA1olTyZQGtx5giu2nSxrOGJ0RpABpfdxISdYqF/GoLEN8O0h7cWmod2lcRyIrhZt
         r+qu9gYf1YPaiKj6xB9SdSALAW/IpAsvIJKR7/g2YJwUiFvhHJ/Lu4BuvImrfpnuOq44
         fYLbtYElZ8Rh6Hy/0G4qsss3SmsXDkRP4ozD3lNQEwIrHqwk7glJKHbEWjh0xSdH77aQ
         Vbn6zZfDjgkLXgQizZuUVLi2UbyC/6c0/53qaMsQ1x7VhKKWqdm/HO8U3UyGAQtunUEh
         SVTBnwUmXMjkVlKI/mK1xlr5MdedQSTx/MjqN0XU6QyCCdC6TZnKJXzz4yDuhr0KwtWb
         OAdQ==
X-Gm-Message-State: AOJu0YwbO0mT9gpDoFWmtRKzf4tNJdgWlXjDOZbRuZZUnxRuwrZbJThp
	3pN3pcY9zGzoI4iyqcCcaO5+BVFSIaakEuuND++38OJWW/PmSCb6o76e/al0B2AjEVI=
X-Gm-Gg: ASbGncu4aEmQTC1N7Fvyi0g6yCR6yd7wr7oy3cx5xA0QTc9zL6B4hybuDbotPBhTix+
	ypBEnSW4cXmb8RwMsazYjuy9MQOxWk1NDWgneNbSkw/KS9A/TP6FIOYue58adAsOVun86g7rVss
	CzUte3fOdMgG1KsUs/7SJqly0nq1yg/LQxI2W4FWMoSWtn3tg54s0RfnC4mVwv66RdJVLCIrRJa
	XhfmBEHh8bs/eFBN4I3Qp+WWrEQDxWp1+PQ5mL6tgpV2D/pQ1PeFARdGri0Usj/huYvYaHNvYBj
	/MUDShrot+w8pruGyNl0IcEFiYuJ2Btrlw5HdbsbDYxmS2Y4M0Wep8OpJofPakOcW1ZF
X-Google-Smtp-Source: AGHT+IFjLqFCy7sYMcfA64FamIas5nnvC28bvlSgo6+v1bonAVCJqb91DMUaJslqnGnYR+QfEJLqag==
X-Received: by 2002:a05:6808:f94:b0:404:ed0d:79e5 with SMTP id 5614622812f47-40b88807fd5mr304514b6e.30.1751405977395;
        Tue, 01 Jul 2025 14:39:37 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:70a7:ca49:a250:f1d5])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40b3243deeesm2288335b6e.48.2025.07.01.14.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 14:39:37 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 01 Jul 2025 16:37:55 -0500
Subject: [PATCH v3 07/12] iio: adc: ad_sigma_delta: refactor setting read
 address
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250701-iio-adc-ad7173-add-spi-offload-support-v3-7-42abb83e3dac@baylibre.com>
References: <20250701-iio-adc-ad7173-add-spi-offload-support-v3-0-42abb83e3dac@baylibre.com>
In-Reply-To: <20250701-iio-adc-ad7173-add-spi-offload-support-v3-0-42abb83e3dac@baylibre.com>
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Mark Brown <broonie@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-spi@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2048; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=ri+GV8hDbxQKdegUY+Asy/ciZDUtvEJCgrkaZk0M59E=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoZFVoUoOvzajg9oS+SsuzrU8BJSDqxyjIjP369
 K3N8UaK+ryJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaGRVaAAKCRDCzCAB/wGP
 wMnWB/0XlKOgOHhV9LDrxXB7kWcQugtbnzivlxQliToetR3VfVAZ8zQY2xL0Fya1YWYJeNWvSlq
 tA+sSbybKR+V+PJdaHdhTdgR8fPVkECr8SZboyxAA93O+OmsRYWxeBep7i14VDEsDrYENR0dJAy
 KYirmjlPXKYcOIpTzYBs0ffaVDEuZg83jGvTzKrcrrSiHfAXMdzxGRoK5/6SVXsglL0RInLMmEk
 Q85Muk94V++iPjj4Js2q3KL14iBmJQhPG7+xw6ErVj8+ZdLvx1w3iexThUrowCCAtH9+yhtAsZ6
 L2CKwdmG5bJosTf2GPuH+rjmGXCtNgZWod7V9fIVEXfGtfxv
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Refactor code to set the read address in a separate function.

This code is already duplicated twice and we will need to use it a third
time in a later commit.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad_sigma_delta.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index b5c66a6cc47ec8e36c458fae87309fd30109c0ec..ce549775ac3d68fd11e660b6b993ac661301756a 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -107,6 +107,14 @@ int ad_sd_write_reg(struct ad_sigma_delta *sigma_delta, unsigned int reg,
 }
 EXPORT_SYMBOL_NS_GPL(ad_sd_write_reg, "IIO_AD_SIGMA_DELTA");
 
+static void ad_sd_set_read_reg_addr(struct ad_sigma_delta *sigma_delta, u8 reg,
+				    u8 *data)
+{
+	data[0] = reg << sigma_delta->info->addr_shift;
+	data[0] |= sigma_delta->info->read_mask;
+	data[0] |= sigma_delta->comm;
+}
+
 static int ad_sd_read_reg_raw(struct ad_sigma_delta *sigma_delta,
 			      unsigned int reg, unsigned int size, u8 *val)
 {
@@ -127,9 +135,7 @@ static int ad_sd_read_reg_raw(struct ad_sigma_delta *sigma_delta,
 	spi_message_init(&m);
 
 	if (sigma_delta->info->has_registers) {
-		data[0] = reg << sigma_delta->info->addr_shift;
-		data[0] |= sigma_delta->info->read_mask;
-		data[0] |= sigma_delta->comm;
+		ad_sd_set_read_reg_addr(sigma_delta, reg, data);
 		spi_message_add_tail(&t[0], &m);
 	}
 	spi_message_add_tail(&t[1], &m);
@@ -288,9 +294,7 @@ static int ad_sigma_delta_clear_pending_event(struct ad_sigma_delta *sigma_delta
 	if (sigma_delta->info->has_registers) {
 		unsigned int data_reg = sigma_delta->info->data_reg ?: AD_SD_REG_DATA;
 
-		data[0] = data_reg << sigma_delta->info->addr_shift;
-		data[0] |= sigma_delta->info->read_mask;
-		data[0] |= sigma_delta->comm;
+		ad_sd_set_read_reg_addr(sigma_delta, data_reg, data);
 		t[0].tx_buf = data;
 		spi_message_add_tail(&t[0], &m);
 	}

-- 
2.43.0


