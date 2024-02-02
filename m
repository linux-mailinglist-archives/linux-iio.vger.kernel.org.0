Return-Path: <linux-iio+bounces-2096-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB818472AF
	for <lists+linux-iio@lfdr.de>; Fri,  2 Feb 2024 16:10:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C98C7297CEE
	for <lists+linux-iio@lfdr.de>; Fri,  2 Feb 2024 15:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E2B145B23;
	Fri,  2 Feb 2024 15:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ejoN/BOH"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A66814463E;
	Fri,  2 Feb 2024 15:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706886594; cv=none; b=g21lneVMc6g3KtxxoQhD2n5vxtwc3SoUauIQqQRcsmYri0q0M2/msoM1EnlBWwGAiQT83FYVmqK0oU9fd7kkxPQ5GlWNqzeEDqq9gNtx0XWO1YHF6jFX8uPTPIG7vuUpCXVJ5lLpgDo0JihBx5DIm5Uy+Bxqu/SECgwcQzHa8F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706886594; c=relaxed/simple;
	bh=Jbx9A60oDrS6/ZkaMfuBhDkPhHXF7P3WtJFWzroFwZw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZFgg7oPVM5gacYVYeesOybPX4vmh5/pAfUaVaTcwlJT5vtBGmmnP5mK6zdlrcY+3arwe8RRRchql+J1ubD/7AM7lTOPNR0iLUYeBh3lVBZl87u6fG2ks6r80eenNZiMOLKTqbZW0ni2TpCWVhK4uFJSS0aWSXPo2CSWxgWOjiwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ejoN/BOH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2D705C43330;
	Fri,  2 Feb 2024 15:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706886594;
	bh=Jbx9A60oDrS6/ZkaMfuBhDkPhHXF7P3WtJFWzroFwZw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ejoN/BOH9hLmWez01Xrsxe3xHUzLoCzYngiZjTz01fXEdHHpvVVUjLDEM+F0b03/z
	 OApIxnyTy7rovbWcuO8HTmuofW88jiZwDzZ5C6yVKCCOWKipMbIpt+UkRzudEpl/BC
	 fkbUYN/UL8L0r2rnWoM3sL7JaQKf77t7Sn5Aj/cQDY3tbOQxyqefe87Q5+I8/VJ2dp
	 Z5FxqD/K4QKRVsRyUmoJNbacaAWbztcVFzTlOL6y3GqWs+n+Z0GqtJX+HM2+zV3ud4
	 zTxI2PJ0uA3wN0CblC7ZXT4SFv5GOIAUmWmO5QVevk3GkcX+rQw3zwbDv/OdAE2yzp
	 kh/k3hnRmFkWg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1300EC48299;
	Fri,  2 Feb 2024 15:09:54 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Fri, 02 Feb 2024 16:08:35 +0100
Subject: [PATCH v8 4/7] iio: buffer-dmaengine: export buffer alloc and free
 functions
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240202-iio-backend-v8-4-f65ee8c8203d@analog.com>
References: <20240202-iio-backend-v8-0-f65ee8c8203d@analog.com>
In-Reply-To: <20240202-iio-backend-v8-0-f65ee8c8203d@analog.com>
To: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, 
 Olivier Moysan <olivier.moysan@foss.st.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706886592; l=3896;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=6pMFXM0wCdg3Id7C+f0CPli3rW2y13iOegJBdE0KPUQ=;
 b=be/VDteWOFsNE5Tul7eBpuYbmAYhjARIDHyiHKbXjmjZivnxtNgNLcFBImpSWDtQbyGm9oxoR
 3kylCO83H9MAf5YmhfeuMBWLwR8cXukshGcjnXGOfAMquaYb7dz1r6U
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received:
 by B4 Relay for nuno.sa@analog.com/20231116 with auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: <nuno.sa@analog.com>

From: Nuno Sa <nuno.sa@analog.com>

Export iio_dmaengine_buffer_free() and iio_dmaengine_buffer_alloc().
This is in preparation of introducing IIO backends support. This will
allow us to allocate a buffer and control it's lifetime from a device
different from the one holding the DMA firmware properties. Effectively,
in this case the struct device holding the firmware information about
the DMA channels is not the same as iio_dev->dev.parent (typical case).

