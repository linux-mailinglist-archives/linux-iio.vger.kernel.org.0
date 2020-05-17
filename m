Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA1131D6B7F
	for <lists+linux-iio@lfdr.de>; Sun, 17 May 2020 19:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbgEQRcP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 17 May 2020 13:32:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:51390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726362AbgEQRcP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 17 May 2020 13:32:15 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3586C2081A;
        Sun, 17 May 2020 17:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589736735;
        bh=/0GvY/0b4q9Y+cINXq9Ay88qg0135Fkn4WcgkpasOcU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gYIXmQDrH30Ode9btGWhxAMfDBTmeKbYaj0PVMCXNl497uVhP0qxK8hEMEyvEOsPA
         Swa3q4SI+EIHIGfrdbiFh9Vn1Q7aZoiPpXE7S7oGEqMp5Gjwmon+Ad6LhZuBiCOe85
         wA6R6DhOkocddpYloAo+cOrFZIkxmfWOnWYFHwg0=
From:   jic23@kernel.org
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Andrew F . Davis" <afd@ti.com>
Subject: [PATCH 08/11] iio:health:afe4404 Fix timestamp alignment and prevent data leak.
Date:   Sun, 17 May 2020 18:29:57 +0100
Message-Id: <20200517173000.220819-9-jic23@kernel.org>
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
this driver which uses a 40 byte array of smaller elements on the stack.
As Lars also noted this anti pattern can involve a leak of data to
userspace and that indeed can happen here.  We close both issues by
moving to a suitable structure in the iio_priv() data with alignment
explicitly requested.  This data is allocated with kzalloc so no
data can leak appart from previous readings.

Fixes: 87aec56e27ef ("iio: health: Add driver for the TI AFE4404 heart monitor")
Reported-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Andrew F. Davis <afd@ti.com>
---
 drivers/iio/health/afe4404.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/health/afe4404.c b/drivers/iio/health/afe4404.c
index e728bbb21ca8..cebb1fd4d0b1 100644
--- a/drivers/iio/health/afe4404.c
+++ b/drivers/iio/health/afe4404.c
@@ -83,6 +83,7 @@ static const struct reg_field afe4404_reg_fields[] = {
  * @regulator: Pointer to the regulator for the IC
  * @trig: IIO trigger for this device
  * @irq: ADC_RDY line interrupt number
+ * @buffer: Used to construct a scan to push to the iio buffer.
  */
 struct afe4404_data {
 	struct device *dev;
@@ -91,6 +92,7 @@ struct afe4404_data {
 	struct regulator *regulator;
 	struct iio_trigger *trig;
 	int irq;
+	s32 buffer[10] __aligned(8);
 };
 
 enum afe4404_chan_id {
@@ -328,17 +330,17 @@ static irqreturn_t afe4404_trigger_handler(int irq, void *private)
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct afe4404_data *afe = iio_priv(indio_dev);
 	int ret, bit, i = 0;
-	s32 buffer[10];
 
 	for_each_set_bit(bit, indio_dev->active_scan_mask,
 			 indio_dev->masklength) {
 		ret = regmap_read(afe->regmap, afe4404_channel_values[bit],
-				  &buffer[i++]);
+				  &afe->buffer[i++]);
 		if (ret)
 			goto err;
 	}
 
-	iio_push_to_buffers_with_timestamp(indio_dev, buffer, pf->timestamp);
+	iio_push_to_buffers_with_timestamp(indio_dev, afe->buffer,
+					   pf->timestamp);
 err:
 	iio_trigger_notify_done(indio_dev->trig);
 
-- 
2.26.2

