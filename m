Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15BC9482B2B
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jan 2022 13:51:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232280AbiABMv2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 2 Jan 2022 07:51:28 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:50340 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232135AbiABMv1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Jan 2022 07:51:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4D862B80D61
        for <linux-iio@vger.kernel.org>; Sun,  2 Jan 2022 12:51:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FC30C36AEE;
        Sun,  2 Jan 2022 12:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641127885;
        bh=PIw1uSJeYEE6U37w5+RAEELwEPcxZiLbx6Bn9BcGMss=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NG1LDFzBw9WeOHGM+4Uy7MUl8Y42LZSCVSDEsa2VjTRR9GqFLQK82HBTxTRK4q5uv
         wJ2SRuog1rBXFTKHpXaWz3mdf0JJUzKMP/7i4wgOFRlDNkledekB3qUwvoS/4rIbpD
         wzIi4MAArmFeGQE9AmuLbvo9Y86Jt+O6ZJf8nNcZS2EB5Mpg+oN9C+v9/XKz1Nm6He
         7cTN17zTdgM0wFcYlt4yiD1nz7nNMymrZQNEhRRbDGvbS41bfsQXGJZWHmGS9Wrqya
         MeuhGGiOMYw/wgL62IZhWhalrCxvznkgA1xJcnO32FTJCRF3OLjCoQruLI06XJKVSb
         5vkXnN/j558LQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: [PATCH v2 12/51] iio:adc:at91-adc: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr() etc
Date:   Sun,  2 Jan 2022 12:55:38 +0000
Message-Id: <20220102125617.1259804-13-jic23@kernel.org>
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

Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
---
 drivers/iio/adc/at91_adc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index 5a7d3a3a5fa8..4ec1586ea0a0 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -1234,7 +1234,6 @@ static int at91_adc_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int at91_adc_suspend(struct device *dev)
 {
 	struct iio_dev *idev = dev_get_drvdata(dev);
@@ -1256,9 +1255,8 @@ static int at91_adc_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
-static SIMPLE_DEV_PM_OPS(at91_adc_pm_ops, at91_adc_suspend, at91_adc_resume);
+DEFINE_SIMPLE_DEV_PM_OPS(at91_adc_pm_ops, at91_adc_suspend, at91_adc_resume);
 
 static const struct at91_adc_trigger at91sam9260_triggers[] = {
 	{ .name = "timer-counter-0", .value = 0x1 },
@@ -1386,7 +1384,7 @@ static struct platform_driver at91_adc_driver = {
 	.driver = {
 		   .name = DRIVER_NAME,
 		   .of_match_table = at91_adc_dt_ids,
-		   .pm = &at91_adc_pm_ops,
+		   .pm = pm_sleep_ptr(&at91_adc_pm_ops),
 	},
 };
 
-- 
2.34.1

