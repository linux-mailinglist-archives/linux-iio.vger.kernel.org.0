Return-Path: <linux-iio+bounces-17298-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5858DA74043
	for <lists+linux-iio@lfdr.de>; Thu, 27 Mar 2025 22:26:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 125F31891CBF
	for <lists+linux-iio@lfdr.de>; Thu, 27 Mar 2025 21:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE8F1A8418;
	Thu, 27 Mar 2025 21:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="ckVwvnXG"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52891DC99E;
	Thu, 27 Mar 2025 21:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743110711; cv=none; b=pDJk2FgnOuzbHV8j80A480SJHL5IzhnPyYwomc67E8W/H6cgNYzl2tvelfAUa7OxkZ9rRR4finu8aJbg90c3pMiEBT9V8Uxb6SZnYeks+0uBh0wXwPYVP3/z03lhIi03ryYNYTBpD/90JUyjxOQpCEAB4C2SVRfRpYBOul5RHm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743110711; c=relaxed/simple;
	bh=jS0lrO/gse8H6c/XnJ92d7hcYuKZhl+tlgPZ2DvBpuA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SlXhdP45Xo8Wx9YLQbaxhv2NtKhSMw9vf/0y+n8ZkBymLcPTr/WQWI/rLnUJmklJ8au8gTUQg35cKqWLCJxQprptwKmppPZS2/nN2DRHGVMZVOsUCmwqMWmWvilhXtTciT3ze+w2Ig+sXAtZGRR3RFhIi0GilGJ63Ros7fyudG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=ckVwvnXG; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52RKY32j010426;
	Thu, 27 Mar 2025 17:24:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=XbPDj
	zPNSDq64LhsXrASAX3D7RCknGRociL114UDN1s=; b=ckVwvnXGhaoFSpCEt3Rhc
	+tikja0Ks79oUiNuHOwHR3A+Y69DZ5avbvtqls8oyninl2FjfxgaZ7xZ0h+2vG9j
	TbTvsafTBO3wjo0hWUq1W2CtMGN9XyRO1MXBpa26msXL6bIQYzEibrwfzYCPnUp2
	gSdHU74wOvU3x0MSRqZDQebEe/xG2coNZbKEFt1IyoIYbnGUBE0JfEh5xhg9URxx
	L5d/GpIBvwLHv1crWbYCCY7obIV8n1N04EGKTNc8XqtJomkKWFstaweEtzRNLECV
	5qzBq00CSQC85x/yulTRIKVdlpOw0aqOuuQkDXbVlSsUZkB9hHAdCEwaltnvBHG5
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 45mwxcdkkj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Mar 2025 17:24:52 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 52RLOpt2047372
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 27 Mar 2025 17:24:51 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Thu, 27 Mar
 2025 17:24:51 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 27 Mar 2025 17:24:50 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 52RLObqO022515;
	Thu, 27 Mar 2025 17:24:40 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <corbet@lwn.net>, <dlechner@baylibre.com>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v4 1/4] iio: adc: ad4000: Add support for SPI offload
Date: Thu, 27 Mar 2025 18:24:35 -0300
Message-ID: <386ce043a0e3fc9e8ff71f17aef8de128ce5869e.1743110188.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1743110188.git.marcelo.schmitt@analog.com>
References: <cover.1743110188.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=AdmxH2XG c=1 sm=1 tr=0 ts=67e5c224 cx=c_pps a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17 a=Vs1iUdzkB0EA:10 a=gAnH3GRIAAAA:8 a=RL0VqAb_ZIiKdKy-vr0A:9
X-Proofpoint-GUID: lxMJZKbjslJf9sGultxfLhHxcenVzamV
X-Proofpoint-ORIG-GUID: lxMJZKbjslJf9sGultxfLhHxcenVzamV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-27_04,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 mlxlogscore=999 impostorscore=0 clxscore=1015 spamscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503270144

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
 drivers/iio/adc/Kconfig  |   7 +-
 drivers/iio/adc/ad4000.c | 382 +++++++++++++++++++++++++++++++++++----
 2 files changed, 354 insertions(+), 35 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 75ed633a3c43..eb0ba7457084 100644
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
index 4fe8dee48da9..e69a9d2a3e8c 100644
--- a/drivers/iio/adc/ad4000.c
+++ b/drivers/iio/adc/ad4000.c
@@ -15,12 +15,14 @@
 #include <linux/mod_devicetable.h>
 #include <linux/gpio/consumer.h>
 #include <linux/regulator/consumer.h>
