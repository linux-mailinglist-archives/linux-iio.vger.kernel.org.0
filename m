Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A676F3D3662
	for <lists+linux-iio@lfdr.de>; Fri, 23 Jul 2021 10:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234313AbhGWHfy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 23 Jul 2021 03:35:54 -0400
Received: from twspam01.aspeedtech.com ([211.20.114.71]:30010 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234307AbhGWHfx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 23 Jul 2021 03:35:53 -0400
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 16N7x7uR041953;
        Fri, 23 Jul 2021 15:59:07 +0800 (GMT-8)
        (envelope-from billy_tsai@aspeedtech.com)
Received: from BillyTsai-pc.aspeed.com (192.168.2.149) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 23 Jul
 2021 16:15:41 +0800
From:   Billy Tsai <billy_tsai@aspeedtech.com>
To:     <jic23@kernel.org>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <robh+dt@kernel.org>, <joel@jms.id.au>, <andrew@aj.id.au>,
        <p.zabel@pengutronix.de>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
CC:     <BMC-SW@aspeedtech.com>
Subject: [v2 8/8] iio: adc: aspeed: Support battery sensing.
Date:   Fri, 23 Jul 2021 16:16:21 +0800
Message-ID: <20210723081621.29477-9-billy_tsai@aspeedtech.com>
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
X-MAIL: twspam01.aspeedtech.com 16N7x7uR041953
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

In ast2600, ADC integrate dividing circuit at last input channel for
battery sensing. This patch use the dts property "battery-sensing" to
enable this feature makes the last channel of each adc can tolerance
higher voltage than reference voltage.

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
 drivers/iio/adc/aspeed_adc.c | 60 +++++++++++++++++++++++++++++++++---
 1 file changed, 55 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/aspeed_adc.c b/drivers/iio/adc/aspeed_adc.c
index 7e674b607e36..6c7e2bb7b1ac 100644
--- a/drivers/iio/adc/aspeed_adc.c
+++ b/drivers/iio/adc/aspeed_adc.c
@@ -45,6 +45,9 @@
 #define ASPEED_ADC_REF_VOLTAGE_1200mV		FIELD_PREP(ASPEED_ADC_REF_VOLTAGE, 1)
 #define ASPEED_ADC_REF_VOLTAGE_EXT_HIGH		FIELD_PREP(ASPEED_ADC_REF_VOLTAGE, 2)
 #define ASPEED_ADC_REF_VOLTAGE_EXT_LOW		FIELD_PREP(ASPEED_ADC_REF_VOLTAGE, 3)
+#define ASPEED_ADC_BATTERY_SENSING_DIV		BIT(6)
+#define ASPEED_ADC_BATTERY_SENSING_DIV_2_3	FIELD_PREP(ASPEED_ADC_BATTERY_SENSING_DIV, 0)
+#define ASPEED_ADC_BATTERY_SENSING_DIV_1_3	FIELD_PREP(ASPEED_ADC_BATTERY_SENSING_DIV, 1)
 #define ASPEED_ADC_CTRL_INIT_RDY		BIT(8)
 #define ASPEED_ADC_CH7_MODE			BIT(12)
 #define ASPEED_ADC_CH7_NORMAL			FIELD_PREP(ASPEED_ADC_CH7_MODE, 0)
@@ -76,6 +79,11 @@ struct aspeed_adc_model_data {
 	unsigned int num_channels;
 };
 
+struct adc_gain {
+	u8 mult;
+	u8 div;
+};
+
 struct aspeed_adc_data {
 	struct device		*dev;
 	void __iomem		*base;
@@ -87,6 +95,8 @@ struct aspeed_adc_data {
 	int			vref;
 	u32			sample_period_ns;
 	int			cv;
+	bool			battery_sensing;
+	struct adc_gain		battery_mode_gain;
 };
 
 #define ASPEED_CHAN(_idx, _data_reg_addr) {			\
@@ -185,14 +195,38 @@ static int aspeed_adc_read_raw(struct iio_dev *indio_dev,
 			       int *val, int *val2, long mask)
 {
 	struct aspeed_adc_data *data = iio_priv(indio_dev);
+	u32 adc_engine_control_reg_val;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		*val = readw(data->base + chan->address) + data->cv;
-		if (*val < 0)
-			*val = 0;
-		else if (*val >= ASPEED_ADC_MAX_RAW_DATA)
-			*val = ASPEED_ADC_MAX_RAW_DATA;
+		if (data->battery_sensing && chan->channel == 7) {
+			adc_engine_control_reg_val =
+				readl(data->base + ASPEED_REG_ENGINE_CONTROL);
+			writel(adc_engine_control_reg_val |
+				       ASPEED_ADC_CH7_BATTERY |
+				       ASPEED_ADC_BATTERY_SENSING_ENABLE,
+			       data->base + ASPEED_REG_ENGINE_CONTROL);
+			/*
+			 * After enable battery sensing mode need to wait some time for adc stable
+			 * Experiment result is 1ms.
+			 */
+			mdelay(1);
+			*val = readw(data->base + chan->address) + data->cv;
+			if (*val < 0)
+				*val = 0;
+			else if (*val >= ASPEED_ADC_MAX_RAW_DATA)
+				*val = ASPEED_ADC_MAX_RAW_DATA;
+			*val = (*val * data->battery_mode_gain.mult) /
+			       data->battery_mode_gain.div;
+			writel(adc_engine_control_reg_val,
+			       data->base + ASPEED_REG_ENGINE_CONTROL);
+		} else {
+			*val = readw(data->base + chan->address) + data->cv;
+			if (*val < 0)
+				*val = 0;
+			else if (*val >= ASPEED_ADC_MAX_RAW_DATA)
+				*val = ASPEED_ADC_MAX_RAW_DATA;
+		}
 		return IIO_VAL_INT;
 
 	case IIO_CHAN_INFO_SCALE:
@@ -392,6 +426,22 @@ static int aspeed_adc_probe(struct platform_device *pdev)
 	if (ret)
 		goto vref_config_error;
 
+	if (of_find_property(data->dev->of_node, "battery-sensing", NULL)) {
+		if (model_data->version >= aspeed_adc_ast2600) {
+			data->battery_sensing = 1;
+			if (readl(data->base + ASPEED_REG_ENGINE_CONTROL) &
+			    ASPEED_ADC_BATTERY_SENSING_DIV_1_3) {
+				data->battery_mode_gain.mult = 3;
+				data->battery_mode_gain.div = 1;
+			} else {
+				data->battery_mode_gain.mult = 3;
+				data->battery_mode_gain.div = 2;
+			}
+		} else
+			dev_warn(&pdev->dev,
+				 "Failed to enable battey-sensing mode\n");
+	}
+
 	if (model_data->wait_init_sequence) {
 		adc_engine_control_reg_val =
 			readl(data->base + ASPEED_REG_ENGINE_CONTROL);
-- 
2.25.1

