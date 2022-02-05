Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE234AACC4
	for <lists+linux-iio@lfdr.de>; Sat,  5 Feb 2022 22:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbiBEVy5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 5 Feb 2022 16:54:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24195 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230390AbiBEVy5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 5 Feb 2022 16:54:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644098097;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5GwwFtXuqqVqlNDk5WcweZxN2NUtLmRBUlCtmJKo00k=;
        b=bkp2DQ68s4I3MYriAVcHbbcmDaLsM86VXRAstrc7u8rkbdrc2PpTKfw/6vRLPzF0s5N2Ya
        KTE+3AecZ0Ozeqftw4lR19/ojJT2h+/ln1BF4e+KT13vNLHSdo8Ym/1L6cNmbT6Zn9Q13M
        BVNM9YIo+GnxbvEVAV/6bQioOzMeKIU=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-160-Ku0TImH3PQyuFLQJwB45xA-1; Sat, 05 Feb 2022 16:54:53 -0500
X-MC-Unique: Ku0TImH3PQyuFLQJwB45xA-1
Received: by mail-ed1-f70.google.com with SMTP id n7-20020a05640205c700b0040b7be76147so5219837edx.10
        for <linux-iio@vger.kernel.org>; Sat, 05 Feb 2022 13:54:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5GwwFtXuqqVqlNDk5WcweZxN2NUtLmRBUlCtmJKo00k=;
        b=Mlhn8hP2wKgB/En6LEX1oGAc0OI/r7d/LDfUCYJAFhFPNpP/VFcy0T+MNJAFywXqlb
         e4GiIjsNq5OZrCVs5I8RV/nHK4a5F0FLNx6Y/lthI2S0ks1kUe0vxGC2D9dJ5BnM5qDY
         xB2733Hl05aKgpAZlxNvGAdpMvQ09gBFx4+JTTR00b1FN3gSsgwp+vRUEd4BxNxuxLR0
         zxPQRCxtpTsGsKKJQTTf4At6FXUheSn7kJsD45FOgpBXRbmhIpH64ec5VSqnCrzWSKyy
         Pmx4jpMdNXVTEQbVoLc4d2Uze3rYYBNk42Ys4I/aAEsGFXlQH82GCMZ7bo9YTzYmFHW1
         sbBQ==
X-Gm-Message-State: AOAM531weaRGn0c/56/I33f1qXMQBcxLeRo9HNUCBNQrnIPoVGV86iuE
        ehV8sr/o5YkPWVCaQSNAr5dmC7xjCg3JoGi7sVRmHqaXaYrCNy5NKKd+Wxb9IWyEQVPVU7q7x7I
        V3mHclkpUwIUBPRpsHEAD
X-Received: by 2002:a17:907:2485:: with SMTP id zg5mr4570943ejb.406.1644098092514;
        Sat, 05 Feb 2022 13:54:52 -0800 (PST)
X-Google-Smtp-Source: ABdhPJywSvZm9jq1ByzJqAXdGvmPKYzAQ7B2lJ9YQbQOB3QUuywj9d5sw0fN59hkZ76JEX1EQYuCJg==
X-Received: by 2002:a17:907:2485:: with SMTP id zg5mr4570934ejb.406.1644098092304;
        Sat, 05 Feb 2022 13:54:52 -0800 (PST)
Received: from localhost (net-37-182-17-113.cust.vodafonedsl.it. [37.182.17.113])
        by smtp.gmail.com with ESMTPSA id v16sm1994493ejo.156.2022.02.05.13.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Feb 2022 13:54:51 -0800 (PST)
Date:   Sat, 5 Feb 2022 22:54:49 +0100
From:   "lorenzo.bianconi@redhat.com" <lorenzo.bianconi@redhat.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Mario TESI <mario.tesi@st.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: wait for settling time in
 st_lsm6dsx_read_oneshot
Message-ID: <Yf7yKSdbtFr5HSnv@lore-desk>
References: <6c10e1de14a42eca2d283a9df242b426e371543e.1643627150.git.lorenzo@kernel.org>
 <1643633216538.97874@st.com>
 <20220205174505.16e6d157@jic23-huawei>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HLc/n3GtQLGNZDB/"
Content-Disposition: inline
In-Reply-To: <20220205174505.16e6d157@jic23-huawei>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--HLc/n3GtQLGNZDB/
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Mon, 31 Jan 2022 12:46:56 +0000
> Mario TESI <mario.tesi@st.com> wrote:
>=20
> > Tested-by: Mario Tesi <mario.tesi@st.com>
> > ________________________________________
> > Da: Lorenzo Bianconi <lorenzo@kernel.org>
> > Inviato: luned=EC 31 gennaio 2022 12:08
> > A: jic23@kernel.org
> > Cc: lorenzo.bianconi@redhat.com; linux-iio@vger.kernel.org; Mario TESI
> > Oggetto: [PATCH] iio: imu: st_lsm6dsx: wait for settling time in st_lsm=
6dsx_read_oneshot
> >=20
> > We need to wait for sensor settling time (~ 3/ODR) before reading data
> > in st_lsm6dsx_read_oneshot routine in order to avoid corrupted samples.
> >=20
> > Reported-by: Mario Tesi <mario.tesi@st.com>
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>=20
> Fixes tag?  This definitely looks like stable material to me
> so we want a clear record of when the issue was introduced.
>=20
> Thanks,

ack, right. I will add it in v2.

Regards,
Lorenzo

>=20
> Jonathan
>=20
>=20
> > ---
> >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio=
/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > index 727b4b6ac696..93f0c6bce502 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > @@ -1374,8 +1374,12 @@ static int st_lsm6dsx_read_oneshot(struct st_lsm=
6dsx_sensor *sensor,
> >         if (err < 0)
> >                 return err;
> >=20
> > +       /*
> > +        * we need to wait for sensor settling time before
> > +        * reading data in order to avoid corrupted samples
> > +        */
> >         delay =3D 1000000000 / sensor->odr;
> > -       usleep_range(delay, 2 * delay);
> > +       usleep_range(3 * delay, 4 * delay);
> >=20
> >         err =3D st_lsm6dsx_read_locked(hw, addr, &data, sizeof(data));
> >         if (err < 0)
> > --
> > 2.34.1
> >=20
>=20

--HLc/n3GtQLGNZDB/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYf7yKQAKCRA6cBh0uS2t
rLYTAQDGHBBxrNjla9qbO2iyaaZwFbFW21ZMU2K+uAW+ry55ewD+PqK9GK8grEYI
PLpKbbAPw2TVykIrNe1IndtH1naRFQ0=
=RPRW
-----END PGP SIGNATURE-----

--HLc/n3GtQLGNZDB/--

