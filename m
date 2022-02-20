Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDFFD4BD090
	for <lists+linux-iio@lfdr.de>; Sun, 20 Feb 2022 19:19:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244482AbiBTSJY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 20 Feb 2022 13:09:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244488AbiBTSJY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 20 Feb 2022 13:09:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CEF2527FB
        for <linux-iio@vger.kernel.org>; Sun, 20 Feb 2022 10:09:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4A02AB80D9C
        for <linux-iio@vger.kernel.org>; Sun, 20 Feb 2022 18:09:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6014AC340F0;
        Sun, 20 Feb 2022 18:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645380540;
        bh=d0wPJssQ3/6yGjmPjbgos22DqYLXiNXaGgTbNCdWQYs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N18JUaOob0OjnvOPsyTyaTTpirrShBCyPH5cSqGYKWEtAHJft4cIQkSoWyGXD3+Tn
         fF5oxnnp9m7YBTITpYWVurSvBGSn8ROxYTTW74DLgWLYA2du2FS1FjfebjLcqHl2ys
         TGUNVz22qTANg9jFRvRy2C+SIzm8o8QZng1oKMU6MY38zUVqAy3LYwWH9SEDS2Xkhf
         CudR3JaBrvjoeOGx45PYnrY9DvcfKsbqeI4O1lQG4z/EhwmiUyKGG4vVOFE8zg9wv3
         P8+hKkhRjfq5WQw1El3muRpicVuU2+S857CYsLuRvCM2FB2gL1GXQgeteEs/XmUlXj
         MhDWcxJ+pR27A==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Tomasz Duszynski <tomasz.duszynski@octakon.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6/8] iio: humidity: hts221: Move symbol exports into IIO_HTS221 namespace
Date:   Sun, 20 Feb 2022 18:15:20 +0000
Message-Id: <20220220181522.541718-7-jic23@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220220181522.541718-1-jic23@kernel.org>
References: <20220220181522.541718-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
2.35.1

