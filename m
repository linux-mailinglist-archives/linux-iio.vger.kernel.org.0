Return-Path: <linux-iio+bounces-27021-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 837BDCB6290
	for <lists+linux-iio@lfdr.de>; Thu, 11 Dec 2025 15:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 86225306502D
	for <lists+linux-iio@lfdr.de>; Thu, 11 Dec 2025 14:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 108F72D24AC;
	Thu, 11 Dec 2025 14:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F4nRF+jI"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C29A2D1932;
	Thu, 11 Dec 2025 14:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765462068; cv=none; b=lg/xrlU8HawVWsarZItkOxzgv0Rw4CVV778th24E5KuVIxt7d2SIWe9bQPSKrmrnc4clt0wqjyhf7rbTbeFh6VNfMKA3bIH5+SfyuZ5lVud0pQxbJ47EGH3H7RUN0e693VkJzMHklNZJJjVX42VEYfVGkNnOu6MfPmD6nvQh23Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765462068; c=relaxed/simple;
	bh=hx7b5hrK/t1h1EGBuhSZdXxMqefCkNpMbXzh1Pxl/GQ=;
	h=From:Date:Content-Type:MIME-Version:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=pBW092m8Hgc0bvEob76sg54fdwNwrTWTyAUwpLh13w2cN8oMUJPBbcTpPF2r/GzcWipM3HDnBWjYrCHFAxa9i2S+xZsleRXqMxI/GakXcPni/tuZZ1d15XkqdbLdBk9XzO8CU/2Ra3Y0g79Tmk6bD3KpIP/kXxvMpjTCIo/6qtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F4nRF+jI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0558FC113D0;
	Thu, 11 Dec 2025 14:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765462068;
	bh=hx7b5hrK/t1h1EGBuhSZdXxMqefCkNpMbXzh1Pxl/GQ=;
	h=From:Date:Cc:To:In-Reply-To:References:Subject:From;
	b=F4nRF+jILoOBJXDsreY4/ec1oenpKVgurmtPrhus5kXNUIYF/WfF+26aLVpRCEnQk
	 J4bn4I+pf4emRNZ0naH44bYtNweuoB/BPCoO29fYQZW4zgjopbjuhSfMPxX8r5C9Sd
	 HwiRVfqG44YlO4jVout14vF5bi56Uq4IBV1g4d1e8jNEULYuOm9QaZbHrg4GJYPUpk
	 Ce+TKRcAdNShbHb98RYKQRWl5VNC4J8FTWcRlsMdsY0irxv1iN+gSAv0F5xjGF1tDo
	 8pyIosatEszKp+OVkMh46qLMQx878RXXrVhSFpV2S8RGMxXc1tSS1ag6GbVr2JfXPM
	 l7Gbv0noZ03iA==
From: Rob Herring <robh@kernel.org>
Date: Thu, 11 Dec 2025 08:07:47 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-crypto@vger.kernel.org, 
 linux-iio@vger.kernel.org, linux-aspeed@lists.ozlabs.org, 
 linux-hwmon@vger.kernel.org, linux-gpio@vger.kernel.org, 
 Joel Stanley <joel@jms.id.au>, Linus Walleij <linusw@kernel.org>, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mmc@vger.kernel.org, openbmc@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>
To: Andrew Jeffery <andrew@codeconstruct.com.au>
In-Reply-To: <20251211-dev-dt-warnings-all-v1-0-21b18b9ada77@codeconstruct.com.au>
References: <20251211-dev-dt-warnings-all-v1-0-21b18b9ada77@codeconstruct.com.au>
Message-Id: <176546188070.971010.10583431722134708925.robh@kernel.org>
Subject: Re: [PATCH RFC 00/16] Eliminate warnings for AST2500 and AST2600
 EVB devicetrees


