Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9330E4A38AF
	for <lists+linux-iio@lfdr.de>; Sun, 30 Jan 2022 20:27:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355973AbiA3T14 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 30 Jan 2022 14:27:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355976AbiA3T1Y (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Jan 2022 14:27:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1EFDC06173B
        for <linux-iio@vger.kernel.org>; Sun, 30 Jan 2022 11:27:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BB2A7B829A0
        for <linux-iio@vger.kernel.org>; Sun, 30 Jan 2022 19:27:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FE60C340F1;
        Sun, 30 Jan 2022 19:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643570839;
        bh=mblSDy2Bf1NsBDPqbR0pms5yQtYPtv8mCCOy3y8v+zc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M0/Gj2+WzF4spw30vsfAsP3jMaGdbIWZle6os5QgOCmIK53Lu+5401JRd3mGydNet
         dZMJQK+8GqDsQO7OCPmPLoiU7rWLnfyxqbofIg9R+SiMOt6vWIbYF7hpXUYRDLSks2
         CPGXymS7XS8BbJv6j+dLGZV15a3E1heCcFWPWl+rsIPb7/hj8rr+dZhGOSUi6D57/7
         fD9bU9rER+13O/fuhJwGyb1hedn7BsZx2rHpSwixdmvs5UeQGJHpkFvfZP06f1fwp/
         1l9DmWBPua0MOrkqVgUc5BrkiXT8SG9hwiK52i9Ua8o8WAm0yrOMU5DtsDWT0O7XL0
         8ul2rGUhW2xJw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>
Subject: [PATCH v3 47/50] iio:proximity:pulsedlight: Switch from CONFIG_PM guards to pm_ptr() etc
Date:   Sun, 30 Jan 2022 19:31:44 +0000
Message-Id: <20220130193147.279148-48-jic23@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220130193147.279148-1-jic23@kernel.org>
References: <20220130193147.279148-1-jic23@kernel.org>
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
2.35.1

