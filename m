Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 453F7D55A6
	for <lists+linux-iio@lfdr.de>; Sun, 13 Oct 2019 12:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728689AbfJMK2F (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 13 Oct 2019 06:28:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:53392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728528AbfJMK2F (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 13 Oct 2019 06:28:05 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97FA720679;
        Sun, 13 Oct 2019 10:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570962484;
        bh=Sqp2HVU2D7BdNWavcfc8KAWJAgvvPZNb28iBUjb/Ur0=;
        h=From:To:Cc:Subject:Date:From;
        b=2Y47o3eZeFRPLOTGTtXD7bsbvBL87prVhrHeMnwyNR+5toXwelxKX5/uutpLsrNnA
         2vLz1WGhbxMwqgtbrIQxzuaFG1OYRMCE49lp4+YM3kXKMHLa8zZ6MC+Z5tnh8IHomt
         G7GHyMFZV3AEpp9gKu2z8KlapZ4b2xGb/4aTAHsk=
From:   jic23@kernel.org
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>
Subject: [PATCH] iio: proximity: pulsedlight v2: Tidy up an endian issue
Date:   Sun, 13 Oct 2019 11:26:00 +0100
Message-Id: <20191013102600.1463679-1-jic23@kernel.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Sparse identified the following
CHECK   drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
drivers/iio/proximity/pulsedlight-lidar-lite-v2.c:144:24: warning: cast to restricted __be16
drivers/iio/proximity/pulsedlight-lidar-lite-v2.c:144:24: warning: cast to restricted __be16
drivers/iio/proximity/pulsedlight-lidar-lite-v2.c:144:24: warning: cast to restricted __be16
drivers/iio/proximity/pulsedlight-lidar-lite-v2.c:144:24: warning: cast to restricted __be16

This cleans up by adding a local variable to hold the value whilst
it is __be16 before applying endian converstion into eventual destination.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Matt Ranostay <matt.ranostay@konsulko.com>
---
 drivers/iio/proximity/pulsedlight-lidar-lite-v2.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
index 47af54f14756..5b369645ef49 100644
--- a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
+++ b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
@@ -136,12 +136,13 @@ static inline int lidar_write_power(struct lidar_data *data, int val)
 
 static int lidar_read_measurement(struct lidar_data *data, u16 *reg)
 {
+	__be16 value;
 	int ret = data->xfer(data, LIDAR_REG_DATA_HBYTE |
 			(data->i2c_enabled ? LIDAR_REG_DATA_WORD_READ : 0),
-			(u8 *) reg, 2);
+			(u8 *) &value, 2);
 
 	if (!ret)
-		*reg = be16_to_cpu(*reg);
+		*reg = be16_to_cpu(value);
 
 	return ret;
 }
-- 
2.23.0

