Return-Path: <linux-iio+bounces-11856-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C30719BA23C
	for <lists+linux-iio@lfdr.de>; Sat,  2 Nov 2024 20:55:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B37D21C21249
	for <lists+linux-iio@lfdr.de>; Sat,  2 Nov 2024 19:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869EA1AB53A;
	Sat,  2 Nov 2024 19:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b="N7FNSpab"
X-Original-To: linux-iio@vger.kernel.org
Received: from a.peacevolution.org (a.peacevolution.org [206.189.193.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02DE1AB51B;
	Sat,  2 Nov 2024 19:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.193.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730577302; cv=none; b=Vi6YX1n9Sw+LYX4b0P+LiUGuSPta+p0xiDPwmXhr2+F4MFwmcx6l/rd1izURO+CvbC4Sad0fTOy3bje1joQKWoGNRL6EDxKvkjeRSJprexrOLjnkztb2SVJHivOMOzPjG1hcuhUNMDkJPTj/LsrKYgDwvyCcF9rD7YsSlTg4t7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730577302; c=relaxed/simple;
	bh=7FJEqZXWfSfqVHK3f18vO7zpSkgyXuTiGdBKpvwy7Dg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mnz4kn4bSyNtlX7SPoP1TI5IRYx/aHgCv732oSVxP4X2I0BjO27IC0eKCb8jyokKtrHWEDDH7qlDareNyMJqlZxsfF+KQc4yISGEsUfnDkfWM8fVombaURhUCJSSpNmJpFrbAdRS6ypWT7gaLv2HOSK07YqAsVcxjv2FupxUals=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org; spf=pass smtp.mailfrom=peacevolution.org; dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b=N7FNSpab; arc=none smtp.client-ip=206.189.193.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peacevolution.org
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
	by a.peacevolution.org (Postfix) with ESMTPA id 519BC4C832;
	Sat,  2 Nov 2024 19:54:58 +0000 (UTC)
From: Aren Moynihan <aren@peacevolution.org>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>
Cc: Aren Moynihan <aren@peacevolution.org>,
	Kaustabh Chakraborty <kauschluss@disroot.org>,
	=?UTF-8?q?Barnab=C3=A1s=20Cz=C3=A9m=C3=A1n?= <trabarni@gmail.com>,
	Ondrej Jirman <megi@xff.cz>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	Dragan Simic <dsimic@manjaro.org>,
	phone-devel@vger.kernel.org
Subject: [PATCH v4 2/6] iio: light: stk3310: handle all remove logic with devm callbacks
Date: Sat,  2 Nov 2024 15:50:37 -0400
Message-ID: <20241102195037.3013934-7-aren@peacevolution.org>
In-Reply-To: <20241102195037.3013934-3-aren@peacevolution.org>
References: <20241102195037.3013934-3-aren@peacevolution.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: auth=pass smtp.auth=aren@peacevolution.org smtp.mailfrom=aren@peacevolution.org
X-Spam-Level: *****
X-Spamd-Bar: +++++
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=peacevolution.org;
	s=dkim; t=1730577299;
	h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding:in-reply-to:references;
	bh=muOFYNTzaO2s6LuQjYw2jR7V/iVjO+R6V5aOyyeC/fE=;
	b=N7FNSpabyT6u3ukvz2bGjgD3Kioi/Imge8JRYxQFCk/rPJ43by7Uq54vvUM7JGmALM8AbD
	TtrYr8kRff/oSFO2M9ES5MPF1Bxlnzy1RgeNDHDPq9FjiiwFM7AAqCQF/MAl4DGeztFM2n
	i+adxee2o+IWMf48clpCf+XkW19ahIw=

Using devm callbacks helps to make the ordering of probe / remove
operations easier to reason about and removes some duplicate code
between the probe error path and driver remove.
---

Notes:
    Changes in v4:
     - also replace mutex_init with devm_mutex_init
    
    Added in v3

 drivers/iio/light/stk3310.c | 37 ++++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
index ed20b6714546..181b7acb3f96 100644
--- a/drivers/iio/light/stk3310.c
+++ b/drivers/iio/light/stk3310.c
@@ -484,6 +484,17 @@ static int stk3310_set_state(struct stk3310_data *data, u8 state)
 	return ret;
 }
 
+static void stk3310_set_state_disable(void *private)
+{
+	int ret;
+	struct stk3310_data *data = private;
+	struct device *dev = &data->client->dev;
+
+	ret = stk3310_set_state(data, STK3310_STATE_STANDBY);
+	if (ret)
+		dev_err(dev, "failed to set state to standby: %d\n", ret);
+}
+
 static int stk3310_init(struct iio_dev *indio_dev)
 {
 	int ret;
@@ -491,6 +502,7 @@ static int stk3310_init(struct iio_dev *indio_dev)
 	u8 state;
 	struct stk3310_data *data = iio_priv(indio_dev);
 	struct i2c_client *client = data->client;
+	struct device *dev = &client->dev;
 
 	ret = regmap_read(data->regmap, STK3310_REG_ID, &chipid);
 	if (ret < 0)
@@ -507,6 +519,10 @@ static int stk3310_init(struct iio_dev *indio_dev)
 		return ret;
 	}
 
+	ret = devm_add_action_or_reset(&client->dev, stk3310_set_state_disable, data);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to register cleanup function\n");
+
 	/* Enable PS interrupts */
 	ret = regmap_field_write(data->reg_int_ps, STK3310_PSINT_EN);
 	if (ret < 0)
@@ -624,7 +640,7 @@ static int stk3310_probe(struct i2c_client *client)
 	device_property_read_u32(&client->dev, "proximity-near-level",
 				 &data->ps_near_level);
 
-	mutex_init(&data->lock);
+	devm_mutex_init(&client->dev, &data->lock);
 
 	ret = stk3310_regmap_init(data);
 	if (ret < 0)
@@ -650,29 +666,17 @@ static int stk3310_probe(struct i2c_client *client)
 		if (ret < 0) {
 			dev_err(&client->dev, "request irq %d failed\n",
 				client->irq);
-			goto err_standby;
+			return ret;
 		}
 	}
 
-	ret = iio_device_register(indio_dev);
+	ret = devm_iio_device_register(&client->dev, indio_dev);
 	if (ret < 0) {
 		dev_err(&client->dev, "device_register failed\n");
-		goto err_standby;
+		return ret;
 	}
 
 	return 0;
-
-err_standby:
-	stk3310_set_state(data, STK3310_STATE_STANDBY);
-	return ret;
-}
-
-static void stk3310_remove(struct i2c_client *client)
-{
-	struct iio_dev *indio_dev = i2c_get_clientdata(client);
-
-	iio_device_unregister(indio_dev);
-	stk3310_set_state(iio_priv(indio_dev), STK3310_STATE_STANDBY);
 }
 
 static int stk3310_suspend(struct device *dev)
@@ -736,7 +740,6 @@ static struct i2c_driver stk3310_driver = {
 		.acpi_match_table = stk3310_acpi_id,
 	},
 	.probe =        stk3310_probe,
-	.remove =           stk3310_remove,
 	.id_table =         stk3310_i2c_id,
 };
 
-- 
2.47.0


