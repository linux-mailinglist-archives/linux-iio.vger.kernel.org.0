Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7005D4A3894
	for <lists+linux-iio@lfdr.de>; Sun, 30 Jan 2022 20:26:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355910AbiA3T0S (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 30 Jan 2022 14:26:18 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:36088 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355914AbiA3T0R (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Jan 2022 14:26:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B1C23612BD
        for <linux-iio@vger.kernel.org>; Sun, 30 Jan 2022 19:26:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52B12C340EB;
        Sun, 30 Jan 2022 19:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643570777;
        bh=fCfqJOCjGwNlkcgzKvP8D9koX+s/mmqEK1M+TUxdTdk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NnUKEBbiIws1QJOyg4DW6zwoN8ynp98p77Mx0DLl0JjHnaJEtXEYNgsvTWc1/ptWO
         KGVbpzM9meFU73exWZf69Nu+nmxLn8pxwkssybdvihzlUJOCPC8rp91crUnN/K6N+/
         uisvxla1i04Ji7G1RuhUSQsFXbilC6lspbRFlCZuasJLB+zJVMnWSKUGN+hJvh7msJ
         U6RL8AeoKdH2aZC48+vlkndoONxBsbiR8Bmxjqin0CXQUm7I+P0Bzdng+jzhKXlr24
         meMLInmtu9s+xyhV4N6FNhCYB3kxVYVgx2HGxzAEMd9K6hb4ShksYubNDgDUEhjsqt
         3oAbjdGwxRd/Q==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Anson Huang <anson.huang@nxp.com>,
        Brian Masney <masneyb@onstation.org>
Subject: [PATCH v3 20/50] iio:light:isl29018: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr()
Date:   Sun, 30 Jan 2022 19:31:17 +0000
Message-Id: <20220130193147.279148-21-jic23@kernel.org>
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
Cc: Anson Huang <anson.huang@nxp.com>
Cc: Brian Masney <masneyb@onstation.org>
---
 drivers/iio/light/isl29018.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/light/isl29018.c b/drivers/iio/light/isl29018.c
index 2689867467a8..b36f8b7ca68e 100644
--- a/drivers/iio/light/isl29018.c
+++ b/drivers/iio/light/isl29018.c
@@ -784,7 +784,6 @@ static int isl29018_probe(struct i2c_client *client,
 	return devm_iio_device_register(&client->dev, indio_dev);
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int isl29018_suspend(struct device *dev)
 {
 	struct isl29018_chip *chip = iio_priv(dev_get_drvdata(dev));
@@ -830,11 +829,8 @@ static int isl29018_resume(struct device *dev)
 	return err;
 }
 
-static SIMPLE_DEV_PM_OPS(isl29018_pm_ops, isl29018_suspend, isl29018_resume);
-#define ISL29018_PM_OPS (&isl29018_pm_ops)
-#else
-#define ISL29018_PM_OPS NULL
-#endif
+static DEFINE_SIMPLE_DEV_PM_OPS(isl29018_pm_ops, isl29018_suspend,
+				isl29018_resume);
 
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id isl29018_acpi_match[] = {
@@ -866,7 +862,7 @@ static struct i2c_driver isl29018_driver = {
 	.driver	 = {
 			.name = "isl29018",
 			.acpi_match_table = ACPI_PTR(isl29018_acpi_match),
-			.pm = ISL29018_PM_OPS,
+			.pm = pm_sleep_ptr(&isl29018_pm_ops),
 			.of_match_table = isl29018_of_match,
 		    },
 	.probe	 = isl29018_probe,
-- 
2.35.1

