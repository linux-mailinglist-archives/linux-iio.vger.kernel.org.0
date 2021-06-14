Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A28B53A65B2
	for <lists+linux-iio@lfdr.de>; Mon, 14 Jun 2021 13:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234320AbhFNLl7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 14 Jun 2021 07:41:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:59698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236056AbhFNLhY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 14 Jun 2021 07:37:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 469F0611EE;
        Mon, 14 Jun 2021 11:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623670419;
        bh=XvUmnBhp741OqeRlc9z7LVCxaoX+lzDfpn4J2bqjm2I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YVX2UPmDGjWYXgXzSxdRrz2d5wJEfUT+jpkm4Qw+upe4nq+bJipN5KyQqDDlSOqrk
         qqCfFPqRZmR/tOt+ElTnDih88fS+dDkKPN7cfTvKjVPmiMITlJK9IMKH4/b/ZpseYj
         Gk/f5VnsWlSmnP8nRUS1109LiesK0TvnUXukK10Syj2ebEb0QMpyu2YpLEZlWHBC2n
         2c/Uywr/0YcqN4+4jasKRqCGeteUhz6aTaYwjkWhlKEx0LUrisrtja5aZDrHECQe6O
         ubJQ39TinXzVhmP575N5r4JsLG/dtoiMnPJikfGrNLrH+BjxPHVMsyWf2b2LQi0kwI
         pHFnMH8YufILA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Cc:     Michael.Hennerich@analog.com, lars@metafoo.de,
        devicetree@vger.kernel.org, Nuno Sa <Nuno.Sa@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 08/17] staging:iio:adc:ad7280a: Drop unused timestamp channel.
Date:   Mon, 14 Jun 2021 12:34:58 +0100
Message-Id: <20210614113507.897732-9-jic23@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210614113507.897732-1-jic23@kernel.org>
References: <20210614113507.897732-1-jic23@kernel.org>
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
2.32.0

