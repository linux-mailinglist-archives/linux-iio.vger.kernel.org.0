Return-Path: <linux-iio+bounces-19977-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E23B5AC5C91
	for <lists+linux-iio@lfdr.de>; Tue, 27 May 2025 23:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A2994A33DF
	for <lists+linux-iio@lfdr.de>; Tue, 27 May 2025 21:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00BE1214A8A;
	Tue, 27 May 2025 21:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QWJyAZ7G"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8833234;
	Tue, 27 May 2025 21:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748383109; cv=none; b=W/fJsCBO/EPib1Hmb/IxL4Fb1EGgbijQLbE2nOXOxIRe2I3mGfYO6krWy9/V+1dFHSr/mYuXdsze1JXtg7efOr7xxftA96zCB3iiwSPX45VH5dPzv6i9jwWoNiY05lAIrVrbTpVNCba23qYkSKxsxl1Dt69rInLT1zbaQrk4HV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748383109; c=relaxed/simple;
	bh=yzfflLE/CmnA0fRHKQPauFe7qCO5bTFV4mVrTc8BWnc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jTAi7AjSt/hNG0Xj58cAZ/oifNTloVkGwZJanpl/owJ8AbbZW7WU9a/TwpKgSXTTk67s75QSgrhciDavxzrBZViD8GeG+JTDM8auLpgs4HTjltzEmlLYoP4+KCgPQ1e/QrWM/xSqilt2zDb/Kjq/DxtFfNon8EVDPqrOOVql+OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QWJyAZ7G; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-4e59012c7eeso688711137.1;
        Tue, 27 May 2025 14:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748383107; x=1748987907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AQ5vYBrKMWZaH1zuLD/k819VIENAAJhaHIcSxKwZrOA=;
        b=QWJyAZ7GHvOpPkEsnrEsIuA+nyutvWvjXl8THRfOcSzO7L+Rcj+hyidRIL8fFyBvbm
         a88j5Ofm+oJKXdW5j+Q9cT7KlBfj0YleQGtTHShRq3lBTSRmFLlVZZ0SPnlWGAy7lRNP
         JYhbQa4L5UdD49wxrJ5Gpdowq7+oH2A62742be2xjtv7aYYKeEAhDs9U2s3uf4HFSJA2
         5vxFmf0TMI/KYoRlbmJ/DRsvcPKb5leFN5NkydKJ+veK9u3XBeDH9Tkhk5xxsijvcGJp
         RRDYXvM6MyHlqxmMBMYXf6nXMlUq+PUJg5Ou60UJLaYEBTK/P9bgZ3Q17NLVpT0yenvf
         QczQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748383107; x=1748987907;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AQ5vYBrKMWZaH1zuLD/k819VIENAAJhaHIcSxKwZrOA=;
        b=DC9YpFQGI4ZdYjhrebEF2vpo8Lkw3Le3bSz+oWwz02hnYhTltgbHejFHDG9IIAJQEY
         0j/hrvaR6ID4AmS9oZFnruAnZ679/8LW3Bdaw2+IojvY2QHJ6b2lqaW0FwfZGJ2TrYY4
         KYjL2vBFPEIpjQNY+UFcHo17sHjV6qgO0RYTPmhFPEHBBccKkkE7m3sdhnbQ9TlKsPo0
         7XEGog9wPc4iRGFco4xtmEUy3VC6Z/bTx1EPGtVXjh6+62ahn7x8x+l4iNtXDVzq/7U+
         gEpyuNW99OmbUQ4xWaZPCxauXv34YjfzXVmGIE7FIBcXAPdNDSFnVPgv8X9DT5EU1G03
         exrA==
