Return-Path: <linux-iio+bounces-19763-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F43EABEE06
	for <lists+linux-iio@lfdr.de>; Wed, 21 May 2025 10:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 825A4188C647
	for <lists+linux-iio@lfdr.de>; Wed, 21 May 2025 08:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4D12367C5;
	Wed, 21 May 2025 08:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O9DJ04I8"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01ECC7080E;
	Wed, 21 May 2025 08:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747816427; cv=none; b=JBMSoh2uIOZymrEltdHnwnzoB97VvWU2C/x5cQxlBeEqfo+tvcffqJjKD3kwblAvlxmET6UWbcpqKCcY2mp9d45JzZbFCxjrYK+RiV3I3XRzmmkLogeSeKMtE6ORwqX21cqzUFnwqJ9bvDVhNRveo7qL6aTUcc3i308y9TdJnrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747816427; c=relaxed/simple;
	bh=WYdMu1TxOolXOfaJN4+YHjhJoFL55/SJnZ+q8PWKmdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EFrwBqdUNa4M1fV+b29rwtQgKggeko0ztxjRunV9Xl+vSrvRipL2XvLZ7qb4PoDMEsw35MWi01GJ8g3fZ7amAxMvkzhBpDTpcT/xGdGZJqd+8pfylKixLxzHvjE/JcyKmbjoWt9w9LacBMg/cmZUGt6d84qxC7k0iXFnkVVj8bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O9DJ04I8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCD32C4CEE4;
	Wed, 21 May 2025 08:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747816426;
	bh=WYdMu1TxOolXOfaJN4+YHjhJoFL55/SJnZ+q8PWKmdo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O9DJ04I8P4hD3DNeBMzAwz+EMy1fzzKDNmIAIp9zbFmWEC/xSqZ3XibCUwHyx+nqR
	 Y8BLerM9DM0ycWKy/Th3LRclWcgxxRHRazb/MZC4SEwaxzs+pT5hdfM/Y9cFFp4yTF
	 mRYJ8ECShWBwNzw53AecRoiZz0qO1em0moZfOMqIly9Si1O/PCX4b8+jgumaV3TgDu
	 JTWjNueamSu7u7OCC3dQWpL0UKJSUKXghEsxJx/z3eBT1dREc5Y3SZfYxjtQyrTO0D
	 Mfb4sdMViQDhbzZ6Zi3NMteBwlnsO/2YO8DrZFlVDs5w2BFYu57hmrjMpEyC+Z/EMQ
	 BRcMvv2823lPw==
Date: Wed, 21 May 2025 10:33:43 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, 
	Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, jic23@kernel.org, lars@metafoo.de, 
	Michael.Hennerich@analog.com, nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, linus.walleij@linaro.org, brgl@bgdev.pl
Subject: Re: [PATCH v3 01/10] dt-bindings: iio: adc: Add AD4170
Message-ID: <20250521-functional-knowing-hornet-b33a1f@kuoka>
References: <cover.1747083143.git.marcelo.schmitt@analog.com>
 <5fa867cff437c0c6d3f0122af823e1677a12d189.1747083143.git.marcelo.schmitt@analog.com>
 <2ab9a6e2-a331-4995-8d42-00290bc825e7@baylibre.com>
 <aCddgYRWrLPlGeuR@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <aCddgYRWrLPlGeuR@debian-BULLSEYE-live-builder-AMD64>

On Fri, May 16, 2025 at 12:45:05PM GMT, Marcelo Schmitt wrote:
> ...
> > > +
> > > +    properties:
> > > +      adi,reference-select:
> > > +        description: |
> > > +          Selects the reference source to use when converting on the=
 specific
> > > +          channel. Valid values are:
> > > +          0: Differential reference voltage REFIN+ - REFIN=E2=88=92.
> > > +          1: Differential reference voltage REFIN2+ - REFIN2=E2=88=
=92.
> > > +          2: Internal 2.5V referece (REFOUT) relative to AVSS.
> > > +          3: Analog supply voltage (AVDD) relative AVSS.
> > > +        $ref: /schemas/types.yaml#/definitions/uint8
> > > +        enum: [0, 1, 2, 3]
> > Using strings instead of int for this and most of the other custom enum=
s here
> > would make them self-documenting and easier to use.
>=20
> The numbers match the values that are documented in the datasheet for each
> option of voltage reference available to use with a channel. So we would =
be
> using numbers mostly to define values of some unit and pin numbers (e.g. =
100 for
> the microamp property)? Not really excited about doing this change becaus=
e I
> think it will make the dtb a bit larger and the driver code a bit more le=
ngthy,
> but can do that for v4.

You must use what is already there, the same property, the same type.
And since existing property was integer, I am unhappy that Dumitru
Ceclan decided to go with a string in commit 3d50d03f2194 ("dt-bindings:
adc: add AD7173"), although that is probably on us.

So now there is a mess and we are going to have either exception or
warnings for these devices (always), because schema expects exactly one
type.

So instead of coming or proposing the third type, just use what was
already in the bindings.

Same for every other property here, really, don't come with your own
custom stuff.

>=20
> ...
> > > +      adi,sensor-type:
> > > +        description: |
> > > +          Type of sensor connected to the device. Depending on the s=
ensor type
> > > +          (weigh scale, RTD, or thermocouple) the values of sensor-n=
ode
> > > +          properties have slightly different constraints. This prope=
rty
> > > +          specifies which particular external sensor is connected to=
 the ADC so
> > > +          the sensor-node properties can be properly parsed and veri=
fied. The
> > > +          possible sensor types are:
> > > +          0: weigh scale;
> > > +          1: RTD;
> > > +          2: thermocouple.
> > > +        $ref: /schemas/types.yaml#/definitions/uint8
> > This property seems reduandant since it has to match the node name.
> >=20
> > i.e. weighscale@... is is always adi,sensor-type =3D <0>; and so on.
>=20
> Yes, can we rely on node names I'll do that for v4.

Again, don't come with own new way of doing things. What node name?
Isn't this always "channel"?

Best regards,
Krzysztof


