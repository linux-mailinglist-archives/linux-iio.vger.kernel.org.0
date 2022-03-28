Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3DEF4EA064
	for <lists+linux-iio@lfdr.de>; Mon, 28 Mar 2022 21:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344100AbiC1Tv0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 28 Mar 2022 15:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345661AbiC1TuF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 28 Mar 2022 15:50:05 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB2B010D9
        for <linux-iio@vger.kernel.org>; Mon, 28 Mar 2022 12:47:48 -0700 (PDT)
Received: from tr.lan (ip-89-176-112-137.net.upcbroadband.cz [89.176.112.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id D5F8783F8D;
        Mon, 28 Mar 2022 21:47:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1648496866;
        bh=owVMwrQ74rQ4ceNaU7cW6L7SJ0tId3IEdIz83QiA1nc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HouvAC0pG3O4nd6LmC1oOWdKrj0XPTEnJiL+H/hx5GtCZCp4l6Jy8+FquCXjM0wx2
         yCSllHIJiUDkrdMcT57xX5CBPy2PwhBJXRSQ0jHd0d4thcq3PblvdAmvMUbsCC/2P+
         F9/yoo4M6ohw6gc9y0Bbfz5My28o52TjCghr/1RidMJJ4gCMs30EBQa87g9eKrS+1i
         zlNjWZA9TxQTMf8Rir9XE3vUAl8a0wg41EKp8PWc0ycif3io55CvAxwu64trDCAHLe
         0eXlydWZTjMcTK39m85SqEvbFMPKAay4pXHRdRRW9Lr3p9kVM30iFVkWWaOLw2MM8Q
         JyJ8eJnhgO/yw==
From:   Marek Vasut <marex@denx.de>
To:     linux-iio@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>, Andy Shevchenko <andy@kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v5 10/10] iio: adc: ti-ads1015: Switch to read_avail
Date:   Mon, 28 Mar 2022 21:47:25 +0200
Message-Id: <20220328194725.149150-10-marex@denx.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220328194725.149150-1-marex@denx.de>
References: <20220328194725.149150-1-marex@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.5 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Replace sysfs attributes with read_avail() callback. This also permits
removal of ads1115_info, since the scale attribute tables are now part
of chip data.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Andy Shevchenko <andy@kernel.org>
Cc: Daniel Baluta <daniel.baluta@nxp.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
V3: New patch
V4: - Reformat ads1x15 scale ranges pairwise
    - Turn the scale ranges into unsigned int
V5: Switch scale to signed int
---
 drivers/iio/adc/ti-ads1015.c | 112 +++++++++++++++++++++--------------
 1 file changed, 67 insertions(+), 45 deletions(-)

diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
index 42ec4e5c2516e..5544da80b6369 100644
--- a/drivers/iio/adc/ti-ads1015.c
+++ b/drivers/iio/adc/ti-ads1015.c
@@ -81,6 +81,9 @@ struct ads1015_chip_data {
 	int				num_channels;
 	const struct iio_info		*info;
 	const int			*data_rate;
+	const int			data_rate_len;
+	const int			*scale;
+	const int			scale_len;
 	bool				has_comparator;
 };
 
@@ -108,10 +111,28 @@ static const int ads1115_data_rate[] = {
  * Translation from PGA bits to full-scale positive and negative input voltage
  * range in mV
  */
-static int ads1015_fullscale_range[] = {
+static const int ads1015_fullscale_range[] = {
 	6144, 4096, 2048, 1024, 512, 256, 256, 256
 };
 
+static const int ads1015_scale[] = {	/* 12bit ADC */
+	256, 11,
+	512, 11,
+	1024, 11,
+	2048, 11,
+	4096, 11,
+	6144, 11
+};
+
+static const int ads1115_scale[] = {	/* 16bit ADC */
+	256, 15,
+	512, 15,
+	1024, 15,
+	2048, 15,
+	4096, 15,
+	6144, 15
+};
+
 /*
  * Translation from COMP_QUE field value to the number of successive readings
  * exceed the threshold values before an interrupt is generated
@@ -166,6 +187,9 @@ static const struct iio_event_spec ads1015_events[] = {
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		\
 				BIT(IIO_CHAN_INFO_SCALE) |	\
 				BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
+	.info_mask_shared_by_all_available =			\
+				BIT(IIO_CHAN_INFO_SCALE) |	\
+				BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
 	.scan_index = _addr,					\
 	.scan_type = {						\
 		.sign = 's',					\
@@ -189,6 +213,9 @@ static const struct iio_event_spec ads1015_events[] = {
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		\
 				BIT(IIO_CHAN_INFO_SCALE) |	\
 				BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
+	.info_mask_shared_by_all_available =			\
+				BIT(IIO_CHAN_INFO_SCALE) |	\
+				BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
 	.scan_index = _addr,					\
 	.scan_type = {						\
 		.sign = 's',					\
@@ -470,7 +497,7 @@ static int ads1015_set_data_rate(struct ads1015_data *data, int chan, int rate)
 {
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(ads1015_data_rate); i++) {
+	for (i = 0; i < data->chip->data_rate_len; i++) {
 		if (data->chip->data_rate[i] == rate) {
 			data->channel_data[chan].data_rate = i;
 			return 0;
@@ -480,6 +507,32 @@ static int ads1015_set_data_rate(struct ads1015_data *data, int chan, int rate)
 	return -EINVAL;
 }
 
+static int ads1015_read_avail(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      const int **vals, int *type, int *length,
+			      long mask)
+{
+	struct ads1015_data *data = iio_priv(indio_dev);
+
+	if (chan->type != IIO_VOLTAGE)
+		return -EINVAL;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		*type = IIO_VAL_FRACTIONAL_LOG2;
+		*vals =  data->chip->scale;
+		*length = data->chip->scale_len;
+		return IIO_AVAIL_LIST;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*type = IIO_VAL_INT;
+		*vals = data->chip->data_rate;
+		*length = data->chip->data_rate_len;
+		return IIO_AVAIL_LIST;
+	default:
+		return -EINVAL;
+	}
+}
+
 static int ads1015_read_raw(struct iio_dev *indio_dev,
 			    struct iio_chan_spec const *chan, int *val,
 			    int *val2, long mask)
@@ -828,60 +881,20 @@ static const struct iio_buffer_setup_ops ads1015_buffer_setup_ops = {
 	.validate_scan_mask = &iio_validate_scan_mask_onehot,
 };
 
-static IIO_CONST_ATTR_NAMED(ads1015_scale_available, scale_available,
-	"3 2 1 0.5 0.25 0.125");
-static IIO_CONST_ATTR_NAMED(ads1115_scale_available, scale_available,
-	"0.1875 0.125 0.0625 0.03125 0.015625 0.007813");
-
-static IIO_CONST_ATTR_NAMED(ads1015_sampling_frequency_available,
-	sampling_frequency_available, "128 250 490 920 1600 2400 3300");
-static IIO_CONST_ATTR_NAMED(ads1115_sampling_frequency_available,
-	sampling_frequency_available, "8 16 32 64 128 250 475 860");
-
-static struct attribute *ads1015_attributes[] = {
-	&iio_const_attr_ads1015_scale_available.dev_attr.attr,
-	&iio_const_attr_ads1015_sampling_frequency_available.dev_attr.attr,
-	NULL,
-};
-
-static const struct attribute_group ads1015_attribute_group = {
-	.attrs = ads1015_attributes,
-};
-
-static struct attribute *ads1115_attributes[] = {
-	&iio_const_attr_ads1115_scale_available.dev_attr.attr,
-	&iio_const_attr_ads1115_sampling_frequency_available.dev_attr.attr,
-	NULL,
-};
-
-static const struct attribute_group ads1115_attribute_group = {
-	.attrs = ads1115_attributes,
-};
-
 static const struct iio_info ads1015_info = {
+	.read_avail	= ads1015_read_avail,
 	.read_raw	= ads1015_read_raw,
 	.write_raw	= ads1015_write_raw,
 	.read_event_value = ads1015_read_event,
 	.write_event_value = ads1015_write_event,
 	.read_event_config = ads1015_read_event_config,
 	.write_event_config = ads1015_write_event_config,
-	.attrs          = &ads1015_attribute_group,
-};
-
-static const struct iio_info ads1115_info = {
-	.read_raw	= ads1015_read_raw,
-	.write_raw	= ads1015_write_raw,
-	.read_event_value = ads1015_read_event,
-	.write_event_value = ads1015_write_event,
-	.read_event_config = ads1015_read_event_config,
-	.write_event_config = ads1015_write_event_config,
-	.attrs          = &ads1115_attribute_group,
 };
 
 static const struct iio_info tla2024_info = {
+	.read_avail	= ads1015_read_avail,
 	.read_raw	= ads1015_read_raw,
 	.write_raw	= ads1015_write_raw,
-	.attrs          = &ads1015_attribute_group,
 };
 
 static int ads1015_client_get_channels_config(struct i2c_client *client)
@@ -1128,14 +1141,20 @@ static const struct ads1015_chip_data ads1015_data = {
 	.num_channels	= ARRAY_SIZE(ads1015_channels),
 	.info		= &ads1015_info,
 	.data_rate	= ads1015_data_rate,
+	.data_rate_len	= ARRAY_SIZE(ads1015_data_rate),
+	.scale		= ads1015_scale,
+	.scale_len	= ARRAY_SIZE(ads1015_scale),
 	.has_comparator	= true,
 };
 
 static const struct ads1015_chip_data ads1115_data = {
 	.channels	= ads1115_channels,
 	.num_channels	= ARRAY_SIZE(ads1115_channels),
-	.info		= &ads1115_info,
+	.info		= &ads1015_info,
 	.data_rate	= ads1115_data_rate,
+	.data_rate_len	= ARRAY_SIZE(ads1115_data_rate),
+	.scale		= ads1115_scale,
+	.scale_len	= ARRAY_SIZE(ads1115_scale),
 	.has_comparator	= true,
 };
 
@@ -1144,6 +1163,9 @@ static const struct ads1015_chip_data tla2024_data = {
 	.num_channels	= ARRAY_SIZE(tla2024_channels),
 	.info		= &tla2024_info,
 	.data_rate	= ads1015_data_rate,
+	.data_rate_len	= ARRAY_SIZE(ads1015_data_rate),
+	.scale		= ads1015_scale,
+	.scale_len	= ARRAY_SIZE(ads1015_scale),
 	.has_comparator	= false,
 };
 
-- 
2.35.1

