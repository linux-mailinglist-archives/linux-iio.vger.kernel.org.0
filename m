Return-Path: <linux-iio+bounces-4200-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 549898A2F88
	for <lists+linux-iio@lfdr.de>; Fri, 12 Apr 2024 15:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A32A6B21B24
	for <lists+linux-iio@lfdr.de>; Fri, 12 Apr 2024 13:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1527483CDD;
	Fri, 12 Apr 2024 13:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LBVz0kap"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34768288A;
	Fri, 12 Apr 2024 13:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712928970; cv=none; b=kLKRBpMO66mGlRdCzo5EGnCfiIq5BM0+YM+gOJz0lLI1zg8nC45KfRIVQMwxdhZktE9aQfrPV5r7buBHPjdpFkE42+RGg4Fd3npmeolTLZ2Iti7vPfKkN26hza7zQHvRboSfpTtpyRvtmZmegliikp5vSTAF7eDe4CSoSytwzfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712928970; c=relaxed/simple;
	bh=idxDXgT45IxlXbQsQfbizuTTntZa7WbsLnmv1Z3aTC0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rQHdyg49FtTLy7/bB/15kUZYpihYGZRkds4KQzrnVhmZQAq7Lwe2IsPleECgZmk/suOkLn6UiCRzhQTGhqyk4RW4l+S3lx8OD3gFEJuziIGuilNMUOtEzkV81Y7hrugfymYT2GTkLITKW76N5Mtbfqbu0u4nEO0J4BtgnHQ2QU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LBVz0kap; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 52030C2BD10;
	Fri, 12 Apr 2024 13:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712928970;
	bh=idxDXgT45IxlXbQsQfbizuTTntZa7WbsLnmv1Z3aTC0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=LBVz0kapySHXT9m9nL90CXjmGgf1kftGVx/NiRjMpArtmtYq/F8GHx+uZ77hBr3Sf
	 0M7TXN3SCmHVNNvkRIj+IFLV1DPLMdlvmkgCVzQIgpEoQQTJjEAs9LeboM5M1x/oyR
	 PZaoSnFLy2/1u9X92Rv1atpugsXo5wgvAjYIdzXGuMxWF4H8VozFKpKOCzwQfuZf67
	 B2MrBzSiI2i1K4EIBB7tl/yZJ+6d30y+b4J1rwNyM6lIkNpW+hqaYS+MDn2K3fdc8r
	 aPTK7FbZ9etpXnaqJAzbegh8dWyze0iALSrAtwZd/s57L+w4FO+oizWlx+GeUZKgXo
	 vpsglqYpWXaNQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F0F9C04FF8;
	Fri, 12 Apr 2024 13:36:10 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Fri, 12 Apr 2024 15:36:08 +0200
Subject: [PATCH v3 01/10] iio: buffer-dma: add iio_dmaengine_buffer_setup()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240412-iio-backend-axi-dac-v3-1-3e9d4c5201fb@analog.com>
References: <20240412-iio-backend-axi-dac-v3-0-3e9d4c5201fb@analog.com>
In-Reply-To: <20240412-iio-backend-axi-dac-v3-0-3e9d4c5201fb@analog.com>
To: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc: Dragos Bogdan <dragos.bogdan@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>, Nuno Sa <nuno.sa@analog.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712928968; l=5827;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=lRZEOGUYHClEFXbBx817QEbybtssYWIkz+H5KwsO9to=;
 b=wTqh5C0ZvDrMzMc4VUJGOjQzdj1tQh3OhYXMYXM8Yti4q72s3BTPsclb/9JD6LGtI2FC1JVW2
 5y/uEGDWs/UB6S1Tz0Exis5rXQ41FzX4iodsOI5Xwgpf6Si5C2xsCEA
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sa <nuno.sa@analog.com>

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
index 4156639b3c8bd..184b36dca6d03 100644
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
index a18c1da292af2..97f3116566f58 100644
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
index cbb8ba957fade..acb60f9a3fffa 100644
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



