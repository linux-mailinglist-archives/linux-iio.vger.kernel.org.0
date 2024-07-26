Return-Path: <linux-iio+bounces-7916-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B718093CF87
	for <lists+linux-iio@lfdr.de>; Fri, 26 Jul 2024 10:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30924B22590
	for <lists+linux-iio@lfdr.de>; Fri, 26 Jul 2024 08:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442751779B1;
	Fri, 26 Jul 2024 08:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MKVrDng1"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDAE176FB8;
	Fri, 26 Jul 2024 08:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721982181; cv=none; b=CNNU5ss6AsgIaRomUqy5GDMtQoGp7XRyNy9onKotPcpjO+KR+BlVH4riSJ3zyS5o2th5TY6IXcECZQI6XZOgpZUD1vhxJAdUARHXg4LBqBrciMjct9KSyC++xKOrzzJVBtGrlVkM9DUAMatcrXXYdR/FHa6hbii8tim/PjSeLE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721982181; c=relaxed/simple;
	bh=npJc2jnvH/dPxB/J6J0wM53WWdN+Ko3nas9x7/U+dmM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WCINWA54MHgaaPV1pwoRHfNzf6Sr8p/pnjJfyN9azgJyVxiwbGa+vrqWKuYAdzZhJTtfB8lCBpo7/wlkxTyaAb1N7wVrse1fv39Jd+zFfejpXW9J7tni2KUgVvV4tGRjak2LjJTtD1ZHZ/iETV+uFWemSWvm6HF3lxTJr4i/JPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MKVrDng1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B426CC4AF18;
	Fri, 26 Jul 2024 08:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721982180;
	bh=npJc2jnvH/dPxB/J6J0wM53WWdN+Ko3nas9x7/U+dmM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=MKVrDng1JsxKU47Qb5IDzXTzB/FovmCUpqyz3wccfZjzgXj12zFC+JTMYX0omXmy/
	 h9vdQnd1vDLqrpTiiumtjhLu2HfQbXSklz9XdTcEc+/0HGngDhzsXTWiNysrLDC9kA
	 bZzE/6QFD/zZJn+rwwzGKSkQNIyqtfTi5gjHevYl3n6jvRu7AjIxkp1a2nnuP6dqNV
	 S+A4kHZhAUD5N7+ZqoRjHJpmDk3p9zC7e/6SzcqUbrHFMZ6LnDjnSBVG0eS4ZcKd5d
	 RDHZAyft9WhytS/Rywdd9/jvjlWU4vAoN0hFRNXzf0jHmJGIu143HMDJVyOjXFAO/r
	 +aMjtqgW+LCOg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA84AC3DA49;
	Fri, 26 Jul 2024 08:23:00 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Fri, 26 Jul 2024 10:23:00 +0200
Subject: [PATCH 08/23] iio: adc: stm32-adc: make use of
 iio_get_masklength()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240726-dev-iio-masklength-private3-v1-8-82913fc0fb87@analog.com>
References: <20240726-dev-iio-masklength-private3-v1-0-82913fc0fb87@analog.com>
In-Reply-To: <20240726-dev-iio-masklength-private3-v1-0-82913fc0fb87@analog.com>
To: linux-iio@vger.kernel.org, linux-staging@lists.linux.dev
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Ramona Gradinariu <ramona.gradinariu@analog.com>, 
 Antoniu Miclaus <antoniu.miclaus@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 Marcus Folkesson <marcus.folkesson@gmail.com>, 
 Kent Gustavsson <kent@minoris.se>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Heiko Stuebner <heiko@sntech.de>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Francesco Dolcini <francesco@dolcini.it>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>, 
 Haibo Chen <haibo.chen@nxp.com>, Michal Simek <michal.simek@amd.com>, 
 Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721982177; l=1283;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=HE1VRfKigITTw2AxPcLnqYl/S+jcBrR+clI++DNvuZY=;
 b=9eZZNY65VYVI3/oJnoG7KIr0BFD5g/ISCZ/fLKLzQaQJqqaSP9foay89jKBytQDgUTA3QmIcJ
 3R8FxHZNySCAfVlpHSCHjNUtqxxlKO42/2PQuPodX4RejQRdzIKMq6v
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sa <nuno.sa@analog.com>

Use iio_get_masklength() to access '.masklength' so it can be annotated
as __private when there are no more direct users of it.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/adc/stm32-adc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
index 375aa7720f80..c901ba1bc6ba 100644
--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -1261,7 +1261,7 @@ static int stm32_adc_conf_scan_seq(struct iio_dev *indio_dev,
 	stm32_adc_writel(adc, adc->cfg->regs->smpr[0], adc->smpr_val[0]);
 	stm32_adc_writel(adc, adc->cfg->regs->smpr[1], adc->smpr_val[1]);
 
-	for_each_set_bit(bit, scan_mask, indio_dev->masklength) {
+	for_each_set_bit(bit, scan_mask, iio_get_masklength(indio_dev)) {
 		chan = indio_dev->channels + bit;
 		/*
 		 * Assign one channel per SQ entry in regular
@@ -1619,7 +1619,7 @@ static int stm32_adc_update_scan_mode(struct iio_dev *indio_dev,
 	if (ret < 0)
 		return ret;
 
-	adc->num_conv = bitmap_weight(scan_mask, indio_dev->masklength);
+	adc->num_conv = bitmap_weight(scan_mask, iio_get_masklength(indio_dev));
 
 	ret = stm32_adc_conf_scan_seq(indio_dev, scan_mask);
 	pm_runtime_mark_last_busy(dev);

-- 
2.45.2



