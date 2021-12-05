Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA492468D2E
	for <lists+linux-iio@lfdr.de>; Sun,  5 Dec 2021 21:22:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238496AbhLEUZq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Dec 2021 15:25:46 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:38586 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238388AbhLEUZo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 5 Dec 2021 15:25:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B1416114D
        for <linux-iio@vger.kernel.org>; Sun,  5 Dec 2021 20:22:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19522C341C4;
        Sun,  5 Dec 2021 20:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638735735;
        bh=E0DenEJgS+Aw/BmJoPFiwK5nbE+zr/yDENLoHrnqu/M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t363JgwJxZdxkzquAqSlzfWY4nciYBUuDHIkiAxO+SdhgBV+iwk2ZW47qqsvU+EhS
         MfEMQC+fiOOUqi47ylAdLADHVoRj50kPA+i5JL1qjXKGyBxC9RDf/mx3Y5qeLGz00t
         j6vkTJFYkxDt7CZfp1hTniY5gEmhOncy9DWYjUM69nn+/4NzL//PXHH3o/k7CSRCjU
         PSp3HnlDyfNSBGshfA+qM/q4N1BG2790yCai7I45w2fKWsYT88nzclIXzLfV1qC2tF
         vZpnioDGREjXcwZADY+r083+05/t5iQDbq0gXAFRvbLPwzx/cIfsAYAmz+VecJRD6z
         zDEzC40hfO+/w==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Nuno Sa <Nuno.Sa@analog.com>
Cc:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>, lars@metafoo.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 04/17] staging:iio:adc:ad7280a: Split buff[2] into tx and rx parts
Date:   Sun,  5 Dec 2021 20:26:57 +0000
Message-Id: <20211205202710.2847005-5-jic23@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211205202710.2847005-1-jic23@kernel.org>
References: <20211205202710.2847005-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

As the __cacheline_aligned will ensure that the first of these two buffers
is appropriate aligned, there is no need to keep them as a single array
which is confusing given the first element is always tx and the second
rx.  Hence let us just have two parts and name them separately.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/staging/iio/adc/ad7280a.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
index 4d866e5fe43c..1f7ea5fb1e20 100644
--- a/drivers/staging/iio/adc/ad7280a.c
+++ b/drivers/staging/iio/adc/ad7280a.c
@@ -153,7 +153,8 @@ struct ad7280_state {
 	unsigned char			cb_mask[AD7280A_MAX_CHAIN];
 	struct mutex			lock; /* protect sensor state */
 
-	__be32				buf[2] ____cacheline_aligned;
+	__be32				tx ____cacheline_aligned;
+	__be32				rx;
 };
 
 static unsigned char ad7280_calc_crc8(unsigned char *crc_tab, unsigned int val)
@@ -196,18 +197,18 @@ static int __ad7280_read32(struct ad7280_state *st, unsigned int *val)
 {
 	int ret;
 	struct spi_transfer t = {
-		.tx_buf	= &st->buf[0],
-		.rx_buf = &st->buf[1],
-		.len = 4,
+		.tx_buf	= &st->tx,
+		.rx_buf = &st->rx,
+		.len = sizeof(st->tx),
 	};
 
-	st->buf[0] = cpu_to_be32(AD7280A_READ_TXVAL);
+	st->tx = cpu_to_be32(AD7280A_READ_TXVAL);
 
 	ret = spi_sync_transfer(st->spi, &t, 1);
 	if (ret)
 		return ret;
 
-	*val = be32_to_cpu(st->buf[1]);
+	*val = be32_to_cpu(st->rx);
 
 	return 0;
 }
@@ -219,9 +220,9 @@ static int ad7280_write(struct ad7280_state *st, unsigned int devaddr,
 			(val & 0xFF) << 13 | all << 12;
 
 	reg |= ad7280_calc_crc8(st->crc_tab, reg >> 11) << 3 | 0x2;
-	st->buf[0] = cpu_to_be32(reg);
+	st->tx = cpu_to_be32(reg);
 
-	return spi_write(st->spi, &st->buf[0], 4);
+	return spi_write(st->spi, &st->tx, sizeof(st->tx));
 }
 
 static int ad7280_read_reg(struct ad7280_state *st, unsigned int devaddr,
-- 
2.34.1

