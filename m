Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA96C286097
	for <lists+linux-iio@lfdr.de>; Wed,  7 Oct 2020 15:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728573AbgJGNzE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 7 Oct 2020 09:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728565AbgJGNy5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 7 Oct 2020 09:54:57 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5803FC0613D4
        for <linux-iio@vger.kernel.org>; Wed,  7 Oct 2020 06:54:56 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id a4so2032701lji.12
        for <linux-iio@vger.kernel.org>; Wed, 07 Oct 2020 06:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2SwvCsmVaQ8BzOAdjunvw5oR5WJb6tkkbp4V6so2UzE=;
        b=kA2rDSPyVattVqVmcoda6L4qxdbKZm6X+/pX43p5kbA1sMVlPq7h4ci59L6+r1gG6m
         2m9uKBnjePNX+3ZEXpBjmPgcJhAMGEkuZpAsAcXduGI0OiasoDL9nsph3VHD3fJ+8yFD
         4oGUgbcpS34rL4U+0o89ZYKzXWEXHxnUliE44e75UjwauNgW2gWzD0FfEa2ST0BBe8Ph
         XFTq6SSZ2dzzbprz1yS9+gqBCleT+w6GKiCKWLrCwBcMwCKwB4VDN1sE64pZEejt23dj
         ry46tfjistlKm/jCnoEV3QGz0Cwquk0vzMkWe2YNnUJbtXR7C7V+HB8pp3JtWSRzytR/
         iQxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2SwvCsmVaQ8BzOAdjunvw5oR5WJb6tkkbp4V6so2UzE=;
        b=s81buzoWdq8kYIPql9nvu8FfUF8ny6OpyD3REgBcIrTSyaktZnP6PUK5JCKAnY2Ysk
         A7YhdKhkUn/dxab57FbTkbEeKaZ1JUFO81p2QBEKIxdcPGLYBRQKntPS+FiL/OWdZNRo
         Oqaq+PbDTQfpML0/O5Fjrqw+8JlPn3WmYMk+4AoyAvzPhxpY7oA0k3y79fzz3IhQI9j+
         oI1cMPammEgaxUYWxIdjvq39lg473DHm8wDcAjgou3T+wul5dmv3FxtZBu8KChIe9U/L
         JDZXtP+ftgn4KpD3DT9NO7ZS03Qs/du0AQ2SvbqTBVwsWTpQ1UApaUKPneioewP9tC8C
         dnnw==
X-Gm-Message-State: AOAM530+O/OO5n/tAkLNEzg6gVcPTnzLdEzf4LWnsv6g3tBLQ1XMjAps
        v+8fjTGrDGaGc53bmlaEG1QWeA==
X-Google-Smtp-Source: ABdhPJyqHi1dnqx40o5wPshAlIDM/OAqCMVGCO6WgGyEwYjIgQ4qPH1JG5qS8VZfycLrqXwnTlg2Mw==
X-Received: by 2002:a05:651c:c1:: with SMTP id 1mr1209022ljr.60.1602078894573;
        Wed, 07 Oct 2020 06:54:54 -0700 (PDT)
Received: from localhost.localdomain ([188.162.65.250])
        by smtp.gmail.com with ESMTPSA id n3sm339768lfq.274.2020.10.07.06.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 06:54:53 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Jishnu Prakash <jprakash@qti.qualcomm.com>
Subject: [PATCH v7 07/10] thermal: qcom: add support for adc-tm5 PMIC thermal monitor
Date:   Wed,  7 Oct 2020 16:54:30 +0300
Message-Id: <20201007135433.1041979-8-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201007135433.1041979-1-dmitry.baryshkov@linaro.org>
References: <20201007135433.1041979-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add support for Thermal Monitoring part of PMIC5. This part is closely
coupled with ADC, using it's channels directly. ADC-TM support
generating interrupts on ADC value crossing low or high voltage bounds,
which is used to support thermal trip points.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/iio/adc/qcom-vadc-common.c       |  62 +++
 drivers/iio/adc/qcom-vadc-common.h       |   3 +
 drivers/thermal/qcom/Kconfig             |  11 +
 drivers/thermal/qcom/Makefile            |   1 +
 drivers/thermal/qcom/qcom-spmi-adc-tm5.c | 622 +++++++++++++++++++++++
 5 files changed, 699 insertions(+)
 create mode 100644 drivers/thermal/qcom/qcom-spmi-adc-tm5.c

