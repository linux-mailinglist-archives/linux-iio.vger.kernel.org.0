Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 619E41A892
	for <lists+linux-iio@lfdr.de>; Sat, 11 May 2019 19:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726038AbfEKRAr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 11 May 2019 13:00:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:49152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725945AbfEKRAr (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 11 May 2019 13:00:47 -0400
Received: from localhost.localdomain (unknown [151.66.17.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 62C0E2183F;
        Sat, 11 May 2019 17:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557594045;
        bh=wxHqbq9y1QoGMbMlMSras3xY+VhCssKH16SZQHmKYQ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Uy2lct5/f9jQ01cFEghXDaNhWR/21Rlz9YRTPp4F/9VbcqmzxHxbPXT3uH/2Y0lGU
         dHgYUtSrbsLiwdqs+91TjatBmaUjVNAuNYO4zphhPkxldZzNaxOAh847qh/3volASR
         cPOTET+YclMpTgK/OB2gAZCSWaC90ARM8mjA9gqw=
Date:   Sat, 11 May 2019 19:00:41 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        martin@geanix.com, Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Denis CIOCCA <denis.ciocca@st.com>
Subject: Re: [PATCH 2/2] iio: imu: st_lsm6dsx: add iio trigger and buffer
 support
Message-ID: <20190511170039.GA4547@localhost.localdomain>
References: <20190507080225.108000-1-sean@geanix.com>
 <20190507080225.108000-2-sean@geanix.com>
 <20190511123755.2d220233@archlinux>
 <20190511123054.GA14837@localhost.localdomain>
 <a8dc4bcc-b004-b287-2126-7c3b082dd3ba@geanix.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cNdxnHkX5QqsyA0e"
Content-Disposition: inline
In-Reply-To: <a8dc4bcc-b004-b287-2126-7c3b082dd3ba@geanix.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On 11/05/2019 14.30, Lorenzo Bianconi wrote:
> > > On Tue,  7 May 2019 10:02:25 +0200
> > > Sean Nyekjaer <sean@geanix.com> wrote:
> > >=20
> > > > This adds support for using iio triggers, this is needed because
> > > > our hardware guys forgot to connect the irq pins from imu device
> > > > to the SoC.
> > > >=20
> > > > Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> > > Hi Sean
> > >=20
> > > A small question on the size of the buffer needed inline.  Otherwise =
looks
> > > good to me.
> >=20
> > Hi Sean,
> >=20
> > this patch does not make sense to me since running st_lsm6dsx_read_ones=
hot
> > you need to wait to power up the device (and you will power it down at =
the
> > end). I guess you will not be able to read at a given ODR (e.g. 416Hz).
> > Moreover you can't read from the hw fifo without the irq line since
> > you need to read a full pattern from it in order to maintain the alignm=
ent.
> We are not using the hw fifo if the hw irq isn't present...
> So if I understand correctly we could speed things up a bit, with leaving
> the sensor powered by implementing a new reading function and
> calling st_lsm6dsx_sensor_set_enable when we enable the trigger?

I do not think so since in this way you will not know when the hw has updat=
ed
the output registers

>=20
> >  From my point of view you have 2 possibility:
> > - poll the output registers from userspace (this is what you are actual=
ly
> >    doing from inside the kernel, what is the advantage of doing so?)
> Yes this is exactly what I'm trying to accomplish here.
> It would be nice for us to have the same hrtimer/trigger to sample this a=
nd
> our adc.

Since we need to wait the data to be ready there is no difference between r=
eading
them polling the output registers in the sysfs and doing so

>=20
> > - fix the hw bug
> Not possible on +20K devices. ;-)
>=20
> >=20
> > Moreover if I read the patch correctly it has a NULL pointer dereferenc=
e bug
> > since hw->iio_devs[i] can be NULL (e.g. if sensor hub is disabled)
> Right above, there is:
> if (!hw->iio_devs[i])
> 	return -ENOMEM;
>=20
> Should be enough...

Do you mean when we alloc hw->iio_devs[]? If so the for loop stops at
ST_LSM6DSX_ID_EXT0 while you are going through the complete list here
(ST_LSM6DSX_ID_MAX)...

> >=20
> > Regards,
> > Lorenzo
> >=20

What I think can be doable is to read data trough the hw fifo but use
the iio hr timer as trigger. We need to set the hr timer timeout according =
to
the pattern len and read the complete pattern. I am not 100% sure it will w=
ork
since read accesses and data generation are asynchronous (so there will be a
drift).
@Jonathan, Denis: can it work?

Regards,
Lorenzo


>=20
> BR
> /Sean


--cNdxnHkX5QqsyA0e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXNb/tAAKCRA6cBh0uS2t
rNPpAQD0MxEB6fiMZ6CbOLhPANnB5/q0+5vrSX+UfVcI4YQGSAEA13Nzpvwk7FeG
WZOq5pqceNWA8S3QNMEYA/oyp0NPlwQ=
=0qER
-----END PGP SIGNATURE-----

--cNdxnHkX5QqsyA0e--
