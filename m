Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D57482A337B
	for <lists+linux-iio@lfdr.de>; Mon,  2 Nov 2020 19:59:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725805AbgKBS7y (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 2 Nov 2020 13:59:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:39594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725833AbgKBS7x (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 2 Nov 2020 13:59:53 -0500
Received: from lore-desk.redhat.com (unknown [151.66.29.159])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C51822225E;
        Mon,  2 Nov 2020 18:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604343593;
        bh=JZRkhw9p+IFGxfm1PxBAqHFTkUmn43GF9Ysfc5agSMY=;
        h=From:To:Cc:Subject:Date:From;
        b=aJ5CjffEA9ztzxyHkiQCwEOBdu6fgdkChsxlvPUFzSBKPrBZah+SC5NRVhMICvfWG
         4G8YFxb3oIBAsrrGwHNS+gNfYUXJfncIZzAK3uUCeqQ8yj0Yz9VYfhIcR8DDfLNgh5
         QJfjGa1zNS2N8+txRqJI66vSEnRiriI1jDPtN0G0=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     lorenzo.bianconi@redhat.com, linux-iio@vger.kernel.org,
        mario.tesi@st.com, denis.ciocca@st.com, armando.visconti@st.com
Subject: [PATCH v2] iio: imu: st_lsm6dsx: fix edge-trigger interrupts
Date:   Mon,  2 Nov 2020 19:59:46 +0100
Message-Id: <797560f9719ee87115b51968c79e9913586d786f.1604343119.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

If the device is configured to trigger edge interrupts it is possible to
miss samples since the sensor can generate an interrupt while the driver
is still processing the previous one but it has already read the fifo
status register. Poll FIFO status register to check if there is any pending
interrupt to process.

Fixes: 89ca88a7cdf2 ("iio: imu: st_lsm6dsx: support active-low interrupts")
Fixes: 290a6ce11d93 ("iio: imu: add support to lsm6dsx driver")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
Changes since v1:
- add missing fixes tags
- keep IRQF_ONESHOT even for edge-interrupts
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index 5e584c6026f1..86c50136219b 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -2460,19 +2460,29 @@ st_lsm6dsx_report_motion_event(struct st_lsm6dsx_hw *hw)
 static irqreturn_t st_lsm6dsx_handler_thread(int irq, void *private)
 {
 	struct st_lsm6dsx_hw *hw = private;
+	int fifo_len = 0, len;
 	bool event;
-	int count;
 
 	event = st_lsm6dsx_report_motion_event(hw);
 
 	if (!hw->settings->fifo_ops.read_fifo)
 		return event ? IRQ_HANDLED : IRQ_NONE;
 
-	mutex_lock(&hw->fifo_lock);
-	count = hw->settings->fifo_ops.read_fifo(hw);
-	mutex_unlock(&hw->fifo_lock);
+	/*
+	 * If we are using edge IRQs, new samples can arrive while
+	 * processing current IRQ and those may be missed unless we
+	 * pick them here, so let's try read FIFO status again
+	 */
+	do {
+		mutex_lock(&hw->fifo_lock);
+		len = hw->settings->fifo_ops.read_fifo(hw);
+		mutex_unlock(&hw->fifo_lock);
+
+		if (len > 0)
+			fifo_len += len;
+	} while (len > 0);
 
-	return count || event ? IRQ_HANDLED : IRQ_NONE;
+	return fifo_len || event ? IRQ_HANDLED : IRQ_NONE;
 }
 
 static int st_lsm6dsx_irq_setup(struct st_lsm6dsx_hw *hw)
-- 
2.26.2

