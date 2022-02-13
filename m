Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E62AC4B3A33
	for <lists+linux-iio@lfdr.de>; Sun, 13 Feb 2022 09:34:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234478AbiBMIeP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 13 Feb 2022 03:34:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234459AbiBMIeO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 13 Feb 2022 03:34:14 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD85D5EDC4;
        Sun, 13 Feb 2022 00:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644741249; x=1676277249;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=g/IIwgDHytkQI9HfTfiqiWQG49DprqFxe9noAIe39lM=;
  b=yxF3n15FntoZQ2DiT1LKr3Lv2E9kVc8IVQ5XjeUn6jRxKo1oPfJR0nJH
   4wnhO1MwP7GXK69UhAlf4hwPiWH+YU4e3/m+Yzy36TT07yVkEKFQMQun9
   uJs28H0iT8XGWa5HwIRZelO+a7uk5FaT31fpmkXGvJ5AWqTOVG+AQgvz3
   4=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 13 Feb 2022 00:34:09 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2022 00:34:08 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Sun, 13 Feb 2022 00:34:07 -0800
Received: from jprakash-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Sun, 13 Feb 2022 00:34:00 -0800
From:   Jishnu Prakash <quic_jprakash@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <devicetree@vger.kernel.org>, <mka@chromium.org>,
        <dmitry.baryshkov@linaro.org>, <robh+dt@kernel.org>,
        <knaack.h@gmx.de>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <manivannan.sadhasivam@linaro.org>, <linus.walleij@linaro.org>,
        <quic_kgunda@quicinc.com>, <quic_aghayal@quicinc.com>,
        <daniel.lezcano@linaro.org>, <rui.zhang@intel.com>,
        <quic_subbaram@quicinc.com>, <jic23@kernel.org>,
        <amitk@kernel.org>, Thara Gopinath <thara.gopinath@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linux-arm-msm-owner@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        Jishnu Prakash <quic_jprakash@quicinc.com>
Subject: [PATCH V5 3/4] thermal: qcom: Add support for multiple generations of devices
Date:   Sun, 13 Feb 2022 14:03:10 +0530
Message-ID: <1644741191-12039-4-git-send-email-quic_jprakash@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1644741191-12039-1-git-send-email-quic_jprakash@quicinc.com>
References: <1644741191-12039-1-git-send-email-quic_jprakash@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Refactor code to support multiple generations of ADC_TM devices
by defining gen number, irq name and disable, configure, isr and
init APIs in the individual data structs.

Signed-off-by: Jishnu Prakash <quic_jprakash@quicinc.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/thermal/qcom/qcom-spmi-adc-tm5.c | 82 ++++++++++++++++++++------------
 1 file changed, 51 insertions(+), 31 deletions(-)

diff --git a/drivers/thermal/qcom/qcom-spmi-adc-tm5.c b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
index 824671c..6d8fcf2 100644
--- a/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
+++ b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
@@ -78,11 +78,10 @@ enum adc5_timer_select {
 	ADC5_TIMER_SEL_NONE,
 };
 
