Return-Path: <linux-iio+bounces-12948-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E56E89E0468
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2024 15:09:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A56EE2828F8
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2024 14:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 743CE20408C;
	Mon,  2 Dec 2024 14:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="NotMN7fF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D311FDE0E;
	Mon,  2 Dec 2024 14:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733148528; cv=none; b=o40nWYb9oxMy8aHtM5iJ8hDfupSFrobBGCvpvADigYxzwORnpeO/cVHPtMPkKI4y3qG7NRL0pZKNqgSoOnbVZuAtRUnii3FzYyH4c8nDT8QdhBJtlcLh2Rpabp/vnwG0+tww2EszHGPhMpkUUyId2LLl6B2TXGNAWURYPgNXjW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733148528; c=relaxed/simple;
	bh=StzXx7c7i0Ou8PJhKupjnVjtQe2vG13hnJQl0ghlgSE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BDJNlWPmymC0OeKrVAoHl9aS54/VvkY5IPI9OUkQy9MjaTSt+goYY/SN7jDgFTo9Ukji8cCjE7WUlb63gQUbB/edXVOnMcCNdYiBUYgjhFdpThWtGObMl/7D3X8UZo2mBWGkGg1mZFD0FoSNn7lEQKwIuGYGzGyDuLrrxF9YUhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=NotMN7fF; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B2BqbfR004498;
	Mon, 2 Dec 2024 09:08:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=7OMS7
	i0qiWYBwt4lkSy8LsR7pW0PUNHDALnfsoZ6g/k=; b=NotMN7fF2VNMU3HTFpkCY
	aJqhXH2Z5QhqlQkFt2Hab6AJPXUvjhjt5FV8+YdpOCTdtA0Jdvt9tB2FB4mnatqb
	briAqn5jdS8XHWzDJgBGFreYY+zqU+J3j+bE4zXM7VQ0X2fjwaJE7iclzztNxoWB
	AgIZ5zBcfHd4wXopGCnVMhrtToHnf4X0/h6PJci+xLisEnEk/HKwYWjqrJuGbNqM
	CyqcD4mHa4g7OuGI7uWexdYXMzIS7BpGLlOv7Nex3YCTRchb5D90nsvO38c05v7A
	8btyVrfJhw8JuAK2RxIAXqQiwHPUe3FiOV5q8kRk1kgJk3zu9ix5W91VD9/Cys37
	g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 437we78jrt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Dec 2024 09:08:32 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 4B2E8VnN006758
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 2 Dec 2024 09:08:31 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 2 Dec 2024 09:08:31 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 2 Dec 2024 09:08:31 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 2 Dec 2024 09:08:31 -0500
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4B2E8ENl027790;
	Mon, 2 Dec 2024 09:08:17 -0500
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <marcelo.schmitt@analog.com>, <jic23@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v6 3/4] iio: adc: ad4000: Use device specific timing for SPI transfers
Date: Mon, 2 Dec 2024 11:08:13 -0300
Message-ID: <a36fcf44cc00b2a498170e2ae3f005829d516266.1733147444.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1733147443.git.marcelo.schmitt@analog.com>
References: <cover.1733147443.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: 7RMTkTtPRQkaVR49oYTFy4nsDQJzJe6m
X-Proofpoint-GUID: 7RMTkTtPRQkaVR49oYTFy4nsDQJzJe6m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 bulkscore=0 impostorscore=0 spamscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 phishscore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412020122

The SPI transfers for AD4020, AD4021, and AD4022 have slightly different
timing specifications. Use device specific timing constraints to set SPI
transfer parameters. While tweaking time constraints, remove time related
defines including unused AD4000_TQUIET1_NS.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
 drivers/iio/adc/ad4000.c | 51 +++++++++++++++++++++++++++++++++-------
 1 file changed, 42 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/adc/ad4000.c b/drivers/iio/adc/ad4000.c
index e73c285b3438..1d0f9c3ddae6 100644
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


