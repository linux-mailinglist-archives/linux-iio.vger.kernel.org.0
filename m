Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD851E1330
	for <lists+linux-iio@lfdr.de>; Mon, 25 May 2020 19:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391267AbgEYRJF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 25 May 2020 13:09:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:42568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388812AbgEYRJF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 25 May 2020 13:09:05 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16C80207D8;
        Mon, 25 May 2020 17:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590426544;
        bh=ZMLNo4cvgQNjTdwR1tJWRA46HQutBLqmURBHlJy0faQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1Odz5GuBc6OGwNnpNnkmz/YsIcxn/Ml13CwV033oF/FZY5O9t/Vfl+wXpGiMy+cJ7
         GKEcZcjmmZ8kN2hB493I3Hj2flA+hubp51ZlZcu7yL4Vca5pw79NWdHe9PC1wlWW8w
         LevHQekLnG9DLMC/plNEUq0oCK/s+Qyc/mI1F7ro=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Subject: [PATCH 04/25] iio:light:st_uvis25 Fix timestamp alignment and prevent data leak.
Date:   Mon, 25 May 2020 18:06:07 +0100
Message-Id: <20200525170628.503283-5-jic23@kernel.org>
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
moving to a suitable structure in the iio_priv()

This data is allocated with kzalloc so no data can leak apart
from previous readings.

Fixes: 3025c8688c1e ("iio: light: add support for UVIS25 sensor")
Reported-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
---
 drivers/iio/light/st_uvis25.h      | 5 +++++
 drivers/iio/light/st_uvis25_core.c | 6 +++---
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/light/st_uvis25.h b/drivers/iio/light/st_uvis25.h
index 78bc56aad129..f7027e4c4493 100644
--- a/drivers/iio/light/st_uvis25.h
+++ b/drivers/iio/light/st_uvis25.h
@@ -27,6 +27,11 @@ struct st_uvis25_hw {
 	struct iio_trigger *trig;
 	bool enabled;
 	int irq;
+	/* Ensure timestamp is naturally aligned */
+	struct {
+		u8 chan;
+		s64 ts;
+	} scan;
 };
 
 extern const struct dev_pm_ops st_uvis25_pm_ops;
diff --git a/drivers/iio/light/st_uvis25_core.c b/drivers/iio/light/st_uvis25_core.c
index d262c254b895..fe1f2dc970c7 100644
--- a/drivers/iio/light/st_uvis25_core.c
+++ b/drivers/iio/light/st_uvis25_core.c
@@ -234,17 +234,17 @@ static const struct iio_buffer_setup_ops st_uvis25_buffer_ops = {
 
 static irqreturn_t st_uvis25_buffer_handler_thread(int irq, void *p)
 {
-	u8 buffer[ALIGN(sizeof(u8), sizeof(s64)) + sizeof(s64)];
 	struct iio_poll_func *pf = p;
 	struct iio_dev *iio_dev = pf->indio_dev;
 	struct st_uvis25_hw *hw = iio_priv(iio_dev);
 	int err;
 
-	err = regmap_read(hw->regmap, ST_UVIS25_REG_OUT_ADDR, (int *)buffer);
+	err = regmap_read(hw->regmap, ST_UVIS25_REG_OUT_ADDR,
+			  (unsigned int *)&hw->scan.chan);
 	if (err < 0)
 		goto out;
 
-	iio_push_to_buffers_with_timestamp(iio_dev, buffer,
+	iio_push_to_buffers_with_timestamp(iio_dev, &hw->scan,
 					   iio_get_time_ns(iio_dev));
 
 out:
-- 
2.26.2

