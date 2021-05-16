Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4463D381FC1
	for <lists+linux-iio@lfdr.de>; Sun, 16 May 2021 18:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbhEPQXS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 May 2021 12:23:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:50014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230032AbhEPQXR (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 16 May 2021 12:23:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6D11761076;
        Sun, 16 May 2021 16:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621182122;
        bh=Y1fnkHnFpkS2lZG/Y3hJviZQfBlot/NohwnJdg7WXA8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CG5NnC3R4qDex/HZEss5jENGwo/YkVdKSAvKZMZx6Tfls3cL8B/ZGz4cj8OKVcTgK
         UpBVlzxZzK5rSGByqpY40ak1NKD9nQKilqg0dFUyEyQ4NHzFOfJu8yI6BNX8oQvUDd
         oMDmbbM/H4yhNh771oKKLeJ/LQPgeWNROsDS5N1Q7+NXEZkG+UlH7tbEmkE+0Zit+Q
         CflGwH098V6anHGPkAiy9IxX9o6ojXqylgn74xRHNHJk87XZp/9KaF2Dr0wSCgXNiX
         Md5ASwb06fbXJJ8WqNHDUoUlNnitkIEyYPv6Lzsmbnctl0oK62qJC0MqOMFMhQPx42
         bOn9qgajKtuIQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 2/6] iio: adc: ads1015: Balance runtime pm +  pm_runtime_resume_and_get()
Date:   Sun, 16 May 2021 17:20:59 +0100
Message-Id: <20210516162103.1332291-3-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210516162103.1332291-1-jic23@kernel.org>
References: <20210516162103.1332291-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

The call to pm_runtime_put_noidle() in remove() is not balancing a
counter increment.  Note this doesn't matter as the runtime pm core
will not allow the counter to go negative.  However, it is confusing
to the reader so let's remove it.

The pm_runtime_resume_and_get() replacement was found using coccicheck
script under review at:
https://lore.kernel.org/lkml/20210427141946.2478411-1-Julia.Lawall@inria.fr/

This is a prequel to taking a closer look at the runtime pm in IIO drivers
in general.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ti-ads1015.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
index 5b828428be77..b0352e91ac16 100644
--- a/drivers/iio/adc/ti-ads1015.c
+++ b/drivers/iio/adc/ti-ads1015.c
@@ -323,9 +323,7 @@ static int ads1015_set_power_state(struct ads1015_data *data, bool on)
 	struct device *dev = regmap_get_device(data->regmap);
 
 	if (on) {
-		ret = pm_runtime_get_sync(dev);
-		if (ret < 0)
-			pm_runtime_put_noidle(dev);
+		ret = pm_runtime_resume_and_get(dev);
 	} else {
 		pm_runtime_mark_last_busy(dev);
 		ret = pm_runtime_put_autosuspend(dev);
@@ -1070,7 +1068,6 @@ static int ads1015_remove(struct i2c_client *client)
 
 	pm_runtime_disable(&client->dev);
 	pm_runtime_set_suspended(&client->dev);
-	pm_runtime_put_noidle(&client->dev);
 
 	/* power down single shot mode */
 	return ads1015_set_conv_mode(data, ADS1015_SINGLESHOT);
-- 
2.31.1

