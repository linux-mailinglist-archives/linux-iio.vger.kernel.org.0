Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6352B39C9
	for <lists+linux-iio@lfdr.de>; Mon, 16 Sep 2019 13:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbfIPLzp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Sep 2019 07:55:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:37658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725912AbfIPLzo (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 16 Sep 2019 07:55:44 -0400
Received: from localhost.localdomain (nat-pool-mxp-t.redhat.com [149.6.153.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A18DA2067B;
        Mon, 16 Sep 2019 11:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568634943;
        bh=agxPINVXz3Xx/ibuJs7OOU4SCF+q3+lbbh2OElm2G+8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jt+d9r6kJsx+U7FDPdxFDHsUnYIEpOyOhFU6mymodSyJI4sc/4HALH3ZhaKkIu4gI
         ucut9cDO1Z1SybaFpHjXPuV5yc5ywx8J1v5oNbI4yWxwCvMeojwI8/0II6E/NJ+HwV
         zNLrEecEtVZHO9sDdN05UCUabfyUjJRsLdOekNU8=
Date:   Mon, 16 Sep 2019 13:55:38 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     linux-iio@vger.kernel.org, jic23@kernel.org,
        lorenzo.bianconi83@gmail.com, denis.ciocca@st.com,
        mario.tesi@st.com, armando.visconti@st.com, martin@geanix.com
Subject: Re: [RFC PATCH] iio: imu: st_lsm6dsx: filter motion events in driver
Message-ID: <20190916115538.GC16063@localhost.localdomain>
References: <20190915143548.25383eb4@archlinux>
 <20190916090222.597444-1-sean@geanix.com>
 <20190916091649.GA16063@localhost.localdomain>
 <07c96bca-f952-71c0-4608-30746fbbc055@geanix.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="JgQwtEuHJzHdouWu"
Content-Disposition: inline
In-Reply-To: <07c96bca-f952-71c0-4608-30746fbbc055@geanix.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--JgQwtEuHJzHdouWu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

>=20
>=20
> On 16/09/2019 11.16, Lorenzo Bianconi wrote:
> > > +	if (hw->event_en_mask & BIT(chan->channel2))
> > > +		goto out;
> > Why do we need this?
> >=20
>=20
> Guess we need to check if 0 < hw->enable_event before disabling the
> sensor...
> > > +
> > >   	/* do not enable events if they are already enabled */
> > >   	if (state && hw->enable_event)
> > > -		return 0;
> > > +		goto out;
>=20
> static int st_lsm6dsx_write_event_config(struct iio_dev *iio_dev,
>                                            const struct iio_chan_spec *ch=
an,
>                                            enum iio_event_type type,
>                                            enum iio_event_direction dir,
>                                            int state)
> {
>         struct st_lsm6dsx_sensor *sensor =3D iio_priv(iio_dev);
>         struct st_lsm6dsx_hw *hw =3D sensor->hw;
>         u8 _enable_event;

please use enable_event instead of _enable_event

>         int err =3D 0;
>=20
>         if (type !=3D IIO_EV_TYPE_THRESH)
>                 return -EINVAL;
>=20
>         if (state) {
>                 _enable_event =3D hw->enable_event | BIT(chan->channel2);
>=20
>                 /* do not enable events if they are already enabled */
>                 if (0 < hw->enable_event)
>                         goto out;

we do not need this since there is the check:
if (hw->enable_event =3D=3D enable_event)
	return 0;

>         } else {
>                 _enable_event =3D hw->enable_event & ~BIT(chan->channel2);
>=20
>                 /* only turn off sensor if no events is enabled */
>=20
>=20
>=20
>=20
>                 if (0 !=3D _enable_event)
>                         goto out;

we do not need this as well

>         }
>=20
>         /* stop here if no changes have been made */
>         if (hw->enable_event =3D=3D _enable_event)
>                 return 0;
>=20
>         err =3D st_lsm6dsx_event_setup(hw, state);
>         if (err < 0)
>                 return err;
>=20
>         err =3D st_lsm6dsx_sensor_set_enable(sensor, state);
>         if (err < 0)
>                 return err;
>=20
> out:
>         hw->enable_event =3D _enable_event;
>=20
>         return 0;
> }
>=20
> Is something like this better?

--JgQwtEuHJzHdouWu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXX94NwAKCRA6cBh0uS2t
rOwfAP42Tdd3wmLtmMqRmcQ2AH31uvymP9T1jonmwpQIJ9WirAD/cixDqIEW6Q6V
ABYXfGNs9eg4ySkx9V/4b5al3sBCzgY=
=J1uU
-----END PGP SIGNATURE-----

--JgQwtEuHJzHdouWu--
