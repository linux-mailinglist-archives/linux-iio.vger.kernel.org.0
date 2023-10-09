Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80A4A7BE1FB
	for <lists+linux-iio@lfdr.de>; Mon,  9 Oct 2023 16:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376722AbjJIOAC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 9 Oct 2023 10:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376693AbjJIOAB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 9 Oct 2023 10:00:01 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 690B494;
        Mon,  9 Oct 2023 06:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1696859999; x=1728395999;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nQJTz2/hIrRy3ZUS8kmvHLZ6fr3tWNIqWy4E00KPdKk=;
  b=SFsV4dzmtdtfjv7bnvYX0BmKwXm7EK64Am7tmX07pdlgsB2v5W4NI5w+
   nlLlTRh+JRfRWMjXGbI3BKjfNoabprpRPwPodbHEoCKtuJ9VWka9niOZP
   lTun+rMW4T+C00KxuYREInmoacIn9g79YSCEZFZUS8OViOa2EgveZh+9b
   C1LZ3GdssuCHHY/E+OoGOlxBnNvp+LMcXSm6kvUB/ie7EShB9UFNgUCVp
   bvmaiMf0TFmvdtSa0zWOVg/6tyO/fbAMUQtqRflauGW4nSjfi99KQRrPg
   kIv8Cg1xh6CF+UyKkE6YIgL0fgsD3KCJ5JsHtzJYAWpp9iZqjP2VzIHj3
   A==;
X-CSE-ConnectionGUID: b228B/oaTI2JseXaSD1k0Q==
X-CSE-MsgGUID: YDOoeZqPRzi+CV5h9W2zOg==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="asc'?scan'208";a="240027128"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Oct 2023 06:59:44 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 9 Oct 2023 06:59:43 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex04.mchp-main.com (10.10.85.152)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 9 Oct 2023 06:59:40 -0700
Date:   Mon, 9 Oct 2023 14:59:20 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
CC:     Biju Das <biju.das.jz@bp.renesas.com>,
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
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Conor Dooley <conor@kernel.org>
Subject: Re: [PATCH v3 0/5] Add RZ/G2UL MTU3a support
Message-ID: <20231009-lure-overcome-f33ee1fd6480@wendy>
References: <20230727081848.100834-1-biju.das.jz@bp.renesas.com>
 <20230831-iphone-muscular-7442cda2c39e@spud>
 <TYCPR01MB5933370B7660B8504B2D8D7386FBA@TYCPR01MB5933.jpnprd01.prod.outlook.com>
 <TYCPR01MB112697D67514D2E6FC690B9F886CEA@TYCPR01MB11269.jpnprd01.prod.outlook.com>
 <576809c2-b7bc-4342-9c63-0662bfcecebf@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="e8ALLTHbEjeomsJ5"
Content-Disposition: inline
In-Reply-To: <576809c2-b7bc-4342-9c63-0662bfcecebf@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

--e8ALLTHbEjeomsJ5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 09, 2023 at 11:52:13AM +0200, Daniel Lezcano wrote:
> On 09/10/2023 08:54, Biju Das wrote:
> > Hi all,
> >=20
> > Gentle ping. This patch is in the patch work for a while.
> > It is acked/reviewed by Conor Dooley and Geert Uytterhoeven.
> >=20
> > Can we apply to mainline if you are happy? Or do you want me
> > to RESEND the patches? Please let me know.
>=20
> Krzysztof ?

Daniel ?

(Or for the non-telepathic, what is "Krzysztof ?" supposed to mean?)

Cheers,
Conor.

> > > > On Thu, Jul 27, 2023 at 09:18:43AM +0100, Biju Das wrote:
> > > > > This patch series aims to add MTU3a support for RZ/G2UL SMARC EVK.
> > > > > Also it fixes overflow/underflow interrupt names.
> > > > >=20
> > > > > v2->v3:
> > > > >   * Dropped patch#4, as it accepted for 6.5 fixes.
> > > > >   * Moved patch#2 to patch#1 as it is fixes patch.
> > > > >   * Added Rb tag from Geert for patch#1 and patch#3.
> > > > >   * Updated the link to lore for Closes tag for patch#2.
> > > > >   * Documented RZ/Five SoC as the same IP used in RZ/G2UL SoC.
> > > > >=20
> > > > > v1->v2:
> > > > >   * Added Ack tags from Conor Dooley for binding patches
> > > > >   * Updated commit description RZ/G2UL->RZ/{G2UL,Five} for patch#=
5.
> > > > >   * Fixed build error reported by kernel test robot by replacing
> > > > >     GIC_SPI x ->SOC_PERIPHERAL_IRQ(x) for patch#5.
> > > > >=20
> > > > > Biju Das (5):
> > > > >    dt-bindings: timer: renesas,rz-mtu3: Fix overflow/underflow in=
terrupt
> > > > >      names
> > > > >    dt-bindings: timer: renesas,rz-mtu3: Improve documentation
> > > > >    dt-bindings: timer: renesas,rz-mtu3: Document RZ/{G2UL,Five} S=
oCs
> > > > >    arm64: dts: renesas: r9a07g043: Add MTU3a node
> > > > >    arm64: dts: renesas: rzg2ul-smarc: Add support for enabling MT=
U3
> >=20
>=20
> --=20
> <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for AR=
M SoCs
>=20
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>=20

--e8ALLTHbEjeomsJ5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZSQHNwAKCRB4tDGHoIJi
0gxeAQDwG9USr3b/VULisPpvkZt8Fi1zQA3PuvWkqP7MNRsXtwEA1ksE5ZnQHr4o
PDxaKF4h/UYVWAZYRoji/OxR/VDy1gw=
=JZYA
-----END PGP SIGNATURE-----

--e8ALLTHbEjeomsJ5--
