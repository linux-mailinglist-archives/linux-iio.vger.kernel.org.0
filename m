Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4847D377657
	for <lists+linux-iio@lfdr.de>; Sun,  9 May 2021 13:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbhEILhy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 May 2021 07:37:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:53328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229563AbhEILhy (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 9 May 2021 07:37:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1A457613F0;
        Sun,  9 May 2021 11:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620560211;
        bh=4O8smvbRXT3ZKhx7nXvkIeuGltwgvdG5B/V8nM0pC8w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bsd4OL7n9VrkJGtSvHLqhEQ49J3L7HFfiZbDLikjI7nHKK4n98MRSJwtZTenYg3a5
         JHO/4pezpZWy1F8uOzzZVH3Amq9T2UwtLlzAGPAf9jwQdub5ConvhpVApiSHgRZVgZ
         W9esjnpVWaLJW1dDqCtYnAVqx60cCzGOx6Ln0obsHnWLw7zt4x3Daznr7cr3jDtQ0H
         ReQR8NeTDiyplC/vcq5RsbTADNeD3yzIQsnMpYCHg7MnwQ4bSuzKzbsqtmaqrYpNnF
         zQxOQp9HxAcW8B5/Hn//ChyS4qSgj1gNiAd5LAWIbyvsJXjzFr9AG+vEVEdiWAF1NB
         2h9hVWIy+wuOQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rui Miguel Silva <rui.silva@linaro.org>
Subject: [PATCH 01/28] iio: gyro: fxa210002c: Balance runtime pm + use pm_runtime_resume_and_get().
Date:   Sun,  9 May 2021 12:33:27 +0100
Message-Id: <20210509113354.660190-2-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210509113354.660190-1-jic23@kernel.org>
References: <20210509113354.660190-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

In both the probe() error path and remove() pm_runtime_put_noidle()
is called which will decrement the runtime pm reference count.
However, there is no matching function to have raised the reference count.
Not this isn't a fix as the runtime pm core will stop the reference count
going negative anyway.

An alternative would have been to raise the count in these paths, but
it is not clear why that would be necessary.

Whilst we are here replace some boilerplate with pm_runtime_resume_and_get()
Found using coccicheck script under review at:
https://lore.kernel.org/lkml/20210427141946.2478411-1-Julia.Lawall@inria.fr/

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Rui Miguel Silva <rui.silva@linaro.org>
---
 drivers/iio/gyro/fxas21002c_core.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/iio/gyro/fxas21002c_core.c b/drivers/iio/gyro/fxas21002c_core.c
index 5af7b48ff01a..539585b0d300 100644
--- a/drivers/iio/gyro/fxas21002c_core.c
+++ b/drivers/iio/gyro/fxas21002c_core.c
@@ -366,14 +366,7 @@ static int fxas21002c_write(struct fxas21002c_data *data,
 
 static int  fxas21002c_pm_get(struct fxas21002c_data *data)
 {
-	struct device *dev = regmap_get_device(data->regmap);
-	int ret;
-
-	ret = pm_runtime_get_sync(dev);
-	if (ret < 0)
-		pm_runtime_put_noidle(dev);
-
-	return ret;
+	return pm_runtime_resume_and_get(regmap_get_device(data->regmap));
 }
 
 static int  fxas21002c_pm_put(struct fxas21002c_data *data)
@@ -1002,7 +995,6 @@ int fxas21002c_core_probe(struct device *dev, struct regmap *regmap, int irq,
 pm_disable:
 	pm_runtime_disable(dev);
 	pm_runtime_set_suspended(dev);
-	pm_runtime_put_noidle(dev);
 
 	return ret;
 }
@@ -1016,7 +1008,6 @@ void fxas21002c_core_remove(struct device *dev)
 
 	pm_runtime_disable(dev);
 	pm_runtime_set_suspended(dev);
-	pm_runtime_put_noidle(dev);
 }
 EXPORT_SYMBOL_GPL(fxas21002c_core_remove);
 
-- 
2.31.1

