Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B52763A44E1
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jun 2021 17:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbhFKP0d (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Jun 2021 11:26:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:58698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231732AbhFKP03 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 11 Jun 2021 11:26:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B4CF661403;
        Fri, 11 Jun 2021 15:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623425071;
        bh=dMk1apYHGU35BIbC57L7mRT5u/LZgR2A9rwZfev9o4c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iaOSx14J1UTNIR8WI92204WqNxv48iYVgxN92+j3G5Pe0nBWoUHEq++fGCedjTUyx
         JrP9yLmUgGv6RRJKFoIyky2WtuO1IYzSczFI99JPMV0ANo0yVOEnQU8sHq+BkN9S7x
         32R+mGuouA1YhqZEXGMA8GypHI8nlTm2jmY/5SFio/81Hp4inVzinMgeLUaE3fR0hn
         mpQxZ4Iv8Cp8NaRsSr2gDht/WvMYANzz1+Rryy786fCogpBePa5rtIV3vht6SsJTKl
         3FBfGDYeDpQ/0MRKZ7hXtzsPxZYRypljOBa10d3LBNXVw1Fz/ZzrJLyGVU37Vt4A7A
         EeP6ifnu/mBZw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Nuno Sa <Nuno.Sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 4/7] staging:iio:frequency: Cleanup includes
Date:   Fri, 11 Jun 2021 16:26:11 +0100
Message-Id: <20210611152614.109361-5-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210611152614.109361-1-jic23@kernel.org>
References: <20210611152614.109361-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Based on consideration of the output of the include-what-you-use
tool.  Remove some unused headers and add some that should be
directly included.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/staging/iio/frequency/ad9832.c | 3 ++-
 drivers/staging/iio/frequency/ad9834.c | 6 ++----
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
index 3f1981e287f5..2d78072ff4c3 100644
--- a/drivers/staging/iio/frequency/ad9832.c
+++ b/drivers/staging/iio/frequency/ad9832.c
@@ -12,8 +12,9 @@
 #include <linux/err.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/mutex.h>
 #include <linux/regulator/consumer.h>
-#include <linux/slab.h>
 #include <linux/spi/spi.h>
 #include <linux/sysfs.h>
 
diff --git a/drivers/staging/iio/frequency/ad9834.c b/drivers/staging/iio/frequency/ad9834.c
index 94b131ef8a22..c163e91c1bc4 100644
--- a/drivers/staging/iio/frequency/ad9834.c
+++ b/drivers/staging/iio/frequency/ad9834.c
@@ -6,17 +6,15 @@
  */
 
 #include <linux/clk.h>
-#include <linux/interrupt.h>
-#include <linux/workqueue.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
-#include <linux/slab.h>
 #include <linux/sysfs.h>
-#include <linux/list.h>
 #include <linux/spi/spi.h>
 #include <linux/regulator/consumer.h>
 #include <linux/err.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/mutex.h>
 #include <asm/div64.h>
 
 #include <linux/iio/iio.h>
-- 
2.31.1

