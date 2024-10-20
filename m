Return-Path: <linux-iio+bounces-10826-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D119A55F8
	for <lists+linux-iio@lfdr.de>; Sun, 20 Oct 2024 21:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EE901C20D18
	for <lists+linux-iio@lfdr.de>; Sun, 20 Oct 2024 19:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79477198E78;
	Sun, 20 Oct 2024 19:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MPt6GaJd"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B70194A63;
	Sun, 20 Oct 2024 19:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729451552; cv=none; b=OVdWK4LrbLy5cFjSW2OmkMRmV7dB8p7r5N7UQupXvnog8wYlv/MY6FWe3mFwhp1xc/5AQvTPBX8+jsXsh64oXEE4SWWiJUqgjAoyTR6Y1j2JCTHLw01WJRMSXoDAc3fo9roKEgmWOtq3i8ehuV0sc3joxbaWI+XGmzUxa/W8EU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729451552; c=relaxed/simple;
	bh=61d8qSHJRGLnh0Y9cAoOg5eCbhpt0hm3xU+QENAD7jA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lv9wEy4IRKZeb9BMgwfzFaikv36uk9/NTp2Zg8WUoMr2lZKsK4ZRb1kI2oWeP9GZI7NLb1e8P4xe2N40ni+Q9zG1jca8DB35WP0Q6E3yQl4bskuvQXnf8E4tveBRDEPtuNPHEhbCgpI5L3Oz7k95nFoQ/QTOJTQ03bjEzpGDagw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MPt6GaJd; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43152b79d25so35543625e9.1;
        Sun, 20 Oct 2024 12:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729451548; x=1730056348; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MgE9PDBrF4vGeAFO8wmq91SsT1HFW3hejwwqxsVL/l4=;
        b=MPt6GaJdYz2s496lvAKFuBhv3OHz98bnf4gC7fMDnkr70hUS/3aui8jsd1TPUhs038
         rH0VSQDVfDDYCjoaKMAc+UiUCTPW88XP8Tm1VtcgsJtf7BNln3H7Jo7bguYo7V3IvXt1
         jXzjAvrFmcRJKeI13kzteLTFDNZb5VYzw8K5ryswY0MExPRkGgPeBCREq78dQyFoWFrD
         XZ22uczxCje/xJyMyMGm/2JoT6J3Iag5HTkA3LiN06VBQo+1wwXgNYy0Iz7TM0zbWC3b
         3fWYHq9O2lqjLLILz5NI2S+B39xATpAoxw4Dzzi9mL1CY1xEV98CKdhJrft2z1ArE3p5
         qsNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729451548; x=1730056348;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MgE9PDBrF4vGeAFO8wmq91SsT1HFW3hejwwqxsVL/l4=;
        b=A/0FO5UW03EepJzXNNybPcXgzLOV9+Ua8DuvDDwNpHAwjV8pVf2M80x7565XX4Hwix
         h9IptyG2fn8jQmepUssrnmgjToDTKgr6A0NQhDafBbX9dwJB6ii94THOvWSZQvCDXqOx
         Wlpbs5iHXqXtg9lucuSU4oE8XrHMNfwyjKnF0HL2YVGymsDpqoNO6AfkV9m7uwiqJDW9
         x5Dj6x/qt7fHqjo4wPqM+E5l3lmztavQ+JGi7LpmYBhCe1tsMVxgXFuBTbDtrfwukn+F
         8WTc0/9DSq9MpIqhNT6boxOlkidqwN7/FHpJ+qx4c2fWLdcLGi/GDqZ5Rfd0IrfOSZ1R
         dDhA==
X-Forwarded-Encrypted: i=1; AJvYcCVEReH9XqldBzUvr8E/mr6X7aRta/UcO7p8vPnDdVf0PxttVDQb2pC0VcX2zoq0BT656nc6kDj/qFGrqlsp@vger.kernel.org, AJvYcCXycu1czrJTSCcQGexU98Pv6SVSc254LOhP/TpGwR4XUxwSRg7c2WFuHgefYKAf47Hre5YB/J/1klny@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe+v7cGu6Ajmj1AXfSmCEhu0Lh0v2bihmRiXhf+xUVDg/g/BHx
	rhoOF/LXXw+anaExBt9hXHKx8kFlYyqvIddYzvvFCb2mXdW6E1dv
X-Google-Smtp-Source: AGHT+IG7TBMYwkJJ1ksSTh7tIlZXCOgZkzmEIhXPaneaAXyBiaDoSC+X6h72MfRA0oCP0f29O13oTA==
X-Received: by 2002:a05:600c:3d9b:b0:431:6060:8b16 with SMTP id 5b1f17b1804b1-431616a37femr73309725e9.30.1729451548402;
        Sun, 20 Oct 2024 12:12:28 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-6b9f-98af-2a5c-6ed2.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:6b9f:98af:2a5c:6ed2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f57b8e0sm31589775e9.12.2024.10.20.12.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 12:12:26 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Sun, 20 Oct 2024 21:12:16 +0200
Subject: [PATCH v2 1/2] dt-bindings: iio: light: veml6030: add veml3235
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241020-veml3235-v2-1-4bc7cfad7e0b@gmail.com>
References: <20241020-veml3235-v2-0-4bc7cfad7e0b@gmail.com>
In-Reply-To: <20241020-veml3235-v2-0-4bc7cfad7e0b@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Rishi Gupta <gupt21@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729451544; l=1908;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=61d8qSHJRGLnh0Y9cAoOg5eCbhpt0hm3xU+QENAD7jA=;
 b=m3kVP6/6pNcQMfB1R2YtR60kStl6jSHt1+P/YxCfNwH+RJcntSYOQkaoVwBdqg+iYfjFMH+r8
 eRrV4Ts+rE1DyZ9L/fXFQbniHoQ9sF3IMg8Nko1qyKqMaIS960E66fS
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

The veml3235 is another Vishay ambient light sensor that shares similar
properties with the other sensors covered by this bindings. In this
case, only the compatible, reg, and vdd-supply properties are required,
and the device does not have an interrupt line, like the already
supported veml7700.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 Documentation/devicetree/bindings/iio/light/vishay,veml6030.yaml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/light/vishay,veml6030.yaml b/Documentation/devicetree/bindings/iio/light/vishay,veml6030.yaml
index 53b55575efd3..4ea69f1fdd63 100644
--- a/Documentation/devicetree/bindings/iio/light/vishay,veml6030.yaml
+++ b/Documentation/devicetree/bindings/iio/light/vishay,veml6030.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/iio/light/vishay,veml6030.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: VEML6030, VEML6035 and VEML7700 Ambient Light Sensors (ALS)
+title: VEML3235, VEML6030, VEML6035 and VEML7700 Ambient Light Sensors (ALS)
 
 maintainers:
   - Rishi Gupta <gupt21@gmail.com>
@@ -20,6 +20,7 @@ description: |
   whenever configured threshold is crossed.
 
   Specifications about the sensors can be found at:
+    https://www.vishay.com/docs/80131/veml3235.pdf
     https://www.vishay.com/docs/84366/veml6030.pdf
     https://www.vishay.com/docs/84889/veml6035.pdf
     https://www.vishay.com/docs/84286/veml7700.pdf
@@ -27,6 +28,7 @@ description: |
 properties:
   compatible:
     enum:
+      - vishay,veml3235
       - vishay,veml6030
       - vishay,veml6035
       - vishay,veml7700
@@ -76,6 +78,7 @@ allOf:
       properties:
         compatible:
           enum:
+            - vishay,veml3235
             - vishay,veml7700
     then:
       properties:

-- 
2.43.0


