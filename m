Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 117987B822
	for <lists+linux-iio@lfdr.de>; Wed, 31 Jul 2019 05:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbfGaDEX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 30 Jul 2019 23:04:23 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35890 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbfGaDEX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 30 Jul 2019 23:04:23 -0400
Received: by mail-pf1-f196.google.com with SMTP id r7so30965682pfl.3;
        Tue, 30 Jul 2019 20:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nLKtWBaUclJcLSqz62oSyWuxJqyS+0P5ZZaa8NbQc7U=;
        b=mD7angjbJddZ1j4BHdjhB2jtUDu5Rz+DOMlgZ7q36CRlKC6d/jKgxcWDPkWs2N7p0j
         yct+h7lmEZqZ9PYTGOZXMQ5Vl+49aIEvDcm4pine2z/hP90BJGMvN620Asl3Ua27tJ/9
         +kiarBRAe/QI0tXIWtUX+BBoCfDp81WAG2U5OKGjMX10TeblSOC7YwsMvedjHFIBINub
         fEj6Vp6+ax37QhoUepCfjV32YGld8minfWZV1wj6CGMmzwWtnSOO4GIwyxBe9dXC+dqs
         18/euesbxu6WPILV9oqoZL/uk0AedaOg3VdwtMCzB0rh+kxN/p7jx5GZw1ey7ugkVuYw
         0Mrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nLKtWBaUclJcLSqz62oSyWuxJqyS+0P5ZZaa8NbQc7U=;
        b=nwvHbkaOwQaHhS9PHb4ln9MAB+1qqLB8vatEe2xbKbOMFqxtJj2xIHBlGyA0QnHrkl
         Ngfc9/fXRY0jazOzbBNykWSIlJK6zurk87pZ/660+3eifd1ZBDWLu0/PsAKFdFUaWrys
         /jBsPQF4mUxfVaUkBoQ4wRvdD2UACBe0kAqYeUTKeLxygacOXPHMiW0foyVOeNtCx+i2
         u/YxIEK/nU8cWSZuVs/zXd9vp4iR81mTO8Xr8ZARNEo4j54JZlHx277D4y9cQSKaXOpT
         IIWzDuX9NAt5oen+G/Nc8iMKBZbxMlnKF6k8h1zV+pE+VHEqXWwn9yswX9tHU+l9Dn/P
         jIiA==
X-Gm-Message-State: APjAAAX1nUEZuNi6KSvQxYIh6Tt1EhGrayIIb6QfHgZItwf/ZT6FNInX
        1IhMpLPRYuS42uu+kp+eJHI=
X-Google-Smtp-Source: APXvYqy6HZ540jFPOqegcCeDr4kcKSF+JKz8R+pobxIf4BzqW2IXGHKkT3SCbitOioukD2PvNukfUQ==
X-Received: by 2002:aa7:8383:: with SMTP id u3mr45104326pfm.175.1564542262254;
        Tue, 30 Jul 2019 20:04:22 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id g1sm107429981pgg.27.2019.07.30.20.04.18
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 20:04:21 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Brian Masney <masneyb@onstation.org>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH v3 1/2] iio: tsl2772: Use device-managed API
Date:   Wed, 31 Jul 2019 11:04:15 +0800
Message-Id: <20190731030415.8062-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Use devm_() APIs to simplify the code.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
Changes in v3:
  - Split v2 into two patches.

 drivers/iio/light/tsl2772.c | 36 +++++++++++++++---------------------
 1 file changed, 15 insertions(+), 21 deletions(-)

diff --git a/drivers/iio/light/tsl2772.c b/drivers/iio/light/tsl2772.c
index 83cece921843..f1134f183be7 100644
--- a/drivers/iio/light/tsl2772.c
+++ b/drivers/iio/light/tsl2772.c
@@ -860,6 +860,13 @@ static int tsl2772_chip_off(struct iio_dev *indio_dev)
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
@@ -1807,10 +1814,10 @@ static int tsl2772_probe(struct i2c_client *clientp,
 		return PTR_ERR(chip->vdd_supply);
 	}
 
-	ret = devm_add_action(&clientp->dev, tsl2772_disable_regulators_action,
+	ret = devm_add_action_or_reset(&clientp->dev,
+				tsl2772_disable_regulators_action,
 			      chip);
 	if (ret < 0) {
-		tsl2772_disable_regulators_action(chip);
 		dev_err(&clientp->dev, "Failed to setup regulator cleanup action %d\n",
 			ret);
 		return ret;
@@ -1877,15 +1884,14 @@ static int tsl2772_probe(struct i2c_client *clientp,
 	if (ret < 0)
 		return ret;
 
-	ret = iio_device_register(indio_dev);
-	if (ret) {
-		tsl2772_chip_off(indio_dev);
-		dev_err(&clientp->dev,
-			"%s: iio registration failed\n", __func__);
+	ret = devm_add_action_or_reset(&clientp->dev,
+					tsl2772_chip_off_action,
+					indio_dev);
+
+	if (ret < 0)
 		return ret;
-	}
 
-	return 0;
+	return devm_iio_device_register(&clientp->dev, indio_dev);
 }
 
 static int tsl2772_suspend(struct device *dev)
@@ -1922,17 +1928,6 @@ static int tsl2772_resume(struct device *dev)
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
@@ -1979,7 +1974,6 @@ static struct i2c_driver tsl2772_driver = {
 	},
 	.id_table = tsl2772_idtable,
 	.probe = tsl2772_probe,
-	.remove = tsl2772_remove,
 };
 
 module_i2c_driver(tsl2772_driver);
-- 
2.20.1

