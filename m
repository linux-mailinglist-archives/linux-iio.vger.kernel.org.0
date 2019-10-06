Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 050F8CD219
	for <lists+linux-iio@lfdr.de>; Sun,  6 Oct 2019 15:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbfJFNWo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 6 Oct 2019 09:22:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:38534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726060AbfJFNWo (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 6 Oct 2019 09:22:44 -0400
Received: from lore-desk-wlan.lan (unknown [151.66.37.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70DCE2080F;
        Sun,  6 Oct 2019 13:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570368163;
        bh=MNWJLwxyI7zRash2vbBuM0IL8Rhccb10ChtBsE6owvU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ToFsD2b2QpUPT/YfcGpqYtuFB+p6gkF4E877uQs9/dUskRNm/stQe14oLdnPwDYsS
         zZ3EaAk9nBrRbsvPh33Ld+6y83AEadrlSdKzRKq+Ins95JNaNZhW0aBGrBmOaLNjBy
         g4ybbhW1hkEPSMWeRQFh0Pb7wfekdWrzxhhPy+qE=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, sean@geanix.com, martin@geanix.com,
        rjones@gateworks.com, lorenzo.bianconi@redhat.com,
        devicetree@vger.kernel.org
Subject: [PATCH 09/13] iio: imu: st_lsm6dsx: fix checkpatch warning
Date:   Sun,  6 Oct 2019 15:22:03 +0200
Message-Id: <7c8a7e5f17befae7ac541cfb155ec7fefa78b10e.1570367532.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1570367532.git.lorenzo@kernel.org>
References: <cover.1570367532.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Fix following checkpatch warnings:

CHECK: Alignment should match open parenthesis
+static int st_lsm6dsx_read_event(struct iio_dev *iio_dev,
+				   const struct iio_chan_spec *chan,

CHECK: Alignment should match open parenthesis
+static int st_lsm6dsx_write_event(struct iio_dev *iio_dev,
+				    const struct iio_chan_spec *chan,

CHECK: Alignment should match open parenthesis
+static int st_lsm6dsx_read_event_config(struct iio_dev *iio_dev,
+					  const struct iio_chan_spec *chan,

CHECK: Alignment should match open parenthesis
+static int st_lsm6dsx_write_event_config(struct iio_dev *iio_dev,
+					   const struct iio_chan_spec *chan,

WARNING: line over 80 characters
+	if (dev->of_node && of_property_read_bool(dev->of_node, "wakeup-source"))

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 35 +++++++++++---------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index 04231710ab9c..b0623b837abd 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -1523,12 +1523,13 @@ static int st_lsm6dsx_read_event(struct iio_dev *iio_dev,
 	return IIO_VAL_INT;
 }
 
-static int st_lsm6dsx_write_event(struct iio_dev *iio_dev,
-				    const struct iio_chan_spec *chan,
-				    enum iio_event_type type,
-				    enum iio_event_direction dir,
-				    enum iio_event_info info,
-				    int val, int val2)
+static int
+st_lsm6dsx_write_event(struct iio_dev *iio_dev,
+		       const struct iio_chan_spec *chan,
+		       enum iio_event_type type,
+		       enum iio_event_direction dir,
+		       enum iio_event_info info,
+		       int val, int val2)
 {
 	struct st_lsm6dsx_sensor *sensor = iio_priv(iio_dev);
 	struct st_lsm6dsx_hw *hw = sensor->hw;
@@ -1554,10 +1555,11 @@ static int st_lsm6dsx_write_event(struct iio_dev *iio_dev,
 	return 0;
 }
 
-static int st_lsm6dsx_read_event_config(struct iio_dev *iio_dev,
-					  const struct iio_chan_spec *chan,
-					  enum iio_event_type type,
-					  enum iio_event_direction dir)
+static int
+st_lsm6dsx_read_event_config(struct iio_dev *iio_dev,
+			     const struct iio_chan_spec *chan,
+			     enum iio_event_type type,
+			     enum iio_event_direction dir)
 {
 	struct st_lsm6dsx_sensor *sensor = iio_priv(iio_dev);
 	struct st_lsm6dsx_hw *hw = sensor->hw;
@@ -1568,11 +1570,11 @@ static int st_lsm6dsx_read_event_config(struct iio_dev *iio_dev,
 	return !!(hw->enable_event & BIT(chan->channel2));
 }
 
-static int st_lsm6dsx_write_event_config(struct iio_dev *iio_dev,
-					   const struct iio_chan_spec *chan,
-					   enum iio_event_type type,
-					   enum iio_event_direction dir,
-					   int state)
+static int
+st_lsm6dsx_write_event_config(struct iio_dev *iio_dev,
+			      const struct iio_chan_spec *chan,
+			      enum iio_event_type type,
+			      enum iio_event_direction dir, int state)
 {
 	struct st_lsm6dsx_sensor *sensor = iio_priv(iio_dev);
 	struct st_lsm6dsx_hw *hw = sensor->hw;
@@ -2150,7 +2152,8 @@ int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id,
 			return err;
 	}
 
-	if (dev->of_node && of_property_read_bool(dev->of_node, "wakeup-source"))
+	if (dev->of_node &&
+	    of_property_read_bool(dev->of_node, "wakeup-source"))
 		device_init_wakeup(dev, true);
 
 	return 0;
-- 
2.21.0

