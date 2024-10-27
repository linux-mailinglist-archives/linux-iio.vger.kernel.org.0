Return-Path: <linux-iio+bounces-11397-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33FD99B1D8C
	for <lists+linux-iio@lfdr.de>; Sun, 27 Oct 2024 12:54:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 653BD1C2123C
	for <lists+linux-iio@lfdr.de>; Sun, 27 Oct 2024 11:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3CE815442D;
	Sun, 27 Oct 2024 11:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TtFCTf4Z"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A825F7DA67;
	Sun, 27 Oct 2024 11:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730030058; cv=none; b=ZIdcPHLya/ZrQ57pFwL6rybHFpBUpmh4yRqE/T0QilGq67YmV4s/ybsr0wp6fcw8bm/7J3cQjiDSXkHB9AaebGFiifTBQCuTqHsiN6Ja6vNmiX+dWauteSladLU92i6SckfdxZvIkGyy311Kr5hFgCIEbA8+N9KDscJFQtaFJxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730030058; c=relaxed/simple;
	bh=rBH8OJYHjgxREN6PmXbHBEyIuzPCI+AXxPTRjbJiYLs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RnX/3oLgMjGehYV7BNyRYVLvhRUVU1fflFSq/H8ZDwE9C5RltCWEtRjpwTiBXk/XzdeqP69DNXNbEL7xtLfqaOJy5beZ9EeySGitFRaI4jrKPijbJ3dntc2F9QskgxIvQA4kvmm0561el2tHSoxWOtOZG7O9rzJmaHsYqnC4FnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TtFCTf4Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D23C7C4CEC3;
	Sun, 27 Oct 2024 11:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730030058;
	bh=rBH8OJYHjgxREN6PmXbHBEyIuzPCI+AXxPTRjbJiYLs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TtFCTf4ZxoLWyTBEkTNqx7yTEKMhW9By9po7bzRw44kz6h+onAWkFs+yMi8WikTIG
	 wSdlUiJiKV/rrUZTOPICpg5Nt1MgmYMkbnhHXMYYtNx3kE2/IljSsX4dAu3a1DSevF
	 YGb2I36n0CSnswxIQgIKlCzdwrPIGnat6QnklYT9MgmA3nR3Op5zuimUvzjPiTZXhI
	 c883oFlH0Hf17vJJ4UQWrznGhcdvNtMwKNoWqnHuZnchjPRDZebM97s9P1i+m/4a1r
	 9oGypsmGTIIoovXLSZs4zQ/EpDJDSx0byv5pE8zqbH7qbRUCUJdCEbkJLu+/FxMmtk
	 ozWY96XuW4O4g==
Date: Sun, 27 Oct 2024 11:54:09 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>
Cc: Alexandru Tachici <alexandru.tachici@analog.com>, Conor Dooley
 <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>, Dumitru
 Ceclan <dumitru.ceclan@analog.com>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>, Rob
 Herring <robh@kernel.org>, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: iio: adc: adi,ad7124: Allow
 specifications of a gpio for irq line
Message-ID: <20241027115409.2de280dd@jic23-huawei>
In-Reply-To: <20241024171703.201436-6-u.kleine-koenig@baylibre.com>
References: <20241024171703.201436-5-u.kleine-koenig@baylibre.com>
	<20241024171703.201436-6-u.kleine-koenig@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 24 Oct 2024 19:17:03 +0200
Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com> wrote:

> For the AD7124 chip the logical irq line (=CC=85R=CC=85D=CC=85Y) is physi=
cally on the same
> pin as the spi MISO output (DOUT) and so reading a register might
> trigger an interrupt. For correct operation it's critical that the
> actual state of the pin can be read to judge if an interrupt event is a
> real one or just a spurious one triggered by toggling the line in its
> MISO mode.

This text should note that this is a limitation with the interrupt controll=
er.
The IRQ is disabled when those reads are going on, yet the controller is
still detecting the interrupt and reporting it on reenable.
I'm not an expert in what the kernel IRQ subsystem requires so maybe
this is a valid implementation.

>=20
> Allow specification of an "interrupt-gpios" property instead of a plain
> interrupt. The semantic is that the GPIO's interrupt is to be used as
> event source and reading the GPIO can be used to differentiate between a
> real event and one triggered by MISO.

This sort of hack is a bit nasty and if we are going to do it we should
allow for double wiring - so to separate GPIO and interrupt pins on the
host wired to single pin on the device.

The binding does that by allowing both interrupts and interrupt-gpio
but we need to make that explicit in this text. Arguably even when
they are the same pin the binding should treat them as independent
and the driver should get the gpio from one, and the interrupt from
the other.

I also definitely need input from Analog Devices folk on this series.

Jonathan

>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
> ---
>  .../devicetree/bindings/iio/adc/adi,ad7124.yaml     | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml b/=
Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml
> index 35ed04350e28..feb3a41a148e 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml
> @@ -37,6 +37,9 @@ properties:
>      description: IRQ line for the ADC
>      maxItems: 1
> =20
> +  interrupt-gpios:
> +    description: GPIO reading the interrupt line
> +
>    '#address-cells':
>      const: 1
> =20
> @@ -57,7 +60,12 @@ required:
>    - reg
>    - clocks
>    - clock-names
> -  - interrupts
> +
> +oneOf:
> +  - required:
> +      - interrupts
> +  - required:
> +      - interrupt-gpios
> =20
>  patternProperties:
>    "^channel@([0-9]|1[0-5])$":
> @@ -119,8 +127,7 @@ examples:
>          compatible =3D "adi,ad7124-4";
>          reg =3D <0>;
>          spi-max-frequency =3D <5000000>;
> -        interrupts =3D <25 2>;
> -        interrupt-parent =3D <&gpio>;
> +        interrupt-gpios =3D <&gpio 25 2>;
>          refin1-supply =3D <&adc_vref>;
>          clocks =3D <&ad7124_mclk>;
>          clock-names =3D "mclk";


