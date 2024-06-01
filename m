Return-Path: <linux-iio+bounces-5580-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D28C88D7187
	for <lists+linux-iio@lfdr.de>; Sat,  1 Jun 2024 20:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B7D8B2129B
	for <lists+linux-iio@lfdr.de>; Sat,  1 Jun 2024 18:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539AD1534EA;
	Sat,  1 Jun 2024 18:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iNlH+UiJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07EC314267;
	Sat,  1 Jun 2024 18:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717266929; cv=none; b=jxob1CSNfzzzNtIX4UKG2W7vRinAG6GGeLwh9JvmqYoI8IlDN7FnzuBbUYRGX0+nJ2KcbOZvYps1VpO7+okk6p3kXnYDtQJTo4ylkphEnJ01s+BbLyQZ79crI6miHBBTfbdotCqOf5oqDJShbxltP1aci/ANCUAnih2aJEs6zfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717266929; c=relaxed/simple;
	bh=mtgb8tUEskvemeJcAOPUnubgObdTQkeV31omALLO7pc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=boP76NWG6DnvsAJWDrjazHcRzm233t8rBlouaTEe0se3h0k+zgpe5EchRgv2NDGpQjDYzAwRe2r15v8BZ5IMxvuzHNooiqRePrWgbOhj6C+CCP2DJvglgzvOpSnr3ejsqJ6uo3a9Wqy+MkzH/uuWze3sv6BHmUB1AgGvRgdH66k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iNlH+UiJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C63A3C116B1;
	Sat,  1 Jun 2024 18:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717266928;
	bh=mtgb8tUEskvemeJcAOPUnubgObdTQkeV31omALLO7pc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iNlH+UiJ3HzSbTmjUVHal1OZKAIrt+6ksY0CblgBD5MNtmimFpmsnRp7mtPSF0Rhz
	 98QnTgIJBWgrjYrdIvo6KYy3QlVcsbgTYywb9eKykXtma8dU5CQnjIISDeVKb0TRDv
	 V4Sg1dG/b/qQqN+Fr8226DrJRFWPjgDrRs73vuSnzWi73OYeScF406fbLjtFXbb5cC
	 q65YQbnMvWIg0c1/oKW8yVHe/XISnPCTSx05AgyVnQIqHFHKsRTihXU+z194wUAb2F
	 Tta2LGLlZXFoVCfufH3OgHQu3bTIl49cI24FO0UjXIWYIU82JHffaRu+93H4N5S+fK
	 FZLsfW2g8Xl4w==
Date: Sat, 1 Jun 2024 19:35:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Dumitru Ceclan via B4 Relay
 <devnull+dumitru.ceclan.analog.com@kernel.org>
Cc: dumitru.ceclan@analog.com, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dumitru Ceclan <mitrutzceclan@gmail.com>
Subject: Re: [PATCH v4 1/6] dt-bindings: adc: ad7173: add support for ad411x
Message-ID: <20240601193512.0e17992b@jic23-huawei>
In-Reply-To: <20240531-ad4111-v4-1-64607301c057@analog.com>
References: <20240531-ad4111-v4-0-64607301c057@analog.com>
	<20240531-ad4111-v4-1-64607301c057@analog.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 31 May 2024 22:42:27 +0300
Dumitru Ceclan via B4 Relay <devnull+dumitru.ceclan.analog.com@kernel.org> =
wrote:

> From: Dumitru Ceclan <dumitru.ceclan@analog.com>
>=20
> Add support for: AD4111, AD4112, AD4114, AD4115, AD4116.
>=20
> AD411x family ADCs support a VCOM pin. The purpose of this pin is to
> offer a dedicated common-mode voltage input for single-ended channels.
> This pin is specified as supporting a differential channel with VIN10 on
> model AD4116.
>=20
> AD4111/AD4112 support current channels. Support is implemented using
> single-channel and "adi,current-channel".
>=20
> Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
I like the common-mode-channel solution to the pseudo differential
description. It makes things explicit whilst avoiding an ugly differential
but not differential mess.

