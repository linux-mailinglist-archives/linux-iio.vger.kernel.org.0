Return-Path: <linux-iio+bounces-13638-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11BE09F7BE0
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2024 13:55:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D116918862C4
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2024 12:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25CF221DA0;
	Thu, 19 Dec 2024 12:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RW1ZKJXv"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFF8223E73;
	Thu, 19 Dec 2024 12:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734612912; cv=none; b=pGSTIsIV8sVSIWcvUC6Scdj39TVFIgbFG8z+9FFHWjjolz7hQq3xGvGbDSGPA2MonIGVz3yX6YDpJ85y32IYpMI5ZwazrGMh+/r0FbbdpvuqXqx5KfB5/jIEZglzcGyfYWSjgMZhMOKUJv/aOrjhBDoFD0sY8Xns1tmySQcDuPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734612912; c=relaxed/simple;
	bh=pIeD2fJOauwUveVVD3dwn5nVKD3fgrOf3KOrxmYJ7Ew=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=frUk1Yt39dAIMbUsGH/bmZeFP4guH5IJW6Vj+rAuzR4qrx+zRcU4WVuhzMT8/G+JujAcweZpMJOFQKPh3vUMGLv4M7sJwiI2V7/87kq31mn/cF4LXkLjrlq2PJ7m+WIQN7uSeRxnOKRSUU/AsuDaA4x7ZfouqCVLXSSFgKdBqeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RW1ZKJXv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 048AFC4CECE;
	Thu, 19 Dec 2024 12:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734612912;
	bh=pIeD2fJOauwUveVVD3dwn5nVKD3fgrOf3KOrxmYJ7Ew=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RW1ZKJXvxsod0Dfxzucq+qHHUBwtKtH3LA2rXu0yHPXEvf3KTAeHIbhQEljga8AuK
	 Y/WxtB/m7JFoJ52yeuoyN+hQcLbP6GQU3OznFVxSrUDPrSzrl3kdf8N54Xo1KUQb7H
	 9joQHdOprCmcIfLDjuuRNczjLysIEQe1TC8tut3ZycYqoJHFcUH1Y/CIk0hJj7/2VD
	 vokH/QB3B4qhRwAzhOAeWuQwi09VMiMRZMgGJnipXf/b4oveNM13gMh1CwF0t1GL98
	 O/J6UXTUTEYBIxNL31bCLKbKy/nVVr+Ufhw198obJ1IlgtuR5CWWm9N31nAyBkw5Py
	 G6Py7kBJy/fng==
Date: Thu, 19 Dec 2024 12:55:03 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, lars@metafoo.de,
 Michael.Hennerich@analog.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, ana-maria.cusco@analog.com, marcelo.schmitt1@gmail.com
Subject: Re: [RFC PATCH 4/4] Documentation: iio: Add ADC documentation
Message-ID: <20241219125503.6c909c24@jic23-huawei>
In-Reply-To: <a2e76ca6-ec21-4ce5-91f7-4d3a0ed792ce@baylibre.com>
References: <cover.1734530280.git.marcelo.schmitt@analog.com>
	<48876e204590c47c532fc5f71e02ca3a00028cb7.1734530280.git.marcelo.schmitt@analog.com>
	<a2e76ca6-ec21-4ce5-91f7-4d3a0ed792ce@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 18 Dec 2024 14:46:14 -0600
David Lechner <dlechner@baylibre.com> wrote:

> On 12/18/24 8:38 AM, Marcelo Schmitt wrote:
> > ADCs can have different input configurations such that developers can g=
et
> > confused when trying to model some of them into IIO channels.
> >=20
> > For example, some differential ADCs can have their channels configured =
as
> > pseudo-differential channels. In that configuration, only one input
> > connects to the signal of interest as opposed to using two inputs of a
> > differential input configuration. Datasheets sometimes also refer to
> > pseudo-differential inputs as single-ended inputs even though they have
> > distinct physical configuration and measurement procedure. There has be=
en
> > some previous discussion in the mailing list about pseudo-differential =
and
> > single-ended channels [1].
> >=20
> > Documenting the many possible ADC channel configurations should provide=
 two
> > benefits:
> > A) Consolidate the knowledge from [2] and from [1], and hopefully reduce
> > the reviewing time of forthcoming ADC drivers.
> > B) Help Linux developers figure out quicker how to better support
> > differential ADCs, specially those that can have channels configured as
> > pseudo-differential inputs.
> >=20
> > Add documentation about common ADC characteristics and IIO support for =
them.
> >=20
> > [1]: https://lore.kernel.org/linux-iio/0fef36f8-a7db-40cc-86bd-9449cb4a=
b46e@gmail.com/
> > [2]: https://www.analog.com/en/resources/technical-articles/sar-adc-inp=
ut-types.html.
> >=20
> > Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> > --- =20
>=20
> This is really nice to have!
Agreed.  I end up looking this up from time to time, so a local set of
definitions makes complete sense to have.

