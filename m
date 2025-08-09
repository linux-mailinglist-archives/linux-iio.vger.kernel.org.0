Return-Path: <linux-iio+bounces-22498-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E91B1F5F9
	for <lists+linux-iio@lfdr.de>; Sat,  9 Aug 2025 21:21:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00F40172137
	for <lists+linux-iio@lfdr.de>; Sat,  9 Aug 2025 19:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D552E278161;
	Sat,  9 Aug 2025 19:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="un/TsiVb"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4A31B423B;
	Sat,  9 Aug 2025 19:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754767277; cv=none; b=SnO2C+Gi4fN6TO0rn55r1Gr3S8LMcllSgbHzAmZqrWdEh8rTZuoi0NZMsz5zZSsK1JOF5YgW4HrD1wEpqPEq6Q8HDI1FY9/1LHIUCu10yJjoSqsIlOpUUrSL+rSKKZ7eN2dR2iGtkUBFpsA7OinxQjAnaZH+/XjdjQT2ELO2w+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754767277; c=relaxed/simple;
	bh=GCE6uzMyEVoH9Xi+v8UkjlWcL2ljkK7PNXJxdtwIgjE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kAqdrmr/knXBO8zzLHlM9QcWONpDg7Z6MRpqAN2FyDd5gX3Q9q5fgkd0+p09W9XBmw/+W0LyaXs+GavVA7WSXI3UVzT3oZg38rIskSkm221lPI5hUn57c5DbLTsUN41nxz8VYrJGicdWpDC0tIRqLEPSkwd3uzggxR39BD3YgEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=un/TsiVb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0ACCC4CEE7;
	Sat,  9 Aug 2025 19:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754767277;
	bh=GCE6uzMyEVoH9Xi+v8UkjlWcL2ljkK7PNXJxdtwIgjE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=un/TsiVbhUj4J2V0PtYOjjxNhePOEpj+PO9BCaG/uqRSo5VXbi7Xl+pGRGiE75RAQ
	 W3irgG74qr3pyvlZ2eLIxNFF/0SZA9AuTGcxxpfQQvv35xYASDGMLCp8AZ7zPoPQSG
	 5jqAFhGqwig/+Ep+3PbPa7XarkfD1u5ISeKgEV0O313Z5umqhESTUIx+UZKFqkmkY5
	 WNDQNuDoJ3IhVEzg8i9XI98FbNu9DWAZgfnIQ+ZX/K18m3W2MPy2J7FhNtFfSBcykG
	 QsydA/scK5WJ8fmXM0OPRn5AJItxPd/KkfAr7cdp2yJ2Xtfqdn26FCkuxcVutoavy4
	 0e8fHyc/UPIvA==
Date: Sat, 9 Aug 2025 20:21:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
 <broonie@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 08/10] dt-bindings: iio: adc: ad7476: Add ROHM
 bd79105
Message-ID: <20250809202106.59d405c5@jic23-huawei>
In-Reply-To: <cc5cfa7540caae4bcb7448a59602421d54353ecc.1754641960.git.mazziesaccount@gmail.com>
References: <cover.1754641960.git.mazziesaccount@gmail.com>
	<cc5cfa7540caae4bcb7448a59602421d54353ecc.1754641960.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 8 Aug 2025 11:54:25 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> The ROHM BD79105 is a simple, 16-bit, 1-channel ADC with a 'CONVSTART'
> pin used to start the ADC conversion. Other than the 'CONVSTART', there
> are 3 supply pins (one used as a reference), analog inputs, ground and
> communication pins. It's worth noting that the pin somewhat confusingly
> labeled as 'DIN', is a pin which should be used as a chip-select. The IC
> does not have any writable registers.
> 
> The device is designed so that the output pin can, in addition to
> outputting the data, be used as a 'data-ready'-IRQ. This, however, would
> require the IRQ to be masked from host side for the duration of the data
> reads - and it wouldn't also work when the SPI is shared. (As access to
> the other SPI devices would cause data line changes to be detected as
> IRQs - and the BD79105 provides no means to detect if it has generated
> an IRQ).
> 
> Hence the device-tree does not contain any IRQ properties.

