Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58537482B4B
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jan 2022 13:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232384AbiABMw4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 2 Jan 2022 07:52:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbiABMw4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Jan 2022 07:52:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 684C5C061574
        for <linux-iio@vger.kernel.org>; Sun,  2 Jan 2022 04:52:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0656960E9A
        for <linux-iio@vger.kernel.org>; Sun,  2 Jan 2022 12:52:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B211DC36AEE;
        Sun,  2 Jan 2022 12:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641127975;
        bh=RTGuq52F8z6ExADzGunQn3KRLpzrAb/KpNyG7Otixlw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c/C1oe8dMLsoMNFuZRpb9efR7mAx6SUD5l+fbApF7mP0f96th7IRGZIgj26Te6LEy
         DNP7JIKs2IxfDmO+mPveDlUG9ctyIfQptJVpgon0VUJBA62KinkHk7qaUBYD0H0FVG
         gySD/+uZdlVugCaJQJfzy+SdVA5WqTj9pNZPYvLJDAAJYSU9brjcgSLatag38EL+dD
         XZBArNG9mwETp0LRiABISjwzGCa7VVdETJrqqyuofoybrBibuRBzDR4FQ8SSzJfKIo
         /dflgNWbwg8iqaWee2jjDQq1XL4iWrz/rZG+cu1VFT2Bu8Mpwu/J11hy1UsZ7ClVUf
         xToa/rKraWezQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Manivannan Sadhasivam <mani@kernel.org>
Subject: [PATCH v2 44/51] iio:temperature:tmp007: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr() etc
Date:   Sun,  2 Jan 2022 12:56:10 +0000
Message-Id: <20220102125617.1259804-45-jic23@kernel.org>
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
Cc: Manivannan Sadhasivam <mani@kernel.org>
---
 drivers/iio/temperature/tmp007.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/temperature/tmp007.c b/drivers/iio/temperature/tmp007.c
index b422371a4674..f7a040f0ee4c 100644
--- a/drivers/iio/temperature/tmp007.c
+++ b/drivers/iio/temperature/tmp007.c
@@ -537,7 +537,6 @@ static int tmp007_probe(struct i2c_client *client,
 	return devm_iio_device_register(&client->dev, indio_dev);
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int tmp007_suspend(struct device *dev)
 {
 	struct tmp007_data *data = iio_priv(i2c_get_clientdata(
@@ -554,9 +553,8 @@ static int tmp007_resume(struct device *dev)
 	return i2c_smbus_write_word_swapped(data->client, TMP007_CONFIG,
 			data->config | TMP007_CONFIG_CONV_EN);
 }
-#endif
 
-static SIMPLE_DEV_PM_OPS(tmp007_pm_ops, tmp007_suspend, tmp007_resume);
+DEFINE_SIMPLE_DEV_PM_OPS(tmp007_pm_ops, tmp007_suspend, tmp007_resume);
 
 static const struct of_device_id tmp007_of_match[] = {
 	{ .compatible = "ti,tmp007", },
@@ -574,7 +572,7 @@ static struct i2c_driver tmp007_driver = {
 	.driver = {
 		.name	= "tmp007",
 		.of_match_table = tmp007_of_match,
-		.pm	= &tmp007_pm_ops,
+		.pm	= pm_sleep_ptr(&tmp007_pm_ops),
 	},
 	.probe		= tmp007_probe,
 	.id_table	= tmp007_id,
-- 
2.34.1

