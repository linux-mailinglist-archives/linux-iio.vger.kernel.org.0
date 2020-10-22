Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A496A295BBB
	for <lists+linux-iio@lfdr.de>; Thu, 22 Oct 2020 11:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895472AbgJVJ1B (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 22 Oct 2020 05:27:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:49836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2509775AbgJVJ1A (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 22 Oct 2020 05:27:00 -0400
Received: from lore-desk.redhat.com (unknown [151.66.125.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE9082417D;
        Thu, 22 Oct 2020 09:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603358820;
        bh=kdqp/FkA978FY67OcQL3JNtovqYBm0/oqRhiSuwbYZY=;
        h=From:To:Cc:Subject:Date:From;
        b=xpzEBSiBB8RVxWd0OEKio19O7RbXNO7UGFBtszvK+jwOfKFaFiVKX4HfhxthPPiSm
         UoSVh6RM9fhE3ZJxitLq7hM3ZsaHgZYGaPFHRIqMecXaz5ZOoPDb1hLsCdmEICmuDc
         72DBaZai1Pcegep5eE31KJu6TdKx8D+Aezv/ciVc=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, lorenzo.bianconi@redhat.com,
        mario.tesi@st.com
Subject: [PATCH] iio: imu: st_lsm6dsx: fix edge-trigger interrupts
Date:   Thu, 22 Oct 2020 11:26:53 +0200
Message-Id: <f48bee8fadf3383b2569c5d3e909b494976f979c.1603358530.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

If the device is configured to trigger edge interrupts it is possible to
miss samples since the sensor can generate an interrupt while the driver
is still processing the previous one.
Poll FIFO status register to process all pending interrupts.
Configure IRQF_ONESHOT only for level interrupts.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 33 +++++++++++++++-----
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index 5e584c6026f1..d43b08ceec01 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -2457,22 +2457,36 @@ st_lsm6dsx_report_motion_event(struct st_lsm6dsx_hw *hw)
 	return data & event_settings->wakeup_src_status_mask;
 }
 
+static irqreturn_t st_lsm6dsx_handler_irq(int irq, void *private)
+{
+	return IRQ_WAKE_THREAD;
+}
+
 static irqreturn_t st_lsm6dsx_handler_thread(int irq, void *private)
 {
 	struct st_lsm6dsx_hw *hw = private;
+	int fifo_len = 0, len = 0;
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
+		fifo_len += len;
+	} while (len > 0);
 
-	return count || event ? IRQ_HANDLED : IRQ_NONE;
+	return fifo_len || event ? IRQ_HANDLED : IRQ_NONE;
 }
 
 static int st_lsm6dsx_irq_setup(struct st_lsm6dsx_hw *hw)
@@ -2488,10 +2502,14 @@ static int st_lsm6dsx_irq_setup(struct st_lsm6dsx_hw *hw)
 
 	switch (irq_type) {
 	case IRQF_TRIGGER_HIGH:
+		irq_type |= IRQF_ONESHOT;
+		fallthrough;
 	case IRQF_TRIGGER_RISING:
 		irq_active_low = false;
 		break;
 	case IRQF_TRIGGER_LOW:
+		irq_type |= IRQF_ONESHOT;
+		fallthrough;
 	case IRQF_TRIGGER_FALLING:
 		irq_active_low = true;
 		break;
@@ -2520,10 +2538,9 @@ static int st_lsm6dsx_irq_setup(struct st_lsm6dsx_hw *hw)
 	}
 
 	err = devm_request_threaded_irq(hw->dev, hw->irq,
-					NULL,
+					st_lsm6dsx_handler_irq,
 					st_lsm6dsx_handler_thread,
-					irq_type | IRQF_ONESHOT,
-					"lsm6dsx", hw);
+					irq_type, "lsm6dsx", hw);
 	if (err) {
 		dev_err(hw->dev, "failed to request trigger irq %d\n",
 			hw->irq);
-- 
2.26.2

