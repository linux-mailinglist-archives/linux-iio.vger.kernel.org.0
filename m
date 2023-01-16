Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B678466BF9B
	for <lists+linux-iio@lfdr.de>; Mon, 16 Jan 2023 14:21:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbjAPNVp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Jan 2023 08:21:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjAPNVo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Jan 2023 08:21:44 -0500
Received: from frolo.macqel.be (smtp2.macqel.be [109.135.2.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D218544B9
        for <linux-iio@vger.kernel.org>; Mon, 16 Jan 2023 05:21:42 -0800 (PST)
Received: by frolo.macqel.be (Postfix, from userid 1000)
        id B5D15DF00AD; Mon, 16 Jan 2023 14:07:47 +0100 (CET)
From:   Philippe De Muyter <Philippe.DeMuyter@macq.eu>
To:     lorenzo@kernel.org, linux-iio@vger.kernel.org
Cc:     Philippe De Muyter <phdm@macqel.be>
Subject: [PATCH v2 2/2] iio: imu: st_lsm6dsx: add 'mount_matrix' sysfs entry to gyro channel.
Date:   Mon, 16 Jan 2023 14:07:14 +0100
Message-Id: <1673874434-30750-3-git-send-email-Philippe.DeMuyter@macq.eu>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1673874434-30750-1-git-send-email-Philippe.DeMuyter@macq.eu>
References: <1673874434-30750-1-git-send-email-Philippe.DeMuyter@macq.eu>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Philippe De Muyter <phdm@macqel.be>

Signed-off-by: Philippe De Muyter <phdm@macqel.be>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index 5b6f195748fc..499fcf8875b4 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -93,7 +93,7 @@ enum st_lsm6dsx_hw_id {
 		.endianness = IIO_LE,					\
 	},								\
 	.event_spec = &st_lsm6dsx_event,				\
-	.ext_info = st_lsm6dsx_accel_ext_info,				\
+	.ext_info = st_lsm6dsx_ext_info,				\
 	.num_event_specs = 1,						\
 }
 
@@ -113,6 +113,7 @@ enum st_lsm6dsx_hw_id {
 		.storagebits = 16,					\
 		.endianness = IIO_LE,					\
 	},								\
+	.ext_info = st_lsm6dsx_ext_info,				\
 }
 
 struct st_lsm6dsx_reg {
@@ -528,7 +529,7 @@ st_lsm6dsx_device_set_enable(struct st_lsm6dsx_sensor *sensor, bool enable)
 }
 
 static const
-struct iio_chan_spec_ext_info __maybe_unused st_lsm6dsx_accel_ext_info[] = {
+struct iio_chan_spec_ext_info __maybe_unused st_lsm6dsx_ext_info[] = {
 	IIO_MOUNT_MATRIX(IIO_SHARED_BY_ALL, st_lsm6dsx_get_mount_matrix),
 	{ }
 };
-- 
2.31.1

