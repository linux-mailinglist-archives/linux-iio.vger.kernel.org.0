Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CAEE53D79D
	for <lists+linux-iio@lfdr.de>; Sat,  4 Jun 2022 18:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237997AbiFDQDo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Jun 2022 12:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238001AbiFDQDm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 4 Jun 2022 12:03:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A92E286DC
        for <linux-iio@vger.kernel.org>; Sat,  4 Jun 2022 09:03:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BAD1160EAC
        for <linux-iio@vger.kernel.org>; Sat,  4 Jun 2022 16:03:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7AD5C36AE3;
        Sat,  4 Jun 2022 16:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654358621;
        bh=OP7pdcy9mvPtKqyf66TsRtMflMNN83QaB0NJ+Wj/WGg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IL1W3vm3RKLv0gmBTXnM6VgfYu8OGkrJ3M1O6eSnHyge2cjsWF6nQEck+WOikX5yA
         m6kIrb9N8orq8YVXn9ix67AUAFqYVEVIFwHF/zwH/iJ5AiXgs8Q2qn0g9Q5j3fcf1V
         kwW2+oKxHEWon2YV3taF6eNhRN9iKLClo8nb0Ag+tikfRUu4V94CPaJ0tqdYK0y79g
         VaVLrqbTbZawPbTlhxZT1ygwQIfH9hLBzJy41c94dp415X5ySIuP2ngYLRpEV3KV1f
         VINTPSxxF+sZY+iiysbORnrbioyzNmGzJNPyd+LuLNLjahZmYaKZtN4pKuW1ifavCa
         5QRip/c3bX1ZQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [RESEND PATCH 5/5] iio: imu: lsm6dsx: Move exported symbols to the IIO_LSM6DSX namespace
Date:   Sat,  4 Jun 2022 17:12:23 +0100
Message-Id: <20220604161223.461847-6-jic23@kernel.org>
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
Link: https://lore.kernel.org/r/20220220181522.541718-9-jic23@kernel.org
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 6 +++---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c  | 1 +
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c  | 1 +
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c  | 1 +
 4 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index 9e4aa5c1c8d6..6b268f1c5fc3 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -2289,7 +2289,7 @@ int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id,
 
 	return 0;
 }
-EXPORT_SYMBOL(st_lsm6dsx_probe);
+EXPORT_SYMBOL_NS(st_lsm6dsx_probe, IIO_LSM6DSX);
 
 static int st_lsm6dsx_suspend(struct device *dev)
 {
@@ -2366,8 +2366,8 @@ static int st_lsm6dsx_resume(struct device *dev)
 	return err;
 }
 
-EXPORT_SIMPLE_DEV_PM_OPS(st_lsm6dsx_pm_ops, st_lsm6dsx_suspend,
-			 st_lsm6dsx_resume);
+EXPORT_NS_SIMPLE_DEV_PM_OPS(st_lsm6dsx_pm_ops, st_lsm6dsx_suspend,
+			    st_lsm6dsx_resume, IIO_LSM6DSX);
 
 MODULE_AUTHOR("Lorenzo Bianconi <lorenzo.bianconi@st.com>");
 MODULE_AUTHOR("Denis Ciocca <denis.ciocca@st.com>");
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
index 5bd565b93a8c..2ea34c0d3a8c 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
@@ -146,3 +146,4 @@ MODULE_AUTHOR("Lorenzo Bianconi <lorenzo.bianconi@st.com>");
 MODULE_AUTHOR("Denis Ciocca <denis.ciocca@st.com>");
 MODULE_DESCRIPTION("STMicroelectronics st_lsm6dsx i2c driver");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(IIO_LSM6DSX);
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c
index 4df186499802..3b0c8b19c448 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c
@@ -54,3 +54,4 @@ module_i3c_driver(st_lsm6dsx_driver);
 MODULE_AUTHOR("Vitor Soares <vitor.soares@synopsys.com>");
 MODULE_DESCRIPTION("STMicroelectronics st_lsm6dsx i3c driver");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(IIO_LSM6DSX);
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
index 3a206fd4d92c..6a8883f022a8 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
@@ -146,3 +146,4 @@ MODULE_AUTHOR("Lorenzo Bianconi <lorenzo.bianconi@st.com>");
 MODULE_AUTHOR("Denis Ciocca <denis.ciocca@st.com>");
 MODULE_DESCRIPTION("STMicroelectronics st_lsm6dsx spi driver");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(IIO_LSM6DSX);
-- 
2.36.1

