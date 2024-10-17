Return-Path: <linux-iio+bounces-10698-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E2069A2FEC
	for <lists+linux-iio@lfdr.de>; Thu, 17 Oct 2024 23:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0B911F219C9
	for <lists+linux-iio@lfdr.de>; Thu, 17 Oct 2024 21:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 054801D8A10;
	Thu, 17 Oct 2024 21:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bDWV0BFt"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029661D7E3E;
	Thu, 17 Oct 2024 21:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729201181; cv=none; b=eBSImdacXbyJ3AvUMVQfwvKpt57ulTrg50ZH+nOJpYS2RcgbLxYnrUKuIeBTRCBKg6Kx2bzDwte8TJDlA/HZByjGmt98OcT3Cp7YMPkqzRp5x7n7YfzdjQiqWYaDgzURDc0dT5lEZimI4TMaUGB1iuQBODIBtfcCGfEUJxNE7Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729201181; c=relaxed/simple;
	bh=APqvJ6aJQIzO3pKdAUeq4yhas7nl1he/ghZ3uuPSAPU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ljeGOXXxO9xKCFEgCV3SVP3zSgJMZoHLRGFI/xXJO0b8ENgYZWNIh1f7w80FpvafA+jY3AmmioQo9E131vtG2UEh1ZoQf7l2W1tr0UTloMoR+yHMFvVPD1cYT3lSCvuu8T7CzNyYFwAHnKuksJlUumEKkJvr1m8DUZYc6pI75B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bDWV0BFt; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-37d461162b8so976535f8f.1;
        Thu, 17 Oct 2024 14:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729201178; x=1729805978; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K01JTLPCFhBJJHzM8KLsJttM33kABYw67HxfGcewzIo=;
        b=bDWV0BFtJIVnVpxpa+NE/bnZDuJvM4rRbEMxnW/MBA4C0iixVTcYIgec46pxquDzYw
         o5tOlWuqiFyprqU4uXtJxsN6Z+50xMVzMVk7Ok47Y5TFMI2z+qw8cv9C24gxVAkI2/dA
         r9D/2vuTLCwvH9pfd0JV+gAduLAX/XwzoQQsr6Q+hKbAsW3zKV7DkqHV8vVmyrCB8ZjU
         tClZfUcZ36AUQ85fS3TFdOGNbUkfDCSwp/LqKEIXOcJ8gDAvsH9ENhI+Bf5ysd411TeL
         pSq7xjHyWhcR6WXc8TnfO8cplSbbump39yaIePoKzzxs+3YesYqmYlNUG8mfJTLmP+iU
         YaLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729201178; x=1729805978;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K01JTLPCFhBJJHzM8KLsJttM33kABYw67HxfGcewzIo=;
        b=mrnVKYGlPEP2mnlJepivTURKxZTPPpJSnbqJN5sosQAeGj0GfdpxnYUYUT8/Kt0A2p
         vAa5/aRrv+EcGD2zyfRJ3k8rRQ/kbPtU5eNfPCsixPkub5n0WhYNcvfb6ugdQpKJjVr1
         JsTArgpgbhfbUHPEwDVQjx68QgNnEjchtxVnVkqIXO/JjTyAnEvxaq7QHq90XNmzgIrm
         R3pF4IkMi0Qy9BwTV2Eirl8fPNJI4QUcOdSho/tmBQZHAjpP3eveBKYGiLaTHvdQgfYM
         HfuGBzgblsVy6W6kdvCMyDN9uTaA6lIcxrRcA6WbHKAp7hNqLk3r3Lhy+TXtxCs2wtu6
         0Y+g==
X-Forwarded-Encrypted: i=1; AJvYcCUl1P+WID5MhkIQV7vgWzTjE7jyGIsX/YG6Y+wH21B288Zqd+RTTssVx8CiAPXvaJbgajzsoPEmeHUnBcUB@vger.kernel.org, AJvYcCX74lFU7zpeFhFoHCKDPJbBKn5UQNF+KP5S7/WCSDiEMuuBem3Zfd4QZ0Oienwse1xqjLAuQBD2Y3sU@vger.kernel.org
X-Gm-Message-State: AOJu0YyYsMxyXUcFP3P3pviUxQ0NUm9le8BNxx9AZyy1MOPgP45ATlc5
	l+THo41v/fdcOIVaTz5RL9fld0HgeEri4+uR2V2IWQJlWp4dtHen
X-Google-Smtp-Source: AGHT+IEwb6mIO53fmJ/9AFUuyk3ahB175Co0Q8OQjRLxY92o3W4AnAKiqcUoPN8xR8LoHhRL2Iv87w==
X-Received: by 2002:a5d:44c8:0:b0:37d:501f:483f with SMTP id ffacd0b85a97d-37eab6ee112mr175077f8f.44.1729201177990;
        Thu, 17 Oct 2024 14:39:37 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-bb11-f817-987f-ea1f.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:bb11:f817:987f:ea1f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ecf06a73esm99874f8f.43.2024.10.17.14.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 14:39:37 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Thu, 17 Oct 2024 23:39:28 +0200
Subject: [PATCH 4/4] iio: light: veml6070: add support for integration time
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241017-veml6070-integration-time-v1-4-3507d17d562a@gmail.com>
References: <20241017-veml6070-integration-time-v1-0-3507d17d562a@gmail.com>
In-Reply-To: <20241017-veml6070-integration-time-v1-0-3507d17d562a@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729201167; l=5086;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=APqvJ6aJQIzO3pKdAUeq4yhas7nl1he/ghZ3uuPSAPU=;
 b=smgCjhGQ8c3vTx2vwpQegGfVCyR1xleuaew5cwnjxjTQAGchnHsui048dcvb5MH4N+/uabxUk
 Z4Vy0OwvJOaASmdXyttyHCiU8JOZC5B1PPkl6+CYYfXKVqDxRygriOP
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

