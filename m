Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56F334FAE6D
	for <lists+linux-iio@lfdr.de>; Sun, 10 Apr 2022 17:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240149AbiDJPWF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 10 Apr 2022 11:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiDJPWE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 10 Apr 2022 11:22:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8912B112D
        for <linux-iio@vger.kernel.org>; Sun, 10 Apr 2022 08:19:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 046596102E
        for <linux-iio@vger.kernel.org>; Sun, 10 Apr 2022 15:19:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB6E9C385A4;
        Sun, 10 Apr 2022 15:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649603991;
        bh=k1I2i70J9t0lcNtwZz70bM+GvzonIBxuNDW7EPzDP4w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=H10+Eh1/liAuFC4H2UsKxkPcF8VQ8wEROEMwPI3vXRJrAj6fCuDmMC8ZkhqsHeXD3
         k1v5cB0ZznrxXWRTCsicbK9FR1Hl0yrlfgoh5xDAQT2JDJwv87Eh5U2OTSWyIWUmZE
         WeGVj1DfNc4bY3IgjMmn/tX1C47Sr4UlQgACy/nPly6BXkO+y84ki+muVY4GTiAee3
         JYzpJ2m0OXcl8inbZ+iDALnjLPMvlZZlCnPA97sMumB2baYrxPq29daOXmh62xw2qJ
         8QruDNmFs2duOUeLeev6BJMe7DjkRM3lQL4VtaNpUPAm/krTlfZbJI/TzqJYKPN9aU
         oL2l97IAU8kxg==
Date:   Sun, 10 Apr 2022 16:27:41 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Denis Ciocca <denis.ciocca@st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        christophe.priouzeau@st.com
Subject: Re: [PATCH v3 13/13] iio: core: Clarify the modes
Message-ID: <20220410162741.71943665@jic23-huawei>
In-Reply-To: <20220405100200.4063e712@xps13>
References: <20220207143840.707510-1-miquel.raynal@bootlin.com>
        <20220207143840.707510-14-miquel.raynal@bootlin.com>
        <20220213184224.1644ddbc@jic23-huawei>
        <20220214095308.42e52f34@xps13>
        <20220227133549.016935a1@jic23-huawei>
        <20220315164450.2fca5fcf@xps13>
        <20220405100200.4063e712@xps13>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 5 Apr 2022 10:02:00 +0200
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Hi Jonathan,
>=20
> miquel.raynal@bootlin.com wrote on Tue, 15 Mar 2022 16:44:50 +0100:
>=20
> > Hello,
> >=20
> > + Christophe
> >=20
> > jic23@kernel.org wrote on Sun, 27 Feb 2022 13:35:49 +0000:
> >  =20
> > > On Mon, 14 Feb 2022 09:53:08 +0100
> > > Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> > >    =20
> > > > Hi Jonathan,
> > > >=20
> > > > jic23@kernel.org wrote on Sun, 13 Feb 2022 18:42:24 +0000:
> > > >      =20
> > > > > On Mon,  7 Feb 2022 15:38:40 +0100
> > > > > Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> > > > >        =20
> > > > > > As part of a previous discussion with Jonathan Cameron [1], it =
appeared
> > > > > > necessary to clarify the meaning of each mode so that new devel=
opers
> > > > > > could understand better what they should use or not use and whe=
n.
> > > > > >=20
> > > > > > The idea of renaming these modes as been let aside because nami=
ng is a
> > > > > > big deal and requires a lot of thinking. So for now let's focus=
 on
> > > > > > correctly explaining what each mode implies.
> > > > > >=20
> > > > > > [1] https://lore.kernel.org/linux-iio/20210930165510.2295e6c4@j=
ic23-huawei/
> > > > > >=20
> > > > > > Suggested-by: Jonathan Cameron <jic23@kernel.org>
> > > > > > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>       =
  =20
> > > > > One trivial thing inline as a result of edits in v3.
> > > > >=20
> > > > > Otherwise, I want to let this series sit a little longer and idea=
lly get
> > > > > some eyes on the st_sensors patches.       =20
>=20
> Sometimes there is no other choice than applying patches to get
> feedback :) Hopefully nothing unexpected will happen, but as this
> series lived almost two month on the mailing list already, I would
> propose to merge the series as it is. We can still drop/revert it as we
> are rather soon in the new cycle. If rebasing is needed just let me
> know.

Fully agree on pushing forwards with merging this.  I've done the rebase wh=
ilst
applying. Other than a bit of fuzz main change was that adxl367 made use
of a kfifo buffer in the meantime so needed updating as well to drop the
buffer type parameter.=20

Take a quick look and see if I messed anything up.
Applied to the togreg branch of iio.git and pushed out as testing for 0-day
etc to take a poke at it before I make a mess of linux-next.

Thanks,

Jonathan

>=20
> Cheers,
> Miqu=C3=A8l
>=20
> > > >=20
> > > > Sure.     =20
> > >=20
> > > Denis, Linus, Lorenzo,
> > >=20
> > > If any of you have time to take a look at patches 4-8 in this series =
or ideally
> > > to run basic sanity tests with series in place that would be great.
> > > https://patchwork.kernel.org/project/linux-iio/list/?series=3D611853
> > >=20
> > > I don't have a convenient platform to test that driver on any more an=
d the
> > > changes are invasive enough to make me a little nervous about taking =
the
> > > series without someone more familiar with that driver taking a look. =
  =20
> >=20
> > I'm adding Christophe from ST who might also help having these patches
> > tested or at least reviewed.
> >=20
> > TLDR: as part of a wider cleanup, I ended up "playing" with locks in
> > the st_sensors drivers, so any testing or feedback is welcome!
> >=20
> > Thanks,
> > Miqu=C3=A8l =20
>=20
>=20

