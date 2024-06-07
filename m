Return-Path: <linux-iio+bounces-6009-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0DF39007CE
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2024 16:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59DE2B24494
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2024 14:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93E919FA81;
	Fri,  7 Jun 2024 14:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZdfKIWSc"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFE419AD4B;
	Fri,  7 Jun 2024 14:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717771989; cv=none; b=n8/Yt3Cv95SEVoEkHPEbgmXceo8KlwOJiGX+yyxCLs+qxkL8LrxFReuOlqRYs9qW54tnXmA+4ptRC+VNrJlOPqrqgbPVuXoXi+UCSqUYm6ppk2AwFEV3rI0EiP1XX3c5rl4VfEw00HgHpKLDhMNFxEd6yhcD0OIiPkA8hReVcqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717771989; c=relaxed/simple;
	bh=6kCCkX7oEiTVbrjZ0mC374x6Q9o8/coYWFgv4Qj3ums=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sPJk0uAt/0qePY5pO0ENWJi+Ne5fnQ5h+CFsuvDKIFZD2YGbXC6OTzjSVJ61jYD7E4N6u4aziehJKOF0lhbPn7k1c0zwXr8p0yRKevUKphjpgz4usq+PVXdkBmyCzhthNXXu5Qy2vZKk/9oZPqacP2SCpfs3MV7XN8fuG9DMI2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZdfKIWSc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 19350C32786;
	Fri,  7 Jun 2024 14:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717771989;
	bh=6kCCkX7oEiTVbrjZ0mC374x6Q9o8/coYWFgv4Qj3ums=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ZdfKIWScN6EdP6GLiks4/zTf7A/PSp4izvDITUCP1UTQ4JM+nrp1vNujxKQdTS6eY
	 e835xGdDnuDPBXWph3E2HmACrEl87VzDVXewL2f6Fbof0E/FRsR7XCGTeqeNWhQNAa
	 vGtYEATdjAtBPWVhOgrn/ztJm9MWxTOv+2UT49yrxqAcgOgGCjYpkE7wrtFoi6Eyc3
	 AUguSYd0p61558ivuBmaFv3M3sH+BWE+CWuLU+1QtZb0GGSy62pgQsVJkYn9EiPzih
	 klI33GyiZ2mjqMouOv9Hyt34expk7xUEIYt3Qr7KJPXyjH5WriUOCHRV33mWO/BDmb
	 nAmQJwt33uclA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C4BC27C6E;
	Fri,  7 Jun 2024 14:53:09 +0000 (UTC)
From: Dumitru Ceclan via B4 Relay <devnull+dumitru.ceclan.analog.com@kernel.org>
Date: Fri, 07 Jun 2024 17:53:07 +0300
Subject: [PATCH v7 1/9] dt-bindings: iio: adc: Add common-mode-channel
 property
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240607-ad4111-v7-1-97e3855900a0@analog.com>
References: <20240607-ad4111-v7-0-97e3855900a0@analog.com>
In-Reply-To: <20240607-ad4111-v7-0-97e3855900a0@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717771987; l=1665;
 i=dumitru.ceclan@analog.com; s=20240313; h=from:subject:message-id;
 bh=7+gdjeLzhs0nsD3z5zCT8lTNIXL7WwI7n9Ywy4A7eJY=;
 b=jzqeOuqC5FOT7DWFbPvNyAz0YOCO86yLAdDJzo5WDcgWNJVfcilm0iCrVq+zmPGq4+XP0siyi
 Tytzh9MbUIpDJZDB95ur5mwwPUgMx2tBtHWdrXuz5JPu1Z0gVYk8gBh
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



