Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04DB32277B
	for <lists+linux-iio@lfdr.de>; Sun, 19 May 2019 19:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725799AbfESRHW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 19 May 2019 13:07:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:58244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725769AbfESRHV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 19 May 2019 13:07:21 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 261A121773;
        Sun, 19 May 2019 11:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558264144;
        bh=EWgtkwVlfGD1NpiyhG72Pl8PdGw5ndsf4DuG+VXBfoQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SU6WiHoGoZwJA0tSPSr8Ct/WNAg1LtBoU6srRdyCmijlkebPylyz4FaGaB3XPni5e
         3IYxkD1ZBKMrCjjzwLIpMg3xsk8CW+vwXEt/hC9rVDq4QVdm95e5JGj05RMiX1jJZn
         KruLdpWUU8gLN7dBNDKMrc8SYGvZisuKG077+660=
Date:   Sun, 19 May 2019 12:09:00 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     =?UTF-8?B?Sm/Do28=?= Seckler <joaoseckler@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: iio: ad7746: add device tree support
Message-ID: <20190519120900.3bef9481@archlinux>
In-Reply-To: <20190519120250.4644c255@archlinux>
References: <20190518222733.2ttcgvy7fct4awra@smtp.gmail.com>
        <20190519120250.4644c255@archlinux>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 19 May 2019 12:02:50 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Sat, 18 May 2019 19:27:33 -0300
> Jo=C3=A3o Seckler <joaoseckler@gmail.com> wrote:
>=20
> > Add a of_device_id struct variable and subsequent call to
> > MODULE_DEVICE_TABLE macro to support device tree.
> >=20
> > Signed-off-by: Jo=C3=A3o Seckler <joaoseckler@gmail.com>
> > Signed-off-by: Lucas Oshiro <lucasseikioshiro@gmail.com>
> > Co-developed-by: Lucas Oshiro <lucasseikioshiro@gmail.com> =20
> Applied to the togreg branch of iio.git and pushed out as testing
> for the autobuilders to play with it.
>=20
> For a future improvement, try to explain the 'why' rather than
> 'what' of a patch in the description.   This particular change
> is so common I don't mind that much, but it is a good habit to
> get into!
Ah, you do say to support device tree at the end, but more
detail on that would have been good!

Thanks,

J
>=20
> Thanks,
>=20
> Jonathan
> > ---
> >  drivers/staging/iio/cdc/ad7746.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >=20
> > diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc=
/ad7746.c
> > index 47610d863908..21527d84f940 100644
> > --- a/drivers/staging/iio/cdc/ad7746.c
> > +++ b/drivers/staging/iio/cdc/ad7746.c
> > @@ -748,9 +748,19 @@ static const struct i2c_device_id ad7746_id[] =3D {
> > =20
> >  MODULE_DEVICE_TABLE(i2c, ad7746_id);
> > =20
> > +static const struct of_device_id ad7746_of_match[] =3D {
> > +	{ .compatible =3D "adi,ad7745" },
> > +	{ .compatible =3D "adi,ad7746" },
> > +	{ .compatible =3D "adi,ad7747" },
> > +	{ },
> > +};
> > +
> > +MODULE_DEVICE_TABLE(of, ad7746_of_match);
> > +
> >  static struct i2c_driver ad7746_driver =3D {
> >  	.driver =3D {
> >  		.name =3D KBUILD_MODNAME,
> > +		.of_match_table =3D ad7746_of_match,
> >  	},
> >  	.probe =3D ad7746_probe,
> >  	.id_table =3D ad7746_id, =20
>=20

