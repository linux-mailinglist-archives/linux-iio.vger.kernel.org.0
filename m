Return-Path: <linux-iio+bounces-23414-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E7AB3C696
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 02:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CF5CE4E3F9D
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 00:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58CE1D435F;
	Sat, 30 Aug 2025 00:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="U0EJh+uh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0801C1AF0A7;
	Sat, 30 Aug 2025 00:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756514639; cv=none; b=NqZzkwFE9F45gDf/ASfEoaSXNsyy796FA+lFsHWmvrB4rXVpdQFRKl3c1xSvuz7VIx8CoLjYmWPl/Cs1fMDq/Mu1tz2fOzTyARihSKc9P24pPcGyoraVQK2e4IBHh3nHMpoi0zp0keSqiuAvnZICLw0S68VY9g5am8/9cNoN8/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756514639; c=relaxed/simple;
	bh=OXeVdrho3GoxweVNKuR6XRHI3Lqzv2OxDj/0YJ2vif8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H0ClLXioV4rx9wDjl/tZO6K5UgdVcTbwtBhkgjouD5wWhqxkC2ImVCR3i31/IQkJETuPid2ovwuWsTNJcO7ktqFECMolyirDIp3bHNuqT9uMbvFA0KU/3zYJMrmsGor6wo8Cu8X7uuE66WqSME3NV76aIapsSBErP6Sqva30dT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=U0EJh+uh; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57U0B1No026873;
	Fri, 29 Aug 2025 20:43:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=y7kkL
	yIA2xfdBdRTnMPxpOpQAVzS1Iq4yr8f29s48XY=; b=U0EJh+uhJz81U5bS/beIw
	n1K4I1QkXjmTxJt3RNS5c7a7malL4SaBU4qy9PEMOAIqA+jOdFUQL2EeIbBTyiae
	6oLrXAMmOowvQ9CAUiLaj/9+yYhc3EChWY10gyJ6Wo8GcuUN/2WNIa7qsO+QEP4/
	tnMhJ6y1uaafuHKPrhW8Ra8Xj7uwIHBH7bDtjrAYwTm49/yg3AsHpzB1EQGYaRgk
	mGkfqw9x2/2DlF5JKizAuhLDsYo3vfpuLOkXXjcWDdNo+7mZqoYLowhv+BWgsl89
	lC35Qv/j4/qbVhjfx4Oz/gNBRcHASo2Rr1KP8z776eKaVioWr39ZqoYT17f/zZJI
	A==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 48sqataje6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Aug 2025 20:43:52 -0400 (EDT)
Received: from m0167088.ppops.net (m0167088.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57U0eBKN006053;
	Fri, 29 Aug 2025 20:43:52 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 48sqataje0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Aug 2025 20:43:52 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 57U0hoFr041072
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 29 Aug 2025 20:43:50 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 29 Aug
 2025 20:43:50 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 29 Aug 2025 20:43:50 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 57U0hV7V004991;
	Fri, 29 Aug 2025 20:43:33 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-spi@vger.kernel.org>
CC: <jic23@kernel.org>, <Michael.Hennerich@analog.com>, <nuno.sa@analog.com>,
        <eblanc@baylibre.com>, <dlechner@baylibre.com>, <andy@kernel.org>,
        <corbet@lwn.net>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <broonie@kernel.org>,
        <Jonathan.Cameron@huawei.com>, <andriy.shevchenko@linux.intel.com>,
        <ahaslam@baylibre.com>, <sergiu.cuciurean@analog.com>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH 09/15] iio: adc: ad4030: Support multiple data lanes per channel
Date: Fri, 29 Aug 2025 21:43:30 -0300
Message-ID: <4e2b2d07a255bb249a1dc40a4470c7e123d4213f.1756511030.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1756511030.git.marcelo.schmitt@analog.com>
References: <cover.1756511030.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI3MDAwMCBTYWx0ZWRfX+Eqfr8TG7pzK
 eCdfq0OMfbX8TvjZAz09VqB0FT5Y1gLKuakFDmD8bUxM/OpIMi6ZLeuegPEw9WHEvDESrp3Yu2j
 DBC7GTDhy8Y+p/Ak9j3BWUoc0VuoS9fFKLaAw7cfS+Kk+V+gr4RTTjxjE4ODo+6FS7NbFy+wMzG
 m8Rb5CKhyhYBXP9hJIWaW8QYcFSjM0kzPfwP75VCreij0Wv9wQnx8+4gxtgZl7Q/BjGUwu8o3vC
 gcy62C6S8zDrreCD4tWhmNdGeQobvsuI5V3iiUmz67FKYH4cHbcpT0+eCGw0BgVG5AkNdxzpakF
 CsDbD0sk3TSqtEWJv/0GTDF2vsMS5hsBjbObX7v4DpRVYPp7VJz3C+PGkXKMpV2b6cukL3QBy/g
 MeZtDXr3
