Return-Path: <linux-iio+bounces-7680-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC04934E4F
	for <lists+linux-iio@lfdr.de>; Thu, 18 Jul 2024 15:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B537284C81
	for <lists+linux-iio@lfdr.de>; Thu, 18 Jul 2024 13:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B4D13DDAD;
	Thu, 18 Jul 2024 13:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NzVAqvRV"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96ED713B290
	for <linux-iio@vger.kernel.org>; Thu, 18 Jul 2024 13:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721309905; cv=none; b=BgezxObDXhwZEXEWQZFiSnUszRczM/P+J5mVK+nzf9BPhtvz0QHLyirDtiiG21x9zxTpeoEapl8LdPVxmxhloNziELWApLd//eb3740Or/zttUDb/P625cpzD6WOEJmd+STC10+u/c4GcCaAbBSFmt+UbAePtB2WKNgngiqdAQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721309905; c=relaxed/simple;
	bh=ocJEoe2Cw41p1BgnfVkxu1byJIGdYc9nRbLJ2i6t4ws=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rcXCn74Z2T5waTX3fUgJtZ/KtnZ1m0mXqbpbf459RORQuUcxpqiUNmKvcwtpPZBk2J/oocB3aLnXIld4F5kLtS23187TGNCTluNe/NgUgTMvRNbytz2DfXXFdMkG2A7KHa4qCX0LWgO906N5ArkwCWR5WJT7SLAR2RikLpd6chY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NzVAqvRV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 47E2BC116B1;
	Thu, 18 Jul 2024 13:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721309905;
	bh=ocJEoe2Cw41p1BgnfVkxu1byJIGdYc9nRbLJ2i6t4ws=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=NzVAqvRVKobhzqHIGVSViQqe5vsEytHD2yT6lSkNz8rtZtLWBufIfZvnKPhrkpXlO
	 0JD31ryTPM0lRm78rj9qdzUN5xkqe+BESCE3HBteL1wglD//wBwBIX83NroB7+vyFI
	 j6qUySnA0DEK2tdVcpNa8fH0wXjpBkdUP6D5JgGW29Pmpakqu3/ZkyG4GL3/2m+leV
	 udigkzd1960cw5p5yCGGNlcCwHHYf0XpnsvT9WqJw+unCSBFQQGSWZoP/tIt0yL718
	 h7o2RMMtXMc3SZGwf6ToZA/hitXAkblsdbFCnKJllKlrOuCjtFDgaNb2T+Hjy8eRj7
	 mrWxNg+F5yJmQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34609C3DA6A;
	Thu, 18 Jul 2024 13:38:25 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Thu, 18 Jul 2024 15:37:47 +0200
Subject: [PATCH 01/22] iio: adc: cc10001_adc: make use of
 iio_for_each_active_channel()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240718-dev-iio-masklength-private2-v1-1-8e12cd042906@analog.com>
References: <20240718-dev-iio-masklength-private2-v1-0-8e12cd042906@analog.com>
In-Reply-To: <20240718-dev-iio-masklength-private2-v1-0-8e12cd042906@analog.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Andreas Klinger <ak@it-klinger.de>, 
 Song Qiang <songqiang1304521@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721309903; l=890;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=7KQilIgM9x/pjjV8IpQ1xKu+V2/UHH1gFTIwZPtjpgg=;
 b=fRsRXoEKF4YGid901q5e9xKkLzGZU67xeNH6uMS37BmezS6j0kxav4HD3+uCyY+mcWK8sNBm7
 rfEyY1iu9/PAdUVvUm+mus23ZkZs+gzMkemRa3Fk8xcUW8uNgmwBxoC
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
 drivers/iio/adc/cc10001_adc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/adc/cc10001_adc.c b/drivers/iio/adc/cc10001_adc.c
index a432342348abe..2c51b90b71018 100644
--- a/drivers/iio/adc/cc10001_adc.c
+++ b/drivers/iio/adc/cc10001_adc.c
@@ -157,9 +157,7 @@ static irqreturn_t cc10001_adc_trigger_h(int irq, void *p)
 
 	i = 0;
 	sample_invalid = false;
-	for_each_set_bit(scan_idx, indio_dev->active_scan_mask,
-				  indio_dev->masklength) {
-
+	iio_for_each_active_channel(indio_dev, scan_idx) {
 		channel = indio_dev->channels[scan_idx].channel;
 		cc10001_adc_start(adc_dev, channel);
 

-- 
2.45.2



