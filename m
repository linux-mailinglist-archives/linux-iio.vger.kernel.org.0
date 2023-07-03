Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22B4B74608A
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jul 2023 18:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbjGCQO6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 Jul 2023 12:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbjGCQO5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Jul 2023 12:14:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA85138;
        Mon,  3 Jul 2023 09:14:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D6D160FB8;
        Mon,  3 Jul 2023 16:14:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0173BC433C8;
        Mon,  3 Jul 2023 16:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688400895;
        bh=BsWEnEqe0ET6H80r8pFNGKHrTSHA978h0Yg/VQDguJQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DBpa3O4SAB9T5iO6tx9YKtDdUNgENsXa7+59DWLAMAhcYmZm1dASjQ3w/8NTnFV7L
         BUeOzClEPDVInf4kDWhAbQ9YFd2G3NBJfwn7BoU/Mgo86gd6YBiP/lbpYafIqi90WR
         JulMexxx/8SQau25L4BD5Kh1Yz46MCxRsgEDEUxEI6s2T32CWwLZkUCDnNW3cNeBGO
         riGCMv/Afh9nzf1ZNE8L3h7sJOAisOJCbqvmL1OcnkE0zSimjitaaNR4sv09seJMkv
         aRaRu58ShUx21o12T/H1deaullBpAnZ2dpoxc50RSw4rFxs1r+tpf4a1pdxNOKzIHP
         753vgVHhyza1g==
Date:   Mon, 3 Jul 2023 17:14:50 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>, jic23@kernel.org,
        lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        alazar@startmail.com, daniel.baluta@nxp.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH] dt-bindings: iio: adc: ti,ads1015: fix datarate max
 value and meaning
Message-ID: <20230703-worshiper-observer-f44b6ddf1e00@spud>
References: <20230621160857.3400747-1-m.felsch@pengutronix.de>
 <20230621-unsavory-ransack-f0a3af93325c@spud>
 <20230702174148.00004260@Huawei.com>
 <20230703064626.2vr6tfwthoi5kivh@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="LP4V6kP74TAFPZ8x"
Content-Disposition: inline
In-Reply-To: <20230703064626.2vr6tfwthoi5kivh@pengutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--LP4V6kP74TAFPZ8x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 03, 2023 at 08:46:26AM +0200, Marco Felsch wrote:
> On 23-07-02, Jonathan Cameron wrote:
> > On Wed, 21 Jun 2023 21:41:05 +0100
> > Conor Dooley <conor@kernel.org> wrote:
> >=20
> > > On Wed, Jun 21, 2023 at 06:08:57PM +0200, Marco Felsch wrote:
> > > > Datarate (dr) is a 3-bit wide register field. Values from 0 to 7 are
> > > > allowed for all devices but only for the ADS1115 devices a value of=
 7
> > > > does make a difference.
> > > >=20
> > > > While on it fix the description of the datarate for ADS1115 devices=
 as
> > > > well.
> > > >=20
> > > > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> > > > ---
> > > >  .../devicetree/bindings/iio/adc/ti,ads1015.yaml   | 15 +++++++++++=
++--
> > > >  1 file changed, 13 insertions(+), 2 deletions(-)
> > > >=20
> > > > diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads1015.y=
aml b/Documentation/devicetree/bindings/iio/adc/ti,ads1015.yaml
> > > > index 2127d639a7683..e004659099c19 100644
> > > > --- a/Documentation/devicetree/bindings/iio/adc/ti,ads1015.yaml
> > > > +++ b/Documentation/devicetree/bindings/iio/adc/ti,ads1015.yaml
> > > > @@ -78,9 +78,9 @@ patternProperties:
> > > >        ti,datarate:
> > > >          $ref: /schemas/types.yaml#/definitions/uint32
> > > >          minimum: 0
> > > > -        maximum: 6
> > > > +        maximum: 7
> > > >          description: |
> > > > -          Data acquisition rate in samples per second
> > > > +          Data acquisition rate in samples per second for ADS1015,=
 TLA2024
> > > >            0: 128
> > > >            1: 250
> > > >            2: 490
> > > > @@ -88,6 +88,17 @@ patternProperties:
> > > >            4: 1600 (default)
> > > >            5: 2400
> > > >            6: 3300
> > > > +          7: 3300
> > > > +
> > > > +          Data acquisition rate in samples per second for ADS1115
> > > > +          0: 8
> > > > +          1: 16
> > > > +          2: 32
> > > > +          3: 64
> > > > +          4: 128 (default)
> > > > +          5: 250
> > > > +          6: 475
> > > > +          7: 860 =20
> > >=20
> > > I'll leave this one to Rob or Krzysztof to ack/review, but this does
> > > seem like as good an opportunity as any to migrate to a property that
> > > allows you to put the actual data acquisition rate in & not have to a=
dd
> > > new key-value mappings to the binding to support devices with differi=
ng
> > > schemes.
> >=20
> > I agree a value would have been better, but now we are where we are,
> > I'm not sure it's worth the churn of changing it - particularly as the
> > driver will need to support the old binding for every anyway.
>=20
> Yep, this would be an API change :/

Of course, but so what you have in these patches anyway. Change being
the operative word, not break ;)

Either way, I passed the buck to Rob and Krzysztof on this one anyway.

--LP4V6kP74TAFPZ8x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZKLz+gAKCRB4tDGHoIJi
0otIAP9xFJSeIP3HiTneXLse5jNZ3jBezQU5c1F9vLvMq+owpAEA7nf2aGhhkepH
TzK/kLHXPz5hZPtCMfwzcibw6Ntxegs=
=lITH
-----END PGP SIGNATURE-----

--LP4V6kP74TAFPZ8x--
