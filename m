Return-Path: <linux-iio+bounces-27235-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E38CD1FA3
	for <lists+linux-iio@lfdr.de>; Fri, 19 Dec 2025 22:33:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B1EAB304A7F7
	for <lists+linux-iio@lfdr.de>; Fri, 19 Dec 2025 21:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3706434404D;
	Fri, 19 Dec 2025 21:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="eiKenuxs"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3537633C193
	for <linux-iio@vger.kernel.org>; Fri, 19 Dec 2025 21:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766180013; cv=none; b=NwHNMHUTuNQ66sUeojdZYQaaxUm+Bacp5JUqsWSIPHx3I+Y+PEncHz/8EYq5kMNLRUBVaMwF7zqJu4JEk5csZ5kTzPLe/rtC6pYLtPj5IztnC/7kxs8WfFemeRgw74mm8wxPhjiHS3H9D2+Vj5OXj342u+U7IgfBbhuXajX608U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766180013; c=relaxed/simple;
	bh=TqPWfvOKcEsi12rSA+ulOC61NeC7/72fTMR7lVl6WbU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JZkGjk3ll7W2TRC0OJdD7MWmyFEHK7k18UZxsHY81VsKt6OPja1NUfeSv8UK8N6I1/3niIuBaT7axpvUhXFbwg6vt/Q7ReQ8FKyx7yC56mMKZMqxji3+Wj/KTGVMzt6UyNM08asM3Nm3dXDQtya6RggBmTlPNM3VWESpMcbMHAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=eiKenuxs; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7c75fc222c3so880465a34.0
        for <linux-iio@vger.kernel.org>; Fri, 19 Dec 2025 13:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1766180010; x=1766784810; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iqTEzojZ7TZAx7J/CtrZy1pdl4/BgUd5w2Zhg+1M8js=;
        b=eiKenuxsWbO2Wf3tFNv7lnyWkvmxYDK4pfGNzZBEKiqBlDcuFpNabK8taP/NfBHune
         TEV62AXnAICztvGJ9dEI7LwEVVk544gMSnSY9FXX8V0SgFKfFYp370iYHz3yvlS/P5tJ
         HVLdnmTTuTKntb/qjYqP6AFJvF/lu1Qda+Vss+8nET2AOQEcF/Sw5dlWRoC4qdzy7DS7
         /3SXlgiz8V30ihw+MWcl0Kp6VIruBCWCVkpcyhdoaCDiSPKbCshK1rBTF/Ii0ZLvWNpy
         Uy6UTijR725FqE4y9PBctdudCI+beUnrt279FGmqnq29PiPsg1UnSsDyr7sHZRXeTZ7C
         UR3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766180010; x=1766784810;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iqTEzojZ7TZAx7J/CtrZy1pdl4/BgUd5w2Zhg+1M8js=;
        b=cnTK5YRNtnzJfcNfWw5JrGFCDkvewaRIGd+rUYZRkaTcIYcDUNE8rj9WF8M0cKEKBX
         yEBJ+YK08OcrPOhpZ0CasoomLCZDtyl8WAAMaaE5h/RMc23TwULc51eDxk5/chmwu/bX
         RyUdYM6s4E0qglxIyimgb3zKnQpLfVTTBvAgLMK+3/xH8xgu5DmwGLF+QadwmFSA33oX
         bMIvKl6iZHVDJQ9U10W7Rb5Lx73VI6Rm0/lts4BmfupCgZPuvFp7Nsv9nVA8StcTB7sH
         +9sP1tIrhlV5JV/iWZxSRyw5dDPxN9ARhFrmTQY98YGkQxeEzYApkvhQRpEF2g/5+5Ds
         vkLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzCG0NviXHV/mFZ8TTImutzCwsoOJPGi/ZFa+Lb8RIuxiA7LoZUUyTTqI5eu76CHw9ZWPHJuprDt8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3WdC76VwO79oPlMMLuQ2uIvLqWoGUcuxvfphceAD6/WHeIt6Q
	AoTP/FfoG6NdgRRS2yGKpqX3VFnSx/+5ZobSWThwxRVYxd0p1v9i5f6RvGVpMv6Ctaw=
