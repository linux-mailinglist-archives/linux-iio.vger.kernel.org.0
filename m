Return-Path: <linux-iio+bounces-27708-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 446E5D1D4E8
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 09:59:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 05DD2306162C
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 08:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC813815C5;
	Wed, 14 Jan 2026 08:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sUY6FxWf"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF7C37F102;
	Wed, 14 Jan 2026 08:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768381079; cv=none; b=UNEOrvc0K8p4AyJQ+gUOm4XEcWMwgREb0kVImoyprMStIsD/yPfYkIaTXkn5JXqvzueLyQ3+f++u6FuAwLHwdqpBKgMc4mECj8Tie7oUXO4JctyHo/1dwWWmXwPOWcQg2OZJVB9ZGg3GgIiNmByMoaVPzZdYXYAYsLTko6NjjsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768381079; c=relaxed/simple;
	bh=WWJf+54MxE46DE9/OPvDJcvnLYSe4vAHk2WGR5k5PcE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i9jLMWdOdmTvOI64ZcmyUBvj7SrGNpmapzRa6coogxdsKP33E44ERpzA2U0SLp7aTchqXOh06gs8jKb/WYC6DPCHir7HNltzl8Jx5AvYCH5Wpdj3NpurTzpyxo2IVgwShsPTiWCkxD9Sv/keDZO+k4wcQYGyjLYJGtMuARxnZ2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sUY6FxWf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA100C19423;
	Wed, 14 Jan 2026 08:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768381078;
	bh=WWJf+54MxE46DE9/OPvDJcvnLYSe4vAHk2WGR5k5PcE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sUY6FxWfr3a+td/KoTJz9Z1lQz1NY0kIowE+9h12lJ6kuVksBiD42Z3QfbhBkxV7b
	 ikzce3BcKPI7wYB7OFDTSnsncq2YAW/Hf4jeGtmz6++WBXFw5zVBmuVCXwhPjRG2UI
	 M81XC/aelGJh/7/GkZma6yNoX/l2vFtwEnk4Jir4BafOmsekHK/gQWK2V0F3mW1cb5
	 L3lkyd2NWplsn1DkeQaHnwjsz7ig4qipaf8rg1XDFKyoSsdnUuu2JYmZ3LEY6dBDiy
	 p1TiRVin6U3oUbPmQyxVTQKJtj+ccEr9j7Bq3bYizdZT1UUaNZuTEn1ZyapfaEfbhK
	 GkoL55WlM9uiA==
Date: Wed, 14 Jan 2026 08:57:47 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Michael Hennerich <michael.hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Sean Anderson
 <sean.anderson@linux.dev>, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH v5 2/9] spi: dt-bindings: add spi-{tx,rx}-lane-map
 properties
Message-ID: <20260114085747.4c3ec953@jic23-huawei>
In-Reply-To: <20260112-spi-add-multi-bus-support-v5-2-295f4f09f6ba@baylibre.com>
References: <20260112-spi-add-multi-bus-support-v5-0-295f4f09f6ba@baylibre.com>
	<20260112-spi-add-multi-bus-support-v5-2-295f4f09f6ba@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 Jan 2026 11:45:20 -0600
David Lechner <dlechner@baylibre.com> wrote:

> Add spi-tx-lane-map and spi-rx-lane-map properties to the SPI peripheral
> device tree binding. These properties allow specifying the mapping of
> peripheral data lanes to controller data lanes. This is needed e.g. when
> some lanes are skipped on the controller side so that the controller
> can correctly route data to/from the peripheral.
> 
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
LGTM
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> ---
> 
> v5 changes:
> - Use SDI/SDO terminology in descriptions. (Fixes incorrect use of TX/RX
>   when describing the peripheral lanes.)
> 
> v4 changes:
> - This replaces the data-lanes property from the previous revision. Now
>   there are separate properties for tx and rx lane maps. And instead of
>   being the primary property for determining the number of lanes, this
>   is only needed in special cases where the mapping is non-trivial.
> ---
>  .../devicetree/bindings/spi/spi-peripheral-props.yaml      | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> index 59ddead7da14..880a9f624566 100644
> --- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> +++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> @@ -75,6 +75,13 @@ properties:
>        enum: [0, 1, 2, 4, 8]
>      default: [1]
>  
> +  spi-rx-lane-map:
> +    description: Mapping of peripheral SDO lanes to controller SDI lanes.
> +      Each index in the array represents a peripheral SDO lane, and the value
> +      at that index represents the corresponding controller SDI lane.
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    default: [0, 1, 2, 3, 4, 5, 6, 7]
> +
>    spi-rx-delay-us:
>      description:
>        Delay, in microseconds, after a read transfer.
> @@ -99,6 +106,13 @@ properties:
>        enum: [0, 1, 2, 4, 8]
>      default: [1]
>  
> +  spi-tx-lane-map:
> +    description: Mapping of peripheral SDI lanes to controller SDO lanes.
> +      Each index in the array represents a peripheral SDI lane, and the value
> +      at that index represents the corresponding controller SDO lane.
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    default: [0, 1, 2, 3, 4, 5, 6, 7]
> +
>    spi-tx-delay-us:
>      description:
>        Delay, in microseconds, after a write transfer.
> 


