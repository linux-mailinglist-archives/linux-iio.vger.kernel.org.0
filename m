Return-Path: <linux-iio+bounces-22685-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C5B6B25059
	for <lists+linux-iio@lfdr.de>; Wed, 13 Aug 2025 18:58:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F88C3B25F7
	for <lists+linux-iio@lfdr.de>; Wed, 13 Aug 2025 16:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7369128F942;
	Wed, 13 Aug 2025 16:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BOZ6V1KD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457BD28C847;
	Wed, 13 Aug 2025 16:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755104092; cv=none; b=evmc1035svS3IU73XTc5PZFEQKhrWQTo6AGwL820+RS6B7RFDkZyl5XK3l7ltyuwrgAqtXGj9qQ7Nrv/Ogf9Bh3EyZC963hUkNnR0Uja16/RGu3h2mym22mTOY944khjfEz0pzFsz+eNmsVmAqrq3gNWo7hSEdWScToGkjqvumU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755104092; c=relaxed/simple;
	bh=QCojpgQaTambRExrbIk1TUy4/Qhyb/7qqdoRGhTQoIE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PlCBqNuSe2YfALJ5lat4FNk/bJjc8vHJm42LJKV8Y+LBBGv+KdKVMlOQ3JKD0lt0+reT3ey7mh6s4Fkoz//Q/Z+5O8FFFUNv77G/taC/WLe+0H/yJhOdFAk1ubkHTBJAdAFEHEBQxT4aXtCnsCseEii9t5FqLQDi1vbanvI0Xfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BOZ6V1KD; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-afcb732eee6so12128366b.0;
        Wed, 13 Aug 2025 09:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755104089; x=1755708889; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qIl9+C1r5UlkK2Ustqcx4O3RVpBf7aZ89Lmr+71U1dY=;
        b=BOZ6V1KDstDpoBRxHc0nB4qMC62D8UZm9pQR7ZfwbX2WYg7qHpU4RWlnuVoWI3/B2Z
         85U79P2rC75krlJRNNVxYJa7KCHuxM9O86cUXSDNMrqFa8P2uw5L3rl/BJwEP8GbSsyL
         1q+DUq5/7ssSOsLOYPhwoo1m2PhTsIxYG+yiwqh25G1waOBW8z/LlyvFvXP6jPVdb/yP
         A5tI1+bB+RnBE96ASczMP60ESJpNQkuZyjyTpCQJQ9CvlGTBUy0vw/nFFBhcJHMM17DW
         R1cAjrywo6c7zaTJOpHA0upl/UVEX6In7OaVydq+hNz7q6wbsQNN8Op5TyV+jX4HAp6e
         y4sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755104089; x=1755708889;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qIl9+C1r5UlkK2Ustqcx4O3RVpBf7aZ89Lmr+71U1dY=;
        b=EGwvMSK1m/+7in9/NcTXBzWhRG3M32KpTJnKG0d5J+TKzIu/czx3ewcr3pDOecumpG
         SRIphhGqiDOTAoGyGPnzuZYNPdiBF9i0OU6oKCORC8O9inYJDR5v9wrBynnxAKJsw3oa
         XP0WRSZiWdYvew7+1rfZcWvB6a3h4WHw1ZvPy/kVUqGSPvTqhgEImzCr83gyBQ2Ihj8W
         psAX8L50jHNYBBXpPf3JFYfmii5Xb3QurYQZHqjmUFUvruKmq55MU9AC0G8oyxndu82V
         GjrjrwOtvSh6TIZncWZPPuaFaTMpreOgOjloKPUGQQWnKxDMKMaFsUkD6ebqbGPVszvS
         50dg==
X-Forwarded-Encrypted: i=1; AJvYcCUQT9jeHf7+abFSFXKj7YKmWdy91QA/RCEjDGveaDJghyOC87t9ArqO5jT1di274loKVK4kWfrU6o+m@vger.kernel.org, AJvYcCWcZ2rL/yrxx47cWe1Zl0zzEv7dUI6ZnU+yNZFXvopmyNO2k1P82Fhir9NoPS0TE/YOKS/bSPklwgCwK7+a@vger.kernel.org, AJvYcCWpXPH1bJen/2hNYDbQW5Rf2U6FtjBxRRZo6Srop2bp+uo91Xy0L3IwmwoLGd05GvuNmIYMW7Bd/3EX@vger.kernel.org
X-Gm-Message-State: AOJu0YwV++UVX+CpVlSyVaJfrmgCELe1kwaA5gm4YKmvbvLmXZZ10xK8
	o4L3GKS01R1qVnz26cpRIcyatBTyK9G66rg9K2xS+xVx3j5mngGKKA8ZR5EcywKD
