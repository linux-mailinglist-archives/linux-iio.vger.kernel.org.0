Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 662A44F1210
	for <lists+linux-iio@lfdr.de>; Mon,  4 Apr 2022 11:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354189AbiDDJfU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 4 Apr 2022 05:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348083AbiDDJfT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 4 Apr 2022 05:35:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 64C8B3BF91
        for <linux-iio@vger.kernel.org>; Mon,  4 Apr 2022 02:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649064802;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V577wNzJa2aGXvvcFpxN0wqY8guCUOTdz2Kf3vzDWoc=;
        b=fgv4WImIOAWdcoJqfmALAVyXlAalqOegyjQ74AdzjFrE+KXEbisGx9SHQHSxDJOmHz0oZk
        6xNiQB5hL6qCPN8MncgWclnGK6QOP/UfCK0P1WUgQGXfjStKID7wDGEacvwg0xMFuxCr4O
        boLIca3udXuN+qkJmCelQpX5hlQPPj8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-556-4Jg9giOXNBOo7yp72QJJ-Q-1; Mon, 04 Apr 2022 05:33:21 -0400
X-MC-Unique: 4Jg9giOXNBOo7yp72QJJ-Q-1
Received: by mail-wr1-f70.google.com with SMTP id d10-20020adfa40a000000b0020608fb395eso713968wra.11
        for <linux-iio@vger.kernel.org>; Mon, 04 Apr 2022 02:33:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=V577wNzJa2aGXvvcFpxN0wqY8guCUOTdz2Kf3vzDWoc=;
        b=IzNbP4Loa/myE8m5N8C9sanOtzl5pr3PHN3JSKlZytRONagHxTjo482vsWGfDuasZt
         DqxUSKnnF6ZtyO/Hl0AnR3+AT1yx1UMBidVj90WWzVSqMlcdfyJ337kuDpK2b5n3hwJr
         v7ifuHVZ/l1IddRIiYv9IzKQ+H74cxSS9EtGhLdtSOYgmIA5lSZX6rgL5ys8kuWKkuoO
         T3NqHdSE6NVVwDJAfL2nTTbZU41G1Llq4S9MX5zutI5gIzRmC0Hgag1Qgaz4x2aSBNdd
         HRRAFqLBk5ZRMovlwtmAOxJykrMBztJXIrDaAiBvzr7G88ohDhzibhQsEUMYLCcyVEhT
         DBYQ==
X-Gm-Message-State: AOAM532VHSvH00pHWNfsLLC2VqDfbcf8D98Vfh7zO6Vch1Q06OdK4Zcj
        z8YOMhGIYQVVsDR2MZzuXNZMY+2Cu8fKRvrZfYeJO1qehnPSss4j9DX92whnnYieoRUTohhSZs+
        g5OgutmW2FnovApjoY1Q5
X-Received: by 2002:a5d:6d0a:0:b0:204:109f:7833 with SMTP id e10-20020a5d6d0a000000b00204109f7833mr16753113wrq.76.1649064799997;
        Mon, 04 Apr 2022 02:33:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxuycbHYX6EMul4kbsnvz6LYS2C9lQwFU/bGx93UjERDwkiT4lRH7jSDSbionXGsloVjlxAOw==
X-Received: by 2002:a5d:6d0a:0:b0:204:109f:7833 with SMTP id e10-20020a5d6d0a000000b00204109f7833mr16753096wrq.76.1649064799697;
        Mon, 04 Apr 2022 02:33:19 -0700 (PDT)
Received: from localhost (net-93-71-56-156.cust.vodafonedsl.it. [93.71.56.156])
        by smtp.gmail.com with ESMTPSA id b15-20020adfc74f000000b001e888b871a0sm9028962wrh.87.2022.04.04.02.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 02:33:19 -0700 (PDT)
Date:   Mon, 4 Apr 2022 11:33:17 +0200
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh@kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: iio: imu: st_lsm6dsx: add asm330lhhx
 device bindings
Message-ID: <Ykq7XW5lZtV7YNuJ@lore-desk>
References: <cover.1648893892.git.lorenzo@kernel.org>
 <ce943fd9d99da9fcd942592a2b83590a8b06a2af.1648893892.git.lorenzo@kernel.org>
 <20220402171753.638e71d5@jic23-huawei>
 <Ykm1s+8lCslxc80e@lore-desk>
 <20220404102258.00005128@Huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lFeFSwq4UXAZtKkT"
Content-Disposition: inline
In-Reply-To: <20220404102258.00005128@Huawei.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--lFeFSwq4UXAZtKkT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Apr 04, Jonathan Cameron wrote:
> On Sun, 3 Apr 2022 16:56:51 +0200
> Lorenzo Bianconi <lorenzo@kernel.org> wrote:
>=20
> > > On Sat,  2 Apr 2022 12:09:30 +0200
> > > Lorenzo Bianconi <lorenzo@kernel.org> wrote:
> > >  =20
> > > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org> =20
> > > Hi Lorenzo,
> > >=20
> > > This runs in to the same feedback that was recently had for
> > > https://lore.kernel.org/all/?q=3DAdd+support+for+ICM-20608-D
> > > but in a more extreme sense as this one presents the same whoami value
> > > as for other sensors already supported.  Things are made more
> > > fun by the fact that sensors with the same WAI seem to have different
> > > features (presence or not of a sensor hub - is there any documented
> > > way to detect that?).  =20
> >=20
> > Hi Jonathan,
> >=20
> > if we consider only the features implemented in st_lsm6dsx, asm330lhhx
> > will be 1:1 compatible with lsm6dsr or lsm6dso, so we can just use one
> > of bindings in this section to support it (the only side effect is it
> > will be listed as "lsm6dsr" or "lsm6dso", but I guess it is ok). Agree?
>=20
> If the part has more features than the base compatible (or a different WA=
I)
> then we can definitely have a backup compatible for it (hence making that
> subset of features work on an old kernel).  We still want to introduce
> the new compatible so that we get the name right etc going forwards and
> are in a good position to add the extra features if we ever get around to=
 it.

