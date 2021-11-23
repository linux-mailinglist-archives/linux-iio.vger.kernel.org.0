Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 452C045ADE8
	for <lists+linux-iio@lfdr.de>; Tue, 23 Nov 2021 22:06:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239058AbhKWVJd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 23 Nov 2021 16:09:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:40048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238022AbhKWVJb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 23 Nov 2021 16:09:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 420AD60FED;
        Tue, 23 Nov 2021 21:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637701583;
        bh=VLoubZjlIS5eHX4fjOA/NQuRCd8tIeG8I8+uigcgBkM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M3huh4nLqwzuFHuFd9axJlLxJfp3rrpSxoVtgYcAXFQWgI+9nSH6UqXWTmEiq5YLc
         29T1vhT9KmtSSFW5XUwI97szM7Uux/LQxzxbIa6YSvBchALzzuFrwT5y3xyPMGbBvf
         Yd/Sa0xy1JbMSjRIqPcUIzlj9LcYQAcbCcPgoDCFkU5E7H6hl+C7YAqQw1FH7Ulg8M
         MdM0jCloMYfqWRFC7J6w3IBijuRUyFUifMki0NuM2U9O/MU9Y8fFHG18/jLQR1puR5
         XYOT88XN6nUGAwsl2B4McValtNpCyjyWzckKVRFwwRJ6tli/ap67yL3hRoP7PKPzmQ
         42QfOlJe/UbbA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 17/49] iio:adc:rcar: Switch from CONFIG_PM guards to pm_ptr() / __maybe_unused
Date:   Tue, 23 Nov 2021 21:09:47 +0000
Message-Id: <20211123211019.2271440-18-jic23@kernel.org>
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
without CONFIG_PM support is simpler and less error prone than the
use of #ifdef based config guards.

Removing instances of this approach from IIO also stops them being
copied into new drivers.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/rcar-gyroadc.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/rcar-gyroadc.c b/drivers/iio/adc/rcar-gyroadc.c
index a48895046408..947d72457066 100644
--- a/drivers/iio/adc/rcar-gyroadc.c
+++ b/drivers/iio/adc/rcar-gyroadc.c
@@ -578,8 +578,7 @@ static int rcar_gyroadc_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#if defined(CONFIG_PM)
-static int rcar_gyroadc_suspend(struct device *dev)
+static __maybe_unused int rcar_gyroadc_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct rcar_gyroadc *priv = iio_priv(indio_dev);
@@ -589,7 +588,7 @@ static int rcar_gyroadc_suspend(struct device *dev)
 	return 0;
 }
 
-static int rcar_gyroadc_resume(struct device *dev)
+static __maybe_unused int rcar_gyroadc_resume(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct rcar_gyroadc *priv = iio_priv(indio_dev);
@@ -598,9 +597,8 @@ static int rcar_gyroadc_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
-static const struct dev_pm_ops rcar_gyroadc_pm_ops = {
+static __maybe_unused  const struct dev_pm_ops rcar_gyroadc_pm_ops = {
 	SET_RUNTIME_PM_OPS(rcar_gyroadc_suspend, rcar_gyroadc_resume, NULL)
 };
 
@@ -610,7 +608,7 @@ static struct platform_driver rcar_gyroadc_driver = {
 	.driver         = {
 		.name		= DRIVER_NAME,
 		.of_match_table	= rcar_gyroadc_match,
-		.pm		= &rcar_gyroadc_pm_ops,
+		.pm		= pm_ptr(&rcar_gyroadc_pm_ops),
 	},
 };
 
-- 
2.34.0

