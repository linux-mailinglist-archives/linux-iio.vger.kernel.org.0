Return-Path: <linux-iio+bounces-9720-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 640D697E48C
	for <lists+linux-iio@lfdr.de>; Mon, 23 Sep 2024 03:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D7941F20FD0
	for <lists+linux-iio@lfdr.de>; Mon, 23 Sep 2024 01:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B41B79F5;
	Mon, 23 Sep 2024 01:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hPGjGQNE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15BE4C76;
	Mon, 23 Sep 2024 01:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727054353; cv=none; b=qQ/ylw8M7f3WEc/vJwUuogrsje0lgINr+J1jrRlFywfeAnKofPA4iVBH08hMcsHKLn9z8hWmetcS2CErH3Z1qB7nlGGLWhgHRJS9m7i374KS/qmiQsLXYpi2ZGzsU25SfyAVxcFoEVRFjlovi9Fp1Lzy+dMqMyjlbTzuh+h/xVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727054353; c=relaxed/simple;
	bh=Bm/fBbwunTzc3PEGFPO09ruF2L1lCurkxmNpD75i5yg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=im9i+sHH4v8Stho1NxolvEj8s1kdnClmQKZH0cnlMD0rRvUp0TOTPdXtDVb2JBvpUJGLeJhlErDFPkjB931WT4oTBxusMx1uu3lvcjpwwVDLBXgWSpb1mf89ZO+JHVcXwpMVbGIRsFhHphkv8Mifhz2VQPf4CBVCIwXTWn6dZlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hPGjGQNE; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2d88a8c66b7so487940a91.1;
        Sun, 22 Sep 2024 18:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727054350; x=1727659150; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AkrHRAhQFFi5+tb6de5seDTs1lMK4Ba4Gh6+v4BLRIs=;
        b=hPGjGQNEhoYB1TfIOSw5W7er5pp8GXBV5acIHy1vRFMDWFCs0z/sWjJEV6R2xHIH2D
         QxWEZcdm89G1tiYvxNtEeyRH1CU34HQRiiQXtuKqjwU8/jYwSNbXs0jwfAnzLPKkyQSF
         NRaUyENyTxIH6rv+mjedC7DxFtgSgD3LyE+3REd4h2fuO3iBQ5VIBR23oC49fbAn3Ljl
         gkWiPrm4qfXwuOhnx13QxhmFJoCyrNjv9FoKGnmWcg3Xx236aeW2sIyQNZprT84u5PI2
         1cUvAUAaMQxQfw3Ql1I5l+jK7KpW6qZQ28SS1cwYp62qkpvvdTkiUQYAh4JBHg0IOL/U
         pRwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727054350; x=1727659150;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AkrHRAhQFFi5+tb6de5seDTs1lMK4Ba4Gh6+v4BLRIs=;
        b=YITBASG0dNMSu+Fy46yOweArUyQKf/iGN04g8ODspGNdVWrsOUt+r+ZdSlNglyRSjr
         D/tCNKSInyog0wDFcEcXsByWqtqSfUm2PL6buv1oX63bxBA3dAIjY3ogQpEvINJyMBSG
         KOEf3+q56MiJFFAR1zNzl7d1PrsCitIYkHWY0WdNf2LjDCX1mS7arnCuYhAXkQZibdaR
         XoKSZIrI92XFu6OH/UzX0MzpbE2l+L8eaRgVCB+KHWBPxmnQMz+Kdtp3MvWUChknSnHX
         ot968919Cqg521OpJP7NEbIHxHVODiLa1ndZHT6cFZ9kry3k8+OEN7i7yOKiP9hLlNfR
         47PA==
