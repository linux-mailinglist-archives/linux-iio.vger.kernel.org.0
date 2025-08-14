Return-Path: <linux-iio+bounces-22734-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B9DEB263B8
	for <lists+linux-iio@lfdr.de>; Thu, 14 Aug 2025 13:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B89307A489D
	for <lists+linux-iio@lfdr.de>; Thu, 14 Aug 2025 10:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA85F2EBBAC;
	Thu, 14 Aug 2025 11:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jwzxqYG2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9148B318159;
	Thu, 14 Aug 2025 11:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755169235; cv=none; b=aJBEpqqeuvdvIwAk7tW6tNTpUPLaTmdXYtOWsJRdsS9b1tDIi77cgH2fcR7WL1iG8uQ5KFD907Cuz0iK7zcJKXqr6oCVQI6ApAjlr0J7g6OaBjlzlw8wrghLV8DsFznbrj2ZBJ7p+2aXQ26SzHOyn7qCb4AoapF0rCwxzq8/nf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755169235; c=relaxed/simple;
	bh=TB8z6eegknP9aVPdrzi4Bt2WSaiCi/VlFDXiuizM2c4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Wtma4Z2+SWFeLW9KwsYh//TKnAxTDao9xmGoUtUmGszX6eraA2ur7sUKXiVdS6H3Iz6dbHmBzHou4AH1mjbM6HkKbUdnVaYMv6e/DVy9iTam5DrIKjIa5Tzx9kWVVAhGnLv2ubEIrqXlADSJ95V3zPw86xLxuEzsxvDYumqVm1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jwzxqYG2; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-afcb7a8dd3dso129824566b.3;
        Thu, 14 Aug 2025 04:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755169232; x=1755774032; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=igkO6ryktDgA+t6fnHzCELHDHELAgmtyYXfKoJ51r+k=;
        b=jwzxqYG2g3Bjvmt9MiHsgg0w/x98BgDS5IHiiNXw3wZZGJkHbSX/iXl8XAC0n4yG8/
         ahbuIaaMEq5HQKmqMsSEbTNuCjZIGrJjKWS7IjqjLbuFNYJXNYbYAXEFDPrDFiVKJiE8
         PSNoUmi2IP+xmtEjuPUnnFIYXeXZ2YeZ3tsPYu8IxvjntLu2n/fddwAy0b4a688bJaKo
         kp4gkpDr7fgJ68Q7l1ak595IzlEviz13L9rx6+xzwRhu/RmqmBwfDdN1Eo5LZlxG9Gy7
         AGZ8ySbmXmzWnLcbZXiuQZ5xjreAsXpk8s/8AuX511uhSDZnT1M6+pfuCQYhh2MrIYn+
         +B7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755169232; x=1755774032;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=igkO6ryktDgA+t6fnHzCELHDHELAgmtyYXfKoJ51r+k=;
        b=uvSppB7Tas2T26Mk8hSJ3JgH+fERcEfZPIcrxdCoTRIye0qO3YMC09ASTXko+MrBgD
         EACEeuJtAlXH87vwu/UDdZsZ40EtpO1zL4age3z8g7sTqbrHWyxZAyW4zgRjDBwOWkPB
         ugV7vlA7x1JpRppKnlp20+N7/1gwYLihnhoevWg1gI8grniyRfGvnPRzni7Vs6Su2Htu
         S+A43qa4tRcK0/bkk+nxgKC+tB5LxCmA91XU2xsesbBakirA3i57gOlBUB6JcvvvtyXJ
         sNMdeGm4JscCWD1r0aR8ndHn12PmeRFTGrmF4m4hRhuswj2xcOELFp8dl6CpSTi04atz
         PPEw==
X-Forwarded-Encrypted: i=1; AJvYcCUyJAVK/MymyTji9EMskDMx7vWxYwezFwbo6wsmLlk5H9R7mqy0Wu6LuITUsXRSx7YIo1gHUUX0vpkvdAP6@vger.kernel.org, AJvYcCVvNlMrzdBkhn9dEj5X9CIHFGnYDSNw0lIWAsz+FFSNdxBazf0WSnC1aGyGZ3NNXVAxaFvgFb/VJXIc@vger.kernel.org, AJvYcCW7yCNRb4tDkwARtQV/veUYwFFoSJF2bwqd3uPSM9dly8vo0JlyaJTheLpx+T104ppdCxhkTxj1MTa5@vger.kernel.org
X-Gm-Message-State: AOJu0YwD7jeym/p8rUEf6VRsndsNDuRo9PQ/uTzL8fMRkRkcB4nZFdmJ
	w02YLS/iNOIUqrE3QfI6ZhI1hVbPK9NmVp1FvPLehE68E0EM254MPyiW3fVFhAzy
