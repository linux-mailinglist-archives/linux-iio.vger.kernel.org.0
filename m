Return-Path: <linux-iio+bounces-18583-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B132A99938
	for <lists+linux-iio@lfdr.de>; Wed, 23 Apr 2025 22:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 088CF3BAAA8
	for <lists+linux-iio@lfdr.de>; Wed, 23 Apr 2025 20:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E65A27B4F4;
	Wed, 23 Apr 2025 20:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n2qFhSZl"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4665152F88;
	Wed, 23 Apr 2025 20:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745439124; cv=none; b=NxAXMV2otg0VuX02dTKH7sbKhQVVMt4Sbibzt95SokSapCM+gHMlrU1c5HdVSFNvUJC7gWBWSQ5QKrQldAtrCluckCoYHcEh99rNZsSkmDKgFIbbt/ivG0qTty2btM+W45AUViyf8HlCeQ+npqDTpuL5AdKId5KK+c3Jc6YOITQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745439124; c=relaxed/simple;
	bh=LnD+ue8gxZJNFdo/2xfgOYOBuy04/6e3cNIPxTVvdRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VBzBkw4Gbv1D+xjYYqXt0k0w4gAYkRYyCn7kgL3Q7cl+LBNnsXb+sRI1TDFK/DhfkJIRiN2a/is0mAkgY6cu5UIAU4ymRvlxd01YXYYISA+vQ5TE/ahyUyoFLSJoHFc+YF+S9U9e3oKcXtCLG3uvJWW9Sjd8zpb6wCnv/ZuMSYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n2qFhSZl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95048C4CEE2;
	Wed, 23 Apr 2025 20:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745439123;
	bh=LnD+ue8gxZJNFdo/2xfgOYOBuy04/6e3cNIPxTVvdRo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n2qFhSZlxizUAuFSVlnuAdPaqwCQ/xa+wkw5ryFyKcgp8+Ghsdi+1UkdPICc4xw08
	 qxeh8i8MSZ4ck7E/2MBg2NYoF53MXkj1pSlyEtrq/1mqaxvTVd73oiylCsfO4ZlkFN
	 FLxKQ844wtaHxfFutwYkpcvGpPzSyi+Bg6Wx9PkjdHbo5RvCv+FbF0ZvH9t9aR0Krk
	 /jxZeT6ORj8fNBaL3oewJJS+CvUnJbsd563wa3hglRLbdYgHjDbePipQfRKmab6/+u
	 cEkfPIzKH+n9lDTMFHG6Ce2VbXdajdTUDlH+pyhBTNYbR9erJxrZU6YJdgjkI2sdqY
	 ONHU3y6VLShtg==
Date: Wed, 23 Apr 2025 15:12:01 -0500
From: Rob Herring <robh@kernel.org>
To: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
Cc: jic23@kernel.org, ~lkcamp/patches@lists.sr.ht,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings:iio:adc:st,spear600-adc: txt to yaml format
 conversion.
Message-ID: <20250423201201.GA983074-robh@kernel.org>
References: <20250423022956.31218-1-rodrigo.gobbi.7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250423022956.31218-1-rodrigo.gobbi.7@gmail.com>

On Tue, Apr 22, 2025 at 11:14:23PM -0300, Rodrigo Gobbi wrote:
> Straight forward conversion from spear-adc.txt into yaml format.
> 
> Signed-off-by: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
> ---
> After the conversion to yaml file, I was not sure about the
> maintainers yaml field. It looks like the original driver author,
> Stefan Roese, is not active contributing.
> @Jonathan, I was not sure about it and I've added you on that field
> as I've noticed at other yaml`s, but feel free to give any suggestions on that
> or how to proceed in this case.

That's fine I think, or you can add the spear platform maintainers.

> 
> Also noticed that the driver was moved out of staging, but the .txt was not
> in that time. Added the yaml in the proper path (out of staging as the driver).
> Tks and best regards.
> ---
>  .../bindings/iio/adc/st,spear600-adc.yaml     | 61 +++++++++++++++++++
>  .../bindings/staging/iio/adc/spear-adc.txt    | 24 --------
>  2 files changed, 61 insertions(+), 24 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/st,spear600-adc.yaml
>  delete mode 100644 Documentation/devicetree/bindings/staging/iio/adc/spear-adc.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/st,spear600-adc.yaml b/Documentation/devicetree/bindings/iio/adc/st,spear600-adc.yaml
> new file mode 100644
> index 000000000000..a858b3f3c494
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/st,spear600-adc.yaml
> @@ -0,0 +1,61 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/st,spear600-adc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ST SPEAr ADC device driver
> +
> +maintainers:
> +  - Jonathan Cameron <jic23@kernel.org>
> +
> +description: |
> +  Integrated ADC inside the ST SPEAr SoC, SPEAr600, supporting
> +  10-bit resolution. Datasheet can be found here:
> +  https://www.st.com/resource/en/datasheet/spear600.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - st,spear600-adc

blank line

> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  sampling-frequency:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Default sampling frequency of the ADC

Constraints?

> +
> +  vref-external:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      External voltage reference in milli-volts. If omitted
> +      the internal voltage reference will be used.

Constraints?

> +
> +  average-samples:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Number of samples to generate an average value. If
> +      omitted, single data conversion will be used.

Constraints?

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - sampling-frequency
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    adc: adc@d8200000 {
> +        compatible = "st,spear600-adc";
> +        reg = <0xd8200000 0x1000>;
> +        interrupt-parent = <&vic1>;
> +        interrupts = <6>;
> +        sampling-frequency = <5000000>;
> +        vref-external = <2500>;	/* 2.5V VRef */
> +    };
> diff --git a/Documentation/devicetree/bindings/staging/iio/adc/spear-adc.txt b/Documentation/devicetree/bindings/staging/iio/adc/spear-adc.txt
> deleted file mode 100644
> index 88bc94fe1f6d..000000000000
> --- a/Documentation/devicetree/bindings/staging/iio/adc/spear-adc.txt
> +++ /dev/null
> @@ -1,24 +0,0 @@
> -* ST SPEAr ADC device driver
> -
> -Required properties:
> -- compatible: Should be "st,spear600-adc"
> -- reg: Address and length of the register set for the device
> -- interrupts: Should contain the ADC interrupt
> -- sampling-frequency: Default sampling frequency
> -
> -Optional properties:
> -- vref-external: External voltage reference in milli-volts. If omitted
> -  the internal voltage reference will be used.
> -- average-samples: Number of samples to generate an average value. If
> -  omitted, single data conversion will be used.
> -
> -Examples:
> -
> -	adc: adc@d8200000 {
> -		compatible = "st,spear600-adc";
> -		reg = <0xd8200000 0x1000>;
> -		interrupt-parent = <&vic1>;
> -		interrupts = <6>;
> -		sampling-frequency = <5000000>;
> -		vref-external = <2500>;	/* 2.5V VRef */
> -	};
> -- 
> 2.47.0
> 

