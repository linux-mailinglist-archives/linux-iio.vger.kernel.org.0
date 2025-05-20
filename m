Return-Path: <linux-iio+bounces-19726-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51CF8ABCF82
	for <lists+linux-iio@lfdr.de>; Tue, 20 May 2025 08:40:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D12213A4DC9
	for <lists+linux-iio@lfdr.de>; Tue, 20 May 2025 06:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B671F25CC74;
	Tue, 20 May 2025 06:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ICz1u1U4"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691D625C70F;
	Tue, 20 May 2025 06:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747723198; cv=none; b=ByFQASf36E+iMEiWC/O7WNYcs0/jlKflfMWtciyAKTShTuQxOByi6EwNFUQFzub9ewpyfLZqrxTgrW2xeCy3KUx3vYE9lYgoXBi0MOob7OcqOuL2mD+N9QiOR8dabHHW0mdK46ef/8iHYiym1TvBrNKlhHCntqKcXh2KqGxgVrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747723198; c=relaxed/simple;
	bh=EGlTeSB6uRyx77ddElrn0kc7eI9eJYnJgKalNdeLb6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g16aJ9/rWTROJl8zLKwwZNIsK25AD8gKvpKkkKNRC5SukT3qkpGHu0AZlot970+dw845o8ufvq/ncVHRn6MQq/8SJ58atXBEBsmXGcmTDsSAF83MemZi3Y56I70DVvOVG/RoNEHlIqVB3qlhAG9mBmkP4xu48ws14ctQvLKA7Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ICz1u1U4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C65BC4CEE9;
	Tue, 20 May 2025 06:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747723197;
	bh=EGlTeSB6uRyx77ddElrn0kc7eI9eJYnJgKalNdeLb6I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ICz1u1U4YO/Cu9JWreR4lFOc6PIhc7pQ+voH0dXHHIUTUqTiw8IM83wHYosYopr8y
	 GadUjMVtOUnTHmrvUjbMc8nch7IcLwJ3oosVvig/nLTC2/A7H3CjsrY4XSHWVbNWPL
	 j2cHnhPIr3z1oNEDBx0uXQpDoV8oOdLLtpxafoMHJeF1w6ZMPbFEeUmD/HYv5xNIKb
	 LyS2DtRw3OEn929ntvLRiB6UFMNqQu04Tu10rOeEwf9sW5GQmOuGEgeMmRqhHh9d4c
	 /jWUphVmOIAPPKtBkLh70wX0OmJmu5q+/xr+4PprrKmj6LXMN4kUBOlAbBYOHZ37D/
	 isv6jK1KUtNjQ==
Date: Tue, 20 May 2025 08:39:55 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Sergiu Cuciurean <sergiu.cuciurean@analog.com>, Dragos Bogdan <dragos.bogdan@analog.com>, 
	Antoniu Miclaus <antoniu.miclaus@analog.com>, Olivier Moysan <olivier.moysan@foss.st.com>, 
	Javier Carrasco <javier.carrasco.cruz@gmail.com>, Matti Vaittinen <mazziesaccount@gmail.com>, 
	Tobias Sperling <tobias.sperling@softing.com>, Alisa-Dariana Roman <alisadariana@gmail.com>, 
	Marcelo Schmitt <marcelo.schmitt@analog.com>, 
	=?utf-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, Esteban Blanc <eblanc@baylibre.com>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 5/6] dt-bindings: iio: adc: adi-axi-adc: add ad7405
 example
Message-ID: <20250520-brawny-statuesque-rottweiler-9ae801@kuoka>
References: <20250519140220.81489-1-pop.ioan-daniel@analog.com>
 <20250519140220.81489-6-pop.ioan-daniel@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250519140220.81489-6-pop.ioan-daniel@analog.com>

On Mon, May 19, 2025 at 05:02:13PM GMT, Pop Ioan Daniel wrote:
> The ad7405 device is defined as a child of the AXI ADC.

1. Why? What we see easily (although not here, because above does not
answer even to what).
2. I do not see any device being added to the binding.

> 
> Signed-off-by: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
> ---
> changes in v4:
>  - add ad7405 device that is defined as a child of the AXI ADC
>  .../bindings/iio/adc/adi,axi-adc.yaml           | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml b/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
> index cf74f84d6103..a6bc8acd101f 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
> @@ -135,4 +135,21 @@ examples:
>              io-backends = <&parallel_bus_controller>;
>          };
>      };
> +  - |
> +    axi_adc@44a00000 {

Follow DTS coding style.

> +        compatible = "adi,axi-adc-10.0.a";
> +        reg = <0x44a00000 0x10000>;
> +        dmas = <&rx_dma 0>;
> +        dma-names = "rx";
> +        clocks = <&axi_clk>;
> +        #io-backend-cells = <0>;

This example is already there, so I do not get why you duplicate it.
Skip the patch or with reason add the child to the existing example.

> +
> +        adc@0 {
> +            compatible = "adi,ad7405";

Best regards,
Krzysztof


