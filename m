Return-Path: <linux-iio+bounces-343-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F78E7F8BE1
	for <lists+linux-iio@lfdr.de>; Sat, 25 Nov 2023 15:55:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 158D61C20D53
	for <lists+linux-iio@lfdr.de>; Sat, 25 Nov 2023 14:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B08B28DB8;
	Sat, 25 Nov 2023 14:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PCSJWuut"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15115D512;
	Sat, 25 Nov 2023 14:55:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A42FC433C8;
	Sat, 25 Nov 2023 14:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700924143;
	bh=Kt+En3ByTbMKWX9m7Y7Co3cJpFE72qRdUomvIpJtRw4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PCSJWuuto2hezNuloMLhCQ9A62N/2UG/SMk3GCYG62sSKt65WA6D18P5+b47ulnKw
	 k7PbKsCHfPiDMWzsf+h/icroV8LNoMBeYuHNoVZZluxmmIeuOv4wPNbahjq4CtOs6N
	 siF1Ov7WXZVcjpBLN5YL+PvHyH5NvD0oq7jNCNnSoxV7F+RJIvkkgTGFCl8kCTBXEl
	 oP/rlquIq/4Nm+Ko6cAk5eFLKBy4tZND+SscFdUB7MC5ODq4yegxYA5pOcLlVbf6Vb
	 vFmIQldIpVW6SS9B+Y9YHL5z2kXMAahH2VKcqe3ww4ETdYbZYfPIVM2ga2WkSDo9w5
	 h4JTCewkNcYdQ==
Date: Sat, 25 Nov 2023 14:55:35 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: 579lpy@gmail.com
Cc: lars@metafoo.de, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/2] dt-bindings: iio: humidity: Add TI HDC302x
 support
Message-ID: <20231125145535.2c897fd9@jic23-huawei>
In-Reply-To: <20231125102749.2876-1-579lpy@gmail.com>
References: <20231125102221.2795-1-579lpy@gmail.com>
	<20231125102749.2876-1-579lpy@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 25 Nov 2023 18:27:49 +0800
579lpy@gmail.com wrote:

> From: Li peiyu <579lpy@gmail.com>
> 
> Add device tree bindings for HDC3020/HDC3021/HDC3022 humidity and
> temperature sensors.
> 
> Signed-off-by: Li peiyu <579lpy@gmail.com>
> ---
> changes for v3:
> - Use a fallback compatible
> changes for v2:
> - change the maintainers to me.
> - hdc3020,hdc3021,hdc3022 are compatible,I've changed the dirver.
> - change the node name to humidity-sensor.
> 
>  .../bindings/iio/humidity/ti,hdc3020.yaml     | 63 +++++++++++++++++++
>  1 file changed, 63 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/humidity/ti,hdc3020.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/humidity/ti,hdc3020.yaml b/Documentation/devicetree/bindings/iio/humidity/ti,hdc3020.yaml
> new file mode 100644
> index 000000000000..08080bb9cd75
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/humidity/ti,hdc3020.yaml
> @@ -0,0 +1,63 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/humidity/ti,hdc3020.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: HDC3020/HDC3021/HDC3022 humidity and temperature iio sensors
> +
> +maintainers:
> +  - Li peiyu <579lpy@gmail.com>
> +
> +description:
> +  https://www.ti.com/lit/ds/symlink/hdc3020.pdf
> +
> +  The HDC302x is an integrated capacitive based relative humidity (RH)
> +  and temperature sensor.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - ti,hdc3021
> +              - ti,hdc3022
> +          - const: ti,hdc3020
> +      - items:
> +          - const: ti,hdc3020
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  vdd-supply: true
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
Convention is to have power supplies that must be turned on in the
required even if you can have them supplied via stub regulators if they
aren't specified. This separates them from supplies that are really optional
such as optional reference supplies where there is an alternative internal
reference generator.

> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        humidity-sensor@47 {
> +            compatible = "ti,hdc3020";
> +            reg = <0x47>;
> +        };
> +    };
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        humidity-sensor@47 {
> +            compatible = "ti,hdc3021", "ti,hdc3020";
I'd just keep this one as an example. Good that you tested both, but now
we don't need two examples.  Also provide the vdd-supply.

Ideally I'd like the driver to turn it on with a devm_regulator_get_enable() call
as those are so simple, I'm not worried about if you've been able to test that or not.

> +            reg = <0x47>;
> +        };
> +    };


