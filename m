Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA858107EBD
	for <lists+linux-iio@lfdr.de>; Sat, 23 Nov 2019 15:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbfKWOPU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 23 Nov 2019 09:15:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:55502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726524AbfKWOPU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 23 Nov 2019 09:15:20 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B8A6205C9;
        Sat, 23 Nov 2019 14:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574518519;
        bh=uI4rimQXWPAfHwLl1iypdUeaUk/AsqK7GNtaATN05/4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Kf0tuNuPBqTxBz2ySYJ1qRYpqRRNVL5K4Tm/+yCmiRe59J9YWZ/SFAgjdNq/hem3Z
         H8leyO1C08rM5cNiNlrlM91zaYhsHt4+aNiNmT5LykUH9yF7HrNeISpLm+Lpddgh3L
         +M34+DDnzD0IGX5VpN2ZAd/7LKmYwNElOg0/Gkq4=
Date:   Sat, 23 Nov 2019 14:15:15 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Eugene Zaikonnikov <eugene.zaikonnikov@norphonic.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        development@norphonic.com, linux-iio@vger.kernel.org
Subject: Re: [PATCH 0/1] Add support for TI HDC200x humidity and temperature
 sensors
Message-ID: <20191123141515.55d9eebc@archlinux>
In-Reply-To: <996dd531-cbc6-9ecc-0a67-0a9b8e686c0c@norphonic.com>
References: <71176abd-4997-70f8-8132-137fadda7768@norphonic.com>
        <20191103121921.5b1d0b02@archlinux>
        <996dd531-cbc6-9ecc-0a67-0a9b8e686c0c@norphonic.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 22 Nov 2019 15:50:43 +0100
Eugene Zaikonnikov <eugene.zaikonnikov@norphonic.com> wrote:

> Jonathan,
>=20
> Just got back to fixing most of the issues you pointed out, excepting the=
se:
>=20
> On 03.11.2019 13:19, Jonathan Cameron wrote:
>=20
> > + =20
> >> +static const struct iio_chan_spec hdc200x_channels[] =3D {
> >> +=C2=A0=C2=A0=C2=A0 {
> >> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 .type =3D IIO_TEMP,
> >> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 .extend_name =3D "Temperature",=
 =20
> > Any use of extend_name changes the ABI and should be done extremely
> > carefully.  It basically means that generic userspace code cannot
> > use your driver.
> >
> > Here I can't see any advantage in doing so at all so drop it. =20
>=20
> If I have two temperature channels and provide no extend_name to at least=
 one of them, they fail to register.
This only worked on the assumption that you could use PEAK below so only
have one channel for both.

Alternative would be to index them, but that doesn't make much sense here e=
ither.

>=20
> > =20
> >> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 },
> >> +=C2=A0=C2=A0=C2=A0 },
> >> +=C2=A0=C2=A0=C2=A0 {
> >> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 .type =3D IIO_TEMP,
> >> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 .extend_name =3D "Temperature_M=
AX", =20
> > Could we use the IIO_CHAN_INFO_PEAK element for this?  Given
> > the different scale, we'd need to do some work to make it
> > have the same scale as temp. =20
>=20
> Started looking into this.
> Are there any examples or docs of using IIO_CHAN_INFO_PEAK? Couldn't find=
 much in the IIO subtree.
> Is it used together with INFO_RAW? And temp&max temp channels have differ=
ent scales already.

ah. I missed they had different scale values.  That's unfortunate.
A simple work around for this might be to just multiply the output in the _=
MAX
case by 256.  That way the two would have the same scale which is assumed i=
f using
the IIO_RAW and IIO_PEAK together.

>=20
> >> +{
> >> +=C2=A0=C2=A0=C2=A0 char tmp =3D (~mask & data->drdy_config) | val;
> >> +=C2=A0=C2=A0=C2=A0 int ret;
> >> +
> >> +=C2=A0=C2=A0=C2=A0 ret =3D i2c_smbus_write_byte_data(data->client,
> >> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=
=C2=A0 =C2=A0=C2=A0=C2=A0 HDC200X_REG_RESET_DRDY_INT_CONF, tmp);
> >> +=C2=A0=C2=A0=C2=A0 if (!ret)
> >> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 data->drdy_config =3D tmp;
> >> +
> >> +=C2=A0=C2=A0=C2=A0 return ret;
> >> +}
> >> +
> >> +static int hdc200x_get_measurement_word(struct hdc200x_data *data,
> >> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=
=C2=A0 =C2=A0=C2=A0=C2=A0 struct iio_chan_spec const *chan) =20
> > These wrappers add relatively little.  I'd prefer that you just call
> > the i2c calls directly instead.  Less code and ultimately a tiny
> > bit easier to review. =20
>=20
> Removed wrappers that are called once. Leaving the wrapper called in diff=
erent places, makes intent more clear IMO.
Hmm. It's always a trade off.  Will see what the result looks
like!

Jonathan

>=20
> --
>=20
> =C2=A0 Eugene
>=20

