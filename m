Return-Path: <linux-iio+bounces-11054-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 157589ADD9F
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 09:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4459A1C2177C
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 07:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5AC8198826;
	Thu, 24 Oct 2024 07:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QffVILSX"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56797169AE4;
	Thu, 24 Oct 2024 07:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729754999; cv=none; b=q8u7yINzlvpv6B6c+HkCWYsl3cY27nOUWMsi4/oSQy4gJY767vVtwQmM2VickabDIHntBjcD9YENOhmyHp3N7HJgVczvxC68aJVdAcNn+eu2rKjtBGfxrgtKl1LuSbNSNec0DWXsIk9hPJ3NzdRsoIxZC6x4O3/AxBJPpCanG3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729754999; c=relaxed/simple;
	bh=G22QRFhSX2UGYMXTZ/s188G3HnD+jJva75a/AyvugZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YDVCpC5k8y3Mf0+/I1GP8QiAfrOJaSIM4RaXOIcrv4CYc1RddFyK+PKlYlh//dW7BH2SD9LfsHk6KPNlHk+5A+YuRpXfrZqs5YrFpf/5TfUH4KkAhNkgKPuV7rxHVt/nKWZRwfFAyf0f3SGNZVm8mM5Ww1fAHlm9oK8F+YV4zqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QffVILSX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4B5FC4CEC7;
	Thu, 24 Oct 2024 07:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729754998;
	bh=G22QRFhSX2UGYMXTZ/s188G3HnD+jJva75a/AyvugZM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QffVILSX4nWEfDxU73jAV9Ve5wNKTKFTWSDuIWMl8ARu6tGib9uJQvYDR2VAE39V/
	 I/XLp41RPgpK/ycWEDLlWdswjvbdZmA17K/VJTkVSqCooGeOh0G0Ss/F0QEvHU/wKx
	 +NRaioIzQjCD4+JbvMCbW0ZBZBu1TLj3R7qxsZCR69sZrA4uu4pBuhPBWaNlFLOmzm
	 mDHqlCxVkQu5MP5nnuBtCz9D+Lu/2kAizhU6rOsdhqZa2WKUJSud0Pb5c7R8Fxl5wn
	 9rmRIv66vFS3oNW6hWDSvH9TF/2iyBaJI7DynunSktWzfTjkNw0xh2xmcV0GdpIcwA
	 zQo6X1DYdIoPw==
Date: Thu, 24 Oct 2024 09:29:54 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Julien Stephan <jstephan@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	David Lechner <dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 1/4] dt-bindings: iio: adc: ad7380: add adaq4370-4 and
 adaq4380-4 compatible parts
Message-ID: <7uih5kvpy6i4ggq5o7eudzczbicopbdnmbtkyprfperkkqgsmt@42q6bncox3ml>
References: <20241023-ad7380-add-adaq4380-4-support-v2-0-d55faea3bedf@baylibre.com>
 <20241023-ad7380-add-adaq4380-4-support-v2-1-d55faea3bedf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241023-ad7380-add-adaq4380-4-support-v2-1-d55faea3bedf@baylibre.com>

On Wed, Oct 23, 2024 at 11:19:33AM +0200, Julien Stephan wrote:
> +  vs-p-supply:
> +    description:
> +      Amplifiers positive supply.
> +
> +  vs-n-supply:
> +    description:
> +      Amplifiers negative supply.
> +
> +  ldo-supply:
> +    description:
> +      LDO supply. Connect to vs-p-supply or a 3.6 to 5.5 V supply.
>  
>    aina-supply:
>      description:
> @@ -97,12 +115,46 @@ properties:
>        specify the ALERT interrupt.
>      maxItems: 1
>  
> +  '#address-cells':

If there is going to be new version/resend, then keep consistent quotes:
" or '.

> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
>  required:
>    - compatible
>    - reg
>    - vcc-supply
>    - vlogic-supply
>  
> +patternProperties:
> +  "^channel@([0-3])$":

() are not necessary

> +    $ref: adc.yaml
> +    type: object
> +
> +    properties:
> +      reg:
> +        description:
> +          The channel number. From 0 to 3 corresponding to channels A,B,C,D
> +        items:
> +          minimum: 0
> +          maximum: 3

No improvements, no response to comment.

> +
> +      adi,gain-milli:
> +        description:
> +          The hardware gain applied to the ADC input (in milli units).
> +          If not present, default to 1000 (no actual gain applied).
> +          Refer to the typical connection diagrams section of the datasheet for
> +          pin wiring.
> +        $ref: /schemas/types.yaml#/definitions/uint16
> +        enum: [300, 600, 1000, 1600]
> +        default: 1000
> +
> +    required:
> +      - reg
> +
> +    additionalProperties: false
> +
>  unevaluatedProperties: false
>  
>  allOf:
> @@ -140,6 +192,7 @@ allOf:
>          aind-supply: false
>  
>    # ad7380-4 uses refin-supply as external reference.
> +  # adaq devices use internal reference only, derived from refin-supply
>    # All other chips from ad738x family use refio as optional external reference.
>    # When refio-supply is omitted, internal reference is used.
>    - if:
> @@ -147,6 +200,8 @@ allOf:
>          compatible:
>            enum:
>              - adi,ad7380-4
> +            - adi,adaq4370-4
> +            - adi,adaq4380-4
>      then:
>        properties:
>          refio-supply: false
> @@ -156,6 +211,27 @@ allOf:
>        properties:
>          refin-supply: false
>  
> +  # adaq devices need more supplies and using channel to declare gain property
> +  # only applies to adaq devices
> +  - if:
> +      properties:
> +        compatible:
> +          enum:
> +            - adi,adaq4370-4
> +            - adi,adaq4380-4
> +    then:
> +      required:
> +        - vs-p-supply
> +        - vs-n-supply
> +        - ldo-supply
> +    else:
> +      properties:
> +        vs-p-supply: false
> +        vs-n-supply: false
> +        ldo-supply: false
> +      patternProperties:
> +        "^channel@([0-3])$": false

() are not necessary

Best regards,
Krzysztof


