Return-Path: <linux-iio+bounces-12294-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD769C9672
	for <lists+linux-iio@lfdr.de>; Fri, 15 Nov 2024 00:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CAC2283606
	for <lists+linux-iio@lfdr.de>; Thu, 14 Nov 2024 23:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479C21B392D;
	Thu, 14 Nov 2024 23:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="GTwR18iV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1EE1B21B8;
	Thu, 14 Nov 2024 23:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731628307; cv=none; b=aGPSCQvIpIxra+w3CU7nyV+H26Y6KkYw67G2olAfGFo7kMzl5RDZqGRGEAww0jZWz3LpGydwF7XpTzOYkJqFHhK0mq/R64qfSLinkDA5yPVFJL2CfUZQyVEgi3NnqTsrilhNHMLIDcfvdmf5hXzPZ/k/4sELsBns24Kck0uai88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731628307; c=relaxed/simple;
	bh=SAd6+yjNxA/bDojGedKL7eysp0BTIRCxIrjlCAgP8To=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q8PNfeWDt2gARBjsWaq3MMBbeEJpS5RVnOT8khxlt0ZX3C7tMxVlobpUn2QZ2reackZcxynnNsbIijkHq82CYOsrki1eGaLroEqwW7+nPAem129aNGM4pc/OghcUfhbLYWdOf8bu5WZn18cTfIeA3XVqd6UGG3MNOP7aR79a0d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=GTwR18iV; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AELXN7n010943;
	Thu, 14 Nov 2024 18:51:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=T49TZ
	OvyOF38grsR7LDefauV8SLnxp6MKYq8K1Q1L/M=; b=GTwR18iVyYc6WBRWJEKOI
	fqsVUz1IK4wseZtBmDbdKbqihAehbGP0UzA/bGzaV2j3dCKjRKWyyk7PyuABFLa8
	AcrMyltNm177xgSKetzLnMNbUPwA2hFjYgICZnWrIXq3ZGWEJjfu7yhCsRdT0JWu
	HYwErFvrVIlhJxb0xq2Ry6ICqYFgB9Bkbq9xgUCws99LVKxeyyBd0wBDINGKx0DS
	AsGgrq179fYwUJW2Vk26tP5yArFy1w7A4MXax0ExxU8rjFhxv61YaqU/G8YesQRy
	hG8UZiKDzjpaYEguoRZ+IbNApn0ghLdY39hmneeCQjbrDZzxZbs+/RXRISWw8ep4
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 42wc2n531x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Nov 2024 18:51:31 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 4AENpUra006631
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 14 Nov 2024 18:51:30 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Thu, 14 Nov
 2024 18:51:30 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 14 Nov 2024 18:51:30 -0500
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4AENpHNB028823;
	Thu, 14 Nov 2024 18:51:20 -0500
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <marcelo.schmitt@analog.com>, <jic23@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <marcelo.schmitt1@gmail.com>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/4] iio: adc: ad4000: Use device specific timing for SPI transfers
Date: Thu, 14 Nov 2024 20:51:16 -0300
Message-ID: <81370b043de208795738e5679c33de37439c0a2e.1731626099.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1731626099.git.marcelo.schmitt@analog.com>
References: <cover.1731626099.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: W_U6O_z_9UUx9B_F-csHblMu1vwVMX2o
X-Proofpoint-ORIG-GUID: W_U6O_z_9UUx9B_F-csHblMu1vwVMX2o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 adultscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411140189

The SPI transfers for AD4020, AD4021, and AD4022 have slightly different
timing specifications. Use device specific timing constraints to set SPI
transfer parameters.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
 drivers/iio/adc/ad4000.c | 50 ++++++++++++++++++++++++++++++++--------
 1 file changed, 41 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/adc/ad4000.c b/drivers/iio/adc/ad4000.c
index 21731c4d31ee..68ac77494263 100644
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
@@ -122,10 +118,30 @@ static const int ad4000_gains[] = {
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
 
@@ -133,90 +149,105 @@ static const struct ad4000_chip_info ad4000_chip_info = {
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
 
@@ -224,6 +255,7 @@ static const struct ad4000_chip_info adaq4003_chip_info = {
 	.dev_name = "adaq4003",
 	.chan_spec = AD4000_DIFF_CHANNELS('s', 18, 0),
 	.reg_access_chan_spec = AD4000_DIFF_CHANNELS('s', 18, 1),
+	.time_spec = &ad4000_t_spec,
 	.has_hardware_gain = true,
 };
 
@@ -238,6 +270,7 @@ struct ad4000_state {
 	bool span_comp;
 	u16 gain_milli;
 	int scale_tbl[AD4000_SCALE_OPTIONS][2];
+	const struct ad4000_time_spec *time_spec;
 
 	/*
 	 * DMA (thus cache coherency maintenance) requires the transfer buffers
@@ -502,16 +535,15 @@ static const struct iio_info ad4000_info = {
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
@@ -529,7 +561,6 @@ static int ad4000_prepare_3wire_mode_message(struct ad4000_state *st,
 static int ad4000_prepare_4wire_mode_message(struct ad4000_state *st,
 					     const struct iio_chan_spec *chan)
 {
-	unsigned int cnv_to_sdi_time = AD4000_TCONV_NS;
 	struct spi_transfer *xfers = st->xfers;
 
 	/*
@@ -537,7 +568,7 @@ static int ad4000_prepare_4wire_mode_message(struct ad4000_state *st,
 	 * going low.
 	 */
 	xfers[0].cs_off = 1;
-	xfers[0].delay.value = cnv_to_sdi_time;
+	xfers[0].delay.value = st->time_spec->t_conv_ns;
 	xfers[0].delay.unit = SPI_DELAY_UNIT_NSECS;
 
 	xfers[1].rx_buf = &st->scan.data;
@@ -576,6 +607,7 @@ static int ad4000_probe(struct spi_device *spi)
 
 	st = iio_priv(indio_dev);
 	st->spi = spi;
+	st->time_spec = chip->time_spec;
 
 	ret = devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(ad4000_power_supplies),
 					     ad4000_power_supplies);
-- 
2.45.2


