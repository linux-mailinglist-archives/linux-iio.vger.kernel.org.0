Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 808545BEC8F
	for <lists+linux-iio@lfdr.de>; Tue, 20 Sep 2022 20:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbiITSKk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 20 Sep 2022 14:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiITSKV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 20 Sep 2022 14:10:21 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 853F0422E7
        for <linux-iio@vger.kernel.org>; Tue, 20 Sep 2022 11:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1663697420;
  x=1695233420;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=V2nmEVWWBX6ggS8jvk8qBrVYXZNyxTiJ2sdeiKELeDg=;
  b=e88I1dhCTwdcNKivNSQUaj2slUw538UGSS46tMQBkStfsFdCNgJJpyEj
   Zny7cfZ7yHZEXVOtvX+dvNKH3G+XVygtE1sVi1VOD3TMhTItD8POTPDfv
   x67Hmw5Q1CYmk8/PxUPElpLfxoVjA3yZ9yj79Dqp9RNrz+UQp+a08KcAN
   VK4KHQhIOEKU1XVmjMjDbcmIYuHUPy4Ccg7lfQZ9ozW6EIfgn6hRyqO0h
   z+l0b8ybWNg6/nrvCLf97r0K/amc+uWjHgfLGu2U1HlQehdEbmRVtsljk
   XQepOdr2u3oxPOFo2HvuQ5AHmaBsppAd6ak72QYzlWAkQ4aIQtmUuXACF
   w==;
From:   =?UTF-8?q?M=C3=A5rten=20Lindahl?= <marten.lindahl@axis.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
CC:     Paul Cercueil <paul@crapouillou.net>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, <linux-iio@vger.kernel.org>,
        <kernel@axis.com>,
        =?UTF-8?q?M=C3=A5rten=20Lindahl?= <marten.lindahl@axis.com>
Subject: [PATCH 2/3] iio: light: vcnl4000: Add enable attributes for vcnl4040
Date:   Tue, 20 Sep 2022 20:09:57 +0200
Message-ID: <20220920180958.2308229-3-marten.lindahl@axis.com>
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

