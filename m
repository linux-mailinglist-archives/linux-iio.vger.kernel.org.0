Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8299B4A38A7
	for <lists+linux-iio@lfdr.de>; Sun, 30 Jan 2022 20:27:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355958AbiA3T1U (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 30 Jan 2022 14:27:20 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:51858 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355961AbiA3T1C (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Jan 2022 14:27:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C7548B829B3
        for <linux-iio@vger.kernel.org>; Sun, 30 Jan 2022 19:27:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F834C340F1;
        Sun, 30 Jan 2022 19:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643570820;
        bh=jxNYpj8GpbsDBl40e15E7p1SzBUgjtIY4AJF15c/PPk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zr2NbBGDh5aDWskbgyPFF1LosQvR2P2vA/v64E7Z6LUlZb/zHIORg8YZBLxhfnh/N
         By2R2Z6+skTpaFiQkZMkuKRfJ2hFR7vW0tpsnXwSadsJJmrofQO9mL2beHzs4ehcA5
         gojQJTiIlR2ERFguqlBaFIyoIEcPEfwaAUdv6YAeriXdPzVEGPIbn2kVUUaEuof5Jd
         +T42zqEnMUyadvc4jDnPGJEQ5it00SQHVk1eS6V95/zEk591SuVVXAb0xNA9xLZTMl
         YzPJlgDTy8YKraGQGzy0Q4Esb9czSIBy+kPARWMunp6l3ReUUh7WwAAvktBB+uknb3
         Tqhok6qrVDbJA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 39/50] iio:accel:bma180: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr() etc
Date:   Sun, 30 Jan 2022 19:31:36 +0000
Message-Id: <20220130193147.279148-40-jic23@kernel.org>
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
 drivers/iio/accel/bma180.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
index d8a454c266d5..4f73bc827eec 100644
--- a/drivers/iio/accel/bma180.c
+++ b/drivers/iio/accel/bma180.c
@@ -1065,7 +1065,6 @@ static int bma180_remove(struct i2c_client *client)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int bma180_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
@@ -1092,11 +1091,7 @@ static int bma180_resume(struct device *dev)
 	return ret;
 }
 
-static SIMPLE_DEV_PM_OPS(bma180_pm_ops, bma180_suspend, bma180_resume);
-#define BMA180_PM_OPS (&bma180_pm_ops)
-#else
-#define BMA180_PM_OPS NULL
-#endif
+static DEFINE_SIMPLE_DEV_PM_OPS(bma180_pm_ops, bma180_suspend, bma180_resume);
 
 static const struct i2c_device_id bma180_ids[] = {
 	{ "bma023", BMA023 },
@@ -1137,7 +1132,7 @@ MODULE_DEVICE_TABLE(of, bma180_of_match);
 static struct i2c_driver bma180_driver = {
 	.driver = {
 		.name	= "bma180",
-		.pm	= BMA180_PM_OPS,
+		.pm	= pm_sleep_ptr(&bma180_pm_ops),
 		.of_match_table = bma180_of_match,
 	},
 	.probe		= bma180_probe,
-- 
2.35.1

