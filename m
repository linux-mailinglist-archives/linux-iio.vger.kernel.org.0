Return-Path: <linux-iio+bounces-8609-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4DE69570CF
	for <lists+linux-iio@lfdr.de>; Mon, 19 Aug 2024 18:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 825D62835EA
	for <lists+linux-iio@lfdr.de>; Mon, 19 Aug 2024 16:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F68187859;
	Mon, 19 Aug 2024 16:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IYjwcEzi"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62143186E2A;
	Mon, 19 Aug 2024 16:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724086130; cv=none; b=BJn0KbHMnDTT81uRavvpzI4LniCvyInvT6GI3AsBpJAukzzEnmqlzVblrvWhX5Qx1t3vD1zvWR+qbSfjLYlCpspfgnGTPvJgFAsgMNV2ZJvRx828dCV5xcg6HylMIP9WN3O4yAGBOaGFBSi9YOHIwi54uymBNbI7SPtv62HBdNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724086130; c=relaxed/simple;
	bh=16TxacFQRSnmxQxajH2B5k39AW2lRgjLC38Elp8ySLw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uUwvACgGYlt4/BAtbh7lP/gP8ftKbrcfNlJqe5E4cZMV2/eroZnGz3+fIVllCaLNlJxK6Jvv2Lm8N2Wca6PZucR38j/pauswO18dCBm895cCh4wlD5PqyoIaDRrdAxh4eehphvohbP28unLsuDXU2OFyriY3v2rxhwKa28Mi34w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IYjwcEzi; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3db18c4927bso2636198b6e.1;
        Mon, 19 Aug 2024 09:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724086128; x=1724690928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RkkzIKfrsu8xLnQwZgjeVDvaKU/MUJN67PA3Rk4p0CM=;
        b=IYjwcEzi8xvP9EC2woeb0Sc99O64qkygbxp85++i+DaMUVbLkB4Q2J+eOJaGP/cDtH
         xWJjBowVNeBQc1vYgqIRP7WIozYzPlNZTnnCvHsFjx+fluxTyU4jzDQnWeqOQrfI7mtc
         iUgBgsqJjL3UJqiN7G6s97bVqdiypQfKi9baB1PJA6MJk5V8wiEOmhLvJ4TVdLQBQa+N
         wpmCy4woWJchNlyyb0h0Y23jCqzoNzTPIWlnxs4B7JT4lI7KCfXUuokTuD6gYLMw4tx7
         IaIMtL8vWqGpCM/zwLjL6hFk/LCj5hWsiWHkgmEturydKTZ2BT8QViDAkZFpdHIREkir
         5XxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724086128; x=1724690928;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RkkzIKfrsu8xLnQwZgjeVDvaKU/MUJN67PA3Rk4p0CM=;
        b=oF6plUArO4kBOnlsHnZY15DuJSIpIK1+KFMdW9tu3kfy/YBl5bFGlJ9xzL4fV1CMDA
         ysd7mRQcNce7mFPBI2hCXXS2I1iy04mYJWjWeUlhr9BaBaKuJ2VN5/B7qk3VWu5oHwoc
         QdhH9NUVCdGZV5CSlueV8vnKNqLzce7TRqIKOWwxSrOCWW6+VRTZEJIEeUdYW256kacj
         +XfQJmmu0EBadRpBAigf3CPoBN+028UWg7Lw+XuwlsJ1Qef3eRU7o5JVAqld4uAXuY+F
         EU9/4+vBVhtNgRzeRpxuEnKmB06K62hrHgJlKzNs05E/1Gf+n1WG5iL3C8/ypfAryn4w
         +E9w==
X-Forwarded-Encrypted: i=1; AJvYcCV3WZQfSCosVBsk/BY5MckfEr8TwXLT8lgYFJpN+u42JG8Oc7mO2r/XgHfK+lwUT57hU0hYq4jUsMxAZLTzuO/U6lprQg1H+guxQK3ZztWzc9Ngi4yiWbxEO3gG9NpdBAPxwBUO/g==
X-Gm-Message-State: AOJu0YyEyXqqbxu3z7Rs+siZqq7YOAfX5YewL6jtzLvcK63lGD9IXi8N
	+1fI6k6hBF5fEAzvAa36Vpt2jNdwGXVO+YiLLV9tTD29uK0un7/1
X-Google-Smtp-Source: AGHT+IHO+Ajg81O2h/SkAHLfyjith17Lryqw1V96phGP04oeUSBU32OaTyHFcHhsC+FfxE2gv09F6A==
X-Received: by 2002:a05:6830:631c:b0:700:d506:cfe9 with SMTP id 46e09a7af769-70cac8585aamr13557410a34.19.1724086128416;
        Mon, 19 Aug 2024 09:48:48 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bcf::54])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70ca649c61csm2332428a34.26.2024.08.19.09.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 09:48:47 -0700 (PDT)
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
Subject: [PATCH V3 07/15] dt-bindings: power: supply: axp20x-battery: Add monitored-battery
Date: Mon, 19 Aug 2024 11:46:11 -0500
Message-Id: <20240819164619.556309-8-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240819164619.556309-1-macroalpha82@gmail.com>
References: <20240819164619.556309-1-macroalpha82@gmail.com>
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


