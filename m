Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3CC47B16C
	for <lists+linux-iio@lfdr.de>; Mon, 20 Dec 2021 17:42:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239178AbhLTQmF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Dec 2021 11:42:05 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:59564 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237951AbhLTQmE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Dec 2021 11:42:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AD6E0B80F98
        for <linux-iio@vger.kernel.org>; Mon, 20 Dec 2021 16:42:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D254C36AE2;
        Mon, 20 Dec 2021 16:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640018522;
        bh=94+5La2rmabQjO3P8lbg7ni/p7o7L4/y5G8+mZ0+GQc=;
        h=From:To:Cc:Subject:Date:From;
        b=TaP7X/kgaJigs20HL+dhUQ4Rfr0BgGPUR49Ldkg2Bds25PpmLI93SBvb+JmghxPdw
         /Va5VoEBFZX0vgs7ugbLC/njCXNJIYexQJjIYMiQYG2waUDuNrkGfLJKwYSwQCw1wG
         5gLKnFitYKBqO5pREsyBvtaz5YeYnnsZMOtAG2SLtnMFAEpgdePIWBj1iO0wU63R5i
         vl6kXPPpJnHVg1SWfsBy70q60DWtlzcFfGligq+rJvQFFw2c3swsM+C7QpChQbdtb/
         qAoaDvIuNf3qdDb4EG0MIzP/BtUK8u60CfgvuFICdM+aYFR4kVrgjzA2ilq2pnjAxq
         2PBZU1ankP7kg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>
Subject: [PATCH] iio:addac:ad74413r: Fix uninitialized ret in a path that won't be hit.
Date:   Mon, 20 Dec 2021 16:47:26 +0000
Message-Id: <20211220164726.3136307-1-jic23@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

I don't believe it's possible to hit this, because we drop
out of __iio_update_buffers() earlier in the event of an empty
list.  However, that is not visible to the compiler so lets
return an error if we do hit the loop with an empty bitmask.

Fixes: 5d97d9e9a703 ("iio: addac: ad74413r: fix off by one in ad74413r_parse_channel_config()")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Cosmin Tanislav <cosmin.tanislav@analog.com>
---
 drivers/iio/addac/ad74413r.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/addac/ad74413r.c b/drivers/iio/addac/ad74413r.c
index 289d254943e1..5271073bb74e 100644
--- a/drivers/iio/addac/ad74413r.c
+++ b/drivers/iio/addac/ad74413r.c
@@ -843,7 +843,7 @@ static int ad74413r_update_scan_mode(struct iio_dev *indio_dev,
 	u8 *rx_buf = &st->adc_samples_buf.rx_buf[-1 * AD74413R_FRAME_SIZE];
 	u8 *tx_buf = st->adc_samples_tx_buf;
 	unsigned int channel;
-	int ret;
+	int ret = -EINVAL;
 
 	mutex_lock(&st->lock);
 
-- 
2.34.1

