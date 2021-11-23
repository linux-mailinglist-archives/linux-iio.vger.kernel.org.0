Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB8945AE0B
	for <lists+linux-iio@lfdr.de>; Tue, 23 Nov 2021 22:07:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239635AbhKWVKi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 23 Nov 2021 16:10:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:40494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239859AbhKWVKg (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 23 Nov 2021 16:10:36 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3B0F260FC3;
        Tue, 23 Nov 2021 21:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637701647;
        bh=3WMSH2p9hgrSj0O6WilIfR05MT5zELoGQ0clNxa4FWM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CNMgbUQuiFqpjP5Mrsj1MxaeOFmNUoddaOrgP/loatueOlW2P2q9exYmzuAWaawT7
         wVdOMOh9lmmlmMlBzGlsVAwowHn9d1PVM1ogOWgvknWSaxQrMCsu233GJ80OPpAUc7
         0KovNf0/z09jHPQkYibWchA36O7TOHIw5UEEf7sLxIW5IJJo3aDpJ+BTD/EP8h2XD5
         Syxs0g5vySnr8dCKysJUA3fDTbXtwiS4XVGd4EZzBjD9f1sa09aKQpPQvzeir1Tq/D
         owluwNiMMX2aU4btwgD6ssifc7/3qROoX3LjWL/V0Q9ovwVP+q/5eqAILkT91gDXT9
         5bvABcrrU3QNA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>
Subject: [PATCH 49/49] iio:chemical:atlas: Switch from CONFIG_PM guards to pm_ptr() / __maybe_unused
Date:   Tue, 23 Nov 2021 21:10:19 +0000
Message-Id: <20211123211019.2271440-50-jic23@kernel.org>
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
---
 drivers/iio/chemical/atlas-sensor.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/chemical/atlas-sensor.c b/drivers/iio/chemical/atlas-sensor.c
index 04b44a327614..7bacd0bd6f19 100644
--- a/drivers/iio/chemical/atlas-sensor.c
+++ b/drivers/iio/chemical/atlas-sensor.c
@@ -737,8 +737,7 @@ static int atlas_remove(struct i2c_client *client)
 	return atlas_set_powermode(data, 0);
 }
 
-#ifdef CONFIG_PM
-static int atlas_runtime_suspend(struct device *dev)
+static __maybe_unused int atlas_runtime_suspend(struct device *dev)
 {
 	struct atlas_data *data =
 		     iio_priv(i2c_get_clientdata(to_i2c_client(dev)));
@@ -746,16 +745,15 @@ static int atlas_runtime_suspend(struct device *dev)
 	return atlas_set_powermode(data, 0);
 }
 
-static int atlas_runtime_resume(struct device *dev)
+static __maybe_unused int atlas_runtime_resume(struct device *dev)
 {
 	struct atlas_data *data =
 		     iio_priv(i2c_get_clientdata(to_i2c_client(dev)));
 
 	return atlas_set_powermode(data, 1);
 }
-#endif
 
-static const struct dev_pm_ops atlas_pm_ops = {
+static __maybe_unused const struct dev_pm_ops atlas_pm_ops = {
 	SET_RUNTIME_PM_OPS(atlas_runtime_suspend,
 			   atlas_runtime_resume, NULL)
 };
@@ -764,7 +762,7 @@ static struct i2c_driver atlas_driver = {
 	.driver = {
 		.name	= ATLAS_DRV_NAME,
 		.of_match_table	= atlas_dt_ids,
-		.pm	= &atlas_pm_ops,
+		.pm	= pm_ptr(&atlas_pm_ops),
 	},
 	.probe		= atlas_probe,
 	.remove		= atlas_remove,
-- 
2.34.0

