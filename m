Return-Path: <linux-iio+bounces-7912-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86FC893CF82
	for <lists+linux-iio@lfdr.de>; Fri, 26 Jul 2024 10:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D0EA1F2192D
	for <lists+linux-iio@lfdr.de>; Fri, 26 Jul 2024 08:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C81176FC5;
	Fri, 26 Jul 2024 08:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UR51aywX"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0EA1176AB9;
	Fri, 26 Jul 2024 08:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721982180; cv=none; b=RysGoAEFo5BYwlsB5h16ii+Wc+eAiNercIQmh97Fj9Nsi15G4juKOf+iCySd7iyoka5sOOqWx4djIx6tEYUX+sYjn23Eq+eBf+6/txxPf45OcdT532a++mcNM1JjmGmzwgTPN9fNzBrSbjQmz1kBoA1rsTXKKS/SVJdex6M46cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721982180; c=relaxed/simple;
	bh=oe8PYLHkYuPtuvvy0SJEHViBy3af2R0M3XExrRg7rHg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g7wJ9BDQlHBm0h+szSN46jDnu7vFybdcsF0JwpoMslyenbpw2zhqp20z1COpSIN2gttyaDIugf6SHwThqhyxpOigqaKbTsawEMGMh22gxCuuhUn1jl8Ovf6aQG4Sh3XPRfghISP+IwrdYD/USL29J+mPEdlT1nO2KMJ4BYchPX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UR51aywX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 620BBC4AF0E;
	Fri, 26 Jul 2024 08:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721982180;
	bh=oe8PYLHkYuPtuvvy0SJEHViBy3af2R0M3XExrRg7rHg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=UR51aywXSxEx1yhZR0OVsujJjEHRcbUoMk67jZ4JFSGiddvjClYA4ZzAWRHf9p7W9
	 D3VzEt5epjMykl+COcuYQ2op4wXH+3vJtnbBMDq5c67/FHWU9otCzhh5CYi3N79HUn
	 pD0zOTlfUqNRDEdftjE1IRFsZB0ze39DLzmDwJy4rdxNQdaBizaMjsUmakeRtXQIMU
	 tAOelIu/lHpv+ZT885a1WSCnF2lFRuuQqa8EHmTm+n0h9qy+qHxpOf+r0qiqfWVmeh
	 hojf1vBqt4oybROwemIVzQ7qegj+Vc7g1N+iYy47Y+dF9xXbi7k4YazZI7DKxKiYF4
	 7ToawGv2n823g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B0E5C49EA1;
	Fri, 26 Jul 2024 08:23:00 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Fri, 26 Jul 2024 10:22:56 +0200
Subject: [PATCH 04/23] iio: adc: mcp3911: make use of
 iio_for_each_active_channel()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240726-dev-iio-masklength-private3-v1-4-82913fc0fb87@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721982177; l=912;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=1KkCvDVTiQQj9ZCfOwbqyke/aSJNCQQgce+lEqp7arg=;
 b=PJ2ERIm3Y7YQuE/0nS2Vit1UFVvEoKeXYXfuf3k/e+LbI0UTkLnUDl5YVrxAwSfRt56phG3a9
 4HFRT841yy7AJJB/KM++DvIe7hx5B2xCZk1nZqsWiCPjqau+3H0mmJB
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
 drivers/iio/adc/mcp3911.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
index 5076028f541d..d0e77971c5d3 100644
--- a/drivers/iio/adc/mcp3911.c
+++ b/drivers/iio/adc/mcp3911.c
@@ -510,7 +510,7 @@ static irqreturn_t mcp3911_trigger_handler(int irq, void *p)
 		goto out;
 	}
 
-	for_each_set_bit(scan_index, indio_dev->active_scan_mask, indio_dev->masklength) {
+	iio_for_each_active_channel(indio_dev, scan_index) {
 		const struct iio_chan_spec *scan_chan = &indio_dev->channels[scan_index];
 
 		adc->scan.channels[i] = get_unaligned_be24(&adc->rx_buf[scan_chan->channel * 3]);

-- 
2.45.2



