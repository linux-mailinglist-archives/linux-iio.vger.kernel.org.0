Return-Path: <linux-iio+bounces-5917-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 160F88FF19E
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 18:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B790D1F25114
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 16:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA0919883C;
	Thu,  6 Jun 2024 16:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p1KBwhLI"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18701197A90;
	Thu,  6 Jun 2024 16:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717690062; cv=none; b=XAlWDNHyZCu9gB7MH6hqwTrNlG6jFnApi2++e2d27vg8QaHuXNmfICqqd2ziWAnAycffPTPPBabHG/LjGkFfg7M7deSopL+VoWxOCgM8iykoGhx8Bd1KWHIkStP+h1Y5vyHxIa5xuR+iogWr9X8KaEkSmTk8sqI3dzNv5UaC6/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717690062; c=relaxed/simple;
	bh=6kCCkX7oEiTVbrjZ0mC374x6Q9o8/coYWFgv4Qj3ums=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R9fnkyaAVlJ9arU0RLrU5RYSQRpLjGpnBmZQXr/6M7zn2Vijd8BCc3WWjzD2oUdLrUlkzrrH6KafOuRgrmpklfmtfbMHRwxhslCB1GUY8EHlgKqrcSRiIFaKIAMtfzkZb9nSojDrbEYO4j+5z39kIq3DNj6P7VVqgxcaBieLeYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p1KBwhLI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A3816C4AF08;
	Thu,  6 Jun 2024 16:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717690061;
	bh=6kCCkX7oEiTVbrjZ0mC374x6Q9o8/coYWFgv4Qj3ums=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=p1KBwhLIWHJbXHGifR5r6w7StwOOh2zXIXG32cqZJPBQ0f7oYj83x93R5Bt/pZaSB
	 heCLMz4XE4wh9MR1os9Ccw91r1ihCPO2U1EqhEAQUQTFg6h2e/0ptc5NfdGwx4AMjm
	 ukuwWdRpbRjtsKIPydgtRbv2DZKdsX+4sT/NuN2RRIOF3/PLI2z3raPLjP2O8T5MVW
	 F6zOWBdmyX+xX0LwZmWWPI5B4wdfP7VIMYKJXfnlKy3gF4ITosLLR/L3kzkMieEc5o
	 vRKyPghEkiz3gjVlUjZFRP/45ivVdiz5H01HDXR7NVlfeO58iR8iNNqrTbce908E3s
	 ZBT0fA5TyULcA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FE12C27C55;
	Thu,  6 Jun 2024 16:07:41 +0000 (UTC)
From: Dumitru Ceclan via B4 Relay <devnull+dumitru.ceclan.analog.com@kernel.org>
Date: Thu, 06 Jun 2024 19:07:40 +0300
Subject: [PATCH v6 1/9] dt-bindings: iio: adc: Add common-mode-channel
 property
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240606-ad4111-v6-1-573981fb3e2e@analog.com>
References: <20240606-ad4111-v6-0-573981fb3e2e@analog.com>
In-Reply-To: <20240606-ad4111-v6-0-573981fb3e2e@analog.com>
To: Ceclan Dumitru <dumitru.ceclan@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dumitru Ceclan <mitrutzceclan@gmail.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717690059; l=1665;
 i=dumitru.ceclan@analog.com; s=20240313; h=from:subject:message-id;
 bh=7+gdjeLzhs0nsD3z5zCT8lTNIXL7WwI7n9Ywy4A7eJY=;
 b=oZyApd6X1HRxsMW2ljvKhFCgcD7m1xakV5QkuOdiYuZYfC09kzX47w5iLBItPUFBMYChHkRox
 DbE8aTtYIuVAfAA+YtcLuQcJ0RTBZqyFpfdZESWZ1cyAHLTB26Ar9yK
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

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
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



