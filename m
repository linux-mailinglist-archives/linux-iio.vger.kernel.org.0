Return-Path: <linux-iio+bounces-7885-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81D9493C31F
	for <lists+linux-iio@lfdr.de>; Thu, 25 Jul 2024 15:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 409911F222CB
	for <lists+linux-iio@lfdr.de>; Thu, 25 Jul 2024 13:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2AD419ADA2;
	Thu, 25 Jul 2024 13:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oUjrGYu8"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675BBC8DF;
	Thu, 25 Jul 2024 13:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721914672; cv=none; b=W+2y0NxTVUh9eWFwIpFiUuuFwzpDARfo+YfrTS0Gr4bWHliHTtcYTXRs9jQrPFRCuDjR2y4pIWT2n4Pz5tDS0hd8uWR9zKMzSBPTRS/P0u56T9pRz1YeHjX8eD+UIZYC/84j+A+aSDWiwgmrLQnSCaN/75m4flok4Fz41f02UJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721914672; c=relaxed/simple;
	bh=uQ/kUueeeni8nylLapPehWnOoiFUDkwvC3TYLWPtfZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kq557uItp+OjYPmIIoBeLJnfxXxfMBNP8XmkeAXvGoMsDtjsaZQPIA9MnlxcaKB06dirGAyR27ev4s2ytE8QPY6aQS+SM46J8z0n1N0P3Wp5Fxd+z1O0yNXOSPP9r+7fRnyAzPUvJ7LOXYY7KRgxFSGPOnRRUHNAdRV/OsQZoKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oUjrGYu8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB9B9C4AF0A;
	Thu, 25 Jul 2024 13:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721914672;
	bh=uQ/kUueeeni8nylLapPehWnOoiFUDkwvC3TYLWPtfZQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oUjrGYu8pxZX0KjizUZN5Z/M2rfAKgJAH53eNqOzwlUO7vBrSeU4KFcPPCvG9w0mV
	 A2DMxmEpG/2GeZcdI5QoXTzD5tuHFlK0ZL7BBBqz4IuaN1emFJxuxVgg5Id6H2hcJw
	 e+8wcIHCdCipwvWM9vdTqY2hYOZ8PszWbCT8aecN0c7UEwLB5x+tjLau2xY5Z7ypQ8
	 3uiPMC5aoqPWY5Bs9QU0nXVCAarD8L/k+48tXEcgPKgpTeaCXP+ogOzKJ4z2zgNXjf
	 HZkpW6weq5/z7v+CCt+IBVjp6t0wUR3SKTqqKSVt1Dr8wtV1yOLNwwPVqA1FNOyBMg
	 ddEimL/R5O1Cg==
Date: Thu, 25 Jul 2024 08:37:50 -0500
From: Rob Herring <robh@kernel.org>
To: Olivier Moysan <olivier.moysan@foss.st.com>
Cc: fabrice.gasnier@foss.st.com, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 5/9] dt-bindings: iio: add backend support to sd
 modulator
Message-ID: <20240725133750.GA1726974-robh@kernel.org>
References: <20240724153639.803263-1-olivier.moysan@foss.st.com>
 <20240724153639.803263-6-olivier.moysan@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240724153639.803263-6-olivier.moysan@foss.st.com>

On Wed, Jul 24, 2024 at 05:36:33PM +0200, Olivier Moysan wrote:
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
>  .../bindings/iio/adc/sigma-delta-modulator.yaml | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.yaml b/Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.yaml
> index cab0d425eaa4..b245971fecb0 100644
> --- a/Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.yaml
> @@ -18,18 +18,31 @@ properties:
>        - sd-modulator
>        - ads1201
>  
> +  '#io-backend-cells':
> +    const: 0
> +
>    '#io-channel-cells':
>      const: 0
>  
>  required:
>    - compatible
> -  - '#io-channel-cells'
> +
> +anyOf:
> +  - required: ['#io-backend-cells']
> +  - required: ['#io-channel-cells']
>  
>  additionalProperties: false
>  
>  examples:
>    - |
> -    ads1202: adc {
> +    // Backend binding example. SD modulator configured as an IIO backend device
> +    ads1201_0 {
> +      compatible = "sd-modulator";
> +      #io-backend-cells = <0>;
> +    };
> +
> +    // Legacy binding example. SD modulator configured as an IIO channel provider
> +    ads1201_1 {

Why the node name change? 'adc' is generic and was correct.

This should be a separate example. (Add '- |').

>        compatible = "sd-modulator";
>        #io-channel-cells = <0>;
>      };
> -- 
> 2.25.1
> 

