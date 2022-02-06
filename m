Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73B1C4AB177
	for <lists+linux-iio@lfdr.de>; Sun,  6 Feb 2022 19:57:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240770AbiBFS52 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 6 Feb 2022 13:57:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234840AbiBFS51 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 6 Feb 2022 13:57:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE34C043184
        for <linux-iio@vger.kernel.org>; Sun,  6 Feb 2022 10:57:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 73BCAB80E63
        for <linux-iio@vger.kernel.org>; Sun,  6 Feb 2022 18:57:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D46E5C340EF;
        Sun,  6 Feb 2022 18:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644173844;
        bh=kKK1tK9vANx9uh/+tdEfpevD4XP37s0POS/pgw9tcck=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rUjEtLf3a9wR4EPTwFhqYTkaaQw68uftQNZY+97ZvWLRrG0WKBfHmb3eDTmZkGUyb
         MSLWOehMV+cPvqYvmY2il+R9RX5fIeUVTwGfDIfF0kdxvLSWUNc5bQ9j7i6MCWFquO
         QfpXED3Nbd6XC9717NcV0tCMuqPrgjsP6juCPipDnnsGQfHgLLY5ZPlmLjB39pxdeb
         mRcXDorslc+s3t/D2ctBEvD/WahWSM2CTHyBRNuhZ4P9pcjFY5gfvJ6VDPPe4PWn4y
         Z0WFAzEMlpFnA3eW9pnE+eXkd0SH8huNwvQ774k+QMez7LiprSu8nJgssV0xm0dL3J
         v5g+FnJXhQ85w==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org,
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc:     Hennerich@vger.kernel.org, Michael <Michael.Hennerich@analog.com>,
        Nuno Sa <Nuno.Sa@analog.com>, lars@metafoo.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 04/20] staging:iio:adc:ad7280a: Split buff[2] into tx and rx parts
Date:   Sun,  6 Feb 2022 19:03:12 +0000
Message-Id: <20220206190328.333093-5-jic23@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220206190328.333093-1-jic23@kernel.org>
References: <20220206190328.333093-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

As the __cacheline_aligned will ensure that the first of these two buffers
is appropriate aligned, there is no need to keep them as a single array
which is confusing given the first element is always tx and the second
rx.  Hence let us just have two parts and name them separately.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
---
 drivers/staging/iio/adc/ad7280a.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
index f1382666d2aa..b1698262cee0 100644
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
2.35.1

