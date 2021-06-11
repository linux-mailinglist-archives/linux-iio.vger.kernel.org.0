Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 326333A43F8
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jun 2021 16:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbhFKOXN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Jun 2021 10:23:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:48634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231180AbhFKOXN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 11 Jun 2021 10:23:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6A54361249;
        Fri, 11 Jun 2021 14:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623421275;
        bh=OeF3ldj+rUhKR2/T5fYFD/rp/bRkG3K2w1Q0z1uPw8Q=;
        h=From:To:Cc:Subject:Date:From;
        b=OupZiZHZOId/g4+K73sUSaOJfqKsMyb5rZ/DRQaaI6tDAdDNo0oCiqCtZM4pzSi92
         Dr6D9p6jvtgOW3QhIguBWdgmKBT7UBwRN9XKgtx5UV6bSuq4M04NO+wjDrAry5je9h
         fl0rsjxky2TmaMiH5LqnMTHczRR87ZLsXfr/WLBd4MSDhE6G8ylNWf0uoFYbfze0fW
         z1bEojQWQQ+x3iIC7zswkDH2v5UiTw98Vt4SeRBwkjR4H5nqXT6aoQnCs23OTMEX7F
         h1Dxe5jqmSO91Ha0JRifN8hxKHhUz6PhbZlslIIKKiQAiShWbjC+uILinLnmClclBL
         5Q7OgyvzPv9LA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] hwmon: (ntc_thermistor) Drop unused headers.
Date:   Fri, 11 Jun 2021 15:22:57 +0100
Message-Id: <20210611142257.103094-1-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

The IIO usage in this driver is purely consumer so it should only
be including linux/iio/consumer.h  Whilst here drop pm_runtime.h
as there is no runtime power management in the driver.

Found using include-what-you-use and manual inspection of the
suggestions.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/ntc_thermistor.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/hwmon/ntc_thermistor.c b/drivers/hwmon/ntc_thermistor.c
index 8587189c7f15..18fd6f12ca16 100644
--- a/drivers/hwmon/ntc_thermistor.c
+++ b/drivers/hwmon/ntc_thermistor.c
@@ -8,7 +8,6 @@
 
 #include <linux/slab.h>
 #include <linux/module.h>
-#include <linux/pm_runtime.h>
 #include <linux/math64.h>
 #include <linux/platform_device.h>
 #include <linux/err.h>
@@ -17,9 +16,6 @@
 
 #include <linux/platform_data/ntc_thermistor.h>
 
-#include <linux/iio/iio.h>
-#include <linux/iio/machine.h>
-#include <linux/iio/driver.h>
 #include <linux/iio/consumer.h>
 
 #include <linux/hwmon.h>
-- 
2.31.1

