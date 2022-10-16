Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB7E360015D
	for <lists+linux-iio@lfdr.de>; Sun, 16 Oct 2022 18:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbiJPQeR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 Oct 2022 12:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbiJPQeQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 16 Oct 2022 12:34:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E4A4326C1
        for <linux-iio@vger.kernel.org>; Sun, 16 Oct 2022 09:34:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E814CB80D08
        for <linux-iio@vger.kernel.org>; Sun, 16 Oct 2022 16:34:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27D3AC433B5;
        Sun, 16 Oct 2022 16:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665938052;
        bh=a7yOum5JKAu+Fe4m4Cd7L9Oye/qmDO0+fBk8bKBco68=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O42POj5xSgHaoe82UQb08aDms52gHGvGp+QgEiNSQ+qBfN5QUU2ROgBVmEkz+1F9v
         3uEcwNkbu4UlDNbt/wjk+5WEwzITnnQiC2q0jDwwKDapzIP1A/GcjLscoC71k2o43q
         9OB5bd5GY/34uTaSlU5atTyYHXOmGaiAPV2C4ZGvP6pvo3xmJB2jJmVIAuFDovjKkW
         8mvnvHE0IpRmAvyhIZWXad5si6UPNPX4y43SAq4DZGPBl3S6OVnViwQcEk+C4lYAFs
         /SAOG0+vQa9ltNEOhV4ofmXYWU6E2CjJGQ5D7nqvgs1dPjqMkhgL3+xzBAKEro+KWK
         UBm0y6hRb5lWw==
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
Subject: [PATCH 05/14] iio: accel: msa311: Use devm_regulator_get_enable()
Date:   Sun, 16 Oct 2022 17:34:00 +0100
Message-Id: <20221016163409.320197-6-jic23@kernel.org>
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
Cc: Dmitry Rokosov <DDRokosov@sberdevices.ru>
---
 drivers/iio/accel/msa311.c | 21 ++-------------------
 1 file changed, 2 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/accel/msa311.c b/drivers/iio/accel/msa311.c
index 2fded3759171..af94d3adf6d8 100644
--- a/drivers/iio/accel/msa311.c
+++ b/drivers/iio/accel/msa311.c
@@ -351,7 +351,6 @@ static const struct regmap_config msa311_regmap_config = {
  * @chip_name: Chip name in the format "msa311-%02x" % partid
  * @new_data_trig: Optional NEW_DATA interrupt driven trigger used
  *                 to notify external consumers a new sample is ready
- * @vdd: Optional external voltage regulator for the device power supply
  */
 struct msa311_priv {
 	struct regmap *regs;
@@ -362,7 +361,6 @@ struct msa311_priv {
 	char *chip_name;
 
 	struct iio_trigger *new_data_trig;
-	struct regulator *vdd;
 };
 
 enum msa311_si {
@@ -1146,11 +1144,6 @@ static void msa311_powerdown(void *msa311)
 	msa311_set_pwr_mode(msa311, MSA311_PWR_MODE_SUSPEND);
 }
 
-static void msa311_vdd_disable(void *vdd)
-{
-	regulator_disable(vdd);
-}
-
 static int msa311_probe(struct i2c_client *i2c)
 {
 	struct device *dev = &i2c->dev;
@@ -1173,19 +1166,9 @@ static int msa311_probe(struct i2c_client *i2c)
 
 	mutex_init(&msa311->lock);
 
-	msa311->vdd = devm_regulator_get(dev, "vdd");
-	if (IS_ERR(msa311->vdd))
-		return dev_err_probe(dev, PTR_ERR(msa311->vdd),
-				     "can't get vdd supply\n");
-
-	err = regulator_enable(msa311->vdd);
+	err = devm_regulator_get_enable(dev, "vdd");
 	if (err)
-		return dev_err_probe(dev, err, "can't enable vdd supply\n");
-
-	err = devm_add_action_or_reset(dev, msa311_vdd_disable, msa311->vdd);
-	if (err)
-		return dev_err_probe(dev, err,
-				     "can't add vdd disable action\n");
+		return dev_err_probe(dev, err, "can't get vdd supply\n");
 
 	err = msa311_check_partid(msa311);
 	if (err)
-- 
2.37.2

