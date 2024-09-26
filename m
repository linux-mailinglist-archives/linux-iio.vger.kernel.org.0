Return-Path: <linux-iio+bounces-9779-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A48986CED
	for <lists+linux-iio@lfdr.de>; Thu, 26 Sep 2024 08:53:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 762F1280FD5
	for <lists+linux-iio@lfdr.de>; Thu, 26 Sep 2024 06:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755A8188CD2;
	Thu, 26 Sep 2024 06:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TQ0B6eRV"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF3A224D6;
	Thu, 26 Sep 2024 06:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727333633; cv=none; b=oKE4T5BGpYavx2J590Zi89FWIImgDdKVWiBSU1IslNYeb7DwnCIRFPtYgXfNQNFiotpSKkB0jjKoig8spHwohgO6aQ0ES/tgRHYGFvbS4k3mYn++L9Q7goSguGc2bwZG71HubFqJk0ZS7DvIi7vsI9MPqRdvYoU1ME/MKJ3Ob6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727333633; c=relaxed/simple;
	bh=LzsrDryHFl9C08XGKSz5W67wXulyuHbJSe/ImatV49o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BBeFGKiSLMRQzqyEGAt9LLg7Unjr7M6JB3UXp/2HHQCKqKDiZvLuAy10oIOqhApoQaOxlFOlya6hI12PTa+MMt1zAld+Y4hpRjRHz9T7ck+viBE4sGodMDvSMQhjr2P/KpzdibDNkhrMU0K9qvYNClSGAMiUFVNjCH1EiAZk4Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TQ0B6eRV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DA13C4CECE;
	Thu, 26 Sep 2024 06:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727333632;
	bh=LzsrDryHFl9C08XGKSz5W67wXulyuHbJSe/ImatV49o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TQ0B6eRV693E2hfSZuZNUxtnfm6CO2piqDYw6jzBLImP5fqjhhGFAiG1dOhzhplnR
	 MqkPs1BFjcLEgPUdx+GreLQyyjzXWisnvtCtjjesJIKyLgaxxsupnk6X6L29yTj6PV
	 gD9EL/Gw3jRFDRo9KVCfOgBZvGhZ09rqsIr+wbU6ef7RmcG30CUdCJHbq5zfZAzJ+U
	 UMFfyB9Ezf+RiN0YaWla4TstCiqBBpGfkU3TC9e+tqboNrI+Tq8vw63aUN88qa0CRl
	 +CKYXYyq88dS6JEWivP1g34hgrc/0+72+AqxyzD0+kjg292EYPhOoJ8kgSWcE3aiVu
	 meDKj6xHbpX0g==
Date: Thu, 26 Sep 2024 08:53:49 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Yasin Lee <yasin.lee.x@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, yasin.lee.x@outlook.com, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: tyhx,hx9023s: Add performance
 tuning configuration
Message-ID: <mzymeyslfhnxpnmiqtmmavn2tyx4mm67f5oy6m5pw7sogcuqn4@uexouiqfkdeb>
References: <20240926-add-performance-tuning-configuration-v2-0-fdbb654f5767@gmail.com>
 <20240926-add-performance-tuning-configuration-v2-1-fdbb654f5767@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240926-add-performance-tuning-configuration-v2-1-fdbb654f5767@gmail.com>

On Thu, Sep 26, 2024 at 12:40:17AM +0800, Yasin Lee wrote:
> When hardware design introduces significant sensor data noise,
> performance can be improved by adjusting register settings.
> 
> Signed-off-by: Yasin Lee <yasin.lee.x@gmail.com>
> ---
>  .../bindings/iio/proximity/tyhx,hx9023s.yaml          | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.yaml b/Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.yaml
> index 64ce8bc8bd36..0673c40472bd 100644
> --- a/Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.yaml
> +++ b/Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.yaml
> @@ -28,6 +28,18 @@ properties:
>  
>    vdd-supply: true
>  
> +  tyhx,performance-tuning:
> +    description:
> +      Optional, When hardware design introduces significant sensor data noise,
> +      performance can be improved by adjusting register settings, including
> +      but not limited to sample integration time and average sample count.
> +      Performance tuning parameters represented as register address-value pairs.
> +      The array consists of 8-bit values, where each pair represents a register
> +      address followed by the value to be written to that register.
> +    $ref: /schemas/types.yaml#/definitions/uint8-array

I think you wanted here in such case uint8-matrix with one dimension set
to two and other 256 or whatever.

I also wonder why do allow any register to be tuned. To me "tuning"
sounds like improving or tweaking the configuration, so for example I
would not expect to change some control-like registers, e.g. interrupts,
enable/disable, reset etc.


> +    minItems: 2
> +    maxItems: 512
> +
>    "#address-cells":
>      const: 1
>  
> @@ -65,6 +77,13 @@ examples:
>          interrupt-parent = <&pio>;
>          interrupts = <16 IRQ_TYPE_EDGE_FALLING>;
>          vdd-supply = <&pp1800_prox>;
> +        tyhx,performance-tuning = [00 00

This above is clearing entirely the GLOBAL_CTRL0 register, which is not
tuning.

You are basically avoiding hardware description as properties in DT and
just dump a blob.


Best regards,
Krzysztof