However, it feels like a general thing to me not a vendor specific one.
Perhaps makes sense to put in adc.yaml?

One other question that is more me being curious and failing to understand
the datasheet than a request to change anything.
> ---
>  .../devicetree/bindings/iio/adc/adi,ad7173.yaml    | 192 +++++++++++++++=
+++++-
>  1 file changed, 190 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml b/=
Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
> index ea6cfcd0aff4..d8474eee553e 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
> @@ -19,7 +19,18 @@ description: |
>    primarily for measurement of signals close to DC but also delivers
>    outstanding performance with input bandwidths out to ~10kHz.
> =20
> +  Analog Devices AD411x ADC's:
> +  The AD411X family encompasses a series of low power, low noise, 24-bit,
> +  sigma-delta analog-to-digital converters that offer a versatile range =
of
> +  specifications. They integrate an analog front end suitable for proces=
sing
> +  fully differential/single-ended and bipolar voltage inputs.
> +
>    Datasheets for supported chips:
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
AD4111.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
AD4112.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
AD4114.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
AD4115.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
AD4116.pdf
>      https://www.analog.com/media/en/technical-documentation/data-sheets/=
AD7172-2.pdf
>      https://www.analog.com/media/en/technical-documentation/data-sheets/=
AD7172-4.pdf
>      https://www.analog.com/media/en/technical-documentation/data-sheets/=
AD7173-8.pdf
> @@ -31,6 +42,11 @@ description: |
>  properties:
>    compatible:
>      enum:
> +      - adi,ad4111
> +      - adi,ad4112
> +      - adi,ad4114
> +      - adi,ad4115
> +      - adi,ad4116
>        - adi,ad7172-2
>        - adi,ad7172-4
>        - adi,ad7173-8
> @@ -129,10 +145,54 @@ patternProperties:
>          maximum: 15
> =20
>        diff-channels:
> +        description: |
> +          This property is used for defining the inputs of a differential
> +          voltage channel. The first value is the positive input and the=
 second
> +          value is the negative input of the channel.
> +
> +          Family AD411x supports a dedicated VINCOM voltage input.
> +          To select it set the second channel to 16.
> +            (VIN2, VINCOM) -> diff-channels =3D <2 16>
> +
> +          There are special values that can be selected besides the volt=
age
> +          analog inputs:
> +            21: REF+
> +            22: REF=E2=88=92
> +          Supported only by AD7172-2, AD7172-4, AD7175-2, AD7175-8, AD71=
77-2:
> +            19: ((AVDD1 =E2=88=92 AVSS)/5)+
> +            20: ((AVDD1 =E2=88=92 AVSS)/5)=E2=88=92

That's what it says on the datasheet (so fine to copy that here) but I'm cu=
rious, what does
that mean in practice?  How can we have negative and postive signals of the=
 difference
between two power supply voltages where I'm fairly sure AVDD1 always greate=
r than AVSS.

Anyhow, that's a problem for the person reading the datasheet to figure out=
 :)
=20
> +
>          items:
>            minimum: 0
>            maximum: 31
> =20
> +      single-channel:
> +        description: |
> +          This property is used for defining a current channel or the po=
sitive
> +          input of a voltage channel (single-ended or pseudo-differentia=
l).
> +
> +          Models AD4111 and AD4112 support current channels.
> +            Example: (IIN2+, IIN2=E2=88=92) -> single-channel =3D <2>
> +          To correctly configure a current channel set the "adi,current-=
channel"
> +          property to true.
> +
> +          To configure a single-ended/pseudo-differential channel set the
> +          "adi,common-mode-channel" property to the desired negative vol=
tage input.
> +
> +          When used as a voltage channel, special inputs are valid as we=
ll.
> +        minimum: 0
> +        maximum: 31
> +
> +      adi,common-mode-channel:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description:
> +          This property is used for defining the negative input of a
> +          single-ended or pseudo-differential voltage channel.
> +
> +          Special inputs are valid as well.
> +        minimum: 0
> +        maximum: 31
> +


