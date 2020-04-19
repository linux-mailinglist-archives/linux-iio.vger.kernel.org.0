Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAFD31AFB8B
	for <lists+linux-iio@lfdr.de>; Sun, 19 Apr 2020 17:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbgDSPEW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 19 Apr 2020 11:04:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:56296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726458AbgDSPEV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 19 Apr 2020 11:04:21 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E44E122202;
        Sun, 19 Apr 2020 15:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587308661;
        bh=6kA6GAzAh+GcRKffrDVz8+S9ooSxg8ZLDQ50os0l9Ps=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FYSSwZgeYYLxdlGlhuLwX1WGoLA2ZYG69m9rG3AnuJCgPzR+yF/mfBYryETKmrswC
         AyRKiHNgrzuAKb6ssl6QcDB/WScyXcY3GWKIbWsFwaZ3zCf1ccd23p9b56lzCGPllc
         VEP+4Q1ZtPLC2YUlo0TizkcbkLrOQDvkIwWSk3wc=
From:   jic23@kernel.org
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 3/7] iio: light: cm3232: Add mod_devicetable.h include and drop of_match_ptr
Date:   Sun, 19 Apr 2020 16:02:02 +0100
Message-Id: <20200419150206.43033-4-jic23@kernel.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200419150206.43033-1-jic23@kernel.org>
References: <20200419150206.43033-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Enables ACPI probing via PRP0001 and removes an example that might
be cut and paste to a new driver.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/light/cm3232.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/light/cm3232.c b/drivers/iio/light/cm3232.c
index cd3cfb7d02bd..867200825686 100644
--- a/drivers/iio/light/cm3232.c
+++ b/drivers/iio/light/cm3232.c
@@ -10,6 +10,7 @@
 
 #include <linux/i2c.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include <linux/init.h>
@@ -418,7 +419,7 @@ MODULE_DEVICE_TABLE(of, cm3232_of_match);
 static struct i2c_driver cm3232_driver = {
 	.driver = {
 		.name	= "cm3232",
-		.of_match_table = of_match_ptr(cm3232_of_match),
+		.of_match_table = cm3232_of_match,
 #ifdef CONFIG_PM_SLEEP
 		.pm	= &cm3232_pm_ops,
 #endif
-- 
2.26.1

