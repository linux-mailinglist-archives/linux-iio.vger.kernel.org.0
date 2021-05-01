Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DBBC370807
	for <lists+linux-iio@lfdr.de>; Sat,  1 May 2021 19:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbhEARDs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 1 May 2021 13:03:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:47418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230450AbhEARDr (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 1 May 2021 13:03:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D49CA61481;
        Sat,  1 May 2021 17:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619888577;
        bh=vEkpMmWq60tmNGyf786zefo2eEI5/JoT0hmtf6a6V+U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ds+ePacjBKIpKMFTP76ZqBozGzkxLnaQx0TnQnxBPs6duvRc0QfYAjmpmaLDEGLjL
         7a3erYgONbnC97NQMGMrA0+PAV3pw4hha94E4VF8j9HYL7KYPrhXxdWtushe37QTum
         hnoO48EFOHRzS7jURHpiIn4aG7rKJ/3L2T2zzigzosNWwBOsxMqyccpUR6NPBhbi+p
         Pe+VDCOZ2b4NIrWMXwciZuPndrFkn3zhHYW+08pWuPPInr8GfWgEwfkct27uxQBkNB
         lltTAzs0I+pn4+PuG5GoIW/W6sTOGJUbpcPKR6iM0Ep7xisCB/FYMQzcdudAALaaG1
         CdYDhvHrJjcwA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 04/19] iio: accel: kxcjk-1013: Fix buffer alignment in iio_push_to_buffers_with_timestamp()
Date:   Sat,  1 May 2021 18:01:06 +0100
Message-Id: <20210501170121.512209-5-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210501170121.512209-1-jic23@kernel.org>
References: <20210501170121.512209-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

To make code more readable, use a structure to express the channel
layout and ensure the timestamp is 8 byte aligned.

Found during an audit of all calls of this function.

Fixes: 1a4fbf6a9286 ("iio: accel: kxcjk1013 3-axis accelerometer driver")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/iio/accel/kxcjk-1013.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index ff724bc17a45..96ab247f17b3 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -133,6 +133,13 @@ enum kx_acpi_type {
 	ACPI_KIOX010A,
 };
 
+enum kxcjk1013_axis {
+	AXIS_X,
+	AXIS_Y,
+	AXIS_Z,
+	AXIS_MAX,
+};
+
 struct kxcjk1013_data {
 	struct regulator_bulk_data regulators[2];
 	struct i2c_client *client;
@@ -140,7 +147,11 @@ struct kxcjk1013_data {
 	struct iio_trigger *motion_trig;
 	struct iio_mount_matrix orientation;
 	struct mutex mutex;
-	s16 buffer[8];
+	/* Ensure timestamp naturally aligned */
+	struct {
+		s16 chans[AXIS_MAX];
+		s64 timestamp __aligned(8);
+	} scan;
 	u8 odr_bits;
 	u8 range;
 	int wake_thres;
@@ -154,13 +165,6 @@ struct kxcjk1013_data {
 	enum kx_acpi_type acpi_type;
 };
 
-enum kxcjk1013_axis {
-	AXIS_X,
-	AXIS_Y,
-	AXIS_Z,
-	AXIS_MAX,
-};
-
 enum kxcjk1013_mode {
 	STANDBY,
 	OPERATION,
@@ -1094,12 +1098,12 @@ static irqreturn_t kxcjk1013_trigger_handler(int irq, void *p)
 	ret = i2c_smbus_read_i2c_block_data_or_emulated(data->client,
 							KXCJK1013_REG_XOUT_L,
 							AXIS_MAX * 2,
-							(u8 *)data->buffer);
+							(u8 *)data->scan.chans);
 	mutex_unlock(&data->mutex);
 	if (ret < 0)
 		goto err;
 
-	iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
+	iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
 					   data->timestamp);
 err:
 	iio_trigger_notify_done(indio_dev->trig);
-- 
2.31.1

