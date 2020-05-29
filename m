Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62D1F1E78C1
	for <lists+linux-iio@lfdr.de>; Fri, 29 May 2020 10:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725971AbgE2Iu7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 29 May 2020 04:50:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:52750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725306AbgE2Iu6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 29 May 2020 04:50:58 -0400
Received: from localhost (unknown [151.48.140.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 667FE207BC;
        Fri, 29 May 2020 08:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590742257;
        bh=2QsqLkpoviLiHrIUBufV3ox0qAFNbdQMp5jg716iMKM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Op0vY/VBA3W1j4Nqfp7cuqyToI9It6VDaPFwoEVZerlmJGF/xsMm10wF/E9qX4XId
         QCLeibG1ZZ7ml88c+wX8nzAJbZg8b7I2wgxvsIKG6/XEmNxYgFx/IOP0czH70vVBtw
         vDAwoa/TiV3V8FWHWCo7xuRsfTztRglWsQQJeGW0=
Date:   Fri, 29 May 2020 10:50:52 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: IIO timestamp get skewed when suspending (st_lsm6dsx)
Message-ID: <20200529085052.GC3198@localhost.localdomain>
References: <54cb146d-e54e-acae-e89c-075521b8e7dc@geanix.com>
 <20200528210711.GD5419@localhost.localdomain>
 <3c629741-43f1-3d3a-2b40-40ddfd773e86@geanix.com>
 <20200529074443.GA3198@localhost.localdomain>
 <5bb0fca9-97a4-4bad-1314-1f275ab632ff@geanix.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="z4+8/lEcDcG5Ke9S"
Content-Disposition: inline
In-Reply-To: <5bb0fca9-97a4-4bad-1314-1f275ab632ff@geanix.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--z4+8/lEcDcG5Ke9S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

>=20
>=20
> On 29/05/2020 09.44, Lorenzo Bianconi wrote:
> > On May 29, Sean Nyekjaer wrote:
> > >=20
> > > > >=20
> > > > > Could a solution, be to call st_lsm6dsx_reset_hw_ts() in st_lsm6d=
sx_resume()
> > > > > ?
> > > >=20
> > > > yes, I think so. Could you please try to patch below? Thanks.
> > > >=20
> > >=20
> > > Hi Lorenzo,
> > >=20
> > > I have tried your patch, and the timestamp seems to behave like befor=
e.
> > >=20
> > > https://gist.github.com/sknsean/959d3421f66cb49144e7841a8a08a2be
> > > Sorry NTP have been connected for a while :)
> > >=20
> > > I will enable some more debug to trace what is happening.
> > >=20
> > > /Sean
> >=20
> > Hi Sean,
> >=20
> > thx for testing. Is the FIFO enabled before the suspend (in other words=
, is
> > st_lsm6dsx_resume_fifo running in st_lsm6dsx_resume?) what is the value=
 of
> > sensor->ts_ref after the resume?
>=20
> I have applied this patch:
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
>=20
> index 7de10bd636ea..915829f89d31 100644
>=20
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
>=20
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
>=20
> @@ -304,12 +304,28 @@ static int st_lsm6dsx_reset_hw_ts(struct st_lsm6dsx=
_hw
> *hw)
>=20
>=20
>=20
>  int st_lsm6dsx_resume_fifo(struct st_lsm6dsx_hw *hw)
>=20
>  {
>=20
> -       int err;
>=20
> +       int err, i;
>=20
> +       struct st_lsm6dsx_sensor *sensor;
>=20
>=20
>=20
> +       printk("st_lsm6dsx_resume_fifo\n");
>=20
> +       for (i =3D 0; i < ST_LSM6DSX_ID_MAX; i++) {
>=20
> +               if (!hw->iio_devs[i])
>=20
> +                       continue;
>=20
> +
>=20
> +               sensor =3D iio_priv(hw->iio_devs[i]);
>=20
> +               printk("Before[%d]: %lld\n", i, sensor->ts_ref);
>=20
> +       }
>=20
>         /* reset hw ts counter */
>=20
>         err =3D st_lsm6dsx_reset_hw_ts(hw);
>=20
>         if (err < 0)
>=20
>                 return err;
>=20
> +       for (i =3D 0; i < ST_LSM6DSX_ID_MAX; i++) {
>=20
> +               if (!hw->iio_devs[i])
>=20
> +                       continue;
>=20
> +
>=20
> +               sensor =3D iio_priv(hw->iio_devs[i]);
>=20
> +               printk("After[%d]: %lld\n", i, sensor->ts_ref);
>=20
> +       }
>=20
>=20
>=20
>         return st_lsm6dsx_set_fifo_mode(hw, ST_LSM6DSX_FIFO_CONT);
>=20
>  }
>=20
> And dmesg:
> [  949.295585] st_lsm6dsx_resume_fifo
>=20
> [  949.295617] Before[0]: 0
>=20
> [  949.295636] Before[1]: 0
>=20
> [  949.296456] After[0]: 1590740890980204361
>=20
> [  949.296476] After[1]: 1590740890980207987
>=20
> [  953.380200] PM: suspend entry (deep)
>=20
> [  953.790084] Filesystems sync: 0.409 seconds
>=20
> [  953.795329] Freezing user space processes ... (elapsed 0.002 seconds)
> done.
>=20
> [  953.798124] OOM killer disabled.
>=20
> [  953.798140] Freezing remaining freezable tasks ... (elapsed 0.001
> seconds) done.
>=20
> [  953.800016] printk: Suspending console(s) (use no_console_suspend to
> debug)
>=20
> [  953.869535] PM: suspend devices took 0.070 seconds
>=20
> [  953.883280] Disabling non-boot CPUs ...
>=20
> [  953.897700] st_lsm6dsx_resume_fifo
>=20
> [  953.897732] Before[0]: 1590740890980204361
>=20
> [  953.897752] Before[1]: 1590740890980207987
>=20
> [  953.898572] After[0]: 1590740895583500924
>=20
> [  953.898594] After[1]: 1590740895583504049
>=20
> [  953.914484] PM: resume devices took 0.020 seconds
>=20
> [  953.914533] OOM killer enabled.
>=20
> [  953.914552] Restarting tasks ... done.
>=20
> [  953.947170] PM: suspend exit
>=20
> /Sean

Ack, values seem properly updated, while values reported to the upserspace =
are
using wrong value? could you please try to dump ts samples reading the hw q=
ueue
after the resume?

Regards,
Lorenzo

--z4+8/lEcDcG5Ke9S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXtDM6gAKCRA6cBh0uS2t
rIrOAP9SAgdzRA5Fas2u/rzSvuyr/0wL7hhTJU72EZVx1aA2pgD+K+9VtX7Ua0bc
21XRYhBroe5GxSb6isk1pemLzYZ13QM=
=dXLL
-----END PGP SIGNATURE-----

--z4+8/lEcDcG5Ke9S--
