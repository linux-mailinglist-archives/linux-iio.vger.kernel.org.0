Return-Path: <linux-iio+bounces-8159-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD1F9463CE
	for <lists+linux-iio@lfdr.de>; Fri,  2 Aug 2024 21:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECCF2283094
	for <lists+linux-iio@lfdr.de>; Fri,  2 Aug 2024 19:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B310166F26;
	Fri,  2 Aug 2024 19:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kwfhINE1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E769166F15;
	Fri,  2 Aug 2024 19:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722626580; cv=none; b=j0M3GzMbXQp+dsFHOgBkQa0NV6XyuKyhv7LmlbY0sPFzrUkPJiarPJvaeG4BjHTFK+nScrwJG6Q8IJFx+i/b+Za6Mshgh9Qy+5bqBjx4EQkZdZVa0EwDr5ZKAlXjCI/2QEdqdZbp7J5aBtqnZjsEIePIBxxw59ZUYT3gJ/0SLkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722626580; c=relaxed/simple;
	bh=PT/vxQ1i1ejBxEgqMlyynIZyktqms6YX4zyHBodMnNQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uKtEkxyJC+2v6N3HrScm70djVP6OdHx+i2fVyVnTjGsbFDmaVRtX95tnR22pRMDWIMBEDIT/+/4d7qrtRiVkXryUXf65SxmygFf4v/qczzH0oVu9aQ/6c2tnU6O5ctTWb8MBJq7LTJJz6ykbY3ABh+ZzxIGZYt6C2sx0e9GSU/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kwfhINE1; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3db1657c0fdso5230588b6e.1;
        Fri, 02 Aug 2024 12:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722626578; x=1723231378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wPAj4Da4Sc7bnXXwUyVabTlnCi/GTfWEK2sStHPGzeE=;
        b=kwfhINE1Jq2zdtNSXf5+hLN4rSH5+P7H0OhldZD0tFf/rrAxl/Re2u04c1EdQ/t6Dk
         WRjtk1BCksINCKTIsME8wxetWRcedskAiSzJ3+iC8fXF7ysTVXi+DMP3ry3xfWyVV14f
         q8jKrDxHpZLTEVjEhwfI7ZPk9LrmgASiFzxeCiEPgfC4dFk3cPVwPVk+vnZ4uO1H90Ce
         g4xZNDDajeyiV9xukOMKhQUVpQ2OBiT0SPl/BphnWNgVYa6TRaWQMNzi4RQ/bG83d8JY
         Rw0GsjGJAgXwIQRKj16NT0M9UmwYHOAXR3FqWMip1CvqW0O4rYuo3FuEXzz5wuJ++iRa
         dp3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722626578; x=1723231378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wPAj4Da4Sc7bnXXwUyVabTlnCi/GTfWEK2sStHPGzeE=;
        b=TgdgJBPWATpSGoB30mk2pz2P2IBaETxxMgeO7kmOC6IkDQVWTQxeJLHnn6PKsnm0S0
         1nzA8PC18qa1wTvcEGj8qCe0bLmLthsje3E+3Q7Va2cyS3nnHXi3zi9IB7tdoTb9IuLr
         AS8W5f1EH9vqiLCSZjE7zOWFPFj6IB6xJ1roO/2F+O+YKwMFGSeVcyt5FRHTDC+c+MJM
         33AUKH41uC98t77KDPYIUPXE345UI4AB+yu6rMeU91IpeaeGabo901a7lRVDhP7Ixo4k
         5IXEvjV/tdPzJcoPZYCr+HMlSbMYZq3yGipGqPw43iG7wpd87voqV1hGYSpXJ7c1Q0tA
         zUtw==
X-Forwarded-Encrypted: i=1; AJvYcCXYIwCHgdtddtmS1jJ6B8zV8xFRRLn/dJFcDp15LZo2Ya3C52xZLnnhP3Rb4/z0cUXLLQgO5+fO72xzITDPGFNYNgH91/hueekg1/uW71rdCcGFUEcKOcWLMCXVGSYgRSi8MCp8fA==
X-Gm-Message-State: AOJu0YytuGppS1ll/W9y8JS7Z+YqIVUC/4aoBgI55rgDAxQ5z+391jqE
	Fr8MwdWSPZ/sAHGUHJWZFmkxxWBwYQ0LLbdnjK/4yEvMDcddMuUF
X-Google-Smtp-Source: AGHT+IH5FX5N0fvUR4u9IMiWOV2xMdXKwvmYk5UzTJWm8zGmj2cVf45I4G7jUboGD0xL+cSlMeMroQ==
X-Received: by 2002:a05:6808:30a6:b0:3da:b335:538e with SMTP id 5614622812f47-3db557f8800mr5227348b6e.8.1722626578200;
        Fri, 02 Aug 2024 12:22:58 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bcf::54])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3db563b7065sm584592b6e.46.2024.08.02.12.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 12:22:57 -0700 (PDT)
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
	Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH V2 10/15] dt-bindings: power: supply: axp20x: Add AXP717 compatible
Date: Fri,  2 Aug 2024 14:20:21 -0500
Message-Id: <20240802192026.446344-11-macroalpha82@gmail.com>
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

Add binding information for AXP717.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 .../power/supply/x-powers,axp20x-battery-power-supply.yaml       | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-battery-power-supply.yaml b/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-battery-power-supply.yaml
index f196bf70b248..5ccd375eb294 100644
--- a/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-battery-power-supply.yaml
+++ b/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-battery-power-supply.yaml
@@ -23,6 +23,7 @@ properties:
       - const: x-powers,axp202-battery-power-supply
       - const: x-powers,axp209-battery-power-supply
       - const: x-powers,axp221-battery-power-supply
+      - const: x-powers,axp717-battery-power-supply
       - items:
           - const: x-powers,axp803-battery-power-supply
           - const: x-powers,axp813-battery-power-supply
-- 
2.34.1


