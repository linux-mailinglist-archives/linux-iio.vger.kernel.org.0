Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89CBA4A3886
	for <lists+linux-iio@lfdr.de>; Sun, 30 Jan 2022 20:25:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355897AbiA3TZy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 30 Jan 2022 14:25:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355873AbiA3TZt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Jan 2022 14:25:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C33D2C06173B
        for <linux-iio@vger.kernel.org>; Sun, 30 Jan 2022 11:25:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 63E10612BD
        for <linux-iio@vger.kernel.org>; Sun, 30 Jan 2022 19:25:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 258BFC340EF;
        Sun, 30 Jan 2022 19:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643570747;
        bh=Vk3iaKqoa+L1AUpwvwC3BtTuq8O4aTjz5o8ypVFWb6w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m8YvKk/YfWugGoYE4FXlkPy3f5CyQa2yzi+Fusd2E5q3SkwTRVg4LLA+zUaAHbPqH
         WG2/87QIvyoJg3J4nEpm9kd25ClH9SPe16WDEzosIIH4aFmkCSl+kaQPMKz4GQZGTn
         7bvfIG6H/m6J+vndYTCupAU24W6lti9nssfqhGehKq3xTmtoM2Y0nQkOjUfT06Ycjb
         gV1Nd6VcL6IKLpsOWyIi6zbS76+UXdyiecvAnYZmAOFSisISQKUCVfYfbDFtcR+zZ8
         DYO3QUNuoneDoiNsxCptKUbtzOuJl2lxL0Z5Z30EsQsRgbEXnpoxrPlxYRjMiEzO0C
         qJZMHVr7bpL+Q==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 06/50] iio:accel:mma7660: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr()
Date:   Sun, 30 Jan 2022 19:31:03 +0000
Message-Id: <20220130193147.279148-7-jic23@kernel.org>
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
use of #ifdef based config guards.

Removing instances of this approach from IIO also stops them being
copied into new drivers.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/accel/mma7660.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/accel/mma7660.c b/drivers/iio/accel/mma7660.c
index 24b83ccdb950..112a5a33c29f 100644
--- a/drivers/iio/accel/mma7660.c
+++ b/drivers/iio/accel/mma7660.c
@@ -222,7 +222,6 @@ static int mma7660_remove(struct i2c_client *client)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int mma7660_suspend(struct device *dev)
 {
 	struct mma7660_data *data;
@@ -241,12 +240,8 @@ static int mma7660_resume(struct device *dev)
 	return mma7660_set_mode(data, MMA7660_MODE_ACTIVE);
 }
 
-static SIMPLE_DEV_PM_OPS(mma7660_pm_ops, mma7660_suspend, mma7660_resume);
-
-#define MMA7660_PM_OPS (&mma7660_pm_ops)
-#else
-#define MMA7660_PM_OPS NULL
-#endif
+static DEFINE_SIMPLE_DEV_PM_OPS(mma7660_pm_ops, mma7660_suspend,
+				mma7660_resume);
 
 static const struct i2c_device_id mma7660_i2c_id[] = {
 	{"mma7660", 0},
@@ -270,7 +265,7 @@ MODULE_DEVICE_TABLE(acpi, mma7660_acpi_id);
 static struct i2c_driver mma7660_driver = {
 	.driver = {
 		.name = "mma7660",
-		.pm = MMA7660_PM_OPS,
+		.pm = pm_sleep_ptr(&mma7660_pm_ops),
 		.of_match_table = mma7660_of_match,
 		.acpi_match_table = ACPI_PTR(mma7660_acpi_id),
 	},
-- 
2.35.1

