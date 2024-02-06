Return-Path: <linux-iio+bounces-2233-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 90BEB84B205
	for <lists+linux-iio@lfdr.de>; Tue,  6 Feb 2024 11:08:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0279B21791
	for <lists+linux-iio@lfdr.de>; Tue,  6 Feb 2024 10:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5097812E1DE;
	Tue,  6 Feb 2024 10:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GL7i5kSm"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0170012DD89;
	Tue,  6 Feb 2024 10:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707214124; cv=none; b=RO66sfnI9GNN/0Rk74t0ni5bOqDkSmu/GDr+LPAdzmnpeB8M2K1WqbMf32wgOK2/g0TgiVdvPdKssK/AfmarHJoHt2dhKOnp+1tLMs9AIwrKg/DUQGI0NubHnsFxwUnddAy8TwyTOy0nL8a9KKPBa66+K0xP2gxM86toL5IrILw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707214124; c=relaxed/simple;
	bh=Jbx9A60oDrS6/ZkaMfuBhDkPhHXF7P3WtJFWzroFwZw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DMcpVfgiyIWfpvMFDpCatq1LP8RXV0/+fgylgNZR/BZKEJ3EqVfL3aicy4r5xZ/usQr0Ix/VxwnI7FHQ0GpG6n/YK1EgFgbdGtDZYP+uILeZmc+8HZE9F3+yRZlqHSOMvbeZfuKBh7UrmJM6euyHFDDshnNPWlKOWbWZBAVMUhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GL7i5kSm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8F387C43143;
	Tue,  6 Feb 2024 10:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707214123;
	bh=Jbx9A60oDrS6/ZkaMfuBhDkPhHXF7P3WtJFWzroFwZw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=GL7i5kSmCedw7hAiZu0KtABP0+sDdjUsE4dOH/Cj8F71oedtETqZRuH+2q8D/pg3q
	 AUSACOmA07btvIdWmEoQK7SdXlz9eDgnuho9eSfjDDJ+06Q329pTyvyncagM955Y/6
	 Eztc8FUA2SZ2duyr5KZP19YDezi2SISCcxQY/vkCE84+85cESHRURQ71P+dJU5OaSq
	 Qo+zfdqIcQauogb/CsqZxWDYBOpII6GQZjdO7d6Fn41Z1onWPZxSYGXnYxpPrXZmBj
	 cSYCFIm2VXBJ6pBBaAhS0J4bjL2PexB3Io35AN+wQ54010uIZ1Ue589jqelqJFvZQ7
	 1YaH/i1FEl3pw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B41AC4829E;
	Tue,  6 Feb 2024 10:08:43 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Tue, 06 Feb 2024 11:08:27 +0100
Subject: [PATCH v9 4/7] iio: buffer-dmaengine: export buffer alloc and free
 functions
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240206-iio-backend-v9-4-df66d159c000@analog.com>
References: <20240206-iio-backend-v9-0-df66d159c000@analog.com>
In-Reply-To: <20240206-iio-backend-v9-0-df66d159c000@analog.com>
To: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, 
 Olivier Moysan <olivier.moysan@foss.st.com>, andy.shevchenko@gmail.com
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707214121; l=3896;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=6pMFXM0wCdg3Id7C+f0CPli3rW2y13iOegJBdE0KPUQ=;
 b=ato7X/PKfyCQvU0eWsgxKEkgwdUAcR8Hsy+ZDCNcGbmJd3KhX9x9uWDRcIQIBReqIrjzTpSm+
 U2L6cwIlWQbDG7j3fWplyQXcD/I0R+y0vcNRGxaBWrRRHKVU3dkDt7C
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


