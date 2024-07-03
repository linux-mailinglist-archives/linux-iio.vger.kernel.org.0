Return-Path: <linux-iio+bounces-7286-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 963B6926B41
	for <lists+linux-iio@lfdr.de>; Thu,  4 Jul 2024 00:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 559732820B7
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2024 22:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7887118A924;
	Wed,  3 Jul 2024 22:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M3OAl1Om"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC49140E5C;
	Wed,  3 Jul 2024 22:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720044533; cv=none; b=NrWPbJCSJm+dMREmel/sCQ4mVW7z1kU2rWYMfvZplMupqCbLiB44Oba2GJMMHFXV4qbp0DXaH/KNj5HszXCM7seCLXOhQgVvqXZr0XBsT1SaQjkd4DDFIgOVRVCwL9GSSkFwdIxoF79brOgnA4ZHEFNCtVlGKrC/Nm9M+tBajZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720044533; c=relaxed/simple;
	bh=wdBdTiHCbF2qKOyMQ7xpVrnGVBj8A+wLtg7RDv7wIL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i0BnzXfSLfzCeaydQH81nB4sBfyqmZ4bejcxztz+1yYEG+DV2YGHw6dzeVMiGbR6XLujBco2xpnNNMoxwDVZL5NiYree+lFRGYUexD2/yJTGN2FPei6kMdiMuVpGcgR7nfiUdj6NReugd//w2uHdzIM85xTgCZUPJT6w9R/6Unw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M3OAl1Om; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D360CC2BD10;
	Wed,  3 Jul 2024 22:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720044533;
	bh=wdBdTiHCbF2qKOyMQ7xpVrnGVBj8A+wLtg7RDv7wIL8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M3OAl1OmWc4RtGGrrOmwYu8LWrgGbJc5D6QLLdJzwJpeATWYRhqScINvlT9cvpUtS
	 L/96x5C2zsvU/nM8IfpRAG9j82Knov3dGMapncZMA60YDK6BZbH1kYW5PJShZdwijn
	 3DvZep1BHEbYI3Y9YYi1VfaRcQ9OegxkVpFJ0qRnckouUDe33oWtpdQJ6d9M5QRZwR
	 dDDURa6TbG2/dYhI7pet408KPn8mB5/sCv2EPDqbvgh6N3cgN6XdA8ue1cY3IIhpTe
	 EOJ3QG+f12g7jioJooLkqt0WcBx73NacjLOBRGfnpIvudhiCUD9v2MM3labTo8Fp8f
	 Kp9WXyFhVqaYw==
Date: Wed, 3 Jul 2024 16:08:51 -0600
From: Rob Herring <robh@kernel.org>
To: Olivier Moysan <olivier.moysan@foss.st.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/8] dt-bindings: iio: add backend support to sd
 modulator
Message-ID: <20240703220851.GA2075233-robh@kernel.org>
References: <20240703160535.2277871-1-olivier.moysan@foss.st.com>
 <20240703160535.2277871-6-olivier.moysan@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703160535.2277871-6-olivier.moysan@foss.st.com>

On Wed, Jul 03, 2024 at 06:05:30PM +0200, Olivier Moysan wrote:
> The legacy sd modulator driver registers the sigma delta modulator as
> an IIO channel provider. This implementation is not convenient when the
> SD modulator has to be cascaded with another IIO device. The scaling
> information is distributed across devices, which makes it difficult to
> report consistent scaling data on IIO devices.
> 
> The solution is to expose these cascaded IIO devices as an aggregate
> device, which report global scaling information.
> Add IIO backend support to SD modulator to allow scaling information
> management.
> 
> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
> ---
>  .../iio/adc/sigma-delta-modulator.yaml        | 24 +++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.yaml b/Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.yaml
> index cab0d425eaa4..e34aa560da63 100644
> --- a/Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.yaml
> @@ -18,18 +18,38 @@ properties:
>        - sd-modulator
>        - ads1201
>  
> +  '#io-backend-cells':
> +    const: 0
> +
>    '#io-channel-cells':
>      const: 0
>  
> +  reg:
> +    maxItems: 1
> +
> +  vref-supply:
> +    description: Phandle to the vref input analog reference voltage.
> +
>  required:
>    - compatible
> -  - '#io-channel-cells'
> +
> +allOf:

Don't need allOf

> +  - anyOf:
> +    - required: ['#io-backend-cells']
> +    - required: ['#io-channel-cells']
>  
>  additionalProperties: false
>  
>  examples:
>    - |
> -    ads1202: adc {
> +    // Exemple1: SD modulator is an IIO backend device
> +    ads1201_0 {
> +      compatible = "ti,ads1201";
> +      #io-backend-cells = <0>;
> +    };
> +
> +    //Example2: SD modulator is an IIO channel provider
> +    ads1201_1 {
>        compatible = "sd-modulator";
>        #io-channel-cells = <0>;

Don't you need some link between the nodes?

>      };
> -- 
> 2.25.1
> 

