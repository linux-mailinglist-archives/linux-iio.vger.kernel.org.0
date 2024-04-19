Return-Path: <linux-iio+bounces-4351-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A5758AAA10
	for <lists+linux-iio@lfdr.de>; Fri, 19 Apr 2024 10:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFB36B2435E
	for <lists+linux-iio@lfdr.de>; Fri, 19 Apr 2024 08:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFFEA57870;
	Fri, 19 Apr 2024 08:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pbxPoXg1"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A31152F82;
	Fri, 19 Apr 2024 08:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713515137; cv=none; b=heDPTnKhui3Bq9s9dDYF/opGsM65IzZHuMvjSPtl2xzypgwga+iFOmhzLQjOHgShUZ1JPxFQJh0jc5pj9EtuwboMH0v3Rz5R+rD8YMpqclhp7X1TUslU4/A5CCB2O2/PnRghnbHfNJa/1XdfRFvkQPfSzeXHFl+BtBpfIaB+Z9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713515137; c=relaxed/simple;
	bh=hYh8/2pNdzpoSpW2D7bhatMD+PmsjE7pzjEVoO9pv9M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UPK2Wya40Y6/wVUDccVI0mIXVXohelCq7lR5kMDt6RdWeUhQTrIOEK1Uw3xIB9FdLTZ+m6Hftvsho0PeeHGaqc+VkCUibO/C3rSoULBsambFEezJ5veEr1i20QOkk+pMWwA4XmS52yPEj/sLQ5x7MntmMuwZQ4Be8v5rBjNlcqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pbxPoXg1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 03931C2BD10;
	Fri, 19 Apr 2024 08:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713515137;
	bh=hYh8/2pNdzpoSpW2D7bhatMD+PmsjE7pzjEVoO9pv9M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=pbxPoXg1ROKoMohdKVnWmxzZuognz9euNrqYhj4u1YO2gy6lYLfRgVxy7jcD9M4vE
	 dyl/Bybv4NXzm5ggShYazTXomK4+QKPgqom6RvFxW9YM2hpsAh7KUejf1D4SZn97Mw
	 jpuBPg5DyUAXjrTR9hkZ3hFYzOw0yaYNgFA0LO+ckZt9ubjumJQlwi5U+8GAoQch8F
	 ++zpPaJbtYWXUYWIgYeoj8viGN+2XXS4uyUyrOvkyIEe693lFq3jd/w8wnZ843q2DU
	 nQ++h5Jkz4LURTxuMYW3hy40yYqHAj/HcP8L4uk6isjIdjAHDPqehQIoEgSYa2kdwA
	 YCLLuiOm/kNgA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F017FC04FF6;
	Fri, 19 Apr 2024 08:25:36 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Fri, 19 Apr 2024 10:25:34 +0200
Subject: [PATCH v4 01/10] iio: buffer-dma: add iio_dmaengine_buffer_setup()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240419-iio-backend-axi-dac-v4-1-5ca45b4de294@analog.com>
References: <20240419-iio-backend-axi-dac-v4-0-5ca45b4de294@analog.com>
In-Reply-To: <20240419-iio-backend-axi-dac-v4-0-5ca45b4de294@analog.com>
To: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc: Dragos Bogdan <dragos.bogdan@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>, Nuno Sa <nuno.sa@analog.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713515134; l=5821;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=qh7cxxUSeQcO4sXq3gc5A3BVtcxRR1nC991URhqSKdY=;
 b=Bm79zJg3mE2/Wlrwt1wCaFY/g/splzbf/IGyakeiB0BupKVvHsN9NH/vnrsQX2zlxX8c57W0h
 pAim/vagWUJBTMZgG7WZ5jzZqlIZBQGUI8uAmfgpY5GuUKpnWAMM8yW
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



