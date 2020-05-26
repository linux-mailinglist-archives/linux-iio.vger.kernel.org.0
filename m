Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5940F1E200E
	for <lists+linux-iio@lfdr.de>; Tue, 26 May 2020 12:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbgEZKsE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 26 May 2020 06:48:04 -0400
Received: from spam.zju.edu.cn ([61.164.42.155]:57540 "EHLO zju.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726977AbgEZKsE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 26 May 2020 06:48:04 -0400
Received: from localhost.localdomain (unknown [222.205.78.173])
        by mail-app4 (Coremail) with SMTP id cS_KCgAHD1O288xeGV4XAA--.8295S4;
        Tue, 26 May 2020 18:47:22 +0800 (CST)
From:   Dinghao Liu <dinghao.liu@zju.edu.cn>
To:     dinghao.liu@zju.edu.cn, kjlu@umn.edu
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] iio: magnetometer: ak8974: Fix runtime PM imbalance on error
Date:   Tue, 26 May 2020 18:47:17 +0800
Message-Id: <20200526104717.3181-1-dinghao.liu@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: cS_KCgAHD1O288xeGV4XAA--.8295S4
X-Coremail-Antispam: 1UD129KBjvJXoWxGrW7Ww47tw15urW5WFWxJFb_yoW5XF4fpr
        WkZFy7trW8Xa47XF4YyrsI9ry5Ca9xJry8CrZYk3WUZF1ayFZ8tFn7Jr1aqF18CFZ7JF45
        JF48t39ruF129r7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUva1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2
        z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcV
        Aq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j
        6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
        vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVAFwVW8twCF04k20xvY0x0EwIxG
        rwCF04k20xvE74AGY7Cv6cx26r4fKr1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
        6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv
        67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyT
        uYvjfUonmRUUUUU
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAgcMBlZdtOUGZwABs1
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

When devm_regmap_init_i2c() returns an error code, a pairing
runtime PM usage counter decrement is needed to keep the
counter balanced. For error paths after ak8974_set_power(),
ak8974_detect() and ak8974_reset(), things are the same.

However, When iio_triggered_buffer_setup() returns an error
code, there will be two PM usgae counter decrements.

Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
---

Changelog:

v2: - Change 3 goto targets from "power_off" to
      "disabel_pm". Remove unused lable "power_off".
      Move 3 PM runtime related calls to the end of
      the function.
---
 drivers/iio/magnetometer/ak8974.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8974.c b/drivers/iio/magnetometer/ak8974.c
index d32996702110..c48c67d4b371 100644
--- a/drivers/iio/magnetometer/ak8974.c
+++ b/drivers/iio/magnetometer/ak8974.c
@@ -764,19 +764,21 @@ static int ak8974_probe(struct i2c_client *i2c,
 	ak8974->map = devm_regmap_init_i2c(i2c, &ak8974_regmap_config);
 	if (IS_ERR(ak8974->map)) {
 		dev_err(&i2c->dev, "failed to allocate register map\n");
+		pm_runtime_put_noidle(&i2c->dev);
+		pm_runtime_disable(&i2c->dev);
 		return PTR_ERR(ak8974->map);
 	}
 
 	ret = ak8974_set_power(ak8974, AK8974_PWR_ON);
 	if (ret) {
 		dev_err(&i2c->dev, "could not power on\n");
-		goto power_off;
+		goto disable_pm;
 	}
 
 	ret = ak8974_detect(ak8974);
 	if (ret) {
 		dev_err(&i2c->dev, "neither AK8974 nor AMI30x found\n");
-		goto power_off;
+		goto disable_pm;
 	}
 
 	ret = ak8974_selftest(ak8974);
@@ -786,14 +788,9 @@ static int ak8974_probe(struct i2c_client *i2c,
 	ret = ak8974_reset(ak8974);
 	if (ret) {
 		dev_err(&i2c->dev, "AK8974 reset failed\n");
-		goto power_off;
+		goto disable_pm;
 	}
 
-	pm_runtime_set_autosuspend_delay(&i2c->dev,
-					 AK8974_AUTOSUSPEND_DELAY);
-	pm_runtime_use_autosuspend(&i2c->dev);
-	pm_runtime_put(&i2c->dev);
-
 	indio_dev->dev.parent = &i2c->dev;
 	indio_dev->channels = ak8974_channels;
 	indio_dev->num_channels = ARRAY_SIZE(ak8974_channels);
@@ -846,6 +843,11 @@ static int ak8974_probe(struct i2c_client *i2c,
 		goto cleanup_buffer;
 	}
 
+	pm_runtime_set_autosuspend_delay(&i2c->dev,
+					 AK8974_AUTOSUSPEND_DELAY);
+	pm_runtime_use_autosuspend(&i2c->dev);
+	pm_runtime_put(&i2c->dev);
+
 	return 0;
 
 cleanup_buffer:
@@ -854,7 +856,6 @@ static int ak8974_probe(struct i2c_client *i2c,
 	pm_runtime_put_noidle(&i2c->dev);
 	pm_runtime_disable(&i2c->dev);
 	ak8974_set_power(ak8974, AK8974_PWR_OFF);
-power_off:
 	regulator_bulk_disable(ARRAY_SIZE(ak8974->regs), ak8974->regs);
 
 	return ret;
-- 
2.17.1

