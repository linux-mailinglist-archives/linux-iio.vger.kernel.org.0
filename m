Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE4F5170754
	for <lists+linux-iio@lfdr.de>; Wed, 26 Feb 2020 19:11:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbgBZSLq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 26 Feb 2020 13:11:46 -0500
Received: from mail.andi.de1.cc ([85.214.55.253]:59970 "EHLO mail.andi.de1.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726880AbgBZSLq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 26 Feb 2020 13:11:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Type:MIME-Version:References:
        In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=j8piK5Vy3nVOxJh0bNhZvksvv7dK9C/nnrKn6Rew/Ps=; b=NukH5haLwzCKCNzMUVsEEueaH
        Tw5oXEvjWH7A4fivz/adRC4xaCbAstLyF+hU6p+rekaEEhGajvWdKRfKtHo/5EEhyrWs1pkA/e0WR
        oPDGwsshJfk1TUNNS4hc66k1eZCeJgTM2LY/Hqo+j+j16elEl2611+sDdpNo8sWklTVlI=;
Received: from p200300ccff0a4d00e2cec3fffe93fc31.dip0.t-ipconnect.de ([2003:cc:ff0a:4d00:e2ce:c3ff:fe93:fc31] helo=eeepc)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1j719o-00070m-OQ; Wed, 26 Feb 2020 19:11:41 +0100
Received: from localhost ([::1])
        by localhost with esmtp (Exim 4.92)
        (envelope-from <andreas@kemnade.info>)
        id 1j719o-00019P-54; Wed, 26 Feb 2020 19:11:40 +0100
Date:   Wed, 26 Feb 2020 19:11:38 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        b.galvani@gmail.com, linus.walleij@linaro.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        phh@phh.me, stefan@agner.ch, letux-kernel@openphoenux.org,
        jic23@kernel.org
Subject: Re: [PATCH v5 1/2] mfd: rn5t618: add ADC subdevice for RC5T619
Message-ID: <20200226190028.0de5c095@kemnade.info>
In-Reply-To: <20200226174640.GR3494@dell>
References: <20200223131638.12130-1-andreas@kemnade.info>
        <20200223131638.12130-2-andreas@kemnade.info>
        <20200226154055.GQ3494@dell>
        <20200226174914.047667d5@kemnade.info>
        <20200226174640.GR3494@dell>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/SIFE=+ScTG+hvbM2i8v3=0v"; protocol="application/pgp-signature"
X-Spam-Score: -1.0 (-)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

--Sig_/SIFE=+ScTG+hvbM2i8v3=0v
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 26 Feb 2020 17:46:40 +0000
Lee Jones <lee.jones@linaro.org> wrote:

> On Wed, 26 Feb 2020, Andreas Kemnade wrote:
>=20
> > On Wed, 26 Feb 2020 15:40:55 +0000
> > Lee Jones <lee.jones@linaro.org> wrote:
> >  =20
> > > On Sun, 23 Feb 2020, Andreas Kemnade wrote:
> > >  =20
> > > > This adds a subdevice for the ADC in the RC5T619
> > > >=20
> > > > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > > > ---
> > > > depends on:
> > > > https://lore.kernel.org/lkml/20191220122416.31881-1-andreas@kemnade=
.info/
> > > >=20
> > > > Changes in v3:
> > > > re-added it to the series because of
> > > > "Oh, it looks like there was a conflict.  Could you collect any Acks
> > > > (including mine) rebase and resend please?"   =20
> > >=20
> > > Looks like there is still a conflict.  Sure, it's not a complicated
> > > fix, but that's beside the point.  What tree is this set based on?
> > >  =20
> > It must be applied on top of my rc5t619 rtc series here:
> > https://lore.kernel.org/lkml/20191220122416.31881-1-andreas@kemnade.inf=
o/
> >=20
> > I expected it to make it into 5.6 and when I first sent the RTC series
> >  (in October) I had no idea when I will continue with other stuff.
> >=20
> > That is why I sent this ADC series separately, also to give the IIO
> > maintainer plenty of time to review.  =20
>=20
> If a patch-set can or should be applied on its own, you should send it
> based on an upstream commit, or else things like this happen.
>=20
It cannot without breaking bisectability. The RTC series adds IRQ support in
the PMIC which is used here.

> My advice would be to maintain topic branches, each based on an
> upstream release, which you can merge together into an integration
> branch for full coverage testing.
>=20
> > Do you want me to resend all that pending stuff together in one series?
> > I have little experience with this multi-subdevice process. =20
>=20
> It makes more sense to rebase this set onto the latest full release
> and resubmit this set on its own.
>=20
So, I resend the RC5T619 RTC series mentioned above as you answered
upont Nikolaus question and wait with this series until review is
through.
Ok, so wait and rebase it onto 5.7-rc1 or 5.8-rc1 or whatever release
the RTC stuff will appear.
So you are not going to create an ib-mfd-rtc-iio branch.

Regards,
Andreas

--Sig_/SIFE=+ScTG+hvbM2i8v3=0v
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEPIWxmAFyOaBcwCpFl4jFM1s/ye8FAl5WtNoACgkQl4jFM1s/
ye/sIQ/8DP1K657W58Pek8cfq+s+pkuon36N55M9vsKG0uld08HlfuO69L0ZPm3G
5BOG1Rpv7Hm4Gjn4MSQCmTe87/W3CtmWL+eWsv+tlj7HzR+qXACaeHO7SG+l2z8n
jkZDMVBj4131zXsa8feKn9Riwi7FLFu5uWKMFZPTZG4BzfLbAkSxZsRxN3Zm9IKQ
nwGpHKC0X1/GE0aL/WDS2PT7C5GlunxP/KiyBUEvBM9Th1R7Bgy+dexymWFevDtC
Icki+Aq/iQkU6zIC1gIbiAnTx/Etu5b1AgnK788du0RvvRS1WxMYRWALDidOyFkX
e2gCAeeBPJVOZGCc203hhbyS637SY05FYreBRX9N3V+LFE0OrxS0REeFC1ZYlbv8
xu7v269xFhwwnsZzRwKOxEgh3hJJUVOkh6W97iyHdE4yZf1kHXNZ0csn8U1VtQKB
a+HQvnCpZsQ2LinmLMwOj1pSl7mpHVuIkTlL0LRqzA0jU/G4fxihxLU8MNEJ6jsQ
AWMum+FQcOyxY8NodjMATr83tC3mZnodUkTgL+djQEhv1q2sKqbOj7Xr0FvESJLa
hZ38x5FqBPHcJZ7H08pFGIBHwTJSMrx7ynIiwKJDcrWGnKSDcZLKqbRe4/GjbS43
cRy1lHQBbp+ucCH8/eVWQ5tjgj7RtI/ONnwID+xj5SRUxvVK97s=
=i3Qi
-----END PGP SIGNATURE-----

--Sig_/SIFE=+ScTG+hvbM2i8v3=0v--
