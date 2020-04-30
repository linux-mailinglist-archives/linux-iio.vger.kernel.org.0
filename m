Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B38D1BF8E2
	for <lists+linux-iio@lfdr.de>; Thu, 30 Apr 2020 15:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbgD3NFw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 30 Apr 2020 09:05:52 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:38199 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbgD3NFw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 30 Apr 2020 09:05:52 -0400
X-Originating-IP: 87.231.134.186
Received: from localhost (87-231-134-186.rev.numericable.fr [87.231.134.186])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 579AB60008;
        Thu, 30 Apr 2020 13:05:49 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: [PATCH] iio: adc: ti-ads8344: Fix channel selection
Date:   Thu, 30 Apr 2020 15:05:47 +0200
Message-Id: <20200430130547.2175250-1-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

During initial submission the selection of the channel was done using
the scan_index member of the iio_chan_spec structure. It was an abuse
because this member is supposed to be used with a buffer so it was
removed.

However there was still the need to be able to known how to select a
channel, the correct member to store this information is address.

Thanks to this it is possible to select any other channel than the
channel 0.

Fixes: 8dd2d7c0fed7 ("iio: adc: Add driver for the TI ADS8344 A/DC chips")
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 drivers/iio/adc/ti-ads8344.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ti-ads8344.c b/drivers/iio/adc/ti-ads8344.c
index 9a460807d46d..d384ca3437da 100644
--- a/drivers/iio/adc/ti-ads8344.c
+++ b/drivers/iio/adc/ti-ads8344.c
@@ -32,16 +32,17 @@ struct ads8344 {
 	u16 rx_buf;
 };
 
-#define ADS8344_VOLTAGE_CHANNEL(chan, si)				\
+#define ADS8344_VOLTAGE_CHANNEL(chan, addr)				\
 	{								\
 		.type = IIO_VOLTAGE,					\
 		.indexed = 1,						\
 		.channel = chan,					\
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
+		.address = addr,					\
 	}
 
-#define ADS8344_VOLTAGE_CHANNEL_DIFF(chan1, chan2, si)			\
+#define ADS8344_VOLTAGE_CHANNEL_DIFF(chan1, chan2, addr)		\
 	{								\
 		.type = IIO_VOLTAGE,					\
 		.indexed = 1,						\
@@ -50,6 +51,7 @@ struct ads8344 {
 		.differential = 1,					\
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
+		.address = addr,					\
 	}
 
 static const struct iio_chan_spec ads8344_channels[] = {
@@ -105,7 +107,7 @@ static int ads8344_read_raw(struct iio_dev *iio,
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
 		mutex_lock(&adc->lock);
-		*value = ads8344_adc_conversion(adc, channel->scan_index,
+		*value = ads8344_adc_conversion(adc, channel->address,
 						channel->differential);
 		mutex_unlock(&adc->lock);
 		if (*value < 0)
-- 
2.26.1

