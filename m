Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9400F3FC341
	for <lists+linux-iio@lfdr.de>; Tue, 31 Aug 2021 09:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239340AbhHaHPq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 31 Aug 2021 03:15:46 -0400
Received: from twspam01.aspeedtech.com ([211.20.114.71]:16726 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239324AbhHaHPq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 31 Aug 2021 03:15:46 -0400
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 17V6sdx6028275;
        Tue, 31 Aug 2021 14:54:39 +0800 (GMT-8)
        (envelope-from billy_tsai@aspeedtech.com)
Received: from BillyTsai-pc.aspeed.com (192.168.2.149) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 31 Aug
 2021 15:13:36 +0800
From:   Billy Tsai <billy_tsai@aspeedtech.com>
To:     <jic23@kernel.org>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <robh+dt@kernel.org>, <joel@jms.id.au>, <andrew@aj.id.au>,
        <p.zabel@pengutronix.de>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
CC:     <BMC-SW@aspeedtech.com>
Subject: [v5 12/15] iio: adc: aspeed: Add func to set sampling rate.
Date:   Tue, 31 Aug 2021 15:14:55 +0800
Message-ID: <20210831071458.2334-13-billy_tsai@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210831071458.2334-1-billy_tsai@aspeedtech.com>
References: <20210831071458.2334-1-billy_tsai@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.2.149]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 17V6sdx6028275
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add the function to set the sampling rate and keep the sampling period
for a driver used to wait the fresh value.
In addition, since the ADC clock is required when initializing the ADC
device, move clk_prepare_enable ahead of the initialization phase.

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
 drivers/iio/adc/aspeed_adc.c | 59 ++++++++++++++++++++++++------------
 1 file changed, 40 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/adc/aspeed_adc.c b/drivers/iio/adc/aspeed_adc.c
index 349377b9fac0..1333d7a88427 100644
--- a/drivers/iio/adc/aspeed_adc.c
+++ b/drivers/iio/adc/aspeed_adc.c
@@ -73,6 +73,12 @@
 
 #define ASPEED_ADC_INIT_POLLING_TIME	500
 #define ASPEED_ADC_INIT_TIMEOUT		500000
+/*
+ * When the sampling rate is too high, the ADC may not have enough charging
+ * time, resulting in a low voltage value. Thus, the default uses a slow
+ * sampling rate for most use cases.
+ */
+#define ASPEED_ADC_DEF_SAMPLING_RATE	65000
 
 struct aspeed_adc_model_data {
 	const char *model_name;
@@ -96,6 +102,7 @@ struct aspeed_adc_data {
 	struct clk_hw		*clk_scaler;
 	struct reset_control	*rst;
 	int			vref_mv;
+	u32			sample_period_ns;
 };
 
 #define ASPEED_CHAN(_idx, _data_reg_addr) {			\
@@ -127,6 +134,24 @@ static const struct iio_chan_spec aspeed_adc_iio_channels[] = {
 	ASPEED_CHAN(15, 0x2E),
 };
 
+static int aspeed_adc_set_sampling_rate(struct iio_dev *indio_dev, u32 rate)
+{
+	struct aspeed_adc_data *data = iio_priv(indio_dev);
+
+	if (rate < data->model_data->min_sampling_rate ||
+	    rate > data->model_data->max_sampling_rate)
+		return -EINVAL;
+	/* Each sampling needs 12 clocks to convert.*/
+	clk_set_rate(data->clk_scaler->clk, rate * ASPEED_CLOCKS_PER_SAMPLE);
+	rate = clk_get_rate(data->clk_scaler->clk);
+	data->sample_period_ns = DIV_ROUND_UP_ULL(
+		(u64)NSEC_PER_SEC * ASPEED_CLOCKS_PER_SAMPLE, rate);
+	dev_dbg(data->dev, "Adc clock = %d sample period = %d ns", rate,
+		data->sample_period_ns);
+
+	return 0;
+}
+
 static int aspeed_adc_read_raw(struct iio_dev *indio_dev,
 			       struct iio_chan_spec const *chan,
 			       int *val, int *val2, long mask)
@@ -157,17 +182,9 @@ static int aspeed_adc_write_raw(struct iio_dev *indio_dev,
 				struct iio_chan_spec const *chan,
 				int val, int val2, long mask)
 {
-	struct aspeed_adc_data *data = iio_priv(indio_dev);
-
 	switch (mask) {
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		if (val < data->model_data->min_sampling_rate ||
-			val > data->model_data->max_sampling_rate)
-			return -EINVAL;
-
-		clk_set_rate(data->clk_scaler->clk,
-				val * ASPEED_CLOCKS_PER_SAMPLE);
-		return 0;
+		return aspeed_adc_set_sampling_rate(indio_dev, val);
 
 	case IIO_CHAN_INFO_SCALE:
 	case IIO_CHAN_INFO_RAW:
@@ -409,6 +426,20 @@ static int aspeed_adc_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	ret = clk_prepare_enable(data->clk_scaler->clk);
+	if (ret)
+		return ret;
+
+	ret = devm_add_action_or_reset(data->dev,
+				       aspeed_adc_clk_disable_unprepare,
+				       data->clk_scaler->clk);
+	if (ret)
+		return ret;
+
+	ret = aspeed_adc_set_sampling_rate(indio_dev, ASPEED_ADC_DEF_SAMPLING_RATE);
+	if (ret)
+		return ret;
+
 	if (data->model_data->wait_init_sequence) {
 		adc_engine_control_reg_val =
 			readl(data->base + ASPEED_REG_ENGINE_CONTROL);
@@ -436,16 +467,6 @@ static int aspeed_adc_probe(struct platform_device *pdev)
 	}
 
 	/* Start all channels in normal mode. */
-	ret = clk_prepare_enable(data->clk_scaler->clk);
-	if (ret)
-		return ret;
-
-	ret = devm_add_action_or_reset(data->dev,
-				       aspeed_adc_clk_disable_unprepare,
-				       data->clk_scaler->clk);
-	if (ret)
-		return ret;
-
 	adc_engine_control_reg_val =
 		readl(data->base + ASPEED_REG_ENGINE_CONTROL);
 	adc_engine_control_reg_val |=
-- 
2.25.1

