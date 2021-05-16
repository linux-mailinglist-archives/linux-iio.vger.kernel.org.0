Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADD88381FC2
	for <lists+linux-iio@lfdr.de>; Sun, 16 May 2021 18:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbhEPQXU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 May 2021 12:23:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:50024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230032AbhEPQXT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 16 May 2021 12:23:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5F8FB61183;
        Sun, 16 May 2021 16:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621182124;
        bh=L3DLCO5r4p/bxGtDFmXFiv1GSgRpjZHdnwSC6swVnao=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PP9tsnF4W2DduFl3gHjj/o0vl1nTG2YSZshoAFrIMIfgcxvpsx1CuHP+1UnSViLBm
         bjcF9liczCpRTCe7VujpPEGX6idVLPpCDUj47fsuizAN3q7PJ4vi6VlAWrrSLJFhVb
         +cgJkoQbSQRF9EQyW6XBr5r6uftUn/4yMO+/bZkhp/NViePMkcSFsHTr0ZtlMzXYsh
         Sw+lCyxHvjll6BwoQUZoWfv8tnnd8Hwyolg4JIODUpBuFx3n+cj1y+QSdRe42J6TPb
         k7iJmostRjVb3cIb1Wj7wHRBTAQsPkPeR7jE8JGnfxA8wFATomPsEOeDNsN5LrNV8v
         g1k53N3iPyAcw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>
Subject: [PATCH v2 3/6] iio: chemical: atlas-sensor: Balance runtime pm + pm_runtime_resume_and_get()
Date:   Sun, 16 May 2021 17:21:00 +0100
Message-Id: <20210516162103.1332291-4-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210516162103.1332291-1-jic23@kernel.org>
References: <20210516162103.1332291-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

The pm_runtime_put_noidle() call in remove isn't balanced with any get, so
drop it.  Note this isn't a bug as the runtime pm core will not allow the
reference count to go negative, making this a noop. However, it is
confusing to the reader so let's drop it.

pm_runtime_resume_and_get() replacement found using the coccicheck script
under review at:
https://lore.kernel.org/lkml/20210427141946.2478411-1-Julia.Lawall@inria.fr/

As pm_runtime_resume_and_get() returns <= 0 take advantage of that to
change the error checking to if (ret) which is more in keeping with the
rest of this driver.

This is a prequel to taking a closer look at the runtime pm in IIO drivers
in general.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Matt Ranostay <matt.ranostay@konsulko.com>
---
 drivers/iio/chemical/atlas-sensor.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/chemical/atlas-sensor.c b/drivers/iio/chemical/atlas-sensor.c
index 0fdb3b29c5eb..9cb99585b6ff 100644
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
@@ -741,7 +737,6 @@ static int atlas_remove(struct i2c_client *client)
 
 	pm_runtime_disable(&client->dev);
 	pm_runtime_set_suspended(&client->dev);
-	pm_runtime_put_noidle(&client->dev);
 
 	return atlas_set_powermode(data, 0);
 }
-- 
2.31.1

