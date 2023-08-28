Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F11F778BA73
	for <lists+linux-iio@lfdr.de>; Mon, 28 Aug 2023 23:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjH1Vua (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 28 Aug 2023 17:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233855AbjH1VuL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 28 Aug 2023 17:50:11 -0400
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 189DD186
        for <linux-iio@vger.kernel.org>; Mon, 28 Aug 2023 14:50:07 -0700 (PDT)
Date:   Mon, 28 Aug 2023 21:49:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=elementarea.net;
        s=protonmail3; t=1693259404; x=1693518604;
        bh=8JhmInorRNbyWE4vmvDnBIpqY1K7kOB/P3D6yMlT/Es=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=kko6iHPG/mJAxMQpQ5BZqftjzL0ZtfaByH5dznkNOELA67yiS7nBtXTtXj7cTKD8S
         RvvsE+HyZ5AhLaVEuxnrEJ+cVn9ei+UTKKyaKamb/Y6wF158c73k5vhABCX5K/8pWQ
         YS6imHRXO6Is91Ar4t4pNIAjweon0n+IXkXncYzPtZN0qLrTUbzOKom1hBP2h2CpJx
         uUtc/rWNayREW+7g40X4omLmngonFcUXUsEyuPzZHfoRkeUBkYKZhrk+XmU45rS5Cd
         T1qLBGZ8LiBHWYo2tOOvsq8SwdBNnUhnC9SV+oB/g+nq5323WfwTPDTg04OTuKvdbU
         VRqUST7J+Jsbg==
To:     Jonathan Cameron <jic23@kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
From:   Andreas Brauchli <a.brauchli@elementarea.net>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        =?utf-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?utf-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-renesas-soc@vger.kernel.org,
        Pascal Sachs <pascal.sachs@sensirion.com>
Subject: Re: [PATCH] iio: chemical: sgp30: Convert enum->pointer for data in the match tables
Message-ID: <a8a0ea077c55c00c83e65a9f6f4c574378720c4f.camel@elementarea.net>
In-Reply-To: <20230828171326.7623a254@jic23-huawei>
References: <20230812165730.216180-1-biju.das.jz@bp.renesas.com> <20230828171326.7623a254@jic23-huawei>
Feedback-ID: 30354973:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 2023-08-28 at 17:13 +0100, Jonathan Cameron wrote:
> On Sat, 12 Aug 2023 17:57:30 +0100
> Biju Das <biju.das.jz@bp.renesas.com> wrote:
>=20
> > Convert enum->pointer for data in the match tables, so that
> > device_get_match_data() can do match against OF/ACPI/I2C tables,
> > once i2c
> > bus type match support added to it.
> >=20
> > Add product_id variable to struct sgp_device and remove the local
> > variable
> > product_id in probe() and replace enum->struct *sgp_device for data
> > in the
> > match table. Simplify theprobe() by replacing
> > device_get_match_data() and
> > ID lookup for retrieving data by i2c_get_match_data().
> >=20
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> +CC Andreas (comments still welcome!)
ACK. Thanks, LGTM.

+CC Pascal at Sensirion

>=20
> Applied to the togreg branch of iio.git but only pushed out as
> testing for
> now because I'll be rebasing on rc1 once available.=C2=A0 0-day can poke
> at
> it in the meantime.
>=20
> Thanks,
>=20
> Jonathan
>=20
> > ---
> > =C2=A0drivers/iio/chemical/sgp30.c | 24 ++++++++++++------------
> > =C2=A01 file changed, 12 insertions(+), 12 deletions(-)
> >=20
> > diff --git a/drivers/iio/chemical/sgp30.c
> > b/drivers/iio/chemical/sgp30.c
> > index b509cff9ce37..21730d62b5c8 100644
> > --- a/drivers/iio/chemical/sgp30.c
> > +++ b/drivers/iio/chemical/sgp30.c
> > @@ -114,6 +114,7 @@ struct sgp_data {
> > =C2=A0};
> >=20
> > =C2=A0struct sgp_device {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned long product_id;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0const struct iio_chan_s=
pec *channels;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int num_channels;
> > =C2=A0};
> > @@ -182,10 +183,12 @@ static const struct iio_chan_spec
> > sgpc3_channels[] =3D {
> >=20
> > =C2=A0static const struct sgp_device sgp_devices[] =3D {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[SGP30] =3D {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0.product_id =3D SGP30,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.channels =3D sgp30_channels,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.num_channels =3D ARRAY_SIZE(sgp30_channels),
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0},
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[SGPC3] =3D {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0.product_id =3D SGPC3,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.channels =3D sgpc3_channels,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.num_channels =3D ARRAY_SIZE(sgpc3_channels),
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0},
> > @@ -491,28 +494,25 @@ static const struct iio_info sgp_info =3D {
> > =C2=A0};
> >=20
> > =C2=A0static const struct of_device_id sgp_dt_ids[] =3D {
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{ .compatible =3D "sensirion=
,sgp30", .data =3D (void *)SGP30 },
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{ .compatible =3D "sensirion=
,sgpc3", .data =3D (void *)SGPC3 },
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{ .compatible =3D "sensirion=
,sgp30", .data =3D
> > &sgp_devices[SGP30] },
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{ .compatible =3D "sensirion=
,sgpc3", .data =3D
> > &sgp_devices[SGPC3] },
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{ }
> > =C2=A0};
> >=20
> > =C2=A0static int sgp_probe(struct i2c_client *client)
> > =C2=A0{
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0const struct i2c_device=
_id *id =3D
> > i2c_client_get_device_id(client);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0const struct sgp_device *mat=
ch_data;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct device *dev =3D =
&client->dev;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct iio_dev *indio_d=
ev;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct sgp_data *data;
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned long product_id;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int ret;
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0indio_dev =3D devm_iio_=
device_alloc(dev, sizeof(*data));
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!indio_dev)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return -ENOMEM;
> >=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (dev_fwnode(dev))
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0product_id =3D (unsigned
> > long)device_get_match_data(dev);
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0else
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0product_id =3D id->driver_data;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0match_data =3D i2c_get_match=
_data(client);
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0data =3D iio_priv(indio=
_dev);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0i2c_set_clientdata(clie=
nt, indio_dev);
> > @@ -528,15 +528,15 @@ static int sgp_probe(struct i2c_client
> > *client)
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0data->feature_set =3D b=
e16_to_cpu(data-
> > >buffer.raw_words[0].value);
> >=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D sgp_check_compat(dat=
a, product_id);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D sgp_check_compat(dat=
a, match_data->product_id);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (ret)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return ret;
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0indio_dev->info =3D &sg=
p_info;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0indio_dev->name =3D id-=
>name;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0indio_dev->modes =3D IN=
DIO_DIRECT_MODE;
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0indio_dev->channels =3D sgp_=
devices[product_id].channels;
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0indio_dev->num_channels =3D
> > sgp_devices[product_id].num_channels;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0indio_dev->channels =3D matc=
h_data->channels;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0indio_dev->num_channels =3D =
match_data->num_channels;
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0sgp_init(data);
> >=20
> > @@ -562,8 +562,8 @@ static void sgp_remove(struct i2c_client
> > *client)
> > =C2=A0}
> >=20
> > =C2=A0static const struct i2c_device_id sgp_id[] =3D {
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{ "sgp30", SGP30 },
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{ "sgpc3", SGPC3 },
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{ "sgp30", (kernel_ulong_t)&=
sgp_devices[SGP30] },
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{ "sgpc3", (kernel_ulong_t)&=
sgp_devices[SGPC3] },
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{ }
> > =C2=A0};
> >=20
>=20


