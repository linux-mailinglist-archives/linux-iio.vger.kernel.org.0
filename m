Return-Path: <linux-iio+bounces-7917-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B59093CF86
	for <lists+linux-iio@lfdr.de>; Fri, 26 Jul 2024 10:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 468171F2164C
	for <lists+linux-iio@lfdr.de>; Fri, 26 Jul 2024 08:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56720178364;
	Fri, 26 Jul 2024 08:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H8Hk8lGX"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AD4176FC9;
	Fri, 26 Jul 2024 08:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721982181; cv=none; b=nllMSobhYGf/8LI8u+uyzHFo4nuyoujuRgocgJjqSwA5qbPRut0kFXVCPMaxugn+aJnkL3h3kcsmMUEPcglg9l7rny5WcsAuKfYNs46j5W0DJzGheM6aSdH74nyvxi7Ys/0sa+q9Z80zgIEOAhMWWSNoJ8TFTk4kByjQKQ2g6MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721982181; c=relaxed/simple;
	bh=DYjDQzEKOXmhB8PTzPSGHJzBrh3vcbTTXhqdNbtWjhU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z5YMN8xXFb4vdnxMUP0kjfFdBmkrZJAiMChY7eEZeECjFQ207NG4ihStt3TBxVlcBOtB56krGYhorh6nUVL/P287EnzkvV4cBr0cVzJyg88fQqcigQDRhEiAuYmDiQzZoilm3BNlZiKzOiynlmXWtyGo1MtR0wc4PPqJePoVTJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H8Hk8lGX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D9171C4AF1A;
	Fri, 26 Jul 2024 08:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721982180;
	bh=DYjDQzEKOXmhB8PTzPSGHJzBrh3vcbTTXhqdNbtWjhU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=H8Hk8lGXCGuqIaXb8Si0n0bpYqZZwOXNroYpkGQxYe6mjRZgcjN7errPH2yT79vR2
	 1Bm4GvBHD/89LnDRiRshChf1zx4UH62bqTQkFSfH7gxV9AQwmpmZd2MiEGxqlxMJCb
	 Ar3N5XC7ECs/r/e4N3YDuynJeMP1AlNjEDpwPqok7IVand1arjankDMsJP+/ufnMhv
	 z/nr4a2GlKYl1fzNDOiAL5ZF1kdExAZUiIRtx5K5ZcgGJp/1r8m+YzRCUhbI6W9MDw
	 PFiGcjzFNM4SnZKhOAQgPBMBvxnpJ45m7oS8f6NfIaSX64Mr/h7KDYTDYYxEpYpVH5
	 sfXqDankE6XoA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A4CC3DA49;
	Fri, 26 Jul 2024 08:23:00 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Fri, 26 Jul 2024 10:23:03 +0200
Subject: [PATCH 11/23] iio: adc: ti-adc084s021: make use of
 iio_for_each_active_channel()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240726-dev-iio-masklength-private3-v1-11-82913fc0fb87@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721982178; l=929;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=pDmrdCKFwcJ+Q8/Qez1fqIpNvLhBZN1RCKpdGSXSeW8=;
 b=jXDGG3lYnq+qxjsUL1eRmtxRuz45PCumiCb1suSE7NNVTuUyrTBJ89inAB3uLkgAQpIWkkdGW
 DFLCbD7PhK6ADOI5S9Cke0sMXm4swWFQ9uRQLHHEIl6fI0OEPmQXk93
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sa <nuno.sa@analog.com>

Use iio_for_each_active_channel() to iterate over active channels
accessing '.masklength' so it can be annotated as __private when there are
no more direct users of it.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/adc/ti-adc084s021.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ti-adc084s021.c b/drivers/iio/adc/ti-adc084s021.c
index 1f6e53832e06..4a07c6295a2b 100644
--- a/drivers/iio/adc/ti-adc084s021.c
+++ b/drivers/iio/adc/ti-adc084s021.c
@@ -166,8 +166,7 @@ static int adc084s021_buffer_preenable(struct iio_dev *indio_dev)
 	int scan_index;
 	int i = 0;
 
-	for_each_set_bit(scan_index, indio_dev->active_scan_mask,
-			 indio_dev->masklength) {
+	iio_for_each_active_channel(indio_dev, scan_index) {
 		const struct iio_chan_spec *channel =
 			&indio_dev->channels[scan_index];
 		adc->tx_buf[i++] = channel->channel << 3;

-- 
2.45.2



