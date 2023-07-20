Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25F9175B602
	for <lists+linux-iio@lfdr.de>; Thu, 20 Jul 2023 19:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbjGTR7m (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 20 Jul 2023 13:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjGTR7l (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 20 Jul 2023 13:59:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3822510DB;
        Thu, 20 Jul 2023 10:59:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B14B161BA6;
        Thu, 20 Jul 2023 17:59:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C85FC433C7;
        Thu, 20 Jul 2023 17:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689875979;
        bh=CqQs7xfNATOq8/S12UaWHVTHvPlH80hjfiTVQx7Nj84=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R3JRdqoYts0JgXCnjUGbbRgffXVK9730O4i91SjmJB3MQHz1IiT78KIwp3aSfeWPt
         uxMFIQez9OGYB7FC4bzLPDzT9A6+v+Dd8qyh5ISmF9cc+GAcZVhHcczwsj+v3L1PCG
         ppsQChOJ5MbpgDpy45C0J+91/Ap6HQTstVoTdiRYePjuY/5Jkm2W1mUiie5uGBPIiT
         Jh30TWFPeLbmVw3w64wBumz/ACfaWjFOwiL+hfqLo6l/EEjNE6MlHdzkhpl5FHInD7
         KY6Wdx3H2YxO/1Qb0CGySXDukC1C36MPBzJLen9jOiyKRwktOn//TVo6c5hK2tF2Fl
         Ur+BaKuZEZV3w==
Date:   Thu, 20 Jul 2023 18:59:33 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Lee Jones <lee@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "stable@kernel.org" <stable@kernel.org>
Subject: Re: [PATCH 2/6] dt-bindings: timer: renesas,rz-mtu3: Fix
 overflow/underflow interrupt names
Message-ID: <20230720-cognitive-identity-1d132ed09d2d@spud>
References: <20230720131016.331793-1-biju.das.jz@bp.renesas.com>
 <20230720131016.331793-3-biju.das.jz@bp.renesas.com>
 <20230720-clash-borax-b458480d1579@spud>
 <TYCPR01MB593325C0DF5169C0DC96A96F863EA@TYCPR01MB5933.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wUTGfTXiSvwb+e8Q"
Content-Disposition: inline
In-Reply-To: <TYCPR01MB593325C0DF5169C0DC96A96F863EA@TYCPR01MB5933.jpnprd01.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--wUTGfTXiSvwb+e8Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 20, 2023 at 05:52:00PM +0000, Biju Das wrote:
> > -----Original Message-----
> > From: Conor Dooley <conor@kernel.org>

> > Sent: Thursday, July 20, 2023 6:19 PM
> > To: Biju Das <biju.das.jz@bp.renesas.com>
> > Cc: Rob Herring <robh+dt@kernel.org>; Krzysztof Kozlowski
> > <krzysztof.kozlowski+dt@linaro.org>; Conor Dooley <conor+dt@kernel.org>;
> > Daniel Lezcano <daniel.lezcano@linaro.org>; Thomas Gleixner
> > <tglx@linutronix.de>; Geert Uytterhoeven <geert+renesas@glider.be>;
> > Magnus Damm <magnus.damm@gmail.com>; Lee Jones <lee@kernel.org>; linux-
> > iio@vger.kernel.org; linux-renesas-soc@vger.kernel.org;
> > devicetree@vger.kernel.org; Fabrizio Castro
> > <fabrizio.castro.jz@renesas.com>; Prabhakar Mahadev Lad
> > <prabhakar.mahadev-lad.rj@bp.renesas.com>; stable@kernel.org

btw, please trim this stuff :)

> > Subject: Re: [PATCH 2/6] dt-bindings: timer: renesas,rz-mtu3: Fix
> > overflow/underflow interrupt names
> >=20
> > On Thu, Jul 20, 2023 at 02:10:12PM +0100, Biju Das wrote:
> > > As per R01UH0914EJ0130 Rev.1.30 HW manual the MTU3 overflow/underflow
> > > interrupt names starts with 'tci' instead of 'tgi'.
> > >
> > > Fix this documentation issue by replacing below overflow/underflow
> > > interrupt names:
> > >  - tgiv0->tciv0
> > >  - tgiv1->tciv1
> > >  - tgiu1->tciu1
> > >  - tgiv2->tciv2
> > >  - tgiu2->tciu2
> > >  - tgiv3->tciv3
> > >  - tgiv4->tciv4
> > >  - tgiv6->tciv6
> > >  - tgiv7->tciv7
> > >  - tgiv8->tciv8
> > >  - tgiu8->tciu8
> > >
> > > Fixes: 0a9d6b54297e ("dt-bindings: timer: Document RZ/G2L MTU3a
> > > bindings")
> > > Cc: stable@kernel.org
> > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> >=20
> > I assume this means that nothing is actually using these interrupt
> > names?
>=20
> Yes, That is correct. Corresponding driver doesn't have interrupt support.

Okay, if it is not being used anywhere:
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--wUTGfTXiSvwb+e8Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZLl2BQAKCRB4tDGHoIJi
0i9OAP9GxYxO5U43ON2v9ag0gyW0hcDwm2T6xTi0dEEmbSFroQD6AwACitjbccP4
lfxlDg8k/lA91I1br9KtehnXY7JeHQM=
=bNLt
-----END PGP SIGNATURE-----

--wUTGfTXiSvwb+e8Q--
