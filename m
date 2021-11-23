Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C868245ADFF
	for <lists+linux-iio@lfdr.de>; Tue, 23 Nov 2021 22:07:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239706AbhKWVKW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 23 Nov 2021 16:10:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:40364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239711AbhKWVKN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 23 Nov 2021 16:10:13 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 632F46023D;
        Tue, 23 Nov 2021 21:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637701624;
        bh=pPyl3puDnQ2YVwDAg9Av2Db11yYm6u2B5Vk0Ez8BCMY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=de+U/FpRZNNmqe97RVGNlMZYygTp6bLLyXNfu748eyS/JJI9f17qvTo3siowCKyhx
         glPVwfvj02kD5bpfevBNFdjhWE/+CAVR+xvuaWvApo6UkUbLkIpJOkTgqRddJcmaQ1
         HSOVQalk6WzgfKqCIfaaW4YbwRgdrnc/ibw2VvUblMg1EVY0TeiA9d85Z2ao2ghhBW
         mIGK7K4oTeti06WpiOfx8xV/qTFhwqxLVUJnwn9HUL2PYoGxFMORnoc1OJTwjeRyHl
         /4D30k5/7Twfbmd5UvPCcq5xnggyLFzvHRYQsjgOHfGhYqm9Dr8er6HxhHVz72ShYd
         QtgXUBl2dkBFw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 37/49] iio:magn:hmc5843: Switch from CONFIG_PM_SLEEP guards to pm_ptr() / __maybe_unused
Date:   Tue, 23 Nov 2021 21:10:07 +0000
Message-Id: <20211123211019.2271440-38-jic23@kernel.org>
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
---
 drivers/iio/magnetometer/hmc5843.h     | 5 -----
 drivers/iio/magnetometer/hmc5843_i2c.c | 2 +-
 drivers/iio/magnetometer/hmc5843_spi.c | 2 +-
 3 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/magnetometer/hmc5843.h b/drivers/iio/magnetometer/hmc5843.h
index 9120c8bbf3dd..c3444f3ab1dc 100644
--- a/drivers/iio/magnetometer/hmc5843.h
+++ b/drivers/iio/magnetometer/hmc5843.h
@@ -55,13 +55,8 @@ void hmc5843_common_remove(struct device *dev);
 int hmc5843_common_suspend(struct device *dev);
 int hmc5843_common_resume(struct device *dev);
 
-#ifdef CONFIG_PM_SLEEP
 static __maybe_unused SIMPLE_DEV_PM_OPS(hmc5843_pm_ops,
 					hmc5843_common_suspend,
 					hmc5843_common_resume);
-#define HMC5843_PM_OPS (&hmc5843_pm_ops)
-#else
-#define HMC5843_PM_OPS NULL
-#endif
 
 #endif /* HMC5843_CORE_H */
diff --git a/drivers/iio/magnetometer/hmc5843_i2c.c b/drivers/iio/magnetometer/hmc5843_i2c.c
index bc6e12f1d521..a7359f439f10 100644
--- a/drivers/iio/magnetometer/hmc5843_i2c.c
+++ b/drivers/iio/magnetometer/hmc5843_i2c.c
@@ -93,7 +93,7 @@ MODULE_DEVICE_TABLE(of, hmc5843_of_match);
 static struct i2c_driver hmc5843_driver = {
 	.driver = {
 		.name	= "hmc5843",
-		.pm	= HMC5843_PM_OPS,
+		.pm	= pm_ptr(&hmc5843_pm_ops),
 		.of_match_table = hmc5843_of_match,
 	},
 	.id_table	= hmc5843_id,
diff --git a/drivers/iio/magnetometer/hmc5843_spi.c b/drivers/iio/magnetometer/hmc5843_spi.c
index 89cf59a62c28..c1bd2ff3c64a 100644
--- a/drivers/iio/magnetometer/hmc5843_spi.c
+++ b/drivers/iio/magnetometer/hmc5843_spi.c
@@ -90,7 +90,7 @@ MODULE_DEVICE_TABLE(spi, hmc5843_id);
 static struct spi_driver hmc5843_driver = {
 		.driver = {
 				.name = "hmc5843",
-				.pm = HMC5843_PM_OPS,
+				.pm = pm_ptr(&hmc5843_pm_ops),
 		},
 		.id_table = hmc5843_id,
 		.probe = hmc5843_spi_probe,
-- 
2.34.0

