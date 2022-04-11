Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D78034FB467
	for <lists+linux-iio@lfdr.de>; Mon, 11 Apr 2022 09:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245199AbiDKHO5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 11 Apr 2022 03:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241772AbiDKHO5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 11 Apr 2022 03:14:57 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67541338A5
        for <linux-iio@vger.kernel.org>; Mon, 11 Apr 2022 00:12:43 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 63E9CFF804;
        Mon, 11 Apr 2022 07:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1649661161;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KAsQ0PqZfyzcLYn0dvqjeTdr9hlj4czIcEGcIuE+ZNk=;
        b=gAQHl0bDNJGSF9Jiycxaep2esIc/PA7ZM4wgrMwff4AaloJn0ilYG6p4BemaYjuiA9bBim
        8kiEFMJz5oCozj1VypPiCBSgLyQ1SLmFaxABg20XzsmvAPdsBhDGE3lLaa52n+Zn+oDKGH
        R9aEfWnkR4XzLs4AM9hbp7jfXNiqTkFV7mau+pkhPT4b2IAR4WWDcWPBAikKC0G0IHmTxp
        hryPT3g8bhOKbtg9nlrzUKGh9YwOBXkg4lgqNKy0iz/Gok+e6r2r7XshOAR5U3nKgvlmPK
        OrFPnC88+7EPOQOFGwY8gXFqXC60kclyffQ2W2jJASvWYLZICBYchhN4C5yOGg==
Date:   Mon, 11 Apr 2022 09:12:39 +0200
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
Message-ID: <20220411091239.6a731790@xps13>
In-Reply-To: <20220410162741.71943665@jic23-huawei>
References: <20220207143840.707510-1-miquel.raynal@bootlin.com>
        <20220207143840.707510-14-miquel.raynal@bootlin.com>
        <20220213184224.1644ddbc@jic23-huawei>
        <20220214095308.42e52f34@xps13>
        <20220227133549.016935a1@jic23-huawei>
        <20220315164450.2fca5fcf@xps13>
        <20220405100200.4063e712@xps13>
        <20220410162741.71943665@jic23-huawei>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

jic23@kernel.org wrote on Sun, 10 Apr 2022 16:27:41 +0100:

> On Tue, 5 Apr 2022 10:02:00 +0200
> Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>=20
> > Hi Jonathan,
> >=20
> > miquel.raynal@bootlin.com wrote on Tue, 15 Mar 2022 16:44:50 +0100:
> >  =20
> > > Hello,
> > >=20
> > > + Christophe
> > >=20
> > > jic23@kernel.org wrote on Sun, 27 Feb 2022 13:35:49 +0000:
> > >    =20
> > > > On Mon, 14 Feb 2022 09:53:08 +0100
> > > > Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> > > >      =20
> > > > > Hi Jonathan,
> > > > >=20
> > > > > jic23@kernel.org wrote on Sun, 13 Feb 2022 18:42:24 +0000:
> > > > >        =20
> > > > > > On Mon,  7 Feb 2022 15:38:40 +0100
> > > > > > Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> > > > > >          =20
> > > > > > > As part of a previous discussion with Jonathan Cameron [1], i=
t appeared
> > > > > > > necessary to clarify the meaning of each mode so that new dev=
elopers
> > > > > > > could understand better what they should use or not use and w=
hen.
> > > > > > >=20
> > > > > > > The idea of renaming these modes as been let aside because na=
ming is a
> > > > > > > big deal and requires a lot of thinking. So for now let's foc=
us on
> > > > > > > correctly explaining what each mode implies.
> > > > > > >=20
> > > > > > > [1] https://lore.kernel.org/linux-iio/20210930165510.2295e6c4=
@jic23-huawei/
> > > > > > >=20
> > > > > > > Suggested-by: Jonathan Cameron <jic23@kernel.org>
> > > > > > > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>     =
      =20
> > > > > > One trivial thing inline as a result of edits in v3.
> > > > > >=20
> > > > > > Otherwise, I want to let this series sit a little longer and id=
eally get
> > > > > > some eyes on the st_sensors patches.         =20
> >=20
> > Sometimes there is no other choice than applying patches to get
> > feedback :) Hopefully nothing unexpected will happen, but as this
> > series lived almost two month on the mailing list already, I would
> > propose to merge the series as it is. We can still drop/revert it as we
> > are rather soon in the new cycle. If rebasing is needed just let me
> > know. =20
>=20
> Fully agree on pushing forwards with merging this.  I've done the rebase =
whilst
> applying. Other than a bit of fuzz main change was that adxl367 made use
> of a kfifo buffer in the meantime so needed updating as well to drop the
> buffer type parameter.=20

Great!

> Take a quick look and see if I messed anything up.
> Applied to the togreg branch of iio.git and pushed out as testing for 0-d=
ay
> etc to take a poke at it before I make a mess of linux-next.

Yep, found on the testing branch, everything LGTM but TBH I don't fully
remember everything as it was "some" time ago :)

Thanks,
Miqu=C3=A8l
