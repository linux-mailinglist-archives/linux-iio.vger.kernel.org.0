Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7D65E9D66
	for <lists+linux-iio@lfdr.de>; Mon, 26 Sep 2022 11:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233846AbiIZJWf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 26 Sep 2022 05:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234454AbiIZJWK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 26 Sep 2022 05:22:10 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B883C46DBB
        for <linux-iio@vger.kernel.org>; Mon, 26 Sep 2022 02:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1664183965;
  x=1695719965;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cws6SB0x/KL8ap8FKiA2yFK4uqwctXTUTQ296kNP0P8=;
  b=UcE0gxtOpZJW8fb8MNlZ/pXstMLKUwZtLwOC9TtIyhTlGnM54m9ku2vp
   grNiXb/tjd+fS5Y8+jPwPbP9NfSMyj+JBN+Hz7Gio00i7egEP74rHhB81
   ko7RfW/TCSujPlFAbAvrAO7EKfjIOBtti5KqF39dhy1Xfta5n2uY63WVy
   Xx3dRY/Th0hlbm1NoO/GvK23O2K82acO2rE4piyQ8t1f9eDrnMpu/1J+J
   2+03O++p3eBKiNS3izPXxuW9ucBNePDp3CVSOQuO1GdokJZjqWyr68Ovk
   CcYGLy3p8f9ordhAjKGLfQaw3ElbQVKMVkv9NR3DLhDP7lifgLqzOEo7C
   Q==;
From:   =?UTF-8?q?M=C3=A5rten=20Lindahl?= <marten.lindahl@axis.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
CC:     Paul Cercueil <paul@crapouillou.net>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, <linux-iio@vger.kernel.org>,
        <kernel@axis.com>,
        =?UTF-8?q?M=C3=A5rten=20Lindahl?= <marten.lindahl@axis.com>
Subject: [PATCH v3 2/2] iio: light: vcnl4000: Add ps_it attributes for vcnl4040
Date:   Mon, 26 Sep 2022 11:19:00 +0200
Message-ID: <20220926091900.1724105-3-marten.lindahl@axis.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220926091900.1724105-1-marten.lindahl@axis.com>
References: <20220926091900.1724105-1-marten.lindahl@axis.com>
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

Add read/write attribute for proximity integration time, and read
attribute for available proximity integration times for the vcnl4040
chip.

Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
---
 drivers/iio/light/vcnl4000.c | 131 ++++++++++++++++++++++++++++++++++-
 1 file changed, 128 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index 208539ad50c2..2a76b19d1cd4 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -17,6 +17,7 @@
  *   interrupts (VCNL4040, VCNL4200)
  */
 
+#include <linux/bitfield.h>
 #include <linux/module.h>
 #include <linux/i2c.h>
 #include <linux/err.h>
@@ -76,6 +77,7 @@
 
 #define VCNL4040_ALS_CONF_ALS_SHUTDOWN	BIT(0)
 #define VCNL4040_PS_CONF1_PS_SHUTDOWN	BIT(0)
+#define VCNL4040_PS_CONF2_PS_IT	GENMASK(3, 1) /* Proximity integration time */
 
 /* Bit masks for interrupt registers. */
 #define VCNL4010_INT_THR_SEL	BIT(0) /* Select threshold interrupt source */
@@ -104,6 +106,17 @@ static const int vcnl4010_prox_sampling_frequency[][2] = {
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
+
 #define VCNL4000_SLEEP_DELAY_MS	2000 /* before we enter pm_runtime_suspend */
 
 enum vcnl4000_device_ids {
@@ -470,6 +483,57 @@ static int vcnl4000_set_pm_runtime_state(struct vcnl4000_data *data, bool on)
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
+	ret = FIELD_GET(VCNL4040_PS_CONF2_PS_IT, ret);
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
+	u16 regval;
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
+	mutex_lock(&data->vcnl4000_lock);
+
+	ret = i2c_smbus_read_word_data(data->client, VCNL4200_PS_CONF1);
+	if (ret < 0)
+		goto out;
+
+	regval = (ret & ~VCNL4040_PS_CONF2_PS_IT) |
+	    FIELD_PREP(VCNL4040_PS_CONF2_PS_IT, index);
+	ret = i2c_smbus_write_word_data(data->client, VCNL4200_PS_CONF1,
+					regval);
+
+out:
+	mutex_unlock(&data->vcnl4000_lock);
+	return ret;
+}
+
 static int vcnl4000_read_raw(struct iio_dev *indio_dev,
 				struct iio_chan_spec const *chan,
 				int *val, int *val2, long mask)
@@ -506,6 +570,47 @@ static int vcnl4000_read_raw(struct iio_dev *indio_dev,
 		*val = 0;
 		*val2 = data->al_scale;
 		return IIO_VAL_INT_PLUS_MICRO;
+	case IIO_CHAN_INFO_INT_TIME:
+		if (chan->type != IIO_PROXIMITY)
+			return -EINVAL;
+		ret = vcnl4040_read_ps_it(data, val, val2);
+		if (ret < 0)
+			return ret;
+		return IIO_VAL_INT_PLUS_MICRO;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int vcnl4040_write_raw(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      int val, int val2, long mask)
+{
+	struct vcnl4000_data *data = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_INT_TIME:
+		if (val != 0)
+			return -EINVAL;
+		if (chan->type != IIO_PROXIMITY)
+			return -EINVAL;
+		return vcnl4040_write_ps_it(data, val2);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int vcnl4040_read_avail(struct iio_dev *indio_dev,
+			       struct iio_chan_spec const *chan,
+			       const int **vals, int *type, int *length,
+			       long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_INT_TIME:
+		*vals = (int *)vcnl4040_ps_it_times;
+		*type = IIO_VAL_INT_PLUS_MICRO;
+		*length = 2 * ARRAY_SIZE(vcnl4040_ps_it_times);
+		return IIO_AVAIL_LIST;
 	default:
 		return -EINVAL;
 	}
@@ -844,6 +949,20 @@ static const struct iio_chan_spec vcnl4010_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(1),
 };
 
+static const struct iio_chan_spec vcnl4040_channels[] = {
+	{
+		.type = IIO_LIGHT,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+			BIT(IIO_CHAN_INFO_SCALE),
+	}, {
+		.type = IIO_PROXIMITY,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+			BIT(IIO_CHAN_INFO_INT_TIME),
+		.info_mask_separate_available = BIT(IIO_CHAN_INFO_INT_TIME),
+		.ext_info = vcnl4000_ext_info,
+	}
+};
+
 static const struct iio_info vcnl4000_info = {
 	.read_raw = vcnl4000_read_raw,
 };
@@ -858,6 +977,12 @@ static const struct iio_info vcnl4010_info = {
 	.write_event_config = vcnl4010_write_event_config,
 };
 
+static const struct iio_info vcnl4040_info = {
+	.read_raw = vcnl4000_read_raw,
+	.write_raw = vcnl4040_write_raw,
+	.read_avail = vcnl4040_read_avail,
+};
+
 static const struct vcnl4000_chip_spec vcnl4000_chip_spec_cfg[] = {
 	[VCNL4000] = {
 		.prod = "VCNL4000",
@@ -887,9 +1012,9 @@ static const struct vcnl4000_chip_spec vcnl4000_chip_spec_cfg[] = {
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

