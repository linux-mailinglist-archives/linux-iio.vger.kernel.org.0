Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30A943A593D
	for <lists+linux-iio@lfdr.de>; Sun, 13 Jun 2021 17:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbhFMPK6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 13 Jun 2021 11:10:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:59746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231841AbhFMPK5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 13 Jun 2021 11:10:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7D50361285;
        Sun, 13 Jun 2021 15:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623596936;
        bh=GftFmaYqSVIZg3oByRPY+E4bX0nmqwmIDpCm3TeFH6s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lk9KY1cHW6XrfQ0X+1SLt5oqBg0WCfkHuXVwJTa0ArMbeE6cXYkh1ld948I4BrHjz
         f2AGoqKM+hrEpjrYYefQlXsFwHQZg3xcMBBwiQebq+zepDoh1aNOqr7nnGX3ZutSeL
         nZ/iDXHDoCT2TMakaXqToxhI7CudhX9gRwZp0hOa+VeyvUcxRLJ2Vjg0oYmLTy7CP0
         803UhjjZu8yr6jDAw8sYxPpxxCXpN2VsSt+WJSy1fgiY3uj9ICV8l52esVIA/vRdqX
         uiW86C+19Zz3lVUjtl/PKT48Bc+1CzezcCrInOTYTdIyT8Z2FDn2M4zSX5workeR/B
         iRWbcsK3zUvKw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Nuno Sa <Nuno.Sa@analog.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
Subject: [PATCH v2 4/4] iio: imu: adis16400: Fix buffer alignment requirements.
Date:   Sun, 13 Jun 2021 16:10:39 +0100
Message-Id: <20210613151039.569883-5-jic23@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210613151039.569883-1-jic23@kernel.org>
References: <20210613151039.569883-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

iio_push_to_buffers_with_timestamp() requires that the buffer
is 8 byte alignment to ensure an inserted timestamp is naturally aligned.

This requirement was not met here when burst mode is in use beause
of a leading u16. Use the new iio_push_to_buffers_with_ts_unaligned()
function that has more relaxed requirements.

It is somewhat complex to access that actual data length, but a
safe bound can be found by using scan_bytes - sizeof(timestamp) so that
is used in this path.

More efficient approaches exist, but this ensure correctness at the
cost of using a bounce buffer.

Fixes: 5075e0720d93 ("iio: imu: adis: generalize burst mode support")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/imu/adis16400.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/imu/adis16400.c b/drivers/iio/imu/adis16400.c
index cb8d3ffab6fc..66a83ebd3109 100644
--- a/drivers/iio/imu/adis16400.c
+++ b/drivers/iio/imu/adis16400.c
@@ -648,13 +648,23 @@ static irqreturn_t adis16400_trigger_handler(int irq, void *p)
 	if (ret)
 		dev_err(&adis->spi->dev, "Failed to read data: %d\n", ret);
 
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
+		iio_push_to_buffers_with_ts_unaligned(indio_dev, buffer,
+						      indio_dev->scan_bytes - sizeof(pf->timestamp),
+						      pf->timestamp);
+	} else {
+		iio_push_to_buffers_with_timestamp(indio_dev,
+						   adis->buffer,
+						   pf->timestamp);
+	}
 
-	iio_push_to_buffers_with_timestamp(indio_dev, buffer,
-		pf->timestamp);
 
 	iio_trigger_notify_done(indio_dev->trig);
 
-- 
2.32.0

