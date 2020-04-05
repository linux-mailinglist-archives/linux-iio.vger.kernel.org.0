Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A15319ED41
	for <lists+linux-iio@lfdr.de>; Sun,  5 Apr 2020 20:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbgDESFu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Apr 2020 14:05:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:54234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726771AbgDESFu (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 5 Apr 2020 14:05:50 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E611720678;
        Sun,  5 Apr 2020 18:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586109949;
        bh=bjBl2F1hxOLL/0V57XCwPmUPsGgwjT98epXBwn0AS8U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0IasuG+4AVUobAPcxhcPVG8q4WAbHSgtMrePRs3jaWFCm/OzZhekAh746egVBGjhy
         3oY+1Ef9GbON8aacb/nXszrl6CTbbP3qpJ7iy3mWYOnQxXMHQbrXCjcZVPnupKHnHf
         326dvKznRfWJRGwizv83IYgY/VKZ3SxU6WM9kies=
From:   jic23@kernel.org
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>
Subject: [PATCH 2/6] iio:chemical:atlas-sensor: Drop unnecessary explicit casts in regmap_bulk_read calls
Date:   Sun,  5 Apr 2020 19:03:17 +0100
Message-Id: <20200405180321.1737310-3-jic23@kernel.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200405180321.1737310-1-jic23@kernel.org>
References: <20200405180321.1737310-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

regmap_bulk_read takes a void * for its val parameter. It certainly
makes no sense to cast to a (u8 *) + no need to explicitly cast
at all when converting another pointer type to void *.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Matt Ranostay <matt.ranostay@konsulko.com>
---
 drivers/iio/chemical/atlas-sensor.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/chemical/atlas-sensor.c b/drivers/iio/chemical/atlas-sensor.c
index 82d470561ad3..973cdb4f1e83 100644
--- a/drivers/iio/chemical/atlas-sensor.c
+++ b/drivers/iio/chemical/atlas-sensor.c
@@ -426,8 +426,7 @@ static irqreturn_t atlas_trigger_handler(int irq, void *private)
 	int ret;
 
 	ret = regmap_bulk_read(data->regmap, data->chip->data_reg,
-			      (u8 *) &data->buffer,
-			      sizeof(__be32) * channels);
+			      &data->buffer, sizeof(__be32) * channels);
 
 	if (!ret)
 		iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
@@ -463,7 +462,7 @@ static int atlas_read_measurement(struct atlas_data *data, int reg, __be32 *val)
 	if (suspended)
 		msleep(data->chip->delay);
 
-	ret = regmap_bulk_read(data->regmap, reg, (u8 *) val, sizeof(*val));
+	ret = regmap_bulk_read(data->regmap, reg, val, sizeof(*val));
 
 	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
@@ -485,7 +484,7 @@ static int atlas_read_raw(struct iio_dev *indio_dev,
 		switch (chan->type) {
 		case IIO_TEMP:
 			ret = regmap_bulk_read(data->regmap, chan->address,
-					      (u8 *) &reg, sizeof(reg));
+					       &reg, sizeof(reg));
 			break;
 		case IIO_PH:
 		case IIO_CONCENTRATION:
-- 
2.26.0