X-Gm-Gg: AY/fxX5k3i7f4NLrbrSviHDHbAFEWHsazy8lP7TuxydZbq/ODI6NB5CldJtiG57jzdE
	MjXflQAwgJoQs+rWP2HL2U6u/igGNuTaWhrQUrng3xdKZ7pammJNbhMUr4XGl/YEl1ZwzcrDGgg
	l60cg5tipCpq9VY6n3N+AdsY4sIxbMi63+3xpdeiGfCEPoTtFblqtSR1pPB4khNt7DaLqzVexd3
	PazhcxxVTTg5TurO0pdAReC5eCj7IQAizbWijz9MlW8VlszX4Q7nLAXUHLiVqNk2B+q2ABzO3KF
	aPlHK19Sp2EBX0jwBtQoULuL6nWINrihei8a8saYl+jWlGl9O3h2vAdbfpqcj2r91rhTFog0Cyp
	oG3AdkOphOKnhm8bnIlgCkeBwnxoMRT2YF+auzDqacNJzoJ0y2kx3XRIyJkmLIxPDcS4jh0W9wI
	1bb+6gjnGTTgvHiL/qV+SzcjRQ
X-Google-Smtp-Source: AGHT+IHyP6fh0H8vwvnVPTmgakBhXpLLWUkiet6oHZRcT83wBBX+S6YNzLE4KzjmaR9ePZdUYAayXg==
X-Received: by 2002:a05:6830:44a4:b0:78e:a394:ca24 with SMTP id 46e09a7af769-7cc668d0fb4mr2768916a34.8.1766180009947;
        Fri, 19 Dec 2025 13:33:29 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:9b20:bac4:9680:435])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cc667563ffsm2485045a34.13.2025.12.19.13.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 13:33:29 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 19 Dec 2025 15:32:10 -0600
Subject: [PATCH v4 2/9] spi: dt-bindings: add spi-{tx,rx}-lane-map
 properties
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251219-spi-add-multi-bus-support-v4-2-145dc5204cd8@baylibre.com>
References: <20251219-spi-add-multi-bus-support-v4-0-145dc5204cd8@baylibre.com>
In-Reply-To: <20251219-spi-add-multi-bus-support-v4-0-145dc5204cd8@baylibre.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Marcelo Schmitt <marcelo.schmitt@analog.com>, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>
Cc: Sean Anderson <sean.anderson@linux.dev>, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2219; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=TqPWfvOKcEsi12rSA+ulOC61NeC7/72fTMR7lVl6WbU=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBpRcRxkkWWmrsQKWOdOOI4zUmj8yp+SSBCoYPla
 Ijt1bECtPOJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaUXEcQAKCRDCzCAB/wGP
 wOS5B/95gImmMOy/n5PIPOKuqGZKZlN6KkZHhVvrFPsEYpOxGhMAm2wfTl/Hi6Ro1jAT1xSOPGF
 e9a7iLotreIH1SHeMvvvzUyZM8OSPL1PYw72p+OXRAnXJLkAFv1SH1irWKZ4klHAkfkpQPs/Z/D
 bmsFLhKMWtTS8Cjh9MCflaYH6uETdgh7NwIyECT/z2BqK/RQWjJ0PkBijrJfbryfoQiPbJIQgkJ
 XGHzpjN2RaX9Q/XhkJxq8z7yyeWEbS3Am7uW54r13ra/K7v/G+AupfGhqZU7T4paWW8fR6/WUGQ
 RozmMQzn7BtuCXf8H1q8+SGyD7Om84FmAVZYKv91k6mn3/BY
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add spi-tx-lane-map and spi-rx-lane-map properties to the SPI peripheral
device tree binding. These properties allow specifying the mapping of
peripheral data lanes to controller data lanes. This is needed e.g. when
some lanes are skipped on the controller side so that the controller
can correctly route data to/from the peripheral.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v4 changes:
- This replaces the data-lanes property from the previous revision. Now
  there are separate properties for tx and rx lane maps. And instead of
  being the primary property for determining the number of lanes, this
  is only needed in special cases where the mapping is non-trivial.
---
 .../devicetree/bindings/spi/spi-peripheral-props.yaml      | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
index 59ddead7da14..2f278f145f78 100644
--- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
@@ -75,6 +75,13 @@ properties:
       enum: [0, 1, 2, 4, 8]
     default: [1]
 
+  spi-rx-lane-map:
+    description: Mapping of peripheral RX lanes to controller RX lanes.
+      Each index in the array represents a peripheral RX lane, and the value
+      at that index represents the corresponding controller RX lane.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    default: [0, 1, 2, 3, 4, 5, 6, 7]
+
   spi-rx-delay-us:
     description:
       Delay, in microseconds, after a read transfer.
@@ -99,6 +106,13 @@ properties:
       enum: [0, 1, 2, 4, 8]
     default: [1]
 
+  spi-tx-lane-map:
+    description: Mapping of peripheral TX lanes to controller TX lanes.
+      Each index in the array represents a peripheral TX lane, and the value
+      at that index represents the corresponding controller TX lane.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    default: [0, 1, 2, 3, 4, 5, 6, 7]
+
   spi-tx-delay-us:
     description:
       Delay, in microseconds, after a write transfer.

-- 
2.43.0


