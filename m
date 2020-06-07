Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5961F0CB3
	for <lists+linux-iio@lfdr.de>; Sun,  7 Jun 2020 17:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbgFGP4y (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 Jun 2020 11:56:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:57668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726703AbgFGP4y (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 7 Jun 2020 11:56:54 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9919206C3;
        Sun,  7 Jun 2020 15:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591545413;
        bh=sPusuvgLxBsWeZb1ceB3MObWrWc5hwbleK/4UxFoGT8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jiLKhtpALhRSEn8cWG6JOdu9ul10QOYmW6SjcTg4zXr2WEGBMN2kzMI3epUWGMFsO
         XLXMy340rlrteQp675PCvUK14DCNxiExcQp7x5WbaAsagmLBM9+MitwXPW7SyV8iF2
         LpKzAkNgjtCN7Z9ma1ebgK50zaWuqhaUYZRqSN/I=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Akinobu Mita <akinobu.mita@gmail.com>
Subject: [PATCH 29/32] iio:adc:ti-adc0832 Fix alignment issue with timestamp
Date:   Sun,  7 Jun 2020 16:54:05 +0100
Message-Id: <20200607155408.958437-30-jic23@kernel.org>
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

We fix this issues by moving to a suitable structure in the iio_priv()
data with alignment explicitly requested.  This data is allocated
with kzalloc so no data can leak apart from previous readings.
Note that previously no data could leak 'including' previous readings
but I don't think it is an issue to potentially leak them like
this now does.

Fixes: 815bbc87462a ("iio: ti-adc0832: add triggered buffer support")
Reported-by: Lars-Peter Clausen <lars@metafoo.de>
Cc: Akinobu Mita <akinobu.mita@gmail.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ti-adc0832.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ti-adc0832.c b/drivers/iio/adc/ti-adc0832.c
index 054db3425afa..a419c697272a 100644
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

