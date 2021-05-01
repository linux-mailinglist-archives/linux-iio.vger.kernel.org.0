Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19CEA370804
	for <lists+linux-iio@lfdr.de>; Sat,  1 May 2021 19:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbhEARDm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 1 May 2021 13:03:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:47356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230450AbhEARDm (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 1 May 2021 13:03:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1F07461477;
        Sat,  1 May 2021 17:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619888572;
        bh=l+q9JoD+N6d5yOdWpLTkf2DWswGnbFRHMRoaHpupKvQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sFURnOk6rzfe54+4NzUu/qHTEXDRBXQpHeqM1aKPnBZWnDLUxD+egZteMC8w9hU0e
         cZK2u4B0MOJXX2Y8MTnnbfZEsDzCIUDkx2kGXrGTYuaNfGy3S0WLOG2fT37u4xgxod
         GlMqMsAajvhtE5fN71rTrUvSrpog+ZN1KDFIqQiHGV8gkN2SHG3wjzTEx3e5f+6xfn
         W9F/2SauD6jElcj28lP+bFiu5qvr3PZFu/3YHrdaNN6EKu61Oyl67Tg1vgzOQXMv1F
         R7piCXf/mTavLF41k4WB+N5AF0c5+Gmv7T11tU3cPDVQWc8NbQ1dr8qM8YksmMECYD
         pQdGJpkgXa7ew==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 01/19] iio: accel: bma180: Fix buffer alignment in iio_push_to_buffers_with_timestamp()
Date:   Sat,  1 May 2021 18:01:03 +0100
Message-Id: <20210501170121.512209-2-jic23@kernel.org>
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

Fixes: b9a6a237ffc9 ("iio:bma180: Drop _update_scan_mode()")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/iio/accel/bma180.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
index b8a7469cdae4..2e901f900ea7 100644
--- a/drivers/iio/accel/bma180.c
+++ b/drivers/iio/accel/bma180.c
@@ -162,7 +162,11 @@ struct bma180_data {
 	int scale;
 	int bw;
 	bool pmode;
-	u8 buff[16]; /* 3x 16-bit + 8-bit + padding + timestamp */
+	/* Ensure timestamp is naturally aligned */
+	struct {
+		s16 chan[3];
+		s64 timestamp __aligned(8);
+	} scan;
 };
 
 enum bma180_chan {
@@ -938,12 +942,12 @@ static irqreturn_t bma180_trigger_handler(int irq, void *p)
 			mutex_unlock(&data->mutex);
 			goto err;
 		}
-		((s16 *)data->buff)[i++] = ret;
+		data->scan.chan[i++] = ret;
 	}
 
 	mutex_unlock(&data->mutex);
 
-	iio_push_to_buffers_with_timestamp(indio_dev, data->buff, time_ns);
+	iio_push_to_buffers_with_timestamp(indio_dev, &data->scan, time_ns);
 err:
 	iio_trigger_notify_done(indio_dev->trig);
 
-- 
2.31.1