X-Authority-Analysis: v=2.4 cv=Z4bsHGRA c=1 sm=1 tr=0 ts=68b24948 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=2OwXVqhp2XgA:10 a=gAnH3GRIAAAA:8 a=v3oLJsYcB7DOy6y-vfUA:9
 a=br55WurUj89AL1qEz8Q6:22
X-Proofpoint-ORIG-GUID: tLA22jJgyI46VTWqLIyiv692W-WFrJiQ
X-Proofpoint-GUID: F2yzzaIrmRv3Taoi7U_dvz-sML0RWQgH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-29_07,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 malwarescore=0 bulkscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508270000

AD4030 and similar chips can output ADC sample data through 1, 2, or 4
lines per channel. The number of SPI lines the device uses to output data
is specified in firmware. Parse SPI read bus width setting from firmware
and configure the device to use that amount of lines to output data.

Co-developed-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
 drivers/iio/adc/ad4030.c | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ad4030.c b/drivers/iio/adc/ad4030.c
index 68f76432dbfd..e6c1c9be1632 100644
--- a/drivers/iio/adc/ad4030.c
+++ b/drivers/iio/adc/ad4030.c
@@ -20,6 +20,7 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
+#include <linux/log2.h>
 #include <linux/pwm.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
@@ -258,6 +259,10 @@ struct ad4030_state {
 #define AD4030_OFFLOAD_CHAN_DIFF(_idx, _scan_type)			\
 	__AD4030_CHAN_DIFF(_idx, _scan_type, 1)
 
+static const int ad4030_rx_bus_width[] = {
+	1, 2, 4, 8,
+};
+
 static const int ad4030_average_modes[] = {
 	1, 2, 4, 8, 16, 32, 64, 128,
 	256, 512, 1024, 2048, 4096, 8192, 16384, 32768,
@@ -1197,7 +1202,7 @@ static void ad4030_prepare_offload_msg(struct ad4030_state *st)
 		 */
 		offload_bpw = data_width * st->chip->num_voltage_inputs;
 	else
-		offload_bpw  = data_width;
+		offload_bpw  = data_width / (1 << st->lane_mode);
 
 	st->offload_xfer.speed_hz = AD4030_SPI_MAX_REG_XFER_SPEED;
 	st->offload_xfer.bits_per_word = offload_bpw;
@@ -1208,6 +1213,10 @@ static void ad4030_prepare_offload_msg(struct ad4030_state *st)
 
 static int ad4030_config(struct ad4030_state *st)
 {
+	struct device *dev = &st->spi->dev;
+	const char *propname;
+	u32 rx_bus_width;
+	unsigned int i;
 	int ret;
 	u8 reg_modes;
 
@@ -1215,10 +1224,28 @@ static int ad4030_config(struct ad4030_state *st)
 	st->offset_avail[1] = 1;
 	st->offset_avail[2] = BIT(st->chip->precision_bits - 1) - 1;
 
-	if (st->chip->num_voltage_inputs > 1)
+	/* Optional property specifying the number of lanes to read ADC data */
+	propname = "spi-rx-bus-width";
+	rx_bus_width = ad4030_rx_bus_width[0]; /* Default to 1 rx lane. */
+	device_property_read_u32(dev, propname, &rx_bus_width);
+	/* Check the rx bus width is valid */
+	for (i = 0; i < ARRAY_SIZE(ad4030_rx_bus_width); i++)
+		if (ad4030_rx_bus_width[i] == rx_bus_width)
+			break;
+
+	if (i >= ARRAY_SIZE(ad4030_rx_bus_width))
+		return dev_err_probe(dev, -EINVAL, "Invalid %s: %u\n",
+				     propname, rx_bus_width);
+
+	rx_bus_width = ad4030_rx_bus_width[i];
+
+	if (rx_bus_width == 8 && st->chip->num_voltage_inputs == 1)
+		return dev_err_probe(dev, -EINVAL, "1 channel with 8 lanes?\n");
+
+	if (rx_bus_width == 1 && st->chip->num_voltage_inputs > 1)
 		st->lane_mode = AD4030_LANE_MD_INTERLEAVED;
 	else
-		st->lane_mode = AD4030_LANE_MD_1_PER_CH;
+		st->lane_mode = ilog2(rx_bus_width / st->chip->num_voltage_inputs);
 
 	reg_modes = FIELD_PREP(AD4030_REG_MODES_MASK_LANE_MODE, st->lane_mode);
 
-- 
2.39.2


