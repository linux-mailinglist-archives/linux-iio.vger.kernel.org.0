Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55B23BA19D
	for <lists+linux-iio@lfdr.de>; Sun, 22 Sep 2019 11:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbfIVJTM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 22 Sep 2019 05:19:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:35684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727883AbfIVJTM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 22 Sep 2019 05:19:12 -0400
Received: from localhost.localdomain (unknown [151.66.30.34])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 947FD21479;
        Sun, 22 Sep 2019 09:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569143951;
        bh=DF1vkcd/o8+uGh6CuyCzUA2mefnZ8dshvMV7DMOiuxs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u6ZqlErSHlW7a0om9Ke+99BU2/0AaMIAfoln4gbfB+SQmnWdKIHD6kiL85eRiIiXO
         ACRgY8VXIB+nHiRFIIBlBHWMl6E+seu5KPatVAKyBzs/CQ2SrwEikDOV1GW5g4+Waz
         v8/wXNY0s6nYlSjLsKwZ56okBNMt5wFwznJGfeIo=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     lorenzo.bianconi@redhat.com, linux-iio@vger.kernel.org,
        martin.kepplinger@puri.sm, rjones@gateworks.com
Subject: [PATCH 3/3] iio: imu: st_lsm6dsx: add sanity check for read_fifo pointer
Date:   Sun, 22 Sep 2019 11:18:53 +0200
Message-Id: <1af639097dd0dd01d991154dba0f3d56e3ed8333.1569143551.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1569143551.git.lorenzo@kernel.org>
References: <cover.1569143551.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Check read_fifo pointer before using it since we can't assume it
is always set adding new sensors

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
index 21c2aad8c56a..f80ce77a4154 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
@@ -588,6 +588,9 @@ int st_lsm6dsx_flush_fifo(struct st_lsm6dsx_hw *hw)
 {
 	int err;
 
+	if (!hw->settings->fifo_ops.read_fifo)
+		return -ENOTSUPP;
+
 	mutex_lock(&hw->fifo_lock);
 
 	hw->settings->fifo_ops.read_fifo(hw);
@@ -662,6 +665,9 @@ static irqreturn_t st_lsm6dsx_handler_thread(int irq, void *private)
 	struct st_lsm6dsx_hw *hw = private;
 	int count;
 
+	if (!hw->settings->fifo_ops.read_fifo)
+		return IRQ_NONE;
+
 	mutex_lock(&hw->fifo_lock);
 	count = hw->settings->fifo_ops.read_fifo(hw);
 	mutex_unlock(&hw->fifo_lock);
-- 
2.21.0

