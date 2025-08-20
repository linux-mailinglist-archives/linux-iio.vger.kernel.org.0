Return-Path: <linux-iio+bounces-23046-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B5DB2DC00
	for <lists+linux-iio@lfdr.de>; Wed, 20 Aug 2025 14:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9F0EA4E524D
	for <lists+linux-iio@lfdr.de>; Wed, 20 Aug 2025 12:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBBCA2F5473;
	Wed, 20 Aug 2025 12:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="ZWIrXcpb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3092F3C2A;
	Wed, 20 Aug 2025 12:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755691428; cv=none; b=CRBq/b/rKjP14XQf+hTC4cX7g3QvrWnLsp8v5zU3W7QoFgih1j5U/ieqfyG4qxjgffucv4N++1+oE0A/EU2dgHPRc8JTjQUjfT0fNkB0ZsFTi3faUx+3TX5wRYhxB3l1Oz1lCB5hWT0gQePahLH+IfvqKTkrjPFdh/Prvyyfck8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755691428; c=relaxed/simple;
	bh=1OJFpcp4YYqG2GVDaeP2XJuGBpnCCCGj/RAEZS/bfOc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iwOZMsvAIOkCBMaVfb3hgk081lTmsbw3h0LmEkoNFBCNXP/iGqvlbdqVOigXvhmluAqgR6QjCAWAQuWYNmqlZMAIX/NsZBPRsyfUnEMsdJ/Qm+1huABq7u9ugGfSyXbLTjUGq1qRoCvx7b2UwxE6Hw8cqy+FuhVyAtHPdnqeYw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=ZWIrXcpb; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57KAcs9o004346;
	Wed, 20 Aug 2025 08:03:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=7fOTP
	1CEnTzzN3ibLisR9ekC7LLlotBk71PqCaUFRVo=; b=ZWIrXcpb7C9CJeAMk9JvD
	BEYHP/3jxfSkZt7tlSl4674KZ7jzePFwoWsWLwbnFCIGkvCw+J8UXp5EY4p5OTJt
	UYpNiaF8qXqgG5va+ikGllTCvruuRQVApQkeHDTaergTXfc/2HSYNTHm66n9tqDr
	xaR0P4QCv6xmEsh+IGWwRaV88RkegxVYSq8uco8dsLB4rb5VlZnrZgjOk740jE6S
	xdkdz0dpTHSbeekOEe7DxaWTGi5pWbFBkfwL8oXb3EA8WiRINODh84z6Pz0QSgx/
	/Ptz2RTwZFpBB4F7dXg7h09id4CNUbpRgJ0SS0l/5XY8zDZDrBnlVPhXvNOpeqvh
	A==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 48n0td3guj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Aug 2025 08:03:32 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 57KC3VSv004706
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 20 Aug 2025 08:03:31 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 20 Aug 2025 08:03:31 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 20 Aug 2025 08:03:31 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 20 Aug 2025 08:03:31 -0400
Received: from IRISTEIU-L01.ad.analog.com (IRISTEIU-L01.ad.analog.com [10.48.65.173])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 57KC31n3020092;
	Wed, 20 Aug 2025 08:03:24 -0400
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
Subject: [PATCH v4 3/4] iio: adc: extract setup function without backend
Date: Wed, 20 Aug 2025 15:02:44 +0300
Message-ID: <20250820120247.3012-4-Ioana.Risteiu@analog.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250820120247.3012-1-Ioana.Risteiu@analog.com>
References: <20250820120247.3012-1-Ioana.Risteiu@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=bvAVxEai c=1 sm=1 tr=0 ts=68a5b994 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=2OwXVqhp2XgA:10 a=gAnH3GRIAAAA:8 a=e6B03PNIoHuVPIBsO9AA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: WQwN1nrInSMs8PEmrVZjifBKCsbxCgda
X-Proofpoint-ORIG-GUID: WQwN1nrInSMs8PEmrVZjifBKCsbxCgda
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDE5NSBTYWx0ZWRfX/AtsBmOsquDt
 SxFmX+1SaTgfsa8bCJFCavZLb2mR/4ARV3Ce7Gp4JxUA4Twf1R18aTRxLNIgKoGEoT0eesj4+x4
 o7NUjfyGkxnNJVOzbgTlb+39vrWfXmLt8HPDCzZt0sUH2SmtaJVwDut6zwe8t+erWA+oo9We2H2
 xBc/TQiTy1Kfc6aYd6E6FdSneYYK2nWBSJmvcQCRekVUMX1dAS6S6Ovu48TirFoAPvpJuxS6Xyi
 7t4wkWEEgki0lorybAnlVaAJpP3gXXHLrPra86bMyJKfFMGPlcmMGN4uxP1l/4n/ohk95xunBnZ
 1vgs/CkO7dWAuA3TcVDopFP78ezbvwPX3kj8OAXmAdv3V4rdNF0vBGyk4+01/8DwacxMWpblhI6
 va9ZVBNDkGqHI1y+UUT7pgRbuP7rPg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_03,2025-08-20_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 spamscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508190195

Refactor probe function by moving the initialization specific to
communication without iio-backend into a separate setup function.

The purpose of this modification is better code organization. No
functional changes intended.

Signed-off-by: Ioana Risteiu <Ioana.Risteiu@analog.com>
---
no changes in v4.
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


