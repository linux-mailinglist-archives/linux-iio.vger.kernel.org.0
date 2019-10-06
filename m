Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47765CD20B
	for <lists+linux-iio@lfdr.de>; Sun,  6 Oct 2019 15:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbfJFNW3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 6 Oct 2019 09:22:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:38338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726060AbfJFNW3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 6 Oct 2019 09:22:29 -0400
Received: from lore-desk-wlan.lan (unknown [151.66.37.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4D7220684;
        Sun,  6 Oct 2019 13:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570368148;
        bh=7a8g0Wg9KKe50FX8PkqjA04Asujhl6+waWSf+7x6Oxo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S8ewJxc4gYI09FzbGWQSst0nF5K6MKwEQAO1N/CirBwUqxmrktYPmolEWG29QDF4Y
         v8Dy1nwtWn7M9WiGgcNN18gaPLyJO/Fz1SibjSvS1e/BA1IhE4vMte8SaPha/YoMys
         lgSCOcuebNIsWof84BhhiGIYbO9WBABFZ4iSrjFc=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, sean@geanix.com, martin@geanix.com,
        rjones@gateworks.com, lorenzo.bianconi@redhat.com,
        devicetree@vger.kernel.org
Subject: [PATCH 02/13] iio: imu: st_lsm6dsx: add sanity check for read_fifo pointer
Date:   Sun,  6 Oct 2019 15:21:56 +0200
Message-Id: <fce5585e5b81f9d2dc2b38bdef0b60631bb713ec.1570367532.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1570367532.git.lorenzo@kernel.org>
References: <cover.1570367532.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Check read_fifo pointer before using it since we can't assume it
is always set adding new sensors. This patch fixes the following crash:

irq 277: nobody cared (try booting with the "irqpoll" option)
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.3.0-rc5-00322-g792b824-dirty #7
Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
[<c0112750>] (unwind_backtrace) from [<c010d018>] (show_stack+0x10/0x14)
[<c010d018>] (show_stack) from [<c0c2bfc8>] (dump_stack+0xd8/0x10c)
[<c0c2bfc8>] (dump_stack) from [<c01923fc>] (__report_bad_irq+0x24/0xc0)
[<c01923fc>] (__report_bad_irq) from [<c0192820>] (note_interrupt+0x27c/0x2dc)
[<c0192820>] (note_interrupt) from [<c018f174>] (handle_irq_event_percpu+0x54/0x7c)
[<c018f174>] (handle_irq_event_percpu) from [<c018f1d4>] (handle_irq_event+0x38/0x5c)
[<c018f1d4>] (handle_irq_event) from [<c0193664>] (handle_level_irq+0xc8/0x154)
[<c0193664>] (handle_level_irq) from [<c018df58>] (generic_handle_irq+0x20/0x34)
[<c018df58>] (generic_handle_irq) from [<c053c348>] (mxc_gpio_irq_handler+0xc4/0xf8)
[<c053c348>] (mxc_gpio_irq_handler) from [<c053c3e0>] (mx3_gpio_irq_handler+0x64/0xb8)
[<c053c3e0>] (mx3_gpio_irq_handler) from [<c018df58>] (generic_handle_irq+0x20/0x34)
[<c018df58>] (generic_handle_irq) from [<c018e550>] (__handle_domain_irq+0x64/0xe0)
[<c018e550>] (__handle_domain_irq) from [<c0529610>] (gic_handle_irq+0x4c/0xa0)
[<c0529610>] (gic_handle_irq) from [<c0101a70>] (__irq_svc+0x70/0x98)
Exception stack(0xc1301f10 to 0xc1301f58
1f00: 00000001 00000006 00000000 c130c340
1f20: c1300000 c1308928 00000001 c1308960 00000000 c12b9db0 c1308908 00000000
1f40: 00000000 c1301f60 c0182010 c0109508 20000013 ffffffff
[<c0101a70>] (__irq_svc) from [<c0109508>] (arch_cpu_idle+0x20/0x3c)
[<c0109508>] (arch_cpu_idle) from [<c015ed70>] (do_idle+0x1bc/0x2bc)
[<c015ed70>] (do_idle) from [<c015f204>] (cpu_startup_entry+0x18/0x1c)
[<c015f204>] (cpu_startup_entry) from [<c1200e68>] (start_kernel+0x440/0x504)
[<c1200e68>] (start_kernel) from [<00000000>] (0x0)
handlers:
[<62052c0d>] st_lsm6dsx_handler_irq threaded
[<f2004b92>] st_lsm6dsx_handler_thread

Fixes: 52f4b1f19679 ("iio: imu: st_lsm6dsx: add support for accel/gyro unit of lsm9ds1")
Tested-by: Bobby Jones <rjones@gateworks.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c | 3 +++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c   | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
index ef579650fd52..cabd4bfeab17 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
@@ -586,6 +586,9 @@ int st_lsm6dsx_flush_fifo(struct st_lsm6dsx_hw *hw)
 {
 	int err;
 
+	if (!hw->settings->fifo_ops.read_fifo)
+		return -ENOTSUPP;
+
 	mutex_lock(&hw->fifo_lock);
 
 	hw->settings->fifo_ops.read_fifo(hw);
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index df270905f21d..eac695663b6f 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -1815,6 +1815,9 @@ static irqreturn_t st_lsm6dsx_handler_thread(int irq, void *private)
 
 	event = st_lsm6dsx_report_motion_event(hw);
 
+	if (!hw->settings->fifo_ops.read_fifo)
+		return event ? IRQ_HANDLED : IRQ_NONE;
+
 	mutex_lock(&hw->fifo_lock);
 	count = hw->settings->fifo_ops.read_fifo(hw);
 	mutex_unlock(&hw->fifo_lock);
-- 
2.21.0

