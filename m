Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3FF1E1335
	for <lists+linux-iio@lfdr.de>; Mon, 25 May 2020 19:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391277AbgEYRJM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 25 May 2020 13:09:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:42624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388812AbgEYRJL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 25 May 2020 13:09:11 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D52720870;
        Mon, 25 May 2020 17:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590426551;
        bh=CvCCODs9v6cJ+sXq8doRK2RVNbHkTrQleIsyW0aZ3bg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BFgApHMvqKGJ4ngpQ8h8ZiWM9zDjFeKOWrDEf5/vqvCBBjISQ9EsNwMJvTqnIdmpE
         DdSwtwpZq80oxC2aTDSVFYEUWEmZk+OjO4AhzD4qkO+uVkOFze5QA5fIbZP2x6zdTw
         8lGcuFETGbQH9S7M7ECju2je3fw9Ljn4J+8avdLA=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alison Schofield <amsfield22@gmail.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>
Subject: [PATCH 09/25] iio:humidity:hdc100x Fix alignment and data leak issues
Date:   Mon, 25 May 2020 18:06:12 +0100
Message-Id: <20200525170628.503283-10-jic23@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200525170628.503283-1-jic23@kernel.org>
References: <20200525170628.503283-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

One of a class of bugs pointed out by Lars in a recent review.
iio_push_to_buffers_with_timestamp assumes the buffer used is aligned
to the size of the timestamp (8 bytes).  This is not guaranteed in
this driver which uses an array of smaller elements on the stack.
As Lars also noted this anti pattern can involve a leak of data to
userspace and that indeed can happen here.  We close both issues by
moving to a suitable structure in the iio_priv() data.
This data is allocated with kzalloc so no data can leak apart
from previous readings.

Fixes: 16bf793f86b2 ("iio: humidity: hdc100x: add triggered buffer support for HDC100X")
Reported-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Alison Schofield <amsfield22@gmail.com>
Cc: Matt Ranostay <matt.ranostay@konsulko.com>
---
 drivers/iio/humidity/hdc100x.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/humidity/hdc100x.c b/drivers/iio/humidity/hdc100x.c
index 7ecd2ffa3132..fd825e281d4f 100644
--- a/drivers/iio/humidity/hdc100x.c
+++ b/drivers/iio/humidity/hdc100x.c
@@ -38,6 +38,11 @@ struct hdc100x_data {
 
 	/* integration time of the sensor */
 	int adc_int_us[2];
+	/* Ensure natural alignment of timestamp */
+	struct {
+		__be16 channels[2];
+		s64 ts;
+	} scan;
 };
 
 /* integration time in us */
@@ -322,7 +327,6 @@ static irqreturn_t hdc100x_trigger_handler(int irq, void *p)
 	struct i2c_client *client = data->client;
 	int delay = data->adc_int_us[0] + data->adc_int_us[1];
 	int ret;
-	s16 buf[8];  /* 2x s16 + padding + 8 byte timestamp */
 
 	/* dual read starts at temp register */
 	mutex_lock(&data->lock);
@@ -333,13 +337,13 @@ static irqreturn_t hdc100x_trigger_handler(int irq, void *p)
 	}
 	usleep_range(delay, delay + 1000);
 
-	ret = i2c_master_recv(client, (u8 *)buf, 4);
+	ret = i2c_master_recv(client, (u8 *)data->scan.channels, 4);
 	if (ret < 0) {
 		dev_err(&client->dev, "cannot read sensor data\n");
 		goto err;
 	}
 
-	iio_push_to_buffers_with_timestamp(indio_dev, buf,
+	iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
 					   iio_get_time_ns(indio_dev));
 err:
 	mutex_unlock(&data->lock);
-- 
2.26.2

