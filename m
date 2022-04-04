Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84FD04F1B66
	for <lists+linux-iio@lfdr.de>; Mon,  4 Apr 2022 23:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379628AbiDDVUM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 4 Apr 2022 17:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380227AbiDDTUS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 4 Apr 2022 15:20:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4A9BA33E0A
        for <linux-iio@vger.kernel.org>; Mon,  4 Apr 2022 12:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649099897;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/UysYK+MXCxUjSEiEyMSa/U76PwwS0k5WwchG22Rv44=;
        b=bmErSC1KwPD03iX7b4eXU9F8AmE0LldV3ztR+1Nw7CM9QjmIWKyPClB8HW2gkQ2yIqqNlf
        nN6wZ5yeOMU3d64As9yUBs7HXVB+4+497ffYSQ7LWOzZU9aafMKVhHAc0/HGO/vE76i94q
        7UMJk5gzMFddvFrruQaK3odwluGJtXY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-194-5Aip9VayNgW0zF5Sgu-SHw-1; Mon, 04 Apr 2022 15:18:13 -0400
X-MC-Unique: 5Aip9VayNgW0zF5Sgu-SHw-1
Received: by mail-wr1-f69.google.com with SMTP id g4-20020adfa484000000b002061151874eso878778wrb.21
        for <linux-iio@vger.kernel.org>; Mon, 04 Apr 2022 12:18:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/UysYK+MXCxUjSEiEyMSa/U76PwwS0k5WwchG22Rv44=;
        b=aalk3LhoZ0Xak40sVcI9qtXuZy0UqIgpBbbkGTnvCxPOTbSrvbLyUQQSXeQDC6rJCE
         Vfyg6VOpW/oQyEO+zhL7J57T4XyJRJdz79YJ6LpP4XoQaxfrJBJzTvjPi+olqrQRnV28
         j3hub8gRenC2cjvsv8BIONfwBLPuUYBeG7wKlJ4GkhNev8Nianori/KlXcKjngYrUj5I
         Dgly6GHHfIKZcT5oVo2Q66Dd6nU/4BU5lyXNS/kJOstZu4mFhZHhQacpXRMEqcGjRG/q
         iYPMkeKfhDXKpnWpDQnBHWJwkebuYlR2Xn060NNZYba3Z2ud+u9xJxTLU2WFfwanQ+Ik
         zpuA==
X-Gm-Message-State: AOAM531SXw0reiIc25KJXUOxSSLJdqgZWOW+ZngxCZR15VXekDg9HVqD
        mhWTIgP50YFA38vPbjhooGywPbJy0MCDDQ4dv8gZKRWIxe+Ayw/MwK8SnEsjmi3b90glLLHAgB/
        wYF1PTZ6LvZc6ADH/B74E
X-Received: by 2002:a05:6000:1681:b0:205:d419:1a92 with SMTP id y1-20020a056000168100b00205d4191a92mr998862wrd.96.1649099892444;
        Mon, 04 Apr 2022 12:18:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyFsGI789M4TjD3DTqy4HVS47FKq5wIbUuTXXiQszrujhDf/YvqWRtShOjdWQKKFzyxjDZ67A==
X-Received: by 2002:a05:6000:1681:b0:205:d419:1a92 with SMTP id y1-20020a056000168100b00205d4191a92mr998841wrd.96.1649099892116;
        Mon, 04 Apr 2022 12:18:12 -0700 (PDT)
Received: from localhost (net-93-71-56-156.cust.vodafonedsl.it. [93.71.56.156])
        by smtp.gmail.com with ESMTPSA id r129-20020a1c2b87000000b0038e6a025d05sm384690wmr.18.2022.04.04.12.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 12:18:11 -0700 (PDT)
Date:   Mon, 4 Apr 2022 21:18:09 +0200
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh@kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: iio: imu: st_lsm6dsx: add asm330lhhx
 device bindings
Message-ID: <YktEcb8UeCpkBEfh@lore-desk>
References: <cover.1648893892.git.lorenzo@kernel.org>
 <ce943fd9d99da9fcd942592a2b83590a8b06a2af.1648893892.git.lorenzo@kernel.org>
 <20220402171753.638e71d5@jic23-huawei>
 <Ykm1s+8lCslxc80e@lore-desk>
 <20220404102258.00005128@Huawei.com>
 <Ykq7XW5lZtV7YNuJ@lore-desk>
 <20220404171718.000021fc@Huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GvP13H2LmjukKQ+G"
