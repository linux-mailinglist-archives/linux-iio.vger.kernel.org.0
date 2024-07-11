Return-Path: <linux-iio+bounces-7519-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BCB392F0ED
	for <lists+linux-iio@lfdr.de>; Thu, 11 Jul 2024 23:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9ED01F21923
	for <lists+linux-iio@lfdr.de>; Thu, 11 Jul 2024 21:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9C61A2548;
	Thu, 11 Jul 2024 21:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RYo0Fnjf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236AE1A08BA;
	Thu, 11 Jul 2024 21:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720732589; cv=none; b=KX9Pl6Anv7BEtPnKpgsOBzyTzLd+ZD83tRPw3BYSsFe91WYaYaqEH9tmiOirShI46ffC2R3WOsKdbRaFmWHsmeZ7Urn6SdPsnwZ6CtH5Vpw7n9pKfgkwTBfACbD9nrzfhHAAcUgTSKiBVZBUbmqnIZBddVcUWTfs3mGj8kJgtZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720732589; c=relaxed/simple;
	bh=MIY4+L0NmEMynecVeO/0pkCJzUVTmZV2u8f7wglj/fg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rGRKUtxhiC5theHgHxnNqw5zEBSfoamO8bNxz+RyhNYs6+U30Qb3RbrCXMVEa3StrCCWiEhCrs/YNBi/nTkEODfbPo5Lo4wttbi8x/4p8GojVD3gp/lxoVN/rpHW/WcdC+4V6xOylU/nTbunZjO+CgKVhwDIL9BdjiwN9rGKmvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RYo0Fnjf; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-58b0beaf703so1731598a12.2;
        Thu, 11 Jul 2024 14:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720732586; x=1721337386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qyXjzhY9ezlQQbIjndFy7mwRcLTwO66fXSYZzAg/9+Y=;
        b=RYo0FnjfS9hmLPqzigoiBIqFINMhk/TDtoUN6pMarOd2f2wTiU9BofCpiFFKWrcCwP
         ADXgbldIGg/nnJJiMJVFKRCwNz8Wp3+urYJo2FIZbgL10otcEsMrCTa7wJsg3D3O5mdW
         RvM4hjmZWNhcK5JVEJuDbSaJ3YKBL2MihuNcRDYQsQTmRzxCoOqHC0zkjYXJT+quY7/e
         +pNwmyRlXSWsqfEdYjwP/uTi4r2s38CbtNaUJZGl/5CoJXX/v1ltlR9gu8YHoeGQubIF
         2F1yDiPwQfVoYDwHf2N0Qqgsav/vFG0/qGPOYXBbgPQbWgu1fvGNq2fa+xdWuTV2WcIn
         RWDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720732586; x=1721337386;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qyXjzhY9ezlQQbIjndFy7mwRcLTwO66fXSYZzAg/9+Y=;
        b=CF6LpfpFuWzbimW2TQLL0RsVHrAYW3lXem+8fSZpLPbTZDWHhxUtNeMKhmkHX4vwPf
         qTtBt9jZTqtQEl+im+GVnAFs7b623YdNxWLFEFMabXWYIqGl2EqLTZN6/Hgp8PAGSxQB
         g2J+AMDn90eBAFGIUkqJJk8M1G7jkwBuqlmfUJTUXecbmd+JXKObaOYAS63P9cCZBCtm
         kt5zbzz1IRoKTOBKhPLiJ/N52NjbN5HbsMnk+ux1fj/3MKL3dS6OlTHx3CW8j7Xn7R2O
         gnv5QGPohBSJ29nQw1MTrZVReSbWntn1KVJEknDaB3xUWBM6PbrfWuBACjd/RUlLnVyJ
         QR+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWfrU0k1Jcc70dOPR5cfSMGQntdQsKULwRz/dSTlK3PDuHTV3nifLL2biJQkmx9TaXbqtQXPB7TxP2me9HkSeg2iMa/q8gS8d1P20P7dwzz0skF5xzwboE6XBhZlzfLYgBClgw7CGcqQVvGqagUvSa4PVbKSxIrlXcyCX77m+JI9nuVUg==
X-Gm-Message-State: AOJu0YyLHYGa6uz+x/l1EY8x0r9xVmBhQ109yorO/JW9CO9l7XN9zxE5
	GI1VFQ2rQTDlqYN0wVc3nVQgr9zZHXqT4NkTRRi5KcXdbv9e02Hy
X-Google-Smtp-Source: AGHT+IGYbC04IPcy7glc5gF3FWSXRl/0yTHBnXil0eHjKGuw3seH1ySoSv0/yZwVDIaIgI84WVEhQw==
X-Received: by 2002:a05:6402:350b:b0:58d:b529:7dc2 with SMTP id 4fb4d7f45d1cf-594b7d836d2mr7914147a12.0.1720732586511;
        Thu, 11 Jul 2024 14:16:26 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:3e02:47b2:c845:ae3a])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-594bd45a1b6sm3815737a12.60.2024.07.11.14.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 14:16:26 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andriy.shevchenko@linux.intel.com
Cc: vassilisamir@gmail.com,
	ang.iglesiasg@gmail.com,
	linus.walleij@linaro.org,
	biju.das.jz@bp.renesas.com,
	javier.carrasco.cruz@gmail.com,
	semen.protsenko@linaro.org,
	579lpy@gmail.com,
	ak@it-klinger.de,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 08/10] dt-bindings: iio: pressure: bmp085: Add interrupts for BMP3xx and BMP5xx devices
Date: Thu, 11 Jul 2024 23:15:56 +0200
Message-Id: <20240711211558.106327-9-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240711211558.106327-1-vassilisamir@gmail.com>
References: <20240711211558.106327-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add interrupt options for BMP3xx and BMP5xx devices as well.

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 .../devicetree/bindings/iio/pressure/bmp085.yaml    | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml b/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
index 6fda887ee9d4..f06f119963bc 100644
--- a/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
+++ b/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
@@ -48,9 +48,20 @@ properties:
 
   interrupts:
     description:
-      interrupt mapping for IRQ (BMP085 only)
+      interrupt mapping for IRQ. Supported in BMP085, BMP3xx, BMP5xx
     maxItems: 1
 
+  interrupt-names:
+    maxItems: 1
+    items:
+      enum:
+        - DRDY
+
+  int-open-drain:
+    desription:
+      set if the interrupt pin should be configured as open drain.
+      If not set, defaults to push-pull configuration.
+
 required:
   - compatible
   - vddd-supply
-- 
2.25.1


