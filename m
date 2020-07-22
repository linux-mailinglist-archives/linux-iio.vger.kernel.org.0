Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE1A229BDE
	for <lists+linux-iio@lfdr.de>; Wed, 22 Jul 2020 17:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbgGVPxR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 22 Jul 2020 11:53:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:35568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726427AbgGVPxQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 22 Jul 2020 11:53:16 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC505207E8;
        Wed, 22 Jul 2020 15:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595433195;
        bh=Qx6VAp2IInsTmEtO1B2pSFla9Ntl+3Z1V9YEjYutsus=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kkIjRr9Lc2aQh5AZ7grdw+/cBraMCehS4Hj32vj5TkHabY8k7VDeckqRQqAVHUU6G
         ryUANl9HX5HR4GjkAhUnoULjFM4pwQjK4tT0k7asvcIklWaIv76+wVJG7MHfV1ADJB
         2DxHjaB0G+U0x83PEjqfEBlKYE/Ci2rci27dl03s=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 05/27] iio:gyro:itg3200: Fix timestamp alignment and prevent data leak.
Date:   Wed, 22 Jul 2020 16:50:41 +0100
Message-Id: <20200722155103.979802-6-jic23@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200722155103.979802-1-jic23@kernel.org>
References: <20200722155103.979802-1-jic23@kernel.org>
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
this driver which uses a 16 byte array of smaller elements on the stack.
This is fixed by using an explicit c structure. As there are no
holes in the structure, there is no possiblity of data leakage
in this case.

The explicit alignment of ts is not strictly necessary but potentially
makes the code slightly less fragile.  It also removes the possibility
of this being cut and paste into another driver where the alignment
isn't already true.

Fixes: 36e0371e7764 ("iio:itg3200: Use iio_push_to_buffers_with_timestamp()")
Reported-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/gyro/itg3200_buffer.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/gyro/itg3200_buffer.c b/drivers/iio/gyro/itg3200_buffer.c
index d3fbe9d86467..1c3c1bd53374 100644
--- a/drivers/iio/gyro/itg3200_buffer.c
+++ b/drivers/iio/gyro/itg3200_buffer.c
@@ -46,13 +46,20 @@ static irqreturn_t itg3200_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct itg3200 *st = iio_priv(indio_dev);
-	__be16 buf[ITG3200_SCAN_ELEMENTS + sizeof(s64)/sizeof(u16)];
-
-	int ret = itg3200_read_all_channels(st->i2c, buf);
+	/*
+	 * Ensure correct alignment and padding including for the
+	 * timestamp that may be inserted.
+	 */
+	struct {
+		__be16 buf[ITG3200_SCAN_ELEMENTS];
+		s64 ts __aligned(8);
+	} scan;
+
+	int ret = itg3200_read_all_channels(st->i2c, scan.buf);
 	if (ret < 0)
 		goto error_ret;
 
-	iio_push_to_buffers_with_timestamp(indio_dev, buf, pf->timestamp);
+	iio_push_to_buffers_with_timestamp(indio_dev, &scan, pf->timestamp);
 
 	iio_trigger_notify_done(indio_dev->trig);
 
-- 
2.27.0

