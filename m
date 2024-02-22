Return-Path: <linux-iio+bounces-2901-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 212E385F8DD
	for <lists+linux-iio@lfdr.de>; Thu, 22 Feb 2024 13:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41DFB1C24B3D
	for <lists+linux-iio@lfdr.de>; Thu, 22 Feb 2024 12:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E23D131E3D;
	Thu, 22 Feb 2024 12:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="KMX09TNk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DFA12FF94;
	Thu, 22 Feb 2024 12:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708606394; cv=none; b=C8vfBYC5vAff1Me0SqSxM0I6ZYpPB4exa3KntoRtqvL7ha08GPrhJVRr5k/sD+DAPr6+ywZRB44lf+hRDbtZEOMkSaNLe/1MsDUyi5t83AAcK+VJSHMGCf0qUBGYc7ei/nvC8LpOMOaEUubIHKsSgrPamhgfgT5faj7YVP8zOGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708606394; c=relaxed/simple;
	bh=LwEIca91rqeRRZZ44qei8F/5sbBn5656SlWnEtYijoo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=nCTD1UTbBoWYDcO0NpAEx/9dV5luABfVPXOK5rLri+uz4gt1in8DkPpaKdfLiAeeOYzEvbDNNOcvVlENX6CVxnDrXzKIgR4P/YGvFUdygqEONBCw56Tp98bIvEEaRaq16n3aYhg9fJsxYngc8Kg7bBmvrM3WoCfCk6OWvfOj2jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=KMX09TNk; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41M9IUw4030381;
	Thu, 22 Feb 2024 07:52:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=DKIM; bh=GxFUx0q2HfPn52sbsbR+ryguODdrJcJ8S2Inz5zweJ0=; b=
	KMX09TNkixrFYLm+74+UpUL3J4ky67+wQndsZRyUr2c/g3fi7ljTaewOBvE7U6H7
	4S5f7d+z/FTPeKuGR4GCuH2+qytYJfkHcVPSgAqBbJpuONQPPo3hoE5z95aujVK/
	Kbd66sSfEITdHet5qj+kkhKvDaQ4vbbDXdtiBIM9zC56Z/gCF7Qn0kmP0kRiXSax
	8idYAW5cStb931fzq0N3GvRlAE0RihxRpdTsMV4pLDSraGcexra0/TBvCT5nduGJ
	wZvhqoWS5egJMjeKqYpwsyuhsFpWx1pFTi8AZS7ksQr/axYq1cjRwrcALKV90x80
	8LDHMU7jSAQwxdXvTbBAqA==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3wd21ggpj7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 07:52:47 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 41MCqkif047603
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 22 Feb 2024 07:52:46 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Thu, 22 Feb
 2024 07:52:45 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 22 Feb 2024 07:52:45 -0500
Received: from [127.0.0.1] ([10.44.3.55])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 41MCqTFB003844;
	Thu, 22 Feb 2024 07:52:40 -0500
From: Nuno Sa <nuno.sa@analog.com>
Date: Thu, 22 Feb 2024 13:55:55 +0100
Subject: [PATCH 4/6] iio: temperature: ltc2983: explicitly set the name in
 chip_info
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240222-ltc2983-misc-improv-v1-4-cf7d4457e98c@analog.com>
References: <20240222-ltc2983-misc-improv-v1-0-cf7d4457e98c@analog.com>
In-Reply-To: <20240222-ltc2983-misc-improv-v1-0-cf7d4457e98c@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708606552; l=3302;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=LwEIca91rqeRRZZ44qei8F/5sbBn5656SlWnEtYijoo=;
 b=vNMsXwg9SRRSttmByciv4dDBR/2YNJlGNd4HWmfKmZSAZ0fAjsq+18zNfA9JOmW/TsH+76LQ0
 nRC3pV9I6ICAAIFhHqimNfDcMSOI2MkM+4jbfvzpCFDKg3ZeLjboDD9
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: IplNDVTQleyhDLj5WFHGia6uUuvlYQd-
X-Proofpoint-ORIG-GUID: IplNDVTQleyhDLj5WFHGia6uUuvlYQd-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_09,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 adultscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 mlxlogscore=758 mlxscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402220101

