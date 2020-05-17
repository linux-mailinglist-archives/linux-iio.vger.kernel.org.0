Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D33D1D6B80
	for <lists+linux-iio@lfdr.de>; Sun, 17 May 2020 19:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbgEQRcR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 17 May 2020 13:32:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:51404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726362AbgEQRcQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 17 May 2020 13:32:16 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80CC62067D;
        Sun, 17 May 2020 17:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589736736;
        bh=TovbVIMMBZOWAy33vNnHTfbzaqf11HmlYgiNALVSgzU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PdQdBxq2h7XCB+IrI9QhWk3kyjuHvMaqVcNkcq6TlD1LpBv5eQR/JusONobLL6Wun
         QruYsH8GQDvbr5BWh0Hsbjb7vK1doVw37haIWzYe/HinoZEBv0/3qr7G0o/9j9Ts9J
         twXC6XocGBV72mHURq/OXBWAxlm/ffNOqY4FQA3c=
From:   jic23@kernel.org
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>
Subject: [PATCH 09/11] iio:chemical:ccs811: Fix timestamp alignment and prevent data leak.
Date:   Sun, 17 May 2020 18:29:58 +0100
Message-Id: <20200517173000.220819-10-jic23@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200517173000.220819-1-jic23@kernel.org>
References: <20200517173000.220819-1-jic23@kernel.org>
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
moving to a suitable structure in the iio_priv() data with alignment
explicitly requested.  This data is allocated with kzalloc so no
data can leak appart from previous readings.

Fixes: 283d26917ad6 ("iio: chemical: ccs811: Add triggered buffer support")
Reported-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>
---
 drivers/iio/chemical/ccs811.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/chemical/ccs811.c b/drivers/iio/chemical/ccs811.c
index 3ecd633f9ed3..fe1901be320d 100644
--- a/drivers/iio/chemical/ccs811.c
+++ b/drivers/iio/chemical/ccs811.c
@@ -78,6 +78,11 @@ struct ccs811_data {
 	struct iio_trigger *drdy_trig;
 	struct gpio_desc *wakeup_gpio;
 	bool drdy_trig_on;
+	/* Ensures correct alignment of timestamp if present */
+	struct {
+		s16 channels[2];
+		s64 ts;
+	} scan;
 };
 
 static const struct iio_chan_spec ccs811_channels[] = {
@@ -327,17 +332,17 @@ static irqreturn_t ccs811_trigger_handler(int irq, void *p)
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct ccs811_data *data = iio_priv(indio_dev);
 	struct i2c_client *client = data->client;
-	s16 buf[8]; /* s16 eCO2 + s16 TVOC + padding + 8 byte timestamp */
 	int ret;
 
-	ret = i2c_smbus_read_i2c_block_data(client, CCS811_ALG_RESULT_DATA, 4,
-					    (u8 *)&buf);
+	ret = i2c_smbus_read_i2c_block_data(client, CCS811_ALG_RESULT_DATA,
+					    sizeof(data->scan.channels),
+					    (u8 *)data->scan.channels);
 	if (ret != 4) {
 		dev_err(&client->dev, "cannot read sensor data\n");
 		goto err;
 	}
 
-	iio_push_to_buffers_with_timestamp(indio_dev, buf,
+	iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
 					   iio_get_time_ns(indio_dev));
 
 err:
-- 
2.26.2

