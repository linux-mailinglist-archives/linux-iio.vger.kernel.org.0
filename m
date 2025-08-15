Return-Path: <linux-iio+bounces-22761-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B09B27DD5
	for <lists+linux-iio@lfdr.de>; Fri, 15 Aug 2025 12:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C75B71B63C4F
	for <lists+linux-iio@lfdr.de>; Fri, 15 Aug 2025 10:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B2E2FF15E;
	Fri, 15 Aug 2025 10:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cE4IhACj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B58F2FD7AF;
	Fri, 15 Aug 2025 10:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755252132; cv=none; b=cjTAkELNye5zTI58JPYI2dle+VLy9p0q8TiTGstgWCK2x6NsCPgT4A1MaIhnt5BlXfPdCuK2Iz82fF7JUo/QR6BRmRQEm4ThhL7R/Gr5fiSi+aN3UYe4bWaKB06MERVSI6suyn7EKS0u/SV8NaGGDkjNwuaW1T9k7Tw9z6cMhLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755252132; c=relaxed/simple;
	bh=JEUYQMGsKw802pSrUBvEuSI6h9jXfzKKuLQpTzQit14=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=op0llRW3qwzIEvmGh1BwQsFNH0NrzWMuA7iZXVA/k7QzFlOJCLkr1I5Q8yp71gfA1mljYmu2tb5ufDKrEGR9Cn4+knMdaLxk3DClAWCMmvNh6BJF9xegWbFTaAye5BR94dv2FTw1RDgH1stPE/SraocETc+duJwdVIQm5Gufs5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cE4IhACj; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-afcb7aea37cso241357066b.3;
        Fri, 15 Aug 2025 03:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755252128; x=1755856928; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OiYwOw6U1QcztXra4utgt/P9v++aI38I7fzbBpmmo6w=;
        b=cE4IhACjzS6orUjlbzomrEgqeDGO6BnftlNztb6EaOlvp04pAZ+knq/hZPxBpXow90
         dA8fUUAlaRtMNesazfUnI5xwgkVTn+F2qhXlvOmruH8JfKPIkzkmwqFj/GF1LyWR+5bN
         NDgKj/3fENqjFO0iq/udnp5H05CdWOXse5vXCiZoPg6G/9Y13iLreHiCGBsgecKORcws
         D58guKa0KKE3aEqPS9aDoRYXLmWI9OBZ+Pw0pPXvqr6eeZBk+11Wfd2PVAgtNyrlv14/
         8gvMu/E0RfpZv7N3SFn/F4CTmXyojvmxB7rihpz06H+1ka4Plax6zbPjtJWEuhYqMyCN
         hY1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755252128; x=1755856928;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OiYwOw6U1QcztXra4utgt/P9v++aI38I7fzbBpmmo6w=;
        b=XF6PTq169duIZUMrJp8246yiSQwcIQFHajRj8NS55X4X8+0g0IlEx4oSTmwDPvZ6ML
         px0UR8zzt3uHxLeWuB9eUxSNg+JPSPgTsl/Xa+w29YLbrpxqzxo4U7HMNXAY2zk2Z1KF
         A7FZfO9aIXRSJgmuijx4s3qiUfL3ETpTQRoNZTyaLQIz1NdyhlDyrO2BAHKx8CoX2wCB
         JYQzNJxkRNSCLd/IbPYkXeDzDS9dymhFPpkHpcbuD4xHGp3uN4yiJHGe8+j7WbNUeBaR
         Wxgpvs9UZ3Hn91Axu94XoKbfMPC6hutEfCDC+WIJALHZWFKv9IhadTx5OiqiX754a3dy
         3W3Q==