Getting the part name with 'spi_get_device_id(spi)->name' is not a very
good pattern. Hence, explicitly add the name in the struct chip_info and
use that instead.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/temperature/ltc2983.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/temperature/ltc2983.c b/drivers/iio/temperature/ltc2983.c
index 4b096aa3fbd8..9bd53e102ab3 100644
--- a/drivers/iio/temperature/ltc2983.c
+++ b/drivers/iio/temperature/ltc2983.c
@@ -209,6 +209,7 @@ enum {
 		container_of(_sensor, struct ltc2983_temp, sensor)
 
 struct ltc2983_chip_info {
+	const char *name;
 	unsigned int max_channels_nr;
 	bool has_temp;
 	bool has_eeprom;
@@ -1613,7 +1614,6 @@ static int ltc2983_probe(struct spi_device *spi)
 	struct ltc2983_data *st;
 	struct iio_dev *indio_dev;
 	struct gpio_desc *gpio;
-	const char *name = spi_get_device_id(spi)->name;
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
@@ -1662,7 +1662,7 @@ static int ltc2983_probe(struct spi_device *spi)
 		return ret;
 
 	ret = devm_request_irq(dev, spi->irq, ltc2983_irq_handler,
-			       IRQF_TRIGGER_RISING, name, st);
+			       IRQF_TRIGGER_RISING, st->info->name, st);
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to request an irq, %d",
 				     ret);
@@ -1676,7 +1676,7 @@ static int ltc2983_probe(struct spi_device *spi)
 			return ret;
 	}
 
-	indio_dev->name = name;
+	indio_dev->name = st->info->name;
 	indio_dev->num_channels = st->iio_channels;
 	indio_dev->channels = st->iio_chan;
 	indio_dev->modes = INDIO_DIRECT_MODE;
@@ -1707,15 +1707,25 @@ static DEFINE_SIMPLE_DEV_PM_OPS(ltc2983_pm_ops, ltc2983_suspend,
 				ltc2983_resume);
 
 static const struct ltc2983_chip_info ltc2983_chip_info_data = {
+	.name = "ltc2983",
 	.max_channels_nr = 20,
 };
 
 static const struct ltc2983_chip_info ltc2984_chip_info_data = {
+	.name = "ltc2984",
 	.max_channels_nr = 20,
 	.has_eeprom = true,
 };
 
 static const struct ltc2983_chip_info ltc2986_chip_info_data = {
+	.name = "ltc2986",
+	.max_channels_nr = 10,
+	.has_temp = true,
+	.has_eeprom = true,
+};
+
+static const struct ltc2983_chip_info ltm2985_chip_info_data = {
+	.name = "ltm2985",
 	.max_channels_nr = 10,
 	.has_temp = true,
 	.has_eeprom = true,
@@ -1725,7 +1735,7 @@ static const struct spi_device_id ltc2983_id_table[] = {
 	{ "ltc2983", (kernel_ulong_t)&ltc2983_chip_info_data },
 	{ "ltc2984", (kernel_ulong_t)&ltc2984_chip_info_data },
 	{ "ltc2986", (kernel_ulong_t)&ltc2986_chip_info_data },
-	{ "ltm2985", (kernel_ulong_t)&ltc2986_chip_info_data },
+	{ "ltm2985", (kernel_ulong_t)&ltm2985_chip_info_data },
 	{},
 };
 MODULE_DEVICE_TABLE(spi, ltc2983_id_table);
@@ -1734,7 +1744,7 @@ static const struct of_device_id ltc2983_of_match[] = {
 	{ .compatible = "adi,ltc2983", .data = &ltc2983_chip_info_data },
 	{ .compatible = "adi,ltc2984", .data = &ltc2984_chip_info_data },
 	{ .compatible = "adi,ltc2986", .data = &ltc2986_chip_info_data },
-	{ .compatible = "adi,ltm2985", .data = &ltc2986_chip_info_data },
+	{ .compatible = "adi,ltm2985", .data = &ltm2985_chip_info_data },
 	{},
 };
 MODULE_DEVICE_TABLE(of, ltc2983_of_match);

-- 
2.43.2


