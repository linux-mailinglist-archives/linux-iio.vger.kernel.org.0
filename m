Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD86CDE0D
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2019 11:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbfJGJMU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 7 Oct 2019 05:12:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:53370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727376AbfJGJMU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 7 Oct 2019 05:12:20 -0400
Received: from localhost.localdomain.com (nat-pool-mxp-t.redhat.com [149.6.153.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA81B2084D;
        Mon,  7 Oct 2019 09:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570439539;
        bh=Jjq736VNp6/LpTnoA7jgPOzEiPdMtwd7CFLx0qcGxT4=;
        h=From:To:Cc:Subject:Date:From;
        b=rOLQ9ggwtFVYIovyGj1+vOqL/kg0CSmyBGyg8FY0uyctUMGoutAiVRpyPTVkubx55
         kksYlcYscqEmxyk1BQF9PEaXlyugEcoSz+22TAVGPI9Z3EG20TXWa2St77IKqG5Km2
         CGjGwAQr2lF9UiEmTm/KExAo/kPBkHiyYWzS6aWg=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, martin@geanix.com,
        lorenzo.bianconi@redhat.com
Subject: [PATCH] iio: imu: st_lsm6dsx: fix gyro gain definitions for LSM9DS1
Date:   Mon,  7 Oct 2019 11:12:13 +0200
Message-Id: <69845a7020f584e07cba80c0a1f2ecddc4268d3a.1570439396.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Fix typos in gyro gain definitions for LSM9DS1 sensor

Fixes: 52f4b1f19679 ("iio: imu: st_lsm6dsx: add support for accel/gyro unit of lsm9ds1")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index 876f59cedc8b..e8c3922f1b59 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -158,9 +158,9 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 					.addr = 0x10,
 					.mask = GENMASK(4, 3),
 				},
-				.fs_avl[0] = {  IIO_DEGREE_TO_RAD(245), 0x0 },
-				.fs_avl[1] = {  IIO_DEGREE_TO_RAD(500), 0x1 },
-				.fs_avl[2] = { IIO_DEGREE_TO_RAD(2000), 0x3 },
+				.fs_avl[0] = {  IIO_DEGREE_TO_RAD(8750), 0x0 },
+				.fs_avl[1] = { IIO_DEGREE_TO_RAD(17500), 0x1 },
+				.fs_avl[2] = { IIO_DEGREE_TO_RAD(70000), 0x3 },
 			},
 		},
 		.irq_config = {
-- 
2.21.0

