Return-Path: <linux-iio+bounces-16543-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77619A57A66
	for <lists+linux-iio@lfdr.de>; Sat,  8 Mar 2025 14:17:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A482C16CDDD
	for <lists+linux-iio@lfdr.de>; Sat,  8 Mar 2025 13:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 515FC1C07E6;
	Sat,  8 Mar 2025 13:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G7SrkmgU"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E9A189F36;
	Sat,  8 Mar 2025 13:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741439849; cv=none; b=E1ywBW8HNlLHOYfvLyy/tmX8xCcGa/eS9lUOYWA4imCKVYZoo++GNhDs810ps/QC9at1fwP2ntXhoisPEtsKSqEPAzeEhEENZN6wEIHQWXPU+Lmj1nMa8rP3mlMDCE/pHfPoFMVfp56sdZUcXATvhSAFwFJE5bvBZPI9r3/fYdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741439849; c=relaxed/simple;
	bh=nJhwyvUuY1byHjPC2rw/pJa/OPhY2PFgEysCZalYMdI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X8d9tT5xQ15nZX2Us0q2sQ+DkVjfb82VgR8YC1/awCKBwQgR8ojyh+DXywbkYlsB6yOx21FMcJYEy+CdQ6Xucx1IYXqEb9eT99JJUNZyjG59QfukBJi+HfaI5tlUCbIXDdCLR+/S2g8yqFuXyPGTC21ywAH01zlLawCizIyOAPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G7SrkmgU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAFCEC4CEE0;
	Sat,  8 Mar 2025 13:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741439848;
	bh=nJhwyvUuY1byHjPC2rw/pJa/OPhY2PFgEysCZalYMdI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=G7SrkmgUkDogTD9rTqnZjAOvXEDR5mnZO3/7z0qlsOrBCKrM+7NtbCcQ3C2VXk+Q9
	 VntInERzrcg9vaznHFyVdC4nflBBSw1pAH7Tn7/HoW4kQuopcASUAuD6oY9cVUJAJ/
	 x+guyLibAi3evdSiImSg7AFaH4saFnzXQeMfTMCCJofbkg1A6/gS105ujZWm9XetPP
	 oK8djD1WeyEBhlFkqa/Bmb+LoinVTgzT38ybCOnm7G6q/COw0qd0H1+HzGd1lF7KUX
	 oULWznFWRgY7Z1IUjNKlfoL1cwR736FtPxXhj7/iu+X3/PJDd6dztI+9Q7BGgBjhdL
	 216gAoUPAu8Qg==
Date: Sat, 8 Mar 2025 13:17:19 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
 <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
 <marcelo.schmitt@analog.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
 <conor+dt@kernel.org>, <linus.walleij@linaro.org>, <brgl@bgdev.pl>,
 <lgirdwood@gmail.com>, <broonie@kernel.org>, <dlechner@baylibre.com>,
 <marcelo.schmitt1@gmail.com>, <jonath4nns@gmail.com>
Subject: Re: [PATCH v4 03/17] dt-bindings: iio: adc: ad7768-1: add
 trigger-sources property
Message-ID: <20250308131719.719f26f2@jic23-huawei>
In-Reply-To: <4136b5259df75221fc314bcd4a57ecaeeab41a45.1741268122.git.Jonathan.Santos@analog.com>
References: <cover.1741268122.git.Jonathan.Santos@analog.com>
	<4136b5259df75221fc314bcd4a57ecaeeab41a45.1741268122.git.Jonathan.Santos@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 6 Mar 2025 18:00:56 -0300
Jonathan Santos <Jonathan.Santos@analog.com> wrote:

> In addition to GPIO synchronization, The AD7768-1 also supports
> synchronization over SPI, which use is recommended when the GPIO
> cannot provide a pulse synchronous with the base MCLK signal. It
> consists of looping back the SYNC_OUT to the SYNC_IN pin and send
> a command via SPI to trigger the synchronization.
> 
> Add a new trigger-sources property to enable synchronization over SPI
> and future multiple devices support. This property references the
> main device (or trigger provider) responsible for generating the
> SYNC_OUT pulse to drive the SYNC_IN of device.
> 
> While at it, add description to the interrupts property.
> 
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
To me this looks fine but there was a discussion with Conor on v3,
so I'll wait for him to take another look.

Jonathan

> ---
> v4 Changes:
> * none
> 
> v3 Changes:
> * Fixed dt-bindings errors.
> * Trigger-source is set as an alternative to sync-in-gpios, so we
>   don't break the previous ABI.
> * increased maxItems from trigger-sources to 2.
> 
> v2 Changes:
> * Patch added as replacement for adi,sync-in-spi patch.
> * addressed the request for a description to interrupts property.
> ---
>  .../bindings/iio/adc/adi,ad7768-1.yaml        | 28 +++++++++++++++++--
>  1 file changed, 25 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
> index 3ce59d4d065f..4bcc9e20fab9 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
> @@ -26,7 +26,19 @@ properties:
>    clock-names:
>      const: mclk
>  
> +  trigger-sources:
> +    description:
> +      Specifies the device responsible for driving the synchronization pin,
> +      as an alternative to adi,sync-in-gpios. If the own device node is
> +      referenced, The synchronization over SPI is enabled and the SYNC_OUT
> +      output will drive the SYNC_IN pin.
> +    maxItems: 2
> +
>    interrupts:
> +    description:
> +      Specifies the interrupt line associated with the ADC. This refers
> +      to the DRDY (Data Ready) pin, which signals when conversion results are
> +      available.
>      maxItems: 1
>  
>    '#address-cells':
> @@ -57,6 +69,9 @@ properties:
>    "#io-channel-cells":
>      const: 1
>  
> +  "#trigger-source-cells":
> +    const: 0
> +
>  required:
>    - compatible
>    - reg
> @@ -65,7 +80,6 @@ required:
>    - vref-supply
>    - spi-cpol
>    - spi-cpha
> -  - adi,sync-in-gpios
>  
>  patternProperties:
>    "^channel@([0-9]|1[0-5])$":
> @@ -89,6 +103,13 @@ patternProperties:
>  allOf:
>    - $ref: /schemas/spi/spi-peripheral-props.yaml#
>  
> +  - oneOf:
> +      - required:
> +          - trigger-sources
> +          - "#trigger-source-cells"
> +      - required:
> +          - adi,sync-in-gpios
> +
>  unevaluatedProperties: false
>  
>  examples:
> @@ -99,7 +120,7 @@ examples:
>          #address-cells = <1>;
>          #size-cells = <0>;
>  
> -        adc@0 {
> +        adc0: adc@0 {
>              compatible = "adi,ad7768-1";
>              reg = <0>;
>              spi-max-frequency = <2000000>;
> @@ -108,7 +129,8 @@ examples:
>              vref-supply = <&adc_vref>;
>              interrupts = <25 IRQ_TYPE_EDGE_RISING>;
>              interrupt-parent = <&gpio>;
> -            adi,sync-in-gpios = <&gpio 22 GPIO_ACTIVE_LOW>;
> +            trigger-sources = <&adc0 0>;
> +            #trigger-source-cells = <0>;
>              reset-gpios = <&gpio 27 GPIO_ACTIVE_LOW>;
>              clocks = <&ad7768_mclk>;
>              clock-names = "mclk";


