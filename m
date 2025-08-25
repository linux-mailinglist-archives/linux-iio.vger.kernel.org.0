Return-Path: <linux-iio+bounces-23294-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7656B35788
	for <lists+linux-iio@lfdr.de>; Tue, 26 Aug 2025 10:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E65B1201EA4
	for <lists+linux-iio@lfdr.de>; Tue, 26 Aug 2025 08:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B3702FF65E;
	Tue, 26 Aug 2025 08:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="MRcR28cs"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F412FD1D6;
	Tue, 26 Aug 2025 08:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756197960; cv=none; b=XqoIo73gG4hnVrn3wzu28753M2hO+YbMckFzgAfnniXhneaylofbjbPfGM2JDtbb1OPxbZcUqFbHV2kxMIOfX5P89v5eMZaw0nAzf0ZWnogsXiCJRc4Z7lu1Womus8vQsH/w4rLCWSNlXZXGHOOC210FlDmxbrjQeBRQYHokm7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756197960; c=relaxed/simple;
	bh=3NEeDNwiJqVrtgcoh4PIn7Mb1+1AKb7QtVjM5AAf0Hk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IyVwcDLOSw1uFzCXK2ltWy6fifyKlQ+SupCXIcXgwQJqAihEaqxoDqi0bo/OToWHjcZHLSixsmjvceGAh8jLke0aPwzXbgTQVgI5nXpgoIG766sgILHqkJsA7faulkUXVrzP2vwK61pJlJobSUoTZk/PrPwyy1KCPL2EGulHDLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=MRcR28cs; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57Q5ufxD018205;
	Tue, 26 Aug 2025 04:45:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=6YfAp
	0oyHOxTayA8Qtha7zyXz/BWXsniu0kSjUthhUQ=; b=MRcR28css5XiaS9I8PeKz
	LunweKJtVzd4K0351DVcht8Zt7zzxYzZ8+814rYCJTlcpH0gkvc/MJTKBS44Hy9Q
	5Sp4JTmVxfK+v4xQD2cPv3kvjxGXqLiSFOUvCkQ2Ak+qeJNd09QBylY42hVuMaqc
	boaoNwXXGwSBGkTnXIrb7L0zaAFOC9eVfAt5Lq/ZBd33mOA2rBt6kYSalPNQbXNf
	0yFfGM1LQKOhRslBDrFOMFif1V+Bjx5CYNkdpb7Gr9gnFjo8G+mGYMR5HpXN6RVh
	KwSRajHZ/LY8hq6NyOkiAQNP4HASWrEbb8/IEfmtUMTtlkdGLpt88ZvS48dhzXzx
	g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 48rmafnwjf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Aug 2025 04:45:43 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 57Q8jgl8045834
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 26 Aug 2025 04:45:42 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 26 Aug
 2025 04:45:42 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 26 Aug 2025 04:45:42 -0400
Received: from IRISTEIU-L01.ad.analog.com (IRISTEIU-L01.ad.analog.com [10.48.65.166])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 57Q8jHnx015527;
	Tue, 26 Aug 2025 04:45:37 -0400
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
CC: Ioana Risteiu <Ioana.Risteiu@analog.com>,
        Andy Shevchenko
	<andriy.shevchenko@intel.com>
Subject: [PATCH v6 3/4] iio: adc: extract setup function without backend
Date: Tue, 26 Aug 2025 01:13:51 +0300
Message-ID: <20250825221355.6214-4-Ioana.Risteiu@analog.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250825221355.6214-1-Ioana.Risteiu@analog.com>
References: <20250825221355.6214-1-Ioana.Risteiu@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI1MDA3NSBTYWx0ZWRfX3zmYxq1dwTt7
 kVMrtj6ciYLy3n7GNnJma4sb5H9jaQa0DUQNBJ3RPTmVHryGDkF7jIsz+ki5vHDp/hZqbt0ZPMl
 EmMYYaGUvzHtWGsoQ7BM+/qe6x28e+3jSd+p2q3Bkcr+90EZqEzMMumYpX4EEVTpKahDtnBY7IC
 TPH0FHHwENgAbPaUpEo4fkeEGMSStHdHwephMJX5zccSTUnJZ4wAFFKgKxUs7rQE9y3pR0ou0Ce
 4TMSKhEiD2LEcII3kByapEEibpDslAvVK1dKMhsuKOi/bCLzTlwaaT6xAaV2dTWzjf5z+DD+nQV
 n+o/SV2XZgEVy1L9KTw2kBhw6jkPEHUpmfkdJRh7epSfa3yCsIaQH66OrVfSJM0FNlYRi1PzWnv
 9DPzsjE5
