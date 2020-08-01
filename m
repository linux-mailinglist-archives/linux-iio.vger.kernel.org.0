Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 470AE23531D
	for <lists+linux-iio@lfdr.de>; Sat,  1 Aug 2020 17:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbgHAPz1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 1 Aug 2020 11:55:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:52916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725841AbgHAPz0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 1 Aug 2020 11:55:26 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4F2E207BC;
        Sat,  1 Aug 2020 15:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596297326;
        bh=tZ5XajEXBDCNdvkEIUQd7cfRvOz8RKCWcDoXMi9uMf4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Lydeae+w/HcXvgmKM+YtX2uEnZzIDaso1sFDwddswOfnEq1WqS3W/Yq5C5Pcbrz4o
         yPKHynn/DDjbqquIKM5N8fM88eGWidXBvBcgMtd8OirnWdPVwP8rV4MYxUnLRpz6V3
         ux4R/3ElDxw2HWNr/Qk2CE/+uNud8vnx7AFy21Gc=
Date:   Sat, 1 Aug 2020 16:55:20 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Christian Eggers <ceggers@arri.de>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rob Herring <robh+dt@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] iio: light: as73211: New driver
Message-ID: <20200801165520.56b73fc2@archlinux>
In-Reply-To: <2665878.D8vGGo3OXt@n95hx1g2>
References: <20200728062831.1143-1-ceggers@arri.de>
        <20200728062831.1143-3-ceggers@arri.de>
        <20200728190114.00004636@Huawei.com>
        <2665878.D8vGGo3OXt@n95hx1g2>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 30 Jul 2020 12:18:56 +0200
Christian Eggers <ceggers@arri.de> wrote:

> Hi Jonathan.
>=20
> got your review nearly simultaneous with Andy's. There are many overlaps
> between both. Most is already integrated, below I left only the open poin=
ts.
>=20
> On Tuesday, 28 July 2020, 20:01:14 CEST, Jonathan Cameron wrote:
> > Hi Christian,
> >
> > I took a fairly quick look. Not divided into the datasheet or anything =
yet! =20
>=20
> > Christian Eggers <ceggers@arri.de> wrote: =20
> > > +/**
> > > + * struct as73211_data - Instance data for one AS73211
> > > + * @client: I2C client.
> > > + * @osr:    Cached Operational State Register.
> > > + * @creg1:  Cached Configuration Register 1.
> > > + * @creg2:  Cached Configuration Register 2.
> > > + * @creg3:  Cached Configuration Register 3. =20
> >
> > Just a thought, but why not creg[3]?; =20
> creg[3] would be indexed from 0 to 2. But the datasheet names them 1 to 3.
>=20
> > > + * @buffer: Buffer for triggered measurements. =20
> >
> > ?  Run kernel-doc, or build with W=3D1 and to check docs. =20
> I ran "make htmldoc" and enabled W=3D1. Are there any errors I should see?
>=20
> > > +static unsigned int as73211_integration_time_us(struct as73211_data
> > > *data)
> > > +{
> > > +   /* Integration time has 15 steps, the step size depends on the =20
> clock. */
> > > +   unsigned int mul =3D 1 << (3 - (data->creg3 & 0b11));  /* 8 =3D 1=
.024 =20
> MHz, 4
> > > =3D 2.048 MHz ...*/ + unsigned int time_cycles =3D
> > > as73211_integration_time_cycles(data); +    unsigned int time_us =3D
> > > time_cycles * 125 * mul; =20
> >
> > This would be easier to read as
> >
> >       unsigned int mul, time_cycles;
> >
> >       mul =3D ...
> >
> >       return time_cycles * 125 * mul;
> > =20
> changed this according to Andy's proposal.
>=20
> > > +static int as73211_read_raw(struct iio_dev *indio_dev,
> > > +                   struct iio_chan_spec const *chan,
> > > +                   int *val, int *val2, long mask) =20
> >
> > Align parameters with opening bracket. =20
> Mixed tabs(8) and spaces or only spaces?

Tabs and spaces.

