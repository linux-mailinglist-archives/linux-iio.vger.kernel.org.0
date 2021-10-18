Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC2543114B
	for <lists+linux-iio@lfdr.de>; Mon, 18 Oct 2021 09:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbhJRHUP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 18 Oct 2021 03:20:15 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:49848 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbhJRHUP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 Oct 2021 03:20:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1634541484; x=1666077484;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=Rjb4/7+OOogd2YDhk3eOct3dZASCssswCfI/IX8OZv8=;
  b=g0XK1++YjLznGD2jpct0Huwj8NGdLH/yczqOkFJ2Na6EFvQ9O4CqjM3Z
   HDZsfxNySG/rz9bOj5l1BnQaimOlPCd/D+4liau/1EIw5uA/XfRnUkF+l
   ZzMwcUq2e2qnjb1WqWeenGgVOpZZwIoNgpryhJd7Pu2xTaDStoTpuN6Ra
   I=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 18 Oct 2021 00:18:04 -0700
X-QCInternal: smtphost
Received: from nalasex01a.na.qualcomm.com ([10.47.209.196])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2021 00:18:03 -0700
Received: from jprakash-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7;
 Mon, 18 Oct 2021 00:17:55 -0700
From:   Jishnu Prakash <quic_jprakash@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <devicetree@vger.kernel.org>, <mka@chromium.org>,
        <linus.walleij@linaro.org>, <dmitry.baryshkov@linaro.org>,
        <Jonathan.Cameron@huawei.com>, <quic_kgunda@quicinc.com>,
        <quic_aghayal@quicinc.com>, <quic_subbaram@quicinc.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "Lars-Peter Clausen" <lars@metafoo.de>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Daniel Lezcano" <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        "Jishnu Prakash" <quic_jprakash@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
CC:     <linux-arm-msm-owner@vger.kernel.org>
Subject: [PATCH 2/2] thermal: qcom: add support for PMIC5 Gen2 ADCTM
Date:   Mon, 18 Oct 2021 12:47:09 +0530
Message-ID: <1634541429-3215-3-git-send-email-quic_jprakash@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1634541429-3215-1-git-send-email-quic_jprakash@quicinc.com>
References: <1634541429-3215-1-git-send-email-quic_jprakash@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add support for PMIC5 Gen2 ADC_TM, used on PMIC7 chips. It is a
close counterpart of PMIC7 ADC and has the same functionality as
PMIC5 ADC_TM, for threshold monitoring and interrupt generation.
It is present on PMK8350 alone, like PMIC7 ADC and can be used
to monitor up to 8 ADC channels, from any of the PMIC7 PMICs
having ADC on a target, through PBS(Programmable Boot Sequence).

Signed-off-by: Jishnu Prakash <quic_jprakash@quicinc.com>
---
 drivers/iio/adc/qcom-vadc-common.c       | 187 ++++++++++++++
 drivers/thermal/qcom/qcom-spmi-adc-tm5.c | 431 ++++++++++++++++++++++++++++++-
 include/linux/iio/adc/qcom-vadc-common.h |   2 +
 3 files changed, 611 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/adc/qcom-vadc-common.c b/drivers/iio/adc/qcom-vadc-common.c
index 1472389..e192736 100644
--- a/drivers/iio/adc/qcom-vadc-common.c
+++ b/drivers/iio/adc/qcom-vadc-common.c
@@ -100,6 +100,182 @@ static const struct vadc_map_pt adcmap_100k_104ef_104fb_1875_vref[] = {
 	{ 46,	125000 },
 };
 
