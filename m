Return-Path: <linux-iio+bounces-8157-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA9419463C7
	for <lists+linux-iio@lfdr.de>; Fri,  2 Aug 2024 21:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 669D71F22D2C
	for <lists+linux-iio@lfdr.de>; Fri,  2 Aug 2024 19:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE8A166F0E;
	Fri,  2 Aug 2024 19:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mdJr8Nsc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE3A1547FD;
	Fri,  2 Aug 2024 19:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722626578; cv=none; b=k6JNK4xZJgfKBQHDLrToxUJPtjlHH8TTTeMGXc+5gA0LO+XPX6wIthsYYyVhdU8sCAsKK2HPmdYkuxeQzBRPaXXym6qKbLg8nIk0VMnA/cIIdw03dvFHx6OBI7fJRKxGlPbCaJfuvPGatALVP2LLrtPHhGUQaRcdpgPdqCOklwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722626578; c=relaxed/simple;
	bh=f8AlV+mmh3WAs+Msf35YzLUk4BjA6ykCslKCpn/PXLg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pJDZFVE52c9Bid71hLcelJwXWQ/uE8/gWxJ2Gks6Y8NGnqNAjAuyXE3ivxDgkLHU4AhxkiKSE3shG+t14lpr+XP1QNW5W6vvF+7wJ27Z2ecE3GRIhnSYro4F1Kwo2/CBhVJhy0qVfJMwm58T1WNIMMDO4hmiyqX7NJRygo8JoRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mdJr8Nsc; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3db14cc9066so5213234b6e.3;
        Fri, 02 Aug 2024 12:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722626576; x=1723231376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0JKFFQnfJOtoACQdVtR48AZhBo/Ifj44v65RGoC713c=;
        b=mdJr8Nsc4a8wYsEScXwEzTn0597nZ+bv/M+idu6C6wQN9WTKzi0ttToYCmWtFfecuw
         uCSQTc71kH/uVqprfRFfIllsX/pnCjwja+4EmPhorbk8p0qjZSrHNbSreWLPxJzMHsvt
         I5qc13f7jYohAF/qm/iGot4Y/oJV/0CHITNEYQWyY0tNwb1L8dTWY/0nhl2aw1c5pX/m
         /z6r1xXB0rClmzwMeVtr9ZXegTFIpkvRobWP7Kz2fjckPxlkeO8+cU5/7uC230JuRG+F
         iO8EUURrO8+VfZLhsVkw5Wec0TeYvoPOdfjGKxTGZdJ8jBSaW9h/1oythUs8oHykDCwH
         X0Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722626576; x=1723231376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0JKFFQnfJOtoACQdVtR48AZhBo/Ifj44v65RGoC713c=;
        b=wHF7JrYNnbiwNzkDpcQaYSRzF/O7VK34zLW6zVdFnFzp9Ylc3WJDQyEmkLaM7QHp1W
         ogBiRcUoAEZ11wbsa4MOhFUNM00LtexlIH+ViyddmEV02m1FYiX2QK7fDvlc3B/CM8VN
         ILgltk/GilAYBlySjJXofkJ2cUYheornrSXVMH6yR0on6tNDw+1Eg3QEa43DfNmhL12w
         GHjhDKv24I+Pofx8vVcweYEn/87hkXMeNul7IMUyhP/QVtPNfecMZ82iR8I6159yh+J7
         QE2uKBIqgDgGDVRp5bPO0o9FDsVuB6CcjhmJe8e3ZgKtjPsUHaWinrOaGp7FzFb7YKjs
         C1NQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUQCyZWNzNb7Pq/teJ30K6oFEilQQjuvGIdWoA/1A8XEgAzQKFXyw27A2yUE+icC96KilbXpnOoNWtUDmb1fdgp9Ct2FSlGAEuvDpSoagKiVWiVRDm6uGQkRTESGi7UL8+Ri6pFA==
X-Gm-Message-State: AOJu0Yz6uQdfNa6Sz/ziqI4o/QDben2/EqxoLie+ZHUl4w073sD69/V+
	mnZwptYEmruhe1sR/f7js5JwvIjxl0NBT+/Hr1NNzANsadKOjHi1
X-Google-Smtp-Source: AGHT+IF3I1srJKWNYL7jsDJ+sv7ElDL9LAdwud9872cKrlkAH4dok6Ad4PODlX3yNJcRGI/V+jR8vg==
X-Received: by 2002:a05:6808:198f:b0:3db:fe8:f744 with SMTP id 5614622812f47-3db558123e9mr5306167b6e.24.1722626576429;
        Fri, 02 Aug 2024 12:22:56 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bcf::54])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3db563b7065sm584592b6e.46.2024.08.02.12.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 12:22:56 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-sunxi@lists.linux.dev
Cc: linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	quentin.schulz@free-electrons.com,
	mripard@kernel.org,
	tgamblin@baylibre.com,
	aidanmacdonald.0x0@gmail.com,
	u.kleine-koenig@pengutronix.de,
	lee@kernel.org,
	samuel@sholland.org,
	jernej.skrabec@gmail.com,
	sre@kernel.org,
	wens@csie.org,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	lars@metafoo.de,
	jic23@kernel.org,
	Chris Morgan <macromorgan@hotmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH V2 08/15] dt-bindings: iio: adc: Add AXP717 compatible
Date: Fri,  2 Aug 2024 14:20:19 -0500
Message-Id: <20240802192026.446344-9-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240802192026.446344-1-macroalpha82@gmail.com>
References: <20240802192026.446344-1-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Morgan <macromorgan@hotmail.com>

Add compatible binding for the axp717.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 .../bindings/iio/adc/x-powers,axp209-adc.yaml        | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/x-powers,axp209-adc.yaml b/Documentation/devicetree/bindings/iio/adc/x-powers,axp209-adc.yaml
index d40689f233f2..1caa896fce82 100644
--- a/Documentation/devicetree/bindings/iio/adc/x-powers,axp209-adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/x-powers,axp209-adc.yaml
@@ -37,6 +37,17 @@ description: |
    3 | batt_dischrg_i
    4 | ts_v
 
+  AXP717
+  ------
+   0 | batt_v
+   1 | ts_v
+   2 | vbus_v
+   3 | vsys_v
+   4 | pmic_temp
+   5 | batt_chrg_i
+   6 | vmid_v
+   7 | bkup_batt_v
+
   AXP813
   ------
    0 | pmic_temp
@@ -52,6 +63,7 @@ properties:
     oneOf:
       - const: x-powers,axp209-adc
       - const: x-powers,axp221-adc
+      - const: x-powers,axp717-adc
       - const: x-powers,axp813-adc
 
       - items:
-- 
2.34.1


