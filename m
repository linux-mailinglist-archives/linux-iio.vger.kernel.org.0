Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 042943A478A
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jun 2021 19:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbhFKROK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Jun 2021 13:14:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:60530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231490AbhFKROJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 11 Jun 2021 13:14:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E2A2F613D0;
        Fri, 11 Jun 2021 17:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623431531;
        bh=TPqFEd2IN1Da5sF1EtgEHgRRtvpoNF7ySi5QwPoy340=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qrTS+X30E6yIpfATRkmIc9qodHvBwvvFirlTH7TeWyVyfkBbHvA4/dus4mrzjKT+q
         OzEWdt62O2kMdlKQJ9GOYWGYepT+5jZ+DrBeU3IlsWF1tn80Yv4eNDLGrLEoA6uh3D
         Lc5hmpxosVLrkJtvyJzWS5qNkE+Ye7cemyPDpFi3ipAc6HcghyZ2klfvZhgWKAF85E
         RaZBOUHWhVriXvQs1qKhwk/6ST8vUJf3yeK2PaoNgh3YhTyw64PwQJvWq+j/+iTjDH
         fzt/muRlCgxVJ2qaBn+PBt2sOOZ6fVD0MBCdWqMykcIPER3b89xpktAxeT1q/WkIo5
         jXvR8gaIKAydQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: [PATCH 01/12] iio:accel:adxl372: Cleanup includes
Date:   Fri, 11 Jun 2021 18:13:43 +0100
Message-Id: <20210611171355.202903-2-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210611171355.202903-1-jic23@kernel.org>
References: <20210611171355.202903-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Based on consideration of the output of include-what-you-use.
Drop some unused headers and include others that should probably be
there based on direct use.  Also a few forward definitions to avoid
any potential future include ordering issues.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>
---
 drivers/iio/accel/adxl372.c     | 4 ++--
 drivers/iio/accel/adxl372.h     | 2 ++
 drivers/iio/accel/adxl372_spi.c | 3 +--
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
index fc9592407717..c679cb9f3ed1 100644
--- a/drivers/iio/accel/adxl372.c
+++ b/drivers/iio/accel/adxl372.c
@@ -6,12 +6,12 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/bitmap.h>
 #include <linux/bitops.h>
 #include <linux/interrupt.h>
-#include <linux/irq.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/regmap.h>
-#include <linux/spi/spi.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
diff --git a/drivers/iio/accel/adxl372.h b/drivers/iio/accel/adxl372.h
index 80a0aa9714fc..86bf8955d60c 100644
--- a/drivers/iio/accel/adxl372.h
+++ b/drivers/iio/accel/adxl372.h
@@ -9,6 +9,8 @@
 #define _ADXL372_H_
 
 #define ADXL372_REVID	0x03
+struct device;
+struct regmap;
 
 int adxl372_probe(struct device *dev, struct regmap *regmap,
 		  int irq, const char *name);
diff --git a/drivers/iio/accel/adxl372_spi.c b/drivers/iio/accel/adxl372_spi.c
index 1f1352fee99a..927379f9b497 100644
--- a/drivers/iio/accel/adxl372_spi.c
+++ b/drivers/iio/accel/adxl372_spi.c
@@ -6,9 +6,8 @@
  */
 
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/regmap.h>
-#include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/spi/spi.h>
 
 #include "adxl372.h"
-- 
2.31.1

