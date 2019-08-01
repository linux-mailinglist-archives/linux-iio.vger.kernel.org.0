Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE0667D66D
	for <lists+linux-iio@lfdr.de>; Thu,  1 Aug 2019 09:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbfHAHg0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 1 Aug 2019 03:36:26 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39147 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbfHAHg0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 1 Aug 2019 03:36:26 -0400
Received: by mail-pf1-f196.google.com with SMTP id f17so29540511pfn.6;
        Thu, 01 Aug 2019 00:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aDlg6KGiZjR/ZSqeO5LTT2diSeBDVpED/ds/lS7zO2Y=;
        b=TJAoCm+UV+/2N1KYfLrH18ZxUdT3KzN4coCEAXjX2HjMl0nI1vdCa4rKkm3NGaj9/Q
         8wGxgsBegOEjI92eppUvuksLq0WABzawI69B8DNzpWrwKJL2z8qcco6Y9qYvFF4Psygi
         V0MPBtR6OYAjMHNcQ2aHbiOarOSBPJQNFdiDF+MctHnC8ShKgYcJR/Mc8WzN1z8+bDf6
         lR4rwDCPUX5Oq7SiMlMQOhbmOZa+UhJlnPPszblkCRYtucXmxwFopLtjTn6eFo6EoR9V
         whYRsKju+D8sm3wstEj+5rXTO60akotme0uadfVk8z68oLDn5JyumPJHlqcUP2hv9lPm
         E2qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aDlg6KGiZjR/ZSqeO5LTT2diSeBDVpED/ds/lS7zO2Y=;
        b=OjYNgnWvPXRAoqo2Ly8UI2bo6e/0ARz3ZdWpRZrT/WMwJWBB9mq17h60/arygmFawH
         VRm4FPxvOTM5ILG71idaRIZbGToXkmOl4tv+kWb0d4DSJP00fbfsobviSvxEiO87UWbk
         dXg453kZb70I2Jhdc5H0AjxqpKY/rSkg73KCMtHWmSOKA6DkGc0VWnB+A/qTNZM7eW5s
         lzlO5pmEb8POFNT/+JPImHHO8OGAF6+xtfqzBXqWC6IEBDwZ9q4Hf1OOviXc8uMEQz6m
         hB62vKn8mMzRoTtma+718b7fDRnEtFe88hImphYrVQe2RPHsuB7BmkL3Rc15x7Xqz94Z
         VipA==
X-Gm-Message-State: APjAAAUGjaXbWI316gTgwLv+Vg4zOxfh/T32rzsAbcNf0LG34sh3gv9q
        EJu2ROWqtw73R0C/MAzaAJ4=
X-Google-Smtp-Source: APXvYqwPTee4ZVGW/6xy7FMMXOeGLJQAy4y1fWk4sVlP9/l6uhQL8NgD/P6GePdM3bGUPAo3Uvh4Cw==
X-Received: by 2002:aa7:81d9:: with SMTP id c25mr52604884pfn.255.1564644985107;
        Thu, 01 Aug 2019 00:36:25 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id h70sm65467748pgc.36.2019.08.01.00.36.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 00:36:24 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Brian Masney <masneyb@onstation.org>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH v4 4/4] iio: tsl2772: Use regulator_bulk_() APIs
Date:   Thu,  1 Aug 2019 15:36:19 +0800
Message-Id: <20190801073619.9743-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Use regulator_bulk_() APIs to shrink driver size.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
Changes in v4:
  - Change the var name of regulator_bulk_data.
  - Adjust alignment.
  - Add a new line between two if blocks.

 drivers/iio/light/tsl2772.c | 87 +++++++++++++------------------------
 1 file changed, 29 insertions(+), 58 deletions(-)

diff --git a/drivers/iio/light/tsl2772.c b/drivers/iio/light/tsl2772.c
index 680afdb078d2..be37fcbd4654 100644
--- a/drivers/iio/light/tsl2772.c
+++ b/drivers/iio/light/tsl2772.c
@@ -134,6 +134,12 @@ enum {
 	TSL2772_CHIP_SUSPENDED = 2
 };
 
+enum {
+	TSL2772_SUPPLY_VDD = 0,
+	TSL2772_SUPPLY_VDDIO = 1,
+	TSL2772_NUM_SUPPLIES = 2
+};
+
 /* Per-device data */
 struct tsl2772_als_info {
 	u16 als_ch0;
@@ -161,8 +167,7 @@ struct tsl2772_chip {
 	struct mutex prox_mutex;
 	struct mutex als_mutex;
 	struct i2c_client *client;
-	struct regulator *vdd_supply;
-	struct regulator *vddio_supply;
+	struct regulator_bulk_data supplies[TSL2772_NUM_SUPPLIES];
 	u16 prox_data;
 	struct tsl2772_als_info als_cur_info;
 	struct tsl2772_settings settings;
@@ -697,46 +702,7 @@ static void tsl2772_disable_regulators_action(void *_data)
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
+	regulator_bulk_disable(ARRAY_SIZE(chip->supplies), chip->supplies);
 }
 
 static int tsl2772_chip_on(struct iio_dev *indio_dev)
@@ -1804,14 +1770,26 @@ static int tsl2772_probe(struct i2c_client *clientp,
 	chip->client = clientp;
 	i2c_set_clientdata(clientp, indio_dev);
 
-	chip->vddio_supply = tsl2772_get_regulator(chip, "vddio");
-	if (IS_ERR(chip->vddio_supply))
-		return PTR_ERR(chip->vddio_supply);
+	chip->supplies[TSL2772_SUPPLY_VDD].supply = "vdd";
+	chip->supplies[TSL2772_SUPPLY_VDDIO].supply = "vddio";
 
-	chip->vdd_supply = tsl2772_get_regulator(chip, "vdd");
-	if (IS_ERR(chip->vdd_supply)) {
-		regulator_disable(chip->vddio_supply);
-		return PTR_ERR(chip->vdd_supply);
+	ret = devm_regulator_bulk_get(&clientp->dev,
+				      ARRAY_SIZE(chip->supplies),
+				      chip->supplies);
+	if (ret < 0) {
+		if (ret != -EPROBE_DEFER)
+			dev_err(&clientp->dev,
+				"Failed to get regulators: %d\n",
+				ret);
+
+		return ret;
+	}
+
+	ret = regulator_bulk_enable(ARRAY_SIZE(chip->supplies), chip->supplies);
+	if (ret < 0) {
+		dev_err(&clientp->dev, "Failed to enable regulators: %d\n",
+			ret);
+		return ret;
 	}
 
 	ret = devm_add_action_or_reset(&clientp->dev,
@@ -1900,8 +1878,7 @@ static int tsl2772_suspend(struct device *dev)
 	int ret;
 
 	ret = tsl2772_chip_off(indio_dev);
-	regulator_disable(chip->vdd_supply);
-	regulator_disable(chip->vddio_supply);
+	regulator_bulk_disable(ARRAY_SIZE(chip->supplies), chip->supplies);
 
 	return ret;
 }
@@ -1912,16 +1889,10 @@ static int tsl2772_resume(struct device *dev)
 	struct tsl2772_chip *chip = iio_priv(indio_dev);
 	int ret;
 
-	ret = tsl2772_enable_regulator(chip, chip->vddio_supply);
+	ret = regulator_bulk_enable(ARRAY_SIZE(chip->supplies), chip->supplies);
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
-- 
2.20.1