X-Gm-Gg: ASbGncsU888itZzUIZgHX0qi7ioct1qKF8fwNhTBBFhlkaMWIOuSBFbm9Fs1KOiYsJe
	zS2d649zlgdIsEexr/cbhLj0HTEbRxdtPDYVJQ+HCtGlZrZZut7w5WRkFQ6Md9Rn5xfkB/HNS27
	DGZskOwPyODHzqs6ONd6SvvRBzlUdlJdPtvjMKjMBvMJjuguwX7WUIa5D998TW+jpThQw9o5AGv
	3MZcmlBP5eREfRTZe6zy+0q7qLmfi6cHfKVSzLE5KeM7qAdP7aF5krR8Z00Hp36pVK5R6aKheRj
	wAmnfDp6nmBTLmJ5CxOnaI5HvM48khb2+AnHnA4E+LjAzjegf4YzlS7KjQD99IMlKvgVCXvUZpP
	qfXZJMCfaBBWwqntiIVWA2ia2XFcBOOtIRlkOlhk=
X-Google-Smtp-Source: AGHT+IEYadHJLnL2vykW7yIXcO68RurN3HgWvLbVue2ISWyT3izNLvR/tSyzRvBjuxPMZumTm+HoTg==
X-Received: by 2002:a17:907:bf06:b0:afa:17f4:4993 with SMTP id a640c23a62f3a-afca4e4711dmr307071566b.37.1755104088365;
        Wed, 13 Aug 2025 09:54:48 -0700 (PDT)
Received: from [127.0.1.1] ([185.177.137.147])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a1e82a5sm2428573766b.82.2025.08.13.09.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 09:54:47 -0700 (PDT)
From: Yusuf Alper Bilgin <y.alperbilgin@gmail.com>
Date: Wed, 13 Aug 2025 18:54:31 +0200
Subject: [PATCH v2 3/4] iio: adc: ltc2497: add temperature sensor support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250813-ltc2495-v2-3-bbaf20f6ba07@gmail.com>
References: <20250813-ltc2495-v2-0-bbaf20f6ba07@gmail.com>
In-Reply-To: <20250813-ltc2495-v2-0-bbaf20f6ba07@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755104084; l=9885;
 i=y.alperbilgin@gmail.com; s=20250811; h=from:subject:message-id;
 bh=QCojpgQaTambRExrbIk1TUy4/Qhyb/7qqdoRGhTQoIE=;
 b=fMd7yrjZBYBl8Jyi7hfxGmwYe+LXapDq0WtD0lvC2j7vGQ0+VDDgBwHoF5D0D4LfUCRHGJHKp
 n81oaP8YuZFCoBU3L5JfyQRaQnaHzzErpmWlYPi6U6TMYVmWQVNcL07
X-Developer-Key: i=y.alperbilgin@gmail.com; a=ed25519;
 pk=FtW2oyQ0+xlYU0XmhYiJYC3lNPtPrgeE6i4WXPwaFnY=

Support for reading the internal temperature sensor on LTC2495 and
LTC2499 via a standard IIO temperature channel.

Signed-off-by: Yusuf Alper Bilgin <y.alperbilgin@gmail.com>
---
 drivers/iio/adc/ltc2497-core.c | 140 ++++++++++++++++++++++++++++++-----------
 drivers/iio/adc/ltc2497.c      |  28 ++++++++-
 drivers/iio/adc/ltc2497.h      |  17 ++++-
 3 files changed, 145 insertions(+), 40 deletions(-)

diff --git a/drivers/iio/adc/ltc2497-core.c b/drivers/iio/adc/ltc2497-core.c
index 2dc5c704426949a4ec62c42591d6c2c40ffb79cc..0e21d5f59e6108be8b5d79bd706425278043b44d 100644
--- a/drivers/iio/adc/ltc2497-core.c
+++ b/drivers/iio/adc/ltc2497-core.c
@@ -18,6 +18,7 @@
 #define LTC2497_SGL			BIT(4)
 #define LTC2497_DIFF			0
 #define LTC2497_SIGN			BIT(3)
+#define LTC2497_KELVIN_TO_CELCIUS	273
 
 static int ltc2497core_wait_conv(struct ltc2497core_driverdata *ddata)
 {
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
+		*val = -LTC2497_KELVIN_TO_CELCIUS * ddata->chip_info->temp_scale_mV;
+		*val2 = ret / 1000;
+
+		return IIO_VAL_FRACTIONAL;
 
 	default:
 		return -EINVAL;
@@ -126,39 +170,55 @@ static int ltc2497core_read_raw(struct iio_dev *indio_dev,
 	.differential = 1, \
 }
 
+#define LTC2497_T_CHAN {									\
+	.type = IIO_TEMP,									\
+	.channel = 0,										\
+	.address = (LTC2497_ENABLE_TEMPERATURE_CONV),						\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),						\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_OFFSET),	\
+}
+
+#define LTC2497_CHANNELS \
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
+	LTC2497_CHANNELS,
+};
+
+static const struct iio_chan_spec ltc2497core_channel_with_temperature[] = {
+	LTC2497_CHANNELS,
+	LTC2497_T_CHAN,
 };
 
 static const struct iio_info ltc2497core_info = {
@@ -182,8 +242,14 @@ int ltc2497core_probe(struct device *dev, struct iio_dev *indio_dev)
 
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
index 64e81c95a3dd05911b6717c09ac0560c9f47f304..7f53bf8b8469d2371bb7ae64ce90a61beadba9ba 100644
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
-	u32 resolution;
 	const char *name;
+	u32 resolution;
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


