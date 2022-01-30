Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9CD4A3885
	for <lists+linux-iio@lfdr.de>; Sun, 30 Jan 2022 20:25:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355889AbiA3TZv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 30 Jan 2022 14:25:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355869AbiA3TZs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Jan 2022 14:25:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E291C061714
        for <linux-iio@vger.kernel.org>; Sun, 30 Jan 2022 11:25:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DB0E7B829AB
        for <linux-iio@vger.kernel.org>; Sun, 30 Jan 2022 19:25:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7764C340E4;
        Sun, 30 Jan 2022 19:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643570745;
        bh=kwS4InBMSPD9zecdfjU085olJk/xJ+Afe4sUYQaSdLk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FFllKuspG/i4w6GtvOiVuyuYSWlv3c1DFWHme0faj9oTUlcLRmF5X2kB9r/HknLK1
         MGtCFnUM7kufBoC1DyFpd0M8Wi3OKcbMPOzmy8c9p1n80v4ytkhASnhwlcR0JORHF+
         CQ+V2QZS2NHY/iya+CmgiuIu4G1gxN0UQVYVNViAB7PALLov16GZeuEF0BaTO5mqV8
         4+XbifHFTvsZe5ONAwqHg5X9cV4GmzyFo/i+lBJlDTKTdPJYwKUKXl4fFyRSRGP5EL
         pS6oOctEVQ4oN995ta1e29E5ll4vvB9UbTHt15Jn0OxN4OjfTFVMYE8qcVz6uAx68F
         DE82ANAjxfsCw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v3 05/50] iio:accel:mc3230: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr() etc
Date:   Sun, 30 Jan 2022 19:31:02 +0000
Message-Id: <20220130193147.279148-6-jic23@kernel.org>
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
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/iio/accel/mc3230.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/accel/mc3230.c b/drivers/iio/accel/mc3230.c
index 735002b716f3..679e69cd7657 100644
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
+static DEFINE_SIMPLE_DEV_PM_OPS(mc3230_pm_ops, mc3230_suspend, mc3230_resume);
 
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
2.35.1

