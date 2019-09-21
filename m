Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45810B9F01
	for <lists+linux-iio@lfdr.de>; Sat, 21 Sep 2019 19:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438435AbfIURCg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 21 Sep 2019 13:02:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:40406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438423AbfIURCf (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 21 Sep 2019 13:02:35 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 596B6218AE;
        Sat, 21 Sep 2019 17:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569085353;
        bh=+eivYeMB4zXYSXi33fhDhabwWSnXlcY1R+z/w7wzxKk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HSTBY/xh6AZFAW05HULSob5vPyy3Bfh126OT1bvAqBmbEcnT4iLQbXayhRO5wy5m8
         tsXZ/lTYp7rpyR+aCMfCd0YhQhS00Xu/Wxq6/5NtIsYHzD3SFrjIezZnlY9bXQsJSI
         FWhPN/2PylUXTcMZvb38nvZqF6SMFXhWR+IJq0e8=
Date:   Sat, 21 Sep 2019 18:02:29 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Sa, Nuno" <Nuno.Sa@analog.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "lars@metafoo.de" <lars@metafoo.de>
Subject: Re: [PATCH 1/2] iio: temperature: Add support for LTC2983
Message-ID: <20190921180229.3483d88e@archlinux>
In-Reply-To: <14a62c13cfd0175e03384ed691720c2db6fc086a.camel@analog.com>
References: <20190909144550.164488-1-nuno.sa@analog.com>
        <20190915122754.4a529e9e@archlinux>
        <14a62c13cfd0175e03384ed691720c2db6fc086a.camel@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 16 Sep 2019 09:37:18 +0000
"Sa, Nuno" <Nuno.Sa@analog.com> wrote:

> Hi Jonathan,
>=20
> Thanks for the review.
> Comments inline.
>=20
> Nuno S=C3=A1
>=20
> On Sun, 2019-09-15 at 12:27 +0100, Jonathan Cameron wrote:
> >=20
> > On Mon, 9 Sep 2019 16:45:49 +0200
> > Nuno S=C3=A1 <nuno.sa@analog.com> wrote:
> >  =20
> > > The LTC2983 is a Multi-Sensor High Accuracy Digital Temperature
> > > Measurement System. It measures a wide variety of temperature
> > > sensors and
> > > digitally outputs the result, in =C2=B0C or =C2=B0F, with 0.1=C2=B0C =
accuracy and
> > > 0.001=C2=B0C resolution. It can measure the temperature of all standa=
rd
> > > thermocouples (type B,E,J,K,N,S,R,T), standard 2-,3-,4-wire RTDs,
> > > thermistors and diodes.
> > >=20
> > > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com> =20
> > Some comments inline.  Main concern is around the interface, rest is
> > minor
> > stuff.
> >=20
> > Jonathan
> >  =20
> > > ---
> > >  .../testing/sysfs-bus-iio-temperature-ltc2983 |   43 +
> > >  MAINTAINERS                                   |    7 +
> > >  drivers/iio/temperature/Kconfig               |   10 +
> > >  drivers/iio/temperature/Makefile              |    1 +
> > >  drivers/iio/temperature/ltc2983.c             | 1327
> > > +++++++++++++++++
> > >  5 files changed, 1388 insertions(+)
> > >  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-
> > > temperature-ltc2983
> > >  create mode 100644 drivers/iio/temperature/ltc2983.c
> > >=20
> > > diff --git a/Documentation/ABI/testing/sysfs-bus-iio-temperature-
> > > ltc2983 b/Documentation/ABI/testing/sysfs-bus-iio-temperature-
> > > ltc2983
> > > new file mode 100644
> > > index 000000000000..3ad3440c0986
> > > --- /dev/null
> > > +++ b/Documentation/ABI/testing/sysfs-bus-iio-temperature-ltc2983
> > > @@ -0,0 +1,43 @@
> > > +What:		/sys/bus/iio/devices/iio:deviceX/in_tempY_therm
> > > istor_raw =20
> > For each of these, I presume we know which type of device is attached
> > at any time?
> > Using the channel naming to convey this (and I assume the fact that
> > different
> > conversions need to be done in userspace?) is a bit messy.  If we
> > need
> > to convey the channel type, then a separate in_tempY_mode attribute
> > may make more
> > sense.  That would keep this ABI 'closer' to standard. Software that
> > just logs
> > an unprocessed value could just work for example.
> >=20
> > I'm not sure I've totally understood what is going on here though.
> >  =20
> So, the `extend_name` does not really bring any functional advantage.
> It was just an easy way for someone to know which kind of sensor the
> channel was referring to. In terms of conversions, all the work is done
> by the part for all the different sensor's and the scale is the same
> for all of them. So, I can just drop the extended name and use standard
> ABI if you prefer?

Please do.  It may make sense to add an additional attribute to provide
the info on the type of sensor, but we don't want to do anything that
will create new ABI in the basic read path.


...
> > > +
> > > +static int __maybe_unused ltc2983_suspend(struct device *dev)
> > > +{
> > > +	struct ltc2983_data *st =3D spi_get_drvdata(to_spi_device(dev));
> > > +	int ret;
> > > +
> > > +	mutex_lock(&st->lock);
> > > +	ret =3D regmap_write(st->regmap, LTC2983_STATUS_REG,
> > > LTC2983_SLEEP);
> > > +	st->reset =3D true; =20
> >=20
> > Naming seems a bit odd. The register field is called sleep, but we
> > call
> > it reset internally? =20
> I agree. Something like `suspend` or `sleep` for the boolean would be
> ok?

yes.

> > > +	mutex_unlock(&st->lock);
> > > +
> > > +	return ret;
> > > +}
> > > +
> > > +static SIMPLE_DEV_PM_OPS(ltc2983_pm_ops, ltc2983_suspend,
> > > ltc2983_resume);
> > > +
> > > +static const struct spi_device_id ltc2983_id_table[] =3D {
> > > +	{ "ltc2983" },
> > > +	{},
> > > +};
> > > +MODULE_DEVICE_TABLE(spi, ltc2983_id_table);
> > > +
> > > +static const struct of_device_id ltc2983_of_match[] =3D {
> > > +	{ .compatible =3D "adi,ltc2983" },
> > > +	{},
> > > +};
> > > +MODULE_DEVICE_TABLE(of, ltc2983_id_table);
> > > +
> > > +static struct spi_driver ltc2983_driver =3D {
> > > +	.driver =3D {
> > > +		.name =3D "ltc2983",
> > > +		.of_match_table =3D ltc2983_of_match,
> > > +		.pm =3D &ltc2983_pm_ops,
> > > +	},
> > > +	.probe =3D ltc2983_probe,
> > > +	.id_table =3D ltc2983_id_table,
> > > +};
> > > +
> > > +module_spi_driver(ltc2983_driver);
> > > +
> > > +MODULE_AUTHOR("Nuno Sa <nuno.sa@analog.com>");
> > > +MODULE_DESCRIPTION("Analog Devices LTC2983 SPI Temperature
> > > sensors");
> > > +MODULE_LICENSE("GPL"); =20
>=20

