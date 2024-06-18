Return-Path: <linux-iio+bounces-6457-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E9690C85F
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 13:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F09E1F21489
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 11:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7911157E9E;
	Tue, 18 Jun 2024 09:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pk00WHYh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54A5201E25;
	Tue, 18 Jun 2024 09:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718703957; cv=none; b=SsWIPGJKbEV9Po3JKdBQYff6iqq5IKTUlZGyKGwwqd1WiDccvzHWyiYR7L5kMzaTzTYKKWbgb/XCei77/S+53j46eURoaLheYmKQM3sCQDslC/ocN6TapO7VRwRTrp6dGpTI0T+Art8vOVYlnb9PACjep4xk3+IslF/1Bl29wk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718703957; c=relaxed/simple;
	bh=eN+nqh/N8/d+fzkoQIhksKlosYB1jbAaTRQ+u4FJj24=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I3XeuoEAczQ2xlcMngKfEALM5ndB9FNkJVRN3Ka+5HtpwDHwgSIYhRQA1H2k3KiUUub2pbzO0VN+IR3R/GXeSgSx1TK7ARLu/54x5lwf276IzO4eJ7VtIpp+BFnnfTd7tPWaKh3kaAHYINAllNIpqcdjNLX8c/DQocAMGCyS6yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pk00WHYh; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-57c60b13a56so6181035a12.0;
        Tue, 18 Jun 2024 02:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718703954; x=1719308754; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vKRF8MXTvSIeTzXw8mwtKiGK85CcK0L09rvi5iK9SFw=;
        b=Pk00WHYhm+f98kiHu0qdBe1R/w/CCN9wLUqz1++zqEmBJhAijH1CUtkOcJq45NLeuy
         K6Y8znKa23N5NXj8mvr/DTcYKVWTogWTUlEPmE2TETK1jwGt+9vjcDesiEZFXqwCvZEH
         YT6JjSmeoyuiZ1yPhgWl1gnhI0PZtflagxrMedzZgiXuR/IJLwfePqV+8d9ls/kdUSnJ
         2YZnvcMZeMrz2maeINiFoChwu0BKYOVNBQxWuo1wgt4Q/I8djHLYr0PFXTKob6WBXACi
         EarTipxRePjJKbYNeMJcVfRtnYpM5kCRJZYOCeuBuqZWe432vsIxLr5CZWg1tuM4E82G
         F+BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718703954; x=1719308754;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vKRF8MXTvSIeTzXw8mwtKiGK85CcK0L09rvi5iK9SFw=;
        b=WRQupdg6u6u0fVNgyQfoCBYcTvJZhmTSIeNmzuXZe4KauxdoCvpiD5x/SdLk1w+nYr
         rcE8h7YhoDAPq4/DKdw1IDC5V/UBlRy10yNrtP/Zb7knkIsURVNt0LoQVR4uF20AiB5n
         mxgwO8SNNq1La1Fg/ntiROV8z0GGaUzc2i0e7A0eSF+9Pp2sNMBfn5pp8akAZtD5Ch5o
         IPfQV07uy7wQY/qNbeeIHQJBmoUd/l0R7uEUyXH/wLcUcMtc0bQTtUTvulKmnxTr8mRM
         a2rALXRiw9FInONQw/hL4SJ+mEK7j0EKI9fQqhmntoyWu85+rjU0IAqsZm2IGVPySTjb
         17QA==
X-Forwarded-Encrypted: i=1; AJvYcCW2/B7fU21s7O32yPkRVctF8E99vWVd7u3rYLwyDSVKgi0q26VA42suLGzzVtRsp4wSEYYPZlmhb5sVk7epBcUWp2BxrX23ZeuifE0tsU2NFsUTb8JlphIlrqsEhKjDJWMa50atmtlV
X-Gm-Message-State: AOJu0YwfaoL+CSdQVPwNXDDxS96pbZmGPILFyaA9uhAE3a33mdbLPjYn
	paR6v1vFMi74tf9dJDCW92J4ePqyx7uu59iEcCgpCtCWWAqTOG4d
X-Google-Smtp-Source: AGHT+IH5WbGCdyJ3gF3O7AKvkMYqVhxBRBCuDhm8udlZ03/cmV6Gt4Lh2ALefIDtWdnwTxvrByb1nA==
X-Received: by 2002:a50:d7c2:0:b0:57c:b7c3:99f1 with SMTP id 4fb4d7f45d1cf-57cbd6635f7mr8459376a12.11.1718703953774;
        Tue, 18 Jun 2024 02:45:53 -0700 (PDT)
