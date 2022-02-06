Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8ECB4AB17B
	for <lists+linux-iio@lfdr.de>; Sun,  6 Feb 2022 19:57:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241720AbiBFS5i (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 6 Feb 2022 13:57:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242266AbiBFS5h (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 6 Feb 2022 13:57:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9888BC043186
        for <linux-iio@vger.kernel.org>; Sun,  6 Feb 2022 10:57:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3419F611DF
        for <linux-iio@vger.kernel.org>; Sun,  6 Feb 2022 18:57:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52438C340F1;
        Sun,  6 Feb 2022 18:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644173855;
        bh=vYQpyjXvwCK2GA0dTm4YVfjyCZ8OKOth1haM7a5ydBI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qVvtxoz6XhLAE4CS27Y0CJSeLYKNOx2dn+fZ4n6UkNzwbrXRQFa0Bq9V30TY6yl29
         KCF9xnNuccnStjnPty5y49esSbLx4gAc+3rqLT1R+JEMyY/c/SXsr12k+fAabRpjEu
         WKiSf0nfzetglsc/xVAbdr84Hqzbvdqf8zis9qm4xZhRIY4GImaWCxzr8rfvUwctg8
         cyhDBt2o8vwc1kVBn3ZmMyPCERUel68vqw2VD7EPUs8Vhtqq070YGPOUX49X9F2qvc
         3kPFxqOkGcdn3lVebafHDNl2aHpblUgjB2PLrZshFOy528QX5wczkQNvpXdwSiYAoq
         dsQ93T+WP9V/w==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org,
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc:     Hennerich@vger.kernel.org, Michael <Michael.Hennerich@analog.com>,
        Nuno Sa <Nuno.Sa@analog.com>, lars@metafoo.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 08/20] staging:iio:adc:ad7280a: Drop unused timestamp channel.
Date:   Sun,  6 Feb 2022 19:03:16 +0000
Message-Id: <20220206190328.333093-9-jic23@kernel.org>
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

The driver doesn't support buffered mode, so a timestamp channel that
is entirely hidden from userspace without buffer mode is rather pointless.
Drop it.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
---
 drivers/staging/iio/adc/ad7280a.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
index 29edbda64230..c1ac46a8112e 100644
--- a/drivers/staging/iio/adc/ad7280a.c
+++ b/drivers/staging/iio/adc/ad7280a.c
@@ -613,16 +613,6 @@ static void ad7280_total_voltage_channel_init(struct iio_chan_spec *chan,
 	chan->scan_type.storagebits = 32;
 }
 
-static void ad7280_timestamp_channel_init(struct iio_chan_spec *chan, int cnt)
-{
-	chan->type = IIO_TIMESTAMP;
-	chan->channel = -1;
-	chan->scan_index = cnt;
-	chan->scan_type.sign = 's';
-	chan->scan_type.realbits = 64;
-	chan->scan_type.storagebits = 64;
-}
-
 static void ad7280_init_dev_channels(struct ad7280_state *st, int dev, int *cnt)
 {
 	int addr, ch, i;
@@ -650,7 +640,7 @@ static int ad7280_channel_init(struct ad7280_state *st)
 {
 	int dev, cnt = 0;
 
-	st->channels = devm_kcalloc(&st->spi->dev, (st->slave_num + 1) * 12 + 2,
+	st->channels = devm_kcalloc(&st->spi->dev, (st->slave_num + 1) * 12 + 1,
 				    sizeof(*st->channels), GFP_KERNEL);
 	if (!st->channels)
 		return -ENOMEM;
@@ -659,8 +649,6 @@ static int ad7280_channel_init(struct ad7280_state *st)
 		ad7280_init_dev_channels(st, dev, &cnt);
 
 	ad7280_total_voltage_channel_init(&st->channels[cnt], cnt, dev);
-	cnt++;
-	ad7280_timestamp_channel_init(&st->channels[cnt], cnt);
 
 	return cnt + 1;
 }
-- 
2.35.1

