Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFCE5482B3A
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jan 2022 13:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbiABMwJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 2 Jan 2022 07:52:09 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:50776 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232363AbiABMwJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Jan 2022 07:52:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1C4FBB80D63
        for <linux-iio@vger.kernel.org>; Sun,  2 Jan 2022 12:52:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 608DEC36AEE;
        Sun,  2 Jan 2022 12:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641127926;
        bh=crSk727opMIIZWe11Sihtf/JhL+JKMx8ihuRL+wXMB8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UPdYI2tFHEy4KjKcBRAlaF1vLPVmlQ0vCImf/CotcHTQ46WZQQC3YTyEGrgzjFdGo
         fnSFniwCxo+O5Ykihho8/fVXI2hgSlNEUH5iaMZi3deS70p1lzREEsv7joHovZ3O0d
         mlsBCjhmpChlPMDb6eTSGOKLY2upiAtmzJ+4os7RRNnPGOklOYWSc3qUZ7cIXui5gl
         qWA/ph4xcEGYhXkf7Al8W+5rqmjbtbb9qam16pyfaOwhw716sIoKe3psGrPqB/ONhX
         Axv04JLk3nbfdJWpYspbEPmdCx4nDRFlCW2a2ePEF48MsSD9R9QvMdeMdZdZRfutU0
         yjzXnupzvE4mw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 27/51] iio:light:jsa1212: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr() etc
Date:   Sun,  2 Jan 2022 12:55:53 +0000
Message-Id: <20220102125617.1259804-28-jic23@kernel.org>
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

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/light/jsa1212.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/light/jsa1212.c b/drivers/iio/light/jsa1212.c
index 724a0ec9f35c..4bf899337384 100644
--- a/drivers/iio/light/jsa1212.c
+++ b/drivers/iio/light/jsa1212.c
@@ -383,7 +383,6 @@ static int jsa1212_remove(struct i2c_client *client)
 	return jsa1212_power_off(data);
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int jsa1212_suspend(struct device *dev)
 {
 	struct jsa1212_data *data;
@@ -421,12 +420,7 @@ static int jsa1212_resume(struct device *dev)
 	return ret;
 }
 
-static SIMPLE_DEV_PM_OPS(jsa1212_pm_ops, jsa1212_suspend, jsa1212_resume);
-
-#define JSA1212_PM_OPS (&jsa1212_pm_ops)
-#else
-#define JSA1212_PM_OPS NULL
-#endif
+DEFINE_SIMPLE_DEV_PM_OPS(jsa1212_pm_ops, jsa1212_suspend, jsa1212_resume);
 
 static const struct acpi_device_id jsa1212_acpi_match[] = {
 	{"JSA1212", 0},
@@ -443,7 +437,7 @@ MODULE_DEVICE_TABLE(i2c, jsa1212_id);
 static struct i2c_driver jsa1212_driver = {
 	.driver = {
 		.name	= JSA1212_DRIVER_NAME,
-		.pm	= JSA1212_PM_OPS,
+		.pm	= pm_sleep_ptr(&jsa1212_pm_ops),
 		.acpi_match_table = ACPI_PTR(jsa1212_acpi_match),
 	},
 	.probe		= jsa1212_probe,
-- 
2.34.1

