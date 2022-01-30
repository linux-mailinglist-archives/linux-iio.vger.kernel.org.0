Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2D54A38AE
	for <lists+linux-iio@lfdr.de>; Sun, 30 Jan 2022 20:27:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355971AbiA3T1y (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 30 Jan 2022 14:27:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239120AbiA3T1Y (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Jan 2022 14:27:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF99AC061753
        for <linux-iio@vger.kernel.org>; Sun, 30 Jan 2022 11:27:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F625612BD
        for <linux-iio@vger.kernel.org>; Sun, 30 Jan 2022 19:27:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 093C5C340EB;
        Sun, 30 Jan 2022 19:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643570836;
        bh=46o7JnBQ88RBXZZPEwknt+KYyCs2caHlHKy68rlYUlo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HaMuObRqXVGJB7xYt4gW+41yV56IDORRdNBuRuMqNB5L5ucP8cBW+B25Dj1RFAJQb
         3xpFt+7oXnfjwCp6I3Fnonnx7/7YRfLtdcxLW70RRRGPCJI/PifeT6JQ+7PSKNIL+1
         nlQi5XghfcvK+RGx6zPiq9bpvbW1M4nNhfJWczwoz7qo0w5giKSMgy4KgN6kKj3gfM
         GjCSJq+URrQhmXvdmlo/DS9YRJw1xAdFfzFoVginbP/LkmqD3CbhVdhmiyWrBnN9AV
         dojGcuGDZLV8yps+FaPxYKCHnUGE62JWqtstWmsNniZ4QY04TElJ7CWQr+Iz7U1jHc
         iziD6EKLGDHlw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v3 46/50] iio:light:bh1780: Switch from CONFIG_PM guards to pm_ptr() etc
Date:   Sun, 30 Jan 2022 19:31:43 +0000
Message-Id: <20220130193147.279148-47-jic23@kernel.org>
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
without CONFIG_PM support is simpler and less error prone than the
use of #ifdef based config guards.

Use the new DEFINE_RUNTIME_DEV_PM_OPS to reduce boilerplate.

Removing instances of this approach from IIO also stops them being
copied into new drivers.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/light/bh1780.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/light/bh1780.c b/drivers/iio/light/bh1780.c
index abbf2e662e7d..790d3d613979 100644
--- a/drivers/iio/light/bh1780.c
+++ b/drivers/iio/light/bh1780.c
@@ -221,7 +221,6 @@ static int bh1780_remove(struct i2c_client *client)
 	return 0;
 }
 
-#ifdef CONFIG_PM
 static int bh1780_runtime_suspend(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
@@ -256,14 +255,9 @@ static int bh1780_runtime_resume(struct device *dev)
 
 	return 0;
 }
-#endif /* CONFIG_PM */
 
-static const struct dev_pm_ops bh1780_dev_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
-				pm_runtime_force_resume)
-	SET_RUNTIME_PM_OPS(bh1780_runtime_suspend,
-			   bh1780_runtime_resume, NULL)
-};
+static DEFINE_RUNTIME_DEV_PM_OPS(bh1780_dev_pm_ops, bh1780_runtime_suspend,
+				bh1780_runtime_resume, NULL);
 
 static const struct i2c_device_id bh1780_id[] = {
 	{ "bh1780", 0 },
@@ -284,7 +278,7 @@ static struct i2c_driver bh1780_driver = {
 	.id_table	= bh1780_id,
 	.driver = {
 		.name = "bh1780",
-		.pm = &bh1780_dev_pm_ops,
+		.pm = pm_ptr(&bh1780_dev_pm_ops),
 		.of_match_table = of_bh1780_match,
 	},
 };
-- 
2.35.1

