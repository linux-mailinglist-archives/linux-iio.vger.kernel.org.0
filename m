Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79097271393
	for <lists+linux-iio@lfdr.de>; Sun, 20 Sep 2020 13:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbgITL2b (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 20 Sep 2020 07:28:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:39486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726285AbgITL2b (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 20 Sep 2020 07:28:31 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1AD5B23119;
        Sun, 20 Sep 2020 11:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600601310;
        bh=qKkiifeQgZBculEoovyDxk+Ss7PduJetxuA0LhIeAI8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MuzWAxBvhRuTC9rYMPpMEd0amHWQ8AoNpplyG4V8y/OSnPF8sQD4Rp3NkGGysqLa0
         SCVGB0YN+0AAvzSX/tVxvos91VmBtPO1e7A/B0Zr6IvQOxXTPotOp49w9izIvi0X8y
         7F5T6rXfVS+RF7QT1qJ5nYJlV5poTJagHXkKzgt0=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Daniel Baluta <daniel.baluta@gmail.com>,
        Daniel Baluta <daniel.baluta@oss.nxp.com>
Subject: [PATCH v4 5/8] iio:imu:bmi160: Fix alignment and data leak issues
Date:   Sun, 20 Sep 2020 12:27:39 +0100
Message-Id: <20200920112742.170751-6-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200920112742.170751-1-jic23@kernel.org>
References: <20200920112742.170751-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
moving to a suitable array in the iio_priv() data with alignment
explicitly requested.  This data is allocated with kzalloc() so no
data can leak apart from previous readings.

In this driver, depending on which channels are enabled, the timestamp
can be in a number of locations.  Hence we cannot use a structure
to specify the data layout without it being misleading.

Fixes: 77c4ad2d6a9b ("iio: imu: Add initial support for Bosch BMI160")
Reported-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Daniel Baluta  <daniel.baluta@gmail.com>
Cc: Daniel Baluta <daniel.baluta@oss.nxp.com>
---
 v4: Improve comments and carry forwards shorter length.
 drivers/iio/imu/bmi160/bmi160.h      | 7 +++++++
 drivers/iio/imu/bmi160/bmi160_core.c | 6 ++----
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/imu/bmi160/bmi160.h b/drivers/iio/imu/bmi160/bmi160.h
index a82e040bd109..32c2ea2d7112 100644
--- a/drivers/iio/imu/bmi160/bmi160.h
+++ b/drivers/iio/imu/bmi160/bmi160.h
@@ -10,6 +10,13 @@ struct bmi160_data {
 	struct iio_trigger *trig;
 	struct regulator_bulk_data supplies[2];
 	struct iio_mount_matrix orientation;
+	/*
+	 * Ensure natural alignment for timestamp if present.
+	 * Max length needed: 2 * 3 channels + 4 bytes padding + 8 byte ts.
+	 * If fewer channels are enabled, less space may be needed, as
+	 * long as the timestamp is still aligned to 8 bytes.
+	 */
+	__le16 buf[12] __aligned(8);
 };
 
 extern const struct regmap_config bmi160_regmap_config;
diff --git a/drivers/iio/imu/bmi160/bmi160_core.c b/drivers/iio/imu/bmi160/bmi160_core.c
index 39fea58dd308..82f03a4dc47a 100644
--- a/drivers/iio/imu/bmi160/bmi160_core.c
+++ b/drivers/iio/imu/bmi160/bmi160_core.c
@@ -427,8 +427,6 @@ static irqreturn_t bmi160_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct bmi160_data *data = iio_priv(indio_dev);
-	__le16 buf[12];
-	/* 2 sens x 3 axis x __le16 + 2 x __le16 pad + 4 x __le16 tstamp */
 	int i, ret, j = 0, base = BMI160_REG_DATA_MAGN_XOUT_L;
 	__le16 sample;
 
@@ -438,10 +436,10 @@ static irqreturn_t bmi160_trigger_handler(int irq, void *p)
 				       &sample, sizeof(sample));
 		if (ret)
 			goto done;
-		buf[j++] = sample;
+		data->buf[j++] = sample;
 	}
 
-	iio_push_to_buffers_with_timestamp(indio_dev, buf, pf->timestamp);
+	iio_push_to_buffers_with_timestamp(indio_dev, data->buf, pf->timestamp);
 done:
 	iio_trigger_notify_done(indio_dev->trig);
 	return IRQ_HANDLED;
-- 
2.28.0

