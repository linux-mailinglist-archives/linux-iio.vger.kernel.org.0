Return-Path: <linux-iio+bounces-7922-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 508B393CF8A
	for <lists+linux-iio@lfdr.de>; Fri, 26 Jul 2024 10:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B44128280B
	for <lists+linux-iio@lfdr.de>; Fri, 26 Jul 2024 08:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4CA17837B;
	Fri, 26 Jul 2024 08:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ehwDI3au"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33019176246;
	Fri, 26 Jul 2024 08:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721982181; cv=none; b=fR5zud1GScRxhHvHrj2vrUN11EySKJ5ZlXNISgNZlgNN4HE8a+e4Jh1MD9i1362R5Oh6kLVWC4x84npNYNnG1oGsYx5jgKG3/2LD36GMjywLTRFowlQ0U/v/us+DZDYKl3UZXEHpKsgmvWGihLXtMJ+5Bo8KfGSLXlJrzqSQYDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721982181; c=relaxed/simple;
	bh=zAvrC8FGXj77GiRK9gtP0Q61104VQzNebdy4cueU28w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VatwiGJlBf+EvXjgszFlqVP0u4J76YVwzA9wKq0VWvTLkk1TZ8/5B6gCJp1X5jY8TOp0e0yirKryVbe4t/FRfduHxqeMUHOJMk9k9g4J9jpLTg4xqS9hWfTz0qeIlaDkRoDTjo3+jcVQyql3RZ8xqjRfKkNpvfSuRza2klVyj40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ehwDI3au; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 157CBC4AF1C;
	Fri, 26 Jul 2024 08:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721982181;
	bh=zAvrC8FGXj77GiRK9gtP0Q61104VQzNebdy4cueU28w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ehwDI3auAxgTZpdDwi4Wyg6ORYenhF/Cp1OPouzlyFwAeAL6KVoYxiFr1LfhvfvtQ
	 lpuzjnnz/r+Q2ybkuPL9x9yIxPy+hbODuw0RJpDYtfmjllOIvJNCjZNqAKTyr+V/fS
	 IdIH25RnvN92n3T3sr5NcFiJH1JH6lqu4ujXfr5ZQF/mz7ZV6Fiysc9xvy/mxjeLn7
	 fvluLoN2w+1Rc74g1NsO99OzNmpjSGsUHO9rO9fIZ1wn6TAjkumR+aaYQq5+AaRqwN
	 iqnCkuFO7WBO77CfWB6leO9A0MAhogIYiK/XfHBbI4raAM7FZauIDZB8SRLOLk6Z8v
	 9w42zwA7Xxo/g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C3BEC3DA7F;
	Fri, 26 Jul 2024 08:23:01 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Fri, 26 Jul 2024 10:23:06 +0200
Subject: [PATCH 14/23] iio: adc: ti-ads1298: make use of
 iio_for_each_active_channel()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240726-dev-iio-masklength-private3-v1-14-82913fc0fb87@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721982178; l=942;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=WR4+V9qNOnxFXSApS/dE7riP9G9UG30sxOIHDEDM8pg=;
 b=ABjdENBRlRCm1CS6lUjav2Z/s60wYwXJeWfDm7wTp5gRDWxEqEEjBKnrGT0fNKD9FVFQeY+NR
 gjhZoRPlg+ZAWmTOxCUfM6XECTwSHGM9wtWZti30ZNSWyfuojIlio2D
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
 drivers/iio/adc/ti-ads1298.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ti-ads1298.c b/drivers/iio/adc/ti-ads1298.c
index 1d1eaba3d6d1..13cb32125eef 100644
--- a/drivers/iio/adc/ti-ads1298.c
+++ b/drivers/iio/adc/ti-ads1298.c
@@ -502,8 +502,7 @@ static void ads1298_rdata_complete(void *context)
 	}
 
 	/* Demux the channel data into our bounce buffer */
-	for_each_set_bit(scan_index, indio_dev->active_scan_mask,
-			 indio_dev->masklength) {
+	iio_for_each_active_channel(indio_dev, scan_index) {
 		const struct iio_chan_spec *scan_chan =
 					&indio_dev->channels[scan_index];
 		const u8 *data = priv->rx_buffer + scan_chan->address;

-- 
2.45.2



