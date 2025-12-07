Return-Path: <linux-iio+bounces-26876-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E924CAB544
	for <lists+linux-iio@lfdr.de>; Sun, 07 Dec 2025 14:22:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 21A0B302D286
	for <lists+linux-iio@lfdr.de>; Sun,  7 Dec 2025 13:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9832690D5;
	Sun,  7 Dec 2025 13:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B3iNKyen"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB983B8D62;
	Sun,  7 Dec 2025 13:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765113736; cv=none; b=UemAM5Z46hMbWcUkiYI3JbE3skwS3bfzY1G8O74Eoa8SaSiQgAwWmSxthqmu5cXhu4a4qDa8nPMaHXoCM6OQSv8HkXldoRtJN6VMdcJ0P4zOR9l14QtrGRe01IYaPB4rq+HnViPgMfIuTCx7iJ/Zs6MFtmvh65eqsYWo5ogLKx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765113736; c=relaxed/simple;
	bh=NkUpwvew5RmRlPhVO+FeBrB1cGUjHqS5fDcZZMBa8fw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rLIfcnNZxHAQBAfFNf/7dx7f+pzu7N9DgclU9+WpTV3sU3ak4srPvp3FdsfRQKKc69cRPlRBw3JQ1XkTZmFMDeePAe5bidrFCt7wO7WfuTMuEu1D0AbiUiwj/nYrTjibgkxDsHo8LD9POx0Q0jDLodGX2mZ3T9zOTDiQfYgioLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B3iNKyen; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12053C4CEFB;
	Sun,  7 Dec 2025 13:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765113735;
	bh=NkUpwvew5RmRlPhVO+FeBrB1cGUjHqS5fDcZZMBa8fw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=B3iNKyennniqYK24IQKg7n67vavntH2pNf/3+vNU+Pr8GVQXli7YFocgNQEA/B4Rj
	 AGlp8gVmREblRcqris2P6Ncp9k+YZE66vPCx6kaP11t8I1PUhzkkasQPu0UK2APzCj
	 ogS34JLRqeA9DZpCv3AYqF/XKcI3GnzuKy8MdSvv0QEoE/7KZvMyhSwYYz36kDbuCA
	 vdT/VoDiv2Q0ng7VJb5DCDzrJK8K+rFblBXiWJNnfYdDiANxlFMeor2gx+v7cV/xPM
	 kYqwIWiDqWDHGEm1b+pTQh2WZSoChhk0zSB1bcerzurETf2v/SCU4lfykH03ntZss6
	 XfaamEqVx1MzQ==
Date: Sun, 7 Dec 2025 13:22:05 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nuno.sa@analog.com>, <dlechner@baylibre.com>, <andy@kernel.org>,
 <Michael.Hennerich@analog.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
 <conor+dt@kernel.org>, <corbet@lwn.net>, <marcelo.schmitt1@gmail.com>,
 Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: iio: adc: Add AD4134
Message-ID: <20251207132205.402f36d4@jic23-huawei>
In-Reply-To: <06d7be2af0f6520c23f612fa0249ff6a26655cb7.1764708608.git.marcelo.schmitt@analog.com>
References: <cover.1764708608.git.marcelo.schmitt@analog.com>
	<06d7be2af0f6520c23f612fa0249ff6a26655cb7.1764708608.git.marcelo.schmitt@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 2 Dec 2025 17:55:03 -0300
Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:

> Add device tree documentation for AD4134 24-Bit, 4-channel simultaneous
> sampling, precision ADC.
> 
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
A few comments inline. Not necessarily anything to change.

Thanks

Jonathan

> ---
> Change log v2 -> v3:
> - fixed typo in powerdown-gpios description.
> - picked up Conor's review tag. 
> 
>  .../bindings/iio/adc/adi,ad4134.yaml          | 198 ++++++++++++++++++
>  MAINTAINERS                                   |   7 +
>  2 files changed, 205 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml
> new file mode 100644
> index 000000000000..69a6ddf6ca92
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml

>
> +allOf:
> +  - if:
> +      not:
> +        required:
> +          - ldoin-supply
> +    then:
> +      required:
> +        - avdd1v8-supply
> +        - dvdd1v8-supply
> +        - clkvdd-supply

Conor gave a tag, so I'm sure this is fine, but could we do this as
a oneOf given it's a pick between two options?

> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        adc@0 {
> +            compatible = "adi,ad4134";
> +            reg = <0>;
> +
> +            spi-max-frequency = <1000000>;
> +
> +            reset-gpios = <&gpio0 86 GPIO_ACTIVE_LOW>;
> +            odr-gpios = <&gpio0 87 GPIO_ACTIVE_HIGH>;
> +            powerdown-gpios = <&gpio0 88 GPIO_ACTIVE_LOW>;
> +
> +            clocks = <&sys_clk>;
> +            clock-names = "clkin";
> +
> +            avdd5-supply = <&avdd5>;
> +            dvdd5-supply = <&dvdd5>;
> +            iovdd-supply = <&iovdd>;
> +            refin-supply = <&refin>;
> +            avdd1v8-supply = <&avdd1v8>;
> +            dvdd1v8-supply = <&dvdd1v8>;
> +            clkvdd-supply = <&clkvdd>;
> +
> +            adi,asrc-mode = "low";
> +            adi,dclkio = "in";
> +            adi,dclkmode = "gated";

Interesting question on whether it is worth adding properties
to examples if they are set to the defaults. Generally we wouldn't
expect actual DT files to set them.  Meh, doesn't matter much to me
either way!

> +
> +            regulators {
> +                vcm_reg: vcm-output {
> +                    regulator-name = "ad4134-vcm";
> +                };
> +            };
> +
> +        };
> +    };
> +...