Received: from [10.76.84.188] ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cb72e9dd7sm7494560a12.57.2024.06.18.02.45.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 02:45:53 -0700 (PDT)
Message-ID: <f338f479-edfc-462f-9c27-d025c85a5eec@gmail.com>
Date: Tue, 18 Jun 2024 12:45:52 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] iio: adc: ad7192: use
 devm_regulator_get_enable_read_voltage
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
 Marcelo Schmitt <marcelo.schmitt1@gmail.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Michael Hennerich <Michael.Hennerich@analog.com>,
 Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240612-iio-adc-ref-supply-refactor-v2-0-fa622e7354e9@baylibre.com>
 <20240612-iio-adc-ref-supply-refactor-v2-1-fa622e7354e9@baylibre.com>
 <20240615130858.22043725@jic23-huawei>
 <dbf947a3-3d3b-4686-a707-a813b6a4ce5a@gmail.com>
 <CAMknhBFJ01Xu69Arvd3S=dbADGFmzaYKm2XBtw_CtnjtYwnnew@mail.gmail.com>
 <2d47aeef-5ee0-4e6f-a408-ba5d737d2c5a@gmail.com>
 <8dd5f4b9-809f-43d8-ba5c-5f7be23107a4@baylibre.com>
 <15a0c2d8-9df4-4a26-bdf4-01f9c3f76ca7@gmail.com>
 <CAMknhBE=fEDdYPe1VeZwWWuvqf5TcUdM_LQGOugHCxGhSGP8-w@mail.gmail.com>
 <bbc2f159-d673-4652-a6b9-a528f905b67c@gmail.com>
 <4ff58005-4a71-491f-9400-cdecf2c25d66@baylibre.com>
Content-Language: en-US
From: Alisa-Dariana Roman <alisadariana@gmail.com>
In-Reply-To: <4ff58005-4a71-491f-9400-cdecf2c25d66@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17.06.2024 23:00, David Lechner wrote:
...

> 
> We could make a ret2 local variable inside of the if block to avoid writing over ret.
> 

Nice! If this looks alright, I will send it along my updated series.

 From f84206b85b04f89d57b9293dd93e017efe8b350c Mon Sep 17 00:00:00 2001
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 12 Jun 2024 16:03:05 -0500
Subject: [PATCH] iio: adc: ad7192: use 
devm_regulator_get_enable_read_voltage

This makes use of the new devm_regulator_get_enable_read_voltage()
function to reduce boilerplate code.

Error messages have changed slightly since there are now fewer places
where we print an error. The rest of the logic of selecting which
supply to use as the reference voltage remains the same.

Also 1000 is replaced by MILLI in a few places for consistency.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
  drivers/iio/adc/ad7192.c | 101 +++++++++++++--------------------------
  1 file changed, 34 insertions(+), 67 deletions(-)

diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index c7fb51a90e87..2448b01e0d59 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -200,8 +200,6 @@ struct ad7192_chip_info {

  struct ad7192_state {
  	const struct ad7192_chip_info	*chip_info;
-	struct regulator		*avdd;
-	struct regulator		*vref;
  	struct clk			*mclk;
  	u16				int_vref_mv;
  	u32				aincom_mv;
@@ -1189,18 +1187,12 @@ static const struct ad7192_chip_info 
ad7192_chip_info_tbl[] = {
  	},
  };

-static void ad7192_reg_disable(void *reg)
-{
-	regulator_disable(reg);
-}
-
  static int ad7192_probe(struct spi_device *spi)
  {
  	struct device *dev = &spi->dev;
  	struct ad7192_state *st;
  	struct iio_dev *indio_dev;
-	struct regulator *aincom;
-	int ret;
+	int ret, ret2, avdd_mv;

  	if (!spi->irq)
  		return dev_err_probe(dev, -ENODEV, "Failed to get IRQ\n");
@@ -1218,72 +1210,47 @@ static int ad7192_probe(struct spi_device *spi)
  	 * Newer firmware should provide a zero volt fixed supply if wired to
  	 * ground.
  	 */
-	aincom = devm_regulator_get_optional(dev, "aincom");
-	if (IS_ERR(aincom)) {
-		if (PTR_ERR(aincom) != -ENODEV)
-			return dev_err_probe(dev, PTR_ERR(aincom),
-					     "Failed to get AINCOM supply\n");
-
-		st->aincom_mv = 0;
-	} else {
-		ret = regulator_enable(aincom);
-		if (ret)
-			return dev_err_probe(dev, ret,
-					     "Failed to enable specified AINCOM supply\n");
-
-		ret = devm_add_action_or_reset(dev, ad7192_reg_disable, aincom);
-		if (ret)
-			return ret;
-
-		ret = regulator_get_voltage(aincom);
-		if (ret < 0)
-			return dev_err_probe(dev, ret,
-					     "Device tree error, AINCOM voltage undefined\n");
-		st->aincom_mv = ret / MILLI;
+	ret = devm_regulator_get_enable_read_voltage(dev, "aincom");
+	if (ret < 0 && ret != -ENODEV)
+		return dev_err_probe(dev, ret, "Failed to get AINCOM voltage\n");
+
+	st->aincom_mv = ret == -ENODEV ? 0 : ret / MILLI;
+
+	/* AVDD can optionally be used as reference voltage */
+	ret = devm_regulator_get_enable_read_voltage(dev, "avdd");
+	if (ret == -ENODEV || ret == -EINVAL) {
+		/*
+		 * We get -EINVAL if avdd is a supply with unknown voltage. We
+		 * still need to enable it since it is also a power supply.
+		 */
+		ret2 = devm_regulator_get_enable(dev, "avdd");
+		if (ret2)
+			return dev_err_probe(dev, ret2,
+					     "Failed to enable AVDD supply\n");
+	} else if (ret < 0) {
+		return dev_err_probe(dev, ret, "Failed to get AVDD voltage\n");
  	}

-	st->avdd = devm_regulator_get(dev, "avdd");
-	if (IS_ERR(st->avdd))
-		return PTR_ERR(st->avdd);
-
-	ret = regulator_enable(st->avdd);
-	if (ret)
-		return dev_err_probe(dev, ret,
-				     "Failed to enable specified AVdd supply\n");
-
-	ret = devm_add_action_or_reset(dev, ad7192_reg_disable, st->avdd);
-	if (ret)
-		return ret;
+	avdd_mv = (ret == -ENODEV) | (ret == -EINVAL) ? 0 : ret / MILLI;

  	ret = devm_regulator_get_enable(dev, "dvdd");
  	if (ret)
  		return dev_err_probe(dev, ret, "Failed to enable specified DVdd 
supply\n");

-	st->vref = devm_regulator_get_optional(dev, "vref");
-	if (IS_ERR(st->vref)) {
-		if (PTR_ERR(st->vref) != -ENODEV)
-			return PTR_ERR(st->vref);
-
-		ret = regulator_get_voltage(st->avdd);
-		if (ret < 0)
-			return dev_err_probe(dev, ret,
-					     "Device tree error, AVdd voltage undefined\n");
-	} else {
-		ret = regulator_enable(st->vref);
-		if (ret)
-			return dev_err_probe(dev, ret,
-					     "Failed to enable specified Vref supply\n");
-
-		ret = devm_add_action_or_reset(dev, ad7192_reg_disable, st->vref);
-		if (ret)
-			return ret;
-
-		ret = regulator_get_voltage(st->vref);
-		if (ret < 0)
-			return dev_err_probe(dev, ret,
-					     "Device tree error, Vref voltage undefined\n");
+	/*
+	 * This is either REFIN1 or REFIN2 depending on adi,refin2-pins-enable.
+	 * If this supply is not present, fall back to AVDD as reference.
+	 */
+	ret = devm_regulator_get_enable_read_voltage(dev, "vref");
+	if (ret == -ENODEV) {
+		if (avdd_mv == 0)
+			return dev_err_probe(dev, -ENODEV,
+					     "No reference voltage available\n");
+	} else if (ret < 0) {
+		return ret;
  	}
-	st->int_vref_mv = ret / 1000;
+
+	st->int_vref_mv = ret == -ENODEV ? avdd_mv : ret / MILLI;

  	st->chip_info = spi_get_device_match_data(spi);
  	indio_dev->name = st->chip_info->name;
-- 
2.34.1


