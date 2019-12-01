Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E493410E3A2
	for <lists+linux-iio@lfdr.de>; Sun,  1 Dec 2019 22:39:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbfLAVih (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 1 Dec 2019 16:38:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:60070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726982AbfLAVih (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 1 Dec 2019 16:38:37 -0500
Received: from localhost.localdomain.com (unknown [77.139.212.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C5982082E;
        Sun,  1 Dec 2019 21:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575236316;
        bh=Yp9EJ3eYs7i04ZRykQ+Y1N/gDTF83XmPwmwjak7dZks=;
        h=From:To:Cc:Subject:Date:From;
        b=DehbeqbttSv8BtUhCtj24d5hON0R8ORCUOMgbfBHeqwbzaIoyTcL/ZjMXcuJlWdLg
         rub0JZGs6bF5RPXBkFrgKHMNoyQAT55zIQ0Mq+hKe/jgf+8kF8deh3Iy1oFOL+9X1r
         O0RPt5fDuQdmFNcLS4axKJJiMFY4FrW3R/d8/VDU=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     lorenzo.bianconi@redhat.com, linux-iio@vger.kernel.org
Subject: [PATCH v2] iio: imu: st_lsm6dsx: fix checkpatch warning
Date:   Sun,  1 Dec 2019 23:38:18 +0200
Message-Id: <34b2e207df91e1645ba5a4d2b12dfd41bdd17336.1575236122.git.lorenzo@kernel.org>
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
Changes since v1:
- remove extra line break in routine signature
- remove not related change
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index a7d40c02ce6b..ff5bac8ff9c6 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -1608,11 +1608,11 @@ static int st_lsm6dsx_event_setup(struct st_lsm6dsx_hw *hw, int state)
 }
 
 static int st_lsm6dsx_read_event(struct iio_dev *iio_dev,
-				   const struct iio_chan_spec *chan,
-				   enum iio_event_type type,
-				   enum iio_event_direction dir,
-				   enum iio_event_info info,
-				   int *val, int *val2)
+				 const struct iio_chan_spec *chan,
+				 enum iio_event_type type,
+				 enum iio_event_direction dir,
+				 enum iio_event_info info,
+				 int *val, int *val2)
 {
 	struct st_lsm6dsx_sensor *sensor = iio_priv(iio_dev);
 	struct st_lsm6dsx_hw *hw = sensor->hw;
-- 
2.21.0

