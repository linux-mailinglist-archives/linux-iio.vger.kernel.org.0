Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42F1E44C339
	for <lists+linux-iio@lfdr.de>; Wed, 10 Nov 2021 15:43:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232157AbhKJOpe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 10 Nov 2021 09:45:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:41616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231683AbhKJOpd (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 10 Nov 2021 09:45:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6B0C3611ED;
        Wed, 10 Nov 2021 14:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636555366;
        bh=tC1ay4NT+xhM56QsIX0XWFGcs6173jr/v3I3PemOlNs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PMoaFBe5Xs1woHmwcA9VGjoJdo+WLviURJgiDU0V9c8VnAInQmtDk7lwY6q4mqhhq
         AToKE0e4t+lJQlRPuP6/9oKiQZhFfTV1Kz1kpzFSS6fxfPfTjH3AUMWvUoA1Qe+Xo2
         ek1zbSkRM0396/xfT/j/D4JVdat7BKniXhOJscDUgfOM3R5QM7+Bf+2LpbBBFn5Xel
         NSau0DfUtWk/46xPjifgqS4hONESg72SMsS+HXOkxUmeUa91/3Z4rssuFz2s2Cr1gS
         Dq3FPUgH6jppm805fhUhRZroMUQdfvz/1m+HHE4L1NJ6/k58ghF8Kr3p4YLxb4cvPE
         pm47ofqZCET/Q==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     lorenzo.bianconi@redhat.com, linux-iio@vger.kernel.org,
        mario.tesi@st.com, devicetree@vger.kernel.org
Subject: [PATCH 1/2] iio: imu: st_lsm6dsx: add dts property to disable sensor-hub
Date:   Wed, 10 Nov 2021 15:42:32 +0100
Message-Id: <78e0ba2979aca8cc1894fe4c99e784591ba681f1.1636552075.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1636552075.git.lorenzo@kernel.org>
References: <cover.1636552075.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Introduce the capability to disable sensorhub through a device-tree
property since there are some configurations where users want to
explicitly disable sensor-hub auto-probing at bootstrap.
A typical configuration is when the sensorhub clock/data lines are connected
to a pull-up resistor since no slave sensors are connected to the i2c master.
If SDO/SA0 line is connected to the same pull-up resistor, when the driver
tries to probe slave devices connected on sensor-hub, it will force SDO/SA0
line to low, modifying the device i2c address.

Tested-by: Mario Tesi <mario.tesi@st.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index f2cbbc756459..82ac6c59ca03 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -2244,7 +2244,9 @@ int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id,
 		return err;
 
 	hub_settings = &hw->settings->shub_settings;
-	if (hub_settings->master_en.addr) {
+	if (hub_settings->master_en.addr &&
+	    (!dev_fwnode(dev) ||
+	     !device_property_read_bool(dev, "st,disable-shub"))) {
 		err = st_lsm6dsx_shub_probe(hw, name);
 		if (err < 0)
 			return err;
-- 
2.31.1

