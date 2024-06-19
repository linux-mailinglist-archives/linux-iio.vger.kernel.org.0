Return-Path: <linux-iio+bounces-6567-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEFE290E804
	for <lists+linux-iio@lfdr.de>; Wed, 19 Jun 2024 12:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 664B6282CEF
	for <lists+linux-iio@lfdr.de>; Wed, 19 Jun 2024 10:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98BC3136E01;
	Wed, 19 Jun 2024 10:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="qLVEiAj+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DC385626
	for <linux-iio@vger.kernel.org>; Wed, 19 Jun 2024 10:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718791937; cv=none; b=eot351PyHITp3nMKEOGJFCdstWm+OsUu5Xt4BPH+wo/uh4NWtAu0Q5x5DT+RhU3vXXp+bG44NND8rCUclJTLz3vujop0H3AdMmchXsxpWMocnR+5MGfTDBJJLpI2DrY26aus5E6xmrwwMWT9uQo1DJHdilyRIr4ILOjB9oJOPos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718791937; c=relaxed/simple;
	bh=ls4kxFHqkBG+kx3WnRXHImWHnlbY3kjK18Z2TnMQLqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lwXZ6ODIzEMUqBGIAaVKoUoJv3+rsaCyxZGDtxZ3hRNhBqZc4ZrEIicXBpvSR26GnxEBzzjyrDj2IxD148b0TlHeEjKZZXuRKrmwD9YJ4RqcAjK2/QC3wSbs7rCbXQhwpiyl95W+qiRuzD/jFHoUwdj73TOUWZ8XpPKsLxGok7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=qLVEiAj+; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2ec1ac1aed2so52463091fa.3
        for <linux-iio@vger.kernel.org>; Wed, 19 Jun 2024 03:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718791932; x=1719396732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eHeUArdSKpP0gigzpdr9jDKMc/RdHGYl+hgWmyzctFg=;
        b=qLVEiAj+Hkt6Y2GHUZjfBtR1AhWPo0BTkE629qCVm0FKTd0e9mth85domMziS2IeON
         Vd2cTL20LAmEKYD6RtiosDDnAtuf07bFLEDIt7NUHCeYBCQPt1KYCDfL5VkMbzT7raHL
         SqkvY1A+AS9LwE7VjIGT+msYXJYF41oBGmLScwFIW016Agb4Nmf0ni+JQIGcpTG1acEl
         QNg+ka2Yed3pN2dn3jWPdvetgexbxesqpy4Tu335A/THmW9KgRibEFiLPsLPGvvpTEXB
         D92JY4AHCVDCd2pGnF3/66Yq8UZr+QoWwjjOJwrXC871cDqfVAWA6KWX+W5RFHFnfHQj
         Eq6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718791932; x=1719396732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eHeUArdSKpP0gigzpdr9jDKMc/RdHGYl+hgWmyzctFg=;
        b=XJbKNHDGB1OG3dEycs8WClsDaMBhEqFtaLjdrJm+tnTdgg3wZPzaPB66XNdf/lh5Xr
         tanvKS/Lbhr+V2Hk6T0FME78xxLFaUUibx8JW89r6yO8xnZzTANq0ogkXkb1na8wwo5+
         n3NbS+0xTnm/p51CBLFNfocwUtyl+9Xcobrx21B7OMM5l4yDm3/3yg0mOzHDFEYUSUOY
         LZKO6s6qw416S+7emnKdIKqmzDy3AzJNSTLqX8uvuvPazJ4r76X6Q7XofqMtAv8O36E4
         ZkP1C3QsGPdqYm67qYFeH5pTGtPMSDEQdRW9iIbXPZQdL3TPH06ONjaAglN0okzUYFsO
         kh7w==
X-Forwarded-Encrypted: i=1; AJvYcCXftnFpiuQwue0D6bbl0q4mK6WdPajmDuB4L1wuxxVV0HolyXA9BHCTr/OSjF+sZM1yHcbibgMGnYWgO1QhrEMlxZSBp84LSWvE
X-Gm-Message-State: AOJu0Yx5CGq3SlSKeXL1na3ih3SpC89ZlKJF07meAdSV3moAOX5Kg9Zz
	9vx8SRAy0ITxsASAy015/JBTH8//kBL0PIKl+5/D2wbKyYeyWbzRGP7dr9hUl2E=