-struct adc_tm5_data {
-	const u32	full_scale_code_volt;
-	unsigned int	*decimation;
-	unsigned int	*hw_settle;
-	bool		is_hc;
+enum adc5_gen {
+	ADC_TM5,
+	ADC_TM_HC,
+	ADC_TM5_MAX
 };
 
 enum adc_tm5_cal_method {
@@ -92,6 +91,19 @@ enum adc_tm5_cal_method {
 };
 
 struct adc_tm5_chip;
+struct adc_tm5_channel;
+
+struct adc_tm5_data {
+	const u32 full_scale_code_volt;
+	unsigned int *decimation;
+	unsigned int *hw_settle;
+	int (*disable_channel)(struct adc_tm5_channel *channel);
+	int (*configure)(struct adc_tm5_channel *channel, int low, int high);
+	irqreturn_t (*isr)(int irq, void *data);
+	int (*init)(struct adc_tm5_chip *chip);
+	char *irq_name;
+	int gen;
+};
 
 /**
  * struct adc_tm5_channel - ADC Thermal Monitoring channel data.
@@ -139,22 +151,6 @@ struct adc_tm5_chip {
 	u16			base;
 };
 
-static const struct adc_tm5_data adc_tm5_data_pmic = {
-	.full_scale_code_volt = 0x70e4,
-	.decimation = (unsigned int []) { 250, 420, 840 },
-	.hw_settle = (unsigned int []) { 15, 100, 200, 300, 400, 500, 600, 700,
-					 1000, 2000, 4000, 8000, 16000, 32000,
-					 64000, 128000 },
-};
-
-static const struct adc_tm5_data adc_tm_hc_data_pmic = {
-	.full_scale_code_volt = 0x70e4,
-	.decimation = (unsigned int []) { 256, 512, 1024 },
-	.hw_settle = (unsigned int []) { 0, 100, 200, 300, 400, 500, 600, 700,
-					 1000, 2000, 4000, 6000, 8000, 10000 },
-	.is_hc = true,
-};
-
 static int adc_tm5_read(struct adc_tm5_chip *adc_tm, u16 offset, u8 *data, int len)
 {
 	return regmap_bulk_read(adc_tm->regmap, adc_tm->base + offset, data, len);
@@ -343,14 +339,14 @@ static int adc_tm5_set_trips(void *data, int low, int high)
 		channel->channel, low, high);
 
 	if (high == INT_MAX && low <= -INT_MAX)
-		ret = adc_tm5_disable_channel(channel);
+		ret = chip->data->disable_channel(channel);
 	else
-		ret = adc_tm5_configure(channel, low, high);
+		ret = chip->data->configure(channel, low, high);
 
 	return ret;
 }
 
-static struct thermal_zone_of_device_ops adc_tm5_ops = {
+static struct thermal_zone_of_device_ops adc_tm5_thermal_ops = {
 	.get_temp = adc_tm5_get_temp,
 	.set_trips = adc_tm5_set_trips,
 };
@@ -366,7 +362,7 @@ static int adc_tm5_register_tzd(struct adc_tm5_chip *adc_tm)
 		tzd = devm_thermal_zone_of_sensor_register(adc_tm->dev,
 							   adc_tm->channels[i].channel,
 							   &adc_tm->channels[i],
-							   &adc_tm5_ops);
+							   &adc_tm5_thermal_ops);
 		if (IS_ERR(tzd)) {
 			if (PTR_ERR(tzd) == -ENODEV) {
 				dev_warn(adc_tm->dev, "thermal sensor on channel %d is not used\n",
@@ -526,6 +522,33 @@ static int adc_tm5_get_dt_channel_data(struct adc_tm5_chip *adc_tm,
 	return 0;
 }
 
+static const struct adc_tm5_data adc_tm5_data_pmic = {
+	.full_scale_code_volt = 0x70e4,
+	.decimation = (unsigned int []) { 250, 420, 840 },
+	.hw_settle = (unsigned int []) { 15, 100, 200, 300, 400, 500, 600, 700,
+					 1000, 2000, 4000, 8000, 16000, 32000,
+					 64000, 128000 },
+	.disable_channel = adc_tm5_disable_channel,
+	.configure = adc_tm5_configure,
+	.isr = adc_tm5_isr,
+	.init = adc_tm5_init,
+	.irq_name = "pm-adc-tm5",
+	.gen = ADC_TM5,
+};
+
+static const struct adc_tm5_data adc_tm_hc_data_pmic = {
+	.full_scale_code_volt = 0x70e4,
+	.decimation = (unsigned int []) { 256, 512, 1024 },
+	.hw_settle = (unsigned int []) { 0, 100, 200, 300, 400, 500, 600, 700,
+					 1000, 2000, 4000, 6000, 8000, 10000 },
+	.disable_channel = adc_tm5_disable_channel,
+	.configure = adc_tm5_configure,
+	.isr = adc_tm5_isr,
+	.init = adc_tm_hc_init,
+	.irq_name = "pm-adc-tm5",
+	.gen = ADC_TM_HC,
+};
+
 static int adc_tm5_get_dt_data(struct adc_tm5_chip *adc_tm, struct device_node *node)
 {
 	struct adc_tm5_channel *channels;
@@ -623,10 +646,7 @@ static int adc_tm5_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	if (adc_tm->data->is_hc)
-		ret = adc_tm_hc_init(adc_tm);
-	else
-		ret = adc_tm5_init(adc_tm);
+	ret = adc_tm->data->init(adc_tm);
 	if (ret) {
 		dev_err(dev, "adc-tm init failed\n");
 		return ret;
@@ -638,8 +658,8 @@ static int adc_tm5_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	return devm_request_threaded_irq(dev, irq, NULL, adc_tm5_isr,
-					 IRQF_ONESHOT, "pm-adc-tm5", adc_tm);
+	return devm_request_threaded_irq(dev, irq, NULL, adc_tm->data->isr,
+			IRQF_ONESHOT, adc_tm->data->irq_name, adc_tm);
 }
 
 static const struct of_device_id adc_tm5_match_table[] = {
-- 
2.7.4

