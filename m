Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA754A38A4
	for <lists+linux-iio@lfdr.de>; Sun, 30 Jan 2022 20:27:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355951AbiA3T1J (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 30 Jan 2022 14:27:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355953AbiA3T0y (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Jan 2022 14:26:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E81FFC061714
        for <linux-iio@vger.kernel.org>; Sun, 30 Jan 2022 11:26:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 87804612EA
        for <linux-iio@vger.kernel.org>; Sun, 30 Jan 2022 19:26:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45C4BC340EB;
        Sun, 30 Jan 2022 19:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643570813;
        bh=SnK+3mPb0mpEwkTUzk1HX9dIbRJIxuNqG/rKKPgnt2Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HL/wOXBY4JljMmLgFwl2q8PmaAHGnSOBQaeYcWkDBd/WV7NJUCY4uHOOgbv1ZKH3n
         ip9FyF9sEoSLOr27nwRB/XDyE/xzl9O7860XLrXSiRr9p1QJi/DM6FeQcslxKI1uDW
         UssLyJE7Dqa04MIxQGtPso9NDNYgr88cP5NGW58ip+3KcmRyR5vXLD8G6jKC9uLgEq
         1h/NN//+ZnHska/oqir6tLxKnA+pp49wxuJOx3kJvfe8LQowPfadZYJ9NMqU2MNZq0
         ZmXmWmSe3uDguC4oDFoXgLHxhSVoJevmEgZ78mi5OUoZSWcEvE1ADsc2y2uVUa7WOi
         pNqLm94rqbOYQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 36/50] iio:temperature:tmp006: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr() etc
Date:   Sun, 30 Jan 2022 19:31:33 +0000
Message-Id: <20220130193147.279148-37-jic23@kernel.org>
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
 drivers/iio/temperature/tmp006.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/temperature/tmp006.c b/drivers/iio/temperature/tmp006.c
index e4943a0bc9aa..706a760f30b4 100644
--- a/drivers/iio/temperature/tmp006.c
+++ b/drivers/iio/temperature/tmp006.c
@@ -261,7 +261,6 @@ static int tmp006_probe(struct i2c_client *client,
 	return devm_iio_device_register(&client->dev, indio_dev);
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int tmp006_suspend(struct device *dev)
 {
 	return tmp006_power(dev, false);
@@ -271,9 +270,8 @@ static int tmp006_resume(struct device *dev)
 {
 	return tmp006_power(dev, true);
 }
-#endif
 
-static SIMPLE_DEV_PM_OPS(tmp006_pm_ops, tmp006_suspend, tmp006_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(tmp006_pm_ops, tmp006_suspend, tmp006_resume);
 
 static const struct i2c_device_id tmp006_id[] = {
 	{ "tmp006", 0 },
@@ -284,7 +282,7 @@ MODULE_DEVICE_TABLE(i2c, tmp006_id);
 static struct i2c_driver tmp006_driver = {
 	.driver = {
 		.name	= "tmp006",
-		.pm	= &tmp006_pm_ops,
+		.pm	= pm_sleep_ptr(&tmp006_pm_ops),
 	},
 	.probe = tmp006_probe,
 	.id_table = tmp006_id,
-- 
2.35.1

