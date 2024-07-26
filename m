Return-Path: <linux-iio+bounces-7913-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD4FE93CF85
	for <lists+linux-iio@lfdr.de>; Fri, 26 Jul 2024 10:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 476ADB22523
	for <lists+linux-iio@lfdr.de>; Fri, 26 Jul 2024 08:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B33D17799F;
	Fri, 26 Jul 2024 08:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FL5Nn1Qs"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE584176FAE;
	Fri, 26 Jul 2024 08:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721982181; cv=none; b=bBp5Z4R5H6y9ZigLT4gNzOAuu5yWl65yDqKlqhBNohYPBhzDbryVdH9Gat6O84Md5ROkmKOa5fOQPPrjgu4cLW4Q2n5t9d2ErZM38ImpWe74vdFZ5PN08KjwBQp01+v+Y9mN8x+VgpADlg5Xlvxveapl687uRVbadLHlo1E9hHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721982181; c=relaxed/simple;
	bh=kNqJmyZGWi2s9us3oGct7nOLdZkNx3oLHbRT8zBEtls=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UbSROcIey1L6tivR0H2eg9FjT82mAqKD2lGSrDFYICiANr1jHkw288jaL5IdAZKprun+88IBOOzu4T8NMh/1BHJwBApqMF+4X/RDySsyXBwG45VAq6+3KSrqg4gwHs6ujXZlUbdYJ3Bl/1Bj/9IaEle4m2tZckGlaLtGBxP4m60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FL5Nn1Qs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 811A7C4AF15;
	Fri, 26 Jul 2024 08:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721982180;
	bh=kNqJmyZGWi2s9us3oGct7nOLdZkNx3oLHbRT8zBEtls=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=FL5Nn1QsuDMybWNcqEEK2hAHX7ocj66RksypVQzUbMFD2dDPvTXY+ZJzBd8U1rspB
	 lTCoeBMI1TFnT3cMRP6TJLgq28zz0Yl7k8yqE3s7aS8ErBiJpWp+r8iK5IuGKTctFU
	 GHIYQ4yIqBTYSgStzos/+tm7JGa/i/CmQpGXh8oWlndDLpLPvRrSN9TNwOnzYgzbnc
	 NjYrJfMrg/icGp5goGywFTmeVoXSLOZkWQiMunCu905yn50ypO9JOMZUBweHI9LOVX
	 Xi1mRy3D4NjnzdaNnF0lf7Ez1BE+c50we1GSjhZKYIMg5GtVyr+KwoGNWaFI71xsYO
	 kII6hj5dhyIbg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76EC7C3DA7F;
	Fri, 26 Jul 2024 08:23:00 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Fri, 26 Jul 2024 10:22:58 +0200
Subject: [PATCH 06/23] iio: adc: rockchip_saradc: make use of
 iio_for_each_active_channel()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240726-dev-iio-masklength-private3-v1-6-82913fc0fb87@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721982177; l=888;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=CPgO/DJbybSsX9tw6RI8AmAF/l5lhTR2BFhQ3+DOBN4=;
 b=GslRyKXkKOLyJ9HqY5PxGnpcWyf9VjVwP1HcWdEyeOC1yI1DvgKx3NIOCi5F74r/vlPXvm5Mx
 j8vL1Eao0FgCN3tnnYPJHz1bTtWbGOSPQ8o/OOdHCS3ImkmPaj0Y0Qd
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
 drivers/iio/adc/rockchip_saradc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
index bbe954a738c7..71f58e3a8307 100644
--- a/drivers/iio/adc/rockchip_saradc.c
+++ b/drivers/iio/adc/rockchip_saradc.c
@@ -370,7 +370,7 @@ static irqreturn_t rockchip_saradc_trigger_handler(int irq, void *p)
 
 	mutex_lock(&info->lock);
 
-	for_each_set_bit(i, i_dev->active_scan_mask, i_dev->masklength) {
+	iio_for_each_active_channel(i_dev, i) {
 		const struct iio_chan_spec *chan = &i_dev->channels[i];
 
 		ret = rockchip_saradc_conversion(info, chan);

-- 
2.45.2



