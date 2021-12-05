Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3096B468D32
	for <lists+linux-iio@lfdr.de>; Sun,  5 Dec 2021 21:22:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238388AbhLEUZx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Dec 2021 15:25:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238514AbhLEUZx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 5 Dec 2021 15:25:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF27BC061714
        for <linux-iio@vger.kernel.org>; Sun,  5 Dec 2021 12:22:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7CCA46114D
        for <linux-iio@vger.kernel.org>; Sun,  5 Dec 2021 20:22:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 030FCC341C5;
        Sun,  5 Dec 2021 20:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638735744;
        bh=LMcoZZFv7kpYVBdxLI6Le+bjxU5IQyp2R1ZDGW2mkuc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XdcDoTNborupt7n9Wh63Tg85/e7f+YgAz4LLQJ2DaSKj60EpihueGbhioZh1RxWdc
         MM7hz7oz46QoO/8B7F3TmTCr8OY9AS3bnSsuvAixfBskiZNmqbptzfH7JSAbaLqicr
         b3WspntpD5oGAc4n4hgk+4fhlDFEHyDPZ+5pfEZBLmlbJBDuj4Z1WTPf/YVCME59lV
         Pvr98QxJPRZ58Y1S6wtGtHPW+DByUT+HZnidwPSx3xwdwTx3wDxeWO4qeXZ5usXkRj
         /ItzhyUlMLRyw/XVYq5yfNFvwbzQk0xGPn1quT0EIPT3gWfGkWtfBsH+yH3JI+wKJ4
         Hve2ev3ul+RUg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Nuno Sa <Nuno.Sa@analog.com>
Cc:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>, lars@metafoo.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 08/17] staging:iio:adc:ad7280a: Drop unused timestamp channel.
Date:   Sun,  5 Dec 2021 20:27:01 +0000
Message-Id: <20211205202710.2847005-9-jic23@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211205202710.2847005-1-jic23@kernel.org>
References: <20211205202710.2847005-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

The driver doesn't support buffered mode, so a timestamp channel that
is entirely hidden from userspace without buffer mode is rather pointless.
Drop it.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/staging/iio/adc/ad7280a.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
index 032d6430bebf..58bddd07df0c 100644
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
2.34.1

