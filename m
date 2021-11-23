Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4927745ADF4
	for <lists+linux-iio@lfdr.de>; Tue, 23 Nov 2021 22:06:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239375AbhKWVJu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 23 Nov 2021 16:09:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:40222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239320AbhKWVJu (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 23 Nov 2021 16:09:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0EC9760FD8;
        Tue, 23 Nov 2021 21:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637701601;
        bh=+kapT8P3GFioNL9o3AIdbCoPNFvmZuVlJvgQMZnwYVg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V/d5q4H+7rKNteZ26yQO09yN4PJafNTSoKlG+LKughIy1Qq9lPnzHfFZ0MIOVVN2p
         kdSOixJ+U4zq6M5pppKdVrTxfc2HvZyuQvfsOX+sHLGvHF2By2zWK7u/BeBpOMbL8L
         fQv6JSPL8E3M8NkXNtqkaqtRDTS//eoevdWYOHMsSmul1rENzrW0a6qXrbqbLKkNPc
         +/QLZ2YuNDv8lmad3wFlbuc5FGeTeVahj+3t6TB7zAdhQ5PHg6ufmq24fOPEBVPHWD
         BzkZv/KdG8p6ixjbR66CMLDzo6ktA8+UEnhjqE1zSovF0QDE2x+2O0TRPhO4+lR9gB
         mEY7zs3nQd40g==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Anson Huang <anson.huang@nxp.com>,
        Brian Masney <masneyb@onstation.org>
Subject: [PATCH 26/49] iio:light:isl29018: Switch from CONFIG_PM_SLEEP guards to pm_ptr() / __maybe_unused
Date:   Tue, 23 Nov 2021 21:09:56 +0000
Message-Id: <20211123211019.2271440-27-jic23@kernel.org>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211123211019.2271440-1-jic23@kernel.org>
References: <20211123211019.2271440-1-jic23@kernel.org>
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

The pm_ptr() macro only removes the reference if CONFIG_PM is not
set. It is possible for CONFIG_PM=y without CONFIG_SLEEP, so this
will not always remove the pm_ops structure.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Anson Huang <anson.huang@nxp.com>
Cc: Brian Masney <masneyb@onstation.org>
---
 drivers/iio/light/isl29018.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/light/isl29018.c b/drivers/iio/light/isl29018.c
index 2689867467a8..608bb357b9f6 100644
--- a/drivers/iio/light/isl29018.c
+++ b/drivers/iio/light/isl29018.c
@@ -784,8 +784,7 @@ static int isl29018_probe(struct i2c_client *client,
 	return devm_iio_device_register(&client->dev, indio_dev);
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int isl29018_suspend(struct device *dev)
+static __maybe_unused int isl29018_suspend(struct device *dev)
 {
 	struct isl29018_chip *chip = iio_priv(dev_get_drvdata(dev));
 	int ret;
@@ -807,7 +806,7 @@ static int isl29018_suspend(struct device *dev)
 	return ret;
 }
 
-static int isl29018_resume(struct device *dev)
+static __maybe_unused int isl29018_resume(struct device *dev)
 {
 	struct isl29018_chip *chip = iio_priv(dev_get_drvdata(dev));
 	int err;
@@ -831,10 +830,6 @@ static int isl29018_resume(struct device *dev)
 }
 
 static SIMPLE_DEV_PM_OPS(isl29018_pm_ops, isl29018_suspend, isl29018_resume);
-#define ISL29018_PM_OPS (&isl29018_pm_ops)
-#else
-#define ISL29018_PM_OPS NULL
-#endif
 
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id isl29018_acpi_match[] = {
@@ -866,7 +861,7 @@ static struct i2c_driver isl29018_driver = {
 	.driver	 = {
 			.name = "isl29018",
 			.acpi_match_table = ACPI_PTR(isl29018_acpi_match),
-			.pm = ISL29018_PM_OPS,
+			.pm = pm_ptr(&isl29018_pm_ops),
 			.of_match_table = isl29018_of_match,
 		    },
 	.probe	 = isl29018_probe,
-- 
2.34.0

