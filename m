Return-Path: <linux-iio+bounces-25076-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4528DBDBA14
	for <lists+linux-iio@lfdr.de>; Wed, 15 Oct 2025 00:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF69E543165
	for <lists+linux-iio@lfdr.de>; Tue, 14 Oct 2025 22:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6DA30DD27;
	Tue, 14 Oct 2025 22:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="bn6X6D1m"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E00257AD3;
	Tue, 14 Oct 2025 22:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760480559; cv=none; b=ozDXDg2Te2Hvb0LAJWCvZp+NlofzadyDFPj2hhZR6fz/ETtCPZXIsjZBv/Ht2XezIAZVybgXAIrXYoWn0aU+J2ywZngLzvL1uKarLrtaBFY9eFB1FI2+1UHv5qZj/vEzBFjJ9UPY7GgYydgYdRA+nOBDpy4sfhxPt9uYpPh+sMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760480559; c=relaxed/simple;
	bh=9hIYWSt7pGN9qpdQ9WSpEFAMIB/uDswTjKbKWwKz8/8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AXCvPNQPaq3PkSpSEZ225X8yKzdcVmKStv5GyhbO7FRZKKxO3cvFogCePghellDx4E22qmUWaJKVW4qJJMo1QEaZEnSJg0d6ttycUtFbkD1QIJA/Gba5V6Bj7UlH6jOtGQVVJW2/CAehyQ5AiMBuPQWmiSFaCvpkky6rZUfUWrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=bn6X6D1m; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59EIm4R1008521;
	Tue, 14 Oct 2025 18:22:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=CVua3
	8IVU26l4VFusghBn6oTsN33l1rWwNv4RD823Ww=; b=bn6X6D1moPAlcL2HjlzBC
	OBYvksntVd3jj7Bs3MaEsPALDka+a7sGX8IrA2uU6Pn1QHr93Hw1ASL/kMly809D
	9GHBelV+QkseZWGKw3XRfvIWooBtyU1Ur1uzynikISSyqBiWVCL0ofzX1P2r+Bxb
	/o/lk/ZSS015LThwyq+TgpV/2Cjak5jP6IlahmLbZ0cD425yW5952KgQR4DsIUBd
	eHXAbe5w8dNC74kfhm6fFf0jgeQs5TuOgsjPJSmpvY8ADsCKXRDhxYaLAoi/Lvj/
	CcSwo2EPrhMxFWJgf4+N2uBK+CACa1fKpBEDvtc/GGLO9AKUxQt+Wv6G6nP2FRk/
	Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 49qm50krbk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Oct 2025 18:22:30 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 59EMMTc5042848
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 14 Oct 2025 18:22:29 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Tue, 14 Oct
 2025 18:22:29 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 14 Oct 2025 18:22:29 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 59EMMDEF005519;
	Tue, 14 Oct 2025 18:22:16 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <michael.hennerich@analog.com>, <nuno.sa@analog.com>,
        <eblanc@baylibre.com>, <dlechner@baylibre.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <corbet@lwn.net>, <marcelo.schmitt1@gmail.com>,
        Trevor Gamblin
	<tgamblin@baylibre.com>,
        Axel Haslam <ahaslam@baylibre.com>
Subject: [PATCH v5 5/7] iio: adc: ad4030: Add SPI offload support
Date: Tue, 14 Oct 2025 19:22:13 -0300
Message-ID: <c12569f251962ad6034395e53cd6d998ce78a63f.1760479760.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1760479760.git.marcelo.schmitt@analog.com>
References: <cover.1760479760.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=cJ7tc1eN c=1 sm=1 tr=0 ts=68eecd26 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=IpJZQVW2AAAA:8 a=gAnH3GRIAAAA:8
 a=hsbic9MvOciXh3eYcaMA:9 a=IawgGOuG5U0WyFbmm1f5:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDA0NyBTYWx0ZWRfX/v49GhLLYjcD
 xHZODVFcy/tNixb3C7oRftE4NVeFZYiEdGDyZru4mICw811HoKq7na2bvlv8oV/NqRzZHvPL/o8
 1sMWglTB1DRHW6ntsPY8L7cbomfAra0JZUdpLwJpnnbghbgBA8vL0e0TRNaeP8IMw7fM7MlIfmV
 577KWLDEk8jn7+rzvLGv+6xVqWNXOOsvc7cHg8545b3Ufo1xDh4p5r3KSA93TXjiD1BR7Q2U+F+
 AmXWXZ6ooB77d6f8LoU99R8Is6YrKYtm6+DEIRdSVU/cYfnGN32gvVHVeAF4aTb1uabhQh6m8Gq
 EUqN0lxeaKQ/63guiTB92KD7NLji0bmVMbc6+axLyykR1zogU+tKJ+8RGSX1nmDykkGPzPGPU48
 XqrFZSGcS7gA5JwTOwuvJKF7tsF44w==
