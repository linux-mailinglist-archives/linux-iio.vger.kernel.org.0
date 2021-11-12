Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4421644EC2D
	for <lists+linux-iio@lfdr.de>; Fri, 12 Nov 2021 18:50:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235420AbhKLRxC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 12 Nov 2021 12:53:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:58538 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235122AbhKLRxC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 12 Nov 2021 12:53:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636739411;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Cvd30l3rKq7GyFVSZb24dEaFadbcOZjSFnrQXgS7mgs=;
        b=ThMgNe2ZlUoQxCqLAe9iUniTF/gUYEOcjapHlQXjy89cS+jwlHY5ozCmvNiTvSvK/0B82j
        1PKdB8xpgmeHSdjKzGIw685NRbQ3mZfK+vig4J9cqFlXaHfFPuZhiRhpn9++vOgpzliIdb
        nicn532r6JOeMJSnXxX8c8H3xbOFmmU=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-9-xS-DO1OtOIiXEKE6bPzOfQ-1; Fri, 12 Nov 2021 12:50:07 -0500
X-MC-Unique: xS-DO1OtOIiXEKE6bPzOfQ-1
Received: by mail-ed1-f72.google.com with SMTP id g3-20020a056402424300b003e2981e1edbso8934580edb.3
        for <linux-iio@vger.kernel.org>; Fri, 12 Nov 2021 09:50:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Cvd30l3rKq7GyFVSZb24dEaFadbcOZjSFnrQXgS7mgs=;
        b=y57KGB9MJ6RG/SOif294qOlvb/Ge9NsAS7SevRjrKHK0kYFN2L4LYIOCp74EKZA3t6
         KlJMvPhyrF3nQinIngK4EHMoCowhV5qXeaMyboJNnB4/lvEp3rsB5/Q7DXg8ylGvub49
         z/ORYSbnFv6B5XRIwaA/fznWfsABvKcjTWZ/LHxARrLnrCa/3v92XXbJ4Ix3DfY3RT8x
         bejIKSee/3diWFLcl5gLzexiEbbKh+EvU2xNIAP7Hy/xSMirLiaXySKz6MjHM0Za9nuI
         H0jwKZlUafOxpuuqYhYMA80IMWZN0mr3fa/SZRAsVoxmoLvEjAn4MNcEdez54oeBW7wb
         8RIw==
X-Gm-Message-State: AOAM5307Eqskm5dvbauF3CIP/JJ1AQXDyOuDOxdkFiZaS54KW3mGbVLu
        I34VqFgWQEpVys7kXxCDXm+JhXQ31ejKO0gorWePnjt73oS2czVmeItMR26UKAzhuXaNPpwi0Q0
        UEcaVGcLnZzeDMz8tmUOX
X-Received: by 2002:a17:907:7850:: with SMTP id lb16mr21541575ejc.67.1636739406343;
        Fri, 12 Nov 2021 09:50:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzDtLlenDPMVHxFRJqqnkUtxPFMDnDOypCAxBoOxoUd1bfv8rGOlM9VxzRy9jsjILe0YazFFA==
X-Received: by 2002:a17:907:7850:: with SMTP id lb16mr21541545ejc.67.1636739406163;
        Fri, 12 Nov 2021 09:50:06 -0800 (PST)
Received: from localhost (net-93-151-197-210.cust.vodafonedsl.it. [93.151.197.210])
        by smtp.gmail.com with ESMTPSA id u16sm2873473ejy.16.2021.11.12.09.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 09:50:05 -0800 (PST)
Date:   Fri, 12 Nov 2021 18:50:03 +0100
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, linux-iio@vger.kernel.org,
        mario.tesi@st.com, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: imu: st_lsm6dsx: add dts property to disable
 sensor-hub
Message-ID: <YY6pS4m83rwbjmsh@lore-desk>
References: <cover.1636552075.git.lorenzo@kernel.org>
 <78e0ba2979aca8cc1894fe4c99e784591ba681f1.1636552075.git.lorenzo@kernel.org>
 <20211112162758.2c2293ae@jic23-huawei>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="H14SFt8fzaWmYXoA"
Content-Disposition: inline
In-Reply-To: <20211112162758.2c2293ae@jic23-huawei>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--H14SFt8fzaWmYXoA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Wed, 10 Nov 2021 15:42:32 +0100
> Lorenzo Bianconi <lorenzo@kernel.org> wrote:
>=20
> > Introduce the capability to disable sensorhub through a device-tree
> > property since there are some configurations where users want to
> > explicitly disable sensor-hub auto-probing at bootstrap.
> > A typical configuration is when the sensorhub clock/data lines are conn=
ected
> > to a pull-up resistor since no slave sensors are connected to the i2c m=
aster.
> > If SDO/SA0 line is connected to the same pull-up resistor, when the dri=
ver
> > tries to probe slave devices connected on sensor-hub, it will force SDO=
/SA0
> > line to low, modifying the device i2c address.
>=20
> That's some 'interesting' wiring...
>=20
> My only suggestion here is perhaps expand on shub as disable-sensor-hub
> would be easier for people not familiar with the abbreviation?

ack, sure. I will fix it in v2.

Regards,
Lorenzo

>=20
> Jonathan
>=20
> >=20
> > Tested-by: Mario Tesi <mario.tesi@st.com>
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio=
/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > index f2cbbc756459..82ac6c59ca03 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > @@ -2244,7 +2244,9 @@ int st_lsm6dsx_probe(struct device *dev, int irq,=
 int hw_id,
> >  		return err;
> > =20
> >  	hub_settings =3D &hw->settings->shub_settings;
> > -	if (hub_settings->master_en.addr) {
> > +	if (hub_settings->master_en.addr &&
> > +	    (!dev_fwnode(dev) ||
> > +	     !device_property_read_bool(dev, "st,disable-shub"))) {
> >  		err =3D st_lsm6dsx_shub_probe(hw, name);
> >  		if (err < 0)
> >  			return err;
>=20

--H14SFt8fzaWmYXoA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYY6pSwAKCRA6cBh0uS2t
rKedAP41nBebgO/Wk0xIaPjs46w2K6SRZIhL5H1xx8oDQH9qZwEA384Y3peNF94A
Z6i0X5B9GzCZEaaX6KORYCW0B1JOGgA=
=uA+7
-----END PGP SIGNATURE-----

--H14SFt8fzaWmYXoA--

