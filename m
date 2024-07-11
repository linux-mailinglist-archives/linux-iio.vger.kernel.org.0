Return-Path: <linux-iio+bounces-7517-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4F792F0E7
	for <lists+linux-iio@lfdr.de>; Thu, 11 Jul 2024 23:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 653CB282FD2
	for <lists+linux-iio@lfdr.de>; Thu, 11 Jul 2024 21:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F3B1A08AC;
	Thu, 11 Jul 2024 21:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b8OGIiJ5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F3A1A01D9;
	Thu, 11 Jul 2024 21:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720732587; cv=none; b=up8dZs5DL1knXlsm7HGb3mNsVph2OXBv9BLCIQE7lz+qYPEN9laO9AlaFGIJq5Est/zfsDjjJ3oMjAr0/KJQFlh5agcZGi1qTIO+O1TPXBIoBETAmAkbg8wRZXr5mkPxUgbescwJr6y4VGfHH733OnNWE2GrV1mMmWfmRWlXvyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720732587; c=relaxed/simple;
	bh=dKyWi8LcT1C1CFo4MuCPSYE2WNQ7OFauCzJpwZMvqqY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KPNdJjzMuh/51hprqjOP3k5NsGjWlTZHTV3gJli3qUggrM/tyWQm3pyRXlUt/qimuMT3J0SlweoeNklxEAjr1cDQr43pfJpleKxcBupUPLxljpbiJth0VeVyCHFwXLwi51PZB/csV1ZjmY2v8pI5gwg/zwWf3XZWeV+TkbDC5IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b8OGIiJ5; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-58ef19aa6b3so867709a12.1;
        Thu, 11 Jul 2024 14:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720732584; x=1721337384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CYcXNPOh0TR9ECTWQep62KZXJN1EG0+nQZbBk6Melzg=;
        b=b8OGIiJ5cz2b8yXq/KE0HvLwJVAn5RTYAxF7/ZSyqci0T5Oy643EeEV//Z2ZqCSnIe
         klj1uQS+OlOJeysunwjYoUMLT/AjIxVs4mWXr08AChVfSl5jXxRnIKpnxhxgqWJEiihd
         b8zm3o8Yo0SDf+qoM6RP9zwNw763eGc9F3hgD3PBMgDAODX3QPu+A0aZXqf9uLUhxSC5
         aKLPJkjOIYe9+A57T+ZJOhS7PGbTsanY5lwgZUYrFLE8GRuRiNLP+WhMBwJAhOFNPjp1
         /lHeb6i5ylNicFqfVQJiU64+FZhwo5vmmJdft+lKvmOj020hhHxkY/xbkCpg+Vh4WoSN
         6koQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720732584; x=1721337384;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CYcXNPOh0TR9ECTWQep62KZXJN1EG0+nQZbBk6Melzg=;
        b=KkNLBIlzCAfn8bE7Yq8chS3xoK5j68kG/6IM+JUW4VMDuzVqiIDCLINOCk8GRarK2i
         KfL71/DGzEtumvegCSNlFnJVEki5ScqW14gx8p24A62yvsk6jh3VOEFJE+B/DviZoL/n
         z6/7dDe5/HV37bxc2EbNmNlmKVOjYM8ZKGab/5UpHEIZ6GRyg6hdFioAy7sI98KOQ10g
         UPNujPOvfOhwEmKqgj20xbiLbux19snAyea6c76XZgsummxoADijgJAbVu2cFX0qV67u
         qltHAcSCXvtVd8RRePeX5qJ6ECZC4cKEjk7qMdsVsmrHS2TLpzeCH06Usool2k6cDE9z
         Z4LA==
X-Forwarded-Encrypted: i=1; AJvYcCWLiDBoXUK35qba/EYzTEPCypj+vf17BeUlT6OREwWKw4DMTNTtOvsKY35DByzMtj9Rm9NXXSvpP2tUTLdayMSdYvzIM46ttn4ZekhiXmY6Nl+cip+xNWKQPlAb9qf2QKifBlNsYrjQtHpv2kjqET4O8e6XWWnOywfKCg7v/dfy9qcrkQ==
X-Gm-Message-State: AOJu0YytbQPSuRcGJD9z7trmNflxjEYMmGKMWgoY+FwvztUpawEyjZdm
	XPnqFY6vDWOWsaUovE6rTAf06vqQZiBIMMHVtVo2poZQV3Brgsu6Uzyp8yNtwaA=
X-Google-Smtp-Source: AGHT+IFWGpm4uzU78tmcS1v8Zu0tJZv9xaswEb3PNtUV/MczU98LOEwk36+ssRUHVZg3Oxm5a9/hxg==
X-Received: by 2002:a05:6402:430b:b0:58c:3252:3ab8 with SMTP id 4fb4d7f45d1cf-594bcba83fcmr10193206a12.37.1720732584286;
        Thu, 11 Jul 2024 14:16:24 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:3e02:47b2:c845:ae3a])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-594bd45a1b6sm3815737a12.60.2024.07.11.14.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 14:16:23 -0700 (PDT)
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
Subject: [PATCH v1 06/10] iio: pressure: bmp280: Remove config error check for IIR filter updates
Date: Thu, 11 Jul 2024 23:15:54 +0200
Message-Id: <20240711211558.106327-7-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240711211558.106327-1-vassilisamir@gmail.com>
References: <20240711211558.106327-1-vassilisamir@gmail.com>
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
index caee586b2268..9c99373d66ec 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -1548,14 +1548,12 @@ static int bmp380_chip_config(struct bmp280_data *data)
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
@@ -2144,15 +2142,13 @@ static int bmp580_chip_config(struct bmp280_data *data)
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


