Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA2131258B
	for <lists+linux-iio@lfdr.de>; Sun,  7 Feb 2021 16:50:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbhBGPuO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 Feb 2021 10:50:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:34040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229646AbhBGPuK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 7 Feb 2021 10:50:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0851464E5C;
        Sun,  7 Feb 2021 15:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612712944;
        bh=ML9ja9AGVGmBbuz2rGGTZBYVZbEJbosGAawvpn9xyxY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vxp2kcuUDT7pJ80DXXsAj/mAyS7Ij7TpYEFdNgG9aPuEWmta32XzMWNz6aE0MlUdY
         PSMlqLSEsj4aszWwCCPavM9DsBKUUuBq49G0Hut2niv9cN+gYyrPP/dz6TuurBV9NU
         MPDkhS1/scYAj3tHljkIsyYZFUPRwarAl1Q3HsElhP6+Mye+FiVHn7MKz5/M1Df+z/
         Bp3GYi2hJvax6MDKdJzwbbehyv5UvcbD6FiWsrB90TEmjX1P8WxpfbzCMuLC+fNh0t
         ycewFxl0QakgsD0YUnAhbKnWga30cTY++zgw18APSaBCf7NLNEjekofNSh94w107xn
         szHK6f6K+8Uug==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        song.bao.hua@hisilicon.com, robh+dt@kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 14/24] staging:iio:cdc:ad7150: Reorganize headers.
Date:   Sun,  7 Feb 2021 15:46:13 +0000
Message-Id: <20210207154623.433442-15-jic23@kernel.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210207154623.433442-1-jic23@kernel.org>
References: <20210207154623.433442-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Whilst not important, it's nice to have the general headers in
alphabetical order.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/staging/iio/cdc/ad7150.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/cdc/ad7150.c b/drivers/staging/iio/cdc/ad7150.c
index 5d4783da7f98..9e88e774752f 100644
--- a/drivers/staging/iio/cdc/ad7150.c
+++ b/drivers/staging/iio/cdc/ad7150.c
@@ -6,13 +6,13 @@
  */
 
 #include <linux/bitfield.h>
-#include <linux/interrupt.h>
 #include <linux/device.h>
-#include <linux/kernel.h>
-#include <linux/slab.h>
-#include <linux/i2c.h>
+#include <linux/interrupt.h>
 #include <linux/irq.h>
+#include <linux/i2c.h>
+#include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/slab.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
-- 
2.30.0

