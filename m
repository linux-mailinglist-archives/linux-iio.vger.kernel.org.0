Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3750482B4C
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jan 2022 13:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232233AbiABMxB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 2 Jan 2022 07:53:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbiABMxA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Jan 2022 07:53:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C19C061574
        for <linux-iio@vger.kernel.org>; Sun,  2 Jan 2022 04:53:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 20D77B80CFC
        for <linux-iio@vger.kernel.org>; Sun,  2 Jan 2022 12:52:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC8BDC36AF1;
        Sun,  2 Jan 2022 12:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641127977;
        bh=lA3Ngi7s/856LrQ5xGdzJnLsQjiAr4PRqnBU1S6Sc84=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ft5sDpgTzEuFbCAdxsvPDUJ1jK+qDPvGf0SFRi9sQoNSsrm/9bYxp/nFByHGl3nhZ
         80E1V4oCDHTLEM7CC9CSX8kBY8DvkUJbNZLLv+JqqFAFJybGpGKNMZ1pTsjppgs3qD
         M9ycnIvDu/8p+YmyJxX0+9D2DLirsnjmW+cxN/PeljuVfEO/jWQL/l9RzQnGn+05Th
         FtUGenUGJ2rdAN4S1DbZTTYtZmePGe90bkyyLsA/YTaA2LwUvA/PM9aa077loG1Thl
         guwfJfKgyiOLJusi2xntB3ZAl+kkT6oEOgkad2ijMkE6KLcDoLOGIMCAohHZYM09GN
         Ak2Xw5vSz4QJw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>
Subject: [PATCH v2 45/51] iio:chemical:atlas: Switch from CONFIG_PM guards to pm_ptr() etc
Date:   Sun,  2 Jan 2022 12:56:11 +0000
Message-Id: <20220102125617.1259804-46-jic23@kernel.org>
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

Acked-by: Matt Ranostay <matt.ranostay@konsulko.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/chemical/atlas-sensor.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/chemical/atlas-sensor.c b/drivers/iio/chemical/atlas-sensor.c
index 04b44a327614..c489d5593ba0 100644
--- a/drivers/iio/chemical/atlas-sensor.c
+++ b/drivers/iio/chemical/atlas-sensor.c
@@ -737,7 +737,6 @@ static int atlas_remove(struct i2c_client *client)
 	return atlas_set_powermode(data, 0);
 }
 
-#ifdef CONFIG_PM
 static int atlas_runtime_suspend(struct device *dev)
 {
 	struct atlas_data *data =
@@ -753,18 +752,16 @@ static int atlas_runtime_resume(struct device *dev)
 
 	return atlas_set_powermode(data, 1);
 }
-#endif
 
 static const struct dev_pm_ops atlas_pm_ops = {
-	SET_RUNTIME_PM_OPS(atlas_runtime_suspend,
-			   atlas_runtime_resume, NULL)
+	RUNTIME_PM_OPS(atlas_runtime_suspend, atlas_runtime_resume, NULL)
 };
 
 static struct i2c_driver atlas_driver = {
 	.driver = {
 		.name	= ATLAS_DRV_NAME,
 		.of_match_table	= atlas_dt_ids,
-		.pm	= &atlas_pm_ops,
+		.pm	= pm_ptr(&atlas_pm_ops),
 	},
 	.probe		= atlas_probe,
 	.remove		= atlas_remove,
-- 
2.34.1

