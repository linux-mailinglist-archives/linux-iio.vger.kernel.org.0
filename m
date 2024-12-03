Return-Path: <linux-iio+bounces-13017-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B83159E1C3D
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2024 13:34:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49F51B614B6
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2024 11:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24DA91EBFF6;
	Tue,  3 Dec 2024 11:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="KxiOJtlL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2D81EB9F0
	for <linux-iio@vger.kernel.org>; Tue,  3 Dec 2024 11:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733224435; cv=none; b=T/n/qXMlj2/Hh2GSZaAKmrIXWutPcrjpmwy/05ijPXscKWlIYY2s+JcRsfNVW19eQpXafpsJ2V/AKJtt2UBD4Sj6e24CaIKnU+ZJDXFaWPi2gpFawsHT57HP9g2P5nLwN9IkJku2VbKB1koQm+Ilt1NtevZW6JKBdeX/buAy0JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733224435; c=relaxed/simple;
	bh=0Xg5mKYCFN3B/HDWUQU/ZSVkSB67Sy7/5+wdEAjCrSk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zn6d9n2R1TqmiIl5mDbbvwUV2a2p5+QJwlwTeeGgfPZat3mTxkEvAEWn3zP2XAfj+18MZOAOrZnwriPo6vYmEZofm7Wffw30ddVYip+d7PoQXSo6NKe35eo8RZnm2LiR3h6PmwJ8GiT6pGP22lm4reoPVBhGjfA9e9FoxWdh9Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=KxiOJtlL; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-434a8640763so46026345e9.1
        for <linux-iio@vger.kernel.org>; Tue, 03 Dec 2024 03:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1733224432; x=1733829232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IvFz9DjYjIp3me/Tgm2Fhi7Oa0TCrW8QzQ1Z7YJsdLs=;
        b=KxiOJtlLwDMoKrium6ef6e1IJsLH5H1zBUrwPVffCUoTaG1RMN/J9uW8FCjkQKr6c7
         zwQlWoko282fwbaUxgmPvBnIU3vorz47kP4xHNJjj+PP8NuXv3puMNdiB59KmzqmAYL3
         eDnDBaQuz+34nKRubZVJnSlBByyGYaj+m755qKqInKqaXWjz3R/7hM1ENdHbF6hw4Xcz
         df6JdDIsqH/ISGAhQhcV062LmrJ0AqhdkvIRT6gXSqqq+VQLzdznyUV41UCkBJrdSSc1
         cdZsRL0tQJFWyIiIyGO6ACYMhmR0ZT4OkBs9kaO3U5ermBuFEmOpKBOD7xksMdJQi6Vk
         zUug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733224432; x=1733829232;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IvFz9DjYjIp3me/Tgm2Fhi7Oa0TCrW8QzQ1Z7YJsdLs=;
        b=aR/PFfBRnGh5HcZipWp2xhqpjagqtucTTEZwCSe7he7duZ6aMgIVsi419Yk2RXr6Ei
         HNbpo7XF9clAq4cttzr8pqoNSrooCS2YsuO8Fg0/wUjrt2i2FCHWI4Hto/Wf/kk12cxl
         TfVQuGmPizOodpCFNVom4wrUkLQwUsA/xrLh5O7yt2fkaUkVtbLSAvH+MELG+O89JuJ0
         E/N2lZp9/rWAW2VupmE8XrWgvc3pERn/nqSSkpwq18KCfqDywNZ5bUEQ9DbPOCsPyT7e
         NwqDNBeTFkrYXf5tR/Y/tYGcUVxGSpurpY4Iz/2wbaeYk30apr9jzYsfHkwUTnVvK6el
         1WTg==
X-Forwarded-Encrypted: i=1; AJvYcCXFKLR5YRzCKHfmOSNxppjpQbAGOYDPOk+WekPmtOT66eZV4/VlH9SGSGJhWPVQuIT+mxgCDBUa3+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8tL7G1n3oOmy/5E/aiDlMsCIwVamA68xpYJCwv+922SOK3Fm2
	K79U3QwhrminzHN5f9DvBdBo8mjYshq1/usMQnM7yCiSr/lQpEqy4JBr2mQKOaY=
X-Gm-Gg: ASbGncuOIsceOyTzfp/LLVCO77n7ZFUcc/1njAkNCWk7AI75rZq6IQk7BY9KPpSP1nL
	W3A7Pudu9rNAHFlfbHf+/4/ignKjS2orO5Fmtf6qGE0aO2OG/rgcBilBBiJO0wSrpeRRQ3/faN4
	Jz/9ivETvBC2xNUEGUpphp4Zd3O2V3HGVVMitSouAF3cfVgtcOPeYlExPtTlIdH2VgRKy3iyWg+
	Av9qWwsNULZJ4DnZeMt7dYKLKFdkQKk5Wj/W2fp2qbixkjNlcKHoWeUBkuY1zNSLJO/7SYW2kmP
	+zmX
X-Google-Smtp-Source: AGHT+IGgDCTuXxyE1Ce9iuzVhaTM/jeSa87WbRODLSiXYZ5sQsvdyKc8VfhYoZmPD2oC0EiFlyZLeQ==
X-Received: by 2002:a05:6000:1566:b0:385:f840:e613 with SMTP id ffacd0b85a97d-385fd429c22mr1719988f8f.51.1733224431788;
        Tue, 03 Dec 2024 03:13:51 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.161])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385e0117069sm11794315f8f.60.2024.12.03.03.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 03:13:51 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: prabhakar.mahadev-lad.rj@bp.renesas.com,
	jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	p.zabel@pengutronix.de
Cc: claudiu.beznea@tuxon.dev,
	linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 12/14] iio: adc: rzg2l_adc: Add support for Renesas RZ/G3S
Date: Tue,  3 Dec 2024 13:13:12 +0200
Message-Id: <20241203111314.2420473-13-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241203111314.2420473-1-claudiu.beznea.uj@bp.renesas.com>
References: <20241203111314.2420473-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Add ADC support for the Renesas RZ/G3S SoC. The key features of this IP
include:
- 9 channels, with one dedicated to reading the temperature reported by the
  Thermal Sensor Unit (TSU)
- A different default ADCMP value, which is written to the ADM3 register.
- Different default sampling rates
- ADM3.ADSMP field is 8 bits wide
- ADINT.INTEN field is 11 bits wide

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/iio/adc/rzg2l_adc.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
index 634073e7241f..dd2ef8203966 100644
--- a/drivers/iio/adc/rzg2l_adc.c
+++ b/drivers/iio/adc/rzg2l_adc.c
@@ -525,7 +525,16 @@ static const struct rzg2l_adc_hw_params rzg2l_hw_params = {
 	.adivc = true
 };
 
+static const struct rzg2l_adc_hw_params rzg3s_hw_params = {
+	.num_channels = 9,
+	.default_adcmp = 0x1d,
+	.default_adsmp = { 0x7f, 0xff },
+	.adsmp_mask = GENMASK(7, 0),
+	.adint_inten_mask = GENMASK(11, 0),
+};
+
 static const struct of_device_id rzg2l_adc_match[] = {
+	{ .compatible = "renesas,r9a08g045-adc", .data = &rzg3s_hw_params },
 	{ .compatible = "renesas,rzg2l-adc", .data = &rzg2l_hw_params },
 	{ /* sentinel */ }
 };
-- 
2.39.2


