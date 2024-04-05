Return-Path: <linux-iio+bounces-4083-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3139689A04E
	for <lists+linux-iio@lfdr.de>; Fri,  5 Apr 2024 16:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA0041F23983
	for <lists+linux-iio@lfdr.de>; Fri,  5 Apr 2024 14:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB2D16F82C;
	Fri,  5 Apr 2024 14:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="K1YL5eNl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8747916DEAB;
	Fri,  5 Apr 2024 14:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712329037; cv=none; b=EyQl66GWhGZLClfctungqHMwMN1kBY3EBDmfqn4LE+T1GxUvenXa2D1ZKf8mY0linH2N5CmTJWkjhRk+3Gvwd6+sEpjZpmOJQodylpx7E3TAE65tfitcbcC8ir7aDRFb8WbkKW4y3xu6WyJWX8ZLHjOSSp9UmlxoTup/AQsQsSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712329037; c=relaxed/simple;
	bh=qh7cxxUSeQcO4sXq3gc5A3BVtcxRR1nC991URhqSKdY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=nkXQCYC0GYgqW+cuQgOZUF3cB+SjbhiD4XK7Gg9qMLmmZhnwOOW6lr1SohHeAbJpxpJ5uDwQj6GCCPjUI8KF5zxos+uegDvzyHgMwfgXM1Ko0ZDI3BqlAhqaxTxnTbKazdi7qdtx4ycEoNfgWsxWesocsQ2Hp7itz0x64BJK928=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=K1YL5eNl; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 435CZwDY010078;
	Fri, 5 Apr 2024 10:56:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=DKIM; bh=JKxxM8czizM00ZHQcVOyUMpdIZVrLnaIRNhHC9RGyy4=; b=
	K1YL5eNlhQUll1g90AXvcWu1dbTYmSLojCt2WBgUlw3EwfU2iOJpU4weTmZDkhhq
	BSEmDdYSkK6oPbp5spwZW7XYS5hkbCGvSJwKe65XtI+0troWUL7Y083Un5thW0qV
	h7K1E+NjL2ZQYTojBarjChikwUX4/nMy6GsfSWk0d4rExGToCVaL+5eDSv+9oDwi
	0n4tLqbMm7EIHfaMHHvql7PfFt6OdzNxrStZ28wSf5n0NjCIBHM5Is71QQG0xJ/q
	kgRM1xS3Pb1BK+X4KxP56SGFA8JW10ZkdrfcyXsFMaNPtkjZYecvSV7pWQTboprP
	6TSZ5Nk26TP1r1ZkCDOfQg==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3x9epgr9hn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Apr 2024 10:56:46 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 435EujDg064519
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 5 Apr 2024 10:56:45 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 5 Apr 2024 10:56:44 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 5 Apr 2024 10:56:44 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 5 Apr 2024 10:56:44 -0400
Received: from [127.0.0.1] ([10.44.3.56])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 435EuSHx019011;
	Fri, 5 Apr 2024 10:56:40 -0400
From: Nuno Sa <nuno.sa@analog.com>
Date: Fri, 5 Apr 2024 16:59:59 +0200
Subject: [PATCH v2 01/11] iio: buffer-dma: add iio_dmaengine_buffer_setup()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240405-iio-backend-axi-dac-v2-1-293bab7d5552@analog.com>
References: <20240405-iio-backend-axi-dac-v2-0-293bab7d5552@analog.com>
In-Reply-To: <20240405-iio-backend-axi-dac-v2-0-293bab7d5552@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: Dragos Bogdan <dragos.bogdan@analog.com>,
        Lars-Peter Clausen
	<lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        "Jonathan Cameron" <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Olivier Moysan <olivier.moysan@foss.st.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712329201; l=5821;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=qh7cxxUSeQcO4sXq3gc5A3BVtcxRR1nC991URhqSKdY=;
 b=i6AjopLFkpnhT39nCF8lxEFbJ6NjulwkZil3E7eIGuLeJop4Qv4cLgGYaOe6NC7fjDgcS57HH
 QKozqRcRo2zDOSoDF6U8vkRIzxYDiSopSoLMCjgFKfQVd+ZdSOkl1t0
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: NkF0ai-QcIFmUcxDxvkNXjKJiO9CHGnY
X-Proofpoint-GUID: NkF0ai-QcIFmUcxDxvkNXjKJiO9CHGnY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-05_16,2024-04-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 adultscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 mlxlogscore=999 spamscore=0 lowpriorityscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404050106

