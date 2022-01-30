Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 562144A388F
	for <lists+linux-iio@lfdr.de>; Sun, 30 Jan 2022 20:26:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355907AbiA3T0I (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 30 Jan 2022 14:26:08 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:35972 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355901AbiA3T0H (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Jan 2022 14:26:07 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7BE0F612FA
        for <linux-iio@vger.kernel.org>; Sun, 30 Jan 2022 19:26:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30DF5C340F0;
        Sun, 30 Jan 2022 19:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643570766;
        bh=H5VTinguuJJmZ/sc+XpK4CJ+1VQatvafPD3nlILegg8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oePV+mkSj1qA5PpTfnYIvnjxOwTwY4kaNH5ggWLdLPNeJx9bwkjvQ/3wF50QB9i//
         tStS6i4kdDaukZehvBAYBFzq7haMsYYlYK2kRm0l4sdf2kVCj0u2z3kv3A2II1PFOh
         +50qY21bHq/KARqdOBHQFQ5GXwARzzRhe2Ix/adAbF9UouhYEKkB5s/oD14NxEfx2W
         FNH4NMzLW1nSYLCwq6hM8rUzvcuaUq77LlsL83LSR7zWSvAmrTR01T6KVvYfBKc+DG
         fAM05OQuQ4MEIBs9nCoAvMQ3B9UoQZxoyGUNkKn93bEjbiWDUhiFsCLBkndQOn8q16
         kngMjfkVlUsaQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
Subject: [PATCH v3 15/50] iio:adc:vf610: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr() etc
Date:   Sun, 30 Jan 2022 19:31:12 +0000
Message-Id: <20220130193147.279148-16-jic23@kernel.org>
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
use of ifdef based config guards.

Removing instances of this approach from IIO also stops them being
copied into new drivers.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
---
 drivers/iio/adc/vf610_adc.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/vf610_adc.c b/drivers/iio/adc/vf610_adc.c
index fd57fc43e8e5..c84293efc129 100644
--- a/drivers/iio/adc/vf610_adc.c
+++ b/drivers/iio/adc/vf610_adc.c
@@ -912,7 +912,6 @@ static int vf610_adc_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int vf610_adc_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
@@ -952,9 +951,9 @@ static int vf610_adc_resume(struct device *dev)
 	regulator_disable(info->vref);
 	return ret;
 }
-#endif
 
-static SIMPLE_DEV_PM_OPS(vf610_adc_pm_ops, vf610_adc_suspend, vf610_adc_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(vf610_adc_pm_ops, vf610_adc_suspend,
+				vf610_adc_resume);
 
 static struct platform_driver vf610_adc_driver = {
 	.probe          = vf610_adc_probe,
@@ -962,7 +961,7 @@ static struct platform_driver vf610_adc_driver = {
 	.driver         = {
 		.name   = DRIVER_NAME,
 		.of_match_table = vf610_adc_match,
-		.pm     = &vf610_adc_pm_ops,
+		.pm     = pm_sleep_ptr(&vf610_adc_pm_ops),
 	},
 };
 
-- 
2.35.1

