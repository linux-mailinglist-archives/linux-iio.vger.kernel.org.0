Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3658737080C
	for <lists+linux-iio@lfdr.de>; Sat,  1 May 2021 19:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbhEARD4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 1 May 2021 13:03:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:47490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231342AbhEARDz (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 1 May 2021 13:03:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 39EA861477;
        Sat,  1 May 2021 17:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619888585;
        bh=iLsqnvUGJ5w7dL2XC3H9hWJQeQgj59U5ptcRzYEzatY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lnKXb6ciBRzsLRPQHTG1UPLakkpi2zHOGZvV3EW0tclTi6xP/b+ijsjCrTqwf59ug
         JUesfpyylF3F1FQFedKzsgpPNQEfXFtOw0uZJFW+N6cM1whoclGFHBPbRbGk7YzalS
         VZRFElUS03BcuBNZnQ6hsYPMgPSi62Lqoj+70kGs1x72OpzEAimPgduQ+fmuUZZMQq
         pM4mk6MgSFvKj1RLBCmm9pjd2b49jZHlt18K9o1AHX1XiH8MCEyEK74QWSK4eNsBc2
         3c298IGDnjtpTaQPCzgok3WM8TRfkqvH38PywPrz02o1Na8kqRvaet9CJEBJ2v+UYp
         JxA+LAL5vo32Q==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>,
        Sanchayan Maity <maitysanchayan@gmail.com>
Subject: [PATCH 09/19] iio: adc: vf610: Fix buffer alignment in iio_push_to_buffers_with_timestamp()
Date:   Sat,  1 May 2021 18:01:11 +0100
Message-Id: <20210501170121.512209-10-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210501170121.512209-1-jic23@kernel.org>
References: <20210501170121.512209-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

To make code more readable, use a structure to express the channel
layout and ensure the timestamp is 8 byte aligned.

Found during an audit of all calls of uses of
iio_push_to_buffers_with_timestamp()

Fixes: 0010d6b44406 ("iio: adc: vf610: Add IIO buffer support for Vybrid ADC")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
Cc: Sanchayan Maity <maitysanchayan@gmail.com>
---
 drivers/iio/adc/vf610_adc.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/vf610_adc.c b/drivers/iio/adc/vf610_adc.c
index 1d794cf3e3f1..fd57fc43e8e5 100644
--- a/drivers/iio/adc/vf610_adc.c
+++ b/drivers/iio/adc/vf610_adc.c
@@ -167,7 +167,11 @@ struct vf610_adc {
 	u32 sample_freq_avail[5];
 
 	struct completion completion;
-	u16 buffer[8];
+	/* Ensure the timestamp is naturally aligned */
+	struct {
+		u16 chan;
+		s64 timestamp __aligned(8);
+	} scan;
 };
 
 static const u32 vf610_hw_avgs[] = { 1, 4, 8, 16, 32 };
@@ -579,9 +583,9 @@ static irqreturn_t vf610_adc_isr(int irq, void *dev_id)
 	if (coco & VF610_ADC_HS_COCO0) {
 		info->value = vf610_adc_read_data(info);
 		if (iio_buffer_enabled(indio_dev)) {
-			info->buffer[0] = info->value;
+			info->scan.chan = info->value;
 			iio_push_to_buffers_with_timestamp(indio_dev,
-					info->buffer,
+					&info->scan,
 					iio_get_time_ns(indio_dev));
 			iio_trigger_notify_done(indio_dev->trig);
 		} else
-- 
2.31.1

