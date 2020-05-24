Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5AD1DFC94
	for <lists+linux-iio@lfdr.de>; Sun, 24 May 2020 04:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388263AbgEXCvu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 23 May 2020 22:51:50 -0400
Received: from mail.zju.edu.cn ([61.164.42.155]:53384 "EHLO zju.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388262AbgEXCvu (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 23 May 2020 22:51:50 -0400
Received: from localhost.localdomain (unknown [222.205.77.158])
        by mail-app2 (Coremail) with SMTP id by_KCgBXHpAl4cleagbCAQ--.44957S4;
        Sun, 24 May 2020 10:51:21 +0800 (CST)
From:   Dinghao Liu <dinghao.liu@zju.edu.cn>
To:     dinghao.liu@zju.edu.cn, kjlu@umn.edu
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: magnetometer: ak8974: Fix runtime PM imbalance on error
Date:   Sun, 24 May 2020 10:51:17 +0800
Message-Id: <20200524025117.15679-1-dinghao.liu@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: by_KCgBXHpAl4cleagbCAQ--.44957S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw4rXrW7uFyUAF13Cry5twb_yoW8uFWkpr
        WkZFy7trW8Xw12qF45ArnxuFy5Cay3Jry8CrZ0ka47ZFsxZa98tF4kJr1YvF18CFWkJF4U
        Jr4vq39ruF12kF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUva1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2
        z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcV
        Aq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j
        6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
        vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVAFwVW8JwCF04k20xvY0x0EwIxG
        rwCF04k20xvE74AGY7Cv6cx26r4fKr1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
        6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv
        67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyT
        uYvjfUO_MaUUUUU
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAgEJBlZdtORShQARsR
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

When devm_regmap_init_i2c() returns an error code, a pairing
runtime PM usage counter decrement is needed to keep the
counter balanced. For error paths after ak8974_set_power(),
ak8974_detect() and ak8974_reset(), things are the same.

However, When iio_triggered_buffer_setup() returns an error
code, we don't need such a decrement because there is already
one before this call. Things are the same for other error paths
after it.

Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
---
 drivers/iio/magnetometer/ak8974.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/magnetometer/ak8974.c b/drivers/iio/magnetometer/ak8974.c
index d32996702110..c1bdb304eb9e 100644
--- a/drivers/iio/magnetometer/ak8974.c
+++ b/drivers/iio/magnetometer/ak8974.c
@@ -764,18 +764,24 @@ static int ak8974_probe(struct i2c_client *i2c,
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
+		pm_runtime_put_noidle(&i2c->dev);
+		pm_runtime_disable(&i2c->dev);
 		goto power_off;
 	}
 
 	ret = ak8974_detect(ak8974);
 	if (ret) {
 		dev_err(&i2c->dev, "neither AK8974 nor AMI30x found\n");
+		pm_runtime_put_noidle(&i2c->dev);
+		pm_runtime_disable(&i2c->dev);
 		goto power_off;
 	}
 
@@ -786,6 +792,8 @@ static int ak8974_probe(struct i2c_client *i2c,
 	ret = ak8974_reset(ak8974);
 	if (ret) {
 		dev_err(&i2c->dev, "AK8974 reset failed\n");
+		pm_runtime_put_noidle(&i2c->dev);
+		pm_runtime_disable(&i2c->dev);
 		goto power_off;
 	}
 
@@ -851,7 +859,6 @@ static int ak8974_probe(struct i2c_client *i2c,
 cleanup_buffer:
 	iio_triggered_buffer_cleanup(indio_dev);
 disable_pm:
-	pm_runtime_put_noidle(&i2c->dev);
 	pm_runtime_disable(&i2c->dev);
 	ak8974_set_power(ak8974, AK8974_PWR_OFF);
 power_off:
-- 
2.17.1

