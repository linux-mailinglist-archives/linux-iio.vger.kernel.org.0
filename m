Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A14924A38AC
	for <lists+linux-iio@lfdr.de>; Sun, 30 Jan 2022 20:27:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355944AbiA3T1m (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 30 Jan 2022 14:27:42 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:36712 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355955AbiA3T1P (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Jan 2022 14:27:15 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E920C612FA
        for <linux-iio@vger.kernel.org>; Sun, 30 Jan 2022 19:27:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8C44C340F0;
        Sun, 30 Jan 2022 19:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643570834;
        bh=zHVd3gNkcOhsl4fu8mlBuuOpbajF5A+8iCivaHYrxys=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qeTOU9iuVQ+OzybI8zFdAflaIr3fmxAOXYdmUWlwjiVdnEx5hBYCgh2YRELuq+xAR
         8fOrr+ZS+o0kFW90osQ8Tuw8/Zczv+zwa2+Dq9gnXCPbfemfMKNQ/Mib1pinrP+6Iv
         G1rqbCQ9qVD+K4U/3NPl2RWMiPTp5Uf21LBWbTlWvj8PD3IgvmXwcvTcXcxYnOVhio
         VEAxcYgwVDcXxTwviOOsTIExS3mQ6Ih0E+gN5Rtm68di8AJ2Nhc4Y93hUbv3iaMcbW
         zkvUvHTIrB23s47vxOAMkCGEIjW1/+VmnIiLPo5KkdOyIOBG0A5IEuSi+1QQL60OyY
         DvLxmee2g8VIg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 45/50] iio:adc:rcar: Switch from CONFIG_PM guards to pm_ptr() etc
Date:   Sun, 30 Jan 2022 19:31:42 +0000
Message-Id: <20220130193147.279148-46-jic23@kernel.org>
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
---
 drivers/iio/adc/rcar-gyroadc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/rcar-gyroadc.c b/drivers/iio/adc/rcar-gyroadc.c
index 727ea6c68049..27d9e147b4b7 100644
--- a/drivers/iio/adc/rcar-gyroadc.c
+++ b/drivers/iio/adc/rcar-gyroadc.c
@@ -577,7 +577,6 @@ static int rcar_gyroadc_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#if defined(CONFIG_PM)
 static int rcar_gyroadc_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
@@ -597,10 +596,9 @@ static int rcar_gyroadc_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
 static const struct dev_pm_ops rcar_gyroadc_pm_ops = {
-	SET_RUNTIME_PM_OPS(rcar_gyroadc_suspend, rcar_gyroadc_resume, NULL)
+	RUNTIME_PM_OPS(rcar_gyroadc_suspend, rcar_gyroadc_resume, NULL)
 };
 
 static struct platform_driver rcar_gyroadc_driver = {
@@ -609,7 +607,7 @@ static struct platform_driver rcar_gyroadc_driver = {
 	.driver         = {
 		.name		= DRIVER_NAME,
 		.of_match_table	= rcar_gyroadc_match,
-		.pm		= &rcar_gyroadc_pm_ops,
+		.pm		= pm_ptr(&rcar_gyroadc_pm_ops),
 	},
 };
 
-- 
2.35.1

