Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0EB4A38A1
	for <lists+linux-iio@lfdr.de>; Sun, 30 Jan 2022 20:26:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355941AbiA3T0v (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 30 Jan 2022 14:26:51 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:36368 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355943AbiA3T0q (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Jan 2022 14:26:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5DF30612EA
        for <linux-iio@vger.kernel.org>; Sun, 30 Jan 2022 19:26:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC318C340E4;
        Sun, 30 Jan 2022 19:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643570805;
        bh=+q5gqWcdlRebWYQMvEFdBg5H0UMHQnFpvB2Dvl7ssd8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=StrM9r37O5/5drV1JYHkZ53a8bNg0I2ykWqDOOumsi3f1vG4pDR8ql9gOF75HDfiU
         Q9Enopm8g3K6kS8AGm7KC75ifnCQFU9FP0JiSHkA8o+VP1f9w1U2mXOHNrl4U7OOPx
         o3M2Wrujq7i5erwms45Dk8SYEkqgtvGCUbBUmBQhrDXty2NqsE3GKS0xvQA4WG7AT7
         qROLZZAKP97fcydV9DbNGORzWT+wLlWseqVgnilJ0wfRica8c3eJ4ycvllIDuLK23t
         4V8oqHEU43YIiXRprj/zYlLk2TbG8PCltMmy/D3kWJCbRr17dZxEZA3fMzTc0xnaTC
         8Ho6x0q3Qltsw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Matt Ranostay <matt.ranostay@konsulko.com>
Subject: [PATCH v3 33/50] iio:proximity:as3935: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr() etc
Date:   Sun, 30 Jan 2022 19:31:30 +0000
Message-Id: <20220130193147.279148-34-jic23@kernel.org>
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
use of #ifdef based config guards.

Removing instances of this approach from IIO also stops them being
copied into new drivers.

Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
Acked-by: Matt Ranostay <matt.ranostay@konsulko.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/proximity/as3935.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/proximity/as3935.c b/drivers/iio/proximity/as3935.c
index bd7595db31d4..420592a4956f 100644
--- a/drivers/iio/proximity/as3935.c
+++ b/drivers/iio/proximity/as3935.c
@@ -295,7 +295,6 @@ static void calibrate_as3935(struct as3935_state *st)
 	as3935_write(st, AS3935_NFLWDTH, st->nflwdth_reg);
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int as3935_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
@@ -337,12 +336,7 @@ static int as3935_resume(struct device *dev)
 	return ret;
 }
 
-static SIMPLE_DEV_PM_OPS(as3935_pm_ops, as3935_suspend, as3935_resume);
-#define AS3935_PM_OPS (&as3935_pm_ops)
-
-#else
-#define AS3935_PM_OPS NULL
-#endif
+static DEFINE_SIMPLE_DEV_PM_OPS(as3935_pm_ops, as3935_suspend, as3935_resume);
 
 static void as3935_stop_work(void *data)
 {
@@ -472,7 +466,7 @@ static struct spi_driver as3935_driver = {
 	.driver = {
 		.name	= "as3935",
 		.of_match_table = as3935_of_match,
-		.pm	= AS3935_PM_OPS,
+		.pm	= pm_sleep_ptr(&as3935_pm_ops),
 	},
 	.probe		= as3935_probe,
 	.id_table	= as3935_id,
-- 
2.35.1

