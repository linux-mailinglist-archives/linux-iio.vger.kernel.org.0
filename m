Return-Path: <linux-iio+bounces-4202-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 249138A2F8D
	for <lists+linux-iio@lfdr.de>; Fri, 12 Apr 2024 15:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78E46B21E43
	for <lists+linux-iio@lfdr.de>; Fri, 12 Apr 2024 13:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB1A84A4F;
	Fri, 12 Apr 2024 13:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nHMNVskN"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7EE83CD3;
	Fri, 12 Apr 2024 13:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712928971; cv=none; b=Mp1hcYKwrHvDL9QOR4PdILpi34Z1u9zKT6r+P2FCIf1myVKO8SPe8dqAklyYqxQCevxAoix3PPQVPfsKr1lADPVe7qZSAVowRGa3u2ewciQudBWStGgtQHPIlJ9HakEVt6uEgBH32uWWsk8ztgJ6gPSWq7Ftr591zShJaUL0nXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712928971; c=relaxed/simple;
	bh=Fk4lWJpMLZkXmh2N8T8oTjFVOtwLh8aQfDOUkMx9F6o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jjnnqo37mkcS2QAngwkW5d4YAfRz6piHpHoZIwbJSZYcypBTiytEjxn4mwR4a1xpotiPi/lI/e6l0fRUMGxGHVTHz2Pl38r0MD6Nd+YwDDxpn24e/2usJ4tEJWDTr7Ife2bhJPW7cE1zdiurNfF2cBswYf0XaPq0VUBakMYEpTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nHMNVskN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 782DAC4AF09;
	Fri, 12 Apr 2024 13:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712928970;
	bh=Fk4lWJpMLZkXmh2N8T8oTjFVOtwLh8aQfDOUkMx9F6o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=nHMNVskN6EC//lgBVOuLfYyytQrFVnV+XzmrAsKfqjtw8mKt8XgDzSRQmiF/m/fv4
	 mpANs9LLfUirjxwoR8130iC2Pitul5uN2ZRHNS6Obj40WKAKyY6Cid8E9ej/GfcHgf
	 QhCuWFeqTkXXcsxEhAkHGmIZaNq6HMnVhJSI3R8o65AJZX+fUwb01Bxl7LWaJaXjAL
	 D38BFw4LrThNqnPe9/lTWhTeDfobkHuGKo6rrkuAwTosZ68F+UbNPuC3tfN2In/ByM
	 uHQx0xg7oKTG3114HNkZ+noHMrAleAhF1+WBATOxmwJ90AfWac3YEwf2gRJafx/hly
	 7DWoNWgTMSgvA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB68C04FFF;
	Fri, 12 Apr 2024 13:36:10 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Fri, 12 Apr 2024 15:36:12 +0200
Subject: [PATCH v3 05/10] iio: buffer-dmaengine: Enable write support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240412-iio-backend-axi-dac-v3-5-3e9d4c5201fb@analog.com>
References: <20240412-iio-backend-axi-dac-v3-0-3e9d4c5201fb@analog.com>
In-Reply-To: <20240412-iio-backend-axi-dac-v3-0-3e9d4c5201fb@analog.com>
To: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc: Dragos Bogdan <dragos.bogdan@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>, 
 Paul Cercueil <paul@crapouillou.net>, 
 Alexandru Ardelean <ardeleanalex@gmail.com>, Nuno Sa <nuno.sa@analog.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712928968; l=1350;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=hXi2S9a5+uGRDuzr8SCbjBuocFR5uBxzW+WmAaRiTGE=;
 b=Hho+1y4yMOhp7Uvnab8mYWZeIid+YIkJAJtngeXmY5D23rkRjSaScfQR+JPDdQ+yHzpU9iT3B
 EzlFjO0XcG7Dl+SZayB/O3AeRDPbZlEx6k8oq7OapPX163z5RtsfxY8
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Paul Cercueil <paul@crapouillou.net>

Use the iio_dma_buffer_write() and iio_dma_buffer_space_available()
functions provided by the buffer-dma core, to enable write support in
the buffer-dmaengine code.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>
Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/buffer/industrialio-buffer-dmaengine.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
index 051e1758e020..e5492572b248 100644
--- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
+++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
@@ -123,12 +123,14 @@ static void iio_dmaengine_buffer_release(struct iio_buffer *buf)
 
 static const struct iio_buffer_access_funcs iio_dmaengine_buffer_ops = {
 	.read = iio_dma_buffer_read,
+	.write = iio_dma_buffer_write,
 	.set_bytes_per_datum = iio_dma_buffer_set_bytes_per_datum,
 	.set_length = iio_dma_buffer_set_length,
 	.request_update = iio_dma_buffer_request_update,
 	.enable = iio_dma_buffer_enable,
 	.disable = iio_dma_buffer_disable,
 	.data_available = iio_dma_buffer_usage,
+	.space_available = iio_dma_buffer_usage,
 	.release = iio_dmaengine_buffer_release,
 
 	.modes = INDIO_BUFFER_HARDWARE,

-- 
2.44.0



