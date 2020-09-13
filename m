Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACA61267EF6
	for <lists+linux-iio@lfdr.de>; Sun, 13 Sep 2020 11:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725923AbgIMJji (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 13 Sep 2020 05:39:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:43572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725916AbgIMJjg (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 13 Sep 2020 05:39:36 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDB872076C;
        Sun, 13 Sep 2020 09:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599989976;
        bh=LDOuPsnG3YrpXDfserIQ0Ztfuc5KAHndkk/KwBoM/JY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hoQHanextgqLEMj3cbQvPcpM4R0u2unqari+FSr8C9XnyBCauE+L4sLLhjyI1ChBG
         PElubQgSF0R8uiJBB2y1m9BIBmbp6fq+2zmR7am10Dn41r1uB49hjSjZ+jaE/VmMH+
         3QhM8T7ZNy3woveHJpDhCCaXyj22fc6XONSXb0eE=
Date:   Sun, 13 Sep 2020 10:39:30 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Christian Eggers <ceggers@arri.de>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: light: as73211: Increase measurement timeout
Message-ID: <20200913103930.7ba15df0@archlinux>
In-Reply-To: <6187855.5mNlXCv1x4@n95hx1g2>
References: <20200909154439.10308-1-ceggers@arri.de>
        <CAHp75VeAoDaBtaSb0Qeb=kHPg6kGvx71_iL2snC5iHh4cKPhRA@mail.gmail.com>
        <6187855.5mNlXCv1x4@n95hx1g2>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 9 Sep 2020 20:04:24 +0200
Christian Eggers <ceggers@arri.de> wrote:

> On Wednesday, 9 September 2020, 18:58:39 CEST, Andy Shevchenko wrote:
> > On Wed, Sep 9, 2020 at 6:45 PM Christian Eggers <ceggers@arri.de> wrote=
: =20
> > > We found some sensors which are much slower (20% at room temperature)
> > > than nominal. According to the data sheet, up to 27% is possible. Now=
 I
> > > add 33% to the nominal time out, hopefully this is enough. =20
> >
> > I'm wondering if this is a function of temperature.
> > And if that has an actual thermistor inside... =20
>  I haven't designed the hardware, but I guess that clock generation is do=
ne
> using an RC oscillator which depends on temperature. Temperature measurem=
ent
> is possible, but I think the recommended way is to externally control the
> integration time using the SYN pin and to get the actual number of RC cyc=
les
> from a register. But generating the required waveform for the SYN pin usi=
ng a
> uC general purpose timer seems challenging.
>=20
> I wouldn't be surprised if the measurement results also depend on the exa=
ct
> value of the supply voltage.
Applied to the togreg branch of iio.git and added a fixes tag to the patch
that introduced the driver.  Note, please try to provide me with one of tho=
se
even if the patch hasn't yet gotten into mainline.  It makes life a little
easier for the stable maintainers etc.  I don't always remember to add one
at point of applying the patch.

Thanks,

Jonathan

>=20
>=20
> ________________________________
>  [http://assets.arri.com/media/sign/2020-04-03-E-mail-signature-Stellar2_=
V1.jpg] <https://microsites.arri.com/stellar/>
>=20
> Get all the latest information from www.arri.com<https://www.arri.com/>, =
Facebook<https://www.facebook.com/TeamARRI>, Twitter<https://twitter.com/AR=
RIChannel>, Instagram<https://instagram.com/arri> and YouTube<https://www.y=
outube.com/user/ARRIChannel>.
>=20
> Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
> Sitz: M=C3=BCnchen - Registergericht: Amtsgericht M=C3=BCnchen - Handelsr=
egisternummer: HRA 57918
> Pers=C3=B6nlich haftender Gesellschafter: Arnold & Richter Cine Technik G=
mbH
> Sitz: M=C3=BCnchen - Registergericht: Amtsgericht M=C3=BCnchen - Handelsr=
egisternummer: HRB 54477
> Gesch=C3=A4ftsf=C3=BChrer: Dr. Michael Neuh=C3=A4user; Stephan Schenk; Wa=
lter Trauninger; Markus Zeiler

