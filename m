Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5957C45AE03
	for <lists+linux-iio@lfdr.de>; Tue, 23 Nov 2021 22:07:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239722AbhKWVK0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 23 Nov 2021 16:10:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:40372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239716AbhKWVKP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 23 Nov 2021 16:10:15 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6ED4260FC3;
        Tue, 23 Nov 2021 21:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637701626;
        bh=kztSKeAV/syJqtLcl2pqVaOWZUGwRM2EFsBo0VTIbTs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b3EbBgWprewG03SMm6wk43S6fn9pyBXRXut+Rmg//j+PHqBw2/pUPeSEuDhubt2vR
         bA/3gLTCyr7+ewC3CVe5uE82DJqL4Y33hDKVHupWwt+rCGHObfWOOuTqDpYX2sxaz0
         tkgywTUFhktnm25irADEBGSAifZCC+vra07w6TvNGUzYZgjjJikc68Ceoeb3Qh3RK9
         ilDWG7b8L2UdkhSxZUp66nurrA95hfoEuoH7umdsOJ8nb8Yr5ZPbMDRzfG05eU+WnF
         sg3IO/HI5T8dddIr4aymlpZRuteZyFX4/95ZAq3T796UFT86vQBOCYulrFSKXaBYTG
         ZySC0XeUz4VgQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 38/49] iio:magn:mag3110: Switch from CONFIG_PM_SLEEP guards to pm_ptr() / __maybe_unused
Date:   Tue, 23 Nov 2021 21:10:08 +0000
Message-Id: <20211123211019.2271440-39-jic23@kernel.org>
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
---
 drivers/iio/magnetometer/mag3110.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/magnetometer/mag3110.c b/drivers/iio/magnetometer/mag3110.c
index 17c62d806218..475fdff037f7 100644
--- a/drivers/iio/magnetometer/mag3110.c
+++ b/drivers/iio/magnetometer/mag3110.c
@@ -573,8 +573,7 @@ static int mag3110_remove(struct i2c_client *client)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int mag3110_suspend(struct device *dev)
+static __maybe_unused int mag3110_suspend(struct device *dev)
 {
 	struct mag3110_data *data = iio_priv(i2c_get_clientdata(
 		to_i2c_client(dev)));
@@ -600,7 +599,7 @@ static int mag3110_suspend(struct device *dev)
 	return 0;
 }
 
-static int mag3110_resume(struct device *dev)
+static __maybe_unused int mag3110_resume(struct device *dev)
 {
 	struct mag3110_data *data = iio_priv(i2c_get_clientdata(
 		to_i2c_client(dev)));
@@ -624,10 +623,6 @@ static int mag3110_resume(struct device *dev)
 }
 
 static SIMPLE_DEV_PM_OPS(mag3110_pm_ops, mag3110_suspend, mag3110_resume);
-#define MAG3110_PM_OPS (&mag3110_pm_ops)
-#else
-#define MAG3110_PM_OPS NULL
-#endif
 
 static const struct i2c_device_id mag3110_id[] = {
 	{ "mag3110", 0 },
@@ -645,7 +640,7 @@ static struct i2c_driver mag3110_driver = {
 	.driver = {
 		.name	= "mag3110",
 		.of_match_table = mag3110_of_match,
-		.pm	= MAG3110_PM_OPS,
+		.pm	= pm_ptr(&mag3110_pm_ops),
 	},
 	.probe = mag3110_probe,
 	.remove = mag3110_remove,
-- 
2.34.0

