Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4CD482B33
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jan 2022 13:51:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232312AbiABMvt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 2 Jan 2022 07:51:49 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:50548 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232274AbiABMvt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Jan 2022 07:51:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 05A31B80D62
        for <linux-iio@vger.kernel.org>; Sun,  2 Jan 2022 12:51:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A574C36AF0;
        Sun,  2 Jan 2022 12:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641127906;
        bh=/JVqu38T1aKbmD/oofqmgNQwJprkWJS/IEjXMG3GsVc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lpIrTQDaAke4qDRDE+5JvvBUM3K8KfmZecFVjfpB4NDz2N444l093F8EWbPC1yY/S
         0Sx0ebSMgwQKXCPsWFQf68+OVMSF01/79A8MzL4zCVOeSWTd9nQAnlRacmCw8BuKde
         nIuo6gzdhQRLY8UMGmVFBO0ycOmm9FMIk1S0iuBlp9rIxzA2vJ4bLCJNeLjHo1DO+f
         jdPeqtEoeqEfE6u0fK6d0jKLLotbs6IZ8MK6MGu6v0pPpCCHXbyiJw5RNg+KcxHggM
         KZxt8BGB03tksxvU10osC15T5pxe3CLLQ9F0w7NPqWWqmZ8DNXeMoOhzcW6pLShBHC
         U0OVqbCYgPAcQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 20/51] iio:common:ssp: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr() etc
Date:   Sun,  2 Jan 2022 12:55:46 +0000
Message-Id: <20220102125617.1259804-21-jic23@kernel.org>
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
use of ifdef based config guards.  Also switch to SIMPLE_DEV_PM_OPS
rather than open coding the structure.

Removing instances of this approach from IIO also stops them being
copied into new drivers.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/common/ssp_sensors/ssp_dev.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/common/ssp_sensors/ssp_dev.c b/drivers/iio/common/ssp_sensors/ssp_dev.c
index 1aee87100038..d1aba8deff7f 100644
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
+DEFINE_SIMPLE_DEV_PM_OPS(ssp_pm_ops, ssp_suspend, ssp_resume);
 
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
2.34.1

