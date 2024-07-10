Return-Path: <linux-iio+bounces-7488-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 088AF92D2B0
	for <lists+linux-iio@lfdr.de>; Wed, 10 Jul 2024 15:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8735281027
	for <lists+linux-iio@lfdr.de>; Wed, 10 Jul 2024 13:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE67192B9D;
	Wed, 10 Jul 2024 13:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b="0NPsXERq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FBD19246F
	for <linux-iio@vger.kernel.org>; Wed, 10 Jul 2024 13:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720617851; cv=none; b=gxbBtaWf1LAfqsHii/FAY9pHKrnsPPdCokySKPtCK3Pbjrr+6zJ13K8Yycyu2fEk13s1eqcm7tMR7vSDMNW46kWl1brvS+a8u+ZSoNTXljdrAQU6qGGsWFFVEou496c0pYdzyKQ7GzfBA1Y0qeTcCX7gcG8/AjCSlCYWEWmdiro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720617851; c=relaxed/simple;
	bh=bQWObWUYccgqENm86cI3IhwEbp7t7q5L6ZiYgQNRUT0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N4M0gBuc6Kbkdt2IVy4xKaXPGnbbcKMFBzm4DjMWN7jCktdGZMndnicJAD9ftEzEA8oBXMOgtokxdDrZhDli7/j7RBhJ/OCKVtk5vfSBPVhFAdDtXHHtHvXlT+eia75odAqakIt8W5QHhg5rCpPvLLxSfJcuFySImvdr/TFRQQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20230601.gappssmtp.com header.i=@thegoodpenguin-co-uk.20230601.gappssmtp.com header.b=0NPsXERq; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4266eda81c5so20688815e9.0
        for <linux-iio@vger.kernel.org>; Wed, 10 Jul 2024 06:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20230601.gappssmtp.com; s=20230601; t=1720617848; x=1721222648; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DGRawoEvSd2Mwh/WhQpx7oR5a9rOc0Q5DzdCc44ChGI=;
        b=0NPsXERqtmmUa/8s2X1SLP5S0EhZTiA2gXcC21R51R/zPG0fmP2j3NQ/ApR1hGjPN+
         mTsE0KlM/bXFaAmeTuIyG0DicuhuSORpCx4Fu0SZnX/B08gFCeIwvS5qO5Dcm4BVlICy
         ENFT7CSnbHzpiXTT46urD3JbUIabuoQjEjAWYClEWxrwJoqzSrnxkB2/TlO1CbFuwtz1
         DXaKxjAJSooUI+0XQ25N3h/rWCIyfI5artQhA7ymZj4rsaycvR6CR9bq0qfXICC2JTTU
         fAAEn3j3cm6yjUfaqvd/TjoiYO12skn5vEIfv6qADgVKycso1hdYpKHH7CLcvY9aKqFg
         xXmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720617848; x=1721222648;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DGRawoEvSd2Mwh/WhQpx7oR5a9rOc0Q5DzdCc44ChGI=;
        b=PHK8q+e4/VTVLScURUScXMquMrIiQuibt/axmx3LLIaCPvykP1B7ccYRXc21O5AaHo
         k6RH/9pUqCoZf0UdmbGUQ5NNVHDOGbPQu/qxbOwBU1gZQ51Nm3ihGnD5tBRM5BGYHKOl
         Mz+vlixQBGRGOKdKAyUyqoc10KJ2i9Qc5zULFeFLMARev35DWTB1rxUGmKgVItmyuHpr
         2WiFLBQfDJJX0vYzMzkWO5Hbtc5AC5mcmNnHbJBIHbnHitFQBD5a2AEhK225ze5teRJh
         XJ6OGplq0XqfaUKFFjGD3NXb1HH8yU5NeObtzH+1u0NqXQ+NSeXoCmy2qkXGvL5I03rl
         4s6Q==
