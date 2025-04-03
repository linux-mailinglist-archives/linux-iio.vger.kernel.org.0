Return-Path: <linux-iio+bounces-17602-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5864AA7A7F6
	for <lists+linux-iio@lfdr.de>; Thu,  3 Apr 2025 18:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 785FA1888674
	for <lists+linux-iio@lfdr.de>; Thu,  3 Apr 2025 16:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048E92512C5;
	Thu,  3 Apr 2025 16:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="Bpsuto1n"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B361927706;
	Thu,  3 Apr 2025 16:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743697705; cv=none; b=bpWAHbpafa/uITHdUpcmM/3AbHaeRhY5W7pbxg1B/VmzMqXJfnKn2ULx2UoRQwaF1VY+SYR1WRPnHbKZaGKl8lS035kqIoYOEGbjt3mHShY3wOjDeYbG/gjbObOtWsWRh8Hni3GSIdA6vZMBE9MJlQU/O+MPk+7l6kzqgu3nhvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743697705; c=relaxed/simple;
	bh=iz9RtCcFsyRRUIKRGNAGl1Uovc4URosI4sBMVQgpMeY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kAB9PhC9za1Z1+6zYtX+gOzaFP5BR5jRnFip8xUekzsiD4BSGEpf/Svmk2y3tcRvQCdufBsCtDxNUiQQddGyWXQEnMnCoGZ9XF/J9uCFXrs1B6DWiOI9Ylx3sJEF8yRayOcS5esSmS0fB74AkUWX8Cvara0edQ1zH0B77f+Wjmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=Bpsuto1n; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 533BPkd8024168;
	Thu, 3 Apr 2025 18:28:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=Ah0TZGtUrsVvEFBC1fVW/Y
	qrrmYj+hZ4lBmeNXKbcZM=; b=Bpsuto1naypPj/7FNujwTbvYkxWE3xsuM0Tlva
	VSxwJwK8qogA12QCLDCIBcxfGabnbXgIo6fwCaLW2AQyFofetj2tS2HiD8AVpCaR
	5GrG62sYWAUMWtIEWm8xyAJww/Xz+8XoDDcrQPhH8C6WtA7+x/4CAFhReXFFOw4x
	Wv12FsNGS3XZHazEci1SqACJEYW9JvbWnlawCewOvHVuWgWGOgLtG4nJVgHnhhbZ
	bBMC6hA86uVTG5B4CaV1k1hZdFI0A8q9HGOkhvW/3OiONEY3Exxu6evAYUpixqe4
	PEtfCbSDiMaqP2Rz6l6bW3hVWcY1FBlguUJZlZdPRDzCpL1w==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 45s2c7fdwx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Apr 2025 18:28:02 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 6E4924007E;
	Thu,  3 Apr 2025 18:26:37 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E01CE8C49E5;
	Thu,  3 Apr 2025 18:24:31 +0200 (CEST)
Received: from localhost (10.48.87.151) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 3 Apr
 2025 18:24:31 +0200
From: Olivier Moysan <olivier.moysan@foss.st.com>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>
CC: Olivier Moysan <olivier.moysan@foss.st.com>,
        Fabrice Gasnier
	<fabrice.gasnier@foss.st.com>,
        <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] iio: adc: stm32: add oversampling support
Date: Thu, 3 Apr 2025 18:23:57 +0200
Message-ID: <20250403162358.1257370-1-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-03_07,2025-04-03_01,2024-11-22_01

Add oversampling support for STM32H7, STM32MP15 & STM32MP13.
STM32F4 ADC has no oversampling feature.

The current support of the oversampling feature aims at increasing
the data SNR, without changing the data resolution.
As the oversampling by itself increases data resolution,
a right shift is applied to keep initial resolution.
Only the oversampling ratio corresponding to a power of two are
supported here, to get a direct link between right shift and
oversampling ratio. (2exp(n) ratio <=> n right shift)

