Return-Path: <linux-iio+bounces-13152-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B8D99E6D23
	for <lists+linux-iio@lfdr.de>; Fri,  6 Dec 2024 12:17:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D740B169527
	for <lists+linux-iio@lfdr.de>; Fri,  6 Dec 2024 11:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265FA206F19;
	Fri,  6 Dec 2024 11:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="IGUkLjZj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B29202F91
	for <linux-iio@vger.kernel.org>; Fri,  6 Dec 2024 11:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733483664; cv=none; b=cBRqlJZHAU1U+OAv2qb9rYA+PXrZtu9bVDbG/U3csy9S9kYxnJ96k/0ceMtHfXMNJ9iwioDfOm3khW31U1dMyJ/VkspGenb4fXIc5SVEz2okkjVe7W1lsT3QxzF4B7RIRZpW0Vszus2wAt1tCLGpDYvmxVg5qpVVwOenlaD3sMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733483664; c=relaxed/simple;
	bh=a4/gsQVtR7MVHM1KJuAuPMWGtk0F3Gae6xSRbB+vIWo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OVzWq6l7ornpRYyBvPrX0W4GVxWRLOtUlH+XxtOlbBlEyN/CAIqy/HuejoVHab9ivpj6yjpm7pJagcTC7jVAmpwDiAgxK55OvDCjDON2l9IwESs1bcbsjQ3zrHTMCcxCVSiHpEY9mZk1Byl3IpcXsSt8A+/8O7iV8Wi6ARQwn/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=IGUkLjZj; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aa62f0cb198so197914766b.2
        for <linux-iio@vger.kernel.org>; Fri, 06 Dec 2024 03:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1733483661; x=1734088461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r9Dnr8lBPRV9hwY5+L6VmdONZwzLphVT7+zA8FZuSvc=;
        b=IGUkLjZjdXavSltmBn7WJKCt7ZmfqpeDzq+c8eJyOQNUX4pmJzPPgbOzPqDCz+QuVr
         0Ee0ApCmiF9L5o970PXWXaFksLDbsPONJoXANY1yjBKK15S8LoRwv4yaI96oTxeBqJo2
         Yr+gjDZ2FhW1Kh/GXVTV7lOFJ5gypIS301DAgBcVqqqsEkmOy52N31+BTOmEd/w4lLyV
         bSuerh/gR7UOtBdU5HxbeKm1lP8vXbSByk1US73myzpL1FAp+lFZ5EzLpOngyAbGRIu/
         VC2PirSXVrkC6aPm57d0vKHq/bjE+wVAIULPleREHmFcG5WpkgNHfVv27jaeWKhyDKH2
         hA+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733483661; x=1734088461;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r9Dnr8lBPRV9hwY5+L6VmdONZwzLphVT7+zA8FZuSvc=;
        b=rImsTTuKtFYlx0N9bG3rlOJ5SQcuA/b9/E3nC4vWOgSoI8mVAlw8/ixD0aoq/J3XhE
         NoiravF9G53rZzCki9OmrHHZIDYE8M+r4GX4fKyaUN5I4xPdfj1gpB1sjLctqaZIDfLP
         kGAWlVF/92Al5HaqmboXKTRNL35DQILhO18i05y7ItBs5xmFECNdoUbqla2qsxlhYG1d
         HyrLFKs17Z2DcE2nO/Fp4S8nCGqkyumZ1BLRcpNOQi8tmC0W1OYVlu2q2Hp4aa2yDsJJ
         Gi1szxJqIhubOXXvmCFuH/n4R8TWjAXPEQxvoAWdoi0JdqR1Fjq4RwXmUvPQyiPQImmM
         psgw==
X-Forwarded-Encrypted: i=1; AJvYcCU+6uD2dWDm6Stro1efk135+2XRG9lcli9LkAJaWbm5yJmK//TM6ABRHK1YqQzpYSxJnwsKp7KeylA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMa8B9o3bp7zS3Da12MOkAmNjgODsB4IS145xnnK68O5VBnqc2
	yfAJPCBjElYEm5cBi8iGqxZqqYcnaDAroT9p0g8xSz3dBO1vrfgiR85nY+hPcCY=
X-Gm-Gg: ASbGncsKGAQ6dszrVtvccpdgvyLSBgTwaMeMOpITH+mnPJyoCVzuSb5G+uaOo9TRSCY
	+8SOItoD7WCYHGuvJfkkPn8STVAZ69spxHOGoK2pUWXwCUVqAJRx+9ZOHGRHUnv3Q3Z2u2Ftiak
	WISc2OZ/osDMcD1qDTTO6SNViBBPRkD9TbYFNeD5W3hs7audXjw8hCdNpYxnFnKI8fouWvRZbVX
	+iiryFGNK0dXxjW+Hg6V6jRK2OJoUhkTFBTwjR6e8/enpf/IJmig+Y8ZrzjvQHBWt8owNSxzrYE
	m8ZX
X-Google-Smtp-Source: AGHT+IG7gJqc4CGdANniAawsf3QrNvInv7nJ0Q0Fqm3FfT2wXTQhceZu1E4SlHPGcY841V3MyHiZiw==
X-Received: by 2002:a17:906:4d2:b0:aa6:2e07:5cf2 with SMTP id a640c23a62f3a-aa63a2086e0mr165912666b.38.1733483661317;
        Fri, 06 Dec 2024 03:14:21 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.161])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa625eee2a6sm226877866b.90.2024.12.06.03.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 03:14:20 -0800 (PST)
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
Subject: [PATCH v2 15/15] arm64: dts: renesas: rzg3s-smarc-som: Enable ADC
Date: Fri,  6 Dec 2024 13:13:37 +0200
Message-Id: <20241206111337.726244-16-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241206111337.726244-1-claudiu.beznea.uj@bp.renesas.com>
References: <20241206111337.726244-1-claudiu.beznea.uj@bp.renesas.com>
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

Changes in v2:
- none

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


