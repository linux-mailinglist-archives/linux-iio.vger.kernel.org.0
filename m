Return-Path: <linux-iio+bounces-5593-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FCD38D7479
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 11:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAD11281D24
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 09:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC500286A6;
	Sun,  2 Jun 2024 09:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mTvCKcB3"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12E61865;
	Sun,  2 Jun 2024 09:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717319486; cv=none; b=aUJWqRMWQCUm37MEBKCd2Cjly1htir3dgjOu5+nw8TLlmFMsBOXYo86M03+/0O6si/st+wL5dVdNQcGayQuCOk8yysuafXSDc7gu3WJSqvlBy2XYAgH5+UEzdRkIyD1gNb6CfkX8nocidfdEFsu9yjp/RUZXSWfO1MK7HBHV53Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717319486; c=relaxed/simple;
	bh=LBjFPp3Q3rHJHdMdS/2R9oP/tIlB0vaTPAyhGdFWnmI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sOUG7F3eobhpdgxwF8MM0QHfCoijZJaFse/fntyJ7c6YHs/cj9LrGt2sbEz4CXHzjNirlEz2S6d6Xj4h7y8Z9sOpRLW4B1knxB71D0G+924fjE7oqZ/9LdRMGYztmNsx2jCUz4RhauxXGI4yi8D66CY1UQyxgUvKn6qU6mzO4so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mTvCKcB3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 001CAC2BBFC;
	Sun,  2 Jun 2024 09:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717319485;
	bh=LBjFPp3Q3rHJHdMdS/2R9oP/tIlB0vaTPAyhGdFWnmI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mTvCKcB3avs0o376VW9qMOx+JxrepXc4lT9feYZH8SMW9ceLeA22YtWa97QnZBaOX
	 M0msA5K7kkDjLTsWhCULYchTKtQKO2ubWBypLA08zDo/8ZmN1A/i3QQ1DMu+l6JJWz
	 OHAW3XtS+5kuMAeC/KHhPBCGUCKdKgx2GAqEBRi4POZlBZ1fYQE7+kkklCA3lxnmAx
	 HuVxrUQVAl7CJlc/iVr/SAnQ8MW4it9bZTR/kqoU/KIZo9dwLlXuPGEKF2a4nobuyT
	 ZoKV+TwGi3Pr4xv7dOHAa61MfmXsJTiuKa9w0CD7Ie6hUhxmxEwnkmIE8C+bYE/pyO
	 qyQYr+wLsrNaw==
Date: Sun, 2 Jun 2024 10:11:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Ramona Alexandra Nechita <ramona.nechita@analog.com>
Cc: <linux-iio@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>, Rob Herring
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
 <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 1/1] dt-bindings: iio: adc: add a7779 doc
Message-ID: <20240602101112.28751a2c@jic23-huawei>
In-Reply-To: <20240531133604.1380-2-ramona.nechita@analog.com>
References: <20240531133604.1380-1-ramona.nechita@analog.com>
	<20240531133604.1380-2-ramona.nechita@analog.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 31 May 2024 16:35:52 +0300
Ramona Alexandra Nechita <ramona.nechita@analog.com> wrote:

> Add dt bindings for adc ad7779.
>=20
> Signed-off-by: Ramona Alexandra Nechita <ramona.nechita@analog.com>
> ---
>  .../ABI/testing/sysfs-bus-iio-adc-ad777x      | 23 +++++
>  .../bindings/iio/adc/adi,ad7779.yaml          | 87 +++++++++++++++++++
>  2 files changed, 110 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-ad777x
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7779.=
yaml
>=20
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-ad777x b/Documen=
tation/ABI/testing/sysfs-bus-iio-adc-ad777x
> new file mode 100644
> index 000000000000..0a57fda598e6
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-ad777x
> @@ -0,0 +1,23 @@
> +What:		/sys/bus/iio/devices/iio:deviceX/filter_type_available

This is a binding patch - ABI docs should be in the driver code patch not h=
ere.
A separate patch for ABI docs is also fine.

