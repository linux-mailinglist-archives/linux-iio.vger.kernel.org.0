Return-Path: <linux-iio+bounces-15188-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1226A2D8EA
	for <lists+linux-iio@lfdr.de>; Sat,  8 Feb 2025 22:26:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 820217A1C08
	for <lists+linux-iio@lfdr.de>; Sat,  8 Feb 2025 21:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4CE244EAC;
	Sat,  8 Feb 2025 21:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b="SxsuCYAL"
X-Original-To: linux-iio@vger.kernel.org
Received: from a.peacevolution.org (a.peacevolution.org [206.189.193.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B29F244E9D;
	Sat,  8 Feb 2025 21:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.193.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739050000; cv=none; b=mkCu8ams2bVQrInxnKE6wQIBpGX1XggArykG6S8S7sFJ9rX7ckVQQ9GrI7U4K+o7yXScIc7zEr8lyit76ZUcWSIY98AEUe9O73V+MJSbjZyrLpT897Ioa6JoOiMrM8CTmuhG4k0OhVNBGt5mcfcjqRUg95v4NswBvoMTOFK44Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739050000; c=relaxed/simple;
	bh=GZyHLxobtg6JhQ/Epup0iThUafaDOuPr9Nd9awNA71U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nk864w57x2eqeyUidP74ysxnNafIvpLHPnrTxTSPcatWFXm6tYRQIfTZYNxDrMm30O1M4/gl6o2j7DZlXMIfcuqWv+LFuWwpWLZF9HbJphC4EYMuOWwIjZThYptqzmRzi6pzmvHdH9Veto0HV0LtlVYopoAa8nGD5VsxZzgWuoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org; spf=pass smtp.mailfrom=peacevolution.org; dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b=SxsuCYAL; arc=none smtp.client-ip=206.189.193.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peacevolution.org
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
	by a.peacevolution.org (Postfix) with ESMTPA id C55B741B58;
	Sat,  8 Feb 2025 21:16:34 +0000 (UTC)
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
Subject: [PATCH v5 2/8] iio: light: stk3310: handle all remove logic with devm callbacks
Date: Sat,  8 Feb 2025 16:13:20 -0500
Message-ID: <20250208211325.992280-4-aren@peacevolution.org>
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
X-Spam-Level: *****
X-Spamd-Bar: +++++
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=peacevolution.org;
	s=dkim; t=1739049396;
	h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding:in-reply-to:references;
	bh=LK3jemsDqV0sI5vp6vEaRz8iaDF3x6LJJQtbIKnsO3Q=;
	b=SxsuCYALuYawrH+McBMsT9cPn+MWX7JE7zYcQN7LbqqBevblVT10OP4u1jBlCGiNMaU54X
	MccDuTCMTMEnQsPfrOJ0jRblxrOE3L7HO0M3ZPAgrj7iV4zxJkigHUilMLW/MvnbwKYG/I
	hFrsW+IpFGNR6FKBkNOTK/3lyNJBG1g=

Using devm callbacks helps to make the ordering of probe / remove
operations easier to reason about and removes some duplicate code
between the probe error path and driver remove.

Signed-off-by: Aren Moynihan <aren@peacevolution.org>
---

Notes:
    Changes in v4:
     - also replace mutex_init with devm_mutex_init
    
    Added in v3

 drivers/iio/light/stk3310.c | 40 +++++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
index b81cc44db43c3..73ea36fa3acec 100644
--- a/drivers/iio/light/stk3310.c
+++ b/drivers/iio/light/stk3310.c
@@ -481,6 +481,17 @@ static int stk3310_set_state(struct stk3310_data *data, u8 state)
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
@@ -488,6 +499,7 @@ static int stk3310_init(struct iio_dev *indio_dev)
 	u8 state;
 	struct stk3310_data *data = iio_priv(indio_dev);
 	struct i2c_client *client = data->client;
+	struct device *dev = &client->dev;
 
 	ret = regmap_read(data->regmap, STK3310_REG_ID, &chipid);
 	if (ret < 0)
@@ -504,6 +516,10 @@ static int stk3310_init(struct iio_dev *indio_dev)
 		return ret;
 	}
 
+	ret = devm_add_action_or_reset(dev, stk3310_set_state_disable, data);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to register cleanup function\n");
+
 	/* Enable PS interrupts */
 	ret = regmap_field_write(data->reg_int_ps, STK3310_PSINT_EN);
 	if (ret < 0)
@@ -607,6 +623,7 @@ static int stk3310_probe(struct i2c_client *client)
 	int ret;
 	struct iio_dev *indio_dev;
 	struct stk3310_data *data;
+	struct device *dev = &client->dev;
 
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
 	if (!indio_dev) {
@@ -621,7 +638,9 @@ static int stk3310_probe(struct i2c_client *client)
 	device_property_read_u32(&client->dev, "proximity-near-level",
 				 &data->ps_near_level);
 
-	mutex_init(&data->lock);
+	ret = devm_mutex_init(dev, &data->lock);
+	if (ret)
+		return ret;
 
 	ret = stk3310_regmap_init(data);
 	if (ret < 0)
@@ -647,29 +666,17 @@ static int stk3310_probe(struct i2c_client *client)
 		if (ret < 0) {
 			dev_err(&client->dev, "request irq %d failed\n",
 				client->irq);
-			goto err_standby;
+			return ret;
 		}
 	}
 
-	ret = iio_device_register(indio_dev);
+	ret = devm_iio_device_register(dev, indio_dev);
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
@@ -733,7 +740,6 @@ static struct i2c_driver stk3310_driver = {
 		.acpi_match_table = stk3310_acpi_id,
 	},
 	.probe =        stk3310_probe,
-	.remove =           stk3310_remove,
 	.id_table =         stk3310_i2c_id,
 };
 
-- 
2.48.1


