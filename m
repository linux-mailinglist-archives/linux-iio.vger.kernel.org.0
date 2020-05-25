Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E559D1E133F
	for <lists+linux-iio@lfdr.de>; Mon, 25 May 2020 19:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391300AbgEYRJV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 25 May 2020 13:09:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:42806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391297AbgEYRJU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 25 May 2020 13:09:20 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C67F20849;
        Mon, 25 May 2020 17:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590426559;
        bh=f/Nc+hedZHg36KsmzFlx/ePuPCJOi0vgAcBQ6L23fr0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gMBwNncBiWiGqwGuZIOXEAW8hDbdPMLKL5ZZsGJKarLetA3w4dlZDnuD/WmJGBopv
         9eBBdag2NcId3pMApdBede0f8w4A7HWr+puLYhtkcuMVSY0g1eDkYaTdPPn+e9Pn0f
         qYkYI4iYc+7WIYtuIcpeHtaw7iju8Vwe1+DU4K0I=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 16/25] iio:adc:ti-adc081c Fix alignment and data leak issues
Date:   Mon, 25 May 2020 18:06:19 +0100
Message-Id: <20200525170628.503283-17-jic23@kernel.org>
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
moving to a suitable structure in the iio_priv().

This data is allocated with kzalloc so no data can leak apart
from previous readings.

Fixes: 08e05d1fce5c (" ti-adc081c: Initial triggered buffer support")
Reported-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ti-adc081c.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ti-adc081c.c b/drivers/iio/adc/ti-adc081c.c
index 0235863ff77b..a5c1a438370d 100644
--- a/drivers/iio/adc/ti-adc081c.c
+++ b/drivers/iio/adc/ti-adc081c.c
@@ -33,6 +33,12 @@ struct adc081c {
 
 	/* 8, 10 or 12 */
 	int bits;
+
+	/* Ensure natural alignment of buffer elements */
+	struct {
+		u16 channel;
+		s64 ts;
+	} scan;
 };
 
 #define REG_CONV_RES 0x00
@@ -128,14 +134,13 @@ static irqreturn_t adc081c_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct adc081c *data = iio_priv(indio_dev);
-	u16 buf[8]; /* 2 bytes data + 6 bytes padding + 8 bytes timestamp */
 	int ret;
 
 	ret = i2c_smbus_read_word_swapped(data->i2c, REG_CONV_RES);
 	if (ret < 0)
 		goto out;
-	buf[0] = ret;
-	iio_push_to_buffers_with_timestamp(indio_dev, buf,
+	data->scan.channel = ret;
+	iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
 					   iio_get_time_ns(indio_dev));
 out:
 	iio_trigger_notify_done(indio_dev->trig);
-- 
2.26.2

