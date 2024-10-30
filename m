Return-Path: <linux-iio+bounces-11660-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D0F9B7055
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2024 00:10:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFA241F21D42
	for <lists+linux-iio@lfdr.de>; Wed, 30 Oct 2024 23:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31487218303;
	Wed, 30 Oct 2024 23:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ro9FvwkM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D099217657;
	Wed, 30 Oct 2024 23:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730329812; cv=none; b=p4HdJPCIQ5/0D1TbXvYrSr7kk5T6u4IPGthcC5VhrDjXC3/5nQF5H353AOPchto9kY/PNF9tTnvBzMqKuD3VyWpEAOb88/9zw2Bjcq48C0/SaSkJKqc4F2pEUnNetd5WfBYxkTtq+Lul+fPF5fP9xc8+ioTqu7cPkMqW2JuuKMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730329812; c=relaxed/simple;
	bh=PvMSlb4ER20zgSWWNwE2ypfP9G5WUX3heFVVSw6vmnE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c8VPMxsKracknj156i1PXTpC9xG3eWFCsGOIIdHdPZhjwARBIG2K6ex9dHqT4x+lJsl93XeGMNJU2WyRWQqmLI/ek1DSOSzKHz2xrckIEs1XreSVVo9W6kMR9bOWuh1AnRgj9DkjVa4edgF2mexJkvt0L6gYDw2KZwfRjTTnxNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ro9FvwkM; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4315df7b43fso2899255e9.0;
        Wed, 30 Oct 2024 16:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730329808; x=1730934608; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JEpzUzJ1c5lFszF2kPARxtWbM5pCJuooPUNo/pm7Vmg=;
        b=Ro9FvwkMvzYIUdb743XXSB3BzBEXdLBW7fOS72iflxQ82z54PNJJm0/sTju8jjhke0
         gS9ppU9IdjfqXAEf2xxMpJVKLtW47iVsiUvBE0uzD72L0A37RmET4a3gAwF6j2CgBGAK
         9aAL9FnEM0hL7ZC16xoPxxqC7kR6na8JnSRPR4tNFS5Smr2wNzN6q2e6VBL+ECSttqVA
         wUUp+cSHB17r0TS51FbXwXm4dt/1mbOHEq8pQgBlmZXC9wm/ljLdOaxMuNpVBo8ywAzR
         ObivbFl1TRkXvdD4JHrMwCxVtNh9CM3hc3FEUuRoYQjbss+pO6wcKOatwOmaqU6132N8
         ZdwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730329808; x=1730934608;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JEpzUzJ1c5lFszF2kPARxtWbM5pCJuooPUNo/pm7Vmg=;
        b=aSnu0MuxNKdbs+oFlxH5I2TCDH95bGwFVSZvHzJENXGE0M0GXYHysKcUCjVhqFUre7
         YL6nqzhAro/EMFbC+x1hsbXQomoonfGsLf1j/eSW5JL7iw+nfrKaml/tYpfZJy5X4WHR
         H1ipwPqPsemHYJkQyKP76tIZMOQqihfFAcXLM6hSgIEm4IV1JONJQYEmYUv9i/OjLBMw
         ZwKVzgyvss0KCYBYEwueZEbAzt9n9ioqKTYVfjltfHNRUn8evf63LK1dDxjmdxu/SOnY
         79jLSH5IkzXLaOVjhDxL+w9bUpoP/Pxa753+jkDyoyZJy1sd0nKsginHrKtF/3t8B7Nt
         EyWw==
X-Forwarded-Encrypted: i=1; AJvYcCVp865PUvRNNAI4Zi+wzkKwgNPrjU/fMausQ+ZWT/dix3Q7ZTmYmapOwOtRfe8Ht4WpvMGeqdYOkfZxHoLY@vger.kernel.org, AJvYcCWuWcajWKEQHURlgCSGP0Ayu16lkq0LsfWLLrJPdtpbc3dPBVAZNErpUpxkBP50AJRiH+EUf9UZWi9z@vger.kernel.org
X-Gm-Message-State: AOJu0YxPMvK1TYCIqyh3e7FTrU3P08TQ+oS42iHDjsvxCLlUM55bjmax
	qwT6PUDHwP0M7TxyrIlKia09dVaXsn4Ly6FgusgLsGik0ZpjNsD6
X-Google-Smtp-Source: AGHT+IEPkiJRff+4vPxkrnkgfrNHalMGa4SX2xBvp2YkmFGoSP8+wKhVuaJOhLWXT9KSEb6MoOwpPA==
X-Received: by 2002:a05:600c:1d16:b0:42e:d4a2:ce67 with SMTP id 5b1f17b1804b1-431ae9c440cmr107681595e9.17.1730329807502;
        Wed, 30 Oct 2024 16:10:07 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-fbf3-0656-23c1-5ba1.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:fbf3:656:23c1:5ba1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd8e848csm34819375e9.3.2024.10.30.16.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 16:10:07 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Thu, 31 Oct 2024 00:09:58 +0100
