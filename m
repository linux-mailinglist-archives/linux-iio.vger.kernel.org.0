Return-Path: <linux-iio+bounces-8523-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89635955730
	for <lists+linux-iio@lfdr.de>; Sat, 17 Aug 2024 12:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3BF828298B
	for <lists+linux-iio@lfdr.de>; Sat, 17 Aug 2024 10:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F14149E0E;
	Sat, 17 Aug 2024 10:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aHkreDwD"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9508B657;
	Sat, 17 Aug 2024 10:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723890391; cv=none; b=sU8Mp8uLMm1/LxWl6SR56uiA4Ct2UliD2PMgF7JH9VCB70kvCio8TlKkmw82WTlSFHCi5HxXdxB1k1kqK0M25i1L/tyXqS4Ctkt9eg2EnWane36P88ynknLRiYeBn0MoJq+QYW7nE0XEfP9FK+RscymzqfaPFaBvejNFAiUvwsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723890391; c=relaxed/simple;
	bh=lYozc8NLhmIarc2gIP+HKCa+ZUpVEC20QXMZ0Sil0iI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cs3hZb6rGD3wmigBS6CgRu8f05X1AWP3FvsWoE/OUAz9ye6oWJW68LXaeaoGQAsyqST+EltQAnXmwyz8S/M2+sE2xZY8uAwxPZX2e4mQX93SMmHAUAuZLs26z2qR1jle6AhhyJy+SU6i+5HxkDxpsmS3JvqTLfq/YUikHQ+PiHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aHkreDwD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06AC5C116B1;
	Sat, 17 Aug 2024 10:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723890390;
	bh=lYozc8NLhmIarc2gIP+HKCa+ZUpVEC20QXMZ0Sil0iI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aHkreDwDLaPg85rFzSMSqtXaBDxDTp9jtqcVckctr5O2pXHqUgFxNjoE2fdwVjVrj
	 PEB4eVq/gWZTbGRMTL578+vZhPh7PZR/FmJfNmiPAzUACsS/iVU0wnKXL7+COqcER2
	 Ld7U6JMUBs67D/gunVpLOG1ZwHoZvNSdz5KlgyrlZ6W/+IvpsxnmlrEfUsqDm7IfkK
	 O0suIbKzmRRvEq4AOVDbYGx9ckYvsSUcKKziQCyEYE5ukvJqgfEkApGNs2fgpc4mOS
	 4o2IedALrLl38yexuta6k8dUz/QZ55zwZ039VgskwRaszsQ2xBFkbeWaaZE7AYlesx
	 Ei4yMxXb/uJiQ==
Date: Sat, 17 Aug 2024 11:26:20 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: wangshuaijie@awinic.com
Cc: lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, kees@kernel.org, gustavoars@kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 liweilei@awinic.com, kangjiajun@awinic.com, Krzysztof Kozlowski
 <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH V6 1/2] dt-bindings: iio: aw96103: Add bindings for
 aw96103/aw96105 sensor
Message-ID: <20240817112620.4426a10b@jic23-huawei>
In-Reply-To: <20240808102851.4024025-2-wangshuaijie@awinic.com>
References: <20240808102851.4024025-1-wangshuaijie@awinic.com>
	<20240808102851.4024025-2-wangshuaijie@awinic.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  8 Aug 2024 10:28:50 +0000
wangshuaijie@awinic.com wrote:

> From: shuaijie wang <wangshuaijie@awinic.com>
> 
> Add device tree bindings for aw96103/aw96105 proximity sensor.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: shuaijie wang <wangshuaijie@awinic.com>
> ---
>  .../iio/proximity/awinic,aw96103.yaml         | 63 +++++++++++++++++++
>  1 file changed, 63 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/proximity/awinic,aw96103.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/proximity/awinic,aw96103.yaml b/Documentation/devicetree/bindings/iio/proximity/awinic,aw96103.yaml
> new file mode 100644
> index 000000000000..54b5bc176d5c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/proximity/awinic,aw96103.yaml
> @@ -0,0 +1,63 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/proximity/awinic,aw96103.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Awinic's AW96103 capacitive proximity sensor and similar
> +
> +maintainers:
> +  - Wang Shuaijie <wangshuaijie@awinic.com>
> +
> +description: |
> +  Awinic's AW96103/AW96105 proximity sensor.
> +  The specific absorption rate (SAR) is a metric that measures
> +  the degree of absorption of electromagnetic radiation emitted by
> +  wireless devices, such as mobile phones and tablets, by human tissue.
> +  In mobile phone applications, the proximity sensor is primarily
> +  used to detect the proximity of the human body to the phone. When the
> +  phone approaches the human body, it will actively reduce the transmit
> +  power of the antenna to keep the SAR within a safe range. Therefore,
> +  we also refer to the proximity sensor as a SAR sensor.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - awinic,aw96103
> +      - awinic,aw96105
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    description:
> +      Generated by the device to announce that a close/far
> +      proximity event has happened.
> +    maxItems: 1
> +
> +  vcc-supply:
> +    description:
> +      Optional regulator for chip, 1.7V-3.6V.

Not optional given it's in required (which is correct)

    vcc-supply: true

is enough for this as the voltage is probably only relevant for the person
designing the board, not the dts author.

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - vcc-supply
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        proximity@12 {
> +            compatible = "awinic,aw96103";
> +            reg = <0x12>;
> +            interrupt-parent = <&gpio>;
> +            interrupts = <23 IRQ_TYPE_EDGE_FALLING>;
> +            vcc-supply = <&pp1800_prox>;
> +        };
> +    };


