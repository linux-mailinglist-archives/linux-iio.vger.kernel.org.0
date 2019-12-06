Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 749CE11564F
	for <lists+linux-iio@lfdr.de>; Fri,  6 Dec 2019 18:20:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbfLFRUi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 6 Dec 2019 12:20:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:58150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726284AbfLFRUi (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 6 Dec 2019 12:20:38 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C862321835;
        Fri,  6 Dec 2019 17:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575652837;
        bh=Pr+trFdFnGgbjsEI7TeElonAO3+mOvXNYagprnJOKE8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kf4H8SAr1/PJx313ybaar132FRdEKhCCg9zWi+/8Wb0R5jbWwx8rQfxp05B9qIel6
         o0spE/Ki0Xz/OkPlC1PQbWukpcSueHFL7019hqdF0TrPOv1nTFGlJ8YjlomOvp88FO
         1baUGKRPjrId6oEg3kjTMwCw2L3+jmdf3Bqo1aKU=
Date:   Fri, 6 Dec 2019 17:20:33 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Eugene Zaikonnikov <eugene.zaikonnikov@norphonic.com>
Cc:     Eugene Zalkonnikov <ez@norphonic.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "development@norphonic.com" <development@norphonic.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] Driver for TI HDC20x0 humidity and temperature
 sensors
Message-ID: <20191206172033.278503b6@archlinux>
In-Reply-To: <221cc09d-340c-b5b5-7af6-0608588598a1@norphonic.com>
References: <1FA22019-2D01-45B2-9C6B-0F6720F1B4A2@norphonic.com>
        <20191201123606.1db0d5b1@archlinux>
        <221cc09d-340c-b5b5-7af6-0608588598a1@norphonic.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 3 Dec 2019 09:10:49 +0000
Eugene Zaikonnikov <eugene.zaikonnikov@norphonic.com> wrote:

> On 01.12.2019 13:36, Jonathan Cameron wrote:
> > =20
> >> Heater out has been converted to IIO_CHAN_INFO_ENABLE, hope it is
> >> idiomatic use. =20
> > Hmm. This is one of those cases where we are probably better off
> > matching existing drivers even if they are a bit illogical.
> >
> > The enable element is mainly used for counting type sensors (start
> > counting steps etc) where there is a clear difference between it
> > being on and taking a measurement. =20
> OK, will revert that to prior.
> > +static const struct iio_chan_spec hdc2010_channels[] =3D { =20
> >> +	{
> >> +		.type =3D IIO_TEMP,
> >> +		.address =3D HDC2010_REG_TEMP_LOW,
> >> +		.info_mask_shared_by_type =3D
> >> BIT(IIO_CHAN_INFO_OFFSET) |
> >> +			BIT(IIO_CHAN_INFO_SCALE),
> >> +		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),
> >> +	},
> >> +	{
> >> +		.type =3D IIO_TEMP,
> >> +		.address =3D HDC2010_REG_TEMP_MAX,
> >> +		.info_mask_separate =3D BIT(IIO_CHAN_INFO_PEAK), =20
> > Not sure I like this approach of a separate channel.  The intent of
> > my previous review as to suggest we used a single channel. Here
> > we are really just adding one to get an address.  Whilst it works
> > today, this sort of unusual structure can make it harder to refactor
> > core elements of the code in the future.
> >
> > I'd rather see a bit of indirection where address actually gives
> > an enum value from which the data and _MAX registers can be
> > established via a lookup in an associated array. =20
>=20
> I see what you mean now. Was taking the name of .address field
> literally, but if anything goes there, sure.
>=20

> While we are at it, there are four r/w threshold registers on the
> device for rh/temp. Should one implement them in the future, are they
> going to be also mixed into these somehow or can they be own event
> channels?

Look at the datasheet, that is one high and one low for each of
rh and temp?  Initially I thought you meant 2 in each direction for
each channel which we don't support (there is no means of
encoding it in the event code to userspace).

That can be handled just fine using the event setup for each channel
as one channel can have multiple event specs.

Thanks,

Jonathan



>=20
>=20
> --
>=20
> =C2=A0 Eugene
>=20

