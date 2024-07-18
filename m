Return-Path: <linux-iio+bounces-7682-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9AB934E51
	for <lists+linux-iio@lfdr.de>; Thu, 18 Jul 2024 15:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0ACB1F21A40
	for <lists+linux-iio@lfdr.de>; Thu, 18 Jul 2024 13:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E3E13E021;
	Thu, 18 Jul 2024 13:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kvV5jRsV"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A774E13D52E
	for <linux-iio@vger.kernel.org>; Thu, 18 Jul 2024 13:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721309905; cv=none; b=emCZbgdpmEo0pJGHl/dF6pivH5cQcoTl1mxTalpc9m4dR2kC5zDoYofKugPNust5QWNzrtU+v3WJ5o29rYSBgZ/pSGdD5CycfO0THB11EHdod3cuZ6IHpDWFG4XdE9B5WSOSJBLZJ2TpTuJac8ReMs7GUfT7v7C14IhLJSWrdcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721309905; c=relaxed/simple;
	bh=Ch3X2bqvmnrCEzV5plOeGqQb8KDZBliDSV1fsN/WO5s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uofdkrzp7+2mVTrSwrsUe59i5MPrx8jnVJzIdNa7yP2xYVZySXd/vmspJHNoeU7ivPVG6RADJLSLOGspuoijCD2Y1OLPqhn/0jiPk1dhgpuBGSBUY7Ms50dl2fyhV0Ulp2l0gqtUdz6waDMJ5r8rCWP/nYn7C5G9rnbV2845iUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kvV5jRsV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 61981C4AF10;
	Thu, 18 Jul 2024 13:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721309905;
	bh=Ch3X2bqvmnrCEzV5plOeGqQb8KDZBliDSV1fsN/WO5s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=kvV5jRsVckhTk+UmuIMPxCXV7OhcsI7SSahG/nXwYZ/Mi5zBY1HSeqI9pWclt/736
	 ukXmQOmOchQUIQLwehdBTj33Vqm5LUBLsMEDKplLTRYygvyVDXiuiAWPHQXYI3D4ww
	 nECGSdiZLAFxuSYuaQwoaB10DRoJksoRtyT9flbCXKCeW7UuXuF43Q3pMdRCl6OC9h
	 FiqvqKjXh7tDWya+02Z2lf+ztHGaNdybJPqhyWOrLZ7S0Ta3gdZTmqkrvVf/Fpxs+J
	 D41cNvWcFGrrnbQknpZ+yMeL0qVx/cN5NJHY0qzDaA/GY4xymyGMO2WgBvKz614g8I
	 alJMzJ+uVhaYA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52638C3DA6C;
	Thu, 18 Jul 2024 13:38:25 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Thu, 18 Jul 2024 15:37:49 +0200
Subject: [PATCH 03/22] iio: adc: hx711: make use of
 iio_for_each_active_channel()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240718-dev-iio-masklength-private2-v1-3-8e12cd042906@analog.com>
References: <20240718-dev-iio-masklength-private2-v1-0-8e12cd042906@analog.com>
In-Reply-To: <20240718-dev-iio-masklength-private2-v1-0-8e12cd042906@analog.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Andreas Klinger <ak@it-klinger.de>, 
 Song Qiang <songqiang1304521@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721309903; l=905;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=KAnU15Hk8iF1wb61OpyPO1VDqtC2h7HwECBSLVsPXIk=;
 b=i+RDahg3yTWSGz+G1qvNnmyIo/4Ra40gyIXDQbVIvpQWJPJ9J03N3niYrlONx1IpHfxvWDUzT
 nSrem2VyLyiCcRXlt2Z2CMZUjTHq/hovWoD9KWa1pU6dQHWyEBXreqw
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
 drivers/iio/adc/hx711.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/iio/adc/hx711.c b/drivers/iio/adc/hx711.c
index b3372ccff7d5..376f4e02de97 100644
--- a/drivers/iio/adc/hx711.c
+++ b/drivers/iio/adc/hx711.c
@@ -363,10 +363,7 @@ static irqreturn_t hx711_trigger(int irq, void *p)
 
 	memset(hx711_data->buffer, 0, sizeof(hx711_data->buffer));
 
-	for (i = 0; i < indio_dev->masklength; i++) {
-		if (!test_bit(i, indio_dev->active_scan_mask))
-			continue;
-
+	iio_for_each_active_channel(indio_dev, i) {
 		hx711_data->buffer[j] = hx711_reset_read(hx711_data,
 					indio_dev->channels[i].channel);
 		j++;

-- 
2.45.2



