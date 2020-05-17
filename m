Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F38021D6B81
	for <lists+linux-iio@lfdr.de>; Sun, 17 May 2020 19:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgEQRcS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 17 May 2020 13:32:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:51418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726362AbgEQRcR (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 17 May 2020 13:32:17 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1951207DA;
        Sun, 17 May 2020 17:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589736737;
        bh=YJFUKYZvTx3XnGzjToVULy1ag16cNtrvTy9ymAft06s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e+/1YfWej+xkl4QZJKMMUQeKB8xL4Qo6Ub1rpRGiG6OosQptuN+ORkWxE7a+Hfuzm
         uSH5c74C9t1VB15B8HJ5G0eYfycYs5OrqgTikscqDT5Wp+ZmIG6Pc98WlsLAMGIb02
         lyH1l0iyQSjzS+nv1F8TiQmpbuWKsUq/3VzbWu4s=
From:   jic23@kernel.org
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Tomasz Duszynski <tduszyns@gmail.com>
Subject: [PATCH 10/11] iio:chemical:sps30: Fix timestamp alignment
Date:   Sun, 17 May 2020 18:29:59 +0100
Message-Id: <20200517173000.220819-11-jic23@kernel.org>
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
this driver which uses an array of smaller elements on the stack.

Fixes: 232e0f6ddeae ("iio: chemical: add support for Sensirion SPS30 sensor")
Reported-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Tomasz Duszynski <tduszyns@gmail.com>
---
 drivers/iio/chemical/sps30.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/chemical/sps30.c b/drivers/iio/chemical/sps30.c
index acb9f8ecbb3d..a88c1fb875a0 100644
--- a/drivers/iio/chemical/sps30.c
+++ b/drivers/iio/chemical/sps30.c
@@ -230,15 +230,18 @@ static irqreturn_t sps30_trigger_handler(int irq, void *p)
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct sps30_state *state = iio_priv(indio_dev);
 	int ret;
-	s32 data[4 + 2]; /* PM1, PM2P5, PM4, PM10, timestamp */
+	struct {
+		s32 data[4]; /* PM1, PM2P5, PM4, PM10 */
+		s64 ts;
+	} scan;
 
 	mutex_lock(&state->lock);
-	ret = sps30_do_meas(state, data, 4);
+	ret = sps30_do_meas(state, scan.data, ARRAY_SIZE(scan.data));
 	mutex_unlock(&state->lock);
 	if (ret)
 		goto err;
 
-	iio_push_to_buffers_with_timestamp(indio_dev, data,
+	iio_push_to_buffers_with_timestamp(indio_dev, &scan,
 					   iio_get_time_ns(indio_dev));
 err:
 	iio_trigger_notify_done(indio_dev->trig);
-- 
2.26.2

