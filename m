Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7936C202C65
	for <lists+linux-iio@lfdr.de>; Sun, 21 Jun 2020 21:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730514AbgFUTgB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 21 Jun 2020 15:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730464AbgFUTgB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 21 Jun 2020 15:36:01 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9635C061794
        for <linux-iio@vger.kernel.org>; Sun, 21 Jun 2020 12:35:59 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id g139so7585604lfd.10
        for <linux-iio@vger.kernel.org>; Sun, 21 Jun 2020 12:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dlizlyDZxKQyiJjzJliE8l4pTIeamHje9eNU3A+fVoQ=;
        b=rTNj3AR8oNVSLtPwZPYIQEjiEvTB0g5iPwvOdMYfyqlvHnudO3gjce4gjNctdGJBGk
         bDd4F0i8UNjUFAc1D/Yo78teRltU2UEGzvzWBNsbxMgk+o/eFCDMll8ANADPoylqqkb/
         650yDV78rVbEmSLeAq9s8zNKrDYTIuLnlbblUS4cMsfm94gVRQFQ7SBSzaJ3W8GIg1cf
         oUbQliErK7owJxo0HYNw/1LLm9pZnRMWjOubm9Ud2EP4MSmfoQFis35vYq7aO88oawYk
         Z8eP4WGbcXkfcu98LM+AUEB4hYFnL1jbqd5hqrY/aVVWa2cPu+etM0EUC0LaPx9lnXU1
         GL+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dlizlyDZxKQyiJjzJliE8l4pTIeamHje9eNU3A+fVoQ=;
        b=pg1LIE2hII4bOdEI74Q61MiBcn8Cz1W6NEk242QVX5mONw5UCViDh69XneNO/V2j/q
         SIjXw6dOxBgufwRmW3AQj4HR0DsQ1FkCgC33/41IVt4zKHuFh0ciljT1wh1YCkPxuGqg
         C7h4g8KvDpkn7JoRW/FzO81oYhUpTIk/KhhOLMbS9EUfkbREvgz2AtqM3NFBxk7tKsg+
         GlYjkRhPF9g1cbPNevyBs+sWcxcvJ5DgHr4LwXYnFTy/+FgxrekzhJKkOeWCaPsNWdLI
         tt7uWeblHqXRSsl3Sn4p80cn6SQLE0UBz587QLt+2Wtr4OdCjYVV9H6lY4+do7SXNToQ
         xn4g==
X-Gm-Message-State: AOAM531080fKJht381ZwqUTUnfLGtYu8r7Pw8Cn8EYXT+KowsRQn5Db8
        5LKRmRmXMo0Sj8fLVRMNKvVqSQ==
X-Google-Smtp-Source: ABdhPJy3YcRcIX5tXbyfpXhsoM5/XgVk81giodzqsTqcuzwj2FtSQCctakrVWxGwjCRCSXnim6TRmw==
X-Received: by 2002:a05:6512:3226:: with SMTP id f6mr7811396lfe.180.1592768158257;
        Sun, 21 Jun 2020 12:35:58 -0700 (PDT)
Received: from eriador.lan ([188.162.65.109])
        by smtp.gmail.com with ESMTPSA id r13sm2917854lfp.80.2020.06.21.12.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2020 12:35:57 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>, linux-iio@vger.kernel.org
Subject: [PATCH 3/5] thermal: qcom: add support for adc-tm5 PMIC thermal monitor
Date:   Sun, 21 Jun 2020 22:35:47 +0300
Message-Id: <20200621193549.2070434-4-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200621193549.2070434-1-dmitry.baryshkov@linaro.org>
References: <20200621193549.2070434-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add support for Thermal Monitoring part of PMIC5. This part is closely
coupled with ADC, using it's channels directly. ADC-TM support
generating interrupts on ADC value crossing low or high voltage bounds,
which is used to support thermal trip points.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/iio/adc/qcom-vadc-common.c       |  67 +++
 drivers/iio/adc/qcom-vadc-common.h       |   3 +
 drivers/thermal/qcom/Kconfig             |  11 +
 drivers/thermal/qcom/Makefile            |   1 +
 drivers/thermal/qcom/qcom-spmi-adc-tm5.c | 617 +++++++++++++++++++++++
 5 files changed, 699 insertions(+)
 create mode 100644 drivers/thermal/qcom/qcom-spmi-adc-tm5.c

