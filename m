Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9684A38B1
	for <lists+linux-iio@lfdr.de>; Sun, 30 Jan 2022 20:28:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355980AbiA3T16 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 30 Jan 2022 14:27:58 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:51952 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355981AbiA3T10 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Jan 2022 14:27:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BD5E3B829AB
        for <linux-iio@vger.kernel.org>; Sun, 30 Jan 2022 19:27:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D28BC340EB;
        Sun, 30 Jan 2022 19:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643570844;
        bh=8IvGAG1+o+7x/stJxebSJzEKtjRlrGOKZsanlKEc4ow=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Un9ISps5t8PmZ+fW0yu32YO3ZbnQmIW+FldXWuLY47OZ7WGLCRVFUdkWiJ69z3UCX
         uIrfgQGHQPr2YeG8jpye+WU4cRteEh+0FcQd9F1ZXkbkbECwUFdd5t7jr7c2AOsEtL
         z2f2dM6zuXTdJ72bPFmrZEb7XJCfZtKWRHEuDO7uijMTC1RJ64FUn0GRGiGDCMPS2X
         g2vKUtMMR43NZImrC6CbWipJ5N32c/fXhMQJdBPCqBuZB8bNZAMVby1exQJ4x7D82b
         DKDAa15oGM9gBhrXMC8TqVgawphRBMTEPU0K7vkYJNM0njFgCXkLTMOAYV40irMvhW
         2cbb/fNjHIZgg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Mikko Koivunen <mikko.koivunen@fi.rohmeurope.com>
Subject: [PATCH v3 49/50] iio:light:rpr0521: Switch from CONFIG_PM guards to pm_ptr() etc
Date:   Sun, 30 Jan 2022 19:31:46 +0000
Message-Id: <20220130193147.279148-50-jic23@kernel.org>
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
without CONFIG_PM support is simpler and less error prone than the
use of #ifdef based config guards.

Removing instances of this approach from IIO also stops them being
copied into new drivers.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Mikko Koivunen <mikko.koivunen@fi.rohmeurope.com>
---
 drivers/iio/light/rpr0521.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/light/rpr0521.c b/drivers/iio/light/rpr0521.c
index c2dd8a3d4217..dabdd05f0e2c 100644
--- a/drivers/iio/light/rpr0521.c
+++ b/drivers/iio/light/rpr0521.c
@@ -1055,7 +1055,6 @@ static int rpr0521_remove(struct i2c_client *client)
 	return 0;
 }
 
-#ifdef CONFIG_PM
 static int rpr0521_runtime_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
@@ -1101,11 +1100,9 @@ static int rpr0521_runtime_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
 static const struct dev_pm_ops rpr0521_pm_ops = {
-	SET_RUNTIME_PM_OPS(rpr0521_runtime_suspend,
-			   rpr0521_runtime_resume, NULL)
+	RUNTIME_PM_OPS(rpr0521_runtime_suspend, rpr0521_runtime_resume, NULL)
 };
 
 static const struct acpi_device_id rpr0521_acpi_match[] = {
@@ -1124,7 +1121,7 @@ MODULE_DEVICE_TABLE(i2c, rpr0521_id);
 static struct i2c_driver rpr0521_driver = {
 	.driver = {
 		.name	= RPR0521_DRV_NAME,
-		.pm	= &rpr0521_pm_ops,
+		.pm	= pm_ptr(&rpr0521_pm_ops),
 		.acpi_match_table = ACPI_PTR(rpr0521_acpi_match),
 	},
 	.probe		= rpr0521_probe,
-- 
2.35.1

