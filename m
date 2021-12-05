Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFADA468C37
	for <lists+linux-iio@lfdr.de>; Sun,  5 Dec 2021 17:56:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236066AbhLERAT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Dec 2021 12:00:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236067AbhLERAT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 5 Dec 2021 12:00:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A1FC061714
        for <linux-iio@vger.kernel.org>; Sun,  5 Dec 2021 08:56:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 188A9B80EC5
        for <linux-iio@vger.kernel.org>; Sun,  5 Dec 2021 16:56:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27672C341C4;
        Sun,  5 Dec 2021 16:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638723409;
        bh=n9lYMQHCTEtNKT22I4DaeXQVUqNE+hzf0ykgHVTDuss=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q5Qa63PHVfg0bVCRHlVa9C65KXgTAH4jfMkBe7eb4fEHLh5zPLHUAbm7UNmWPNSOQ
         usX/3JfXk08zDCefysGdNBg5DzDOWPM3l1WiIbrwgWdZSqJfiNfG244EkYVWCPka5B
         XM/VQacpj6f+/W5fq9ebgF9FxzG8F5kNa+EsCsXZ8Hc+NyK7eJEfnc1S83KZ0iR/yY
         uPlmmjrlAjR/RzjBso+TbAyq5aTUn9SPM587k5BEPBsiTsju+OSRVPqj+2uPUmcrBG
         tv2fOAh8WKiqdv9n+jcI+busUHZ3b5VuP/csatsjEQkZgvUvemMpuSrxaCWIwtZ/Tp
         rGlpxFI2DA7Hw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v3 06/12] iio:light:cm3605: Switch to generic firmware properties.
Date:   Sun,  5 Dec 2021 17:01:34 +0000
Message-Id: <20211205170140.2783914-7-jic23@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211205170140.2783914-1-jic23@kernel.org>
References: <20211205170140.2783914-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This enables use of other firmware types with minimal driver changes.
Part of an ongoing effort to move all IIO drivers over to generic
accessors in order to reduce the chance of of_* versions being
copied into new drivers.  Also updated the headers to reflect this change
including using mod_devicetable.h for struct of_device_id definition
rather than going via of.h

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/iio/light/cm3605.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/light/cm3605.c b/drivers/iio/light/cm3605.c
index 3e7fb16ab1f6..50d34a98839c 100644
--- a/drivers/iio/light/cm3605.c
+++ b/drivers/iio/light/cm3605.c
@@ -10,6 +10,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include <linux/iio/events.h>
@@ -18,7 +19,7 @@
 #include <linux/init.h>
 #include <linux/leds.h>
 #include <linux/platform_device.h>
-#include <linux/of.h>
+#include <linux/property.h>
 #include <linux/regulator/consumer.h>
 #include <linux/gpio/consumer.h>
 #include <linux/interrupt.h>
@@ -156,7 +157,6 @@ static int cm3605_probe(struct platform_device *pdev)
 	struct cm3605 *cm3605;
 	struct iio_dev *indio_dev;
 	struct device *dev = &pdev->dev;
-	struct device_node *np = dev->of_node;
 	enum iio_chan_type ch_type;
 	u32 rset;
 	int irq;
@@ -171,7 +171,7 @@ static int cm3605_probe(struct platform_device *pdev)
 	cm3605->dev = dev;
 	cm3605->dir = IIO_EV_DIR_FALLING;
 
-	ret = of_property_read_u32(np, "capella,aset-resistance-ohms", &rset);
+	ret = device_property_read_u32(dev, "capella,aset-resistance-ohms", &rset);
 	if (ret) {
 		dev_info(dev, "no RSET specified, assuming 100K\n");
 		rset = 100000;
-- 
2.34.1

