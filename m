Return-Path: <linux-iio+bounces-3963-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81701893BB5
	for <lists+linux-iio@lfdr.de>; Mon,  1 Apr 2024 16:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A1ED1F21224
	for <lists+linux-iio@lfdr.de>; Mon,  1 Apr 2024 14:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3285B3FE52;
	Mon,  1 Apr 2024 14:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BlB1HkG8"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33098BF0;
	Mon,  1 Apr 2024 14:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711980130; cv=none; b=elTSlDLi7BVxod4EB8Ae4e1ax2m0l4eAwqX8vhAwIZAKJOhAyxN7wlw1zcnKWxlVKvaxOzIjI/5Cg/ESBZJbDCdsGYz2n7XLt5/5YIxCAAAKHpV9B/tG7/08rvq0e5jxMp5rQw+SCprsB9rvazczT8Dq/hlu0EI9gXns55Ul4WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711980130; c=relaxed/simple;
	bh=KL9VJZme0DHIxfzxC50Ri0kz+SdP7JpKJohNJpF0YJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m3RikMfyVYpTmk6dedrvYGE9YTbozIesEsl1u58tRIIOhv40Ev4SSzQzgjqe5U/wHoOfdlrQMJkThfexA5QZ+osqnLXMUQx+lAX1/3TIahUcIjOiTG7hPGhcgcq817rCKdwiUpCp7dYrHsaIDsiTe8b1uRj8EIvA9HPdlrqNU3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BlB1HkG8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A6BCC433C7;
	Mon,  1 Apr 2024 14:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711980129;
	bh=KL9VJZme0DHIxfzxC50Ri0kz+SdP7JpKJohNJpF0YJQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BlB1HkG8XoDapjJQg5R4ahspJ0sz/Q7QTVofP1XuuMySaEeD5haE0yn4l2AmFWhOf
	 6274XQFFuqPEPcc1OyISQXyoSPlnV6mljWsl0c/tH0QLWWKjVVOjo1uPNqJhaIEHoL
	 sk8olfvb6g5paksOjfElVB27+EhjZDwqm0opYHE7BsW0ZAKVNme9fNhOUBocip+iln
	 vsGTGi3rEub152QbIHu4eT8m7JxpiRorzfE+PTyLrwro78Xk4CdNSRfoFu9wWfOFtf
	 0+VwFJ0dGnAsfuUBW+1laSu6HMNAJIFkzo9Kkn50NCPlYll0l+Tr5NI3dy+kgm+uH7
	 zZXNKOZ7kT/mA==
Date: Mon, 1 Apr 2024 09:02:07 -0500
From: Rob Herring <robh@kernel.org>
To: Nuno Sa <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	Dragos Bogdan <dragos.bogdan@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Olivier Moysan <olivier.moysan@foss.st.com>
Subject: Re: [PATCH 07/10] dt-bindings: iio: dac: add bindings doc for AD9739A
Message-ID: <20240401140207.GA353303-robh@kernel.org>
References: <20240328-iio-backend-axi-dac-v1-0-afc808b3fde3@analog.com>
 <20240328-iio-backend-axi-dac-v1-7-afc808b3fde3@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328-iio-backend-axi-dac-v1-7-afc808b3fde3@analog.com>

On Thu, Mar 28, 2024 at 02:22:31PM +0100, Nuno Sa wrote:
> This adds the bindings documentation for the 14 bit
> RF Digital-to-Analog converter.

Reword the subject to say 'bindings' only once.

> 
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> ---
>  .../devicetree/bindings/iio/dac/adi,ad9739a.yaml   | 88 ++++++++++++++++++++++
>  MAINTAINERS                                        |  8 ++
>  2 files changed, 96 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad9739a.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad9739a.yaml
> new file mode 100644
> index 000000000000..24bcec763a9b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/dac/adi,ad9739a.yaml
> @@ -0,0 +1,88 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/dac/adi,ad9739a.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AD9739A RF DAC
> +
> +maintainers:
> +  - Dragos Bogdan <dragos.bogdan@analog.com>
> +  - Nuno Sa <nuno.sa@analog.com>
> +
> +description: |
> +  The AD9739A is a 14-bit, 2.5 GSPS high performance RF DACs that are capable
> +  of synthesizing wideband signals from dc up to 3 GHz.
> +
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ad9737a_9739a.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ad9739a
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  reset-gpios:
> +    maxItems: 1
> +
> +  vdd_3_3-supply:

vdd-3-3-supply or vdd-3p3-supply

> +    description: 3.3V Digital input supply.
> +
> +  vdd-supply:
> +    description: 1.8V Digital input supply.
> +
> +  vdda-supply:
> +    description: 3.3V Analog input supply.
> +
> +  vddc-supply:
> +    description: 1.8V Clock input supply.
> +
> +  io-backends:
> +    maxItems: 1
> +
> +  adi,full-scale-microamp:
> +    description: This property represents the DAC full scale current.
> +    minimum: 8700
> +    maximum: 31700
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - io-backends
> +  - vdd_3_3-supply
> +  - vdd-supply
> +  - vdda-supply
> +  - vddc-supply
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        dac@0 {
> +            compatible = "adi,ad9739a";
> +            reg = <0>;
> +
> +            clocks = <&dac_clk>;
> +
> +            io-backends = <&iio_backend>;
> +
> +            vdd_3_3-supply = <&vdd_3_3>;
> +            vdd-supply = <&vdd>;
> +            vdda-supply = <&vdd_3_3>;
> +            vddc-supply = <&vdd>;
> +        };
> +    };
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2137eb452376..76e872e320d7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1234,6 +1234,14 @@ W:	https://ez.analog.com/linux-software-drivers
>  F:	Documentation/devicetree/bindings/iio/adc/adi,ad7780.yaml
>  F:	drivers/iio/adc/ad7780.c
>  
> +ANALOG DEVICES INC AD9739a DRIVER
> +M:	Nuno Sa <nuno.sa@analog.com>
> +M:	Dragos Bogdan <dragos.bogdan@analog.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Supported
> +W:	https://ez.analog.com/linux-software-drivers
> +F:	Documentation/devicetree/bindings/iio/dac/adi,ad9739a.yaml
> +
>  ANALOG DEVICES INC ADA4250 DRIVER
>  M:	Antoniu Miclaus <antoniu.miclaus@analog.com>
>  L:	linux-iio@vger.kernel.org
> 
> -- 
> 2.44.0
> 

