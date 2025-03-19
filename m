Return-Path: <linux-iio+bounces-17099-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73CCAA692AD
	for <lists+linux-iio@lfdr.de>; Wed, 19 Mar 2025 16:14:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 437F44639CD
	for <lists+linux-iio@lfdr.de>; Wed, 19 Mar 2025 15:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178071D6DBF;
	Wed, 19 Mar 2025 14:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="aECYky05"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476181B0F1E;
	Wed, 19 Mar 2025 14:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742396278; cv=none; b=EAyJCcc/qFCZocegOZMp0X5asY4MN4z04uFNWb64C4oKpyHB2anLB5PzwZK64iKqWqfNk7NmEswPB7ThN7oxmzY7y7+l5RlwdFIcOk4f9OfaDKdYX20HTWx/cwdlrp3pNA1p7cuIh7BM2i8HAy7C/skxmIadKVUtG0axOXUTbnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742396278; c=relaxed/simple;
	bh=koG1NMwv0/MzOba5oG+GRKxH3wkzuGb+WtfhvWbLy3A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q3ikPCD66GK5dJStvpephFg6CzSe+h9gLrrX4yrVjYicgd2t18Ztwk7NjUxMHPF7aWGDCczzqWQQ00cVw3GbyTlWpUY8Q96s/VeyQ2cjLH1f98Dw5YG2zRU41dAhzsdEu4brB+siD8Zqgcjfdw6GqvR+SwuaaxGfR2Tfoyx3sEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=aECYky05; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52JCSKg4003549;
	Wed, 19 Mar 2025 10:57:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=r6CoL
	ViLHKGe0IDggsjEIlD6IPEn3lcE7yyHgxDEKX8=; b=aECYky05eIih8Jdd5Ksrm
	TU5iRpB/D6iL7LzsPOZmYnVq8lCks4zkKpHuMerUS/QC1GvVM2LSjLKzlbrx2DTV
	t5vrpRM/B2Slhs/c5kzAJex0PcRJ/3lwOJxE4LP5lnQf+pMTVyLJrEXc1pLNklCB
	kHNiQX5XT7V81av4jIO2TuGHvnvuB7y1QIpsFjgKxHbVek1CRxNsplIST22HrJ2+
	2BlWjzHEXcGbLPYeMgeW2HnlJwyT3MoyYDjqOAqbmdw/0bd1AO2eFEBGqnteKCcG
	U/JJLH5J6TItz9yifrriFRARMzRFKXCkIc04fVWWYdPEwryFyNf3wiMPDKvBD4T5
	Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 45ftbrsvu9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Mar 2025 10:57:39 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 52JEvcS3043960
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 19 Mar 2025 10:57:38 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Wed, 19 Mar
 2025 10:57:37 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 19 Mar 2025 10:57:37 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 52JEvPSC025123;
	Wed, 19 Mar 2025 10:57:27 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <corbet@lwn.net>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v2 2/5] iio: adc: ad4000: Add support for SPI offload
Date: Wed, 19 Mar 2025 11:57:23 -0300
Message-ID: <84843837a2acab58f8853152ecaa67c79b9a9666.1742394806.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1742394806.git.marcelo.schmitt@analog.com>
References: <cover.1742394806.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: xBcs5OmUQcp35MScDkqyBIt-kwKGbjr_
X-Proofpoint-GUID: xBcs5OmUQcp35MScDkqyBIt-kwKGbjr_
X-Authority-Analysis: v=2.4 cv=Qs5e3Uyd c=1 sm=1 tr=0 ts=67dadb63 cx=c_pps a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17 a=Vs1iUdzkB0EA:10 a=gAnH3GRIAAAA:8 a=a-wZI2P6Zr9K2gKbinIA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-19_05,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 priorityscore=1501 mlxlogscore=999 clxscore=1015 impostorscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 spamscore=0 mlxscore=0
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503190101

FPGA HDL projects can include a PWM generator in addition to SPI-Engine.
The PWM IP is used to trigger SPI-Engine offload modules that in turn set
SPI-Engine to execute transfers to poll data from the ADC. That allows data
to be read at the maximum sample rates. Also, it is possible to set a
specific sample rate by setting the proper PWM duty cycle and related state
parameters, thus allowing an adjustable ADC sample rate when a PWM (offload
trigger) is used in combination with SPI-Engine.

Add support for SPI offload.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
Instead of changing bits_per_word according to buffer endianness, I set
bits_per_word for other SPI transfers and updated IIO channels to always use CPU
endianness (the first patch in the series). With that, bits_per_word no longer
needs be updated according to buffer endianness or, in other words, buffer
endianness is no longer related to bits_per_word.

 drivers/iio/adc/Kconfig  |   7 +-
 drivers/iio/adc/ad4000.c | 491 ++++++++++++++++++++++++++++++++-------
 2 files changed, 419 insertions(+), 79 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index b7ae6e0ae0df..1cfa3a32f3a7 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -25,10 +25,15 @@ config AD4000
 	tristate "Analog Devices AD4000 ADC Driver"
 	depends on SPI
 	select IIO_BUFFER
+	select IIO_BUFFER_DMAENGINE
 	select IIO_TRIGGERED_BUFFER
+	select SPI_OFFLOAD
 	help
 	  Say yes here to build support for Analog Devices AD4000 high speed
-	  SPI analog to digital converters (ADC).
+	  SPI analog to digital converters (ADC). If intended to use with
+	  SPI offloading support, it is recommended to enable
+	  CONFIG_SPI_AXI_SPI_ENGINE, CONFIG_PWM_AXI_PWMGEN, and
+	  CONFIG_SPI_OFFLOAD_TRIGGER_PWM.
 
 	  To compile this driver as a module, choose M here: the module will be
 	  called ad4000.
diff --git a/drivers/iio/adc/ad4000.c b/drivers/iio/adc/ad4000.c
index 19bc021e1b5d..b3f4d215cad4 100644
--- a/drivers/iio/adc/ad4000.c
+++ b/drivers/iio/adc/ad4000.c
@@ -21,9 +21,12 @@
 #include <linux/iio/iio.h>
 
 #include <linux/iio/buffer.h>
+#include <linux/iio/buffer-dmaengine.h>
 #include <linux/iio/triggered_buffer.h>
 #include <linux/iio/trigger_consumer.h>
 
+#include <linux/spi/offload/consumer.h>
+
 #define AD4000_READ_COMMAND	0x54
 #define AD4000_WRITE_COMMAND	0x14
 