This brings the DMA buffer API more in line with what we have in the
triggered buffer. There's no need of having both
devm_iio_dmaengine_buffer_setup() and devm_iio_dmaengine_buffer_alloc().
Hence we introduce the new iio_dmaengine_buffer_setup() that together
with devm_iio_dmaengine_buffer_setup() should be all we need.

Note that as part of this change iio_dmaengine_buffer_alloc() is again
static and the axi-adc was updated accordingly.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/adc/adi-axi-adc.c                      | 16 +-------
 drivers/iio/buffer/industrialio-buffer-dmaengine.c | 48 +++++++++-------------
 include/linux/iio/buffer-dmaengine.h               |  5 ++-
 3 files changed, 24 insertions(+), 45 deletions(-)

diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
index 4156639b3c8b..184b36dca6d0 100644
--- a/drivers/iio/adc/adi-axi-adc.c
+++ b/drivers/iio/adc/adi-axi-adc.c
@@ -124,26 +124,12 @@ static struct iio_buffer *axi_adc_request_buffer(struct iio_backend *back,
 						 struct iio_dev *indio_dev)
 {
 	struct adi_axi_adc_state *st = iio_backend_get_priv(back);
-	struct iio_buffer *buffer;
 	const char *dma_name;
-	int ret;
 
 	if (device_property_read_string(st->dev, "dma-names", &dma_name))
 		dma_name = "rx";
 
-	buffer = iio_dmaengine_buffer_alloc(st->dev, dma_name);
-	if (IS_ERR(buffer)) {
-		dev_err(st->dev, "Could not get DMA buffer, %ld\n",
-			PTR_ERR(buffer));
-		return ERR_CAST(buffer);
-	}
-
-	indio_dev->modes |= INDIO_BUFFER_HARDWARE;
-	ret = iio_device_attach_buffer(indio_dev, buffer);
-	if (ret)
-		return ERR_PTR(ret);
-
-	return buffer;
+	return iio_dmaengine_buffer_setup(st->dev, indio_dev, dma_name);
 }
 
 static void axi_adc_free_buffer(struct iio_backend *back,
diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
index a18c1da292af..97f3116566f5 100644
--- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
+++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
@@ -159,7 +159,7 @@ static const struct iio_dev_attr *iio_dmaengine_buffer_attrs[] = {
  * Once done using the buffer iio_dmaengine_buffer_free() should be used to
  * release it.
  */
-struct iio_buffer *iio_dmaengine_buffer_alloc(struct device *dev,
+static struct iio_buffer *iio_dmaengine_buffer_alloc(struct device *dev,
 	const char *channel)
 {
 	struct dmaengine_buffer *dmaengine_buffer;
@@ -210,7 +210,6 @@ struct iio_buffer *iio_dmaengine_buffer_alloc(struct device *dev,
 	kfree(dmaengine_buffer);
 	return ERR_PTR(ret);
 }
-EXPORT_SYMBOL_NS_GPL(iio_dmaengine_buffer_alloc, IIO_DMAENGINE_BUFFER);
 
 /**
  * iio_dmaengine_buffer_free() - Free dmaengine buffer
@@ -230,39 +229,33 @@ void iio_dmaengine_buffer_free(struct iio_buffer *buffer)
 }
 EXPORT_SYMBOL_NS_GPL(iio_dmaengine_buffer_free, IIO_DMAENGINE_BUFFER);
 
-static void __devm_iio_dmaengine_buffer_free(void *buffer)
-{
-	iio_dmaengine_buffer_free(buffer);
-}
-
-/**
- * devm_iio_dmaengine_buffer_alloc() - Resource-managed iio_dmaengine_buffer_alloc()
- * @dev: Parent device for the buffer
- * @channel: DMA channel name, typically "rx".
- *
- * This allocates a new IIO buffer which internally uses the DMAengine framework
- * to perform its transfers. The parent device will be used to request the DMA
- * channel.
- *
- * The buffer will be automatically de-allocated once the device gets destroyed.
- */
-static struct iio_buffer *devm_iio_dmaengine_buffer_alloc(struct device *dev,
-	const char *channel)
+struct iio_buffer *iio_dmaengine_buffer_setup(struct device *dev,
+					      struct iio_dev *indio_dev,
+					      const char *channel)
 {
 	struct iio_buffer *buffer;
 	int ret;
 
 	buffer = iio_dmaengine_buffer_alloc(dev, channel);
 	if (IS_ERR(buffer))
-		return buffer;
+		return ERR_CAST(buffer);
 
-	ret = devm_add_action_or_reset(dev, __devm_iio_dmaengine_buffer_free,
-				       buffer);
-	if (ret)
+	indio_dev->modes |= INDIO_BUFFER_HARDWARE;
+
+	ret = iio_device_attach_buffer(indio_dev, buffer);
+	if (ret) {
+		iio_dmaengine_buffer_free(buffer);
 		return ERR_PTR(ret);
+	}
 
 	return buffer;
 }
+EXPORT_SYMBOL_NS_GPL(iio_dmaengine_buffer_setup, IIO_DMAENGINE_BUFFER);
+
+static void __devm_iio_dmaengine_buffer_free(void *buffer)
+{
+	iio_dmaengine_buffer_free(buffer);
+}
 
 /**
  * devm_iio_dmaengine_buffer_setup() - Setup a DMA buffer for an IIO device
@@ -281,13 +274,12 @@ int devm_iio_dmaengine_buffer_setup(struct device *dev,
 {
 	struct iio_buffer *buffer;
 
-	buffer = devm_iio_dmaengine_buffer_alloc(dev, channel);
+	buffer = iio_dmaengine_buffer_setup(dev, indio_dev, channel);
 	if (IS_ERR(buffer))
 		return PTR_ERR(buffer);
 
-	indio_dev->modes |= INDIO_BUFFER_HARDWARE;
-
-	return iio_device_attach_buffer(indio_dev, buffer);
+	return devm_add_action_or_reset(dev, __devm_iio_dmaengine_buffer_free,
+					buffer);
 }
 EXPORT_SYMBOL_NS_GPL(devm_iio_dmaengine_buffer_setup, IIO_DMAENGINE_BUFFER);
 
diff --git a/include/linux/iio/buffer-dmaengine.h b/include/linux/iio/buffer-dmaengine.h
index cbb8ba957fad..acb60f9a3fff 100644
--- a/include/linux/iio/buffer-dmaengine.h
+++ b/include/linux/iio/buffer-dmaengine.h
@@ -10,9 +10,10 @@
 struct iio_dev;
 struct device;
 
-struct iio_buffer *iio_dmaengine_buffer_alloc(struct device *dev,
-					      const char *channel);
 void iio_dmaengine_buffer_free(struct iio_buffer *buffer);
+struct iio_buffer *iio_dmaengine_buffer_setup(struct device *dev,
+					      struct iio_dev *indio_dev,
+					      const char *channel);
 int devm_iio_dmaengine_buffer_setup(struct device *dev,
 				    struct iio_dev *indio_dev,
 				    const char *channel);

-- 
2.44.0


