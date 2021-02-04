Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A324630EF4D
	for <lists+linux-iio@lfdr.de>; Thu,  4 Feb 2021 10:12:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234875AbhBDJKn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 4 Feb 2021 04:10:43 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:2590 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235040AbhBDJIu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 4 Feb 2021 04:08:50 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11496kRq023276;
        Thu, 4 Feb 2021 04:08:07 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 36dbud5gw1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Feb 2021 04:08:07 -0500
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 114985Tq044090
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 4 Feb 2021 04:08:05 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2; Thu, 4 Feb 2021
 04:08:04 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.721.2 via Frontend Transport;
 Thu, 4 Feb 2021 04:08:04 -0500
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 114982l4001727;
        Thu, 4 Feb 2021 04:08:03 -0500
From:   <alexandru.tachici@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <jic23@kernel.org>, <robh+dt@kernel.org>
Subject: [PATCH 1/2] iio: adc: ad7124: allow 16 channels
Date:   Thu, 4 Feb 2021 11:10:44 +0200
Message-ID: <20210204091045.4175-2-alexandru.tachici@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210204091045.4175-1-alexandru.tachici@analog.com>
References: <20210204091045.4175-1-alexandru.tachici@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-04_05:2021-02-04,2021-02-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 clxscore=1015 suspectscore=0 malwarescore=0 mlxscore=0
 priorityscore=1501 bulkscore=0 mlxlogscore=999 spamscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102040057
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Alexandru Tachici <alexandru.tachici@analog.com>

AD7124-8 can have up to 16 pseudo-differential channels
enabled simultaneously and only 8 configurations. In this
scenario we cannot assign one configuration per channel,
some channels will have to share configurations like, ODR,
gain and filter parameters.

This patch allows the user to specify channels and configurations
separately in device-tree and assign, if needed, the same
configuration to multiple channels.

Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
---
 drivers/iio/adc/ad7124.c | 196 ++++++++++++++++++++++++---------------
 1 file changed, 122 insertions(+), 74 deletions(-)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index 766c73333604..358e55e6dc1d 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -86,6 +86,12 @@
 #define AD7124_SINC3_FILTER 2
 #define AD7124_SINC4_FILTER 0
 
