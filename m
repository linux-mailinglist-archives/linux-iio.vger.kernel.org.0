Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5DE8482B25
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jan 2022 13:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232365AbiABMvK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 2 Jan 2022 07:51:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiABMvJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Jan 2022 07:51:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 912F8C061574
        for <linux-iio@vger.kernel.org>; Sun,  2 Jan 2022 04:51:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C23B60E9A
        for <linux-iio@vger.kernel.org>; Sun,  2 Jan 2022 12:51:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AD4BC36AF0;
        Sun,  2 Jan 2022 12:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641127868;
        bh=V2zaxYNHfWbCB6anYSxNpCPTjwhmh1N7jMTHXMR8Qco=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=niPZy0d5tt2nlGxA008gjGWxFiORAJYeCnaDMG/TAdCk6+2HtEVbHM0Sk1hGNAUMg
         I9S8RAYfr7VhxeeaSUlB2gdnip9ZpFeF0O6nZQo1l34Ht92+MHTVc+Asn4TnZN8Dxw
         ZXvlWz2LuJCC5NgY05SRuKpK2MUDC2w6WizHP6aOXUTaaSMOh5iv+DV0wI6PpROiFC
         tCTbpknGsRUQll4s1L8yWvIk3jTSN1TSH+btcqKDDBhQd/iKVabI/UWcIln8GdIwVK
         Z4+CZS0IRir8ZMR2+Lj5CmVC38WTdvuG9NQd0xMm1Sw4S/3ddsmb63YQzMpfF/C80q
         KxqFzd62+cXiA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 06/51] iio:accel:mma7660: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr()
Date:   Sun,  2 Jan 2022 12:55:32 +0000
Message-Id: <20220102125617.1259804-7-jic23@kernel.org>
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
---
 drivers/iio/accel/mma7660.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/accel/mma7660.c b/drivers/iio/accel/mma7660.c
index 24b83ccdb950..0dec40ca4fd4 100644
--- a/drivers/iio/accel/mma7660.c
+++ b/drivers/iio/accel/mma7660.c
@@ -222,7 +222,6 @@ static int mma7660_remove(struct i2c_client *client)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int mma7660_suspend(struct device *dev)
 {
 	struct mma7660_data *data;
@@ -241,12 +240,7 @@ static int mma7660_resume(struct device *dev)
 	return mma7660_set_mode(data, MMA7660_MODE_ACTIVE);
 }
 
-static SIMPLE_DEV_PM_OPS(mma7660_pm_ops, mma7660_suspend, mma7660_resume);
-
-#define MMA7660_PM_OPS (&mma7660_pm_ops)
-#else
-#define MMA7660_PM_OPS NULL
-#endif
+DEFINE_SIMPLE_DEV_PM_OPS(mma7660_pm_ops, mma7660_suspend, mma7660_resume);
 
 static const struct i2c_device_id mma7660_i2c_id[] = {
 	{"mma7660", 0},
@@ -270,7 +264,7 @@ MODULE_DEVICE_TABLE(acpi, mma7660_acpi_id);
 static struct i2c_driver mma7660_driver = {
 	.driver = {
 		.name = "mma7660",
-		.pm = MMA7660_PM_OPS,
+		.pm = pm_sleep_ptr(&mma7660_pm_ops),
 		.of_match_table = mma7660_of_match,
 		.acpi_match_table = ACPI_PTR(mma7660_acpi_id),
 	},
-- 
2.34.1

