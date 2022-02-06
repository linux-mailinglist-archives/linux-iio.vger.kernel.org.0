Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A05954AB179
	for <lists+linux-iio@lfdr.de>; Sun,  6 Feb 2022 19:57:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245631AbiBFS5f (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 6 Feb 2022 13:57:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244837AbiBFS5e (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 6 Feb 2022 13:57:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F72C043187
        for <linux-iio@vger.kernel.org>; Sun,  6 Feb 2022 10:57:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EE61EB80D88
        for <linux-iio@vger.kernel.org>; Sun,  6 Feb 2022 18:57:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B27CC340EF;
        Sun,  6 Feb 2022 18:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644173849;
        bh=ckWS8DShBGzT5pBQkAwA7fcZ1CjoWP4789mHASHkJI0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s+rI66hmnwmUjispnAiMooPApTO2m6A7BHXYpFnHBpkb0Ka0ri7izlvrkGn9cg5nc
         L8T3xxTzAskC/0tAlMeJ0TZREFUc9Mpz38xTyQlf85wlRoLUZuVeSnPeaIDex2A8dc
         yuZeE5BiedJk6w5ZIHWXaZOvFAMIZ7oIZ+Tt0hMyLjEryBnXMYvN3t2TTLkwoYrjwA
         oVHgL019D6axArfVBablMX+U/4E/8D+1v72J0GjAjbu5DjDSTXbCSPYsF888WbnJmV
         mJdtnMCr2KWt6N/eiTnZ5/37lYjw5Efy9nmESNuGMiX/lTOJ+UkYLytSIgskHKP11k
         rFKxRY/lOCFmQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org,
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc:     Hennerich@vger.kernel.org, Michael <Michael.Hennerich@analog.com>,
        Nuno Sa <Nuno.Sa@analog.com>, lars@metafoo.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 06/20] staging:iio:adc:ad7280a: Switch to standard event control
Date:   Sun,  6 Feb 2022 19:03:14 +0000
Message-Id: <20220206190328.333093-7-jic23@kernel.org>
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

This driver had a slightly non standard events ABI but there seems
to be no reason for not doing it with the core support for rising and
falling events on the two types of channels.

In theory the events on different daisy chained chips could be at
different levels, but the driver has never supported this and it doesn't
seem likely to be used so let us ignore that option.

Includes reordering so that we only set the software cached value
of the thresholds if the hardware write succeeds.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
---
 drivers/staging/iio/adc/ad7280a.c | 213 +++++++++++++++---------------
 1 file changed, 110 insertions(+), 103 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
index 0db7ac02589b..34b0f826ebee 100644
--- a/drivers/staging/iio/adc/ad7280a.c
+++ b/drivers/staging/iio/adc/ad7280a.c
@@ -551,18 +551,34 @@ static const struct attribute_group ad7280_attrs_group = {
 	.attrs = ad7280_attributes,
 };
 
+static const struct iio_event_spec ad7280_events[] = {
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE),
+	}, {
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_FALLING,
+		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE),
+	},
+};
+
 static void ad7280_voltage_channel_init(struct iio_chan_spec *chan, int i)
 {
 	chan->type = IIO_VOLTAGE;
 	chan->differential = 1;
 	chan->channel = i;
 	chan->channel2 = chan->channel + 1;
+	chan->event_spec = ad7280_events;
+	chan->num_event_specs = ARRAY_SIZE(ad7280_events);
 }
 
 static void ad7280_temp_channel_init(struct iio_chan_spec *chan, int i)
 {
 	chan->type = IIO_TEMP;
 	chan->channel = i;
+	chan->event_spec = ad7280_events;
+	chan->num_event_specs = ARRAY_SIZE(ad7280_events);
 }
 
 static void ad7280_common_fields_init(struct iio_chan_spec *chan, int addr,
@@ -732,88 +748,120 @@ static int ad7280_attr_init(struct ad7280_state *st)
 	return 0;
 }
 
