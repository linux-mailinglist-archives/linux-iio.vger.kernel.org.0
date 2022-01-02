Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 468B6482B46
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jan 2022 13:52:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232378AbiABMwl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 2 Jan 2022 07:52:41 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:42832 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbiABMwl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Jan 2022 07:52:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3100C60DB7
        for <linux-iio@vger.kernel.org>; Sun,  2 Jan 2022 12:52:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 483A3C36AEF;
        Sun,  2 Jan 2022 12:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641127960;
        bh=AtYr1ZOo/ebcDefxLRUYJiT4S6AyOcE3IM5O0OparHk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Va8sd8pmbaEGSjrQvVJz+2xeuw5V1YZo2ek1F+PKdMHUAeZLNjNUFJUF5b7LbHEzp
         AU9OouWPK1v39jT3OAfOamDiwAPnopdU5oEpDWzS1ApCuS+wChSE6bxSi5Vji/tGk4
         lWO9dO4cCOiycjdmYwL0jtleI5CpWedO/7CMT2mvJtS62tD77cYVjaFFzv+SR1Yvi4
         ZhAfa5EyMpbK3svWzhN/ctg5ZhIc8A3/rYyI2rMeUvTN6qcNJqLHPjVMjojY+ENmch
         2K2+wGKvLAGOQYirfGT+ID0DINZFzTeEqc9RF771EyVd3rPQ147S7sAJmDYNlGmNQA
         xBH0nqMWkiKGw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>
Subject: [PATCH v2 39/51] iio:proximity:as3935: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr() etc
Date:   Sun,  2 Jan 2022 12:56:05 +0000
Message-Id: <20220102125617.1259804-40-jic23@kernel.org>
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
use of #ifdef based config guards.

Removing instances of this approach from IIO also stops them being
copied into new drivers.

Acked-by: Matt Ranostay <matt.ranostay@konsulko.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/proximity/as3935.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/proximity/as3935.c b/drivers/iio/proximity/as3935.c
index 51f4f92ae84a..5716048e228c 100644
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
+DEFINE_SIMPLE_DEV_PM_OPS(as3935_pm_ops, as3935_suspend, as3935_resume);
 
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
2.34.1

