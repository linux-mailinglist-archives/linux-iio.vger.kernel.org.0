Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD4875ED34
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jul 2023 10:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbjGXIRY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 24 Jul 2023 04:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbjGXIQu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 24 Jul 2023 04:16:50 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53F76113;
        Mon, 24 Jul 2023 01:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1690186588; x=1721722588;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OSGy1RGNrKj5Vn5UTuxn9sL6Z684rIbmZJT3w7sWpu0=;
  b=f2Aa9RRmNB1Bsbm+wvLUCCwFTZQ+5hQlK+FxdXz2q0mJ964LnIC/z/k0
   nzAP5bX4bwnjb2SWSd97zozUix4FD7cMuNPMd+WNxvyXEpg7SsdMIHop8
   a3Juum0CPuzVEOlRHsARnFRm4O/NjhRWmXWM5o7k9/p+z8pqGSr8/zFwR
   iOLLTaFZbfU3SZm3TqJ97lRDCWWOKk0DmkDL9kgRrSeb+cv5uaOFK4/tM
   L8/MSrL5KE/oglrUeTGhsC+5IOOt3kFEvxqmpz6YNdGn1PNjFz8uIqEtw
   lYJspPKfKfzwEnGYV7HnOEQwgZDePms3ZkHuPQl3PBD52l/pvVOrDaJEF
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="asc'?scan'208";a="221827756"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Jul 2023 01:16:26 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 24 Jul 2023 01:16:23 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 24 Jul 2023 01:16:20 -0700
Date:   Mon, 24 Jul 2023 09:15:46 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
CC:     Conor Dooley <conor@kernel.org>, Rob Herring <robh+dt@kernel.org>,
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
Message-ID: <20230724-pork-reformer-0eb65d306222@wendy>
References: <20230720131016.331793-1-biju.das.jz@bp.renesas.com>
 <20230720131016.331793-3-biju.das.jz@bp.renesas.com>
 <20230720-clash-borax-b458480d1579@spud>
 <TYCPR01MB593325C0DF5169C0DC96A96F863EA@TYCPR01MB5933.jpnprd01.prod.outlook.com>
 <20230720-cognitive-identity-1d132ed09d2d@spud>
 <OS0PR01MB59223400A76E7D05BE0C00088602A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fA97oSgobCkMgECf"
Content-Disposition: inline
In-Reply-To: <OS0PR01MB59223400A76E7D05BE0C00088602A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

--fA97oSgobCkMgECf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 24, 2023 at 08:04:08AM +0000, Biju Das wrote:
> Hi Conor Dooley,=20
>=20
> > Subject: Re: [PATCH 2/6] dt-bindings: timer: renesas,rz-mtu3: Fix
> > overflow/underflow interrupt names
> >=20
> > On Thu, Jul 20, 2023 at 05:52:00PM +0000, Biju Das wrote:
> > > > -----Original Message-----
> > > > From: Conor Dooley <conor@kernel.org>
> >=20
> > > > Sent: Thursday, July 20, 2023 6:19 PM
> > > > To: Biju Das <biju.das.jz@bp.renesas.com>
> > > > Cc: Rob Herring <robh+dt@kernel.org>; Krzysztof Kozlowski
> > > > <krzysztof.kozlowski+dt@linaro.org>; Conor Dooley
> > > > <conor+dt@kernel.org>; Daniel Lezcano <daniel.lezcano@linaro.org>;
> > > > Thomas Gleixner <tglx@linutronix.de>; Geert Uytterhoeven
> > > > <geert+renesas@glider.be>; Magnus Damm <magnus.damm@gmail.com>; Lee
> > > > Jones <lee@kernel.org>; linux- iio@vger.kernel.org;
> > > > linux-renesas-soc@vger.kernel.org;
> > > > devicetree@vger.kernel.org; Fabrizio Castro
> > > > <fabrizio.castro.jz@renesas.com>; Prabhakar Mahadev Lad
> > > > <prabhakar.mahadev-lad.rj@bp.renesas.com>; stable@kernel.org
> >=20
> > btw, please trim this stuff :)
>=20
> You mean trim the recipient list?

Not the actual recipient list, this junk that outlook adds to emails :)

--fA97oSgobCkMgECf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZL4zMgAKCRB4tDGHoIJi
0rCTAQCuRxkiUYcOAQBbF660/gzxDZIr4jikc502dj5qWO8/xAEAuONpjgutf6sS
fuBegmjNJOTw1537U9tW3QBn4PprrwU=
=5Pc6
-----END PGP SIGNATURE-----

--fA97oSgobCkMgECf--
