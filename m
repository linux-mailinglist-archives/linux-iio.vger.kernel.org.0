Return-Path: <linux-iio+bounces-12718-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3345B9D9F81
	for <lists+linux-iio@lfdr.de>; Wed, 27 Nov 2024 00:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CF10B24B8F
	for <lists+linux-iio@lfdr.de>; Tue, 26 Nov 2024 23:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14EC41DF992;
	Tue, 26 Nov 2024 23:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="lo97Nm0a"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED8A1CCEE2;
	Tue, 26 Nov 2024 23:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732663041; cv=none; b=QnkW1lujVo2zVBkGjdB+hHxYlYTPAaDpP+VDKYzBXDVjrFIZi3TUhOg5kogXLpIqRN4PkGrN/wAR6oFczgbz9NDa/gFy6OJJ1y+/kHJkUHCJaD4W5U2vS/jeVfZttacMBPzDXJ++ovNK2+XSXmNveJCa6I4QG93bJRqNAnefOpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732663041; c=relaxed/simple;
	bh=0NtJLeywE+5TIOBJlVnnpu8TszEYpxScCqZ+saKDLZE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ghgyU67vudR/pv9Ru7rZkxl96+CoAKAL3HgczFGad7H9SQIeQH84pXv9btsgEKUVL5FXPe7B41i7BPkjqjOjl4C+P0fXtQSi+SK/TwBkFiTXKC+UFFZqZwA7ZRpVFbOYmUYyeK35KpgWFQgXkS6hF3QInD+vUYvJIcceGcRKTHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=lo97Nm0a; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AQKo74N007275;
	Tue, 26 Nov 2024 18:17:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=ATPUJ
	Fb2+7Q0aIr6pLA77tNE670dlGb9JHs4u0ZKanc=; b=lo97Nm0aNkrmQU4uDl2Gj
	fu2MibqfgclhodGB+Z0rW1cmOliRYR3pOaSeD/gnN9Wa9qMRHx2EOEw6xqQiXIal
	6/g+L+rgIscLtFeanntecBYh0Gdz6S5+o03q7B8ve0qBSLaTNTYHInU6Js7cI1AP
	+yFZhdafgvcVvV3MrxL4smyw+zw2KI28N41VWoJU3bWekRC1bTM7KtdqTiskR1Zp
	ua+UGjhCtHmp4OwtcxlWfOAzsg05zMDSTaV53nBlW7kfzRhB2YlAZcrMNqfLmwG9
	0RZOYCYmmb7NeOtNDhtmorwmOdzigPaqQ7gTaoMefRVzsYffS0ExiSVhZahKAK1t
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 433cu713bb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Nov 2024 18:17:05 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 4AQNH3PC037106
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 26 Nov 2024 18:17:03 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Tue, 26 Nov
 2024 18:17:03 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 26 Nov 2024 18:17:03 -0500
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4AQNGom0017916;
	Tue, 26 Nov 2024 18:16:52 -0500
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <marcelo.schmitt@analog.com>, <jic23@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v4 3/4] iio: adc: ad4000: Use device specific timing for SPI transfers
Date: Tue, 26 Nov 2024 20:16:48 -0300
Message-ID: <e694a8010a70ba656aef711e2f9447a8c109d0c2.1732660478.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1732660478.git.marcelo.schmitt@analog.com>
References: <cover.1732660478.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: YdrqLEm0aVuElGkSfMTMFeGMZWtpH0hh
X-Proofpoint-ORIG-GUID: YdrqLEm0aVuElGkSfMTMFeGMZWtpH0hh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 malwarescore=0 phishscore=0 clxscore=1015 spamscore=0 suspectscore=0
 mlxscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2411260187

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


