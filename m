Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31186229BE6
	for <lists+linux-iio@lfdr.de>; Wed, 22 Jul 2020 17:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729604AbgGVPx2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 22 Jul 2020 11:53:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:35692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729306AbgGVPx2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 22 Jul 2020 11:53:28 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF6A2207DD;
        Wed, 22 Jul 2020 15:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595433208;
        bh=/E/fLONlk2D40Co8MwdPnHBs/wsbak7ZiF44SBUW+ek=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=obwdA4t6YMZLMAjM7kG2orS2w6KPAYCYmrdLFHW+oiyPb5wjO9HclC5IyXof1nFRF
         Hv8yHP6nZVvvaErswx5+qFyfGh0DCmBt6llPiR9q4AUoS2vEjOz4y0JB6MRTsnxUcZ
         5Z/A71udaBRaq0yYXOq3Ldl+n8F8t1n5j1iZtS68=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Gregor Boirie <gregor.boirie@parrot.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v3 13/27] iio:magnetometer:ak8975 Fix alignment and data leak issues.
Date:   Wed, 22 Jul 2020 16:50:49 +0100
Message-Id: <20200722155103.979802-14-jic23@kernel.org>
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
this driver which uses an array of smaller elements on the stack.
As Lars also noted this anti pattern can involve a leak of data to
userspace and that indeed can happen here.  We close both issues by
moving to a suitable structure in the iio_priv() data.

This data is allocated with kzalloc so no data can leak apart from
previous readings.

The explicit alignment of ts is not necessary in this case as by
coincidence the padding will end up the same, however I consider
it to make the code less fragile and have included it.

Fixes: bc11ca4a0b84 ("iio:magnetometer:ak8975: triggered buffer support")
Reported-by: Lars-Peter Clausen <lars@metafoo.de>
Cc: Gregor Boirie <gregor.boirie@parrot.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/magnetometer/ak8975.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index 03d71f796177..623766ff800b 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -366,6 +366,12 @@ struct ak8975_data {
 	struct iio_mount_matrix orientation;
 	struct regulator	*vdd;
 	struct regulator	*vid;
+
+	/* Ensure natural alignment of timestamp */
+	struct {
+		s16 channels[3];
+		s64 ts __aligned(8);
+	} scan;
 };
 
 /* Enable attached power regulator if any. */
@@ -793,7 +799,6 @@ static void ak8975_fill_buffer(struct iio_dev *indio_dev)
 	const struct i2c_client *client = data->client;
 	const struct ak_def *def = data->def;
 	int ret;
-	s16 buff[8]; /* 3 x 16 bits axis values + 1 aligned 64 bits timestamp */
 	__le16 fval[3];
 
 	mutex_lock(&data->lock);
@@ -816,12 +821,13 @@ static void ak8975_fill_buffer(struct iio_dev *indio_dev)
 	mutex_unlock(&data->lock);
 
 	/* Clamp to valid range. */
-	buff[0] = clamp_t(s16, le16_to_cpu(fval[0]), -def->range, def->range);
-	buff[1] = clamp_t(s16, le16_to_cpu(fval[1]), -def->range, def->range);
-	buff[2] = clamp_t(s16, le16_to_cpu(fval[2]), -def->range, def->range);
+	data->scan.channels[0] = clamp_t(s16, le16_to_cpu(fval[0]), -def->range, def->range);
+	data->scan.channels[1] = clamp_t(s16, le16_to_cpu(fval[1]), -def->range, def->range);
+	data->scan.channels[2] = clamp_t(s16, le16_to_cpu(fval[2]), -def->range, def->range);
 
-	iio_push_to_buffers_with_timestamp(indio_dev, buff,
+	iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
 					   iio_get_time_ns(indio_dev));
+
 	return;
 
 unlock:
-- 
2.27.0

