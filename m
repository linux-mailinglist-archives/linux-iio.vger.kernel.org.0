Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 251A3468C33
	for <lists+linux-iio@lfdr.de>; Sun,  5 Dec 2021 17:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235260AbhLERAL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Dec 2021 12:00:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232577AbhLERAL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 5 Dec 2021 12:00:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB98C061714
        for <linux-iio@vger.kernel.org>; Sun,  5 Dec 2021 08:56:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 32D0CB80EC2
        for <linux-iio@vger.kernel.org>; Sun,  5 Dec 2021 16:56:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 245AFC00446;
        Sun,  5 Dec 2021 16:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638723400;
        bh=IpUlBRlSN/5tRTv+Gs1cfLmyqYuUnYvKW04V77uxmsg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZQT+zckDrHTsDptCpTl4D3bdvuaxPJ056bYQ/Sdf0tWLL4jG8nZnm9NT+I9ENZuZ3
         KlS/RRqAjzDNvrLRctw+slXd430bd/R3Fn+5sC8yMmsuqDNzX50uLIp6p80AYRnzEk
         ajA8TjJSAhZxk/CVATthwzRtJIXMrOPqL64v38GIQdfZSiVMkbW4q96SvSY+DAJdNv
         7Qg8/Ziin9zpzI+qDD09ytN9xaCqY8ZcFz8IAF5GE0LFiVdkVTJs8CucKb8UmcJ9E+
         NKEpjIplR8xlDaDnExQIo5w1V0wd+uFrzbpOQYuaXFoJil5KcoPdNVs5xMkmVqc026
         bgmCL43ynO/2g==
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Daniel Gomez <dagmcr@gmail.com>
Subject: [PATCH v3 02/12] iio:dac:ad5758: Drop unused of specific headers.
Date:   Sun,  5 Dec 2021 17:01:30 +0000
Message-Id: <20211205170140.2783914-3-jic23@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211205170140.2783914-1-jic23@kernel.org>
References: <20211205170140.2783914-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

These have never been used in this driver.  What is used is in
mod_devicetable.h so add that include (struct of_device_id)

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Daniel Gomez <dagmcr@gmail.com>
---
 drivers/iio/dac/ad5758.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/dac/ad5758.c b/drivers/iio/dac/ad5758.c
index 0572ef518101..98771e37a7b5 100644
--- a/drivers/iio/dac/ad5758.c
+++ b/drivers/iio/dac/ad5758.c
@@ -10,9 +10,8 @@
 #include <linux/delay.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/property.h>
-#include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/spi/spi.h>
 #include <linux/gpio/consumer.h>
 
-- 
2.34.1

