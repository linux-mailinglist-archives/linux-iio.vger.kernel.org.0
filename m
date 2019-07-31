Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD52D7B824
	for <lists+linux-iio@lfdr.de>; Wed, 31 Jul 2019 05:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728314AbfGaDEa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 30 Jul 2019 23:04:30 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45369 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbfGaDEa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 30 Jul 2019 23:04:30 -0400
Received: by mail-pf1-f193.google.com with SMTP id r1so30954589pfq.12;
        Tue, 30 Jul 2019 20:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2QlSNFu1dUP/B+me4BxUHR+T/odrpULH3hEpS4tUUw4=;
        b=ckulWYQxKGqN0gL07+zGTez6TKJF8tj/3lZ62irYXJ7y1iFf1MlrxmB4ROIkixOxjj
         XC0Ufrh0Wvcyjb4TkZcENx6Wjuc1ct1J6ZK8jJs2JUlJ2Ui/PIsbHpFjhJYlFRGVz5UL
         64ZHunpH9BqgEIRQh2reKRoO4z44QQSRy8XNfq8dCHIIdEgKCk8zYvBRpr+2rCCaZHoc
         9XMRqnx3G2cB4AlAoKGSdi+SyMwyAwbQIFCcG1UAaGxHD09xq04lPVDwvhEX+a277ybZ
         3ppGTDgsZTOpw+XmJJGioB6JlXkl23xOWJXti9aSeIirnlDInV2v4+qOIp1Pcq3rFMYD
         RKIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2QlSNFu1dUP/B+me4BxUHR+T/odrpULH3hEpS4tUUw4=;
        b=OjRg2AiHUeDfq5nT2DndI6Sv6loL1e29tJBjnsUN5YYIpsGTDNDQ7UeZ5ixhLPujVo
         C3zj68g5YmriT5Cwmw3STpFBPaMI96RbmhnirsYfkyejpmKdcIvVSRGNwFjIFcU+pQEV
         PuEwz/hsrXcvJpRbVa16gT7UgzvcF6NnImiVvUorlQTmBxBgpWtbiPDKBjEZZpauOdQl
         E73Fu9MQy6cWbf9BWKK2DIOVLJMXfbO8VvaPtXZUarGsQT24pkdOy+84UOs1C1oj/B4h
         /s1EuTGrBmqazuaUrHjfH4uHWluzR9M07pSf4jp/Tc4Q/Y2038f1mGonWbrA3GXTvaoH
         vVIQ==
X-Gm-Message-State: APjAAAWu7GZ6GJs2LrQ7Xesn1y46rShextyV7SQ3StJ0hGFesA4Jo6b9
        PG30stzr8jQ6b3+X8jYMyCE=
X-Google-Smtp-Source: APXvYqzRXjCa+vOghPaFFnUFCaSDvH1hb4p8C2pMxazM3TJcBBqn25U7CXpW2jietlsHNl5XtOuYTw==
X-Received: by 2002:aa7:8189:: with SMTP id g9mr45703459pfi.143.1564542269261;
        Tue, 30 Jul 2019 20:04:29 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id f8sm34351930pgd.58.2019.07.30.20.04.26
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 20:04:28 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Brian Masney <masneyb@onstation.org>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH v3 2/2] iio: tsl2772: Use regulator_bulk_() APIs
Date:   Wed, 31 Jul 2019 11:04:23 +0800
Message-Id: <20190731030423.8116-1-hslester96@gmail.com>
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
Changes in v3:
  - Split v2 into two patches.
  - Add dev_err to log error messages.
  - Add a check for EPROBE_DEFER.

 drivers/iio/light/tsl2772.c | 82 +++++++++++--------------------------
 1 file changed, 24 insertions(+), 58 deletions(-)

diff --git a/drivers/iio/light/tsl2772.c b/drivers/iio/light/tsl2772.c
index f1134f183be7..fd6d44297dba 100644
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
+	struct regulator_bulk_data reg[TSL2772_NUM_SUPPLIES];
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
+	regulator_bulk_disable(ARRAY_SIZE(chip->reg), chip->reg);
 }
 
 static int tsl2772_chip_on(struct iio_dev *indio_dev)
@@ -1804,14 +1770,21 @@ static int tsl2772_probe(struct i2c_client *clientp,
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
+	ret = devm_regulator_bulk_get(&clientp->dev, ARRAY_SIZE(chip->reg),
+								chip->reg);
+	if (ret < 0) {
+		if (ret != -EPROBE_DEFER)
+			dev_err(&clientp->dev, "Failed to get regulators: %d\n", ret);
+		return ret;
+	}
+
+	ret = regulator_bulk_enable(ARRAY_SIZE(chip->reg), chip->reg);
+	if (ret < 0) {
+		dev_err(&clientp->dev, "Failed to enable regulators: %d\n", ret);
+		return ret;
 	}
 
 	ret = devm_add_action_or_reset(&clientp->dev,
@@ -1901,8 +1874,7 @@ static int tsl2772_suspend(struct device *dev)
 	int ret;
 
 	ret = tsl2772_chip_off(indio_dev);
-	regulator_disable(chip->vdd_supply);
-	regulator_disable(chip->vddio_supply);
+	regulator_bulk_disable(ARRAY_SIZE(chip->reg), chip->reg);
 
 	return ret;
 }
@@ -1913,16 +1885,10 @@ static int tsl2772_resume(struct device *dev)
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
-- 
2.20.1