+#include <linux/spi/offload/consumer.h>
 #include <linux/spi/spi.h>
 #include <linux/units.h>
 #include <linux/util_macros.h>
-#include <linux/iio/iio.h>
 
+#include <linux/iio/iio.h>
 #include <linux/iio/buffer.h>
+#include <linux/iio/buffer-dmaengine.h>
 #include <linux/iio/triggered_buffer.h>
 #include <linux/iio/trigger_consumer.h>
 
@@ -32,10 +34,11 @@
 /* AD4000 Configuration Register programmable bits */
 #define AD4000_CFG_SPAN_COMP		BIT(3) /* Input span compression  */
 #define AD4000_CFG_HIGHZ		BIT(2) /* High impedance mode  */
+#define AD4000_CFG_TURBO		BIT(1) /* Turbo mode */
 
 #define AD4000_SCALE_OPTIONS		2
 
-#define __AD4000_DIFF_CHANNEL(_sign, _real_bits, _storage_bits, _reg_access)	\
+#define __AD4000_DIFF_CHANNEL(_sign, _real_bits, _storage_bits, _reg_access, _offl)\
 {										\
 	.type = IIO_VOLTAGE,							\
 	.indexed = 1,								\
@@ -43,54 +46,65 @@
 	.channel = 0,								\
 	.channel2 = 1,								\
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |				\
-			      BIT(IIO_CHAN_INFO_SCALE),				\
+			      BIT(IIO_CHAN_INFO_SCALE) |			\
+			      (_offl ? BIT(IIO_CHAN_INFO_SAMP_FREQ) : 0),	\
 	.info_mask_separate_available = _reg_access ? BIT(IIO_CHAN_INFO_SCALE) : 0,\
 	.scan_index = 0,							\
 	.scan_type = {								\
 		.sign = _sign,							\
 		.realbits = _real_bits,						\
 		.storagebits = _storage_bits,					\
-		.shift = _storage_bits - _real_bits,				\
-		.endianness = IIO_BE,						\
+		.shift = (_offl ? 0 : _storage_bits - _real_bits),		\
+		.endianness = _offl ? IIO_CPU : IIO_BE				\
 	},									\
 }
 
-#define AD4000_DIFF_CHANNEL(_sign, _real_bits, _reg_access)			\
+#define AD4000_DIFF_CHANNEL(_sign, _real_bits, _reg_access, _offl)		\
 	__AD4000_DIFF_CHANNEL((_sign), (_real_bits),				\
-				     ((_real_bits) > 16 ? 32 : 16), (_reg_access))
+			      (((_offl) || ((_real_bits) > 16)) ? 32 : 16),	\
+			      (_reg_access), (_offl))
 
+/*
+ * When SPI offload is configured, transfers are executed without CPU
+ * intervention so no soft timestamp can be recorded when transfers run.
+ * Because of that, the macros that set timestamp channel are only used when
+ * transfers are not offloaded.
+ */
 #define AD4000_DIFF_CHANNELS(_sign, _real_bits, _reg_access)			\
 {										\
-	AD4000_DIFF_CHANNEL(_sign, _real_bits, _reg_access),			\
+	AD4000_DIFF_CHANNEL(_sign, _real_bits, _reg_access, 0),			\
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
+			      BIT(IIO_CHAN_INFO_OFFSET) |			\
+			      (_offl ? BIT(IIO_CHAN_INFO_SAMP_FREQ) : 0),	\
 	.info_mask_separate_available = _reg_access ? BIT(IIO_CHAN_INFO_SCALE) : 0,\
 	.scan_index = 0,							\
 	.scan_type = {								\
 		.sign = _sign,							\
 		.realbits = _real_bits,						\
 		.storagebits = _storage_bits,					\
-		.shift = _storage_bits - _real_bits,				\
-		.endianness = IIO_BE,						\
+		.shift = (_offl ? 0 : _storage_bits - _real_bits),		\
+		.endianness = _offl ? IIO_CPU : IIO_BE				\
 	},									\
 }
 
