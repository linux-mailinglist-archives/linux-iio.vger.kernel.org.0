Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22E5D7BE621
	for <lists+linux-iio@lfdr.de>; Mon,  9 Oct 2023 18:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377115AbjJIQRm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 9 Oct 2023 12:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377094AbjJIQRl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 9 Oct 2023 12:17:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F5C92;
        Mon,  9 Oct 2023 09:17:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 272BFC433C8;
        Mon,  9 Oct 2023 16:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696868259;
        bh=1I9Mf0P70RDfN2bWDORGQ7rejIEzlWu8nj21FaxunAg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ueG4FvCWARpNVmDgXA7EKEoHYkK543c6nnLJkJyo1VXbTfAzaCxx5Aoua/yEHbol3
         o4sr5OFut3T87VxzmRx+WXRKdyVLf/xZhv8183TPX6B1vkvQv9/uTTqD6XimoP9Ih/
         D2HQK+a0ZGa8qetpGmHe1ibvwWiZqjCA+FOn6OjJR695v+oPEDf2AHM1jJXvgD8FZb
         aWHGDcYi0Qi/Ty4+fKTd3ty51g9VtP5mOFbsKCAt9dnm4nyWbDe6mbVzHJ/2vWtCeR
         7KkaSaIYYATYR+AExbXJo5js5rjpkB008YqkEJpQPi2y5pt2wjCSZwRs44oKPSfivQ
         xIACtvNeuJffw==
Date:   Mon, 9 Oct 2023 17:17:34 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v3 0/5] Add RZ/G2UL MTU3a support
Message-ID: <20231009-elderly-squad-a739461e5e64@spud>
References: <20230727081848.100834-1-biju.das.jz@bp.renesas.com>
 <20230831-iphone-muscular-7442cda2c39e@spud>
 <TYCPR01MB5933370B7660B8504B2D8D7386FBA@TYCPR01MB5933.jpnprd01.prod.outlook.com>
 <TYCPR01MB112697D67514D2E6FC690B9F886CEA@TYCPR01MB11269.jpnprd01.prod.outlook.com>
 <576809c2-b7bc-4342-9c63-0662bfcecebf@linaro.org>
 <20231009-lure-overcome-f33ee1fd6480@wendy>
 <42ed1a41-a59c-478b-8ef2-4000f0509150@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="aAbF7L5PVlLbwYHe"
Content-Disposition: inline
In-Reply-To: <42ed1a41-a59c-478b-8ef2-4000f0509150@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--aAbF7L5PVlLbwYHe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 09, 2023 at 04:18:13PM +0200, Daniel Lezcano wrote:
> On 09/10/2023 15:59, Conor Dooley wrote:
> > On Mon, Oct 09, 2023 at 11:52:13AM +0200, Daniel Lezcano wrote:
> > > On 09/10/2023 08:54, Biju Das wrote:
> > > > Hi all,
> > > >=20
> > > > Gentle ping. This patch is in the patch work for a while.
> > > > It is acked/reviewed by Conor Dooley and Geert Uytterhoeven.
> > > >=20
> > > > Can we apply to mainline if you are happy? Or do you want me
> > > > to RESEND the patches? Please let me know.
> > >=20
> > > Krzysztof ?
> >=20
> > Daniel ?
> >=20
> > (Or for the non-telepathic, what is "Krzysztof ?" supposed to mean?)
>=20
> Sorry I missed you were in the DT bindings maintainer list. I was expecti=
ng
> Krzysztof tag.

Heh, I figured that that is what was going on, but my telepathy skills
were a bit lacking and I was not 100% sure... NW!

--aAbF7L5PVlLbwYHe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZSQnngAKCRB4tDGHoIJi
0l8PAP9T0L4kqeS6/ASmu3yIS50Za7MyLA0Jb8xkzTKiqMKSFQEA/j8oMP+ApNPf
I85BeVxW73nPy5pB8htbvqQXubCK2AA=
=ObgY
-----END PGP SIGNATURE-----

--aAbF7L5PVlLbwYHe--
