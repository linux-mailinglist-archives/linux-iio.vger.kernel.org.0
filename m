Return-Path: <linux-iio+bounces-15185-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56474A2D8DD
	for <lists+linux-iio@lfdr.de>; Sat,  8 Feb 2025 22:17:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A3371887D4F
	for <lists+linux-iio@lfdr.de>; Sat,  8 Feb 2025 21:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5004248190;
	Sat,  8 Feb 2025 21:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b="J4Okbg3Q"
X-Original-To: linux-iio@vger.kernel.org
Received: from a.peacevolution.org (a.peacevolution.org [206.189.193.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17DE22475C4;
	Sat,  8 Feb 2025 21:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.193.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739049407; cv=none; b=t8fZil1Yw/umDkikFWv+BbBNNV22kVziHLHNTq5ixjlca4EZm8hXfzGhBxmwV4xDMzqLvyIe5UTMpekgN8i9u+kmnZKfdJHLEMysuLqKAe7bRG0hkzPjhJY5ODI0zhzJcrIvPK1S37+Zm3fLCnCZtvCPisScTPSxVoLcUuCj9QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739049407; c=relaxed/simple;
	bh=aVKNohCKsQoQ5xomcP8SK+r18BRhXWRwQcT3bJtJEto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OgGNFkU6SweYR5GE7KG0if0bqDZdXfwM6rWI3X4EjRvYbv3vcpBTKx2Im1AdJpSzosZ/vCybhuv8atwJrKVKEHQm6EzVabJYcqwyZfpXD/WH2DO4ufdXF/+2e3hU+iPoy7GTKD2cjuXbQWguiBCCIOLgWvGuE7DepJjBRK51iaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org; spf=pass smtp.mailfrom=peacevolution.org; dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b=J4Okbg3Q; arc=none smtp.client-ip=206.189.193.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peacevolution.org
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
	by a.peacevolution.org (Postfix) with ESMTPA id E6BC641B6B;
	Sat,  8 Feb 2025 21:16:43 +0000 (UTC)
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
	Julien Stephan <jstephan@baylibre.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	Ondrej Jirman <megi@xff.cz>,
	Dragan Simic <dsimic@manjaro.org>,
	phone-devel@vger.kernel.org
Subject: [PATCH v5 6/8] iio: light: stk3310: use dev_err_probe where possible
Date: Sat,  8 Feb 2025 16:13:24 -0500
Message-ID: <20250208211325.992280-8-aren@peacevolution.org>
In-Reply-To: <20250208211325.992280-2-aren@peacevolution.org>
References: <20250208211325.992280-2-aren@peacevolution.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: auth=pass smtp.auth=aren@peacevolution.org smtp.mailfrom=aren@peacevolution.org
X-Spam-Level: ***
X-Spamd-Bar: +++
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=peacevolution.org;
	s=dkim; t=1739049405;
	h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding:in-reply-to:references;
	bh=KC0X8lgQOTNNFYjC1MhZEeQLG9S5MuH28VUYqdOhE+o=;
	b=J4Okbg3QnG7lEL3C4iRk+5TnFawAvUuqzePAkBusC1qhBoBrBXjERbpxiTmT9RwEzzLlG9
	EJzFAmh608wYtGQs83y92RJX7nTkrOwdYQDT4RVANdHF9bLM1p/4QYI4GDAEuIfKr1uwG8
	TRUU2x9wGGKx0XmOKucnyfEdIiWifFM=

Using dev_err_probe instead of dev_err and return makes the errors
easier to understand by including the error name, and saves a little
code.

Signed-off-by: Aren Moynihan <aren@peacevolution.org>
---

Notes:
    Changes in v4:
     - Get a struct device ahead of time so it can be passed as "dev"
       instead of "&client->dev"
    
    No changes in v3
    
    Added in v2

 drivers/iio/light/stk3310.c | 42 +++++++++++++++----------------------
 1 file changed, 17 insertions(+), 25 deletions(-)

diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
index 2233eab63b7aa..9d517d51f6bae 100644
--- a/drivers/iio/light/stk3310.c
+++ b/drivers/iio/light/stk3310.c
@@ -504,10 +504,8 @@ static int stk3310_init(struct iio_dev *indio_dev)
 
 	state = STK3310_STATE_EN_ALS | STK3310_STATE_EN_PS;
 	ret = stk3310_set_state(data, state);
-	if (ret < 0) {
-		dev_err(&client->dev, "failed to enable sensor");
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "failed to enable sensor\n");
 
 	ret = devm_add_action_or_reset(dev, stk3310_set_state_disable, data);
 	if (ret)
@@ -516,9 +514,9 @@ static int stk3310_init(struct iio_dev *indio_dev)
 	/* Enable PS interrupts */
 	ret = regmap_field_write(data->reg_int_ps, STK3310_PSINT_EN);
 	if (ret < 0)
-		dev_err(&client->dev, "failed to enable interrupts!\n");
+		return dev_err_probe(dev, ret, "failed to enable interrupts!\n");
 
-	return ret;
+	return 0;
 }
 
 static bool stk3310_is_volatile_reg(struct device *dev, unsigned int reg)
@@ -547,14 +545,14 @@ static const struct regmap_config stk3310_regmap_config = {
 static int stk3310_regmap_init(struct stk3310_data *data)
 {
 	struct regmap *regmap;
-	struct i2c_client *client;
+	struct i2c_client *client = data->client;
+	struct device *dev = &client->dev;
 
-	client = data->client;
 	regmap = devm_regmap_init_i2c(client, &stk3310_regmap_config);
-	if (IS_ERR(regmap)) {
-		dev_err(&client->dev, "regmap initialization failed.\n");
-		return PTR_ERR(regmap);
-	}
+	if (IS_ERR(regmap))
+		return dev_err_probe(dev, PTR_ERR(regmap),
+				     "regmap initialization failed\n");
+
 	data->regmap = regmap;
 
 	data->reg_state = devm_regmap_field_alloc(dev, regmap, stk3310_reg_field_state);
@@ -676,10 +674,8 @@ static int stk3310_probe(struct i2c_client *client)
 	struct device *dev = &client->dev;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
-	if (!indio_dev) {
-		dev_err(&client->dev, "iio allocation failed!\n");
-		return -ENOMEM;
-	}
+	if (!indio_dev)
+		return dev_err_probe(dev, -ENOMEM, "iio allocation failed!\n");
 
 	data = iio_priv(indio_dev);
 	data->client = client;
@@ -728,18 +724,14 @@ static int stk3310_probe(struct i2c_client *client)
 						IRQF_TRIGGER_FALLING |
 						IRQF_ONESHOT,
 						STK3310_EVENT, indio_dev);
-		if (ret < 0) {
-			dev_err(&client->dev, "request irq %d failed\n",
-				client->irq);
-			return ret;
-		}
+		if (ret < 0)
+			return dev_err_probe(dev, ret, "request irq %d failed\n",
+					     client->irq);
 	}
 
 	ret = devm_iio_device_register(dev, indio_dev);
-	if (ret < 0) {
-		dev_err(&client->dev, "device_register failed\n");
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "device_register failed\n");
 
 	return 0;
 }
-- 
2.48.1


