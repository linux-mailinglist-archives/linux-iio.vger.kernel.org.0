Return-Path: <linux-iio+bounces-7307-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D9D9272E9
	for <lists+linux-iio@lfdr.de>; Thu,  4 Jul 2024 11:22:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFF221F24A03
	for <lists+linux-iio@lfdr.de>; Thu,  4 Jul 2024 09:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570ED1AB51D;
	Thu,  4 Jul 2024 09:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="aSgPkzfb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC271AB50E;
	Thu,  4 Jul 2024 09:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720084955; cv=none; b=P6wqkWAbqdZOLevtRogLsFI95rqkZnT7vOsns1QEU871jtWlV/sFLb0omzDHSeSrU73GAsRqPm2RiXGIqRYPdfrdDVuEgQduYVLv+Om6qXqe82xuzE+nV7FX8uQfkkaM4fnOtDRal4P5thfHrZ33IVqLfoDkZ7SM4EKJd7Zly6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720084955; c=relaxed/simple;
	bh=F3dDK0/pvu/BBK44Zu08RnmwdorZmIdJNH/uAHvs/EU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=p/40ZjPWfixxBDV3MyhOpNNQK6Uqq3LoNGdM95gcErcqFoEQIj8Dl+vil8KlxT8RvPBSz2x5DLtFk062jMeIag6PU5I+GY2M7oEwPIaD0v3dmmyhkDMMhepb1PKUqW3JlMjyL63LewRZlFq5taBwni8onfXcX6Zyu6wRojIO/eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=aSgPkzfb; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4646rAEC003641;
	Thu, 4 Jul 2024 05:22:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=mPXqv
	OjDq6RUGvHm7w96GSr1GrUkw1/VwO9JThkRowU=; b=aSgPkzfbAtkRTj2IpTHBb
	KQepKvtrhZLrVAASQLAcpHk4iPYZiugFimcSqpspIcWcQXf/cri147ON5jTE/SQl
	ZYqODePcDHFgChsA5ngKLRF3uACLxX6nHbJIEicAglMOzk25dEuA5ZKeFV8IQmbd
	Apw3FaR0BzWVQNhnZLGkpnZJ2T5yGGsssk6Lvn0BJva04zgeLliFBSwLTbkEmZuN
	MkDqxbFb/N7oKojHr1jHyW+N3WoF5AWEey+gdOPaSNJ3IBTKa87l2a5zROLnwl7+
	2VuZNHrheO916GiE4npPz6aYDKun0mX7DgsWOiJNDoIvDF7Unxq23lPtxE23MEca
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 405a7natfq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jul 2024 05:22:20 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 4649MJXh058900
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 4 Jul 2024 05:22:19 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 4 Jul 2024 05:22:18 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 4 Jul 2024 05:22:18 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 4 Jul 2024 05:22:18 -0400
Received: from [127.0.0.1] ([10.44.3.56])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4649M1dn012858;
	Thu, 4 Jul 2024 05:22:11 -0400
From: Nuno Sa <nuno.sa@analog.com>
Date: Thu, 4 Jul 2024 11:25:25 +0200
Subject: [PATCH 5/5] iio: adc: ad9467: support new parts
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240704-dev-iio-ad9467-new-devs-v1-5-f1adfee921f7@analog.com>
References: <20240704-dev-iio-ad9467-new-devs-v1-0-f1adfee921f7@analog.com>
In-Reply-To: <20240704-dev-iio-ad9467-new-devs-v1-0-f1adfee921f7@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720085156; l=5389;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=F3dDK0/pvu/BBK44Zu08RnmwdorZmIdJNH/uAHvs/EU=;
 b=MdKQnk39Gj1I6inXvXzZ5ZhYr+F85IbPc5AEJ1hKmD8Qbukw9o84zExN1s1Yoc48AaQcZ5N4j
 qGaKf/r0QsKBA1dCZlf3S7XZ5CsFzuAFFEnY3KtVNMO7lD6qfXMyb6y
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: PI2y7wD6q0rTe8ftFZQ38T2Zj14ZxNZf
X-Proofpoint-GUID: PI2y7wD6q0rTe8ftFZQ38T2Zj14ZxNZf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-04_06,2024-07-03_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 suspectscore=0 mlxscore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 mlxlogscore=659 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407040064