The integration time of the veml6070 depends on an external resistor
(called Rset in the datasheet) and the value configured in the IT
field of the command register.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/light/veml6070.c | 109 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 107 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/veml6070.c b/drivers/iio/light/veml6070.c
index d11ae00f61f8..87dc3295a656 100644
--- a/drivers/iio/light/veml6070.c
+++ b/drivers/iio/light/veml6070.c
@@ -6,7 +6,7 @@
  *
  * IIO driver for VEML6070 (7-bit I2C slave addresses 0x38 and 0x39)
  *
- * TODO: integration time, ACK signal
+ * TODO: ACK signal
  */
 
 #include <linux/bitfield.h>
@@ -29,15 +29,78 @@
 #define VEML6070_COMMAND_RSRVD	BIT(1) /* reserved, set to 1 */
 #define VEML6070_COMMAND_SD	BIT(0) /* shutdown mode when set */
 
-#define VEML6070_IT_10	0x01 /* integration time 1x */
+#define VEML6070_IT_05		0x00
+#define VEML6070_IT_10		0x01
+#define VEML6070_IT_20		0x02
+#define VEML6070_IT_40		0x03
+
+#define VEML6070_MIN_RSET_KOHM	75
+#define VEML6070_MIN_IT_US	15625 /* Rset = 75 kohm, IT = 1/2 */
 
 struct veml6070_data {
 	struct i2c_client *client1;
 	struct i2c_client *client2;
 	u8 config;
 	struct mutex lock;
+	u32 it[4][2];
 };
 
+static void veml6070_calc_it(struct device *dev, struct veml6070_data *data)
+{
+	u32 rset, tmp_it;
+	int i, ret;
+
+	ret = device_property_read_u32(dev, "rset-kohms", &rset);
+	if (ret) {
+		dev_warn(dev, "no Rset specified, using default 300 kohms\n");
+		rset = 300;
+	}
+
+	if (rset < 75) {
+		dev_warn(dev, "Rset too low, using minimum = 75 kohms\n");
+		rset = 75;
+	}
+
+	if (rset > 1200) {
+		dev_warn(dev, "Rset too high, using maximum = 1200 kohms\n");
+		rset = 1200;
+	}
+
+	tmp_it = VEML6070_MIN_IT_US * (rset / VEML6070_MIN_RSET_KOHM);
+	for (i = 0; i < ARRAY_SIZE(data->it); i++) {
+		data->it[i][0] = (tmp_it << i) / 1000000;
+		data->it[i][1] = (tmp_it << i) % 1000000;
+	}
+}
+
+static int veml6070_get_it(struct veml6070_data *data, int *val, int *val2)
+{
+	int it_idx = FIELD_GET(VEML6070_COMMAND_IT, data->config);
+
+	*val = data->it[it_idx][0];
+	*val2 = data->it[it_idx][1];
+
+	return IIO_VAL_INT_PLUS_MICRO;
+}
+
+static int veml6070_set_it(struct veml6070_data *data, int val, int val2)
+{
+	int it_idx;
+
+	for (it_idx = 0; it_idx < ARRAY_SIZE(data->it); it_idx++) {
+		if (data->it[it_idx][0] == val && data->it[it_idx][1] == val2)
+			break;
+	}
+
+	if (it_idx >= ARRAY_SIZE(data->it))
+		return -EINVAL;
+
+	data->config = (data->config & ~VEML6070_COMMAND_IT) |
+		FIELD_PREP(VEML6070_COMMAND_IT, it_idx);
+
+	return i2c_smbus_write_byte(data->client1, data->config);
+}
+
 static int veml6070_read(struct veml6070_data *data)
 {
 	int ret;
@@ -81,10 +144,14 @@ static const struct iio_chan_spec veml6070_channels[] = {
 		.modified = 1,
 		.channel2 = IIO_MOD_LIGHT_UV,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME),
+		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME),
 	},
 	{
 		.type = IIO_UVINDEX,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME),
+		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME),
 	}
 };
 
@@ -127,6 +194,40 @@ static int veml6070_read_raw(struct iio_dev *indio_dev,
 		else
 			*val = ret;
 		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_INT_TIME:
+		return veml6070_get_it(data, val, val2);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int veml6070_read_avail(struct iio_dev *indio_dev,
+			       struct iio_chan_spec const *chan,
+			       const int **vals, int *type, int *length,
+			       long mask)
+{
+	struct veml6070_data *data = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_INT_TIME:
+		*vals = (int *)data->it;
+		*length = 2 * ARRAY_SIZE(data->it);
+		*type = IIO_VAL_INT_PLUS_MICRO;
+		return IIO_AVAIL_LIST;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int veml6070_write_raw(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      int val, int val2, long mask)
+{
+	struct veml6070_data *data = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_INT_TIME:
+		return veml6070_set_it(data, val, val2);
 	default:
 		return -EINVAL;
 	}
@@ -134,6 +235,8 @@ static int veml6070_read_raw(struct iio_dev *indio_dev,
 
 static const struct iio_info veml6070_info = {
 	.read_raw = veml6070_read_raw,
+	.read_avail  = veml6070_read_avail,
+	.write_raw = veml6070_write_raw,
 };
 
 static void veml6070_i2c_unreg(void *p)
@@ -164,6 +267,8 @@ static int veml6070_probe(struct i2c_client *client)
 	indio_dev->name = VEML6070_DRV_NAME;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
+	veml6070_calc_it(&client->dev, data);
+
 	ret = devm_regulator_get_enable(&client->dev, "vdd");
 	if (ret < 0)
 		return ret;

-- 
2.43.0


