Return-Path: <linux-iio+bounces-8671-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9ED795A74B
	for <lists+linux-iio@lfdr.de>; Wed, 21 Aug 2024 23:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED1401C22B78
	for <lists+linux-iio@lfdr.de>; Wed, 21 Aug 2024 21:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E81717BB33;
	Wed, 21 Aug 2024 21:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YYp1SneS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA6017C23B;
	Wed, 21 Aug 2024 21:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724277456; cv=none; b=X33jByf3uhXoTWpIKTA2cQnCpwQcHBZ1Jdo7uJmwx3H67YX/E8SLjFBeClW6UhkKFu2RTyY1T8+BtkV03Zf4hCCeQ5+U5bHDeSfCSuw54AyX0vlEqpDvs8rAD/fuzUPsD2+0MucEkU89MiHkqfkMoRCIaYSey50Vp+MxZBPx7wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724277456; c=relaxed/simple;
	bh=16TxacFQRSnmxQxajH2B5k39AW2lRgjLC38Elp8ySLw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZhFWtl+A4iIvK6T8k35LjVTfx2glE6ELX3/R91E20ClNxsvKY6rZZY8yBg8uwGRv42KC1xwOYyAWPQYur7r8mW9ssMNlBzNW9oiuyfBQGFdi2vJHvlgQFm1YdvqQ6qLv16ks2cZutPaIMguNUnj2In+CJmlaIH/RKCArY2CVhKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YYp1SneS; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3dd16257b7bso63097b6e.1;
        Wed, 21 Aug 2024 14:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724277454; x=1724882254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RkkzIKfrsu8xLnQwZgjeVDvaKU/MUJN67PA3Rk4p0CM=;
        b=YYp1SneSnBRz5DbeqUz1gM/9ex9YZ62ZACTGVS7wjD88lgdT9DbQE4T1eKWavNPkiz
         zgb0T1FI6GthJQua6VQfsvYChSueCN5z/bTSsMkn3HYh1/DE4oCnmBY/32GZl6mt/PuX
         HcUyA+h4ALA5k4PNIiTkASagpTrk0tyFI6Dxsfm5yPQmVwN3hEcr0C+tRxzwiMKqTXwT
         fcdITkJxGeZhjQnjlS4+L41608scv7kXUJNDKrfRYDRb5w7Vdus8L/Kt8WuAab2m+AkO
         nlIbl3O73oBT+vILMcKNvBZf9Qvx1PwWNifUfzVsgq8QJaoQ97o7lTeGSHAv2yV5fweF
         22wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724277454; x=1724882254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RkkzIKfrsu8xLnQwZgjeVDvaKU/MUJN67PA3Rk4p0CM=;
        b=ODNB79l1XN3iqsGL4VbiP8/ZqRDLW3VLqSvx+DgFOEJBPFoa/RFNUc3vV3UNWNtsGR
         q1Am+uMPDLQfNHhFED4RlYI70JSZxwd/4lGNr2IvhFv6Vb3vqfonBHm2dUhqyS49u3qT
         3i5MPkZE66bV1hxp7zpe35Nx+06hpCtkasZE5O6GEQj4va4P0OUZyrZAE7H873t6aDfB
         OqUOZ50ucaiLE0f/w9DAif+lPuYKqq1cvsdfCyOuJwDHyHAcsIy2Psk2CJIQoR+pvjtZ
         pq6O4MluRMkUJjB06pmFSSEXrSeAMAPSGQOX4fxHh+ZsmkyZ37kOGD6ruFVCGjJ7BiGI
         QdkA==
X-Forwarded-Encrypted: i=1; AJvYcCWzFcEFavSZXURez/thxQKpjbrLwo1q4/GZkm8dVGHuFEefzhRnYlAmIZovIYEwnCffcegOkb+UOgUs@vger.kernel.org, AJvYcCX+CQTB0suyIBIicSTgAhOq6loUohKFW56BPvNIyE7G+5VKHNA9KGtxpsCDJABZdPkrf2Pg6C/BvnEJ@vger.kernel.org
X-Gm-Message-State: AOJu0YyrvlsDIK36CEa148zomrWBqBIniNAAt2h06sMMegV6+LnkEUfa
	i6Rs/Jcqvb8KhdQ3HHgjRfKHEv2tonpeUzqHSJWnungveOHTvdM5
X-Google-Smtp-Source: AGHT+IGG5pB023gZP8ZguddlFNlR28q2cmj9bTwLc1Bj1tHSp3mMg1g9qpl/sTQ1MotPq+SJ7pl1cw==
X-Received: by 2002:a05:6808:1796:b0:3da:aae9:7165 with SMTP id 5614622812f47-3de194f96e3mr4164334b6e.14.1724277454392;
        Wed, 21 Aug 2024 14:57:34 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bcf:81a9:2325:e0f7:7376])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3de225555b6sm47070b6e.17.2024.08.21.14.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 14:57:34 -0700 (PDT)
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
	jonathan.cameron@huawei.com,
	Chris Morgan <macromorgan@hotmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH V4 07/15] dt-bindings: power: supply: axp20x-battery: Add monitored-battery
Date: Wed, 21 Aug 2024 16:54:48 -0500
Message-Id: <20240821215456.962564-8-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240821215456.962564-1-macroalpha82@gmail.com>
References: <20240821215456.962564-1-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Morgan <macromorgan@hotmail.com>

Document the monitored-battery property, which the existing driver can
use to set certain properties.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 .../power/supply/x-powers,axp20x-battery-power-supply.yaml  | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-battery-power-supply.yaml b/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-battery-power-supply.yaml
index e0b95ecbbebd..f196bf70b248 100644
--- a/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-battery-power-supply.yaml
+++ b/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-battery-power-supply.yaml
@@ -28,6 +28,12 @@ properties:
           - const: x-powers,axp813-battery-power-supply
       - const: x-powers,axp813-battery-power-supply
 
+  monitored-battery:
+    description:
+      Specifies the phandle of an optional simple-battery connected to
+      this gauge.
+    $ref: /schemas/types.yaml#/definitions/phandle
+
 required:
   - compatible
 
-- 
2.34.1


