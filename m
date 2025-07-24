Return-Path: <linux-iio+bounces-21953-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D6AB108D4
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 13:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22CB218911BD
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 11:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D575E270572;
	Thu, 24 Jul 2025 11:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZGvYe1/O"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16C72701BB
	for <linux-iio@vger.kernel.org>; Thu, 24 Jul 2025 11:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753355648; cv=none; b=SwcbKcbx8jUQOYjMiv8mFnz7T+tvCuIVRGrhVSBODOjp27ablauRjaEFE/z3IYOUnPn2jxeAfYwbut8Oh47zoK1VkSHre+VUtFFYumF9t8XB2Tbr7nyvDMfm/BOWeezJNHXJ3ox5M0Tx1JWrzBGD4FhxsKKvG2wen+Iuc+b41Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753355648; c=relaxed/simple;
	bh=b6N2umPNTV1IfL0+b1JOlj8SzHV/dhc713qHvi1TTIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jr/k84Da6lgk7yAhJq38QZhcVzL3CGvscsuWLzfopl8sARZv8V90P4XSuv2bVxyns2ko3tb2MhP5H3fbjInP0X1zeRVE2Jj0Cfj0AfshwmbMLFDuVDwNkxQ65Vt85wUHjJ9+WiIccXKPJ3En8w375tDz/KpmwBpEuBHdkKx1tgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZGvYe1/O; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-adb2bd27d8bso14504066b.1
        for <linux-iio@vger.kernel.org>; Thu, 24 Jul 2025 04:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753355645; x=1753960445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bQZpQlnfxb8+AbjkuLqrM6+tWlLtQf4du/oIELr93aw=;
        b=ZGvYe1/OENH+LRmIDw9ZUOU2QvRiPphRgi9aW2GVd7l3hovyHqH/msU01Sa8C+CX7K
         HRipvMixVPDI/e13ZNl7xXI1IQVADrjUMg5LVaJIXLc+YwAZWWDWzfU1AFCMsr2f4Xam
         ZA72gwQwx2ZpAjAZ8XPPQJ7xv1dhJsO7p9w4BrKDOb+Mubl2kM/bJ5tOqAMDoIBXV7Kw
         s7RmLQdZoPzO8qdc5X8R3eWcly4Si8H0bCnAvKQUdtYLXlXzqx+tB9roJKwYV066yINZ
         mA8mqH5HTXiH19txyTvczNdBbKNy7mnRqfKIgQmu+gTvb3IgXWWhrM3W9V7gsXWAsRRC
         sCrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753355645; x=1753960445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bQZpQlnfxb8+AbjkuLqrM6+tWlLtQf4du/oIELr93aw=;
        b=QrhG2bHEbOS6D/+FNtEPCIfXCclUTmXUQG4zqcL8rp9L3bovJvO8i4KRFqT/fU340M
         9FxHKA2Qc6LEFPeRgJBFfazSj954KiCWA8kUi29rnlieP8qdBLErcMItmrNgXk7+yb9o
         ayafX1DzmCzSXjQ71wVycWB1+3nCwU9efyjq95QueZO5pbuqHQzTVhj9q6LMvkHzatZp
         c94OhyMLv/k7LOqX+OWPYBySwhnQaIJ6pzFMZHULM0i35QMRH5eFxYHCkNFbgtBONnFW
         u06+smqMP2JHphLxe8KNiks1FKSKXyeL0353Bt0aWayNdBhk6DJaadZx3AuzBd8YTHqE
         ph4g==
X-Forwarded-Encrypted: i=1; AJvYcCXCyE5OqeCkwr84z2mdjZGURorEpiO6gPrenFStJuEa4PeAwQVHAYXtDCxh9e57pndJkIMliIPVdyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxwg/gwpexKG2ASj4StBeRYJv4/L0hw/JS2TsFDezMqydd1N5OO
	M2tPpMMxQ1+cjvs7x22LlTbdZ0MMpnMYhOg12tJx2HvkU3O5cN2AK3pxEblW5jg5oY8=
X-Gm-Gg: ASbGncuQ+LoJtwxBGcPpi+L5SoJ6q6xREs7jJEs2zydm6ba3RLtc+PV92pu80Wh02nd
	hy/85ktWJacl0plWZ1GKVapZMWGas0mgZrDAf0Iep+ddmXB3z8D3xUO4U6ZG4zJC6cTALNu7GCy
	ca7ZHcFpp69yv8nGDYil3Td8OGuJHwWFTJL65IJ+QfqYfa+os23Ge7WQ54/+8iJujnGQ/zkIQHL
	BfF/vrdMHmQl2F6/LFdfQO6zrvS429Q3i0QoDQiNtFZWjJacKV0IK1JZu96nvNS9C/95AFm+nuU
	/paf/iSsp82LMHV9CNI7pi7Y7342pk3DRFX4gJyuKnnpSuGMWddtoOjw8q979aUU2f784df++r2
	/u7yRTuRu3vttwE8B7OQcIkcMXj6ELzV4
X-Google-Smtp-Source: AGHT+IFa0qQb9reYIZm1YmnTMClWxGtJ7wMFuJjmizdol6uz/d8+OmMad9nebjC8fBgVpRYvCf7I3A==
X-Received: by 2002:a17:907:da0:b0:ae3:bd92:e6aa with SMTP id a640c23a62f3a-af2f6d21a13mr251363066b.6.1753355644977;
        Thu, 24 Jul 2025 04:14:04 -0700 (PDT)
