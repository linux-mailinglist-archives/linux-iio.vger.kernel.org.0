Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 118A6229BDF
	for <lists+linux-iio@lfdr.de>; Wed, 22 Jul 2020 17:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728670AbgGVPxS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 22 Jul 2020 11:53:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:35578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726427AbgGVPxR (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 22 Jul 2020 11:53:17 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45D9B2080D;
        Wed, 22 Jul 2020 15:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595433197;
        bh=5QuK84qbMXTvOmisdS/5lYhQHBC9xeUyd2YS0HocAi8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RYlV+JJvRdEjuZSGJbMQfO1g9MSPnI9P1+caY1CknQaURJgoXPoE2t0bCdjX2wdhT
         FDox1yoniV8O9+/+/xWFklWKMu2yXOQCREnViwx5k5QycgV6unTPa0X8WIBztGbhbe
         JLMp7PtTXnFpR2JOPpYrXIe+9Z6IKlMpZsTqeeCE=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andreas Klinger <ak@it-klinger.de>
Subject: [PATCH v3 06/27] iio:proximity:mb1232: Fix timestamp alignment and prevent data leak.
Date:   Wed, 22 Jul 2020 16:50:42 +0100
Message-Id: <20200722155103.979802-7-jic23@kernel.org>
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
this driver which uses a 16 byte s16 array on the stack   As Lars also noted
this anti pattern can involve a leak of data to userspace and that
indeed can happen here.  We close both issues by moving to
a suitable structure in the iio_priv() data with alignment
ensured by use of an explicit c structure.  This data is allocated
with kzalloc so no data can leak appart from previous readings.

In this case the forced alignment of the ts is necessary to ensure
correct padding on x86_32 where the s64 would only be 4 byte aligned.

Fixes: 16b05261537e ("mb1232.c: add distance iio sensor with i2c")
Reported-by: Lars-Peter Clausen <lars@metafoo.de>
Cc: Andreas Klinger <ak@it-klinger.de>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/proximity/mb1232.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/proximity/mb1232.c b/drivers/iio/proximity/mb1232.c
index 654564c45248..ad4b1fb2607a 100644
--- a/drivers/iio/proximity/mb1232.c
+++ b/drivers/iio/proximity/mb1232.c
@@ -40,6 +40,11 @@ struct mb1232_data {
 	 */
 	struct completion	ranging;
 	int			irqnr;
+	/* Ensure correct alignment of data to push to IIO buffer */
+	struct {
+		s16 distance;
+		s64 ts __aligned(8);
+	} scan;
 };
 
 static irqreturn_t mb1232_handle_irq(int irq, void *dev_id)
@@ -113,17 +118,13 @@ static irqreturn_t mb1232_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct mb1232_data *data = iio_priv(indio_dev);
-	/*
-	 * triggered buffer
-	 * 16-bit channel + 48-bit padding + 64-bit timestamp
-	 */
-	s16 buffer[8] = { 0 };
 
-	buffer[0] = mb1232_read_distance(data);
-	if (buffer[0] < 0)
+	data->scan.distance = mb1232_read_distance(data);
+	if (data->scan.distance < 0)
 		goto err;
 
-	iio_push_to_buffers_with_timestamp(indio_dev, buffer, pf->timestamp);
+	iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
+					   pf->timestamp);
 
 err:
 	iio_trigger_notify_done(indio_dev->trig);
-- 
2.27.0

