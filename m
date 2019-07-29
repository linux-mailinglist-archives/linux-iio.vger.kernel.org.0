Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6B978915
	for <lists+linux-iio@lfdr.de>; Mon, 29 Jul 2019 12:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbfG2KDs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 29 Jul 2019 06:03:48 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46610 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbfG2KDs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 29 Jul 2019 06:03:48 -0400
Received: by mail-pl1-f195.google.com with SMTP id c2so27289296plz.13;
        Mon, 29 Jul 2019 03:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vOGpMl552FygMXPX2+TYRNoRusjP/DEMFHtzis/q4dc=;
        b=K+vGDLENJPIirskMFUETiPXIEm21dQGMHnCuL+IUoU8nSbxIxxn17j48OOaw2+Hef0
         Dzko5BEFpAEhZABfnlgHVwtT8BMJ0ip9ESVcyZOLh7/9b029jTZgH9TMBQxMWrTBghGU
         fxlbgyZdxc4qSL90hejPGNzywKRr4cjYC3aWXZaBzZrwqBMBEo4JqS83eX28waGUlr77
         jnwVfby+zx1syJZCsbxn6ZzG4ROvImPiMjPOVPJJqOXYetJ8X4Z+J0b3xxlb5PYdUNSx
         D5BErayniIeWbyjzw8BPZZQalwQt/FKbt1Zj2G4p2QjvtxiImn0wrz55C5W1UcyxPWz+
         JVyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vOGpMl552FygMXPX2+TYRNoRusjP/DEMFHtzis/q4dc=;
        b=YQibvQgJ+Z5+WuLLD43mLiKAxHViX6YYoxLLobGzUZrIwV96ushQ7kSYknUbKk1x1q
         4pxFpiCED9LuqHpLQyEwdvHiM3eWi2yWJEBoKFiLM1+M+gl4LjUVdv+YzlSEgi3aaRBs
         mBkSuA49wdBE9fUSt17dhNT1a8iptnYV3Mm3xvNX9m/PNayx5DS5nM3IRTwDi3qDLE9i
         mmIs567eN5OPer6CkUty0Y7O4L4k0PRQYUCEMz2ODzFkxizSUvcjCdY+eSFlxGaG99GM
         FIKc4LemX4BilCp5ewsYVBbf6QPNR9fPp2jNvjXBDSjbYRBqajZBF0pS6j4DabxSxFWg
         jRPQ==
X-Gm-Message-State: APjAAAWABw+CUjwXZQ+rrdau8axd2GjNIYbNpJVxYe++/Gl9jfyhsnNR
        gn9yXKNKUjINMEHaw9feNpw=
X-Google-Smtp-Source: APXvYqwK9biZhbZKFawAVdfhB9ssPdRsamzDKvBD3sEvy58ucb5IKSXP5Tx07DsoAlqs9Vy/QWd3Jg==
X-Received: by 2002:a17:902:aa95:: with SMTP id d21mr104922251plr.185.1564394627769;
        Mon, 29 Jul 2019 03:03:47 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id q1sm82641423pfn.178.2019.07.29.03.03.44
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 03:03:46 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Brian Masney <masneyb@onstation.org>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH v2] iio: tsl2772: Use device-managed API
Date:   Mon, 29 Jul 2019 18:03:39 +0800
Message-Id: <20190729100339.24054-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Use devm_iio_device_register to simplify
the code.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
Changes in v2:
  - Use regulator_bulk_() to shrink driver
    size.
  - Utilize more devm functions to simplify
    the code.
  - Remove several redundant functions.

 drivers/iio/light/tsl2772.c | 116 +++++++++++-------------------------
 1 file changed, 34 insertions(+), 82 deletions(-)

