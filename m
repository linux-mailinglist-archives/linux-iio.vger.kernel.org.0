Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 074B437083E
	for <lists+linux-iio@lfdr.de>; Sat,  1 May 2021 19:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbhEAR1c (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 1 May 2021 13:27:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:33176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231724AbhEAR1c (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 1 May 2021 13:27:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 10A9661353;
        Sat,  1 May 2021 17:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619890002;
        bh=JMdkmCwdMa062ZW88E1zPmLbJ7CiSfvIbLzrI1I4gPI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U/mTFHIEkpvUpRHxmkJGt5cgJC3Kmrl2Ikglw99yBnS7SwXtx8Jj/cEQEpP9Eyd4k
         9/0XpyF2hAfRAlcuAPBMDAzpYDzUQQvV/kj9gDUuRJWhfHb04tK9Q9+NAPz2OVJ5CA
         93zfo6WWVuGEwwBzy+kFhxw75D32cnZIuuuzVIeNFT61ku5fnkhN7OCdMcBjc0a1dC
         jNxaeyMJy+4XN+Yp1A+waJgXxOitKHgV110uZj2OUOV59sLdzc9I8OlLiCDs/zdXbM
         t0fN25N78yx4KC3gO13hvBe3Wy8NTkkDeiSS8z9KcohbpXoR0d5tp5VRs1OD6IUfgy
         PkoF0hbWOaJnA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jan Kiszka <jan.kiszka@siemens.com>
Subject: [RFC PATCH 2/4] iio: adc: ti-adc108s102: Fix alignment of buffer pushed to iio buffers.
Date:   Sat,  1 May 2021 18:25:13 +0100
Message-Id: <20210501172515.513486-3-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210501172515.513486-1-jic23@kernel.org>
References: <20210501172515.513486-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Use the newly introduce iio_push_to_buffers_with_ts_na() function
to ensure a bounce buffer is used to provide the required alignment and
space padding needed by the IIO core which requires the timestamp
is naturally aligned.  There will be a performance cost to this change
but it will ensure the driver works on platforms that do not support
unaligned 8 byte assignements, and with consumer drivers that may
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
index 183b2245e89b..7aeed3503829 100644
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
+	iio_push_to_buffers_with_ts_na(indio_dev,
+				       &st->rx_buf[1],
+				       st->ring_xfer.len - sizeof(st->rx_buf[1]),
+				       iio_get_time_ns(indio_dev));
 
 out_notify:
 	iio_trigger_notify_done(indio_dev->trig);
-- 
2.31.1

