Return-Path: <linux-iio+bounces-7919-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42DAC93CF89
	for <lists+linux-iio@lfdr.de>; Fri, 26 Jul 2024 10:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7529E1C217D4
	for <lists+linux-iio@lfdr.de>; Fri, 26 Jul 2024 08:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66FFC178372;
	Fri, 26 Jul 2024 08:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="feulg/V5"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23150177982;
	Fri, 26 Jul 2024 08:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721982181; cv=none; b=saMz2rZ6crRyKIlasrrNQGH49bAuIoYsg7PHyToQCU8Azu7PogQIFiAgHkMJ+6Mbhe+OfeE2ii/Dxc4yAuMUPV3Qau5Df68Ve4zSfc42txEKEzoAw2GhUKUAwsZJPCGZsSGEG8gzcmVP2BjdhqipQic2z/rpC/tWjIs6QINan44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721982181; c=relaxed/simple;
	bh=nzUWAUdckXIGph1ePT/7063qkyAusr43E/xStTlrsEY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hN7z/ZHiTRePwU+to8PlZ8h19xmqzX+XCn2XsjP0Dx470Ljzei8sS8G//cOUQ9YkpY4nKvI1UFyTCtaeOqSpgyUN94wtu6kBGL7HQbC5c4hSspiSG7G5Wzm47MB8dgwDt/WlgdUZdGp9UzZvq1zuVZHOGrod+Sb9pnL6PuXLERU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=feulg/V5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 04C17C4AF11;
	Fri, 26 Jul 2024 08:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721982181;
	bh=nzUWAUdckXIGph1ePT/7063qkyAusr43E/xStTlrsEY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=feulg/V5lmrZD+XstVWm/r08zytvlEvyLHe3XOZxKVvYoAOwebJpdoP5Pu+pIReKW
	 YKgLY+69+sx4Cx80+xuDQHP5oATPHrF7y3YuXGdv9O2nBXaFhRNT/g/KyRqSi17GcK
	 KPDMQuefk2uNc/fsmtKnmO5IL/HcTmTsrLVzNpOkoswbhIuU4UAgP/8dz5r/VHf47h
	 RxNuzc8/5K+tWOubKF+bl9pp7IK76ZA8QkwyB9seagkR38H5z1SW5a4vTy/2HPGHng
	 cV1dbp9dkRu+u/WtnkJxT09MUr8kWAS3zXrLuBwc7YUfCro+wFYFANgEQ7QDxUKKE0
	 tqOl0QYM5k1AQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB3BC52CDA;
	Fri, 26 Jul 2024 08:23:00 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Fri, 26 Jul 2024 10:23:05 +0200
Subject: [PATCH 13/23] iio: adc: ti-ads1119: make use of
 iio_get_masklength()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240726-dev-iio-masklength-private3-v1-13-82913fc0fb87@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721982178; l=1136;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=HnDbSftd+e0Ucp5FBdQe7pOcKFrEr/hE1TurBJs2zNI=;
 b=3FAN4ZBfLYDF7k1ISI+aJeeV5O6Otw0p/Vs1ESTmIKNRpp/aEygYyDiCwgjT6pOjx3UiXV9oA
 7T7b7WBBP2tDiGj5Ap9GHkFNoRjocoiSYz1mP93QZ1YXMZUqQ+QX19G
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
 drivers/iio/adc/ti-ads1119.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ti-ads1119.c b/drivers/iio/adc/ti-ads1119.c
index 630f5d5f9a60..44d9f69c9df3 100644
--- a/drivers/iio/adc/ti-ads1119.c
+++ b/drivers/iio/adc/ti-ads1119.c
@@ -435,7 +435,7 @@ static int ads1119_triggered_buffer_preenable(struct iio_dev *indio_dev)
 	int ret;
 
 	index = find_first_bit(indio_dev->active_scan_mask,
-			       indio_dev->masklength);
+			       iio_get_masklength(indio_dev));
 
 	ret = ads1119_set_conv_mode(st, true);
 	if (ret)
@@ -508,7 +508,7 @@ static irqreturn_t ads1119_trigger_handler(int irq, void *private)
 
 	if (!iio_trigger_using_own(indio_dev)) {
 		index = find_first_bit(indio_dev->active_scan_mask,
-				       indio_dev->masklength);
+				       iio_get_masklength(indio_dev));
 
 		ret = ads1119_poll_data_ready(st, &indio_dev->channels[index]);
 		if (ret) {

-- 
2.45.2



