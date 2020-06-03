Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34ACF1ECD8C
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jun 2020 12:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725859AbgFCK2s (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 3 Jun 2020 06:28:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:45212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725854AbgFCK2r (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 3 Jun 2020 06:28:47 -0400
Received: from localhost (unknown [151.48.128.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B679420679;
        Wed,  3 Jun 2020 10:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591180127;
        bh=W7499KNHIjAPDb8qmwTw+brP85cGpOHHz2VEVDrl8DE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q2Lm8IFYoy9K3nS57ZqjJzE+vuKCUGsS+TRz5mAryLpa/zWzIXFLxfO78f7Jz2YCF
         2w/24Za45ugCWYQa5VYU5yi1sL8WWOTRqAg75FBI6i+BuQFj4LAyClMRgyC87C3ISY
         O9BEQG7w4x2H69jbGgXtrGS3bU2UYFuzO5G84VVQ=
Date:   Wed, 3 Jun 2020 12:28:41 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: IIO timestamp get skewed when suspending (st_lsm6dsx)
Message-ID: <20200603102841.GC544784@lore-desk.lan>
References: <20200529074443.GA3198@localhost.localdomain>
 <5bb0fca9-97a4-4bad-1314-1f275ab632ff@geanix.com>
 <20200529085052.GC3198@localhost.localdomain>
 <08c824c2-dfb2-7a5c-b6fd-8258d6ce3808@geanix.com>
 <20200529121616.GD3198@localhost.localdomain>
 <26401237-5e3b-faf7-35c7-9d6e22f6d239@geanix.com>
 <b3363da1-033b-4afa-59cd-28328ec32066@geanix.com>
 <e9964fda-3b83-2e23-299a-7ab7d50529af@geanix.com>
 <20200603080619.GA544784@lore-desk.lan>
 <91165f5d-8cba-3ea2-67dc-99d65bce3d19@geanix.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="L6iaP+gRLNZHKoI4"
Content-Disposition: inline
In-Reply-To: <91165f5d-8cba-3ea2-67dc-99d65bce3d19@geanix.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--L6iaP+gRLNZHKoI4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

>=20
>=20
> On 03/06/2020 10.06, Lorenzo Bianconi wrote:
> > >=20
> > >=20
> > > On 02/06/2020 15.39, Sean Nyekjaer wrote:
> > > > > > are these values from the hw FIFO? can you please add
> > > > > > sensor->ts_ref to the trace and
> > > > > > a log into st_lsm6dsx_reset_hw_ts?
> > > > > >=20
> > > > >=20
> > > > > Hi,
> > > > >=20
> > > > > This certainly looks weird,
> > > > >=20
> > > > > https://gist.github.com/sknsean/b32bae140008cf446a8fea58e305da47
> > > > >=20
> > > > > Seems like the ts_ref is updated and used but not read/used in
> > > > > userspace...
> > > > >=20
> > > > > /Sean
> > > >=20
> > > > added to st_lsm6dsx_read_fifo :
> > > >=20
> > > > printk("ts_ref %lld, ts %lld, sample_time %lld\n", acc_sensor->ts_r=
ef,
> > > > ts, acc_sensor->ts_ref + ts);
> > > >=20
> > > > https://gist.github.com/sknsean/3ad1e9e05cb0e2ef811a3c83492a1980
> > > >=20
> > > > Suspend again was 15sec
> > > >=20
> > > > /Sean
> > >=20
> > > Hi,
> > >=20
> > > Some more findings :)
> > > https://gist.github.com/sknsean/d31e48b65515361309cd238dcf68600f
> > >=20
> > > To me it looks like ktime_get_real_ns() isn't ready or updated when w=
e are
> > > calling iio_get_time_ns().
> > > If we look in the trace ktime_get_real_ns() it's ready when we are ge=
tting
> > > the first sample after suspend.
> > >=20
> > > Running with this patch:
> > > https://gist.github.com/sknsean/415d1b9c34f20db4419a0c61a58eb188
> > > +
> > > The first from this thread.
> > >=20
> > > /Sean
> >=20
> > Hi Sean,
> >=20
> > looking at the logs I guess we should not reset the sensor hw ts. Could=
 you
> > please try the below patch?
> >=20
> > Regards,
> > Lorenzo
> >=20
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio=
/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > index 0b776cb91928..4f8a9bcee77b 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > @@ -2445,6 +2445,8 @@ static int __maybe_unused st_lsm6dsx_resume(struc=
t device *dev)
> >   		if (!(hw->suspend_mask & BIT(sensor->id)))
> >   			continue;
> > +		sensor->ts_ref =3D iio_get_time_ns(hw->iio_devs[i]);
> > +
> >   		if (sensor->id =3D=3D ST_LSM6DSX_ID_EXT0 ||
> >   		    sensor->id =3D=3D ST_LSM6DSX_ID_EXT1 ||
> >   		    sensor->id =3D=3D ST_LSM6DSX_ID_EXT2)
> >=20
>=20
> Hmm, suspend again for 15s.
>=20
> https://gist.github.com/sknsean/911ae4ae2e74ebe1e7eca1405c645ff1
>=20
> [  105.520634] PM: suspend exit
> [  105.540206] ts_ref 1591097307780181385, ts 2861700000, sample_time
> 1591097310641881385
>=20
> [  105.548416] ktime_get_real_ns: 1591097322928175385
>=20
> CLOCK_REALTIME isn't ready in the resume function. I think we need to link
> it to CLOCK_BOOTTIME (Which ticking under suspend) instead.

With latest patch it seems to me the time reported is now monotonic so it s=
eems
correct. What is the clocktype you set? you can check it in:
/sys/bus/iio/devices/iio:device<x>/current_timestamp_clock

Regards,
Lorenzo

>=20
> /Sean

--L6iaP+gRLNZHKoI4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXtd7VwAKCRA6cBh0uS2t
rHJ2AP9/y/NH6dokoX0vTfNpgUCZWK8Lc13GN/JGjasbQQD16QD3fypAdjwQUxI/
hP6/v2e5HaucSMraYhfBQ+jMyOYlBQ==
=Tc2E
-----END PGP SIGNATURE-----

--L6iaP+gRLNZHKoI4--