Content-Disposition: inline
In-Reply-To: <20220404171718.000021fc@Huawei.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--GvP13H2LmjukKQ+G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Mon, 4 Apr 2022 11:33:17 +0200
> Lorenzo Bianconi <lorenzo.bianconi@redhat.com> wrote:
>=20
> > On Apr 04, Jonathan Cameron wrote:
> > > On Sun, 3 Apr 2022 16:56:51 +0200
> > > Lorenzo Bianconi <lorenzo@kernel.org> wrote:
> > >  =20
> > > > > On Sat,  2 Apr 2022 12:09:30 +0200
> > > > > Lorenzo Bianconi <lorenzo@kernel.org> wrote:
> > > > >    =20
> > > > > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>   =20
> > > > > Hi Lorenzo,
> > > > >=20
> > > > > This runs in to the same feedback that was recently had for
> > > > > https://lore.kernel.org/all/?q=3DAdd+support+for+ICM-20608-D
> > > > > but in a more extreme sense as this one presents the same whoami =
value
> > > > > as for other sensors already supported.  Things are made more
> > > > > fun by the fact that sensors with the same WAI seem to have diffe=
rent
> > > > > features (presence or not of a sensor hub - is there any document=
ed
> > > > > way to detect that?).    =20
> > > >=20
> > > > Hi Jonathan,
> > > >=20
> > > > if we consider only the features implemented in st_lsm6dsx, asm330l=
hhx
> > > > will be 1:1 compatible with lsm6dsr or lsm6dso, so we can just use =
one
> > > > of bindings in this section to support it (the only side effect is =
it
> > > > will be listed as "lsm6dsr" or "lsm6dso", but I guess it is ok). Ag=
ree? =20
> > >=20
> > > If the part has more features than the base compatible (or a differen=
t WAI)
> > > then we can definitely have a backup compatible for it (hence making =
that
> > > subset of features work on an old kernel).  We still want to introduce
> > > the new compatible so that we get the name right etc going forwards a=
nd
> > > are in a good position to add the extra features if we ever get aroun=
d to it. =20
> >=20
> > ack. I did not completely get what you mean here with "backup compatibl=
e".
> > Do you mean:
> > - use "st,lsm6dsr" for asm330lhhx on older kernels and add "st,asm330lh=
hx" on
> >   new ones. Do you have any pointer on how to document it?
> Take a look at the mpu6050 patches.=20
>=20
>=20
>  properties:
>    compatible:
> -    enum:
> -      - invensense,iam20680
> -      - invensense,icm20608
> -      - invensense,icm20609
> -      - invensense,icm20689
> -      - invensense,icm20602
> -      - invensense,icm20690
> -      - invensense,mpu6000
> -      - invensense,mpu6050
> -      - invensense,mpu6500
> -      - invensense,mpu6515
> -      - invensense,mpu6880
> -      - invensense,mpu9150
> -      - invensense,mpu9250
> -      - invensense,mpu9255
> +    oneOf:
> +      - enum:
> +        - invensense,iam20680
> +        - invensense,icm20608
> +        - invensense,icm20609
> +        - invensense,icm20689
> +        - invensense,icm20602
> +        - invensense,icm20690
> +        - invensense,mpu6000
> +        - invensense,mpu6050
> +        - invensense,mpu6500
> +        - invensense,mpu6515
> +        - invensense,mpu6880
> +        - invensense,mpu9150
> +        - invensense,mpu9250
> +        - invensense,mpu9255
> +      - items:
> +        - const: invensense,icm20608d
> +        - const: invensense,icm20608
>=20
> Which ends up expecting
>=20
> compatible =3D "invensense,icm20608d", "invensense,icm20608"
> and will try matching on the first. If that fails it will try
> with the second value.

ack, thx for pointing this out. I will fix it in v2.

Regards,
Lorenzo

