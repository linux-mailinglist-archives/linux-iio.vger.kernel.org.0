Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 196B537765F
	for <lists+linux-iio@lfdr.de>; Sun,  9 May 2021 13:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbhEILiQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 May 2021 07:38:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:53734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229609AbhEILiN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 9 May 2021 07:38:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9B7D5613F0;
        Sun,  9 May 2021 11:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620560230;
        bh=itbBRgIGcJitaSPlfQsKcJgN02UaghCL9Ye6hKHiibI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jFMxFIiCirbV8cukS6fydY19rwmClOS3sIpaHu4rhIcHQCn2Oaggpu1Ex+I45Zoj8
         VI0OCHY4DYBPuOAfy0JdlAQ+vfX5ZLENb+zlQCMtFmHh6IgrM0DPbFDA0qIR/Tw/B3
         10qjVCMswZxtDq3jOzsGAla0mKgn61Tak2cI9hKt+IKoJ5PRcgR0vjIK2korP8fgbI
         HEtSwjoM+gvNXXsF/xFO+9WWN24HPKMCq9kCvW9dTkJEBgl198Foa5bpl47v8iVYbM
         FlkHbUj6NJoCmN9E5S1DEZlBC8oA0z+oGaq+iKN6kb3Xqy89LitpDFNYL44b1E0JGK
         g0SIYYVVZvFdg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 09/28] iio: imu: kmx61: Balance runtime pm + use pm_runtime_resume_and_get()
Date:   Sun,  9 May 2021 12:33:35 +0100
Message-Id: <20210509113354.660190-10-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210509113354.660190-1-jic23@kernel.org>
References: <20210509113354.660190-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

No point in calling pm_runtime_put_noidle() that isn't balancing a get.
Note no actual impact because the runtime pm core protects against
a negative reference counter.

For the pm_runtime_resume_and_get() main interest is in clearing
out this old pattern to avoid it getting coppied into new submissions.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/imu/kmx61.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/iio/imu/kmx61.c b/drivers/iio/imu/kmx61.c
index d3e06ce99c1e..1dabfd615dab 100644
--- a/drivers/iio/imu/kmx61.c
+++ b/drivers/iio/imu/kmx61.c
@@ -750,7 +750,7 @@ static int kmx61_set_power_state(struct kmx61_data *data, bool on, u8 device)
 	}
 
 	if (on) {
-		ret = pm_runtime_get_sync(&data->client->dev);
+		ret = pm_runtime_resume_and_get(&data->client->dev);
 	} else {
 		pm_runtime_mark_last_busy(&data->client->dev);
 		ret = pm_runtime_put_autosuspend(&data->client->dev);
@@ -759,8 +759,6 @@ static int kmx61_set_power_state(struct kmx61_data *data, bool on, u8 device)
 		dev_err(&data->client->dev,
 			"Failed: kmx61_set_power_state for %d, ret %d\n",
 			on, ret);
-		if (on)
-			pm_runtime_put_noidle(&data->client->dev);
 
 		return ret;
 	}
@@ -1426,7 +1424,6 @@ static int kmx61_remove(struct i2c_client *client)
 
 	pm_runtime_disable(&client->dev);
 	pm_runtime_set_suspended(&client->dev);
-	pm_runtime_put_noidle(&client->dev);
 
 	if (client->irq > 0) {
 		iio_triggered_buffer_cleanup(data->acc_indio_dev);
-- 
2.31.1