X-Proofpoint-GUID: AEKxgCcbNCEFknSVg2WAtm3ligbDicRI
X-Proofpoint-ORIG-GUID: AEKxgCcbNCEFknSVg2WAtm3ligbDicRI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 spamscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110047

AD4030 and similar ADCs can capture data at sample rates up to 2 mega
samples per second (MSPS). Not all SPI controllers are able to achieve such
high throughputs and even when the controller is fast enough to run
transfers at the required speed, it may be costly to the CPU to handle
transfer data at such high sample rates. Add SPI offload support for AD4030
and similar ADCs to enable data capture at maximum sample rates.

Co-developed-by: Trevor Gamblin <tgamblin@baylibre.com>
Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
Co-developed-by: Axel Haslam <ahaslam@baylibre.com>
Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
Change log v4 -> v5
- Made Kconfig entry depend on PWM and select other features.
- Reused ad4030_exit_config_mode() in ad4030_offload_buffer_postenable().
- Dropped common-mode voltage support on SPI offload setup.
- Adjusted offload trigger period calculation.
- No longer setting data frame mode from ad4030_set_avg_frame_len().
- Rearranged code to reduce patch diff.

 drivers/iio/adc/Kconfig  |   5 +
 drivers/iio/adc/ad4030.c | 425 +++++++++++++++++++++++++++++++++++++--
 2 files changed, 416 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index b0580fcefef5..f76df0609b3d 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -60,9 +60,14 @@ config AD4030
 	tristate "Analog Devices AD4030 ADC Driver"
 	depends on SPI
 	depends on GPIOLIB
+	depends on PWM
 	select REGMAP
 	select IIO_BUFFER
+	select IIO_BUFFER_DMA
+	select IIO_BUFFER_DMAENGINE
 	select IIO_TRIGGERED_BUFFER
+	select SPI_OFFLOAD
+	select SPI_OFFLOAD_TRIGGER_PWM
 	help
 	  Say yes here to build support for Analog Devices AD4030 and AD4630 high speed
 	  SPI analog to digital converters (ADC).
diff --git a/drivers/iio/adc/ad4030.c b/drivers/iio/adc/ad4030.c
index b2847fd90271..3df0b593c808 100644
--- a/drivers/iio/adc/ad4030.c
+++ b/drivers/iio/adc/ad4030.c
@@ -14,15 +14,25 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/cleanup.h>
 #include <linux/clk.h>
+#include <linux/dmaengine.h>
+#include <linux/iio/buffer-dmaengine.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
+#include <linux/limits.h>
+#include <linux/log2.h>
+#include <linux/math64.h>
+#include <linux/minmax.h>
+#include <linux/pwm.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
+#include <linux/spi/offload/consumer.h>
 #include <linux/spi/spi.h>
 #include <linux/unaligned.h>
 #include <linux/units.h>
+#include <linux/types.h>
 
 #define AD4030_REG_INTERFACE_CONFIG_A			0x00
 #define     AD4030_REG_INTERFACE_CONFIG_A_SW_RESET	(BIT(0) | BIT(7))
@@ -111,6 +121,8 @@
 #define AD4632_TCYC_NS			2000
 #define AD4632_TCYC_ADJUSTED_NS		(AD4632_TCYC_NS - AD4030_TCNVL_NS)
 #define AD4030_TRESET_COM_DELAY_MS	750
