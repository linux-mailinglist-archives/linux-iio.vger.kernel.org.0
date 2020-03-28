Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 897F01966E9
	for <lists+linux-iio@lfdr.de>; Sat, 28 Mar 2020 16:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbgC1PVi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 28 Mar 2020 11:21:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:36312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725807AbgC1PVi (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 28 Mar 2020 11:21:38 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABE2420716;
        Sat, 28 Mar 2020 15:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585408897;
        bh=JsWNCW+E/FEvlrY/8s2LDzeUVPhR7r4MU73MoQkf4Hc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JrB75c10YUkNmTzgLlSKKkmgW7nFIABie5ie0+dNbll+cbTahzAdsCleVbwpYWsLm
         7KuGqI88r9KwJw+mbFx8KcZ+oC4tiMnqN/UoOQ3YpK/7EQJOJJF51bhXPBmUUQKrAE
         Lbu7e8jSoUTP0TEoiGfnFTHqlg4TYcqIsMfVQw4E=
Date:   Sat, 28 Mar 2020 15:21:33 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Eugene Zalkonnikov <ez@norphonic.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "development@norphonic.com" <development@norphonic.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v6 1/2] Driver for TI HDC20x0 humidity and temperature
 sensors
Message-ID: <20200328152133.09095af5@archlinux>
In-Reply-To: <F8BF24B6-5686-437E-8EE4-1A2151C848CF@norphonic.com>
References: <84EE5291-D8C4-40D3-A75C-92362BF9DF8B@norphonic.com>
        <20200322161722.0feb8da8@archlinux>
        <F8BF24B6-5686-437E-8EE4-1A2151C848CF@norphonic.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 23 Mar 2020 14:39:34 +0000
Eugene Zalkonnikov <ez@norphonic.com> wrote:

> Hi Jonathan,
>=20
> > On 22 Mar 2020, at 17:17, Jonathan Cameron <jic23@kernel.org> wrote: =20
> >> +static int hdc2010_write_raw(struct iio_dev *indio_dev,
> >> +			     struct iio_chan_spec const *chan,
> >> +			     int val, int val2, long mask)
> >> +{
> >> +	struct hdc2010_data *data =3D iio_priv(indio_dev);
> >> +	int new, ret =3D -EINVAL; =20
> >=20
> > Unless I'm half asleep (which is possible :) ret is always
> > written below before being used.  Hence this init isn't needed.
> >  =20
> I suspect it=E2=80=99s a vestige from before all stylistic rewrites in re=
cent patches.=20
> Same for the shared returns. Will change that.
>=20
> >> +
> >> +	indio_dev->dev.parent =3D &client->dev;
> >> +	indio_dev->name =3D dev_name(&client->dev); =20
> >=20
> > That should be the part number.  IIRC that's not what you'll get
> > from dev_name called on the i2c device.  Note we let a few of
> > these in in the past and are now stuck with them...=20
> >  =20
> My access to actual hw is limited now, so to reduce the iterations here: =
what
> is going to be a suitable device name? Would =E2=80=9Chdc20x0=E2=80=9D do=
? =E2=80=9Chdc2010=E2=80=9D?
Should match the part so hdc2010 or hdc2080 as appropriate. No wild cards.
>=20
>=20
> Regards,
>   Eugene.
