Return-Path: <linux-iio+bounces-10310-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B0699385B
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2024 22:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F2341C228CF
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2024 20:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8A0320F;
	Mon,  7 Oct 2024 20:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K2Jy12nJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEE31DE897;
	Mon,  7 Oct 2024 20:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728333419; cv=none; b=oXeTNw8eWL/MViSRqVYW9ayp0XAnAQsQyNewNbw5SEAZAhUxx3c/TWVrI9CVZzT6sMUAmsaFXJs5/e6U/G1DS67VNYpHURhb2s4gkkyVzKWJxqkGihvJLRxVYdBbeeYZufOWcljHszJQjof6w+gqDZTeRafeLdENn5gs+jztNEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728333419; c=relaxed/simple;
	bh=y4vqS5nfCnERP4qzOWuVu6eCZ3By6WEqi9MYZeckG9U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cNq30lcVApFmOfJtW9dc7SSLSYnk3CdJjA6lCmp9TN/zu4Ilau4/JHDm0PyIpljeo8Pmg73uTyZ8uCki4DMLvrAD14UZvjtUela7JpeUdx/d129DiUy7FBema/hDGOODVrxeESsr4PYI7IFl3JBi2Qdev1uOCYhR5sNcrz/VdwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K2Jy12nJ; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-539908f238fso5462446e87.2;
        Mon, 07 Oct 2024 13:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728333416; x=1728938216; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k2maYBiM5LIOhyk/i3lQ3qKHgbPUsqZuC6OiA0rm4sE=;
        b=K2Jy12nJVlB2kzqdq1xCikiXRJwqUl2KHKjEzvKHQFBY7ce13AFzSKrAOR39Z8y6KK
         ZvrbSb6o8u2ij4twwYAatTfkGgdYY25B7oY8A/KNxe9QB5CxYnsipu4aLqPxRMCfznS3
         hpZ5VZBTOUXufQBuuI1hctdhe0Gzu05xoD8KoefH4tTwInJfSuIj2bogNoMwOfR8DCEv
         tJRTqRbbJCdSE63bm7o0yPHKiTYyJmyyAJTbPgbjsv9SmGw0WoWvRRZKArMVLLGibMWe
         IrpndrD38jwaS412mTW1VDmdg4/xwDcSE+5SScsEPEkyro0tiAljJaRtuXvFzmIGJu9o
         Dluw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728333416; x=1728938216;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k2maYBiM5LIOhyk/i3lQ3qKHgbPUsqZuC6OiA0rm4sE=;
        b=uAJy4xGWHrh2MWaAcU5VyqT6Q/rhn/laWzX3reuSElZKQKAT/G7iGPpoJyrV90KCII
         vFi6De9aUi5Th/VUgnDkeF4NmVXCVi6EIdCfab3MjZoj/EOPXtMkzdMkhKTBJPgm5vWR
         y6P72rVoQfksfbsbUbgy6ZPJ610aps1/asWNNdm08UreZKncagRI6QoNLFtyUP4XY7K5
         oT5Lk+aCRlcnbqa5vcl1Sgs7FfBxTCXPpoXrsLx0ipkDiASskhZmwumEmihiENFIFotq
         CeVfHqRfZX2C+rS6sqwxDcHP9cqPJTftPqSYlI5NyfPS2/WySS9DpxVHan863JMX1J4O
         uYDQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2N4yDAGTplbbWT+spKiBkbjQ0FbAyFl2AQRub5LIgLmAXCN17qsoEzRm/Uz+i8qks78qpcVrwj1Yi@vger.kernel.org, AJvYcCWLO0eh/ZPNXTACuc5nO6H9f3u0jIDqp67/6opZHBUdoNzcnL1X+j44tXNF0t/bDEnUD2sACodyXV4EAjV+@vger.kernel.org, AJvYcCXckXoCPFWZXIlZudTt5G9LfcUMBcyEXBXw5fZrxveRHtvA3ynQCQr9GKpVaPlAb7H+ao2tsGYVm76W@vger.kernel.org
X-Gm-Message-State: AOJu0YxlcazbQ6R6Vvvz2L2nLpmUlyhoFtHPnPnO8xNb75CInkZ1U9iE
	namZe3JRrrUSeLtEX11ZUNeAYoZ89i693Ez8if2B29W8bi6uOtp8D8wNgA==
X-Google-Smtp-Source: AGHT+IH6cLAUJNTcmZyhSx914kndG2XyPmg8cfvfVi+R9NAIzUtsooMjqhFu8imn1PFV7qc1Q2YxJw==
X-Received: by 2002:a05:6512:3d93:b0:533:d3e:16fe with SMTP id 2adb3069b0e04-539ab9eae13mr6638267e87.38.1728333415276;
        Mon, 07 Oct 2024 13:36:55 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-26cc-001d-7ed0-e346.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:26cc:1d:7ed0:e346])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d1690f75bsm6464315f8f.23.2024.10.07.13.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 13:36:53 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Mon, 07 Oct 2024 22:36:36 +0200
