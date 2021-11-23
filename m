Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7370745ADEE
	for <lists+linux-iio@lfdr.de>; Tue, 23 Nov 2021 22:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237964AbhKWVJk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 23 Nov 2021 16:09:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:40082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239459AbhKWVJi (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 23 Nov 2021 16:09:38 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id EE90B60FC1;
        Tue, 23 Nov 2021 21:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637701589;
        bh=u6JR+BkVUxeRvzfyD0nWG6ApnIKahflv2F64KvoJvtA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c2F5z6UHeFpZKvHHIfuRhV8N2SCTeHzESq2qftglooV4QYg5WUabdldw9qdi1wuby
         LjtaoA54Q5qmEsX4ia8zC6D8fCOh414eJP2jQUMFqtVgybPYGGGEcFR+1C/axVBexA
         Rrf5zOcVwo09p0bLegND/6cJTxCdaCl/7yTXW12dkVO+3Q5+m4bizz2TFWFitmLgPw
         WnznMTuO5sKWL6BMlGw4z9tGYjB5Xc1YNftVyEnQRBiPLsSLO6DmOy+DJ92hNxCjs4
         V2vSG9NnyQrg75rjgRaeNvRiHzlGgY7FNFTQQTbl2zLQz2cfQrqZhhklL+QEVpaErV
         zqxOLrd1LB2ZQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
Subject: [PATCH 20/49] iio:adc:vf610: Switch from CONFIG_PM_SLEEP guards to pm_ptr() / __maybe_unused
Date:   Tue, 23 Nov 2021 21:09:50 +0000
Message-Id: <20211123211019.2271440-21-jic23@kernel.org>
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
use of ifdef based config guards.

Removing instances of this approach from IIO also stops them being
copied into new drivers.

The pm_ptr() macro only removes the reference if CONFIG_PM is not
set. It is possible for CONFIG_PM=y without CONFIG_SLEEP, so this
will not always remove the pm_ops structure.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
---
 drivers/iio/adc/vf610_adc.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/vf610_adc.c b/drivers/iio/adc/vf610_adc.c
index fd57fc43e8e5..c05ef6d85093 100644
--- a/drivers/iio/adc/vf610_adc.c
+++ b/drivers/iio/adc/vf610_adc.c
@@ -912,8 +912,7 @@ static int vf610_adc_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int vf610_adc_suspend(struct device *dev)
+static __maybe_unused int vf610_adc_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct vf610_adc *info = iio_priv(indio_dev);
@@ -930,7 +929,7 @@ static int vf610_adc_suspend(struct device *dev)
 	return 0;
 }
 
-static int vf610_adc_resume(struct device *dev)
+static __maybe_unused int vf610_adc_resume(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct vf610_adc *info = iio_priv(indio_dev);
@@ -952,7 +951,6 @@ static int vf610_adc_resume(struct device *dev)
 	regulator_disable(info->vref);
 	return ret;
 }
-#endif
 
 static SIMPLE_DEV_PM_OPS(vf610_adc_pm_ops, vf610_adc_suspend, vf610_adc_resume);
 
@@ -962,7 +960,7 @@ static struct platform_driver vf610_adc_driver = {
 	.driver         = {
 		.name   = DRIVER_NAME,
 		.of_match_table = vf610_adc_match,
-		.pm     = &vf610_adc_pm_ops,
+		.pm     = pm_ptr(&vf610_adc_pm_ops),
 	},
 };
 
-- 
2.34.0

