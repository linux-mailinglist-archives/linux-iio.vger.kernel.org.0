Return-Path: <linux-iio+bounces-23210-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D303AB33D37
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 12:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97D1A7A3597
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 10:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654092E040B;
	Mon, 25 Aug 2025 10:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="efWgevYW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98A42E03F2;
	Mon, 25 Aug 2025 10:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756119177; cv=none; b=foFKFXKR3wmuUO3ADmMTMwFrOVPPoXjurVCDISiz3ZIocnzfGZaXLD+XCzSXQTemoniiS3J6Mgm3FqG6fIpe+sIAQZCIevJDmFLWa+hsZr8FRyUT4Kxwbd3YTCC0pmND2zwfkoRz4jNJn5YOyzxWd4Bp3upnGx712zVpty/VZEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756119177; c=relaxed/simple;
	bh=ppEOVBjtii7HdVVYjIzkJHuJSJViqIcKx9C7+sf9HUA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TTURpZMrSIC0cYg3xqOblRG5zBwOygsEuA453bvDXpcvl9MhoctoQseY/Y3RsyCQPN3uhf6FajrXN1vLjSaWuTqE0g0cyK0le8NuftMOI9seiLotBzEzgOFQpDbv7OPj5taZo1DYyLMoLS7GiFecuevwqy92wbH2mns+VSz4+dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=efWgevYW; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57P9kb6H007933;
	Mon, 25 Aug 2025 06:52:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=t6V/n
	cizTRkWgJ4SEQ8wwi4NP2i9xdX2CHvig99ucY0=; b=efWgevYWJLy2EVAAcya2G
	vEhBuRiGqdOk+mW4KU8iGd95lEeBAGkJXuxJWNNwv/Jn/kkdXSocBmzdwlOCBbmP
	5bAJtZ8NmcTrnYu034ZmybX1R79WTy7u8n0IUbwv4larhH5olSJp0HftTyNntokC
	/AxmIDR9A7szhvkZPoho9B67AwbzlU6QbTevn4nlUcWK6PN9HlCQ/xpDBfOO5OXy
	J6R8nJyi1dni6V0mWD2H+3saaVKcaq6BLMiBW+p0F+VlhL9DXqDTuJqMVf1ldAmK
	gxCsBnYZB2bqRCA8e4aWS0sOO0trVpr2g+olQzeqfyFka80tzY9bnoYOUc3ToPPF
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 48q7g40rec-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Aug 2025 06:52:41 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 57PAqeif006407
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 25 Aug 2025 06:52:40 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 25 Aug 2025 06:52:40 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 25 Aug 2025 06:52:40 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 25 Aug 2025 06:52:40 -0400
Received: from IRISTEIU-L01.ad.analog.com ([10.65.213.1])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 57PAq60A026383;
	Mon, 25 Aug 2025 06:52:33 -0400
From: Ioana Risteiu <Ioana.Risteiu@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "David
 Lechner" <dlechner@baylibre.com>,
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
Subject: [PATCH v5 3/4] iio: adc: extract setup function without backend
Date: Mon, 25 Aug 2025 13:51:18 +0300
Message-ID: <20250825105121.19848-4-Ioana.Risteiu@analog.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250825105121.19848-1-Ioana.Risteiu@analog.com>
References: <20250825105121.19848-1-Ioana.Risteiu@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: QGtxKTbi9cPx-vIoJFjHdTDDnqN5_SkK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDA1MSBTYWx0ZWRfXz+oISvKgG2T3
 K5JUqFRLwsElE1B/s+SJd3JOJwVqz0SKAmiPhwuIb09RjyIdxuLILK9fTddycI1KdYUpOsSwN9I
 WDzglm2MIRwgistMNXyo65XCKyGHlNA3+sKHyhJjEzz1ECIR0yYy6Xd46nRLHGQYWnfRA1oQkjV
 1GHJJUrO73m8SrX3W6T0kKg5If9yFJ/SSB+lJZIRnYKQCAc1jYlAZZW9Z8CMdyn6UcugvciZlhd
 ocg4F2eoPLYNAqZXNXy6QjEtL7tes8nZ/u6tjnmGBWGiXKibMcn7mrg8ru05KBXFCa/y2tdy2A9
 pHgRDT3oOYjiaHYJdIMxC+7iX5YoxpRUsPztK8y2Ld0HdGcHcYRTEvgX8gTNYHOsP9yqUGOnzsa
 iQnnvBJQ
X-Proofpoint-GUID: QGtxKTbi9cPx-vIoJFjHdTDDnqN5_SkK
X-Authority-Analysis: v=2.4 cv=PNQP+eqC c=1 sm=1 tr=0 ts=68ac4079 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=2OwXVqhp2XgA:10 a=gAnH3GRIAAAA:8 a=e6B03PNIoHuVPIBsO9AA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_05,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508230051

Refactor probe function by moving the initialization specific to
communication without iio-backend into a separate setup function.

The purpose of this modification is better code organization. No
functional changes intended.

Signed-off-by: Ioana Risteiu <Ioana.Risteiu@analog.com>
---
changes in v5:
 - fix indentation
 - remove blank line
 drivers/iio/adc/ad7779.c | 84 +++++++++++++++++++++-------------------
 1 file changed, 45 insertions(+), 39 deletions(-)

diff --git a/drivers/iio/adc/ad7779.c b/drivers/iio/adc/ad7779.c
index 845adc510239..b4e56983201c 100644
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
@@ -760,9 +804,6 @@ static int ad7779_probe(struct spi_device *spi)
 	struct device *dev = &spi->dev;
 	int ret = -EINVAL;
 
-	if (!spi->irq)
-		return dev_err_probe(dev, ret, "DRDY irq not present\n");
-
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
 	if (!indio_dev)
 		return -ENOMEM;
@@ -804,45 +845,10 @@ static int ad7779_probe(struct spi_device *spi)
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
-
-	ret = ad7779_spi_write_mask(st, AD7779_REG_DOUT_FORMAT,
-				    AD7779_DCLK_CLK_DIV_MSK,
-				    FIELD_PREP(AD7779_DCLK_CLK_DIV_MSK, 7));
+	ret = ad7779_setup_without_backend(st, indio_dev);
 	if (ret)
 		return ret;
 
-- 
2.47.2


