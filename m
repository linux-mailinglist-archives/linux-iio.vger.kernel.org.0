Return-Path: <linux-iio+bounces-4092-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDDB589A05F
	for <lists+linux-iio@lfdr.de>; Fri,  5 Apr 2024 16:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34B481F21FAF
	for <lists+linux-iio@lfdr.de>; Fri,  5 Apr 2024 14:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FF5616F8FF;
	Fri,  5 Apr 2024 14:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="fNTtVE7q"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B31E16F29C;
	Fri,  5 Apr 2024 14:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712329041; cv=none; b=WTj4BW+ctUikyrs7Np68+wObZEEm9jOj3OmFbQuk9KG9xhUipzbC4uucStgpmrCQ6DZlKPAJdDjbclyej8i71N7o2Ta4cWm6wmHjFeHo0+HysOClPthbnGSbqXKB4Cq9QLN5kHVK4Nblw56wN+V2f9wyjTo1Wrv5Nr5JJyyXlac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712329041; c=relaxed/simple;
	bh=W7Q9EeQC69HgOXY6yDvreeXfFACrgL2UG7ipn2evH7w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=T4mFTti+WAVnCXqG2TNyhcp0FTaSNt1SASYlO/rHs/dmv89Uoz406XhaTTps6vlQ3Q7yxD2c8YQP6GZy6lBQzv7fLPk4FpTs2I1T4wFxGR7fmFmRe6WhMmpCmGX1TAtitl4GBwYgAd4SdWkoITZqRWPIXCf5Hp7zhVIkEimWecs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=fNTtVE7q; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 435DKGHI000726;
	Fri, 5 Apr 2024 10:56:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=DKIM; bh=MECQlO22bZYWROO0dEMj/QcUw5yypUrj+6g37+1Kw+Q=; b=
	fNTtVE7qhQKvvLmfuuttVWdqI1Q44CAv8YMQdb9uWXcfMINLvpdFFcDo6rOeIMi7
	JVkR2JgEwiQKru3Op8i4s3tFb6HePHVj8gK+6mulwCpWX2L0TMEhabyHu/MmPpIU
	mhNtLSy5gA+KwmlxwBqwviOFV1vI4WL5iOIGvOAZpf1rs1o+13wIh0JtuFNxK579
	n+qOT+u6qgEyOiHEFYgTEi0xT3FMUfxYa2bH+fbVuS9dN6grzHn5c4jXIGXJ9Oi0
	2Wu5H0ulAgBTnq3vXNkjc1VMups9nDUFNLYichi8ldC0i2ikbS6ikLbG1UtrtJFE
	dWZR1zrhSktLxAIhJSVkGg==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3x9y8vvnnp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Apr 2024 10:56:53 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 435EupnK022811
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 5 Apr 2024 10:56:52 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 5 Apr 2024 10:56:51 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 5 Apr 2024 10:56:49 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 5 Apr 2024 10:56:49 -0400
Received: from [127.0.0.1] ([10.44.3.56])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 435EuSI2019011;
	Fri, 5 Apr 2024 10:56:44 -0400
From: Nuno Sa <nuno.sa@analog.com>
Date: Fri, 5 Apr 2024 17:00:02 +0200
Subject: [PATCH v2 04/11] iio: buffer-dmaengine: Support specifying buffer
 direction
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240405-iio-backend-axi-dac-v2-4-293bab7d5552@analog.com>
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
        Olivier Moysan <olivier.moysan@foss.st.com>,
        "Paul
 Cercueil" <paul@crapouillou.net>,
        Alexandru Ardelean <ardeleanalex@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712329201; l=5579;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=u23I6KLSCcrBhm4fnCuOy4udHamrKg4Ga64h2+KE9cI=;
 b=kG6L0njSKRpIEL+WMm7HQt2S0EoTXd8TXbUssCUCyCTuwplIfSec1vByEaH2ubtSDnnQisvOE
 lT/0RU19kuyDB74yXjSFDUFnVECY3IV+TV3mZZIsHeSCCrvnICVB0bD
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: lJ1zFkjoGPKy1OpwEAS-MGOn9Wv6CdXs
X-Proofpoint-GUID: lJ1zFkjoGPKy1OpwEAS-MGOn9Wv6CdXs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-05_16,2024-04-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404050106

From: Paul Cercueil <paul@crapouillou.net>

Update the devm_iio_dmaengine_buffer_setup() function to support
specifying the buffer direction.

Update the iio_dmaengine_buffer_submit() function to handle input
buffers as well as output buffers.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>
Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/buffer/industrialio-buffer-dmaengine.c | 41 +++++++++++++++-------
 include/linux/iio/buffer-dmaengine.h               | 25 +++++++++----
 2 files changed, 47 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
