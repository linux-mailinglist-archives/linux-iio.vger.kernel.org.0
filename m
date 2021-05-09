Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3317377667
	for <lists+linux-iio@lfdr.de>; Sun,  9 May 2021 13:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbhEILic (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 May 2021 07:38:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:54084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229645AbhEILib (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 9 May 2021 07:38:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 29DB3613E5;
        Sun,  9 May 2021 11:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620560248;
        bh=L6bvA0UdHArtdy5oOTzfgym9WzGpT/8959l9seqgw0A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OAXddpyOVlyLb/vpGu5MJAN5j0iz0MVC6tKQcvwVp4H3ma8TQBCi96mosOb0A/tx6
         Ry0msRZ6o+VkUeARfSVsqtekR5eGM3+bs5Af05SRC3BNXqhoc/kyV2Ln2YwmfVPu6w
         ipP3QgF+IuixdjtxUn4zDAN6/cBcrq8HnH0fcxkrzHe6cKAL7ni1MIO9z77TKl7/4s
         aUODkkGj6iifnKjYZCZt2mlPVdzCV6jYAYN1nftQPT/7WfjfXCjnAgnP71x+BA9Nw5
         j7dwh1fvcH2ysftSinxokW8lmb2fX/8HC1pWumV49h7tCBfENSD0GefoZ9aZkxUztx
         3BG80TWu87zhg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 17/28] iio: adc: ads1015: Use pm_runtime_resume_and_get() to replace open coding.
Date:   Sun,  9 May 2021 12:33:43 +0100
Message-Id: <20210509113354.660190-18-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210509113354.660190-1-jic23@kernel.org>
References: <20210509113354.660190-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Found using coccicheck script under review at:
https://lore.kernel.org/lkml/20210427141946.2478411-1-Julia.Lawall@inria.fr/

This is a prequel to taking a closer look at the runtime pm in IIO drivers
in general.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ti-ads1015.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
index 9fef39bcf997..4b61ee3d2501 100644
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
-- 
2.31.1