@@ -32,10 +35,15 @@
 /* AD4000 Configuration Register programmable bits */
 #define AD4000_CFG_SPAN_COMP		BIT(3) /* Input span compression  */
 #define AD4000_CFG_HIGHZ		BIT(2) /* High impedance mode  */
+#define AD4000_CFG_TURBO		BIT(1) /* Turbo mode */
 
 #define AD4000_SCALE_OPTIONS		2
 
-#define __AD4000_DIFF_CHANNEL(_sign, _real_bits, _storage_bits, _reg_access)	\
+#define AD4000_TQUIET1_NS		190
+#define AD4000_TQUIET2_NS		60
+#define AD4000_TCONV_NS			320
+
+#define __AD4000_DIFF_CHANNEL(_sign, _real_bits, _storage_bits, _reg_access, _offl)\
 {										\
 	.type = IIO_VOLTAGE,							\
 	.indexed = 1,								\
@@ -43,8 +51,9 @@
 	.channel = 0,								\
 	.channel2 = 1,								\
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |				\
-			      BIT(IIO_CHAN_INFO_SCALE),				\
-	.info_mask_separate_available = _reg_access ? BIT(IIO_CHAN_INFO_SCALE) : 0,\
+			      BIT(IIO_CHAN_INFO_SCALE) |			\
+			      (_offl ? BIT(IIO_CHAN_INFO_SAMP_FREQ) : 0),	\
+	.info_mask_separate_available = (_reg_access ? BIT(IIO_CHAN_INFO_SCALE) : 0),\
 	.scan_index = 0,							\
 	.scan_type = {								\
 		.sign = _sign,							\
@@ -54,25 +63,28 @@
 	},									\
 }
 
-#define AD4000_DIFF_CHANNEL(_sign, _real_bits, _reg_access)			\
+#define AD4000_DIFF_CHANNEL(_sign, _real_bits, _reg_access, _offl)		\
 	__AD4000_DIFF_CHANNEL((_sign), (_real_bits),				\
-				     ((_real_bits) > 16 ? 32 : 16), (_reg_access))
+			      (((_offl) || ((_real_bits) > 16)) ? 32 : 16),	\
+			      (_reg_access), (_offl))
 
-#define AD4000_DIFF_CHANNELS(_sign, _real_bits, _reg_access)			\
+#define AD4000_DIFF_CHANNELS(_sign, _real_bits, _reg_access, _offl)		\
 {										\
-	AD4000_DIFF_CHANNEL(_sign, _real_bits, _reg_access),			\
+	AD4000_DIFF_CHANNEL(_sign, _real_bits, _reg_access, _offl),		\
 	IIO_CHAN_SOFT_TIMESTAMP(1),						\
 }
 
-#define __AD4000_PSEUDO_DIFF_CHANNEL(_sign, _real_bits, _storage_bits, _reg_access)\
+#define __AD4000_PSEUDO_DIFF_CHANNEL(_sign, _real_bits, _storage_bits,		\
+				     _reg_access, _offl)			\
 {										\
 	.type = IIO_VOLTAGE,							\
 	.indexed = 1,								\
 	.channel = 0,								\
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |				\
 			      BIT(IIO_CHAN_INFO_SCALE) |			\
-			      BIT(IIO_CHAN_INFO_OFFSET),			\
-	.info_mask_separate_available = _reg_access ? BIT(IIO_CHAN_INFO_SCALE) : 0,\
+			      BIT(IIO_CHAN_INFO_OFFSET) |			\
+			      (_offl ? BIT(IIO_CHAN_INFO_SAMP_FREQ) : 0),	\
+	.info_mask_separate_available = (_reg_access ? BIT(IIO_CHAN_INFO_SCALE) : 0),\
 	.scan_index = 0,							\
 	.scan_type = {								\
 		.sign = _sign,							\
@@ -82,13 +94,14 @@
 	},									\
 }
 
-#define AD4000_PSEUDO_DIFF_CHANNEL(_sign, _real_bits, _reg_access)		\
+#define AD4000_PSEUDO_DIFF_CHANNEL(_sign, _real_bits, _reg_access, _offl)	\
 	__AD4000_PSEUDO_DIFF_CHANNEL((_sign), (_real_bits),			\
-				     ((_real_bits) > 16 ? 32 : 16), (_reg_access))
+				     (((_offl) || ((_real_bits) > 16)) ? 32 : 16),\
+				     (_reg_access), (_offl))
 
-#define AD4000_PSEUDO_DIFF_CHANNELS(_sign, _real_bits, _reg_access)		\
+#define AD4000_PSEUDO_DIFF_CHANNELS(_sign, _real_bits, _reg_access, _offl)	\
 {										\
-	AD4000_PSEUDO_DIFF_CHANNEL(_sign, _real_bits, _reg_access),		\
+	AD4000_PSEUDO_DIFF_CHANNEL(_sign, _real_bits, _reg_access, _offl),	\
 	IIO_CHAN_SOFT_TIMESTAMP(1),						\
 }
 
