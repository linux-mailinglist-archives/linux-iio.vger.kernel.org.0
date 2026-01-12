Return-Path: <linux-iio+bounces-27648-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C69D14788
	for <lists+linux-iio@lfdr.de>; Mon, 12 Jan 2026 18:46:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 28108300ACBC
	for <lists+linux-iio@lfdr.de>; Mon, 12 Jan 2026 17:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FCA737F0EE;
	Mon, 12 Jan 2026 17:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="1tQdmPu5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62BC3612F8
	for <linux-iio@vger.kernel.org>; Mon, 12 Jan 2026 17:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768240000; cv=none; b=pRlj5uxPApLhE0oPfUnpGAZrwPRy7a10TR1lPc6UOL5FBP80YHT7mgQo573JB2YGwfb+w7q8GRIAik7tsBLIuxG9BmiphGV01exWkBG51bqbJHMfc6h5pr9r7sK5ehSvZTwyvQ2zK3f4Db0o4yasvP6BWoRf1sQCRx0H86jxkeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768240000; c=relaxed/simple;
	bh=tZ1gVB3H8yXnnq8oO3CvMZarToXPlUChHiU/VJKv9/w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=puLxdWO+gVUNB6R3DJwGiw9XpRDECZjesXYSNue4bBxeMlCUMDGjACRyFi9C8Pk5YzSz1YfiSFRWS4/76jY6DphmpZZV0h5INGaeGCSrCbxIDQGj794JyOwVDSzqqxV9eU42bbGrq7ZVrHq1GRVjR+VXJ2p/VDETgg/Wx96QZk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=1tQdmPu5; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-3ffbfebae12so2099018fac.2
        for <linux-iio@vger.kernel.org>; Mon, 12 Jan 2026 09:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1768239991; x=1768844791; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sqlipSAYiQrFu95dtCHHFkG0TmH5NP5KRF7vhyQD8q0=;
        b=1tQdmPu5BY0fWMSjInfF38Z7jMy4Hf4qqlT3VFbhhGyXcjZPW5s61+YS2eqTAq/Myw
         5ATfAk/RcEye+MVkfbjqFAse/DvaJbmMc6YLc40CRejbWgHd+gsHYU6c/YB1HJBeJ/ez
         dlvYoa3YMXxgwjEA3fDgFHVHuljTHsaztTSuq72aO1bl450/h/LaJQrWV4iJns4mURfX
         8j57KLtTVwprQNFJrSNKaJURam3ou1kSdCtkfRGzLnOvmBm45mJEGg8rHr2zrCgsFo5K
         oqUp6GDkluVfq4VGCf/LYaQ9f/NNOV0mSlSKvYhowTcVZ1zOfWswv5tXC8FW8c9KtK7v
         S/6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768239991; x=1768844791;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sqlipSAYiQrFu95dtCHHFkG0TmH5NP5KRF7vhyQD8q0=;
        b=hy10zZ4trY1tFO663bO5o3a7LljQ/FeQsckJgJwb+arBLAIs1xTvOcCzOH2vEKK3rJ
         b/5DLmd4L7aLY3gD+54jJ1td1AlfrSSJvuWTaQWINdaov8UKGsG95vRC8Nx/1qb6/T6d
         j5J72EhqCPyGmFh65moXhGtjlNcFj17FoguueMqHotm3p9RH3ddBCDXLJIsZ4KZaOd61
         OJaWDH7/5NyVpIAleI6hTHNXvODdI+qhm6ENJ2qK27bA7frY/PDLU2u7bkaKZXkqp0ok
         E+5dcUgDzcTO2EUQOvCOReGzL1pis0uPMUgEvuzv1WoMP9TRxiTCjiSMWAILmgb8Wn/y
         1S0w==
X-Forwarded-Encrypted: i=1; AJvYcCVVhEj6I/xBLYQdGQBcPiPbbZPUja/VprXZftrruljioM7D5FpuitXr5f0PL0bVnBSpXEuoVzPuRYs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpBlOqQXZAKttjJophCgY2lwxKHi2O51xqDdVoRYdbCgA6+gvc
	RZ+KHaMGHD4W1dQscEQGeT+mltTzNZpzecc+/zRZe/2gUggadtpyq5wEveuxNtEmunY=
