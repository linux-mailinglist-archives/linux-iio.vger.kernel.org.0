Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92F5D46095F
	for <lists+linux-iio@lfdr.de>; Sun, 28 Nov 2021 20:25:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238987AbhK1T2T (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 28 Nov 2021 14:28:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243536AbhK1T0O (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 28 Nov 2021 14:26:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE73C0613F9
        for <linux-iio@vger.kernel.org>; Sun, 28 Nov 2021 11:22:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A51D61047
        for <linux-iio@vger.kernel.org>; Sun, 28 Nov 2021 19:22:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAC71C004E1;
        Sun, 28 Nov 2021 19:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638127324;
        bh=LtDlVUSDDvLN+P2JyQc1386x1mGPeB6e0c3FnrsA7TQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F36gNKT6xJ8FwMv7tGD4iCdtOe3nYd+E+OnJ4ol6s2tDwJ3cKnoam72mjzhE7OG6J
         JQjfQJstTQmvDnKVoZng5ksP3vsSER6pA0o90mLhWIlTiSzSfJTTi2UWA4xH1osPAh
         Tky2kDiCGHHAyAtsffn8hbhdAGquAOhzG24WphEtmwTklUa9oAtNg1oZXvAmsy9ptx
         CtkymqQKukRshsF5ePeZbnQxeqaDEMRHf743bQ6zpETtkAl67D8u8CmvFhXpg4Ux7l
         c1arEp+TYeCgQfgMzzH6MzI0AnwvPc4UzfCMhbJzUXHEVMrMrHtxYrJocmKbkSA+y5
         BQDdbS43AXCjw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 11/12] iio:adc:ti-ads124s08: Drop dependency on OF.
Date:   Sun, 28 Nov 2021 19:26:34 +0000
Message-Id: <20211128192635.2724359-12-jic23@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211128192635.2724359-1-jic23@kernel.org>
References: <20211128192635.2724359-1-jic23@kernel.org>
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

