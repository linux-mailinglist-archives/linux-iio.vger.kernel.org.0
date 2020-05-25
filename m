Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8DF1E132F
	for <lists+linux-iio@lfdr.de>; Mon, 25 May 2020 19:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389275AbgEYRJE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 25 May 2020 13:09:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:42558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388812AbgEYRJE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 25 May 2020 13:09:04 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F12B62078B;
        Mon, 25 May 2020 17:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590426543;
        bh=m8RwHQtW52r/AFKN3Dy02ncCis7GXGs0Kb7gVGLAjRo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Top3V7QSQNfAYMglMCaXMJ8piyOaHitaxaibLTG+gWzl4xqL9pM+u5O9n9X5agYSI
         XvnZKyhztS9jIdNMROZzQGId8dN0JuzqJZqQSnsfyW/EEJ7ozBRRzaUQG0p4uipphn
         XK5KpJWowpz8r+Yo3vk/lvDZyK+8adTdaPjU8e9M=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Mikko Koivunen <mikko.koivunen@fi.rohmeurope.com>
Subject: [PATCH 03/25] iio:light:rpr0521 Fix timestamp alignment and prevent data leak.
Date:   Mon, 25 May 2020 18:06:06 +0100
Message-Id: <20200525170628.503283-4-jic23@kernel.org>
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
This data is allocated with kzalloc so no data can leak appart
from previous readings and in this case the status byte from the device.

Fixes: e12ffd241c00 ("iio: light: rpr0521 triggered buffer")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Mikko Koivunen <mikko.koivunen@fi.rohmeurope.com>
---
 drivers/iio/light/rpr0521.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/light/rpr0521.c b/drivers/iio/light/rpr0521.c
index a0a7aeae5a82..a1fc8a91b2b6 100644
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
+		s64 ts;
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

