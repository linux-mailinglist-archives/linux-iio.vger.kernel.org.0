Return-Path: <linux-iio+bounces-4356-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AFC68AAA18
	for <lists+linux-iio@lfdr.de>; Fri, 19 Apr 2024 10:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F12C31F2214F
	for <lists+linux-iio@lfdr.de>; Fri, 19 Apr 2024 08:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC65960262;
	Fri, 19 Apr 2024 08:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qwtw4NdW"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99ABA54FBD;
	Fri, 19 Apr 2024 08:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713515137; cv=none; b=KFJjL80B/eMrMKghlGLLtik1yNAABqlBoDWMG17AvdM2WF8ZGenTzVW8jbVcJ4NcflrSgXdd72CgjTbEzTeFy8BmU1tnbiIoZwuMa9buhvsbxfxcWSwVVF9awzAhLtX5W/eJQ2WK6ypc5h/62wRTgftAdPlF5WQsEnP2UaXMnTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713515137; c=relaxed/simple;
	bh=Fk4lWJpMLZkXmh2N8T8oTjFVOtwLh8aQfDOUkMx9F6o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M2UMRq7i2GSX43nyQoAgKdtHGdtjbuy++7LvYYhOIhS6Ex4J/t32juWTxIefqli8d3LREQ2w9eHOAk/SlRCaWqeQEvnH4SZ5kjo6V8VEQA87DRkyOaAevDFmJs7pCv+MYYSANJiLf8mnWfF7zoHvEB/WRcLloYgEFQ9tkM3C7Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qwtw4NdW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4E3BDC4AF0F;
	Fri, 19 Apr 2024 08:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713515137;
	bh=Fk4lWJpMLZkXmh2N8T8oTjFVOtwLh8aQfDOUkMx9F6o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=qwtw4NdWhXO4ffacAR3oCAfpXSdnfe9sT0wUDKdnXyln4o9Qw4VIFCP86pfwO+KM6
	 B3QpzWGb/jBgTqV4m+HM5UQ5I9lCykoe8P7SnGa8X9kZp5JLkl+3m0McVSrtqi35rH
	 H/JYJq9tHt8wozF4n/DJI/uqA5U1DXZ5X9wPmnJaFyAqoVdSethlgIB6NBesa1iq5o
	 +f7OjdeufsB6Im5V1q6GAppZJkROQqJwxaPn0ZuATXLnT9V+LZMYrAHUq1J/hTu/m6
	 jM95aJdT1uuNYlXyCCsY9kWG8RP+lRTSh5XC1WHH2bvYcL3duT+eSa+efMaHcUr7+z
	 yv16S1EMMfgDg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 473DCC04FF6;
	Fri, 19 Apr 2024 08:25:37 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Fri, 19 Apr 2024 10:25:38 +0200
Subject: [PATCH v4 05/10] iio: buffer-dmaengine: Enable write support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240419-iio-backend-axi-dac-v4-5-5ca45b4de294@analog.com>
References: <20240419-iio-backend-axi-dac-v4-0-5ca45b4de294@analog.com>
In-Reply-To: <20240419-iio-backend-axi-dac-v4-0-5ca45b4de294@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713515134; l=1350;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=hXi2S9a5+uGRDuzr8SCbjBuocFR5uBxzW+WmAaRiTGE=;
 b=1HjaJfeTFqtcxwQg6Ke89Msmv6kZWU6mZmkQcZqjYDR5GXWK+C0pEztEeiu2izjhETLtxKdXc
 kaLfHvesyVgAM9/jBLC2CldwjAvLvABXP8Z1QAXvb7fMErdjGtvQdk2
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



