Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B355295493
	for <lists+linux-iio@lfdr.de>; Wed, 21 Oct 2020 23:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409703AbgJUVyG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 21 Oct 2020 17:54:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:51050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2409614AbgJUVyG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 21 Oct 2020 17:54:06 -0400
Received: from lore-desk.redhat.com (unknown [151.66.125.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1009B24178;
        Wed, 21 Oct 2020 21:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603317245;
        bh=NEx36QvSDMoQYGbBHFXD8w32hv/ikO4U5LoiRs83w0Q=;
        h=From:To:Cc:Subject:Date:From;
        b=PQmTJakVPDSdQyAWkucOT1pxwWd/CULJYvHMRTvr27D8thQ9tbJ3pO7xGzEgO5q8R
         uvAiLWQa8lbJi8wgvu2lNODBCc0pxCL+6HAh9w+xy8hnXpm3V/z/OiSR9PCffraKEv
         2OEGOUdmKY4XIjbQ+Z2/E/k8J+6xHSRpNZR+GtAo=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     lorenzo.bianconi@redhat.com, linux-iio@vger.kernel.org
Subject: [PATCH] iio: imu: st_lsm6dsx: set 10ms as min shub slave timeout
Date:   Wed, 21 Oct 2020 23:53:54 +0200
Message-Id: <b0cd79d1b72246652df9ccef19bd951bb17b5c55.1603317102.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Set 10ms as minimum i2c slave configuration timeout since at high ODRs
(e.g. 833Hz) the slave sensor may need more cycles than ~3ms
(2s/833Hz + 1) for the configuration

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
index 8c8d8870ca07..99562ba85ee4 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
@@ -156,11 +156,13 @@ static const struct st_lsm6dsx_ext_dev_settings st_lsm6dsx_ext_dev_table[] = {
 static void st_lsm6dsx_shub_wait_complete(struct st_lsm6dsx_hw *hw)
 {
 	struct st_lsm6dsx_sensor *sensor;
-	u32 odr;
+	u32 odr, timeout;
 
 	sensor = iio_priv(hw->iio_devs[ST_LSM6DSX_ID_ACC]);
 	odr = (hw->enable_mask & BIT(ST_LSM6DSX_ID_ACC)) ? sensor->odr : 12500;
-	msleep((2000000U / odr) + 1);
+	/* set 10ms as minimum timeout for i2c slave configuration */
+	timeout = max_t(u32, 2000000U / odr + 1, 10);
+	msleep(timeout);
 }
 
 /*
-- 
2.26.2

