Return-Path: <linux-iio+bounces-10932-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FCA79AA369
	for <lists+linux-iio@lfdr.de>; Tue, 22 Oct 2024 15:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFEC5283EF3
	for <lists+linux-iio@lfdr.de>; Tue, 22 Oct 2024 13:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9C119F133;
	Tue, 22 Oct 2024 13:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eWdZIp4w"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650FD19EED3;
	Tue, 22 Oct 2024 13:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729604464; cv=none; b=X87XAo+8PyWL4hpcAMB986S+YXS/W79D2kkfjuTpJ2FZgkxp/ZdNKMxzqyzPq0GIMigAIOAihOPhJUGoqb/rDkU0FtGCVqE4KflKIAw4UudmdobeYekwbNLswLBPfbEP8CPoTx22e2PaVOqWCJPd2rw9/5l8jzkk7qRgJNNH7i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729604464; c=relaxed/simple;
	bh=QqlugLdFG9Y5oU8kGv0o9veX7/mlOyMr4C2DHWI7ZKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gPnoH+96Z9bpcQuabxbKtlC1f2C12ShMHab0RjZ/gy9D8gixJ+2B1zqgsOVY7tiYLj8Hx0OKfNnzJYZ9wUniGAFqcDFIeOm36uW1A1gBLCojigfOj5BQl1PN51iEVhGyGzySxBfNi4ScXHGkc0Typz/OB5/yvrb+q60Vyl5Su9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eWdZIp4w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C362EC4CEC7;
	Tue, 22 Oct 2024 13:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729604463;
	bh=QqlugLdFG9Y5oU8kGv0o9veX7/mlOyMr4C2DHWI7ZKc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eWdZIp4wDgEUxXWDBNPGl9ajQjc5KpqUhiBTaYMzy2lha3vZ7TQNQJmFtGAuK0dj/
	 oly0FERWDT2IV18br2bAyS65BNEUl9/gZdIZPNUc5qnZdpWvE5GsWbYD1d4zlecnmy
	 H5Umn0YdwALjO8U/PG2+9ikzXxyogoDrX5HxpByrtJial2g/0MB4z4R7rwEJnb8BV0
	 +Q6sBT0YNnd3+WRrO2c6q8g0veXNohvlE8N+w6ktHaC4F9oHsWvyAtDdHMSH4JvtwK
	 ZQ+K64ifeCZaPRkV6a+8dwM3F+kgVWT+bvtmo6Q2qtVEffNlEQn1yh4iPVjotmcRa0
	 bSfdR2EhOzjbA==
Date: Tue, 22 Oct 2024 08:41:02 -0500
From: Rob Herring <robh@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, krzk+dt@kernel.org,
	conor+dt@kernel.org, andriy.shevchenko@linux.intel.com,
	anshulusr@gmail.com, gustavograzs@gmail.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 11/13] dt-bindings: iio: add binding for BME680 driver
Message-ID: <20241022134102.GA401216-robh@kernel.org>
References: <20241021195316.58911-1-vassilisamir@gmail.com>
 <20241021195316.58911-12-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021195316.58911-12-vassilisamir@gmail.com>

On Mon, Oct 21, 2024 at 09:53:14PM +0200, Vasileios Amoiridis wrote:
> Add dt-binding for BME680 gas sensor device. The device incorporates as
> well temperature, pressure and relative humidity sensors.

You aren't adding a binding for bme680, but extending it.

Drop the 2nd 'bindings' from subject. 

Something like this:

dt-bindings: iio/chemical: bosch,bme680: Add supply properties

> 
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> ---
>  .../bindings/iio/chemical/bosch,bme680.yaml   | 64 +++++++++++++++++++
>  .../devicetree/bindings/trivial-devices.yaml  |  2 -
>  2 files changed, 64 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/chemical/bosch,bme680.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/chemical/bosch,bme680.yaml b/Documentation/devicetree/bindings/iio/chemical/bosch,bme680.yaml
> new file mode 100644
> index 000000000000..e54df3afa7b2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/chemical/bosch,bme680.yaml
> @@ -0,0 +1,64 @@
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
> +description:

You need '>' to maintain paragraphs.

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
> +  - vdd-supply
> +  - vddio-supply

These supplies can't be required. That's an ABI change from what was 
already supported.

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
> index 0108d7507215..3d9c08ed7bce 100644
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
> -- 
> 2.43.0
> 

