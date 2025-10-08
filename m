Return-Path: <linux-iio+bounces-24841-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CC702BC3340
	for <lists+linux-iio@lfdr.de>; Wed, 08 Oct 2025 05:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8E4F74EA5E6
	for <lists+linux-iio@lfdr.de>; Wed,  8 Oct 2025 03:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F44129E114;
	Wed,  8 Oct 2025 03:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M1WIwCnp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CA629DB6C
	for <linux-iio@vger.kernel.org>; Wed,  8 Oct 2025 03:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759893500; cv=none; b=mDLANWE7oMiDVd6/Ht7KowVool8f79FCwSqquT6YTSB5Y3kOOrHLbeU/4e5rfZlUSBa/JFgI1hhLgBLzC7tmc8WMpoM4JxzZu/tf2EnuMGHXa/6ay5SXSSBUXPVuQm6IthjSySCDxawW6TLudzY2fas0EtcLUZZFoJnidFVYTKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759893500; c=relaxed/simple;
	bh=w88O91l141EF9mRTJr5gYUX1SUVp35Zw9XxJTz5LQBg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SlnToFvimq4qC04Kf+IH73WGkIymurPtnwF+/f105tdQqVX33/4/OItf1r3mpD6s2agWPoDdOD9in02bF2iNAWXoMnX/l2xtTyEeLGp8LtgTEukei8qNZiNfP4O5EOF/0DmHu4ueh38Udhxjt/YMmloBDGDkMSMpF3/5PzJMqXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M1WIwCnp; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-781997d195aso4574126b3a.3
        for <linux-iio@vger.kernel.org>; Tue, 07 Oct 2025 20:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759893497; x=1760498297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BlQFQcawRFMEewIt0bOgUlauxcu0MJP5hQDoYscvOlw=;
        b=M1WIwCnpEDzXEfOawWMTjwqmrgQJKk4/+Gosj0RlYSOe4ynNOy15RyErknQiYiS7be
         Wa6MO96L31WX3vNoC2viiiA0hnrnWZgJzcB1NlA2xq2eEu01XsV+UYjbcBfIbaZ9z0QA
         3xvhvPYfDqmlWIFyaKqmO5VIr+oXckVj4uuPRfAI3DU2gRaL1F6XVmqjyEMqXkpoRSBD
         0R7hLfEKUH+VirBEFDFBd+KIHT9ZBuINuyyTpY/g9nO3uWauw9L7RvQfXWrhqPPQnQkW
         5Q82/DZ32jeuUqSR486wLyHjSMNvS7a8OwOfJ4a0zEM0zzr3RBHTlhoJYZC0JP4K52ch
         J9MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759893497; x=1760498297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BlQFQcawRFMEewIt0bOgUlauxcu0MJP5hQDoYscvOlw=;
        b=DnRPkPqSiEeJdIG8CzUh/WD8XY0tpSM3SU+s5Wr7NeJIcX76nlJTXBir3ku3gq+m0t
         uGUv6gF1rok/+ATicjP4sbP4SI3GAYXEMdEn2OXlhg4MSeQX5W1nrvyDToLdX6+9mN4D
         7xJxe5uJ1l+aIQi06JnA3xnbV1pBwNlpEzkEJTZGSB4V3GPOMcPtU2dnepxeKfUtz509
         DH97rDzeW4NJ8C4kTy0vOadTReHUwYQ/pHLjAphYGszOIvo8sP2eBf2OtwvDiOBo+eQB
         2ABwpkQIqOVTgRU7uDOAzo+0OzH+8XVysJdpCETTXDPQDaLdcNOMR8blOGbhue66kh4D
         ptrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXiUppCrcMhmR/cwJMfe1374OOMH6xigH5kHLWzptDBxUkf5/WBwWgau+2boOAU4cMCeisDspNqB3A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8rO312uLZ6nhVAiSFVyfAoEtaPP7rG+PGL/NvC/tJcqV89QTP
	N2G8WYOLwkIDKLG63kPXhFzX0ZD2DX2eT5yrwjQm2ZcMc00hSTSZViv1
