Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC9737081E
	for <lists+linux-iio@lfdr.de>; Sat,  1 May 2021 19:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbhEARQT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 1 May 2021 13:16:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:53998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230195AbhEARQS (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 1 May 2021 13:16:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0E3E2614A7;
        Sat,  1 May 2021 17:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619889328;
        bh=nEu9A1pI3R9ee81srm640DsOiOYvfIRSQLBr1IuR9cU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OJc6OmP88Lj9kdMARG33E5XI7eHDdIMTwdyWfCecjABBs3ya7jbAzy34NIR7evt0A
         /bb5/qYdvRiPpA5qMUsRiqMhPZA3nfFo4unp37xma4jt0gluCDgpeKf1+vKC1DF/Hl
         k5hyh3dyHIVv2rQl64LUl414tk6G6FF9fRuJQZWoxBE0kKGqPFCJovLWB6wDqf3qWF
         Y++j3GBh7nCnNCHv9elWxtgRybnbmyxDV7DZyMFxWPE2+7LHT+2Q00mQcNFx2FOGP7
         wi0hiX1q/glCwEeckKPuQ8ZmyMfcxy/KJasvh1VBopGvholJUz/xRrM3gdrBWoYj8n
         oEZtdy6Ujrg3Q==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andreas Klinger <ak@it-klinger.de>
Subject: [PATCH 03/11] iio: adc: mxs-lradc: Fix buffer alignment in iio_push_to_buffers_with_timestamp()
Date:   Sat,  1 May 2021 18:13:44 +0100
Message-Id: <20210501171352.512953-4-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210501171352.512953-1-jic23@kernel.org>
References: <20210501171352.512953-1-jic23@kernel.org>
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
index 30e29f44ebd2..c480cb489c1a 100644
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
2.31.1

