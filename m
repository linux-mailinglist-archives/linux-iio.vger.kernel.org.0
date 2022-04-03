Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 137384F0A74
	for <lists+linux-iio@lfdr.de>; Sun,  3 Apr 2022 16:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356365AbiDCO6y (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 3 Apr 2022 10:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353718AbiDCO6x (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 3 Apr 2022 10:58:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F6239B89;
        Sun,  3 Apr 2022 07:56:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F096C611E6;
        Sun,  3 Apr 2022 14:56:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC074C340ED;
        Sun,  3 Apr 2022 14:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648997816;
        bh=G+C+UBC3lQ0ywOASUozTyB8hNZzie2AVaJ+6XA4ZkG8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HN67lSJJ3pX1VQPEObjBVjsua1n4Tteb1ims6JXir/2gb+kqIEAyiQbhZQ/oTE8HC
         zxJWpIwYkgztvMV3LW+mXQ4ge2XRKF2xaPidSrVrCG4paOaAxrTWCMqIc9Az0TYswM
         0wxtASFBmf/NGj3p3vmvoC/vZpQpImBogxeK6AFSSOgzGr4i1LABHeoIOvIGfO1O/v
         OELgQZmu4cLFE5kToB1FVFXOwbA8BhPKNkhJ1EX2f7ul2tLLAZ+FbHhZXv7o7lzGL0
         53wij7EoqT8UwTa9V5sctJL8i257014RWAQxJCsVibyJ5yVE6V/eaOhwjxkgJAOwbb
         MdqDiyyHRwcow==
Date:   Sun, 3 Apr 2022 16:56:51 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        lorenzo.bianconi@redhat.com, robh@kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: iio: imu: st_lsm6dsx: add asm330lhhx
 device bindings
Message-ID: <Ykm1s+8lCslxc80e@lore-desk>
References: <cover.1648893892.git.lorenzo@kernel.org>
 <ce943fd9d99da9fcd942592a2b83590a8b06a2af.1648893892.git.lorenzo@kernel.org>
 <20220402171753.638e71d5@jic23-huawei>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="N2zD5b8iIpSIHlWz"
Content-Disposition: inline
In-Reply-To: <20220402171753.638e71d5@jic23-huawei>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--N2zD5b8iIpSIHlWz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Sat,  2 Apr 2022 12:09:30 +0200
> Lorenzo Bianconi <lorenzo@kernel.org> wrote:
>=20
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> Hi Lorenzo,
>=20
> This runs in to the same feedback that was recently had for
> https://lore.kernel.org/all/?q=3DAdd+support+for+ICM-20608-D
> but in a more extreme sense as this one presents the same whoami value
> as for other sensors already supported.  Things are made more
> fun by the fact that sensors with the same WAI seem to have different
> features (presence or not of a sensor hub - is there any documented
> way to detect that?).=20

Hi Jonathan,

if we consider only the features implemented in st_lsm6dsx, asm330lhhx
will be 1:1 compatible with lsm6dsr or lsm6dso, so we can just use one
of bindings in this section to support it (the only side effect is it
will be listed as "lsm6dsr" or "lsm6dso", but I guess it is ok). Agree?

The only difference between asm330lhhx and asm330lhh is the former supports
sensor-hub while the latter does not declare it (even if the use the same
whoami).
AFAIK there is no way to autodetect if the sensor supports sensor-hub and
we can just try to discover slave devices connected. This can have some
downside as described in the commit:

commit 35619155d044830357f06f1d2c8188c4530b4d7a
Author: Lorenzo Bianconi <lorenzo@kernel.org>
Date:   Sat Nov 13 16:23:14 2021 +0100

iio: imu: st_lsm6dsx: add dts property to disable sensor-hub

I would like to merge the sections in st_lsm6dsx_settings struct for
lsm6dsr, lsm6dso.. and lsm6dsop, asm330lhh since the only difference is
sensor-hub support. I guess we can have 2 option here to avoid any
sensor-hub corner cases:
- provide the "st,disable-sensor-hub" in dts to disable sensor-hub for
  asm330lhh, lsm6dsop (need user changes)
- add a bool variable st_lsm6dsx_settings[].id[] in order to specify if the
  chip supports sensor-hub.

Which one do you prefer?

Regards,
Lorenzo

>=20
> As such, we should really be listing this as compatible with one=20
> of the parts that is already supported such as the
> LSM6DSR.
>=20
> For that we'll need a slightly more complex binding and it would
> have the side effect that if the match was on that compatible we
> would list the name as whatever that part is.
>=20
> I'm not sure that really matters a great deal, but it could in theory
> create a userspace ABI change if we later needed to add explicit support
> for the part due to some real differences not indicated by the WAI value.
>=20
> An extension is whether we should relax the need to match on WAI if
> the part is considered compatible.  I guess that depends on just how
> compatible we think they are.
>=20
> So I see several steps to this process.
>=20
> 1) Add fallback compatibles for existing entries to first one with same W=
AI and
>    same feature set.
> 2) Add fallback compatibles beyond that to first part introduced with par=
ticular
>    characteristics.  For this we'd also want to have the driver relax its
>    handling to just warn if the WAI isn't listed for any of the parts that
>    share a particular set of characteristic (so you'll have to loop over =
the local
>    array again to check):
> https://elixir.bootlin.com/linux/latest/source/drivers/iio/imu/st_lsm6dsx=
/st_lsm6dsx_core.c#L1197
> Same argument applies as for the mpu6050 that, whilst we should modify th=
at code to
> cope, it's not a prerequisit for adding the compatible fallback to the bi=
nding.
> Personally I'd like it to be the first patch in the series that modifies =
the
> binding though.  Note it'll be easy to add the fallbacks for this new par=
t as
> no mainline trees presumably use it.  To 'fix' the rest we'll have to find
> and update any DTs in mainline.
>=20
> Note this won't stop us needing to add compatibles to newer kernels (at v=
ery
> least to the dt-binding, but probably also the driver), but it should hel=
p a newer
> DT 'work' with an old kernel.
>=20
> Jonathan
>=20
>=20
> > ---
> >  Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml =
b/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
> > index 0750f700a143..23637c420d20 100644
> > --- a/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
> > +++ b/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
> > @@ -31,6 +31,7 @@ properties:
> >        - st,lsm6dsrx
> >        - st,lsm6dst
> >        - st,lsm6dsop
> > +      - st,asm330lhhx
> > =20
> >    reg:
> >      maxItems: 1
>=20

--N2zD5b8iIpSIHlWz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYkm1swAKCRA6cBh0uS2t
rOf6AP9Fzq2bfpz3NnlQO+uUJ1QCejjsY+s7XZShCaYmxDJ+LQEA9xkHgWMqpbS8
kHOYfWRDOYn81IsG++OW7XbmUiwYVQg=
=0d4H
-----END PGP SIGNATURE-----

--N2zD5b8iIpSIHlWz--