diff --git a/drivers/iio/light/tsl2772.c b/drivers/iio/light/tsl2772.c
index 83cece921843..946537c8586f 100644
--- a/drivers/iio/light/tsl2772.c
+++ b/drivers/iio/light/tsl2772.c
@@ -131,7 +131,10 @@ enum {
 enum {
 	TSL2772_CHIP_UNKNOWN = 0,
 	TSL2772_CHIP_WORKING = 1,
-	TSL2772_CHIP_SUSPENDED = 2
+	TSL2772_CHIP_SUSPENDED = 2,
+	TSL2772_SUPPLY_VDD = 0,
+	TSL2772_SUPPLY_VDDIO = 1,
+	TSL2772_NUM_SUPPLIES = 2
 };
 
 /* Per-device data */
@@ -161,8 +164,7 @@ struct tsl2772_chip {
 	struct mutex prox_mutex;
 	struct mutex als_mutex;
 	struct i2c_client *client;
-	struct regulator *vdd_supply;
-	struct regulator *vddio_supply;
+	struct regulator_bulk_data reg[TSL2772_NUM_SUPPLIES];
 	u16 prox_data;
 	struct tsl2772_als_info als_cur_info;
 	struct tsl2772_settings settings;
@@ -697,46 +699,7 @@ static void tsl2772_disable_regulators_action(void *_data)
 {
 	struct tsl2772_chip *chip = _data;
 
-	regulator_disable(chip->vdd_supply);
-	regulator_disable(chip->vddio_supply);
-}
-
-static int tsl2772_enable_regulator(struct tsl2772_chip *chip,
-				    struct regulator *regulator)
-{
-	int ret;
-
-	ret = regulator_enable(regulator);
-	if (ret < 0) {
-		dev_err(&chip->client->dev, "Failed to enable regulator: %d\n",
-			ret);
-		return ret;
-	}
-
-	return 0;
-}
-
-static struct regulator *tsl2772_get_regulator(struct tsl2772_chip *chip,
-					       char *name)
-{
-	struct regulator *regulator;
-	int ret;
-
-	regulator = devm_regulator_get(&chip->client->dev, name);
-	if (IS_ERR(regulator)) {
-		if (PTR_ERR(regulator) != -EPROBE_DEFER)
-			dev_err(&chip->client->dev,
-				"Failed to get %s regulator %d\n",
-				name, (int)PTR_ERR(regulator));
-
-		return regulator;
-	}
-
-	ret = tsl2772_enable_regulator(chip, regulator);
-	if (ret < 0)
-		return ERR_PTR(ret);
-
-	return regulator;
+	regulator_bulk_disable(ARRAY_SIZE(chip->reg), chip->reg);
 }
 
 static int tsl2772_chip_on(struct iio_dev *indio_dev)
@@ -860,6 +823,13 @@ static int tsl2772_chip_off(struct iio_dev *indio_dev)
 	return tsl2772_write_control_reg(chip, 0x00);
 }
 
+static void tsl2772_chip_off_action(void *data)
+{
+	struct iio_dev *indio_dev = data;
+
+	tsl2772_chip_off(indio_dev);
+}
+
 /**
  * tsl2772_invoke_change - power cycle the device to implement the user
  *                         parameters
@@ -1797,20 +1767,22 @@ static int tsl2772_probe(struct i2c_client *clientp,
 	chip->client = clientp;
 	i2c_set_clientdata(clientp, indio_dev);
 
-	chip->vddio_supply = tsl2772_get_regulator(chip, "vddio");
-	if (IS_ERR(chip->vddio_supply))
-		return PTR_ERR(chip->vddio_supply);
+	chip->reg[TSL2772_SUPPLY_VDD].supply = "vdd";
+	chip->reg[TSL2772_SUPPLY_VDDIO].supply = "vddio";
 
-	chip->vdd_supply = tsl2772_get_regulator(chip, "vdd");
-	if (IS_ERR(chip->vdd_supply)) {
-		regulator_disable(chip->vddio_supply);
-		return PTR_ERR(chip->vdd_supply);
-	}
+	ret = devm_regulator_bulk_get(&clientp->dev, ARRAY_SIZE(chip->reg),
+		chip->reg);
+	if (ret < 0)
+		return ret;
+
+	ret = regulator_bulk_enable(ARRAY_SIZE(chip->reg), chip->reg);
+	if (ret < 0)
+		return ret;
 
-	ret = devm_add_action(&clientp->dev, tsl2772_disable_regulators_action,
-			      chip);
+	ret = devm_add_action_or_reset(&clientp->dev,
+				tsl2772_disable_regulators_action,
+			    chip);
 	if (ret < 0) {
-		tsl2772_disable_regulators_action(chip);
 		dev_err(&clientp->dev, "Failed to setup regulator cleanup action %d\n",
 			ret);
 		return ret;
@@ -1877,15 +1849,14 @@ static int tsl2772_probe(struct i2c_client *clientp,
 	if (ret < 0)
 		return ret;
 
-	ret = iio_device_register(indio_dev);
-	if (ret) {
-		tsl2772_chip_off(indio_dev);
-		dev_err(&clientp->dev,
-			"%s: iio registration failed\n", __func__);
+	ret = devm_add_action_or_reset(&clientp->dev,
+						tsl2772_chip_off_action,
+						indio_dev);
+
+	if (ret < 0)
 		return ret;
-	}
 
-	return 0;
+	return devm_iio_device_register(&clientp->dev, indio_dev);
 }
 
 static int tsl2772_suspend(struct device *dev)
@@ -1895,8 +1866,7 @@ static int tsl2772_suspend(struct device *dev)
 	int ret;
 
 	ret = tsl2772_chip_off(indio_dev);
-	regulator_disable(chip->vdd_supply);
-	regulator_disable(chip->vddio_supply);
+	regulator_bulk_disable(ARRAY_SIZE(chip->reg), chip->reg);
 
 	return ret;
 }
@@ -1907,32 +1877,15 @@ static int tsl2772_resume(struct device *dev)
 	struct tsl2772_chip *chip = iio_priv(indio_dev);
 	int ret;
 
-	ret = tsl2772_enable_regulator(chip, chip->vddio_supply);
+	ret = regulator_bulk_enable(ARRAY_SIZE(chip->reg), chip->reg);
 	if (ret < 0)
 		return ret;
 
-	ret = tsl2772_enable_regulator(chip, chip->vdd_supply);
-	if (ret < 0) {
-		regulator_disable(chip->vddio_supply);
-		return ret;
-	}
-
 	usleep_range(TSL2772_BOOT_MIN_SLEEP_TIME, TSL2772_BOOT_MAX_SLEEP_TIME);
 
 	return tsl2772_chip_on(indio_dev);
 }
 
-static int tsl2772_remove(struct i2c_client *client)
-{
-	struct iio_dev *indio_dev = i2c_get_clientdata(client);
-
-	tsl2772_chip_off(indio_dev);
-
-	iio_device_unregister(indio_dev);
-
-	return 0;
-}
-
 static const struct i2c_device_id tsl2772_idtable[] = {
 	{ "tsl2571", tsl2571 },
 	{ "tsl2671", tsl2671 },
@@ -1979,7 +1932,6 @@ static struct i2c_driver tsl2772_driver = {
 	},
 	.id_table = tsl2772_idtable,
 	.probe = tsl2772_probe,
-	.remove = tsl2772_remove,
 };
 
 module_i2c_driver(tsl2772_driver);
-- 
2.20.1