On Thu, 11 Dec 2025 17:45:42 +0900, Andrew Jeffery wrote:
> Hi all,
> 
> This series removes the remaining warnings produced by `make
> CHECK_DTBS=y ...` for the AST2500 and AST2600 EVBs and their related
> DTSIs. The tidy-up has the usual benefit of making it clear to
> contributors that any warnings are likely their own to fix before their
> patches will be considered for merging.
> 
> I've framed it as an RFC with all patches contained in the one series
> so the goal is clear, we can see what's needed to reach it, and we can
> decide whether and how it should be split or merged going forward.
> 
> As it stands there's little in the way of code change, except to
> pinctrl (though also not much there). As such I've included the
> binding maintainers and subsystem lists as recipients but not yet Cc'ed
> subsystem maintainers directly because there are quite a few and I hope
> to avoid mostly uninteresting patches being a source of irritation.
> 
> The patches fall into several groups:
> 
> Patch 1:
>   Rob's conversion of the PWM/tach binding to DT schema with fixes
>   applied for the license and typos identified by Krzysztof.
> 
> Patches 2-5:
>   Fixes for the warnings related to the LPC and pinctrl nodes, touching
>   relevant drivers and the devicetrees.
> 
>   I expect that if this approach is acceptable that we'll need to split
>   application of the patches across successive release cycles, with the
>   driver changes going in first.
> 
> Patches 6-8:
>   Fix MMC/SDHCI warnings, touching the relevant binding and devicetrees
> 
> Patches 9-10:
>   Clarify the relationships between the ACRY and AHB controller
> 
> Patches 11-16:
>   The remaining pieces that eliminate the warnings
> 
> I'm at plumbers so don't have hardware on hand to test with, but some
> brief smoke tests under qemu look okay. Given that it's all RFC that
> should be enough for the moment. I'll do more testing after discussions
> and when I have boards at hand.
> 
> Please review!
> 
> Andrew
> 
> Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
> ---
> Andrew Jeffery (15):
>       pinctrl: aspeed: g5: Constrain LPC binding revision workaround to AST2500
>       pinctrl: aspeed: g5: Allow use of LPC node instead of LPC host controller
>       ARM: dts: aspeed: g5: Use LPC phandle for pinctrl aspeed,external-nodes
>       ARM: dts: aspeed: Remove unspecified LPC host controller node
>       dt-bindings: mmc: Switch ref to sdhci-common.yaml
>       ARM: dts: aspeed: Remove sdhci-drive-type property from AST2600 EVB
>       ARM: dts: aspeed: Use specified wp-inverted property for AST2600 EVB
>       dt-bindings: bus: aspeed: Require syscon for AST2600 AHB controller
>       dt-bindings: crypto: Document aspeed,ahbc property for Aspeed ACRY
>       ARM: dts: aspeed: Drop syscon compatible from EDAC in g6 dtsi
>       ARM: dts: aspeed: g6: Drop unspecified aspeed,ast2600-udma node
>       ARM: dts: aspeed: ast2600-evb: Tidy up A0 work-around for UART5
>       dt-bindings: iio: adc: Allow interrupts property for AST2600
>       ARM: dts: aspeed: g6: Drop clocks property from arm,armv7-timer
>       dt-bindings: mfd: Document smp-memram node for AST2600 SCU
> 
> Rob Herring (Arm) (1):
>       dt-bindings: hwmon: Convert aspeed,ast2400-pwm-tacho to DT schema
> 
>  .../bindings/bus/aspeed,ast2600-ahbc.yaml          |   8 +-
>  .../bindings/crypto/aspeed,ast2600-acry.yaml       |   7 ++
>  .../bindings/hwmon/aspeed,ast2400-pwm-tacho.yaml   | 106 +++++++++++++++++++++
>  .../devicetree/bindings/hwmon/aspeed-pwm-tacho.txt |  73 --------------
>  .../bindings/iio/adc/aspeed,ast2600-adc.yaml       |   3 +
>  .../bindings/mfd/aspeed,ast2x00-scu.yaml           |  18 ++++
>  .../devicetree/bindings/mmc/aspeed,sdhci.yaml      |   2 +-
>  arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dts    |   7 +-
>  .../dts/aspeed/aspeed-bmc-facebook-clemente.dts    |   4 -
>  arch/arm/boot/dts/aspeed/aspeed-g4.dtsi            |   5 -
>  arch/arm/boot/dts/aspeed/aspeed-g5.dtsi            |   8 +-
>  arch/arm/boot/dts/aspeed/aspeed-g6.dtsi            |  17 +---
>  drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c         |  32 ++++---
>  13 files changed, 165 insertions(+), 125 deletions(-)
> ---
> base-commit: 5ce74bc1b7cb2732b22f9c93082545bc655d6547
> change-id: 20251211-dev-dt-warnings-all-bd5854b04d60
> 
> Best regards,
> --
> Andrew Jeffery <andrew@codeconstruct.com.au>
> 
> 
> 


