Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B15341E1333
	for <lists+linux-iio@lfdr.de>; Mon, 25 May 2020 19:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391275AbgEYRJJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 25 May 2020 13:09:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:42602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388812AbgEYRJJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 25 May 2020 13:09:09 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A98532078B;
        Mon, 25 May 2020 17:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590426548;
        bh=2ZongO4r61nzcvxv3gVNk8l5fF2nHAYt8WrvrUHK6PI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tfW3fbN59Y81bT2okCVlNyvD44wESrnqEnmbu/fCvGkdUFLKCI0m1uNkMDwIEOZW0
         L6K8oB6xH9eBPeOGhP9/fAbh2MtE1+6e9U4E07H8mTn+zqcZadviZTK41UlA8Yga5Q
         8zalC3Z6s25Iqzy40MQ2p/i+teRjuqHGzGUWHD90=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Gregor Boirie <gregor.boirie@parrot.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 07/25] iio:magnetometer:ak8975 Fix alignment and data leak issues.
Date:   Mon, 25 May 2020 18:06:10 +0100
Message-Id: <20200525170628.503283-8-jic23@kernel.org>
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
moving to a suitable structure in the iio_priv() data.

This data is allocated with kzalloc so no data can leak apart from
previous readings.

Fixes: bc11ca4a0b84 ("iio:magnetometer:ak8975: triggered buffer support")
Reported-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Gregor Boirie <gregor.boirie@parrot.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/iio/magnetometer/ak8975.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index 3c881541ae72..673ac70d014d 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -365,6 +365,12 @@ struct ak8975_data {
 	struct iio_mount_matrix orientation;
 	struct regulator	*vdd;
 	struct regulator	*vid;
+
+	/* Ensure natural alignment of timestamp */
+	struct {
+		s16 channels[3];
+		s64 ts;
+	} scan;
 };
 
 /* Enable attached power regulator if any. */
@@ -787,7 +793,6 @@ static void ak8975_fill_buffer(struct iio_dev *indio_dev)
 	const struct i2c_client *client = data->client;
 	const struct ak_def *def = data->def;
 	int ret;
-	s16 buff[8]; /* 3 x 16 bits axis values + 1 aligned 64 bits timestamp */
 	__le16 fval[3];
 
 	mutex_lock(&data->lock);
@@ -810,11 +815,14 @@ static void ak8975_fill_buffer(struct iio_dev *indio_dev)
 	mutex_unlock(&data->lock);
 
 	/* Clamp to valid range. */
-	buff[0] = clamp_t(s16, le16_to_cpu(fval[0]), -def->range, def->range);
-	buff[1] = clamp_t(s16, le16_to_cpu(fval[1]), -def->range, def->range);
-	buff[2] = clamp_t(s16, le16_to_cpu(fval[2]), -def->range, def->range);
-
-	iio_push_to_buffers_with_timestamp(indio_dev, buff,
+	data->scan.channels[0] =
+		clamp_t(s16, le16_to_cpu(fval[0]), -def->range, def->range);
+	data->scan.channels[1] =
+		clamp_t(s16, le16_to_cpu(fval[1]), -def->range, def->range);
+	data->scan.channels[2] =
+		clamp_t(s16, le16_to_cpu(fval[2]), -def->range, def->range);
+
+	iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
 					   iio_get_time_ns(indio_dev));
 	return;
 
-- 
2.26.2

