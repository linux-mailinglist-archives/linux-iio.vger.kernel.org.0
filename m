Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BBFC370840
	for <lists+linux-iio@lfdr.de>; Sat,  1 May 2021 19:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231846AbhEAR1f (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 1 May 2021 13:27:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:33238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231784AbhEAR1f (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 1 May 2021 13:27:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3B785613B0;
        Sat,  1 May 2021 17:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619890005;
        bh=WhMpe9jY5QFi6XU8b1GuG7GpGTvF623i/0hC2OJnUhM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QmV/rqLUItgjWS4dDWmXqEnpT4MCv7fZZ6j2vzmz59X4S8fr9fuYlnWS+3SPgzhRk
         NcEy4cSxB7Sw2+/F5SnaiK2zSku6u33tyYy/vhPWiE1MDK01uKXvQ+w9NZHeqyh8MS
         R8ZzrRqLleu0z5e5M+RqasUvnyTn0PgzW+CXhw0wmRsZb1QisaPgpOw2t9TStFLkW8
         gDtIFjJZ9ikXqz6Qucde8Uwwcm1aS8yt6pFqS3e0lCkksbjE/IELrAq1J9ct8v59Zz
         n3lXLbE++LdWeqMAWwLv1j5Okdg22IMWHGPV5h61xRtwToNLlmpKtPPP8kUVUcCoxy
         +g25n/awwkzzg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Nuno Sa <nuno.sa@analog.com>
Subject: [RFC PATCH 4/4] iio: imu: adis16400: Fix buffer alignment requirements.
Date:   Sat,  1 May 2021 18:25:15 +0100
Message-Id: <20210501172515.513486-5-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210501172515.513486-1-jic23@kernel.org>
References: <20210501172515.513486-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

iio_push_to_buffers_with_timestamp() requires that the buffer
is 8 byte alignment to ensure an inserted timestamp is naturally aligned.

This requirement was not met here when burst mode is in use beause
of a leading u16. Use the new iio_push_to_buffers_with_ts_na() function
that has more relaxed requirements.

It is somewhat complex to access that actual data length, but a
safe bound can be found by using scan_bytes - sizeof(timestamp) so that
is used in this path.

More efficient approaches exist, but this ensure correctness at the
cost of using a bounce buffer.

Fixes: 5075e0720d93 ("iio: imu: adis: generalize burst mode support")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/imu/adis16400.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/imu/adis16400.c b/drivers/iio/imu/adis16400.c
index 768aa493a1a6..c6d03a37373b 100644
--- a/drivers/iio/imu/adis16400.c
+++ b/drivers/iio/imu/adis16400.c
@@ -663,13 +663,23 @@ static irqreturn_t adis16400_trigger_handler(int irq, void *p)
 		spi_setup(st->adis.spi);
 	}
 
-	if (st->variant->flags & ADIS16400_BURST_DIAG_STAT)
+	if (st->variant->flags & ADIS16400_BURST_DIAG_STAT) {
 		buffer = adis->buffer + sizeof(u16);
-	else
-		buffer = adis->buffer;
+		/*
+		 * The size here is always larger than, or equal to the true
+		 * size of the channel data. This may result in a larger copy
+		 * than necessary, but as the target buffer will be
+		 * buffer->scan_bytes this will be safe.
+		 */
+		iio_push_to_buffers_with_ts_na(indio_dev, buffer,
+					       indio_dev->scan_bytes - sizeof(pf->timestamp),
+					       pf->timestamp);
+	} else {
+		iio_push_to_buffers_with_timestamp(indio_dev,
+						   adis->buffer,
+						   pf->timestamp);
+	}
 
-	iio_push_to_buffers_with_timestamp(indio_dev, buffer,
-		pf->timestamp);
 
 	iio_trigger_notify_done(indio_dev->trig);
 
-- 
2.31.1

