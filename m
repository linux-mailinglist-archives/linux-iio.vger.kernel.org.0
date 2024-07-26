Return-Path: <linux-iio+bounces-7915-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7493993CF83
	for <lists+linux-iio@lfdr.de>; Fri, 26 Jul 2024 10:23:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2492D1F21551
	for <lists+linux-iio@lfdr.de>; Fri, 26 Jul 2024 08:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE5A1779AB;
	Fri, 26 Jul 2024 08:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ATLxxCSb"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC37176FB6;
	Fri, 26 Jul 2024 08:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721982181; cv=none; b=IXQTiH2lp36pyXmPmWfdK4/gFIUTbzThxN/UcLeEaAoNVbuR7LkIFcos9TDcSfobKJkXtlrsOi9nGGdka1EDIKRUArchBjSlc3ddVfbRWgjKV0IvTtChi/0LvqMy55fCTE7s7UNBO8zMcr+JUoxW5CbjIkS1VN0sS7dExnPAKLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721982181; c=relaxed/simple;
	bh=nC3POYv192Z+FAIp5HPmb/0r9WThvP45ju6pKT6D49w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Oep5n9/6CmXZ9oxhkMFTW/kUGYqhuGi2Zo4o4sL3bXJfXdMyNS1whVzuSxzh+ErOmHqqltwRu+rlRlGCeTClO1LSAulWofe+sdCV9nqKHGkDL4LUlrToWHFRjjN5Wv+5MNVYS9ViHH9jmHoft0/ZkXLf+LX7LjIwoBO6ltd/Pvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ATLxxCSb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 950B7C4AF17;
	Fri, 26 Jul 2024 08:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721982180;
	bh=nC3POYv192Z+FAIp5HPmb/0r9WThvP45ju6pKT6D49w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ATLxxCSbDWgYbY3SBmqoq0y8UlPmnRz7Wjnvy3lDgWVeQ5/AS9p++0mv0yupyr0Vp
	 49Bd3XnL2Ifo+5f3rRvOJ0Bv2mNPaGX5gJ2JraK2IJrjqBTkxX308QXHtt0FRUjLd2
	 p3NBuOM8By5u5/urGQfBKJSvCsGNsIcQhWyOeLB01WHwFQt622EHAHBZ3jsZtul5G7
	 CPfDsBU2M8NhNBAO//aYlH4dbODa9iiUv/n0/78CLNQsr9Qfccdx1q5XLeKujP33yZ
	 iwjzsETR8rqwzEPdHpMsEMDrPlKcyYsjDt6tyrg5wvI/ofoJ3rfN+WJOa45l8dW29G
	 CmGLtZeom0WDA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 885FFC52CD9;
	Fri, 26 Jul 2024 08:23:00 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Fri, 26 Jul 2024 10:22:59 +0200
Subject: [PATCH 07/23] iio: adc: rtq6056: make use of
 iio_for_each_active_channel()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240726-dev-iio-masklength-private3-v1-7-82913fc0fb87@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721982177; l=858;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=knlH5er1Yg2N7YkeYPSV+hi3/osuANfnkU/1A8ZVm0o=;
 b=cY8pNc37aUPu8/EBSFXkrJw4+uaxKK/uqMIFOeCukrXb0tR8pIhG0Zu7SZRe9uuPCDVEOOtcn
 bPyoSwhTa98BeM8Atlz+0uJM0UB+ZpYt2mQISSSoVoMrlJ3MfDRKqfm
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
 drivers/iio/adc/rtq6056.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/rtq6056.c b/drivers/iio/adc/rtq6056.c
index bcb129840908..45b1b81c9fdd 100644
--- a/drivers/iio/adc/rtq6056.c
+++ b/drivers/iio/adc/rtq6056.c
@@ -643,7 +643,7 @@ static irqreturn_t rtq6056_buffer_trigger_handler(int irq, void *p)
 
 	pm_runtime_get_sync(dev);
 
-	for_each_set_bit(bit, indio_dev->active_scan_mask, indio_dev->masklength) {
+	iio_for_each_active_channel(indio_dev, bit) {
 		unsigned int addr = rtq6056_channels[bit].address;
 
 		ret = regmap_read(priv->regmap, addr, &raw);

-- 
2.45.2



