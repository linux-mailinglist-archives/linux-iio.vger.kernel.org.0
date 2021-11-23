Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5DED45ADE4
	for <lists+linux-iio@lfdr.de>; Tue, 23 Nov 2021 22:06:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234770AbhKWVJY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 23 Nov 2021 16:09:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:39988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235362AbhKWVJY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 23 Nov 2021 16:09:24 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3E31B60FC3;
        Tue, 23 Nov 2021 21:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637701575;
        bh=KK0hcC9cvY2znW2Ml62+mkMlhp+owYdBi4z6EJY9WoA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AL5j4lvPRotQQIjyIPWootkCLyBRhf8yRZ9TE3ycr5UAc8AsycQDpcp2ncXCwOEjB
         GcXU8kq77ukng7JWDBycetvr/wWwDEcVShWIag80RXXLcTZhXeG8AsBnFPHG5SQvF9
         jvCA4QLgc25hHDQIrdqy3A3CPWl2wBp6LG6RL8+DS27fOv+oEwhgT699hdwf2u/lbz
         XeBSIAzjXC1c/apbAHWFXbz9II/rrm7d8Vh99Qis4LHw1KZkrJCb+K6fcFeucsb+el
         j9gOpGrrNW27Qy8Bm4TzySe314JO/dNbA0XPtDB5ZqlfUvZ2lKX4d2bJVuyUafiC34
         kh9W7ar9+WDnQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: [PATCH 13/49] iio:adc:at91-adc: Switch from CONFIG_PM_SLEEP guards to pm_ptr() / __maybe_unused
Date:   Tue, 23 Nov 2021 21:09:43 +0000
Message-Id: <20211123211019.2271440-14-jic23@kernel.org>
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
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
---
 drivers/iio/adc/at91_adc.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index 5a7d3a3a5fa8..14a4735d72b5 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -1234,8 +1234,7 @@ static int at91_adc_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int at91_adc_suspend(struct device *dev)
+static __maybe_unused int at91_adc_suspend(struct device *dev)
 {
 	struct iio_dev *idev = dev_get_drvdata(dev);
 	struct at91_adc_state *st = iio_priv(idev);
@@ -1246,7 +1245,7 @@ static int at91_adc_suspend(struct device *dev)
 	return 0;
 }
 
-static int at91_adc_resume(struct device *dev)
+static __maybe_unused int at91_adc_resume(struct device *dev)
 {
 	struct iio_dev *idev = dev_get_drvdata(dev);
 	struct at91_adc_state *st = iio_priv(idev);
@@ -1256,7 +1255,6 @@ static int at91_adc_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
 static SIMPLE_DEV_PM_OPS(at91_adc_pm_ops, at91_adc_suspend, at91_adc_resume);
 
@@ -1386,7 +1384,7 @@ static struct platform_driver at91_adc_driver = {
 	.driver = {
 		   .name = DRIVER_NAME,
 		   .of_match_table = at91_adc_dt_ids,
-		   .pm = &at91_adc_pm_ops,
+		   .pm = pm_ptr(&at91_adc_pm_ops),
 	},
 };
 
-- 
2.34.0

