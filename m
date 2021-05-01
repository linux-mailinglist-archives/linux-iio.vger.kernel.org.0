Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B659D370821
	for <lists+linux-iio@lfdr.de>; Sat,  1 May 2021 19:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbhEARQX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 1 May 2021 13:16:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:54070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230195AbhEARQX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 1 May 2021 13:16:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 127D761284;
        Sat,  1 May 2021 17:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619889333;
        bh=2nyzGl1dLGqNduo1q2W6IN09V0foDNM3moAfWVlppr0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NcZvsA3hTFyTOwm/0d6bZlSuyOeno/EwxI1bp47l8Qun06cN303egEhmEyFpe+Aeh
         Kv1+HzIWOr3KUvwic5VphAI/Hct5BCRFb6jBdgggevOoJVG4f8g2ZJlhxuSJOc/jeg
         Lh+FtR5H8XPo+s3ISfl9gYbsHX0wCs5wviw4mPxUimhyD2UEQLFXUhMr63QW8BLQB8
         /mUyjWw+EsHqJK1sQx/Yz1jXQrkDhJRALpoEw2Y5dTBkosyawiQcHUihhUUtg1azx9
         wDajS4Ml8xYtZes6gi+WHMIExrsctt4YrcuBNj6xNugDwQyocTNkr8rcbf9yV4TTQJ
         5LoB7gRpgcTmg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH 06/11] iio: cros_ec_sensors: Fix alignment of buffer in iio_push_to_buffers_with_timestamp()
Date:   Sat,  1 May 2021 18:13:47 +0100
Message-Id: <20210501171352.512953-7-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210501171352.512953-1-jic23@kernel.org>
References: <20210501171352.512953-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

The samples buffer is passed to iio_push_to_buffers_with_timestamp()
which requires a buffer aligned to 8 bytes as it is assumed that
the timestamp will be naturally aligned if present.

Fixes tag is inaccurate but prior to that likely manual backporting needed.

Fixes: 5a0b8cb46624c ("iio: cros_ec: Move cros_ec_sensors_core.h in /include")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Gwendal Grignou <gwendal@chromium.org>
---
 include/linux/iio/common/cros_ec_sensors_core.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/iio/common/cros_ec_sensors_core.h b/include/linux/iio/common/cros_ec_sensors_core.h
index 7ce8a8adad58..c582e1a14232 100644
--- a/include/linux/iio/common/cros_ec_sensors_core.h
+++ b/include/linux/iio/common/cros_ec_sensors_core.h
@@ -77,7 +77,7 @@ struct cros_ec_sensors_core_state {
 		u16 scale;
 	} calib[CROS_EC_SENSOR_MAX_AXIS];
 	s8 sign[CROS_EC_SENSOR_MAX_AXIS];
-	u8 samples[CROS_EC_SAMPLE_SIZE];
+	u8 samples[CROS_EC_SAMPLE_SIZE] __aligned(8);
 
 	int (*read_ec_sensors_data)(struct iio_dev *indio_dev,
 				    unsigned long scan_mask, s16 *data);
-- 
2.31.1

