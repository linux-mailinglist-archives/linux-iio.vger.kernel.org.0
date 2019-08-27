Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FAA19E2A9
	for <lists+linux-iio@lfdr.de>; Tue, 27 Aug 2019 10:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729326AbfH0I3M (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 27 Aug 2019 04:29:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:52814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729028AbfH0I3M (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 27 Aug 2019 04:29:12 -0400
Received: from localhost.localdomain.com (nat-pool-mxp-t.redhat.com [149.6.153.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 737692173E;
        Tue, 27 Aug 2019 08:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566894551;
        bh=9Hh1/JVu8l+X8ovxfS501Jt/HOGa7lE8YDDAZRHj78g=;
        h=From:To:Cc:Subject:Date:From;
        b=fGuaHK4ST49iyn0QYRP105/ihYs3RPoocs4n5FH2i6B7NvZQf30FtnRvIg8T6O0Al
         xyw0IAOlyuf0KFVeOrWrtK3OfbWH32XciBWfUyFHs5BxV7YrXiPFTQ7pK1vFD29+OE
         7SetPRn9P3IIBedAWHn9JWILv1k4Zb0RMc7fu7Yw=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     lorenzo.bianconi@redhat.com, linux-iio@vger.kernel.org,
        martin.kepplinger@puri.sm
Subject: [PATCH] iio: imu: st_lsm6dsx: rely on IIO_G_TO_M_S_2 for gain definition for LSM9DS1
Date:   Tue, 27 Aug 2019 10:29:06 +0200
Message-Id: <776652415fadc8fc027ca13e74d942d7f45d7e7e.1566894470.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Rely on IIO_G_TO_M_S_2 macro for LSM9DS1 accelerometer gain definitions

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index c85c8be3a024..2d3495560136 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -141,10 +141,10 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 					.addr = 0x20,
 					.mask = GENMASK(4, 3),
 				},
-				.fs_avl[0] = {  599, 0x0 },
-				.fs_avl[1] = { 1197, 0x2 },
-				.fs_avl[2] = { 2394, 0x3 },
-				.fs_avl[3] = { 4788, 0x1 },
+				.fs_avl[0] = {  IIO_G_TO_M_S_2(61), 0x0 },
+				.fs_avl[1] = { IIO_G_TO_M_S_2(122), 0x2 },
+				.fs_avl[2] = { IIO_G_TO_M_S_2(244), 0x3 },
+				.fs_avl[3] = { IIO_G_TO_M_S_2(732), 0x1 },
 			},
 			[ST_LSM6DSX_ID_GYRO] = {
 				.reg = {
-- 
2.21.0

