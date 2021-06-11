Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C251A3A44E4
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jun 2021 17:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbhFKP0g (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Jun 2021 11:26:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:58730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231703AbhFKP0d (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 11 Jun 2021 11:26:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 801F2613DE;
        Fri, 11 Jun 2021 15:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623425075;
        bh=o0xTMTs7ajCTG24cib5RhjG0E4dUOUFj+VxMI8s/Ydo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EUEJDwNCjpl9s3/amDZaq/KE7iGyrMyS5rByrdp1vJX4YvppxIRmq5584w0w7Wm+D
         GQsI1z6YM39uhhPG+Fvnnlsjtf5hzFwj7DdiJ3AlLVKMYRDvh6RK9SuyK04j4RSlI6
         P7RNk1GchWp2y85lRmDHniwDVdT2BKq11glQA/vKRcgLGfajwika9SHx3FFbCm/B6L
         VFayYD2cAnC+jTRCxB0Ii0vZPweSdwFVzA1mQ0ligFStm6ganX4HGR5BlUDiI1Lm19
         HNMeV6PeC3NykulimdKW+NZYiLaIMU1R2Pwwwb9DFmdBRUemw5T0DbAo/1UbaHQxAN
         wstFPzkU3lTQg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Nuno Sa <Nuno.Sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6/7] staging:iio:meter:ade7854: Cleanup includes
Date:   Fri, 11 Jun 2021 16:26:13 +0100
Message-Id: <20210611152614.109361-7-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210611152614.109361-1-jic23@kernel.org>
References: <20210611152614.109361-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Based on consideration of the output of the include-what-you-use tool.
Drop some unused headers and some that should probably have always
been included.  Also a few forwards definitions to avoid any
future issues with header ordering.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/staging/iio/meter/ade7854-i2c.c | 3 ++-
 drivers/staging/iio/meter/ade7854-spi.c | 3 ++-
 drivers/staging/iio/meter/ade7854.c     | 4 ----
 drivers/staging/iio/meter/ade7854.h     | 5 +++++
 4 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/iio/meter/ade7854-i2c.c b/drivers/staging/iio/meter/ade7854-i2c.c
index a9a06e8dda51..c6b3e1418c84 100644
--- a/drivers/staging/iio/meter/ade7854-i2c.c
+++ b/drivers/staging/iio/meter/ade7854-i2c.c
@@ -8,8 +8,9 @@
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/i2c.h>
-#include <linux/slab.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/mutex.h>
 
 #include <linux/iio/iio.h>
 #include "ade7854.h"
diff --git a/drivers/staging/iio/meter/ade7854-spi.c b/drivers/staging/iio/meter/ade7854-spi.c
index f12a6c8b3e88..7ba7dc4cdbc9 100644
--- a/drivers/staging/iio/meter/ade7854-spi.c
+++ b/drivers/staging/iio/meter/ade7854-spi.c
@@ -8,8 +8,9 @@
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/spi/spi.h>
-#include <linux/slab.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/mutex.h>
 
 #include <linux/iio/iio.h>
 #include "ade7854.h"
diff --git a/drivers/staging/iio/meter/ade7854.c b/drivers/staging/iio/meter/ade7854.c
index 68da6ecde6a3..68a5e9c6b047 100644
--- a/drivers/staging/iio/meter/ade7854.c
+++ b/drivers/staging/iio/meter/ade7854.c
@@ -5,15 +5,11 @@
  * Copyright 2010 Analog Devices Inc.
  */
 
-#include <linux/interrupt.h>
-#include <linux/irq.h>
 #include <linux/delay.h>
 #include <linux/mutex.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
-#include <linux/slab.h>
 #include <linux/sysfs.h>
-#include <linux/list.h>
 #include <linux/module.h>
 
 #include <linux/iio/iio.h>
diff --git a/drivers/staging/iio/meter/ade7854.h b/drivers/staging/iio/meter/ade7854.h
index a51e6e3183d3..620d3d075f95 100644
--- a/drivers/staging/iio/meter/ade7854.h
+++ b/drivers/staging/iio/meter/ade7854.h
@@ -1,4 +1,9 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+
+#include <linux/mutex.h>
+struct device;
+struct iio_device;
+
 #ifndef _ADE7854_H
 #define _ADE7854_H
 
-- 
2.31.1

