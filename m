Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 170A15BEC90
	for <lists+linux-iio@lfdr.de>; Tue, 20 Sep 2022 20:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbiITSKm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 20 Sep 2022 14:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbiITSKW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 20 Sep 2022 14:10:22 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58E560DA
        for <linux-iio@vger.kernel.org>; Tue, 20 Sep 2022 11:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1663697422;
  x=1695233422;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MPZKYp4oFaqBOcPZd2l2V6b6ugN9rSIgG2fetzPl/lM=;
  b=P4WXnD25UH9r7fooSteOMu6KJahmNfQd30jKyIQBvostuKE2uzPaQYLw
   22l40zFTJLEmCDQVEMi/LsJ8sN4V+2XQVM0qVv8fVjFvYydlcsoMxQ9+5
   LxKjbh2MKctKePWsIBbRgEAaxtasG9SplDSiYnCS51aZXk4ApogE3zJTc
   PoHdKOPX4YygQKMRg6Hw+WiJoFPEW5BlrhvW+OJyPqG2JJch9LaJ/VgVr
   LBHIG3tbfHxQlYomQMNbi73EPOtIBAB9ImTdDy6DjXi87DCrMS6eox4/8
   a35c7yo+xKsuAnBx32mVtFjwjQ5IY/3/FowcFVatdj1SxqkrYOhCd6eT7
   A==;
From:   =?UTF-8?q?M=C3=A5rten=20Lindahl?= <marten.lindahl@axis.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
CC:     Paul Cercueil <paul@crapouillou.net>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, <linux-iio@vger.kernel.org>,
        <kernel@axis.com>,
        =?UTF-8?q?M=C3=A5rten=20Lindahl?= <marten.lindahl@axis.com>
Subject: [PATCH 3/3] iio: light: vcnl4000: Add ps_it attributes for vcnl4040
Date:   Tue, 20 Sep 2022 20:09:58 +0200
Message-ID: <20220920180958.2308229-4-marten.lindahl@axis.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220920180958.2308229-1-marten.lindahl@axis.com>
References: <20220920180958.2308229-1-marten.lindahl@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add read/write attribute for proximity integration time, and a read
attribute for available integration times for the vcnl4040 chip.

Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
---
 drivers/iio/light/vcnl4000.c | 83 +++++++++++++++++++++++++++++++++++-
 1 file changed, 82 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index 9838f0868372..7a207e48335d 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -76,6 +76,8 @@
 
 #define VCNL4040_ALS_CONF_ALS_SD	BIT(0) /* Enable ambient light sensor */
 #define VCNL4040_PS_CONF1_PS_SD	BIT(0) /* Enable proximity sensor */
+#define VCNL4040_PS_CONF2_PS_IT \
+	(BIT(3) | BIT(2) | BIT(1)) /* Proximity integration time */
 
 /* Bit masks for interrupt registers. */
 #define VCNL4010_INT_THR_SEL	BIT(0) /* Select threshold interrupt source */
@@ -103,6 +105,16 @@ static const int vcnl4010_prox_sampling_frequency[][2] = {
 	{125, 0},
 	{250, 0},
 };
+static const int vcnl4040_ps_it_times[][2] = {
+	{0, 100},
+	{0, 150},
+	{0, 200},
+	{0, 250},
+	{0, 300},
+	{0, 350},
+	{0, 400},
+	{0, 800},
+};
 
 #define VCNL4000_SLEEP_DELAY_MS	2000 /* before we enter pm_runtime_suspend */
 
@@ -486,6 +498,49 @@ static int vcnl4000_set_pm_runtime_state(struct vcnl4000_data *data, bool on)
 	return ret;
 }
 
+static int vcnl4040_read_ps_it(struct vcnl4000_data *data, int *val, int *val2)
+{
+	int ret;
+
+	ret = i2c_smbus_read_word_data(data->client, VCNL4200_PS_CONF1);
+	if (ret < 0)
+		return ret;
+
+	ret = (ret & VCNL4040_PS_CONF2_PS_IT) >> 1;
+
+	if (ret >= ARRAY_SIZE(vcnl4040_ps_it_times))
+		return -EINVAL;
+
+	*val = vcnl4040_ps_it_times[ret][0];
+	*val2 = vcnl4040_ps_it_times[ret][1];
+
+	return 0;
+}
+
+static ssize_t vcnl4040_write_ps_it(struct vcnl4000_data *data, int val)
+{
+	unsigned int i;
+	int ret, index = -1;
+
+	for (i = 0; i < ARRAY_SIZE(vcnl4040_ps_it_times); i++) {
+		if (val == vcnl4040_ps_it_times[i][1]) {
+			index = i;
+			break;
+		}
+	}
+
+	if (index < 0)
+		return -EINVAL;
+
+	ret = i2c_smbus_read_word_data(data->client, VCNL4200_PS_CONF1);
+	if (ret < 0)
+		return ret;
+
+	ret = (ret & ~VCNL4040_PS_CONF2_PS_IT) | (index << 1);
+
+	return i2c_smbus_write_word_data(data->client, VCNL4200_PS_CONF1, ret);
+}
+
 static int vcnl4000_read_raw(struct iio_dev *indio_dev,
 				struct iio_chan_spec const *chan,
 				int *val, int *val2, long mask)
@@ -533,6 +588,13 @@ static int vcnl4000_read_raw(struct iio_dev *indio_dev,
 		default:
 			return -EINVAL;
 		}
+	case IIO_CHAN_INFO_INT_TIME:
+		if (chan->type != IIO_PROXIMITY)
+			return -EINVAL;
+		ret = vcnl4040_read_ps_it(data, val, val2);
+		if (ret < 0)
+			return ret;
+		return IIO_VAL_INT_PLUS_MICRO;
 	default:
 		return -EINVAL;
 	}
@@ -554,6 +616,12 @@ static int vcnl4040_write_raw(struct iio_dev *indio_dev,
 		default:
 			return -EINVAL;
 		}
+	case IIO_CHAN_INFO_INT_TIME:
+		if (val != 0)
+			return -EINVAL;
+		if (chan->type != IIO_PROXIMITY)
+			return -EINVAL;
+		return vcnl4040_write_ps_it(data, val2);
 	default:
 		return -EINVAL;
 	}
@@ -900,11 +968,23 @@ static const struct iio_chan_spec vcnl4040_channels[] = {
 	}, {
 		.type = IIO_PROXIMITY,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
-			BIT(IIO_CHAN_INFO_ENABLE),
+			BIT(IIO_CHAN_INFO_ENABLE) | BIT(IIO_CHAN_INFO_INT_TIME),
 		.ext_info = vcnl4000_ext_info,
 	}
 };
 
+static IIO_CONST_ATTR(in_proximity_integration_time_available,
+	"0.000100 0.000150 0.000200 0.000250 0.000300 0.000350 0.000400 0.000800");
+
+static struct attribute *vcnl4040_attributes[] = {
+	&iio_const_attr_in_proximity_integration_time_available.dev_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group vcnl4040_attribute_group = {
+	.attrs = vcnl4040_attributes,
+};
+
 static const struct iio_info vcnl4000_info = {
 	.read_raw = vcnl4000_read_raw,
 };
@@ -922,6 +1002,7 @@ static const struct iio_info vcnl4010_info = {
 static const struct iio_info vcnl4040_info = {
 	.read_raw = vcnl4000_read_raw,
 	.write_raw = vcnl4040_write_raw,
+	.attrs = &vcnl4040_attribute_group,
 };
 
 static const struct vcnl4000_chip_spec vcnl4000_chip_spec_cfg[] = {
-- 
2.30.2

