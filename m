Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32B621F0CA5
	for <lists+linux-iio@lfdr.de>; Sun,  7 Jun 2020 17:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbgFGP4f (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 Jun 2020 11:56:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:57444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726703AbgFGP4f (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 7 Jun 2020 11:56:35 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1361207C3;
        Sun,  7 Jun 2020 15:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591545394;
        bh=mMuKcBvTXiWZzJiaFG6JAmtS0d6Tu2YW0zZARGnklTY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XlmVDbbUtW8Q27lhucCqy+UcQylCiuARUbUa6TfWRVAwtefzBtJgb0TCYHPubvkmh
         SutjyAuBmm6thE9fKalEHMYMpBLUOTvN9BGnXdZn1mbE9tsBfQVYTUiDfYrFBtZHOU
         dyEFOLe5bpFQlXqDlEsE7dP46VbKqHgP4Op0HHJA=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 15/32] iio:magnetometer:mag3110 Fix alignment and data leak issues.
Date:   Sun,  7 Jun 2020 16:53:51 +0100
Message-Id: <20200607155408.958437-16-jic23@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200607155408.958437-1-jic23@kernel.org>
References: <20200607155408.958437-1-jic23@kernel.org>
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
This data is allocated with kzalloc so no data can leak apart from
previous readings.

The explicit alignment of ts is not necessary in this case but
does make the code slightly less fragile so I have included it.

Fixes: 39631b5f9584 ("iio: Add Freescale mag3110 magnetometer driver")
Reported-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/magnetometer/mag3110.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/magnetometer/mag3110.c b/drivers/iio/magnetometer/mag3110.c
index 4d305a21c379..e96113ca39bd 100644
--- a/drivers/iio/magnetometer/mag3110.c
+++ b/drivers/iio/magnetometer/mag3110.c
@@ -56,6 +56,12 @@ struct mag3110_data {
 	int sleep_val;
 	struct regulator *vdd_reg;
 	struct regulator *vddio_reg;
+	/* Ensure natural alignment of timestamp */
+	struct {
+		__be16 channels[3];
+		u8 temp;
+		s64 ts __aligned(8);
+	} scan;
 };
 
 static int mag3110_request(struct mag3110_data *data)
@@ -387,10 +393,9 @@ static irqreturn_t mag3110_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct mag3110_data *data = iio_priv(indio_dev);
-	u8 buffer[16]; /* 3 16-bit channels + 1 byte temp + padding + ts */
 	int ret;
 
-	ret = mag3110_read(data, (__be16 *) buffer);
+	ret = mag3110_read(data, data->scan.channels);
 	if (ret < 0)
 		goto done;
 
@@ -399,10 +404,10 @@ static irqreturn_t mag3110_trigger_handler(int irq, void *p)
 			MAG3110_DIE_TEMP);
 		if (ret < 0)
 			goto done;
-		buffer[6] = ret;
+		data->scan.temp = ret;
 	}
 
-	iio_push_to_buffers_with_timestamp(indio_dev, buffer,
+	iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
 		iio_get_time_ns(indio_dev));
 
 done:
-- 
2.26.2

