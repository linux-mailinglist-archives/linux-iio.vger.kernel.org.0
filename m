Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0ECB19F37B
	for <lists+linux-iio@lfdr.de>; Mon,  6 Apr 2020 12:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbgDFKXv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 6 Apr 2020 06:23:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:52452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726898AbgDFKXv (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 6 Apr 2020 06:23:51 -0400
Received: from lore-desk-wlan.redhat.com (unknown [151.48.151.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E81D2054F;
        Mon,  6 Apr 2020 10:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586168631;
        bh=Oew7m3cWjZC6xjRHCGZ0wHAJOOqRwkCbupnTdt+fTuU=;
        h=From:To:Cc:Subject:Date:From;
        b=n0NV0dxelrdx2vrVjR0+JcrxPm8nls8vRbQaSY1o93UaiYaLryQB77izxWlBxDZpA
         XYgorFuugu6R4ir7YIy5QPWvrmO5La7eLdb3wQoJuzTJs5vwCXYIclPbxLM1ZWuitT
         kmNQK7O4iTPm4gCn9ARo2qXDj8yz1hX4JVGIBdHA=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, lorenzo.bianconi@redhat.com,
        jimmyassarsson@gmail.com, andy.shevchenko@gmail.com
Subject: [PATCH] iio: imu: st_lsm6dsx: drop huge include in sensor-hub driver
Date:   Mon,  6 Apr 2020 12:23:32 +0200
Message-Id: <f0ccd740ca61ac0666177425afb5d7067b8074d5.1586168520.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Drop largely unconnected driver include to just introduce default wai
address and use the value directly st_lsm6dsx_ext_dev_settings register
map

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
index 280925dd8edb..947ca3a7dcaf 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
@@ -28,7 +28,6 @@
 #include <linux/iio/sysfs.h>
 #include <linux/bitfield.h>
 
-#include <linux/iio/common/st_sensors.h>
 #include "st_lsm6dsx.h"
 
 #define ST_LSM6DSX_SLV_ADDR(n, base)		((base) + (n) * 3)
@@ -93,7 +92,7 @@ static const struct st_lsm6dsx_ext_dev_settings st_lsm6dsx_ext_dev_table[] = {
 	{
 		.i2c_addr = { 0x1e },
 		.wai = {
-			.addr = ST_SENSORS_DEFAULT_WAI_ADDRESS,
+			.addr = 0x0f,
 			.val = 0x3d,
 		},
 		.id = ST_LSM6DSX_ID_MAGN,
-- 
2.25.1

