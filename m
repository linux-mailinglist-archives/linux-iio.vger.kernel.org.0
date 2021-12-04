Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8FE2468672
	for <lists+linux-iio@lfdr.de>; Sat,  4 Dec 2021 18:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355645AbhLDRL0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Dec 2021 12:11:26 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:58806 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355675AbhLDRLZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 4 Dec 2021 12:11:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0EC1060ECE
        for <linux-iio@vger.kernel.org>; Sat,  4 Dec 2021 17:08:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F344CC341C2;
        Sat,  4 Dec 2021 17:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638637679;
        bh=LtDlVUSDDvLN+P2JyQc1386x1mGPeB6e0c3FnrsA7TQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N6oI3PkiUiR6sN/bT8f+DpKtfe5vGw3cImDB/Hsnmrdvn19jhppwUsVZXEN0Y5ese
         i9HVK+NZ9llhumtg8s9yl+ccQJpihGPJY5iFLHT4c0UWPDwuNCVTWoLK8QIYV/iGEL
         ovd5uIhIoG0CPkKibUHpg/hbYVFYHllbvroA8pjWoKHLlDcJoREETb7k+aOiCTyp/Q
         b5XSgDAWL5RHTadVv6i0L9Xng94S1XC91W0Yxz/XbiUhItyzRGFOhCJky9GDYR2Wsd
         q+Qbr3XnnXiSNXzxvN+69rZ+yuzuDEoGaKqPy0/A99+uDFZfvrwD7qxCd0W0hYnL7d
         jPM4RcFIKfwBA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 11/12] iio:adc:ti-ads124s08: Drop dependency on OF.
Date:   Sat,  4 Dec 2021 17:12:36 +0000
Message-Id: <20211204171237.2769210-12-jic23@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211204171237.2769210-1-jic23@kernel.org>
References: <20211204171237.2769210-1-jic23@kernel.org>
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

