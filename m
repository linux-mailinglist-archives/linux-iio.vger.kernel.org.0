Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0E3A600163
	for <lists+linux-iio@lfdr.de>; Sun, 16 Oct 2022 18:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbiJPQef (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 Oct 2022 12:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbiJPQee (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 16 Oct 2022 12:34:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF6A6564
        for <linux-iio@vger.kernel.org>; Sun, 16 Oct 2022 09:34:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3906560BEE
        for <linux-iio@vger.kernel.org>; Sun, 16 Oct 2022 16:34:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD5E5C433D6;
        Sun, 16 Oct 2022 16:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665938070;
        bh=GhVHV6K+q3LcxWI69qYLDgj1UGrM58lQD/K0aFYcpiI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QoJsUXSAWUJNuuT6ohDHpk/Ob5IKpt0z2kQkFJ/6whGMkOZYR9+baessYqUY5aMmq
         jfLTPiLXg+BXHnz5yDMnSsK6Iqi6mb2XcuRgOcRhAi9iDsTRlf6S5eXkc7LnzvORCC
         DVzuCO1qy4HINly8u4RkyZxhYFkDLHdi1QMUgqeBoKkdN53gywQTrWtxLU7JNYGjBx
         PJzsny9a9PEqEHFTIWx91wGkKpERmtFrQ/7GSzlRgz7aUW5CDhFo5vLKkk/c62jPBg
         N5C/ljgo39UpmHwBjwhNkjEqBrp9rcEMWjJIQckNG0/PaOLozRWuRZ/QqGEaDz6gKf
         OLCHuWCp4SV7g==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        Sean Nyekjaer <sean@geanix.com>,
        Dmitry Rokosov <DDRokosov@sberdevices.ru>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Martyn Welch <martyn.welch@collabora.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Tomasz Duszynski <tduszyns@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 09/14] iio: humidity: hts211: Use devm_regulator_get_enable()
Date:   Sun, 16 Oct 2022 17:34:04 +0100
Message-Id: <20221016163409.320197-10-jic23@kernel.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221016163409.320197-1-jic23@kernel.org>
References: <20221016163409.320197-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This driver only turns the power on at probe and off via a custom
devm_add_action_or_reset() callback. The new devm_regulator_get_enable()
replaces this boilerplate code.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/iio/humidity/hts221.h      |  2 --
 drivers/iio/humidity/hts221_core.c | 27 ++++-----------------------
 2 files changed, 4 insertions(+), 25 deletions(-)

diff --git a/drivers/iio/humidity/hts221.h b/drivers/iio/humidity/hts221.h
index cf3d8d2dccd6..721359e226cb 100644
--- a/drivers/iio/humidity/hts221.h
+++ b/drivers/iio/humidity/hts221.h
@@ -13,7 +13,6 @@
 #define HTS221_DEV_NAME		"hts221"
 
 #include <linux/iio/iio.h>
-#include <linux/regulator/consumer.h>
 
 enum hts221_sensor_type {
 	HTS221_SENSOR_H,
@@ -30,7 +29,6 @@ struct hts221_hw {
 	const char *name;
 	struct device *dev;
 	struct regmap *regmap;
-	struct regulator *vdd;
 
 	struct iio_trigger *trig;
 	int irq;
diff --git a/drivers/iio/humidity/hts221_core.c b/drivers/iio/humidity/hts221_core.c
index 517158307d8c..2a413da87b76 100644
--- a/drivers/iio/humidity/hts221_core.c
+++ b/drivers/iio/humidity/hts221_core.c
@@ -14,6 +14,7 @@
 #include <linux/delay.h>
 #include <linux/pm.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
 #include <linux/bitfield.h>
 
 #include "hts221.h"
@@ -549,33 +550,17 @@ static const unsigned long hts221_scan_masks[] = {0x3, 0x0};
 
 static int hts221_init_regulators(struct device *dev)
 {
-	struct iio_dev *iio_dev = dev_get_drvdata(dev);
-	struct hts221_hw *hw = iio_priv(iio_dev);
 	int err;
 
-	hw->vdd = devm_regulator_get(dev, "vdd");
-	if (IS_ERR(hw->vdd))
-		return dev_err_probe(dev, PTR_ERR(hw->vdd),
-				     "failed to get vdd regulator\n");
-
-	err = regulator_enable(hw->vdd);
-	if (err) {
-		dev_err(dev, "failed to enable vdd regulator: %d\n", err);
-		return err;
-	}
+	err = devm_regulator_get_enable(dev, "vdd");
+	if (err)
+		return dev_err_probe(dev, err, "failed to get vdd regulator\n");
 
 	msleep(50);
 
 	return 0;
 }
 
-static void hts221_chip_uninit(void *data)
-{
-	struct hts221_hw *hw = data;
-
-	regulator_disable(hw->vdd);
-}
-
 int hts221_probe(struct device *dev, int irq, const char *name,
 		 struct regmap *regmap)
 {
@@ -600,10 +585,6 @@ int hts221_probe(struct device *dev, int irq, const char *name,
 	if (err)
 		return err;
 
-	err = devm_add_action_or_reset(dev, hts221_chip_uninit, hw);
-	if (err)
-		return err;
-
 	err = hts221_check_whoami(hw);
 	if (err < 0)
 		return err;
-- 
2.37.2

