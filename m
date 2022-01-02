Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A21F0482B3D
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jan 2022 13:52:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232371AbiABMwP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 2 Jan 2022 07:52:15 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:42510 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232372AbiABMwP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Jan 2022 07:52:15 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 28B1260DB7
        for <linux-iio@vger.kernel.org>; Sun,  2 Jan 2022 12:52:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A88F0C36AEE;
        Sun,  2 Jan 2022 12:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641127934;
        bh=WnlP3Vb44vJMXTs8gAC08Z8FdES2VCfcNz5QDCKAVJg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jayjra7dO334s1Apg5KciIn8iciy85kE0eMm2ROrkmHOXZ2C5RWTRCRD+4G+yFF68
         UKFKwU1Nb84fUF94yooQFYhQgj56u4qBqak2urpwKN10A7P6hMoj6OD0xbl5wVm97x
         2NvHe2cociMXbexC0EcdwZy4BWjAI79P+qA1EvIuRzU0fuMaBUaGfNwsEtmLfwyPhF
         FVvtGM8qEkV3mD+32RHG27rDbKMlPQAiCOSgXR5CCzsjK0XyaQpAwz1f0EXrre+FWh
         3FmR7nLtbbCOFJs0vCr7mS15cZvQJSoINwrBo87RDeLranlc3RqT8wRUqoyZNvQkAS
         7LS/kA1sfXZbQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 30/51] iio:light:tcs3414: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr() etc
Date:   Sun,  2 Jan 2022 12:55:56 +0000
Message-Id: <20220102125617.1259804-31-jic23@kernel.org>
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
 drivers/iio/light/tcs3414.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/light/tcs3414.c b/drivers/iio/light/tcs3414.c
index b87222141429..3e0944c3e36f 100644
--- a/drivers/iio/light/tcs3414.c
+++ b/drivers/iio/light/tcs3414.c
@@ -345,7 +345,6 @@ static int tcs3414_probe(struct i2c_client *client,
 	return devm_iio_device_register(&client->dev, indio_dev);
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int tcs3414_suspend(struct device *dev)
 {
 	struct tcs3414_data *data = iio_priv(i2c_get_clientdata(
@@ -360,9 +359,8 @@ static int tcs3414_resume(struct device *dev)
 	return i2c_smbus_write_byte_data(data->client, TCS3414_CONTROL,
 		data->control);
 }
-#endif
 
-static SIMPLE_DEV_PM_OPS(tcs3414_pm_ops, tcs3414_suspend, tcs3414_resume);
+DEFINE_SIMPLE_DEV_PM_OPS(tcs3414_pm_ops, tcs3414_suspend, tcs3414_resume);
 
 static const struct i2c_device_id tcs3414_id[] = {
 	{ "tcs3414", 0 },
@@ -373,7 +371,7 @@ MODULE_DEVICE_TABLE(i2c, tcs3414_id);
 static struct i2c_driver tcs3414_driver = {
 	.driver = {
 		.name	= TCS3414_DRV_NAME,
-		.pm	= &tcs3414_pm_ops,
+		.pm	= pm_sleep_ptr(&tcs3414_pm_ops),
 	},
 	.probe		= tcs3414_probe,
 	.id_table	= tcs3414_id,
-- 
2.34.1

