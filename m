Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3368E4AAF6E
	for <lists+linux-iio@lfdr.de>; Sun,  6 Feb 2022 14:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239246AbiBFNVW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 6 Feb 2022 08:21:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236136AbiBFNVW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 6 Feb 2022 08:21:22 -0500
Received: from relay12.mail.gandi.net (relay12.mail.gandi.net [IPv6:2001:4b98:dc4:8::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D99C06173B
        for <linux-iio@vger.kernel.org>; Sun,  6 Feb 2022 05:21:20 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 161CE200002;
        Sun,  6 Feb 2022 13:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1644153678;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/WUU2gEZz2rwyOqxHE0/4kbFuI6fFX3Wp4xUR4nQAb4=;
        b=XREVI2W2HMi4HPnsiPr4MyXM6MYGst+KvEYWhH5QIPp5B03LVLk38Kpnial87+90tl3S9U
        19yM8H3vY8r175yTTxI0XqfoA7Ihma1cAIcltjPz/cPL7bxQZFfh/HcN87fVLdswczuUG1
        vPfpHe1t1nXL78aWnycyQLimkiJMucthbuO+fYe3+kSHblGGkkM8NriiPTjX8I6cq+pZYD
        4PBW2Y/NcY29PM3KBTCT9eNNUbGeSFqrEL24y1ry1ycG9+iYXescCpQI7UMv+6KLbVD/Z6
        0XYQ8alDROR5nzoggJKV6NzEFM3wBDyMF/5C9lHb+DMuG+09y97sdSd1MnalIg==
Date:   Sun, 6 Feb 2022 14:21:16 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 10/10] iio: core: Clarify the modes
Message-ID: <20220206142116.30eadc62@xps13>
In-Reply-To: <20220205185600.14085748@jic23-huawei>
References: <20211215151344.163036-1-miquel.raynal@bootlin.com>
        <20211215151344.163036-11-miquel.raynal@bootlin.com>
        <20220115173050.3501e20c@jic23-huawei>
        <20220202144635.35748521@xps13>
        <20220205185600.14085748@jic23-huawei>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

jic23@kernel.org wrote on Sat, 5 Feb 2022 18:56:00 +0000:

> On Wed, 2 Feb 2022 14:46:35 +0100
> Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>=20
> > Hi Jonathan,
> >=20
> > jic23@kernel.org wrote on Sat, 15 Jan 2022 17:30:50 +0000:
> >  =20
> > > On Wed, 15 Dec 2021 16:13:44 +0100
> > > Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> > >    =20
> > > > As part of a previous discussion with Jonathan Cameron [1], it appe=
ared
> > > > necessary to clarify the meaning of each mode so that new developers
> > > > could understand better what they should use or not use and when.
> > > >=20
> > > > The idea of renaming these modes as been let aside because naming i=
s a
> > > > big deal and requires a lot of thinking. So for now let's focus on
> > > > correctly explaining what each mode implies.
> > > >=20
> > > > [1] https://lore.kernel.org/linux-iio/20210930165510.2295e6c4@jic23=
-huawei/
> > > >=20
> > > > Suggested-by: Jonathan Cameron <jic23@kernel.org>
> > > > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > > > ---
> > > >  include/linux/iio/iio.h | 40 +++++++++++++++++++++++++++++++++++++=
++-
> > > >  1 file changed, 39 insertions(+), 1 deletion(-)
> > > >=20
> > > > diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> > > > index d04ab89fa0c2..75b561fd63d0 100644
> > > > --- a/include/linux/iio/iio.h
> > > > +++ b/include/linux/iio/iio.h
> > > > @@ -314,7 +314,45 @@ static inline bool iio_channel_has_available(c=
onst struct iio_chan_spec *chan,
> > > >  s64 iio_get_time_ns(const struct iio_dev *indio_dev);
> > > >  unsigned int iio_get_time_res(const struct iio_dev *indio_dev);
> > > > =20
> > > > -/* Device operating modes */
> > > > +/**
> > > > + * Device operating modes
> > > > + * @INDIO_DIRECT_MODE: There is an access to the last single value=
 available.     =20
> > >=20
> > > I'd avoid 'last' as not obvious wrt to what time point.  Perhaps use =
something
> > > horrible like "timely"?   =20
> >=20
> > I don't feel a big difference between the two, besides timely being far
> > from easy to understand IMHO, but I'll use it if you think it's best. =
=20
> timely is deliberately slightly vague.  An alternative would be to lay it=
 out
> in detail
>=20
> There is an access to either:
> a) The last single value available for devices that do not provide on dem=
and
>    reads.
> b) A read of a new value is performed on demand.

I just get now why you refused the "last" wording.

That feels infinitely clearer. I'll wait for feedback on the second
version, and include these additional details.

[...]

> > V2 finally coming soon. =20
> You beat me replying but I don't think any of the above replies will grea=
tly influence things.
>=20
> This wordy stuff always takes more thought that code so yet again you end
> up at the end of my review queue with these on the basis of too hard - I'=
ll
> do it later :)

Take your time, you're not the only reviewer either.

Thanks,
Miqu=C3=A8l
