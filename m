Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFDB4482B51
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jan 2022 13:53:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232398AbiABMxN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 2 Jan 2022 07:53:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbiABMxN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Jan 2022 07:53:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5234FC061574
        for <linux-iio@vger.kernel.org>; Sun,  2 Jan 2022 04:53:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF6FC60E9A
        for <linux-iio@vger.kernel.org>; Sun,  2 Jan 2022 12:53:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDA29C36AEF;
        Sun,  2 Jan 2022 12:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641127991;
        bh=HRvI0cl6UM+KucQWgJJglscbV/wtlWnz1xOOGJipHVY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aaOm4L7UAeVCGoUS+ML2e+kHODiAJ6cgUaRPiBwfumKD6JqA5PNiqNJ3vSdu9duBx
         KEuy9ZbKKDkQguYdhKFhtnpyqP6fOGUnLSgTZ51r5dNOUhS2CliOd7gu4xwGHXaaUx
         TzJlnbJ+yQcGdmMrZ6y2h2JoJce0z1PvgDQO8lpeWHdKEVM9iNnLy6SPqqsG9T9I5m
         pelaBqjXNCNdpQiK9PE8NyquN6d7VRKSa1MCjgkt0Pt279zhFdvNTDwo9LG9pi4sKB
         JvStm3eBV3wBYLMYive8EdOePsWtToNhGiTjkOI7PafNjVQogBapUbqziUrE160SlY
         iJ7mMZKo+0MRw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Mikko Koivunen <mikko.koivunen@fi.rohmeurope.com>
Subject: [PATCH v2 50/51] iio:light:rpr0521: Switch from CONFIG_PM guards to pm_ptr() etc
Date:   Sun,  2 Jan 2022 12:56:16 +0000
Message-Id: <20220102125617.1259804-51-jic23@kernel.org>
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
without CONFIG_PM support is simpler and less error prone than the
use of #ifdef based config guards.

Removing instances of this approach from IIO also stops them being
copied into new drivers.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Mikko Koivunen <mikko.koivunen@fi.rohmeurope.com>
---
 drivers/iio/light/rpr0521.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/light/rpr0521.c b/drivers/iio/light/rpr0521.c
index c2dd8a3d4217..dabdd05f0e2c 100644
--- a/drivers/iio/light/rpr0521.c
+++ b/drivers/iio/light/rpr0521.c
@@ -1055,7 +1055,6 @@ static int rpr0521_remove(struct i2c_client *client)
 	return 0;
 }
 
-#ifdef CONFIG_PM
 static int rpr0521_runtime_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
@@ -1101,11 +1100,9 @@ static int rpr0521_runtime_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
 static const struct dev_pm_ops rpr0521_pm_ops = {
-	SET_RUNTIME_PM_OPS(rpr0521_runtime_suspend,
-			   rpr0521_runtime_resume, NULL)
+	RUNTIME_PM_OPS(rpr0521_runtime_suspend, rpr0521_runtime_resume, NULL)
 };
 
 static const struct acpi_device_id rpr0521_acpi_match[] = {
@@ -1124,7 +1121,7 @@ MODULE_DEVICE_TABLE(i2c, rpr0521_id);
 static struct i2c_driver rpr0521_driver = {
 	.driver = {
 		.name	= RPR0521_DRV_NAME,
-		.pm	= &rpr0521_pm_ops,
+		.pm	= pm_ptr(&rpr0521_pm_ops),
 		.acpi_match_table = ACPI_PTR(rpr0521_acpi_match),
 	},
 	.probe		= rpr0521_probe,
-- 
2.34.1

