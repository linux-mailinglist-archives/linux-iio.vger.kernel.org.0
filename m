Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0669D7DE13
	for <lists+linux-iio@lfdr.de>; Thu,  1 Aug 2019 16:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbfHAOja (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 1 Aug 2019 10:39:30 -0400
Received: from comms.puri.sm ([159.203.221.185]:54674 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726409AbfHAOj3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 1 Aug 2019 10:39:29 -0400
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 29B3EE0F66;
        Thu,  1 Aug 2019 07:39:29 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id FG_DbJrd2E_C; Thu,  1 Aug 2019 07:39:28 -0700 (PDT)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     lorenzo.bianconi83@gmail.com, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH] iio: imu: st_lsm6dsx: make IIO_CHAN_INFO_SCALE shared by type
Date:   Thu,  1 Aug 2019 16:39:08 +0200
Message-Id: <20190801143908.27608-1-martin.kepplinger@puri.sm>
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

in_accel_x_scale, in_accel_y_scale and in_accel_z_scale are always
the same. The scale is still defined to be in "info_mask_separate".

Userspace (iio-sensor-proxy and others) is not used to that and only
looks for "in_accel_scale" for the scaling factor to apply.

Change IIO_CHAN_INFO_SCALE from being separate in all channel to be
shared by type.

This removes in_accel_x_scale, in_accel_y_scale and in_accel_z_scale and
makes available in_accel_scale.

Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---

AFAIK in all other drivers, IIO_CHAN_INFO_SCALE is "shared by type". Sure
devices are different, but LSM6DSX devices still don't have different
scales for x/y/z channels :)

thanks,

                              martin



 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index af379a5429ed..59c3ab7cbb6f 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -56,8 +56,8 @@ enum st_lsm6dsx_hw_id {
 	.address = addr,						\
 	.modified = 1,							\
 	.channel2 = mod,						\
-	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |			\
-			      BIT(IIO_CHAN_INFO_SCALE),			\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),		\
 	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
 	.scan_index = scan_idx,						\
 	.scan_type = {							\
-- 
2.20.1