Received: from kuoka.. ([178.197.203.90])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af47cc6b416sm98680266b.40.2025.07.24.04.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 04:14:04 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lucas Stankus <lucas.p.stankus@gmail.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	Dan Robertson <dan@dlrobertson.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Dragos Bogdan <dragos.bogdan@analog.com>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	=?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>,
	Alexandru Tachici <alexandru.tachici@analog.com>,
	Stefan Popa <stefan.popa@analog.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Stephan Gerhold <stephan@gerhold.net>,
	Ceclan Dumitru <dumitru.ceclan@analog.com>,
	Alexandru Lazar <alazar@startmail.com>,
	Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Angelo Compagnucci <angelo.compagnucci@gmail.com>,
	Mike Looijmans <mike.looijmans@topic.nl>,
	David Heidelberg <david@ixit.cz>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Andreas Klinger <ak@it-klinger.de>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 4/4] dt-bindings: iio: light: Simplify interrupts property in the example
Date: Thu, 24 Jul 2025 13:13:49 +0200
Message-ID: <20250724111345.47889-8-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250724111345.47889-5-krzysztof.kozlowski@linaro.org>
References: <20250724111345.47889-5-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1756; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=b6N2umPNTV1IfL0+b1JOlj8SzHV/dhc713qHvi1TTIo=;
 b=owEBbAKT/ZANAwAKAcE3ZuaGi4PXAcsmYgBoghVv8JkjSZ8TS10rImPxhJU6HQEp0Ax8CdrPj
 oFHeCKo4tmJAjIEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaIIVbwAKCRDBN2bmhouD
 1+xND/dph6v3f/nk6xR6ZOVDJzqcxHAMQW0NMaZkXHLCSexCIrYiXqPYWGOTQr1kxGVpawORqWf
 WEys7LnslZMo0RJeJqF8MU49l5ngYTPO5r3uwWWR5ujBuBUgIWF40bZMZaNZ1jFzFh0x6NzQ8on
 fNRUkL5E+WhVNien8tpppc5W35sunUUoI67pNmo//pIbOY8l1YK4/z7OhPxQvtnBKTzq1/5ijPl
 emLzxmSY842kA/l4YDqE8VFKBmsR+nQA9jByliluWCNtbvkrQ8BVrXWFbnfeEo+Ts67krs0+Erq
 RdOszM9836SAecgYaVZyk/ChFftLLywwpXH/H0RUg0QKbBPYOkKDvj1wRYD9I5QHH0JHqyoLf0Q
 KkLiEFfGNQ/JZqaxildmiiHNEjQzacsj8YmT7HM5slfZoi6iWYz4WNHwzv55SFke2/1VNLEyh4C
 DsgO7tYJJ2HWrG+YPZTu6KohrQLV9M/CF7Gna6E/QGEI3FY4A6E8iSPvDNEGsZ03dfOkxOxM4Qm
 UxxJMk35cSze6vAI2pFfB03721d2x25Cf4RuX8hKGWUJ2yYM05eYGn1msvWybWR26ogcI0UG6Lv
 HvhlielC+QYEOhDWOSK7f2olNiVjRlngmx/32jTCIwy/0R+HRhYN/35eAAFRVVtmuuxE3sMMSym MHhpGZoVv9Prp
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

dynaimage,al3010 and dynaimage,al3320a are I2C devices, so their
interrupts are not routed to GIC and rarely first interrupt cell is <0>.
This looks like copy-paste from some SoC block, so drop it and also for
readability use known defines instead of hard-coding interrupt flag.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/iio/light/dynaimage,al3010.yaml         | 2 +-
 .../devicetree/bindings/iio/light/dynaimage,al3320a.yaml        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/light/dynaimage,al3010.yaml b/Documentation/devicetree/bindings/iio/light/dynaimage,al3010.yaml
index f1048c30e73e..1472c997c16f 100644
--- a/Documentation/devicetree/bindings/iio/light/dynaimage,al3010.yaml
+++ b/Documentation/devicetree/bindings/iio/light/dynaimage,al3010.yaml
@@ -42,6 +42,6 @@ examples:
             compatible = "dynaimage,al3010";
             reg = <0x1c>;
             vdd-supply = <&vdd_reg>;
-            interrupts = <0 99 4>;
+            interrupts = <99 IRQ_TYPE_LEVEL_HIGH>;
         };
     };
diff --git a/Documentation/devicetree/bindings/iio/light/dynaimage,al3320a.yaml b/Documentation/devicetree/bindings/iio/light/dynaimage,al3320a.yaml
index 8249be99cff9..d06db737cd9e 100644
--- a/Documentation/devicetree/bindings/iio/light/dynaimage,al3320a.yaml
+++ b/Documentation/devicetree/bindings/iio/light/dynaimage,al3320a.yaml
@@ -40,6 +40,6 @@ examples:
             compatible = "dynaimage,al3320a";
             reg = <0x1c>;
             vdd-supply = <&vdd_reg>;
-            interrupts = <0 99 4>;
+            interrupts = <99 IRQ_TYPE_LEVEL_HIGH>;
         };
     };
-- 
2.48.1


