Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 485963A4793
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jun 2021 19:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbhFKROZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Jun 2021 13:14:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:60632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230197AbhFKROV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 11 Jun 2021 13:14:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5AD75613DF;
        Fri, 11 Jun 2021 17:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623431542;
        bh=TMHig0zfQ8l4RDIfHSpnRxTAbEZykscqYHKS1vo2A0Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T7eAAb5dzASOHfvK8W2ZcA4p0bfLcdv5EE+XAU6iXEYXOyvyUPz7957hxmdhpnWjm
         teoKbUme53mMkmRvUZ7ba8QKQIzPEOBfnm9wytNDYgIH/VlzhHPYZFoBqeK07qL6oG
         iSqmEGgOf133E0k/IM20zE7eTGTY6StzXbGJcKd9+B/GZf1unkx3+cYdebvzn4nlAW
         vMIvNTMXi3ZhDo8A/7l6e8/BivNI+/Y/z+6mbGLoDfF6dbYEfXUuGAb5wI88K3auP0
         h45d/eiugdQg9r/N65c+ljJfwSSHVV60/U7RKDWvQShYNDEhBAVLrs7NTY2WRzzctI
         3Y/Q/Wq5hkPgw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 10/12] iio:accel:memsic drivers: Cleanup includes
Date:   Fri, 11 Jun 2021 18:13:52 +0100
Message-Id: <20210611171355.202903-11-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210611171355.202903-1-jic23@kernel.org>
References: <20210611171355.202903-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Based on consideration of the output of the include-what-you-use tool.
Mixture of removing unused headers and adding includes for some of those
directly used in these files.

There are no hard rules on when to include a header and when to assume
it is included by another one.  This is an attempt to be more consistent
in IIO on that choice.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/accel/mxc4005.c | 4 ++++
 drivers/iio/accel/mxc6255.c | 5 ++---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/mxc4005.c b/drivers/iio/accel/mxc4005.c
index b3afbf064915..2f4c9bdbfc9e 100644
--- a/drivers/iio/accel/mxc4005.c
+++ b/drivers/iio/accel/mxc4005.c
@@ -9,6 +9,10 @@
 #include <linux/i2c.h>
 #include <linux/iio/iio.h>
 #include <linux/acpi.h>
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
+#include <linux/mutex.h>
 #include <linux/regmap.h>
 #include <linux/iio/sysfs.h>
 #include <linux/iio/trigger.h>
diff --git a/drivers/iio/accel/mxc6255.c b/drivers/iio/accel/mxc6255.c
index 9aeeadc420d3..9ab0c66636a7 100644
--- a/drivers/iio/accel/mxc6255.c
+++ b/drivers/iio/accel/mxc6255.c
@@ -8,13 +8,12 @@
  */
 
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/i2c.h>
-#include <linux/init.h>
 #include <linux/iio/iio.h>
-#include <linux/delay.h>
+#include <linux/kernel.h>
 #include <linux/acpi.h>
 #include <linux/regmap.h>
-#include <linux/iio/sysfs.h>
 
 #define MXC6255_DRV_NAME		"mxc6255"
 #define MXC6255_REGMAP_NAME		"mxc6255_regmap"
-- 
2.31.1

