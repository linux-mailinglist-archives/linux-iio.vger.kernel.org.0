Return-Path: <linux-iio+bounces-11848-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28BA89BA139
	for <lists+linux-iio@lfdr.de>; Sat,  2 Nov 2024 16:33:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F97F1C20CED
	for <lists+linux-iio@lfdr.de>; Sat,  2 Nov 2024 15:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBDFC19F12D;
	Sat,  2 Nov 2024 15:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DftYCHxx"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F28E56446;
	Sat,  2 Nov 2024 15:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730561605; cv=none; b=PmYSow0PUhsiiNHL9PIxR/xg0y38lSaBX1tBgNfVk5xqhXXrzbgZzz9Fg3d5+nB0NdwcCPwNlX1bKGFBjZ6bbDxYHGCfkJTnwspZR+PFh1w5/gv/SFL1msOPNdr6u3OUiAakd/8FkV//Tzx3H+eDp311g0gKbDueyOi+yk9FdUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730561605; c=relaxed/simple;
	bh=sXtLlj7XPZ9pojfaipDxHncUgVCzNZeXs7DpPEH7uaA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mVSMbANmB786LtNVlVxazI8dNJ+hA9+JPTfuVg0x0SJqnByL11pOIXDF1hC6oBh7QR/ZDCJXmRQ+jnyiV1WQh5yMGeSv8bPzUwMZaE+AKcZxpiuF9KACHZsHRuLsgASTEgIjAzkQ2ATGWwzyPQ1Uu1FroTZXJD3jhaE6UFB0NHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DftYCHxx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CA45C4CEC3;
	Sat,  2 Nov 2024 15:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730561605;
	bh=sXtLlj7XPZ9pojfaipDxHncUgVCzNZeXs7DpPEH7uaA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DftYCHxxvD2/qgzBxy/DsKnApVPFWMsQIizGfopUqEasz/EUFbVYiuwEwvzmkrFjD
	 jEkkWYFE96fRoJkT7r7B8EqiLKvICnWKCPuWKr5m9YJ5Ya3EY14DS/Z3f4p55g8m07
	 zarzDnCLgcoln567HOTiFROJtq7dU8rGY1Yf5gO9XEond4cCvR3Nu4nU2rdTvQePcq
	 Pl5otw/QHelQYlDhtOn8wofBoriA0+ddfhEnu3qIXhyKfGIssTHv/JMB/8C0uyvR+0
	 IaWRDY0qb5VJkP6yIl3njuMkDha6458lVM3JP8OGK+HnfYrup3HQBy8NZLSh9AVwGO
	 4INdWXt8SJ6/Q==
Date: Sat, 2 Nov 2024 15:33:15 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, andriy.shevchenko@linux.intel.com,
 anshulusr@gmail.com, gustavograzs@gmail.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/7] dt-bindings: iio: bosch,bme680: Add supply
 properties
Message-ID: <20241102153315.2175fd5b@jic23-huawei>
In-Reply-To: <20241102131311.36210-6-vassilisamir@gmail.com>
References: <20241102131311.36210-1-vassilisamir@gmail.com>
	<20241102131311.36210-6-vassilisamir@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  2 Nov 2024 14:13:09 +0100
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> Extend dt-binding for BME680 gas sensor device. The device incorporates
> as well temperature, pressure and relative humidity sensors.
This description should make it clear it is moving from trivial-devices.yaml

dt-bindings: iio: bosch,bme680: Move from trivial-bindings and add missing supplies.

Then say a little more on why you are moving it.

> 
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>

There was an open question on the previous version about
setting the supplies as required (which I see you've removed).
My understanding previously was that it is fine to make that change
in a binding if it reflects supplies that are required to be enabled
for the device to function at all.  If there were previously missing
that's a binding bug we should fix.

I'd like a clarification from the DT binding maintainers on that.
Obviously doesn't work for other users of dt bindings but in
Linux this would be fine as they were already on for any board
that worked and the regulator framework will through us a fake
regulator for cases like this.

https://lore.kernel.org/all/20241022182451.00007ac0@Huawei.com/

Jonathan

https://lore.kernel.org/all/20241022182451.00007ac0@Huawei.com/

> ---
>  .../bindings/iio/chemical/bosch,bme680.yaml   | 62 +++++++++++++++++++
>  .../devicetree/bindings/trivial-devices.yaml  |  2 -
>  2 files changed, 62 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/chemical/bosch,bme680.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/chemical/bosch,bme680.yaml b/Documentation/devicetree/bindings/iio/chemical/bosch,bme680.yaml
> new file mode 100644
> index 000000000000..0eac22e465e7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/chemical/bosch,bme680.yaml
> @@ -0,0 +1,62 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/chemical/bosch,bme680.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Bosch BME680 Gas sensor
> +
> +maintainers:
> +  - Vasileios Amoiridis <vassilisamir@gmail.com>
> +
> +description: >
> +  BME680 is a gas sensor which combines relative humidity, barometric pressure,
> +  ambient temperature and gas (VOC - Volatile Organic Compounds) measurements.
> +
> +  https://www.bosch-sensortec.com/media/boschsensortec/downloads/datasheets/bst-bme680-ds001.pdf
> +
> +properties:
> +  compatible:
> +    const: bosch,bme680
> +
> +  reg:
> +    maxItems: 1
> +
> +  vdd-supply: true
> +  vddio-supply: true
> +
> +required:
> +  - compatible
> +  - reg
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        bme680@77 {
> +            compatible = "bosch,bme680";
> +            reg = <0x77>;
> +            vddio-supply = <&vddio>;
> +            vdd-supply = <&vdd>;
> +        };
> +    };
> +  - |
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        bme680@0 {
> +            compatible = "bosch,bme680";
> +            reg = <0>;
> +            spi-max-frequency = <500000>;
> +            vddio-supply = <&vddio>;
> +            vdd-supply = <&vdd>;
> +        };
> +    };
> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
> index 9bf0fb17a05e..b651826e2d21 100644
> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> @@ -55,8 +55,6 @@ properties:
>            - atmel,atsha204a
>              # BPA-RS600: Power Supply
>            - blutek,bpa-rs600
> -            # Bosch Sensortec pressure, temperature, humididty and VOC sensor
> -          - bosch,bme680
>              # CM32181: Ambient Light Sensor
>            - capella,cm32181
>              # CM3232: Ambient Light Sensor