The oversampling ratio is shared by all channels, whatever channel type.
(e.g. single ended or differential).

Oversampling can be configured using IIO ABI:
- in_voltage_oversampling_ratio_available
- in_voltage_oversampling_ratio

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>

---
Changes in v2:
- Remove useless header files
- Use FIELD_PREP macro
- Reorder stm32_adc_write_raw() function
---
 drivers/iio/adc/stm32-adc-core.h |  14 ++++
 drivers/iio/adc/stm32-adc.c      | 137 +++++++++++++++++++++++++++++++
 2 files changed, 151 insertions(+)

diff --git a/drivers/iio/adc/stm32-adc-core.h b/drivers/iio/adc/stm32-adc-core.h
index 73b2c2e91c08..bfd42c5456bf 100644
--- a/drivers/iio/adc/stm32-adc-core.h
+++ b/drivers/iio/adc/stm32-adc-core.h
@@ -91,6 +91,7 @@
 #define STM32H7_ADC_IER			0x04
 #define STM32H7_ADC_CR			0x08
 #define STM32H7_ADC_CFGR		0x0C
+#define STM32H7_ADC_CFGR2		0x10
 #define STM32H7_ADC_SMPR1		0x14
 #define STM32H7_ADC_SMPR2		0x18
 #define STM32H7_ADC_PCSEL		0x1C
@@ -160,6 +161,13 @@
 #define STM32H7_DMNGT_SHIFT		0
 #define STM32H7_DMNGT_MASK		GENMASK(1, 0)
 