X-Forwarded-Encrypted: i=1; AJvYcCUEL6SjTXRnEbBAIFXAyu6cmi5dhJuIrY0tZRxqHelG8l8rLzJqoC2iaJ5rUyVYLXrN2xiXzxemCjL3c99e@vger.kernel.org, AJvYcCUNvs0ZoI421SIq/VzArItU8txGMzKCPyYXwdyZKk7B9SnwAdXV/P1lDjRXwpr03wd9+qHjLXHdVRVC@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5bNN6iJ/6e9i1e6iM82BfWAcqDyQMRfrbSjqVGYDBgRguYmsW
	PImmrEGwl3FfgTHQlYbPqrSN6cN2odccCxZ3QvqGdCvfaBBqZiBrku08CjX0
X-Google-Smtp-Source: AGHT+IG1HgpbVCo7mlJKqLiAKvitkjQ9Vnu2PHFQVNi6W8Nt50ebW98MAgUdrF7jQoV3nyOPzYxFMw==
X-Received: by 2002:a05:6a21:7891:b0:1cf:37d4:c50b with SMTP id adf61e73a8af0-1d30a94d354mr7684747637.4.1727054350545;
        Sun, 22 Sep 2024 18:19:10 -0700 (PDT)
Received: from [127.0.1.1] ([45.32.86.188])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db49920497sm14408888a12.45.2024.09.22.18.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2024 18:19:10 -0700 (PDT)
From: Yasin Lee <yasin.lee.x@gmail.com>
Date: Mon, 23 Sep 2024 09:16:10 +0800
Subject: [PATCH 1/2] dt-bindings: iio: tyhx,hx9023s: Add performance tuning
 configuration
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240923-add-performance-tuning-configuration-v1-1-587220c8aece@gmail.com>
References: <20240923-add-performance-tuning-configuration-v1-0-587220c8aece@gmail.com>
In-Reply-To: <20240923-add-performance-tuning-configuration-v1-0-587220c8aece@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Yasin Lee <yasin.lee.x@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1455; i=yasin.lee.x@gmail.com;
 h=from:subject:message-id; bh=Bm/fBbwunTzc3PEGFPO09ruF2L1lCurkxmNpD75i5yg=;
 b=owGbwMvMwCEYyfeRr6Zs90zG02pJDGkfDrEfOrp24/at+n7Rd93D5QR1Vjd+YDnakvTbfOdKN
 5N7HnKOHaUsDIIcDLJiiixnXr9hzVd9uCf4t2sGzBxWJpAhDFycAjARv1cMfzjfnQ1n+GQsfXFX
 68+ARMYNCy3vZM58KyPdv+hb02b5mG0M/6zDzns7cXm8Wz0p0+HG2nc1U+379wtv3iafN61lp94
 BOVUA
X-Developer-Key: i=yasin.lee.x@gmail.com; a=openpgp;
 fpr=CCEBEC056F25E1BC53FB4568590EF10E7C76BB99

When hardware design introduces significant sensor data noise,
performance can be improved by adjusting register settings.

Signed-off-by: Yasin Lee <yasin.lee.x@gmail.com>
---
 .../devicetree/bindings/iio/proximity/tyhx,hx9023s.yaml    | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.yaml b/Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.yaml
index 64ce8bc8bd36..417fbc0bb205 100644
--- a/Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.yaml
+++ b/Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.yaml
@@ -28,6 +28,13 @@ properties:
 
   vdd-supply: true
 
+  tyhx,performance-tuning:
+    description:
+      Optional, When hardware design introduces significant sensor data noise,
+      performance can be improved by adjusting register settings, including
+      but not limited to sample integration time and average sample count.
+    $ref: /schemas/types.yaml#/definitions/uint8-array
+
   "#address-cells":
     const: 1
 
@@ -65,6 +72,13 @@ examples:
         interrupt-parent = <&pio>;
         interrupts = <16 IRQ_TYPE_EDGE_FALLING>;
         vdd-supply = <&pp1800_prox>;
+        tyhx,performance-tuning = [00 00
+        02 17
+        0D 44
+        0E 44
+        0F 04
+        1F 65
+        21 65];
 
         #address-cells = <1>;
         #size-cells = <0>;

-- 
2.43.0


