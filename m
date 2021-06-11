Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2133A44DA
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jun 2021 17:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbhFKP0W (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Jun 2021 11:26:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:58600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229517AbhFKP0W (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 11 Jun 2021 11:26:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1D530613F9;
        Fri, 11 Jun 2021 15:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623425064;
        bh=u2VUhnSE2tkqul+DuCqGlYUrEMmTfLbRTxtgNTdZHQg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nU2TrBjCKSqt62sWDHjPhxJXavUMSik+eXB7YSWyY1p1rqpTYQjLLqXdAs2oMq40R
         7tmuVubw6ATLcmHVw9p7OjErTxBFY3nloXCalspsVWfTQdk9fxPq5yP2uQnsn+lgBG
         eH1kfVLcv8UkZ1Y6PL4WGda9KjA0HzmT83Pm713TbWhgz0NzcYxU1+kxEiqbaMG5x4
         ez+fYY8mUyRrAUYjZ4hyf93t17ZZr/rP3kwUPtQt6DPAnzoVhC21z4GJnzFmq3nuxY
         uzyHqufhdd2kdJ2vUbmMikBfP4YQnj1g26RHitFz69WtG8Hp9S4yQtGXhjI63o/BIy
         QZ9ncggRtReGQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Nuno Sa <Nuno.Sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 1/7] staging:iio:adc: Cleanup includes
Date:   Fri, 11 Jun 2021 16:26:08 +0100
Message-Id: <20210611152614.109361-2-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210611152614.109361-1-jic23@kernel.org>
References: <20210611152614.109361-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Result of considering the output of the include-what-you-use tool.
Note that this is partly a case of taste and consistency.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/staging/iio/adc/ad7280a.c | 2 ++
 drivers/staging/iio/adc/ad7816.c  | 3 +--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
index fef0055b8990..135fdf33c655 100644
--- a/drivers/staging/iio/adc/ad7280a.c
+++ b/drivers/staging/iio/adc/ad7280a.c
@@ -15,6 +15,8 @@
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/mutex.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
index 6c14d7bcdd67..0d943f99383b 100644
--- a/drivers/staging/iio/adc/ad7816.c
+++ b/drivers/staging/iio/adc/ad7816.c
@@ -9,11 +9,10 @@
 #include <linux/gpio/consumer.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
-#include <linux/slab.h>
 #include <linux/sysfs.h>
-#include <linux/list.h>
 #include <linux/spi/spi.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
-- 
2.31.1

