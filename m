Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCC90482B48
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jan 2022 13:52:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232382AbiABMws (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 2 Jan 2022 07:52:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbiABMwr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Jan 2022 07:52:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E776C061574
        for <linux-iio@vger.kernel.org>; Sun,  2 Jan 2022 04:52:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1DD3A60E98
        for <linux-iio@vger.kernel.org>; Sun,  2 Jan 2022 12:52:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F1E4C36AEF;
        Sun,  2 Jan 2022 12:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641127966;
        bh=ewQh+yXqUqKE2qnkFV0FY5ol9QNzNU+E907FU2VBWNk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cvcd4+fAlwdqprXky0oCrH365rFwNGb1KzcLKQhJbcoV2SS9HZW1cKqot4vk0TD8M
         6AJDMdWmGXfZeeOZURovEtd0nunOd/LdHZXLCi4bgWW1eMKvAIOdlrKAZv/8AZwe/j
         zTxKs0iF91YcLj9VJ5sTLkTw4imE0VZNXfPu2BAQJ58urLuh+8g27WWg6TJX1vYtm2
         NZJggEcmwnfiYKMu5xQojMckdLUJFUVFz5uoB7qPKn3K8wjU9CZsHXzLHuMdyiI5Pw
         yaFWqN6nEakspcQQ2QbP/kJ4My0d6DY+iOUHAU4Mst0J1Pl0Tb87SL8CBIsv39zvxM
         3+KkjRzj1CZdg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 41/51] iio:proximity:rfd77492: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr() etc
Date:   Sun,  2 Jan 2022 12:56:07 +0000
Message-Id: <20220102125617.1259804-42-jic23@kernel.org>
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
 drivers/iio/proximity/rfd77402.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/proximity/rfd77402.c b/drivers/iio/proximity/rfd77402.c
index 8c06d02139b6..4f594d71f15d 100644
--- a/drivers/iio/proximity/rfd77402.c
+++ b/drivers/iio/proximity/rfd77402.c
@@ -295,7 +295,6 @@ static int rfd77402_probe(struct i2c_client *client,
 	return devm_iio_device_register(&client->dev, indio_dev);
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int rfd77402_suspend(struct device *dev)
 {
 	return rfd77402_powerdown(to_i2c_client(dev));
@@ -305,9 +304,8 @@ static int rfd77402_resume(struct device *dev)
 {
 	return rfd77402_init(to_i2c_client(dev));
 }
-#endif
 
-static SIMPLE_DEV_PM_OPS(rfd77402_pm_ops, rfd77402_suspend, rfd77402_resume);
+DEFINE_SIMPLE_DEV_PM_OPS(rfd77402_pm_ops, rfd77402_suspend, rfd77402_resume);
 
 static const struct i2c_device_id rfd77402_id[] = {
 	{ "rfd77402", 0},
@@ -318,7 +316,7 @@ MODULE_DEVICE_TABLE(i2c, rfd77402_id);
 static struct i2c_driver rfd77402_driver = {
 	.driver = {
 		.name   = RFD77402_DRV_NAME,
-		.pm     = &rfd77402_pm_ops,
+		.pm     = pm_sleep_ptr(&rfd77402_pm_ops),
 	},
 	.probe  = rfd77402_probe,
 	.id_table = rfd77402_id,
-- 
2.34.1

