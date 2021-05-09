Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 935A0377669
	for <lists+linux-iio@lfdr.de>; Sun,  9 May 2021 13:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbhEILii (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 May 2021 07:38:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:54164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229660AbhEILif (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 9 May 2021 07:38:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7377A613E5;
        Sun,  9 May 2021 11:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620560252;
        bh=ZIxGBvcZWUCfOZOMlWvE57HoHtq0JE4s5ZIJx7Ye7yw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qsBNBJvY8Wh4q8x3VIWbnH8idtZb908RMl6cHAtwKP752xRdymIUBsbiWQG2oIDAP
         EIINq8Ga2k8Fa3NGqoAN9SoSqwd1HlxWjcpGV6op8CgrBOqMzofkR9HkfZzDXDq7r4
         6/vufDj1Sib6z5VtnY/qyL410IV5TxAkcK233jwiEfrIqI3AP6i+W9eFfNO4XPFBCo
         5oM3vlbQnjg18QjxIWWzmuQbjLLP3AnrWmPxy9P5qJs4yopMq1B0Z2M7EnsUv3KLi4
         dkSkwaJzoswwSrNF22CqQbWHeYxyVZgd7o3CcfbH8onvZU3tFFfTC59WrqLzHGE+xT
         mBPLK8l0CUC/w==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 19/28] iio: light: pa12203001: Use pm_runtime_resume_and_get() to replace open coding.
Date:   Sun,  9 May 2021 12:33:45 +0100
Message-Id: <20210509113354.660190-20-jic23@kernel.org>
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
 drivers/iio/light/pa12203001.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/light/pa12203001.c b/drivers/iio/light/pa12203001.c
index bfade6577a38..a52b2c788540 100644
--- a/drivers/iio/light/pa12203001.c
+++ b/drivers/iio/light/pa12203001.c
@@ -186,9 +186,7 @@ static int pa12203001_set_power_state(struct pa12203001_data *data, bool on,
 	}
 
 	if (on) {
-		ret = pm_runtime_get_sync(&data->client->dev);
-		if (ret < 0)
-			pm_runtime_put_noidle(&data->client->dev);
+		ret = pm_runtime_resume_and_get(&data->client->dev);
 
 	} else {
 		pm_runtime_mark_last_busy(&data->client->dev);
-- 
2.31.1

