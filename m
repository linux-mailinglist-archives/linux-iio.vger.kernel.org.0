Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1EC845ADEF
	for <lists+linux-iio@lfdr.de>; Tue, 23 Nov 2021 22:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239264AbhKWVJk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 23 Nov 2021 16:09:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:40090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239320AbhKWVJj (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 23 Nov 2021 16:09:39 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 05DF460FC3;
        Tue, 23 Nov 2021 21:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637701591;
        bh=5c/9u/nyytxFRVfPIp2yMmTIUe35YDHVWTow3ymK0JY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XE6UFSGgmU854Haih6gHd3Icwuo06KgVvIP8bxz3kki/Bh8gZEih9d76Hs3E+daMU
         SBzA8NUF2jftlT13UmI54/LK4vi0OSMLvm8kc1/YTwBauN8YO88iWbjZ7ku2i8unfH
         XZ8rskI7uZF/btsjN3dJDOE5xvBFsuvfma43wBNPaNsh2QRDLupirM4ZihGG3SW6dd
         PORFthf5zyyL9hLN+p5oDtqe0ESNNFzRkjuRCa2CnDVLTSXbePD9Sx2qhU89olSJYc
         84hcldH1YUj6AN9xv1mnCt5QrisdRuBOdfC4Xo8fKpxqxy0+hanA4yDUNB2Ji+7ncx
         O72zCq2LAFsLw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 21/49] iio:common:ssp: Switch from CONFIG_PM_SLEEP guards to pm_ptr() / __maybe_unused
Date:   Tue, 23 Nov 2021 21:09:51 +0000
Message-Id: <20211123211019.2271440-22-jic23@kernel.org>
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
use of ifdef based config guards.  Also switch to SIMPLE_DEV_PM_OPS
rather than open coding the structure.

Removing instances of this approach from IIO also stops them being
copied into new drivers.

The pm_ptr() macro only removes the reference if CONFIG_PM is not
set. It is possible for CONFIG_PM=y without CONFIG_SLEEP, so this
will not always remove the pm_ops structure.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/common/ssp_sensors/ssp_dev.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/common/ssp_sensors/ssp_dev.c b/drivers/iio/common/ssp_sensors/ssp_dev.c
index 1aee87100038..b5d2c69b5cc9 100644
--- a/drivers/iio/common/ssp_sensors/ssp_dev.c
+++ b/drivers/iio/common/ssp_sensors/ssp_dev.c
@@ -612,8 +612,7 @@ static int ssp_remove(struct spi_device *spi)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int ssp_suspend(struct device *dev)
+static __maybe_unused int ssp_suspend(struct device *dev)
 {
 	int ret;
 	struct ssp_data *data = spi_get_drvdata(to_spi_device(dev));
@@ -638,7 +637,7 @@ static int ssp_suspend(struct device *dev)
 	return 0;
 }
 
-static int ssp_resume(struct device *dev)
+static __maybe_unused int ssp_resume(struct device *dev)
 {
 	int ret;
 	struct ssp_data *data = spi_get_drvdata(to_spi_device(dev));
@@ -661,17 +660,14 @@ static int ssp_resume(struct device *dev)
 
 	return 0;
 }
-#endif /* CONFIG_PM_SLEEP */
 
-static const struct dev_pm_ops ssp_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(ssp_suspend, ssp_resume)
-};
+static SIMPLE_DEV_PM_OPS(ssp_pm_ops, ssp_suspend, ssp_resume);
 
 static struct spi_driver ssp_driver = {
 	.probe = ssp_probe,
 	.remove = ssp_remove,
 	.driver = {
-		.pm = &ssp_pm_ops,
+		.pm = pm_ptr(&ssp_pm_ops),
 		.of_match_table = of_match_ptr(ssp_of_match),
 		.name = "sensorhub"
 	},
-- 
2.34.0

