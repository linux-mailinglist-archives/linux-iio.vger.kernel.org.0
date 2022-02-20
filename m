Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 483DB4BD093
	for <lists+linux-iio@lfdr.de>; Sun, 20 Feb 2022 19:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244489AbiBTSJ3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 20 Feb 2022 13:09:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244488AbiBTSJ3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 20 Feb 2022 13:09:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29470527E5
        for <linux-iio@vger.kernel.org>; Sun, 20 Feb 2022 10:09:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CA333B80DAE
        for <linux-iio@vger.kernel.org>; Sun, 20 Feb 2022 18:09:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 006E8C36AE3;
        Sun, 20 Feb 2022 18:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645380544;
        bh=N9/wJ5Y7mRYtOlnDVlD2jdSksLcjrjzsdCSt64BWsVw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IT0u/W1AuTo6KK2RbZW/xTnuF2KUybuPeo5De1DIKvZyD12ou8JKgG3vyfzCF4AUI
         u+vee9vTBKh6BnvDmm+YWl/St3S+/UTGrnlbUAFlDOqF25u5hV8K0/MppqWLAAvWtK
         Z8aCEGuJzCwJclY859g+ciCXX2dDXvMjIu0otEw2a2jSEx6JuQqAR8t1u7INR5oIPT
         C0gqRrMJYEPCTqWtptzA9A5Kk2+JNzax5S7QOGfzOaACTxEMurSUq28hD2nLzE+3X6
         ePUWpNvdc52u6+Cg+ARuVYyaQfPH9mbsnW06JyBl7MoMhYE4WakINgSw19+T9ubRAu
         5kM7yccaU2lYg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Tomasz Duszynski <tomasz.duszynski@octakon.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 8/8] iio: imu: lsm6dsx: Move exported symbols to the IIO_LSM6DSX namespace
Date:   Sun, 20 Feb 2022 18:15:22 +0000
Message-Id: <20220220181522.541718-9-jic23@kernel.org>
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
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 6 +++---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c  | 1 +
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c  | 1 +
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c  | 1 +
 4 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index 0a86534bd1dd..03f3bc62e27b 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -2281,7 +2281,7 @@ int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id,
 
 	return 0;
 }
-EXPORT_SYMBOL(st_lsm6dsx_probe);
+EXPORT_SYMBOL_NS(st_lsm6dsx_probe, IIO_LSM6DSX);
 
 static int st_lsm6dsx_suspend(struct device *dev)
 {
@@ -2358,8 +2358,8 @@ static int st_lsm6dsx_resume(struct device *dev)
 	return err;
 }
 
-EXPORT_SIMPLE_DEV_PM_OPS(st_lsm6dsx_pm_ops, st_lsm6dsx_suspend,
-			 st_lsm6dsx_resume);
+EXPORT_NS_SIMPLE_DEV_PM_OPS(st_lsm6dsx_pm_ops, st_lsm6dsx_suspend,
+			    st_lsm6dsx_resume, IIO_LSM6DSX);
 
 MODULE_AUTHOR("Lorenzo Bianconi <lorenzo.bianconi@st.com>");
 MODULE_AUTHOR("Denis Ciocca <denis.ciocca@st.com>");
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
index faf4e67f0f4c..7ea12ae66afe 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
@@ -141,3 +141,4 @@ MODULE_AUTHOR("Lorenzo Bianconi <lorenzo.bianconi@st.com>");
 MODULE_AUTHOR("Denis Ciocca <denis.ciocca@st.com>");
 MODULE_DESCRIPTION("STMicroelectronics st_lsm6dsx i2c driver");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(IIO_LSM6DSX);
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c
index aaa6b29be3be..ecf592e4150b 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c
@@ -54,3 +54,4 @@ module_i3c_driver(st_lsm6dsx_driver);
 MODULE_AUTHOR("Vitor Soares <vitor.soares@synopsys.com>");
 MODULE_DESCRIPTION("STMicroelectronics st_lsm6dsx i3c driver");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(IIO_LSM6DSX);
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
index 6180110a1379..55e0f9c204ef 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
@@ -141,3 +141,4 @@ MODULE_AUTHOR("Lorenzo Bianconi <lorenzo.bianconi@st.com>");
 MODULE_AUTHOR("Denis Ciocca <denis.ciocca@st.com>");
 MODULE_DESCRIPTION("STMicroelectronics st_lsm6dsx spi driver");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(IIO_LSM6DSX);
-- 
2.35.1