-#define AD4000_PSEUDO_DIFF_CHANNEL(_sign, _real_bits, _reg_access)		\
+#define AD4000_PSEUDO_DIFF_CHANNEL(_sign, _real_bits, _reg_access, _offl)	\
 	__AD4000_PSEUDO_DIFF_CHANNEL((_sign), (_real_bits),			\
-				     ((_real_bits) > 16 ? 32 : 16), (_reg_access))
+				     (((_offl) || ((_real_bits) > 16)) ? 32 : 16),\
+				     (_reg_access), (_offl))
 
 #define AD4000_PSEUDO_DIFF_CHANNELS(_sign, _real_bits, _reg_access)		\
 {										\
-	AD4000_PSEUDO_DIFF_CHANNEL(_sign, _real_bits, _reg_access),		\
+	AD4000_PSEUDO_DIFF_CHANNEL(_sign, _real_bits, _reg_access, 0),		\
 	IIO_CHAN_SOFT_TIMESTAMP(1),						\
 }
 
@@ -184,212 +198,298 @@ struct ad4000_chip_info {
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
 	.chan_spec = AD4000_PSEUDO_DIFF_CHANNELS('u', 16, 0),
 	.reg_access_chan_spec = AD4000_PSEUDO_DIFF_CHANNELS('u', 16, 1),
+	.offload_chan_spec = AD4000_PSEUDO_DIFF_CHANNEL('u', 16, 0, 1),
+	.reg_access_offload_chan_spec = AD4000_PSEUDO_DIFF_CHANNEL('u', 16, 1, 1),
 	.time_spec = &ad4000_t_spec,
+	.max_rate_hz = 2 * MEGA,
 };
 
 static const struct ad4000_chip_info ad4001_chip_info = {
 	.dev_name = "ad4001",
 	.chan_spec = AD4000_DIFF_CHANNELS('s', 16, 0),
 	.reg_access_chan_spec = AD4000_DIFF_CHANNELS('s', 16, 1),
+	.offload_chan_spec = AD4000_DIFF_CHANNEL('s', 16, 0, 1),
+	.reg_access_offload_chan_spec = AD4000_DIFF_CHANNEL('s', 16, 1, 1),
 	.time_spec = &ad4000_t_spec,
+	.max_rate_hz = 2 * MEGA,
 };
 
 static const struct ad4000_chip_info ad4002_chip_info = {
 	.dev_name = "ad4002",
 	.chan_spec = AD4000_PSEUDO_DIFF_CHANNELS('u', 18, 0),
 	.reg_access_chan_spec = AD4000_PSEUDO_DIFF_CHANNELS('u', 18, 1),
+	.offload_chan_spec = AD4000_PSEUDO_DIFF_CHANNEL('u', 18, 0, 1),
+	.reg_access_offload_chan_spec = AD4000_PSEUDO_DIFF_CHANNEL('u', 18, 1, 1),
 	.time_spec = &ad4000_t_spec,
+	.max_rate_hz = 2 * MEGA,
 };
 
 static const struct ad4000_chip_info ad4003_chip_info = {
 	.dev_name = "ad4003",
 	.chan_spec = AD4000_DIFF_CHANNELS('s', 18, 0),
 	.reg_access_chan_spec = AD4000_DIFF_CHANNELS('s', 18, 1),
+	.offload_chan_spec = AD4000_DIFF_CHANNEL('s', 18, 0, 1),
+	.reg_access_offload_chan_spec = AD4000_DIFF_CHANNEL('s', 18, 1, 1),
 	.time_spec = &ad4000_t_spec,
+	.max_rate_hz = 2 * MEGA,
 };
 
 static const struct ad4000_chip_info ad4004_chip_info = {
 	.dev_name = "ad4004",
 	.chan_spec = AD4000_PSEUDO_DIFF_CHANNELS('u', 16, 0),
 	.reg_access_chan_spec = AD4000_PSEUDO_DIFF_CHANNELS('u', 16, 1),
+	.offload_chan_spec = AD4000_PSEUDO_DIFF_CHANNEL('u', 16, 0, 1),
+	.reg_access_offload_chan_spec = AD4000_PSEUDO_DIFF_CHANNEL('u', 16, 1, 1),
 	.time_spec = &ad4000_t_spec,
+	.max_rate_hz = 1 * MEGA,
 };
 
 static const struct ad4000_chip_info ad4005_chip_info = {
 	.dev_name = "ad4005",
 	.chan_spec = AD4000_DIFF_CHANNELS('s', 16, 0),
 	.reg_access_chan_spec = AD4000_DIFF_CHANNELS('s', 16, 1),
+	.offload_chan_spec = AD4000_DIFF_CHANNEL('s', 16, 0, 1),
+	.reg_access_offload_chan_spec = AD4000_DIFF_CHANNEL('s', 16, 1, 1),
 	.time_spec = &ad4000_t_spec,
+	.max_rate_hz = 1 * MEGA,
 };
 
 static const struct ad4000_chip_info ad4006_chip_info = {
 	.dev_name = "ad4006",
 	.chan_spec = AD4000_PSEUDO_DIFF_CHANNELS('u', 18, 0),
 	.reg_access_chan_spec = AD4000_PSEUDO_DIFF_CHANNELS('u', 18, 1),
+	.offload_chan_spec = AD4000_PSEUDO_DIFF_CHANNEL('u', 18, 0, 1),
+	.reg_access_offload_chan_spec = AD4000_PSEUDO_DIFF_CHANNEL('u', 18, 1, 1),
 	.time_spec = &ad4000_t_spec,
+	.max_rate_hz = 1 * MEGA,
 };
 
 static const struct ad4000_chip_info ad4007_chip_info = {
 	.dev_name = "ad4007",
 	.chan_spec = AD4000_DIFF_CHANNELS('s', 18, 0),
 	.reg_access_chan_spec = AD4000_DIFF_CHANNELS('s', 18, 1),
+	.offload_chan_spec = AD4000_DIFF_CHANNEL('s', 18, 0, 1),
+	.reg_access_offload_chan_spec = AD4000_DIFF_CHANNEL('s', 18, 1, 1),
 	.time_spec = &ad4000_t_spec,
+	.max_rate_hz = 1 * MEGA,
 };
 
 static const struct ad4000_chip_info ad4008_chip_info = {
 	.dev_name = "ad4008",
 	.chan_spec = AD4000_PSEUDO_DIFF_CHANNELS('u', 16, 0),
 	.reg_access_chan_spec = AD4000_PSEUDO_DIFF_CHANNELS('u', 16, 1),
+	.offload_chan_spec = AD4000_PSEUDO_DIFF_CHANNEL('u', 16, 0, 1),
+	.reg_access_offload_chan_spec = AD4000_PSEUDO_DIFF_CHANNEL('u', 16, 1, 1),
 	.time_spec = &ad4000_t_spec,
+	.max_rate_hz = 500 * KILO,
 };
 
 static const struct ad4000_chip_info ad4010_chip_info = {
 	.dev_name = "ad4010",
 	.chan_spec = AD4000_PSEUDO_DIFF_CHANNELS('u', 18, 0),
 	.reg_access_chan_spec = AD4000_PSEUDO_DIFF_CHANNELS('u', 18, 1),
+	.offload_chan_spec = AD4000_PSEUDO_DIFF_CHANNEL('u', 18, 0, 1),
+	.reg_access_offload_chan_spec = AD4000_PSEUDO_DIFF_CHANNEL('u', 18, 1, 1),
 	.time_spec = &ad4000_t_spec,
+	.max_rate_hz = 500 * KILO,
 };
 
 static const struct ad4000_chip_info ad4011_chip_info = {
 	.dev_name = "ad4011",
 	.chan_spec = AD4000_DIFF_CHANNELS('s', 18, 0),
 	.reg_access_chan_spec = AD4000_DIFF_CHANNELS('s', 18, 1),
+	.offload_chan_spec = AD4000_DIFF_CHANNEL('s', 18, 0, 1),
+	.reg_access_offload_chan_spec = AD4000_DIFF_CHANNEL('s', 18, 1, 1),
 	.time_spec = &ad4000_t_spec,
+	.max_rate_hz = 500 * KILO,
 };
 
 static const struct ad4000_chip_info ad4020_chip_info = {
 	.dev_name = "ad4020",
 	.chan_spec = AD4000_DIFF_CHANNELS('s', 20, 0),
 	.reg_access_chan_spec = AD4000_DIFF_CHANNELS('s', 20, 1),
+	.offload_chan_spec = AD4000_DIFF_CHANNEL('s', 20, 0, 1),
+	.reg_access_offload_chan_spec = AD4000_DIFF_CHANNEL('s', 20, 1, 1),
 	.time_spec = &ad4020_t_spec,
+	.max_rate_hz = 1800 * KILO,
 };
 
 static const struct ad4000_chip_info ad4021_chip_info = {
 	.dev_name = "ad4021",
 	.chan_spec = AD4000_DIFF_CHANNELS('s', 20, 0),
 	.reg_access_chan_spec = AD4000_DIFF_CHANNELS('s', 20, 1),
+	.offload_chan_spec = AD4000_DIFF_CHANNEL('s', 20, 0, 1),
+	.reg_access_offload_chan_spec = AD4000_DIFF_CHANNEL('s', 20, 1, 1),
 	.time_spec = &ad4020_t_spec,
+	.max_rate_hz = 1 * MEGA,
 };
 
 static const struct ad4000_chip_info ad4022_chip_info = {
 	.dev_name = "ad4022",
 	.chan_spec = AD4000_DIFF_CHANNELS('s', 20, 0),
 	.reg_access_chan_spec = AD4000_DIFF_CHANNELS('s', 20, 1),
+	.offload_chan_spec = AD4000_DIFF_CHANNEL('s', 20, 0, 1),
+	.reg_access_offload_chan_spec = AD4000_DIFF_CHANNEL('s', 20, 1, 1),
 	.time_spec = &ad4020_t_spec,
+	.max_rate_hz = 500 * KILO,
 };
 
 static const struct ad4000_chip_info adaq4001_chip_info = {
 	.dev_name = "adaq4001",
 	.chan_spec = AD4000_DIFF_CHANNELS('s', 16, 0),
 	.reg_access_chan_spec = AD4000_DIFF_CHANNELS('s', 16, 1),
+	.offload_chan_spec = AD4000_DIFF_CHANNEL('s', 16, 0, 1),
+	.reg_access_offload_chan_spec = AD4000_DIFF_CHANNEL('s', 16, 1, 1),
 	.time_spec = &ad4000_t_spec,
 	.has_hardware_gain = true,
+	.max_rate_hz = 2 * MEGA,
 };
 
 static const struct ad4000_chip_info adaq4003_chip_info = {
 	.dev_name = "adaq4003",
 	.chan_spec = AD4000_DIFF_CHANNELS('s', 18, 0),
 	.reg_access_chan_spec = AD4000_DIFF_CHANNELS('s', 18, 1),
+	.offload_chan_spec = AD4000_DIFF_CHANNEL('s', 18, 0, 1),
+	.reg_access_offload_chan_spec = AD4000_DIFF_CHANNEL('s', 18, 1, 1),
 	.time_spec = &ad4000_t_spec,
 	.has_hardware_gain = true,
+	.max_rate_hz = 2 * MEGA,
 };
 
 static const struct ad4000_chip_info ad7685_chip_info = {
 	.dev_name = "ad7685",
 	.chan_spec = AD4000_PSEUDO_DIFF_CHANNELS('u', 16, 0),
+	.offload_chan_spec = AD4000_PSEUDO_DIFF_CHANNEL('u', 16, 0, 1),
 	.time_spec = &ad7687_t_spec,
+	.max_rate_hz = 250 * KILO,
 };
 
 static const struct ad4000_chip_info ad7686_chip_info = {
 	.dev_name = "ad7686",
 	.chan_spec = AD4000_PSEUDO_DIFF_CHANNELS('u', 16, 0),
+	.offload_chan_spec = AD4000_PSEUDO_DIFF_CHANNEL('u', 16, 0, 1),
 	.time_spec = &ad7686_t_spec,
+	.max_rate_hz = 500 * KILO,
 };
 
 static const struct ad4000_chip_info ad7687_chip_info = {
 	.dev_name = "ad7687",
 	.chan_spec = AD4000_DIFF_CHANNELS('s', 16, 0),
+	.offload_chan_spec = AD4000_DIFF_CHANNEL('s', 16, 0, 1),
 	.time_spec = &ad7687_t_spec,
+	.max_rate_hz = 250 * KILO,
 };
 
 static const struct ad4000_chip_info ad7688_chip_info = {
 	.dev_name = "ad7688",
 	.chan_spec = AD4000_DIFF_CHANNELS('s', 16, 0),
+	.offload_chan_spec = AD4000_DIFF_CHANNEL('s', 16, 0, 1),
 	.time_spec = &ad7686_t_spec,
+	.max_rate_hz = 500 * KILO,
 };
 
 static const struct ad4000_chip_info ad7690_chip_info = {
 	.dev_name = "ad7690",
 	.chan_spec = AD4000_DIFF_CHANNELS('s', 18, 0),
+	.offload_chan_spec = AD4000_DIFF_CHANNEL('s', 18, 0, 1),
 	.time_spec = &ad7690_t_spec,
+	.max_rate_hz = 400 * KILO,
 };
 
 static const struct ad4000_chip_info ad7691_chip_info = {
 	.dev_name = "ad7691",
 	.chan_spec = AD4000_DIFF_CHANNELS('s', 18, 0),
+	.offload_chan_spec = AD4000_DIFF_CHANNEL('s', 18, 0, 1),
 	.time_spec = &ad7691_t_spec,
+	.max_rate_hz = 250 * KILO,
 };
 
 static const struct ad4000_chip_info ad7693_chip_info = {
 	.dev_name = "ad7693",
 	.chan_spec = AD4000_DIFF_CHANNELS('s', 16, 0),
+	.offload_chan_spec = AD4000_DIFF_CHANNEL('s', 16, 0, 1),
 	.time_spec = &ad7686_t_spec,
+	.max_rate_hz = 500 * KILO,
 };
 
 static const struct ad4000_chip_info ad7942_chip_info = {
 	.dev_name = "ad7942",
 	.chan_spec = AD4000_PSEUDO_DIFF_CHANNELS('u', 14, 0),
+	.offload_chan_spec = AD4000_PSEUDO_DIFF_CHANNEL('u', 14, 0, 1),
 	.time_spec = &ad7687_t_spec,
+	.max_rate_hz = 250 * KILO,
 };
 
 static const struct ad4000_chip_info ad7946_chip_info = {
 	.dev_name = "ad7946",
 	.chan_spec = AD4000_PSEUDO_DIFF_CHANNELS('u', 14, 0),
+	.offload_chan_spec = AD4000_PSEUDO_DIFF_CHANNEL('u', 14, 0, 1),
 	.time_spec = &ad7686_t_spec,
+	.max_rate_hz = 500 * KILO,
 };
 
 static const struct ad4000_chip_info ad7980_chip_info = {
 	.dev_name = "ad7980",
 	.chan_spec = AD4000_PSEUDO_DIFF_CHANNELS('u', 16, 0),
+	.offload_chan_spec = AD4000_PSEUDO_DIFF_CHANNEL('u', 16, 0, 1),
 	.time_spec = &ad7980_t_spec,
+	.max_rate_hz = 1 * MEGA,
 };
 
 static const struct ad4000_chip_info ad7982_chip_info = {
 	.dev_name = "ad7982",
 	.chan_spec = AD4000_DIFF_CHANNELS('s', 18, 0),
+	.offload_chan_spec = AD4000_DIFF_CHANNEL('s', 18, 0, 1),
 	.time_spec = &ad7980_t_spec,
+	.max_rate_hz = 1 * MEGA,
 };
 
 static const struct ad4000_chip_info ad7983_chip_info = {
 	.dev_name = "ad7983",
 	.chan_spec = AD4000_PSEUDO_DIFF_CHANNELS('u', 16, 0),
+	.offload_chan_spec = AD4000_PSEUDO_DIFF_CHANNEL('u', 16, 0, 1),
 	.time_spec = &ad7983_t_spec,
+	.max_rate_hz = 1 * MEGA + 333 * KILO + 333,
 };
 
 static const struct ad4000_chip_info ad7984_chip_info = {
 	.dev_name = "ad7984",
 	.chan_spec = AD4000_DIFF_CHANNELS('s', 18, 0),
+	.offload_chan_spec = AD4000_DIFF_CHANNEL('s', 18, 0, 1),
 	.time_spec = &ad7983_t_spec,
+	.max_rate_hz = 1 * MEGA + 333 * KILO + 333,
 };
 
 static const struct ad4000_chip_info ad7988_1_chip_info = {
 	.dev_name = "ad7988-1",
 	.chan_spec = AD4000_PSEUDO_DIFF_CHANNELS('u', 16, 0),
+	.offload_chan_spec = AD4000_PSEUDO_DIFF_CHANNEL('u', 16, 0, 1),
 	.time_spec = &ad7988_1_t_spec,
+	.max_rate_hz = 100 * KILO,
 };
 
 static const struct ad4000_chip_info ad7988_5_chip_info = {
 	.dev_name = "ad7988-5",
 	.chan_spec = AD4000_PSEUDO_DIFF_CHANNELS('u', 16, 0),
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
@@ -397,6 +497,13 @@ struct ad4000_state {
 	struct gpio_desc *cnv_gpio;
 	struct spi_transfer xfers[2];
 	struct spi_message msg;
+	struct spi_transfer offload_xfer;
+	struct spi_message offload_msg;
+	struct spi_offload *offload;
+	struct spi_offload_trigger *offload_trigger;
+	bool using_offload;
+	unsigned long offload_trigger_hz;
+	int max_rate_hz;
 	struct mutex lock; /* Protect read modify write cycle */
 	int vref_mv;
 	enum ad4000_sdi sdi_pin;
@@ -411,8 +518,10 @@ struct ad4000_state {
 	 */
 	struct {
 		union {
-			__be16 sample_buf16;
-			__be32 sample_buf32;
+			__be16 sample_buf16_be;
+			__be32 sample_buf32_be;
+			u16 sample_buf16;
+			u32 sample_buf32;
 		} data;
 		aligned_s64 timestamp;
 	} scan __aligned(IIO_DMA_MINALIGN);
@@ -487,6 +596,25 @@ static int ad4000_read_reg(struct ad4000_state *st, unsigned int *val)
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
@@ -515,10 +643,17 @@ static int ad4000_single_conversion(struct iio_dev *indio_dev,
 	if (ret < 0)
 		return ret;
 
-	if (chan->scan_type.storagebits > 16)
-		sample = be32_to_cpu(st->scan.data.sample_buf32);
-	else
-		sample = be16_to_cpu(st->scan.data.sample_buf16);
+	if (chan->scan_type.endianness == IIO_BE) {
+		if (chan->scan_type.realbits > 16)
+			sample = be32_to_cpu(st->scan.data.sample_buf32_be);
+		else
+			sample = be16_to_cpu(st->scan.data.sample_buf16_be);
+	} else {
+		if (chan->scan_type.realbits > 16)
+			sample = st->scan.data.sample_buf32;
+		else
+			sample = st->scan.data.sample_buf16;
+	}
 
 	sample >>= chan->scan_type.shift;
 
@@ -554,6 +689,9 @@ static int ad4000_read_raw(struct iio_dev *indio_dev,
 		if (st->span_comp)
 			*val = mult_frac(st->vref_mv, 1, 10);
 
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*val = st->offload_trigger_hz;
 		return IIO_VAL_INT;
 	default:
 		return -EINVAL;
@@ -620,6 +758,7 @@ static int ad4000_write_raw(struct iio_dev *indio_dev,
 			    struct iio_chan_spec const *chan,
 			    int val, int val2, long mask)
 {
+	struct ad4000_state *st = iio_priv(indio_dev);
 	int ret;
 
 	switch (mask) {
@@ -629,6 +768,15 @@ static int ad4000_write_raw(struct iio_dev *indio_dev,
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
@@ -659,10 +807,114 @@ static const struct iio_info ad4000_reg_access_info = {
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
+static int ad4000_offload_buffer_predisable(struct iio_dev *indio_dev)
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
+	.predisable = &ad4000_offload_buffer_predisable,
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
+ * This executes a data sample transfer when using SPI offloading. The device
+ * connections should be in "3-wire" mode, selected either when the adi,sdi-pin
+ * device tree property is absent or set to "high". Also, the ADC CNV pin must
+ * be connected to a SPI controller CS (it can't be connected to a GPIO).
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
+ * Note that, with `bits_per_word` set to the number of ADC precision bits,
+ * transfers use larger word sizes that get stored in 'in-memory wordsizes' that
+ * are always in native CPU byte order. Because of that, IIO buffer elements
+ * ought to be read in CPU endianness which requires setting IIO scan_type
+ * endianness accordingly (i.e. IIO_CPU).
+ */
+static int ad4000_prepare_offload_message(struct ad4000_state *st,
+					  const struct iio_chan_spec *chan)
+{
+	struct spi_transfer *xfer = &st->offload_xfer;
+
+	xfer->bits_per_word = chan->scan_type.realbits;
+	xfer->len = chan->scan_type.realbits > 16 ? 4 : 2;
+	xfer->delay.value = st->time_spec->t_quiet2_ns;
+	xfer->delay.unit = SPI_DELAY_UNIT_NSECS;
+	xfer->offload_flags = SPI_OFFLOAD_XFER_RX_STREAM;
+
+	spi_message_init_with_transfers(&st->offload_msg, xfer, 1);
+	st->offload_msg.offload = st->offload;
+
+	return devm_spi_optimize_message(&st->spi->dev, st->spi, &st->offload_msg);
+}
+
 /*
  * This executes a data sample transfer for when the device connections are
  * in "3-wire" mode, selected when the adi,sdi-pin device tree property is
@@ -690,6 +942,15 @@ static int ad4000_prepare_3wire_mode_message(struct ad4000_state *st,
 
 	xfers[1].rx_buf = &st->scan.data;
 	xfers[1].len = BITS_TO_BYTES(chan->scan_type.storagebits);
+
+	/*
+	 * If the device is set up for SPI offloading, IIO channel scan_type is
+	 * set to IIO_CPU. When that is the case, use larger SPI word sizes for
+	 * single-shot reads too. Thus, sample data can be correctly handled in
+	 * ad4000_single_conversion() according to scan_type endianness.
+	 */
+	if (chan->scan_type.endianness != IIO_BE)
+		xfers[1].bits_per_word = chan->scan_type.realbits;
 	xfers[1].delay.value = st->time_spec->t_quiet2_ns;
 	xfers[1].delay.unit = SPI_DELAY_UNIT_NSECS;
 
@@ -733,6 +994,9 @@ static int ad4000_config(struct ad4000_state *st)
 	if (device_property_present(&st->spi->dev, "adi,high-z-input"))
 		reg_val |= FIELD_PREP(AD4000_CFG_HIGHZ, 1);
 
+	if (st->using_offload)
+		reg_val |= FIELD_PREP(AD4000_CFG_TURBO, 1);
+
 	return ad4000_write_reg(st, reg_val);
 }
 
@@ -755,6 +1019,7 @@ static int ad4000_probe(struct spi_device *spi)
 	st = iio_priv(indio_dev);
 	st->spi = spi;
 	st->time_spec = chip->time_spec;
+	st->max_rate_hz = chip->max_rate_hz;
 
 	ret = devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(ad4000_power_supplies),
 					     ad4000_power_supplies);
@@ -772,6 +1037,26 @@ static int ad4000_probe(struct spi_device *spi)
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
@@ -784,7 +1069,6 @@ static int ad4000_probe(struct spi_device *spi)
 	switch (st->sdi_pin) {
 	case AD4000_SDI_MOSI:
 		indio_dev->info = &ad4000_reg_access_info;
-		indio_dev->channels = chip->reg_access_chan_spec;
 
 		/*
 		 * In "3-wire mode", the ADC SDI line must be kept high when
@@ -796,9 +1080,26 @@ static int ad4000_probe(struct spi_device *spi)
 		if (ret < 0)
 			return ret;
 
+		if (st->using_offload) {
+			indio_dev->channels = &chip->reg_access_offload_chan_spec;
+			indio_dev->num_channels = 1;
+			ret = ad4000_prepare_offload_message(st, indio_dev->channels);
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
@@ -806,19 +1107,38 @@ static int ad4000_probe(struct spi_device *spi)
 
 		break;
 	case AD4000_SDI_VIO:
-		indio_dev->info = &ad4000_info;
-		indio_dev->channels = chip->chan_spec;
+		if (st->using_offload) {
+			indio_dev->info = &ad4000_offload_info;
+			indio_dev->channels = &chip->offload_chan_spec;
+			indio_dev->num_channels = 1;
+
+			ret = ad4000_prepare_offload_message(st, indio_dev->channels);
+			if (ret)
+				return dev_err_probe(dev, ret,
+						     "Failed to optimize SPI msg\n");
+		} else {
+			indio_dev->info = &ad4000_info;
+			indio_dev->channels = chip->chan_spec;
+			indio_dev->num_channels = ARRAY_SIZE(chip->chan_spec);
+		}
+
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
@@ -830,7 +1150,6 @@ static int ad4000_probe(struct spi_device *spi)
 	}
 
 	indio_dev->name = chip->dev_name;
-	indio_dev->num_channels = 2;
 
 	ret = devm_mutex_init(dev, &st->lock);
 	if (ret)
@@ -853,12 +1172,6 @@ static int ad4000_probe(struct spi_device *spi)
 
 	ad4000_fill_scale_tbl(st, &indio_dev->channels[0]);
 
-	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
-					      &iio_pollfunc_store_time,
-					      &ad4000_trigger_handler, NULL);
-	if (ret)
-		return ret;
-
 	return devm_iio_device_register(dev, indio_dev);
 }
 
@@ -947,3 +1260,4 @@ module_spi_driver(ad4000_driver);
 MODULE_AUTHOR("Marcelo Schmitt <marcelo.schmitt@analog.com>");
 MODULE_DESCRIPTION("Analog Devices AD4000 ADC driver");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("IIO_DMAENGINE_BUFFER");
-- 
2.47.2


