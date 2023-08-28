Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED15578B2DF
	for <lists+linux-iio@lfdr.de>; Mon, 28 Aug 2023 16:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjH1OVe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 28 Aug 2023 10:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231691AbjH1OVY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 28 Aug 2023 10:21:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 208BA103;
        Mon, 28 Aug 2023 07:21:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B2A0161025;
        Mon, 28 Aug 2023 14:21:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2F63C433C8;
        Mon, 28 Aug 2023 14:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693232477;
        bh=xpNfgoWofuEd3QNaE6srsrtNynbjtKnemyhrAeAl+Ak=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=k8sj5q+Bo9/Bw+7MODPt1MacHjhmyalrQHmMaAnPSrA0sIkTBv5XHk5nwzJDsGksj
         M+npj7iPLUSF2/ExOlhUQDthkps4OMftVGtnk7xlZ9vNVgfEks9EiponF8qlsLSGuo
         3dUwqu3WVdGNialXTcUKOnf8hevwTtCZFes7yFcvDb/L0iNpO7+8oedxG+BQwcLlc2
         xSrNUtkiOjG+RnyDFA9DvsXRn18KpifEj+uI961SmzFvR2Iscwe+EqWjZlCTD/UwPb
         j8OeFg2DoctrwDq/mBtCcQNEIU7gvguX2HeB5IepKESheKMvfuuXFrH70WyKgdcMNO
         QDC8Vt0m3GtLQ==
Date:   Mon, 28 Aug 2023 15:21:37 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 4/5] iio: magnetometer: ak8975: Drop deprecated enums
 from OF table
Message-ID: <20230828152137.2db2668d@jic23-huawei>
In-Reply-To: <CAMuHMdWwo1hYnbztoRUtHD7iw53f7Np-vPsfMMBdwbMP7-Q98A@mail.gmail.com>
References: <20230818075600.24277-1-biju.das.jz@bp.renesas.com>
        <20230818075600.24277-5-biju.das.jz@bp.renesas.com>
        <ZN9WCKQ/hv4zKfsK@smile.fi.intel.com>
        <OS0PR01MB5922F93ABF408AA9037A8EAC861BA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
        <ZN+IDGfc0MJfqOV9@smile.fi.intel.com>
        <CAMuHMdWwo1hYnbztoRUtHD7iw53f7Np-vPsfMMBdwbMP7-Q98A@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 18 Aug 2023 17:17:44 +0200
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> Hi Andy,
>=20
> CC devicetree
>=20
> On Fri, Aug 18, 2023 at 5:03=E2=80=AFPM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Fri, Aug 18, 2023 at 11:40:37AM +0000, Biju Das wrote: =20
> > > > Subject: Re: [PATCH v2 4/5] iio: magnetometer: ak8975: Drop depreca=
ted
> > > > enums from OF table
> > > >
> > > > On Fri, Aug 18, 2023 at 08:55:59AM +0100, Biju Das wrote: =20
> > > > > Drop deprecated enums from OF table as corresponding entries are
> > > > > removed from bindings and it also saves memory. =20
> > > >
> > > > You can't do this.
> > > >
> > > > Only sorting by "prefixed first" criteria is possible. =20
> > >
> > > The rule applies only for fallback compatible. I checked bindings and=
 I don't
> > > find any fallback compatibles. All compatibles are just enums. Am I m=
issing
> > > anything here?? =20
> >
> > Yes. As per above patch. The _whole_ world is not under your / our cont=
rol.
> > NAK to this change, sorry. =20
>=20
> The single user ever in the upstream kernel was fixed in commit
> 9846210b1ec9bbaa ("ARM: tegra: seaboard: add missing DT vendor
> prefixes") in v3.8 back in 2012.
> And it had to be fixed again 9 years later in commit fa0fdb78cb5d4cde
> ("ARM: dts: am335x: Use correct vendor prefix for Asahi Kasei Corp.").
>=20
> There may be other out-of-tree users, which would be broken by this
> change.  Typically we wait a few years between deprecating a compatible
> value and removing support from the driver.
>=20
> As Biju is only deprecating these compatible values in PATCH 3/5 of
> his series, this may be a bit premature.
Absolutely.  I'd go a bit further.
Unless there is a maintenance reason to remove these (after a few years from
removal in the binding doc) then we never remove them as it can only hurt u=
sers.

Jonathan

>=20
> Gr{oetje,eeting}s,
>=20
>                         Geert
>=20
>=20
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>=20
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                 -- Linus Torvalds

