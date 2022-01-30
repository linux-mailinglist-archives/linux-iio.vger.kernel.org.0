Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2B94A3882
	for <lists+linux-iio@lfdr.de>; Sun, 30 Jan 2022 20:25:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355863AbiA3TZk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 30 Jan 2022 14:25:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355830AbiA3TZj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Jan 2022 14:25:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4E72C061714
        for <linux-iio@vger.kernel.org>; Sun, 30 Jan 2022 11:25:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 51D91612FA
        for <linux-iio@vger.kernel.org>; Sun, 30 Jan 2022 19:25:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC44BC340F0;
        Sun, 30 Jan 2022 19:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643570738;
        bh=Y/g/2m5Cn6oOac6URakBQDgP7bRkWL2SmqjtoPYrTQc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VglIxQt9+qwb99/HjuCmt0r+CgyyqZKTAm7WyB/1enfh1ScTIL6QubxVHlDP0aQbx
         I6bvPmTrTDnsIS4nq3y9CKKJltxnTijz/NmbFYErOZidZYmhPZTJJW4/spfMR/4dus
         rqvGlWMP/6mB9rZQbgLEUMlvxiZPAxZjIlKaxscGK+yW/Rq8IC+KkWdcYB/T+LJSQo
         xDXKG3cVxb+4qKBRSg+FFkpZQNSBfERhp6JZUweV4Xi2fntnIhhz2ttBji4b/X9P49
         7y5taVlqozCE7SgQ9Iy89gOHuIHhFP7PTXoY9YCovTpCyX9RHqyHWyL8P6f8adsanN
         dnQpp2wPHDvlg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 02/50] iio:accel:da280: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr() etc
Date:   Sun, 30 Jan 2022 19:30:59 +0000
Message-Id: <20220130193147.279148-3-jic23@kernel.org>
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
 drivers/iio/accel/da280.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/accel/da280.c b/drivers/iio/accel/da280.c
index 9633bdae5fd4..04e9c5678964 100644
--- a/drivers/iio/accel/da280.c
+++ b/drivers/iio/accel/da280.c
@@ -153,7 +153,6 @@ static int da280_probe(struct i2c_client *client,
 	return devm_iio_device_register(&client->dev, indio_dev);
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int da280_suspend(struct device *dev)
 {
 	return da280_enable(to_i2c_client(dev), false);
@@ -163,9 +162,8 @@ static int da280_resume(struct device *dev)
 {
 	return da280_enable(to_i2c_client(dev), true);
 }
-#endif
 
-static SIMPLE_DEV_PM_OPS(da280_pm_ops, da280_suspend, da280_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(da280_pm_ops, da280_suspend, da280_resume);
 
 static const struct acpi_device_id da280_acpi_match[] = {
 	{"MIRAACC", da280},
@@ -184,7 +182,7 @@ static struct i2c_driver da280_driver = {
 	.driver = {
 		.name = "da280",
 		.acpi_match_table = ACPI_PTR(da280_acpi_match),
-		.pm = &da280_pm_ops,
+		.pm = pm_sleep_ptr(&da280_pm_ops),
 	},
 	.probe		= da280_probe,
 	.id_table	= da280_i2c_id,
-- 
2.35.1