X-Proofpoint-ORIG-GUID: BKv0JnBD4Mj-n8azbCxWryBA9LbGMPIp
X-Proofpoint-GUID: BKv0JnBD4Mj-n8azbCxWryBA9LbGMPIp
X-Authority-Analysis: v=2.4 cv=AoXu3P9P c=1 sm=1 tr=0 ts=68ad7437 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=2OwXVqhp2XgA:10 a=QyXUC8HyAAAA:8 a=gAnH3GRIAAAA:8 a=e6B03PNIoHuVPIBsO9AA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 adultscore=0 bulkscore=0 phishscore=0 impostorscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508250075

Refactor probe function by moving the initialization specific to
communication without iio-backend into a separate setup function.

The purpose of this modification is better code organization. No
functional changes intended.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Ioana Risteiu <Ioana.Risteiu@analog.com>
---
changes in v6:
 - move channels and num_channels assignment together in ad7779_setup_without_backend()
 drivers/iio/adc/ad7779.c | 86 +++++++++++++++++++++-------------------
 1 file changed, 46 insertions(+), 40 deletions(-)

diff --git a/drivers/iio/adc/ad7779.c b/drivers/iio/adc/ad7779.c
index 845adc510239..4e6fa6370593 100644
--- a/drivers/iio/adc/ad7779.c
+++ b/drivers/iio/adc/ad7779.c
@@ -752,6 +752,51 @@ static int ad7779_conf(struct ad7779_state *st, struct gpio_desc *start_gpio)
 	return 0;
 }
 
+static int ad7779_setup_without_backend(struct ad7779_state *st, struct iio_dev *indio_dev)
+{
+	int ret;
+	struct device *dev = &st->spi->dev;
+
+	indio_dev->info = &ad7779_info;
+	indio_dev->channels = st->chip_info->channels;
+	indio_dev->num_channels = ARRAY_SIZE(ad7779_channels);
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
+				     st->spi->irq);
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
+				     AD7779_DCLK_CLK_DIV_MSK,
+				     FIELD_PREP(AD7779_DCLK_CLK_DIV_MSK, 7));
+}
+
 static int ad7779_probe(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev;
@@ -760,9 +805,6 @@ static int ad7779_probe(struct spi_device *spi)
 	struct device *dev = &spi->dev;
 	int ret = -EINVAL;
 
-	if (!spi->irq)
-		return dev_err_probe(dev, ret, "DRDY irq not present\n");
-
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
 	if (!indio_dev)
 		return -ENOMEM;
@@ -804,45 +846,9 @@ static int ad7779_probe(struct spi_device *spi)
 		return ret;
 
 	indio_dev->name = st->chip_info->name;
-	indio_dev->info = &ad7779_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
-	indio_dev->channels = st->chip_info->channels;
-	indio_dev->num_channels = ARRAY_SIZE(ad7779_channels);
-
-	st->trig = devm_iio_trigger_alloc(dev, "%s-dev%d", indio_dev->name,
-					  iio_device_id(indio_dev));
-	if (!st->trig)
-		return -ENOMEM;
 
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
-
-	ret = ad7779_spi_write_mask(st, AD7779_REG_DOUT_FORMAT,
-				    AD7779_DCLK_CLK_DIV_MSK,
-				    FIELD_PREP(AD7779_DCLK_CLK_DIV_MSK, 7));
+	ret = ad7779_setup_without_backend(st, indio_dev);
 	if (ret)
 		return ret;
 
-- 
2.47.2


