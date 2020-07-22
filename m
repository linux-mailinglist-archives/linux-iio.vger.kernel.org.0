Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E91DE229BE1
	for <lists+linux-iio@lfdr.de>; Wed, 22 Jul 2020 17:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728697AbgGVPxV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 22 Jul 2020 11:53:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:35614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726427AbgGVPxU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 22 Jul 2020 11:53:20 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5CA80206F5;
        Wed, 22 Jul 2020 15:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595433200;
        bh=bygXAix11Yif9FOMNTJ8h+p55wt+ROUtmFRG85PnGR4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LmjgHCUHKPjaeNrOj/F+ADsQ4rJqULAgrosOZBjZWJYUCicppfRk39gnXE1StVRpQ
         RtXHf6FCSWBelQCQM3+EZtKrR1d9z+r/r4Ke2wkLFO1Xw8fe3iL/8edMlVhVs54KnD
         oT95apDhYB7WQUE6XetDWscqHSln7UEhvuAlx0kQ=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 08/27] iio:light:si1145: Fix timestamp alignment and prevent data leak.
Date:   Wed, 22 Jul 2020 16:50:44 +0100
Message-Id: <20200722155103.979802-9-jic23@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200722155103.979802-1-jic23@kernel.org>
References: <20200722155103.979802-1-jic23@kernel.org>
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
this driver which uses a 24 byte array of smaller elements on the stack.
As Lars also noted this anti pattern can involve a leak of data to
userspace and that indeed can happen here.  We close both issues by
moving to a suitable array in the iio_priv() data with alignment
explicitly requested.  This data is allocated with kzalloc so no
data can leak appart from previous readings.

Depending on the enabled channels, the  location of the timestamp
can be at various aligned offsets through the buffer.  As such we
any use of a structure to enforce this alignment would incorrectly
suggest a single location for the timestamp.

Fixes: ac45e57f1590 ("iio: light: Add driver for Silabs si1132, si1141/2/3 and si1145/6/7 ambient light, uv index and proximity sensors")
Reported-by: Lars-Peter Clausen <lars@metafoo.de>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/light/si1145.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/light/si1145.c b/drivers/iio/light/si1145.c
index 155faaea8c72..e8bdc221d65b 100644
--- a/drivers/iio/light/si1145.c
+++ b/drivers/iio/light/si1145.c
@@ -179,6 +179,8 @@ struct si1145_data {
 	bool autonomous;
 	struct iio_trigger *trig;
 	int meas_rate;
+	/* Ensure timestamp will be naturally aligned if present */
+	u8 buffer[24] __aligned(8);
 };
 
 /*
@@ -445,7 +447,6 @@ static irqreturn_t si1145_trigger_handler(int irq, void *private)
 	 *   6*2 bytes channels data + 4 bytes alignment +
 	 *   8 bytes timestamp
 	 */
-	u8 buffer[24];
 	int i, j = 0;
 	int ret;
 	u8 irq_status = 0;
@@ -478,7 +479,7 @@ static irqreturn_t si1145_trigger_handler(int irq, void *private)
 
 		ret = i2c_smbus_read_i2c_block_data_or_emulated(
 				data->client, indio_dev->channels[i].address,
-				sizeof(u16) * run, &buffer[j]);
+				sizeof(u16) * run, &data->buffer[j]);
 		if (ret < 0)
 			goto done;
 		j += run * sizeof(u16);
@@ -493,7 +494,7 @@ static irqreturn_t si1145_trigger_handler(int irq, void *private)
 			goto done;
 	}
 
-	iio_push_to_buffers_with_timestamp(indio_dev, buffer,
+	iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
 		iio_get_time_ns(indio_dev));
 
 done:
-- 
2.27.0

