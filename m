Return-Path: <linux-iio+bounces-9865-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD269894E3
	for <lists+linux-iio@lfdr.de>; Sun, 29 Sep 2024 12:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 610641C215E5
	for <lists+linux-iio@lfdr.de>; Sun, 29 Sep 2024 10:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1C415B108;
	Sun, 29 Sep 2024 10:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bqffkAEM"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10AE813A878;
	Sun, 29 Sep 2024 10:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727607120; cv=none; b=V9uJpEQ/mmJbQJRATYh+cnPeOry0HsC/TXfhi0X+aMon85bCUkCjRSVy2/fHDGxJOlZSd2RUFHQ+yHwbupMyvC1W3l5y413nxPYGdrIkzzPaHLmQGTJ3vC9zfWsAq4LlAyeEsUA808bR1jfmerwa0k3E63AnEg26spfjRO3Hbbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727607120; c=relaxed/simple;
	bh=W2VIIbTK72xMf1IVwA07QupuewDLSJU1I75NKD5Q/bI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vim26tpuo0/aL5Os7dEDmZ///CVX5xrnvB11BpkqJiB//NAmswIhjCqiZJ6JGqH6rIdSmrjPLF+aYKiAXG0X64OY94wumogCCpgolQzCTeT6ckocqQ4NyHDL2YBC19J0KTfj5Zqzu2W9wSDSXaeIwsJTyuDwKIFMLlMRd8rY21k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bqffkAEM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB67BC4CEC5;
	Sun, 29 Sep 2024 10:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727607119;
	bh=W2VIIbTK72xMf1IVwA07QupuewDLSJU1I75NKD5Q/bI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bqffkAEM3w+hF9k0kHNx35Jx0cEb4wOVepFu9Iz8XJ8CbMXTgTJK/4BrrhzIXFwdx
	 VZZ0DODFsAR+7061eKiJY8haLPHInqzDlRo4J4h9XaqY0BSiQaYy1B9pd+4bUfNTSi
	 Y5+m0M0gWGh7Pw5Ze50Kpn9WRXIiLSsgU4TKXYP3VPy4s8lKawif1LkQE6BWURKbkl
	 58MpyXAb10K2okFay4oydGAisHKLbBcmvlUTd2rTnYDWpcg3WKGLhTi6K2c3KvJCWb
	 Ywr5mdDxjHzoa24652qRfJgIEzw+Cd7eo+WSGp8pVgiZMLA4AJcTum5QqYcT0L3xLc
	 B8+FD2+72T/nA==
Date: Sun, 29 Sep 2024 11:51:50 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, dlechner@baylibre.com
Subject: Re: [PATCH v3 04/10] dt-bindings: iio: dac: ad3552r: add io-backend
 support
Message-ID: <20240929115150.6d1c22b3@jic23-huawei>
In-Reply-To: <20240919-wip-bl-ad3552r-axi-v0-iio-testing-v3-4-a17b9b3d05d9@baylibre.com>
References: <20240919-wip-bl-ad3552r-axi-v0-iio-testing-v3-0-a17b9b3d05d9@baylibre.com>
	<20240919-wip-bl-ad3552r-axi-v0-iio-testing-v3-4-a17b9b3d05d9@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 19 Sep 2024 11:20:00 +0200
Angelo Dureghello <adureghello@baylibre.com> wrote:

> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> There is a version AXI DAC IP block (for FPGAs) that provides
> a physical bus for AD3552R and similar chips, and acts as
> an SPI controller.

Wrap is a bit short. Aim for < 75 chars for patch descriptions.

> 
> For this case, the binding is modified to include some
> additional properties.
> 
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> ---
>  .../devicetree/bindings/iio/dac/adi,ad3552r.yaml   | 42 ++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
> index 41fe00034742..aca4a41c2633 100644
> --- a/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
> +++ b/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
> @@ -60,6 +60,18 @@ properties:
>      $ref: /schemas/types.yaml#/definitions/uint32
>      enum: [0, 1, 2, 3]
>  
> +  io-backends:
> +    description: The iio backend reference.

Give a description of what the backend does in this case.  I.e. that it is
a qspi DDR backend with ...

> +      An example backend can be found at
> +        https://analogdevicesinc.github.io/hdl/library/axi_ad3552r/index.html
> +    maxItems: 1
> +
> +  adi,synchronous-mode:
> +    description: Enable waiting for external synchronization signal.
> +      Some AXI IP configuration can implement a dual-IP layout, with internal
> +      wirings for streaming synchronization.

I've no idea what a dual-IP layout is.  Can you provide a little more info
here?  What are the two IPs?

> +    type: boolean
> +
>    '#address-cells':
>      const: 1
>  
> @@ -128,6 +140,7 @@ patternProperties:
>            - custom-output-range-config
>  
>  allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
>    - if:
>        properties:
>          compatible:
> @@ -238,4 +251,33 @@ examples:
>              };
>          };
>      };
> +
> +  - |
> +    axi_dac: spi@44a70000 {
> +        compatible = "adi,axi-ad3552r";
> +        reg = <0x44a70000 0x1000>;
> +        dmas = <&dac_tx_dma 0>;
> +        dma-names = "tx";
> +        #io-backend-cells = <0>;
> +        clocks = <&ref_clk>;
> +
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        dac@0 {
> +            compatible = "adi,ad3552r";
> +            reg = <0>;
> +            reset-gpios = <&gpio0 92 0>;
> +            io-backends = <&axi_dac>;
> +            spi-max-frequency = <66000000>;
> +
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            channel@0 {
> +                reg = <0>;
> +                adi,output-range-microvolt = <(-10000000) (10000000)>;
> +            };
> +        };
> +    };
>  ...
> 


