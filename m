Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB61169A83F
	for <lists+linux-iio@lfdr.de>; Fri, 17 Feb 2023 10:37:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbjBQJhb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Feb 2023 04:37:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbjBQJh3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Feb 2023 04:37:29 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E724561876
        for <linux-iio@vger.kernel.org>; Fri, 17 Feb 2023 01:37:28 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1pSxB5-0006h9-G7; Fri, 17 Feb 2023 10:37:15 +0100
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <mfe@pengutronix.de>)
        id 1pSxB3-005YBQ-5a; Fri, 17 Feb 2023 10:37:14 +0100
Received: from mfe by dude02.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <mfe@pengutronix.de>)
        id 1pSxB3-007wJs-Lz; Fri, 17 Feb 2023 10:37:13 +0100
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     puranjay12@gmail.com, jic23@kernel.org, lars@metafoo.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH v3 4/4] iio: temperature: tmp117: cosmetic alignment cleanup
Date:   Fri, 17 Feb 2023 10:37:11 +0100
Message-Id: <20230217093711.1891564-5-m.felsch@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230217093711.1891564-1-m.felsch@pengutronix.de>
References: <20230217093711.1891564-1-m.felsch@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Align the code correctly if possible and align the channel bit mask to
make it easier to read.

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
v3:
- no changes
v2:
- no changes

 drivers/iio/temperature/tmp117.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/temperature/tmp117.c b/drivers/iio/temperature/tmp117.c
index 728538fbaf9ba..8fe87b37a0aca 100644
--- a/drivers/iio/temperature/tmp117.c
+++ b/drivers/iio/temperature/tmp117.c
@@ -42,8 +42,8 @@ struct tmp117_data {
 };
 
 static int tmp117_read_raw(struct iio_dev *indio_dev,
-		struct iio_chan_spec const *channel, int *val,
-		int *val2, long mask)
+			   struct iio_chan_spec const *channel, int *val,
+			   int *val2, long mask)
 {
 	struct tmp117_data *data = iio_priv(indio_dev);
 	s32 ret;
@@ -51,7 +51,7 @@ static int tmp117_read_raw(struct iio_dev *indio_dev,
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
 		ret = i2c_smbus_read_word_swapped(data->client,
-						TMP117_REG_TEMP);
+						  TMP117_REG_TEMP);
 		if (ret < 0)
 			return ret;
 		*val = sign_extend32(ret, 15);
@@ -59,7 +59,7 @@ static int tmp117_read_raw(struct iio_dev *indio_dev,
 
 	case IIO_CHAN_INFO_CALIBBIAS:
 		ret = i2c_smbus_read_word_swapped(data->client,
-					TMP117_REG_TEMP_OFFSET);
+						  TMP117_REG_TEMP_OFFSET);
 		if (ret < 0)
 			return ret;
 		*val = sign_extend32(ret, 15);
@@ -81,9 +81,8 @@ static int tmp117_read_raw(struct iio_dev *indio_dev,
 	}
 }
 
-static int tmp117_write_raw(struct iio_dev *indio_dev,
-		struct iio_chan_spec const *channel, int val,
-		int val2, long mask)
+static int tmp117_write_raw(struct iio_dev *indio_dev, struct iio_chan_spec
+			    const *channel, int val, int val2, long mask)
 {
 	struct tmp117_data *data = iio_priv(indio_dev);
 	s16 off;
@@ -106,7 +105,9 @@ static const struct iio_chan_spec tmp117_channels[] = {
 	{
 		.type = IIO_TEMP,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
-			BIT(IIO_CHAN_INFO_CALIBBIAS) | BIT(IIO_CHAN_INFO_SCALE),
+				      BIT(IIO_CHAN_INFO_CALIBBIAS) |
+				      BIT(IIO_CHAN_INFO_SCALE),
+	},
 };
 
 static const struct iio_chan_spec tmp116_channels[] = {
-- 
2.30.2

