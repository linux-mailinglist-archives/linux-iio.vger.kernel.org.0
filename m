Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA6A4381FC5
	for <lists+linux-iio@lfdr.de>; Sun, 16 May 2021 18:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbhEPQX0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 May 2021 12:23:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:50054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230210AbhEPQXZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 16 May 2021 12:23:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9CD3E610CA;
        Sun, 16 May 2021 16:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621182130;
        bh=WwsiPze7dj1of2AXA77/CyGgH0wvLu7RLi+6yEbP3fY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TQ/cQpu4co0s65sZYyBd6RMs/8xBlXecTVdYxIioIY9ojhG25R2lfo6zbkvZSbWOD
         6firTC0CrB/APZLes3vV8CPZbf3OgqWRPemskLnqeBJJ20g00afuKuHmVXD+ifNeWm
         /rscKQRcx9zRP07ByOnKW3b5MJ2e9uG2+vhjAdyPvyvX9rjsy9w9jeVlKaV2VkrEgn
         ysgRwjr2U4iJeZ7eUUY3vHK1jXmpVieDI+dlFaNLCgbDCl39O4KI5JdXGltyQh40hG
         JsCoinUMf6Ymw71o0q2oU0TBQYQPLjx9pqzIIKV7w6pYF68rZdCw7sRTB3BD7FOphq
         F/shnchuhuybw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH v2 6/6] iio: pressure: icp10100: Balance runtime pm + use pm_runtime_resume_and_get()
Date:   Sun, 16 May 2021 17:21:03 +0100
Message-Id: <20210516162103.1332291-7-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210516162103.1332291-1-jic23@kernel.org>
References: <20210516162103.1332291-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

The devm_ handled runtime pm disable calls pm_runtime_put_sync_suspend()
which isn't balancing a matching get call.  It isn't a bug as such,
because the runtime pm core doesn't decrement the reference count below
zero, but it is missleading so let's drop it.

Using pm_runtime_resume_and_get() new call makes it easy to handle
failures in resume as it doesn't hold a reference count if it exits
with an error.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
---
 drivers/iio/pressure/icp10100.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/pressure/icp10100.c b/drivers/iio/pressure/icp10100.c
index 48759fc4bf18..af4621eaa6b5 100644
--- a/drivers/iio/pressure/icp10100.c
+++ b/drivers/iio/pressure/icp10100.c
@@ -250,7 +250,9 @@ static int icp10100_get_measures(struct icp10100_state *st,
 	__be16 measures[3];
 	int ret;
 
-	pm_runtime_get_sync(&st->client->dev);
+	ret = pm_runtime_resume_and_get(&st->client->dev);
+	if (ret < 0)
+		return ret;
 
 	mutex_lock(&st->lock);
 	cmd = &icp10100_cmd_measure[st->mode];
@@ -525,7 +527,6 @@ static void icp10100_pm_disable(void *data)
 {
 	struct device *dev = data;
 
-	pm_runtime_put_sync_suspend(dev);
 	pm_runtime_disable(dev);
 }
 
-- 
2.31.1

