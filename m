Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5701210D293
	for <lists+linux-iio@lfdr.de>; Fri, 29 Nov 2019 09:47:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbfK2IrI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 29 Nov 2019 03:47:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:53366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725892AbfK2IrI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 29 Nov 2019 03:47:08 -0500
Received: from localhost.localdomain (unknown [77.139.212.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4992521721;
        Fri, 29 Nov 2019 08:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575017227;
        bh=jSx/JzbAiL7M8QxSA/rsgod36UnBOZ54GVlhJ7WOjAA=;
        h=From:To:Cc:Subject:Date:From;
        b=PcBSdsy1RXeVLKyG1+suVi/IYr1fKoL8x+04p8MKXzEam3yKDbMrK8ugG/nyP8cRQ
         vZt/z7CQgIAh13ctewWM1tDCr6SHPvrPFaV0pF78PomdzJGkSI3N8PdnyPiQ2bwXJK
         xrm4+vl0myWKlQjNzw7JWt4yHSx7pTmM9hxgRhyw=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     lorenzo.bianconi@redhat.com, linux-iio@vger.kernel.org
Subject: [PATCH] iio: imu: st_lsm6dsx: fix checkpatch warning
Date:   Fri, 29 Nov 2019 10:46:44 +0200
Message-Id: <4a1fefa9f941bf2c350b4a886fd05909e5ba8ea3.1575017118.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Fix following checkpatch warning:

CHECK: Alignment should match open parenthesis
+static int st_lsm6dsx_read_event(struct iio_dev *iio_dev,
+                                  const struct iio_chan_spec *chan,

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index a7d40c02ce6b..990643da9f4e 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -1607,12 +1607,13 @@ static int st_lsm6dsx_event_setup(struct st_lsm6dsx_hw *hw, int state)
 					     hw->irq_routing->mask, data);
 }
 
-static int st_lsm6dsx_read_event(struct iio_dev *iio_dev,
-				   const struct iio_chan_spec *chan,
-				   enum iio_event_type type,
-				   enum iio_event_direction dir,
-				   enum iio_event_info info,
-				   int *val, int *val2)
+static int
+st_lsm6dsx_read_event(struct iio_dev *iio_dev,
+		      const struct iio_chan_spec *chan,
+		      enum iio_event_type type,
+		      enum iio_event_direction dir,
+		      enum iio_event_info info,
+		      int *val, int *val2)
 {
 	struct st_lsm6dsx_sensor *sensor = iio_priv(iio_dev);
 	struct st_lsm6dsx_hw *hw = sensor->hw;
@@ -1620,8 +1621,8 @@ static int st_lsm6dsx_read_event(struct iio_dev *iio_dev,
 	if (type != IIO_EV_TYPE_THRESH)
 		return -EINVAL;
 
-	*val2 = 0;
 	*val = hw->event_threshold;
+	*val2 = 0;
 
 	return IIO_VAL_INT;
 }
-- 
2.21.0