Also, it is also a documentation bug to have more than one sysfs docs file
for an attribute with the same What line.  We already have this one in ad41=
30.

So the documentation needs to be combined into Documentation/ABI/testing/sy=
sfs-bus-iio-adc
or sysfs-bus-iio

That means you need to write the doc so that is as generic as possible.
There are a few places where we have previously documented device specific
aspects - copy one of those if it is absolutely necessary, but there is info
here that doesn't matter in ABI docs such as what the maximum ODR is for
a particular part - that should be possible to read back from existing ABI.

> +KernelVersion:  6.1
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Reading returns a list with the possible filter modes. Only supported =
by
> +		AD7771.
> +
> +		  * "sinc3"	- The digital sinc3 filter implements three main notches, =
one at
> +				the maximum ODR (128 kHz or 32 kHz, depending on the
> +				power mode) and another two at the ODR frequency selected to
> +				stop noise aliasing into the pass band.
> +
> +		  * "sinc5"	- The sinc5 filter implements five notches, one at
> +				the maximum ODR (128 kHz or 32 kHz, depending on the
> +				power mode) and another four at the ODR frequency
> +				selected to stop noise aliasing into the pass band.

This one sounds nice - so why don't I select it all the time?
Helpful to state the disadvantages.

I'm also a little confused by 4 notches at the ODR frequency. I see that
text comes from the datasheet but that doesn't mean you can't improve it :)
I think this really means notches at multiples of the sampling frequency.



> +
> +What:		/sys/bus/iio/devices/iio:deviceX/filter_type
> +KernelVersion:  6.1
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Set the filter mode of the differential channel. The current sampling_=
frequency
> +		is set according to the filter range. Only supported by AD7771.
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7779.yaml b/=
Documentation/devicetree/bindings/iio/adc/adi,ad7779.yaml
> new file mode 100644
> index 000000000000..632e9ec0ab44
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7779.yaml
> @@ -0,0 +1,87 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/adi,ad7779.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AD777X family 8-Channel, 24-Bit, Simultaneous Samp=
ling ADCs
> +
> +maintainers:
> +  - Ramona Nechita <ramona.nechita@analog.com>
> +
> +description: |
> +  The AD777X family consist of 8-channel, simultaneous sampling analog-t=
o-
> +  digital converter (ADC). Eight full =CE=A3-=CE=94 ADCs are on-chip. The
> +  AD7771 provides an ultralow input current to allow direct sensor
> +  connection. Each input channel has a programmable gain stage
> +  allowing gains of 1, 2, 4, and 8 to map lower amplitude sensor
> +  outputs into the full-scale ADC input range, maximizing the
> +  dynamic range of the signal chain.
> +
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ad=
7770.pdf
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ad=
7771.pdf
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ad=
7779.pdf
> +
> +$ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ad7770
> +      - adi,ad7771
> +      - adi,ad7779
> +
> +  reg:
> +    maxItems: 1
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +  spi-max-frequency: true
> +
> +  clocks:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  vref-supply:
> +    description:
> +      ADC reference voltage supply
> +
> +  start-gpios:
> +    description:
> +      Pin that controls start synchronization pulse.
> +    maxItems: 1
> +
> +  reset-gpios:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
You seem to be missing a whole raft of power supplies.
AVDD1x, AVDD2,, IOVDD - maybe more.
Some of those at least will be 'required'.
Note that required doesn't rule out using fixed or dummy regulators=20
(those supplied by the regulator framework if nothing is found in DT)
but the binding should still reflect we need to provide power for the chip
to function.

> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    spi {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        adc@0 {
> +          compatible =3D "adi,ad7779";
> +          reg =3D <0>;
> +          spi-max-frequency =3D <20000000>;
> +          vref-supply =3D <&vref>;
> +          start-gpios =3D <&gpio0 87 GPIO_ACTIVE_LOW>;
> +          reset-gpios =3D <&gpio0 93 GPIO_ACTIVE_LOW>;
> +          clocks =3D <&adc_clk>;
> +        };
> +    };
> +...


