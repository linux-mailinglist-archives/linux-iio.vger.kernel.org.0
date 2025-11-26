Return-Path: <linux-iio+bounces-26480-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D99C89217
	for <lists+linux-iio@lfdr.de>; Wed, 26 Nov 2025 10:54:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 37AEE4E935E
	for <lists+linux-iio@lfdr.de>; Wed, 26 Nov 2025 09:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22DB62FD7D5;
	Wed, 26 Nov 2025 09:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rHj+qhT5"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC412FD1D3;
	Wed, 26 Nov 2025 09:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764150806; cv=none; b=LwfGn1AtNnVDBinz6aAvvMi5PNAbJa3B60L1t2h4v87RT7tJtVBt/8wpY1yS88/h0A3t/ZGgGz2MmAOsqszoQoX35imHjvavPxD0vox8ZqZbdU5h+OV2cm41yoZliJmesoxSAykOxAX3NuneqOUftQAEtocB/y7bKZ2sxVHoDVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764150806; c=relaxed/simple;
	bh=VlaG7D/FlaLiJ9zapfWyZLwnWYoNbnCpKlAXt2tJUSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uxZY1RIW4CSH2J/bpHKbH0M0Z8REjSeNrwSr8xNXXBLoWueEyo3Ug+vtcXkvw7IhsfheUjx7lcON1fNvAacCeTk1DJccIm6Hq/TtxlZSellj/uvv9gWnHsd5jkDtRHTs90/1t6r675KRFWwBgAP9WyPzXrUxJlhlPA4tHGgnQGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rHj+qhT5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C84DFC113D0;
	Wed, 26 Nov 2025 09:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764150806;
	bh=VlaG7D/FlaLiJ9zapfWyZLwnWYoNbnCpKlAXt2tJUSY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rHj+qhT5ACF0ysunZQQF1Cn1JMMzXvg2wsZk8qxG0DvFFax3lusyEfGT7lNYZcGD0
	 IpJth5vgUCVj0fOKMaco96wC/+X7HJyXBfjBZmz4JYVGDX2BxzeagLTWqOuzvg2cyQ
	 mJdEWL8wN8U0WscuCUMNCG0oQ90LinaplhH0mKrUtSk78e8+tj0ui26UfdoJCmgoQA
	 7fuiV4VGIqHEOdlSrEDDXdF6fBJnvF7gVg5T3im0ILjgWinNREydHFO7+m13Q3vS61
	 YCwITHCDMD1dVBxryHF94dBb0UDJ8VpP9HAsHTYX3zMpCm1ssSnIo/3TC90WllkvA3
	 F7IEIF/oexU6w==
Date: Wed, 26 Nov 2025 10:53:23 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Shrikant Raskar <raskar.shree97@gmail.com>
Cc: jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	heiko@sntech.de, neil.armstrong@linaro.org, skhan@linuxfoundation.org, 
	david.hunter.linux@gmail.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: iio: proximity: Add YAML binding for
 RFD77402 ToF sensor
Message-ID: <20251126-cautious-eagle-from-sirius-83fe52@kuoka>
References: <20251126031440.30065-1-raskar.shree97@gmail.com>
 <20251126031440.30065-2-raskar.shree97@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251126031440.30065-2-raskar.shree97@gmail.com>

On Wed, Nov 26, 2025 at 08:44:38AM +0530, Shrikant Raskar wrote:
> The RFD77402 driver has existed without a formal device tree binding
> description. With the recent addition of Device Tree support and
> interrupt handling in the driver, it is now necessary to document
> the DT properties used for configuring the device.

This is all irrelevant here. It does not matter for the bindings if the
driver existed or not.

Please rather document here the hardware.

A nit, subject: drop second/last, redundant "YAML binding for". The
"dt-bindings" prefix is already stating that these are bindings.
See also:
https://elixir.bootlin.com/linux/v6.17-rc3/source/Documentation/devicetree/bindings/submitting-patches.rst#L18
For sure don't use "YAML binding" - there is no such thing.

> 
> Since the binding introduces the compatible string "rfdigital,rfd77402",
> the "rfdigital" vendor prefix is also added to vendor-prefixes.yaml.

Also redundant, we can see the diff.

> 
> Signed-off-by: Shrikant Raskar <raskar.shree97@gmail.com>
> ---
>  .../iio/proximity/rfdigital,rfd77402.yaml     | 55 +++++++++++++++++++
>  .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
>  2 files changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/proximity/rfdigital,rfd77402.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/proximity/rfdigital,rfd77402.yaml b/Documentation/devicetree/bindings/iio/proximity/rfdigital,rfd77402.yaml
> new file mode 100644
> index 000000000000..93deaa4e8b7a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/proximity/rfdigital,rfd77402.yaml
> @@ -0,0 +1,55 @@
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
> +description: |

Do not need '|' unless you need to preserve formatting.

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
> +    description: |

Same, also a bit odd wrapping of the text below

> +      Generated by the device to announce that a new
> +      measurement data is ready in result register.
> +
> +  vdd-supply:
> +    description: Regulator that provides power to the sensor
> +
> +  vddio-supply:
> +    description: Regulator providing I/O interface voltage
> +
> +required:
> +  - compatible
> +  - reg

supplies should be required, devices rarely work without power. If you
think hardware works without power, this is something unusual thus you
should explain it in the commit msg.

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
> +            interrupt-parent = <&gpio>;
> +            interrupts = <4 IRQ_TYPE_EDGE_FALLING>;

Supplies

Best regards,
Krzysztof


