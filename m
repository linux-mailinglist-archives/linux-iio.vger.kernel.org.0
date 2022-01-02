Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D840482B21
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jan 2022 13:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232354AbiABMvA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 2 Jan 2022 07:51:00 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:50102 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiABMvA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Jan 2022 07:51:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2FB23B80CFC
        for <linux-iio@vger.kernel.org>; Sun,  2 Jan 2022 12:50:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3027AC36AEE;
        Sun,  2 Jan 2022 12:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641127857;
        bh=CVadK/vpnpagtOE8zLmFBZnFI4hufQM28CZEH0u/Tcg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dEJCJngTceC+DVKexIAL4mbRhcdO5fDLGebb3QYgGAI3RvGDGVJAiNAzpo1k9vq7t
         umNcJLXFbJS9TL/g7HWOM9+Ya9Dc1xddMnJ8AxF1I43YhBjmUsIdMdI0Gw/V8IdOPr
         xvlShV1C9F9tBfW9ondJDMklUq5qXi2JaB3haLOMhIwue+drBr7d5ZoX+XcSuTwYrz
         c+g3cBBbp2Ch6vrP1WYmopaFm0KruRkgTlls4yo79zImXjhsltJvhQJrIX746zSaYv
         Nlg0Hb87P8SOPr6k7eQ6oo/hp71Eo/W+uAkd8esbDQkc14LiY/IFydJb1cfUaZLt3V
         bJmfAFcywm/Xg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 02/51] iio:accel:da280: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr() etc
Date:   Sun,  2 Jan 2022 12:55:28 +0000
Message-Id: <20220102125617.1259804-3-jic23@kernel.org>
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
 drivers/iio/accel/da280.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/accel/da280.c b/drivers/iio/accel/da280.c
index 9633bdae5fd4..10fdaaa54c40 100644
--- a/drivers/iio/accel/da280.c
+++ b/drivers/iio/accel/da280.c
@@ -153,7 +153,6 @@ static int da280_probe(struct i2c_client *client,
 	return devm_iio_device_register(&client->dev, indio_dev);
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int da280_suspend(struct device *dev)
 {
 	return da280_enable(to_i2c_client(dev), false);
@@ -163,9 +162,8 @@ static int da280_resume(struct device *dev)
 {
 	return da280_enable(to_i2c_client(dev), true);
 }
-#endif
 
-static SIMPLE_DEV_PM_OPS(da280_pm_ops, da280_suspend, da280_resume);
+DEFINE_SIMPLE_DEV_PM_OPS(da280_pm_ops, da280_suspend, da280_resume);
 
 static const struct acpi_device_id da280_acpi_match[] = {
 	{"MIRAACC", da280},
@@ -184,7 +182,7 @@ static struct i2c_driver da280_driver = {
 	.driver = {
 		.name = "da280",
 		.acpi_match_table = ACPI_PTR(da280_acpi_match),
-		.pm = &da280_pm_ops,
+		.pm = pm_sleep_ptr(&da280_pm_ops),
 	},
 	.probe		= da280_probe,
 	.id_table	= da280_i2c_id,
-- 
2.34.1

