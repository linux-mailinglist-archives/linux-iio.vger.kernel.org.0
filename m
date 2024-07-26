Return-Path: <linux-iio+bounces-7924-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF6C93CF8D
	for <lists+linux-iio@lfdr.de>; Fri, 26 Jul 2024 10:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE3AB282462
	for <lists+linux-iio@lfdr.de>; Fri, 26 Jul 2024 08:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E1A178387;
	Fri, 26 Jul 2024 08:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RmcuPf75"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5357F178363;
	Fri, 26 Jul 2024 08:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721982181; cv=none; b=mO9BSaYMm5aI/B1nGoCoVN/7Z0h+8Z5YC3ujaZNghu+AIlNZUO22EETCK/fGmkg6NzWhC+HsT2/Rt/I9/miWsgUuaHiNWtqWZstz1mgOL0G1PAf0P8+mIy9OyeE41bu1j4U39tFCAMaVTq6tzvvC+lqkNFl/wGEnExcPU9ANnzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721982181; c=relaxed/simple;
	bh=OdFAmfqn5OYDoEM2AFkjOAkfp9UDIgGQCF9t0mvJcoE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CSj9hXoWc7CLdnA4sztIR7x4pJYXfMbMktAYjm2e624vXeiD0VzqzUMqSkJUpM3Q9E0nspxVvJO9/ECjB4O9vzNDOR2ZWOjVzTXwwjQshbUiMBpXUm4+rRFZtSraMbXY27wDgkPm5z1EIzIIOVkLn3VGDGftGUpZytjyqL3Ij8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RmcuPf75; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3642AC4AF0F;
	Fri, 26 Jul 2024 08:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721982181;
	bh=OdFAmfqn5OYDoEM2AFkjOAkfp9UDIgGQCF9t0mvJcoE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=RmcuPf75bEOi/Rl2uvfZrApseW6/anyPC+lu8dEtzEdwX51IMofUz2sjdXcz0TfNZ
	 eVFlnd1CMaaO9AT7hYVuatsv/JntzlZmiFd9G8Jc1ZnXhdsO4HARrshgIWXoNp9jJn
	 WnzTV6yvbj1DCJRytcempQt6TMFiFYlpD0V1Fc4ioyZkgj5r80fhdTwc5P5mPfRs7z
	 Z207ICAoWEo5PmmPcBIQzje633AJaCdFuCDcAySSzKmd3PRWMHA1+zb3LWELsQ+eSd
	 fbZHYORLGfUn2fsv/4abXeZ/IQyrRG6G4LE8kWd2ffL5QYHayodrS3zKG/qmHONsPJ
	 Y+ViiB8ImhnxA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C10BC3DA49;
	Fri, 26 Jul 2024 08:23:01 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Fri, 26 Jul 2024 10:23:08 +0200
Subject: [PATCH 16/23] iio: adc: ti-ads124s08: make use of
 iio_for_each_active_channel()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240726-dev-iio-masklength-private3-v1-16-82913fc0fb87@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721982178; l=892;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=KjfjQzdm2bmltYrEkWRpiKz/U9ZMi6Ze3QqEmoK9kAA=;
 b=7L41U9fWy71xRJLeii57OtixHdlLNYPXf9ukClL4uXPdoC/3gwmAc4Wa2XhL7+PLyLv1a1dMj
 CfISDVzxnd0Af/QNR0BRNYe2RYAP7esXCgsGs8hExBos/DT2TRDBmUW
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
 drivers/iio/adc/ti-ads124s08.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ti-ads124s08.c b/drivers/iio/adc/ti-ads124s08.c
index 4ca62121f0d17..c115f892232ae 100644
--- a/drivers/iio/adc/ti-ads124s08.c
+++ b/drivers/iio/adc/ti-ads124s08.c
@@ -279,8 +279,7 @@ static irqreturn_t ads124s_trigger_handler(int irq, void *p)
 	int scan_index, j = 0;
 	int ret;
 
-	for_each_set_bit(scan_index, indio_dev->active_scan_mask,
-			 indio_dev->masklength) {
+	iio_for_each_active_channel(indio_dev, scan_index) {
 		ret = ads124s_write_reg(indio_dev, ADS124S08_INPUT_MUX,
 					scan_index);
 		if (ret)

-- 
2.45.2



