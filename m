Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98E88482B3F
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jan 2022 13:52:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232372AbiABMwV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 2 Jan 2022 07:52:21 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:42574 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232279AbiABMwU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Jan 2022 07:52:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9195E60E98
        for <linux-iio@vger.kernel.org>; Sun,  2 Jan 2022 12:52:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B08D1C36AF0;
        Sun,  2 Jan 2022 12:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641127940;
        bh=/Z1TG5WRwvD6r/g9w+mv+ybatRDs4GbcGq34P7E0Onc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eTCQd6Z+Vk7Zz8TCIoBJ/BxfvQAsBDN8e0hjwVokjS0hEQV3ZsCu7pe76kW9XKWwj
         b4v6np/xer5o6s7OUHb7ChMaydEScTLPZ9XR2MVkrSdj3t2YS5fzB50e3r77UUF1iT
         A7B2AdyR15oamrsPHmUg4wsoTsM/gGlQCqDEmIIfidyTXjtrjnOYbe5X8JsDcnYAAm
         qDD2jgRh6W4GzbCQ/3tG5xXyNCS2aiuyjuVOx6IlFTc8QBeWgkFunWfW3xhNyK495h
         By1rX98voM7BdVurL9/AJy0httcVdE4V0IxSkktas0tTZv9uEYa0FtHCFoXvnLCqXh
         ECFRVJq9SJTJA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vaishnav M A <vaishnav@beagleboard.org>
Subject: [PATCH v2 32/51] iio:light:tsl2563: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr() etc
Date:   Sun,  2 Jan 2022 12:55:58 +0000
Message-Id: <20220102125617.1259804-33-jic23@kernel.org>
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
Cc: Vaishnav M A <vaishnav@beagleboard.org>
---
 drivers/iio/light/tsl2563.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/light/tsl2563.c b/drivers/iio/light/tsl2563.c
index 5bf2bfbc5379..f3ad3158b199 100644
--- a/drivers/iio/light/tsl2563.c
+++ b/drivers/iio/light/tsl2563.c
@@ -814,7 +814,6 @@ static int tsl2563_remove(struct i2c_client *client)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int tsl2563_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
@@ -857,11 +856,7 @@ static int tsl2563_resume(struct device *dev)
 	return ret;
 }
 
-static SIMPLE_DEV_PM_OPS(tsl2563_pm_ops, tsl2563_suspend, tsl2563_resume);
-#define TSL2563_PM_OPS (&tsl2563_pm_ops)
-#else
-#define TSL2563_PM_OPS NULL
-#endif
+DEFINE_SIMPLE_DEV_PM_OPS(tsl2563_pm_ops, tsl2563_suspend, tsl2563_resume);
 
 static const struct i2c_device_id tsl2563_id[] = {
 	{ "tsl2560", 0 },
@@ -885,7 +880,7 @@ static struct i2c_driver tsl2563_i2c_driver = {
 	.driver = {
 		.name	 = "tsl2563",
 		.of_match_table = tsl2563_of_match,
-		.pm	= TSL2563_PM_OPS,
+		.pm	= pm_sleep_ptr(&tsl2563_pm_ops),
 	},
 	.probe		= tsl2563_probe,
 	.remove		= tsl2563_remove,
-- 
2.34.1

