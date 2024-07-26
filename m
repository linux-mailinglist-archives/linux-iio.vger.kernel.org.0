Return-Path: <linux-iio+bounces-7925-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B61893CF8E
	for <lists+linux-iio@lfdr.de>; Fri, 26 Jul 2024 10:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27DA3282E0A
	for <lists+linux-iio@lfdr.de>; Fri, 26 Jul 2024 08:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F8B178389;
	Fri, 26 Jul 2024 08:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XXVb1pjr"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63325178371;
	Fri, 26 Jul 2024 08:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721982181; cv=none; b=QWwZA8N8AgYL+CpGJXK2e3cxh9/Md5HtWnX2oE9+icZ6BXCMmQQ3KvyPXhGYUunKg8iLb5Or9VJkEu6fEDJUVeMhUNbklvfueNNMbfpHZH1nFwd/ngMhChp50uQfnU04V9l1lSgf91GfqBqhfo1lyDQcxwoQx4eC9lTNSgtrECM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721982181; c=relaxed/simple;
	bh=s3XYHeiqfx5M0rPGyIr8GFtHULw30fcBEQeLoshTKRM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QgTIxr6VXT6eITQyticc3lFzsbnut/0NI3Rzk/Oqmpv+ncnQfnN9s6oh2YITcUfWPv2NxzLyOb1LPKYHLm+3sdSrKGxLqCZNvj1k66hbVaF7LRqAp1HPFzDoPvbiH2hCXao1RdRSc1twR76VvbPG2NQHzVEYwa9D0S0KmriJDEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XXVb1pjr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 452CFC4AF4D;
	Fri, 26 Jul 2024 08:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721982181;
	bh=s3XYHeiqfx5M0rPGyIr8GFtHULw30fcBEQeLoshTKRM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=XXVb1pjruYJE46zySPWI5Yhw8veWhHjHSjlRvthY5Qjob6BPqTyNnfmAUQ5IXa/Ye
	 bUFNxkrw4k/F+EEJD7dnTq9PGwCJP0QkBR5mR2zPnTF8a9jnZ3scKR6aqgfVQ5suDJ
	 9TOgbeiwANwNr/dgQ8ZAKFsrnSJKh/+/+SgmXJGq6tewoW7ayrCn195m6ZnoSMQdaZ
	 Dhb7e7Q28mOZ2HHAesalDsLHB45u7eZAdsxFZpGzqDgKq0VjkVA1FYXLjU/OlogLI/
	 vZDHdqLsUxQtr8KbZHFT6ITQ9lgVesPlSotglJUTcRy4+LvFfWa56rBcknhpC6J4ry
	 M3/3uTM3STnDg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B364C52CDA;
	Fri, 26 Jul 2024 08:23:01 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Fri, 26 Jul 2024 10:23:09 +0200
Subject: [PATCH 17/23] iio: adc: ti-ads131e08: make use of
 iio_for_each_active_channel()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240726-dev-iio-masklength-private3-v1-17-82913fc0fb87@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721982178; l=906;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=Wmj4heT1Vtbx3+Qw30Meikm6rdXb9sWv/ExTDPPdk4A=;
 b=0GFuG/6wJrEjIxNPymKrc3E/xuuUKG+CQZ5h5YQM00UjbUYs0fj5bjauhcuGVCMG0z8H47IEP
 R9/V1RWlxOyDxSrc451CqehO5i8yKtdPZt4za9xGbhvcVgRFIb+W0pm
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
 drivers/iio/adc/ti-ads131e08.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ti-ads131e08.c b/drivers/iio/adc/ti-ads131e08.c
index 96dd9366f8ff..55366ffb0489 100644
--- a/drivers/iio/adc/ti-ads131e08.c
+++ b/drivers/iio/adc/ti-ads131e08.c
@@ -637,7 +637,7 @@ static irqreturn_t ads131e08_trigger_handler(int irq, void *private)
 	if (ret)
 		goto out;
 
-	for_each_set_bit(chn, indio_dev->active_scan_mask, indio_dev->masklength) {
+	iio_for_each_active_channel(indio_dev, chn) {
 		src = st->rx_buf + ADS131E08_NUM_STATUS_BYTES + chn * num_bytes;
 		dest = st->tmp_buf.data + i * ADS131E08_NUM_STORAGE_BYTES;
 

-- 
2.45.2



