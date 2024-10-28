Return-Path: <linux-iio+bounces-11472-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 856A09B3354
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 15:23:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A869A1C21171
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 14:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E2361DE4F0;
	Mon, 28 Oct 2024 14:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b="cqf1pXMj"
X-Original-To: linux-iio@vger.kernel.org
Received: from a.peacevolution.org (a.peacevolution.org [206.189.193.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390AA1DE4F1;
	Mon, 28 Oct 2024 14:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.193.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730125329; cv=none; b=o9BW1u6nc3ecF7SjXjmYk6UYqwxsJOKftKKo7i2hreq2gPoQWuX7IXOmUyZuJM+PhbxDtsWV1SZVZO84Tjpn5P59Bc9ozJgc1oeftUt4VcuueiDdaadt1AtjdYKlDXZqEnanrGwygiEOTiQehOqSHHyyMjnHuzp9am3Rv8fKfyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730125329; c=relaxed/simple;
	bh=R0QdaxKXZI0DFp2QnvBUzElHKM3qvbEjHucu9DEE1mk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xq6d+8ktvWq72+GfxkpOSMzHx0yEeG1nTY8XgagiaE8JW4i+ixdFO60kvsAIzH1HM5uormTEfz6mJCsr85YeJuyaLiLE3lyV6RGyNY2WWYgXxjHJnZ6ZJQp9GDbvscBNGOZkV94DtFaB7loBGFh09wv4g+xadVBe8UrFWhhlI+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org; spf=pass smtp.mailfrom=peacevolution.org; dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b=cqf1pXMj; arc=none smtp.client-ip=206.189.193.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peacevolution.org
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
	by a.peacevolution.org (Postfix) with ESMTPA id 303D24C772;
	Mon, 28 Oct 2024 14:22:05 +0000 (UTC)
From: Aren Moynihan <aren@peacevolution.org>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>
Cc: Aren Moynihan <aren@peacevolution.org>,
	Kaustabh Chakraborty <kauschluss@disroot.org>,
	=?UTF-8?q?Barnab=C3=A1s=20Cz=C3=A9m=C3=A1n?= <trabarni@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Ondrej Jirman <megi@xff.cz>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	Dragan Simic <dsimic@manjaro.org>,
	phone-devel@vger.kernel.org
Subject: [PATCH v3 4/6] iio: light: stk3310: use dev_err_probe where possible
Date: Mon, 28 Oct 2024 10:19:58 -0400
Message-ID: <20241028142000.1058149-5-aren@peacevolution.org>
In-Reply-To: <20241028142000.1058149-1-aren@peacevolution.org>
References: <20241028142000.1058149-1-aren@peacevolution.org>
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
	s=dkim; t=1730125326;
	h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding:in-reply-to:references;
	bh=BYRnEk36IG62nZFzfPUk6ctg8BAgE9bbIy4meLjMgzI=;
	b=cqf1pXMjukY8Zv46PsYKFeV55lZhBqM38mH3p3E4cmvuH9UV6mTtFWKG3tCX4bitZ0DpkP
	pJEptKQFJXJIWJd9qgHzxkrmJqnaKg3g6B7eBrEGf+yj19ePMOkBzrdPjo88UYI3SxqAYG
	8NcgYXvHDVm6ZbRJW5Z5M9R3nisONzk=

Using dev_err_probe instead of dev_err and return makes the errors
easier to understand by including the error name, and saves a little
code.

Signed-off-by: Aren Moynihan <aren@peacevolution.org>
---

Notes:
    Added in v2

 drivers/iio/light/stk3310.c | 47 ++++++++++++++++---------------------
 1 file changed, 20 insertions(+), 27 deletions(-)

diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
index f02b4d20c282..968a2cc59d09 100644
--- a/drivers/iio/light/stk3310.c
+++ b/drivers/iio/light/stk3310.c
@@ -63,10 +63,10 @@
 		data->reg_##name =					    \
 			devm_regmap_field_alloc(&client->dev, regmap,	    \
 				stk3310_reg_field_##name);		    \
-		if (IS_ERR(data->reg_##name)) {				    \
-			dev_err(&client->dev, "reg field alloc failed.\n"); \
-			return PTR_ERR(data->reg_##name);		    \
-		}							    \
+		if (IS_ERR(data->reg_##name))				    \
+			return dev_err_probe(&client->dev,		    \
+				PTR_ERR(data->reg_##name),		    \
+				"reg field alloc failed.\n");		    \
 	} while (0)
 
 static const struct reg_field stk3310_reg_field_state =
@@ -516,10 +516,8 @@ static int stk3310_init(struct iio_dev *indio_dev)
 
 	state = STK3310_STATE_EN_ALS | STK3310_STATE_EN_PS;
 	ret = stk3310_set_state(data, state);
-	if (ret < 0) {
-		dev_err(&client->dev, "failed to enable sensor");
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(&client->dev, ret, "failed to enable sensor\n");
 
 	ret = devm_add_action_or_reset(&client->dev, stk3310_set_state_disable, data);
 	if (ret)
@@ -529,9 +527,10 @@ static int stk3310_init(struct iio_dev *indio_dev)
 	/* Enable PS interrupts */
 	ret = regmap_field_write(data->reg_int_ps, STK3310_PSINT_EN);
 	if (ret < 0)
-		dev_err(&client->dev, "failed to enable interrupts!\n");
+		return dev_err_probe(&client->dev, ret,
+				     "failed to enable interrupts!\n");
 
-	return ret;
+	return 0;
 }
 
 static bool stk3310_is_volatile_reg(struct device *dev, unsigned int reg)
@@ -564,10 +563,10 @@ static int stk3310_regmap_init(struct stk3310_data *data)
 
 	client = data->client;
 	regmap = devm_regmap_init_i2c(client, &stk3310_regmap_config);
-	if (IS_ERR(regmap)) {
-		dev_err(&client->dev, "regmap initialization failed.\n");
-		return PTR_ERR(regmap);
-	}
+	if (IS_ERR(regmap))
+		return dev_err_probe(&client->dev, PTR_ERR(regmap),
+				     "regmap initialization failed.\n");
+
 	data->regmap = regmap;
 
 	STK3310_REGFIELD(state);
@@ -656,10 +655,8 @@ static int stk3310_probe(struct i2c_client *client)
 	struct stk3310_data *data;
 
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
-	if (!indio_dev) {
-		dev_err(&client->dev, "iio allocation failed!\n");
-		return -ENOMEM;
-	}
+	if (!indio_dev)
+		return dev_err_probe(&client->dev, -ENOMEM, "iio allocation failed!\n");
 
 	data = iio_priv(indio_dev);
 	data->client = client;
@@ -708,18 +705,14 @@ static int stk3310_probe(struct i2c_client *client)
 						IRQF_TRIGGER_FALLING |
 						IRQF_ONESHOT,
 						STK3310_EVENT, indio_dev);
-		if (ret < 0) {
-			dev_err(&client->dev, "request irq %d failed\n",
-				client->irq);
-			return ret;
-		}
+		if (ret < 0)
+			return dev_err_probe(&client->dev, ret, "request irq %d failed\n",
+					     client->irq);
 	}
 
 	ret = devm_iio_device_register(&client->dev, indio_dev);
-	if (ret < 0) {
-		dev_err(&client->dev, "device_register failed\n");
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(&client->dev, ret, "device_register failed\n");
 
 	return 0;
 }
-- 
2.47.0