X-Gm-Gg: ASbGncuZnKcWJ/fLTufiaR+7rFPDQUa1c13I3J1kC4YiPTq1tH1QanWKo0KwicY0T2f
	806SOn4VAOuBfN0BpjMCl8uf/MJQ5SisZ91JXOrR7zpfAEi6jU/fZm17GHg5uHPWUSUw5HsMJ6R
	QwmLLOFAmRVL5CIV8551JVsCerWkfuT97FjWJ+HSNL5IlYxvdEfrcud5QAQ8NqT2kgUDL8HvQ00
	bzSN1aBO/WPYQ6fDKV1m6aO3evv/IEcVDCE/v/Xr2Y/oTdNEfkY+8dQmkk3MMeVGCYx+zFMYQGL
	a5dSuhHVLRQDJJM9N6lwJVh+F19G6C7p5LitjqzFhl1bXNcchRX0q2h3gD6jkos01wJG9ZpbyJT
	rfAQHt3Gfd+xj3aWK+w1mblLm6lVB1o6aeTpXMlzyCHv/TVybGA==
X-Google-Smtp-Source: AGHT+IEeKJ+xs0GcbSYEkaMOoq4ZNzOHvQx0Xbcrl6XMXjx/qanyX4b6zdbK6WVXlHpUCKR6ek6s0w==
X-Received: by 2002:a05:6a20:a103:b0:2e3:dd60:913d with SMTP id adf61e73a8af0-32da8163cc9mr2183530637.21.1759893496900;
        Tue, 07 Oct 2025 20:18:16 -0700 (PDT)
Received: from Ubuntu24.. ([103.187.64.31])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6099f5990csm16527746a12.38.2025.10.07.20.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 20:18:16 -0700 (PDT)
From: Shrikant Raskar <raskar.shree97@gmail.com>
To: jic23@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	matt@ranostay.sg,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	Shrikant Raskar <raskar.shree97@gmail.com>
Subject: [PATCH v2 1/2] dt-bindings: iio: max30100: Add pulse-width property
Date: Wed,  8 Oct 2025 08:47:36 +0530
Message-ID: <20251008031737.7321-2-raskar.shree97@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251008031737.7321-1-raskar.shree97@gmail.com>
References: <20251008031737.7321-1-raskar.shree97@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The appropriate LED pulse width for the MAX30100 depends on
board-specific optical and mechanical design (lens, enclosure,
LED-to-sensor distance) and the trade-off between measurement
resolution and power consumption. Encoding it in Device Tree
documents these platform choices and ensures consistent behavior.

Tested on: Raspberry Pi 3B + MAX30100 breakout board.

Signed-off-by: Shrikant Raskar <raskar.shree97@gmail.com>

Changes since v1:
Add unit suffix.
Drop redundant description.

Link to v1:
https://lore.kernel.org/all/20251004015623.7019-2-raskar.shree97@gmail.com/
---
 .../devicetree/bindings/iio/health/maxim,max30100.yaml      | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/health/maxim,max30100.yaml b/Documentation/devicetree/bindings/iio/health/maxim,max30100.yaml
index 967778fb0ce8..5c651a0151cc 100644
--- a/Documentation/devicetree/bindings/iio/health/maxim,max30100.yaml
+++ b/Documentation/devicetree/bindings/iio/health/maxim,max30100.yaml
@@ -27,6 +27,11 @@ properties:
       LED current whilst the engine is running. First indexed value is
       the configuration for the RED LED, and second value is for the IR LED.
 
+  maxim,pulse-width-us:
+    maxItems: 1
+    description: Pulse width in microseconds
+    enum: [200, 400, 800, 1600]
+
 additionalProperties: false
 
 required:
@@ -44,6 +49,7 @@ examples:
             compatible = "maxim,max30100";
             reg = <0x57>;
             maxim,led-current-microamp = <24000 50000>;
+            maxim,pulse-width-us = <1600>;
             interrupt-parent = <&gpio1>;
             interrupts = <16 2>;
         };
-- 
2.43.0