diff --git a/drivers/iio/adc/qcom-vadc-common.c b/drivers/iio/adc/qcom-vadc-common.c
index ffa578ce76db..e470beb8c6f9 100644
--- a/drivers/iio/adc/qcom-vadc-common.c
+++ b/drivers/iio/adc/qcom-vadc-common.c
@@ -176,6 +176,47 @@ static int qcom_vadc_map_voltage_temp(const struct vadc_map_pt *pts,
 	return 0;
 }
 
+static s32 qcom_vadc_map_temp_voltage(const struct vadc_map_pt *pts,
+				      u32 tablesize, int input)
+{
+	bool descending = 1;
+	u32 i = 0;
+
+	/* Check if table is descending or ascending */
+	if (tablesize > 1) {
+		if (pts[0].y < pts[1].y)
+			descending = 0;
+	}
+
+	while (i < tablesize) {
+		if ((descending) && (pts[i].y < input)) {
+			/* table entry is less than measured*/
+			 /* value and table is descending, stop */
+			break;
+		} else if ((!descending) &&
+				(pts[i].y > input)) {
+			/* table entry is greater than measured*/
+			/*value and table is ascending, stop */
+			break;
+		}
+		i++;
+	}
+
+	if (i == 0)
+		return pts[0].x;
+	if (i == tablesize)
+		return pts[tablesize - 1].x;
+
+	/* result is between search_index and search_index-1 */
+	/* interpolate linearly */
+	return (((s32)((pts[i].x - pts[i - 1].x) *
+		(input - pts[i - 1].y)) /
+		(pts[i].y - pts[i - 1].y)) +
+		pts[i - 1].x);
+
+	return 0;
+}
+
 static void qcom_vadc_scale_calib(const struct vadc_linear_graph *calib_graph,
 				  u16 adc_code,
 				  bool absolute,
@@ -273,6 +314,19 @@ static int qcom_vadc_scale_chg_temp(const struct vadc_linear_graph *calib_graph,
 	return 0;
 }
 
+static u16 qcom_vadc_scale_voltage_code(int voltage,
+				const struct vadc_prescale_ratio *prescale,
+				const u32 full_scale_code_volt,
+				unsigned int factor)
+{
+	s64 volt = voltage, adc_vdd_ref_mv = 1875;
+
+	volt *= prescale->num * factor * full_scale_code_volt;
+	volt = div64_s64(volt, (s64)prescale->den * adc_vdd_ref_mv * 1000);
+
+	return volt;
+}
+
 static int qcom_vadc_scale_code_voltage_factor(u16 adc_code,
 				const struct vadc_prescale_ratio *prescale,
 				const struct adc5_data *data,
@@ -396,6 +450,19 @@ int qcom_vadc_scale(enum vadc_scale_fn_type scaletype,
 }
 EXPORT_SYMBOL(qcom_vadc_scale);
 
+u16 qcom_adc_tm5_temp_volt_scale(unsigned int prescale_ratio,
+		u32 full_scale_code_volt, int temp)
+{
+	const struct vadc_prescale_ratio *prescale = &adc5_prescale_ratios[prescale_ratio];
+	s32 voltage;
+
+	voltage = qcom_vadc_map_temp_voltage(adcmap_100k_104ef_104fb_1875_vref,
+				 ARRAY_SIZE(adcmap_100k_104ef_104fb_1875_vref),
+				 temp);
+	return qcom_vadc_scale_voltage_code(voltage, prescale, full_scale_code_volt, 1000);
+}
+EXPORT_SYMBOL(qcom_adc_tm5_temp_volt_scale);
+
 int qcom_adc5_hw_scale(enum vadc_scale_fn_type scaletype,
 		    unsigned int prescale_ratio,
 		    const struct adc5_data *data,
diff --git a/drivers/iio/adc/qcom-vadc-common.h b/drivers/iio/adc/qcom-vadc-common.h
index 2c65ddc98696..978820443d8a 100644
--- a/drivers/iio/adc/qcom-vadc-common.h
+++ b/drivers/iio/adc/qcom-vadc-common.h
@@ -157,6 +157,9 @@ int qcom_adc5_hw_scale(enum vadc_scale_fn_type scaletype,
 		    const struct adc5_data *data,
 		    u16 adc_code, int *result_mdec);
 
+u16 qcom_adc_tm5_temp_volt_scale(unsigned int prescale_ratio,
+		u32 full_scale_code_volt, int temp);
+
 int qcom_adc5_prescaling_from_dt(u32 num, u32 den);
 
 int qcom_adc5_hw_settle_time_from_dt(u32 value,
diff --git a/drivers/thermal/qcom/Kconfig b/drivers/thermal/qcom/Kconfig
index aa9c1d80fae4..c61df55760e9 100644
--- a/drivers/thermal/qcom/Kconfig
+++ b/drivers/thermal/qcom/Kconfig
@@ -20,3 +20,14 @@ config QCOM_SPMI_TEMP_ALARM
 	  trip points. The temperature reported by the thermal sensor reflects the
 	  real time die temperature if an ADC is present or an estimate of the
 	  temperature based upon the over temperature stage value.
+
+config QCOM_SPMI_ADC_TM5
+	tristate "Qualcomm SPMI PMIC Thermal Monitor ADC5"
+	depends on OF && SPMI && IIO
+	select REGMAP_SPMI
+	select QCOM_VADC_COMMON
+	help
+	  This enables the thermal driver for the ADC thermal monitoring
+	  device. It shows up as a thermal zone with multiple trip points.
+	  Thermal client sets threshold temperature for both warm and cool and
+	  gets updated when a threshold is reached.
diff --git a/drivers/thermal/qcom/Makefile b/drivers/thermal/qcom/Makefile
index ec86eef7f6a6..5b9445a3fd26 100644
--- a/drivers/thermal/qcom/Makefile
+++ b/drivers/thermal/qcom/Makefile
@@ -4,3 +4,4 @@ obj-$(CONFIG_QCOM_TSENS)	+= qcom_tsens.o
 qcom_tsens-y			+= tsens.o tsens-v2.o tsens-v1.o tsens-v0_1.o \
 				   tsens-8960.o
 obj-$(CONFIG_QCOM_SPMI_TEMP_ALARM)	+= qcom-spmi-temp-alarm.o
+obj-$(CONFIG_QCOM_SPMI_ADC_TM5)	+= qcom-spmi-adc-tm5.o
diff --git a/drivers/thermal/qcom/qcom-spmi-adc-tm5.c b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
new file mode 100644
index 000000000000..ebfe0c9fbf96
--- /dev/null
+++ b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
@@ -0,0 +1,617 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2012-2020, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2020 Linaro Limited
+ */
+
+#include <linux/iio/consumer.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/thermal.h>
+
+#include "../../iio/adc/qcom-vadc-common.h"
+
+#define ADC5_MAX_CHANNEL                        0xc0
+#define ADC_TM5_NUM_CHANNELS		8
+#define ADC_TM5_TIMER1			3 /* 3.9ms */
+#define ADC_TM5_TIMER2			10 /* 1 second */
+#define ADC_TM5_TIMER3			4 /* 4 second */
+
+#define ADC_TM5_STATUS_LOW			0x0a
+
+#define ADC_TM5_STATUS_HIGH			0x0b
+
+#define ADC_TM5_NUM_BTM				0x0f
+
+#define ADC_TM5_ADC_DIG_PARAM			0x42
+
+#define ADC_TM5_FAST_AVG_CTL			0x43
+#define ADC_TM5_FAST_AVG_EN			BIT(7)
+
+#define ADC_TM5_MEAS_INTERVAL_CTL		0x44
+
+#define ADC_TM5_MEAS_INTERVAL_CTL2		0x45
+#define ADC_TM5_MEAS_INTERVAL_CTL2_SHIFT		0x4
+#define ADC_TM5_MEAS_INTERVAL_CTL2_MASK		0xf0
+#define ADC_TM5_MEAS_INTERVAL_CTL3_MASK		0xf
+
+#define ADC_TM5_Mn_EN(n)			((n * 8) + 0x67)
+#define ADC_TM5_Mn_MEAS_EN			BIT(7)
+#define ADC_TM5_Mn_HIGH_THR_INT_EN		BIT(1)
+#define ADC_TM5_Mn_LOW_THR_INT_EN		BIT(0)
+
+#define ADC_TM5_Mn_ADC_CH_SEL_CTL(n)		((n * 8) + 0x60)
+#define ADC_TM5_Mn_LOW_THR0(n)			((n * 8) + 0x61)
+#define ADC_TM5_Mn_LOW_THR1(n)			((n * 8) + 0x62)
+#define ADC_TM5_Mn_HIGH_THR0(n)			((n * 8) + 0x63)
+#define ADC_TM5_Mn_HIGH_THR1(n)			((n * 8) + 0x64)
+#define ADC_TM5_Mn_MEAS_INTERVAL_CTL(n)		((n * 8) + 0x65)
+#define ADC_TM5_Mn_CTL(n)			((n * 8) + 0x66)
+#define ADC_TM5_CTL_HW_SETTLE_DELAY_MASK		0xf
+#define ADC_TM5_CTL_CAL_SEL			0x30
+#define ADC_TM5_CTL_CAL_SEL_MASK_SHIFT		4
+#define ADC_TM5_CTL_CAL_VAL			0x40
+
+enum adc5_timer_select {
+	ADC5_TIMER_SEL_1 = 0,
+	ADC5_TIMER_SEL_2,
+	ADC5_TIMER_SEL_3,
+	ADC5_TIMER_SEL_NONE,
+};
+
+struct adc_tm5_data {
+	const u32	full_scale_code_volt;
+	unsigned int	*decimation;
+	unsigned int	*hw_settle;
+};
+
+enum adc_tm5_cal_method {
+	ADC_TM5_NO_CAL = 0,
+	ADC_TM5_RATIOMETRIC_CAL,
+	ADC_TM5_ABSOLUTE_CAL
+};
+
+struct adc_tm5_chip;
+
+struct adc_tm5_channel {
+	unsigned int		channel;
+	unsigned int		adc_channel;
+	enum adc_tm5_cal_method	cal_method;
+	unsigned int		prescale;
+	unsigned int		hw_settle_time;
+	struct iio_channel	*iio;
+	struct adc_tm5_chip	*chip;
+	struct thermal_zone_device *tzd;
+};
+
+struct adc_tm5_chip {
+	struct regmap		*regmap;
+	struct device		*dev;
+	struct adc_tm5_channel	*channels;
+	const struct adc_tm5_data	*data;
+	spinlock_t		reg_lock;
+	unsigned int		decimation;
+	unsigned int		avg_samples;
+	unsigned int		timer1;
+	unsigned int		timer2;
+	unsigned int		timer3;
+	unsigned int		nchannels;
+	u16			base;
+};
+
+static const struct adc_tm5_data adc_tm5_data_pmic = {
+	.full_scale_code_volt = 0x70e4,
+	.decimation = (unsigned int []) {250, 420, 840},
+	.hw_settle = (unsigned int []) {15, 100, 200, 300, 400, 500, 600, 700,
+					1, 2, 4, 8, 16, 32, 64, 128},
+};
+
+static const struct of_device_id adc_tm5_match_table[] = {
+	{
+		.compatible = "qcom,spmi-adc-tm5",
+		.data = &adc_tm5_data_pmic,
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, adc_tm5_match_table);
+
+static int adc_tm5_read(struct adc_tm5_chip *adc_tm, u16 offset, u8 *data, int len)
+{
+	return regmap_bulk_read(adc_tm->regmap, adc_tm->base + offset, data, len);
+}
+
+static int adc_tm5_write(struct adc_tm5_chip *adc_tm, u16 offset, u8 *data, int len)
+{
+	return regmap_bulk_write(adc_tm->regmap, adc_tm->base + offset, data, len);
+}
+
+static int adc_tm5_reg_update(struct adc_tm5_chip *adc_tm, u16 offset, u8 mask, u8 val)
+{
+	return regmap_write_bits(adc_tm->regmap, adc_tm->base + offset, mask, val);
+}
+
+static irqreturn_t adc_tm5_isr(int irq, void *data)
+{
+	struct adc_tm5_chip *chip = data;
+	u8 status_low, status_high, ctl;
+	int ret = 0, i = 0;
+	unsigned long flags;
+
+	ret = adc_tm5_read(chip, ADC_TM5_STATUS_LOW, &status_low, 1);
+	if (ret < 0) {
+		dev_err(chip->dev, "read status low failed with %d\n", ret);
+		return IRQ_HANDLED;
+	}
+
+	ret = adc_tm5_read(chip, ADC_TM5_STATUS_HIGH, &status_high, 1);
+	if (ret < 0) {
+		dev_err(chip->dev, "read status high failed with %d\n", ret);
+		return IRQ_HANDLED;
+	}
+
+	for (i = 0; i < chip->nchannels; i++) {
+		bool upper_set = false, lower_set = false;
+		unsigned int ch = chip->channels[i].channel;
+
+		if (!chip->channels[i].tzd) {
+			dev_err(chip->dev, "thermal device not found\n");
+			continue;
+		}
+
+		spin_lock_irqsave(&chip->reg_lock, flags);
+		ret = adc_tm5_read(chip, ADC_TM5_Mn_EN(ch), &ctl, 1);
+		spin_unlock_irqrestore(&chip->reg_lock, flags);
+
+		if (ret) {
+			dev_err(chip->dev, "ctl read failed with %d\n", ret);
+			goto fail;
+		}
+
+		if ((status_low & BIT(ch)) && (ctl & ADC_TM5_Mn_MEAS_EN)
+				&& (ctl & ADC_TM5_Mn_LOW_THR_INT_EN))
+			lower_set = true;
+
+		if ((status_high & BIT(ch)) && (ctl & ADC_TM5_Mn_MEAS_EN) &&
+					(ctl & ADC_TM5_Mn_HIGH_THR_INT_EN))
+			upper_set = true;
+fail:
+
+		if (upper_set || lower_set)
+			thermal_zone_device_update(chip->channels[i].tzd,
+					THERMAL_EVENT_UNSPECIFIED);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int adc_tm5_get_temp(void *data, int *temp)
+{
+	struct adc_tm5_channel *channel = data;
+	int ret, milli_celsius;
+
+	if (!channel || !channel->iio)
+		return -EINVAL;
+
+	ret = iio_read_channel_processed(channel->iio, &milli_celsius);
+	if (ret < 0)
+		return ret;
+
+	*temp = milli_celsius;
+
+	return 0;
+}
+
+static int adc_tm5_disable_channel(struct adc_tm5_channel *channel)
+{
+	struct adc_tm5_chip *chip = channel->chip;
+	unsigned int reg = ADC_TM5_Mn_EN(channel->channel);
+
+	return adc_tm5_reg_update(chip, reg,
+			ADC_TM5_Mn_MEAS_EN | ADC_TM5_Mn_HIGH_THR_INT_EN | ADC_TM5_Mn_LOW_THR_INT_EN,
+			0);
+}
+
+static int adc_tm5_configure(struct adc_tm5_channel *channel, u8 *low_thr, u8 *high_thr)
+{
+	struct adc_tm5_chip *chip = channel->chip;
+	u8 buf[8], cal_method;
+	u16 reg = ADC_TM5_Mn_ADC_CH_SEL_CTL(channel->channel);
+	int ret = 0;
+
+	ret = adc_tm5_read(chip, reg, buf, 8);
+	if (ret < 0) {
+		dev_err(chip->dev, "block read failed with %d\n", ret);
+		return ret;
+	}
+
+	/* Update ADC channel select */
+	buf[0] = channel->adc_channel;
+
+	if (low_thr) {
+		buf[1] = low_thr[0];
+		buf[2] = low_thr[1];
+		buf[7] |= ADC_TM5_Mn_LOW_THR_INT_EN;
+	}
+
+	if (high_thr) {
+		buf[3] = high_thr[0];
+		buf[4] = high_thr[1];
+		buf[7] |= ADC_TM5_Mn_HIGH_THR_INT_EN;
+	}
+
+	/* Update timer select */
+	buf[5] = ADC5_TIMER_SEL_2;
+
+	/* Set calibration select, hw_settle delay */
+	cal_method = (u8) (channel->cal_method << ADC_TM5_CTL_CAL_SEL_MASK_SHIFT);
+	buf[6] &= (u8) ~ADC_TM5_CTL_HW_SETTLE_DELAY_MASK;
+	buf[6] |= (u8) channel->hw_settle_time;
+	buf[6] &= (u8) ~ADC_TM5_CTL_CAL_SEL;
+	buf[6] |= (u8) cal_method;
+
+	buf[7] |= ADC_TM5_Mn_MEAS_EN;
+
+	ret = adc_tm5_write(chip, reg, buf, 8);
+	if (ret < 0) {
+		dev_err(chip->dev, "buf write failed\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int adc_tm5_set_trip_temp(void *data,
+		int low_temp, int high_temp)
+{
+	struct adc_tm5_channel *channel = data;
+	struct adc_tm5_chip *chip;
+	u8 trip_high_thr[2], trip_low_thr[2];
+	u8 *trip_high_ptr = NULL, *trip_low_ptr = NULL;
+	int ret;
+	unsigned long flags;
+
+	if (!channel)
+		return -EINVAL;
+
+	dev_info(channel->chip->dev, "%d:low_temp(mdegC):%d, high_temp(mdegC):%d\n",
+			channel->channel, low_temp, high_temp);
+	chip = channel->chip;
+
+	/* Warm temperature corresponds to low voltage threshold */
+	if (high_temp != INT_MAX) {
+		u16 adc_code = qcom_adc_tm5_temp_volt_scale(channel->prescale,
+				chip->data->full_scale_code_volt, high_temp);
+
+		trip_low_thr[0] = adc_code & 0xff;
+		trip_low_thr[1] = adc_code >> 8;
+		trip_low_ptr = trip_low_thr;
+	}
+
+	/* Cool temperature corresponds to high voltage threshold */
+	if (low_temp != -INT_MAX) {
+		u16 adc_code = qcom_adc_tm5_temp_volt_scale(channel->prescale,
+				chip->data->full_scale_code_volt, low_temp);
+
+		trip_high_thr[0] = adc_code & 0xff;
+		trip_high_thr[1] = adc_code >> 8;
+		trip_high_ptr = trip_high_thr;
+	}
+
+	spin_lock_irqsave(&chip->reg_lock, flags);
+	if (high_temp == INT_MAX && low_temp == INT_MIN)
+		ret = adc_tm5_disable_channel(channel);
+	else
+		ret = adc_tm5_configure(channel, trip_low_ptr, trip_high_ptr);
+
+	spin_unlock_irqrestore(&chip->reg_lock, flags);
+
+	return ret;
+}
+
+
+static struct thermal_zone_of_device_ops adc_tm5_ops = {
+	.get_temp = adc_tm5_get_temp,
+	.set_trips = adc_tm5_set_trip_temp,
+};
+
+static int adc_tm5_register_tzd(struct adc_tm5_chip *adc_tm)
+{
+	unsigned int i;
+	struct thermal_zone_device *tzd;
+
+	for (i = 0; i < adc_tm->nchannels; i++) {
+		adc_tm->channels[i].chip = adc_tm;
+
+		tzd = devm_thermal_zone_of_sensor_register(
+				adc_tm->dev, adc_tm->channels[i].channel,
+				&adc_tm->channels[i], &adc_tm5_ops);
+		if (IS_ERR(tzd)) {
+			dev_err(adc_tm->dev, "Error registering TZ zone:%ld for channel:%d\n",
+				PTR_ERR(tzd), adc_tm->channels[i].channel);
+			continue;
+		}
+		adc_tm->channels[i].tzd = tzd;
+	}
+
+	return 0;
+}
+
+static int adc_tm5_init(struct adc_tm5_chip *chip)
+{
+	u8 buf[4], channels_available, meas_int_timer_2_3 = 0;
+	int ret;
+	unsigned int i;
+
+	ret = adc_tm5_read(chip, ADC_TM5_NUM_BTM, &channels_available, 1);
+	if (ret < 0) {
+		dev_err(chip->dev, "read failed for BTM channels\n");
+		return ret;
+	}
+
+	ret = adc_tm5_read(chip, ADC_TM5_ADC_DIG_PARAM, buf, 4);
+	if (ret < 0) {
+		dev_err(chip->dev, "block read failed with %d\n", ret);
+		return ret;
+	}
+
+	/* Select decimation */
+	buf[0] = chip->decimation;
+
+	/* Select number of samples in fast average mode */
+	buf[1] = chip->avg_samples | ADC_TM5_FAST_AVG_EN;
+
+	/* Select timer1 */
+	buf[2] = chip->timer1;
+
+	/* Select timer2 and timer3 */
+	meas_int_timer_2_3 |= chip->timer2 <<
+				ADC_TM5_MEAS_INTERVAL_CTL2_SHIFT;
+	meas_int_timer_2_3 |= chip->timer3;
+	buf[3] = meas_int_timer_2_3;
+
+	ret = adc_tm5_write(chip,
+			ADC_TM5_ADC_DIG_PARAM, buf, 4);
+	if (ret < 0)
+		dev_err(chip->dev, "block write failed with %d\n", ret);
+
+	for (i = 0; i < chip->nchannels; i++) {
+		if (chip->channels[i].channel >= channels_available) {
+			dev_err(chip->dev, "Invalid channel %d\n", chip->channels[i].channel);
+			return -EINVAL;
+		}
+	}
+
+	return ret;
+}
+
+static int adc_tm5_get_dt_channel_data(struct adc_tm5_chip *adc_tm,
+				       struct adc_tm5_channel *prop,
+				       struct device_node *node,
+				       const struct adc_tm5_data *data)
+{
+	const char *name = node->name;
+	u32 chan, value, varr[2];
+	int ret;
+	struct device *dev = adc_tm->dev;
+
+	ret = of_property_read_u32(node, "reg", &chan);
+	if (ret) {
+		dev_err(dev, "invalid channel number %s\n", name);
+		return ret;
+	}
+
+	if (chan >= ADC_TM5_NUM_CHANNELS) {
+		dev_err(dev, "%s invalid channel number %d\n", name, chan);
+		return -EINVAL;
+	}
+
+	/* the channel has DT description */
+	prop->channel = chan;
+
+	ret = of_property_read_u32(node, "qcom,adc-channel", &chan);
+	if (ret) {
+		dev_err(dev, "invalid channel number %s\n", name);
+		return ret;
+	}
+	if (chan >= ADC5_MAX_CHANNEL) {
+		dev_err(dev, "%s invalid ADC channel number %d\n", name, chan);
+		return ret;
+	}
+	prop->adc_channel = chan;
+
+	prop->iio = devm_iio_channel_get(adc_tm->dev, name);
+	if (IS_ERR(prop->iio)) {
+		ret = PTR_ERR(prop->iio);
+		prop->iio = NULL;
+		dev_err(dev, "error getting channel %s: %d\n", name, ret);
+		return ret;
+	}
+
+	ret = of_property_read_u32_array(node, "qcom,pre-scaling", varr, 2);
+	if (!ret) {
+		ret = qcom_adc5_prescaling_from_dt(varr[0], varr[1]);
+		if (ret < 0) {
+			dev_err(dev, "%02x invalid pre-scaling <%d %d>\n",
+				chan, varr[0], varr[1]);
+			return ret;
+		}
+		prop->prescale = ret;
+	} else {
+		prop->prescale = 0; /*1:1 is index 0 */
+	}
+
+	ret = of_property_read_u32(node, "qcom,hw-settle-time", &value);
+	if (!ret) {
+		ret = qcom_adc5_hw_settle_time_from_dt(value,
+							data->hw_settle);
+		if (ret < 0) {
+			dev_err(dev, "%02x invalid hw-settle-time %d us\n",
+				chan, value);
+			return ret;
+		}
+		prop->hw_settle_time = ret;
+	} else {
+		prop->hw_settle_time = VADC_DEF_HW_SETTLE_TIME;
+	}
+
+	if (of_property_read_bool(node, "qcom,ratiometric"))
+		prop->cal_method = ADC_TM5_RATIOMETRIC_CAL;
+	else
+		prop->cal_method = ADC_TM5_ABSOLUTE_CAL;
+
+	dev_dbg(dev, "%02x name %s\n", chan, name);
+
+	return 0;
+}
+
+static int adc_tm5_get_dt_data(struct adc_tm5_chip *adc_tm, struct device_node *node)
+{
+	struct adc_tm5_channel *channels;
+	struct device_node *child;
+	unsigned int index = 0;
+	const struct of_device_id *id;
+	const struct adc_tm5_data *data;
+	u32 value;
+	int ret;
+	struct device *dev = adc_tm->dev;
+
+	adc_tm->nchannels = of_get_available_child_count(node);
+	if (!adc_tm->nchannels)
+		return -EINVAL;
+
+	adc_tm->channels = devm_kcalloc(adc_tm->dev, adc_tm->nchannels,
+					sizeof(*adc_tm->channels), GFP_KERNEL);
+	if (!adc_tm->channels)
+		return -ENOMEM;
+
+	channels = adc_tm->channels;
+
+	id = of_match_node(adc_tm5_match_table, node);
+	if (id)
+		data = id->data;
+	else
+		data = &adc_tm5_data_pmic;
+	adc_tm->data = data;
+
+	ret = of_property_read_u32(node, "qcom,decimation", &value);
+	if (!ret) {
+		ret = qcom_adc5_decimation_from_dt(value, data->decimation);
+		if (ret < 0) {
+			dev_err(dev, "invalid decimation %d\n",
+				value);
+			return ret;
+		}
+		adc_tm->decimation = ret;
+	} else {
+		adc_tm->decimation = ADC5_DECIMATION_DEFAULT;
+	}
+
+	ret = of_property_read_u32(node, "qcom,avg-samples", &value);
+	if (!ret) {
+		ret = qcom_adc5_avg_samples_from_dt(value);
+		if (ret < 0) {
+			dev_err(dev, "invalid avg-samples %d\n",
+				value);
+			return ret;
+		}
+		adc_tm->avg_samples = ret;
+	} else {
+		adc_tm->avg_samples = VADC_DEF_AVG_SAMPLES;
+	}
+
+	adc_tm->timer1 = ADC_TM5_TIMER1;
+	adc_tm->timer2 = ADC_TM5_TIMER2;
+	adc_tm->timer3 = ADC_TM5_TIMER3;
+
+	for_each_available_child_of_node(node, child) {
+		ret = adc_tm5_get_dt_channel_data(adc_tm, channels, child, data);
+		if (ret) {
+			of_node_put(child);
+			return ret;
+		}
+
+		channels++;
+		index++;
+	}
+
+	return 0;
+}
+
+static int adc_tm5_probe(struct platform_device *pdev)
+{
+	struct device_node *node = pdev->dev.of_node;
+	struct device *dev = &pdev->dev;
+	struct adc_tm5_chip *adc_tm;
+	struct regmap *regmap;
+	int ret, irq;
+	u32 reg;
+
+	regmap = dev_get_regmap(dev->parent, NULL);
+	if (!regmap)
+		return -ENODEV;
+
+	ret = of_property_read_u32(node, "reg", &reg);
+	if (ret < 0)
+		return ret;
+
+	adc_tm = devm_kzalloc(&pdev->dev, sizeof(*adc_tm), GFP_KERNEL);
+	if (!adc_tm)
+		return -ENOMEM;
+
+	adc_tm->regmap = regmap;
+	adc_tm->dev = dev;
+	adc_tm->base = reg;
+	spin_lock_init(&adc_tm->reg_lock);
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		dev_err(dev, "get_irq failed: %d\n", irq);
+		return irq;
+	}
+
+	ret = adc_tm5_get_dt_data(adc_tm, node);
+	if (ret) {
+		dev_err(dev, "get dt data failed: %d\n", ret);
+		return ret;
+	}
+
+	ret = adc_tm5_init(adc_tm);
+	if (ret) {
+		dev_err(dev, "adc-tm init failed\n");
+		return ret;
+	}
+
+	ret = adc_tm5_register_tzd(adc_tm);
+
+	ret = devm_request_irq(dev, irq, adc_tm5_isr, 0,
+			       "pm-adc-tm5", adc_tm);
+	if (ret)
+		return ret;
+
+	platform_set_drvdata(pdev, adc_tm);
+
+	return 0;
+}
+
+static int adc_tm5_remove(struct platform_device *pdev)
+{
+	return 0;
+}
+
+static struct platform_driver adc_tm5_driver = {
+	.driver = {
+		.name = "spmi-adc-tm5",
+		.of_match_table = adc_tm5_match_table,
+	},
+	.probe = adc_tm5_probe,
+	.remove = adc_tm5_remove,
+};
+module_platform_driver(adc_tm5_driver);
+
+MODULE_ALIAS("platform:spmi-adc-tm5");
+MODULE_DESCRIPTION("SPMI PMIC Thermal Monitor ADC driver");
+MODULE_LICENSE("GPL v2");
-- 
2.27.0

