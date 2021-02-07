Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 533D6312586
	for <lists+linux-iio@lfdr.de>; Sun,  7 Feb 2021 16:50:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbhBGPuK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 Feb 2021 10:50:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:34028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229615AbhBGPuJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 7 Feb 2021 10:50:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AFDE864E54;
        Sun,  7 Feb 2021 15:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612712934;
        bh=5ktcO7M+7ub0BD03DVCMXmzuQaOquDyiftN7Rg9aDZo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pt0Fq2zeTiOBz2STEhg/BPWQLbYX6w0BGN4xOm84XAND7NJCwm5TkvKLDPY2lrFQB
         XBn6paMYmyJUdOGXB3KtBuOSaaOT2kaWNJge3GE0Nt/pCBH/9oBRrYPjzBwZy6rO7Y
         TScl9t3aXY9nAYinoFXs2CjxX/7xkwcGKsbIlTJJmDiDrTrGJANsJ7ni684LqACVpb
         yO3Ov7utKEPzLp/pHJqc9z9T8HI0OhngWLfxIHP+OsbbgqKehtROY0pIH7pgHggW05
         wPf/zCBBooFB+Shw3iil2t+RZhkmiYqPnIEFcjO+alBN8TOqYI1Zvu9uLQ5eB2MXcR
         y7y4n4hD+MTrA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        song.bao.hua@hisilicon.com, robh+dt@kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 08/24] staging:iio:cdc:ad7150: Drop noisy print in probe
Date:   Sun,  7 Feb 2021 15:46:07 +0000
Message-Id: <20210207154623.433442-9-jic23@kernel.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210207154623.433442-1-jic23@kernel.org>
References: <20210207154623.433442-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Also
* drop i2c_set_client_data() as now unused.
* white space cleanups

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/staging/iio/cdc/ad7150.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/iio/cdc/ad7150.c b/drivers/staging/iio/cdc/ad7150.c
index 34e6afe52f0e..8f8e472e3240 100644
--- a/drivers/staging/iio/cdc/ad7150.c
+++ b/drivers/staging/iio/cdc/ad7150.c
@@ -573,11 +573,9 @@ static int ad7150_probe(struct i2c_client *client,
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*chip));
 	if (!indio_dev)
 		return -ENOMEM;
+
 	chip = iio_priv(indio_dev);
 	mutex_init(&chip->state_lock);
-	/* this is only used for device removal purposes */
-	i2c_set_clientdata(client, indio_dev);
-
 	chip->client = client;
 
 	indio_dev->name = id->name;
@@ -624,14 +622,7 @@ static int ad7150_probe(struct i2c_client *client,
 		}
 	}
 
-	ret = devm_iio_device_register(indio_dev->dev.parent, indio_dev);
-	if (ret)
-		return ret;
-
-	dev_info(&client->dev, "%s capacitive sensor registered,irq: %d\n",
-		 id->name, client->irq);
-
-	return 0;
+	return devm_iio_device_register(indio_dev->dev.parent, indio_dev);
 }
 
 static const struct i2c_device_id ad7150_id[] = {
-- 
2.30.0

