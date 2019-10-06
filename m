Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1878CD221
	for <lists+linux-iio@lfdr.de>; Sun,  6 Oct 2019 15:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbfJFNWw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 6 Oct 2019 09:22:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:38640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726060AbfJFNWw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 6 Oct 2019 09:22:52 -0400
Received: from lore-desk-wlan.lan (unknown [151.66.37.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE46420684;
        Sun,  6 Oct 2019 13:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570368171;
        bh=lF4U+388Up8x8NgLcxcAHnQARZqRdLj5ly/E56lPHhI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gnltqg8Qk8XyDJ0K3hgDwFxoKddPM2+XkP8PlzK8EdE8MS/0TMLjp132Z/W+si6bu
         vrGgW+nzo5oRltocFn+pC1xRi41VoJcDKPMl7/K2VknL9MgQ1uN33/0jsMgKgogiQw
         W1zKolNmoaPCmw1jMhpwLMt1qC2vyFEACPXjKn8k=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, sean@geanix.com, martin@geanix.com,
        rjones@gateworks.com, lorenzo.bianconi@redhat.com,
        devicetree@vger.kernel.org
Subject: [PATCH 13/13] iio: imu: st_lsm6dsx: enable wake-up event for LSM6DSO
Date:   Sun,  6 Oct 2019 15:22:07 +0200
Message-Id: <a67031c30724002724209dc1e0bba3c53c53a2a5.1570367532.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1570367532.git.lorenzo@kernel.org>
References: <cover.1570367532.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add missing wake-up register info for LSM6DSO/LSM6DSOX sensor

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 25 +++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index a2a0ac81e3d3..876f59cedc8b 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -780,6 +780,14 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.addr = 0x56,
 				.mask = BIT(6),
 			},
+			.irq1_func = {
+				.addr = 0x5e,
+				.mask = BIT(5),
+			},
+			.irq2_func = {
+				.addr = 0x5f,
+				.mask = BIT(5),
+			},
 			.hla = {
 				.addr = 0x12,
 				.mask = BIT(5),
@@ -847,7 +855,22 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 			.slv0_addr = 0x15,
 			.dw_slv0_addr = 0x21,
 			.batch_en = BIT(3),
-		}
+		},
+		.event_settings = {
+			.enable_reg = {
+				.addr = 0x58,
+				.mask = BIT(7),
+			},
+			.wakeup_reg = {
+				.addr = 0x5b,
+				.mask = GENMASK(5, 0),
+			},
+			.wakeup_src_reg = 0x1b,
+			.wakeup_src_status_mask = BIT(3),
+			.wakeup_src_z_mask = BIT(0),
+			.wakeup_src_y_mask = BIT(1),
+			.wakeup_src_x_mask = BIT(2),
+		},
 	},
 	{
 		.wai = 0x6b,
-- 
2.21.0

