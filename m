Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 842D04A389F
	for <lists+linux-iio@lfdr.de>; Sun, 30 Jan 2022 20:26:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355930AbiA3T0n (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 30 Jan 2022 14:26:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355938AbiA3T0m (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Jan 2022 14:26:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D86C061714
        for <linux-iio@vger.kernel.org>; Sun, 30 Jan 2022 11:26:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5995C612BD
        for <linux-iio@vger.kernel.org>; Sun, 30 Jan 2022 19:26:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62E41C340E4;
        Sun, 30 Jan 2022 19:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643570800;
        bh=nQ/UPFI3bGg+pCkQrdle5mrTeURGGE/kT8IgId0oO0E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pehGUkXR6Pznup+fxvCujc0nF9OCLJEz/zN4U2Cg2l0apECUqWI+re1vC28n6KhtZ
         TQjM6ezVHa/bekplJ5EUZyqh3yznedzcekgHuaQyVDUkqqS5FbkqLRnA68z29NSjMJ
         1ZbDvLKKW9xcQx4I/rhTk055QBDg4NDRGzBJ+kJVx+ebZNdtM2O+u2blk9jTlrPH59
         W19uSwa2k7R4bnvkxRWAddIBQV6PiKXoQ4f7h6unUpem+UFGCTuVztQZ8yCUDGbemk
         kg98WaIYdQJpN5B01ho5XHhLHOyt5knVeKgVqLAOkk7+54CfGey7wFnt6pqgFe/uqx
         WmKzFFTxbdRQQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 31/50] iio:magn:mmc35240: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr() etc
Date:   Sun, 30 Jan 2022 19:31:28 +0000
Message-Id: <20220130193147.279148-32-jic23@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220130193147.279148-1-jic23@kernel.org>
References: <20220130193147.279148-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Letting the compiler remove these functions when the kernel is built
without CONFIG_PM_SLEEP support is simpler and less error prone than the
use of #ifdef based config guards. Also use SIMPLE_DEV_PM_OPS instead
of open-coding the equivalent.

Removing instances of this approach from IIO also stops them being
copied into new drivers.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/magnetometer/mmc35240.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/magnetometer/mmc35240.c b/drivers/iio/magnetometer/mmc35240.c
index 65f3d1ed0d59..186edfcda0b7 100644
--- a/drivers/iio/magnetometer/mmc35240.c
+++ b/drivers/iio/magnetometer/mmc35240.c
@@ -521,7 +521,6 @@ static int mmc35240_probe(struct i2c_client *client,
 	return devm_iio_device_register(&client->dev, indio_dev);
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int mmc35240_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
@@ -548,11 +547,9 @@ static int mmc35240_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
-static const struct dev_pm_ops mmc35240_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(mmc35240_suspend, mmc35240_resume)
-};
+static DEFINE_SIMPLE_DEV_PM_OPS(mmc35240_pm_ops, mmc35240_suspend,
+				mmc35240_resume);
 
 static const struct of_device_id mmc35240_of_match[] = {
 	{ .compatible = "memsic,mmc35240", },
@@ -576,7 +573,7 @@ static struct i2c_driver mmc35240_driver = {
 	.driver = {
 		.name = MMC35240_DRV_NAME,
 		.of_match_table = mmc35240_of_match,
-		.pm = &mmc35240_pm_ops,
+		.pm = pm_sleep_ptr(&mmc35240_pm_ops),
 		.acpi_match_table = ACPI_PTR(mmc35240_acpi_match),
 	},
 	.probe		= mmc35240_probe,
-- 
2.35.1

