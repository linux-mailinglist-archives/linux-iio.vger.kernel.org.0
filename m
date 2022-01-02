Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5682D482B24
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jan 2022 13:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232359AbiABMvJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 2 Jan 2022 07:51:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiABMvI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Jan 2022 07:51:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA17C061574
        for <linux-iio@vger.kernel.org>; Sun,  2 Jan 2022 04:51:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0ECB7B80D63
        for <linux-iio@vger.kernel.org>; Sun,  2 Jan 2022 12:51:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C1BFC36AE7;
        Sun,  2 Jan 2022 12:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641127865;
        bh=J9oO+je7d9RNkd2uZILlh3K7YF6mQhwBZjNY6JmOd8I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P3valWOeNb+DEmBE+ZmRPPcUm5TfvvIwVSEo0Wt78ZwLBUsPoh/UuASzKfz78sh4M
         7ORAuAKd3J9Ba7M7UklRlkjou4gKYXtR288IZ9kitYxDbG9agiAeLVwr3nfXBDXlyr
         Z21uJm3YFy1jXKAfXeNRH6lJhB52xj5qOv1iw51UPBj9QdpplK3RgaFnAn/rRFmHod
         92Fj/Wd5QK7GTOrSFuUvAuj2epBJ/ZaAQlqyMRPy+iWWkeHygk8HDYen/CMiupLqqX
         L0H3Lu+XfJ6oJpQu71yvfo6VqGvpZmdWd9taHGjkC8P35+e0rUnZ5uZnj0VSQ7EVi2
         i6q6hJHfOBr+Q==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 05/51] iio:accel:mc3230: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr() etc
Date:   Sun,  2 Jan 2022 12:55:31 +0000
Message-Id: <20220102125617.1259804-6-jic23@kernel.org>
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
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/iio/accel/mc3230.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/accel/mc3230.c b/drivers/iio/accel/mc3230.c
index 735002b716f3..09647706756a 100644
--- a/drivers/iio/accel/mc3230.c
+++ b/drivers/iio/accel/mc3230.c
@@ -160,7 +160,6 @@ static int mc3230_remove(struct i2c_client *client)
 	return mc3230_set_opcon(iio_priv(indio_dev), MC3230_MODE_OPCON_STANDBY);
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int mc3230_suspend(struct device *dev)
 {
 	struct mc3230_data *data;
@@ -178,9 +177,8 @@ static int mc3230_resume(struct device *dev)
 
 	return mc3230_set_opcon(data, MC3230_MODE_OPCON_WAKE);
 }
-#endif
 
-static SIMPLE_DEV_PM_OPS(mc3230_pm_ops, mc3230_suspend, mc3230_resume);
+DEFINE_SIMPLE_DEV_PM_OPS(mc3230_pm_ops, mc3230_suspend, mc3230_resume);
 
 static const struct i2c_device_id mc3230_i2c_id[] = {
 	{"mc3230", 0},
@@ -191,7 +189,7 @@ MODULE_DEVICE_TABLE(i2c, mc3230_i2c_id);
 static struct i2c_driver mc3230_driver = {
 	.driver = {
 		.name = "mc3230",
-		.pm = &mc3230_pm_ops,
+		.pm = pm_sleep_ptr(&mc3230_pm_ops),
 	},
 	.probe		= mc3230_probe,
 	.remove		= mc3230_remove,
-- 
2.34.1

