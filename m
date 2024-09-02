Return-Path: <linux-iio+bounces-8995-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E359686D1
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 13:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00ABFB25D0B
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 11:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 979841DAC44;
	Mon,  2 Sep 2024 11:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hsH7XqUA"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516DF17F394;
	Mon,  2 Sep 2024 11:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725278158; cv=none; b=Oa+V/q3vABNHLwa0G5op/cH+QiL6MY+x99rcurbLSZpjE/UFQHObt/EmrKiXo34FgsYCKDoaKEMrN5f67n98bS38a7QAUzA7g5NPPu/VR90Azfh2gpAzxH5TAndEyjPChSzgL11BWG+WOzpLWfpUdwq7H2as1ZW2UAdqPf1g5Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725278158; c=relaxed/simple;
	bh=Y8MfiB7irJCP3K3Jd5maCMcOLA9rDhVRzc4+TXJsPmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KJQW5TajqmhsDxw0NF+zzeH0UQX32KR5sdxowHO5l1urMuHpPdl0IjmSJhLklmm0wTY5nP4C9lz1gB+dDway+TQ0FQZ6CnenVxKDYT7wbhckxbtmnbAa6oAtbVLSDF/CZ7fSpzk3tux0AZJqTzPEazjt5Z+1ho/fROQQera0wM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hsH7XqUA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33CCDC4CEC2;
	Mon,  2 Sep 2024 11:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725278158;
	bh=Y8MfiB7irJCP3K3Jd5maCMcOLA9rDhVRzc4+TXJsPmM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hsH7XqUALX2lEKVlWS0dVERz5tJO1QBLsYNq9H2WVCi7oTLFsXwvLyVWU1L9JHt1k
	 WDhcrysj6J+qNaRj7CG/xQHHMOA64VTJFTGyr6kBuIKLNWQBDHxqcvcsmzgkqPtxp7
	 MpA7nDI6sbNEyuwIlceULxG3sf2y2eG3EL4o+/yReHCqDb5YxLzvFTfpZWIJyz83wW
	 P9acAnop8tYgCKXI3pBIsYb8/+wyZjxAYghePHKjwOD+2exrM5zNTlebrZSLiGlFUl
	 IjhF1gFmmZo8zfUVPMS6uuHju7lzzaH6g/PKQUxmK+N/Um4I0emhU5sVbbhZdnlY/v
	 Z9eYpW/bBeI2Q==
Date: Mon, 2 Sep 2024 13:55:54 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Alexandru Ardelean <aardelean@baylibre.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, jic23@kernel.org, krzk+dt@kernel.org, robh@kernel.org, 
	lars@metafoo.de, michael.hennerich@analog.com, gstols@baylibre.com
Subject: Re: [PATCH v2 7/8] dt-bindings: iio: adc: add adi,ad7606c-{16,18}
 compatible strings
Message-ID: <rdk2f6c457k462g5v6s5vumdmhejefyfareio5f6bogslg4wg5@ket4vfwwbyi7>
References: <20240902103638.686039-1-aardelean@baylibre.com>
 <20240902103638.686039-8-aardelean@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240902103638.686039-8-aardelean@baylibre.com>

On Mon, Sep 02, 2024 at 01:36:30PM +0300, Alexandru Ardelean wrote:
>    reg:
> @@ -114,6 +118,25 @@ properties:
>        assumed that the pins are hardwired to VDD.
>      type: boolean
>  
> +patternProperties:
> +  "^channel@([0-7])$":
> +    type: object
> +    $ref: adc.yaml
> +    unevaluatedProperties: false
> +
> +    properties:
> +      reg:
> +        description: The channel number.
> +        minimum: 0
> +        maximum: 7
> +
> +      diff-channels: true

Shouldn't this be specific?

> +
> +      bipolar: true
> +
> +    required:
> +      - reg
> +
>  required:
>    - compatible
>    - reg
> @@ -202,4 +225,44 @@ examples:
>              standby-gpios = <&gpio 24 GPIO_ACTIVE_LOW>;
>          };
>      };
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        adc@0 {
> +            compatible = "adi,ad7606c-18";
> +            reg = <0>;
> +            spi-max-frequency = <1000000>;
> +            spi-cpol;
> +            spi-cpha;
> +
> +            avcc-supply = <&adc_vref>;
> +            vdrive-supply = <&vdd_supply>;
> +
> +            interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
> +            interrupt-parent = <&gpio>;
> +
> +            adi,conversion-start-gpios = <&gpio 17 GPIO_ACTIVE_HIGH>;
> +
> +            adi,conversion-start-gpios = <&gpio 17 GPIO_ACTIVE_HIGH>;
> +            reset-gpios = <&gpio 27 GPIO_ACTIVE_HIGH>;
> +            adi,first-data-gpios = <&gpio 22 GPIO_ACTIVE_HIGH>;
> +            standby-gpios = <&gpio 24 GPIO_ACTIVE_LOW>;
> +
> +            adi,sw-mode;
> +
> +            channel@1 {
> +                reg = <1>;
> +                diff-channel;

Where is this property defined (which schema)?

Did you test it?

Best regards,
Krzysztof