X-Gm-Gg: ASbGncuZAB7XHaEE2SdPgcsfMZSEBLldeLsEHHJE9nbsU4Cy/0nNqkjXGr3T8pe7+W1
	WNayqwufdUf6F/bfhPYbOnph5mAGPW5wAc8Q+ffCyz68cfgRq3mbHpviLWLd7anU5Z/ME+CC6LR
	VpkfI01KgbsJP9Q+Hi5Aa5pXICoyNmLb48/KrbX2h4bCoSebrjbWJvYY232SgcVIOxF2gEY/b8w
	+9R/N99ZiL75y/vLiDFAOgE0gHV4vnVJL//knSbBdzKW7/aoEgPbD8LOnRM8q+7HdOagS8jqlQn
	SqnH7uoi+hUhnJcVDK9zZkfblp8hiNqtVajbry92vpa/Aw+xSu+uhogbV1GaTO3XVc2SIUaSg6G
	y4hSOtBz8mpO68ePbDhrZXt6EuIvW
X-Google-Smtp-Source: AGHT+IE0cdESPySUOhaMsPxZ6zwDP3I5x/eiYZTISbPQaTxM80zBvskI8z5Bt8WgeHdM+SBnMJLOdQ==
X-Received: by 2002:a17:907:94cf:b0:af9:8438:de48 with SMTP id a640c23a62f3a-afcb99072a6mr257208466b.48.1755169231657;
        Thu, 14 Aug 2025 04:00:31 -0700 (PDT)
Received: from [127.0.1.1] ([185.177.137.147])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91dfd4b31sm2542980066b.85.2025.08.14.04.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 04:00:25 -0700 (PDT)
From: Yusuf Alper Bilgin <y.alperbilgin@gmail.com>
Date: Thu, 14 Aug 2025 13:00:19 +0200
Subject: [PATCH v3 3/4] iio: adc: ltc2497: add temperature sensor support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250814-ltc2495-v3-3-c2a6cecd6b99@gmail.com>
References: <20250814-ltc2495-v3-0-c2a6cecd6b99@gmail.com>
In-Reply-To: <20250814-ltc2495-v3-0-c2a6cecd6b99@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liam Beguin <liambeguin@gmail.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Yusuf Alper Bilgin <y.alperbilgin@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755169221; l=9863;
 i=y.alperbilgin@gmail.com; s=20250811; h=from:subject:message-id;
 bh=TB8z6eegknP9aVPdrzi4Bt2WSaiCi/VlFDXiuizM2c4=;
 b=3RpzE5IJRt2tHIttbRU8w1soTf9ebzVMLxjOjmMeVZwR4j+rGsBWhcULouRtfGekF4vHnQjgn
 YwcPofcDiqyCP2iPVLIxc+oHP8XS0KP1lGTKhYjkoFpz7XveZWTW3YB
X-Developer-Key: i=y.alperbilgin@gmail.com; a=ed25519;
 pk=FtW2oyQ0+xlYU0XmhYiJYC3lNPtPrgeE6i4WXPwaFnY=

Support for reading the internal temperature sensor on LTC2495 and
LTC2499 via a standard IIO temperature channel.

Signed-off-by: Yusuf Alper Bilgin <y.alperbilgin@gmail.com>
---
 drivers/iio/adc/ltc2497-core.c | 141 ++++++++++++++++++++++++++++++-----------
 drivers/iio/adc/ltc2497.c      |  28 +++++++-
 drivers/iio/adc/ltc2497.h      |  15 +++++
 3 files changed, 145 insertions(+), 39 deletions(-)

diff --git a/drivers/iio/adc/ltc2497-core.c b/drivers/iio/adc/ltc2497-core.c
index 2dc5c704426949a4ec62c42591d6c2c40ffb79cc..bbb7948f81933ee35103e37cb2ba94354f61b32e 100644
--- a/drivers/iio/adc/ltc2497-core.c
+++ b/drivers/iio/adc/ltc2497-core.c
@@ -12,6 +12,7 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/regulator/consumer.h>
+#include <linux/units.h>
 
 #include "ltc2497.h"
 
