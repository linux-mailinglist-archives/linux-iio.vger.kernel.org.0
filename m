Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60A68229BE2
	for <lists+linux-iio@lfdr.de>; Wed, 22 Jul 2020 17:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728936AbgGVPxW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 22 Jul 2020 11:53:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:35634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726427AbgGVPxW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 22 Jul 2020 11:53:22 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB1C320717;
        Wed, 22 Jul 2020 15:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595433201;
        bh=tJNRtj1pgUOXomhod3e9MpNDSMmcwEtsX1Km8Tcofnw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GYrGPZlmyZwwoISgUBXjlKBt0W4wzNM6+F2/7WMWudNa4+BK/11vsZLQhwDnAnsap
         fIv5z2+0G1rqUOB9+9agJ0I7Rgi3DaOr0dpUaVEU6YfxUqCC+TdthUVOabrWJpRoDG
         1w9AW2Owp+caRosv52h2kz3Bl3rkwnZUqJZqnnRs=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 09/27] iio:light:max44000 Fix timestamp alignment and prevent data leak.
Date:   Wed, 22 Jul 2020 16:50:45 +0100
Message-Id: <20200722155103.979802-10-jic23@kernel.org>
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
As Lars also noted this anti pattern can involve a leak of data to
userspace and that indeed can happen here.  We close both issues by
moving to a suitable structure in the iio_priv().
This data is allocated with kzalloc so no data can leak appart
from previous readings.

It is necessary to force the alignment of ts to avoid the padding
on x86_32 being different from 64 bit platorms (it alows for
4 bytes aligned 8 byte types.

Fixes: 06ad7ea10e2b ("max44000: Initial triggered buffer support")
Reported-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/light/max44000.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/light/max44000.c b/drivers/iio/light/max44000.c
index aa8ed1e3e89a..b8e721bced5b 100644
--- a/drivers/iio/light/max44000.c
+++ b/drivers/iio/light/max44000.c
@@ -75,6 +75,11 @@
 struct max44000_data {
 	struct mutex lock;
 	struct regmap *regmap;
+	/* Ensure naturally aligned timestamp */
+	struct {
+		u16 channels[2];
+		s64 ts __aligned(8);
+	} scan;
 };
 
 /* Default scale is set to the minimum of 0.03125 or 1 / (1 << 5) lux */
@@ -488,7 +493,6 @@ static irqreturn_t max44000_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct max44000_data *data = iio_priv(indio_dev);
-	u16 buf[8]; /* 2x u16 + padding + 8 bytes timestamp */
 	int index = 0;
 	unsigned int regval;
 	int ret;
@@ -498,17 +502,17 @@ static irqreturn_t max44000_trigger_handler(int irq, void *p)
 		ret = max44000_read_alsval(data);
 		if (ret < 0)
 			goto out_unlock;
-		buf[index++] = ret;
+		data->scan.channels[index++] = ret;
 	}
 	if (test_bit(MAX44000_SCAN_INDEX_PRX, indio_dev->active_scan_mask)) {
 		ret = regmap_read(data->regmap, MAX44000_REG_PRX_DATA, &regval);
 		if (ret < 0)
 			goto out_unlock;
-		buf[index] = regval;
+		data->scan.channels[index] = regval;
 	}
 	mutex_unlock(&data->lock);
 
-	iio_push_to_buffers_with_timestamp(indio_dev, buf,
+	iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
 					   iio_get_time_ns(indio_dev));
 	iio_trigger_notify_done(indio_dev->trig);
 	return IRQ_HANDLED;
-- 
2.27.0

