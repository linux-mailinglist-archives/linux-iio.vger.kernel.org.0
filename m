Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 827094F27C6
	for <lists+linux-iio@lfdr.de>; Tue,  5 Apr 2022 10:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233657AbiDEII4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 5 Apr 2022 04:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233661AbiDEIIr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 5 Apr 2022 04:08:47 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C0EA6B0B6
        for <linux-iio@vger.kernel.org>; Tue,  5 Apr 2022 01:02:08 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 7BD0760006;
        Tue,  5 Apr 2022 08:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1649145723;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DJuT0CGY/gEjE8kpQ+PyqxUGM3vV5Pla3ENMpWl5Lk8=;
        b=lrXeoVzXMFzdcV/HWAnKuIczUDlFcnS21uDTqnG2dqHuahGOz9vj9A7wJfpIZ2zIHRbZs2
        4fuos3FbTX3Ua2utmc5XBvC/xn2yJBQysibDxOI/4kbfi8/joWthBMCS0ubV/p2vPjetfk
        7ux9HeU1uxXJO88mm9nrid3ts10O4AoPgHl0oGuAoOKQixhdKZ5ELRo1wawyDAOJOznDXZ
        4kAB/9dTCPUWDBhLkHbacAEddc1IwGeIax8OXntvWe64Qsr7WzVxiVfROIOYw5QPXSWkBZ
        dwjqMWjg6nq0e5XQOQG+7G/5DjG0OW+2OCOueeQC7qNHeQLAwsBEwZBi5k+WjQ==
Date:   Tue, 5 Apr 2022 10:02:00 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Denis Ciocca <denis.ciocca@st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        christophe.priouzeau@st.com
Subject: Re: [PATCH v3 13/13] iio: core: Clarify the modes
Message-ID: <20220405100200.4063e712@xps13>
In-Reply-To: <20220315164450.2fca5fcf@xps13>
References: <20220207143840.707510-1-miquel.raynal@bootlin.com>
        <20220207143840.707510-14-miquel.raynal@bootlin.com>
        <20220213184224.1644ddbc@jic23-huawei>
        <20220214095308.42e52f34@xps13>
        <20220227133549.016935a1@jic23-huawei>
        <20220315164450.2fca5fcf@xps13>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

miquel.raynal@bootlin.com wrote on Tue, 15 Mar 2022 16:44:50 +0100:

> Hello,
>=20
> + Christophe
>=20
> jic23@kernel.org wrote on Sun, 27 Feb 2022 13:35:49 +0000:
>=20
> > On Mon, 14 Feb 2022 09:53:08 +0100
> > Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> >  =20
> > > Hi Jonathan,
> > >=20
> > > jic23@kernel.org wrote on Sun, 13 Feb 2022 18:42:24 +0000:
> > >    =20
> > > > On Mon,  7 Feb 2022 15:38:40 +0100
> > > > Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> > > >      =20
> > > > > As part of a previous discussion with Jonathan Cameron [1], it ap=
peared
> > > > > necessary to clarify the meaning of each mode so that new develop=
ers
> > > > > could understand better what they should use or not use and when.
> > > > >=20
> > > > > The idea of renaming these modes as been let aside because naming=
 is a
> > > > > big deal and requires a lot of thinking. So for now let's focus on
> > > > > correctly explaining what each mode implies.
> > > > >=20
> > > > > [1] https://lore.kernel.org/linux-iio/20210930165510.2295e6c4@jic=
23-huawei/
> > > > >=20
> > > > > Suggested-by: Jonathan Cameron <jic23@kernel.org>
> > > > > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>       =20
> > > > One trivial thing inline as a result of edits in v3.
> > > >=20
> > > > Otherwise, I want to let this series sit a little longer and ideall=
y get
> > > > some eyes on the st_sensors patches.     =20

Sometimes there is no other choice than applying patches to get
feedback :) Hopefully nothing unexpected will happen, but as this
series lived almost two month on the mailing list already, I would
propose to merge the series as it is. We can still drop/revert it as we
are rather soon in the new cycle. If rebasing is needed just let me
know.

Cheers,
Miqu=C3=A8l

> > >=20
> > > Sure.   =20
> >=20
> > Denis, Linus, Lorenzo,
> >=20
> > If any of you have time to take a look at patches 4-8 in this series or=
 ideally
> > to run basic sanity tests with series in place that would be great.
> > https://patchwork.kernel.org/project/linux-iio/list/?series=3D611853
> >=20
> > I don't have a convenient platform to test that driver on any more and =
the
> > changes are invasive enough to make me a little nervous about taking the
> > series without someone more familiar with that driver taking a look. =20
>=20
> I'm adding Christophe from ST who might also help having these patches
> tested or at least reviewed.
>=20
> TLDR: as part of a wider cleanup, I ended up "playing" with locks in
> the st_sensors drivers, so any testing or feedback is welcome!
>=20
> Thanks,
> Miqu=C3=A8l