+#define AD7124_CONF_ADDR_OFFSET	20
+#define AD7124_MAX_CONFIGS	8
+#define AD7124_MAX_CHANNELS	16
+
+#define AD7124_REG_NO 57
+
 enum ad7124_ids {
 	ID_AD7124_4,
 	ID_AD7124_8,
@@ -136,21 +142,29 @@ struct ad7124_chip_info {
 };
 
 struct ad7124_channel_config {
+	bool enable;
+	unsigned int nr;
 	enum ad7124_ref_sel refsel;
 	bool bipolar;
 	bool buf_positive;
 	bool buf_negative;
-	unsigned int ain;
 	unsigned int vref_mv;
 	unsigned int pga_bits;
 	unsigned int odr;
 	unsigned int filter_type;
 };
 
+struct ad7124_channel {
+	struct ad7124_channel_config *cfg;
+	unsigned int ain;
+	unsigned int slot;
+};
+
 struct ad7124_state {
 	const struct ad7124_chip_info *chip_info;
 	struct ad_sigma_delta sd;
-	struct ad7124_channel_config *channel_config;
+	struct ad7124_channel channels[AD7124_MAX_CHANNELS];
+	struct ad7124_channel_config configs[AD7124_MAX_CONFIGS];
 	struct regulator *vref[4];
 	struct clk *mclk;
 	unsigned int adc_control;
@@ -242,9 +256,21 @@ static int ad7124_set_channel(struct ad_sigma_delta *sd, unsigned int channel)
 {
 	struct ad7124_state *st = container_of(sd, struct ad7124_state, sd);
 	unsigned int val;
+	int i;
 
-	val = st->channel_config[channel].ain | AD7124_CHANNEL_EN(1) |
-	      AD7124_CHANNEL_SETUP(channel);
+	if (channel == AD_SD_SLOT_DISABLE) {
+		for (i = 0; i < AD7124_MAX_CHANNELS; i++) {
+			/* disable channel associated with unused slot */
+			if (st->channels[i].slot == slot)
+				return ad_sd_write_reg(&st->sd, AD7124_CHANNEL(i), 2, 0);
+		}
+
+		return 0;
+	}
+
+	st->channels[channel].slot = slot;
+	val = st->channels[channel].ain | AD7124_CHANNEL_EN(1) |
+	      AD7124_CHANNEL_SETUP(st->channels[channel].cfg->nr);
 
 	return ad_sd_write_reg(&st->sd, AD7124_CHANNEL(channel), 2, val);
 }
@@ -280,14 +306,13 @@ static int ad7124_set_channel_odr(struct ad7124_state *st,
 	else if (odr_sel_bits > 2047)
 		odr_sel_bits = 2047;
 
-	ret = ad7124_spi_write_mask(st, AD7124_FILTER(channel),
+	ret = ad7124_spi_write_mask(st, AD7124_FILTER(st->channels[channel].cfg->nr),
 				    AD7124_FILTER_FS_MSK,
 				    AD7124_FILTER_FS(odr_sel_bits), 3);
 	if (ret < 0)
 		return ret;
 	/* fADC = fCLK / (FS[10:0] x 32) */
-	st->channel_config[channel].odr =
-		DIV_ROUND_CLOSEST(fclk, odr_sel_bits * 32);
+	st->channels[channel].cfg->odr = DIV_ROUND_CLOSEST(fclk, odr_sel_bits * 32);
 
 	return 0;
 }
@@ -301,13 +326,13 @@ static int ad7124_set_channel_gain(struct ad7124_state *st,
 
 	res = ad7124_find_closest_match(ad7124_gain,
 					ARRAY_SIZE(ad7124_gain), gain);
-	ret = ad7124_spi_write_mask(st, AD7124_CONFIG(channel),
+	ret = ad7124_spi_write_mask(st, AD7124_CONFIG(st->channels[channel].cfg->nr),
 				    AD7124_CONFIG_PGA_MSK,
 				    AD7124_CONFIG_PGA(res), 2);
 	if (ret < 0)
 		return ret;
 
-	st->channel_config[channel].pga_bits = res;
+	st->channels[channel].cfg->pga_bits = res;
 
 	return 0;
 }
@@ -317,9 +342,9 @@ static int ad7124_get_3db_filter_freq(struct ad7124_state *st,
 {
 	unsigned int fadc;
 
-	fadc = st->channel_config[channel].odr;
+	fadc = st->channels[channel].cfg->odr;
 
-	switch (st->channel_config[channel].filter_type) {
+	switch (st->channels[channel].cfg->filter_type) {
 	case AD7124_SINC3_FILTER:
 		return DIV_ROUND_CLOSEST(fadc * 230, 1000);
 	case AD7124_SINC4_FILTER:
@@ -349,11 +374,11 @@ static int ad7124_set_3db_filter_freq(struct ad7124_state *st,
 		new_odr = sinc3_3db_odr;
 	}
 
-	if (st->channel_config[channel].filter_type != new_filter) {
+	if (st->channels[channel].cfg->filter_type != new_filter) {
 		int ret;
 
-		st->channel_config[channel].filter_type = new_filter;
-		ret = ad7124_spi_write_mask(st, AD7124_FILTER(channel),
+		st->channels[channel].cfg->filter_type = new_filter;
+		ret = ad7124_spi_write_mask(st, AD7124_FILTER(st->channels[channel].cfg->nr),
 					    AD7124_FILTER_TYPE_MSK,
 					    AD7124_FILTER_TYPE_SEL(new_filter),
 					    3);
@@ -380,30 +405,30 @@ static int ad7124_read_raw(struct iio_dev *indio_dev,
 		/* After the conversion is performed, disable the channel */
 		ret = ad_sd_write_reg(&st->sd,
 				      AD7124_CHANNEL(chan->address), 2,
-				      st->channel_config[chan->address].ain |
+				      st->channels[chan->address].ain |
 				      AD7124_CHANNEL_EN(0));
 		if (ret < 0)
 			return ret;
 
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
-		idx = st->channel_config[chan->address].pga_bits;
-		*val = st->channel_config[chan->address].vref_mv;
-		if (st->channel_config[chan->address].bipolar)
+		idx = st->channels[chan->address].cfg->pga_bits;
+		*val = st->channels[chan->address].cfg->vref_mv;
+		if (st->channels[chan->address].cfg->bipolar)
 			*val2 = chan->scan_type.realbits - 1 + idx;
 		else
 			*val2 = chan->scan_type.realbits + idx;
 
 		return IIO_VAL_FRACTIONAL_LOG2;
 	case IIO_CHAN_INFO_OFFSET:
-		if (st->channel_config[chan->address].bipolar)
+		if (st->channels[chan->address].cfg->bipolar)
 			*val = -(1 << (chan->scan_type.realbits - 1));
 		else
 			*val = 0;
 
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		*val = st->channel_config[chan->address].odr;
+		*val = st->channels[chan->address].cfg->odr;
 
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
@@ -431,12 +456,12 @@ static int ad7124_write_raw(struct iio_dev *indio_dev,
 		if (val != 0)
 			return -EINVAL;
 
-		if (st->channel_config[chan->address].bipolar)
+		if (st->channels[chan->address].cfg->bipolar)
 			full_scale = 1 << (chan->scan_type.realbits - 1);
 		else
 			full_scale = 1 << chan->scan_type.realbits;
 
-		vref = st->channel_config[chan->address].vref_mv * 1000000LL;
+		vref = st->channels[chan->address].cfg->vref_mv * 1000000LL;
 		res = DIV_ROUND_CLOSEST(vref, full_scale);
 		gain = DIV_ROUND_CLOSEST(res, val2);
 
@@ -550,7 +575,7 @@ static int ad7124_check_chip_id(struct ad7124_state *st)
 static int ad7124_init_channel_vref(struct ad7124_state *st,
 				    unsigned int channel_number)
 {
-	unsigned int refsel = st->channel_config[channel_number].refsel;
+	unsigned int refsel = st->channels[channel_number].cfg->refsel;
 
 	switch (refsel) {
 	case AD7124_REFIN1:
@@ -562,13 +587,13 @@ static int ad7124_init_channel_vref(struct ad7124_state *st,
 				ad7124_ref_names[refsel]);
 			return PTR_ERR(st->vref[refsel]);
 		}
-		st->channel_config[channel_number].vref_mv =
+		st->channels[channel_number].cfg->vref_mv =
 			regulator_get_voltage(st->vref[refsel]);
 		/* Conversion from uV to mV */
-		st->channel_config[channel_number].vref_mv /= 1000;
+		st->channels[channel_number].cfg->vref_mv /= 1000;
 		break;
 	case AD7124_INT_REF:
-		st->channel_config[channel_number].vref_mv = 2500;
+		st->channels[channel_number].cfg->vref_mv = 2500;
 		st->adc_control &= ~AD7124_ADC_CTRL_REF_EN_MSK;
 		st->adc_control |= AD7124_ADC_CTRL_REF_EN(1);
 		return ad_sd_write_reg(&st->sd, AD7124_ADC_CONTROL,
@@ -587,14 +612,40 @@ static int ad7124_of_parse_channel_config(struct iio_dev *indio_dev,
 	struct ad7124_state *st = iio_priv(indio_dev);
 	struct device_node *child;
 	struct iio_chan_spec *chan;
-	struct ad7124_channel_config *chan_config;
-	unsigned int ain[2], channel = 0, tmp;
+	unsigned int ain[2], config_nr = 0, channel = 0, tmp;
 	int ret;
 
-	st->num_channels = of_get_available_child_count(np);
-	if (!st->num_channels) {
-		dev_err(indio_dev->dev.parent, "no channel children\n");
-		return -ENODEV;
+	/* parse configuration nodes */
+	for_each_available_child_of_node(np, child) {
+		ret = of_property_read_u32_array(child, "diff-channels", ain, 2);
+		if (!ret) {
+			st->num_channels++;
+			continue;
+		}
+
+		if (ret == -EINVAL) {
+			ret = of_property_read_u32(child, "reg", &config_nr);
+			if (ret)
+				goto err;
+
+			config_nr -= AD7124_CONF_ADDR_OFFSET;
+			st->configs[config_nr].enable = true;
+			st->configs[config_nr].nr = config_nr;
+			st->configs[config_nr].bipolar = of_property_read_bool(child, "bipolar");
+
+			ret = of_property_read_u32(child, "adi,reference-select", &tmp);
+			if (ret)
+				st->configs[config_nr].refsel = AD7124_INT_REF;
+			else
+				st->configs[config_nr].refsel = tmp;
+
+			st->configs[config_nr].buf_positive =
+				of_property_read_bool(child, "adi,buffered-positive");
+			st->configs[config_nr].buf_negative =
+				of_property_read_bool(child, "adi,buffered-negative");
+		} else {
+			goto err;
+		}
 	}
 
 	chan = devm_kcalloc(indio_dev->dev.parent, st->num_channels,
@@ -602,46 +653,43 @@ static int ad7124_of_parse_channel_config(struct iio_dev *indio_dev,
 	if (!chan)
 		return -ENOMEM;
 
-	chan_config = devm_kcalloc(indio_dev->dev.parent, st->num_channels,
-				   sizeof(*chan_config), GFP_KERNEL);
-	if (!chan_config)
-		return -ENOMEM;
-
 	indio_dev->channels = chan;
 	indio_dev->num_channels = st->num_channels;
-	st->channel_config = chan_config;
 
+	/* parse channel nodes */
 	for_each_available_child_of_node(np, child) {
-		ret = of_property_read_u32(child, "reg", &channel);
-		if (ret)
-			goto err;
-
-		ret = of_property_read_u32_array(child, "diff-channels",
-						 ain, 2);
-		if (ret)
-			goto err;
-
-		st->channel_config[channel].ain = AD7124_CHANNEL_AINP(ain[0]) |
-						  AD7124_CHANNEL_AINM(ain[1]);
-		st->channel_config[channel].bipolar =
-			of_property_read_bool(child, "bipolar");
-
-		ret = of_property_read_u32(child, "adi,reference-select", &tmp);
-		if (ret)
-			st->channel_config[channel].refsel = AD7124_INT_REF;
-		else
-			st->channel_config[channel].refsel = tmp;
-
-		st->channel_config[channel].buf_positive =
-			of_property_read_bool(child, "adi,buffered-positive");
-		st->channel_config[channel].buf_negative =
-			of_property_read_bool(child, "adi,buffered-negative");
-
-		chan[channel] = ad7124_channel_template;
-		chan[channel].address = channel;
-		chan[channel].scan_index = channel;
-		chan[channel].channel = ain[0];
-		chan[channel].channel2 = ain[1];
+		ret = of_property_read_u32_array(child, "diff-channels", ain, 2);
+		if (!ret) {
+			ret = of_property_read_u32(child, "reg", &channel);
+			if (ret)
+				goto err;
+
+			ret = of_property_read_u32_array(child, "diff-channels", ain, 2);
+			if (ret)
+				goto err;
+
+			st->channels[channel].ain = AD7124_CHANNEL_AINP(ain[0]) |
+						    AD7124_CHANNEL_AINM(ain[1]);
+
+			ret = of_property_read_u32(child, "adi,configuration", &config_nr);
+			if (ret)
+				goto err;
+
+			config_nr -= AD7124_CONF_ADDR_OFFSET;
+			if (!st->configs[config_nr].enable) {
+				dev_err(&st->sd.spi->dev, "Configuration %u not specified in DT.\n",
+					config_nr);
+				return -EINVAL;
+			}
+
+			st->channels[channel].cfg = &st->configs[config_nr];
+
+			chan[channel] = ad7124_channel_template;
+			chan[channel].address = channel;
+			chan[channel].scan_index = channel;
+			chan[channel].channel = ain[0];
+			chan[channel].channel2 = ain[1];
+		}
 	}
 
 	return 0;
@@ -678,7 +726,7 @@ static int ad7124_setup(struct ad7124_state *st)
 		return ret;
 
 	for (i = 0; i < st->num_channels; i++) {
-		val = st->channel_config[i].ain | AD7124_CHANNEL_SETUP(i);
+		val = st->channels[i].ain | AD7124_CHANNEL_SETUP(i);
 		ret = ad_sd_write_reg(&st->sd, AD7124_CHANNEL(i), 2, val);
 		if (ret < 0)
 			return ret;
@@ -687,13 +735,13 @@ static int ad7124_setup(struct ad7124_state *st)
 		if (ret < 0)
 			return ret;
 
-		tmp = (st->channel_config[i].buf_positive << 1)  +
-			st->channel_config[i].buf_negative;
+		tmp = (st->channels[i].cfg->buf_positive << 1)  +
+			st->channels[i].cfg->buf_negative;
 
-		val = AD7124_CONFIG_BIPOLAR(st->channel_config[i].bipolar) |
-		      AD7124_CONFIG_REF_SEL(st->channel_config[i].refsel) |
+		val = AD7124_CONFIG_BIPOLAR(st->channels[i].cfg->bipolar) |
+		      AD7124_CONFIG_REF_SEL(st->channels[i].cfg->refsel) |
 		      AD7124_CONFIG_IN_BUFF(tmp);
-		ret = ad_sd_write_reg(&st->sd, AD7124_CONFIG(i), 2, val);
+		ret = ad_sd_write_reg(&st->sd, AD7124_CONFIG(st->channels[i].cfg->nr), 2, val);
 		if (ret < 0)
 			return ret;
 		/*
-- 
2.20.1

