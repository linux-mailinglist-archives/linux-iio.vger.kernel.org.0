Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54D11468C3B
	for <lists+linux-iio@lfdr.de>; Sun,  5 Dec 2021 17:57:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236080AbhLERA1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Dec 2021 12:00:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236074AbhLERA0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 5 Dec 2021 12:00:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6099C061714
        for <linux-iio@vger.kernel.org>; Sun,  5 Dec 2021 08:56:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 568176110F
        for <linux-iio@vger.kernel.org>; Sun,  5 Dec 2021 16:56:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10B9FC341C5;
        Sun,  5 Dec 2021 16:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638723418;
        bh=vk/lsHRZySG2Er1cjeslS1V3JQmoJK2eW/Yz0duLaJs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GxxO3pi8tzjZZQmg/FjAJpvAKdthpJ/6BamkHHt9YpbxIrQaR1ZFXCC7byas9eZ/w
         wUH7elfimhhh3zzzlMc8y+aF12TULoYlSfkM+m2qvy/V88ua0viT3XvKfNsU3xYYL8
         CUECoXt2raXOi9MWpgna3kdgg+ctBExADGRmux71BjG3MZq9sc8z82oO0uVgHOo5tn
         uKroiBIrS5dmESYuqGfO+1+ZtRPVlVdnZimckDeBFk2UuCHjux+tklzI1I+x3AMWOE
         68FE+0Vr8qSQqm+1S+UsmuJ2wQnSW+6DDUawGhxZuG6iy7Z+5NH2xORHKRcnk5Jibw
         QWAsiItanSOfg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Peter Rosin <peda@axentia.se>
Subject: [PATCH v3 10/12] iio:adc:envelope-detector: Switch from of headers to mod_devicetable.h
Date:   Sun,  5 Dec 2021 17:01:38 +0000
Message-Id: <20211205170140.2783914-11-jic23@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211205170140.2783914-1-jic23@kernel.org>
References: <20211205170140.2783914-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

There is nothing directly using of specific interfaces in this driver,
so lets not include the headers.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: Peter Rosin <peda@axentia.se>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/iio/adc/envelope-detector.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/adc/envelope-detector.c b/drivers/iio/adc/envelope-detector.c
index d73eac36153f..e911c25d106d 100644
--- a/drivers/iio/adc/envelope-detector.c
+++ b/drivers/iio/adc/envelope-detector.c
@@ -31,14 +31,13 @@
 #include <linux/err.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/mutex.h>
 #include <linux/iio/consumer.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
-#include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/spinlock.h>
 #include <linux/workqueue.h>
-- 
2.34.1