X-Google-Smtp-Source: AGHT+IGyBLZDsIe+RLHY2gT0ffX4UdQ+4/orS3dRcY6M6qSnO9AgKtn+LaqX7vFTMoagllxCj9bhpg==
X-Received: by 2002:a19:c205:0:b0:52c:aa0f:622d with SMTP id 2adb3069b0e04-52ccaa37500mr1184800e87.30.1718791931979;
        Wed, 19 Jun 2024 03:12:11 -0700 (PDT)
Received: from localhost (p509153eb.dip0.t-ipconnect.de. [80.145.83.235])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422f602e802sm224164165e9.11.2024.06.19.03.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 03:12:11 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	William Breathitt Gray <wbg@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-pwm@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Thorsten Scherer <T.Scherer@eckelmann.de>
Subject: [PATCH v2 3/5] counter: stm32-timer-cnt: Use TIM_DIER_CCxIE(x) instead of TIM_DIER_CCxIE(x)
Date: Wed, 19 Jun 2024 12:11:44 +0200
Message-ID:  <126bd153a03f39e42645573eecf44ffab5354fc7.1718791090.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1718791090.git.u.kleine-koenig@baylibre.com>
References: <cover.1718791090.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1691; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=ls4kxFHqkBG+kx3WnRXHImWHnlbY3kjK18Z2TnMQLqo=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmcq7mxkltqOid2paUGt3syPB6S0GwVABYwtite mZw5LibI4+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZnKu5gAKCRCPgPtYfRL+ ThvbCACIw0IFO0iRtD++sN85YjotjckPff1mDVwNLBVaYqLdD/VtfYCUK2skkHC67BNifelJo3I G2/mOes1u137ttN4EbhqeW5MG9RqBa19yYwx31nH8RvOUywSbqyhYfdgeuDqtr/A1NDvL6eOnjU U9uwZf7FjLh4mnnTehhIJJoGBFAKprGxIbVI7QjjBJiP0/WEB0U/GF85mbSjXauaQBq5Iw2yynC DEczOF7dcKrtl1IzqBaF08lPGfHzGpX0WUbX064/snRbhcVXQ5ruP93BFjUM+67ecHXsEymcTHy dTqkyaIFtvIUw3HjwSHexHs0tMC4xNcCb6dgUX0okdcKZ6W3
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

These two defines have the same purpose and this change doesn't
introduce any differences in drivers/counter/stm32-timer-cnt.o.

The only difference between the two is that

	TIM_DIER_CC_IE(1) == TIM_DIER_CC2IE

while

	TIM_DIER_CCxIE(1) == TIM_DIER_CC1IE

. That makes it necessary to have an explicit "+ 1" in the user code,
but IMHO this is a good thing as this is the code locatation that
"knows" that for software channel 1 you have to use TIM_DIER_CC2IE
(because software guys start counting at 0, while the relevant hardware
designer started at 1).

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/counter/stm32-timer-cnt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/counter/stm32-timer-cnt.c b/drivers/counter/stm32-timer-cnt.c
index 0664ef969f79..186e73d6ccb4 100644
--- a/drivers/counter/stm32-timer-cnt.c
+++ b/drivers/counter/stm32-timer-cnt.c
@@ -465,7 +465,7 @@ static int stm32_count_events_configure(struct counter_device *counter)
 			ret = stm32_count_capture_configure(counter, event_node->channel, true);
 			if (ret)
 				return ret;
-			dier |= TIM_DIER_CC_IE(event_node->channel);
+			dier |= TIM_DIER_CCxIE(event_node->channel + 1);
 			break;
 		default:
 			/* should never reach this path */
@@ -478,7 +478,7 @@ static int stm32_count_events_configure(struct counter_device *counter)
 
 	/* check for disabled capture events */
 	for (i = 0 ; i < priv->nchannels; i++) {
-		if (!(dier & TIM_DIER_CC_IE(i))) {
+		if (!(dier & TIM_DIER_CCxIE(i + 1))) {
 			ret = stm32_count_capture_configure(counter, i, false);
 			if (ret)
 				return ret;
-- 
2.43.0