+/*
+ * Resistance to temperature table for NTCG104EF104 thermistor with
+ * 100k pull-up.
+ */
+static const struct vadc_map_pt adcmap_100k_adc7[] = {
+	{ 4250657, -40960 },
+	{ 3962085, -39936 },
+	{ 3694875, -38912 },
+	{ 3447322, -37888 },
+	{ 3217867, -36864 },
+	{ 3005082, -35840 },
+	{ 2807660, -34816 },
+	{ 2624405, -33792 },
+	{ 2454218, -32768 },
+	{ 2296094, -31744 },
+	{ 2149108, -30720 },
+	{ 2012414, -29696 },
+	{ 1885232, -28672 },
+	{ 1766846, -27648 },
+	{ 1656598, -26624 },
+	{ 1553884, -25600 },
+	{ 1458147, -24576 },
+	{ 1368873, -23552 },
+	{ 1285590, -22528 },
+	{ 1207863, -21504 },
+	{ 1135290, -20480 },
+	{ 1067501, -19456 },
+	{ 1004155, -18432 },
+	{ 944935, -17408 },
+	{ 889550, -16384 },
+	{ 837731, -15360 },
+	{ 789229, -14336 },
+	{ 743813, -13312 },
+	{ 701271, -12288 },
+	{ 661405, -11264 },
+	{ 624032, -10240 },
+	{ 588982, -9216 },
+	{ 556100, -8192 },
+	{ 525239, -7168 },
+	{ 496264, -6144 },
+	{ 469050, -5120 },
+	{ 443480, -4096 },
+	{ 419448, -3072 },
+	{ 396851, -2048 },
+	{ 375597, -1024 },
+	{ 355598, 0 },
+	{ 336775, 1024 },
+	{ 319052, 2048 },
+	{ 302359, 3072 },
+	{ 286630, 4096 },
+	{ 271806, 5120 },
+	{ 257829, 6144 },
+	{ 244646, 7168 },
+	{ 232209, 8192 },
+	{ 220471, 9216 },
+	{ 209390, 10240 },
+	{ 198926, 11264 },
+	{ 189040, 12288 },
+	{ 179698, 13312 },
+	{ 170868, 14336 },
+	{ 162519, 15360 },
+	{ 154622, 16384 },
+	{ 147150, 17408 },
+	{ 140079, 18432 },
+	{ 133385, 19456 },
+	{ 127046, 20480 },
+	{ 121042, 21504 },
+	{ 115352, 22528 },
+	{ 109960, 23552 },
+	{ 104848, 24576 },
+	{ 100000, 25600 },
+	{ 95402, 26624 },
+	{ 91038, 27648 },
+	{ 86897, 28672 },
+	{ 82965, 29696 },
+	{ 79232, 30720 },
+	{ 75686, 31744 },
+	{ 72316, 32768 },
+	{ 69114, 33792 },
+	{ 66070, 34816 },
+	{ 63176, 35840 },
+	{ 60423, 36864 },
+	{ 57804, 37888 },
+	{ 55312, 38912 },
+	{ 52940, 39936 },
+	{ 50681, 40960 },
+	{ 48531, 41984 },
+	{ 46482, 43008 },
+	{ 44530, 44032 },
+	{ 42670, 45056 },
+	{ 40897, 46080 },
+	{ 39207, 47104 },
+	{ 37595, 48128 },
+	{ 36057, 49152 },
+	{ 34590, 50176 },
+	{ 33190, 51200 },
+	{ 31853, 52224 },
+	{ 30577, 53248 },
+	{ 29358, 54272 },
+	{ 28194, 55296 },
+	{ 27082, 56320 },
+	{ 26020, 57344 },
+	{ 25004, 58368 },
+	{ 24033, 59392 },
+	{ 23104, 60416 },
+	{ 22216, 61440 },
+	{ 21367, 62464 },
+	{ 20554, 63488 },
+	{ 19776, 64512 },
+	{ 19031, 65536 },
+	{ 18318, 66560 },
+	{ 17636, 67584 },
+	{ 16982, 68608 },
+	{ 16355, 69632 },
+	{ 15755, 70656 },
+	{ 15180, 71680 },
+	{ 14628, 72704 },
+	{ 14099, 73728 },
+	{ 13592, 74752 },
+	{ 13106, 75776 },
+	{ 12640, 76800 },
+	{ 12192, 77824 },
+	{ 11762, 78848 },
+	{ 11350, 79872 },
+	{ 10954, 80896 },
+	{ 10574, 81920 },
+	{ 10209, 82944 },
+	{ 9858, 83968 },
+	{ 9521, 84992 },
+	{ 9197, 86016 },
+	{ 8886, 87040 },
+	{ 8587, 88064 },
+	{ 8299, 89088 },
+	{ 8023, 90112 },
+	{ 7757, 91136 },
+	{ 7501, 92160 },
+	{ 7254, 93184 },
+	{ 7017, 94208 },
+	{ 6789, 95232 },
+	{ 6570, 96256 },
+	{ 6358, 97280 },
+	{ 6155, 98304 },
+	{ 5959, 99328 },
+	{ 5770, 100352 },
+	{ 5588, 101376 },
+	{ 5412, 102400 },
+	{ 5243, 103424 },
+	{ 5080, 104448 },
+	{ 4923, 105472 },
+	{ 4771, 106496 },
+	{ 4625, 107520 },
+	{ 4484, 108544 },
+	{ 4348, 109568 },
+	{ 4217, 110592 },
+	{ 4090, 111616 },
+	{ 3968, 112640 },
+	{ 3850, 113664 },
+	{ 3736, 114688 },
+	{ 3626, 115712 },
+	{ 3519, 116736 },
+	{ 3417, 117760 },
+	{ 3317, 118784 },
+	{ 3221, 119808 },
+	{ 3129, 120832 },
+	{ 3039, 121856 },
+	{ 2952, 122880 },
+	{ 2868, 123904 },
+	{ 2787, 124928 },
+	{ 2709, 125952 },
+	{ 2633, 126976 },
+	{ 2560, 128000 },
+	{ 2489, 129024 },
+	{ 2420, 130048 }
+};
+
+
 static const struct vadc_map_pt adcmap7_die_temp[] = {
 	{ 857300, 160000 },
 	{ 820100, 140000 },
@@ -677,6 +853,17 @@ u16 qcom_adc_tm5_temp_volt_scale(unsigned int prescale_ratio,
 }
 EXPORT_SYMBOL(qcom_adc_tm5_temp_volt_scale);
 
+u16 qcom_adc_tm5_temp_res_scale(int temp)
+{
+	int64_t resistance;
+
+	resistance = qcom_vadc_map_temp_voltage(adcmap_100k_adc7,
+		ARRAY_SIZE(adcmap_100k_adc7), temp);
+
+	return div64_s64((resistance * RATIO_MAX_ADC7), (resistance + R_PU_100K));
+}
+EXPORT_SYMBOL(qcom_adc_tm5_temp_res_scale);
+
 int qcom_adc5_hw_scale(enum vadc_scale_fn_type scaletype,
 		    unsigned int prescale_ratio,
 		    const struct adc5_data *data,
diff --git a/drivers/thermal/qcom/qcom-spmi-adc-tm5.c b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
index 8494cc0..f344976f 100644
--- a/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
+++ b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
@@ -71,6 +71,60 @@
 #define ADC_TM5_M_HIGH_THR_INT_EN			BIT(1)
 #define ADC_TM5_M_LOW_THR_INT_EN			BIT(0)
 
+#define ADC_TM_GEN2_STATUS1				0x08
+#define ADC_TM_GEN2_STATUS_LOW_SET		0x09
+#define ADC_TM_GEN2_STATUS_LOW_CLR		0x0a
+#define ADC_TM_GEN2_STATUS_HIGH_SET		0x0b
+#define ADC_TM_GEN2_STATUS_HIGH_CLR		0x0c
+
+#define ADC_TM_GEN2_CFG_HS_SET			0x0d
+#define ADC_TM_GEN2_CFG_HS_FLAG			BIT(0)
+#define ADC_TM_GEN2_CFG_HS_CLR			0x0e
+
+#define ADC_TM_GEN2_SID				0x40
+
+#define ADC_TM_GEN2_CH_CTL			0x41
+#define ADC_TM_GEN2_TM_CH_SEL			GENMASK(7, 5)
+#define ADC_TM_GEN2_MEAS_INT_SEL		GENMASK(3, 2)
+
+#define ADC_TM_GEN2_ADC_DIG_PARAM		0x42
+#define ADC_TM_GEN2_CTL_CAL_SEL			GENMASK(5, 4)
+#define ADC_TM_GEN2_CTL_DEC_RATIO_MASK		GENMASK(3, 2)
+
+#define ADC_TM_GEN2_FAST_AVG_CTL		0x43
+#define ADC_TM_GEN2_FAST_AVG_EN			BIT(7)
+
+#define ADC_TM_GEN2_ADC_CH_SEL_CTL		0x44
+
+#define ADC_TM_GEN2_DELAY_CTL			0x45
+#define ADC_TM_GEN2_HW_SETTLE_DELAY		GENMASK(3, 0)
+
+#define ADC_TM_GEN2_EN_CTL1			0x46
+#define ADC_TM_GEN2_EN				BIT(7)
+
+#define ADC_TM_GEN2_CONV_REQ			0x47
+#define ADC_TM_GEN2_CONV_REQ_EN			BIT(7)
+
+#define ADC_TM_GEN2_LOW_THR0			0x49
+#define ADC_TM_GEN2_LOW_THR1			0x4a
+#define ADC_TM_GEN2_HIGH_THR0			0x4b
+#define ADC_TM_GEN2_HIGH_THR1			0x4c
+#define ADC_TM_GEN2_LOWER_MASK(n)		((n) & GENMASK(7, 0))
+#define ADC_TM_GEN2_UPPER_MASK(n)		(((n) & GENMASK(15, 8)) >> 8)
+
+#define ADC_TM_GEN2_MEAS_IRQ_EN			0x4d
+#define ADC_TM_GEN2_MEAS_EN			BIT(7)
+#define ADC_TM5_GEN2_HIGH_THR_INT_EN		BIT(1)
+#define ADC_TM5_GEN2_LOW_THR_INT_EN		BIT(0)
+
+#define ADC_TM_GEN2_MEAS_INT_LSB		0x50
+#define ADC_TM_GEN2_MEAS_INT_MSB		0x51
+#define ADC_TM_GEN2_MEAS_INT_MODE		0x52
+
+#define ADC_TM_GEN2_Mn_DATA0(n)			((n * 2) + 0xa0)
+#define ADC_TM_GEN2_Mn_DATA1(n)			((n * 2) + 0xa1)
+#define ADC_TM_GEN2_DATA_SHIFT			8
+
 enum adc5_timer_select {
 	ADC5_TIMER_SEL_1 = 0,
 	ADC5_TIMER_SEL_2,
@@ -79,6 +133,7 @@ enum adc5_timer_select {
 };
 
 struct adc_tm5_data {
+	const struct	adc_tm_ops *ops;
 	const u32	full_scale_code_volt;
 	unsigned int	*decimation;
 	unsigned int	*hw_settle;
@@ -100,6 +155,12 @@ struct adc_tm5_chip;
  * @prescale: channel scaling performed on the input signal.
  * @hw_settle_time: the time between AMUX being configured and the
  *	start of conversion.
+ * @decimation: sampling rate supported for the channel.
+ * @avg_samples: ability to provide single result from the ADC
+ *	that is an average of multiple measurements.
+ * @high_thr_en: channel upper voltage threshold enable state.
+ * @low_thr_en: channel lower voltage threshold enable state.
+ * @meas_en: recurring measurement enable state
  * @iio: IIO channel instance used by this channel.
  * @chip: ADC TM chip instance.
  * @tzd: thermal zone device used by this channel.
@@ -110,6 +171,11 @@ struct adc_tm5_channel {
 	enum adc_tm5_cal_method	cal_method;
 	unsigned int		prescale;
 	unsigned int		hw_settle_time;
+	unsigned int		decimation;	/* For Gen2 ADC_TM */
+	unsigned int		avg_samples;	/* For Gen2 ADC_TM */
+	bool			high_thr_en;
+	bool			low_thr_en;
+	bool			meas_en;
 	struct iio_channel	*iio;
 	struct adc_tm5_chip	*chip;
 	struct thermal_zone_device *tzd;
@@ -123,9 +189,12 @@ struct adc_tm5_channel {
  * @channels: array of ADC TM channel data.
  * @nchannels: amount of channels defined/allocated
  * @decimation: sampling rate supported for the channel.
+ *      Applies to all channels, used only on Gen1 ADC_TM.
  * @avg_samples: ability to provide single result from the ADC
- *	that is an average of multiple measurements.
+ *      that is an average of multiple measurements. Applies to all
+ *      channels, used only on Gen1 ADC_TM.
  * @base: base address of TM registers.
+ * @adc_mutex_lock: ADC_TM mutex lock.
  */
 struct adc_tm5_chip {
 	struct regmap		*regmap;
@@ -136,9 +205,34 @@ struct adc_tm5_chip {
 	unsigned int		decimation;
 	unsigned int		avg_samples;
 	u16			base;
+	struct mutex		adc_mutex_lock;
+};
+
+enum adc_tm_gen2_time_select {
+	MEAS_INT_50MS = 0,
+	MEAS_INT_100MS,
+	MEAS_INT_1S,
+	MEAS_INT_SET,
+	MEAS_INT_NONE,
+};
+
+struct adc_tm_ops {
+	int (*disable_channel)(struct adc_tm5_channel *channel);
+	int (*configure)(struct adc_tm5_channel *channel, int low,
+					int high);
+	int (*init)(struct adc_tm5_chip *chip);
 };
 
+enum adc_tm_index {
+	ADC_TM5,
+	ADC_TM5_GEN2,
+	ADC_TM5_MAX
+};
+
+static const struct adc_tm_ops ops_adc_tm5[ADC_TM5_MAX];
+
 static const struct adc_tm5_data adc_tm5_data_pmic = {
+	.ops = &ops_adc_tm5[ADC_TM5],
 	.full_scale_code_volt = 0x70e4,
 	.decimation = (unsigned int []) { 250, 420, 840 },
 	.hw_settle = (unsigned int []) { 15, 100, 200, 300, 400, 500, 600, 700,
@@ -146,6 +240,15 @@ static const struct adc_tm5_data adc_tm5_data_pmic = {
 					 64000, 128000 },
 };
 
+static const struct adc_tm5_data adc_tm5_gen2_data_pmic = {
+	.ops = &ops_adc_tm5[ADC_TM5_GEN2],
+	.full_scale_code_volt = 0x70e4,
+	.decimation = (unsigned int []) { 85, 340, 1360 },
+	.hw_settle = (unsigned int []) { 15, 100, 200, 300, 400, 500, 600, 700,
+					 1000, 2000, 4000, 8000, 16000, 32000,
+					 64000, 128000 },
+};
+
 static int adc_tm5_read(struct adc_tm5_chip *adc_tm, u16 offset, u8 *data, int len)
 {
 	return regmap_bulk_read(adc_tm->regmap, adc_tm->base + offset, data, len);
@@ -210,6 +313,61 @@ static irqreturn_t adc_tm5_isr(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+static irqreturn_t adc_tm5_gen2_isr(int irq, void *data)
+{
+	struct adc_tm5_chip *chip = data;
+	u8 status_low, status_high;
+	int ret, i;
+
+	ret = adc_tm5_read(chip, ADC_TM_GEN2_STATUS_LOW_CLR, &status_low, sizeof(status_low));
+	if (ret) {
+		dev_err(chip->dev, "read status_low failed: %d\n", ret);
+		return IRQ_HANDLED;
+	}
+
+	ret = adc_tm5_read(chip, ADC_TM_GEN2_STATUS_HIGH_CLR, &status_high, sizeof(status_high));
+	if (ret) {
+		dev_err(chip->dev, "read status_high failed: %d\n", ret);
+		return IRQ_HANDLED;
+	}
+
+	ret = adc_tm5_write(chip, ADC_TM_GEN2_STATUS_LOW_CLR, &status_low, sizeof(status_low));
+	if (ret < 0) {
+		dev_err(chip->dev, "clear status low failed with %d\n", ret);
+		return IRQ_HANDLED;
+	}
+
+	ret = adc_tm5_write(chip, ADC_TM_GEN2_STATUS_HIGH_CLR, &status_high, sizeof(status_high));
+	if (ret < 0) {
+		dev_err(chip->dev, "clear status high failed with %d\n", ret);
+		return IRQ_HANDLED;
+	}
+
+	for (i = 0; i < chip->nchannels; i++) {
+		bool upper_set = false, lower_set = false;
+		unsigned int ch = chip->channels[i].channel;
+
+		/* No TZD, we warned at the boot time */
+		if (!chip->channels[i].tzd)
+			continue;
+
+		if (!chip->channels[i].meas_en)
+			continue;
+
+		lower_set = (status_low & BIT(ch)) &&
+			(chip->channels[i].low_thr_en);
+
+		upper_set = (status_high & BIT(ch)) &&
+			(chip->channels[i].high_thr_en);
+
+		if (upper_set || lower_set)
+			thermal_zone_device_update(chip->channels[i].tzd,
+						   THERMAL_EVENT_UNSPECIFIED);
+	}
+
+	return IRQ_HANDLED;
+}
+
 static int adc_tm5_get_temp(void *data, int *temp)
 {
 	struct adc_tm5_channel *channel = data;
@@ -240,6 +398,104 @@ static int adc_tm5_disable_channel(struct adc_tm5_channel *channel)
 				  0);
 }
 
+#define ADC_TM_GEN2_POLL_DELAY_MIN_US		100
+#define ADC_TM_GEN2_POLL_DELAY_MAX_US		110
+#define ADC_TM_GEN2_POLL_RETRY_COUNT			3
+
+static int32_t adc_tm5_gen2_conv_req(struct adc_tm5_chip *chip)
+{
+	int ret = 0;
+	u8 data = 0;
+	unsigned int count;
+
+	data = ADC_TM_GEN2_EN;
+	ret = adc_tm5_write(chip, ADC_TM_GEN2_EN_CTL1, &data, 1);
+	if (ret < 0) {
+		pr_err("adc-tm enable failed with %d\n", ret);
+		return ret;
+	}
+
+	data = ADC_TM_GEN2_CFG_HS_FLAG;
+	ret = adc_tm5_write(chip, ADC_TM_GEN2_CFG_HS_SET, &data, 1);
+	if (ret < 0) {
+		pr_err("adc-tm handshake failed with %d\n", ret);
+		return ret;
+	}
+
+	data = ADC_TM_GEN2_CONV_REQ_EN;
+	ret = adc_tm5_write(chip, ADC_TM_GEN2_CONV_REQ, &data, 1);
+	if (ret < 0) {
+		pr_err("adc-tm request conversion failed with %d\n", ret);
+		return ret;
+	}
+
+	/*
+	 * SW sets a handshake bit and waits for PBS to clear it
+	 * before the next conversion request can be queued.
+	 */
+
+	for (count = 0; count < ADC_TM_GEN2_POLL_RETRY_COUNT; count++) {
+		ret = adc_tm5_read(chip, ADC_TM_GEN2_CFG_HS_SET, &data, sizeof(data));
+		if (ret < 0) {
+			pr_err("adc-tm read failed with %d\n", ret);
+			return ret;
+		}
+
+		if (!(data & ADC_TM_GEN2_CFG_HS_FLAG))
+			return ret;
+		usleep_range(ADC_TM_GEN2_POLL_DELAY_MIN_US,
+			ADC_TM_GEN2_POLL_DELAY_MAX_US);
+	}
+
+	pr_err("adc-tm conversion request handshake timed out\n");
+
+	return -ETIMEDOUT;
+}
+
+static int adc_tm5_gen2_disable_channel(struct adc_tm5_channel *channel)
+{
+	struct adc_tm5_chip *chip = channel->chip;
+	int ret;
+	u8 val;
+
+	mutex_lock(&chip->adc_mutex_lock);
+
+	channel->meas_en = false;
+	channel->high_thr_en = false;
+	channel->low_thr_en = false;
+
+	ret = adc_tm5_read(chip, ADC_TM_GEN2_CH_CTL, &val, sizeof(val));
+	if (ret < 0) {
+		pr_err("adc-tm block read failed with %d\n", ret);
+		goto disable_fail;
+	}
+
+	val &= ~ADC_TM_GEN2_TM_CH_SEL;
+	val |= FIELD_PREP(ADC_TM_GEN2_TM_CH_SEL, channel->channel);
+
+	ret = adc_tm5_write(chip, ADC_TM_GEN2_CH_CTL, &val, 1);
+	if (ret < 0) {
+		dev_err(chip->dev, "adc-tm channel disable failed with %d\n", ret);
+		goto disable_fail;
+	}
+
+	val = 0;
+	ret = adc_tm5_write(chip, ADC_TM_GEN2_MEAS_IRQ_EN, &val, 1);
+	if (ret < 0) {
+		dev_err(chip->dev, "adc-tm interrupt disable failed with %d\n", ret);
+		goto disable_fail;
+	}
+
+
+	ret = adc_tm5_gen2_conv_req(channel->chip);
+	if (ret < 0)
+		dev_err(chip->dev, "adc-tm channel configure failed with %d\n", ret);
+
+disable_fail:
+	mutex_unlock(&chip->adc_mutex_lock);
+	return ret;
+}
+
 static int adc_tm5_enable(struct adc_tm5_chip *chip)
 {
 	int ret;
@@ -320,6 +576,86 @@ static int adc_tm5_configure(struct adc_tm5_channel *channel, int low, int high)
 	return adc_tm5_enable(chip);
 }
 
+static int adc_tm5_gen2_configure(struct adc_tm5_channel *channel, int low, int high)
+{
+	struct adc_tm5_chip *chip = channel->chip;
+	int ret;
+	u8 buf[14];
+	u16 adc_code;
+
+	mutex_lock(&chip->adc_mutex_lock);
+
+	channel->meas_en = true;
+
+	ret = adc_tm5_read(chip, ADC_TM_GEN2_SID, buf, sizeof(buf));
+	if (ret < 0) {
+		pr_err("adc-tm block read failed with %d\n", ret);
+		goto config_fail;
+	}
+
+	/* Set SID from virtual channel number */
+	buf[0] = channel->adc_channel >> 8;
+
+	/* Set TM channel number used and measurment interval */
+	buf[1] &= ~ADC_TM_GEN2_TM_CH_SEL;
+	buf[1] |= FIELD_PREP(ADC_TM_GEN2_TM_CH_SEL, channel->channel);
+	buf[1] &= ~ADC_TM_GEN2_MEAS_INT_SEL;
+	buf[1] |= FIELD_PREP(ADC_TM_GEN2_MEAS_INT_SEL, MEAS_INT_1S);
+
+	buf[2] &= ~ADC_TM_GEN2_CTL_DEC_RATIO_MASK;
+	buf[2] |= FIELD_PREP(ADC_TM_GEN2_CTL_DEC_RATIO_MASK, channel->decimation);
+	buf[2] &= ~ADC_TM_GEN2_CTL_CAL_SEL;
+	buf[2] |= FIELD_PREP(ADC_TM_GEN2_CTL_CAL_SEL, channel->cal_method);
+
+	buf[3] = channel->avg_samples | ADC_TM_GEN2_FAST_AVG_EN;
+
+	buf[4] = channel->adc_channel & 0xff;
+
+	buf[5] = channel->hw_settle_time & ADC_TM_GEN2_HW_SETTLE_DELAY;
+
+	/* High temperature corresponds to low voltage threshold */
+	if (high != INT_MAX) {
+		channel->low_thr_en = true;
+		adc_code = qcom_adc_tm5_temp_res_scale(high);
+
+		buf[9] = adc_code & 0xff;
+		buf[10] = adc_code >> 8;
+	} else {
+		channel->low_thr_en = false;
+	}
+
+	/* Low temperature corresponds to high voltage threshold */
+	if (low != -INT_MAX) {
+		channel->high_thr_en = true;
+		adc_code = qcom_adc_tm5_temp_res_scale(low);
+
+		buf[11] = adc_code & 0xff;
+		buf[12] = adc_code >> 8;
+	} else {
+		channel->high_thr_en = false;
+	}
+
+	buf[13] = ADC_TM_GEN2_MEAS_EN;
+	if (channel->high_thr_en)
+		buf[13] |= ADC_TM5_GEN2_HIGH_THR_INT_EN;
+	if (channel->low_thr_en)
+		buf[13] |= ADC_TM5_GEN2_LOW_THR_INT_EN;
+
+	ret = adc_tm5_write(chip, ADC_TM_GEN2_SID, buf, sizeof(buf));
+	if (ret) {
+		dev_err(chip->dev, "channel %d params write failed: %d\n", channel->channel, ret);
+		goto config_fail;
+	}
+
+	ret = adc_tm5_gen2_conv_req(channel->chip);
+	if (ret < 0)
+		dev_err(chip->dev, "adc-tm channel configure failed with %d\n", ret);
+
+config_fail:
+	mutex_unlock(&chip->adc_mutex_lock);
+	return ret;
+}
+
 static int adc_tm5_set_trips(void *data, int low, int high)
 {
 	struct adc_tm5_channel *channel = data;
@@ -334,14 +670,14 @@ static int adc_tm5_set_trips(void *data, int low, int high)
 		channel->channel, low, high);
 
 	if (high == INT_MAX && low <= -INT_MAX)
-		ret = adc_tm5_disable_channel(channel);
+		ret = chip->data->ops->disable_channel(channel);
 	else
-		ret = adc_tm5_configure(channel, low, high);
+		ret = chip->data->ops->configure(channel, low, high);
 
 	return ret;
 }
 
-static struct thermal_zone_of_device_ops adc_tm5_ops = {
+static struct thermal_zone_of_device_ops adc_tm5_thermal_ops = {
 	.get_temp = adc_tm5_get_temp,
 	.set_trips = adc_tm5_set_trips,
 };
@@ -357,7 +693,7 @@ static int adc_tm5_register_tzd(struct adc_tm5_chip *adc_tm)
 		tzd = devm_thermal_zone_of_sensor_register(adc_tm->dev,
 							   adc_tm->channels[i].channel,
 							   &adc_tm->channels[i],
-							   &adc_tm5_ops);
+							   &adc_tm5_thermal_ops);
 		if (IS_ERR(tzd)) {
 			if (PTR_ERR(tzd) == -ENODEV) {
 				dev_warn(adc_tm->dev, "thermal sensor on channel %d is not used\n",
@@ -410,12 +746,37 @@ static int adc_tm5_init(struct adc_tm5_chip *chip)
 	return ret;
 }
 
+static int adc_tm5_gen2_init(struct adc_tm5_chip *chip)
+{
+	u8 channels_available;
+	int ret;
+	unsigned int i;
+
+	ret = adc_tm5_read(chip, ADC_TM5_NUM_BTM,
+			   &channels_available, sizeof(channels_available));
+	if (ret) {
+		dev_err(chip->dev, "read failed for BTM channels\n");
+		return ret;
+	}
+
+	mutex_init(&chip->adc_mutex_lock);
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
 static int adc_tm5_get_dt_channel_data(struct adc_tm5_chip *adc_tm,
 				       struct adc_tm5_channel *channel,
 				       struct device_node *node)
 {
 	const char *name = node->name;
-	u32 chan, value, varr[2];
+	u32 chan, value, adc_channel, varr[2];
 	int ret;
 	struct device *dev = adc_tm->dev;
 	struct of_phandle_args args;
@@ -445,7 +806,11 @@ static int adc_tm5_get_dt_channel_data(struct adc_tm5_chip *adc_tm,
 	}
 	of_node_put(args.np);
 
-	if (args.args_count != 1 || args.args[0] >= ADC5_MAX_CHANNEL) {
+	adc_channel = args.args[0];
+	if (adc_tm->data->ops == &ops_adc_tm5[ADC_TM5_GEN2])
+		adc_channel &= 0xff;
+
+	if (args.args_count != 1 || adc_channel >= ADC5_MAX_CHANNEL) {
 		dev_err(dev, "%s: invalid ADC channel number %d\n", name, chan);
 		return -EINVAL;
 	}
@@ -491,6 +856,32 @@ static int adc_tm5_get_dt_channel_data(struct adc_tm5_chip *adc_tm,
 	else
 		channel->cal_method = ADC_TM5_ABSOLUTE_CAL;
 
+	if (adc_tm->data->ops == &ops_adc_tm5[ADC_TM5_GEN2]) {
+		ret = of_property_read_u32(node, "qcom,decimation", &value);
+		if (!ret) {
+			ret = qcom_adc5_decimation_from_dt(value, adc_tm->data->decimation);
+			if (ret < 0) {
+				dev_err(dev, "invalid decimation %d\n", value);
+				return ret;
+			}
+			channel->decimation = ret;
+		} else {
+			channel->decimation = ADC5_DECIMATION_DEFAULT;
+		}
+
+		ret = of_property_read_u32(node, "qcom,avg-samples", &value);
+		if (!ret) {
+			ret = qcom_adc5_avg_samples_from_dt(value);
+			if (ret < 0) {
+				dev_err(dev, "invalid avg-samples %d\n", value);
+				return ret;
+			}
+			channel->avg_samples = ret;
+		} else {
+			channel->avg_samples = VADC_DEF_AVG_SAMPLES;
+		}
+	}
+
 	return 0;
 }
 
@@ -591,7 +982,7 @@ static int adc_tm5_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = adc_tm5_init(adc_tm);
+	ret = adc_tm->data->ops->init(adc_tm);
 	if (ret) {
 		dev_err(dev, "adc-tm init failed\n");
 		return ret;
@@ -603,15 +994,37 @@ static int adc_tm5_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	if (adc_tm->data->ops == &ops_adc_tm5[ADC_TM5_GEN2])
+		return devm_request_threaded_irq(dev, irq, NULL, adc_tm5_gen2_isr,
+				IRQF_ONESHOT, "pm-adc-tm5-gen2", adc_tm);
+
 	return devm_request_threaded_irq(dev, irq, NULL, adc_tm5_isr,
-					 IRQF_ONESHOT, "pm-adc-tm5", adc_tm);
+				IRQF_ONESHOT, "pm-adc-tm5", adc_tm);
 }
 
+static const struct adc_tm_ops ops_adc_tm5[ADC_TM5_MAX] = {
+	[ADC_TM5] = {
+		.disable_channel = adc_tm5_disable_channel,
+		.configure = adc_tm5_configure,
+		.init = adc_tm5_init,
+	},
+
+	[ADC_TM5_GEN2] = {
+		.disable_channel = adc_tm5_gen2_disable_channel,
+		.configure = adc_tm5_gen2_configure,
+		.init = adc_tm5_gen2_init,
+	},
+};
+
 static const struct of_device_id adc_tm5_match_table[] = {
 	{
 		.compatible = "qcom,spmi-adc-tm5",
 		.data = &adc_tm5_data_pmic,
 	},
+	{
+		.compatible = "qcom,spmi-adc-tm5-gen2",
+		.data = &adc_tm5_gen2_data_pmic,
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, adc_tm5_match_table);
diff --git a/include/linux/iio/adc/qcom-vadc-common.h b/include/linux/iio/adc/qcom-vadc-common.h
index 33f60f4..fa2eabe 100644
--- a/include/linux/iio/adc/qcom-vadc-common.h
+++ b/include/linux/iio/adc/qcom-vadc-common.h
@@ -161,6 +161,8 @@ int qcom_adc5_hw_scale(enum vadc_scale_fn_type scaletype,
 u16 qcom_adc_tm5_temp_volt_scale(unsigned int prescale_ratio,
 				 u32 full_scale_code_volt, int temp);
 
+u16 qcom_adc_tm5_temp_res_scale(int temp);
+
 int qcom_adc5_prescaling_from_dt(u32 num, u32 den);
 
 int qcom_adc5_hw_settle_time_from_dt(u32 value, const unsigned int *hw_settle);
-- 
2.7.4

