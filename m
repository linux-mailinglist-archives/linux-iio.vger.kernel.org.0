Return-Path: <linux-iio+bounces-7166-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA8692431E
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jul 2024 18:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12C0428B770
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jul 2024 16:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2831BD4E5;
	Tue,  2 Jul 2024 16:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kwn1cs4o"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBAE1BD50E;
	Tue,  2 Jul 2024 16:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719936160; cv=none; b=Jok0T2haLu1lUVt1+Cl/NVbeeeHpKvKCXOqcHcMuM7ifpKUJTqUQi1kHeYAi//pMC7zlCL7CQwTC/0nCz5quXO5hyqfWlYwKgCpGABMOoxTsP7FrAJ9eDWm6fjm8eZgJaDnBngo1gJpND/uujCaGUDZdTXolFUQu19dAOKkk6n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719936160; c=relaxed/simple;
	bh=yOWVypS4kSOx1G29xEk/xKSpqDyhIwoOhx6i3r0Qfts=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mo00DWjhlGGSvxzZBvscqYI73zo+rpBfMO2wmmxX+Y3spSvGgQx6807QCbHDFgIm3gZ/JBbmOKO++VGkK/LfAofjQMB7HFsZpoR/G0OqxU3EYDENXmBB56iqnRJgidpDrmxSurvrSd4YMTGO1dlDtc9XOIFroVAArBh1D+hVfFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kwn1cs4o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2387EC116B1;
	Tue,  2 Jul 2024 16:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719936160;
	bh=yOWVypS4kSOx1G29xEk/xKSpqDyhIwoOhx6i3r0Qfts=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=kwn1cs4okhnkZgPsHVSAptADCRALmck4WOXA+YKCvDogxZof0aUFRcfTEmRCWmRxc
	 O88Fh0ZrsndbCsax/QVZkZCIEWCAp8x2T05jujRk1NePQ7m54je4OQlbyYDvWD+HRK
	 AhyLxgBD+lGr/sy6GupLSvtHU+T3ezd3l8Cg3SF2aVLtAVqsu+pOFd3hNFV2ff9Yfq
	 aN/sbA4AWr7aSMp8HdNf7Fh1SVeybPR1eyIFkXM4kHhDjTGSoLVC227Pnt58VZyix0
	 xRFPwGuPHXGLOE7uEoQoOkCSdEbXcnGiW5qF/LkbQcW3jtqhcRECmohNDIhy3tqbjT
	 p35gUew3vajUA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1964FC30658;
	Tue,  2 Jul 2024 16:02:40 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Tue, 02 Jul 2024 18:02:50 +0200
Subject: [PATCH 18/20] iio: adc: at91_adc: make use of
 iio_for_each_active_channel()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240702-dev-iio-masklength-private-v1-18-98193bf536a6@analog.com>
References: <20240702-dev-iio-masklength-private-v1-0-98193bf536a6@analog.com>
In-Reply-To: <20240702-dev-iio-masklength-private-v1-0-98193bf536a6@analog.com>
To: linux-iio@vger.kernel.org, chrome-platform@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Cosmin Tanislav <cosmin.tanislav@analog.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, 
 Dmitry Rokosov <ddrokosov@sberdevices.ru>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719936157; l=908;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=W/t1QLnOMBghJ3cBP0Sz8vy2Yubdg+XmvmGHI/DD3L0=;
 b=UgykRrQ4gxnOiL92MVtaXiv5JRu0qLvRXJ3en/zfBLdcF1+6f4aouctfdqT139Xlq0n1yySoq
 /o3KRpCxAeyDCNviZtJkLh3MEekKinZgzRRLzBwuc1kxonACiBumgdF
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
 drivers/iio/adc/at91_adc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index eb501e3c86a5..af4b0224076f 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -268,9 +268,7 @@ static irqreturn_t at91_adc_trigger_handler(int irq, void *p)
 	struct iio_chan_spec const *chan;
 	int i, j = 0;
 
-	for (i = 0; i < idev->masklength; i++) {
-		if (!test_bit(i, idev->active_scan_mask))
-			continue;
+	iio_for_each_active_channel(idev, i) {
 		chan = idev->channels + i;
 		st->buffer[j] = at91_adc_readl(st, AT91_ADC_CHAN(st, chan->channel));
 		j++;

-- 
2.45.2



