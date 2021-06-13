Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E86BE3A593B
	for <lists+linux-iio@lfdr.de>; Sun, 13 Jun 2021 17:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231852AbhFMPKw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 13 Jun 2021 11:10:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:59646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231841AbhFMPKw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 13 Jun 2021 11:10:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7904361354;
        Sun, 13 Jun 2021 15:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623596931;
        bh=evQspTvNNzcemrt8Qfvezi2VvurRJB1NS3HL5Yx6//0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UHzUsIa9V64wW8yIFuoW2lgcUZysLRmXV+6KS03mK6dPCNtIM5Q4SFYWQduFZ1nqb
         ZS7zdWGiaEdr0de2D6ZQVYvPH70OfkioNhOaHpGci7lR97j/o7chYV2hzFRd41my0+
         q/irdFSZLvHw76Z0t+9vqPIcCN5PnOz7BxtD0mMn/AGXRwAoqIiJ4L+loaW+0PKWQk
         SM0d1a/SH8LsWKPk0rKKe6CO/FR86RB0GaEWZVEVeN/67tjrqd/NilBUGD7bkeMx/A
         3y3XfOeidOxFPFCADIjwKPSg94npl0p7V0DDEXGx2eQjrJzXJC64RR3StYetTf6lP/
         DxYPlQF2Te7sw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Nuno Sa <Nuno.Sa@analog.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 2/4] iio: adc: ti-adc108s102: Fix alignment of buffer pushed to iio buffers.
Date:   Sun, 13 Jun 2021 16:10:37 +0100
Message-Id: <20210613151039.569883-3-jic23@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210613151039.569883-1-jic23@kernel.org>
References: <20210613151039.569883-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Use the newly introduce iio_push_to_buffers_with_ts_unaligned() function
to ensure a bounce buffer is used to provide the required alignment and
space padding needed by the IIO core which requires the timestamp
is naturally aligned.  There will be a performance cost to this change
but it will ensure the driver works on platforms that do not support
unaligned 8 byte assignments, and with consumer drivers that may
assume natural alignment of the timestamp.

Issue found as part of an audit of all calls to
iio_push_to_buffers_with_timestamp()

Fixes: 7e87d11c9bda ("iio: adc: Add support for TI ADC108S102 and ADC128S102")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>
---
 drivers/iio/adc/ti-adc108s102.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/ti-adc108s102.c b/drivers/iio/adc/ti-adc108s102.c
index db902aef2abe..c8e48881c37f 100644
--- a/drivers/iio/adc/ti-adc108s102.c
+++ b/drivers/iio/adc/ti-adc108s102.c
@@ -75,9 +75,9 @@ struct adc108s102_state {
 	 *  rx_buf: |XX|R0|R1|R2|R3|R4|R5|R6|R7|tt|tt|tt|tt|
 	 *
 	 *  tx_buf: 8 channel read commands, plus 1 dummy command
-	 *  rx_buf: 1 dummy response, 8 channel responses, plus 64-bit timestamp
+	 *  rx_buf: 1 dummy response, 8 channel responses
 	 */
-	__be16				rx_buf[13] ____cacheline_aligned;
+	__be16				rx_buf[9] ____cacheline_aligned;
 	__be16				tx_buf[9] ____cacheline_aligned;
 };
 
@@ -149,9 +149,10 @@ static irqreturn_t adc108s102_trigger_handler(int irq, void *p)
 		goto out_notify;
 
 	/* Skip the dummy response in the first slot */
-	iio_push_to_buffers_with_timestamp(indio_dev,
-					   (u8 *)&st->rx_buf[1],
-					   iio_get_time_ns(indio_dev));
+	iio_push_to_buffers_with_ts_unaligned(indio_dev,
+					      &st->rx_buf[1],
+					      st->ring_xfer.len - sizeof(st->rx_buf[1]),
+					      iio_get_time_ns(indio_dev));
 
 out_notify:
 	iio_trigger_notify_done(indio_dev->trig);
-- 
2.32.0