-static ssize_t ad7280_read_channel_config(struct device *dev,
-					  struct device_attribute *attr,
-					  char *buf)
+static int ad7280a_read_thresh(struct iio_dev *indio_dev,
+			       const struct iio_chan_spec *chan,
+			       enum iio_event_type type,
+			       enum iio_event_direction dir,
+			       enum iio_event_info info, int *val, int *val2)
 {
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ad7280_state *st = iio_priv(indio_dev);
-	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
-	unsigned int val;
 
-	switch (this_attr->address) {
-	case AD7280A_CELL_OVERVOLTAGE_REG:
-		val = 1000 + (st->cell_threshhigh * 1568) / 100;
-		break;
-	case AD7280A_CELL_UNDERVOLTAGE_REG:
-		val = 1000 + (st->cell_threshlow * 1568) / 100;
-		break;
-	case AD7280A_AUX_ADC_OVERVOLTAGE_REG:
-		val = (st->aux_threshhigh * 196) / 10;
+	switch (chan->type) {
+	case IIO_VOLTAGE:
+		switch (dir) {
+		case IIO_EV_DIR_RISING:
+			*val = 1000 + (st->cell_threshhigh * 1568L) / 100;
+			return IIO_VAL_INT;
+		case IIO_EV_DIR_FALLING:
+			*val = 1000 + (st->cell_threshlow * 1568L) / 100;
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
 		break;
-	case AD7280A_AUX_ADC_UNDERVOLTAGE_REG:
-		val = (st->aux_threshlow * 196) / 10;
+	case IIO_TEMP:
+		switch (dir) {
+		case IIO_EV_DIR_RISING:
+			*val = ((st->aux_threshhigh) * 196L) / 10;
+			return IIO_VAL_INT;
+		case IIO_EV_DIR_FALLING:
+			*val = (st->aux_threshlow * 196L) / 10;
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
 		break;
 	default:
 		return -EINVAL;
 	}
-
-	return sprintf(buf, "%u\n", val);
 }
 
-static ssize_t ad7280_write_channel_config(struct device *dev,
-					   struct device_attribute *attr,
-					   const char *buf,
-					   size_t len)
+static int ad7280a_write_thresh(struct iio_dev *indio_dev,
+				const struct iio_chan_spec *chan,
+				enum iio_event_type type,
+				enum iio_event_direction dir,
+				enum iio_event_info info,
+				int val, int val2)
 {
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ad7280_state *st = iio_priv(indio_dev);
-	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
-
-	long val;
+	unsigned int addr;
+	long value;
 	int ret;
 
-	ret = kstrtol(buf, 10, &val);
-	if (ret)
-		return ret;
-
-	switch (this_attr->address) {
-	case AD7280A_CELL_OVERVOLTAGE_REG:
-	case AD7280A_CELL_UNDERVOLTAGE_REG:
-		val = ((val - 1000) * 100) / 1568; /* LSB 15.68mV */
-		break;
-	case AD7280A_AUX_ADC_OVERVOLTAGE_REG:
-	case AD7280A_AUX_ADC_UNDERVOLTAGE_REG:
-		val = (val * 10) / 196; /* LSB 19.6mV */
-		break;
-	default:
-		return -EFAULT;
-	}
-
-	val = clamp(val, 0L, 0xFFL);
+	if (val2 != 0)
+		return -EINVAL;
 
 	mutex_lock(&st->lock);
-	switch (this_attr->address) {
-	case AD7280A_CELL_OVERVOLTAGE_REG:
-		st->cell_threshhigh = val;
-		break;
-	case AD7280A_CELL_UNDERVOLTAGE_REG:
-		st->cell_threshlow = val;
-		break;
-	case AD7280A_AUX_ADC_OVERVOLTAGE_REG:
-		st->aux_threshhigh = val;
+	switch (chan->type) {
+	case IIO_VOLTAGE:
+		value = ((val - 1000) * 100) / 1568; /* LSB 15.68mV */
+		value = clamp(value, 0L, 0xFFL);
+		switch (dir) {
+		case IIO_EV_DIR_RISING:
+			addr = AD7280A_CELL_OVERVOLTAGE_REG;
+			ret = ad7280_write(st, AD7280A_DEVADDR_MASTER, addr,
+					   1, val);
+			if (ret)
+				break;
+			st->cell_threshhigh = value;
+			break;
+		case IIO_EV_DIR_FALLING:
+			addr = AD7280A_CELL_UNDERVOLTAGE_REG;
+			ret = ad7280_write(st, AD7280A_DEVADDR_MASTER, addr,
+					   1, val);
+			if (ret)
+				break;
+			st->cell_threshlow = value;
+			break;
+		default:
+			ret = -EINVAL;
+			goto err_unlock;
+		}
 		break;
-	case AD7280A_AUX_ADC_UNDERVOLTAGE_REG:
-		st->aux_threshlow = val;
+	case IIO_TEMP:
+		value = (val * 10) / 196; /* LSB 19.6mV */
+		value = clamp(value, 0L, 0xFFL);
+		switch (dir) {
+		case IIO_EV_DIR_RISING:
+			addr = AD7280A_AUX_ADC_OVERVOLTAGE_REG;
+			ret = ad7280_write(st, AD7280A_DEVADDR_MASTER, addr,
+					   1, val);
+			if (ret)
+				break;
+			st->aux_threshhigh = val;
+			break;
+		case IIO_EV_DIR_FALLING:
+			addr = AD7280A_AUX_ADC_UNDERVOLTAGE_REG;
+			ret = ad7280_write(st, AD7280A_DEVADDR_MASTER, addr,
+					   1, val);
+			if (ret)
+				break;
+			st->aux_threshlow = val;
+			break;
+		default:
+			ret = -EINVAL;
+			goto err_unlock;
+		}
 		break;
+	default:
+		ret = -EINVAL;
+		goto err_unlock;
 	}
 
-	ret = ad7280_write(st, AD7280A_DEVADDR_MASTER,
-			   this_attr->address, 1, val);
-
+err_unlock:
 	mutex_unlock(&st->lock);
 
-	return ret ? ret : len;
+	return ret;
 }
 
 static irqreturn_t ad7280_event_handler(int irq, void *private)
@@ -875,48 +923,6 @@ static irqreturn_t ad7280_event_handler(int irq, void *private)
 	return IRQ_HANDLED;
 }
 
-/* Note: No need to fix checkpatch warning that reads:
- *	CHECK: spaces preferred around that '-' (ctx:VxV)
- * The function argument is stringified and doesn't need a fix
- */
-static IIO_DEVICE_ATTR_NAMED(in_thresh_low_value,
-			     in_voltage-voltage_thresh_low_value,
-			     0644,
-			     ad7280_read_channel_config,
-			     ad7280_write_channel_config,
-			     AD7280A_CELL_UNDERVOLTAGE_REG);
-
-static IIO_DEVICE_ATTR_NAMED(in_thresh_high_value,
-			     in_voltage-voltage_thresh_high_value,
-			     0644,
-			     ad7280_read_channel_config,
-			     ad7280_write_channel_config,
-			     AD7280A_CELL_OVERVOLTAGE_REG);
-
-static IIO_DEVICE_ATTR(in_temp_thresh_low_value,
-		       0644,
-		       ad7280_read_channel_config,
-		       ad7280_write_channel_config,
-		       AD7280A_AUX_ADC_UNDERVOLTAGE_REG);
-
-static IIO_DEVICE_ATTR(in_temp_thresh_high_value,
-		       0644,
-		       ad7280_read_channel_config,
-		       ad7280_write_channel_config,
-		       AD7280A_AUX_ADC_OVERVOLTAGE_REG);
-
-static struct attribute *ad7280_event_attributes[] = {
-	&iio_dev_attr_in_thresh_low_value.dev_attr.attr,
-	&iio_dev_attr_in_thresh_high_value.dev_attr.attr,
-	&iio_dev_attr_in_temp_thresh_low_value.dev_attr.attr,
-	&iio_dev_attr_in_temp_thresh_high_value.dev_attr.attr,
-	NULL,
-};
-
-static const struct attribute_group ad7280_event_attrs_group = {
-	.attrs = ad7280_event_attributes,
-};
-
 static int ad7280_read_raw(struct iio_dev *indio_dev,
 			   struct iio_chan_spec const *chan,
 			   int *val,
@@ -956,7 +962,8 @@ static int ad7280_read_raw(struct iio_dev *indio_dev,
 
 static const struct iio_info ad7280_info = {
 	.read_raw = ad7280_read_raw,
-	.event_attrs = &ad7280_event_attrs_group,
+	.read_event_value = &ad7280a_read_thresh,
+	.write_event_value = &ad7280a_write_thresh,
 	.attrs = &ad7280_attrs_group,
 };
 
-- 
2.35.1

