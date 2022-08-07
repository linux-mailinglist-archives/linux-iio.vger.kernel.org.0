Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5700658BC98
	for <lists+linux-iio@lfdr.de>; Sun,  7 Aug 2022 20:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbiHGSyB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 Aug 2022 14:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbiHGSyA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 7 Aug 2022 14:54:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC87E6381
        for <linux-iio@vger.kernel.org>; Sun,  7 Aug 2022 11:53:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 72FE561031
        for <linux-iio@vger.kernel.org>; Sun,  7 Aug 2022 18:53:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F335C433D6;
        Sun,  7 Aug 2022 18:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659898438;
        bh=NjZ01vuK1u+MajVjMoSBUz3LQysA9iShSjjV89sBx2o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cZHtZz1c4ZB1q823kyNyGutG9xbVutQe/Zgs8tFASzHuKGaPvvUf1ydIuDKOl/HK0
         3uAxJQQvfKYQqfDk9xj3LzbQ2L6z9pPM8P3TaxLqBA5YY+8S/ouO51ldfZhDDPSA/P
         5j7ZYmdgwP8tr7EK9Kd+COCYCt6RdIBM3to83n+Im8/ZkH9zRglz27tSW99qfpUn8q
         kDCy3SsMM/PrgyjhmiQlQtVBKz9J96m/Qmc6IN4oM9zcDEu4stOcfr6bWmaVfFxqyF
         CyfmuPBqaDzTY0jixeZeEIkZpbMMUrupk7GduYdFTuXScr1fsW+tKszPg9Gd5A5Xnt
         dec9mUFAwoH0w==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
        Crt Mori <cmo@melexis.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 2/2] iio: temp: mlx90632: Switch form UNVIVERSAL to DEFINE_RUNTIME_DEV_PM_OPS()
Date:   Sun,  7 Aug 2022 20:04:14 +0100
Message-Id: <20220807190414.1039028-3-jic23@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220807190414.1039028-1-jic23@kernel.org>
References: <20220807190414.1039028-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

The callbacks in this driver are simple and it doesn't matter if
they are unnecessarily called multiple times.  However, we might as
well not repeat the effort if the device is already suspended.
The new DEFINE_RUNTIME_DEV_PM_OPS() has the advantage that we don't
need to mark the callbacks __maybe_unused.  The compiler will still
remove them for us if CONFIG_PM is not set.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Crt Mori <cmo@melexis.com>
---
 drivers/iio/temperature/mlx90632.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/temperature/mlx90632.c b/drivers/iio/temperature/mlx90632.c
index 7ee7ff8047a4..9fc69d099784 100644
--- a/drivers/iio/temperature/mlx90632.c
+++ b/drivers/iio/temperature/mlx90632.c
@@ -952,7 +952,7 @@ static const struct of_device_id mlx90632_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, mlx90632_of_match);
 
-static int __maybe_unused mlx90632_pm_suspend(struct device *dev)
+static int mlx90632_pm_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
 	struct mlx90632_data *data = iio_priv(indio_dev);
@@ -960,7 +960,7 @@ static int __maybe_unused mlx90632_pm_suspend(struct device *dev)
 	return mlx90632_sleep(data);
 }
 
-static int __maybe_unused mlx90632_pm_resume(struct device *dev)
+static int mlx90632_pm_resume(struct device *dev)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
 	struct mlx90632_data *data = iio_priv(indio_dev);
@@ -968,14 +968,14 @@ static int __maybe_unused mlx90632_pm_resume(struct device *dev)
 	return mlx90632_wakeup(data);
 }
 
-static UNIVERSAL_DEV_PM_OPS(mlx90632_pm_ops, mlx90632_pm_suspend,
-			    mlx90632_pm_resume, NULL);
+static DEFINE_RUNTIME_DEV_PM_OPS(mlx90632_pm_ops, mlx90632_pm_suspend,
+				 mlx90632_pm_resume, NULL);
 
 static struct i2c_driver mlx90632_driver = {
 	.driver = {
 		.name	= "mlx90632",
 		.of_match_table = mlx90632_of_match,
-		.pm	= &mlx90632_pm_ops,
+		.pm	= pm_ptr(&mlx90632_pm_ops),
 	},
 	.probe = mlx90632_probe,
 	.remove = mlx90632_remove,
-- 
2.37.1

