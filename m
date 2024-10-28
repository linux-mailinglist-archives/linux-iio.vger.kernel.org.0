Return-Path: <linux-iio+bounces-11431-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1628E9B29E2
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 09:08:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C10AB22264
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 08:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0890F1917EE;
	Mon, 28 Oct 2024 08:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eITFST+e"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45AE17BB34;
	Mon, 28 Oct 2024 08:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730102779; cv=none; b=cPKC2NpyEE+uL5PETBz5OTcToqCsAp+QUhn5xdSkCdNmXeKW6w+yjZ2TdtqdvrbDcz5TPG51Aa6YfNsQKzr2qRYWOAOXLDnC4/R/qXvBz5KwNp+VUAUZt4ZRr8S2tgy63h8Akn1YzNA4LtY/94qs0u8yFoaiK1Ip6TAszrvPVLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730102779; c=relaxed/simple;
	bh=oLOrjxLO4jpqn+/v2u9s6D7B2l4cAsIRB6H7GDg37Dg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ad5irVw8W2A0bc8dAJie0EqtjEDhG9sRI9meCuCXS8pXS36sq+yN+XxC29imm0IIi+fzluAvGB5ywk7MKP/2rMhV3DxMNuo7u5kGUkZvb73PSJ+JPqY07BZ3WUDgjKkY4MbK9thu53mgIDPQrbYuEDdgJxXicJrGLbZth2I57DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eITFST+e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D51CC4CEC3;
	Mon, 28 Oct 2024 08:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730102779;
	bh=oLOrjxLO4jpqn+/v2u9s6D7B2l4cAsIRB6H7GDg37Dg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eITFST+emWawecxJTkcdCJMhNyFxK8c992NF7GI3yRsDNLCY/Zt7ni1GzIm1SNohV
	 kbSCinkP1LZTNPJEv2hdCBIm1hJN+0N7ie89oOaHCgnHSbadKEK02GPrPz4OgSErSF
	 xRKYFn15fL0c+3D9txUYWio8UITcXDdqvOi1tvkUhtTLrD4Lhj4KIzDxYQN/Drw/C0
	 VAQYkPEXmkNQDm6qG4f+9ViFq9jfKsOXsO7TmOkPrRf5O2L2jecsu/GFRxeIS5giiu
	 0hx2War4NcqBFGIXaLxEpM7Naw5IGUu4fIW5LTwQoUywxK0ilTHui1NBpC1WPlrmNa
	 97QzQrMaTDdRg==
Date: Mon, 28 Oct 2024 09:06:14 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: ahaslam@baylibre.com
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, nuno.sa@analog.com, 
	dlechner@baylibre.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] dt-bindings: iio: dac: ad5791: Add required voltage
 supplies
Message-ID: <oy25ajhj7hgg2lk6i2xpkceisoveloc6i6z5sank44jc7i4f6k@xpqgqjpcgn34>
References: <20241028071118.699951-1-ahaslam@baylibre.com>
 <20241028071118.699951-3-ahaslam@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241028071118.699951-3-ahaslam@baylibre.com>

On Mon, Oct 28, 2024 at 08:11:14AM +0100, ahaslam@baylibre.com wrote:
> From: Axel Haslam <ahaslam@baylibre.com>
> 
> Vcc, iovcc, vrefp, and vrefn are needed for the DAC to work.
> Add them as required bindings for ad5791.
> 
> Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
> ---
>  .../bindings/iio/dac/adi,ad5791.yaml          | 24 +++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5791.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5791.yaml
> index fe664378c966..79cb4b78a88a 100644
> --- a/Documentation/devicetree/bindings/iio/dac/adi,ad5791.yaml
> +++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5791.yaml
> @@ -26,6 +26,22 @@ properties:
>    vdd-supply: true
>    vss-supply: true
>  
> +  vcc-supply:
> +    description:
> +      Supply that powers the chip.
> +
> +  iovcc-supply:
> +    description:
> +      Supply for the digital interface.
> +
> +  vrefp-supply:
> +    description:
> +      Positive referance input voltage range. From 5v to (vdd - 2.5)
> +
> +  vrefn-supply:
> +    description:
> +      Negative referance input voltage range. From (vss + 2.5) to 0.
> +
>    adi,rbuf-gain2-en:
>      description: Specify to allow an external amplifier to be connected in a
>        gain of two configuration.
> @@ -47,6 +63,10 @@ required:
>    - reg
>    - vdd-supply
>    - vss-supply
> +  - vcc-supply
> +  - iovcc-supply
> +  - vrefp-supply
> +  - vrefn-supply

So you have six required supplies?

Datasheet says "A voltage range of 2.7 V to 5.5 V *can* be connected",
so doesn't it mean this is optional? Although similar wording is for
other supplies, so maybe it's just imprecise language?

Best regards,
Krzysztof