Commit message needs an update as it now allows for IRQ properties.


> 
> Add a compatible for the bd79105.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> ---
> Revision history:
>  v2 => :
>  - No changes
> 
>  v1 => v2:
>  - BD79105 can provide data-ready IRQ (or GPIO) via DOUT-pin.
> ---
>  .../bindings/iio/adc/adi,ad7476.yaml          | 54 +++++++++++++++++++
>  1 file changed, 54 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7476.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7476.yaml
> index d0cb32f136e5..c411a7467651 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7476.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7476.yaml
> @@ -41,6 +41,7 @@ properties:
>                - adi,ad7910
>                - adi,ad7920
>                - adi,ad7940
> +              - rohm,bd79105
>                - ti,adc081s
>                - ti,adc101s
>                - ti,adc121s
> @@ -55,6 +56,11 @@ properties:
>    reg:
>      maxItems: 1
>  
> +  interrupts:
> +    description:
> +      The data-ready interrupt. Provided via DOUT pin.
> +    maxItems: 1
> +
>    vcc-supply:
>      description:
>        Main powersupply voltage for the chips, sometimes referred to as VDD on
> @@ -75,6 +81,10 @@ properties:
>      description: A GPIO used to trigger the start of a conversion
>      maxItems: 1
>  
> +  rdy-gpios:
> +    description: A GPIO for detecting the data-ready.
> +    maxItems: 1
> +
>  required:
>    - compatible
>    - reg
> @@ -82,6 +92,20 @@ required:
>  allOf:
>    - $ref: /schemas/spi/spi-peripheral-props.yaml#
>  
> +# Devices with an IRQ
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - rohm,bd79105
> +    then:
> +      properties:
> +        interrupts: true

It's been a while since I wrote one of these, but do we need
the true bit given we have already specified the interrupts
property.  I think we only need to do the setting to false
on an if: not: 

> +    else:
> +      properties:
> +        interrupts: false
> +
>    # Devices where reference is vcc
>    - if:
>        properties:
> @@ -115,6 +139,7 @@ allOf:
>                - adi,ad7274
>                - adi,ad7475
>                - lltc,ltc2314-14
> +              - rohm,bd79105
>      then:
>        properties:
>          vref-supply: true
> @@ -131,6 +156,7 @@ allOf:
>                - adi,ad7274
>                - adi,ad7475
>                - lltc,ltc2314-14
> +              - rohm,bd79105
>      then:
>        required:
>          - vref-supply
> @@ -141,12 +167,28 @@ allOf:
>              enum:
>                - adi,ad7475
>                - adi,ad7495
> +              - rohm,bd79105
>      then:
>        properties:
>          vdrive-supply: true
>      else:
>        properties:
>          vdrive-supply: false
> +
> +  # Devices which support polling the data-ready via GPIO
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - rohm,bd79105
> +    then:
> +      properties:
> +        rdy-gpios: true

As above, I believe we only need the not case.

> +    else:
> +      properties:
> +        rdy-gpios: false
> +
>    - if:
>        properties:
>          compatible:
> @@ -154,6 +196,7 @@ allOf:
>              enum:
>                - adi,ad7091
>                - adi,ad7091r
> +              - rohm,bd79105
>      then:
>        properties:
>          adi,conversion-start-gpios: true
> @@ -161,6 +204,17 @@ allOf:
>        properties:
>          adi,conversion-start-gpios: false
>  
> +  # Devices with a convstart GPIO where it is not optional
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - rohm,bd79105
> +    then:
> +      required:
> +        - adi,conversion-start-gpios
> +
>  unevaluatedProperties: false
>  
>  examples:


