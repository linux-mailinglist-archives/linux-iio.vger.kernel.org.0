Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 095A9370813
	for <lists+linux-iio@lfdr.de>; Sat,  1 May 2021 19:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbhEAREH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 1 May 2021 13:04:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:47622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231624AbhEAREH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 1 May 2021 13:04:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 804D961494;
        Sat,  1 May 2021 17:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619888597;
        bh=xzCdApNrTu4WGkorKfY7rAn71k/JxYlItlZly/aomvA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bDw2GNFJAqy+LahkJyHpWbmZoy7J4NWNlmVdaE/wq92h0g9Rff7n45LCaj9PXc36i
         ab1lvd6OihwCdRj2Q3yUZeiK4VQGREAb1l+mhkCtOaGcLw6LEuWNrT+bfxAPqHUiyb
         nDHDIn2HlmyVxNdl5kRc8JZv9YHkUIoEA0M0fN3GIYvEEcYbDkLpjPA4xQtVZdRnjf
         1kczA533zj/rmOVlgFT2AHsfNEidyNjE2te+Nt7xepHhtwaKkQFH9w95JU1eKwEzUs
         wFbTaCcadkqvO6fLTmjeIND22jRnbvx1LERrF2Z/zqyQtA1SLlOzhIAA2MRjKs44H2
         1F0A9eDlbQmcg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 16/19] iio: magn: bmc150: Fix buffer alignment in iio_push_to_buffers_with_timestamp()
Date:   Sat,  1 May 2021 18:01:18 +0100
Message-Id: <20210501170121.512209-17-jic23@kernel.org>
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

Found during an audit of all calls of uses of
iio_push_to_buffers_with_timestamp()

Fixes: c91746a2361d ("iio: magn: Add support for BMC150 magnetometer")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Stephan Gerhold <stephan@gerhold.net>
Cc: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/iio/magnetometer/bmc150_magn.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/magnetometer/bmc150_magn.c b/drivers/iio/magnetometer/bmc150_magn.c
index 00f9766bad5c..dd5f80093a18 100644
--- a/drivers/iio/magnetometer/bmc150_magn.c
+++ b/drivers/iio/magnetometer/bmc150_magn.c
@@ -138,8 +138,11 @@ struct bmc150_magn_data {
 	struct regmap *regmap;
 	struct regulator_bulk_data regulators[2];
 	struct iio_mount_matrix orientation;
-	/* 4 x 32 bits for x, y z, 4 bytes align, 64 bits timestamp */
-	s32 buffer[6];
+	/* Ensure timestamp is naturally aligned */
+	struct {
+		s32 chans[4];
+		s64 timestamp __aligned(8);
+	} scan;
 	struct iio_trigger *dready_trig;
 	bool dready_trigger_on;
 	int max_odr;
@@ -675,11 +678,11 @@ static irqreturn_t bmc150_magn_trigger_handler(int irq, void *p)
 	int ret;
 
 	mutex_lock(&data->mutex);
-	ret = bmc150_magn_read_xyz(data, data->buffer);
+	ret = bmc150_magn_read_xyz(data, data->scan.chans);
 	if (ret < 0)
 		goto err;
 
-	iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
+	iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
 					   pf->timestamp);
 
 err:
-- 
2.31.1