Subject: [PATCH v4 2/2] iio: light: veml6070: add support for integration
 time
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241031-veml6070-integration-time-v4-2-c66da6788256@gmail.com>
References: <20241031-veml6070-integration-time-v4-0-c66da6788256@gmail.com>
In-Reply-To: <20241031-veml6070-integration-time-v4-0-c66da6788256@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730329801; l=6758;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=PvMSlb4ER20zgSWWNwE2ypfP9G5WUX3heFVVSw6vmnE=;
 b=+EdcuvwG1WczhePTCYyzglYFdPFVj9AAVTEJ2sDx/eebrBnlXW5E7l2CVy0ozcUxnP5IPrmsq
 QjMqAzrLibqAfylLCZFroYqXVhQ8XuKDSCbrbWMoCysGCLt6VfMyMOV
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

The integration time of the veml6070 depends on an external resistor
(called Rset in the datasheet) and the value configured in the IT
field of the command register, whose supported values are 1/2x, 1x,
2x and 4x.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/light/veml6070.c | 131 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 123 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/light/veml6070.c b/drivers/iio/light/veml6070.c
index d11ae00f61f8..6d4483c85f30 100644
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
@@ -15,6 +15,7 @@
 #include <linux/mutex.h>
 #include <linux/err.h>
 #include <linux/delay.h>
+#include <linux/units.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -29,18 +30,79 @@
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
+	u32 rset;
+	int it[4][2];
 };
 
+static int veml6070_calc_it(struct device *dev, struct veml6070_data *data)
+{
+	int i, tmp_it;
+
+	data->rset = 270000;
+	device_property_read_u32(dev, "vishay,rset-ohms", &data->rset);
+
+	if (data->rset < 75000 || data->rset > 1200000)
+		return dev_err_probe(dev, -EINVAL, "Rset out of range\n");
+
+	/*
+	 * convert to kohm to avoid overflows and work with the same units as
+	 * in the datasheet and simplify UVI operations.
+	 */
+	data->rset /= KILO;
+
+	tmp_it = VEML6070_MIN_IT_US * data->rset / VEML6070_MIN_RSET_KOHM;
+	for (i = 0; i < ARRAY_SIZE(data->it); i++) {
+		data->it[i][0] = (tmp_it << i) / MICRO;
+		data->it[i][1] = (tmp_it << i) % MICRO;
+	}
+
+	return 0;
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
-	int ret;
+	int ret, it_ms, val, val2;
 	u8 msb, lsb;
 
 	guard(mutex)(&data->lock);
@@ -51,7 +113,9 @@ static int veml6070_read(struct veml6070_data *data)
 	if (ret < 0)
 		return ret;
 
-	msleep(125 + 10); /* measurement takes up to 125 ms for IT 1x */
+	veml6070_get_it(data, &val, &val2);
+	it_ms = val * MILLI + val2 / (MICRO / MILLI);
+	msleep(it_ms + 10);
 
 	ret = i2c_smbus_read_byte(data->client2); /* read MSB, address 0x39 */
 	if (ret < 0)
@@ -81,26 +145,37 @@ static const struct iio_chan_spec veml6070_channels[] = {
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
 
-static int veml6070_to_uv_index(unsigned int val)
+static int veml6070_to_uv_index(struct veml6070_data *data, unsigned int val)
 {
 	/*
 	 * conversion of raw UV intensity values to UV index depends on
 	 * integration time (IT) and value of the resistor connected to
-	 * the RSET pin (default: 270 KOhm)
+	 * the RSET pin.
 	 */
 	unsigned int uvi[11] = {
 		187, 373, 560, /* low */
 		746, 933, 1120, /* moderate */
 		1308, 1494, /* high */
 		1681, 1868, 2054}; /* very high */
-	int i;
+	int i, it_idx;
+
+	it_idx = FIELD_GET(VEML6070_COMMAND_IT, data->config);
+
+	if (!it_idx)
+		val = (val * 270  / data->rset) << 1;
+	else
+		val = (val * 270 / data->rset) >> (it_idx - 1);
 
 	for (i = 0; i < ARRAY_SIZE(uvi); i++)
 		if (val <= uvi[i])
@@ -123,10 +198,44 @@ static int veml6070_read_raw(struct iio_dev *indio_dev,
 		if (ret < 0)
 			return ret;
 		if (mask == IIO_CHAN_INFO_PROCESSED)
-			*val = veml6070_to_uv_index(ret);
+			*val = veml6070_to_uv_index(data, ret);
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
@@ -134,6 +243,8 @@ static int veml6070_read_raw(struct iio_dev *indio_dev,
 
 static const struct iio_info veml6070_info = {
 	.read_raw = veml6070_read_raw,
+	.read_avail  = veml6070_read_avail,
+	.write_raw = veml6070_write_raw,
 };
 
 static void veml6070_i2c_unreg(void *p)
@@ -164,6 +275,10 @@ static int veml6070_probe(struct i2c_client *client)
 	indio_dev->name = VEML6070_DRV_NAME;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
+	ret = veml6070_calc_it(&client->dev, data);
+	if (ret < 0)
+		return ret;
+
 	ret = devm_regulator_get_enable(&client->dev, "vdd");
 	if (ret < 0)
 		return ret;

-- 
2.43.0


