Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 117B61D6B7E
	for <lists+linux-iio@lfdr.de>; Sun, 17 May 2020 19:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbgEQRcO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 17 May 2020 13:32:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:51380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726362AbgEQRcO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 17 May 2020 13:32:14 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3F3220810;
        Sun, 17 May 2020 17:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589736733;
        bh=te4lt9SuagOI5X8R2hnGAgrUQqUKRttx/WZsbIr7q2o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jZpz2DKY+vWx3YWAdw3rYcFc+gZAS7VHcR/Ditq5SiH/TfahJ8NyyGzdrQufjF74i
         +7LAQTMzPdQap2NPnNRic4zkY681wMzS0/tEF7Wff/9jalO0i03eKOm85EhFhSeOpP
         prvgD5hr7Vz8bAhtWjN99WavBheQnf7ibaS/x620=
From:   jic23@kernel.org
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Andrew F . Davis" <afd@ti.com>
Subject: [PATCH 07/11] iio:health:afe4403 Fix timestamp alignment and prevent data leak.
Date:   Sun, 17 May 2020 18:29:56 +0100
Message-Id: <20200517173000.220819-8-jic23@kernel.org>
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
this driver which uses a 32 byte array of smaller elements on the stack.
As Lars also noted this anti pattern can involve a leak of data to
userspace and that indeed can happen here.  We close both issues by
moving to a suitable structure in the iio_priv() data with alignment
explicitly requested.  This data is allocated with kzalloc so no
data can leak appart from previous readings.

Fixes: eec96d1e2d31 ("iio: health: Add driver for the TI AFE4403 heart monitor")
Reported-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Andrew F. Davis <afd@ti.com>
---
 drivers/iio/health/afe4403.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/health/afe4403.c b/drivers/iio/health/afe4403.c
index e9f87e42ff4f..a3507624b30f 100644
--- a/drivers/iio/health/afe4403.c
+++ b/drivers/iio/health/afe4403.c
@@ -65,6 +65,7 @@ static const struct reg_field afe4403_reg_fields[] = {
  * @regulator: Pointer to the regulator for the IC
  * @trig: IIO trigger for this device
  * @irq: ADC_RDY line interrupt number
+ * @buffer: Used to construct data layout to push into IIO buffer.
  */
 struct afe4403_data {
 	struct device *dev;
@@ -74,6 +75,8 @@ struct afe4403_data {
 	struct regulator *regulator;
 	struct iio_trigger *trig;
 	int irq;
+	/* Ensure suitable alignment for timestamp */
+	s32 buffer[8] __aligned(8);
 };
 
 enum afe4403_chan_id {
@@ -309,7 +312,6 @@ static irqreturn_t afe4403_trigger_handler(int irq, void *private)
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct afe4403_data *afe = iio_priv(indio_dev);
 	int ret, bit, i = 0;
-	s32 buffer[8];
 	u8 tx[4] = {AFE440X_CONTROL0, 0x0, 0x0, AFE440X_CONTROL0_READ};
 	u8 rx[3];
 
@@ -326,7 +328,7 @@ static irqreturn_t afe4403_trigger_handler(int irq, void *private)
 		if (ret)
 			goto err;
 
-		buffer[i++] = get_unaligned_be24(&rx[0]);
+		afe->buffer[i++] = get_unaligned_be24(&rx[0]);
 	}
 
 	/* Disable reading from the device */
@@ -335,7 +337,8 @@ static irqreturn_t afe4403_trigger_handler(int irq, void *private)
 	if (ret)
 		goto err;
 
-	iio_push_to_buffers_with_timestamp(indio_dev, buffer, pf->timestamp);
+	iio_push_to_buffers_with_timestamp(indio_dev, afe->buffer,
+					   pf->timestamp);
 err:
 	iio_trigger_notify_done(indio_dev->trig);
 
-- 
2.26.2