Thanks for doing this!
A few really minor additions to David's comments inline.

Thanks

Jonathan

>=20
> >  Documentation/iio/iio_adc.rst | 280 ++++++++++++++++++++++++++++++++++
> >  Documentation/iio/index.rst   |   1 +
> >  2 files changed, 281 insertions(+)
> >  create mode 100644 Documentation/iio/iio_adc.rst
> >=20
> > diff --git a/Documentation/iio/iio_adc.rst b/Documentation/iio/iio_adc.=
rst
> > new file mode 100644
> > index 000000000000..43b8cad547c9
> > --- /dev/null
> > +++ b/Documentation/iio/iio_adc.rst
> > @@ -0,0 +1,280 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> > +IIO Abstractions for ADCs
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> > +
> > +1. Overview
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +The IIO subsystem supports many Analog to Digital Converters (ADCs). S=
ome ADCs
> > +have features and characteristics that are supported in specific ways =
by IIO
> > +device drivers. This documentation describes common ADC features and e=
xplains
> > +how they are (should be?) supported by the IIO subsystem.
> > +
> > +1. ADC Channel Types
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +ADCs can have distinct types of inputs, each of them measuring analog =
voltages
> > +in a slightly different way. An ADC digitizes the analog input voltage=
 over a
> > +span given by the provided voltage reference, the input type, and the =
input
> > +polarity. The input range allowed to an ADC channel is needed to deter=
mine the
> > +scale factor and offset needed to obtain the measured value in real-wo=
rld
> > +units (millivolts for voltage measurement, milliamps for current measu=
rement,
> > +etc.).

Add some 'weasel' words in here.  There are more complex non linear ADCs an=
d ones
only capable of reaching some fraction of the reference voltage.
Maybe throw in a "generally" somewhere.

> > +
> > +There are three types of ADC inputs (single-ended, differential, =20
>                   ^
>                   | general
>=20
> > +pseudo-differential) and two possible polarities (unipolar, bipolar). =
The input
> > +type (single-ended, differential, pseudo-differential) is one channel
> > +characteristic, and is completely independent of the polarity (unipola=
r,
> > +bipolar) aspect. A comprehensive article about ADC input types (on whi=
ch this
> > +doc is heavily based on) can be found at
> > +https://www.analog.com/en/resources/technical-articles/sar-adc-input-t=
ypes.html.
> > +
...

> > +
> > +1.2.1 Differential Bipolar Channels
> > +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > +
> > +::
> > +
> > +  -------- +VREF ------
> > +    =C2=B4 `       =C2=B4 `               +-------------------+
> > +  /     \   /     \   /        /                    |
> > +         `-=C2=B4       `-=C2=B4    --- <  IN+                |
> > +  -------- -VREF ------        |                    |
> > +                               |            ADC     |
> > +  -------- +VREF ------        |                    |
> > +        =C2=B4 `       =C2=B4 `     --- <  IN-                |
> > +  \   /     \   /     \        \       +VREF  -VREF |
> > +   `-=C2=B4       `-=C2=B4                +-------------------+
> > +  -------- -VREF ------                  ^       ^
> > +                                         |       +---- External -VREF
> > +                                  External +VREF
> > +
> > +The analog signals to **differential bipolar** inputs are also allowed=
 to swing
> > +from -VREF to +VREF. If -VREF is below system GND, these are also call=
ed
> > +differential true bipolar inputs.
> > +
> > +Device tree example of a differential bipolar channel::
> > +
> > +    adc@0 {
> > +        ...
> > +        #address-cells =3D <1>;
> > +        #size-cells =3D <0>;
> > +
> > +        channel@0 {
> > +            reg =3D <0>;
> > +            bipolar;
> > +            diff-channels =3D <0 1>;
> > +        };
> > +    };
> > +
> > +In the ADC driver, `differential =3D 1` is set into `struct iio_chan_s=
pec` for the
> > +channel. See ``include/linux/iio/iio.h`` for more information.
> > +
> > +1.2.2 Differential Unipolar Channels
> > +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ =20
>=20
> To be consistent with the other sections, move unipolar before bipolar.

I'm not sure I agree on this.  It's the 'weird one', so some logic in intro=
ducing
it after bipolar differential.


> > diff --git a/Documentation/iio/index.rst b/Documentation/iio/index.rst
> > index 074dbbf7ba0a..15f62d304eaa 100644
> > --- a/Documentation/iio/index.rst
> > +++ b/Documentation/iio/index.rst
> > @@ -7,6 +7,7 @@ Industrial I/O
> >  .. toctree::
> >     :maxdepth: 1
> > =20
> > +   iio_adc =20
>=20
> Maybe make this iio_adc_inputs in case we make a general adc page in the =
future.

Can rename if we do.

>=20
> >     iio_configfs
> >     iio_devbuf
> >     iio_dmabuf_api =20
>=20
>=20