X-Forwarded-Encrypted: i=1; AJvYcCU4RsZlju95PAYc+mzMwYVpaf5fcw6gLqVhWnubAvdc6YIKOoXd8Edoe4DgewJ6nKa1nkpOMV3KdY5y@vger.kernel.org, AJvYcCVyZzIAgB4Q9NAHyRffDD0afovHL1TyXUFoG5yxJ+hUnLHRy9d7BnjJwI9JT2QfpxtvHjO2xTkaxB3kn6LA@vger.kernel.org, AJvYcCWArNCz7BkJLzugg62+lF69dTrPqs/e4HZMzORypHWWijXcB92T1LXFGORnbnp0SKYYXEqxHP0k59e+@vger.kernel.org
X-Gm-Message-State: AOJu0YwiHA55a3NAb6Y51A2KWXCxlzWHoTVhx9Awrpa795PNSkKKqN+x
	oweGsEg1mxbd9elqyJoVtXbpEjnYga4roz/mQqMy5NFmnRT/xfilppp6
X-Gm-Gg: ASbGncvjY9kFQpEmY6YdlXZr0g8C4OpeHkC8uEzxg8jO3qYnVE1LrgIAGnkhPwHVwpK
	OL80UTKREU2EIeAxXbXVJkT11CBxoKgHutO0V8+5Ygq3FrbIbjk62SvifeijqeZQ7lbu+9Suli1
	PYnUUHAMf269NJ5jObPI5y6PboWbemM59IVteD4Mwd3pNfcRLiInX2vq3Sq4AwYLT/nvlfqgwLz
	Gng8z6Y4yk+dOBGJseRVZv0jXYAXM7MmwAcY/7Ke+c5qOePUrLSp6xMcBIkrjQQpw6o71jzovC3
	WQepAXS4y7iB8XPcj+Ta5EUDvriIycyz0fv/RzNQ7XV3Cl6BfKN63u/Xs/YDJ660p/64lb1V2xc
	b7cXrVaigirnFIgwjWBRbI38rB0CU
X-Google-Smtp-Source: AGHT+IHt5VPJS222P902wv4YloJ68QWavQ8uO8Hp1ehIwkyMSkd/de7mqWzcqtxpvTFgdb5ctK1mwg==
X-Received: by 2002:a17:907:9805:b0:ad8:9997:aa76 with SMTP id a640c23a62f3a-afcdc2c11d1mr123784866b.37.1755252127880;
        Fri, 15 Aug 2025 03:02:07 -0700 (PDT)
Received: from [127.0.1.1] ([185.177.137.147])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afcdce72d5dsm119031766b.37.2025.08.15.03.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 03:02:07 -0700 (PDT)
From: Yusuf Alper Bilgin <y.alperbilgin@gmail.com>
Date: Fri, 15 Aug 2025 12:02:03 +0200
Subject: [PATCH v4 2/3] iio: adc: ltc2497: add support for LTC2495
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250815-ltc2495-v4-2-2d04e6005468@gmail.com>
References: <20250815-ltc2495-v4-0-2d04e6005468@gmail.com>
In-Reply-To: <20250815-ltc2495-v4-0-2d04e6005468@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755252124; l=11228;
 i=y.alperbilgin@gmail.com; s=20250811; h=from:subject:message-id;
 bh=JEUYQMGsKw802pSrUBvEuSI6h9jXfzKKuLQpTzQit14=;
 b=FpyzVFnqSN9I2xMWDHD4ySB7M+6A5VgSikbaFoJmGW7c5KIRxsBLkCfjisJAd/Ym90jYLYJg9
 gTDcqrZqTLdD0Wi8+x5KR1oSc2gqhXPaGoibs33imDo0N5wDFPomQyu
X-Developer-Key: i=y.alperbilgin@gmail.com; a=ed25519;
 pk=FtW2oyQ0+xlYU0XmhYiJYC3lNPtPrgeE6i4WXPwaFnY=

Update the LTC2497 driver to also support the LTC2495.

Support for reading the internal temperature sensor on LTC2495 and
LTC2499 via a standard IIO temperature channel.

Signed-off-by: Yusuf Alper Bilgin <y.alperbilgin@gmail.com>
---
 drivers/iio/adc/ltc2497-core.c | 132 ++++++++++++++++++++++++++++-------------
 drivers/iio/adc/ltc2497.c      |  39 +++++++++++-
 drivers/iio/adc/ltc2497.h      |  11 ++++
 3 files changed, 140 insertions(+), 42 deletions(-)

