Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3400721D51E
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jul 2020 13:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729581AbgGMLkd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Jul 2020 07:40:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:53362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728950AbgGMLkc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 13 Jul 2020 07:40:32 -0400
Received: from localhost.localdomain.com (unknown [151.48.133.17])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D112020738;
        Mon, 13 Jul 2020 11:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594640431;
        bh=mhcgshfj3TaW5B3pbdZ3PhwLFZh1c2pJd2omkSkCwUg=;
        h=From:To:Cc:Subject:Date:From;
        b=2K+uOmQEyu4INv9KOAazTsr6b9rK548wRwqTMvkxbxdiKiExUqtuHYMJcRjee6Nsn
         8JOHnM/SHNbgt6JKVuSNF/BjX585DxEP005uZ4oV8cFUiEym9RthvXisRFWmQLgfBq
         ilr+UQLMQhO7c9c5QXo3WVy7OVZvHU5kxpZRgSuU=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     sean@geanix.com, linux-iio@vger.kernel.org,
        lorenzo.bianconi@redhat.com
Subject: [PATCH v2] iio: imu: st_lsm6dsx: reset hw ts after resume
Date:   Mon, 13 Jul 2020 13:40:19 +0200
Message-Id: <4eb556ec9e68dccde35fa01fddad252a746a2fd3.1594640279.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Reset hw time samples generator after system resume in order to avoid
disalignment between system and device time reference since FIFO
batching and time samples generator are disabled during suspend.

Fixes: 213451076bd3 ("iio: imu: st_lsm6dsx: add hw timestamp support")
Tested-by: Sean Nyekjaer <sean@geanix.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
Changes since v1:
- add missing Fixes tag
- improve commit log
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h       |  3 +--
 .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    | 23 ++++++++++++-------
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c  |  2 +-
 3 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index b56df409ed0f..529970195b39 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -436,8 +436,7 @@ int st_lsm6dsx_update_watermark(struct st_lsm6dsx_sensor *sensor,
 				u16 watermark);
 int st_lsm6dsx_update_fifo(struct st_lsm6dsx_sensor *sensor, bool enable);
 int st_lsm6dsx_flush_fifo(struct st_lsm6dsx_hw *hw);
-int st_lsm6dsx_set_fifo_mode(struct st_lsm6dsx_hw *hw,
-			     enum st_lsm6dsx_fifo_mode fifo_mode);
+int st_lsm6dsx_resume_fifo(struct st_lsm6dsx_hw *hw);
 int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw *hw);
 int st_lsm6dsx_read_tagged_fifo(struct st_lsm6dsx_hw *hw);
 int st_lsm6dsx_check_odr(struct st_lsm6dsx_sensor *sensor, u32 odr, u8 *val);
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
index afd00daeefb2..7de10bd636ea 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
@@ -184,8 +184,8 @@ static int st_lsm6dsx_update_decimators(struct st_lsm6dsx_hw *hw)
 	return err;
 }
 
-int st_lsm6dsx_set_fifo_mode(struct st_lsm6dsx_hw *hw,
-			     enum st_lsm6dsx_fifo_mode fifo_mode)
+static int st_lsm6dsx_set_fifo_mode(struct st_lsm6dsx_hw *hw,
+				    enum st_lsm6dsx_fifo_mode fifo_mode)
 {
 	unsigned int data;
 
@@ -302,6 +302,18 @@ static int st_lsm6dsx_reset_hw_ts(struct st_lsm6dsx_hw *hw)
 	return 0;
 }
 
+int st_lsm6dsx_resume_fifo(struct st_lsm6dsx_hw *hw)
+{
+	int err;
+
+	/* reset hw ts counter */
+	err = st_lsm6dsx_reset_hw_ts(hw);
+	if (err < 0)
+		return err;
+
+	return st_lsm6dsx_set_fifo_mode(hw, ST_LSM6DSX_FIFO_CONT);
+}
+
 /*
  * Set max bulk read to ST_LSM6DSX_MAX_WORD_LEN/ST_LSM6DSX_MAX_TAGGED_WORD_LEN
  * in order to avoid a kmalloc for each bus access
@@ -675,12 +687,7 @@ int st_lsm6dsx_update_fifo(struct st_lsm6dsx_sensor *sensor, bool enable)
 		goto out;
 
 	if (fifo_mask) {
-		/* reset hw ts counter */
-		err = st_lsm6dsx_reset_hw_ts(hw);
-		if (err < 0)
-			goto out;
-
-		err = st_lsm6dsx_set_fifo_mode(hw, ST_LSM6DSX_FIFO_CONT);
+		err = st_lsm6dsx_resume_fifo(hw);
 		if (err < 0)
 			goto out;
 	}
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index c8ddeb3f48ff..346c24281d26 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -2457,7 +2457,7 @@ static int __maybe_unused st_lsm6dsx_resume(struct device *dev)
 	}
 
 	if (hw->fifo_mask)
-		err = st_lsm6dsx_set_fifo_mode(hw, ST_LSM6DSX_FIFO_CONT);
+		err = st_lsm6dsx_resume_fifo(hw);
 
 	return err;
 }
-- 
2.26.2

