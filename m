Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17A674A38B0
	for <lists+linux-iio@lfdr.de>; Sun, 30 Jan 2022 20:27:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355975AbiA3T15 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 30 Jan 2022 14:27:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355978AbiA3T1Y (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Jan 2022 14:27:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2456C061756
        for <linux-iio@vger.kernel.org>; Sun, 30 Jan 2022 11:27:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 82420612EE
        for <linux-iio@vger.kernel.org>; Sun, 30 Jan 2022 19:27:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4182EC340EF;
        Sun, 30 Jan 2022 19:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643570842;
        bh=P4J2NsxIS8e07oLXQjfVABLnQ0hru+D8DJH9GkU/HcE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PQIF0uBzMLeVAAzMf8ybM10YMER3Lxm0zy+5siCNLXa065QUGOgZQQZO69lz1lBIj
         DuYM8T6ObAnDiGonm58DlMNToT/vYCSiNS8BRswQWThLdIsv+kKvJxf9gXPqlGHWL/
         4Yr6Rk3Iscc5edUy+iPWZagN91b93rNpKGHQgu6lITcb/X66LBBo283/R/onAp2YOt
         4+yactPk2f6y1pe4+C7szRPv60NSQgcWnYqLhxXJT4lT2Knz/hRFh8/GsVE20x1KMN
         6CTxR6YlF8xHMSr/pzZHCMKZHy5mDVbYvYjHQ3rdOZJmZ76mjqwowkFwUD6yX4Hpp3
         7XiKQX9cy/fjg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>
Subject: [PATCH v3 48/50] iio:chemical:atlas: Switch from CONFIG_PM guards to pm_ptr() etc
Date:   Sun, 30 Jan 2022 19:31:45 +0000
Message-Id: <20220130193147.279148-49-jic23@kernel.org>
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

Removing instances of this approach from IIO also stops them being
copied into new drivers.

Acked-by: Matt Ranostay <matt.ranostay@konsulko.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/chemical/atlas-sensor.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/chemical/atlas-sensor.c b/drivers/iio/chemical/atlas-sensor.c
index a8211dd20b35..56dea9734c8d 100644
--- a/drivers/iio/chemical/atlas-sensor.c
+++ b/drivers/iio/chemical/atlas-sensor.c
@@ -737,7 +737,6 @@ static int atlas_remove(struct i2c_client *client)
 	return atlas_set_powermode(data, 0);
 }
 
-#ifdef CONFIG_PM
 static int atlas_runtime_suspend(struct device *dev)
 {
 	struct atlas_data *data =
@@ -753,18 +752,16 @@ static int atlas_runtime_resume(struct device *dev)
 
 	return atlas_set_powermode(data, 1);
 }
-#endif
 
 static const struct dev_pm_ops atlas_pm_ops = {
-	SET_RUNTIME_PM_OPS(atlas_runtime_suspend,
-			   atlas_runtime_resume, NULL)
+	RUNTIME_PM_OPS(atlas_runtime_suspend, atlas_runtime_resume, NULL)
 };
 
 static struct i2c_driver atlas_driver = {
 	.driver = {
 		.name	= ATLAS_DRV_NAME,
 		.of_match_table	= atlas_dt_ids,
-		.pm	= &atlas_pm_ops,
+		.pm	= pm_ptr(&atlas_pm_ops),
 	},
 	.probe		= atlas_probe,
 	.remove		= atlas_remove,
-- 
2.35.1