X-Gm-Gg: AY/fxX4XsEoHYRxiY5K8G3D6alD1qcDHTTqDgw6AOMsFmhrvfH7oFzlyi4piGXjqLZB
	yS+Zpk94Gp9AnYdUBiy/oXQ7Q+r0o0KCuDeFEOye8iCKat4oHB5DN7pPJH2syG+HbSH21wqq/wH
	Dm4xVl07ZnLih/PoFbjwHi4atEjpkrBT5bcu+n0Jkqgh9Jk7ZRw2loXTios1+93D+Kpi6DA86Z6
	EOpPLTHz0PWXRu1KYGN3ZsFFcu1JdUc74LPxgqArcQxJ0pbZFDrCo9If4Qm1kaLqeU5dkNAtyXi
	riD2yZ4N5cTYg8+4FkTSifym0zbseKnUEgiMNxkvlDe5wgn1/CkXlUIy2oIaKyzTXTXpoeZYWsn
	68Beq6yvZKAGlOz++Vb5q8ELr/Wy1IRGnqLkFtcQ0b3XTxwj12n3sXtyOQa6h3hEt6hL78eQFRh
	9TZ0QM05iS2QlFKL8=
X-Google-Smtp-Source: AGHT+IFBdEdVyipvpJKVouqlkR/vSnnrwI8wG4Tu4qRwUv58Q4gW/GedXwjx1n4TT49Du6joX748WQ==
X-Received: by 2002:a05:6870:d14b:b0:3c9:895a:d9ec with SMTP id 586e51a60fabf-3ffc09e1502mr10193116fac.17.1768239990568;
        Mon, 12 Jan 2026 09:46:30 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:6b4b:49b3:cce5:b58f])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3ffa4de40bfsm12126941fac.5.2026.01.12.09.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 09:46:30 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 12 Jan 2026 11:45:20 -0600
Subject: [PATCH v5 2/9] spi: dt-bindings: add spi-{tx,rx}-lane-map
 properties
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260112-spi-add-multi-bus-support-v5-2-295f4f09f6ba@baylibre.com>
References: <20260112-spi-add-multi-bus-support-v5-0-295f4f09f6ba@baylibre.com>
In-Reply-To: <20260112-spi-add-multi-bus-support-v5-0-295f4f09f6ba@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2408; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=tZ1gVB3H8yXnnq8oO3CvMZarToXPlUChHiU/VJKv9/w=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBpZTM+DIYL1xcg6jfE74/jpkdtlp+q7+GbQ9JbK
 h/EWhyK2BGJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaWUzPgAKCRDCzCAB/wGP
 wPlECACIbVDWCUcNaRQdTeo2VIG+zSuMX2p5ZPUyVmKqKtRzNyrrmuFHmX55JxoHewW1I9Hp4tm
 dPHi8bsFSkSE2SZ8JV/iVdMFvaJOzUH6rF4I17lF2OP++VTwQsb79zfu5jDyZaeZWPHpAxioHeY
 aLb9sOlHnqZc5pPjp6wbFAXHkeea4dHAaaPCI1+8yXi6XSxfKnL+DC5TQAPM20BzleTz/39t4+r
 lp0jBXCBdXBGmNPNowvuiJPo//BGMPGTQvvPRIzkbkdoQlbWKHAfc+io2BOFg5QH8cGZA1ECK50
 emKQp7nga6j1SJYRlLuwnylqXhnG4srXdf/ctV9glydZf9KX
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add spi-tx-lane-map and spi-rx-lane-map properties to the SPI peripheral
device tree binding. These properties allow specifying the mapping of
peripheral data lanes to controller data lanes. This is needed e.g. when
some lanes are skipped on the controller side so that the controller
can correctly route data to/from the peripheral.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v5 changes:
- Use SDI/SDO terminology in descriptions. (Fixes incorrect use of TX/RX
  when describing the peripheral lanes.)

v4 changes:
- This replaces the data-lanes property from the previous revision. Now
  there are separate properties for tx and rx lane maps. And instead of
  being the primary property for determining the number of lanes, this
  is only needed in special cases where the mapping is non-trivial.
---
 .../devicetree/bindings/spi/spi-peripheral-props.yaml      | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
index 59ddead7da14..880a9f624566 100644
--- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
@@ -75,6 +75,13 @@ properties:
       enum: [0, 1, 2, 4, 8]
     default: [1]
 
+  spi-rx-lane-map:
+    description: Mapping of peripheral SDO lanes to controller SDI lanes.
+      Each index in the array represents a peripheral SDO lane, and the value
+      at that index represents the corresponding controller SDI lane.
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
+    description: Mapping of peripheral SDI lanes to controller SDO lanes.
+      Each index in the array represents a peripheral SDI lane, and the value
+      at that index represents the corresponding controller SDO lane.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    default: [0, 1, 2, 3, 4, 5, 6, 7]
+
   spi-tx-delay-us:
     description:
       Delay, in microseconds, after a write transfer.

-- 
2.43.0


