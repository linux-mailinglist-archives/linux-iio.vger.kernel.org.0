Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11E3B4242D8
	for <lists+linux-iio@lfdr.de>; Wed,  6 Oct 2021 18:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234375AbhJFQku (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 6 Oct 2021 12:40:50 -0400
Received: from box.trvn.ru ([194.87.146.52]:36163 "EHLO box.trvn.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232082AbhJFQkt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 6 Oct 2021 12:40:49 -0400
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 23C1D428D5;
        Wed,  6 Oct 2021 21:31:17 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1633537877; bh=uIen75qqOYkJA/WCGn3GUIYd88tAz2rU3z+nxfJYUO4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bp/iCGBd+ZdVibcUACevapvSUxO7uA6hU8HSykqvKrvDo3x0MFpDuPivp+SBECZ3A
         KmhkAn5RxMUj5Quiftb6rWNPBGrX5ZMilGX/9Icqdc2VA7v7RiCgffPZdWWUGbBhYo
         lmrn3YBYIKzaxhPQzxTXsailPW66/nnqghsqOPfMkC48/IhHLBBXZNYyEcCCd+0VWD
         6PwvzqjGCIaZZW28+BuJeodTRvxr3C9OXEwivfvZFhToCDuk8dotN6Blor06xUmRt/
         axNjppZ1xtP+tHyikg2O5GMuy94ffmJpfe1XjDN1Vo6d5tJtbfrIAWzM3w0/eVvIXg
         IF4QZKtQeSM6g==
From:   Nikita Travkin <nikita@trvn.ru>
To:     jic23@kernel.org
Cc:     lars@metafoo.de, robh+dt@kernel.org, stephan@gerhold.net,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nikita Travkin <nikita@trvn.ru>
Subject: [PATCH 3/4] iio: light: ltr501: Add rudimentary regulator support
Date:   Wed,  6 Oct 2021 21:30:57 +0500
Message-Id: <20211006163058.145842-3-nikita@trvn.ru>
In-Reply-To: <20211006163058.145842-1-nikita@trvn.ru>
References: <20211006163058.145842-1-nikita@trvn.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On some platforms the supply regulators must be enabled before the
sensor can work. Add vdd and vddio regulators for the sensor and IO bus
power respectively.

Signed-off-by: Nikita Travkin <nikita@trvn.ru>
---
 drivers/iio/light/ltr501.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
index 1830221da48d..57851c8ef1c6 100644
--- a/drivers/iio/light/ltr501.c
+++ b/drivers/iio/light/ltr501.c
@@ -15,6 +15,7 @@
 #include <linux/delay.h>
 #include <linux/regmap.h>
 #include <linux/acpi.h>
+#include <linux/regulator/consumer.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/events.h>
@@ -151,6 +152,7 @@ struct ltr501_chip_info {
 
 struct ltr501_data {
 	struct i2c_client *client;
+	struct regulator_bulk_data regulators[2];
 	struct mutex lock_als, lock_ps;
 	const struct ltr501_chip_info *chip_info;
 	u8 als_contr, ps_contr;
@@ -1379,6 +1381,13 @@ static const struct regmap_config ltr501_regmap_config = {
 	.volatile_reg = ltr501_is_volatile_reg,
 };
 
+static void ltr501_disable_regulators(void *d)
+{
+	struct ltr501_data *data = d;
+
+	regulator_bulk_disable(ARRAY_SIZE(data->regulators), data->regulators);
+}
+
 static int ltr501_powerdown(struct ltr501_data *data)
 {
 	return ltr501_write_contr(data, data->als_contr &
@@ -1423,6 +1432,25 @@ static int ltr501_probe(struct i2c_client *client,
 	mutex_init(&data->lock_als);
 	mutex_init(&data->lock_ps);
 
+	data->regulators[0].supply = "vdd";
+	data->regulators[1].supply = "vddio";
+	ret = devm_regulator_bulk_get(&client->dev,
+				      ARRAY_SIZE(data->regulators),
+				      data->regulators);
+	if (ret)
+		return dev_err_probe(&client->dev, ret,
+				     "Failed to get regulators\n");
+
+	ret = regulator_bulk_enable(ARRAY_SIZE(data->regulators),
+				    data->regulators);
+	if (ret)
+		return ret;
+
+	ret = devm_add_action_or_reset(&client->dev,
+				       ltr501_disable_regulators, data);
+	if (ret)
+		return ret;
+
 	data->reg_it = devm_regmap_field_alloc(&client->dev, regmap,
 					       reg_field_it);
 	if (IS_ERR(data->reg_it)) {
-- 
2.30.2

