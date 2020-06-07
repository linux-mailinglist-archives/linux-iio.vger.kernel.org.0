Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 758EE1F0C9F
	for <lists+linux-iio@lfdr.de>; Sun,  7 Jun 2020 17:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbgFGP42 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 Jun 2020 11:56:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:57342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726631AbgFGP42 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 7 Jun 2020 11:56:28 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 347CC2078C;
        Sun,  7 Jun 2020 15:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591545388;
        bh=duArOxpewVlEIEs0Kj8syK3wzNGOBAJ/uJ57SD/1F7w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SDPwBA/D/fHbpYl324o55ZsG5hDojQZySUQyEBMVuNBN/4YW8Cr/l9P1ffeochIsW
         F+pl6Xozp6h26P8PjdJUI6fdQPnLQ0eP5V/I3YTyVEU7D0DcekzLUMEh1hT1Ws6rVr
         35QBjRigROUrSH61TvKNBdSPwUqwl/Mm6L9wpKHs=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Mikko Koivunen <mikko.koivunen@fi.rohmeurope.com>
Subject: [PATCH 10/32] iio:light:rpr0521 Fix timestamp alignment and prevent data leak.
Date:   Sun,  7 Jun 2020 16:53:46 +0100
Message-Id: <20200607155408.958437-11-jic23@kernel.org>
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
moving to a suitable structure in the iio_priv().
This data is allocated with kzalloc so no data can leak appart
from previous readings and in this case the status byte from the device.

The forced alignment of ts is not necessary in this case but it
potentially makes the code less fragile.

Fixes: e12ffd241c00 ("iio: light: rpr0521 triggered buffer")
Cc: Mikko Koivunen <mikko.koivunen@fi.rohmeurope.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/light/rpr0521.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/light/rpr0521.c b/drivers/iio/light/rpr0521.c
index c20fbc730d65..66f22ea3d68a 100644
--- a/drivers/iio/light/rpr0521.c
+++ b/drivers/iio/light/rpr0521.c
@@ -194,6 +194,17 @@ struct rpr0521_data {
 	bool pxs_need_dis;
 
 	struct regmap *regmap;
+
+	/*
+	 * Ensure correct naturally aligned timestamp.
+	 * Note that the read will put garbage data into
+	 * the padding but this should not be a problem
+	 */
+	struct {
+		__le16 channels[3];
+		u8 garbage;
+		s64 ts __aligned(8);
+	} scan;
 };
 
 static IIO_CONST_ATTR(in_intensity_scale_available, RPR0521_ALS_SCALE_AVAIL);
@@ -449,8 +460,6 @@ static irqreturn_t rpr0521_trigger_consumer_handler(int irq, void *p)
 	struct rpr0521_data *data = iio_priv(indio_dev);
 	int err;
 
-	u8 buffer[16]; /* 3 16-bit channels + padding + ts */
-
 	/* Use irq timestamp when reasonable. */
 	if (iio_trigger_using_own(indio_dev) && data->irq_timestamp) {
 		pf->timestamp = data->irq_timestamp;
@@ -461,11 +470,11 @@ static irqreturn_t rpr0521_trigger_consumer_handler(int irq, void *p)
 		pf->timestamp = iio_get_time_ns(indio_dev);
 
 	err = regmap_bulk_read(data->regmap, RPR0521_REG_PXS_DATA,
-		&buffer,
+		data->scan.channels,
 		(3 * 2) + 1);	/* 3 * 16-bit + (discarded) int clear reg. */
 	if (!err)
 		iio_push_to_buffers_with_timestamp(indio_dev,
-						   buffer, pf->timestamp);
+						   &data->scan, pf->timestamp);
 	else
 		dev_err(&data->client->dev,
 			"Trigger consumer can't read from sensor.\n");
-- 
2.26.2

