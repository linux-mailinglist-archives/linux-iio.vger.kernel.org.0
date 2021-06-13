Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB3E3A5958
	for <lists+linux-iio@lfdr.de>; Sun, 13 Jun 2021 17:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231931AbhFMPXR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 13 Jun 2021 11:23:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:60976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231844AbhFMPXR (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 13 Jun 2021 11:23:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1282D61358;
        Sun, 13 Jun 2021 15:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623597676;
        bh=iyAIIOgOWfYUCbhWSZ72K4nDwPr+DNsjgnbf+4mU8gU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rw/0/ExVS/1EPzwuG8mPt1y+T823j8ghIYR97bWEF7Nn4Yi6N1dE1yEZWwLsu8Fg5
         jzvBBFSkYLI6UH7K0AXvN3W6dPyj5xht8+VmwffPrq03WO7vJR/nKKly6XpjgF15Gn
         atzZvAMLeKr6ZwSoHfQCM0Tg2KOLtAR9Lde0l0ad3+y1d1CyO4nrHqyhyl5rMRof6X
         edGHB3U5IOr8dd5bEQ39fpyJeWZD/zkxxdlDo12CcOqma2TyV8LHp6e2IceE0Byj1m
         AD3F/6EsSty/oQyBlHXl75yrMWpZbDkJsJC8lOTH/hTjG63x1NsM1PTkcF5bI94tpO
         OZ5kEa9Pb2q8w==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andreas Klinger <ak@it-klinger.de>
Subject: [PATCH RESEND 3/8] iio: adc: mxs-lradc: Fix buffer alignment in iio_push_to_buffers_with_timestamp()
Date:   Sun, 13 Jun 2021 16:22:56 +0100
Message-Id: <20210613152301.571002-4-jic23@kernel.org>
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
Add a comment on why the buffer is the size it is as not immediately
obvious.

Found during an audit of all calls of this function.

Fixes: 6dd112b9f85e ("iio: adc: mxs-lradc: Add support for ADC driver")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Andreas Klinger <ak@it-klinger.de>
---
 drivers/iio/adc/mxs-lradc-adc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/mxs-lradc-adc.c b/drivers/iio/adc/mxs-lradc-adc.c
index 1d99170d3328..bca79a93cbe4 100644
--- a/drivers/iio/adc/mxs-lradc-adc.c
+++ b/drivers/iio/adc/mxs-lradc-adc.c
@@ -115,7 +115,8 @@ struct mxs_lradc_adc {
 	struct device		*dev;
 
 	void __iomem		*base;
-	u32			buffer[10];
+	/* Maximum of 8 channels + 8 byte ts */
+	u32			buffer[10] __aligned(8);
 	struct iio_trigger	*trig;
 	struct completion	completion;
 	spinlock_t		lock;
-- 
2.32.0

