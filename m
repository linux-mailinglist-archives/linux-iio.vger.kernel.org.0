Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 985311E1346
	for <lists+linux-iio@lfdr.de>; Mon, 25 May 2020 19:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391307AbgEYRJ2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 25 May 2020 13:09:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:42890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391301AbgEYRJ1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 25 May 2020 13:09:27 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 406E320776;
        Mon, 25 May 2020 17:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590426567;
        bh=AETRhCeY7BNet5jvDUX2jK+rvWgMOMebVUXzSDccbDk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fXtE8LjcCBZCfCaGIw955mkuI/XP5yKE5Qy5oZIqHr4hH6iTlelMYlXrVL1uqvYng
         c2Lptvx0tMGY93EGr6v13Onj3ri2xFSi2AJTt/nXrR/ntteNmYI+HtokX8ClqV8CQq
         7D2r1ibkTO1YSKFUKdti0q3rl56zAmftobSpuDmI=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Akinobu Mita <akinobu.mita@gmail.com>
Subject: [PATCH 22/25] iio:adc:ti-adc0832 Fix alignment issue with timestamp
Date:   Mon, 25 May 2020 18:06:25 +0100
Message-Id: <20200525170628.503283-23-jic23@kernel.org>
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

We fix this issues by moving to a suitable structure in the iio_priv()
data with alignment explicitly requested.  This data is allocated
with kzalloc so no data can leak apart from previous readings.
Note that previously no data could leak 'including' previous readings
but I don't think it is an issue to potentially leak them like
this now does.

Fixes: 815bbc87462a ("iio: ti-adc0832: add triggered buffer support")
Reported-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Akinobu Mita <akinobu.mita@gmail.com>
---
 drivers/iio/adc/ti-adc0832.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ti-adc0832.c b/drivers/iio/adc/ti-adc0832.c
index 6ea39f4bbb37..f94c862b7821 100644
--- a/drivers/iio/adc/ti-adc0832.c
+++ b/drivers/iio/adc/ti-adc0832.c
@@ -28,6 +28,8 @@ struct adc0832 {
 	struct regulator *reg;
 	struct mutex lock;
 	u8 mux_bits;
+	/* 16x 1 byte ADC data + 8 bytes timestamp */
+	u8 data[24] __aligned(8);
 
 	u8 tx_buf[2] ____cacheline_aligned;
 	u8 rx_buf[2];
@@ -199,7 +201,6 @@ static irqreturn_t adc0832_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct adc0832 *adc = iio_priv(indio_dev);
-	u8 data[24] = { }; /* 16x 1 byte ADC data + 8 bytes timestamp */
 	int scan_index;
 	int i = 0;
 
@@ -217,10 +218,10 @@ static irqreturn_t adc0832_trigger_handler(int irq, void *p)
 			goto out;
 		}
 
-		data[i] = ret;
+		adc->data[i] = ret;
 		i++;
 	}
-	iio_push_to_buffers_with_timestamp(indio_dev, data,
+	iio_push_to_buffers_with_timestamp(indio_dev, adc->data,
 					   iio_get_time_ns(indio_dev));
 out:
 	mutex_unlock(&adc->lock);
-- 
2.26.2

