Return-Path: <linux-iio+bounces-22920-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7026B2A48A
	for <lists+linux-iio@lfdr.de>; Mon, 18 Aug 2025 15:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 968D81B25312
	for <lists+linux-iio@lfdr.de>; Mon, 18 Aug 2025 13:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B30320CDB;
	Mon, 18 Aug 2025 13:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="rfLcrDwo"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946D3320CD2;
	Mon, 18 Aug 2025 13:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755522876; cv=none; b=pBENIIimFo/ei43I5Ctv4FsRMGVoiHyW8v8Y3lofqJAFTSPDPvxiNPqlpUnJwBV2ZVANsSbUaKIaMQcfAJ9CdIQm2yXuZ05+YQctr1JwJ5WyzCHiq/RNTahO895a6JgtGEph7/kHnNTWOF0VB2f9ByZ1wWWQK4TgioMZk/8I8x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755522876; c=relaxed/simple;
	bh=gC6Rovao3McQkrifXwGder8mGO5i4dOLuXjWzLzTizw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WCLwCgZ+oCGCpuARIstmDj3NFwQ0cqs+XYnWJ4SZDXVtRZnETCOews3ywaM7dSxOWzOCjU3Rklt1dVqXIZSBY0j1Lyu8Hgelc9eXYZOiqCP8ifNNjH5bHLSX4ci1MSv4r74AVh+U08qRAmo6Ag/c+KWtgvkctLcdyi0N5jJPzdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=rfLcrDwo; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57ICCKq3025582;
	Mon, 18 Aug 2025 09:14:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=3sVjo
	7kPN6V5vNQ77ewA5Q3PCJmVw2Vm/lqGCiwL9Xg=; b=rfLcrDwoREJk1hz/ZT5Dp
	QiqtHOCSluxbhxi457uiNnUSyyVv8gNL8SyJitlCm/yTTP2fznVylXsAQQhJQ5+N
	dnHBJS3eeQC/AFULugs5Zn6M5kr2ka2aHLEYvwjXFmRbBrHlny8rSeodd+KQeIK8
	B/FM0Nyh0HOAD7uxslss/6D3+uRNDN/Kch96vAyYLO/Y1tDiCULRuyruwYLTnpCn
	+tLmLznHcMx90tTiTXSv0bt5B58P+MH6sw9vC9fiAxM2carjO4BincWMPWyyJy6s
	EAAZeCqZvLyDetiDiMf1ijP6VMrsWVaFHlMKbbI8wzWVbhKVcETvlI6+zL37LekI
	g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 48kn0sv488-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Aug 2025 09:14:18 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 57IDEHtB011985
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 18 Aug 2025 09:14:17 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 18 Aug
 2025 09:14:17 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 18 Aug 2025 09:14:17 -0400
Received: from IRISTEIU-L01.ad.analog.com (IRISTEIU-L01.ad.analog.com [10.48.65.173])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 57IDD8Oo008451;
	Mon, 18 Aug 2025 09:14:10 -0400
From: Ioana Risteiu <Ioana.Risteiu@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David
 Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Ramona Nechita <ramona.nechita@analog.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Ioana Risteiu <Ioana.Risteiu@analog.com>
Subject: [PATCH v3 3/4] iio: adc: extract setup function without backend
Date: Mon, 18 Aug 2025 16:12:49 +0300
Message-ID: <20250818131253.8854-4-Ioana.Risteiu@analog.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250818131253.8854-1-Ioana.Risteiu@analog.com>
References: <20250818131253.8854-1-Ioana.Risteiu@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: mNRIKtwdxZ3NofiI9UQxE_fteBCxwp28
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE3MDE5OSBTYWx0ZWRfX0RmmE0vCAs5h
 tKqFTPQdRml0dUGl/66fDQzJ38eldpYIwKuPoRfO2WvvHO4wQpDqqsZ1uxSatBSAFNwid8lN3P7
 trnYFqxHcwoDpqigluWnI2Z9ozR3w/HjUaN0u5z3sK/rnZWEcHsDdanovvVD9TSnwe/88J8fNmm
 DU2GatwRdAgGimv73GDCJPhWrNf7lezmueh+81LypFu2yGDtfheiAm7donM2djk8v+1dF7OwBPQ
 X3K7P+NuuqnHuqzi9bfY5DdTTuk0+vOTalK1oxpvm7j2nQ1pVAtyzZjE9ugBSJS6FC3rIqEtAWF
 Xg9ihBV9TQasVEtnKYxopn4VXE48q/nacpQwXMTKF0B4djFGqgF2JiuJL0w8JBQZFeanvzPCWI5
 +U24dQp9
X-Authority-Analysis: v=2.4 cv=T6qMT+KQ c=1 sm=1 tr=0 ts=68a3272a cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=2OwXVqhp2XgA:10 a=gAnH3GRIAAAA:8 a=e6B03PNIoHuVPIBsO9AA:9
X-Proofpoint-ORIG-GUID: mNRIKtwdxZ3NofiI9UQxE_fteBCxwp28
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_05,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 spamscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508170199

