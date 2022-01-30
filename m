Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE6684A38AA
	for <lists+linux-iio@lfdr.de>; Sun, 30 Jan 2022 20:27:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355942AbiA3T13 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 30 Jan 2022 14:27:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355963AbiA3T1J (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Jan 2022 14:27:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F92C061714
        for <linux-iio@vger.kernel.org>; Sun, 30 Jan 2022 11:27:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8DD0AB829A0
        for <linux-iio@vger.kernel.org>; Sun, 30 Jan 2022 19:27:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8AC4C340EB;
        Sun, 30 Jan 2022 19:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643570827;
        bh=7iRAGDYzZh09h2kvmp+uyhuvn/hNl7b8gogCScyy5R4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JF9T1ixKrlx4kIkBdlz/rAXh9zWuAl2XgAq0FCxV8asviNQwhzk2CzTOrMqdtM1RF
         LHdExmqsFY7ALiIWu2zPJKjACkAeOX7pDd0qhg3Cz33+/+AQRXP0SdYKnGJzKubJE7
         XguD5a/Yrjwo24E0cZCz91kOznx2/UgtIhPRzrqv5IZ7Sv1FrfRN17cCGZi45rAyTl
         qBDsLhlaOP0CGj6GGuViFpxRMX0rx+hWWsLKGBqfYEOpCPepwjIwHz3Dp+q1dY2zgF
         lS5icW4v25ZDrHuEo+ysUZbv6jWI5xrtJ/5hmuXHFIzFGzc2JBvdcb40afrIrM0rwn
         kCJhwFyHYAWjA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Crt Mori <cmo@melexis.com>
Subject: [PATCH v3 42/50] iio:temperature:mlx90614: Switch from CONFIG_PM* guards to pm_ptr() etc
Date:   Sun, 30 Jan 2022 19:31:39 +0000
Message-Id: <20220130193147.279148-43-jic23@kernel.org>
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
without one or  more of CONFIG_PM/CONFIG_PM_SLEEP support is simpler and
less error prone than the use of #ifdef based config guards.

Removing instances of this approach from IIO also stops them being
copied into new drivers.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Crt Mori <cmo@melexis.com>
---
 drivers/iio/temperature/mlx90614.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/temperature/mlx90614.c b/drivers/iio/temperature/mlx90614.c
index afcb10ea7c44..c253a5315988 100644
--- a/drivers/iio/temperature/mlx90614.c
+++ b/drivers/iio/temperature/mlx90614.c
@@ -600,7 +600,6 @@ static const struct of_device_id mlx90614_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, mlx90614_of_match);
 
-#ifdef CONFIG_PM_SLEEP
 static int mlx90614_pm_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
@@ -630,9 +629,7 @@ static int mlx90614_pm_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
-#ifdef CONFIG_PM
 static int mlx90614_pm_runtime_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
@@ -648,19 +645,18 @@ static int mlx90614_pm_runtime_resume(struct device *dev)
 
 	return mlx90614_wakeup(data);
 }
-#endif
 
 static const struct dev_pm_ops mlx90614_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(mlx90614_pm_suspend, mlx90614_pm_resume)
-	SET_RUNTIME_PM_OPS(mlx90614_pm_runtime_suspend,
-			   mlx90614_pm_runtime_resume, NULL)
+	SYSTEM_SLEEP_PM_OPS(mlx90614_pm_suspend, mlx90614_pm_resume)
+	RUNTIME_PM_OPS(mlx90614_pm_runtime_suspend,
+		       mlx90614_pm_runtime_resume, NULL)
 };
 
 static struct i2c_driver mlx90614_driver = {
 	.driver = {
 		.name	= "mlx90614",
 		.of_match_table = mlx90614_of_match,
-		.pm	= &mlx90614_pm_ops,
+		.pm	= pm_ptr(&mlx90614_pm_ops),
 	},
 	.probe = mlx90614_probe,
 	.remove = mlx90614_remove,
-- 
2.35.1

