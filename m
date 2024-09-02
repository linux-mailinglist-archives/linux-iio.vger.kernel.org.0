Return-Path: <linux-iio+bounces-9023-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F139968DBC
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 20:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBC1A2828E0
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 18:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F6C2101A4;
	Mon,  2 Sep 2024 18:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LFVOdIit"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF021D54FA;
	Mon,  2 Sep 2024 18:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725302554; cv=none; b=LdE/MMDilRWML3lbLeLRthpjoGutsweeRNdBt2pHBLBAD6SEFs9hEVHJiCsjdkbTWpkk9irPRNJJC0Q5IaSeHEuB9P9mRz0GZ+5xNg9iruZxQW4YeDK4swGnfDkxl3gPGiNP47go25aShUTgS09jcLtIPryNsT0Fc1V73W2BEmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725302554; c=relaxed/simple;
	bh=lVC7WlN7YckA2mM8wFj8qrXa0WB/KGPHOOm8UvTq8Ek=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=egXz0tsVqlhBDts3VG71oD3h1Oml9+uuswCIxnsCuPEX0T0JTrFUNfLR90ZMH9EQ+v5KcisSOP2mJChFCCIaeuORME8QSe10nJQq4Yrn5zoDsydVs0KZJ2J+zs0zh4cl0MFuGAEgZp034NxeYx27CU4611UHcfR+KhTwVJFhP9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LFVOdIit; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a8692bbec79so510275266b.3;
        Mon, 02 Sep 2024 11:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725302550; x=1725907350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yvk2TMmuGsaW1+rcNYCCXTK4HcycwNpIaYWePsGt+E0=;
        b=LFVOdIitJGsOltl4bNEgmBs9B4UO+inzpmG+wXy6eX448TifZPfAxsvMCB9AgHQ5ym
         ZHiJ4CSM2A7UH4c9hH3fp+lA20INwekgwS2xZVWWHvQ0PfGZRvcnX+7nMOecEyjO9OW3
         6lCL7Wm0M2AKfB8bfVHxwDkBh3f3YjwB7lJ9lr5MnKbnxAQxjEPXBKWASnPL422lBzAs
         WVer30wrgbOahCtPBp3iFWNqbnH/tE9uvesO/KAN/RzU9unhvZugHjyWjmiRz0z5FsTG
         LeQDwWNlfCNTc88ApHrRexbso8WeK/0E1o/ajn1Qi0FGRRY1q9r2J5DrmBo7B+i4C2M1
         vlxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725302550; x=1725907350;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yvk2TMmuGsaW1+rcNYCCXTK4HcycwNpIaYWePsGt+E0=;
        b=LaHdc+u42ftCuP1HpfE79bsmiFWWNDzS2IBImtXVwyIgqq6PdLuwInAwKbw8XjTxnf
         lPclivwesmCQUVp6RCX6fa+d2uykeZxkCCM+Tj//4AOwanvnapoYgWRE3RMJ+pgVH3C1
         +artl9XPDiC6E55dJmylmflwN3xYUTD/iDmHwUbcLAMeEim+z7/XcPEVQGmkd8Gj7X8U
         y3m2gJ90IbiaNmuQqtFTeStCzhOhPqei5ucZOenn8u4om2Iwx63JimO6iBvjW3DHBE6D
         skLcblHoP9oRgzyNgY2g6t4MqNqAGYhQqakmnbI7xUFivx9Z3h3sEC2suVrtCrxVZIU/
         DGYA==
X-Forwarded-Encrypted: i=1; AJvYcCVOqsnrytTOUuPQrdBls8Dumg3+ZlXsSfjcCFof+S+q3nuIt8nAUAzdWuP61NuOWrXs99ZgZKaL9ZPFHvJA@vger.kernel.org, AJvYcCVSIqwAcl6nreNqeVH42NHxSr3hzjjCzrrdjKzbPUfOsernbE9Ake+AAutnk3BFjkqxS4sxd9hwU6ii@vger.kernel.org, AJvYcCXat73kMC2I3Ua3CO8qFZoY6otfNmQjoVfXLlCqK8k6m8mDsNtwz9BJ/O5wyN5PKHbpIOF7/J7db3z2@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6IepKMrO0CJHJbRcI50BHbbC81n8OtCvwjQi4sTyOuM8SSKKe
	J5tOL+EQBkYq5XNJyxspDrFlYAz35mEB9ZqZFzGeihc6qPRXC9B5
X-Google-Smtp-Source: AGHT+IHe8YUfrEPyU3d6xE8V5nUPszHrEqi/Q4L2hZGuDGXWs005Bh05PMD4GrgbjGCFrx2PtA+WYg==
X-Received: by 2002:a17:907:1b97:b0:a89:b820:335 with SMTP id a640c23a62f3a-a89b820043cmr477451066b.65.1725302548831;
        Mon, 02 Sep 2024 11:42:28 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:bc14:b544:1196:d1a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a898900ec0asm590537966b.53.2024.09.02.11.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 11:42:28 -0700 (PDT)
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
	linux-kernel@vger.kernel.org,
	christophe.jaillet@wanadoo.fr
Subject: [PATCH v5 3/7] iio: pressure: bmp280: Remove config error check for IIR filter updates
Date: Mon,  2 Sep 2024 20:42:18 +0200
Message-Id: <20240902184222.24874-4-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240902184222.24874-1-vassilisamir@gmail.com>
References: <20240902184222.24874-1-vassilisamir@gmail.com>
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
index cd975fad2753..ba77c428042d 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -1559,14 +1559,12 @@ static int bmp380_chip_config(struct bmp280_data *data)
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
@@ -2156,15 +2154,13 @@ static int bmp580_chip_config(struct bmp280_data *data)
 	reg_val = FIELD_PREP(BMP580_DSP_IIR_PRESS_MASK, data->iir_filter_coeff) |
 		  FIELD_PREP(BMP580_DSP_IIR_TEMP_MASK, data->iir_filter_coeff);
 
-	ret = regmap_update_bits_check(data->regmap, BMP580_REG_DSP_IIR,
-				       BMP580_DSP_IIR_PRESS_MASK |
-				       BMP580_DSP_IIR_TEMP_MASK,
-				       reg_val, &aux);
+	ret = regmap_update_bits(data->regmap, BMP580_REG_DSP_IIR,
+				 BMP580_DSP_IIR_PRESS_MASK | BMP580_DSP_IIR_TEMP_MASK,
+				 reg_val);
 	if (ret) {
 		dev_err(data->dev, "failed to write config register\n");
 		return ret;
 	}
-	change = change || aux;
 
 	/* Restore sensor to normal operation mode */
 	ret = regmap_write_bits(data->regmap, BMP580_REG_ODR_CONFIG,
-- 
2.25.1