index df05d66afff9..051e1758e020 100644
--- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
+++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
@@ -64,14 +64,25 @@ static int iio_dmaengine_buffer_submit_block(struct iio_dma_buffer_queue *queue,
 	struct dmaengine_buffer *dmaengine_buffer =
 		iio_buffer_to_dmaengine_buffer(&queue->buffer);
 	struct dma_async_tx_descriptor *desc;
+	enum dma_transfer_direction dma_dir;
+	size_t max_size;
 	dma_cookie_t cookie;
 
-	block->bytes_used = min(block->size, dmaengine_buffer->max_size);
-	block->bytes_used = round_down(block->bytes_used,
-			dmaengine_buffer->align);
+	max_size = min(block->size, dmaengine_buffer->max_size);
+	max_size = round_down(max_size, dmaengine_buffer->align);
+
+	if (queue->buffer.direction == IIO_BUFFER_DIRECTION_IN) {
+		block->bytes_used = max_size;
+		dma_dir = DMA_DEV_TO_MEM;
+	} else {
+		dma_dir = DMA_MEM_TO_DEV;
+	}
+
+	if (!block->bytes_used || block->bytes_used > max_size)
+		return -EINVAL;
 
 	desc = dmaengine_prep_slave_single(dmaengine_buffer->chan,
-		block->phys_addr, block->bytes_used, DMA_DEV_TO_MEM,
+		block->phys_addr, block->bytes_used, dma_dir,
 		DMA_PREP_INTERRUPT);
 	if (!desc)
 		return -ENOMEM;
@@ -229,9 +240,10 @@ void iio_dmaengine_buffer_free(struct iio_buffer *buffer)
 }
 EXPORT_SYMBOL_NS_GPL(iio_dmaengine_buffer_free, IIO_DMAENGINE_BUFFER);
 
-struct iio_buffer *iio_dmaengine_buffer_setup(struct device *dev,
-					      struct iio_dev *indio_dev,
-					      const char *channel)
+struct iio_buffer *iio_dmaengine_buffer_setup_ext(struct device *dev,
+						  struct iio_dev *indio_dev,
+						  const char *channel,
+						  enum iio_buffer_direction dir)
 {
 	struct iio_buffer *buffer;
 	int ret;
@@ -242,6 +254,8 @@ struct iio_buffer *iio_dmaengine_buffer_setup(struct device *dev,
 
 	indio_dev->modes |= INDIO_BUFFER_HARDWARE;
 
+	buffer->direction = dir;
+
 	ret = iio_device_attach_buffer(indio_dev, buffer);
 	if (ret) {
 		iio_dmaengine_buffer_free(buffer);
@@ -250,7 +264,7 @@ struct iio_buffer *iio_dmaengine_buffer_setup(struct device *dev,
 
 	return buffer;
 }
-EXPORT_SYMBOL_NS_GPL(iio_dmaengine_buffer_setup, IIO_DMAENGINE_BUFFER);
+EXPORT_SYMBOL_NS_GPL(iio_dmaengine_buffer_setup_ext, IIO_DMAENGINE_BUFFER);
 
 static void __devm_iio_dmaengine_buffer_free(void *buffer)
 {
@@ -268,20 +282,21 @@ static void __devm_iio_dmaengine_buffer_free(void *buffer)
  * It also appends the INDIO_BUFFER_HARDWARE mode to the supported modes of the
  * IIO device.
  */
-int devm_iio_dmaengine_buffer_setup(struct device *dev,
-				    struct iio_dev *indio_dev,
-				    const char *channel)
+int devm_iio_dmaengine_buffer_setup_ext(struct device *dev,
+					struct iio_dev *indio_dev,
+					const char *channel,
+					enum iio_buffer_direction dir)
 {
 	struct iio_buffer *buffer;
 
-	buffer = iio_dmaengine_buffer_setup(dev, indio_dev, channel);
+	buffer = iio_dmaengine_buffer_setup_ext(dev, indio_dev, channel, dir);
 	if (IS_ERR(buffer))
 		return PTR_ERR(buffer);
 
 	return devm_add_action_or_reset(dev, __devm_iio_dmaengine_buffer_free,
 					buffer);
 }
-EXPORT_SYMBOL_NS_GPL(devm_iio_dmaengine_buffer_setup, IIO_DMAENGINE_BUFFER);
+EXPORT_SYMBOL_NS_GPL(devm_iio_dmaengine_buffer_setup_ext, IIO_DMAENGINE_BUFFER);
 
 MODULE_AUTHOR("Lars-Peter Clausen <lars@metafoo.de>");
 MODULE_DESCRIPTION("DMA buffer for the IIO framework");
diff --git a/include/linux/iio/buffer-dmaengine.h b/include/linux/iio/buffer-dmaengine.h
index acb60f9a3fff..81d9a19aeb91 100644
--- a/include/linux/iio/buffer-dmaengine.h
+++ b/include/linux/iio/buffer-dmaengine.h
@@ -7,15 +7,28 @@
 #ifndef __IIO_DMAENGINE_H__
 #define __IIO_DMAENGINE_H__
 
+#include <linux/iio/buffer.h>
+
 struct iio_dev;
 struct device;
 
 void iio_dmaengine_buffer_free(struct iio_buffer *buffer);
-struct iio_buffer *iio_dmaengine_buffer_setup(struct device *dev,
-					      struct iio_dev *indio_dev,
-					      const char *channel);
-int devm_iio_dmaengine_buffer_setup(struct device *dev,
-				    struct iio_dev *indio_dev,
-				    const char *channel);
+struct iio_buffer *iio_dmaengine_buffer_setup_ext(struct device *dev,
+						  struct iio_dev *indio_dev,
+						  const char *channel,
+						  enum iio_buffer_direction dir);
+
+#define iio_dmaengine_buffer_setup(dev, indio_dev, channel)	\
+	iio_dmaengine_buffer_setup_ext(dev, indio_dev, channel,	\
+				       IIO_BUFFER_DIRECTION_IN)
+
+int devm_iio_dmaengine_buffer_setup_ext(struct device *dev,
+					struct iio_dev *indio_dev,
+					const char *channel,
+					enum iio_buffer_direction dir);
+
+#define devm_iio_dmaengine_buffer_setup(dev, indio_dev, channel)	\
+	devm_iio_dmaengine_buffer_setup_ext(dev, indio_dev, channel,	\
+					    IIO_BUFFER_DIRECTION_IN)
 
 #endif

-- 
2.44.0