My bot found new DTB warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not. No need to reply
unless the platform maintainer has comments.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


This patch series was applied (using b4) to base:
 Base: 5ce74bc1b7cb2732b22f9c93082545bc655d6547 (use --merge-base to override)

If this is not the correct base, please add 'base-commit' tag
(or use b4 which does this automatically)

New warnings running 'make CHECK_DTBS=y for arch/arm/boot/dts/aspeed/' for 20251211-dev-dt-warnings-all-v1-0-21b18b9ada77@codeconstruct.com.au:

arch/arm/boot/dts/aspeed/aspeed-bmc-quanta-s6q.dtb: adc@1e6e9000 (aspeed,ast2600-adc0): 'vref' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/iio/adc/aspeed,ast2600-adc.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-quanta-s6q.dtb: adc@1e6e9100 (aspeed,ast2600-adc1): 'vref' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/iio/adc/aspeed,ast2600-adc.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-opp-mowgli.dtb: pwm-tacho-controller@1e786000 (aspeed,ast2500-pwm-tacho): 'fan@8', 'fan@9' do not match any of the regexes: '^fan@[0-7]$', '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/hwmon/aspeed,ast2400-pwm-tacho.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dtb: adc@1e6e9000 (aspeed,ast2600-adc0): 'vref' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/iio/adc/aspeed,ast2600-adc.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dtb: adc@1e6e9100 (aspeed,ast2600-adc1): 'vref' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/iio/adc/aspeed,ast2600-adc.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjade.dtb: pwm-tacho-controller@1e786000 (aspeed,ast2500-pwm-tacho): 'fan@10', 'fan@11', 'fan@8', 'fan@9' do not match any of the regexes: '^fan@[0-7]$', '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/hwmon/aspeed,ast2400-pwm-tacho.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-asus-x4tf.dtb: adc@1e6e9000 (aspeed,ast2600-adc0): 'vref' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/iio/adc/aspeed,ast2600-adc.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-asus-x4tf.dtb: adc@1e6e9100 (aspeed,ast2600-adc1): 'vref' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/iio/adc/aspeed,ast2600-adc.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-lenovo-hr855xg2.dtb: pwm-tacho-controller@1e786000 (aspeed,ast2500-pwm-tacho): 'fan@10', 'fan@11', 'fan@12', 'fan@13', 'fan@14', 'fan@15', 'fan@16', 'fan@8', 'fan@9' do not match any of the regexes: '^fan@[0-7]$', '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/hwmon/aspeed,ast2400-pwm-tacho.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-amd-daytonax.dtb: pwm-tacho-controller@1e786000 (aspeed,ast2500-pwm-tacho): 'fan@10', 'fan@11', 'fan@12', 'fan@13', 'fan@14', 'fan@15', 'fan@8', 'fan@9' do not match any of the regexes: '^fan@[0-7]$', '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/hwmon/aspeed,ast2400-pwm-tacho.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-lenovo-hr630.dtb: pwm-tacho-controller@1e786000 (aspeed,ast2500-pwm-tacho): 'fan@10', 'fan@11', 'fan@12', 'fan@13', 'fan@8', 'fan@9' do not match any of the regexes: '^fan@[0-7]$', '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/hwmon/aspeed,ast2400-pwm-tacho.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-ufispace-ncplite.dtb: adc@1e6e9000 (aspeed,ast2600-adc0): 'vref' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/iio/adc/aspeed,ast2600-adc.yaml
arch/arm/boot/dts/aspeed/aspeed-bmc-ufispace-ncplite.dtb: adc@1e6e9100 (aspeed,ast2600-adc1): 'vref' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/iio/adc/aspeed,ast2600-adc.yaml