Subject: [PATCH 1/3] iio: light: veml6035: fix read_avail in no_irq case
 for veml6035
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241007-veml7700-v1-1-fb85dd839d63@gmail.com>
References: <20241007-veml7700-v1-0-fb85dd839d63@gmail.com>
In-Reply-To: <20241007-veml7700-v1-0-fb85dd839d63@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Rishi Gupta <gupt21@gmail.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728333411; l=3278;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=y4vqS5nfCnERP4qzOWuVu6eCZ3By6WEqi9MYZeckG9U=;
 b=d8Fnn37QwWjf77/oAvh13BikQMOj9HD96wgh4hFpEuy1zxc7fbsQwtR8yUxdIWgxGl9NA4fL1
 CRCPgjrxNtgBtuytsvT+N+nfc0CcjkIHOpt4IFdLEuyay3PjVU5N+UZ
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

The iio_info is identical for veml6030 and veml6035. Moreover,
veml6035_info_no_irq is missing the initialization of the read_avail
member, which is actually a bug if no irq is provided.

Instead of adding the missing initialization, remove the device-specific
iio_info and use the existing one for the veml6030.

Fixes: ccc26bd7d7d7 ("iio: light: veml6030: add support for veml6035")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/light/veml6030.c | 26 ++------------------------
 1 file changed, 2 insertions(+), 24 deletions(-)

diff --git a/drivers/iio/light/veml6030.c b/drivers/iio/light/veml6030.c
index a5deae333554..ca0379945b1c 100644
--- a/drivers/iio/light/veml6030.c
+++ b/drivers/iio/light/veml6030.c
@@ -56,8 +56,6 @@ struct veml603x_chip {
 	const char *name;
 	const int(*scale_vals)[][2];
 	const int num_scale_vals;
-	const struct iio_info *info;
-	const struct iio_info *info_no_irq;
 	int (*hw_init)(struct iio_dev *indio_dev, struct device *dev);
 	int (*set_als_gain)(struct iio_dev *indio_dev, int val, int val2);
 	int (*get_als_gain)(struct iio_dev *indio_dev, int *val, int *val2);
@@ -829,28 +827,12 @@ static const struct iio_info veml6030_info = {
 	.event_attrs = &veml6030_event_attr_group,
 };
 
-static const struct iio_info veml6035_info = {
-	.read_raw  = veml6030_read_raw,
-	.read_avail  = veml6030_read_avail,
-	.write_raw = veml6030_write_raw,
-	.read_event_value = veml6030_read_event_val,
-	.write_event_value = veml6030_write_event_val,
-	.read_event_config = veml6030_read_interrupt_config,
-	.write_event_config = veml6030_write_interrupt_config,
-	.event_attrs = &veml6030_event_attr_group,
-};
-
 static const struct iio_info veml6030_info_no_irq = {
 	.read_raw  = veml6030_read_raw,
 	.read_avail  = veml6030_read_avail,
 	.write_raw = veml6030_write_raw,
 };
 
-static const struct iio_info veml6035_info_no_irq = {
-	.read_raw  = veml6030_read_raw,
-	.write_raw = veml6030_write_raw,
-};
-
 static irqreturn_t veml6030_event_handler(int irq, void *private)
 {
 	int ret, reg, evtdir;
@@ -1039,9 +1021,9 @@ static int veml6030_probe(struct i2c_client *client)
 					     "irq %d request failed\n",
 					     client->irq);
 
-		indio_dev->info = data->chip->info;
+		indio_dev->info = &veml6030_info;
 	} else {
-		indio_dev->info = data->chip->info_no_irq;
+		indio_dev->info = &veml6030_info_no_irq;
 	}
 
 	ret = data->chip->hw_init(indio_dev, &client->dev);
@@ -1084,8 +1066,6 @@ static const struct veml603x_chip veml6030_chip = {
 	.name = "veml6030",
 	.scale_vals = &veml6030_scale_vals,
 	.num_scale_vals = ARRAY_SIZE(veml6030_scale_vals),
-	.info = &veml6030_info,
-	.info_no_irq = &veml6030_info_no_irq,
 	.hw_init = veml6030_hw_init,
 	.set_als_gain = veml6030_set_als_gain,
 	.get_als_gain = veml6030_get_als_gain,
@@ -1095,8 +1075,6 @@ static const struct veml603x_chip veml6035_chip = {
 	.name = "veml6035",
 	.scale_vals = &veml6035_scale_vals,
 	.num_scale_vals = ARRAY_SIZE(veml6035_scale_vals),
-	.info = &veml6035_info,
-	.info_no_irq = &veml6035_info_no_irq,
 	.hw_init = veml6035_hw_init,
 	.set_als_gain = veml6035_set_als_gain,
 	.get_als_gain = veml6035_get_als_gain,

-- 
2.43.0