diff --git a/drivers/iio/adc/qcom-vadc-common.c b/drivers/iio/adc/qcom-vadc-common.c
index 40d77b3af1bb..e58e393b8713 100644
--- a/drivers/iio/adc/qcom-vadc-common.c
+++ b/drivers/iio/adc/qcom-vadc-common.c
@@ -377,6 +377,42 @@ static int qcom_vadc_map_voltage_temp(const struct vadc_map_pt *pts,
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
+		if (descending && pts[i].y < input) {
+			/* table entry is less than measured*/
+			 /* value and table is descending, stop */
+			break;
+		} else if ((!descending) && pts[i].y > input) {
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
+	return fixp_linear_interpolate(pts[i - 1].y, pts[i - 1].x,
+			pts[i].y, pts[i].x, input);
+}
+
 static void qcom_vadc_scale_calib(const struct vadc_linear_graph *calib_graph,
 				  u16 adc_code,
 				  bool absolute,
@@ -474,6 +510,19 @@ static int qcom_vadc_scale_chg_temp(const struct vadc_linear_graph *calib_graph,
 	return 0;
 }
 
+static u16 qcom_vadc_scale_voltage_code(int voltage,
+					const struct vadc_prescale_ratio *prescale,
+					const u32 full_scale_code_volt,
+					unsigned int factor)
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
@@ -658,6 +707,19 @@ int qcom_vadc_scale(enum vadc_scale_fn_type scaletype,
 }
 EXPORT_SYMBOL(qcom_vadc_scale);
 
+u16 qcom_adc_tm5_temp_volt_scale(unsigned int prescale_ratio,
+				 u32 full_scale_code_volt, int temp)
+{
+	const struct vadc_prescale_ratio *prescale = &adc5_prescale_ratios[prescale_ratio];
+	s32 voltage;
+
+	voltage = qcom_vadc_map_temp_voltage(adcmap_100k_104ef_104fb_1875_vref,
+					     ARRAY_SIZE(adcmap_100k_104ef_104fb_1875_vref),
+					     temp);
+	return qcom_vadc_scale_voltage_code(voltage, prescale, full_scale_code_volt, 1000);
+}
+EXPORT_SYMBOL(qcom_adc_tm5_temp_volt_scale);
+
 int qcom_adc5_hw_scale(enum vadc_scale_fn_type scaletype,
 		    unsigned int prescale_ratio,
 		    const struct adc5_data *data,
diff --git a/drivers/iio/adc/qcom-vadc-common.h b/drivers/iio/adc/qcom-vadc-common.h
index 7e5f6428e311..9af41201ad77 100644
--- a/drivers/iio/adc/qcom-vadc-common.h
+++ b/drivers/iio/adc/qcom-vadc-common.h
@@ -172,6 +172,9 @@ int qcom_adc5_hw_scale(enum vadc_scale_fn_type scaletype,
 		    const struct adc5_data *data,
 		    u16 adc_code, int *result_mdec);
 
+u16 qcom_adc_tm5_temp_volt_scale(unsigned int prescale_ratio,
+				 u32 full_scale_code_volt, int temp);
+
 int qcom_adc5_prescaling_from_dt(u32 num, u32 den);
 
 int qcom_adc5_hw_settle_time_from_dt(u32 value, const unsigned int *hw_settle);
diff --git a/drivers/thermal/qcom/Kconfig b/drivers/thermal/qcom/Kconfig
index aa9c1d80fae4..8d5ac2df26dc 100644
--- a/drivers/thermal/qcom/Kconfig
+++ b/drivers/thermal/qcom/Kconfig
@@ -10,6 +10,17 @@ config QCOM_TSENS
 	  Also able to set threshold temperature for both hot and cold and update
 	  when a threshold is reached.
 
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
+
 config QCOM_SPMI_TEMP_ALARM
 	tristate "Qualcomm SPMI PMIC Temperature Alarm"
 	depends on OF && SPMI && IIO
diff --git a/drivers/thermal/qcom/Makefile b/drivers/thermal/qcom/Makefile
index ec86eef7f6a6..252ea7d9da0b 100644
--- a/drivers/thermal/qcom/Makefile
+++ b/drivers/thermal/qcom/Makefile
@@ -3,4 +3,5 @@ obj-$(CONFIG_QCOM_TSENS)	+= qcom_tsens.o
 
 qcom_tsens-y			+= tsens.o tsens-v2.o tsens-v1.o tsens-v0_1.o \
 				   tsens-8960.o
+obj-$(CONFIG_QCOM_SPMI_ADC_TM5)	+= qcom-spmi-adc-tm5.o
 obj-$(CONFIG_QCOM_SPMI_TEMP_ALARM)	+= qcom-spmi-temp-alarm.o
diff --git a/drivers/thermal/qcom/qcom-spmi-adc-tm5.c b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
new file mode 100644
index 000000000000..c09a50f59053
--- /dev/null
+++ b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
@@ -0,0 +1,622 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2012-2020, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2020 Linaro Limited
+ */
+
+#include <linux/bitfield.h>
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
+
+#define ADC_TM5_STATUS_LOW			0x0a
+
+#define ADC_TM5_STATUS_HIGH			0x0b
+
+#define ADC_TM5_NUM_BTM				0x0f
+
+#define ADC_TM5_ADC_DIG_PARAM			0x42
+
+#define ADC_TM5_FAST_AVG_CTL			(ADC_TM5_ADC_DIG_PARAM + 1)
+#define ADC_TM5_FAST_AVG_EN				BIT(7)
+
+#define ADC_TM5_MEAS_INTERVAL_CTL		(ADC_TM5_ADC_DIG_PARAM + 2)
+#define ADC_TM5_TIMER1					3 /* 3.9ms */
+
+#define ADC_TM5_MEAS_INTERVAL_CTL2		(ADC_TM5_ADC_DIG_PARAM + 3)
+#define ADC_TM5_MEAS_INTERVAL_CTL2_MASK			0xf0
+#define ADC_TM5_TIMER2					10 /* 1 second */
+#define ADC_TM5_MEAS_INTERVAL_CTL3_MASK			0xf
+#define ADC_TM5_TIMER3					4 /* 4 second */
+
+#define ADC_TM_EN_CTL1				0x46
+#define ADC_TM_EN					BIT(7)
+#define ADC_TM_CONV_REQ				0x47
+#define ADC_TM_CONV_REQ_EN				BIT(7)
+
+#define ADC_TM5_M_CHAN_BASE			0x60
+
+#define ADC_TM5_M_ADC_CH_SEL_CTL(n)		(ADC_TM5_M_CHAN_BASE + ((n) * 8) + 0)
+#define ADC_TM5_M_LOW_THR0(n)			(ADC_TM5_M_CHAN_BASE + ((n) * 8) + 1)
+#define ADC_TM5_M_LOW_THR1(n)			(ADC_TM5_M_CHAN_BASE + ((n) * 8) + 2)
+#define ADC_TM5_M_HIGH_THR0(n)			(ADC_TM5_M_CHAN_BASE + ((n) * 8) + 3)
+#define ADC_TM5_M_HIGH_THR1(n)			(ADC_TM5_M_CHAN_BASE + ((n) * 8) + 4)
+#define ADC_TM5_M_MEAS_INTERVAL_CTL(n)		(ADC_TM5_M_CHAN_BASE + ((n) * 8) + 5)
+#define ADC_TM5_M_CTL(n)			(ADC_TM5_M_CHAN_BASE + ((n) * 8) + 6)
+#define ADC_TM5_M_CTL_HW_SETTLE_DELAY_MASK		0xf
+#define ADC_TM5_M_CTL_CAL_SEL_MASK			0x30
+#define ADC_TM5_M_CTL_CAL_VAL				0x40
+#define ADC_TM5_M_EN(n)				(ADC_TM5_M_CHAN_BASE + ((n) * 8) + 7)
+#define ADC_TM5_M_MEAS_EN				BIT(7)
+#define ADC_TM5_M_HIGH_THR_INT_EN			BIT(1)
+#define ADC_TM5_M_LOW_THR_INT_EN			BIT(0)
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
+/**
+ * struct adc_tm5_channel - ADC Thermal Monitoring channel data.
+ * @channel: channel number.
+ * @adc_channel: corresponding ADC channel number.
+ * @cal_method: calibration method.
+ * @prescale: channel scaling performed on the input signal.
+ * @hw_settle_time: the time between AMUX being configured and the
+ *	start of conversion.
+ * @iio: IIO channel instance used by this channel.
+ * @chip: ADC TM chip instance.
+ * @tzd: thermal zone device used by this channel.
+ */
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
+/**
+ * struct adc_tm5_chip - ADC Thermal Monitoring properties
+ * @regmap: SPMI ADC5 Thermal Monitoring  peripheral register map field.
+ * @dev: SPMI ADC5 device.
+ * @data: software configuration data.
+ * @channels: array of ADC TM channel data.
+ * @nchannels: amount of channels defined/allocated
+ * @decimation: sampling rate supported for the channel.
+ * @avg_samples: ability to provide single result from the ADC
+ *	that is an average of multiple measurements.
+ * @base: base address of TM registers.
+ */
+struct adc_tm5_chip {
+	struct regmap		*regmap;
+	struct device		*dev;
+	const struct adc_tm5_data	*data;
+	struct adc_tm5_channel	*channels;
+	unsigned int		nchannels;
+	unsigned int		decimation;
+	unsigned int		avg_samples;
+	u16			base;
+};
+
+static const struct adc_tm5_data adc_tm5_data_pmic = {
+	.full_scale_code_volt = 0x70e4,
+	.decimation = (unsigned int []) {250, 420, 840},
+	.hw_settle = (unsigned int []) {15, 100, 200, 300, 400, 500, 600, 700,
+					1000, 2000, 4000, 8000, 16000, 32000, 64000, 128000},
+};
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
+
+	ret = adc_tm5_read(chip, ADC_TM5_STATUS_LOW, &status_low, 1);
+	if (ret) {
+		dev_err(chip->dev, "read status low failed with %d\n", ret);
+		return IRQ_HANDLED;
+	}
+
+	ret = adc_tm5_read(chip, ADC_TM5_STATUS_HIGH, &status_high, 1);
+	if (ret) {
+		dev_err(chip->dev, "read status high failed with %d\n", ret);
+		return IRQ_HANDLED;
+	}
+
+	for (i = 0; i < chip->nchannels; i++) {
+		bool upper_set = false, lower_set = false;
+		unsigned int ch = chip->channels[i].channel;
+
+		if (!chip->channels[i].tzd) {
+			dev_err_once(chip->dev, "thermal device not found\n");
+			continue;
+		}
+
+		ret = adc_tm5_read(chip, ADC_TM5_M_EN(ch), &ctl, 1);
+
+		if (ret) {
+			dev_err(chip->dev, "ctl read failed with %d\n", ret);
+			continue;
+		}
+
+		lower_set = (status_low & BIT(ch)) &&
+			(ctl & ADC_TM5_M_MEAS_EN) &&
+			(ctl & ADC_TM5_M_LOW_THR_INT_EN);
+
+		upper_set = (status_high & BIT(ch)) &&
+			(ctl & ADC_TM5_M_MEAS_EN) &&
+			(ctl & ADC_TM5_M_HIGH_THR_INT_EN);
+
+		if (upper_set || lower_set)
+			thermal_zone_device_update(chip->channels[i].tzd,
+						   THERMAL_EVENT_UNSPECIFIED);
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
+	unsigned int reg = ADC_TM5_M_EN(channel->channel);
+
+	return adc_tm5_reg_update(chip, reg,
+			ADC_TM5_M_MEAS_EN | ADC_TM5_M_HIGH_THR_INT_EN | ADC_TM5_M_LOW_THR_INT_EN,
+			0);
+}
+
+static int adc_tm5_enable(struct adc_tm5_chip *chip)
+{
+	int rc = 0;
+	u8 data = 0;
+
+	data = ADC_TM_EN;
+	rc = adc_tm5_write(chip, ADC_TM_EN_CTL1, &data, 1);
+	if (rc < 0) {
+		pr_err("adc-tm enable failed\n");
+		return rc;
+	}
+
+	data = ADC_TM_CONV_REQ_EN;
+	rc = adc_tm5_write(chip, ADC_TM_CONV_REQ, &data, 1);
+	if (rc < 0) {
+		pr_err("adc-tm request conversion failed\n");
+		return rc;
+	}
+
+	return rc;
+}
+
+static int adc_tm5_configure(struct adc_tm5_channel *channel, int low_temp, int high_temp)
+{
+	struct adc_tm5_chip *chip = channel->chip;
+	u8 buf[8];
+	u16 reg = ADC_TM5_M_ADC_CH_SEL_CTL(channel->channel);
+	int ret = 0;
+
+	ret = adc_tm5_read(chip, reg, buf, sizeof(buf));
+	if (ret) {
+		dev_err(chip->dev, "block read failed with %d\n", ret);
+		return ret;
+	}
+
+	/* Update ADC channel select */
+	buf[0] = channel->adc_channel;
+
+	/* Warm temperature corresponds to low voltage threshold */
+	if (high_temp != INT_MAX) {
+		u16 adc_code = qcom_adc_tm5_temp_volt_scale(channel->prescale,
+				chip->data->full_scale_code_volt, high_temp);
+
+		buf[1] = adc_code & 0xff;
+		buf[2] = adc_code >> 8;
+		buf[7] |= ADC_TM5_M_LOW_THR_INT_EN;
+	} else {
+		buf[7] &= ~ADC_TM5_M_LOW_THR_INT_EN;
+	}
+
+	/* Cool temperature corresponds to high voltage threshold */
+	if (low_temp != -INT_MAX) {
+		u16 adc_code = qcom_adc_tm5_temp_volt_scale(channel->prescale,
+				chip->data->full_scale_code_volt, low_temp);
+
+		buf[3] = adc_code & 0xff;
+		buf[4] = adc_code >> 8;
+		buf[7] |= ADC_TM5_M_HIGH_THR_INT_EN;
+	} else {
+		buf[7] &= ~ADC_TM5_M_HIGH_THR_INT_EN;
+	}
+
+	/* Update timer select */
+	buf[5] = ADC5_TIMER_SEL_2;
+
+	/* Set calibration select, hw_settle delay */
+	buf[6] &= ~ADC_TM5_M_CTL_HW_SETTLE_DELAY_MASK;
+	buf[6] |= FIELD_PREP(ADC_TM5_M_CTL_HW_SETTLE_DELAY_MASK, channel->hw_settle_time);
+	buf[6] &= ~ADC_TM5_M_CTL_CAL_SEL_MASK;
+	buf[6] |= FIELD_PREP(ADC_TM5_M_CTL_CAL_SEL_MASK, channel->cal_method);
+
+	buf[7] |= ADC_TM5_M_MEAS_EN;
+
+	ret = adc_tm5_write(chip, reg, buf, sizeof(buf));
+	if (ret) {
+		dev_err(chip->dev, "buf write failed\n");
+		return ret;
+	}
+
+	return adc_tm5_enable(chip);
+}
+
+static int adc_tm5_set_trips(void *data, int low_temp, int high_temp)
+{
+	struct adc_tm5_channel *channel = data;
+	struct adc_tm5_chip *chip;
+	int ret;
+
+	if (!channel)
+		return -EINVAL;
+
+	chip = channel->chip;
+	dev_dbg(chip->dev, "%d:low_temp(mdegC):%d, high_temp(mdegC):%d\n",
+		channel->channel, low_temp, high_temp);
+
+	if (high_temp == INT_MAX && low_temp <= -INT_MAX)
+		ret = adc_tm5_disable_channel(channel);
+	else
+		ret = adc_tm5_configure(channel, low_temp, high_temp);
+
+	return ret;
+}
+
+static struct thermal_zone_of_device_ops adc_tm5_ops = {
+	.get_temp = adc_tm5_get_temp,
+	.set_trips = adc_tm5_set_trips,
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
+		tzd = devm_thermal_zone_of_sensor_register(adc_tm->dev,
+							   adc_tm->channels[i].channel,
+							   &adc_tm->channels[i],
+							   &adc_tm5_ops);
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
+	u8 buf[4], channels_available;
+	int ret;
+	unsigned int i;
+
+	ret = adc_tm5_read(chip, ADC_TM5_NUM_BTM, &channels_available, 1);
+	if (ret) {
+		dev_err(chip->dev, "read failed for BTM channels\n");
+		return ret;
+	}
+
+	ret = adc_tm5_read(chip, ADC_TM5_ADC_DIG_PARAM, buf, sizeof(buf));
+	if (ret) {
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
+	buf[2] = ADC_TM5_TIMER1;
+
+	/* Select timer2 and timer3 */
+	buf[3] = FIELD_PREP(ADC_TM5_MEAS_INTERVAL_CTL2_MASK, ADC_TM5_TIMER2) |
+		 FIELD_PREP(ADC_TM5_MEAS_INTERVAL_CTL3_MASK, ADC_TM5_TIMER3);
+
+	ret = adc_tm5_write(chip, ADC_TM5_ADC_DIG_PARAM, buf, sizeof(buf));
+	if (ret)
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
+				       struct adc_tm5_channel *channel,
+				       struct device_node *node)
+{
+	const char *name = node->name;
+	u32 chan, value, varr[2];
+	int ret;
+	struct device *dev = adc_tm->dev;
+	struct of_phandle_args args;
+
+	ret = of_property_read_u32(node, "reg", &chan);
+	if (ret) {
+		dev_err(dev, "%s: invalid channel number (%d)\n", name, ret);
+		return ret;
+	}
+
+	if (chan >= ADC_TM5_NUM_CHANNELS) {
+		dev_err(dev, "%s: invalid channel number %d\n", name, chan);
+		return -EINVAL;
+	}
+
+	/* the channel has DT description */
+	channel->channel = chan;
+
+	/*
+	 * We are tied to PMIC's ADC controller, which always use single argument for channel number.
+	 * So don't bother parsing #io-channel-cells, just enforce cell_count = 1.
+	 */
+	ret = of_parse_phandle_with_fixed_args(node, "io-channels", 1, 0, &args);
+	if (ret < 0) {
+		dev_err(dev, "%s: invalid ADC channel number %d: %d\n", name, chan, ret);
+		return ret;
+	}
+	of_node_put(args.np);
+
+	if (args.args_count != 1 || args.args[0] >= ADC5_MAX_CHANNEL) {
+		dev_err(dev, "%s: invalid ADC channel number %d\n", name, chan);
+		return ret;
+	}
+	channel->adc_channel = args.args[0];
+
+	channel->iio = devm_of_iio_channel_get_by_name(adc_tm->dev, node, NULL);
+	if (IS_ERR(channel->iio)) {
+		ret = PTR_ERR(channel->iio);
+		channel->iio = NULL;
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev, "%s: error getting channel: %d\n", name, ret);
+		return ret;
+	}
+
+	ret = of_property_read_u32_array(node, "qcom,pre-scaling", varr, 2);
+	if (!ret) {
+		ret = qcom_adc5_prescaling_from_dt(varr[0], varr[1]);
+		if (ret < 0) {
+			dev_err(dev, "%s: invalid pre-scaling <%d %d>\n",
+				name, varr[0], varr[1]);
+			return ret;
+		}
+		channel->prescale = ret;
+	} else {
+		/* 1:1 prescale is index 0 */
+		channel->prescale = 0;
+	}
+
+	ret = of_property_read_u32(node, "qcom,hw-settle-time-us", &value);
+	if (!ret) {
+		ret = qcom_adc5_hw_settle_time_from_dt(value, adc_tm->data->hw_settle);
+		if (ret < 0) {
+			dev_err(dev, "%s invalid hw-settle-time-us %d us\n",
+				name, value);
+			return ret;
+		}
+		channel->hw_settle_time = ret;
+	} else {
+		channel->hw_settle_time = VADC_DEF_HW_SETTLE_TIME;
+	}
+
+	if (of_property_read_bool(node, "qcom,ratiometric"))
+		channel->cal_method = ADC_TM5_RATIOMETRIC_CAL;
+	else
+		channel->cal_method = ADC_TM5_ABSOLUTE_CAL;
+
+	return 0;
+}
+
+static int adc_tm5_get_dt_data(struct adc_tm5_chip *adc_tm, struct device_node *node)
+{
+	struct adc_tm5_channel *channels;
+	struct device_node *child;
+	u32 value;
+	int ret;
+	struct device *dev = adc_tm->dev;
+
+	adc_tm->nchannels = of_get_available_child_count(node);
+	if (!adc_tm->nchannels)
+		return -EINVAL;
+
+	adc_tm->channels = devm_kcalloc(dev, adc_tm->nchannels,
+					sizeof(*adc_tm->channels), GFP_KERNEL);
+	if (!adc_tm->channels)
+		return -ENOMEM;
+
+	channels = adc_tm->channels;
+
+	adc_tm->data = of_device_get_match_data(dev);
+	if (!adc_tm->data)
+		adc_tm->data = &adc_tm5_data_pmic;
+
+	ret = of_property_read_u32(node, "qcom,decimation", &value);
+	if (!ret) {
+		ret = qcom_adc5_decimation_from_dt(value, adc_tm->data->decimation);
+		if (ret < 0) {
+			dev_err(dev, "invalid decimation %d\n", value);
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
+			dev_err(dev, "invalid avg-samples %d\n", value);
+			return ret;
+		}
+		adc_tm->avg_samples = ret;
+	} else {
+		adc_tm->avg_samples = VADC_DEF_AVG_SAMPLES;
+	}
+
+	for_each_available_child_of_node(node, child) {
+		ret = adc_tm5_get_dt_channel_data(adc_tm, channels, child);
+		if (ret) {
+			of_node_put(child);
+			return ret;
+		}
+
+		channels++;
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
+	if (ret)
+		return ret;
+
+	adc_tm = devm_kzalloc(&pdev->dev, sizeof(*adc_tm), GFP_KERNEL);
+	if (!adc_tm)
+		return -ENOMEM;
+
+	adc_tm->regmap = regmap;
+	adc_tm->dev = dev;
+	adc_tm->base = reg;
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
+	if (ret) {
+		dev_err(dev, "tzd register failed\n");
+		return ret;
+	}
+
+	return devm_request_threaded_irq(dev, irq, NULL, adc_tm5_isr, IRQF_ONESHOT, "pm-adc-tm5", adc_tm);
+}
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
+static struct platform_driver adc_tm5_driver = {
+	.driver = {
+		.name = "qcom-spmi-adc-tm5",
+		.of_match_table = adc_tm5_match_table,
+	},
+	.probe = adc_tm5_probe,
+};
+module_platform_driver(adc_tm5_driver);
+
+MODULE_DESCRIPTION("SPMI PMIC Thermal Monitor ADC driver");
+MODULE_LICENSE("GPL v2");
-- 
2.28.0

