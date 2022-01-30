Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F040F4A389B
	for <lists+linux-iio@lfdr.de>; Sun, 30 Jan 2022 20:26:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355933AbiA3T0j (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 30 Jan 2022 14:26:39 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:36230 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355930AbiA3T0d (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Jan 2022 14:26:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BF007612EE
        for <linux-iio@vger.kernel.org>; Sun, 30 Jan 2022 19:26:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 916BCC340E4;
        Sun, 30 Jan 2022 19:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643570792;
        bh=D6o0UcSaxBEyVO5E+Ksuu1qudFjZG2rtmMoA6FguGyg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DBHJAXSNPOoXLnq2VzCpBfAufb/KnaVONqsMFK3L7zBKVOXtMfHLWFyGHhxSrtZ6J
         mBt/TJZ21zYeAbiHdp8Qb0/yCcM5yxVkXyzebSNjkDuNDLXvMX9Gc3oUx/aYuHVUc+
         N+8NJJc953T/tKIXOOpYuv5YMzu+Js/V/0Z9DZHygHH3mjzlRU9WuIFj7vSyM4z5rb
         IoZFREB89w6u30rHDpZnk7M10uGwquPalXRUaT1dNgpBi2z8Cg8WkCGugN2j9OPfuj
         2XH/VON+bPrebze1yiiPDHW0gsDArU2GC5yOTbsEtc/0Yf134LM60JOt0eo/ejvXRF
         pxoll7ZZd9pHw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vaishnav M A <vaishnav@beagleboard.org>
Subject: [PATCH v3 27/50] iio:light:tsl2563: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr() etc
Date:   Sun, 30 Jan 2022 19:31:24 +0000
Message-Id: <20220130193147.279148-28-jic23@kernel.org>
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

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Vaishnav M A <vaishnav@beagleboard.org>
---
 drivers/iio/light/tsl2563.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/light/tsl2563.c b/drivers/iio/light/tsl2563.c
index 5bf2bfbc5379..0a278eea36ca 100644
--- a/drivers/iio/light/tsl2563.c
+++ b/drivers/iio/light/tsl2563.c
@@ -814,7 +814,6 @@ static int tsl2563_remove(struct i2c_client *client)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int tsl2563_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
@@ -857,11 +856,8 @@ static int tsl2563_resume(struct device *dev)
 	return ret;
 }
 
-static SIMPLE_DEV_PM_OPS(tsl2563_pm_ops, tsl2563_suspend, tsl2563_resume);
-#define TSL2563_PM_OPS (&tsl2563_pm_ops)
-#else
-#define TSL2563_PM_OPS NULL
-#endif
+static DEFINE_SIMPLE_DEV_PM_OPS(tsl2563_pm_ops, tsl2563_suspend,
+				tsl2563_resume);
 
 static const struct i2c_device_id tsl2563_id[] = {
 	{ "tsl2560", 0 },
@@ -885,7 +881,7 @@ static struct i2c_driver tsl2563_i2c_driver = {
 	.driver = {
 		.name	 = "tsl2563",
 		.of_match_table = tsl2563_of_match,
-		.pm	= TSL2563_PM_OPS,
+		.pm	= pm_sleep_ptr(&tsl2563_pm_ops),
 	},
 	.probe		= tsl2563_probe,
 	.remove		= tsl2563_remove,
-- 
2.35.1

