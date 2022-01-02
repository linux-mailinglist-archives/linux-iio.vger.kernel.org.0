Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B92B482B3B
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jan 2022 13:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232369AbiABMwM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 2 Jan 2022 07:52:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232363AbiABMwL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Jan 2022 07:52:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C75C061574
        for <linux-iio@vger.kernel.org>; Sun,  2 Jan 2022 04:52:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6EF8BB80D61
        for <linux-iio@vger.kernel.org>; Sun,  2 Jan 2022 12:52:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40622C36AF0;
        Sun,  2 Jan 2022 12:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641127929;
        bh=9NnJ2ODFpPcmHDmuc4kajl0/dcmK4qqhOi2wuxxJugI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UcZ8rMibw1ndXMJORYF5e5gcPHZLIHJPKVesdoXh289L/TquL9vxkMNhy0xZOclq7
         c1slgpZl5oyw69GoE+ucw/tNmNrUutA3cb5f02pmqQa33pS0PagSD6aGLpieqtw1Sq
         j3To8eI1s2NgXBWqJjqWzyqtEdd6k8y60LsP0Ya3IpMJeH21RriD2+lUaEn1A4YZsK
         mrUtQcdXrxbIkyijHo7DAQGcDp5+qxn3BPx0Z7ryOyyTzSL8au2Hd7k7xWi4MtldUt
         yHefQrG6quaFoFGmFl02JC9rv+tSD3V6/Fwep4dNZBR0MOsBZR8W0rrpM87KfvvvWK
         OkyC6GHDkRIog==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Maslov Dmitry <maslovdmitry@seeed.cc>
Subject: [PATCH v2 28/51] iio:light:ltr501: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr() etc
Date:   Sun,  2 Jan 2022 12:55:54 +0000
Message-Id: <20220102125617.1259804-29-jic23@kernel.org>
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
use of #ifdef based config guards.

Removing instances of this approach from IIO also stops them being
copied into new drivers.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Maslov Dmitry <maslovdmitry@seeed.cc>
---
 drivers/iio/light/ltr501.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
index 47d61ec2bb50..08d03101653f 100644
--- a/drivers/iio/light/ltr501.c
+++ b/drivers/iio/light/ltr501.c
@@ -1611,7 +1611,6 @@ static int ltr501_remove(struct i2c_client *client)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int ltr501_suspend(struct device *dev)
 {
 	struct ltr501_data *data = iio_priv(i2c_get_clientdata(
@@ -1627,9 +1626,8 @@ static int ltr501_resume(struct device *dev)
 	return ltr501_write_contr(data, data->als_contr,
 		data->ps_contr);
 }
-#endif
 
-static SIMPLE_DEV_PM_OPS(ltr501_pm_ops, ltr501_suspend, ltr501_resume);
+DEFINE_SIMPLE_DEV_PM_OPS(ltr501_pm_ops, ltr501_suspend, ltr501_resume);
 
 static const struct acpi_device_id ltr_acpi_match[] = {
 	{"LTER0501", ltr501},
@@ -1661,7 +1659,7 @@ static struct i2c_driver ltr501_driver = {
 	.driver = {
 		.name   = LTR501_DRV_NAME,
 		.of_match_table = ltr501_of_match,
-		.pm	= &ltr501_pm_ops,
+		.pm	= pm_sleep_ptr(&ltr501_pm_ops),
 		.acpi_match_table = ACPI_PTR(ltr_acpi_match),
 	},
 	.probe  = ltr501_probe,
-- 
2.34.1