+/* Datasheet says 9.8ns, so use the closest integer value */
+#define AD4030_TQUIET_CNV_DELAY_NS	10
 
 enum ad4030_out_mode {
 	AD4030_OUT_DATA_MD_DIFF,
@@ -136,11 +148,13 @@ struct ad4030_chip_info {
 	const char *name;
 	const unsigned long *available_masks;
 	const struct iio_chan_spec channels[AD4030_MAX_IIO_CHANNEL_NB];
+	const struct iio_chan_spec offload_channels[AD4030_MAX_IIO_CHANNEL_NB];
 	u8 grade;
 	u8 precision_bits;
 	/* Number of hardware channels */
 	int num_voltage_inputs;
 	unsigned int tcyc_ns;
+	unsigned int max_sample_rate_hz;
 };
 
 struct ad4030_state {
@@ -153,6 +167,14 @@ struct ad4030_state {
 	int offset_avail[3];
 	unsigned int avg_log2;
 	enum ad4030_out_mode mode;
+	/* Offload sampling */
+	struct spi_transfer offload_xfer;
+	struct spi_message offload_msg;
+	struct spi_offload *offload;
+	struct spi_offload_trigger *offload_trigger;
+	struct spi_offload_trigger_config offload_trigger_config;
+	struct pwm_device *cnv_trigger;
+	struct pwm_waveform cnv_wf;
 
 	/*
 	 * DMA (thus cache coherency maintenance) requires the transfer buffers
@@ -209,8 +231,9 @@ struct ad4030_state {
  * - voltage0-voltage1
  * - voltage2-voltage3
  */
-#define AD4030_CHAN_DIFF(_idx, _scan_type) {				\
+#define __AD4030_CHAN_DIFF(_idx, _scan_type, _offload) {		\
 	.info_mask_shared_by_all =					\
+		(_offload ? BIT(IIO_CHAN_INFO_SAMP_FREQ) : 0) |		\
 		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),			\
 	.info_mask_shared_by_all_available =				\
 		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),			\
@@ -232,6 +255,12 @@ struct ad4030_state {
 	.num_ext_scan_type = ARRAY_SIZE(_scan_type),			\
 }
 
+#define AD4030_CHAN_DIFF(_idx, _scan_type)				\
+	__AD4030_CHAN_DIFF(_idx, _scan_type, 0)
+
+#define AD4030_OFFLOAD_CHAN_DIFF(_idx, _scan_type)			\
+	__AD4030_CHAN_DIFF(_idx, _scan_type, 1)
+
 static const int ad4030_average_modes[] = {
 	BIT(0),					/* No averaging/oversampling */
 	BIT(1), BIT(2), BIT(3), BIT(4),		/* 2 to 16 */
@@ -240,6 +269,11 @@ static const int ad4030_average_modes[] = {
 	BIT(13), BIT(14), BIT(15), BIT(16),	/* 8192 to 65536 */
 };
 
+static const struct spi_offload_config ad4030_offload_config = {
+	.capability_flags = SPI_OFFLOAD_CAP_TRIGGER |
+			    SPI_OFFLOAD_CAP_RX_STREAM_DMA,
+};
+
 static int ad4030_enter_config_mode(struct ad4030_state *st)
 {
 	st->tx_data[0] = AD4030_REG_ACCESS;
@@ -453,6 +487,103 @@ static int ad4030_get_chan_calibbias(struct iio_dev *indio_dev,
 	}
 }
 
+static void ad4030_get_sampling_freq(struct ad4030_state *st, int *freq)
+{
+	struct spi_offload_trigger_config *config = &st->offload_trigger_config;
+
+	/*
+	 * Conversion data is fetched from the device when the offload transfer
+	 * is triggered. Thus, provide the SPI offload trigger frequency as the
+	 * sampling frequency.
+	 */
+	*freq = config->periodic.frequency_hz;
+}
+
+static int ad4030_update_conversion_rate(struct ad4030_state *st,
+					 unsigned int freq_hz, unsigned int avg_log2)
+{
+	struct spi_offload_trigger_config *config = &st->offload_trigger_config;
+	struct pwm_waveform cnv_wf = { };
+	u64 target = AD4030_TCNVH_NS;
+	unsigned int cnv_rate_hz;
+	u64 offload_period_ns;
+	u64 offload_offset_ns;
+	int ret;
+
+	/*
+	 * When averaging/oversampling over N samples, we fire the offload
+	 * trigger once at every N pulses of the CNV signal. Conversely, the CNV
+	 * signal needs to be N times faster than the offload trigger. Take that
+	 * into account to correctly re-evaluate both the PWM waveform connected
+	 * to CNV and the SPI offload trigger.
+	 */
+	cnv_rate_hz = freq_hz << avg_log2;
+
+	cnv_wf.period_length_ns = DIV_ROUND_CLOSEST(NSEC_PER_SEC, cnv_rate_hz);
+	/*
+	 * The datasheet lists a minimum time of 9.8 ns, but no maximum. If the
+	 * rounded PWM's value is less than 10, increase the target value by 10
+	 * and attempt to round the waveform again, until the value is at least
+	 * 10 ns. Use a separate variable to represent the target in case the
+	 * rounding is severe enough to keep putting the first few results under
+	 * the minimum 10ns condition checked by the while loop.
+	 */
+	do {
+		cnv_wf.duty_length_ns = target;
+		ret = pwm_round_waveform_might_sleep(st->cnv_trigger, &cnv_wf);
+		if (ret)
+			return ret;
+		target += AD4030_TCNVH_NS;
+	} while (cnv_wf.duty_length_ns < AD4030_TCNVH_NS);
+
+	if (!in_range(cnv_wf.period_length_ns, AD4030_TCYC_NS, INT_MAX))
+		return -EINVAL;
+
+	offload_period_ns = DIV_ROUND_CLOSEST(NSEC_PER_SEC, freq_hz);
+
+	config->periodic.frequency_hz = DIV_ROUND_UP_ULL(NSEC_PER_SEC,
+							 offload_period_ns);
+
+	/*
+	 * The hardware does the capture on zone 2 (when SPI trigger PWM
+	 * is used). This means that the SPI trigger signal should happen at
+	 * tsync + tquiet_con_delay being tsync the conversion signal period
+	 * and tquiet_con_delay 9.8ns. Hence set the PWM phase accordingly.
+	 *
+	 * The PWM waveform API only supports nanosecond resolution right now,
+	 * so round this setting to the closest available value.
+	 */
+	offload_offset_ns = AD4030_TQUIET_CNV_DELAY_NS;
+	do {
+		config->periodic.offset_ns = offload_offset_ns;
+		ret = spi_offload_trigger_validate(st->offload_trigger, config);
+		if (ret)
+			return ret;
+		offload_offset_ns += AD4030_TQUIET_CNV_DELAY_NS;
+	} while (config->periodic.offset_ns < AD4030_TQUIET_CNV_DELAY_NS);
+
+	st->cnv_wf = cnv_wf;
+
+	return 0;
+}
+
+static int ad4030_set_sampling_freq(struct iio_dev *indio_dev, int freq_hz)
+{
+	struct ad4030_state *st = iio_priv(indio_dev);
+
+	/*
+	 * We have no control over the sampling frequency without SPI offload
+	 * triggering.
+	 */
+	if (!st->offload_trigger)
+		return -ENODEV;
+
+	if (!in_range(freq_hz, 1, st->chip->max_sample_rate_hz))
+		return -EINVAL;
+
+	return ad4030_update_conversion_rate(st, freq_hz, st->avg_log2);
+}
+
 static int ad4030_set_chan_calibscale(struct iio_dev *indio_dev,
 				      struct iio_chan_spec const *chan,
 				      int gain_int,
@@ -512,11 +643,30 @@ static int ad4030_set_avg_frame_len(struct iio_dev *dev, int avg_val)
 	struct ad4030_state *st = iio_priv(dev);
 	unsigned int avg_log2 = ilog2(avg_val);
 	unsigned int last_avg_idx = ARRAY_SIZE(ad4030_average_modes) - 1;
+	int freq_hz;
 	int ret;
 
 	if (avg_val < 0 || avg_val > ad4030_average_modes[last_avg_idx])
 		return -EINVAL;
 
+	if (st->offload_trigger) {
+		/*
+		 * The sample averaging and sampling frequency configurations
+		 * are mutually dependent one from another. That's because the
+		 * effective data sample rate is fCNV / 2^N, where N is the
+		 * number of samples being averaged.
+		 *
+		 * When SPI offload is supported and we have control over the
+		 * sample rate, the conversion start signal (CNV) and the SPI
+		 * offload trigger frequencies must be re-evaluated so data is
+		 * fetched only after 'avg_val' conversions.
+		 */
+		ad4030_get_sampling_freq(st, &freq_hz);
+		ret = ad4030_update_conversion_rate(st, freq_hz, avg_log2);
+		if (ret)
+			return ret;
+	}
+
 	ret = regmap_write(st->regmap, AD4030_REG_AVG,
 			   AD4030_REG_AVG_MASK_AVG_SYNC |
 			   FIELD_PREP(AD4030_REG_AVG_MASK_AVG_VAL, avg_log2));
@@ -769,6 +919,13 @@ static int ad4030_read_raw_dispatch(struct iio_dev *indio_dev,
 		*val = BIT(st->avg_log2);
 		return IIO_VAL_INT;
 
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		if (!st->offload_trigger)
+			return -ENODEV;
+
+		ad4030_get_sampling_freq(st, val);
+		return IIO_VAL_INT;
+
 	default:
 		return -EINVAL;
 	}
@@ -809,6 +966,9 @@ static int ad4030_write_raw_dispatch(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
 		return ad4030_set_avg_frame_len(indio_dev, val);
 
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		return ad4030_set_sampling_freq(indio_dev, val);
+
 	default:
 		return -EINVAL;
 	}
@@ -898,6 +1058,104 @@ static const struct iio_buffer_setup_ops ad4030_buffer_setup_ops = {
 	.validate_scan_mask = ad4030_validate_scan_mask,
 };
 
+static void ad4030_prepare_offload_msg(struct iio_dev *indio_dev)
+{
+	struct ad4030_state *st = iio_priv(indio_dev);
+	u8 offload_bpw;
+
+	if (st->mode == AD4030_OUT_DATA_MD_30_AVERAGED_DIFF)
+		offload_bpw = 32;
+	else
+		offload_bpw = st->chip->precision_bits;
+
+	st->offload_xfer.bits_per_word = offload_bpw;
+	st->offload_xfer.len = spi_bpw_to_bytes(offload_bpw);
+	st->offload_xfer.offload_flags = SPI_OFFLOAD_XFER_RX_STREAM;
+	spi_message_init_with_transfers(&st->offload_msg, &st->offload_xfer, 1);
+}
+
+static int ad4030_offload_buffer_postenable(struct iio_dev *indio_dev)
+{
+	struct ad4030_state *st = iio_priv(indio_dev);
+	unsigned int reg_modes;
+	int ret, ret2;
+
+	/*
+	 * When data from 2 analog input channels is output through a single
+	 * bus line (interleaved mode (LANE_MD == 0b11)) and gets pushed through
+	 * DMA, extra hardware is required to do the de-interleaving. While we
+	 * don't support such hardware configurations, disallow interleaved mode
+	 * when using SPI offload.
+	 */
+	ret = regmap_read(st->regmap, AD4030_REG_MODES, &reg_modes);
+	if (ret)
+		return ret;
+
+	if (st->chip->num_voltage_inputs > 1 &&
+	    FIELD_GET(AD4030_REG_MODES_MASK_LANE_MODE, reg_modes) == AD4030_LANE_MD_INTERLEAVED)
+		return -EINVAL;
+
+	ret = ad4030_exit_config_mode(st);
+	if (ret)
+		return ret;
+
+	ad4030_prepare_offload_msg(indio_dev);
+	st->offload_msg.offload = st->offload;
+	ret = spi_optimize_message(st->spi, &st->offload_msg);
+	if (ret)
+		goto out_reset_mode;
+
+	ret = pwm_set_waveform_might_sleep(st->cnv_trigger, &st->cnv_wf, false);
+	if (ret)
+		goto out_unoptimize;
+
+	ret = spi_offload_trigger_enable(st->offload, st->offload_trigger,
+					 &st->offload_trigger_config);
+	if (ret)
+		goto out_pwm_disable;
+
+	return 0;
+
+out_pwm_disable:
+	pwm_disable(st->cnv_trigger);
+out_unoptimize:
+	spi_unoptimize_message(&st->offload_msg);
+out_reset_mode:
+	/* reenter register configuration mode */
+	ret2 = ad4030_enter_config_mode(st);
+	if (ret2)
+		dev_err(&st->spi->dev,
+			"couldn't reenter register configuration mode: %d\n",
+			ret2);
+
+	return ret;
+}
+
+static int ad4030_offload_buffer_predisable(struct iio_dev *indio_dev)
+{
+	struct ad4030_state *st = iio_priv(indio_dev);
+	int ret;
+
+	spi_offload_trigger_disable(st->offload, st->offload_trigger);
+
+	pwm_disable(st->cnv_trigger);
+
+	spi_unoptimize_message(&st->offload_msg);
+
+	/* reenter register configuration mode */
+	ret = ad4030_enter_config_mode(st);
+	if (ret)
+		dev_err(&st->spi->dev,
+			"couldn't reenter register configuration mode\n");
+
+	return ret;
+}
+
+static const struct iio_buffer_setup_ops ad4030_offload_buffer_setup_ops = {
+	.postenable = &ad4030_offload_buffer_postenable,
+	.predisable = &ad4030_offload_buffer_predisable,
+};
+
 static int ad4030_regulators_get(struct ad4030_state *st)
 {
 	struct device *dev = &st->spi->dev;
@@ -967,6 +1225,24 @@ static int ad4030_detect_chip_info(const struct ad4030_state *st)
 	return 0;
 }
 
+static int ad4030_pwm_get(struct ad4030_state *st)
+{
+	struct device *dev = &st->spi->dev;
+
+	st->cnv_trigger = devm_pwm_get(dev, NULL);
+	if (IS_ERR(st->cnv_trigger))
+		return dev_err_probe(dev, PTR_ERR(st->cnv_trigger),
+				     "Failed to get CNV PWM\n");
+
+	/*
+	 * Preemptively disable the PWM, since we only want to enable it with
+	 * the buffer.
+	 */
+	pwm_disable(st->cnv_trigger);
+
+	return 0;
+}
+
 static int ad4030_config(struct ad4030_state *st)
 {
 	int ret;
@@ -994,6 +1270,31 @@ static int ad4030_config(struct ad4030_state *st)
 	return 0;
 }
 
+static int ad4030_spi_offload_setup(struct iio_dev *indio_dev,
+				    struct ad4030_state *st)
+{
+	struct device *dev = &st->spi->dev;
+	struct dma_chan *rx_dma;
+
+	indio_dev->setup_ops = &ad4030_offload_buffer_setup_ops;
+
+	st->offload_trigger = devm_spi_offload_trigger_get(dev, st->offload,
+							   SPI_OFFLOAD_TRIGGER_PERIODIC);
+	if (IS_ERR(st->offload_trigger))
+		return dev_err_probe(dev, PTR_ERR(st->offload_trigger),
+				     "failed to get offload trigger\n");
+
+	st->offload_trigger_config.type = SPI_OFFLOAD_TRIGGER_PERIODIC;
+
+	rx_dma = devm_spi_offload_rx_stream_request_dma_chan(dev, st->offload);
+	if (IS_ERR(rx_dma))
+		return dev_err_probe(dev, PTR_ERR(rx_dma),
+				     "failed to get offload RX DMA\n");
+
+	return devm_iio_dmaengine_buffer_setup_with_handle(dev, indio_dev, rx_dma,
+							   IIO_BUFFER_DIRECTION_IN);
+}
+
 static int ad4030_probe(struct spi_device *spi)
 {
 	struct device *dev = &spi->dev;
@@ -1045,24 +1346,61 @@ static int ad4030_probe(struct spi_device *spi)
 		return dev_err_probe(dev, PTR_ERR(st->cnv_gpio),
 				     "Failed to get cnv gpio\n");
 
-	/*
-	 * One hardware channel is split in two software channels when using
-	 * common byte mode. Add one more channel for the timestamp.
-	 */
-	indio_dev->num_channels = 2 * st->chip->num_voltage_inputs + 1;
 	indio_dev->name = st->chip->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &ad4030_iio_info;
-	indio_dev->channels = st->chip->channels;
 	indio_dev->available_scan_masks = st->chip->available_masks;
 
-	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
-					      iio_pollfunc_store_time,
-					      ad4030_trigger_handler,
-					      &ad4030_buffer_setup_ops);
-	if (ret)
-		return dev_err_probe(dev, ret,
-				     "Failed to setup triggered buffer\n");
+	st->offload = devm_spi_offload_get(dev, spi, &ad4030_offload_config);
+	ret = PTR_ERR_OR_ZERO(st->offload);
+	if (ret && ret != -ENODEV)
+		return dev_err_probe(dev, ret, "failed to get offload\n");
+
+	/* Fall back to low speed usage when no SPI offload is available. */
+	if (ret == -ENODEV) {
+		/*
+		 * One hardware channel is split in two software channels when
+		 * using common byte mode. Add one more channel for the timestamp.
+		 */
+		indio_dev->num_channels = 2 * st->chip->num_voltage_inputs + 1;
+		indio_dev->channels = st->chip->channels;
+
+		ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
+						      iio_pollfunc_store_time,
+						      ad4030_trigger_handler,
+						      &ad4030_buffer_setup_ops);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "Failed to setup triggered buffer\n");
+	} else {
+		/*
+		 * One hardware channel is split in two software channels when
+		 * using common byte mode. Offloaded SPI transfers can't support
+		 * software timestamp so no additional timestamp channel is added.
+		 */
+		indio_dev->num_channels = 2 * st->chip->num_voltage_inputs;
+		indio_dev->channels = st->chip->offload_channels;
+		ret = ad4030_spi_offload_setup(indio_dev, st);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "Failed to setup SPI offload\n");
+
+		ret = ad4030_pwm_get(st);
+		if (ret)
+			return dev_err_probe(&spi->dev, ret,
+					     "Failed to get PWM: %d\n", ret);
+
+		/*
+		 * Start with a slower sampling rate so there is some room for
+		 * adjusting the sample averaging and the sampling frequency
+		 * without hitting the maximum conversion rate.
+		 */
+		ret = ad4030_update_conversion_rate(st, st->chip->max_sample_rate_hz >> 4,
+						    st->avg_log2);
+		if (ret)
+			return dev_err_probe(&spi->dev, ret,
+					     "Failed to set offload samp freq\n");
+	}
 
 	return devm_iio_device_register(dev, indio_dev);
 }