Refactor probe function by moving the initialization specific to
communication without iio-backend into a separate setup function.

The purpose of this modification is better code organization. No
functional changes intended.

Signed-off-by: Ioana Risteiu <Ioana.Risteiu@analog.com>
---
 drivers/iio/adc/ad7779.c | 83 ++++++++++++++++++++++------------------
 1 file changed, 45 insertions(+), 38 deletions(-)

diff --git a/drivers/iio/adc/ad7779.c b/drivers/iio/adc/ad7779.c
index 845adc510239..f7e681c0e8c0 100644
--- a/drivers/iio/adc/ad7779.c
+++ b/drivers/iio/adc/ad7779.c
@@ -752,6 +752,50 @@ static int ad7779_conf(struct ad7779_state *st, struct gpio_desc *start_gpio)
 	return 0;
 }
 
+static int ad7779_setup_without_backend(struct ad7779_state *st, struct iio_dev *indio_dev)
+{
+	int ret;
+	struct device *dev = &st->spi->dev;
+
+	indio_dev->info = &ad7779_info;
+	indio_dev->channels = st->chip_info->channels;
+
+	st->trig = devm_iio_trigger_alloc(dev, "%s-dev%d", indio_dev->name,
+					  iio_device_id(indio_dev));
+	if (!st->trig)
+		return -ENOMEM;
+
+	st->trig->ops = &ad7779_trigger_ops;
+
+	iio_trigger_set_drvdata(st->trig, st);
+
+	ret = devm_request_irq(dev, st->spi->irq, iio_trigger_generic_data_rdy_poll,
+			       IRQF_ONESHOT | IRQF_NO_AUTOEN, indio_dev->name,
+			       st->trig);
+	if (ret)
+		return dev_err_probe(dev, ret, "request IRQ %d failed\n",
+					st->spi->irq);
+
+	ret = devm_iio_trigger_register(dev, st->trig);
+	if (ret)
+		return ret;
+
+	indio_dev->trig = iio_trigger_get(st->trig);
+
+	init_completion(&st->completion);
+
+	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
+					      &iio_pollfunc_store_time,
+					      &ad7779_trigger_handler,
+					      &ad7779_buffer_setup_ops);
+	if (ret)
+		return ret;
+
+	return ad7779_spi_write_mask(st, AD7779_REG_DOUT_FORMAT,
+				    AD7779_DCLK_CLK_DIV_MSK,
+				    FIELD_PREP(AD7779_DCLK_CLK_DIV_MSK, 7));
+}
+
 static int ad7779_probe(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev;
@@ -760,9 +804,6 @@ static int ad7779_probe(struct spi_device *spi)
 	struct device *dev = &spi->dev;
 	int ret = -EINVAL;
 
-	if (!spi->irq)
-		return dev_err_probe(dev, ret, "DRDY irq not present\n");
-
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
 	if (!indio_dev)
 		return -ENOMEM;
@@ -804,45 +845,11 @@ static int ad7779_probe(struct spi_device *spi)
 		return ret;
 
 	indio_dev->name = st->chip_info->name;
-	indio_dev->info = &ad7779_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
-	indio_dev->channels = st->chip_info->channels;
 	indio_dev->num_channels = ARRAY_SIZE(ad7779_channels);
 
-	st->trig = devm_iio_trigger_alloc(dev, "%s-dev%d", indio_dev->name,
-					  iio_device_id(indio_dev));
-	if (!st->trig)
-		return -ENOMEM;
-
-	st->trig->ops = &ad7779_trigger_ops;
-
-	iio_trigger_set_drvdata(st->trig, st);
-
-	ret = devm_request_irq(dev, spi->irq, iio_trigger_generic_data_rdy_poll,
-			       IRQF_ONESHOT | IRQF_NO_AUTOEN, indio_dev->name,
-			       st->trig);
-	if (ret)
-		return dev_err_probe(dev, ret, "request IRQ %d failed\n",
-				     st->spi->irq);
-
-	ret = devm_iio_trigger_register(dev, st->trig);
-	if (ret)
-		return ret;
-
-	indio_dev->trig = iio_trigger_get(st->trig);
-
-	init_completion(&st->completion);
-
-	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
-					      &iio_pollfunc_store_time,
-					      &ad7779_trigger_handler,
-					      &ad7779_buffer_setup_ops);
-	if (ret)
-		return ret;
+	ret = ad7779_setup_without_backend(st, indio_dev);
 
-	ret = ad7779_spi_write_mask(st, AD7779_REG_DOUT_FORMAT,
-				    AD7779_DCLK_CLK_DIV_MSK,
-				    FIELD_PREP(AD7779_DCLK_CLK_DIV_MSK, 7));
 	if (ret)
 		return ret;
 
-- 
2.47.2


