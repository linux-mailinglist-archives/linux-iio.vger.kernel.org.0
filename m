Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0C3482B32
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jan 2022 13:51:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232310AbiABMvq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 2 Jan 2022 07:51:46 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:42142 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232333AbiABMvp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Jan 2022 07:51:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 27FAA60DB7
        for <linux-iio@vger.kernel.org>; Sun,  2 Jan 2022 12:51:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D930C36AEF;
        Sun,  2 Jan 2022 12:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641127904;
        bh=wfLuY9IJCthJwZ6emwUuF0rr+yB2hBxGYbDXsYhtv2M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WCOaocqUiDSBotKLN9YsAwaJkuqUsboBoaACJRUmoOz5QwMZkhJqPzYIEyKILwYu+
         BmjuCYSV0qkJurSuqy+CvKtLjy4RzMSGkEUbHPupngrBgUmgLn7Pp+qX9q/nQONdur
         YacnSVa3gP7YN+oq8b47FJGblYlNMX3n4wWEVQHl7E+C0L8mwWMWAj3p6cGDcUZjlE
         UhwPGa+yf6K56BmP0EarPpOIyuqZPeoySC5kmNXnbZdJJJed2ZIg1Pnl8s0EdCes/V
         0heUlbM+tOOiVuS2qcBv3RVsRD2+E1zzbQhP1tKR28iFJeeW0N0Ig4DXif9yxM9MRz
         ChjRhunJUXa5Q==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
Subject: [PATCH v2 19/51] iio:adc:vf610: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr() etc
Date:   Sun,  2 Jan 2022 12:55:45 +0000
Message-Id: <20220102125617.1259804-20-jic23@kernel.org>
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
use of ifdef based config guards.

Removing instances of this approach from IIO also stops them being
copied into new drivers.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
---
 drivers/iio/adc/vf610_adc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/vf610_adc.c b/drivers/iio/adc/vf610_adc.c
index fd57fc43e8e5..6f10b265a481 100644
--- a/drivers/iio/adc/vf610_adc.c
+++ b/drivers/iio/adc/vf610_adc.c
@@ -912,7 +912,6 @@ static int vf610_adc_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int vf610_adc_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
@@ -952,9 +951,8 @@ static int vf610_adc_resume(struct device *dev)
 	regulator_disable(info->vref);
 	return ret;
 }
-#endif
 
-static SIMPLE_DEV_PM_OPS(vf610_adc_pm_ops, vf610_adc_suspend, vf610_adc_resume);
+DEFINE_SIMPLE_DEV_PM_OPS(vf610_adc_pm_ops, vf610_adc_suspend, vf610_adc_resume);
 
 static struct platform_driver vf610_adc_driver = {
 	.probe          = vf610_adc_probe,
@@ -962,7 +960,7 @@ static struct platform_driver vf610_adc_driver = {
 	.driver         = {
 		.name   = DRIVER_NAME,
 		.of_match_table = vf610_adc_match,
-		.pm     = &vf610_adc_pm_ops,
+		.pm     = pm_sleep_ptr(&vf610_adc_pm_ops),
 	},
 };
 
-- 
2.34.1

