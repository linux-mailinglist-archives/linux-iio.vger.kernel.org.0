Return-Path: <linux-iio+bounces-7910-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5843F93CF80
	for <lists+linux-iio@lfdr.de>; Fri, 26 Jul 2024 10:23:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0781F1F21789
	for <lists+linux-iio@lfdr.de>; Fri, 26 Jul 2024 08:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8D3176FBB;
	Fri, 26 Jul 2024 08:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r9ev5Wc8"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65641369B1;
	Fri, 26 Jul 2024 08:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721982180; cv=none; b=pswam8sAw2Yi2vk4v1lLV4wZpnC54izsc5LGEXjE51p63V/EnpAaN8CTh+SlK00RUR2xyH714bSfWxSjXb1pjyACcM8V4MZvG3EI/tgV3WCTKXa2W5kMRLELUr9rgU8Cl+iJ5bPZChsWFVgV9TuEoRIEl+1eVGqUxgPhSJ00XNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721982180; c=relaxed/simple;
	bh=RPBEfCLtoa80U8IeuyjR+FaVitU17yph6ofsmxSLDx8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kzcbRhsgJL3g1rdI2G29/itZKbxCYhxYVafLaJHHBqFcjyQU62X1nGP0o8z/BeBtIE412ib3DOL63WSt6m7f3/+hEIvHhxeNqryg8Ma90WQ/P15HJR3wqvhWUjbODNvlyRFqDbbxfyvOtgFQPWPHEkeWH26uIe23WPCOX/HSOZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r9ev5Wc8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5782FC4AF0C;
	Fri, 26 Jul 2024 08:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721982180;
	bh=RPBEfCLtoa80U8IeuyjR+FaVitU17yph6ofsmxSLDx8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=r9ev5Wc81gkusJDluvt6MnbsFTG2VaIuMyXMbAb7d6R7RhTYnD4Wau5vczy2E9Dif
	 jw6usYlyjMo/W7B5MxSddnbKC2ogetAuC4LYyK4nP6ey51abLYOyU0OGrOwi0w9VgM
	 CauUX5vOPjR2K6yaH5Ib5kiEVH/6cwAIRlb3gm6EIkCT04vGdFEmGd65ibF4p974WX
	 c4CohE+vZ8Ylw+9JJO8ZroG7SxclNElvxAFEigVvF+x0YRcBEjYIMMtI+/EnC979tg
	 7X1hgLjWjIrHFsaeEvcvzUb6eaxo7ilNqijRs+0M4hWhZhyoOcTStyN/BU98dYLsCt
	 xAJUMTF9Gt8HA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F6EC52CD9;
	Fri, 26 Jul 2024 08:23:00 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Fri, 26 Jul 2024 10:22:55 +0200
Subject: [PATCH 03/23] iio: adc: max1118: make use of
 iio_for_each_active_channel()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240726-dev-iio-masklength-private3-v1-3-82913fc0fb87@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721982177; l=908;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=DheHP5b+88AM4ORpC6YZejcYJvF8p0nEHYsD327C5Lo=;
 b=nR8wiqJfPj5SHRIp+IERpQJn9KAS+AJCAFr3ozletUYp9vHcgbtiCQsB9n9U2E5NNY94bbTCb
 QQ5pssu/6cdAz3E042P0iY/qXS2RbX1bc4Iw14KDSLSwJtoquhtydEG
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
 drivers/iio/adc/max1118.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/adc/max1118.c b/drivers/iio/adc/max1118.c
index 75ab57d9aef74..0beccfde81f26 100644
--- a/drivers/iio/adc/max1118.c
+++ b/drivers/iio/adc/max1118.c
@@ -174,8 +174,7 @@ static irqreturn_t max1118_trigger_handler(int irq, void *p)
 
 	mutex_lock(&adc->lock);
 
-	for_each_set_bit(scan_index, indio_dev->active_scan_mask,
-			indio_dev->masklength) {
+	iio_for_each_active_channel(indio_dev, scan_index) {
 		const struct iio_chan_spec *scan_chan =
 				&indio_dev->channels[scan_index];
 		int ret = max1118_read(indio_dev, scan_chan->channel);

-- 
2.45.2



