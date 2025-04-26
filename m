Return-Path: <linux-iio+bounces-18679-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F26C8A9DA2F
	for <lists+linux-iio@lfdr.de>; Sat, 26 Apr 2025 12:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B9679270BD
	for <lists+linux-iio@lfdr.de>; Sat, 26 Apr 2025 10:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A1021883E;
	Sat, 26 Apr 2025 10:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XvMFIxPY"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9DC52F88;
	Sat, 26 Apr 2025 10:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745664453; cv=none; b=KoJj6XHpV9ntY+TKAYKKTkDvlXf2X7FJqVvTTk66BiTy8xS3VW2WFba8jEck9JqXNrD6n1OWG9QQlBXZNkBnH0euTec8xRs0sMWfmO2dNOPDFIAdyH0mfsVmIxGY/W5Oeb9pIeAz9o4ofJOnAh64l5mw1Wuis7hkDNepLTpjRMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745664453; c=relaxed/simple;
	bh=tW3bgprbWZjUelXIyTcHAxilFpzgGn89apgqA+i44Q4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tHVU9ykjg4W5L1pgxXBcDJvhT4M+biuo3T2uFNHe6PPSB0KjYHBFR77UilQ/TkG/vY1Zg3iYBtetpXViXitDN1EKvEucs0TDVXjv60LFx9ReN2kiYW19AWbVzyvOUGVpu4Fjyu4aDkmsJBkSGENTXTbhcIjOB9kjOEpVytBtvXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XvMFIxPY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45B95C4CEE2;
	Sat, 26 Apr 2025 10:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745664452;
	bh=tW3bgprbWZjUelXIyTcHAxilFpzgGn89apgqA+i44Q4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XvMFIxPYcn/uotJTYHmylTbyj9f2Ea+4OusdjGhg61b6WGK3jD/uS5sP5KNTkZVEW
	 fLuwy2as2BvAJLF3chn6i+bIkjEtPFxNdV7anhkEQN7JmedbrAtryH1Yhotpo1V4El
	 E4fIUVfIWPDatOKEKJdCNnt3nxwERt3tZYJW12jAPLIdgkiwFvnTuuecNEq7BL3epB
	 byt7e64uiNXmOy5+awMJefab3sDKlUPc0iByggrt0w+DY/viRvux0qtglETBOTubCP
	 gkz/dHq0LrWVYqoNnh5YC+E0TrLDmtmSEKgUWI8QEHWk6sPE+qIz2vT1bcxIWD4W+A
	 wlPGz3FOcA4mQ==
Date: Sat, 26 Apr 2025 11:47:25 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: surajsonawane0215@gmail.com
Cc: lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: chemical: Add sharp,gp2y1010au0f
Message-ID: <20250426114725.27ab44bc@jic23-huawei>
In-Reply-To: <20250425215149.49068-1-surajsonawane0215@gmail.com>
References: <20250425215149.49068-1-surajsonawane0215@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 26 Apr 2025 03:21:49 +0530
surajsonawane0215@gmail.com wrote:

> From: Suraj Sonawane <surajsonawane0215@gmail.com>
Hi Suraj,

Welcome to IIO.

>=20
> Add Device Tree bindings for Sharp GP2Y1010AU0F optical dust sensor.
> The sensor measures particulate matter concentration via infrared
> scattering and requires:
>=20
> 1. GPIO for LED pulse control (280=CE=BCs pulses with 40=CE=BCs delay)
> 2. ADC channel for analog output measurement
> 3. Power regulator (vdd-supply)
>=20
> Datasheet:
> https://global.sharp/products/device/lineup/data/pdf/datasheet/gp2y1010au=
_appl_e.pdf
This can be a tag, so put it all on one line and drop this blank line so it=
 forms
part of the tag block.  Don't worry about checkpatch warning that will resu=
lt.
It never got updated for Datasheet: properly.
>=20
> Signed-off-by: Suraj Sonawane <surajsonawane0215@gmail.com>
> ---
>  .../iio/chemical/sharp,gp2y1010au0f.yaml      | 67 +++++++++++++++++++
>  1 file changed, 67 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/chemical/sharp,=
gp2y1010au0f.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/iio/chemical/sharp,gp2y101=
0au0f.yaml b/Documentation/devicetree/bindings/iio/chemical/sharp,gp2y1010a=
u0f.yaml
> new file mode 100644
> index 000000000..358c2b2f7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/chemical/sharp,gp2y1010au0f.y=
aml
> @@ -0,0 +1,67 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/chemical/sharp,gp2y1010au0f.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Sharp GP2Y1010AU0F Optical Dust Sensor
> +
> +maintainers:
> +  - Suraj Sonawane <surajsonawane0215@gmail.com>
> +
> +description: |
> +  Optical dust sensor measuring particulate matter concentration via inf=
rared scattering.
> +  Requires ADC for analog output and GPIO for pulsed LED control with st=
rict timing.
> +  Datasheet: https://global.sharp/products/device/lineup/data/pdf/datash=
eet/gp2y1010au_appl_e.pdf
> +
> +properties:
> +  compatible:
> +    const: sharp,gp2y1010au0f
> +
> +  vdd-supply:
> +    description: Phandle to the regulator that provides power to the sen=
sor

For a simple supply voltage no real need for the docs.
    vdd-supply: true
is usually enough.

> +
> +  led-gpios:
> +    description: GPIO connected to the sensor's LED control pin (V-LED)
> +    maxItems: 1
> +
> +  io-channels:
> +    description: ADC channel connected to the sensor's analog output (Vo)
> +    maxItems: 1
> +
> +  io-channel-names:
> +    const: dust
> +
> +  sharp,led-on-delay-us:
> +    description: Time in microseconds to wait after turning LED on befor=
e ADC read

The datasheet seems to suggest a 0.28msec value for this for an LED pulse w=
idth of
0.32msecs

Hence maybe you could give a spec reference for the range given here?  I ma=
y well
be looking at the wrong bit of the datasheet!

> +    default: 40
> +    minimum: 0
> +    maximum: 100
> +
> +  sharp,measurement-window-us:
> +    description: Measurement window in microseconds after LED turn-on

I'm not able to directly relate this to what I'm seeing on the datasheet.
Is this just the on time?

> +    default: 200
> +    minimum: 0
> +    maximum: 280
> +
> +required:
> +  - compatible
> +  - led-gpios
> +  - io-channels
> +  - io-channel-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    dust_sensor {
I think this needs a reg, even if that is just an index so we can keep trac=
k of multiple sensors.

> +        compatible =3D "sharp,gp2y1010au0f";
> +        vdd-supply =3D <&vcc>;
> +        led-gpios =3D <&gpio 44 GPIO_ACTIVE_HIGH>;
> +        io-channels =3D <&adc 0>;
> +        io-channel-names =3D "dust";
> +        sharp,led-on-delay-us =3D <40>;
> +        sharp,measurement-window-us =3D <200>;=09
> +    };