@@ -182,212 +195,298 @@ struct ad4000_chip_info {
 	const char *dev_name;
 	struct iio_chan_spec chan_spec[2];
 	struct iio_chan_spec reg_access_chan_spec[2];
+	struct iio_chan_spec offload_chan_spec;
+	struct iio_chan_spec reg_access_offload_chan_spec;
 	const struct ad4000_time_spec *time_spec;
 	bool has_hardware_gain;
+	int max_rate_hz;
 };
 
 static const struct ad4000_chip_info ad4000_chip_info = {
 	.dev_name = "ad4000",
-	.chan_spec = AD4000_PSEUDO_DIFF_CHANNELS('u', 16, 0),
-	.reg_access_chan_spec = AD4000_PSEUDO_DIFF_CHANNELS('u', 16, 1),
+	.chan_spec = AD4000_PSEUDO_DIFF_CHANNELS('u', 16, 0, 0),
+	.reg_access_chan_spec = AD4000_PSEUDO_DIFF_CHANNELS('u', 16, 1, 0),
+	.offload_chan_spec = AD4000_PSEUDO_DIFF_CHANNEL('u', 16, 0, 1),
+	.reg_access_offload_chan_spec = AD4000_PSEUDO_DIFF_CHANNEL('u', 16, 1, 1),
 	.time_spec = &ad4000_t_spec,
+	.max_rate_hz = 2 * MEGA,
 };
 
 static const struct ad4000_chip_info ad4001_chip_info = {
 	.dev_name = "ad4001",
-	.chan_spec = AD4000_DIFF_CHANNELS('s', 16, 0),
-	.reg_access_chan_spec = AD4000_DIFF_CHANNELS('s', 16, 1),
+	.chan_spec = AD4000_DIFF_CHANNELS('s', 16, 0, 0),
+	.reg_access_chan_spec = AD4000_DIFF_CHANNELS('s', 16, 1, 0),
+	.offload_chan_spec = AD4000_DIFF_CHANNEL('s', 16, 0, 1),
+	.reg_access_offload_chan_spec = AD4000_DIFF_CHANNEL('s', 16, 1, 1),
 	.time_spec = &ad4000_t_spec,
+	.max_rate_hz = 2 * MEGA,
 };
 
 static const struct ad4000_chip_info ad4002_chip_info = {
 	.dev_name = "ad4002",
-	.chan_spec = AD4000_PSEUDO_DIFF_CHANNELS('u', 18, 0),
-	.reg_access_chan_spec = AD4000_PSEUDO_DIFF_CHANNELS('u', 18, 1),
+	.chan_spec = AD4000_PSEUDO_DIFF_CHANNELS('u', 18, 0, 0),
+	.reg_access_chan_spec = AD4000_PSEUDO_DIFF_CHANNELS('u', 18, 1, 0),
+	.offload_chan_spec = AD4000_PSEUDO_DIFF_CHANNEL('u', 18, 0, 1),
+	.reg_access_offload_chan_spec = AD4000_PSEUDO_DIFF_CHANNEL('u', 18, 1, 1),
 	.time_spec = &ad4000_t_spec,
+	.max_rate_hz = 2 * MEGA,
 };
 
 static const struct ad4000_chip_info ad4003_chip_info = {
 	.dev_name = "ad4003",
-	.chan_spec = AD4000_DIFF_CHANNELS('s', 18, 0),
-	.reg_access_chan_spec = AD4000_DIFF_CHANNELS('s', 18, 1),
+	.chan_spec = AD4000_DIFF_CHANNELS('s', 18, 0, 0),
+	.reg_access_chan_spec = AD4000_DIFF_CHANNELS('s', 18, 1, 0),
+	.offload_chan_spec = AD4000_DIFF_CHANNEL('s', 18, 0, 1),
+	.reg_access_offload_chan_spec = AD4000_DIFF_CHANNEL('s', 18, 1, 1),
 	.time_spec = &ad4000_t_spec,
+	.max_rate_hz = 2 * MEGA,
 };
 
 static const struct ad4000_chip_info ad4004_chip_info = {
 	.dev_name = "ad4004",
-	.chan_spec = AD4000_PSEUDO_DIFF_CHANNELS('u', 16, 0),
-	.reg_access_chan_spec = AD4000_PSEUDO_DIFF_CHANNELS('u', 16, 1),
+	.chan_spec = AD4000_PSEUDO_DIFF_CHANNELS('u', 16, 0, 0),
+	.reg_access_chan_spec = AD4000_PSEUDO_DIFF_CHANNELS('u', 16, 1, 0),
+	.offload_chan_spec = AD4000_PSEUDO_DIFF_CHANNEL('u', 16, 0, 1),
+	.reg_access_offload_chan_spec = AD4000_PSEUDO_DIFF_CHANNEL('u', 16, 1, 1),
 	.time_spec = &ad4000_t_spec,
+	.max_rate_hz = 1 * MEGA,
 };
 
 static const struct ad4000_chip_info ad4005_chip_info = {
 	.dev_name = "ad4005",
-	.chan_spec = AD4000_DIFF_CHANNELS('s', 16, 0),
-	.reg_access_chan_spec = AD4000_DIFF_CHANNELS('s', 16, 1),
+	.chan_spec = AD4000_DIFF_CHANNELS('s', 16, 0, 0),
+	.reg_access_chan_spec = AD4000_DIFF_CHANNELS('s', 16, 1, 0),
+	.offload_chan_spec = AD4000_DIFF_CHANNEL('s', 16, 0, 1),
+	.reg_access_offload_chan_spec = AD4000_DIFF_CHANNEL('s', 16, 1, 1),
 	.time_spec = &ad4000_t_spec,
+	.max_rate_hz = 1 * MEGA,
 };
 
 static const struct ad4000_chip_info ad4006_chip_info = {
 	.dev_name = "ad4006",
-	.chan_spec = AD4000_PSEUDO_DIFF_CHANNELS('u', 18, 0),
-	.reg_access_chan_spec = AD4000_PSEUDO_DIFF_CHANNELS('u', 18, 1),
+	.chan_spec = AD4000_PSEUDO_DIFF_CHANNELS('u', 18, 0, 0),
+	.reg_access_chan_spec = AD4000_PSEUDO_DIFF_CHANNELS('u', 18, 1, 0),
+	.offload_chan_spec = AD4000_PSEUDO_DIFF_CHANNEL('u', 18, 0, 1),
+	.reg_access_offload_chan_spec = AD4000_PSEUDO_DIFF_CHANNEL('u', 18, 1, 1),
 	.time_spec = &ad4000_t_spec,
+	.max_rate_hz = 1 * MEGA,
 };
 
 static const struct ad4000_chip_info ad4007_chip_info = {
 	.dev_name = "ad4007",
-	.chan_spec = AD4000_DIFF_CHANNELS('s', 18, 0),
-	.reg_access_chan_spec = AD4000_DIFF_CHANNELS('s', 18, 1),
+	.chan_spec = AD4000_DIFF_CHANNELS('s', 18, 0, 0),
+	.reg_access_chan_spec = AD4000_DIFF_CHANNELS('s', 18, 1, 0),
+	.offload_chan_spec = AD4000_DIFF_CHANNEL('s', 18, 0, 1),
+	.reg_access_offload_chan_spec = AD4000_DIFF_CHANNEL('s', 18, 1, 1),
 	.time_spec = &ad4000_t_spec,
+	.max_rate_hz = 1 * MEGA,
 };
 
 static const struct ad4000_chip_info ad4008_chip_info = {
 	.dev_name = "ad4008",
-	.chan_spec = AD4000_PSEUDO_DIFF_CHANNELS('u', 16, 0),
-	.reg_access_chan_spec = AD4000_PSEUDO_DIFF_CHANNELS('u', 16, 1),
+	.chan_spec = AD4000_PSEUDO_DIFF_CHANNELS('u', 16, 0, 0),
+	.reg_access_chan_spec = AD4000_PSEUDO_DIFF_CHANNELS('u', 16, 1, 0),
+	.offload_chan_spec = AD4000_PSEUDO_DIFF_CHANNEL('u', 16, 0, 1),
+	.reg_access_offload_chan_spec = AD4000_PSEUDO_DIFF_CHANNEL('u', 16, 1, 1),
 	.time_spec = &ad4000_t_spec,
+	.max_rate_hz = 500 * KILO,
 };
 
 static const struct ad4000_chip_info ad4010_chip_info = {
 	.dev_name = "ad4010",
-	.chan_spec = AD4000_PSEUDO_DIFF_CHANNELS('u', 18, 0),
-	.reg_access_chan_spec = AD4000_PSEUDO_DIFF_CHANNELS('u', 18, 1),
+	.chan_spec = AD4000_PSEUDO_DIFF_CHANNELS('u', 18, 0, 0),
+	.reg_access_chan_spec = AD4000_PSEUDO_DIFF_CHANNELS('u', 18, 1, 0),
+	.offload_chan_spec = AD4000_PSEUDO_DIFF_CHANNEL('u', 18, 0, 1),
+	.reg_access_offload_chan_spec = AD4000_PSEUDO_DIFF_CHANNEL('u', 18, 1, 1),
 	.time_spec = &ad4000_t_spec,
+	.max_rate_hz = 500 * KILO,
 };
 
 static const struct ad4000_chip_info ad4011_chip_info = {
 	.dev_name = "ad4011",
-	.chan_spec = AD4000_DIFF_CHANNELS('s', 18, 0),
-	.reg_access_chan_spec = AD4000_DIFF_CHANNELS('s', 18, 1),
+	.chan_spec = AD4000_DIFF_CHANNELS('s', 18, 0, 0),
+	.reg_access_chan_spec = AD4000_DIFF_CHANNELS('s', 18, 1, 0),
+	.offload_chan_spec = AD4000_DIFF_CHANNEL('s', 18, 0, 1),
+	.reg_access_offload_chan_spec = AD4000_DIFF_CHANNEL('s', 18, 1, 1),
 	.time_spec = &ad4000_t_spec,
+	.max_rate_hz = 500 * KILO,
 };
 
 static const struct ad4000_chip_info ad4020_chip_info = {
 	.dev_name = "ad4020",
-	.chan_spec = AD4000_DIFF_CHANNELS('s', 20, 0),
-	.reg_access_chan_spec = AD4000_DIFF_CHANNELS('s', 20, 1),
+	.chan_spec = AD4000_DIFF_CHANNELS('s', 20, 0, 0),
+	.reg_access_chan_spec = AD4000_DIFF_CHANNELS('s', 20, 1, 0),
+	.offload_chan_spec = AD4000_DIFF_CHANNEL('s', 20, 0, 1),
+	.reg_access_offload_chan_spec = AD4000_DIFF_CHANNEL('s', 20, 1, 1),
 	.time_spec = &ad4020_t_spec,
+	.max_rate_hz = 1800 * KILO,
 };
 
 static const struct ad4000_chip_info ad4021_chip_info = {
 	.dev_name = "ad4021",
-	.chan_spec = AD4000_DIFF_CHANNELS('s', 20, 0),
-	.reg_access_chan_spec = AD4000_DIFF_CHANNELS('s', 20, 1),
+	.chan_spec = AD4000_DIFF_CHANNELS('s', 20, 0, 0),
+	.reg_access_chan_spec = AD4000_DIFF_CHANNELS('s', 20, 1, 0),
+	.offload_chan_spec = AD4000_DIFF_CHANNEL('s', 20, 0, 1),
+	.reg_access_offload_chan_spec = AD4000_DIFF_CHANNEL('s', 20, 1, 1),
 	.time_spec = &ad4020_t_spec,
+	.max_rate_hz = 1 * MEGA,
 };
 
 static const struct ad4000_chip_info ad4022_chip_info = {
 	.dev_name = "ad4022",
-	.chan_spec = AD4000_DIFF_CHANNELS('s', 20, 0),
-	.reg_access_chan_spec = AD4000_DIFF_CHANNELS('s', 20, 1),
+	.chan_spec = AD4000_DIFF_CHANNELS('s', 20, 0, 0),
+	.reg_access_chan_spec = AD4000_DIFF_CHANNELS('s', 20, 1, 0),
+	.offload_chan_spec = AD4000_DIFF_CHANNEL('s', 20, 0, 1),
+	.reg_access_offload_chan_spec = AD4000_DIFF_CHANNEL('s', 20, 1, 1),
 	.time_spec = &ad4020_t_spec,
+	.max_rate_hz = 500 * KILO,
 };
 
 static const struct ad4000_chip_info adaq4001_chip_info = {
 	.dev_name = "adaq4001",
-	.chan_spec = AD4000_DIFF_CHANNELS('s', 16, 0),
-	.reg_access_chan_spec = AD4000_DIFF_CHANNELS('s', 16, 1),
+	.chan_spec = AD4000_DIFF_CHANNELS('s', 16, 0, 0),
+	.reg_access_chan_spec = AD4000_DIFF_CHANNELS('s', 16, 1, 0),
+	.offload_chan_spec = AD4000_DIFF_CHANNEL('s', 16, 0, 1),
+	.reg_access_offload_chan_spec = AD4000_DIFF_CHANNEL('s', 16, 1, 1),
 	.time_spec = &ad4000_t_spec,
 	.has_hardware_gain = true,
+	.max_rate_hz = 2 * MEGA,
 };
 
 static const struct ad4000_chip_info adaq4003_chip_info = {
 	.dev_name = "adaq4003",
-	.chan_spec = AD4000_DIFF_CHANNELS('s', 18, 0),
-	.reg_access_chan_spec = AD4000_DIFF_CHANNELS('s', 18, 1),
+	.chan_spec = AD4000_DIFF_CHANNELS('s', 18, 0, 0),
+	.reg_access_chan_spec = AD4000_DIFF_CHANNELS('s', 18, 1, 0),
+	.offload_chan_spec = AD4000_DIFF_CHANNEL('s', 18, 0, 1),
+	.reg_access_offload_chan_spec = AD4000_DIFF_CHANNEL('s', 18, 1, 1),
 	.time_spec = &ad4000_t_spec,
 	.has_hardware_gain = true,
+	.max_rate_hz = 2 * MEGA,
 };
 
 static const struct ad4000_chip_info ad7685_chip_info = {
 	.dev_name = "ad7685",
-	.chan_spec = AD4000_PSEUDO_DIFF_CHANNELS('u', 16, 0),
+	.chan_spec = AD4000_PSEUDO_DIFF_CHANNELS('u', 16, 0, 0),
+	.offload_chan_spec = AD4000_PSEUDO_DIFF_CHANNEL('u', 16, 0, 1),
 	.time_spec = &ad7687_t_spec,
+	.max_rate_hz = 250 * KILO,
 };
 
 static const struct ad4000_chip_info ad7686_chip_info = {
 	.dev_name = "ad7686",
-	.chan_spec = AD4000_PSEUDO_DIFF_CHANNELS('u', 16, 0),
+	.chan_spec = AD4000_PSEUDO_DIFF_CHANNELS('u', 16, 0, 0),
+	.offload_chan_spec = AD4000_PSEUDO_DIFF_CHANNEL('u', 16, 0, 1),
 	.time_spec = &ad7686_t_spec,
+	.max_rate_hz = 500 * KILO,
 };
 
 static const struct ad4000_chip_info ad7687_chip_info = {
 	.dev_name = "ad7687",
-	.chan_spec = AD4000_DIFF_CHANNELS('s', 16, 0),
+	.chan_spec = AD4000_DIFF_CHANNELS('s', 16, 0, 0),
+	.offload_chan_spec = AD4000_DIFF_CHANNEL('s', 16, 0, 1),
 	.time_spec = &ad7687_t_spec,
+	.max_rate_hz = 250 * KILO,
 };
 
 static const struct ad4000_chip_info ad7688_chip_info = {
 	.dev_name = "ad7688",
-	.chan_spec = AD4000_DIFF_CHANNELS('s', 16, 0),
+	.chan_spec = AD4000_DIFF_CHANNELS('s', 16, 0, 0),
+	.offload_chan_spec = AD4000_DIFF_CHANNEL('s', 16, 0, 1),
 	.time_spec = &ad7686_t_spec,
+	.max_rate_hz = 500 * KILO,
 };
 
 static const struct ad4000_chip_info ad7690_chip_info = {
 	.dev_name = "ad7690",
-	.chan_spec = AD4000_DIFF_CHANNELS('s', 18, 0),
+	.chan_spec = AD4000_DIFF_CHANNELS('s', 18, 0, 0),
+	.offload_chan_spec = AD4000_DIFF_CHANNEL('s', 18, 0, 1),
 	.time_spec = &ad7690_t_spec,
+	.max_rate_hz = 400 * KILO,
 };
 
 static const struct ad4000_chip_info ad7691_chip_info = {
 	.dev_name = "ad7691",
-	.chan_spec = AD4000_DIFF_CHANNELS('s', 18, 0),
+	.chan_spec = AD4000_DIFF_CHANNELS('s', 18, 0, 0),
+	.offload_chan_spec = AD4000_DIFF_CHANNEL('s', 18, 0, 1),
 	.time_spec = &ad7691_t_spec,
+	.max_rate_hz = 250 * KILO,
 };
 
 static const struct ad4000_chip_info ad7693_chip_info = {
 	.dev_name = "ad7693",
-	.chan_spec = AD4000_DIFF_CHANNELS('s', 16, 0),
+	.chan_spec = AD4000_DIFF_CHANNELS('s', 16, 0, 0),
+	.offload_chan_spec = AD4000_DIFF_CHANNEL('s', 16, 0, 1),
 	.time_spec = &ad7686_t_spec,
+	.max_rate_hz = 500 * KILO,
 };
 
 static const struct ad4000_chip_info ad7942_chip_info = {
 	.dev_name = "ad7942",
-	.chan_spec = AD4000_PSEUDO_DIFF_CHANNELS('u', 14, 0),
+	.chan_spec = AD4000_PSEUDO_DIFF_CHANNELS('u', 14, 0, 0),
+	.offload_chan_spec = AD4000_PSEUDO_DIFF_CHANNEL('u', 14, 0, 1),
 	.time_spec = &ad7687_t_spec,
+	.max_rate_hz = 250 * KILO,
 };
 
 static const struct ad4000_chip_info ad7946_chip_info = {
 	.dev_name = "ad7946",
-	.chan_spec = AD4000_PSEUDO_DIFF_CHANNELS('u', 14, 0),
+	.chan_spec = AD4000_PSEUDO_DIFF_CHANNELS('u', 14, 0, 0),
+	.offload_chan_spec = AD4000_PSEUDO_DIFF_CHANNEL('u', 14, 0, 1),
 	.time_spec = &ad7686_t_spec,
+	.max_rate_hz = 500 * KILO,
 };
 
 static const struct ad4000_chip_info ad7980_chip_info = {
 	.dev_name = "ad7980",
-	.chan_spec = AD4000_PSEUDO_DIFF_CHANNELS('u', 16, 0),
+	.chan_spec = AD4000_PSEUDO_DIFF_CHANNELS('u', 16, 0, 0),
+	.offload_chan_spec = AD4000_PSEUDO_DIFF_CHANNEL('u', 16, 0, 1),
 	.time_spec = &ad7980_t_spec,
+	.max_rate_hz = 1 * MEGA,
 };
 
 static const struct ad4000_chip_info ad7982_chip_info = {
 	.dev_name = "ad7982",
-	.chan_spec = AD4000_DIFF_CHANNELS('s', 18, 0),
+	.chan_spec = AD4000_DIFF_CHANNELS('s', 18, 0, 0),
+	.offload_chan_spec = AD4000_DIFF_CHANNEL('s', 18, 0, 1),
 	.time_spec = &ad7980_t_spec,
+	.max_rate_hz = 1 * MEGA,
 };
 
 static const struct ad4000_chip_info ad7983_chip_info = {
 	.dev_name = "ad7983",
-	.chan_spec = AD4000_PSEUDO_DIFF_CHANNELS('u', 16, 0),
+	.chan_spec = AD4000_PSEUDO_DIFF_CHANNELS('u', 16, 0, 0),
+	.offload_chan_spec = AD4000_PSEUDO_DIFF_CHANNEL('u', 16, 0, 1),
 	.time_spec = &ad7983_t_spec,
+	.max_rate_hz = 1330 * KILO,
 };
 
 static const struct ad4000_chip_info ad7984_chip_info = {
 	.dev_name = "ad7984",
-	.chan_spec = AD4000_DIFF_CHANNELS('s', 18, 0),
+	.chan_spec = AD4000_DIFF_CHANNELS('s', 18, 0, 0),
+	.offload_chan_spec = AD4000_DIFF_CHANNEL('s', 18, 0, 1),
 	.time_spec = &ad7983_t_spec,
+	.max_rate_hz = 1330 * KILO,
 };
 
 static const struct ad4000_chip_info ad7988_1_chip_info = {
 	.dev_name = "ad7988-1",
-	.chan_spec = AD4000_PSEUDO_DIFF_CHANNELS('u', 16, 0),
+	.chan_spec = AD4000_PSEUDO_DIFF_CHANNELS('u', 16, 0, 0),
+	.offload_chan_spec = AD4000_PSEUDO_DIFF_CHANNEL('u', 16, 0, 1),
 	.time_spec = &ad7988_1_t_spec,
+	.max_rate_hz = 100 * KILO,
 };
 
 static const struct ad4000_chip_info ad7988_5_chip_info = {
 	.dev_name = "ad7988-5",
-	.chan_spec = AD4000_PSEUDO_DIFF_CHANNELS('u', 16, 0),
+	.chan_spec = AD4000_PSEUDO_DIFF_CHANNELS('u', 16, 0, 0),
+	.offload_chan_spec = AD4000_PSEUDO_DIFF_CHANNEL('u', 16, 0, 1),
 	.time_spec = &ad7686_t_spec,
+	.max_rate_hz = 500 * KILO,
+};
+
+static const struct spi_offload_config ad4000_offload_config = {
+	.capability_flags = SPI_OFFLOAD_CAP_TRIGGER |
+			    SPI_OFFLOAD_CAP_RX_STREAM_DMA,
 };
 
 struct ad4000_state {
@@ -395,6 +494,13 @@ struct ad4000_state {
 	struct gpio_desc *cnv_gpio;
 	struct spi_transfer xfers[2];
 	struct spi_message msg;
+	struct spi_transfer offload_xfers[2];
+	struct spi_message offload_msg;
+	struct spi_offload *offload;
+	struct spi_offload_trigger *offload_trigger;
+	bool using_offload;
+	unsigned long offload_trigger_hz;
+	int max_rate_hz;
 	struct mutex lock; /* Protect read modify write cycle */
 	int vref_mv;
 	enum ad4000_sdi sdi_pin;
@@ -485,6 +591,25 @@ static int ad4000_read_reg(struct ad4000_state *st, unsigned int *val)
 	return ret;
 }
 
+static int ad4000_set_sampling_freq(struct ad4000_state *st, int freq)
+{
+	struct spi_offload_trigger_config config = {
+		.type = SPI_OFFLOAD_TRIGGER_PERIODIC,
+		.periodic = {
+			.frequency_hz = freq,
+		},
+	};
+	int ret;
+
+	ret = spi_offload_trigger_validate(st->offload_trigger, &config);
+	if (ret)
+		return ret;
+
+	st->offload_trigger_hz = config.periodic.frequency_hz;
+
+	return 0;
+}
+
 static int ad4000_convert_and_acquire(struct ad4000_state *st)
 {
 	int ret;
@@ -550,6 +675,9 @@ static int ad4000_read_raw(struct iio_dev *indio_dev,
 		if (st->span_comp)
 			*val = mult_frac(st->vref_mv, 1, 10);
 
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*val = st->offload_trigger_hz;
 		return IIO_VAL_INT;
 	default:
 		return -EINVAL;
@@ -616,6 +744,7 @@ static int ad4000_write_raw(struct iio_dev *indio_dev,
 			    struct iio_chan_spec const *chan,
 			    int val, int val2, long mask)
 {
+	struct ad4000_state *st = iio_priv(indio_dev);
 	int ret;
 
 	switch (mask) {
@@ -625,6 +754,15 @@ static int ad4000_write_raw(struct iio_dev *indio_dev,
 		ret = __ad4000_write_raw(indio_dev, chan, val2);
 		iio_device_release_direct(indio_dev);
 		return ret;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		if (val < 1 || val > st->max_rate_hz)
+			return -EINVAL;
+
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
+		ret = ad4000_set_sampling_freq(st, val);
+		iio_device_release_direct(indio_dev);
+		return ret;
 	default:
 		return -EINVAL;
 	}
@@ -655,10 +793,153 @@ static const struct iio_info ad4000_reg_access_info = {
 	.write_raw_get_fmt = &ad4000_write_raw_get_fmt,
 };
 
+static const struct iio_info ad4000_offload_info = {
+	.read_raw = &ad4000_read_raw,
+	.write_raw = &ad4000_write_raw,
+	.write_raw_get_fmt = &ad4000_write_raw_get_fmt,
+};
+
 static const struct iio_info ad4000_info = {
 	.read_raw = &ad4000_read_raw,
 };
 
+static int ad4000_offload_buffer_postenable(struct iio_dev *indio_dev)
+{
+	struct ad4000_state *st = iio_priv(indio_dev);
+	struct spi_offload_trigger_config config = {
+		.type = SPI_OFFLOAD_TRIGGER_PERIODIC,
+		.periodic = {
+			.frequency_hz = st->offload_trigger_hz,
+		},
+	};
+
+	return spi_offload_trigger_enable(st->offload, st->offload_trigger,
+					  &config);
+}
+
+static int ad4000_offload_buffer_postdisable(struct iio_dev *indio_dev)
+{
+	struct ad4000_state *st = iio_priv(indio_dev);
+
+	spi_offload_trigger_disable(st->offload, st->offload_trigger);
+
+	return 0;
+}
+
+static const struct iio_buffer_setup_ops ad4000_offload_buffer_setup_ops = {
+	.postenable = &ad4000_offload_buffer_postenable,
+	.postdisable = &ad4000_offload_buffer_postdisable,
+};
+
+static int ad4000_spi_offload_setup(struct iio_dev *indio_dev,
+				    struct ad4000_state *st)
+{
+	struct spi_device *spi = st->spi;
+	struct device *dev = &spi->dev;
+	struct dma_chan *rx_dma;
+	int ret;
+
+	st->offload_trigger = devm_spi_offload_trigger_get(dev, st->offload,
+							   SPI_OFFLOAD_TRIGGER_PERIODIC);
+	if (IS_ERR(st->offload_trigger))
+		return dev_err_probe(dev, PTR_ERR(st->offload_trigger),
+				     "Failed to get offload trigger\n");
+
+	ret = ad4000_set_sampling_freq(st, st->max_rate_hz);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to set sampling frequency\n");
+
+	rx_dma = devm_spi_offload_rx_stream_request_dma_chan(dev, st->offload);
+	if (IS_ERR(rx_dma))
+		return dev_err_probe(dev, PTR_ERR(rx_dma),
+				     "Failed to get offload RX DMA\n");
+
+	ret = devm_iio_dmaengine_buffer_setup_with_handle(dev, indio_dev, rx_dma,
+							  IIO_BUFFER_DIRECTION_IN);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to setup DMA buffer\n");
+
+	return 0;
+}
+
+/*
+ * This executes a data sample transfer when using SPI offloading for when the
+ * device connections are in "3-wire" mode, selected when the adi,sdi-pin device
+ * tree property is absent. In this connection mode, the ADC SDI pin is
+ * connected to MOSI or to VIO and ADC CNV pin is connected to a SPI controller
+ * CS (it can't be connected to a GPIO).
+ *
+ * In order to achieve the maximum sample rate, we only do one transfer per
+ * SPI offload trigger. Because the ADC output has a one sample latency (delay)
+ * when the device is wired in "3-wire" mode and only one transfer per sample is
+ * being made in turbo mode, the first data sample is not valid because it
+ * contains the output of an earlier conversion result. We also set transfer
+ * `bits_per_word` to achieve higher throughput by using the minimum number of
+ * SCLK cycles. Also, a delay is added to make sure we meet the minimum quiet
+ * time before releasing the CS line. Plus the CS change delay is set to ensure
+ * that we meet the minimum quiet time before asserting CS again.
+ *
+ * This timing is only valid if turbo mode is enabled (reading during conversion).
+ */
+static int ad4000_prepare_offload_turbo_message(struct ad4000_state *st,
+						const struct iio_chan_spec *chan)
+{
+	struct spi_transfer *xfers = st->offload_xfers;
+
+	/* Have to do a short CS toggle to trigger conversion. */
+	xfers[0].cs_change = 1;
+	xfers[0].cs_change_delay.value = AD4000_TQUIET1_NS;
+	xfers[0].cs_change_delay.unit = SPI_DELAY_UNIT_NSECS;
+	xfers[0].offload_flags = SPI_OFFLOAD_XFER_RX_STREAM;
+
+	xfers[1].offload_flags = SPI_OFFLOAD_XFER_RX_STREAM;
+	xfers[1].bits_per_word = chan->scan_type.realbits;
+	xfers[1].len = chan->scan_type.realbits > 16 ? 4 : 2;
+	xfers[1].delay.value = AD4000_TQUIET2_NS;
+	xfers[1].delay.unit = SPI_DELAY_UNIT_NSECS;
+
+	spi_message_init_with_transfers(&st->offload_msg, xfers, 2);
+	st->offload_msg.offload = st->offload;
+
+	return devm_spi_optimize_message(&st->spi->dev, st->spi, &st->offload_msg);
+}
+
+/*
+ * This executes a data sample transfer when using SPI offloading for when the
+ * device connections are in "3-wire" mode, selected when the adi,sdi-pin device
+ * tree property is set to "high". In this connection mode, the ADC SDI pin is
+ * connected to VIO and ADC CNV pin is connected to a SPI controller CS (it
+ * can't be connected to a GPIO).
+ *
+ * In order to achieve the maximum sample rate, we only do one transfer per
+ * SPI offload trigger. Because the ADC output has a one sample latency (delay)
+ * when the device is wired in "3-wire" mode and only one transfer per sample is
+ * being made in turbo mode, the first data sample is not valid because it
+ * contains the output of an earlier conversion result. We also set transfer
+ * `bits_per_word` to achieve higher throughput by using the minimum number of
+ * SCLK cycles. Also, a delay is added to make sure we meet the minimum quiet
+ * time before releasing the CS line.
+ *
+ * This timing is only valid if turbo mode is disabled (reading during acquisition).
+ */
+static int ad4000_prepare_offload_message(struct ad4000_state *st,
+					  const struct iio_chan_spec *chan)
+{
+	struct spi_transfer *xfers = st->offload_xfers;
+
+	xfers[0].bits_per_word = chan->scan_type.realbits;
+	xfers[0].len = chan->scan_type.realbits > 16 ? 4 : 2;
+	xfers[0].delay.value = AD4000_TQUIET2_NS;
+	xfers[0].delay.unit = SPI_DELAY_UNIT_NSECS;
+	xfers[0].offload_flags = SPI_OFFLOAD_XFER_RX_STREAM;
+
+	spi_message_init_with_transfers(&st->offload_msg, xfers, 1);
+	st->offload_msg.offload = st->offload;
+
+	return devm_spi_optimize_message(&st->spi->dev, st->spi, &st->offload_msg);
+}
+
 /*
  * This executes a data sample transfer for when the device connections are
  * in "3-wire" mode, selected when the adi,sdi-pin device tree property is
@@ -686,7 +967,7 @@ static int ad4000_prepare_3wire_mode_message(struct ad4000_state *st,
 
 	xfers[1].rx_buf = &st->scan.data;
 	xfers[1].bits_per_word = chan->scan_type.realbits;
-	xfers[1].len = BITS_TO_BYTES(chan->scan_type.storagebits);
+	xfers[1].len = chan->scan_type.realbits > 16 ? 4 : 2;
 	xfers[1].delay.value = st->time_spec->t_quiet2_ns;
 	xfers[1].delay.unit = SPI_DELAY_UNIT_NSECS;
 
@@ -717,7 +998,7 @@ static int ad4000_prepare_4wire_mode_message(struct ad4000_state *st,
 
 	xfers[1].rx_buf = &st->scan.data;
 	xfers[1].bits_per_word = chan->scan_type.realbits;
-	xfers[1].len = BITS_TO_BYTES(chan->scan_type.storagebits);
+	xfers[1].len = chan->scan_type.realbits > 16 ? 4 : 2;
 
 	spi_message_init_with_transfers(&st->msg, st->xfers, 2);
 
@@ -731,6 +1012,9 @@ static int ad4000_config(struct ad4000_state *st)
 	if (device_property_present(&st->spi->dev, "adi,high-z-input"))
 		reg_val |= FIELD_PREP(AD4000_CFG_HIGHZ, 1);
 
+	if (st->using_offload)
+		reg_val |= FIELD_PREP(AD4000_CFG_TURBO, 1);
+
 	return ad4000_write_reg(st, reg_val);
 }
 
@@ -753,6 +1037,7 @@ static int ad4000_probe(struct spi_device *spi)
 	st = iio_priv(indio_dev);
 	st->spi = spi;
 	st->time_spec = chip->time_spec;
+	st->max_rate_hz = chip->max_rate_hz;
 
 	ret = devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(ad4000_power_supplies),
 					     ad4000_power_supplies);
@@ -770,6 +1055,26 @@ static int ad4000_probe(struct spi_device *spi)
 		return dev_err_probe(dev, PTR_ERR(st->cnv_gpio),
 				     "Failed to get CNV GPIO");
 
+	st->offload = devm_spi_offload_get(dev, spi, &ad4000_offload_config);
+	ret = PTR_ERR_OR_ZERO(st->offload);
+	if (ret && ret != -ENODEV)
+		return dev_err_probe(dev, ret, "Failed to get offload\n");
+
+	st->using_offload = !IS_ERR(st->offload);
+	if (st->using_offload) {
+		indio_dev->setup_ops = &ad4000_offload_buffer_setup_ops;
+		ret = ad4000_spi_offload_setup(indio_dev, st);
+		if (ret)
+			return ret;
+	} else {
+		ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
+						      &iio_pollfunc_store_time,
+						      &ad4000_trigger_handler,
+						      NULL);
+		if (ret)
+			return ret;
+	}
+
 	ret = device_property_match_property_string(dev, "adi,sdi-pin",
 						    ad4000_sdi_pin,
 						    ARRAY_SIZE(ad4000_sdi_pin));
@@ -781,9 +1086,6 @@ static int ad4000_probe(struct spi_device *spi)
 	st->sdi_pin = ret == -EINVAL ? AD4000_SDI_MOSI : ret;
 	switch (st->sdi_pin) {
 	case AD4000_SDI_MOSI:
-		indio_dev->info = &ad4000_reg_access_info;
-		indio_dev->channels = chip->reg_access_chan_spec;
-
 		/*
 		 * In "3-wire mode", the ADC SDI line must be kept high when
 		 * data is not being clocked out of the controller.
@@ -794,9 +1096,28 @@ static int ad4000_probe(struct spi_device *spi)
 		if (ret < 0)
 			return ret;
 
+		indio_dev->info = &ad4000_reg_access_info;
+
+		if (st->using_offload) {
+			indio_dev->channels = &chip->reg_access_offload_chan_spec;
+			indio_dev->num_channels = 1;
+			ret = ad4000_prepare_offload_turbo_message(st, indio_dev->channels);
+			if (ret)
+				return dev_err_probe(dev, ret,
+						     "Failed to optimize SPI msg\n");
+		} else {
+			indio_dev->channels = chip->reg_access_chan_spec;
+			indio_dev->num_channels = ARRAY_SIZE(chip->reg_access_chan_spec);
+		}
+
+		/*
+		 * Call ad4000_prepare_3wire_mode_message() so single-shot read
+		 * SPI messages are always initialized.
+		 */
 		ret = ad4000_prepare_3wire_mode_message(st, &indio_dev->channels[0]);
 		if (ret)
-			return ret;
+			return dev_err_probe(dev, ret,
+					     "Failed to optimize SPI msg\n");
 
 		ret = ad4000_config(st);
 		if (ret < 0)
@@ -804,19 +1125,39 @@ static int ad4000_probe(struct spi_device *spi)
 
 		break;
 	case AD4000_SDI_VIO:
-		indio_dev->info = &ad4000_info;
-		indio_dev->channels = chip->chan_spec;
+		if (st->using_offload) {
+			indio_dev->info = &ad4000_offload_info;
+			indio_dev->channels = &chip->offload_chan_spec;
+			indio_dev->num_channels = 1;
+
+			spi->cs_hold.value = AD4000_TCONV_NS;
+			spi->cs_hold.unit = SPI_DELAY_UNIT_NSECS;
+			ret = ad4000_prepare_offload_message(st, indio_dev->channels);
+			if (ret)
+				return dev_err_probe(dev, ret,
+						     "Failed to optimize SPI msg\n");
+		} else {
+			indio_dev->info = &ad4000_info;
+			indio_dev->channels = chip->chan_spec;
+			indio_dev->num_channels = ARRAY_SIZE(chip->chan_spec);
+		}
 		ret = ad4000_prepare_3wire_mode_message(st, &indio_dev->channels[0]);
 		if (ret)
-			return ret;
+			return dev_err_probe(dev, ret,
+					     "Failed to optimize SPI msg\n");
 
 		break;
 	case AD4000_SDI_CS:
+		if (st->using_offload)
+			return dev_err_probe(dev, -EPROTONOSUPPORT,
+					     "Unsupported sdi-pin + offload config\n");
 		indio_dev->info = &ad4000_info;
 		indio_dev->channels = chip->chan_spec;
+		indio_dev->num_channels = ARRAY_SIZE(chip->chan_spec);
 		ret = ad4000_prepare_4wire_mode_message(st, &indio_dev->channels[0]);
 		if (ret)
-			return ret;
+			return dev_err_probe(dev, ret,
+					     "Failed to optimize SPI msg\n");
 
 		break;
 	case AD4000_SDI_GND:
@@ -828,7 +1169,6 @@ static int ad4000_probe(struct spi_device *spi)
 	}
 
 	indio_dev->name = chip->dev_name;
-	indio_dev->num_channels = 2;
 
 	ret = devm_mutex_init(dev, &st->lock);
 	if (ret)
@@ -851,12 +1191,6 @@ static int ad4000_probe(struct spi_device *spi)
 
 	ad4000_fill_scale_tbl(st, &indio_dev->channels[0]);
 
-	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
-					      &iio_pollfunc_store_time,
-					      &ad4000_trigger_handler, NULL);
-	if (ret)
-		return ret;
-
 	return devm_iio_device_register(dev, indio_dev);
 }
 
@@ -945,3 +1279,4 @@ module_spi_driver(ad4000_driver);
 MODULE_AUTHOR("Marcelo Schmitt <marcelo.schmitt@analog.com>");
 MODULE_DESCRIPTION("Analog Devices AD4000 ADC driver");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("IIO_DMAENGINE_BUFFER");
-- 
2.47.2


