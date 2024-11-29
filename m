Return-Path: <linux-iio+bounces-12808-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA919DE716
	for <lists+linux-iio@lfdr.de>; Fri, 29 Nov 2024 14:15:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E13B3283DA1
	for <lists+linux-iio@lfdr.de>; Fri, 29 Nov 2024 13:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9AB1A00D6;
	Fri, 29 Nov 2024 13:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="XwGHwXfS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F9B156991;
	Fri, 29 Nov 2024 13:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732886078; cv=none; b=Fhu4hz1MWpbJ9Gan6y9WYo0g5Rm98uP6FFF+VUMV4Z6BP2BbaRWSgdpQFQsWAsdn3xilRQDu2drhPVxXyf6MzJwU8UtpbZJztKQDPfaRJ1a+pKcXLEt/MAbf1SSEGTC6Y+Nx/Q2m66sH0yyLejLHD812Lu86U9eC64fbaWA79wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732886078; c=relaxed/simple;
	bh=0NtJLeywE+5TIOBJlVnnpu8TszEYpxScCqZ+saKDLZE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=itb0nw7O3vnqvLDQTigqznPAqBCIlSqATEITXGVRM3KahLQjlIH12xCKqgbpkJ705S05HtGw2yIzGSRmycC5ynzr/uBQeLVmVPErOwlPmKjXljJBSMu7+nEsnvYAmBjtVLyNARIy5sNuHrqydKSFuQ3UWayN0I/G2J1lqnqc00g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=XwGHwXfS; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ATBMX94018166;
	Fri, 29 Nov 2024 08:14:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=ATPUJ
	Fb2+7Q0aIr6pLA77tNE670dlGb9JHs4u0ZKanc=; b=XwGHwXfSauYLHsbjxEDKj
	4L/f5YAAPkla3rqO7KsNo95npi8nzueI1UUTZradLdEnq7naV1RbF64iEp+7o+Ry
	i9nWEC20VezyaZFS3y1lDENSrNueMPMZbCcWslGdpmE02km8/0YJPdqzKCaE5o2G
	22sJkCsDqM6BAsgViEZ0+ZoKdUI9kQjqyyTb9mktRFJfh+ZD96yb9NRWrgmZkdgE
	CKPEtOYZ//5Pjf2/HUFIII7er6ZdkF8V197+WkqT7yIXVqVlUvOpb1oxRSo/aaeW
	I5k2iiIXTyv2m2kcLaMTqZnr5fsKgBSYPb8F4qZsuR1lwBJF7DBogcPITzxh0Wtp
	w==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 436715t0d9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Nov 2024 08:14:23 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 4ATDEMwR064013
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 29 Nov 2024 08:14:22 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 29 Nov 2024 08:14:21 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 29 Nov 2024 08:14:21 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 29 Nov 2024 08:14:21 -0500
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4ATDEAJ2027169;
	Fri, 29 Nov 2024 08:14:13 -0500
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <marcelo.schmitt@analog.com>, <jic23@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v5 3/4] iio: adc: ad4000: Use device specific timing for SPI transfers
Date: Fri, 29 Nov 2024 10:14:09 -0300
Message-ID: <3969839a39023ab907f5ad726ee94f23ae0415e8.1732885470.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1732885470.git.marcelo.schmitt@analog.com>
References: <cover.1732885470.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: L_OIeZP4MNI70KnB5MADwL6mCeM2moRH
X-Proofpoint-GUID: L_OIeZP4MNI70KnB5MADwL6mCeM2moRH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 suspectscore=0 mlxscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2411290108

The SPI transfers for AD4020, AD4021, and AD4022 have slightly different
timing specifications. Use device specific timing constraints to set SPI
transfer parameters. While tweaking time constraints, remove time related
defines including unused AD4000_TQUIET1_NS.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
 drivers/iio/adc/ad4000.c | 51 +++++++++++++++++++++++++++++++++-------
 1 file changed, 42 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/adc/ad4000.c b/drivers/iio/adc/ad4000.c
index 21731c4d31ee..c700d51b5637 100644
--- a/drivers/iio/adc/ad4000.c
+++ b/drivers/iio/adc/ad4000.c
@@ -35,10 +35,6 @@
 
 #define AD4000_SCALE_OPTIONS		2
 
