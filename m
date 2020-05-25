Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E51B1E1336
	for <lists+linux-iio@lfdr.de>; Mon, 25 May 2020 19:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391280AbgEYRJO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 25 May 2020 13:09:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:42642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388812AbgEYRJN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 25 May 2020 13:09:13 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C110920878;
        Mon, 25 May 2020 17:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590426552;
        bh=/K37xNWkiux7nVbz0T1QufBrgwbjsyiaXp95wAoXfbA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XugG6PSgghvXabF3xfQp+XgVwL1N+f3BXmkgCcYBCbHtXkRAGHGN+/xy/+Bt1xa5z
         ipAXG+lQP5q8SCpdtAjnpI0lIEd55ovdW0m0c7LIfhctUyn9PWEFcbjU0bSssxl0Aa
         U6xkrHB+1n5XPxCYjj1z9m+c1Xk337X9fkh6+KF8=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Subject: [PATCH 10/25] iio:humidity:hts221 Fix alignment and data leak issues
Date:   Mon, 25 May 2020 18:06:13 +0100
Message-Id: <20200525170628.503283-11-jic23@kernel.org>
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
moving to a suitable structure in the iio_priv() data.
This data is allocated with kzalloc so no data can leak
apart from previous readings.

Fixes: e4a70e3e7d84 ("iio: humidity: add support to hts221 rh/temp combo device")
Reported-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
---
 drivers/iio/humidity/hts221.h        | 5 +++++
 drivers/iio/humidity/hts221_buffer.c | 9 +++++----
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/humidity/hts221.h b/drivers/iio/humidity/hts221.h
index 7c650df77556..6ad579ca9cef 100644
--- a/drivers/iio/humidity/hts221.h
+++ b/drivers/iio/humidity/hts221.h
@@ -39,6 +39,11 @@ struct hts221_hw {
 
 	bool enabled;
 	u8 odr;
+	/* Ensure natural alignment of timestamp */
+	struct {
+		__le16 channels[2];
+		s64 ts;
+	} scan;
 };
 
 extern const struct dev_pm_ops hts221_pm_ops;
diff --git a/drivers/iio/humidity/hts221_buffer.c b/drivers/iio/humidity/hts221_buffer.c
index 21c6c160462d..59ede9860185 100644
--- a/drivers/iio/humidity/hts221_buffer.c
+++ b/drivers/iio/humidity/hts221_buffer.c
@@ -160,7 +160,6 @@ static const struct iio_buffer_setup_ops hts221_buffer_ops = {
 
 static irqreturn_t hts221_buffer_handler_thread(int irq, void *p)
 {
-	u8 buffer[ALIGN(2 * HTS221_DATA_SIZE, sizeof(s64)) + sizeof(s64)];
 	struct iio_poll_func *pf = p;
 	struct iio_dev *iio_dev = pf->indio_dev;
 	struct hts221_hw *hw = iio_priv(iio_dev);
@@ -170,18 +169,20 @@ static irqreturn_t hts221_buffer_handler_thread(int irq, void *p)
 	/* humidity data */
 	ch = &iio_dev->channels[HTS221_SENSOR_H];
 	err = regmap_bulk_read(hw->regmap, ch->address,
-			       buffer, HTS221_DATA_SIZE);
+			       &hw->scan.channels[0],
+			       sizeof(hw->scan.channels[0]));
 	if (err < 0)
 		goto out;
 
 	/* temperature data */
 	ch = &iio_dev->channels[HTS221_SENSOR_T];
 	err = regmap_bulk_read(hw->regmap, ch->address,
-			       buffer + HTS221_DATA_SIZE, HTS221_DATA_SIZE);
+			       &hw->scan.channels[1],
+			       sizeof(hw->scan.channels[1]));
 	if (err < 0)
 		goto out;
 
-	iio_push_to_buffers_with_timestamp(iio_dev, buffer,
+	iio_push_to_buffers_with_timestamp(iio_dev, &hw->scan,
 					   iio_get_time_ns(iio_dev));
 
 out:
-- 
2.26.2

