Return-Path: <linux-iio+bounces-404-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C327F9497
	for <lists+linux-iio@lfdr.de>; Sun, 26 Nov 2023 18:30:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F57A1C20B2F
	for <lists+linux-iio@lfdr.de>; Sun, 26 Nov 2023 17:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C86CDF69;
	Sun, 26 Nov 2023 17:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qYz3M403"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E406846A2;
	Sun, 26 Nov 2023 17:30:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52783C433C7;
	Sun, 26 Nov 2023 17:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701019810;
	bh=8ojV6a7cA9LYv/jr195EjbCuO3ivVg0awU0eg229aNI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qYz3M403eaUTi/hMjdpYXhdNYCNb5yjIPB3zQQdo5E8BaOBKrnaS1wIYN47e3De9O
	 /KToXdsYSF6P+RY3Rcx50jgCbrFsdkdRhGwRMkEkjUHbTg9LU499lCaZTWv2sN0llK
	 ohDzK856p14I8nseZEFqyVOQx/Z2SAkWVHmHpuAkCPlBSBle7ZXBystWWT5ac7+x+P
	 bllmXWNG+hrbPGc6yHy/5qzi+pZd7PZfgSyegv8LyXgrgbfLg4xKqWGb7wsxWAKAJs
	 yK6AV7Cuh9Y41aZUUcF9JS4b/fttd7BVohRrp/T6ghN4rJbOYqja2EchnOLXx9SYgk
	 tSP0hOUpYy24Q==
Date: Sun, 26 Nov 2023 17:30:02 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Abdel Alkuor <alkuor@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: temperature: Add AMS AS6200
Message-ID: <20231126173002.3783271f@jic23-huawei>
In-Reply-To: <7e108db19cd9ad19b6413f65099280c010325a91.1699740057.git.alkuor@gmail.com>
References: <7e108db19cd9ad19b6413f65099280c010325a91.1699740057.git.alkuor@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 11 Nov 2023 17:05:01 -0500
Abdel Alkuor <alkuor@gmail.com> wrote:

> as6200 is high accuracy temperature sensor of -/+ 0.4C degree
> with a range between -40C to 125C degrees
> 
Hi Abdel,

Welcome to IIO.  Just one comment on specifying power supplies below.

Jonathan


> Signed-off-by: Abdel Alkuor <alkuor@gmail.com>
> ---
>  .../bindings/iio/temperature/ams,as6200.yaml  | 45 +++++++++++++++++++
>  1 file changed, 45 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/temperature/ams,as6200.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/temperature/ams,as6200.yaml b/Documentation/devicetree/bindings/iio/temperature/ams,as6200.yaml
> new file mode 100644
> index 000000000000..97a73b92a789
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/temperature/ams,as6200.yaml
> @@ -0,0 +1,45 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/temperature/ams,as6200.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: AMS AS6200 Temperature Sensor
> +
> +maintainers:
> +  - Abdel Alkuor <alkuor@gmail.com>
> +
> +description: |
> +  https://ams.com/documents/20143/36005/AS6200_DS000449_4-00.pdf
> +
> +properties:
> +  compatible:
> +    const: ams,as6200
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1

I'd like to see
vdd-supply: true
and it added to teh required list.

The device needs power. Note there is
a devm_regulator_get_enable() function that can then be used in the driver to turn
on any regulator specified in DT which will provide a stub regulator if there isn't
one (not unusual if a fixed power supply is used that is always on).

> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        temperature-sensor@48 {
> +            compatible = "ams,as6200";
> +            reg = <0x48>;
> +            interrupt-parent = <&gpio1>;
> +            interrupts = <17 IRQ_TYPE_EDGE_BOTH>;
> +        };
> +    };
> +...


