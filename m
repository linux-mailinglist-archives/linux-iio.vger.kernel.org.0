Return-Path: <linux-iio+bounces-9760-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3658984D25
	for <lists+linux-iio@lfdr.de>; Tue, 24 Sep 2024 23:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A409C281FAA
	for <lists+linux-iio@lfdr.de>; Tue, 24 Sep 2024 21:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38979146A93;
	Tue, 24 Sep 2024 21:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BHLd0kc5"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E587A13B7BC;
	Tue, 24 Sep 2024 21:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727215154; cv=none; b=oNLEXAjNsfx5QY0y+jYZq9XRghCClcxbInHFTtXC/Xxk5fM5fRhDwf909Awim9g7Wh4abCaiVhmL41ZiI2D9TAITOtB3KEo3sWZ+NTqrtaECJoipqNnkaGvPzSh4NZtpJx+RZYFn57Q/WpqNoXwnGRXvdmBiGTK5d2AZXU403Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727215154; c=relaxed/simple;
	bh=3BAXpePOp0z4mzDMdqzOAP3fa2JWxH7UFoXI7w2oTgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sbqjbcgR7YdUkgV35/OeoLXXet+JYPXykEV8HP88KgHg29HyCUJ6aDhkm3vjunEgoBTKRtH1EUK7GD+MVGcz/QVDw0bwYqxDzPctKofMifgsBm6h3dsDlY+kyaKNROtgzShNXicsn8U54PRtmJWD4oe5e1etDHBrDIhU8OY42kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BHLd0kc5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ECB5C4CEC6;
	Tue, 24 Sep 2024 21:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727215153;
	bh=3BAXpePOp0z4mzDMdqzOAP3fa2JWxH7UFoXI7w2oTgU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BHLd0kc5wUn1+YoeJ6Kgzsjpf9izoyVfypK1JaFjI8tRFKolc1x5nsKn2k1pEAwzS
	 f9VfOP598NrX6jTA5V0DZlJgL0B6c9BrMBTVxRy8/REQwkRJrZ3umtZYMBocB5ZJhu
	 OVXp8Z//0baWxG8jzTKPuSB/JAuTdWhCyygpkC2TWNIP1lBfZXVQ9AJpXg3wKTCTCs
	 kOWa7r3habqdiEe+CkWtCoI65EbsRyNyZThhmzfyaRaafnBXy9IDLjFxJt8oNH4pxm
	 01bAGXx8WLk+YoPFwEYYuTJ6FAKdtg8y6yecIVJuLNTYFIFxW7VsiTos2pT/i0bq4g
	 QFDmcF6NkXYlg==
Date: Tue, 24 Sep 2024 16:59:12 -0500
From: Rob Herring <robh@kernel.org>
To: Yasin Lee <yasin.lee.x@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: tyhx,hx9023s: Add performance
 tuning configuration
Message-ID: <20240924215912.GA363446-robh@kernel.org>
References: <20240923-add-performance-tuning-configuration-v1-0-587220c8aece@gmail.com>
 <20240923-add-performance-tuning-configuration-v1-1-587220c8aece@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240923-add-performance-tuning-configuration-v1-1-587220c8aece@gmail.com>

On Mon, Sep 23, 2024 at 09:16:10AM +0800, Yasin Lee wrote:
> When hardware design introduces significant sensor data noise,
> performance can be improved by adjusting register settings.
> 
> Signed-off-by: Yasin Lee <yasin.lee.x@gmail.com>
> ---
>  .../devicetree/bindings/iio/proximity/tyhx,hx9023s.yaml    | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.yaml b/Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.yaml
> index 64ce8bc8bd36..417fbc0bb205 100644
> --- a/Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.yaml
> +++ b/Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.yaml
> @@ -28,6 +28,13 @@ properties:
>  
>    vdd-supply: true
>  
> +  tyhx,performance-tuning:
> +    description:
> +      Optional, When hardware design introduces significant sensor data noise,
> +      performance can be improved by adjusting register settings, including
> +      but not limited to sample integration time and average sample count.
> +    $ref: /schemas/types.yaml#/definitions/uint8-array

1 byte is valid? What about 10000? Add some constraints on the array 
size and the values if possible 

> +
>    "#address-cells":
>      const: 1
>  
> @@ -65,6 +72,13 @@ examples:
>          interrupt-parent = <&pio>;
>          interrupts = <16 IRQ_TYPE_EDGE_FALLING>;
>          vdd-supply = <&pp1800_prox>;
> +        tyhx,performance-tuning = [00 00
> +        02 17
> +        0D 44
> +        0E 44
> +        0F 04
> +        1F 65
> +        21 65];
>  
>          #address-cells = <1>;
>          #size-cells = <0>;
> 
> -- 
> 2.43.0
> 

