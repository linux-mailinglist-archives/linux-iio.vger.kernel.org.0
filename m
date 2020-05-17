Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C66891D6B7A
	for <lists+linux-iio@lfdr.de>; Sun, 17 May 2020 19:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbgEQRcL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 17 May 2020 13:32:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:51328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726362AbgEQRcK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 17 May 2020 13:32:10 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65D9E207E8;
        Sun, 17 May 2020 17:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589736730;
        bh=RHgVpYE0WH0sv+hQelqIqq0LxK+4GDd/mUHkbhjDXU0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k51yluV1qBu3Gdfc+RtAJ1VvUC9qoqWym1plGPKSRVJSsmfGRIu2NfOfegoFosLKB
         s0+MIXHU2MJli8hE4KbOfDM84jnLa+59Ky1EGheI8ECCVCxTR0g0yI2n9dQqPVOX/E
         1AElcMo8NTOxzIDilAl8i+s6kavYpU7EppE4J4x8=
From:   jic23@kernel.org
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 04/11] iio:accel:mma7455: Fix timestamp alignment and prevent data leak.
Date:   Sun, 17 May 2020 18:29:53 +0100
Message-Id: <20200517173000.220819-5-jic23@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200517173000.220819-1-jic23@kernel.org>
References: <20200517173000.220819-1-jic23@kernel.org>
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
this driver which uses a 16 byte u8 array on the stack   As Lars also noted
this anti pattern can involve a leak of data to userspace and that
indeed can happen here.  We close both issues by moving to
a suitable structure in the iio_priv() data with alignment
ensured by use of an explicit c structure.  This data is allocated
with kzalloc so no data can leak appart from previous readings.

Fixes: a84ef0d181d9 ("iio: accel: add Freescale MMA7455L/MMA7456L 3-axis accelerometer driver")
Reported-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/accel/mma7455_core.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/accel/mma7455_core.c b/drivers/iio/accel/mma7455_core.c
index 8b5a6aff9bf4..b48caece170e 100644
--- a/drivers/iio/accel/mma7455_core.c
+++ b/drivers/iio/accel/mma7455_core.c
@@ -52,6 +52,14 @@
 
 struct mma7455_data {
 	struct regmap *regmap;
+	/*
+	 * Used to reorganize data.  Will ensure correct alignment of
+	 * the timestamp if present
+	 */
+	struct {
+		__le16 channels[3];
+		s64 ts;
+	} scan;
 };
 
 static int mma7455_drdy(struct mma7455_data *mma7455)
@@ -82,19 +90,19 @@ static irqreturn_t mma7455_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct mma7455_data *mma7455 = iio_priv(indio_dev);
-	u8 buf[16]; /* 3 x 16-bit channels + padding + ts */
 	int ret;
 
 	ret = mma7455_drdy(mma7455);
 	if (ret)
 		goto done;
 
-	ret = regmap_bulk_read(mma7455->regmap, MMA7455_REG_XOUTL, buf,
-			       sizeof(__le16) * 3);
+	ret = regmap_bulk_read(mma7455->regmap, MMA7455_REG_XOUTL,
+			       mma7455->scan.channels,
+			       sizeof(mma7455->scan.channels));
 	if (ret)
 		goto done;
 
-	iio_push_to_buffers_with_timestamp(indio_dev, buf,
+	iio_push_to_buffers_with_timestamp(indio_dev, &mma7455->scan,
 					   iio_get_time_ns(indio_dev));
 
 done:
-- 
2.26.2

