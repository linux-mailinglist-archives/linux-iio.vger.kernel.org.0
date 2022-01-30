Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38AE04A389A
	for <lists+linux-iio@lfdr.de>; Sun, 30 Jan 2022 20:26:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355927AbiA3T0g (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 30 Jan 2022 14:26:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355929AbiA3T0d (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Jan 2022 14:26:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC92C061714
        for <linux-iio@vger.kernel.org>; Sun, 30 Jan 2022 11:26:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2FCECB829AF
        for <linux-iio@vger.kernel.org>; Sun, 30 Jan 2022 19:26:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80206C340F2;
        Sun, 30 Jan 2022 19:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643570790;
        bh=SPHkKQlgXlzBrZWPaT/PXgHi0Iipk9QCgoSKA4bsFxc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gKqErSli89o513tOrNv+NrYNgGQY86+aZ4Nk2sQBbVgea2z0JNacDD2iFkTiRcpFo
         qU8xZeu9ADTTvz98kW4HioStcXAKx8gvk/zuIl1c3GfscVH0VaiwZVUfmKPdyXuDlz
         vGlNAp/6SJOUULxQ7hxp4LSwDdPZU/zU2x/GT0+sMQB2V36Go6MrmG5DJHzicpiirc
         do1Kf3jQWx4wHs7lRCmoDWe5vl2SWEbCNo2AGK4zaLJkmsxnEtG2/TPAjHvOcS/MQJ
         WXmv86sECHzkCiEJrMy70wF1d3n4pHTXdXAojvXy/5cyZSZ8tMK0ITVCatCKqkdIwT
         ZRB1dmqrX4tjA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 26/50] iio:light:tcs3472: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr() etc
Date:   Sun, 30 Jan 2022 19:31:23 +0000
Message-Id: <20220130193147.279148-27-jic23@kernel.org>
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
 drivers/iio/light/tcs3472.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/light/tcs3472.c b/drivers/iio/light/tcs3472.c
index 371c6a39a165..823435f59bb6 100644
--- a/drivers/iio/light/tcs3472.c
+++ b/drivers/iio/light/tcs3472.c
@@ -572,7 +572,6 @@ static int tcs3472_remove(struct i2c_client *client)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int tcs3472_suspend(struct device *dev)
 {
 	struct tcs3472_data *data = iio_priv(i2c_get_clientdata(
@@ -598,9 +597,9 @@ static int tcs3472_resume(struct device *dev)
 
 	return ret;
 }
-#endif
 
-static SIMPLE_DEV_PM_OPS(tcs3472_pm_ops, tcs3472_suspend, tcs3472_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(tcs3472_pm_ops, tcs3472_suspend,
+				tcs3472_resume);
 
 static const struct i2c_device_id tcs3472_id[] = {
 	{ "tcs3472", 0 },
@@ -611,7 +610,7 @@ MODULE_DEVICE_TABLE(i2c, tcs3472_id);
 static struct i2c_driver tcs3472_driver = {
 	.driver = {
 		.name	= TCS3472_DRV_NAME,
-		.pm	= &tcs3472_pm_ops,
+		.pm	= pm_sleep_ptr(&tcs3472_pm_ops),
 	},
 	.probe		= tcs3472_probe,
 	.remove		= tcs3472_remove,
-- 
2.35.1

