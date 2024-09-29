Return-Path: <linux-iio+bounces-9863-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C349894DA
	for <lists+linux-iio@lfdr.de>; Sun, 29 Sep 2024 12:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B9931C21EB5
	for <lists+linux-iio@lfdr.de>; Sun, 29 Sep 2024 10:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746BD157465;
	Sun, 29 Sep 2024 10:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MvKtvp9g"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2586A3D96D;
	Sun, 29 Sep 2024 10:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727606778; cv=none; b=d9qDFOKboA+eXHgIsTgATre7pyvlZXBaEWC7QxB43LkVJG8jTa01MQp2RFMdnDbWG2WHUDZZYk4CF4XrTwek+pZ/jTpSvn16N/14h5FydMVuL5iJ7HIb6HE9Hh+s/v7AJQtuSUvKovVZsc4nYUTIMlMCYTYB/nUV4gYLUv3daww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727606778; c=relaxed/simple;
	bh=hntgGK3sMevf+qeRjWC++r7wHMhMKpbwCR+qn4UMyrw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HDbBcR1pB7vFJajsxhqc3UysRmaLNrdGBpbnAbNNlz8578+zFvsJ/N2Ju5ipxj3TL5tx6NnEIZR1iqj93JUjaAXTeHTjZjX9Ctv2pwJSGpJR1gNlAKecLN6ckLmpl5HSoH1ublv0yWrPMxzQgVtDikAosNqaYqi4vU7MQYq4RDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MvKtvp9g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E9B7C4CEC5;
	Sun, 29 Sep 2024 10:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727606777;
	bh=hntgGK3sMevf+qeRjWC++r7wHMhMKpbwCR+qn4UMyrw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MvKtvp9g/64IcPbCSCBesoOzFdgcscx4uoB6XwoEcGAArn1B9kMQ6PdUyjsnkCGnT
	 iCe52/Ea4Job4qy9l5zvPQz7H2sWI+2d6EO3LmVh41j1FAU2Cj9Fn6hngbZ+aB96J/
	 5OBus+kMM5Zk5kOW6jHAx9txtXZUe+KNj1jcpLfzDd82xl6qpbhXgvT3wUXsfewylI
	 tMOvKVtm6aGeqlbCejH0nm5PMM8EOP5vb6IpC+QBzaOSssuXi5qrrdf99ACNeIsWuL
	 xSLRQ7FcHDA71RDk5aMBDoK65YwS9rn/NfDCL+0lbxbmOeIwMmMcatrf/rKAtb8STy
	 eKkG34Q08PuWg==
Date: Sun, 29 Sep 2024 11:46:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, dlechner@baylibre.com, Mark Brown
 <broonie@kernel.org>, linux-spi@vger.kernel.org
Subject: Re: [PATCH v3 02/10] dt-bindings: iio: dac: axi-dac: add ad3552r
 axi variant
Message-ID: <20240929114606.7500ba7e@jic23-huawei>
In-Reply-To: <20240919-wip-bl-ad3552r-axi-v0-iio-testing-v3-2-a17b9b3d05d9@baylibre.com>
References: <20240919-wip-bl-ad3552r-axi-v0-iio-testing-v3-0-a17b9b3d05d9@baylibre.com>
	<20240919-wip-bl-ad3552r-axi-v0-iio-testing-v3-2-a17b9b3d05d9@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 19 Sep 2024 11:19:58 +0200
Angelo Dureghello <adureghello@baylibre.com> wrote:

> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> Add a new compatible and related bindigns for the fpga-based
> "ad3552r" AXI IP core, a variant of the generic AXI DAC IP.
> 
> The AXI "ad3552r" IP is a very similar HDL (fpga) variant of the
> generic AXI "DAC" IP, intended to control ad3552r and similar chips,
> mainly to reach high speed transfer rates using an additional QSPI

I'd drop the word additional as I assume it is an 'either/or' situation
for the interfaces.

Do we have other devices using this same IP?  I.e. does it make
sense to provide a more generic compatible as a fallback for this one
so that other devices would work without the need for explicit support?


I'd also ideally like a view point from Mark Brown as SPI maintainer
on how we should deal with this highly specialized spi controller.
Is he happy with us using an SPI like binding but not figuring out how
to fit this engine into the SPI subsystem.

Please +CC Mark and the spi list (done here) on future versions + provide
a clear description of what is going on for them.

Maybe with the binding fixed as spi compliant, we can figure out the
if we eventually want to treat this as an SPI controller from the
kernel driver point of view even if we initially do something 'special'.

Jonathan


> DDR interface.
> 
> The ad3552r device is defined as a child of the AXI DAC, that in
> this case is acting as an SPI controller.
> 
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> ---
>  .../devicetree/bindings/iio/dac/adi,axi-dac.yaml   | 40 ++++++++++++++++++++--
>  1 file changed, 37 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml b/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml
> index a55e9bfc66d7..6cf0c2cb84e7 100644
> --- a/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml
> +++ b/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml
> @@ -19,11 +19,13 @@ description: |
>    memory via DMA into the DAC.
>  
>    https://wiki.analog.com/resources/fpga/docs/axi_dac_ip
> +  https://analogdevicesinc.github.io/hdl/library/axi_ad3552r/index.html
>  
>  properties:
>    compatible:
>      enum:
>        - adi,axi-dac-9.1.b
> +      - adi,axi-ad3552r
>  
>    reg:
>      maxItems: 1
> @@ -41,22 +43,54 @@ properties:
>    '#io-backend-cells':
>      const: 0
>  
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
>  required:
>    - compatible
>    - dmas
>    - reg
>    - clocks
>  
> +patternProperties:
> +  "^.*@([0-9])$":
> +    type: object
> +    additionalProperties: true
> +    properties:
> +      io-backends:
> +        description: |
> +          AXI backend reference
> +    required:
> +      - io-backends
> +
>  additionalProperties: false
>  
>  examples:
>    - |
>      dac@44a00000 {
> -        compatible = "adi,axi-dac-9.1.b";
> -        reg = <0x44a00000 0x10000>;
> -        dmas = <&tx_dma 0>;
> +      compatible = "adi,axi-dac-9.1.b";
> +      reg = <0x44a00000 0x10000>;
> +      dmas = <&tx_dma 0>;

If it makes sense to reformat then separate patch
please as this is hard to read as a result of this
change.  Also, as pointed out, be consistent with spacing.

> +      dma-names = "tx";
> +      #io-backend-cells = <0>;
> +      clocks = <&axi_clk>;
> +    };
> +
> +  - |
> +    axi_dac: spi@44a70000 {
> +        compatible = "adi,axi-ad3552r";
> +        reg = <0x44a70000 0x1000>;
> +        dmas = <&dac_tx_dma 0>;
>          dma-names = "tx";
>          #io-backend-cells = <0>;
>          clocks = <&axi_clk>;
> +
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        /* DAC devices */
>      };
>  ...
> 


