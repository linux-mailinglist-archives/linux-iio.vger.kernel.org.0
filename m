Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3C9482B4A
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jan 2022 13:52:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232383AbiABMwx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 2 Jan 2022 07:52:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbiABMwx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Jan 2022 07:52:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39DFEC061574
        for <linux-iio@vger.kernel.org>; Sun,  2 Jan 2022 04:52:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CCCB060E9A
        for <linux-iio@vger.kernel.org>; Sun,  2 Jan 2022 12:52:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 107EAC36AE7;
        Sun,  2 Jan 2022 12:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641127972;
        bh=xfezNELutGTcG0K7t65QpD6LYBCoR8xNK/wZfk4v2g8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J6+GD1A78BbKg0XgS55Fa9iyOIQ2NKqDDkAFSI4aBDwnB1HHOJROmDTzsI6rV1TvC
         8ge/uh/scOY9mWboole54ecD3sqt662jJgquXNoCCf8vsOfsx8Tn740toVE/yYTSyV
         QGC0pQVlbkzAV9KDWu7hvBqMc9N6EKIRRLOmF4/bLabBUhXMyb6aKAyE2ZpTGgir7L
         8D5N9lzGi2Rzs45549ZHGRzxr8XLNCZuBeSjkdYQ2kglpgBIir2Yy7jKGKisRCy7CL
         EvsX9ku3Yh8CCN+A2bHrf5Q4d+xLzw781F0mtJxNU4iUFbBSR+yVhLWoe6qOaFXOi4
         u8f3OP2Q9GP1Q==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 43/51] iio:temperature:tmp006: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr() etc
Date:   Sun,  2 Jan 2022 12:56:09 +0000
Message-Id: <20220102125617.1259804-44-jic23@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220102125617.1259804-1-jic23@kernel.org>
References: <20220102125617.1259804-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Letting the compiler remove these functions when the kernel is built
without CONFIG_PM_SLEEP support is simpler and less error prone than the
use of #ifdef based config guards.

Removing instances of this approach from IIO also stops them being
copied into new drivers.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/temperature/tmp006.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/temperature/tmp006.c b/drivers/iio/temperature/tmp006.c
index e4943a0bc9aa..bb72df22d63b 100644
--- a/drivers/iio/temperature/tmp006.c
+++ b/drivers/iio/temperature/tmp006.c
@@ -261,7 +261,6 @@ static int tmp006_probe(struct i2c_client *client,
 	return devm_iio_device_register(&client->dev, indio_dev);
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int tmp006_suspend(struct device *dev)
 {
 	return tmp006_power(dev, false);
@@ -271,9 +270,8 @@ static int tmp006_resume(struct device *dev)
 {
 	return tmp006_power(dev, true);
 }
-#endif
 
-static SIMPLE_DEV_PM_OPS(tmp006_pm_ops, tmp006_suspend, tmp006_resume);
+DEFINE_SIMPLE_DEV_PM_OPS(tmp006_pm_ops, tmp006_suspend, tmp006_resume);
 
 static const struct i2c_device_id tmp006_id[] = {
 	{ "tmp006", 0 },
@@ -284,7 +282,7 @@ MODULE_DEVICE_TABLE(i2c, tmp006_id);
 static struct i2c_driver tmp006_driver = {
 	.driver = {
 		.name	= "tmp006",
-		.pm	= &tmp006_pm_ops,
+		.pm	= pm_sleep_ptr(&tmp006_pm_ops),
 	},
 	.probe = tmp006_probe,
 	.id_table = tmp006_id,
-- 
2.34.1

