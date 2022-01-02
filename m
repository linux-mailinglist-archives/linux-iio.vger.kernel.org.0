Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DACC482B39
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jan 2022 13:52:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232341AbiABMwG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 2 Jan 2022 07:52:06 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:50728 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiABMwG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Jan 2022 07:52:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 06515B80CFC
        for <linux-iio@vger.kernel.org>; Sun,  2 Jan 2022 12:52:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B30D5C36AEF;
        Sun,  2 Jan 2022 12:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641127923;
        bh=VwPk5H64KUpKe+x0yB3Zc0wFvDFV6P5KJxSj7sBMFgY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aWXBs7w+1o1bdPAWt8xSDgiWxZerYQHwFpA3NW+BMFDdbcEIbFT4kqiVPoYWGBq9S
         RkorO9NdlfJK6mE05/XLS6SC9Zzr3ku2u7bTny9Li8THv5ueC7/maqQRQRJyFFTfpT
         6Dpm6dSnGEiNL91d2KNvDT0A+gNtoxkhbfMf7CJ3LCNF1XkzAhYyJm2fG+ceow3/l1
         tXHSLVqPV01QjSB57gpDfnn7/ltJGPlQpCPkK6S8/rf81zniDTJKZWfEyA7pwGjOHD
         mCHmlxiJpYYKbHxSoxjVC2NR7DU9l4BzyqgtBgwnuOcP34mVHLXX4qpsDs2+MDRWy3
         k/ir/0fTuQlxg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 26/51] iio:light:isl29125: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr() etc
Date:   Sun,  2 Jan 2022 12:55:52 +0000
Message-Id: <20220102125617.1259804-27-jic23@kernel.org>
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
---
 drivers/iio/light/isl29125.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/light/isl29125.c b/drivers/iio/light/isl29125.c
index ba53b50d711a..756015b5cfd6 100644
--- a/drivers/iio/light/isl29125.c
+++ b/drivers/iio/light/isl29125.c
@@ -311,7 +311,6 @@ static int isl29125_remove(struct i2c_client *client)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int isl29125_suspend(struct device *dev)
 {
 	struct isl29125_data *data = iio_priv(i2c_get_clientdata(
@@ -326,9 +325,8 @@ static int isl29125_resume(struct device *dev)
 	return i2c_smbus_write_byte_data(data->client, ISL29125_CONF1,
 		data->conf1);
 }
-#endif
 
-static SIMPLE_DEV_PM_OPS(isl29125_pm_ops, isl29125_suspend, isl29125_resume);
+DEFINE_SIMPLE_DEV_PM_OPS(isl29125_pm_ops, isl29125_suspend, isl29125_resume);
 
 static const struct i2c_device_id isl29125_id[] = {
 	{ "isl29125", 0 },
@@ -339,7 +337,7 @@ MODULE_DEVICE_TABLE(i2c, isl29125_id);
 static struct i2c_driver isl29125_driver = {
 	.driver = {
 		.name	= ISL29125_DRV_NAME,
-		.pm	= &isl29125_pm_ops,
+		.pm	= pm_sleep_ptr(&isl29125_pm_ops),
 	},
 	.probe		= isl29125_probe,
 	.remove		= isl29125_remove,
-- 
2.34.1

