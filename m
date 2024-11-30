Return-Path: <linux-iio+bounces-12846-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0AE9DEFA2
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 10:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50C4A163081
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 09:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E55114BF87;
	Sat, 30 Nov 2024 09:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tMMup1VW"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3246729A0;
	Sat, 30 Nov 2024 09:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732959748; cv=none; b=n02QkquIkzBUiCMDyHOcuFrDGCFpn0sGNY+wyB86FL+Pjghfd/HlE3w9AGjPLgwPk7hdxixS0hycDy18cKrCdeQuKKoqJxs6yCFypj42MpAGkgjfVINPl3YaLtjxhmqERbKyVisAFF8ONgk5FoPFx7RISagyZqMePGCsyoBYxGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732959748; c=relaxed/simple;
	bh=ChA8MaKv7FB791eaVmMD6k6drakoh/CD0dYxRF0wTpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iNFmDpvcIAZj6KmZup0Ms7NGwbcPy4ulYDNp1nD/FZwkA2FucoQDic0ssF/nTFn71qERyAwpRWeqVnYuO2fLGWF/Zf3mxLXKOv2At78csBykSiIIbsIYyf+Mm/UfgOE5apVNUQQekpsxMP9AWmTaievHFOboJqtGfAdC5rJuA4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tMMup1VW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E61D0C4CECC;
	Sat, 30 Nov 2024 09:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732959746;
	bh=ChA8MaKv7FB791eaVmMD6k6drakoh/CD0dYxRF0wTpc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tMMup1VWFBUr30C29DJm1UDQsxJnfz8Amx9ZLw35AzC0UQ7XmprGJyNT09G9cRRbS
	 aqloYdIb6Wq54UyVp4/xJIgfIWIOQskytqb9940L4r5egzBFhd9hZNAnbYVr4T6Ztq
	 pmiaI+4LVlje//sEQpZyOFl9tAtkLjlUjY09Sdf9AdwyHmBfVTaeJZ3xi9wTLoPcP5
	 2JeuWOIXk76LtrTNVGipu42X7UBR/o7Fy9ndHVBCKztTZdQl8fejHcblA/oSoc772b
	 1hrBi1278XCBCPdGawFyV+Y1zpCcAno+ryiLo96eA0gLJJUKSP8OOshhkJ7FaKIvGA
	 nqM3Mk3viF4VA==
Date: Sat, 30 Nov 2024 10:42:23 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v5 1/4] dt-bindings: iio: adc: adi,ad4000: Add PulSAR
Message-ID: <vjdi3s5cvhg72hqodybrh4ydbh5lvol2rczn324cmqp3ehetnh@7fnvi66smqky>
References: <cover.1732885470.git.marcelo.schmitt@analog.com>
 <93f63a7b5973c8596cfc3216e833d0129d8c61a4.1732885470.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <93f63a7b5973c8596cfc3216e833d0129d8c61a4.1732885470.git.marcelo.schmitt@analog.com>

On Fri, Nov 29, 2024 at 10:13:35AM -0300, Marcelo Schmitt wrote:
> Extend the AD4000 series device tree documentation to also describe
> PulSAR devices.
> 
> The single-channel series of PulSAR devices is similar to the AD4000 series
> except PulSAR devices sample at slower rates and don't have a
> configuration register. Because PulSAR devices don't have a configuration
> register, they don't support all features of AD4000 devices and thus fewer
> interfaces are provided to user space. Also, while AD4000 may have their
> SDI pin connected to SPI host MOSI line, PulSAR SDI pin is never connected
> to MOSI.
> 
> Some devices within the PulSAR series are just faster versions of others.
> >From fastest to slowest, AD7980, AD7988-5, AD7686, AD7685, and AD7988-1 are
> all 16-bit pseudo-differential pin-for-pin compatible ADCs. Devices that
> only vary on the sample rate are documented with a common fallback
> compatible.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
> Change log v4 -> v5
> - Added const items for fallback compatibles.
> 
>  .../bindings/iio/adc/adi,ad4000.yaml          | 59 +++++++++++++++++++
>  1 file changed, 59 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml
> index e413a9d8d2a2..5b6662f5f40f 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4000.yaml
> @@ -19,6 +19,20 @@ description: |
>      https://www.analog.com/media/en/technical-documentation/data-sheets/ad4020-4021-4022.pdf
>      https://www.analog.com/media/en/technical-documentation/data-sheets/adaq4001.pdf
>      https://www.analog.com/media/en/technical-documentation/data-sheets/adaq4003.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7685.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7686.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7687.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7688.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7690.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7691.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7693.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7942.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7946.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7980.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7982.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7983.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7984.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7988-1_7988-5.pdf
>  
>  $ref: /schemas/spi/spi-peripheral-props.yaml#
>  
> @@ -63,6 +77,35 @@ properties:
>  
>        - const: adi,adaq4003
>  
> +      - const: adi,ad7983

Why this is here but not in enum?

> +      - items:
> +          - enum:
> +              - adi,ad7685
> +              - adi,ad7686
> +              - adi,ad7980
> +              - adi,ad7988-1
> +              - adi,ad7988-5
> +          - const: adi,ad7983
> +
> +      - const: adi,ad7687
> +      - items:
> +          - enum:
> +              - adi,ad7688
> +              - adi,ad7693
> +          - const: adi,ad7687
> +
> +      - const: adi,ad7691
> +      - items:
> +          - enum:
> +              - adi,ad7690
> +              - adi,ad7982
> +              - adi,ad7984
> +          - const: adi,ad7691
> +
> +      - enum:
> +          - adi,ad7942
> +          - adi,ad7946

Look, you have here enum for all single-compatible cases. Add all of
other cases here as well. That's the convention in 99% of bindings.

Best regards,
Krzysztof


