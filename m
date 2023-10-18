Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF7C57CE805
	for <lists+linux-iio@lfdr.de>; Wed, 18 Oct 2023 21:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbjJRTpS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Oct 2023 15:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231733AbjJRTpR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Oct 2023 15:45:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 545F2112;
        Wed, 18 Oct 2023 12:45:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DFBAC433CC;
        Wed, 18 Oct 2023 19:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697658314;
        bh=DOHZIzxJHV1onXNJBkxkTLgBiYI4wMryfFayE9a0DSc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=r5Mp7Y/WAS4WCy30ylHUMZYDG4MIAL3d3WzPiEuNNz479tSjNqfFYrEraHNeq7kYm
         xrPkC8tHxWUjx/x0i28/BQ64M8M7feGlC88sxSalMdQu0OGOWzArxz+v4eqvZLI0c4
         piXtiWKykinYnAPg0GyHLwks17YpWnPdFPdQwlTMsqSgWMlBYia30Yd+WoQnJss/TT
         c3fhXq/uJynzA6RsQH6H9/O9cWeLWPoNHoM9nBzdNrx2WcFkqlPUZCDKiXMQOvAhgo
         f/02WLeqKOHqegTdb1odgCnpoyujF282sjKD52gHtubQPBiMhoXQh20jsp6z7nqgfS
         UMVxg8KB7ZnNQ==
Date:   Wed, 18 Oct 2023 20:45:33 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     git@apitzsch.eu, Biju Das <biju.das.jz@bp.renesas.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2 1/5] iio: magnetometer: ak8975: Convert enum->pointer
 for data in the match tables
Message-ID: <20231018204533.39399b0b@jic23-huawei>
In-Reply-To: <CAMuHMdUTxQym7+vYPtnvMQeH8GKSk0iOyuMnLkgr3LH1E8TTYA@mail.gmail.com>
References: <20230818075600.24277-1-biju.das.jz@bp.renesas.com>
        <20230818075600.24277-2-biju.das.jz@bp.renesas.com>
        <5e0d2716fb757d408ebe77cb132ae242ef3aa470.camel@apitzsch.eu>
        <CAMuHMdUTxQym7+vYPtnvMQeH8GKSk0iOyuMnLkgr3LH1E8TTYA@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 18 Oct 2023 09:04:44 +0200
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> Hi Andr=C3=A9,
>=20
> On Tue, Oct 17, 2023 at 11:12=E2=80=AFPM Andr=C3=A9 Apitzsch <git@apitzsc=
h.eu> wrote:
> > Am Freitag, dem 18.08.2023 um 08:55 +0100 schrieb Biju Das: =20
> > > Convert enum->pointer for data in the match tables to simplify the
> > > probe()
> > > by replacing device_get_match_data() and i2c_client_get_device_id by
> > > i2c_get_match_data() as we have similar I2C, ACPI and DT matching
> > > table.
> > >
> > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com> =20
>=20
> > > --- a/drivers/iio/magnetometer/ak8975.c
> > > +++ b/drivers/iio/magnetometer/ak8975.c
> > > @@ -883,10 +883,7 @@ static int ak8975_probe(struct i2c_client
> > > *client)
> > >       struct iio_dev *indio_dev;
> > >       struct gpio_desc *eoc_gpiod;
> > >       struct gpio_desc *reset_gpiod;
> > > -     const void *match;
> > > -     unsigned int i;
> > >       int err;
> > > -     enum asahi_compass_chipset chipset;
> > >       const char *name =3D NULL;
> > >
> > >       /*
> > > @@ -928,27 +925,15 @@ static int ak8975_probe(struct i2c_client
> > > *client)
> > >               return err;
> > >
> > >       /* id will be NULL when enumerated via ACPI */
> > > -     match =3D device_get_match_data(&client->dev);
> > > -     if (match) {
> > > -             chipset =3D (uintptr_t)match;
> > > -             name =3D dev_name(&client->dev);
> > > -     } else if (id) {
> > > -             chipset =3D (enum asahi_compass_chipset)(id- =20
> > > >driver_data); =20
> > > -             name =3D id->name;
> > > -     } else
> > > -             return -ENOSYS;
> > > -
> > > -     for (i =3D 0; i < ARRAY_SIZE(ak_def_array); i++)
> > > -             if (ak_def_array[i].type =3D=3D chipset)
> > > -                     break;
> > > -
> > > -     if (i =3D=3D ARRAY_SIZE(ak_def_array)) {
> > > -             dev_err(&client->dev, "AKM device type unsupported:
> > > %d\n",
> > > -                     chipset);
> > > +     data->def =3D i2c_get_match_data(client);
> > > +     if (!data->def)
> > >               return -ENODEV;
> > > -     }
> > >
> > > -     data->def =3D &ak_def_array[i];
> > > +     /* If enumerated via firmware node, fix the ABI */
> > > +     if (dev_fwnode(&client->dev))
> > > +             name =3D dev_name(&client->dev);
> > > +     else
> > > +             name =3D id->name;
> > > =20
> >
> > I just noticed, that with the above change '0-000d' instead of the
> > previous and expected 'ak09911' is shown now as name for the
> > magnetometer in longcheer l9100 [1]. =20
>=20
> While this doesn't help much, note that the old name would break
> the case of having two instances of the same device.

Why? In IIO ABI, this is the part number - it's absolutely fine to have
two device with same name. There are lots of other ways of figuring out
which is which (parent device being the easiest).

This is indeed a bug but it isn't a new one and it's been there long
enough that there may be userspace code relying on it... =20

There are some of these from a time when I was being unobservant in
catching them in review (this one was approx 2014 I think)
We've never fixed them because of possibility of breaking usersapce.


>=20
> >
> > id->name contains the expected string ('ak09911'), but because of
> > dev_fwnode(&client->dev) being true, it is not used.
> >
> > Andr=C3=A9
> >
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git=
/tree/arch/arm64/boot/dts/qcom/msm8939-longcheer-l9100.dts?h=3Dnext-2023101=
7#n127 =20
>=20
> Gr{oetje,eeting}s,
>=20
>                         Geert
>=20