Add support for new devices:
 * Analog Devices AD9652 16-bit 310 MSPS ADC;
 * Analog Devices AD9643 14-Bit, 170/210/250 MSPS ADC;
 * Analog Devices AD9649 14-bit 20/40/65/80 MSPS ADC.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/adc/ad9467.c | 101 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
index d06a5fcc4ee8..b07c83efc39a 100644
--- a/drivers/iio/adc/ad9467.c
+++ b/drivers/iio/adc/ad9467.c
@@ -104,6 +104,27 @@
 #define AD9467_DEF_OUTPUT_MODE		0x08
 #define AD9467_REG_VREF_MASK		0x0F
 
+/*
+ * Analog Devices AD9643 14-Bit, 170/210/250 MSPS ADC
+ */
+
+#define CHIPID_AD9643			0x82
+#define AD9643_REG_VREF_MASK		0x1F
+
+/*
+ * Analog Devices AD9652 16-bit 310 MSPS ADC
+ */
+
+#define CHIPID_AD9652                   0xC1
+#define AD9652_REG_VREF_MASK            0xC0
+
+/*
+ * Analog Devices AD9649 14-bit 20/40/65/80 MSPS ADC
+ */
+
+#define CHIPID_AD9649			0x6F
+#define AD9649_TEST_POINTS		8
+
 #define AD9647_MAX_TEST_POINTS		32
 #define AD9467_CAN_INVERT(st)	\
 	(!(st)->info->has_dco || (st)->info->has_dco_invert)
@@ -218,6 +239,24 @@ static const unsigned int ad9467_scale_table[][2] = {
 	{2300, 8}, {2400, 9}, {2500, 10},
 };
 
