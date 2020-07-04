Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01B3D21479C
	for <lists+linux-iio@lfdr.de>; Sat,  4 Jul 2020 19:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgGDREf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Jul 2020 13:04:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:40072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726639AbgGDREf (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 4 Jul 2020 13:04:35 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7837206BE;
        Sat,  4 Jul 2020 17:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593882274;
        bh=DkgPIls1+c5LNFEqZV01uTNJv3uWaayUf8Qlid7V49g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=yIKNSUaxN6i+9YxDBWVuHlCAyI5Nl9AmiIjkHWTsv2ZIB3vM1eOQCltPszIJ1k/Uf
         kRKgG8/XRPnfZkc3Mbx7G6bCYo8348AJqMw9I1uyTjrs8x+9RQugpcxUffEHsVJ+kr
         uZraLKdsWL6pl8TjTJEnJbmu3SvJxnG2Rwv+HFX8=
Date:   Sat, 4 Jul 2020 18:04:30 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-iio@vger.kernel.org, alexandru.Ardelean@analog.com,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: Re: [PATCH 09/23] iio:adc:ltc2497 drop of_match_ptr protection
Message-ID: <20200704180430.0a6d5df1@archlinux>
In-Reply-To: <20200628155324.y257v4tf5xvzb5xh@pengutronix.de>
References: <20200628123654.32830-1-jic23@kernel.org>
        <20200628123654.32830-10-jic23@kernel.org>
        <20200628155324.y257v4tf5xvzb5xh@pengutronix.de>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 28 Jun 2020 17:53:24 +0200
Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> wrote:

> On Sun, Jun 28, 2020 at 01:36:40PM +0100, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >=20
> > This prevents the driver being used with ACPI PRP0001 based
> > bindings. Also switch include to mod_devicetable.h which devices
> > the used id structure.
> >=20
> > Note this is most about removing something I don't want want cut
> > and paste into new driver rather than any thought that this particular
> > driver will be used in an ACPI system (though it might!)
> >=20
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Michael Hennerich <michael.hennerich@analog.com>
> > Cc: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> > ---
> >  drivers/iio/adc/ltc2497.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/iio/adc/ltc2497.c b/drivers/iio/adc/ltc2497.c
> > index 5db63d7c6bc5..1adddf5a88a9 100644
> > --- a/drivers/iio/adc/ltc2497.c
> > +++ b/drivers/iio/adc/ltc2497.c
> > @@ -11,7 +11,7 @@
> >  #include <linux/iio/iio.h>
> >  #include <linux/iio/driver.h>
> >  #include <linux/module.h>
> > -#include <linux/of.h>
> > +#include <linux/mod_devicetable.h>
> > =20
> >  #include "ltc2497.h"
> > =20
> > @@ -98,7 +98,7 @@ MODULE_DEVICE_TABLE(of, ltc2497_of_match);
> >  static struct i2c_driver ltc2497_driver =3D {
> >  	.driver =3D {
> >  		.name =3D "ltc2497",
> > -		.of_match_table =3D of_match_ptr(ltc2497_of_match),
> > +		.of_match_table =3D ltc2497_of_match, =20
>=20
> This was the copy source of ltc2496_driver. there the change was fine,
> so it is here:
>=20
> Reviewed-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
Applied thanks,

J

>=20
> Best regards
> Uwe
>=20

