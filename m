Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78AEA3D365E
	for <lists+linux-iio@lfdr.de>; Fri, 23 Jul 2021 10:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234348AbhGWHfd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 23 Jul 2021 03:35:33 -0400
Received: from twspam01.aspeedtech.com ([211.20.114.71]:29960 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234354AbhGWHfd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 23 Jul 2021 03:35:33 -0400
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 16N7x6Sv041951;
        Fri, 23 Jul 2021 15:59:06 +0800 (GMT-8)
        (envelope-from billy_tsai@aspeedtech.com)
Received: from BillyTsai-pc.aspeed.com (192.168.2.149) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 23 Jul
 2021 16:15:40 +0800
From:   Billy Tsai <billy_tsai@aspeedtech.com>
To:     <jic23@kernel.org>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <robh+dt@kernel.org>, <joel@jms.id.au>, <andrew@aj.id.au>,
        <p.zabel@pengutronix.de>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
CC:     <BMC-SW@aspeedtech.com>
Subject: [v2 6/8] iio: adc: aspeed: Add compensation phase.
Date:   Fri, 23 Jul 2021 16:16:19 +0800
Message-ID: <20210723081621.29477-7-billy_tsai@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210723081621.29477-1-billy_tsai@aspeedtech.com>
References: <20210723081621.29477-1-billy_tsai@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.2.149]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 16N7x6Sv041951
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch adds a compensation phase to improve the accurate of adc
measurement. This is the builtin function though input half of the
reference voltage to get the adc offset.

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
 drivers/iio/adc/aspeed_adc.c | 52 ++++++++++++++++++++++++++++++++++--
 1 file changed, 50 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/aspeed_adc.c b/drivers/iio/adc/aspeed_adc.c
index bb6100228cae..0153b28b83b7 100644
--- a/drivers/iio/adc/aspeed_adc.c
+++ b/drivers/iio/adc/aspeed_adc.c
@@ -61,6 +61,7 @@
  * rate for most user case.
  */
 #define ASPEED_ADC_DEF_SAMPLING_RATE	65000
+#define ASPEED_ADC_MAX_RAW_DATA		GENMASK(9, 0)
 
 enum aspeed_adc_version {
 	aspeed_adc_ast2400,
@@ -84,6 +85,7 @@ struct aspeed_adc_data {
 	struct reset_control	*rst;
 	int			vref;
 	u32			sample_period_ns;
+	int			cv;
 };
 
 #define ASPEED_CHAN(_idx, _data_reg_addr) {			\
@@ -115,6 +117,48 @@ static const struct iio_chan_spec aspeed_adc_iio_channels[] = {
 	ASPEED_CHAN(15, 0x2E),
 };
 
+static int aspeed_adc_compensation(struct platform_device *pdev)
+{
+	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
+	struct aspeed_adc_data *data = iio_priv(indio_dev);
+	u32 index, adc_raw = 0;
+	u32 adc_engine_control_reg_val =
+		readl(data->base + ASPEED_REG_ENGINE_CONTROL);
+	adc_engine_control_reg_val |=
+		(ASPEED_ADC_OPERATION_MODE_NORMAL | ASPEED_ADC_ENGINE_ENABLE);
+
+	/*
+	 * Enable compensating sensing:
+	 * After that, the input voltage of adc will force to half of the reference
+	 * voltage. So the expected reading raw data will become half of the max
+	 * value. We can get compensating value = 0x200 - adc read raw value.
+	 * It is recommended to average at least 10 samples to get a final CV.
+	 */
+	writel(adc_engine_control_reg_val | ASPEED_ADC_CTRL_COMPENSATION |
+		       ASPEED_ADC_CTRL_CHANNEL_ENABLE(0),
+	       data->base + ASPEED_REG_ENGINE_CONTROL);
+	/*
+	 * After enable compensating sensing mode need to wait some time for adc stable
+	 * Experiment result is 1ms.
+	 */
+	mdelay(1);
+
+	for (index = 0; index < 16; index++) {
+		/*
+		 * Waiting for the sampling period ensures that the value acquired
+		 * is fresh each time.
+		 */
+		ndelay(data->sample_period_ns);
+		adc_raw += readw(data->base + aspeed_adc_iio_channels[0].address);
+	}
+	adc_raw >>= 4;
+	data->cv = BIT(ASPEED_RESOLUTION_BITS - 1) - adc_raw;
+	writel(adc_engine_control_reg_val,
+	       data->base + ASPEED_REG_ENGINE_CONTROL);
+	dev_dbg(data->dev, "compensating value = %d\n", data->cv);
+	return 0;
+}
+
 static int aspeed_adc_set_sampling_rate(struct iio_dev *indio_dev, u32 rate)
 {
 	struct aspeed_adc_data *data = iio_priv(indio_dev);
@@ -143,7 +187,11 @@ static int aspeed_adc_read_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		*val = readw(data->base + chan->address);
+		*val = readw(data->base + chan->address) + data->cv;
+		if (*val < 0)
+			*val = 0;
+		else if (*val >= ASPEED_ADC_MAX_RAW_DATA)
+			*val = ASPEED_ADC_MAX_RAW_DATA;
 		return IIO_VAL_INT;
 
 	case IIO_CHAN_INFO_SCALE:
@@ -347,7 +395,7 @@ static int aspeed_adc_probe(struct platform_device *pdev)
 		if (ret)
 			goto poll_timeout_error;
 	}
-
+	aspeed_adc_compensation(pdev);
 	adc_engine_control_reg_val =
 		readl(data->base + ASPEED_REG_ENGINE_CONTROL);
 	/* Start all channels in normal mode. */
-- 
2.25.1

