Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02CC81F0CA2
	for <lists+linux-iio@lfdr.de>; Sun,  7 Jun 2020 17:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbgFGP4b (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 Jun 2020 11:56:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:57374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726703AbgFGP4b (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 7 Jun 2020 11:56:31 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6CD920723;
        Sun,  7 Jun 2020 15:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591545390;
        bh=kB6f4yVW/JpgGxwha4XSD5/n+WvVjsG7v5Tz7QWGmBw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s3+Zgylo2/hHN4+c76bFP8pTRhgKLlQ72HpNt1U5+fxRmy9jGyf7Ais9ROLGCm7p0
         ZFK6hOxhvGvVemeGjtkjAAfW1ILBElmJ0U14T1MocE75TQdKKEQE3cGSvp6DomnZOJ
         wqOUa0cKlKF60pnHk82voKDilDiVxC4ibU/JPH90=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 12/32] iio:light:ltr501 Fix timestamp alignment issue.
Date:   Sun,  7 Jun 2020 16:53:48 +0100
Message-Id: <20200607155408.958437-13-jic23@kernel.org>
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
Here we use a structure on the stack.  The driver already did an
explicit memset so no data leak was possible.

Forced alignment of ts is not strictly necessary but probably makes
the code slightly less fragile.

Note there has been some rework in this driver of the years, so no
way this will apply cleanly all the way back.

Fixes: 2690be905123 ("iio: Add Lite-On ltr501 ambient light / proximity sensor driver")
Reported-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/light/ltr501.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
index 4bac0646398d..b4323d2db0b1 100644
--- a/drivers/iio/light/ltr501.c
+++ b/drivers/iio/light/ltr501.c
@@ -1243,13 +1243,16 @@ static irqreturn_t ltr501_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct ltr501_data *data = iio_priv(indio_dev);
-	u16 buf[8];
+	struct {
+		u16 channels[3];
+		s64 ts __aligned(8);
+	} scan;
 	__le16 als_buf[2];
 	u8 mask = 0;
 	int j = 0;
 	int ret, psdata;
 
-	memset(buf, 0, sizeof(buf));
+	memset(&scan, 0, sizeof(scan));
 
 	/* figure out which data needs to be ready */
 	if (test_bit(0, indio_dev->active_scan_mask) ||
@@ -1268,9 +1271,9 @@ static irqreturn_t ltr501_trigger_handler(int irq, void *p)
 		if (ret < 0)
 			return ret;
 		if (test_bit(0, indio_dev->active_scan_mask))
-			buf[j++] = le16_to_cpu(als_buf[1]);
+			scan.channels[j++] = le16_to_cpu(als_buf[1]);
 		if (test_bit(1, indio_dev->active_scan_mask))
-			buf[j++] = le16_to_cpu(als_buf[0]);
+			scan.channels[j++] = le16_to_cpu(als_buf[0]);
 	}
 
 	if (mask & LTR501_STATUS_PS_RDY) {
@@ -1278,10 +1281,10 @@ static irqreturn_t ltr501_trigger_handler(int irq, void *p)
 				       &psdata, 2);
 		if (ret < 0)
 			goto done;
-		buf[j++] = psdata & LTR501_PS_DATA_MASK;
+		scan.channels[j++] = psdata & LTR501_PS_DATA_MASK;
 	}
 
-	iio_push_to_buffers_with_timestamp(indio_dev, buf,
+	iio_push_to_buffers_with_timestamp(indio_dev, &scan,
 					   iio_get_time_ns(indio_dev));
 
 done:
-- 
2.26.2