-#define AD4000_TQUIET1_NS		190
-#define AD4000_TQUIET2_NS		60
-#define AD4000_TCONV_NS			320
-
 #define __AD4000_DIFF_CHANNEL(_sign, _real_bits, _storage_bits, _reg_access)	\
 {										\
 	.type = IIO_VOLTAGE,							\
@@ -122,10 +118,31 @@ static const int ad4000_gains[] = {
 	454, 909, 1000, 1900,
 };
 
+struct ad4000_time_spec {
+	int t_conv_ns;
+	int t_quiet2_ns;
+};
+
+/*
+ * Same timing specifications for all of AD4000, AD4001, ..., AD4008, AD4010,
+ * ADAQ4001, and ADAQ4003.
+ */
+static const struct ad4000_time_spec ad4000_t_spec = {
+	.t_conv_ns = 320,
+	.t_quiet2_ns = 60,
+};
+
+/* AD4020, AD4021, AD4022 */
+static const struct ad4000_time_spec ad4020_t_spec = {
+	.t_conv_ns = 350,
+	.t_quiet2_ns = 60,
+};
+
 struct ad4000_chip_info {
 	const char *dev_name;
 	struct iio_chan_spec chan_spec[2];
 	struct iio_chan_spec reg_access_chan_spec[2];
+	const struct ad4000_time_spec *time_spec;
 	bool has_hardware_gain;
 };
 
@@ -133,90 +150,105 @@ static const struct ad4000_chip_info ad4000_chip_info = {
 	.dev_name = "ad4000",
 	.chan_spec = AD4000_PSEUDO_DIFF_CHANNELS('u', 16, 0),
 	.reg_access_chan_spec = AD4000_PSEUDO_DIFF_CHANNELS('u', 16, 1),
+	.time_spec = &ad4000_t_spec,
 };
 
 static const struct ad4000_chip_info ad4001_chip_info = {
 	.dev_name = "ad4001",
 	.chan_spec = AD4000_DIFF_CHANNELS('s', 16, 0),
 	.reg_access_chan_spec = AD4000_DIFF_CHANNELS('s', 16, 1),
+	.time_spec = &ad4000_t_spec,
 };
 
 static const struct ad4000_chip_info ad4002_chip_info = {
 	.dev_name = "ad4002",
 	.chan_spec = AD4000_PSEUDO_DIFF_CHANNELS('u', 18, 0),
 	.reg_access_chan_spec = AD4000_PSEUDO_DIFF_CHANNELS('u', 18, 1),
+	.time_spec = &ad4000_t_spec,
 };
 
 static const struct ad4000_chip_info ad4003_chip_info = {
 	.dev_name = "ad4003",
 	.chan_spec = AD4000_DIFF_CHANNELS('s', 18, 0),
 	.reg_access_chan_spec = AD4000_DIFF_CHANNELS('s', 18, 1),
+	.time_spec = &ad4000_t_spec,
 };
 
 static const struct ad4000_chip_info ad4004_chip_info = {
 	.dev_name = "ad4004",
 	.chan_spec = AD4000_PSEUDO_DIFF_CHANNELS('u', 16, 0),
 	.reg_access_chan_spec = AD4000_PSEUDO_DIFF_CHANNELS('u', 16, 1),
+	.time_spec = &ad4000_t_spec,
 };
 
 static const struct ad4000_chip_info ad4005_chip_info = {
 	.dev_name = "ad4005",
 	.chan_spec = AD4000_DIFF_CHANNELS('s', 16, 0),
 	.reg_access_chan_spec = AD4000_DIFF_CHANNELS('s', 16, 1),
+	.time_spec = &ad4000_t_spec,
 };
 
 static const struct ad4000_chip_info ad4006_chip_info = {
 	.dev_name = "ad4006",
 	.chan_spec = AD4000_PSEUDO_DIFF_CHANNELS('u', 18, 0),
 	.reg_access_chan_spec = AD4000_PSEUDO_DIFF_CHANNELS('u', 18, 1),
+	.time_spec = &ad4000_t_spec,
 };
 
 static const struct ad4000_chip_info ad4007_chip_info = {
 	.dev_name = "ad4007",
 	.chan_spec = AD4000_DIFF_CHANNELS('s', 18, 0),
 	.reg_access_chan_spec = AD4000_DIFF_CHANNELS('s', 18, 1),
+	.time_spec = &ad4000_t_spec,
 };
 
 static const struct ad4000_chip_info ad4008_chip_info = {
 	.dev_name = "ad4008",
 	.chan_spec = AD4000_PSEUDO_DIFF_CHANNELS('u', 16, 0),
 	.reg_access_chan_spec = AD4000_PSEUDO_DIFF_CHANNELS('u', 16, 1),
+	.time_spec = &ad4000_t_spec,
 };
 
 static const struct ad4000_chip_info ad4010_chip_info = {
 	.dev_name = "ad4010",
 	.chan_spec = AD4000_PSEUDO_DIFF_CHANNELS('u', 18, 0),
 	.reg_access_chan_spec = AD4000_PSEUDO_DIFF_CHANNELS('u', 18, 1),
+	.time_spec = &ad4000_t_spec,
 };
 
 static const struct ad4000_chip_info ad4011_chip_info = {
 	.dev_name = "ad4011",
 	.chan_spec = AD4000_DIFF_CHANNELS('s', 18, 0),
 	.reg_access_chan_spec = AD4000_DIFF_CHANNELS('s', 18, 1),
+	.time_spec = &ad4000_t_spec,
 };
 
 static const struct ad4000_chip_info ad4020_chip_info = {
 	.dev_name = "ad4020",
 	.chan_spec = AD4000_DIFF_CHANNELS('s', 20, 0),
 	.reg_access_chan_spec = AD4000_DIFF_CHANNELS('s', 20, 1),
+	.time_spec = &ad4020_t_spec,
 };
 
 static const struct ad4000_chip_info ad4021_chip_info = {
 	.dev_name = "ad4021",
 	.chan_spec = AD4000_DIFF_CHANNELS('s', 20, 0),
 	.reg_access_chan_spec = AD4000_DIFF_CHANNELS('s', 20, 1),
+	.time_spec = &ad4020_t_spec,
 };
 
 static const struct ad4000_chip_info ad4022_chip_info = {
 	.dev_name = "ad4022",
 	.chan_spec = AD4000_DIFF_CHANNELS('s', 20, 0),
 	.reg_access_chan_spec = AD4000_DIFF_CHANNELS('s', 20, 1),
+	.time_spec = &ad4020_t_spec,
 };
 
 static const struct ad4000_chip_info adaq4001_chip_info = {
 	.dev_name = "adaq4001",
 	.chan_spec = AD4000_DIFF_CHANNELS('s', 16, 0),
 	.reg_access_chan_spec = AD4000_DIFF_CHANNELS('s', 16, 1),
+	.time_spec = &ad4000_t_spec,
 	.has_hardware_gain = true,
 };
 
@@ -224,6 +256,7 @@ static const struct ad4000_chip_info adaq4003_chip_info = {
 	.dev_name = "adaq4003",
 	.chan_spec = AD4000_DIFF_CHANNELS('s', 18, 0),
 	.reg_access_chan_spec = AD4000_DIFF_CHANNELS('s', 18, 1),
+	.time_spec = &ad4000_t_spec,
 	.has_hardware_gain = true,
 };
 
@@ -238,6 +271,7 @@ struct ad4000_state {
 	bool span_comp;
 	u16 gain_milli;
 	int scale_tbl[AD4000_SCALE_OPTIONS][2];
+	const struct ad4000_time_spec *time_spec;
 
 	/*
 	 * DMA (thus cache coherency maintenance) requires the transfer buffers
@@ -502,16 +536,15 @@ static const struct iio_info ad4000_info = {
 static int ad4000_prepare_3wire_mode_message(struct ad4000_state *st,
 					     const struct iio_chan_spec *chan)
 {
-	unsigned int cnv_pulse_time = AD4000_TCONV_NS;
 	struct spi_transfer *xfers = st->xfers;
 
 	xfers[0].cs_change = 1;
-	xfers[0].cs_change_delay.value = cnv_pulse_time;
+	xfers[0].cs_change_delay.value = st->time_spec->t_conv_ns;
 	xfers[0].cs_change_delay.unit = SPI_DELAY_UNIT_NSECS;
 
 	xfers[1].rx_buf = &st->scan.data;
 	xfers[1].len = BITS_TO_BYTES(chan->scan_type.storagebits);
-	xfers[1].delay.value = AD4000_TQUIET2_NS;
+	xfers[1].delay.value = st->time_spec->t_quiet2_ns;
 	xfers[1].delay.unit = SPI_DELAY_UNIT_NSECS;
 
 	spi_message_init_with_transfers(&st->msg, st->xfers, 2);
@@ -529,7 +562,6 @@ static int ad4000_prepare_3wire_mode_message(struct ad4000_state *st,
 static int ad4000_prepare_4wire_mode_message(struct ad4000_state *st,
 					     const struct iio_chan_spec *chan)
 {
-	unsigned int cnv_to_sdi_time = AD4000_TCONV_NS;
 	struct spi_transfer *xfers = st->xfers;
 
 	/*
@@ -537,7 +569,7 @@ static int ad4000_prepare_4wire_mode_message(struct ad4000_state *st,
 	 * going low.
 	 */
 	xfers[0].cs_off = 1;
-	xfers[0].delay.value = cnv_to_sdi_time;
+	xfers[0].delay.value = st->time_spec->t_conv_ns;
 	xfers[0].delay.unit = SPI_DELAY_UNIT_NSECS;
 
 	xfers[1].rx_buf = &st->scan.data;
@@ -576,6 +608,7 @@ static int ad4000_probe(struct spi_device *spi)
 
 	st = iio_priv(indio_dev);
 	st->spi = spi;
+	st->time_spec = chip->time_spec;
 
 	ret = devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(ad4000_power_supplies),
 					     ad4000_power_supplies);
-- 
2.45.2


