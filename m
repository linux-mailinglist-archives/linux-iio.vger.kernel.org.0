Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50D0653D79A
	for <lists+linux-iio@lfdr.de>; Sat,  4 Jun 2022 18:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237979AbiFDQDi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Jun 2022 12:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237984AbiFDQDh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 4 Jun 2022 12:03:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE50286DC
        for <linux-iio@vger.kernel.org>; Sat,  4 Jun 2022 09:03:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E18C760E9E
        for <linux-iio@vger.kernel.org>; Sat,  4 Jun 2022 16:03:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D1D1C34119;
        Sat,  4 Jun 2022 16:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654358615;
        bh=5L5zfHOo9YjQc3aTFmxjI3nBGjZ4EU5LBpij1BpYUs4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sTMXtBVIQJaT2XwQQdVurQGjtW9P1fPWMCzVz2VTIT16lRPawisTm8CSq3HMS7btM
         cOMvOBsYN1ozYPQHyTO5k99WqkM+F7Nfcdu6Qxlj+6acn+s0xgXxu7Nspq4JdX/30h
         rAcCoeS/QadlkEQl/xaqvpls+LNAI1oIEEryaopK3Aoq/16vj9K0eG7xc32r46zUIB
         RFeNqTtKCGdhjEywTZGT0g4NkA4G5LMG6xbpjnWjSq0Pk5cnCSko10EfCrlRQ0XDSd
         rzxcl5USRGbSJIcuN7dEwItVxm/OOwJ6VkkTBIYIaVvgDutXG/8R1pV0lm7mg3z9kY
         0AWORFLz8SutA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [RESEND PATCH 2/5] iio: humidity: hts221: Use EXPORT_SIMPLE_DEV_PM_OPS() to allow compiler to remove dead code.
Date:   Sat,  4 Jun 2022 17:12:20 +0100
Message-Id: <20220604161223.461847-3-jic23@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220604161223.461847-1-jic23@kernel.org>
References: <20220604161223.461847-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

If CONFIG_PM_SLEEP is not defined using EXPORT_SIMPLE_DEV_PM_OPS()
in conjunction with pm_sleep_ptr() allows the compiler to remove
the unused code and data. This removes the need for __maybe_unused
markings etc.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>
Link: https://lore.kernel.org/r/20220220181522.541718-6-jic23@kernel.org
---
 drivers/iio/humidity/hts221_core.c | 9 +++------
 drivers/iio/humidity/hts221_i2c.c  | 2 +-
 drivers/iio/humidity/hts221_spi.c  | 2 +-
 3 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/humidity/hts221_core.c b/drivers/iio/humidity/hts221_core.c
index 6a39615b6961..da9c08432ef2 100644
--- a/drivers/iio/humidity/hts221_core.c
+++ b/drivers/iio/humidity/hts221_core.c
@@ -670,7 +670,7 @@ int hts221_probe(struct device *dev, int irq, const char *name,
 }
 EXPORT_SYMBOL(hts221_probe);
 
-static int __maybe_unused hts221_suspend(struct device *dev)
+static int hts221_suspend(struct device *dev)
 {
 	struct iio_dev *iio_dev = dev_get_drvdata(dev);
 	struct hts221_hw *hw = iio_priv(iio_dev);
@@ -680,7 +680,7 @@ static int __maybe_unused hts221_suspend(struct device *dev)
 				  FIELD_PREP(HTS221_ENABLE_MASK, false));
 }
 
-static int __maybe_unused hts221_resume(struct device *dev)
+static int hts221_resume(struct device *dev)
 {
 	struct iio_dev *iio_dev = dev_get_drvdata(dev);
 	struct hts221_hw *hw = iio_priv(iio_dev);
@@ -694,10 +694,7 @@ static int __maybe_unused hts221_resume(struct device *dev)
 	return err;
 }
 
-const struct dev_pm_ops hts221_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(hts221_suspend, hts221_resume)
-};
-EXPORT_SYMBOL(hts221_pm_ops);
+EXPORT_SIMPLE_DEV_PM_OPS(hts221_pm_ops, hts221_suspend, hts221_resume);
 
 MODULE_AUTHOR("Lorenzo Bianconi <lorenzo.bianconi@st.com>");
 MODULE_DESCRIPTION("STMicroelectronics hts221 sensor driver");
diff --git a/drivers/iio/humidity/hts221_i2c.c b/drivers/iio/humidity/hts221_i2c.c
index cab39c4756f8..933b05e4d972 100644
--- a/drivers/iio/humidity/hts221_i2c.c
+++ b/drivers/iio/humidity/hts221_i2c.c
@@ -62,7 +62,7 @@ MODULE_DEVICE_TABLE(i2c, hts221_i2c_id_table);
 static struct i2c_driver hts221_driver = {
 	.driver = {
 		.name = "hts221_i2c",
-		.pm = &hts221_pm_ops,
+		.pm = pm_sleep_ptr(&hts221_pm_ops),
 		.of_match_table = hts221_i2c_of_match,
 		.acpi_match_table = ACPI_PTR(hts221_acpi_match),
 	},
diff --git a/drivers/iio/humidity/hts221_spi.c b/drivers/iio/humidity/hts221_spi.c
index 729e86e433b1..888c5eab944c 100644
--- a/drivers/iio/humidity/hts221_spi.c
+++ b/drivers/iio/humidity/hts221_spi.c
@@ -55,7 +55,7 @@ MODULE_DEVICE_TABLE(spi, hts221_spi_id_table);
 static struct spi_driver hts221_driver = {
 	.driver = {
 		.name = "hts221_spi",
-		.pm = &hts221_pm_ops,
+		.pm = pm_sleep_ptr(&hts221_pm_ops),
 		.of_match_table = hts221_spi_of_match,
 	},
 	.probe = hts221_spi_probe,
-- 
2.36.1

