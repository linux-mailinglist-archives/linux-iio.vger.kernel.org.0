Return-Path: <linux-iio+bounces-13019-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E97C9E1AAD
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2024 12:17:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22C7C163793
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2024 11:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ADC11EE019;
	Tue,  3 Dec 2024 11:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="It1J3/+s"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7231EE005
	for <linux-iio@vger.kernel.org>; Tue,  3 Dec 2024 11:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733224440; cv=none; b=C1s0RG+lz4+mEASFlWGr+hJCVMLgT3xAH28OFhdPUcm1lZ0ImBpunM28ZgD4YpZY+3qHhDp6SftpXzn+bjDDI3ftpcLw+TGFtVAh0tUhrZDi7XMd74ipBz7eh9sI2V/8AShFOkOCwhLcoSfP2WUmCdTc0OZ/Yw4v0/zhpgiCdGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733224440; c=relaxed/simple;
	bh=hPzvAQBya4lMaHbeDMGEHEu0Sst46VpHxejcDLV1/YY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cT5AkmhHFdFbXR7i9DyXsEk+mlY825y0mqQgy4LaBU1oU557xHtYBD2E2knjOmXALa/w8R7GQDgYOavmEGXCrPD4hirNdt12WZL54yQw2bYl1iOdyXbDd4PAK54v0gF4Tb3ANJ/LO67Ku5PwcbcaU8pc2rSqEQstmgaLhdbInhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=It1J3/+s; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-434a852bb6eso49489535e9.3
        for <linux-iio@vger.kernel.org>; Tue, 03 Dec 2024 03:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1733224437; x=1733829237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vuYmwt2mwWEd+Tu2KpQNpDTdmewly+5/W4Kvuhh8MtU=;
        b=It1J3/+s9eSfgOa8xL59iWVGv+bPplYPchi3wNeRX2rnrYbTkBFFvQtNbDfm1r41OG
         qgBVYtaUStEnB5rBO3lZRE2JNiqq/BrOXom1WDnToiQxwuP+th0L+oEeaEuz6BZtxlWQ
         GAqrdY74ufxHua152q5gx1h0V/u2yPDuoCozhjPXuFj5YxlLGafPWd1XrJyX7U3nezW5
         CTHDPFT1pdavJiWU2Khk+m6t02EbH9zCCuTWuAmUz4d7Zpo7VwRze2UVDrr6odo25X7T
         GnlaqtR4KRk7r2WiViqaEkG8rJDo49sD7BFGDvlsLGyOUvyr7SOnUSvF/zgT017NrMi5
         avig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733224437; x=1733829237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vuYmwt2mwWEd+Tu2KpQNpDTdmewly+5/W4Kvuhh8MtU=;
        b=k68GUHLLVPFKOsVuW0ssGFv8bbWdkJUBryG79jpGVvSn1HZPeT7aJ8oeodh0tlxjrO
         KJ+MbYv06o+WZETp3r5XXOz9qbtNx9K58iQ6RFslAQVTxCQFnyZZFqDqAAiXX14ixFSO
         7BedrHXeyHK2T729uHAnukG6ZmTyMrspo8pnubkZRjMAuFq15qoScYeOSMk+wg6DQnT2
         xkwXcch6paFNIu2/FgQ0J0GlUmRccGQavSWB0mmk48yt/sq+v0aUJVYRnN8sGjkvPfpn
         wtU5DuEht4VTojrwalIrcLFAHHv+kEvnWBYTRo7qOwG90lG/dBf3oni2pphMTAoglH5S
         8MeA==
X-Forwarded-Encrypted: i=1; AJvYcCWpikN2m7FDerbA+3f22FHXVQdZWClCG0HC1DHTN1uhczifcr182/EcPfPi7lWDVjqFsflJX1Tp7YE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzssl8x01ne6d18FS8cKPCeGCzXvMKUfsE3MXIt6PHHQtrFeYBT
	90kFh5ip1hwwm9+jyHJ+5I2eTXH5410C/BgBapC5w6raF+luAyputXxKnQryCw4=
X-Gm-Gg: ASbGnctoxZ2DBGPotPLbDEac4FUc6plUccO8qjMvfq+AdHvE7OKRTIhc4Zl1gn6N3FO
	k/V7miR6wzslGYnt7B0WDINOC1Zz7Deeu4xHP7WU38bd6Qk41RVH7ds7qM4vAjUcvZEqkB5A5zM
	kjEz0SumVLmOX+KQZ1o1lPBKPcy56OonVBNBmS9G3SAV1K0XFab1w5K/q7LOeaeHUIwuYzPlCkr
	9+5o5cE/+uGrZDJVW24YQQOC9L1L5UZxsaNavPhNrZiwiEobrP9SmMDOFzstWL0Sbbfc7KhnMOr
	FBPk
X-Google-Smtp-Source: AGHT+IHOuquR0Z2Y/9RwvEymwXXAAW6Jm4OPLCo5DQNmdYBocmhFqjdVsjkAP+GiCZweMjILCABwxQ==
X-Received: by 2002:a05:600c:4710:b0:434:a30b:5455 with SMTP id 5b1f17b1804b1-434d0a239c3mr16423245e9.27.1733224435487;
        Tue, 03 Dec 2024 03:13:55 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.161])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385e0117069sm11794315f8f.60.2024.12.03.03.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 03:13:55 -0800 (PST)
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
Subject: [PATCH 14/14] arm64: dts: renesas: rzg3s-smarc-som: Enable ADC
Date: Tue,  3 Dec 2024 13:13:14 +0200
Message-Id: <20241203111314.2420473-15-claudiu.beznea.uj@bp.renesas.com>
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

Enable ADC.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
index 2ed01d391554..57ebdfc858eb 100644
--- a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
@@ -94,6 +94,10 @@ vcc_sdhi2: regulator2 {
 	};
 };
 
+&adc {
+	status = "okay";
+};
+
 #if SW_CONFIG3 == SW_ON
 &eth0 {
 	pinctrl-0 = <&eth0_pins>;
-- 
2.39.2