>=20
> > > +static int _as73211_write_raw(struct iio_dev *indio_dev,
> > > +                   struct iio_chan_spec const *chan =20
> __always_unused,
> >
> > Whilst true, what's the benefit of marking that as __always_unused?
> > =20
> I read somewhere in the process docs that I should build with EXTRA_CFLAG=
S=3D-W

Probably a bit paranoid for a callback, but doesn't really matter.

>=20
> > > +           } else {
> > > +                   /* saturate all channels (useful for =20
> overflows) */
> > > +                   iio_buffer[1] =3D 0xffff;
> > > +                   iio_buffer[2] =3D 0xffff;
> > > +                   iio_buffer[3] =3D 0xffff; =20
> >
> > That is rather non standard. =20
> How do other drivers handle measurement errors in buffered mode? The
> application needs to know about measurement overflows as the integration
> time and gain have to be adjusted in case.

It's actually pretty rare to have a device that reports and error.
Many just saturate.  So it's probably fine to mimic that here as long
as the issue is definitely saturation rather than some other error.
If it's another error, don't push data and log some sort of message.
Unfortunately there isn't really a standard interface for
reporting hardware faults in these sort of devices.

=46rom what you have said I'll assume we are just looking at overflow
so can mimic saturation. In which case what you have done is fine.

>=20
> > > +static IIO_DEV_ATTR_SAMP_FREQ_AVAIL(as73211_show_samp_freq_available=
);
> > > +static IIO_DEV_ATTR_INT_TIME_AVAIL(as73211_show_int_time_available);
> > > +static IIO_DEVICE_ATTR(hardwaregain_available, S_IRUGO,
> > > +           as73211_show_hardwaregain_available, NULL, 0);
> > > +static IIO_CONST_ATTR_TEMP_OFFSET("-66.9");
> > > +static IIO_CONST_ATTR_TEMP_SCALE("0.05");
> > > +
> > > +static struct attribute *as73211_attributes[] =3D {
> > > +   &iio_dev_attr_sampling_frequency_available.dev_attr.attr,
> > > +   &iio_dev_attr_integration_time_available.dev_attr.attr,
> > > +   &iio_dev_attr_hardwaregain_available.dev_attr.attr,
> > > +   &iio_const_attr_in_temp_offset.dev_attr.attr,
> > > +   &iio_const_attr_in_temp_scale.dev_attr.attr, =20
> >
> > These should be handled via read_raw. =20
> Only the last two ones?
Yup
>=20
> > Ideally do the _available ones via the core callbacks
> > and _avail masks as well. For the more complex values,
> > compute the table on first read or at probe and cache it. =20
> The list of available values can depend on the setting of other attributes
> (e.g. available integration times depends on sampling frequency).
That's not that unusual.  It's fine to calculate the values
returned as needed, or pick from a selection of options.

>=20
> > > +   indio_dev->dev.parent =3D &client->dev; =20
> >
> > That is now set by the IIO core, so no need to set it manually. =20
> Can you please give me a pointer? Before removing this in my branch, I ne=
ed to
> make sure that this is already available in the kernel I'm using (5.4.lat=
est).
I think I mentioned in a later thread, that's in linux-next now.
Though there was a bit of a messup where we added it then accidentally broke
it again, then fixed it finally.

Jonathan

>=20
> > > +buffer_cleanup:
> > > +   iio_triggered_buffer_cleanup(indio_dev); =20
> >
> > Should we not powerdown on error? =20
> yes, we should.
>=20
> > Also rather feels like we should have a trivial powerup function to
> > match with powerdown. =20
> changed as73211_powerdown() to as73211_power()
>=20
> regards
> Christian
>=20
>=20
>=20
> ________________________________
>  [http://assets.arri.com/media/sign/2020-04-03-E-mail-signature-Stellar2_=
V1.jpg] <https://microsites.arri.com/stellar/>
>=20
> Get all the latest information from www.arri.com<https://www.arri.com/>, =
Facebook<https://www.facebook.com/TeamARRI>, Twitter<https://twitter.com/AR=
RIChannel>, Instagram<https://instagram.com/arri> and YouTube<https://www.y=
outube.com/user/ARRIChannel>.
>=20
> Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
> Sitz: M=C3=BCnchen - Registergericht: Amtsgericht M=C3=BCnchen - Handelsr=
egisternummer: HRA 57918
> Pers=C3=B6nlich haftender Gesellschafter: Arnold & Richter Cine Technik G=
mbH
> Sitz: M=C3=BCnchen - Registergericht: Amtsgericht M=C3=BCnchen - Handelsr=
egisternummer: HRB 54477
> Gesch=C3=A4ftsf=C3=BChrer: Dr. Michael Neuh=C3=A4user; Stephan Schenk; Wa=
lter Trauninger; Markus Zeiler

