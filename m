Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E96624E1D5C
	for <lists+linux-iio@lfdr.de>; Sun, 20 Mar 2022 19:15:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343501AbiCTSQW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 20 Mar 2022 14:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343498AbiCTSQW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 20 Mar 2022 14:16:22 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BBD4527ED
        for <linux-iio@vger.kernel.org>; Sun, 20 Mar 2022 11:14:58 -0700 (PDT)
Received: from tr.lan (ip-89-176-112-137.net.upcbroadband.cz [89.176.112.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id F16A083AC6;
        Sun, 20 Mar 2022 19:14:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1647800097;
        bh=fYBWoVYDLHtobslcVvs2/8PW2UMhxM3Chzl2JPwLqso=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GXB3BiIwWvJckVJmBXwz+yiK7Agi4fX75Ew0rerGTTQO2eFULWotwYFLDZlL0pfPM
         EPNeLmF9iaII01r+d8Eq4L0TtwLwhLpJ/6dzwVAwejMrWoqrJo6mDPQRT27RYAtazm
         w0BsEDH0oxsVYVOq7rHDgw5BZVq4WFZGgr5/xl/b7rhr5RA4d0JH1fVNPKleC0rKJZ
         WU9prUMp7aQEwrYhWaIFxhrTJGavu6FO70DgiOmUMjHV4RtB+VPs4G+6ElDJgS2QQn
         qtu2HVYGZqVhGD+3BTDylsgcuz/iLAqrUPrf6wYlYTAxL1gO7xAf0nnHsofOIDSzZJ
         6kvYwMlnmDOWw==
From:   Marek Vasut <marex@denx.de>
To:     linux-iio@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 09/10] iio: adc: ti-ads1015: Replace data_rate with chip data struct ads1015_data
Date:   Sun, 20 Mar 2022 19:14:27 +0100
Message-Id: <20220320181428.168109-9-marex@denx.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220320181428.168109-1-marex@denx.de>
References: <20220320181428.168109-1-marex@denx.de>
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

Instead of storing only data_rate in private data, store pointer to the
whole chip data and use the data_rate from chip data throughout the driver.
No functional change. This is done in preparation for switch to read_avail().

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Daniel Baluta <daniel.baluta@nxp.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
V3: New patch
---
 drivers/iio/adc/ti-ads1015.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
index 19e75ebdddd49..66431d1445d9b 100644
--- a/drivers/iio/adc/ti-ads1015.c
+++ b/drivers/iio/adc/ti-ads1015.c
@@ -227,7 +227,7 @@ struct ads1015_data {
 	unsigned int comp_mode;
 	struct ads1015_thresh_data thresh_data[ADS1015_CHANNELS];
 
-	const unsigned int *data_rate;
+	const struct ads1015_chip_data *chip;
 	/*
 	 * Set to true when the ADC is switched to the continuous-conversion
 	 * mode and exits from a power-down state.  This flag is used to avoid
@@ -368,6 +368,7 @@ static int ads1015_set_power_state(struct ads1015_data *data, bool on)
 static
 int ads1015_get_adc_result(struct ads1015_data *data, int chan, int *val)
 {
+	const unsigned int *data_rate = data->chip->data_rate;
 	int ret, pga, dr, dr_old, conv_time;
 	unsigned int old, mask, cfg;
 
@@ -402,8 +403,8 @@ int ads1015_get_adc_result(struct ads1015_data *data, int chan, int *val)
 	}
 	if (data->conv_invalid) {
 		dr_old = (old & ADS1015_CFG_DR_MASK) >> ADS1015_CFG_DR_SHIFT;
-		conv_time = DIV_ROUND_UP(USEC_PER_SEC, data->data_rate[dr_old]);
-		conv_time += DIV_ROUND_UP(USEC_PER_SEC, data->data_rate[dr]);
+		conv_time = DIV_ROUND_UP(USEC_PER_SEC, data_rate[dr_old]);
+		conv_time += DIV_ROUND_UP(USEC_PER_SEC, data_rate[dr]);
 		conv_time += conv_time / 10; /* 10% internal clock inaccuracy */
 		usleep_range(conv_time, conv_time + 1);
 		data->conv_invalid = false;
@@ -470,7 +471,7 @@ static int ads1015_set_data_rate(struct ads1015_data *data, int chan, int rate)
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(ads1015_data_rate); i++) {
-		if (data->data_rate[i] == rate) {
+		if (data->chip->data_rate[i] == rate) {
 			data->channel_data[chan].data_rate = i;
 			return 0;
 		}
@@ -528,7 +529,7 @@ static int ads1015_read_raw(struct iio_dev *indio_dev,
 		break;
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		idx = data->channel_data[chan->address].data_rate;
-		*val = data->data_rate[idx];
+		*val = data->chip->data_rate[idx];
 		ret = IIO_VAL_INT;
 		break;
 	default:
@@ -588,7 +589,7 @@ static int ads1015_read_event(struct iio_dev *indio_dev,
 		dr = data->channel_data[chan->address].data_rate;
 		comp_queue = data->thresh_data[chan->address].comp_queue;
 		period = ads1015_comp_queue[comp_queue] *
-			USEC_PER_SEC / data->data_rate[dr];
+			USEC_PER_SEC / data->chip->data_rate[dr];
 
 		*val = period / USEC_PER_SEC;
 		*val2 = period % USEC_PER_SEC;
@@ -610,6 +611,7 @@ static int ads1015_write_event(struct iio_dev *indio_dev,
 	int val2)
 {
 	struct ads1015_data *data = iio_priv(indio_dev);
+	const unsigned int *data_rate = data->chip->data_rate;
 	int realbits = chan->scan_type.realbits;
 	int ret = 0;
 	long long period;
@@ -635,7 +637,7 @@ static int ads1015_write_event(struct iio_dev *indio_dev,
 
 		for (i = 0; i < ARRAY_SIZE(ads1015_comp_queue) - 1; i++) {
 			if (period <= ads1015_comp_queue[i] *
-					USEC_PER_SEC / data->data_rate[dr])
+					USEC_PER_SEC / data_rate[dr])
 				break;
 		}
 		data->thresh_data[chan->address].comp_queue = i;
@@ -992,7 +994,7 @@ static int ads1015_probe(struct i2c_client *client,
 	indio_dev->channels = chip->channels;
 	indio_dev->num_channels = chip->num_channels;
 	indio_dev->info = chip->info;
-	data->data_rate = chip->data_rate;
+	data->chip = chip;
 	data->event_channel = ADS1015_CHANNELS;
 
 	/*
-- 
2.35.1

