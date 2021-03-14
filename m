Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7549333A767
	for <lists+linux-iio@lfdr.de>; Sun, 14 Mar 2021 19:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233560AbhCNSRq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Mar 2021 14:17:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:45044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233570AbhCNSRj (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 14 Mar 2021 14:17:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CF22064EC3;
        Sun, 14 Mar 2021 18:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615745859;
        bh=G/yDof4P/Fe2MUjVSQA6rgTKsHYd9M9l46Jf2hH6wGM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RarVtevaI0nf/HEgste2cAnB5wTWei9yPz9FbYDZqKsWM9xnWBrwyk9TEfqg2X9ow
         oF0to5fb1TduPTig/UqUoAvigyTpk+h147yN1lDzNSLnfYCe+uHrrDibXOuReteGPW
         s3KoyQOCdB/tSDzO2uP4tsPEhjRuGJS0qv51fR2b8ZoA1vJJru7rJBXhf2MaVzyE12
         TU7PSRGorrDCQCcWj2TS88ybtZRIGZgRBZumUWRcskRcsxkHO+G+4V73ONA7kbqA0c
         KlHizfzQuK+VG87ETVwLXJRxBdILGN8qqs7BMyu9ccy/LQpAR9kX4Lge8iZs2T8Ahk
         DTq9WGq3SPS/Q==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Alexandru Ardelean <aardelean@deviqon.com>, Robh+dt@kernel.org,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2 08/24] staging:iio:cdc:ad7150: Drop noisy print in probe
Date:   Sun, 14 Mar 2021 18:14:55 +0000
Message-Id: <20210314181511.531414-9-jic23@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210314181511.531414-1-jic23@kernel.org>
References: <20210314181511.531414-1-jic23@kernel.org>
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
Reviewed-by: Barry Song <song.bao.hua@hisilicon.com>
Reviewed-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Link: https://lore.kernel.org/r/20210207154623.433442-9-jic23@kernel.org
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
2.30.2