While at it, namespace the buffer-dmaengine exports and update the
current user of these buffers.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/adc/adi-axi-adc.c                      | 1 +
 drivers/iio/buffer/industrialio-buffer-dmaengine.c | 8 +++++---
 include/linux/iio/buffer-dmaengine.h               | 3 +++
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
index c247ff1541d2..0f21d1d98b9f 100644
--- a/drivers/iio/adc/adi-axi-adc.c
+++ b/drivers/iio/adc/adi-axi-adc.c
@@ -447,3 +447,4 @@ module_platform_driver(adi_axi_adc_driver);
 MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
 MODULE_DESCRIPTION("Analog Devices Generic AXI ADC IP core driver");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(IIO_DMAENGINE_BUFFER);
diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
index 45fe7d0d42ee..a18c1da292af 100644
--- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
+++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
@@ -159,7 +159,7 @@ static const struct iio_dev_attr *iio_dmaengine_buffer_attrs[] = {
  * Once done using the buffer iio_dmaengine_buffer_free() should be used to
  * release it.
  */
-static struct iio_buffer *iio_dmaengine_buffer_alloc(struct device *dev,
+struct iio_buffer *iio_dmaengine_buffer_alloc(struct device *dev,
 	const char *channel)
 {
 	struct dmaengine_buffer *dmaengine_buffer;
@@ -210,6 +210,7 @@ static struct iio_buffer *iio_dmaengine_buffer_alloc(struct device *dev,
 	kfree(dmaengine_buffer);
 	return ERR_PTR(ret);
 }
+EXPORT_SYMBOL_NS_GPL(iio_dmaengine_buffer_alloc, IIO_DMAENGINE_BUFFER);
 
 /**
  * iio_dmaengine_buffer_free() - Free dmaengine buffer
@@ -217,7 +218,7 @@ static struct iio_buffer *iio_dmaengine_buffer_alloc(struct device *dev,
  *
  * Frees a buffer previously allocated with iio_dmaengine_buffer_alloc().
  */
-static void iio_dmaengine_buffer_free(struct iio_buffer *buffer)
+void iio_dmaengine_buffer_free(struct iio_buffer *buffer)
 {
 	struct dmaengine_buffer *dmaengine_buffer =
 		iio_buffer_to_dmaengine_buffer(buffer);
@@ -227,6 +228,7 @@ static void iio_dmaengine_buffer_free(struct iio_buffer *buffer)
 
 	iio_buffer_put(buffer);
 }
+EXPORT_SYMBOL_NS_GPL(iio_dmaengine_buffer_free, IIO_DMAENGINE_BUFFER);
 
 static void __devm_iio_dmaengine_buffer_free(void *buffer)
 {
@@ -287,7 +289,7 @@ int devm_iio_dmaengine_buffer_setup(struct device *dev,
 
 	return iio_device_attach_buffer(indio_dev, buffer);
 }
-EXPORT_SYMBOL_GPL(devm_iio_dmaengine_buffer_setup);
+EXPORT_SYMBOL_NS_GPL(devm_iio_dmaengine_buffer_setup, IIO_DMAENGINE_BUFFER);
 
 MODULE_AUTHOR("Lars-Peter Clausen <lars@metafoo.de>");
 MODULE_DESCRIPTION("DMA buffer for the IIO framework");
diff --git a/include/linux/iio/buffer-dmaengine.h b/include/linux/iio/buffer-dmaengine.h
index 5c355be89814..cbb8ba957fad 100644
--- a/include/linux/iio/buffer-dmaengine.h
+++ b/include/linux/iio/buffer-dmaengine.h
@@ -10,6 +10,9 @@
 struct iio_dev;
 struct device;
 
+struct iio_buffer *iio_dmaengine_buffer_alloc(struct device *dev,
+					      const char *channel);
+void iio_dmaengine_buffer_free(struct iio_buffer *buffer);
 int devm_iio_dmaengine_buffer_setup(struct device *dev,
 				    struct iio_dev *indio_dev,
 				    const char *channel);

-- 
2.43.0


