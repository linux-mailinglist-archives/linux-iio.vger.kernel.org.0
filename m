Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5DE4482B47
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jan 2022 13:52:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232380AbiABMwo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 2 Jan 2022 07:52:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbiABMwo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Jan 2022 07:52:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F841C061574
        for <linux-iio@vger.kernel.org>; Sun,  2 Jan 2022 04:52:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2068E60E98
        for <linux-iio@vger.kernel.org>; Sun,  2 Jan 2022 12:52:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28612C36AF0;
        Sun,  2 Jan 2022 12:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641127963;
        bh=OXH0/L9EFNfLVRZrQcq9nvs1DS+gwcC5JwTlBZPFF2w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sopTctIGec4JFzcteED9fzGs0caXqYj43oci3kxKzT5gUcfZJBcO0u0gVZOWJ3Wsb
         UnPK1CaqP5TRsagvArho8kg7a/RknXWQmIIjLg2r+lKKf69kaM8YJQqMshe+/cq+eg
         eop5/bm4IZ+ZnyATXpRG43H52qjXZc33gYSPMo1ADKSSiA1fnCQFZ7yejlQx6iL2zM
         J+0s205wr+zxW7FHVWklLpT7INnmQx5CgE1JGEGGK1vs2Hw8anWewAi8nzMC4p2wl2
         KbbGVtJ17dPkXMukFcRpImS3rh1KsQyjsn4SJ3vHw78g6UfEvP3ieqmmTVg3WcYDeh
         9XfN/HRk1/SzA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>
Subject: [PATCH v2 40/51] iio:proximity:pulsedlight: Switch from CONFIG_PM guards to pm_ptr() etc
Date:   Sun,  2 Jan 2022 12:56:06 +0000
Message-Id: <20220102125617.1259804-41-jic23@kernel.org>
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
without CONFIG_PM support is simpler and less error prone than the
use of #ifdef based config guards.

Removing instances of this approach from IIO also stops them being
copied into new drivers.

Acked-by: Matt Ranostay <matt.ranostay@konsulko.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/proximity/pulsedlight-lidar-lite-v2.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
index 27026c060ab9..648ae576d6fa 100644
--- a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
+++ b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
@@ -338,7 +338,6 @@ static const struct of_device_id lidar_dt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, lidar_dt_ids);
 
-#ifdef CONFIG_PM
 static int lidar_pm_runtime_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
@@ -358,18 +357,16 @@ static int lidar_pm_runtime_resume(struct device *dev)
 
 	return ret;
 }
-#endif
 
 static const struct dev_pm_ops lidar_pm_ops = {
-	SET_RUNTIME_PM_OPS(lidar_pm_runtime_suspend,
-			   lidar_pm_runtime_resume, NULL)
+	RUNTIME_PM_OPS(lidar_pm_runtime_suspend, lidar_pm_runtime_resume, NULL)
 };
 
 static struct i2c_driver lidar_driver = {
 	.driver = {
 		.name	= LIDAR_DRV_NAME,
 		.of_match_table	= lidar_dt_ids,
-		.pm	= &lidar_pm_ops,
+		.pm	= pm_ptr(&lidar_pm_ops),
 	},
 	.probe		= lidar_probe,
 	.remove		= lidar_remove,
-- 
2.34.1

