Return-Path: <linux-iio+bounces-12388-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A399D1883
	for <lists+linux-iio@lfdr.de>; Mon, 18 Nov 2024 19:54:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B42EE28245D
	for <lists+linux-iio@lfdr.de>; Mon, 18 Nov 2024 18:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4721E1048;
	Mon, 18 Nov 2024 18:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="hqc1S3We"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5411B1494B0;
	Mon, 18 Nov 2024 18:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731956067; cv=none; b=u87Y0KiHGAx4A5oVEXoQR+QirSpKi7IEdlzBcsgYy26soLE5SM1i+C43a7aEPJDyRAJYByIrk/omaQWlSckU/tpODqlBoo4rh4/nJ8Rv0JIES6BWcG6xrH0c8NV5EoeeyExvtSf64apPkj/VI5TZpwlV27S+CGZHQ1yf0Cbty7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731956067; c=relaxed/simple;
	bh=/H1PV/BMvbHKTb5SX6XHfRjbNzmVKHPWMMhdfwTSBwY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q2BRYGcOp3BjGPyBMcVqpl1/T2dq8plGcYiMrSJvPIDpm3wdRZOcS47ZqenzTT03Mt3j9uT52T/EaL+xzv0ap4N7NyyfdAj9VH5YlDiHeKHg219fIHQQgH5LHGAbKiZsTStMhVEk6W+QOeyQHpspXujdXWii81PX/gmx/ayTpug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=hqc1S3We; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AIEnlBB020192;
	Mon, 18 Nov 2024 13:54:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=tOpXV
	wzlbLBsoHKMz1ze+XGt9cfn8hPt2ymMX5qf7WU=; b=hqc1S3WellmQjnzsF5NSX
	DA/wqCt2R9+1iUC9encRlYpjBJhddWWYlZEcMTKCw06JzLUaDkm99qrbtnju8Gst
	9WgQTFnEEFi+ZMuQqAA8f9jpIyFOIqyzdl0Eaeovick2qPlDF6xMQ5JD5gw2FFXg
	l6GDhuBAgVtiwlb6zDIJAr1JsO63OT3bdm76hH4rI0YiV5JqGZ2eXWVuQHlzFooD
	3EYjkcVOQMjt1ZG99ekgRXPGKezSFyNu6I2YAcFftaCKYAyOqDH2aoWqH0oJ9yyg
	ALmwFR5vIzs4ARTRNJzISIfY1NblNtVZlM33eSAOYe6giojKHh4nd58HgOFbAg3+
	Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 43025m2fxw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Nov 2024 13:54:10 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 4AIIs96k064064
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 18 Nov 2024 13:54:09 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Mon, 18 Nov
 2024 13:54:09 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 18 Nov 2024 13:54:09 -0500
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4AIIrsd8010391;
	Mon, 18 Nov 2024 13:53:56 -0500
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <marcelo.schmitt@analog.com>, <jic23@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <marcelo.schmitt1@gmail.com>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, David Lechner <dlechner@baylibre.com>
Subject: [PATCH v2 4/4] iio: adc: ad4000: Add support for PulSAR devices
Date: Mon, 18 Nov 2024 15:53:52 -0300
Message-ID: <c56511e7629c3eaddefac771aeb34306fcf0d5a7.1731953012.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1731953012.git.marcelo.schmitt@analog.com>
References: <cover.1731953012.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: 25OR0Z8ag8UZ-ZvusLGtbjiHPEfKBRTu
X-Proofpoint-ORIG-GUID: 25OR0Z8ag8UZ-ZvusLGtbjiHPEfKBRTu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 bulkscore=0 mlxlogscore=999 lowpriorityscore=0
 clxscore=1015 malwarescore=0 impostorscore=0 adultscore=0 spamscore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411180155

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
 drivers/iio/adc/ad4000.c | 141 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 141 insertions(+)

diff --git a/drivers/iio/adc/ad4000.c b/drivers/iio/adc/ad4000.c
index 3fa12bcf73aa..38cd98adda8a 100644
--- a/drivers/iio/adc/ad4000.c
+++ b/drivers/iio/adc/ad4000.c
@@ -138,6 +138,27 @@ static const struct ad4000_time_spec ad4000_t_spec = AD4000_TSPEC(320, 60);
 /* AD4020, AD4021, AD4022 */
 static const struct ad4000_time_spec ad4020_t_spec = AD4000_TSPEC(350, 60);
 
+/* AD7983, AD7984 */
+static const struct ad4000_time_spec ad7983_t_spec = AD4000_TSPEC(500, 0);
+
+/* AD7980, AD7982 */
+static const struct ad4000_time_spec ad7980_t_spec = AD4000_TSPEC(800, 0);
+
+/* AD7946, AD7686, AD7688, AD7988-5, AD7693 */
+static const struct ad4000_time_spec ad7686_t_spec = AD4000_TSPEC(1600, 0);
+
+/* AD7690 */
+static const struct ad4000_time_spec ad7690_t_spec = AD4000_TSPEC(2100, 0);
+
+/* AD7942, AD7685, AD7687 */
+static const struct ad4000_time_spec ad7687_t_spec = AD4000_TSPEC(3200, 0);
+
+/* AD7691 */
+static const struct ad4000_time_spec ad7691_t_spec = AD4000_TSPEC(3700, 0);
+
+/* AD7988-1 */
+static const struct ad4000_time_spec ad7988_1_t_spec = AD4000_TSPEC(9500, 0);
+
 struct ad4000_chip_info {
 	const char *dev_name;
 	struct iio_chan_spec chan_spec[2];
@@ -260,6 +281,96 @@ static const struct ad4000_chip_info adaq4003_chip_info = {
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
@@ -733,6 +844,21 @@ static const struct spi_device_id ad4000_id[] = {
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
@@ -754,6 +880,21 @@ static const struct of_device_id ad4000_of_match[] = {
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