X-Gm-Message-State: AOJu0Yy0zb+Oc8Q42M2o+WRlUG5O1wuYaZZuhdP/UXD/G7ZsfQh7G2v4
	ejCbYumRFJiqv6AKYZaLXLB7BEKJaqhuf4sagyMkZVzl8Ixpk+J/VZwRuMPx6Kw=
X-Google-Smtp-Source: AGHT+IFpPwv5G3twTnV1ZrZTrpaDkQ+Zk27Ddk+qmWEN7BZ4n/Fhck+rqJGlA8dHoMDXUThHhaS2gQ==
X-Received: by 2002:a05:600c:4850:b0:426:62c5:4731 with SMTP id 5b1f17b1804b1-426707f8563mr46178855e9.29.1720617848414;
        Wed, 10 Jul 2024 06:24:08 -0700 (PDT)
Received: from carbon.local (aztw-29-b2-v4wan-166913-cust1764.vm26.cable.virginm.net. [82.37.38.229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4266d0185d9sm106441025e9.3.2024.07.10.06.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 06:24:08 -0700 (PDT)
From: Joshua Felmeden <jfelmeden@thegoodpenguin.co.uk>
Date: Wed, 10 Jul 2024 14:24:04 +0100
Subject: [PATCH v3 1/2] dt-bindings: iio: humidity: add ENS21x sensor
 family
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240710-ens21x-v3-1-4e3fbcf2a7fb@thegoodpenguin.co.uk>
References: <20240710-ens21x-v3-0-4e3fbcf2a7fb@thegoodpenguin.co.uk>
In-Reply-To: <20240710-ens21x-v3-0-4e3fbcf2a7fb@thegoodpenguin.co.uk>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Joshua Felmeden <jfelmeden@thegoodpenguin.co.uk>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720617846; l=1876;
 i=jfelmeden@thegoodpenguin.co.uk; s=20240709; h=from:subject:message-id;
 bh=bQWObWUYccgqENm86cI3IhwEbp7t7q5L6ZiYgQNRUT0=;
 b=5MHm+Vj83EAC1T74aljcT7fCJMlicOJ+rFoy3Gc73rIS/mmZnMrDA6Pgn0A0LHWLKVCiAR37j
 Twf6jW0XCO0B8RJ/tF9i9HxlnisJdS3e6XH5ksBr/lPIS+ckwsSBM1K
X-Developer-Key: i=jfelmeden@thegoodpenguin.co.uk; a=ed25519;
 pk=tePkZ5iJ3ejQ2O3vjhsj7GrLYcyJN1o1sMT3IEXvKo0=

Add device tree documentation for ENS21x family of temperature and
humidity sensors

Signed-off-by: Joshua Felmeden <jfelmeden@thegoodpenguin.co.uk>
---
 .../bindings/iio/humidity/sciosense,ens21x.yaml    | 55 ++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/humidity/sciosense,ens21x.yaml b/Documentation/devicetree/bindings/iio/humidity/sciosense,ens21x.yaml
new file mode 100644
index 000000000000..425d3b57f701
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/humidity/sciosense,ens21x.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/humidity/sciosense,ens21x.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ScioSense ENS21x temperature and humidity sensor
+
+maintainers:
+  - Joshua Felmeden <jfelmeden@thegoodpenguin.co.uk>
+
+description: |
+  Temperature and Humidity sensor.
+
+  Datasheet:
+    https://www.sciosense.com/wp-content/uploads/2024/04/ENS21x-Datasheet.pdf
+    https://www.sciosense.com/wp-content/uploads/2023/12/ENS210-Datasheet.pdf
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - sciosense,ens210a
+              - sciosense,ens211
+              - sciosense,ens212
+              - sciosense,ens213a
+              - sciosense,ens215
+          - const: sciosense,ens210
+      - const: sciosense,ens210
+
+  reg:
+    maxItems: 1
+
+  vdd-supply: true
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+       #address-cells = <1>;
+       #size-cells = <0>;
+
+       temperature-sensor@43 {
+           compatible = "sciosense,ens210";
+           reg = <0x43>;
+       };
+    };
+...
+

-- 
2.39.2


