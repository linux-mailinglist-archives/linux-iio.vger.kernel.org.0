Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90CF9482B43
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jan 2022 13:52:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232375AbiABMwd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 2 Jan 2022 07:52:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbiABMwd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Jan 2022 07:52:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EEB8C061574
        for <linux-iio@vger.kernel.org>; Sun,  2 Jan 2022 04:52:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A3A1E60DB7
        for <linux-iio@vger.kernel.org>; Sun,  2 Jan 2022 12:52:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F343CC36AE7;
        Sun,  2 Jan 2022 12:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641127952;
        bh=M3Xm2SSNVNIjG86rcehOAZ8bZP3L/TMpj/DRiK0S5h8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eG6uLYlIUVfo5lIjCsKoNqv0l4elVgmkwvIT4bSLGVdot1GvnSjVYPz3kKsT+ujMs
         gFKGuzzsYLuXjiV7bueHjKg3MHrJqZvX/RyctGLCBADJW6cWvjICzEt7o/7yn8PJsf
         pRW/fhKXLrCF8bZZagnZqg6W9ZiQbEhVcIQPIUsT+Wo0zGldzCvWSOUS/qEyOGYTiz
         Pyts2DjjsXutUz+muCEhBi1M5EuUmgyVhUXsYUFY5mXdvqyKvsR75S6NofOk/+iBxv
         HSC5dpR8MDC7YHFF6YHZajaVeW3/lfAkhlefmasrshpOJnpgJodmZpk4yFMI1ieRBo
         0DZHbv8JaZbjg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 36/51] iio:magn:mag3110: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr() etc
Date:   Sun,  2 Jan 2022 12:56:02 +0000
Message-Id: <20220102125617.1259804-37-jic23@kernel.org>
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
 drivers/iio/magnetometer/mag3110.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/magnetometer/mag3110.c b/drivers/iio/magnetometer/mag3110.c
index 17c62d806218..7d4b87da29ef 100644
--- a/drivers/iio/magnetometer/mag3110.c
+++ b/drivers/iio/magnetometer/mag3110.c
@@ -573,7 +573,6 @@ static int mag3110_remove(struct i2c_client *client)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int mag3110_suspend(struct device *dev)
 {
 	struct mag3110_data *data = iio_priv(i2c_get_clientdata(
@@ -623,11 +622,7 @@ static int mag3110_resume(struct device *dev)
 		data->ctrl_reg1);
 }
 
-static SIMPLE_DEV_PM_OPS(mag3110_pm_ops, mag3110_suspend, mag3110_resume);
-#define MAG3110_PM_OPS (&mag3110_pm_ops)
-#else
-#define MAG3110_PM_OPS NULL
-#endif
+DEFINE_SIMPLE_DEV_PM_OPS(mag3110_pm_ops, mag3110_suspend, mag3110_resume);
 
 static const struct i2c_device_id mag3110_id[] = {
 	{ "mag3110", 0 },
@@ -645,7 +640,7 @@ static struct i2c_driver mag3110_driver = {
 	.driver = {
 		.name	= "mag3110",
 		.of_match_table = mag3110_of_match,
-		.pm	= MAG3110_PM_OPS,
+		.pm	= pm_sleep_ptr(&mag3110_pm_ops),
 	},
 	.probe = mag3110_probe,
 	.remove = mag3110_remove,
-- 
2.34.1