ack. I did not completely get what you mean here with "backup compatible".
Do you mean:
- use "st,lsm6dsr" for asm330lhhx on older kernels and add "st,asm330lhhx" =
on
  new ones. Do you have any pointer on how to document it?

or=20

- add a "wildcard" compatible string for this kind of devices. Do you have =
any
  pointers?

Regards,
Lorenzo

>=20
>=20
> >=20
> > The only difference between asm330lhhx and asm330lhh is the former supp=
orts
> > sensor-hub while the latter does not declare it (even if the use the sa=
me
> > whoami).
> > AFAIK there is no way to autodetect if the sensor supports sensor-hub a=
nd
> > we can just try to discover slave devices connected. This can have some
> > downside as described in the commit:
>=20
> Ah thanks. I'd forgotten this.
>=20
> >=20
> > commit 35619155d044830357f06f1d2c8188c4530b4d7a
> > Author: Lorenzo Bianconi <lorenzo@kernel.org>
> > Date:   Sat Nov 13 16:23:14 2021 +0100
> >=20
> > iio: imu: st_lsm6dsx: add dts property to disable sensor-hub
> >=20
> > I would like to merge the sections in st_lsm6dsx_settings struct for
> > lsm6dsr, lsm6dso.. and lsm6dsop, asm330lhh since the only difference is
> > sensor-hub support. I guess we can have 2 option here to avoid any
> > sensor-hub corner cases:
> > - provide the "st,disable-sensor-hub" in dts to disable sensor-hub for
> >   asm330lhh, lsm6dsop (need user changes)
> > - add a bool variable st_lsm6dsx_settings[].id[] in order to specify if=
 the
> >   chip supports sensor-hub.
> >=20
> > Which one do you prefer?
> >=20
> > Regards,
> > Lorenzo
> >=20
> > >=20
> > > As such, we should really be listing this as compatible with one=20
> > > of the parts that is already supported such as the
> > > LSM6DSR.
> > >=20
> > > For that we'll need a slightly more complex binding and it would
> > > have the side effect that if the match was on that compatible we
> > > would list the name as whatever that part is.
> > >=20
> > > I'm not sure that really matters a great deal, but it could in theory
> > > create a userspace ABI change if we later needed to add explicit supp=
ort
> > > for the part due to some real differences not indicated by the WAI va=
lue.
> > >=20
> > > An extension is whether we should relax the need to match on WAI if
> > > the part is considered compatible.  I guess that depends on just how
> > > compatible we think they are.
> > >=20
> > > So I see several steps to this process.
> > >=20
> > > 1) Add fallback compatibles for existing entries to first one with sa=
me WAI and
> > >    same feature set.
> > > 2) Add fallback compatibles beyond that to first part introduced with=
 particular
> > >    characteristics.  For this we'd also want to have the driver relax=
 its
> > >    handling to just warn if the WAI isn't listed for any of the parts=
 that
> > >    share a particular set of characteristic (so you'll have to loop o=
ver the local
> > >    array again to check):
> > > https://elixir.bootlin.com/linux/latest/source/drivers/iio/imu/st_lsm=
6dsx/st_lsm6dsx_core.c#L1197
> > > Same argument applies as for the mpu6050 that, whilst we should modif=
y that code to
> > > cope, it's not a prerequisit for adding the compatible fallback to th=
e binding.
> > > Personally I'd like it to be the first patch in the series that modif=
ies the
> > > binding though.  Note it'll be easy to add the fallbacks for this new=
 part as
> > > no mainline trees presumably use it.  To 'fix' the rest we'll have to=
 find
> > > and update any DTs in mainline.
> > >=20
> > > Note this won't stop us needing to add compatibles to newer kernels (=
at very
> > > least to the dt-binding, but probably also the driver), but it should=
 help a newer
> > > DT 'work' with an old kernel.
> > >=20
> > > Jonathan
> > >=20
> > >  =20
> > > > ---
> > > >  Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >=20
> > > > diff --git a/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.y=
aml b/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
> > > > index 0750f700a143..23637c420d20 100644
> > > > --- a/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
> > > > +++ b/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
> > > > @@ -31,6 +31,7 @@ properties:
> > > >        - st,lsm6dsrx
> > > >        - st,lsm6dst
> > > >        - st,lsm6dsop
> > > > +      - st,asm330lhhx
> > > > =20
> > > >    reg:
> > > >      maxItems: 1 =20
> > >  =20
> >=20
>=20

--lFeFSwq4UXAZtKkT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYkq7XQAKCRA6cBh0uS2t
rCVRAQCMsSKVmR73BRSuem1TBEpwj13BP1zZRvJfNJBlu1VWXAD/RkdCmZFqCiEn
iQGeWhVdEXKbqAxdh6dwt0al+Rko4g0=
=BZXg
-----END PGP SIGNATURE-----

--lFeFSwq4UXAZtKkT--

