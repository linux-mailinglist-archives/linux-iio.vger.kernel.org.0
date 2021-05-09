Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5335A37766D
	for <lists+linux-iio@lfdr.de>; Sun,  9 May 2021 13:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbhEILik (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 May 2021 07:38:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:54208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229669AbhEILih (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 9 May 2021 07:38:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4CE146128C;
        Sun,  9 May 2021 11:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620560254;
        bh=b+tLoTv+lsAjiHxUo1wQsVHVNEJiZp1wTwI5sOMa2DA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jNB8IPxinP3SF1RjmYrEDBaD0t9naoRn1jvS5Q8NZQ1UIWV1vE88ng0k6Pi1HvXXQ
         8g+1qSsXfNUF+RE+ZzeIhLKm+V8HERMiIXOg3rHhTntBxPQDrf/Iwgt3LdWTGMqT8v
         CLYQoPFa96O7A1e2PY25cJWPY3HKcmFLIW4p1XL8Yp5jmR/+XVTeoKgXHIaNxJCXI8
         XEkw5GKTcOTr5RIkUemcfU8VaA1pltL747/7ANWZc3axAERLfpWmOjW8fKVDuFU/El
         Xs3KTrrAMGisp4N55LVsP5qNjUF0Cwxv5GwGZuchkGwELxQ+dbC8BKx5Fc3uz4v9Wo
         s1Lcb4KxwcVYg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 20/28] iio: light: us5182: Use pm_runtime_resume_and_get() to replace open coding.
Date:   Sun,  9 May 2021 12:33:46 +0100
Message-Id: <20210509113354.660190-21-jic23@kernel.org>
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
 drivers/iio/light/us5182d.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/light/us5182d.c b/drivers/iio/light/us5182d.c
index 393f27b75c75..96e4a66ddf28 100644
--- a/drivers/iio/light/us5182d.c
+++ b/drivers/iio/light/us5182d.c
@@ -367,9 +367,7 @@ static int us5182d_set_power_state(struct us5182d_data *data, bool on)
 		return 0;
 
 	if (on) {
-		ret = pm_runtime_get_sync(&data->client->dev);
-		if (ret < 0)
-			pm_runtime_put_noidle(&data->client->dev);
+		ret = pm_runtime_resume_and_get(&data->client->dev);
 	} else {
 		pm_runtime_mark_last_busy(&data->client->dev);
 		ret = pm_runtime_put_autosuspend(&data->client->dev);
-- 
2.31.1