+/* STM32H7_ADC_CFGR2 bit fields */
+#define STM32H7_OVSR_MASK		GENMASK(25, 16) /* Correspond to OSVR field in datasheet */
+#define STM32H7_OVSR(v)			FIELD_PREP(STM32H7_OVSR_MASK, v)
+#define STM32H7_OVSS_MASK		GENMASK(8, 5)
+#define STM32H7_OVSS(v)			FIELD_PREP(STM32H7_OVSS_MASK, v)
+#define STM32H7_ROVSE			BIT(0)
+
 enum stm32h7_adc_dmngt {
 	STM32H7_DMNGT_DR_ONLY,		/* Regular data in DR only */
 	STM32H7_DMNGT_DMA_ONESHOT,	/* DMA one shot mode */
@@ -226,6 +234,12 @@ enum stm32h7_adc_dmngt {
 #define STM32MP13_RES_SHIFT		3
 #define STM32MP13_RES_MASK		GENMASK(4, 3)
 
+/* STM32MP13_ADC_CFGR2 bit fields */
+#define STM32MP13_OVSR_MASK		GENMASK(4, 2)
+#define STM32MP13_OVSR(v)		FIELD_PREP(STM32MP13_OVSR_MASK, v)
+#define STM32MP13_OVSS_MASK		GENMASK(8, 5)
+#define STM32MP13_OVSS(v)		FIELD_PREP(STM32MP13_OVSS_MASK, v)
+
 /* STM32MP13_ADC_DIFSEL - bit fields */
 #define STM32MP13_DIFSEL_MASK		GENMASK(18, 0)
 
diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
index 5dbf5f136768..0f0910e05de8 100644
--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -6,6 +6,7 @@
  * Author: Fabrice Gasnier <fabrice.gasnier@st.com>.
  */
 
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/debugfs.h>
 #include <linux/delay.h>
@@ -202,11 +203,13 @@ struct stm32_adc;
  * @has_boostmode:	boost mode support flag
  * @has_linearcal:	linear calibration support flag
  * @has_presel:		channel preselection support flag
+ * @has_oversampling:	oversampling support flag
  * @prepare:		optional prepare routine (power-up, enable)
  * @start_conv:		routine to start conversions
  * @stop_conv:		routine to stop conversions
  * @unprepare:		optional unprepare routine (disable, power-down)
  * @irq_clear:		routine to clear irqs
+ * @set_ovs:		routine to set oversampling configuration
  * @smp_cycles:		programmable sampling time (ADC clock cycles)
  * @ts_int_ch:		pointer to array of internal channels minimum sampling time in ns
  */
@@ -219,11 +222,13 @@ struct stm32_adc_cfg {
 	bool has_boostmode;
 	bool has_linearcal;
 	bool has_presel;
+	bool has_oversampling;
 	int (*prepare)(struct iio_dev *);
 	void (*start_conv)(struct iio_dev *, bool dma);
 	void (*stop_conv)(struct iio_dev *);
 	void (*unprepare)(struct iio_dev *);
 	void (*irq_clear)(struct iio_dev *indio_dev, u32 msk);
+	void (*set_ovs)(struct iio_dev *indio_dev, u32 ovs_idx);
 	const unsigned int *smp_cycles;
 	const unsigned int *ts_int_ch;
 };
@@ -255,6 +260,7 @@ struct stm32_adc_cfg {
  * @num_diff:		number of differential channels
  * @int_ch:		internal channel indexes array
  * @nsmps:		number of channels with optional sample time
+ * @ovs_idx:		current oversampling ratio index (in oversampling array)
  */
 struct stm32_adc {
 	struct stm32_adc_common	*common;
@@ -282,6 +288,7 @@ struct stm32_adc {
 	u32			num_diff;
 	int			int_ch[STM32_ADC_INT_CH_NB];
 	int			nsmps;
+	int			ovs_idx;
 };
 
 struct stm32_adc_diff_channel {
@@ -293,12 +300,24 @@ struct stm32_adc_diff_channel {
  * struct stm32_adc_info - stm32 ADC, per instance config data
  * @max_channels:	Number of channels
  * @resolutions:	available resolutions
+ * @oversampling:	available oversampling ratios
  * @num_res:		number of available resolutions
+ * @num_ovs:		number of available oversampling ratios
  */
 struct stm32_adc_info {
 	int max_channels;
 	const unsigned int *resolutions;
+	const unsigned int *oversampling;
 	const unsigned int num_res;
+	const unsigned int num_ovs;
+};
+
+static const unsigned int stm32h7_adc_oversampling_avail[] = {
+1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024
+};
+
+static const unsigned int stm32mp13_adc_oversampling_avail[] = {
+1, 2, 4, 8, 16, 32, 64, 128, 256
 };
 
 static const unsigned int stm32f4_adc_resolutions[] = {
@@ -322,14 +341,18 @@ static const unsigned int stm32h7_adc_resolutions[] = {
 static const struct stm32_adc_info stm32h7_adc_info = {
 	.max_channels = STM32_ADC_CH_MAX,
 	.resolutions = stm32h7_adc_resolutions,
+	.oversampling = stm32h7_adc_oversampling_avail,
 	.num_res = ARRAY_SIZE(stm32h7_adc_resolutions),
+	.num_ovs = ARRAY_SIZE(stm32h7_adc_oversampling_avail),
 };
 
 /* stm32mp13 can have up to 19 channels */
 static const struct stm32_adc_info stm32mp13_adc_info = {
 	.max_channels = 19,
 	.resolutions = stm32f4_adc_resolutions,
+	.oversampling = stm32mp13_adc_oversampling_avail,
 	.num_res = ARRAY_SIZE(stm32f4_adc_resolutions),
+	.num_ovs = ARRAY_SIZE(stm32mp13_adc_oversampling_avail),
 };
 
 /*
@@ -889,6 +912,41 @@ static void stm32mp13_adc_start_conv(struct iio_dev *indio_dev, bool dma)
 	stm32_adc_set_bits(adc, STM32H7_ADC_CR, STM32H7_ADSTART);
 }
 
+static void stm32h7_adc_set_ovs(struct iio_dev *indio_dev, u32 ovs_idx)
+{
+	struct stm32_adc *adc = iio_priv(indio_dev);
+	u32 ovsr_bits, bits, msk;
+
+	msk = STM32H7_ROVSE | STM32H7_OVSR_MASK | STM32H7_OVSS_MASK;
+	stm32_adc_clr_bits(adc, STM32H7_ADC_CFGR2, msk);
+
+	if (!ovs_idx)
+		return;
+
+	ovsr_bits = (1 << ovs_idx) - 1;
+	bits = STM32H7_ROVSE | STM32H7_OVSS(ovs_idx) | STM32H7_OVSR(ovsr_bits);
+
+	stm32_adc_set_bits(adc, STM32H7_ADC_CFGR2, bits & msk);
+}
+
+static void stm32mp13_adc_set_ovs(struct iio_dev *indio_dev, u32 ovs_idx)
+{
+	struct stm32_adc *adc = iio_priv(indio_dev);
+	u32 bits, msk;
+
+	msk = STM32H7_ROVSE | STM32MP13_OVSR_MASK | STM32MP13_OVSS_MASK;
+	stm32_adc_clr_bits(adc, STM32H7_ADC_CFGR2, msk);
+
+	if (!ovs_idx)
+		return;
+
+	bits = STM32H7_ROVSE | STM32MP13_OVSS(ovs_idx);
+	if (ovs_idx - 1)
+		bits |= STM32MP13_OVSR(ovs_idx - 1);
+
+	stm32_adc_set_bits(adc, STM32H7_ADC_CFGR2, bits & msk);
+}
+
 static int stm32h7_adc_exit_pwr_down(struct iio_dev *indio_dev)
 {
 	struct stm32_adc *adc = iio_priv(indio_dev);
@@ -1461,6 +1519,69 @@ static int stm32_adc_single_conv(struct iio_dev *indio_dev,
 	return ret;
 }
 
+static int stm32_adc_write_raw(struct iio_dev *indio_dev,
+			       struct iio_chan_spec const *chan,
+			       int val, int val2, long mask)
+{
+	struct stm32_adc *adc = iio_priv(indio_dev);
+	struct device *dev = indio_dev->dev.parent;
+	int nb = adc->cfg->adc_info->num_ovs;
+	u32 idx;
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		if (val2)
+			return -EINVAL;
+
+		for (idx = 0; idx < nb; idx++)
+			if (adc->cfg->adc_info->oversampling[idx] == val)
+				break;
+
+		if (idx >= nb)
+			return -EINVAL;
+
+		ret = iio_device_claim_direct_mode(indio_dev);
+		if (ret)
+			return ret;
+
+		ret = pm_runtime_resume_and_get(dev);
+		if (ret < 0)
+			goto err;
+
+		adc->cfg->set_ovs(indio_dev, idx);
+
+		pm_runtime_mark_last_busy(dev);
+		pm_runtime_put_autosuspend(dev);
+
+		adc->ovs_idx = idx;
+
+err:
+		iio_device_release_direct_mode(indio_dev);
+
+		return ret;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int stm32_adc_read_avail(struct iio_dev *indio_dev,
+				struct iio_chan_spec const *chan,
+				const int **vals, int *type, int *length, long m)
+{
+	struct stm32_adc *adc = iio_priv(indio_dev);
+
+	switch (m) {
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		*type = IIO_VAL_INT;
+		*length = adc->cfg->adc_info->num_ovs;
+		*vals = adc->cfg->adc_info->oversampling;
+		return IIO_AVAIL_LIST;
+	default:
+		return -EINVAL;
+	}
+}
+
 static int stm32_adc_read_raw(struct iio_dev *indio_dev,
 			      struct iio_chan_spec const *chan,
 			      int *val, int *val2, long mask)
@@ -1502,6 +1623,10 @@ static int stm32_adc_read_raw(struct iio_dev *indio_dev,
 			*val = 0;
 		return IIO_VAL_INT;
 
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		*val = adc->cfg->adc_info->oversampling[adc->ovs_idx];
+		return IIO_VAL_INT;
+
 	default:
 		return -EINVAL;
 	}
@@ -1678,6 +1803,8 @@ static int stm32_adc_debugfs_reg_access(struct iio_dev *indio_dev,
 
 static const struct iio_info stm32_adc_iio_info = {
 	.read_raw = stm32_adc_read_raw,
+	.write_raw = stm32_adc_write_raw,
+	.read_avail = stm32_adc_read_avail,
 	.validate_trigger = stm32_adc_validate_trigger,
 	.hwfifo_set_watermark = stm32_adc_set_watermark,
 	.update_scan_mode = stm32_adc_update_scan_mode,
@@ -1971,6 +2098,10 @@ static void stm32_adc_chan_init_one(struct iio_dev *indio_dev,
 		chan->info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
 	chan->info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |
 					 BIT(IIO_CHAN_INFO_OFFSET);
+	if (adc->cfg->has_oversampling) {
+		chan->info_mask_shared_by_all |= BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO);
+		chan->info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO);
+	}
 	chan->scan_type.sign = 'u';
 	chan->scan_type.realbits = adc->cfg->adc_info->resolutions[adc->res];
 	chan->scan_type.storagebits = 16;
@@ -2587,6 +2718,7 @@ static const struct stm32_adc_cfg stm32h7_adc_cfg = {
 	.has_boostmode = true,
 	.has_linearcal = true,
 	.has_presel = true,
+	.has_oversampling = true,
 	.start_conv = stm32h7_adc_start_conv,
 	.stop_conv = stm32h7_adc_stop_conv,
 	.prepare = stm32h7_adc_prepare,
@@ -2594,6 +2726,7 @@ static const struct stm32_adc_cfg stm32h7_adc_cfg = {
 	.smp_cycles = stm32h7_adc_smp_cycles,
 	.irq_clear = stm32h7_adc_irq_clear,
 	.ts_int_ch = stm32_adc_min_ts_h7,
+	.set_ovs = stm32h7_adc_set_ovs,
 };
 
 static const unsigned int stm32_adc_min_ts_mp1[] = { 100, 100, 100, 4300, 9800 };
@@ -2607,6 +2740,7 @@ static const struct stm32_adc_cfg stm32mp1_adc_cfg = {
 	.has_boostmode = true,
 	.has_linearcal = true,
 	.has_presel = true,
+	.has_oversampling = true,
 	.start_conv = stm32h7_adc_start_conv,
 	.stop_conv = stm32h7_adc_stop_conv,
 	.prepare = stm32h7_adc_prepare,
@@ -2614,6 +2748,7 @@ static const struct stm32_adc_cfg stm32mp1_adc_cfg = {
 	.smp_cycles = stm32h7_adc_smp_cycles,
 	.irq_clear = stm32h7_adc_irq_clear,
 	.ts_int_ch = stm32_adc_min_ts_mp1,
+	.set_ovs = stm32h7_adc_set_ovs,
 };
 
 static const unsigned int stm32_adc_min_ts_mp13[] = { 100, 0, 0, 4300, 9800 };
@@ -2623,6 +2758,7 @@ static const struct stm32_adc_cfg stm32mp13_adc_cfg = {
 	.regs = &stm32mp13_adc_regspec,
 	.adc_info = &stm32mp13_adc_info,
 	.trigs = stm32h7_adc_trigs,
+	.has_oversampling = true,
 	.start_conv = stm32mp13_adc_start_conv,
 	.stop_conv = stm32h7_adc_stop_conv,
 	.prepare = stm32h7_adc_prepare,
@@ -2630,6 +2766,7 @@ static const struct stm32_adc_cfg stm32mp13_adc_cfg = {
 	.smp_cycles = stm32mp13_adc_smp_cycles,
 	.irq_clear = stm32h7_adc_irq_clear,
 	.ts_int_ch = stm32_adc_min_ts_mp13,
+	.set_ovs = stm32mp13_adc_set_ovs,
 };
 
 static const struct of_device_id stm32_adc_of_match[] = {
-- 
2.25.1