@@ -95,10 +96,53 @@ static int ltc2497core_read_raw(struct iio_dev *indio_dev,
 		if (ret < 0)
 			return ret;
 
-		*val = ret / 1000;
-		*val2 = ddata->chip_info->resolution + 1;
+		switch (chan->type) {
+		case IIO_VOLTAGE:
+			*val = ret / 1000;
+			*val2 = ddata->chip_info->resolution + 1;
+
+			return IIO_VAL_FRACTIONAL_LOG2;
+
+		case IIO_TEMP:
+			if (!ddata->chip_info->has_temp_channel)
+				return -EINVAL;
+
+			/*
+			 * The datasheet formula to get Temperature in Celsius is:
+			 * Temp_C = (DATAOUT * Vref_V / temp_scale) - 273
+			 *
+			 * To match the IIO framework's model of (raw + offset) * scale,
+			 * and to get the final result in millidegrees Celsius:
+			 *
+			 * Temp_mC = ((DATAOUT * Vref_mV / temp_scale_mV) - 273) * 1000
+			 * Temp_mC = (DATAOUT - (273 * temp_scale_mV / Vref_mv)) * 1000 *
+			 *           Vref_mV / temp_scale_mV
+			 *
+			 * This gives us:
+			 * scale  = Vref_mV * 1000 / temp_scale_mV
+			 * offset = -273 * temp_scale / Vref_mV
+			 */
+			*val = ret;
+			*val2 = ddata->chip_info->temp_scale_mV;
+
+			return IIO_VAL_FRACTIONAL;
+
+		default:
+			return -EINVAL;
+		}
+	case IIO_CHAN_INFO_OFFSET:
+		if (chan->type != IIO_TEMP)
+			return -EINVAL;
+
+		/* see the calculation above. Offset with (-273 * temp_scale / Vref) */
+		ret = regulator_get_voltage(ddata->ref);
+		if (ret < 0)
+			return ret;
 
-		return IIO_VAL_FRACTIONAL_LOG2;
+		*val = kelvin_to_celsius(0) * ddata->chip_info->temp_scale_mV;
+		*val2 = ret / 1000;
+
+		return IIO_VAL_FRACTIONAL;
 
 	default:
 		return -EINVAL;
@@ -126,39 +170,56 @@ static int ltc2497core_read_raw(struct iio_dev *indio_dev,
 	.differential = 1, \
 }
 
+#define LTC2497_TEMPERATURE_CHAN \
+{												\
+	.type = IIO_TEMP,									\
+	.channel = 0,										\
+	.address = (LTC2497_ENABLE_TEMPERATURE_CONV),						\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),						\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_OFFSET),	\
+}
+
+#define LTC2497_VOLTAGE_CHANNEL_LIST \
+	LTC2497_CHAN(0, LTC2497_SGL, "CH0"),			\
+	LTC2497_CHAN(1, LTC2497_SGL, "CH1"),			\
+	LTC2497_CHAN(2, LTC2497_SGL, "CH2"),			\
+	LTC2497_CHAN(3, LTC2497_SGL, "CH3"),			\
+	LTC2497_CHAN(4, LTC2497_SGL, "CH4"),			\
+	LTC2497_CHAN(5, LTC2497_SGL, "CH5"),			\
+	LTC2497_CHAN(6, LTC2497_SGL, "CH6"),			\
+	LTC2497_CHAN(7, LTC2497_SGL, "CH7"),			\
+	LTC2497_CHAN(8, LTC2497_SGL, "CH8"),			\
+	LTC2497_CHAN(9, LTC2497_SGL, "CH9"),			\
+	LTC2497_CHAN(10, LTC2497_SGL, "CH10"),			\
+	LTC2497_CHAN(11, LTC2497_SGL, "CH11"),			\
+	LTC2497_CHAN(12, LTC2497_SGL, "CH12"),			\
+	LTC2497_CHAN(13, LTC2497_SGL, "CH13"),			\
+	LTC2497_CHAN(14, LTC2497_SGL, "CH14"),			\
+	LTC2497_CHAN(15, LTC2497_SGL, "CH15"),			\
+	LTC2497_CHAN_DIFF(0, LTC2497_DIFF),			\
+	LTC2497_CHAN_DIFF(1, LTC2497_DIFF),			\
+	LTC2497_CHAN_DIFF(2, LTC2497_DIFF),			\
+	LTC2497_CHAN_DIFF(3, LTC2497_DIFF),			\
+	LTC2497_CHAN_DIFF(4, LTC2497_DIFF),			\
+	LTC2497_CHAN_DIFF(5, LTC2497_DIFF),			\
+	LTC2497_CHAN_DIFF(6, LTC2497_DIFF),			\
+	LTC2497_CHAN_DIFF(7, LTC2497_DIFF),			\
+	LTC2497_CHAN_DIFF(0, LTC2497_DIFF | LTC2497_SIGN),	\
+	LTC2497_CHAN_DIFF(1, LTC2497_DIFF | LTC2497_SIGN),	\
+	LTC2497_CHAN_DIFF(2, LTC2497_DIFF | LTC2497_SIGN),	\
+	LTC2497_CHAN_DIFF(3, LTC2497_DIFF | LTC2497_SIGN),	\
+	LTC2497_CHAN_DIFF(4, LTC2497_DIFF | LTC2497_SIGN),	\
+	LTC2497_CHAN_DIFF(5, LTC2497_DIFF | LTC2497_SIGN),	\
+	LTC2497_CHAN_DIFF(6, LTC2497_DIFF | LTC2497_SIGN),	\
+	LTC2497_CHAN_DIFF(7, LTC2497_DIFF | LTC2497_SIGN)
+
 static const struct iio_chan_spec ltc2497core_channel[] = {
-	LTC2497_CHAN(0, LTC2497_SGL, "CH0"),
-	LTC2497_CHAN(1, LTC2497_SGL, "CH1"),
-	LTC2497_CHAN(2, LTC2497_SGL, "CH2"),
-	LTC2497_CHAN(3, LTC2497_SGL, "CH3"),
-	LTC2497_CHAN(4, LTC2497_SGL, "CH4"),
-	LTC2497_CHAN(5, LTC2497_SGL, "CH5"),
-	LTC2497_CHAN(6, LTC2497_SGL, "CH6"),
-	LTC2497_CHAN(7, LTC2497_SGL, "CH7"),
-	LTC2497_CHAN(8, LTC2497_SGL, "CH8"),
-	LTC2497_CHAN(9, LTC2497_SGL, "CH9"),
-	LTC2497_CHAN(10, LTC2497_SGL, "CH10"),
-	LTC2497_CHAN(11, LTC2497_SGL, "CH11"),
-	LTC2497_CHAN(12, LTC2497_SGL, "CH12"),
-	LTC2497_CHAN(13, LTC2497_SGL, "CH13"),
-	LTC2497_CHAN(14, LTC2497_SGL, "CH14"),
-	LTC2497_CHAN(15, LTC2497_SGL, "CH15"),
-	LTC2497_CHAN_DIFF(0, LTC2497_DIFF),
-	LTC2497_CHAN_DIFF(1, LTC2497_DIFF),
-	LTC2497_CHAN_DIFF(2, LTC2497_DIFF),
-	LTC2497_CHAN_DIFF(3, LTC2497_DIFF),
-	LTC2497_CHAN_DIFF(4, LTC2497_DIFF),
-	LTC2497_CHAN_DIFF(5, LTC2497_DIFF),
-	LTC2497_CHAN_DIFF(6, LTC2497_DIFF),
-	LTC2497_CHAN_DIFF(7, LTC2497_DIFF),
-	LTC2497_CHAN_DIFF(0, LTC2497_DIFF | LTC2497_SIGN),
-	LTC2497_CHAN_DIFF(1, LTC2497_DIFF | LTC2497_SIGN),
-	LTC2497_CHAN_DIFF(2, LTC2497_DIFF | LTC2497_SIGN),
-	LTC2497_CHAN_DIFF(3, LTC2497_DIFF | LTC2497_SIGN),
-	LTC2497_CHAN_DIFF(4, LTC2497_DIFF | LTC2497_SIGN),
-	LTC2497_CHAN_DIFF(5, LTC2497_DIFF | LTC2497_SIGN),
-	LTC2497_CHAN_DIFF(6, LTC2497_DIFF | LTC2497_SIGN),
-	LTC2497_CHAN_DIFF(7, LTC2497_DIFF | LTC2497_SIGN),
+	LTC2497_VOLTAGE_CHANNEL_LIST,
+};
+
+static const struct iio_chan_spec ltc2497core_channel_with_temperature[] = {
+	LTC2497_VOLTAGE_CHANNEL_LIST,
+	LTC2497_TEMPERATURE_CHAN,
 };
 
 static const struct iio_info ltc2497core_info = {
@@ -182,8 +243,14 @@ int ltc2497core_probe(struct device *dev, struct iio_dev *indio_dev)
 
 	indio_dev->info = &ltc2497core_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
-	indio_dev->channels = ltc2497core_channel;
-	indio_dev->num_channels = ARRAY_SIZE(ltc2497core_channel);
+
+	if (ddata->chip_info->has_temp_channel) {
+		indio_dev->channels = ltc2497core_channel_with_temperature;
+		indio_dev->num_channels = ARRAY_SIZE(ltc2497core_channel_with_temperature);
+	} else {
+		indio_dev->channels = ltc2497core_channel;
+		indio_dev->num_channels = ARRAY_SIZE(ltc2497core_channel);
+	}
 
 	ret = ddata->result_and_measure(ddata, LTC2497_CONFIG_DEFAULT, NULL);
 	if (ret < 0)
diff --git a/drivers/iio/adc/ltc2497.c b/drivers/iio/adc/ltc2497.c
index 8f4665547b5b0d32084599f8557c40102c37a4ce..07fced79aeead3778964b114d479fdcb643c16df 100644
--- a/drivers/iio/adc/ltc2497.c
+++ b/drivers/iio/adc/ltc2497.c
@@ -86,8 +86,28 @@ static int ltc2497_result_and_measure(struct ltc2497core_driverdata *ddata,
 			return 0;
 	}
 
-	ret = i2c_smbus_write_byte(st->client,
-				   LTC2497_ENABLE | address);
+	/*
+	 * Chips with temperature sensor support (e.g., LTC2495/LTC2499)
+	 * require a two-byte command format to select any channel.
+	 *
+	 * To read the internal temperature, LTC2497_ENABLE_TEMPERATURE_CONV
+	 * is sent as the second byte. To read a voltage channel, LTC2497_EN2
+	 * is sent, which sets the default configuration: simultaneous 50/60Hz
+	 * rejection, 1x speed, and gain=1.
+	 *
+	 * Chips without this feature use a standard single-byte command.
+	 */
+	if (ddata->chip_info->has_temp_channel) {
+		if (address == LTC2497_ENABLE_TEMPERATURE_CONV)
+			ret = i2c_smbus_write_byte_data(st->client, LTC2497_ENABLE,
+							LTC2497_ENABLE_TEMPERATURE_CONV);
+		else
+			ret = i2c_smbus_write_byte_data(st->client, LTC2497_ENABLE | address,
+							LTC2497_EN2);
+	} else {
+		ret = i2c_smbus_write_byte(st->client, LTC2497_ENABLE | address);
+	}
+
 	if (ret)
 		dev_err(&st->client->dev, "i2c transfer failed: %pe\n",
 			ERR_PTR(ret));
@@ -135,6 +155,8 @@ static const struct ltc2497_chip_info ltc2497_info[] = {
 	[TYPE_LTC2495] = {
 		.resolution = 16,
 		.name = "ltc2495",
+		.has_temp_channel = true,
+		.temp_scale_mV = 12250,
 	},
 	[TYPE_LTC2497] = {
 		.resolution = 16,
@@ -143,6 +165,8 @@ static const struct ltc2497_chip_info ltc2497_info[] = {
 	[TYPE_LTC2499] = {
 		.resolution = 24,
 		.name = "ltc2499",
+		.has_temp_channel = true,
+		.temp_scale_mV = 1570000,
 	},
 };
 
diff --git a/drivers/iio/adc/ltc2497.h b/drivers/iio/adc/ltc2497.h
index 64e81c95a3dd05911b6717c09ac0560c9f47f304..65f406bc61c24b912de4beed604a074b3ea9df91 100644
--- a/drivers/iio/adc/ltc2497.h
+++ b/drivers/iio/adc/ltc2497.h
@@ -3,10 +3,25 @@
 #define LTC2497_ENABLE			0xA0
 #define LTC2497_CONFIG_DEFAULT		LTC2497_ENABLE
 #define LTC2497_CONVERSION_TIME_MS	150ULL
+#define LTC2497_EN2			BIT(7)
+/* Enable the internal temperature sensor */
+#define LTC2497_IM                      BIT(6)
+/* Second command byte value to initiate a temperature conversion */
+#define LTC2497_ENABLE_TEMPERATURE_CONV	(LTC2497_EN2 | LTC2497_IM)
 
 struct ltc2497_chip_info {
 	u32 resolution;
 	const char *name;
+	/*
+	 * Represents the datasheet constant from the temperature formula:
+	 * T_Kelvin = (DATAOUT * Vref) / temp_scale, where Vref is in Volts.
+	 *
+	 * To allow the driver to use Vref in millivolts for the calculation
+	 * and also to avoid floating points, this stored value represents the
+	 * datasheet constant scaled by 1000.
+	 */
+	u32 temp_scale_mV;
+	bool has_temp_channel;
 };
 
 struct ltc2497core_driverdata {

-- 
2.43.0


