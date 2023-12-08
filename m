Return-Path: <linux-iio+bounces-763-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF5180A719
	for <lists+linux-iio@lfdr.de>; Fri,  8 Dec 2023 16:14:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CD85B20CFC
	for <lists+linux-iio@lfdr.de>; Fri,  8 Dec 2023 15:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCEDE315AE;
	Fri,  8 Dec 2023 15:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dccnMUeE"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F0A2D7A4;
	Fri,  8 Dec 2023 15:14:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A15A0C433BA;
	Fri,  8 Dec 2023 15:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702048450;
	bh=SqQ+50W53qG7S7RJxgaNsJOHoBzoWJvcQ6VHAxt4k90=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=dccnMUeEQnOjd+r7g3fbxn8reA8G6D6ujOdiBqeQlxWjXcBG9jdQw3ldx83gbYDib
	 XxmeOW281rLvDR8GXWILaCyyHHLGb45EcmTHWusj7shxftP+OdL5Eh1dYxsp/4eQgC
	 r4wL3QoDsvqwE+4q1ynISmzE3hGPM9Be6YHTqKIV5cJMV4I/t5acUAmtoA0ZDZwFJZ
	 Xhtn6K2QjmC2m8kcaXQtoW6hm6i7i6ftydWGbz4NaX4Z4+eusKYne7Wkn+obgeAmXT
	 ZAro6EvqFMfyarc+0DCQK1pr4IvxYfG/sH2qKrOf2DC0CRcp1oKacQkGS3coNGURTT
	 SqWKKxeGhbwoA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87805C10F07;
	Fri,  8 Dec 2023 15:14:10 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Fri, 08 Dec 2023 16:14:12 +0100
Subject: [PATCH v2 5/8] iio: buffer-dmaengine: export buffer alloc and free
 functions
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231208-dev-iio-backend-v2-5-5450951895e1@analog.com>
References: <20231208-dev-iio-backend-v2-0-5450951895e1@analog.com>
In-Reply-To: <20231208-dev-iio-backend-v2-0-5450951895e1@analog.com>
To: devicetree@vger.kernel.org, linux-iio@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Frank Rowand <frowand.list@gmail.com>, Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702048448; l=2841;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=PHssvXjy9vdNnomVrtQNrYg62p1PVB5lyq+W1L3M6ig=;
 b=z/GQA4W/R6Y5X+RVBwzXMBqzM2inYW5ItGJfTsM2v5mvvGM6J3C6d7XyzEWIXaXmRGv/B1FS9
 5221rj/OdsSD6ni73F6P3i1x4eZ+6E6maNDBq8csAGQWGqVVk2Ppllw
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

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/buffer/industrialio-buffer-dmaengine.c | 6 ++++--
 include/linux/iio/buffer-dmaengine.h               | 4 +++-
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
index 5f85ba38e6f6..5bf8c5eb1853 100644
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
+EXPORT_SYMBOL_GPL(iio_dmaengine_buffer_alloc);
 
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
+EXPORT_SYMBOL_GPL(iio_dmaengine_buffer_free);
 
 static void __devm_iio_dmaengine_buffer_free(void *buffer)
 {
diff --git a/include/linux/iio/buffer-dmaengine.h b/include/linux/iio/buffer-dmaengine.h
index 5c355be89814..6c44da550b2c 100644
--- a/include/linux/iio/buffer-dmaengine.h
+++ b/include/linux/iio/buffer-dmaengine.h
@@ -10,8 +10,10 @@
 struct iio_dev;
 struct device;
 
+struct iio_buffer *iio_dmaengine_buffer_alloc(struct device *dev,
+					      const char *channel);
+void iio_dmaengine_buffer_free(struct iio_buffer *buffer);
 int devm_iio_dmaengine_buffer_setup(struct device *dev,
 				    struct iio_dev *indio_dev,
 				    const char *channel);
-
 #endif

-- 
2.43.0


