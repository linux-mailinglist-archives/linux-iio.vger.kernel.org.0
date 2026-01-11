Return-Path: <linux-iio+bounces-27603-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9D0DD0EE22
	for <lists+linux-iio@lfdr.de>; Sun, 11 Jan 2026 13:39:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5824F3007CAC
	for <lists+linux-iio@lfdr.de>; Sun, 11 Jan 2026 12:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ADF33382C8;
	Sun, 11 Jan 2026 12:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OkMgY8zI"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDD11F5821;
	Sun, 11 Jan 2026 12:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768135183; cv=none; b=Wk52lFpoPtBtygBUXxy1fg+cVWKWHBbyykGO3b9NgBDTuDVcUgQh+6tNjE4fof1+5ClJHoqnx3lpz5O3KztJHn9V+PoZ3rl6riTvYOrlVfRf8aLwolrCT5QBlkKjzYavZ4qhXfzoYAZv7KdQ6cKsCLjqbFXyoKrMhDtPl0ZaACM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768135183; c=relaxed/simple;
	bh=4SE1jQ5xu1ASw5YTeuCdatgEIqgoScZizHJqoURat9c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PyVIUWEYn1to0fWMfde5iSCxcTL+wfkKqZpNEerP2AOm8oQ+cz6rXgvyt8/eYHcJl3CUH21eu4+ntLgOzHVuPjDChGSORRc1qRJGCjxnsBIzA383kGOwiYlJxXq+ViF8kfTH1GQxhwPNi1VU6p8i1lhUvkVwbqU2P8XxLsQmav0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OkMgY8zI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B445C4CEF7;
	Sun, 11 Jan 2026 12:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768135182;
	bh=4SE1jQ5xu1ASw5YTeuCdatgEIqgoScZizHJqoURat9c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OkMgY8zIQn4y+XU1u1G/4dc+GzZdPJ50+TC4kXXhNQ06XpLixecL5hX8pqBwligS0
	 cgqH8sU4lvV2yt78F4G5g459M+qifJz87oNiG5AKO1cd4V7IZJzayK8tApNnFgJnYn
	 rRM0SGpXcV2+HaU0YXpoTn5Rp81AhIdJRNMmFTSE8QW+1n23jlNlyEzg3trnnQtiM1
	 KXXgdCTPKsEgwd7BxgNG/F47/RCue7n7SfXjIXEtu9914v7ELsY0JbFoUmSEehQjcB
	 1wPpDakbmlajDwLBmd65zxGw6N9LinL+ikPXiTcswmkJDdlWgRQaGA4PJukRxyg2gy
	 h984aiOtKPiYw==
Date: Sun, 11 Jan 2026 12:39:32 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Shrikant Raskar via B4 Relay
 <devnull+raskar.shree97.gmail.com@kernel.org>
Cc: raskar.shree97@gmail.com, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, skhan@linuxfoundation.org,
 david.hunter.linux@gmail.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Krzysztof
 Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v4 1/4] dt-bindings: iio: proximity: Add RF Digital
 RFD77402 ToF sensor
Message-ID: <20260111123932.6bf63cdb@jic23-huawei>
In-Reply-To: <20260101-b4-rfd77402_irq-v4-1-42cd54359e9f@gmail.com>
References: <20260101-b4-rfd77402_irq-v4-0-42cd54359e9f@gmail.com>
	<20260101-b4-rfd77402_irq-v4-1-42cd54359e9f@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 01 Jan 2026 21:47:38 +0530
Shrikant Raskar via B4 Relay <devnull+raskar.shree97.gmail.com@kernel.org> wrote:

> From: Shrikant Raskar <raskar.shree97@gmail.com>
> 
> The RF Digital RFD77402 is a Time-of-Flight (ToF) proximity and distance
> sensor that provides absolute and highly accurate distance measurements
> from 100 mm up to 2000 mm over an I2C interface. It includes an optional
> interrupt pin that signals when new measurement data is ready.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Shrikant Raskar <raskar.shree97@gmail.com>
Given the first two patches of this series are ready to go and
independent of the last one I'll apply them now.

Applied patches 1 and 2 to the togreg branch of iio.git and pushed out as testing.
Just send the last two in v5.


Thanks,

Jonathan

> ---
>  .../bindings/iio/proximity/rfdigital,rfd77402.yaml | 53 ++++++++++++++++++++++
>  .../devicetree/bindings/vendor-prefixes.yaml       |  2 +
>  2 files changed, 55 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/proximity/rfdigital,rfd77402.yaml b/Documentation/devicetree/bindings/iio/proximity/rfdigital,rfd77402.yaml
> new file mode 100644
> index 000000000000..1ef6326b209e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/proximity/rfdigital,rfd77402.yaml
> @@ -0,0 +1,53 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/proximity/rfdigital,rfd77402.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: RF Digital RFD77402 ToF sensor
> +
> +maintainers:
> +  - Shrikant Raskar <raskar.shree97@gmail.com>
> +
> +description:
> +  The RF Digital RFD77402 is a Time-of-Flight (ToF) proximity and distance
> +  sensor providing up to 200 mm range measurement over an I2C interface.
> +
> +properties:
> +  compatible:
> +    const: rfdigital,rfd77402
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +    description:
> +      Interrupt asserted when a new distance measurement is available.
> +
> +  vdd-supply:
> +    description: Regulator that provides power to the sensor.
> +
> +required:
> +  - compatible
> +  - reg
> +  - vdd-supply
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        proximity@4c {
> +            compatible = "rfdigital,rfd77402";
> +            reg = <0x4c>;
> +            vdd-supply = <&vdd_3v3>;
> +            interrupt-parent = <&gpio>;
> +            interrupts = <4 IRQ_TYPE_EDGE_FALLING>;
> +        };
> +    };
> +...
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> index c7591b2aec2a..59ac4f0756d9 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -1361,6 +1361,8 @@ patternProperties:
>      description: Revolution Robotics, Inc. (Revotics)
>    "^rex,.*":
>      description: iMX6 Rex Project
> +  "^rfdigital,.*":
> +    description: RF Digital Corporation
>    "^richtek,.*":
>      description: Richtek Technology Corporation
>    "^ricoh,.*":
> 


