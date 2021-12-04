Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDC3C46866D
	for <lists+linux-iio@lfdr.de>; Sat,  4 Dec 2021 18:07:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355591AbhLDRLN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Dec 2021 12:11:13 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:58700 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355598AbhLDRLN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 4 Dec 2021 12:11:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 60F6760ECF
        for <linux-iio@vger.kernel.org>; Sat,  4 Dec 2021 17:07:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0C3AC341C0;
        Sat,  4 Dec 2021 17:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638637666;
        bh=Dj1AW6TONaV/z4cDutreB2d9371lGFX2Rys1xOOoXDw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=txSg4b/axr7nP+K6LQZLoOXI8Hdk7xqPeqIM1yi56KjMHS6O5LC+CHC7V9V/nXCSw
         URRwsSWH+aYA99OMOc4+42jwb7v3xv/who0O5aL20KL42uq5wA3b9IiJMJC7gPuKXu
         FzeVIIGfZWd5NbCRKMA1+HeLj5MjzyjNMCKUb1iEGpFUrlQBFZBQHRdn2tKJySve8O
         mZaAdLWlJkrg2RuimF9hiEmo2DEbfpAxRzKI4a2pvqfNl0twhvdn00wYFhhNRuWPCx
         U5jt1hI/kq0MXgNmcaHLIFTbGB+LtG0PSv+rjnuMQxSram0FqGBrUOaHKhqGNnyvyG
         mBhWWMiKE+Kog==
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v2 06/12] iio:light:cm3605: Switch to generic firmware properties.
Date:   Sat,  4 Dec 2021 17:12:31 +0000
Message-Id: <20211204171237.2769210-7-jic23@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211204171237.2769210-1-jic23@kernel.org>
References: <20211204171237.2769210-1-jic23@kernel.org>
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

