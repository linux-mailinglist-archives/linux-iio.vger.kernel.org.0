Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8136A5517
	for <lists+linux-iio@lfdr.de>; Tue, 28 Feb 2023 10:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbjB1JFe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Feb 2023 04:05:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbjB1JFd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Feb 2023 04:05:33 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE6D15CBE
        for <linux-iio@vger.kernel.org>; Tue, 28 Feb 2023 01:05:31 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1pWvvF-0002sF-Lp; Tue, 28 Feb 2023 10:05:21 +0100
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <mfe@pengutronix.de>)
        id 1pWvvE-000poR-Ro; Tue, 28 Feb 2023 10:05:20 +0100
Received: from mfe by dude02.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <mfe@pengutronix.de>)
        id 1pWvvD-002DrU-Gs; Tue, 28 Feb 2023 10:05:19 +0100
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     puranjay12@gmail.com, jic23@kernel.org, lars@metafoo.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH v6 5/5] iio: temperature: tmp117: cosmetic alignment cleanup
Date:   Tue, 28 Feb 2023 10:05:18 +0100
Message-Id: <20230228090518.529811-6-m.felsch@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230228090518.529811-1-m.felsch@pengutronix.de>
References: <20230228090518.529811-1-m.felsch@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Align the code correctly if possible and align the channel bit mask to
make it easier to read.

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
v6:
- no changes
v5:
- no changes
v4:
- no changes
v3:
- no changes
v2:
- no changes

 drivers/iio/temperature/tmp117.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/temperature/tmp117.c b/drivers/iio/temperature/tmp117.c
index 9bfb818c3bf1d..638e3a5bd6b84 100644
--- a/drivers/iio/temperature/tmp117.c
+++ b/drivers/iio/temperature/tmp117.c
@@ -43,8 +43,8 @@ struct tmp117_data {
 };
 
 static int tmp117_read_raw(struct iio_dev *indio_dev,
-		struct iio_chan_spec const *channel, int *val,
-		int *val2, long mask)
+			   struct iio_chan_spec const *channel, int *val,
+			   int *val2, long mask)
 {
 	struct tmp117_data *data = iio_priv(indio_dev);
 	s32 ret;
@@ -52,7 +52,7 @@ static int tmp117_read_raw(struct iio_dev *indio_dev,
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
 		ret = i2c_smbus_read_word_swapped(data->client,
-						TMP117_REG_TEMP);
+						  TMP117_REG_TEMP);
 		if (ret < 0)
 			return ret;
 		*val = sign_extend32(ret, 15);
@@ -60,7 +60,7 @@ static int tmp117_read_raw(struct iio_dev *indio_dev,
 
 	case IIO_CHAN_INFO_CALIBBIAS:
 		ret = i2c_smbus_read_word_swapped(data->client,
-					TMP117_REG_TEMP_OFFSET);
+						  TMP117_REG_TEMP_OFFSET);
 		if (ret < 0)
 			return ret;
 		*val = sign_extend32(ret, 15);
@@ -82,9 +82,8 @@ static int tmp117_read_raw(struct iio_dev *indio_dev,
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
@@ -107,7 +106,8 @@ static const struct iio_chan_spec tmp117_channels[] = {
 	{
 		.type = IIO_TEMP,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
-			BIT(IIO_CHAN_INFO_CALIBBIAS) | BIT(IIO_CHAN_INFO_SCALE),
+				      BIT(IIO_CHAN_INFO_CALIBBIAS) |
+				      BIT(IIO_CHAN_INFO_SCALE),
 	},
 };
 
-- 
2.30.2

