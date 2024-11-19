Return-Path: <linux-iio+bounces-12405-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D656D9D2695
	for <lists+linux-iio@lfdr.de>; Tue, 19 Nov 2024 14:12:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACAACB30555
	for <lists+linux-iio@lfdr.de>; Tue, 19 Nov 2024 12:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 378BF1CC8A7;
	Tue, 19 Nov 2024 12:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="QoROGbph"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA471CC88D;
	Tue, 19 Nov 2024 12:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732020915; cv=none; b=T42BsvTJc6IigIuFZlbArceOVXRALHxtVnnxZ4y9KoOrOTQOFKhI9f32L9yqKHZNaqHWhXYEPok29KaL5fn957UJ9FqZIV8o5mCMjHTUbdSZ9NUMID/O4FAKuRECd3JoJJLXVma5cAMWzWRamqBF3ASiYJl5ephX1MTwZFxu0Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732020915; c=relaxed/simple;
	bh=UG0j9jP4clEqcDpOVurpM+p4zKueeealkqG18mOI5Fc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SMT1lJYeS9AYJ5zFiwZ2na7F2gAyKRnPtriJMkTPsGmq7p6xTrtkwzUkUKGk7Jnijab8dlTnHaLqWhC49lbITmXcRqkQuS+5neDB5uGtUYQVcvldkVI2Wf8tdjle6BevQyB2OR7lfuG04rttAvOWdM8MBCmiwitqEARFvxXyfQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=QoROGbph; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJCMdrr020233;
	Tue, 19 Nov 2024 07:54:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=RtKzt
	Mk+WaSacvWDrWRl7PaF1p+LzKzHwlczSrtztto=; b=QoROGbph0BKCtfHUwC6eY
	iqDt8nZoEH4pskfq3DfslKhO69SOBXSu5LBWlJCk1R3MuJ7VkNmEteO3W2oPraxq
	1fjNIu/W+TzRLBIiz7rU8QnlfEm3PC80Z1buDOWsgdIPvBjzmWWwFx91f3SlBpLi
	9l8+vwZn0A3x+Ncz2ZWt/iwmy/gWuQNhCkxJcQnICKppNLzZln2kGDQShkbLe5+y
	A/PHcHVWBjTaykq/IXb7BoS246UWZiYVFoMmreCAjmAUV7yEQ875qxnNwvRO4GQh
	ccvg0/+pP1teRA4PyparOuae9RdQTu2XcCVWNfm4M2GSJ+mkxL2uoNF8JVJ4lZYC
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 43025m6hfb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 07:54:57 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 4AJCsuHl005035
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 19 Nov 2024 07:54:56 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Tue, 19 Nov
 2024 07:54:56 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 19 Nov 2024 07:54:56 -0500
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4AJCsfwN007335;
	Tue, 19 Nov 2024 07:54:43 -0500
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <marcelo.schmitt@analog.com>, <jic23@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <marcelo.schmitt1@gmail.com>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, David Lechner <dlechner@baylibre.com>
Subject: [PATCH v3 4/4] iio: adc: ad4000: Add support for PulSAR devices
Date: Tue, 19 Nov 2024 09:54:39 -0300
Message-ID: <d5f127acef28e02f1bd4af0d68bd06e75a98dfca.1732020224.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1732020224.git.marcelo.schmitt@analog.com>
References: <cover.1732020224.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: AWhEhaKjXbNS37g5ITvXKU-vkOM1u5uz
X-Proofpoint-ORIG-GUID: AWhEhaKjXbNS37g5ITvXKU-vkOM1u5uz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 bulkscore=0 mlxlogscore=999 lowpriorityscore=0
 clxscore=1015 malwarescore=0 impostorscore=0 adultscore=0 spamscore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411190095

The ADI PulSAR series of single-channel devices comprises differential and
pseudo-differential ADCs that don't require any input data from the host
controller. By not requiring a data input line, PulSAR devices can operate
with a 3-wire only data bus in some setups.

The AD4000 series and the single-channel PulSAR series of devices have
similar SPI transfer specifications and wiring configurations.
Single-channel PulSAR devices are slower than AD4000 and don't have a
configuration register. That taken into account, single-channel PulSARs can
be supported by the ad4000 driver without any increase in code complexity.

Extend the AD4000 driver to also support single-channel PulSAR devices.

Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
 drivers/iio/adc/ad4000.c | 162 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 162 insertions(+)

diff --git a/drivers/iio/adc/ad4000.c b/drivers/iio/adc/ad4000.c
index c700d51b5637..74b8894d1a2a 100644
--- a/drivers/iio/adc/ad4000.c
+++ b/drivers/iio/adc/ad4000.c
@@ -138,6 +138,48 @@ static const struct ad4000_time_spec ad4020_t_spec = {
 	.t_quiet2_ns = 60,
 };
 
