Return-Path: <linux-iio+bounces-5691-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F918D8725
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jun 2024 18:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 162891C220E4
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jun 2024 16:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC451369B1;
	Mon,  3 Jun 2024 16:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UACeeEkz"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC97134409;
	Mon,  3 Jun 2024 16:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717431794; cv=none; b=TrI8Rh+s9kAZDFsI2FuQQnYS8LDLsdYu/xzmwJd5TFBxKurMgPJ5y73CUtC+6XxPU9aMnF9I6ypPD1FWrgkMOQXbUcgUUdegZpPKTTBfiFXiurqt/qlSRqZVLd8e3bAuMhmbkxx5N7MBQ6hgSlUnYOBP5jiTs9/t5FN6ZTOAG7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717431794; c=relaxed/simple;
	bh=HfO/yuYx9sp/Ilgrbzk8A2s9uHxyK412PuzRVCvRPTI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T8YchUTBKR2ENocgTfqiPQpk2tBg9UBXyiug62lSgfh6QWbvNoEnQFC7MbE9H4tPZDvUYSuNG8C+hN2q5Kcg/9Y9V6rG0NFe5cY6ihzIaAItMEbaq4zPKEXPyanfdoXnHD4mWn34QMParRGf3ThjfFqOiohuUIteEP1zgfLz7PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UACeeEkz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DF0B4C4AF0A;
	Mon,  3 Jun 2024 16:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717431793;
	bh=HfO/yuYx9sp/Ilgrbzk8A2s9uHxyK412PuzRVCvRPTI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=UACeeEkzYa50AY9lqhgIgAUcc+WWdaRaqM3//bEKhI08zDrhIyGca4go9QBVzWXoY
	 N/HhNemrYbBFVKTI3j9SV6sbY7oXkLiDSS10DCx/oKPyadgeHTV3W4l1WAgOqLr2/2
	 qs8LBzJGW1ZUogfXoFpT3NB+N0KUV9Ov+gqjLsWMaaPEQVL4+fDzs6LWCuJ3b1A0Jp
	 PGImNAYiqKNQbo2t2ZioWYx2p5qakOdgmGiOTrcE53eiKtoReeKkOIHwlI6AgO+a/S
	 7GpjOW67SJHW+iQMr3LRgVSF//4YaE7ek0qHooWZ/C7gJ73ymNu8S2Eiuvj0NCzV0L
	 c+oomU+EBhesw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB2B3C27C50;
	Mon,  3 Jun 2024 16:23:13 +0000 (UTC)
From: Dumitru Ceclan via B4 Relay <devnull+dumitru.ceclan.analog.com@kernel.org>
Date: Mon, 03 Jun 2024 19:22:59 +0300
Subject: [PATCH v5 1/9] dt-bindings: iio: adc: Add common-mode-channel
 property
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240603-ad4111-v5-1-9a9c54d9ac78@analog.com>
References: <20240603-ad4111-v5-0-9a9c54d9ac78@analog.com>
In-Reply-To: <20240603-ad4111-v5-0-9a9c54d9ac78@analog.com>
To: Ceclan Dumitru <dumitru.ceclan@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dumitru Ceclan <mitrutzceclan@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717431792; l=1609;
 i=dumitru.ceclan@analog.com; s=20240313; h=from:subject:message-id;
 bh=yba6tP7JS+6mHrdlyW824eKSL9BwktJrw/w3K4BKVMQ=;
 b=UMNtbTu2auA50gLwkPnJfIR725zXZRSZvm72Yngt4yYk58WXq+zrgy+iiwOmaQet+V06k34p7
 X5iBXxgrvDrAPcAy+sPjeqDQwHT4CqvEZH+jhRhai4D0/Rk0pYTV4iH
X-Developer-Key: i=dumitru.ceclan@analog.com; a=ed25519;
 pk=HdqMlVyrcazwoiai7oN6ghU+Bj1pusGUFRl30jhS7Bo=
X-Endpoint-Received: by B4 Relay for dumitru.ceclan@analog.com/20240313
 with auth_id=140
X-Original-From: Dumitru Ceclan <dumitru.ceclan@analog.com>
Reply-To: dumitru.ceclan@analog.com

From: Dumitru Ceclan <dumitru.ceclan@analog.com>

There are ADCs that are differential but support to measure single-ended
signals on the same channels by connecting a constant voltage to the
negative input pin.

This property allows to properly define a single-ended channel that
requires two inputs to be specified. Software can use the presence of
this property to mark the channel as not differential.

Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
---
 Documentation/devicetree/bindings/iio/adc/adc.yaml | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adc.yaml b/Documentation/devicetree/bindings/iio/adc/adc.yaml
index 0a77592f7388..8e7835cf36fd 100644
--- a/Documentation/devicetree/bindings/iio/adc/adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adc.yaml
@@ -46,6 +46,17 @@ properties:
       differential channels). If this and diff-channels are not present reg
       shall be used instead.
 
+  common-mode-channel:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Some ADCs have differential input pins that can be used to measure
+      single-ended or pseudo-differential inputs. This property can be used
+      in addition to single-channel to signal software that this channel is
+      not differential but still specify two inputs.
+
+      The input pair is specified by setting single-channel to the positive
+      input pin and common-mode-channel to the negative pin.
+
   settling-time-us:
     description:
       Time between enabling the channel and first stable readings.

-- 
2.43.0



