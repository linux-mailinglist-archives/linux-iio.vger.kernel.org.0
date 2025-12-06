Return-Path: <linux-iio+bounces-26849-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7558BCAAC80
	for <lists+linux-iio@lfdr.de>; Sat, 06 Dec 2025 19:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E9BC63079291
	for <lists+linux-iio@lfdr.de>; Sat,  6 Dec 2025 18:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8A52EBB8C;
	Sat,  6 Dec 2025 18:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JOyNJgZ+"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FCF27FB32;
	Sat,  6 Dec 2025 18:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765047033; cv=none; b=K1qxsHwO3RBpZaRMiRTcpVPr7unPUCAc5YCzS38rh2JaZLYOD/ER/SICdPewNjJYo6GDNkN6VJ2P64p/O/7e/xBpE35yLL8rvCD1arDAiGSL3GfKz9+QNPAej6jDdf81TCTy2I5k8tFQZBYXP/wvdqzsp1QxC02S/7XWjdl5JgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765047033; c=relaxed/simple;
	bh=OLL02dPgI+XbGqEfj119H7zgdt4K7NCHKLZBLLGTA9M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uKA3hiLJfNZIrDZyabraoISTNgzEUCyZg7b1UoFiPhXAB9GmXx/+Y/5PozPg7/Nx7QZD0NSFBU0e+67qiQg1bwT1E0CkXKGJO6loFNmO+KcuIIOmRd799MgMyeM1jcZ5be7EnS9BYfUoYk7dre2L1F6OR28SljvLdy55YGRKR6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JOyNJgZ+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05E18C4CEF5;
	Sat,  6 Dec 2025 18:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765047033;
	bh=OLL02dPgI+XbGqEfj119H7zgdt4K7NCHKLZBLLGTA9M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JOyNJgZ+ysBLeO++6KZIiuoOsYq+6haUP+ULcyWfTB8NV9xYfEmsNQgdlr10Bu6In
	 2ry4vk9ERG6N1b9h8EhOVX+tf+KdUMT9PVkB50IzfEclVysxLK7PoJPN4h3cTIzpKj
	 ZWguhHAe9dbXK/gbPQSpHdF/f7CcZ7bi/hF+jkUvD/gQimxxdJ78CBBzl+PM3FiEoR
	 7Ci9F4pmho5rabWCgUZ37CnP2xG9JU9IwGj4JgoCPZ5M2o+K/8h0UDymKZtDTqqVCn
	 DaGlKOl4ivUx1xnw2w75Yl8pnai8+Fy1X1ivlmnvfa+o1qgwBvxynULgl2VOF/LxoO
	 ntpzk23riU1ag==
Date: Sat, 6 Dec 2025 18:50:23 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, "David Lechner" <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 1/2] dt-bindings: iio: amplifiers: add adl8113
Message-ID: <20251206185023.78d1d378@jic23-huawei>
In-Reply-To: <20251205144058.1918-2-antoniu.miclaus@analog.com>
References: <20251205144058.1918-1-antoniu.miclaus@analog.com>
	<20251205144058.1918-2-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 5 Dec 2025 16:40:40 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add devicetree bindings for adl8113.

If you roll a v7 I'd add some description of the 'interesting'
bit in here - which is the gains for the two external bypass paths.
I like the solution but i would like more eyes to focus on that!

Other than that this looks good to me. Maybe I'll add something
to this description if I apply this version.

Jonathan


> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> changes in v6:
>  - Use items list for ctrl-gpios instead of minItems/maxItems
>  - Simplify ctrl-gpios item descriptions (remove GPIO_ACTIVE_HIGH mentions)
>  - Remove maxItems (implied by items list)
> 
>  .../bindings/iio/amplifiers/adi,adl8113.yaml  | 87 +++++++++++++++++++
>  1 file changed, 87 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/amplifiers/adi,adl8113.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/amplifiers/adi,adl8113.yaml b/Documentation/devicetree/bindings/iio/amplifiers/adi,adl8113.yaml
> new file mode 100644
> index 000000000000..28b3738cb675
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/amplifiers/adi,adl8113.yaml
> @@ -0,0 +1,87 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/amplifiers/adi,adl8113.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices ADL8113 Low Noise Amplifier with integrated bypass switches
> +
> +maintainers:
> +  - Antoniu Miclaus <antoniu.miclaus@analog.com>
> +
> +description: |
> +  The ADL8113 is a 10MHz to 12GHz Low Noise Amplifier with integrated bypass
> +  switches controlled by two GPIO pins (VA and VB). The device supports four
> +  operation modes:
> +    - Internal Amplifier: VA=0, VB=0 - Signal passes through the internal LNA
> +    - Internal Bypass: VA=1, VB=1 - Signal bypasses through internal path
> +    - External Bypass A: VA=0, VB=1 - Signal routes from RFIN to OUT_A and from IN_A to RFOUT
> +    - External Bypass B: VA=1, VB=0 - Signal routes from RFIN to OUT_B and from IN_B to RFOUT
> +
> +    https://www.analog.com/en/products/adl8113.html
> +
> +properties:
> +  compatible:
> +    const: adi,adl8113
> +
> +  vdd1-supply: true
> +
> +  vdd2-supply: true
> +
> +  vss2-supply: true
> +
> +  ctrl-gpios:
> +    items:
> +      - description: VA control pin
> +      - description: VB control pin
> +
> +  adi,external-bypass-a-gain-db:
> +    description:
> +      Gain in dB of external amplifier connected to bypass path A (OUT_A/IN_A).
> +      When specified, this gain value becomes selectable via the hardwaregain
> +      attribute and automatically routes through the external A path.
> +
> +  adi,external-bypass-b-gain-db:
> +    description:
> +      Gain in dB of external amplifier connected to bypass path B (OUT_B/IN_B).
> +      When specified, this gain value becomes selectable via the hardwaregain
> +      attribute and automatically routes through the external B path.
> +
> +required:
> +  - compatible
> +  - ctrl-gpios
> +  - vdd1-supply
> +  - vdd2-supply
> +  - vss2-supply
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    /* Basic configuration with only internal paths */
> +    amplifier {
> +        compatible = "adi,adl8113";
> +        ctrl-gpios = <&gpio 22 GPIO_ACTIVE_HIGH>,
> +                     <&gpio 23 GPIO_ACTIVE_HIGH>;
> +        vdd1-supply = <&vdd1_5v>;
> +        vdd2-supply = <&vdd2_3v3>;
> +        vss2-supply = <&vss2_neg>;
> +    };
> +
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    /* Configuration with external bypass amplifiers */
> +    amplifier {
> +        compatible = "adi,adl8113";
> +        ctrl-gpios = <&gpio 24 GPIO_ACTIVE_HIGH>,
> +                     <&gpio 25 GPIO_ACTIVE_HIGH>;
> +        vdd1-supply = <&vdd1_5v>;
> +        vdd2-supply = <&vdd2_3v3>;
> +        vss2-supply = <&vss2_neg>;
> +        adi,external-bypass-a-gain-db = <20>;  /* 20dB external amp on path A */
> +        adi,external-bypass-b-gain-db = <6>;   /* 6dB external amp on path B */
> +    };
> +...