> =20
> >=20
> > or=20
> >=20
> > - add a "wildcard" compatible string for this kind of devices. Do you h=
ave any
> >   pointers?
> >=20
> > Regards,
> > Lorenzo
> >=20
> > >=20
> > >  =20
> > > >=20
> > > > The only difference between asm330lhhx and asm330lhh is the former =
supports
> > > > sensor-hub while the latter does not declare it (even if the use th=
e same
> > > > whoami).
> > > > AFAIK there is no way to autodetect if the sensor supports sensor-h=
ub and
> > > > we can just try to discover slave devices connected. This can have =
some
> > > > downside as described in the commit: =20
> > >=20
> > > Ah thanks. I'd forgotten this.
> > >  =20
> > > >=20
> > > > commit 35619155d044830357f06f1d2c8188c4530b4d7a
> > > > Author: Lorenzo Bianconi <lorenzo@kernel.org>
> > > > Date:   Sat Nov 13 16:23:14 2021 +0100
> > > >=20
> > > > iio: imu: st_lsm6dsx: add dts property to disable sensor-hub
> > > >=20
> > > > I would like to merge the sections in st_lsm6dsx_settings struct for
> > > > lsm6dsr, lsm6dso.. and lsm6dsop, asm330lhh since the only differenc=
e is
> > > > sensor-hub support. I guess we can have 2 option here to avoid any
> > > > sensor-hub corner cases:
> > > > - provide the "st,disable-sensor-hub" in dts to disable sensor-hub =
for
> > > >   asm330lhh, lsm6dsop (need user changes)
> > > > - add a bool variable st_lsm6dsx_settings[].id[] in order to specif=
y if the
> > > >   chip supports sensor-hub.
> > > >=20
> > > > Which one do you prefer?
> > > >=20
> > > > Regards,
> > > > Lorenzo
> > > >  =20
> > > > >=20
> > > > > As such, we should really be listing this as compatible with one=
=20
> > > > > of the parts that is already supported such as the
> > > > > LSM6DSR.
> > > > >=20
> > > > > For that we'll need a slightly more complex binding and it would
> > > > > have the side effect that if the match was on that compatible we
> > > > > would list the name as whatever that part is.
> > > > >=20
> > > > > I'm not sure that really matters a great deal, but it could in th=
eory
> > > > > create a userspace ABI change if we later needed to add explicit =
support
> > > > > for the part due to some real differences not indicated by the WA=
I value.
> > > > >=20
> > > > > An extension is whether we should relax the need to match on WAI =
if
> > > > > the part is considered compatible.  I guess that depends on just =
how
> > > > > compatible we think they are.
> > > > >=20
> > > > > So I see several steps to this process.
> > > > >=20
> > > > > 1) Add fallback compatibles for existing entries to first one wit=
h same WAI and
> > > > >    same feature set.
> > > > > 2) Add fallback compatibles beyond that to first part introduced =
with particular
> > > > >    characteristics.  For this we'd also want to have the driver r=
elax its
> > > > >    handling to just warn if the WAI isn't listed for any of the p=
arts that
> > > > >    share a particular set of characteristic (so you'll have to lo=
op over the local
> > > > >    array again to check):
> > > > > https://elixir.bootlin.com/linux/latest/source/drivers/iio/imu/st=
_lsm6dsx/st_lsm6dsx_core.c#L1197
> > > > > Same argument applies as for the mpu6050 that, whilst we should m=
odify that code to
> > > > > cope, it's not a prerequisit for adding the compatible fallback t=
o the binding.
> > > > > Personally I'd like it to be the first patch in the series that m=
odifies the
> > > > > binding though.  Note it'll be easy to add the fallbacks for this=
 new part as
> > > > > no mainline trees presumably use it.  To 'fix' the rest we'll hav=
e to find
> > > > > and update any DTs in mainline.
> > > > >=20
> > > > > Note this won't stop us needing to add compatibles to newer kerne=
ls (at very
> > > > > least to the dt-binding, but probably also the driver), but it sh=
ould help a newer
> > > > > DT 'work' with an old kernel.
> > > > >=20
> > > > > Jonathan
> > > > >=20
> > > > >    =20
> > > > > > ---
> > > > > >  Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml | 1 +
> > > > > >  1 file changed, 1 insertion(+)
> > > > > >=20
> > > > > > diff --git a/Documentation/devicetree/bindings/iio/imu/st,lsm6d=
sx.yaml b/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
> > > > > > index 0750f700a143..23637c420d20 100644
> > > > > > --- a/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
> > > > > > +++ b/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
> > > > > > @@ -31,6 +31,7 @@ properties:
> > > > > >        - st,lsm6dsrx
> > > > > >        - st,lsm6dst
> > > > > >        - st,lsm6dsop
> > > > > > +      - st,asm330lhhx
> > > > > > =20
> > > > > >    reg:
> > > > > >      maxItems: 1   =20
> > > > >    =20
> > > >  =20
> > >  =20
> >=20
>=20

--GvP13H2LmjukKQ+G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYktEcQAKCRA6cBh0uS2t
rPFiAQD82q7vul5rzghoGGvJi9GNzY+RkCTzfnZIYeWCdM1FwgEA6U5sa6ZDiIPE
kKLy84Cm0s6sFmvaI8gT1JUQbxaUwww=
=oJaA
-----END PGP SIGNATURE-----

--GvP13H2LmjukKQ+G--

