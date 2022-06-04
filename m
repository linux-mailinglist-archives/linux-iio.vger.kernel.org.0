Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC3853D79B
	for <lists+linux-iio@lfdr.de>; Sat,  4 Jun 2022 18:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237992AbiFDQDm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Jun 2022 12:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237984AbiFDQDm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 4 Jun 2022 12:03:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5066286DB
        for <linux-iio@vger.kernel.org>; Sat,  4 Jun 2022 09:03:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8E382B8069B
        for <linux-iio@vger.kernel.org>; Sat,  4 Jun 2022 16:03:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB4E4C36AE3;
        Sat,  4 Jun 2022 16:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654358617;
        bh=0SOx3c6aBcif/9j7gTE3UpXYNkrXr8ovQONA+oZ14Dk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ck0laejdfbYG1k77Y6fVR/9xar9jJLBQWAbFkr3QwtZi3rO2AevLMLTNbA5quKStn
         zLrGXq1ubg8AWMILPL+PBB5xXPUP6+if3DYrczj1SahVAtHLap00wsWQDw+HGGi6Tj
         84jGzd9d96QKm2o5tTDntTRLRp5FThkjaEx3K3z/TO3H23z2FduN0r038T8A/1cGNQ
         Yh5NVraqSkVWUts8iv0ELAs3e8A5O788OFM3UEzLtJuiDPxW7gCDR5KLL5PLjvp9Ih
         WpsOLJjS1A5ZssNgJz+9cWAIb95T5tzSjI6gPW80ZhsnQAaCtU0OEn9HZm4ZeABLar
         GbV/gVOzAgWpQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [RESEND PATCH 3/5] iio: humidity: hts221: Move symbol exports into IIO_HTS221 namespace
Date:   Sat,  4 Jun 2022 17:12:21 +0100
Message-Id: <20220604161223.461847-4-jic23@kernel.org>
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

Avoid unnecessary pollution of the global symbol namespace by
moving library functions in to a specific namespace and import
that into the drivers that make use of the functions.

For more info: https://lwn.net/Articles/760045/

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>
Link: https://lore.kernel.org/r/20220220181522.541718-7-jic23@kernel.org
---
 drivers/iio/humidity/hts221_core.c | 5 +++--
 drivers/iio/humidity/hts221_i2c.c  | 1 +
 drivers/iio/humidity/hts221_spi.c  | 1 +
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/humidity/hts221_core.c b/drivers/iio/humidity/hts221_core.c
index da9c08432ef2..517158307d8c 100644
--- a/drivers/iio/humidity/hts221_core.c
+++ b/drivers/iio/humidity/hts221_core.c
@@ -668,7 +668,7 @@ int hts221_probe(struct device *dev, int irq, const char *name,
 
 	return devm_iio_device_register(hw->dev, iio_dev);
 }
-EXPORT_SYMBOL(hts221_probe);
+EXPORT_SYMBOL_NS(hts221_probe, IIO_HTS221);
 
 static int hts221_suspend(struct device *dev)
 {
@@ -694,7 +694,8 @@ static int hts221_resume(struct device *dev)
 	return err;
 }
 
-EXPORT_SIMPLE_DEV_PM_OPS(hts221_pm_ops, hts221_suspend, hts221_resume);
+EXPORT_NS_SIMPLE_DEV_PM_OPS(hts221_pm_ops, hts221_suspend, hts221_resume,
+			    IIO_HTS221);
 
 MODULE_AUTHOR("Lorenzo Bianconi <lorenzo.bianconi@st.com>");
 MODULE_DESCRIPTION("STMicroelectronics hts221 sensor driver");
diff --git a/drivers/iio/humidity/hts221_i2c.c b/drivers/iio/humidity/hts221_i2c.c
index 933b05e4d972..afbc611f7712 100644
--- a/drivers/iio/humidity/hts221_i2c.c
+++ b/drivers/iio/humidity/hts221_i2c.c
@@ -74,3 +74,4 @@ module_i2c_driver(hts221_driver);
 MODULE_AUTHOR("Lorenzo Bianconi <lorenzo.bianconi@st.com>");
 MODULE_DESCRIPTION("STMicroelectronics hts221 i2c driver");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(IIO_HTS221);
diff --git a/drivers/iio/humidity/hts221_spi.c b/drivers/iio/humidity/hts221_spi.c
index 888c5eab944c..fc4adb68faf6 100644
--- a/drivers/iio/humidity/hts221_spi.c
+++ b/drivers/iio/humidity/hts221_spi.c
@@ -66,3 +66,4 @@ module_spi_driver(hts221_driver);
 MODULE_AUTHOR("Lorenzo Bianconi <lorenzo.bianconi@st.com>");
 MODULE_DESCRIPTION("STMicroelectronics hts221 spi driver");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(IIO_HTS221);
-- 
2.36.1

