Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06A6C3F6C83
	for <lists+linux-iio@lfdr.de>; Wed, 25 Aug 2021 02:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234259AbhHYAXq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 24 Aug 2021 20:23:46 -0400
Received: from twspam01.aspeedtech.com ([211.20.114.71]:38370 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235197AbhHYAXq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 24 Aug 2021 20:23:46 -0400
Received: (from root@localhost)
        by twspam01.aspeedtech.com id 17P04QtL094614
        for <linux-iio@vger.kernel.org>; Wed, 25 Aug 2021 08:04:26 +0800 (GMT-8)
        (envelope-from billy_tsai@aspeedtech.com)
Message-Id: <202108250004.17P04QtL094614@twspam01.aspeedtech.com>
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 17O8rHKq098405;
        Tue, 24 Aug 2021 16:53:17 +0800 (GMT-8)
        (envelope-from billy_tsai@aspeedtech.com)
Received: from BillyTsai-pc.aspeed.com (192.168.2.149) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 24 Aug
 2021 17:11:49 +0800
From:   Billy Tsai <billy_tsai@aspeedtech.com>
To:     <jic23@kernel.org>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <robh+dt@kernel.org>, <joel@jms.id.au>, <andrew@aj.id.au>,
        <p.zabel@pengutronix.de>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
CC:     <BMC-SW@aspeedtech.com>
Subject: [RESEND v4 15/15] iio: adc: aspeed: Get and set trimming data.
Date:   Tue, 24 Aug 2021 17:12:43 +0800
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210824091243.9393-1-billy_tsai@aspeedtech.com>
References: <20210824091243.9393-1-billy_tsai@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.2.149]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 17P04QtL094614
X-MSS:  FORWARD@twspam01.aspeedtech.com
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The adc controller have trimming register for fine-tune the reference
voltage. The trimming value come from the otp register which will be
written before chip product. This patch will read this otp value and
configure it to the adc register when adc controller probe and using dts
property "aspeed,trim-data-valid" to determine whether to execute this
flow.

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
 drivers/iio/adc/aspeed_adc.c | 68 ++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/drivers/iio/adc/aspeed_adc.c b/drivers/iio/adc/aspeed_adc.c
index 0c5d84e82561..bd7fb23f3510 100644
--- a/drivers/iio/adc/aspeed_adc.c
+++ b/drivers/iio/adc/aspeed_adc.c
@@ -25,6 +25,8 @@
 #include <linux/spinlock.h>
 #include <linux/types.h>
 #include <linux/bitfield.h>
+#include <linux/regmap.h>
+#include <linux/mfd/syscon.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/driver.h>
@@ -72,6 +74,11 @@
  */
 #define ASPEED_ADC_DEF_SAMPLING_RATE	65000
 
+struct aspeed_adc_trim_locate {
+	const unsigned int offset;
+	const unsigned int field;
+};
+
 struct aspeed_adc_model_data {
 	const char *model_name;
 	unsigned int min_sampling_rate;	// Hz
@@ -82,6 +89,7 @@ struct aspeed_adc_model_data {
 	bool bat_sense_sup;
 	u8 scaler_bit_width;
 	unsigned int num_channels;
+	const struct aspeed_adc_trim_locate *trim_locate;
 };
 
 struct adc_gain {
@@ -136,6 +144,44 @@ static const struct iio_chan_spec aspeed_adc_iio_channels[] = {
 	ASPEED_CHAN(15, 0x2E),
 };
 
+static int aspeed_adc_set_trim_data(struct iio_dev *indio_dev)
+{
+	struct device_node *syscon;
+	struct regmap *scu;
+	u32 scu_otp, trimming_val;
+	struct aspeed_adc_data *data = iio_priv(indio_dev);
+
+	syscon = of_find_node_by_name(NULL, "syscon");
+	if (syscon == NULL) {
+		dev_warn(data->dev, "Couldn't find syscon node\n");
+		return -EOPNOTSUPP;
+	}
+	scu = syscon_node_to_regmap(syscon);
+	if (IS_ERR(scu)) {
+		dev_warn(data->dev, "Failed to get syscon regmap\n");
+		return -EOPNOTSUPP;
+	}
+	if (data->model_data->trim_locate) {
+		if (regmap_read(scu, data->model_data->trim_locate->offset,
+				&scu_otp)) {
+			dev_warn(data->dev,
+				 "Failed to get adc trimming data\n");
+			trimming_val = 0x8;
+		} else {
+			trimming_val =
+				((scu_otp) &
+				 (data->model_data->trim_locate->field)) >>
+				__ffs(data->model_data->trim_locate->field);
+		}
+		dev_dbg(data->dev,
+			"trimming val = %d, offset = %08x, fields = %08x\n",
+			trimming_val, data->model_data->trim_locate->offset,
+			data->model_data->trim_locate->field);
+		writel(trimming_val, data->base + ASPEED_REG_COMPENSATION_TRIM);
+	}
+	return 0;
+}
+
 static int aspeed_adc_compensation(struct iio_dev *indio_dev)
 {
 	struct aspeed_adc_data *data = iio_priv(indio_dev);
@@ -506,6 +552,10 @@ static int aspeed_adc_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	if (of_find_property(data->dev->of_node, "aspeed,trim-data-valid",
+			     NULL))
+		aspeed_adc_set_trim_data(indio_dev);
+
 	if (of_find_property(data->dev->of_node, "aspeed,battery-sensing",
 			     NULL)) {
 		if (data->model_data->bat_sense_sup) {
@@ -579,6 +629,21 @@ static int aspeed_adc_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct aspeed_adc_trim_locate ast2500_adc_trim = {
+	.offset = 0x154,
+	.field = GENMASK(31, 28),
+};
+
+static const struct aspeed_adc_trim_locate ast2600_adc0_trim = {
+	.offset = 0x5d0,
+	.field = GENMASK(3, 0),
+};
+
+static const struct aspeed_adc_trim_locate ast2600_adc1_trim = {
+	.offset = 0x5d0,
+	.field = GENMASK(7, 4),
+};
+
 static const struct aspeed_adc_model_data ast2400_model_data = {
 	.model_name = "ast2400-adc",
 	.vref_fixed = 2500, // mV
@@ -598,6 +663,7 @@ static const struct aspeed_adc_model_data ast2500_model_data = {
 	.need_prescaler = true,
 	.scaler_bit_width = 10,
 	.num_channels = 16,
+	.trim_locate = &ast2500_adc_trim,
 };
 
 static const struct aspeed_adc_model_data ast2600_adc0_model_data = {
@@ -608,6 +674,7 @@ static const struct aspeed_adc_model_data ast2600_adc0_model_data = {
 	.bat_sense_sup = true,
 	.scaler_bit_width = 16,
 	.num_channels = 8,
+	.trim_locate = &ast2600_adc0_trim,
 };
 
 static const struct aspeed_adc_model_data ast2600_adc1_model_data = {
@@ -618,6 +685,7 @@ static const struct aspeed_adc_model_data ast2600_adc1_model_data = {
 	.bat_sense_sup = true,
 	.scaler_bit_width = 16,
 	.num_channels = 8,
+	.trim_locate = &ast2600_adc1_trim,
 };
 
 static const struct of_device_id aspeed_adc_matches[] = {
-- 
2.25.1