Add channel attribute in_illuminance_en and in_proximity_en with
read/write access for vcnl4040. If automatic runtime power management is
turned off (power/control = on), both sensors can be kept on or off by
userspace.

Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
---
 drivers/iio/light/vcnl4000.c | 79 ++++++++++++++++++++++++++++++++----
 1 file changed, 72 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index 0b226c684957..9838f0868372 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -125,6 +125,9 @@ struct vcnl4000_data {
 	enum vcnl4000_device_ids id;
 	int rev;
 	int al_scale;
+	bool als_enable;
+	bool ps_enable;
+
 	const struct vcnl4000_chip_spec *chip_spec;
 	struct mutex vcnl4000_lock;
 	struct vcnl4200_channel vcnl4200_al;
@@ -202,10 +205,13 @@ static ssize_t vcnl4000_write_als_enable(struct vcnl4000_data *data, int val)
 		if (ret < 0)
 			return ret;
 
-		if (val)
+		if (val) {
 			ret &= ~VCNL4040_ALS_CONF_ALS_SD;
-		else
+			data->als_enable = true;
+		} else {
 			ret |= VCNL4040_ALS_CONF_ALS_SD;
+			data->als_enable = false;
+		}
 
 		return i2c_smbus_write_word_data(data->client, VCNL4200_AL_CONF,
 						 ret);
@@ -225,10 +231,13 @@ static ssize_t vcnl4000_write_ps_enable(struct vcnl4000_data *data, int val)
 		if (ret < 0)
 			return ret;
 
-		if (val)
+		if (val) {
 			ret &= ~VCNL4040_PS_CONF1_PS_SD;
-		else
+			data->ps_enable = true;
+		} else {
 			ret |= VCNL4040_PS_CONF1_PS_SD;
+			data->ps_enable = false;
+		}
 
 		return i2c_smbus_write_word_data(data->client,
 						 VCNL4200_PS_CONF1, ret);
@@ -283,6 +292,8 @@ static int vcnl4200_init(struct vcnl4000_data *data)
 	dev_dbg(&data->client->dev, "device id 0x%x", id);
 
 	data->rev = (ret >> 8) & 0xf;
+	data->als_enable = false;
+	data->ps_enable = false;
 
 	data->vcnl4200_al.reg = VCNL4200_AL_DATA;
 	data->vcnl4200_ps.reg = VCNL4200_PS_DATA;
@@ -459,8 +470,12 @@ static bool vcnl4010_is_in_periodic_mode(struct vcnl4000_data *data)
 static int vcnl4000_set_pm_runtime_state(struct vcnl4000_data *data, bool on)
 {
 	struct device *dev = &data->client->dev;
+	struct iio_dev *indio_dev = i2c_get_clientdata(data->client);
 	int ret;
 
+	if (!indio_dev->dev.power.runtime_auto)
+		return 0;
+
 	if (on) {
 		ret = pm_runtime_resume_and_get(dev);
 	} else {
@@ -507,6 +522,38 @@ static int vcnl4000_read_raw(struct iio_dev *indio_dev,
 		*val = 0;
 		*val2 = data->al_scale;
 		return IIO_VAL_INT_PLUS_MICRO;
+	case IIO_CHAN_INFO_ENABLE:
+		switch (chan->type) {
+		case IIO_LIGHT:
+			*val = data->als_enable;
+			return IIO_VAL_INT;
+		case IIO_PROXIMITY:
+			*val = data->ps_enable;
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
+	default:
+		return -EINVAL;
+	}
+}
+
+static int vcnl4040_write_raw(struct iio_dev *indio_dev,
+				struct iio_chan_spec const *chan,
+				int val, int val2, long mask)
+{
+	struct vcnl4000_data *data = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_ENABLE:
+		switch (chan->type) {
+		case IIO_LIGHT:
+			return vcnl4000_write_als_enable(data, val);
+		case IIO_PROXIMITY:
+			return vcnl4000_write_ps_enable(data, val);
+		default:
+			return -EINVAL;
+		}
 	default:
 		return -EINVAL;
 	}
@@ -845,6 +892,19 @@ static const struct iio_chan_spec vcnl4010_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(1),
 };
 
+static const struct iio_chan_spec vcnl4040_channels[] = {
+	{
+		.type = IIO_LIGHT,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+			BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_ENABLE),
+	}, {
+		.type = IIO_PROXIMITY,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+			BIT(IIO_CHAN_INFO_ENABLE),
+		.ext_info = vcnl4000_ext_info,
+	}
+};
+
 static const struct iio_info vcnl4000_info = {
 	.read_raw = vcnl4000_read_raw,
 };
@@ -859,6 +919,11 @@ static const struct iio_info vcnl4010_info = {
 	.write_event_config = vcnl4010_write_event_config,
 };
 
+static const struct iio_info vcnl4040_info = {
+	.read_raw = vcnl4000_read_raw,
+	.write_raw = vcnl4040_write_raw,
+};
+
 static const struct vcnl4000_chip_spec vcnl4000_chip_spec_cfg[] = {
 	[VCNL4000] = {
 		.prod = "VCNL4000",
@@ -888,9 +953,9 @@ static const struct vcnl4000_chip_spec vcnl4000_chip_spec_cfg[] = {
 		.measure_light = vcnl4200_measure_light,
 		.measure_proximity = vcnl4200_measure_proximity,
 		.set_power_state = vcnl4200_set_power_state,
-		.channels = vcnl4000_channels,
-		.num_channels = ARRAY_SIZE(vcnl4000_channels),
-		.info = &vcnl4000_info,
+		.channels = vcnl4040_channels,
+		.num_channels = ARRAY_SIZE(vcnl4040_channels),
+		.info = &vcnl4040_info,
 		.irq_support = false,
 	},
 	[VCNL4200] = {
-- 
2.30.2

