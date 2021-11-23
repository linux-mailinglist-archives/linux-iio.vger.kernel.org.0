Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5DD45AE04
	for <lists+linux-iio@lfdr.de>; Tue, 23 Nov 2021 22:07:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239716AbhKWVK2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 23 Nov 2021 16:10:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:40416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239697AbhKWVKW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 23 Nov 2021 16:10:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 97CB660FD8;
        Tue, 23 Nov 2021 21:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637701634;
        bh=vBB2NZWycv1kmd2HSobY/TLiEQ0drqU/c2g3st1MkLQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TWFChkIU1qJ4rfWzwLIED1yafdofGQty4JryddG+b9OzzZgDTmaB3/NzCwjMdTgCL
         qiVAN35U8VHbsz4OByljrh88aXNDUJeJgqFaO4aRWTuGhVbDzzGmCtsTN7gRa1TwNi
         7ceKVCy74FTNsktUDNLtm1Z3emR/1DiZvXI09DwSRS2IjYGPhWTk2LTpX1G1sECehu
         4TR1WffWNcO78QbLwA/JkQljGIsOPmTDivV07eWSGOIrC+gdoWlZGe2tqM5sNcHgBd
         rCbDOsj0iU6YHkeIZA/KWXGWqYW9Bzb4DGmhBf6TaeuoFB/A8depi2sFNDTI4ueZMJ
         OsA/Ry6+VgIOg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>
Subject: [PATCH 42/49] iio:proximity:as3935: Switch from CONFIG_PM_SLEEP guards to pm_ptr() / __maybe_unused
Date:   Tue, 23 Nov 2021 21:10:12 +0000
Message-Id: <20211123211019.2271440-43-jic23@kernel.org>
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
Cc: Matt Ranostay <matt.ranostay@konsulko.com>
---
 drivers/iio/proximity/as3935.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/proximity/as3935.c b/drivers/iio/proximity/as3935.c
index d62766b6b39e..605c6095d704 100644
--- a/drivers/iio/proximity/as3935.c
+++ b/drivers/iio/proximity/as3935.c
@@ -295,8 +295,7 @@ static void calibrate_as3935(struct as3935_state *st)
 	as3935_write(st, AS3935_NFLWDTH, st->nflwdth_reg);
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int as3935_suspend(struct device *dev)
+static __maybe_unused int as3935_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct as3935_state *st = iio_priv(indio_dev);
@@ -316,7 +315,7 @@ static int as3935_suspend(struct device *dev)
 	return ret;
 }
 
-static int as3935_resume(struct device *dev)
+static __maybe_unused int as3935_resume(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct as3935_state *st = iio_priv(indio_dev);
@@ -338,11 +337,6 @@ static int as3935_resume(struct device *dev)
 }
 
 static SIMPLE_DEV_PM_OPS(as3935_pm_ops, as3935_suspend, as3935_resume);
-#define AS3935_PM_OPS (&as3935_pm_ops)
-
-#else
-#define AS3935_PM_OPS NULL
-#endif
 
 static void as3935_stop_work(void *data)
 {
@@ -472,7 +466,7 @@ static struct spi_driver as3935_driver = {
 	.driver = {
 		.name	= "as3935",
 		.of_match_table = as3935_of_match,
-		.pm	= AS3935_PM_OPS,
+		.pm	= pm_ptr(&as3935_pm_ops),
 	},
 	.probe		= as3935_probe,
 	.id_table	= as3935_id,
-- 
2.34.0

