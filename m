Return-Path: <linux-iio+bounces-11471-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C399B3351
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 15:23:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9095D1F236B9
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 14:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A391DE4E0;
	Mon, 28 Oct 2024 14:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b="brSA4imX"
X-Original-To: linux-iio@vger.kernel.org
Received: from a.peacevolution.org (a.peacevolution.org [206.189.193.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6ED21DE3DB;
	Mon, 28 Oct 2024 14:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.193.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730125324; cv=none; b=DO1U2rN3jysFTkNCcaQIv3rViZ16H8PWvIQUBAvTw3Y1zVtr3A6c8nFkR6/2gHC1s3tyJ+0NGAw1n2Az9O8ScKj0GWN0/2xVsfncYWqG/VCWjh8W7jox7f/v0lfATfEqMr1JNZghYo4VizVwGhYjif23JoF9Ptf+i+hwtJZFm+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730125324; c=relaxed/simple;
	bh=U8rlJZTMqpHnsFmbKCMlHFvFQ6aACYBAaLdN4IKCXrw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P5PP+p+bC9mEDQQ+qogjoNhhhGdSxlWBI6Ac4QY6Wp87Vzz7wCLJ3x2s5SBVgpYrzT1LbjrKij2H2c3i0DLdEcby36Hqj8JoCZxiD119zZpA0yDyFHRVF3rkqZ/JdGcFnr/oqhf/IyZGzTmQXRmpR2yl/9Vfol86ARPfaQL+x3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org; spf=pass smtp.mailfrom=peacevolution.org; dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b=brSA4imX; arc=none smtp.client-ip=206.189.193.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peacevolution.org
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
	by a.peacevolution.org (Postfix) with ESMTPA id D55D14C75C;
	Mon, 28 Oct 2024 14:21:59 +0000 (UTC)
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
Subject: [PATCH v3 3/6] iio: light: stk3310: Implement vdd and leda supplies
Date: Mon, 28 Oct 2024 10:19:57 -0400
Message-ID: <20241028142000.1058149-4-aren@peacevolution.org>
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
X-Spam-Level: ******
X-Spamd-Bar: ++++++
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=peacevolution.org;
	s=dkim; t=1730125321;
	h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding:in-reply-to:references;
	bh=XzAaEXLSb0gVUT48L6jxPocvqnzRypxww88Qv3DK4cg=;
	b=brSA4imXB0mSeHbBEkm0HIhd4Kor5Vt3u76cpfTs6Mort8TXHc5mtytkhkZxfEUntzK3TF
	Gte8CA20RGA0VPC2Tog1IkFQC1N0k/1QvyQo4L4fTi9n1UfQGWKGH61OSyFvEVE+8iDfI5
	uk41hR2FP09oEmQGNBA8dnFAiQDdsLE=

The vdd and leda supplies must be powered on for the chip to function
and can be powered off during system suspend.

Co-developed-by: Ondrej Jirman <megi@xff.cz>
Signed-off-by: Aren Moynihan <aren@peacevolution.org>
---

Notes:
    I'm not sure what the proper way to handle attribution for this patch
    is. It was origionally based on a patch by Ondrej Jirman[1], but I have
    rewritten a large portion if it. I have included a Co-developed-by tag
    to indicate this, but haven't sent him this patch, so I'm not sure what
    to do about a Signed-off-by.
    
    1: https://codeberg.org/megi/linux/commit/a933aff8b7a0e6e3c9cf1d832dcba07022bbfa82
    
    Changes in v3:
     - use bulk regulators instead of two individual ones
     - handle cleanup using devm callbacks instead of the remove function
    
    Changes in v2:
     - always enable / disable regulators and rely on a dummy regulator if
       one isn't specified
     - replace usleep_range with fsleep
     - reorder includes so iio headers are last
     - add missing error handling to resume

 drivers/iio/light/stk3310.c | 76 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 74 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
index 2e1aa551bdbc..f02b4d20c282 100644
--- a/drivers/iio/light/stk3310.c
+++ b/drivers/iio/light/stk3310.c
@@ -13,6 +13,8 @@
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+
 #include <linux/iio/events.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -130,6 +132,7 @@ struct stk3310_data {
 	struct regmap_field *reg_int_ps;
 	struct regmap_field *reg_flag_psint;
 	struct regmap_field *reg_flag_nf;
+	struct regulator_bulk_data supplies[2];
 };
 
 static const struct iio_event_spec stk3310_events[] = {
@@ -621,6 +624,31 @@ static irqreturn_t stk3310_irq_event_handler(int irq, void *private)
 	return IRQ_HANDLED;
 }
 
+static int stk3310_regulators_enable(struct stk3310_data *data)
+{
+	int ret;
+
+	ret = regulator_bulk_enable(ARRAY_SIZE(data->supplies), data->supplies);
+	if (ret)
+		return ret;
+
+	/* we need a short delay to allow the chip time to power on */
+	fsleep(1000);
+
+	return 0;
+}
+
+static void stk3310_regulators_disable(void *private)
+{
+	int ret;
+	struct stk3310_data *data = private;
+	struct device *dev = &data->client->dev;
+
+	ret = regulator_bulk_disable(ARRAY_SIZE(data->supplies), data->supplies);
+	if (ret)
+		dev_err(dev, "failed to disable regulators: %d\n", ret);
+}
+
 static int stk3310_probe(struct i2c_client *client)
 {
 	int ret;
@@ -642,6 +670,13 @@ static int stk3310_probe(struct i2c_client *client)
 
 	mutex_init(&data->lock);
 
+	data->supplies[0].supply = "vdd";
+	data->supplies[1].supply = "leda";
+	ret = devm_regulator_bulk_get(&client->dev, ARRAY_SIZE(data->supplies),
+				      data->supplies);
+	if (ret)
+		return dev_err_probe(&client->dev, ret, "get regulators failed\n");
+
 	ret = stk3310_regmap_init(data);
 	if (ret < 0)
 		return ret;
@@ -652,6 +687,16 @@ static int stk3310_probe(struct i2c_client *client)
 	indio_dev->channels = stk3310_channels;
 	indio_dev->num_channels = ARRAY_SIZE(stk3310_channels);
 
+	ret = stk3310_regulators_enable(data);
+	if (ret)
+		return dev_err_probe(&client->dev, ret,
+				     "regulator enable failed\n");
+
+	ret = devm_add_action_or_reset(&client->dev, stk3310_regulators_disable, data);
+	if (ret)
+		return dev_err_probe(&client->dev, ret,
+				     "failed to register regulator cleanup\n");
+
 	ret = stk3310_init(indio_dev);
 	if (ret < 0)
 		return ret;
@@ -682,18 +727,45 @@ static int stk3310_probe(struct i2c_client *client)
 static int stk3310_suspend(struct device *dev)
 {
 	struct stk3310_data *data;
+	int ret;
 
 	data = iio_priv(i2c_get_clientdata(to_i2c_client(dev)));
 
-	return stk3310_set_state(data, STK3310_STATE_STANDBY);
+	ret = stk3310_set_state(data, STK3310_STATE_STANDBY);
+	if (ret)
+		return ret;
+
+	regcache_mark_dirty(data->regmap);
+
+	ret = regulator_bulk_disable(ARRAY_SIZE(data->supplies), data->supplies);
+	if (ret) {
+		dev_err(dev, "failed to disable regulators: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
 }
 
 static int stk3310_resume(struct device *dev)
 {
-	u8 state = 0;
 	struct stk3310_data *data;
+	u8 state = 0;
+	int ret;
 
 	data = iio_priv(i2c_get_clientdata(to_i2c_client(dev)));
+
+	ret = stk3310_regulators_enable(data);
+	if (ret) {
+		dev_err(dev, "Failed to re-enable regulators: %d", ret);
+		return ret;
+	}
+
+	ret = regcache_sync(data->regmap);
+	if (ret) {
+		dev_err(dev, "Failed to restore registers: %d\n", ret);
+		return ret;
+	}
+
 	if (data->ps_enabled)
 		state |= STK3310_STATE_EN_PS;
 	if (data->als_enabled)
-- 
2.47.0