X-Forwarded-Encrypted: i=1; AJvYcCUZ6l4+NNVj0NuSACqEByAAaI/teNMbhRbGqU9K/txDJPYDVldPgpyNqFjGWDq+UGKTiKrdJ4yOUdzMddSd@vger.kernel.org, AJvYcCVSI9jCUl7+GZvGuVkC0l943GlSZO/djx2UbmPu7QBuVuRvndZl0Z232PcQHKOJci+yIu3taokRZGoN@vger.kernel.org, AJvYcCVa4GpTOld52DLKPDvnN8uf9UKgrCynR5teY9cOzLDk0JzI+WDRHjdu+P9mvGvwHO+xHgvt0mgJkVc8@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1X9WyFM1eBIvlos5KVBhXtrH2dl4f/6/Hx3dcIQNlwIHjIYa+
	+I6k6KeLUR9YjcA+iZw77yL/W63xrnn6K8BMpXAhp68KVO3eP6r+rw86
X-Gm-Gg: ASbGncvNr3WyQkupWu3ny5on5SDlazPd+4kfrSB5uCEKO1mItlJbHj9ppwIRxKl2lrK
	8o0OgALGOHhvCCHwUXuL5JUCK7wrLRsLyIix1daYeLy4H7BS+ehDzIW7If4NBT7PWUWepxhyxjO
	15y0hocE2sGv3B7RhTlpOyIQt8Eh62ijuFMHRIw2L9d/YVjOoSHRnupZiXeSYepvZsyW6for3rT
	pXmouWNLzhWyaP+EC6vA5j1dhixUnY0K0ED3ZjWJi0YYl7NzC3T1W7qoRmtWkc9NWcwQapDk7TI
	GApt8XZ8+1U0p6CAyZkuF3LI9OSDlMRoSG6qPf7eEFpWwAyMv35+4z7PSaIk0q5uK04bAchy5zw
	=
X-Google-Smtp-Source: AGHT+IEUoevBi6RywQWfsw+8GwAh49pHKNT9kloFDyB7k7GecnRthNhrCsW3FQk5GcsSNa/c2UUrnA==
X-Received: by 2002:a05:6102:3e89:b0:4df:4a04:8d5e with SMTP id ada2fe7eead31-4e42409c5d8mr12103923137.8.1748383107157;
        Tue, 27 May 2025 14:58:27 -0700 (PDT)
Received: from localhost.localdomain ([2804:14d:4c64:81ec:7409:107a:a63b:a3da])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-87e1d5abbc3sm170203241.25.2025.05.27.14.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 14:58:26 -0700 (PDT)
From: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
To: linus.walleij@linaro.org,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: ~lkcamp/patches@lists.sr.ht,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: iio: gyro: invensense,mpu3050: change irq maxItems
Date: Tue, 27 May 2025 18:51:06 -0300
Message-ID: <20250527215818.13000-1-rodrigo.gobbi.7@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The mpu3050 datasheet describes that this IC only supports one INT pin,
which means one item with two cells inside binding.
Change max to match this description.

Signed-off-by: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
---
The mpu3050 supports only one INT pin as described at [1] at
"Pin Out and Signal Description" (pg 14), so maxItems could be 1 at max (one item with two cells).
Validated with dtbs_check/dt_binding_check and looks fine. There is a different case at [2],
which is using interrupts-extended but as far as I understand, it`s still max=1.
Tks and regards.

[1] https://invensense.tdk.com/wp-content/uploads/2015/02/PS-MPU-3050A-00-v2-7.pdf
[2] https://github.com/torvalds/linux/blob/015a99fa76650e7d6efa3e36f20c0f5b346fe9ce/arch/arm/boot/dts/qcom/qcom-apq8060-dragonboard.dts#L248
---
 .../devicetree/bindings/iio/gyroscope/invensense,mpu3050.yaml   | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/gyroscope/invensense,mpu3050.yaml b/Documentation/devicetree/bindings/iio/gyroscope/invensense,mpu3050.yaml
index d1a6103fc37a..f3242dc0e7e6 100644
--- a/Documentation/devicetree/bindings/iio/gyroscope/invensense,mpu3050.yaml
+++ b/Documentation/devicetree/bindings/iio/gyroscope/invensense,mpu3050.yaml
@@ -21,7 +21,7 @@ properties:
   vlogic-supply: true
 
   interrupts:
-    minItems: 1
+    maxItems: 1
     description:
       Interrupt mapping for the trigger interrupt from the internal oscillator.
 
-- 
2.49.0


