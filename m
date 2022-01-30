Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 468E64A3896
	for <lists+linux-iio@lfdr.de>; Sun, 30 Jan 2022 20:26:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355917AbiA3T0Z (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 30 Jan 2022 14:26:25 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:36152 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355930AbiA3T0Y (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Jan 2022 14:26:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E9EBC612EA
        for <linux-iio@vger.kernel.org>; Sun, 30 Jan 2022 19:26:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0DB3C340E4;
        Sun, 30 Jan 2022 19:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643570783;
        bh=BD8PvWk4VweyI28pAA6l+tXi91Rl+/BQ/1d0+KokOBw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TBpksewCqGBxd4aXzZ3uBlbk4QJ7z4F8NKeAK5lCEiV4N/po+0AYi5pLN1z4yZ+ky
         ja7YIwPV52Eal25Pb6dDJ/ZBOmDisDGQLz64pAIoNuNFd7Nff9UzwUzk9aFP0dIIWb
         x00w2MdkB0bNYGp+dFQ4w7mevJzpnyqdpUq4U8vnw5k6yJEympKN/JGPMsDEEuZTpG
         TZwMZikwwlSxhHiDalqT0USucO2cuWcAwT81jiapBUL+nR43sR4dKdnDlq0vb2ilwZ
         V8dg5BMa8n2452P54oZLXkz68r+JiWfrXJhoy5chUMdU8OapfSJwLsa+i8b3Q1rWnk
         X1MEtudaN52MA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Maslov Dmitry <maslovdmitry@seeed.cc>
Subject: [PATCH v3 23/50] iio:light:ltr501: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr() etc
Date:   Sun, 30 Jan 2022 19:31:20 +0000
Message-Id: <20220130193147.279148-24-jic23@kernel.org>
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
Cc: Maslov Dmitry <maslovdmitry@seeed.cc>
---
 drivers/iio/light/ltr501.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
index d1532ef5f08b..679a1e1086ae 100644
--- a/drivers/iio/light/ltr501.c
+++ b/drivers/iio/light/ltr501.c
@@ -1611,7 +1611,6 @@ static int ltr501_remove(struct i2c_client *client)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int ltr501_suspend(struct device *dev)
 {
 	struct ltr501_data *data = iio_priv(i2c_get_clientdata(
@@ -1627,9 +1626,8 @@ static int ltr501_resume(struct device *dev)
 	return ltr501_write_contr(data, data->als_contr,
 		data->ps_contr);
 }
-#endif
 
-static SIMPLE_DEV_PM_OPS(ltr501_pm_ops, ltr501_suspend, ltr501_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(ltr501_pm_ops, ltr501_suspend, ltr501_resume);
 
 static const struct acpi_device_id ltr_acpi_match[] = {
 	{ "LTER0501", ltr501 },
@@ -1661,7 +1659,7 @@ static struct i2c_driver ltr501_driver = {
 	.driver = {
 		.name   = LTR501_DRV_NAME,
 		.of_match_table = ltr501_of_match,
-		.pm	= &ltr501_pm_ops,
+		.pm	= pm_sleep_ptr(&ltr501_pm_ops),
 		.acpi_match_table = ACPI_PTR(ltr_acpi_match),
 	},
 	.probe  = ltr501_probe,
-- 
2.35.1

