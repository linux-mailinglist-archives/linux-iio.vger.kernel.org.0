Return-Path: <linux-iio+bounces-19631-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B579ABB0E6
	for <lists+linux-iio@lfdr.de>; Sun, 18 May 2025 18:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF9273A5CFD
	for <lists+linux-iio@lfdr.de>; Sun, 18 May 2025 16:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C230421D3E7;
	Sun, 18 May 2025 16:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rc8HLvac"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731F221D3D1;
	Sun, 18 May 2025 16:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747586703; cv=none; b=PS4odNkknvsf5oD+NgFhUj9UHdbH5cSCWpaviQxeXRS2rVs0XlaDuXMrf2yP9tJGQbPEkMUGO/gICGSgZCd+ad43AnMRPfZeLcqizVmdkdB6+EDQ3aNH5PbcGWGbNvzxqdGzJJkh2ZKBnRX/oaleJ/UwzStVv9RSb4e5OHAOzlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747586703; c=relaxed/simple;
	bh=hqYYae6HdTbOX7JwE+TunGPlD72L5BsUZLZ3ArZO5z8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sX2Pbys1H8i2liLFVk74XOvENKz0+u3PAviqQAAIbmF3C+ETpKwb0AcE5APXiCCtLFxmpKWkLKhdJwd1+vyCDLljnVbTPUz3cMo/emkskV1JpkiZH6bPj6Eu9Z9CeypWhnMM4VeNAVLEFFBNkY/8+3SViqI226JDwdk51Bsbyx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rc8HLvac; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CAC9C4CEE7;
	Sun, 18 May 2025 16:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747586702;
	bh=hqYYae6HdTbOX7JwE+TunGPlD72L5BsUZLZ3ArZO5z8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rc8HLvacxAyWZcWo+E/Juqc1tAlTZDikiyaQB1KVAkSCM3Bo4L9uRxDoJdFYUc/8g
	 Dou73bK2tAu4SERilMWpN8R4bKwZeTI7lKJodFx/RVreZZPfV13p8F6dkZgQoB7Dml
	 wgRO95C8KwiEs5cc5zDGesxfUhey75Di/muooDvmZY9vKHq0HRx+izs6rolDRAk6vb
	 vUwlc5hvDnT7qEZnwYDOmRIDJjXNUOA9ISESiwLZwvqjyYd7ufnIgxYH4Jpl60UQ4D
	 RToICoLZK7xGbrwvLRKrClk35vB/Yy0BoxfCzjlfufYpm8Hp4tHnpcSvBCi7gwrJ4J
	 MaEkcoRJDCorQ==
Date: Sun, 18 May 2025 17:44:50 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Sergiu Cuciurean
 <sergiu.cuciurean@analog.com>, Dragos Bogdan <dragos.bogdan@analog.com>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>, Olivier Moysan
 <olivier.moysan@foss.st.com>, Javier Carrasco
 <javier.carrasco.cruz@gmail.com>, Matti Vaittinen
 <mazziesaccount@gmail.com>, Tobias Sperling <tobias.sperling@softing.com>,
 Alisa-Dariana Roman <alisadariana@gmail.com>, Marcelo Schmitt
 <marcelo.schmitt@analog.com>, Trevor Gamblin <tgamblin@baylibre.com>,
 Matteo Martelli <matteomartelli3@gmail.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 3/4] dt-bindings: iio: adc: add ad7405
Message-ID: <20250518174450.044d2464@jic23-huawei>
In-Reply-To: <20250516105810.3028541-4-pop.ioan-daniel@analog.com>
References: <20250516105810.3028541-1-pop.ioan-daniel@analog.com>
	<20250516105810.3028541-4-pop.ioan-daniel@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 16 May 2025 13:58:03 +0300
Pop Ioan Daniel <pop.ioan-daniel@analog.com> wrote:

> Add devicetree bindings for ad7405/adum770x family.
>=20
> Signed-off-by: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
> ---
> changes in v2:
>  - fix properties: clocks issue
>  .../bindings/iio/adc/adi,ad7405.yaml          | 60 +++++++++++++++++++
>  1 file changed, 60 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7405.=
yaml
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7405.yaml b/=
Documentation/devicetree/bindings/iio/adc/adi,ad7405.yaml
> new file mode 100644
> index 000000000000..939de3bd6f26
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7405.yaml
> @@ -0,0 +1,60 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright 2025 Analog Devices Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/adi,ad7405.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AD7405 family
> +
> +maintainers:
> +  - Dragos Bogdan <dragos.bogdan@analog.com>
> +  - Pop Ioan Daniel <pop.ioan-daniel@analog.com>
> +
> +description: |
> +  Analog Devices AD7405 is a high performance isolated ADC, 1-channel,
> +  16-bit with a second-order =CE=A3-=CE=94 modulator that converts an an=
alog input signal
> +  into a high speed, single-bit data stream.
> +
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ad=
7405.pdf
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ad=
um7701.pdf
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ad=
um7702.pdf
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/AD=
uM7703.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ad7405
> +      - adi,adum7701
> +      - adi,adum7702
> +      - adi,adum7703
> +
> +  clocks:
> +    maxItems: 1

The closest part we have to this (LVDS bus etc) that I could find was
the ad7625.  That does use an explicit clock but there is more going
on as it also has a pwm connected to gate that clock so maybe isn't
an idea example to follow.

As you will see in the driver review I just sent I'm wondering if an
explicit clock is a separate thing or considered part of the lvds bus.

It's definitely wired to the ADC as a clock but it's also (I think) either
wired up to the IP we map to the backend (from software point of view)
or generated by that.

I don't think this device is using an LVDS encoding to allow the clock
to be established from the data lines alone? 8b/10b or similar (if it were =
then the
clock to the ADC only description would be correct choice).

Perhaps this device is one that needs docs in the kernel to talk us
through how the signalling is working.

Jonathan

> +
> +  vdd1-supply: true
> +
> +  vdd2-supply: true
> +
> +  io-backends:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - clocks
> +  - vdd1-supply
> +  - vdd2-supply
> +  - io-backends
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    adc {
> +        compatible =3D "adi,ad7405";
> +        clocks =3D <&axi_clk_gen 0>;
> +        vdd1-supply =3D <&vdd1>;
> +        vdd2-supply =3D <&vdd2>;
> +        io-backends =3D <&iio_backend>;
> +    };
> +...


