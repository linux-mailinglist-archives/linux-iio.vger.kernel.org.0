Return-Path: <linux-iio+bounces-4319-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2BD98A89D3
	for <lists+linux-iio@lfdr.de>; Wed, 17 Apr 2024 19:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3E1D1C20E86
	for <lists+linux-iio@lfdr.de>; Wed, 17 Apr 2024 17:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44AEA172BBA;
	Wed, 17 Apr 2024 17:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ho4hgLtp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC49172BA2;
	Wed, 17 Apr 2024 17:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713373473; cv=none; b=IQ7Con1mgLZ0PDoR3qxdm89it1m1LmDYC9ISd6wQ53mfJuzAei4+QfqETGuRiI4sSlfAsPIlQWvM7BjXWqkyZUNMsGOj3IOocIh+ajk7iTXs6DnfoNu9LZz0mN3djUdE9JHM3pPsHiU6RmCJihPbwfmc+nOKUAjFGTIrsCOBMjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713373473; c=relaxed/simple;
	bh=nLBeWAQeiKbZf3mF1ykIdirIbJIAA4nnhmQ1kThLG0Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ork2K0D5wa73JV0fm6oEVL/9P9rhCfF8GRsBlIEcHuZwx6oCJ2kkwIQab6lN6U0XW4CEq6XcsfkDhqWzr5qyNUsQYgKSuykcASU/tDYIPdI7oMQwRdZLzyvclI/9GWjLYZV/8VPuPxP7UPNmm5GakN9NjFHh8TBMi/152+ES6iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ho4hgLtp; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-222b6a05bb1so3557643fac.3;
        Wed, 17 Apr 2024 10:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713373471; x=1713978271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WvlGloqVqYqrVdULrntdx9ykOfT/I/tNVxJeqY/xDsQ=;
        b=ho4hgLtpI37XDmXWLnSybruy/ygNTpFQxl//Ke3OvjL8i1WQg54hB8Ulj+H+5WVilN
         lC9B+YE1AOMBlmLrAAINR7379MkOcLRby7IoYYpTTMV94dVSrd6l7uzj+Bzq5gsOIAYl
         gq8Dq5bxJG79D7kECKuZuWrPAwdN8hTEzLKQp+8Vjk4N35hSlNzCwcnHbqAkbqE/6/oo
         UizpF6TWOlUKxvtCVSY7topl+1z6K1mmq9V+CsdKaGJlh59Nj9fTgZckLujTAkLkzkLA
         qjmXg38dzkA2/cpsWQKFv+N2EBrRc02K+N5iN9xl6hwntGsUZY6N52ZrDWge500Jvk21
         D5AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713373471; x=1713978271;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WvlGloqVqYqrVdULrntdx9ykOfT/I/tNVxJeqY/xDsQ=;
        b=PXXJEl5qXqPbmX1sg8/mjaV8x2j8WIWpkiJFRrXN+/VZDSLkBf+xhVM06SQcPknfFK
         /8M3WupSYZdSSlcRdE7CyUI/eVUqS7ybpoAPV5tBAObvfLPgg08unJjdxxP0lxm/b46J
         5bdm/zrWe5+bp4VFFqGsA3YqxRNup9tjhcMY/5Pg51eRL9RVYTLwq4f6kOSP4Nn1aHkB
         WJ6jWDx2uhxyk/qch8TVRy0h8qGYfDi8QB4CUThoMB2hjp42FPwF0omJxQHuOcafggNM
         uRnHy0Ig3C3pt7mVd7oEmWxybuO+viS8c/1PI277YT9v3rbUJPjF7QgijBnyFLujZEF4
         QDPw==
X-Forwarded-Encrypted: i=1; AJvYcCUCIyWyUepVOC9taL9ucdmklwZB6LasGvoHnsE2JrjlZMN+TcGRMu1QzQQej7+LpP+bYhORqWlDi3LApmaUVW4GvIU/pNUc0gl8r1ee2sC3U5ZELTPLvUt/Agj7Ahx/zCBc3zVubQ==
X-Gm-Message-State: AOJu0YyBSrYuXo65BAlvKGBXtg7XWJexm8mjbVKTE3lpyDZPXaIHIRVY
	37i/QqlBxJRdCOMSpfH+DpOtCBfmMt4CKJMZvfRaG27castGIdDc
X-Google-Smtp-Source: AGHT+IHtCr9ppMf52l67g0OPTfj+8NuBOPYiNMq3frVYOEx23sXZoPzKUhtTawQ6kjwZcrqYwStuPw==
X-Received: by 2002:a05:6870:e311:b0:229:7fe1:5674 with SMTP id z17-20020a056870e31100b002297fe15674mr171917oad.29.1713373470452;
        Wed, 17 Apr 2024 10:04:30 -0700 (PDT)
Received: from localhost.localdomain ([75.28.21.198])
        by smtp.gmail.com with ESMTPSA id k20-20020a056830151400b006eb77e42ff5sm1721615otp.26.2024.04.17.10.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 10:04:30 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-sunxi@lists.linux.dev
Cc: linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	p.zabel@pengutronix.de,
	sboyd@kernel.org,
	mturquette@baylibre.com,
	samuel@sholland.org,
	jernej.skrabec@gmail.com,
	wens@csie.org,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH 2/3] dt-bindings: iio: adc: Add GPADC for Allwinner H616
Date: Wed, 17 Apr 2024 12:04:22 -0500
Message-Id: <20240417170423.20640-3-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240417170423.20640-1-macroalpha82@gmail.com>
References: <20240417170423.20640-1-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Morgan <macromorgan@hotmail.com>

Add support for the GPADC for the Allwinner H616. It is identical to
the existing ADC for the D1/T113s/R329/T507 SoCs.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 .../bindings/iio/adc/allwinner,sun20i-d1-gpadc.yaml      | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/allwinner,sun20i-d1-gpadc.yaml b/Documentation/devicetree/bindings/iio/adc/allwinner,sun20i-d1-gpadc.yaml
index 7ef46c90ebc8..da605a051b94 100644
--- a/Documentation/devicetree/bindings/iio/adc/allwinner,sun20i-d1-gpadc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/allwinner,sun20i-d1-gpadc.yaml
@@ -11,8 +11,13 @@ maintainers:
 
 properties:
   compatible:
-    enum:
-      - allwinner,sun20i-d1-gpadc
+    oneOf:
+      - enum:
+          - allwinner,sun20i-d1-gpadc
+      - items:
+          - enum:
+              - allwinner,sun50i-h616-gpadc
+          - const: allwinner,sun20i-d1-gpadc
 
   "#io-channel-cells":
     const: 1
-- 
2.34.1