@@ -1100,6 +1438,23 @@ static const struct iio_scan_type ad4030_24_scan_types[] = {
 	},
 };
 
+static const struct iio_scan_type ad4030_24_offload_scan_types[] = {
+	[AD4030_SCAN_TYPE_NORMAL] = {
+		.sign = 's',
+		.storagebits = 32,
+		.realbits = 24,
+		.shift = 0,
+		.endianness = IIO_CPU,
+	},
+	[AD4030_SCAN_TYPE_AVG] = {
+		.sign = 's',
+		.storagebits = 32,
+		.realbits = 30,
+		.shift = 2,
+		.endianness = IIO_CPU,
+	},
+};
+
 static const struct iio_scan_type ad4030_16_scan_types[] = {
 	[AD4030_SCAN_TYPE_NORMAL] = {
 		.sign = 's',
@@ -1117,6 +1472,23 @@ static const struct iio_scan_type ad4030_16_scan_types[] = {
 	}
 };
 
+static const struct iio_scan_type ad4030_16_offload_scan_types[] = {
+	[AD4030_SCAN_TYPE_NORMAL] = {
+		.sign = 's',
+		.storagebits = 32,
+		.realbits = 16,
+		.shift = 0,
+		.endianness = IIO_CPU,
+	},
+	[AD4030_SCAN_TYPE_AVG] = {
+		.sign = 's',
+		.storagebits = 32,
+		.realbits = 30,
+		.shift = 2,
+		.endianness = IIO_CPU,
+	},
+};
+
 static const struct ad4030_chip_info ad4030_24_chip_info = {
 	.name = "ad4030-24",
 	.available_masks = ad4030_channel_masks,
@@ -1125,10 +1497,14 @@ static const struct ad4030_chip_info ad4030_24_chip_info = {
 		AD4030_CHAN_CMO(1, 0),
 		IIO_CHAN_SOFT_TIMESTAMP(2),
 	},
+	.offload_channels = {
+		AD4030_OFFLOAD_CHAN_DIFF(0, ad4030_24_offload_scan_types),
+	},
 	.grade = AD4030_REG_CHIP_GRADE_AD4030_24_GRADE,
 	.precision_bits = 24,
 	.num_voltage_inputs = 1,
 	.tcyc_ns = AD4030_TCYC_ADJUSTED_NS,
+	.max_sample_rate_hz = 2 * HZ_PER_MHZ,
 };
 
 static const struct ad4030_chip_info ad4630_16_chip_info = {
@@ -1141,10 +1517,15 @@ static const struct ad4030_chip_info ad4630_16_chip_info = {
 		AD4030_CHAN_CMO(3, 1),
 		IIO_CHAN_SOFT_TIMESTAMP(4),
 	},
+	.offload_channels = {
+		AD4030_OFFLOAD_CHAN_DIFF(0, ad4030_16_offload_scan_types),
+		AD4030_OFFLOAD_CHAN_DIFF(1, ad4030_16_offload_scan_types),
+	},
 	.grade = AD4030_REG_CHIP_GRADE_AD4630_16_GRADE,
 	.precision_bits = 16,
 	.num_voltage_inputs = 2,
 	.tcyc_ns = AD4030_TCYC_ADJUSTED_NS,
+	.max_sample_rate_hz = 2 * HZ_PER_MHZ,
 };
 
 static const struct ad4030_chip_info ad4630_24_chip_info = {
@@ -1157,10 +1538,15 @@ static const struct ad4030_chip_info ad4630_24_chip_info = {
 		AD4030_CHAN_CMO(3, 1),
 		IIO_CHAN_SOFT_TIMESTAMP(4),
 	},
+	.offload_channels = {
+		AD4030_OFFLOAD_CHAN_DIFF(0, ad4030_24_offload_scan_types),
+		AD4030_OFFLOAD_CHAN_DIFF(1, ad4030_24_offload_scan_types),
+	},
 	.grade = AD4030_REG_CHIP_GRADE_AD4630_24_GRADE,
 	.precision_bits = 24,
 	.num_voltage_inputs = 2,
 	.tcyc_ns = AD4030_TCYC_ADJUSTED_NS,
+	.max_sample_rate_hz = 2 * HZ_PER_MHZ,
 };
 
 static const struct ad4030_chip_info ad4632_16_chip_info = {
@@ -1173,10 +1559,15 @@ static const struct ad4030_chip_info ad4632_16_chip_info = {
 		AD4030_CHAN_CMO(3, 1),
 		IIO_CHAN_SOFT_TIMESTAMP(4),
 	},
+	.offload_channels = {
+		AD4030_OFFLOAD_CHAN_DIFF(0, ad4030_16_offload_scan_types),
+		AD4030_OFFLOAD_CHAN_DIFF(1, ad4030_16_offload_scan_types),
+	},
 	.grade = AD4030_REG_CHIP_GRADE_AD4632_16_GRADE,
 	.precision_bits = 16,
 	.num_voltage_inputs = 2,
 	.tcyc_ns = AD4632_TCYC_ADJUSTED_NS,
+	.max_sample_rate_hz = 500 * HZ_PER_KHZ,
 };
 
 static const struct ad4030_chip_info ad4632_24_chip_info = {
@@ -1189,10 +1580,15 @@ static const struct ad4030_chip_info ad4632_24_chip_info = {
 		AD4030_CHAN_CMO(3, 1),
 		IIO_CHAN_SOFT_TIMESTAMP(4),
 	},
+	.offload_channels = {
+		AD4030_OFFLOAD_CHAN_DIFF(0, ad4030_24_offload_scan_types),
+		AD4030_OFFLOAD_CHAN_DIFF(1, ad4030_24_offload_scan_types),
+	},
 	.grade = AD4030_REG_CHIP_GRADE_AD4632_24_GRADE,
 	.precision_bits = 24,
 	.num_voltage_inputs = 2,
 	.tcyc_ns = AD4632_TCYC_ADJUSTED_NS,
+	.max_sample_rate_hz = 500 * HZ_PER_KHZ,
 };
 
 static const struct spi_device_id ad4030_id_table[] = {
@@ -1228,3 +1624,4 @@ module_spi_driver(ad4030_driver);
 MODULE_AUTHOR("Esteban Blanc <eblanc@baylibre.com>");
 MODULE_DESCRIPTION("Analog Devices AD4630 ADC family driver");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("IIO_DMAENGINE_BUFFER");
-- 
2.39.2


