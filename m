Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 297131F0CAE
	for <lists+linux-iio@lfdr.de>; Sun,  7 Jun 2020 17:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbgFGP4s (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 Jun 2020 11:56:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:57592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726703AbgFGP4r (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 7 Jun 2020 11:56:47 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3191C2075A;
        Sun,  7 Jun 2020 15:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591545407;
        bh=uM0FYKGVkIcOcvlbf1vGvmQSGOxaLshXHdVEW9i+wN0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U2BUDz43U+k7LtJspMTnlhfE3AgRwRZJ+F71iZ5jf8reRlp76wInfrSiVIwlDuCQg
         rfTFKfi1AXRavJKu/1fS3ZBVXiBfoZAdED7MDqhfgBquvxCzfKy8nfmO+BLia2m6jB
         0CfKlVdJ7lb8NrKT9uCiqa2DvPB0C2z+0ii550eo=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        =?UTF-8?q?M=C3=A5rten=20Lindahl?= <martenli@axis.com>
Subject: [PATCH 24/32] iio:adc:ti-adc084s021 Fix alignment and data leak issues.
Date:   Sun,  7 Jun 2020 16:54:00 +0100
Message-Id: <20200607155408.958437-25-jic23@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200607155408.958437-1-jic23@kernel.org>
References: <20200607155408.958437-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
moving to a suitable structure in the iio_priv().

This data is allocated with kzalloc so no data can leak apart from
previous readings.

The force alignment of ts is not strictly necessary in this case
but reduces the fragility of the code.

Fixes: 3691e5a69449 ("iio: adc: add driver for the ti-adc084s021 chip")
Reported-by: Lars-Peter Clausen <lars@metafoo.de>
Cc: Mårten Lindahl <martenli@axis.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ti-adc084s021.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ti-adc084s021.c b/drivers/iio/adc/ti-adc084s021.c
index 376a0cf1f4ff..3ffbde379011 100644
--- a/drivers/iio/adc/ti-adc084s021.c
+++ b/drivers/iio/adc/ti-adc084s021.c
@@ -25,6 +25,11 @@ struct adc084s021 {
 	struct spi_transfer spi_trans;
 	struct regulator *reg;
 	struct mutex lock;
+	/* Buffer used to align data */
+	struct {
+		__be16 channels[4];
+		s64 ts __aligned(8);
+	} scan;
 	/*
 	 * DMA (thus cache coherency maintenance) requires the
 	 * transfer buffers to live in their own cache line.
@@ -140,14 +145,13 @@ static irqreturn_t adc084s021_buffer_trigger_handler(int irq, void *pollfunc)
 	struct iio_poll_func *pf = pollfunc;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct adc084s021 *adc = iio_priv(indio_dev);
-	__be16 data[8] = {0}; /* 4 * 16-bit words of data + 8 bytes timestamp */
 
 	mutex_lock(&adc->lock);
 
-	if (adc084s021_adc_conversion(adc, &data) < 0)
+	if (adc084s021_adc_conversion(adc, adc->scan.channels) < 0)
 		dev_err(&adc->spi->dev, "Failed to read data\n");
 
-	iio_push_to_buffers_with_timestamp(indio_dev, data,
+	iio_push_to_buffers_with_timestamp(indio_dev, &adc->scan,
 					   iio_get_time_ns(indio_dev));
 	mutex_unlock(&adc->lock);
 	iio_trigger_notify_done(indio_dev->trig);
-- 
2.26.2

