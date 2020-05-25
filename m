Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DDD61E1331
	for <lists+linux-iio@lfdr.de>; Mon, 25 May 2020 19:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391273AbgEYRJG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 25 May 2020 13:09:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:42578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388812AbgEYRJG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 25 May 2020 13:09:06 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 534BF207DA;
        Mon, 25 May 2020 17:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590426546;
        bh=P/qsnxYPMV2FGwuWAhBl8kCLLFpLGH3XIqJL5xPeNHw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s54pUHyhJ6ZSEzNbmO6BthwYYQAF3KFtykCAHnzrpigezdWcQ5GS1lkU2L16KXjuD
         OVqrYjQPAtHyZfhc6MRGVRkFmBhcEzXqGqS2snkLdogdENr1kuFki7NYAeml9H2LFE
         Ez5MT2MnSzTM4hMdU+KAukRzzQv9sngf5lf1xU9k=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 05/25] iio:light:ltr501 Fix timestamp alignment issue.
Date:   Mon, 25 May 2020 18:06:08 +0100
Message-Id: <20200525170628.503283-6-jic23@kernel.org>
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
Here we use a structure on the stack.  The driver already did an
explicit memset so no data leak was possible.

Note there has been some rework in this driver of the years, so no
way this will apply cleanly all the way back.

Fixes: 2690be905123 ("iio: Add Lite-On ltr501 ambient light / proximity sensor driver")
Reported-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/light/ltr501.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
index 5a3fcb127cd2..c8b1ca13eb55 100644
--- a/drivers/iio/light/ltr501.c
+++ b/drivers/iio/light/ltr501.c
@@ -1243,13 +1243,16 @@ static irqreturn_t ltr501_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct ltr501_data *data = iio_priv(indio_dev);
-	u16 buf[8];
+	struct {
+		u16 channels[3];
+		s64 ts;
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