diff --git a/drivers/iio/adc/ltc2497-core.c b/drivers/iio/adc/ltc2497-core.c
index 2dc5c704426949a4ec62c42591d6c2c40ffb79cc..9f3509c5974dd7a0489145c591630e1ff9dc333e 100644
--- a/drivers/iio/adc/ltc2497-core.c
+++ b/drivers/iio/adc/ltc2497-core.c
@@ -12,6 +12,7 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/regulator/consumer.h>
+#include <linux/units.h>
 
 #include "ltc2497.h"
 
@@ -46,7 +47,8 @@ static int ltc2497core_wait_conv(struct ltc2497core_driverdata *ddata)
 	return 1;
 }
 
-static int ltc2497core_read(struct ltc2497core_driverdata *ddata, u8 address, int *val)
+static int ltc2497core_read(struct ltc2497core_driverdata *ddata, u8 address,
+			    enum iio_chan_type type, int *val)
 {
 	int ret;
 
@@ -54,11 +56,13 @@ static int ltc2497core_read(struct ltc2497core_driverdata *ddata, u8 address, in
 	if (ret < 0)
 		return ret;
 
-	if (ret || ddata->addr_prev != address) {
+	if (ret || ddata->addr_prev != address ||
+	    ddata->chan_type_prev != type) {
 		ret = ddata->result_and_measure(ddata, address, NULL);
 		if (ret < 0)
 			return ret;
 		ddata->addr_prev = address;
+		ddata->chan_type_prev = type;
 
 		if (msleep_interruptible(LTC2497_CONVERSION_TIME_MS))
 			return -ERESTARTSYS;
@@ -83,7 +87,7 @@ static int ltc2497core_read_raw(struct iio_dev *indio_dev,
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
 		mutex_lock(&ddata->lock);
-		ret = ltc2497core_read(ddata, chan->address, val);
+		ret = ltc2497core_read(ddata, chan->address, chan->type, val);
 		mutex_unlock(&ddata->lock);
 		if (ret < 0)
 			return ret;
@@ -95,10 +99,37 @@ static int ltc2497core_read_raw(struct iio_dev *indio_dev,
 		if (ret < 0)
 			return ret;
 
-		*val = ret / 1000;
-		*val2 = ddata->chip_info->resolution + 1;
+		switch (chan->type) {
+		case IIO_VOLTAGE:
+			*val = ret / 1000;
+			*val2 = ddata->chip_info->resolution + 1;
 
-		return IIO_VAL_FRACTIONAL_LOG2;
+			return IIO_VAL_FRACTIONAL_LOG2;
+
+		case IIO_TEMP:
+			if (!ddata->chip_info->has_temp_channel)
+				return -EINVAL;
+
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
+		ret = regulator_get_voltage(ddata->ref);
+		if (ret < 0)
+			return ret;
+
+		*val = kelvin_to_celsius(0) * ddata->chip_info->temp_scale_mV;
+		*val2 = ret / 1000;
+
+		return IIO_VAL_FRACTIONAL;
 
 	default:
 		return -EINVAL;
@@ -126,39 +157,54 @@ static int ltc2497core_read_raw(struct iio_dev *indio_dev,
 	.differential = 1, \
 }
 
+#define LTC2497_TEMPERATURE_CHAN \
+{												\
+	.type = IIO_TEMP,									\
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
@@ -182,8 +228,14 @@ int ltc2497core_probe(struct device *dev, struct iio_dev *indio_dev)
 
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
index eb9d521e86e54def0493ea0e81f63b37900c56a5..cd3d00a8ffcb44107c9ad948913c97db9412b5f5 100644
--- a/drivers/iio/adc/ltc2497.c
+++ b/drivers/iio/adc/ltc2497.c
@@ -18,7 +18,12 @@
 
 #include "ltc2497.h"
 
+/* Optional second byte fields for LTC2495 and LTC2499 */
+#define LTC2497_EN2	BIT(7)
+#define LTC2497_IM	BIT(6)
+
 enum ltc2497_chip_type {
+	TYPE_LTC2495,
 	TYPE_LTC2497,
 	TYPE_LTC2499,
 };
@@ -85,8 +90,28 @@ static int ltc2497_result_and_measure(struct ltc2497core_driverdata *ddata,
 			return 0;
 	}
 
-	ret = i2c_smbus_write_byte(st->client,
-				   LTC2497_ENABLE | address);
+	/*
+	 * Chips with temperature sensor support (e.g., LTC2495/LTC2499)
+	 * require a two-byte command format to select any channel.
+	 *
+	 * To read the internal temperature, LTC2497_EN2 and LTC2497_IM
+	 * are sent as the second byte. To read a voltage channel, LTC2497_EN2
+	 * is sent, which sets the default configuration: simultaneous 50/60Hz
+	 * rejection, 1x speed, and gain=1.
+	 *
+	 * Chips without this feature use a standard single-byte command.
+	 */
+	if (ddata->chip_info->has_temp_channel) {
+		if (ddata->chan_type_prev == IIO_TEMP)
+			ret = i2c_smbus_write_byte_data(st->client, LTC2497_ENABLE,
+							LTC2497_EN2 | LTC2497_IM);
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
@@ -131,6 +156,12 @@ static void ltc2497_remove(struct i2c_client *client)
 }
 
 static const struct ltc2497_chip_info ltc2497_info[] = {
+	[TYPE_LTC2495] = {
+		.resolution = 16,
+		.name = "ltc2495",
+		.has_temp_channel = true,
+		.temp_scale_mV = 12250,
+	},
 	[TYPE_LTC2497] = {
 		.resolution = 16,
 		.name = NULL,
@@ -138,10 +169,13 @@ static const struct ltc2497_chip_info ltc2497_info[] = {
 	[TYPE_LTC2499] = {
 		.resolution = 24,
 		.name = "ltc2499",
+		.has_temp_channel = true,
+		.temp_scale_mV = 1570000,
 	},
 };
 
 static const struct i2c_device_id ltc2497_id[] = {
+	{ "ltc2495", (kernel_ulong_t)&ltc2497_info[TYPE_LTC2495] },
 	{ "ltc2497", (kernel_ulong_t)&ltc2497_info[TYPE_LTC2497] },
 	{ "ltc2499", (kernel_ulong_t)&ltc2497_info[TYPE_LTC2499] },
 	{ }
@@ -149,6 +183,7 @@ static const struct i2c_device_id ltc2497_id[] = {
 MODULE_DEVICE_TABLE(i2c, ltc2497_id);
 
 static const struct of_device_id ltc2497_of_match[] = {
+	{ .compatible = "lltc,ltc2495", .data = &ltc2497_info[TYPE_LTC2495] },
 	{ .compatible = "lltc,ltc2497", .data = &ltc2497_info[TYPE_LTC2497] },
 	{ .compatible = "lltc,ltc2499", .data = &ltc2497_info[TYPE_LTC2499] },
 	{ }
diff --git a/drivers/iio/adc/ltc2497.h b/drivers/iio/adc/ltc2497.h
index 64e81c95a3dd05911b6717c09ac0560c9f47f304..dfe2d5c30017adeb3f17e57fc5bf1e0e792ff30f 100644
--- a/drivers/iio/adc/ltc2497.h
+++ b/drivers/iio/adc/ltc2497.h
@@ -7,6 +7,16 @@
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
@@ -18,6 +28,7 @@ struct ltc2497core_driverdata {
 	u8 addr_prev;
 	int (*result_and_measure)(struct ltc2497core_driverdata *ddata,
 				  u8 address, int *val);
+	enum iio_chan_type chan_type_prev;
 };
 
 int ltc2497core_probe(struct device *dev, struct iio_dev *indio_dev);

-- 
2.43.0


