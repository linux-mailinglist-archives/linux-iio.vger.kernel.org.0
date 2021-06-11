Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 879E63A44DE
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jun 2021 17:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbhFKP0b (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Jun 2021 11:26:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:58626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231694AbhFKP0Y (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 11 Jun 2021 11:26:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E173B613FA;
        Fri, 11 Jun 2021 15:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623425066;
        bh=FBJKy5tann1grvl0yu2wQXYgMfNnyiJwMR2/bOESKWA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bAwktObW2fCA50iLbgk2UcalfzsIUH8kd6ISuGkQZnFtujvTMNuI3duF4UaUguvvg
         24TWeZ8MrKnuLcQjF9vcoT0fjLHNAPr+bb36cj0TAAtAX+q6ymGj7FpIKt/53QzI/n
         QDYejhc2BXGu3xua5gD1d5TK91gaFrxnxFQVEtijymF/4R39E9Y0FgW0v4sEG4XMc8
         644A6UbKv+jIne54Fa6m6kMSEfstG9LYY+C4lRHYZBYgFsXqa1XaSzfg/Yb75kUYNb
         YoTDNnYjiLpgmiNNFDNb4GcrRjmFagY+5bCSvW1GhWdJEKGyjmRrvT1osfOZb8IcpY
         dbqCRy9Lm0OLg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Nuno Sa <Nuno.Sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 2/7] staging:iio:addac:adt7316: Cleanup includes
Date:   Fri, 11 Jun 2021 16:26:09 +0100
Message-Id: <20210611152614.109361-3-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210611152614.109361-1-jic23@kernel.org>
References: <20210611152614.109361-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Result of consideration of the output of the include-what-you-use
tool.  Also a forwards definition of device to avoid any
ordering of headers issues.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/staging/iio/addac/adt7316.c | 5 -----
 drivers/staging/iio/addac/adt7316.h | 1 +
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
index ccbafcaaf27e..e81791ee182f 100644
--- a/drivers/staging/iio/addac/adt7316.c
+++ b/drivers/staging/iio/addac/adt7316.c
@@ -8,14 +8,9 @@
 #include <linux/interrupt.h>
 #include <linux/gpio/consumer.h>
 #include <linux/irq.h>
-#include <linux/workqueue.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
-#include <linux/slab.h>
 #include <linux/sysfs.h>
-#include <linux/list.h>
-#include <linux/i2c.h>
-#include <linux/rtc.h>
 #include <linux/module.h>
 
 #include <linux/iio/iio.h>
diff --git a/drivers/staging/iio/addac/adt7316.h b/drivers/staging/iio/addac/adt7316.h
index 8c2a92ae7157..a1f6324ead59 100644
--- a/drivers/staging/iio/addac/adt7316.h
+++ b/drivers/staging/iio/addac/adt7316.h
@@ -10,6 +10,7 @@
 
 #include <linux/types.h>
 #include <linux/pm.h>
+struct device;
 
 #define ADT7316_REG_MAX_ADDR		0x3F
 
-- 
2.31.1

