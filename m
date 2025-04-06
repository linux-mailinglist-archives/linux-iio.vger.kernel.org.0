Return-Path: <linux-iio+bounces-17661-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3644A7CDAE
	for <lists+linux-iio@lfdr.de>; Sun,  6 Apr 2025 13:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A52A23B293A
	for <lists+linux-iio@lfdr.de>; Sun,  6 Apr 2025 11:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C991C549E;
	Sun,  6 Apr 2025 11:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qxrpw9x/"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF5D1C3BE3;
	Sun,  6 Apr 2025 11:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743937715; cv=none; b=kxrEIbtKQpkf0NSNLv9UlnIAyLtuZcNoYmwKaYgXfDWkEuKgcyzTCmNErwNg2Q7vxG8AXNxDbEES9/UfIONquQt0tEDf5uIOJYYbgWbixvXTa5/HX/keV18nhy1IN+f2SpGNu2MCWmOiEZSHkH/sg7Iww2O0F6EhhcH4aVLRnWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743937715; c=relaxed/simple;
	bh=oBmAzxjhp7mJqD6p6LasQZgVUcBakosqINxBsK7ZtXs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nPkR8FmvPaZz1Gxzfr6iXLc26xgxLtKUFrrRgfuwdisy7g5keYq+g1wkuGVdmTkUleq1niKL526VrEtQwBlpnaAmsoa087FgMd5mH+hGToKA0eus3s0Sowoe6pHfQYIju/uZFeKNXeZgG9EhqRkPy+o2pe4NZEQfGjAzep6y3Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qxrpw9x/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 150E4C4CEEA;
	Sun,  6 Apr 2025 11:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743937714;
	bh=oBmAzxjhp7mJqD6p6LasQZgVUcBakosqINxBsK7ZtXs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qxrpw9x/zFnW1kQVc8EhU1TdH52+BExKfz5WOlP2aKjGoydpOuPDG0d4q17bZVeG3
	 1XDbxZqu3pK0ztfe+buvsXyHyWeNq0S+Lu34mg+origft2rJzxnujIOHlBB4eFsKG0
	 vcdgGSium+SHE4uimHqLuOoU6pdHxzhk0VQl/ZQ2f1QMpyqYbINM9isEk0mZb9AH1M
	 G8sKM5ry4aOyfJjZEVL6fb9iAZB5aESPrnvePl1Y8C1gfe2YMxARUWH0ZUw/J2QUPa
	 f0dPoUV2RiQqQoILvap/5Fr3kG/k2Z/u39NIbOPuOZQuWeqTzdIlWK08+48xfNskoX
	 QCO98XgGNVm3w==
Date: Sun, 6 Apr 2025 12:08:25 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andreas Klinger <ak@it-klinger.de>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 lars@metafoo.de, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, javier.carrasco.cruz@gmail.com,
 mazziesaccount@gmail.com, subhajit.ghosh@tweaklogic.com,
 muditsharma.info@gmail.com, arthur.becker@sentec.com,
 ivan.orlov0322@gmail.com, Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH 2/3] iio: light: add support for veml6046x00 RGBIR color
 sensor
Message-ID: <20250406120825.41b2575c@jic23-huawei>
In-Reply-To: <Z_I-qwzUrTNz1DZp@mail.your-server.de>
References: <20250316113131.62884-1-ak@it-klinger.de>
	<20250316113131.62884-3-ak@it-klinger.de>
	<20250317115005.72a539a0@jic23-huawei>
	<Z_I-qwzUrTNz1DZp@mail.your-server.de>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 6 Apr 2025 10:43:23 +0200
Andreas Klinger <ak@it-klinger.de> wrote:

> Hi Jonathan,
>=20
> I need to pick up the meaning of scale once again for clarification.
>=20
> Jonathan Cameron <jic23@kernel.org> schrieb am Mo, 17. M=C3=A4r 11:50:
> > On Sun, 16 Mar 2025 12:31:30 +0100
> > Andreas Klinger <ak@it-klinger.de> wrote:
> >  =20
> > > +static int veml6046x00_get_scale(struct veml6046x00_data *data,
> > > +				 int *val, int *val2) =20
> >=20
> > How is this related to integration time?  I'd normally expect
> > to see that read in here somewhere as well as doubling integration
> > time tends to double scale. =20
>=20
> In the documentation file "sysfs-bus-iio" it says:
> "
> What:           /sys/.../iio:deviceX/in_illuminanceY_raw
> [...]
> Description:
>                 Illuminance measurement, units after application of scale
>                                 and offset are lux.
> "
>=20
> This means that the scale should be the real factor and not the gain mult=
iplied
> by photodiode size (PDDIV) as i implemented it so far.
>=20
> This means also that doubling integration time should halve the scale. The
> higher raw value should lead to the same lux value.

Sounds correct.

>=20
> The documentation of the sensor (veml6046x00.pdf) provides us the calcula=
tion
> between raw green values and lux.
> Wouldn't it be better to give the user the real factor to be able to get =
lux?

Absolutely.  That's the expectation if we are providing illuminance_raw and
illuminance_scale.

>=20
> The fact that only the green channel can be used for calculation could be
> documented in the driver.

Ah. One of these devices.  Hmm. Why do people pretend they can get from
Green to illuminance.  That has to assume 'white light'.
I get grumpy about this, but if it is the best we can do I guess we have
to live with it (I might not be consistent on this).

>=20
> Then i found the "in_illuminance_hardwaregain" property. It seems that th=
is is
> exactly what the combination of gain and PDDIV is used for.
>=20
> So what is the scale at the moment could become the hardwaregain and the =
scale
> the factor from raw value to lux.

If it is useful to export it separately that works, however it's not typica=
lly
the control attribute - those tend to be read only because, without access =
to
datasheets simple software has no idea how to control them.

The alternative is the GTS helpers that attempt to figure out the best
way to meet the user requirements in setting the integration time and ampli=
fier
gain when a scale is requested.

+CC Matti who is the expert on those.


>=20
>=20
> To sum up the suggested interface under /sys/bus/iio/devices/iio\:deviceX=
 would
> be something like:
>=20
> in_illuminance_hardwaregain --> set and get gain and PDDIV on the sensor

This is usually the read only one as it reflects things that aren't
easy for a userspace program / user to tune.  They typically want to control
integration time because it reflects noise level and scale because they want
to avoid saturation etc and because we need it to get to the actual value
in lux.

>=20
> integration_time            --> set and get integration time on the sensor
driving these directly is fine.
>=20
> integration_time_available  --> show available integration time values
>=20
> scale                       --> (only) get real calculation value, taken =
from
>                                 sensor documenation, e.g. 1.3440
This should remain a main control attribute.
>=20
> scale_available             --> not existing anymore
This gets tricky but the GTS helpers will calculate it for you I think.

Jonathan

>=20
>=20
> What do you think?
>=20
> Andreas
>=20


