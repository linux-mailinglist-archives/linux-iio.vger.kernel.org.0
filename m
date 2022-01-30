Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 928944A3890
	for <lists+linux-iio@lfdr.de>; Sun, 30 Jan 2022 20:26:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbiA3T0L (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 30 Jan 2022 14:26:11 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:51548 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbiA3T0L (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Jan 2022 14:26:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 23284B829A0
        for <linux-iio@vger.kernel.org>; Sun, 30 Jan 2022 19:26:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EB1BC340E4;
        Sun, 30 Jan 2022 19:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643570768;
        bh=cYwhRW8zgTvYu77ZoirVqN+1sl4RLq93fAGOsyHJPco=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oE+uwwvERCqBvi/zsfQq1P8pOD1ZgIxLi90lFjojJvCrBjkCoSIgo0H1Bpw1LHfw7
         ps8As2hubKaDroAreJxpM24P5kLGfUKgj6mha250Xjo37XQolrhvTU5Bj/C+2/u1y5
         /CTYhfg1fs6UuTRDa4dx9s0/MNshD90rtUWwoFCxPGLc7xhQAf2jHeP+TKLw+OCbXu
         p9InLf+Ok6hgdMilvSJS6KLqqW283CavbdCfSMTDi+mV9+uuwgYS3oXiaV9sSRpfub
         Gu2D7UlJvHeQ/fCK4MT8SYbCa8V7OEN0PJKH9rrAAgUU8lX1cylKX7bi4iyhAPLG5/
         fQM5fsw59nz3A==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 16/50] iio:common:ssp: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr() etc
Date:   Sun, 30 Jan 2022 19:31:13 +0000
Message-Id: <20220130193147.279148-17-jic23@kernel.org>
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
use of ifdef based config guards.  Also switch to SIMPLE_DEV_PM_OPS
rather than open coding the structure.

Removing instances of this approach from IIO also stops them being
copied into new drivers.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/common/ssp_sensors/ssp_dev.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/common/ssp_sensors/ssp_dev.c b/drivers/iio/common/ssp_sensors/ssp_dev.c
index 1aee87100038..49f228836a5c 100644
--- a/drivers/iio/common/ssp_sensors/ssp_dev.c
+++ b/drivers/iio/common/ssp_sensors/ssp_dev.c
@@ -612,7 +612,6 @@ static int ssp_remove(struct spi_device *spi)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int ssp_suspend(struct device *dev)
 {
 	int ret;
@@ -661,17 +660,14 @@ static int ssp_resume(struct device *dev)
 
 	return 0;
 }
-#endif /* CONFIG_PM_SLEEP */
 
-static const struct dev_pm_ops ssp_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(ssp_suspend, ssp_resume)
-};
+static DEFINE_SIMPLE_DEV_PM_OPS(ssp_pm_ops, ssp_suspend, ssp_resume);
 
 static struct spi_driver ssp_driver = {
 	.probe = ssp_probe,
 	.remove = ssp_remove,
 	.driver = {
-		.pm = &ssp_pm_ops,
+		.pm = pm_sleep_ptr(&ssp_pm_ops),
 		.of_match_table = of_match_ptr(ssp_of_match),
 		.name = "sensorhub"
 	},
-- 
2.35.1

