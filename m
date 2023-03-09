Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40BF26B20C1
	for <lists+linux-iio@lfdr.de>; Thu,  9 Mar 2023 10:57:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbjCIJ5H (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 9 Mar 2023 04:57:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbjCIJ5G (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 9 Mar 2023 04:57:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB4A866D22;
        Thu,  9 Mar 2023 01:57:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 64FB061AD8;
        Thu,  9 Mar 2023 09:57:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 459B4C433EF;
        Thu,  9 Mar 2023 09:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678355824;
        bh=ODnKzBpDfhjHRjZi6xnYZfhimajSnaKsAA3E99ICe5s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t9+cGRIw+5d4GxF7DDN32S7cRMxKOpZs/+z82FSELi1BBrFKV3tZc9iPUPLmLnkQk
         OFsRZxjDXK96kLHiUbHDmP/u7J8+btKoYb6XvVoOoAJT1tv9yRFNINHztE6o97Np+A
         pkdN8/iDS1F272hVyLSf6mkOL87DBmquHG2OOABseYdprRbPV3FBXe/PmMqSCHjYdG
         WZJ2FLQ7fRRyH150sNV2Ml4dffdDFImxWD4kll5erDhcIrxTHEtU0OgMxTtshT+B8R
         Rc92XdJtvu4RepF6ioctCorilboycYO9ZJdyTUBhmyVZrahfFp9WnOmwaMRxjCXENf
         fb9gfqQPeYdNA==
Date:   Thu, 9 Mar 2023 10:57:00 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     jic23@kernel.org, linux-iio@vger.kernel.org,
        lorenzo.bianconi@redhat.com, devicetree@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Subject: Re: [PATCH 2/2] dt-bindings: iio: imu: st_lsm6dsx: add asm330lhb
Message-ID: <ZAmtbGfUJiH5gSIY@lore-desk>
References: <cover.1678100533.git.lorenzo@kernel.org>
 <fecf1f20cc8e99fb8654cc733f14bd449ca7f87a.1678100533.git.lorenzo@kernel.org>
 <f2bbda1a-b6e3-ccbb-d77a-8bdb42aca0ee@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jkV1bburN89PBeLT"
Content-Disposition: inline
In-Reply-To: <f2bbda1a-b6e3-ccbb-d77a-8bdb42aca0ee@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--jkV1bburN89PBeLT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mar 07, Krzysztof Kozlowski wrote:
> On 06/03/2023 12:08, Lorenzo Bianconi wrote:
> > Add device bindings for asm330lhb IMU sensor.
> > Use asm330lhh as fallback device for asm330lhb since it implements all
> > the features currently supported by asm330lhb.
> >=20
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml | 3 +++
> >  1 file changed, 3 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml =
b/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
> > index decf022335d8..b39f5217d8ff 100644
> > --- a/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
> > +++ b/Documentation/devicetree/bindings/iio/imu/st,lsm6dsx.yaml
> > @@ -46,6 +46,9 @@ properties:
> >        - items:
> >            - const: st,ism330is
> >            - const: st,lsm6dso16is
> > +      - items:
> > +          - const: st,asm330lhb
> > +          - const: st,asm330lhh
>=20
> You added it to the end of the list, but aren't there any ordering
> already? If so, it should be put rather in correct place.

Hi Krzysztof,

I do not think there is any ordering issue there.

Regards,
Lorenzo

>=20
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>=20
>=20
> Best regards,
> Krzysztof
>=20

--jkV1bburN89PBeLT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZAmtbAAKCRA6cBh0uS2t
rDeWAP9XsT0VORBjVCWmnkZS31d5vRGUosz6Lj9+UWXyJ65eWwD/QBfgXftmET36
Kgbpyao9C6x65UVORFm0P5/HqiaAWAQ=
=0OIE
-----END PGP SIGNATURE-----

--jkV1bburN89PBeLT--
