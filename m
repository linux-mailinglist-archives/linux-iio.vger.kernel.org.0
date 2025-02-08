Return-Path: <linux-iio+bounces-15182-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 910EBA2D8D3
	for <lists+linux-iio@lfdr.de>; Sat,  8 Feb 2025 22:16:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7B651887D33
	for <lists+linux-iio@lfdr.de>; Sat,  8 Feb 2025 21:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08DF1F3BA8;
	Sat,  8 Feb 2025 21:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b="I3LnkCzf"
X-Original-To: linux-iio@vger.kernel.org
Received: from a.peacevolution.org (a.peacevolution.org [206.189.193.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FA01AA1FE;
	Sat,  8 Feb 2025 21:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.193.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739049400; cv=none; b=U+8wgJlFnrTDHeIe7szwMisle3hJX2uUspSDJeubcWYM232j5iHnO6CvA/8sTrw6R8ZHiuxqq8uRdBRYtM1rNLqKQBLfzAShKNuOaFVW/85KkdAIoIfo8vw/4AKKeUe/894Y3L0DQFyq0r+dE5z4pnQ2eznDigc5lqsB5CCwLIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739049400; c=relaxed/simple;
	bh=S7TS2dTgXLDKWQ8H4GZRdQ/KgeNs9JFfBdout5LGBKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fDXJXCr4jOnV3tZCDY0yuRmsSvChy52oVYduzk9YqtvDZDaF1ih3lwLg4BHhpbyRU6dH0H2Cx1gSTORjGUp70DINY41hB5Vx+NjkgwusyXqfdd0rAcV8pimwDTvJLr9sCTdpFp78kpqw2CHhqqHi9c7dpOrmiFik6SaWWJkjBt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org; spf=pass smtp.mailfrom=peacevolution.org; dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b=I3LnkCzf; arc=none smtp.client-ip=206.189.193.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peacevolution.org
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
	by a.peacevolution.org (Postfix) with ESMTPA id DB3AB41B5C;
	Sat,  8 Feb 2025 21:16:36 +0000 (UTC)
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
Subject: [PATCH v5 3/8] iio: light: stk3310: implement vdd and leda supplies
Date: Sat,  8 Feb 2025 16:13:21 -0500
Message-ID: <20250208211325.992280-5-aren@peacevolution.org>
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
X-Spam-Level: ******
X-Spamd-Bar: ++++++
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=peacevolution.org;
	s=dkim; t=1739049398;
	h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding:in-reply-to:references;
	bh=ntyJSBJfrG72XmoeXkVO4Qlom9oNlP0IrTSTWLoR4vU=;
	b=I3LnkCzfPUy+GdccLFWWcf0WyW5X015DA1Kz9Du2vHznVZxboQC1SM2FNhmwpnJZh0bhGx
	ERiS5NwZwJzCd7dCy3a7/tBVLLUJ5/woBkKg7MejpSgovuGLo8i90Z/fFRPMhJ/p5WHzQ2
	8g0YA5dCF/toruqEIwGew0+e/+iYeMk=

The vdd and leda supplies must be powered on for the chip to function
and can be powered off during system suspend.

This is originally based on a patch by Ondrej Jirman, but has been
rewritten since.

Link: https://codeberg.org/megi/linux/commit/a933aff8b7a0e6e3c9cf1d832dcba07022bbfa82
Signed-off-by: Aren Moynihan <aren@peacevolution.org>
---

Notes:
    Changes in v5:
     - explicitely include array_size.h
    
    Changes in v4:
     - fix variable declaration order in stk3310_resume to match the rest of
       the driver
    
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
index 73ea36fa3acec..9c38ff01fdf0f 100644
--- a/drivers/iio/light/stk3310.c
+++ b/drivers/iio/light/stk3310.c
@@ -7,12 +7,15 @@
  * IIO driver for STK3310/STK3311. 7-bit I2C address: 0x48.
  */
 
+#include <linux/array_size.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+
 #include <linux/iio/events.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -130,6 +133,7 @@ struct stk3310_data {
 	struct regmap_field *reg_int_ps;
 	struct regmap_field *reg_flag_psint;
 	struct regmap_field *reg_flag_nf;
+	struct regulator_bulk_data supplies[2];
 };
 
 static const struct iio_event_spec stk3310_events[] = {
@@ -618,6 +622,31 @@ static irqreturn_t stk3310_irq_event_handler(int irq, void *private)
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
@@ -642,6 +671,13 @@ static int stk3310_probe(struct i2c_client *client)
 	if (ret)
 		return ret;
 
+	data->supplies[0].supply = "vdd";
+	data->supplies[1].supply = "leda";
+	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(data->supplies),
+				      data->supplies);
+	if (ret)
+		return dev_err_probe(dev, ret, "get regulators failed\n");
+
 	ret = stk3310_regmap_init(data);
 	if (ret < 0)
 		return ret;
@@ -652,6 +688,15 @@ static int stk3310_probe(struct i2c_client *client)
 	indio_dev->channels = stk3310_channels;
 	indio_dev->num_channels = ARRAY_SIZE(stk3310_channels);
 
+	ret = stk3310_regulators_enable(data);
+	if (ret)
+		return dev_err_probe(dev, ret, "regulator enable failed\n");
+
+	ret = devm_add_action_or_reset(dev, stk3310_regulators_disable, data);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "failed to register regulator cleanup\n");
+
 	ret = stk3310_init(indio_dev);
 	if (ret < 0)
 		return ret;
@@ -681,19 +726,46 @@ static int stk3310_probe(struct i2c_client *client)
 
 static int stk3310_suspend(struct device *dev)
 {
+	int ret;
 	struct stk3310_data *data;
 
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
+	int ret;
 	struct stk3310_data *data;
+	u8 state = 0;
 
 	data = iio_priv(i2c_get_clientdata(to_i2c_client(dev)));
+
+	ret = stk3310_regulators_enable(data);
+	if (ret) {
+		dev_err(dev, "Failed to re-enable regulators: %d\n", ret);
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
2.48.1