+/* AD7983, AD7984 */
+static const struct ad4000_time_spec ad7983_t_spec = {
+	.t_conv_ns = 500,
+	.t_quiet2_ns = 0,
+};
+
+/* AD7980, AD7982 */
+static const struct ad4000_time_spec ad7980_t_spec = {
+	.t_conv_ns = 800,
+	.t_quiet2_ns = 0,
+};
+
+/* AD7946, AD7686, AD7688, AD7988-5, AD7693 */
+static const struct ad4000_time_spec ad7686_t_spec = {
+	.t_conv_ns = 1600,
+	.t_quiet2_ns = 0,
+};
+
+/* AD7690 */
+static const struct ad4000_time_spec ad7690_t_spec = {
+	.t_conv_ns = 2100,
+	.t_quiet2_ns = 0,
+};
+
+/* AD7942, AD7685, AD7687 */
+static const struct ad4000_time_spec ad7687_t_spec = {
+	.t_conv_ns = 3200,
+	.t_quiet2_ns = 0,
+};
+
+/* AD7691 */
+static const struct ad4000_time_spec ad7691_t_spec = {
+	.t_conv_ns = 3700,
+	.t_quiet2_ns = 0,
+};
+
+/* AD7988-1 */
+static const struct ad4000_time_spec ad7988_1_t_spec = {
+	.t_conv_ns = 9500,
+	.t_quiet2_ns = 0,
+};
+
 struct ad4000_chip_info {
 	const char *dev_name;
 	struct iio_chan_spec chan_spec[2];
@@ -260,6 +302,96 @@ static const struct ad4000_chip_info adaq4003_chip_info = {
 	.has_hardware_gain = true,
 };
 
+static const struct ad4000_chip_info ad7685_chip_info = {
+	.dev_name = "ad7685",
+	.chan_spec = AD4000_PSEUDO_DIFF_CHANNELS('u', 16, 0),
+	.time_spec = &ad7687_t_spec,
+};
+
+static const struct ad4000_chip_info ad7686_chip_info = {
+	.dev_name = "ad7686",
+	.chan_spec = AD4000_PSEUDO_DIFF_CHANNELS('u', 16, 0),
+	.time_spec = &ad7686_t_spec,
+};
+
+static const struct ad4000_chip_info ad7687_chip_info = {
+	.dev_name = "ad7687",
+	.chan_spec = AD4000_DIFF_CHANNELS('s', 16, 0),
+	.time_spec = &ad7687_t_spec,
+};
+
+static const struct ad4000_chip_info ad7688_chip_info = {
+	.dev_name = "ad7688",
+	.chan_spec = AD4000_DIFF_CHANNELS('s', 16, 0),
+	.time_spec = &ad7686_t_spec,
+};
+
+static const struct ad4000_chip_info ad7690_chip_info = {
+	.dev_name = "ad7690",
+	.chan_spec = AD4000_DIFF_CHANNELS('s', 18, 0),
+	.time_spec = &ad7690_t_spec,
+};
+
+static const struct ad4000_chip_info ad7691_chip_info = {
+	.dev_name = "ad7691",
+	.chan_spec = AD4000_DIFF_CHANNELS('s', 18, 0),
+	.time_spec = &ad7691_t_spec,
+};
+
+static const struct ad4000_chip_info ad7693_chip_info = {
+	.dev_name = "ad7693",
+	.chan_spec = AD4000_DIFF_CHANNELS('s', 16, 0),
+	.time_spec = &ad7686_t_spec,
+};
+
+static const struct ad4000_chip_info ad7942_chip_info = {
+	.dev_name = "ad7942",
+	.chan_spec = AD4000_PSEUDO_DIFF_CHANNELS('u', 14, 0),
+	.time_spec = &ad7687_t_spec,
+};
+
+static const struct ad4000_chip_info ad7946_chip_info = {
+	.dev_name = "ad7946",
+	.chan_spec = AD4000_PSEUDO_DIFF_CHANNELS('u', 14, 0),
+	.time_spec = &ad7686_t_spec,
+};
+
+static const struct ad4000_chip_info ad7980_chip_info = {
+	.dev_name = "ad7980",
+	.chan_spec = AD4000_PSEUDO_DIFF_CHANNELS('u', 16, 0),
+	.time_spec = &ad7980_t_spec,
+};
+
+static const struct ad4000_chip_info ad7982_chip_info = {
+	.dev_name = "ad7982",
+	.chan_spec = AD4000_DIFF_CHANNELS('s', 18, 0),
+	.time_spec = &ad7980_t_spec,
+};
+
+static const struct ad4000_chip_info ad7983_chip_info = {
+	.dev_name = "ad7983",
+	.chan_spec = AD4000_PSEUDO_DIFF_CHANNELS('u', 16, 0),
+	.time_spec = &ad7983_t_spec,
+};
+
+static const struct ad4000_chip_info ad7984_chip_info = {
+	.dev_name = "ad7984",
+	.chan_spec = AD4000_DIFF_CHANNELS('s', 18, 0),
+	.time_spec = &ad7983_t_spec,
+};
+
+static const struct ad4000_chip_info ad7988_1_chip_info = {
+	.dev_name = "ad7988-1",
+	.chan_spec = AD4000_PSEUDO_DIFF_CHANNELS('u', 16, 0),
+	.time_spec = &ad7988_1_t_spec,
+};
+
+static const struct ad4000_chip_info ad7988_5_chip_info = {
+	.dev_name = "ad7988-5",
+	.chan_spec = AD4000_PSEUDO_DIFF_CHANNELS('u', 16, 0),
+	.time_spec = &ad7686_t_spec,
+};
+
 struct ad4000_state {
 	struct spi_device *spi;
 	struct gpio_desc *cnv_gpio;
@@ -733,6 +865,21 @@ static const struct spi_device_id ad4000_id[] = {
 	{ "ad4022", (kernel_ulong_t)&ad4022_chip_info },
 	{ "adaq4001", (kernel_ulong_t)&adaq4001_chip_info },
 	{ "adaq4003", (kernel_ulong_t)&adaq4003_chip_info },
+	{ "ad7685", (kernel_ulong_t)&ad7685_chip_info },
+	{ "ad7686", (kernel_ulong_t)&ad7686_chip_info },
+	{ "ad7687", (kernel_ulong_t)&ad7687_chip_info },
+	{ "ad7688", (kernel_ulong_t)&ad7688_chip_info },
+	{ "ad7690", (kernel_ulong_t)&ad7690_chip_info },
+	{ "ad7691", (kernel_ulong_t)&ad7691_chip_info },
+	{ "ad7693", (kernel_ulong_t)&ad7693_chip_info },
+	{ "ad7942", (kernel_ulong_t)&ad7942_chip_info },
+	{ "ad7946", (kernel_ulong_t)&ad7946_chip_info },
+	{ "ad7980", (kernel_ulong_t)&ad7980_chip_info },
+	{ "ad7982", (kernel_ulong_t)&ad7982_chip_info },
+	{ "ad7983", (kernel_ulong_t)&ad7983_chip_info },
+	{ "ad7984", (kernel_ulong_t)&ad7984_chip_info },
+	{ "ad7988-1", (kernel_ulong_t)&ad7988_1_chip_info },
+	{ "ad7988-5", (kernel_ulong_t)&ad7988_5_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, ad4000_id);
@@ -754,6 +901,21 @@ static const struct of_device_id ad4000_of_match[] = {
 	{ .compatible = "adi,ad4022", .data = &ad4022_chip_info },
 	{ .compatible = "adi,adaq4001", .data = &adaq4001_chip_info },
 	{ .compatible = "adi,adaq4003", .data = &adaq4003_chip_info },
+	{ .compatible = "adi,ad7685", .data = &ad7685_chip_info },
+	{ .compatible = "adi,ad7686", .data = &ad7686_chip_info },
+	{ .compatible = "adi,ad7687", .data = &ad7687_chip_info },
+	{ .compatible = "adi,ad7688", .data = &ad7688_chip_info },
+	{ .compatible = "adi,ad7690", .data = &ad7690_chip_info },
+	{ .compatible = "adi,ad7691", .data = &ad7691_chip_info },
+	{ .compatible = "adi,ad7693", .data = &ad7693_chip_info },
+	{ .compatible = "adi,ad7942", .data = &ad7942_chip_info },
+	{ .compatible = "adi,ad7946", .data = &ad7946_chip_info },
+	{ .compatible = "adi,ad7980", .data = &ad7980_chip_info },
+	{ .compatible = "adi,ad7982", .data = &ad7982_chip_info },
+	{ .compatible = "adi,ad7983", .data = &ad7983_chip_info },
+	{ .compatible = "adi,ad7984", .data = &ad7984_chip_info },
+	{ .compatible = "adi,ad7988-1", .data = &ad7988_1_chip_info },
+	{ .compatible = "adi,ad7988-5", .data = &ad7988_5_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ad4000_of_match);
-- 
2.45.2


