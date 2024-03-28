Return-Path: <linux-iio+bounces-3856-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D4989000A
	for <lists+linux-iio@lfdr.de>; Thu, 28 Mar 2024 14:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02FBA1C23710
	for <lists+linux-iio@lfdr.de>; Thu, 28 Mar 2024 13:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97448060A;
	Thu, 28 Mar 2024 13:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fWHB4HcF"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760EE7EF1C;
	Thu, 28 Mar 2024 13:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711632151; cv=none; b=d5v1BEl7FZaXmMPJZUP9oTFJD1Z/q2aZgpB22wDCI/o7u74nuKfBMLhHALngz7dRolcPU/MwnZZjVG0PH+duwlhzQgjDaYlntFJZcw90Fpsgziu3RmD9q3M0u1Vqj20azYO/K+36wx7jC4H1U5cKVReYe5/MCOHvW3pfKSx4ovU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711632151; c=relaxed/simple;
	bh=Zhpd8WzkLG2F5zW5Uvp82LSK9+vK4KrStNMmwiVeLwg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Lx5Ypd5MVVswokmVfCMi5PURmhpUXDl35NLm4y1isT8iI5hmhFnqUif3bpAzWNsxB2QifqZ3IA/Jh/u1CTlDOy1hIueOopsEKC/sjzUvuQB3y0NbegpNyCoqLRMImNyppRHDWBzWGu5xqmqBSAtB6iYMY2tCuuQQeXZGmeUnWLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fWHB4HcF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1B89CC43390;
	Thu, 28 Mar 2024 13:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711632151;
	bh=Zhpd8WzkLG2F5zW5Uvp82LSK9+vK4KrStNMmwiVeLwg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=fWHB4HcF5mZFa2aNtlc0W980cIM0NEIQvsluRxl9D0CBoQPm73jippPIGSFXUk0SU
	 PQVuhryKV0VzF4PdbvcfU6SSBL913HqVIRa8X0Qsw4uJVJ7lvBPL3j9lYTI9SmM4jJ
	 7mJjixgfhef44yBBprWoEWnPgoYH10FDVsHn1r7442qvsB5EoM6ELwlOBNOJKTE6S/
	 kNZLW40EZQ8aUIwLmB/3Z0M9SwXlSut/mYv6J8S3vcqaa9DooE0oB6grWLN4fkrJP2
	 93r5DwuXjugc+q9X1xxTmI/AVz8E1zTsH0r2Xr+LyQGpuphj0CFbXIox+HP6UKCeth
	 v/g3oOSd7NLXg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 070ABC54E67;
	Thu, 28 Mar 2024 13:22:31 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Thu, 28 Mar 2024 14:22:25 +0100
Subject: [PATCH 01/10] iio: buffer: add helper for setting direction
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-iio-backend-axi-dac-v1-1-afc808b3fde3@analog.com>
References: <20240328-iio-backend-axi-dac-v1-0-afc808b3fde3@analog.com>
In-Reply-To: <20240328-iio-backend-axi-dac-v1-0-afc808b3fde3@analog.com>
To: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc: Dragos Bogdan <dragos.bogdan@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>, Nuno Sa <nuno.sa@analog.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711632149; l=1414;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=lt7Z8RtIdxVgrFaJw2wbb9LfqTru+QeAjVGlcUx2ZmQ=;
 b=YLdcKzTC+ACwMMpn0xzv2NB3s4QralrrXazg9t1SIQP7uy/w+RRq3Rgl7jmXevXFSEwPUZ2C1
 FVOvjF3XC2FCSohkp+rZmxd4a49eEsMvkPBYCx6aiO52KTdDgokTXhG
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sa <nuno.sa@analog.com>

Simple helper for setting the buffer direction when it's allocated using
iio_dmaengine_buffer_alloc().

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/industrialio-buffer.c | 7 +++++++
 include/linux/iio/buffer.h        | 3 +++
 2 files changed, 10 insertions(+)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 1d950a3e153b..4b1ca6ad86ee 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -1956,6 +1956,13 @@ void iio_buffer_put(struct iio_buffer *buffer)
 }
 EXPORT_SYMBOL_GPL(iio_buffer_put);
 
+void iio_buffer_set_dir(struct iio_buffer *buffer,
+			enum iio_buffer_direction dir)
+{
+	buffer->direction = dir;
+}
+EXPORT_SYMBOL_GPL(iio_buffer_set_dir);
+
 /**
  * iio_device_attach_buffer - Attach a buffer to a IIO device
  * @indio_dev: The device the buffer should be attached to
diff --git a/include/linux/iio/buffer.h b/include/linux/iio/buffer.h
index 418b1307d3f2..7e70bb5adc01 100644
--- a/include/linux/iio/buffer.h
+++ b/include/linux/iio/buffer.h
@@ -55,4 +55,7 @@ bool iio_validate_scan_mask_onehot(struct iio_dev *indio_dev,
 int iio_device_attach_buffer(struct iio_dev *indio_dev,
 			     struct iio_buffer *buffer);
 
+void iio_buffer_set_dir(struct iio_buffer *buffer,
+			enum iio_buffer_direction dir);
+
 #endif /* _IIO_BUFFER_GENERIC_H_ */

-- 
2.44.0



