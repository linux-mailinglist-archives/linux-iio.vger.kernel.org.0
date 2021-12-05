Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59A2F468C3C
	for <lists+linux-iio@lfdr.de>; Sun,  5 Dec 2021 17:57:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236081AbhLERA2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Dec 2021 12:00:28 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:38146 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236074AbhLERA2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 5 Dec 2021 12:00:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 43A8E61115
        for <linux-iio@vger.kernel.org>; Sun,  5 Dec 2021 16:57:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67831C341C4;
        Sun,  5 Dec 2021 16:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638723420;
        bh=HGbGuowxETAg7lXTStsCmbJfdS9io80uosZB8kA8qak=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cwfs7qE4yxI5PQ2gpkWrtknZVxHafcMOGZ1WQ66vfU6IkVEm7StO37Q9klvxAUCec
         xwWz/O8EA0pSPRQdBNzh2wZTt/18yyW7C2k5eGSAqfQ85cbwgB39drv9CPBA1my1ZW
         npzvrxBSHj/acEXFy/uhF0imOvkQYubKwlIuMNCylIzJ9JC8NMR+34hN9XDQDBKW8h
         xN4AtS3qrenuEfLYS2PjZ1K5AHSPON1LLZWnCTRzy421oij4X8RFuUzaFqew9aKSPH
         cqEYpy33gi7AcEyGF0EaJV9dPOYCihrWRXm0Mu/EUJI230GF2iTT1rKEo05fE+uDhU
         slLwOwKsyuqFg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 11/12] iio:adc:ti-ads124s08: Drop dependency on OF.
Date:   Sun,  5 Dec 2021 17:01:39 +0000
Message-Id: <20211205170140.2783914-12-jic23@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211205170140.2783914-1-jic23@kernel.org>
References: <20211205170140.2783914-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Nothing in this driver depends on OF firmware so drop the dependency
and update the headers to remove the false impression such a dependency
exists.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/iio/adc/Kconfig        | 2 +-
 drivers/iio/adc/ti-ads124s08.c | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 8bf5b62a73f4..9b0b99bc826c 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1166,7 +1166,7 @@ config TI_ADS8688
 
 config TI_ADS124S08
 	tristate "Texas Instruments ADS124S08"
-	depends on SPI && OF
+	depends on SPI
 	help
 	  If you say yes here you get support for Texas Instruments ADS124S08
 	  and ADS124S06 ADC chips
diff --git a/drivers/iio/adc/ti-ads124s08.c b/drivers/iio/adc/ti-ads124s08.c
index 17d0da5877a9..767b3b634809 100644
--- a/drivers/iio/adc/ti-ads124s08.c
+++ b/drivers/iio/adc/ti-ads124s08.c
@@ -8,8 +8,7 @@
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/of.h>
-#include <linux/of_gpio.h>
+#include <linux/mod_devicetable.h>
 #include <linux/slab.h>
 #include <linux/sysfs.h>
 
-- 
2.34.1

