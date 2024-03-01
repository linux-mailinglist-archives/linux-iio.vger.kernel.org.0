Return-Path: <linux-iio+bounces-3257-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D0986E70E
	for <lists+linux-iio@lfdr.de>; Fri,  1 Mar 2024 18:22:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11D03B2C242
	for <lists+linux-iio@lfdr.de>; Fri,  1 Mar 2024 17:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D4810A26;
	Fri,  1 Mar 2024 17:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sNmNtrYv"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D6A747C;
	Fri,  1 Mar 2024 17:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709313294; cv=none; b=PmYS//U2PFli0EI5UCVuMZAW1Y0USnMGpYjo+kw/zkA2atK749IWPNMmyzeECULmAneP2Lxs3s9G1/cyT0D5fA1u3vdTIloIblhe2Ffde9tloIg5mT91eTnTrLkp2Y3P2qiPnNyZH9aQFa5KSO6ypdgbVRCndPSIyCuD9wkr/Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709313294; c=relaxed/simple;
	bh=5LwiEc0JQbTPQYke7alKRRRS8r0EUt+i17MxSjVlal0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KJz1/D4oT5+gOQmXOWEv7WYTLbVuQY3M3ZQY4i/PwAV3ftS5p/XOspIUiEATwTVNKx3zodi/Qv3bI2cjNTdEuilGFiZCMkWpMkCRXQhxZQFT9ILLozdJya8NFyuGGSAO5/rCoMUW2Zd8SMGYDzOsQRg1PaPz7bfSsB2n4RsGoxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sNmNtrYv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7F722C43390;
	Fri,  1 Mar 2024 17:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709313293;
	bh=5LwiEc0JQbTPQYke7alKRRRS8r0EUt+i17MxSjVlal0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=sNmNtrYvEtAdUUrXaojLixjv549ZNWH0mhVj0HpfYZ1TYfXuVkQhm/yS7xH6Ydi2K
	 6DcPH/DvJ7+1x0WmFEzlnVhy0FzBiZVgh2OSeVsw/sUNnpriDgd5m3Rn+rl4OGHRnr
	 TmwVnfQeGUb/ha4oOLbu/7KRTW/dZcztTc1BxXXKeQ3rB2hH1iOZPFkYq3WzFAzlE/
	 r1AfbMd0KEpXnjC8rJrsWlbN/APyUoA5VGDqu8odB4dE3ejwT6nCkj1QHnh7vlR7sL
	 wOZESBwXDgmwovpf5nAzwpi6OYRN6+nwCTgY/Qk9JKZxW+q3rHR0J62fuUpdEL5DZG
	 RiH36m+MyoBrQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 699A4C54E55;
	Fri,  1 Mar 2024 17:14:53 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Fri, 01 Mar 2024 18:14:51 +0100
Subject: [PATCH v3 2/3] dt-bindings: iio: temperature: ltc2983: document
 power supply
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240301-ltc2983-misc-improv-v3-2-c09516ac0efc@analog.com>
References: <20240301-ltc2983-misc-improv-v3-0-c09516ac0efc@analog.com>
In-Reply-To: <20240301-ltc2983-misc-improv-v3-0-c09516ac0efc@analog.com>
To: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709313291; l=1162;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=cQBR+Yq83wR9gQYjnaJnzjaD/C1UCI7IIsrATX4nTW8=;
 b=xGEJ10/wpnMNl/TXsFcMJ84nFiHRFXRPlzKnerymazyD+p0amBNLO1XJ3Syag/O/ZjZmoquGn
 +DxgDt9HiVzD8tTSNhX9OyfnScJkcQkf9Ulpy1hDJnv9QK5FbTJc/vP
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received:
 by B4 Relay for nuno.sa@analog.com/20231116 with auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: <nuno.sa@analog.com>

From: Nuno Sa <nuno.sa@analog.com>

Add a property for the VDD power supply regulator.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
index dbb85135fd668..312febeeb3bba 100644
--- a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
+++ b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
@@ -57,6 +57,8 @@ properties:
   interrupts:
     maxItems: 1
 
+  vdd-supply: true
+
   adi,mux-delay-config-us:
     description: |
       Extra delay prior to each conversion, in addition to the internal 1ms
@@ -460,6 +462,7 @@ required:
   - compatible
   - reg
   - interrupts
+  - vdd-supply
 
 additionalProperties: false
 
@@ -489,6 +492,7 @@ examples:
             #address-cells = <1>;
             #size-cells = <0>;
 
+            vdd-supply = <&supply>;
             interrupts = <20 IRQ_TYPE_EDGE_RISING>;
             interrupt-parent = <&gpio>;
 

-- 
2.43.2


