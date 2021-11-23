Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D86445AE0A
	for <lists+linux-iio@lfdr.de>; Tue, 23 Nov 2021 22:07:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240334AbhKWVKi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 23 Nov 2021 16:10:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:40474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239635AbhKWVKd (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 23 Nov 2021 16:10:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0AC3460FE7;
        Tue, 23 Nov 2021 21:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637701643;
        bh=867xwiImbbcYCPHk9Q7wJlRPxcEFxSBNxxo/sqbKcB8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nlgDJFNuTZYlzGmUfvTa4oKLpQmlku9by2ek308M5/L+51HvCa0pR28asiC1Ae3mT
         bMzg5ddxULI/jqDbOOdRoIYJ80NZT6s4MW3TyPqX0jxHkItAlYwz+xis6xBIe9E72q
         HWaM2tlF0rxQ3yNyMX5XKWRvlMmIpV4kBzTUOJ4btD19N3JxtWomYF2lQo/jIUbvTo
         MgzKAnYl0HqwjZKZZ5JBrhIu8/4qXftNNlEExG2bfTMSy4E+ilkTf79DdsrMVUxrpE
         RHVopG66FmYAugiPVKtTESU78Q6s4gh/OdrhNKW7I6vuN3RbxyaP1Oib9cPYvgDKQX
         7Lw/FI+kWkyUg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Manivannan Sadhasivam <mani@kernel.org>
Subject: [PATCH 47/49] iio:temperature:tmp007: Switch from CONFIG_PM_SLEEP guards to pm_ptr() / __maybe_unused
Date:   Tue, 23 Nov 2021 21:10:17 +0000
Message-Id: <20211123211019.2271440-48-jic23@kernel.org>
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
without CONFIG_PM_SLEEP support is simpler and less error prone than the
use of #ifdef based config guards.

Removing instances of this approach from IIO also stops them being
copied into new drivers.

The pm_ptr() macro only removes the reference if CONFIG_PM is not
set. It is possible for CONFIG_PM=y without CONFIG_SLEEP, so this
will not always remove the pm_ops structure.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>
---
 drivers/iio/temperature/tmp007.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/temperature/tmp007.c b/drivers/iio/temperature/tmp007.c
index b422371a4674..9a1b7f63500e 100644
--- a/drivers/iio/temperature/tmp007.c
+++ b/drivers/iio/temperature/tmp007.c
@@ -537,8 +537,7 @@ static int tmp007_probe(struct i2c_client *client,
 	return devm_iio_device_register(&client->dev, indio_dev);
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int tmp007_suspend(struct device *dev)
+static __maybe_unused int tmp007_suspend(struct device *dev)
 {
 	struct tmp007_data *data = iio_priv(i2c_get_clientdata(
 			to_i2c_client(dev)));
@@ -546,7 +545,7 @@ static int tmp007_suspend(struct device *dev)
 	return tmp007_powerdown(data);
 }
 
-static int tmp007_resume(struct device *dev)
+static __maybe_unused int tmp007_resume(struct device *dev)
 {
 	struct tmp007_data *data = iio_priv(i2c_get_clientdata(
 			to_i2c_client(dev)));
@@ -554,7 +553,6 @@ static int tmp007_resume(struct device *dev)
 	return i2c_smbus_write_word_swapped(data->client, TMP007_CONFIG,
 			data->config | TMP007_CONFIG_CONV_EN);
 }
-#endif
 
 static SIMPLE_DEV_PM_OPS(tmp007_pm_ops, tmp007_suspend, tmp007_resume);
 
@@ -574,7 +572,7 @@ static struct i2c_driver tmp007_driver = {
 	.driver = {
 		.name	= "tmp007",
 		.of_match_table = tmp007_of_match,
-		.pm	= &tmp007_pm_ops,
+		.pm	= pm_ptr(&tmp007_pm_ops),
 	},
 	.probe		= tmp007_probe,
 	.id_table	= tmp007_id,
-- 
2.34.0

