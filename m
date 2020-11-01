Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 609132A1F4F
	for <lists+linux-iio@lfdr.de>; Sun,  1 Nov 2020 16:54:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbgKAPyK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 1 Nov 2020 10:54:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48845 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726499AbgKAPyI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 1 Nov 2020 10:54:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604246046;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Xs/Qle3QFlyWQ/hWPo/No+Tdic7rMqT27SQ6y+p2D0g=;
        b=igbtjVVsnZWptyPdJDRGvLOLGm73l89jXWrE2m22DhoKLBFDQ/drQegfpM1ooDl8x7p0SH
        uX2UGKt6eR1/bvot9DQNanmWaBFT0NuHH3gG/cordyUp1WEMQiilDzErsXQrYfD/0X1J0E
        TneFFQvsgBnON1DGMsc/xBw8YPqaeXo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-565-btzxnnROOEaYjL_OuEELSQ-1; Sun, 01 Nov 2020 10:54:04 -0500
X-MC-Unique: btzxnnROOEaYjL_OuEELSQ-1
Received: by mail-wr1-f69.google.com with SMTP id h8so5343510wrt.9
        for <linux-iio@vger.kernel.org>; Sun, 01 Nov 2020 07:54:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Xs/Qle3QFlyWQ/hWPo/No+Tdic7rMqT27SQ6y+p2D0g=;
        b=dO512mtvSiqPUJGLUlUsfcq0e9hwIY2VllET/LYdxKQqOJTlTAngwWbQDFEh+nL+q8
         sjTuoyiiND7va46/UV0w8HmQqEYm4TyVmmZpps1wSQN5w17qPWpJ1nce78pasPa4uel0
         Ydb1ktKg9U2w8KU0MnkQKOFSb/fpSn+sTg0hEVRUd+N6E7CsWLwgJ/PagVITLWf9k4OK
         PsbdnbIVqUlXTzIUPInc/JmUmrifQ1g4teTiSHhYZXN7P4bYRpvFQqGWyJgQ8RqjFQpR
         lvpWqRgYq9uZ3jwj27wJnsn41i/G8hLVnuEuV1qei4v8sTFRRPE1iZvL4jdse8hgs9WU
         e0bQ==
X-Gm-Message-State: AOAM531gy/Z1pzWyRQ7gTwu32cjt4ST2Qor7x9A4ArhYencgE0xVaoxD
        KgLNNLHZQn5AyU8wLlB1+OLd9kMtQCjFqoZrQ4zoWyrnlEOXPInNalSJx9izq9UXx57AHjY9TGK
        SUt3LpuYhagscfwti2eg7
X-Received: by 2002:a1c:309:: with SMTP id 9mr4897437wmd.80.1604246043293;
        Sun, 01 Nov 2020 07:54:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw19lQod0kHzxAIxUlTB95f3aGZ6jmKJiyB62PUw/E3ITiZPr8SNe9JdZwzHj0Waj2RMr/x7A==
X-Received: by 2002:a1c:309:: with SMTP id 9mr4897421wmd.80.1604246043119;
        Sun, 01 Nov 2020 07:54:03 -0800 (PST)
Received: from localhost ([151.66.29.159])
        by smtp.gmail.com with ESMTPSA id y10sm17875644wru.94.2020.11.01.07.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2020 07:54:02 -0800 (PST)
Date:   Sun, 1 Nov 2020 16:53:59 +0100
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: set 10ms as min shub slave timeout
Message-ID: <20201101155359.GA222330@lore-desk>
References: <b0cd79d1b72246652df9ccef19bd951bb17b5c55.1603317102.git.lorenzo@kernel.org>
 <20201101154310.6f2aa827@archlinux>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="h31gzZEtNLTqOjlF"
Content-Disposition: inline
In-Reply-To: <20201101154310.6f2aa827@archlinux>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Nov 01, Jonathan Cameron wrote:
> On Wed, 21 Oct 2020 23:53:54 +0200
> Lorenzo Bianconi <lorenzo@kernel.org> wrote:
>=20
> > Set 10ms as minimum i2c slave configuration timeout since at high ODRs
> > (e.g. 833Hz) the slave sensor may need more cycles than ~3ms
> > (2s/833Hz + 1) for the configuration
> >=20
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>=20
> Hi Lorenzo,
>=20
> This sounds like a fix to me.  Could you give a bit more detail on what
> setup it fails for and a fixes tag so we can get this into appropriate
> stable trees?

ack, I will post v2 soon.

Regards,
Lorenzo

>=20
> Thanks,
>=20
> Jonathan
>=20
> > ---
> >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c b/drivers/iio=
/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> > index 8c8d8870ca07..99562ba85ee4 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> > @@ -156,11 +156,13 @@ static const struct st_lsm6dsx_ext_dev_settings s=
t_lsm6dsx_ext_dev_table[] =3D {
> >  static void st_lsm6dsx_shub_wait_complete(struct st_lsm6dsx_hw *hw)
> >  {
> >  	struct st_lsm6dsx_sensor *sensor;
> > -	u32 odr;
> > +	u32 odr, timeout;
> > =20
> >  	sensor =3D iio_priv(hw->iio_devs[ST_LSM6DSX_ID_ACC]);
> >  	odr =3D (hw->enable_mask & BIT(ST_LSM6DSX_ID_ACC)) ? sensor->odr : 12=
500;
> > -	msleep((2000000U / odr) + 1);
> > +	/* set 10ms as minimum timeout for i2c slave configuration */
> > +	timeout =3D max_t(u32, 2000000U / odr + 1, 10);
> > +	msleep(timeout);
> >  }
> > =20
> >  /*
>=20

--h31gzZEtNLTqOjlF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCX57aFAAKCRA6cBh0uS2t
rCY/AP9TRlo4/Cqa5YSN2hM7VKURkp1Qcg3dbGLE/FH/SFHptgEApUZsW88wBOnj
ovtrU14GmvBqzpiutryYLfgXPzLmYwc=
=rPC3
-----END PGP SIGNATURE-----

--h31gzZEtNLTqOjlF--

