Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5067045ADFE
	for <lists+linux-iio@lfdr.de>; Tue, 23 Nov 2021 22:07:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240259AbhKWVKV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 23 Nov 2021 16:10:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:40342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239697AbhKWVKL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 23 Nov 2021 16:10:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E81BE60FD8;
        Tue, 23 Nov 2021 21:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637701622;
        bh=8BjqzG3s6UGxSA/9rRtzhwtLf+eeayN7bA7C4l0zmJk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QBFwdePV+8Q+IrUvPipBq1H+qtX1HEVkBXHS1EcsBN4lyL7FXwtGD8+crDsUiWKh2
         LeS0WNesxZRDHKWexj0xyiK9nMTZXEJ/94FlfegYUnx/hZYzBRGXYgreC8UbhRf22N
         f7A6beGGVb37uH4yABvcvcRSRH1sRh7QfCBDP5NWoyuLjhkXry8kbL1vjFB+BRPtBy
         X/V02gu3hiuXnmC1yM5Scb7LGi91Go+7p28aM8hfaqWufad3xyG4hnKOoxrzez3mTu
         i3rtCDyUidy8ocTf+BjU8OFshZkG/G4ylHF9/L0S71PntoEkYtF7w+iO+jw5FU/WYH
         6IKRpGZa7amdA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Jonathan Albrieux <jonathan.albrieux@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 36/49] iio:magn:ak8975: Switch from CONFIG_PM guards to pm_ptr() / __maybe_unused
Date:   Tue, 23 Nov 2021 21:10:06 +0000
Message-Id: <20211123211019.2271440-37-jic23@kernel.org>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211123211019.2271440-1-jic23@kernel.org>
References: <20211123211019.2271440-1-jic23@kernel.org>
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

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Matt Ranostay <matt.ranostay@konsulko.com>
Cc: Jonathan Albrieux <jonathan.albrieux@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/iio/magnetometer/ak8975.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index 6e82dc54a417..ced3e674eb5f 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -1033,8 +1033,7 @@ static int ak8975_remove(struct i2c_client *client)
 	return 0;
 }
 
-#ifdef CONFIG_PM
-static int ak8975_runtime_suspend(struct device *dev)
+static __maybe_unused int ak8975_runtime_suspend(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
@@ -1053,7 +1052,7 @@ static int ak8975_runtime_suspend(struct device *dev)
 	return 0;
 }
 
-static int ak8975_runtime_resume(struct device *dev)
+static __maybe_unused int ak8975_runtime_resume(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
@@ -1074,9 +1073,8 @@ static int ak8975_runtime_resume(struct device *dev)
 
 	return 0;
 }
-#endif /* CONFIG_PM */
 
-static const struct dev_pm_ops ak8975_dev_pm_ops = {
+static __maybe_unused const struct dev_pm_ops ak8975_dev_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
 				pm_runtime_force_resume)
 	SET_RUNTIME_PM_OPS(ak8975_runtime_suspend,
@@ -1113,7 +1111,7 @@ MODULE_DEVICE_TABLE(of, ak8975_of_match);
 static struct i2c_driver ak8975_driver = {
 	.driver = {
 		.name	= "ak8975",
-		.pm = &ak8975_dev_pm_ops,
+		.pm = pm_ptr(&ak8975_dev_pm_ops),
 		.of_match_table = ak8975_of_match,
 		.acpi_match_table = ak_acpi_match,
 	},
-- 
2.34.0

