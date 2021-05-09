Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 724A2377668
	for <lists+linux-iio@lfdr.de>; Sun,  9 May 2021 13:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbhEILie (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 May 2021 07:38:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:54134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229645AbhEILid (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 9 May 2021 07:38:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 04D6A6128C;
        Sun,  9 May 2021 11:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620560251;
        bh=283NxLrX//BLHBD8UnO4ihT6aUasQ2WS1A9+8nSljug=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rz5OworksElthKM1tHOmlw8fKtERf2/ZINfRRNEVRyXLwGPPHJgmzXyMnRTTfLZlv
         pEmQgh/lsRs/MCOlxkcGUUnvecvuD4+WB73o1nKkI6o57BwS0iRDOScaw+ox8Uz11S
         84DyDo3bcReXDOMImpeBUJDFkQNDqb4R2LYwnhpMtefv/tplsxC4UjpRX8zvhtwCx3
         hLQLLHSHQDX6lBgDPi8dTMkiaYxEdPI8pzP0OLurcdpjdIWmViK2djhSwAHhX8Ouwt
         L0wgfR2w0FrCYOf8hfv3kEt2mjHFpw8BxxdAq4fn6wu5MxWoSOHkRGtMmUJVSaS7PD
         dOry17GBcd9LQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>
Subject: [PATCH 18/28] iio: chemical: atlas-sensor: Use pm_runtime_resume_and_get() to replace open coding.
Date:   Sun,  9 May 2021 12:33:44 +0100
Message-Id: <20210509113354.660190-19-jic23@kernel.org>
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

As pm_runtime_resume_and_get() returns <= 0 take advantage of that to
change the error checking to if (ret) which is more in keeping with the
rest of this driver.

This is a prequel to taking a closer look at the runtime pm in IIO drivers
in general.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Matt Ranostay <matt.ranostay@konsulko.com>
---
 drivers/iio/chemical/atlas-sensor.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/chemical/atlas-sensor.c b/drivers/iio/chemical/atlas-sensor.c
index d10f921b233a..90bb3f5bff19 100644
--- a/drivers/iio/chemical/atlas-sensor.c
+++ b/drivers/iio/chemical/atlas-sensor.c
@@ -410,11 +410,9 @@ static int atlas_buffer_postenable(struct iio_dev *indio_dev)
 	struct atlas_data *data = iio_priv(indio_dev);
 	int ret;
 
-	ret = pm_runtime_get_sync(&data->client->dev);
-	if (ret < 0) {
-		pm_runtime_put_noidle(&data->client->dev);
+	ret = pm_runtime_resume_and_get(&data->client->dev);
+	if (ret)
 		return ret;
-	}
 
 	return atlas_set_interrupt(data, true);
 }
@@ -487,11 +485,9 @@ static int atlas_read_measurement(struct atlas_data *data, int reg, __be32 *val)
 	int suspended = pm_runtime_suspended(dev);
 	int ret;
 
-	ret = pm_runtime_get_sync(dev);
-	if (ret < 0) {
-		pm_runtime_put_noidle(dev);
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret)
 		return ret;
-	}
 
 	if (suspended)
 		msleep(data->chip->delay);
-- 
2.31.1

