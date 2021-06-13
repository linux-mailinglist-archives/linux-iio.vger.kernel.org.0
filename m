Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B22B63A5956
	for <lists+linux-iio@lfdr.de>; Sun, 13 Jun 2021 17:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231928AbhFMPXO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 13 Jun 2021 11:23:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:60962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231799AbhFMPXO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 13 Jun 2021 11:23:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C31E661285;
        Sun, 13 Jun 2021 15:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623597672;
        bh=A2mZSbX/BRRKhma5z072BPclMFGaJIcuWPhmZbCWk0Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D56jp3mmGxdduPvRmaq57RD/8/G5qNZX1IP+KGA65yhprOCzxoDJrrlAAPc82xZr2
         czb66l2ZuYzBHcuE/43XZfxu9TXfrFHaLcu7aPfhx20Zzfn6f4SL1p8UsFRkFtNoY3
         2x9YxB43feBD3GPPdD38FQjXiibUFzAyMKF9CJgNDWnUwvJNMALUslYG2WBfAct7Vj
         yWAP6J9pAVSIVoBon06WbnmjnnMLP2rRn9kKLW5/pn2yZRrUJEv+49+do3CENUNEK4
         myt4F/jRFMyfoHVrG0+GiWLIJOpZ/JUr1hNKo0E+1hwx/JKYRSYZBNM2k3PYkeyIqQ
         X5eeqO2DQEAIg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH RESEND 1/8] iio: adc: at91-sama5d2: Fix buffer alignment in iio_push_to_buffers_with_timestamp()
Date:   Sun, 13 Jun 2021 16:22:54 +0100
Message-Id: <20210613152301.571002-2-jic23@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210613152301.571002-1-jic23@kernel.org>
References: <20210613152301.571002-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

To make code more readable, use a structure to express the channel
layout and ensure the timestamp is 8 byte aligned.

Found during an audit of all calls of this function.

Fixes: 5e1a1da0f8c9 ("iio: adc: at91-sama5d2_adc: add hw trigger and buffer support")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Eugen Hristev <eugen.hristev@microchip.com>
---
 drivers/iio/adc/at91-sama5d2_adc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index 6e8c28675947..ea5ca163d879 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -403,7 +403,8 @@ struct at91_adc_state {
 	struct at91_adc_dma		dma_st;
 	struct at91_adc_touch		touch_st;
 	struct iio_dev			*indio_dev;
-	u16				buffer[AT91_BUFFER_MAX_HWORDS];
+	/* Ensure naturally aligned timestamp */
+	u16				buffer[AT91_BUFFER_MAX_HWORDS] __aligned(8);
 	/*
 	 * lock to prevent concurrent 'single conversion' requests through
 	 * sysfs.
-- 
2.32.0

