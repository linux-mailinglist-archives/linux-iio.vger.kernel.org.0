Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3225E482B45
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jan 2022 13:52:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232377AbiABMwk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 2 Jan 2022 07:52:40 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:51056 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbiABMwk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Jan 2022 07:52:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 00047B80D63
        for <linux-iio@vger.kernel.org>; Sun,  2 Jan 2022 12:52:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 677B7C36AF0;
        Sun,  2 Jan 2022 12:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641127957;
        bh=0cijYQo/NuB1+IvljjUKrjSxG4oYxAf34FLMjdK5nK0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aExMEuRjbql08fBddxpO4CDUI19pQ09cJw+w1nJs4uw+IK8oxvldUFaeA2ifqwrf5
         SU20aeV6ikmuHWxUGlCVBQwTTOnowwfnFV987jEVx6bjZ6SwaIHdGnArqhY04Tm2BV
         ac73OGCRQUWcsWpDOk0iHEmBd0mcZdXnfoXF9ZHiYqQRECRJu0ALvhw/2Iecgq1o2Q
         gYYylpO5B78h+5iJ/IKIMKPU7v7uR8J6wCuO305qDEA6f8xQy+NEzhlqZg+CSUqKhx
         X87i2Zj8FnXQlgreuXlvGLGBMZPN5TZSYs2LEmegapRYugCSy+cKkFp6c0O2JjFzxg
         iD4dS6hSBXmNw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 38/51] iio:pressure:mpl3115: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr() etc
Date:   Sun,  2 Jan 2022 12:56:04 +0000
Message-Id: <20220102125617.1259804-39-jic23@kernel.org>
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
 drivers/iio/pressure/mpl3115.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/pressure/mpl3115.c b/drivers/iio/pressure/mpl3115.c
index e95b9a5475b4..e118d3067228 100644
--- a/drivers/iio/pressure/mpl3115.c
+++ b/drivers/iio/pressure/mpl3115.c
@@ -301,7 +301,6 @@ static int mpl3115_remove(struct i2c_client *client)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int mpl3115_suspend(struct device *dev)
 {
 	return mpl3115_standby(iio_priv(i2c_get_clientdata(
@@ -317,11 +316,7 @@ static int mpl3115_resume(struct device *dev)
 		data->ctrl_reg1);
 }
 
-static SIMPLE_DEV_PM_OPS(mpl3115_pm_ops, mpl3115_suspend, mpl3115_resume);
-#define MPL3115_PM_OPS (&mpl3115_pm_ops)
-#else
-#define MPL3115_PM_OPS NULL
-#endif
+DEFINE_SIMPLE_DEV_PM_OPS(mpl3115_pm_ops, mpl3115_suspend, mpl3115_resume);
 
 static const struct i2c_device_id mpl3115_id[] = {
 	{ "mpl3115", 0 },
@@ -339,7 +334,7 @@ static struct i2c_driver mpl3115_driver = {
 	.driver = {
 		.name	= "mpl3115",
 		.of_match_table = mpl3115_of_match,
-		.pm	= MPL3115_PM_OPS,
+		.pm	= pm_sleep_ptr(&mpl3115_pm_ops),
 	},
 	.probe = mpl3115_probe,
 	.remove = mpl3115_remove,
-- 
2.34.1

