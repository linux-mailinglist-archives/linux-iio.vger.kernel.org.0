Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22A0E1E1345
	for <lists+linux-iio@lfdr.de>; Mon, 25 May 2020 19:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391306AbgEYRJ0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 25 May 2020 13:09:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:42878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391301AbgEYRJ0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 25 May 2020 13:09:26 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3E4620723;
        Mon, 25 May 2020 17:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590426565;
        bh=G68Usw2U6nRxeR+vJb7TeOGTTy2D2HEYNeEVvVD3bK4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cZ9AblseYwu4LnfJXGWBRpiB+0T8iJCpaq2V+f5Jaz/EXye/xn00OYYPc4GMhb2Su
         C19P7sGNC+P2ZX3Hiifpor/iFNpNkT8rDkgfbs3j2syZZOTd+01SQS/ybtLReqCul1
         fpx18DPEbya/OoMKo8uJzmM+5vkjVPTMix/HTTpU=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Sean Nyekjaer <sean@geanix.com>
Subject: [PATCH 21/25] iio:adc:ti-ads8688 Fix alignment and potential data leak issue
Date:   Mon, 25 May 2020 18:06:24 +0100
Message-Id: <20200525170628.503283-22-jic23@kernel.org>
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
this driver which uses a 32 byte array of smaller elements on the stack.
As Lars also noted this anti pattern can involve a leak of data to
userspace and that indeed can happen here.  We close both issues by
moving to a suitable structure in the iio_priv() data with alignment
explicitly requested.  This data is allocated with kzalloc so no
data can leak apart from previous readings.

Fixes: 2a86487786b5 ("iio: adc: ti-ads8688: add trigger and buffer support")
Reported-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Sean Nyekjaer <sean@geanix.com>
---
 drivers/iio/adc/ti-ads8688.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ti-ads8688.c b/drivers/iio/adc/ti-ads8688.c
index 14fe7c320b52..8acc0f59de60 100644
--- a/drivers/iio/adc/ti-ads8688.c
+++ b/drivers/iio/adc/ti-ads8688.c
@@ -68,6 +68,12 @@ struct ads8688_state {
 	struct regulator		*reg;
 	unsigned int			vref_mv;
 	enum ads8688_range		range[8];
+	/*
+	 * Used to align data for pushing to IIO.
+	 * Ensure natural alignment of timestamps
+	 */
+	u16 buffer[ADS8688_MAX_CHANNELS + sizeof(s64)/sizeof(u16)] __aligned(8);
+
 	union {
 		__be32 d32;
 		u8 d8[4];
@@ -383,17 +389,17 @@ static irqreturn_t ads8688_trigger_handler(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
-	u16 buffer[ADS8688_MAX_CHANNELS + sizeof(s64)/sizeof(u16)];
+	struct ads8688_state *st = iio_priv(indio_dev);
 	int i, j = 0;
 
 	for (i = 0; i < indio_dev->masklength; i++) {
 		if (!test_bit(i, indio_dev->active_scan_mask))
 			continue;
-		buffer[j] = ads8688_read(indio_dev, i);
+		st->buffer[j] = ads8688_read(indio_dev, i);
 		j++;
 	}
 
-	iio_push_to_buffers_with_timestamp(indio_dev, buffer,
+	iio_push_to_buffers_with_timestamp(indio_dev, st->buffer,
 			iio_get_time_ns(indio_dev));
 
 	iio_trigger_notify_done(indio_dev->trig);
-- 
2.26.2