+static const unsigned int ad9643_scale_table[][2] = {
+	{2087, 0x0F}, {2065, 0x0E}, {2042, 0x0D}, {2020, 0x0C}, {1997, 0x0B},
+	{1975, 0x0A}, {1952, 0x09}, {1930, 0x08}, {1907, 0x07}, {1885, 0x06},
+	{1862, 0x05}, {1840, 0x04}, {1817, 0x03}, {1795, 0x02}, {1772, 0x01},
+	{1750, 0x00}, {1727, 0x1F}, {1704, 0x1E}, {1681, 0x1D}, {1658, 0x1C},
+	{1635, 0x1B}, {1612, 0x1A}, {1589, 0x19}, {1567, 0x18}, {1544, 0x17},
+	{1521, 0x16}, {1498, 0x15}, {1475, 0x14}, {1452, 0x13}, {1429, 0x12},
+	{1406, 0x11}, {1383, 0x10},
+};
+
+static const unsigned int ad9649_scale_table[][2] = {
+	 {2000, 0},
+};
+
+static const unsigned int ad9652_scale_table[][2] = {
+	 {1250, 0}, {1125, 1}, {1200, 2}, {1250, 3}, {1000, 5},
+};
+
 static void __ad9467_get_scale(struct ad9467_state *st, int index,
 			       unsigned int *val, unsigned int *val2)
 {
@@ -255,6 +294,20 @@ static const struct iio_chan_spec ad9467_channels[] = {
 	AD9467_CHAN(0, BIT(IIO_CHAN_INFO_SCALE), 0, 16, 's'),
 };
 
+static const struct iio_chan_spec ad9643_channels[] = {
+	AD9467_CHAN(0, BIT(IIO_CHAN_INFO_SCALE), 0, 14, 's'),
+	AD9467_CHAN(1, BIT(IIO_CHAN_INFO_SCALE), 1, 14, 's'),
+};
+
+static const struct iio_chan_spec ad9649_channels[] = {
+	AD9467_CHAN(0, 0, 0, 14, 's'),
+};
+
+static const struct iio_chan_spec ad9652_channels[] = {
+	AD9467_CHAN(0, BIT(IIO_CHAN_INFO_SCALE), 0, 16, 's'),
+	AD9467_CHAN(1, BIT(IIO_CHAN_INFO_SCALE), 1, 16, 's'),
+};
+
 static const struct ad9467_chip_info ad9467_chip_tbl = {
 	.name = "ad9467",
 	.id = CHIPID_AD9467,
@@ -298,6 +351,48 @@ static const struct ad9467_chip_info ad9265_chip_tbl = {
 	.has_dco_invert = true,
 };
 
+static const struct ad9467_chip_info ad9643_chip_tbl = {
+	.name = "ad9643",
+	.id = CHIPID_AD9643,
+	.max_rate = 250000000UL,
+	.scale_table = ad9643_scale_table,
+	.num_scales = ARRAY_SIZE(ad9643_scale_table),
+	.channels = ad9643_channels,
+	.num_channels = ARRAY_SIZE(ad9643_channels),
+	.test_points = AD9647_MAX_TEST_POINTS,
+	.vref_mask = AD9643_REG_VREF_MASK,
+	.has_dco = true,
+	.has_dco_invert = true,
+	.dco_en = AN877_ADC_DCO_DELAY_ENABLE,
+};
+
+static const struct ad9467_chip_info ad9649_chip_tbl = {
+	.name = "ad9649",
+	.id = CHIPID_AD9649,
+	.max_rate = 80000000UL,
+	.scale_table = ad9649_scale_table,
+	.num_scales = ARRAY_SIZE(ad9649_scale_table),
+	.channels = ad9649_channels,
+	.num_channels = ARRAY_SIZE(ad9649_channels),
+	.test_points = AD9649_TEST_POINTS,
+	.has_dco = true,
+	.has_dco_invert = true,
+	.dco_en = AN877_ADC_DCO_DELAY_ENABLE,
+};
+
+static const struct ad9467_chip_info ad9652_chip_tbl = {
+	.name = "ad9652",
+	.id = CHIPID_AD9652,
+	.max_rate = 310000000UL,
+	.scale_table = ad9652_scale_table,
+	.num_scales = ARRAY_SIZE(ad9652_scale_table),
+	.channels = ad9652_channels,
+	.num_channels = ARRAY_SIZE(ad9652_channels),
+	.test_points = AD9647_MAX_TEST_POINTS,
+	.vref_mask = AD9652_REG_VREF_MASK,
+	.has_dco = true,
+};
+
 static int ad9467_get_scale(struct ad9467_state *st, int *val, int *val2)
 {
 	const struct ad9467_chip_info *info = st->info;
@@ -948,6 +1043,9 @@ static const struct of_device_id ad9467_of_match[] = {
 	{ .compatible = "adi,ad9265", .data = &ad9265_chip_tbl, },
 	{ .compatible = "adi,ad9434", .data = &ad9434_chip_tbl, },
 	{ .compatible = "adi,ad9467", .data = &ad9467_chip_tbl, },
+	{ .compatible = "adi,ad9643", .data = &ad9643_chip_tbl, },
+	{ .compatible = "adi,ad9649", .data = &ad9649_chip_tbl, },
+	{ .compatible = "adi,ad9652", .data = &ad9652_chip_tbl, },
 	{}
 };
 MODULE_DEVICE_TABLE(of, ad9467_of_match);
@@ -956,6 +1054,9 @@ static const struct spi_device_id ad9467_ids[] = {
 	{ "ad9265", (kernel_ulong_t)&ad9265_chip_tbl },
 	{ "ad9434", (kernel_ulong_t)&ad9434_chip_tbl },
 	{ "ad9467", (kernel_ulong_t)&ad9467_chip_tbl },
+	{ "ad9643", (kernel_ulong_t)&ad9643_chip_tbl },
+	{ "ad9649", (kernel_ulong_t)&ad9649_chip_tbl, },
+	{ "ad9652", (kernel_ulong_t)&ad9652_chip_tbl, },
 	{}
 };
 MODULE_DEVICE_TABLE(spi, ad9467_ids);

-- 
2.45.2


