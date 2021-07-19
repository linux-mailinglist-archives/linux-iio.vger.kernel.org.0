Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA5263CCFD6
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jul 2021 11:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235471AbhGSIVo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 19 Jul 2021 04:21:44 -0400
Received: from twspam01.aspeedtech.com ([211.20.114.71]:19043 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234973AbhGSIVo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 19 Jul 2021 04:21:44 -0400
Received: from twspam01.aspeedtech.com (localhost [127.0.0.2] (may be forged))
        by twspam01.aspeedtech.com with ESMTP id 16J7ojeR015585
        for <linux-iio@vger.kernel.org>; Mon, 19 Jul 2021 15:50:45 +0800 (GMT-8)
        (envelope-from billy_tsai@aspeedtech.com)
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 16J7nREM015324;
        Mon, 19 Jul 2021 15:49:27 +0800 (GMT-8)
        (envelope-from billy_tsai@aspeedtech.com)
Received: from BillyTsai-pc.aspeed.com (192.168.2.149) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 19 Jul
 2021 16:05:48 +0800
From:   Billy Tsai <billy_tsai@aspeedtech.com>
To:     <jic23@kernel.org>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <robh+dt@kernel.org>, <joel@jms.id.au>, <andrew@aj.id.au>,
        <p.zabel@pengutronix.de>, <billy_tsai@aspeedtech.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <raltherr@google.com>
CC:     <BMC-SW@aspeedtech.com>
Subject: [v1 5/7] iio: adc: aspeed: Add func to set sampling rate.
Date:   Mon, 19 Jul 2021 16:06:05 +0800
Message-ID: <20210719080607.28712-6-billy_tsai@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210719080607.28712-1-billy_tsai@aspeedtech.com>
References: <20210719080607.28712-1-billy_tsai@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.2.149]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 16J7nREM015324
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add the function to set the sampling rate and keep the sampling period
for a driver used to wait the lastest value.

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
 drivers/iio/adc/aspeed_adc.c | 35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/adc/aspeed_adc.c b/drivers/iio/adc/aspeed_adc.c
index 6a77ac4e7dcb..b33ff9f0a3af 100644
--- a/drivers/iio/adc/aspeed_adc.c
+++ b/drivers/iio/adc/aspeed_adc.c
@@ -55,6 +55,7 @@
 
 #define ASPEED_ADC_INIT_POLLING_TIME	500
 #define ASPEED_ADC_INIT_TIMEOUT		500000
+#define ASPEED_ADC_DEF_SAMPLING_RATE	250000
 
 enum aspeed_adc_version {
 	aspeed_adc_ast2400,
@@ -77,6 +78,7 @@ struct aspeed_adc_data {
 	struct clk_hw		*clk_scaler;
 	struct reset_control	*rst;
 	int			vref;
+	u32			sample_period_ns;
 };
 
 #define ASPEED_CHAN(_idx, _data_reg_addr) {			\
@@ -108,6 +110,26 @@ static const struct iio_chan_spec aspeed_adc_iio_channels[] = {
 	ASPEED_CHAN(15, 0x2E),
 };
 
+static int aspeed_adc_set_sampling_rate(struct iio_dev *indio_dev, u32 rate)
+{
+	struct aspeed_adc_data *data = iio_priv(indio_dev);
+	const struct aspeed_adc_model_data *model_data =
+		of_device_get_match_data(data->dev);
+
+	if (rate < model_data->min_sampling_rate ||
+	    rate > model_data->max_sampling_rate)
+		return -EINVAL;
+	/* Each sampling needs 12 clocks to covert.*/
+	clk_set_rate(data->clk_scaler->clk, rate * ASPEED_CLOCKS_PER_SAMPLE);
+
+	rate = clk_get_rate(data->clk_scaler->clk);
+	data->sample_period_ns = DIV_ROUND_UP_ULL(
+		(u64)NSEC_PER_SEC * ASPEED_CLOCKS_PER_SAMPLE, rate);
+	dev_dbg(data->dev, "Adc clock = %d sample period = %d ns", rate,
+		data->sample_period_ns);
+	return 0;
+}
+
 static int aspeed_adc_read_raw(struct iio_dev *indio_dev,
 			       struct iio_chan_spec const *chan,
 			       int *val, int *val2, long mask)
@@ -138,19 +160,9 @@ static int aspeed_adc_write_raw(struct iio_dev *indio_dev,
 				struct iio_chan_spec const *chan,
 				int val, int val2, long mask)
 {
-	struct aspeed_adc_data *data = iio_priv(indio_dev);
-	const struct aspeed_adc_model_data *model_data =
-			of_device_get_match_data(data->dev);
-
 	switch (mask) {
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		if (val < model_data->min_sampling_rate ||
-			val > model_data->max_sampling_rate)
-			return -EINVAL;
-
-		clk_set_rate(data->clk_scaler->clk,
-				val * ASPEED_CLOCKS_PER_SAMPLE);
-		return 0;
+		return aspeed_adc_set_sampling_rate(indio_dev, val);
 
 	case IIO_CHAN_INFO_SCALE:
 	case IIO_CHAN_INFO_RAW:
@@ -325,6 +337,7 @@ static int aspeed_adc_probe(struct platform_device *pdev)
 	ret = clk_prepare_enable(data->clk_scaler->clk);
 	if (ret)
 		goto clk_enable_error;
+	aspeed_adc_set_sampling_rate(indio_dev, ASPEED_ADC_DEF_SAMPLING_RATE);
 	adc_engine_control_reg_val =
 		readl(data->base + ASPEED_REG_ENGINE_CONTROL);
 	/* Start all channels in normal mode. */
-- 
2.25.1

