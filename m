Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6DF67E74
	for <lists+linux-iio@lfdr.de>; Sun, 14 Jul 2019 12:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728065AbfGNKJH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Jul 2019 06:09:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:44166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726799AbfGNKJH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 14 Jul 2019 06:09:07 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 72AEA20838;
        Sun, 14 Jul 2019 10:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563098946;
        bh=Yc6A1cGAFiY0v3G2IKWiF9mvk1/HlO1sJcd6V4N1RLw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZDxY3BZOCdUdALgKCB7dBFPWLfaNlyx1FB5VCelksB9alIU6P3TV62dLIed2S0tlT
         ve2lgBis3EJnUiaZ/rkU3FnfKX/xnpA7oZHs+IpX6Bfm+n0LiLQKGMrC1VAdO0ilGi
         twjFVTSheEUNKMg7GCzp5m6bPbumKhpSSSo7P8ok=
Date:   Sun, 14 Jul 2019 11:09:01 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Benjamin Gaignard <benjamin.gaignard@st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-iio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] IIO: stm32: Remove quadrature related functions from
 trigger driver
Message-ID: <20190714110901.752643ae@archlinux>
In-Reply-To: <20190711121620.GA11661@icarus>
References: <20190507091224.17781-1-benjamin.gaignard@st.com>
        <20190711115059.GA7778@icarus>
        <CA+M3ks42Whd=QVQ-4==n5bRJKEwYpQtRHs=gBGEZ_Hr=_8YU1g@mail.gmail.com>
        <20190711121620.GA11661@icarus>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 11 Jul 2019 21:16:20 +0900
William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> On Thu, Jul 11, 2019 at 02:12:27PM +0200, Benjamin Gaignard wrote:
> > Le jeu. 11 juil. 2019 =C3=A0 13:51, William Breathitt Gray
> > <vilhelm.gray@gmail.com> a =C3=A9crit : =20
> > >
> > > On Tue, May 07, 2019 at 11:12:24AM +0200, Benjamin Gaignard wrote: =20
> > > > Quadrature feature is now hosted on it own framework.
> > > > Remove quadrature related code from stm32-trigger driver to avoid
> > > > code duplication and simplify the ABI.
> > > >
> > > > Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com> =20
> > >
> > > What is the status of this patch? Are there any objections currently =
for
> > > its inclusion? =20
> >=20
> > You were the only one asking for more details about it :-)
> > If you agree I think that Jonathan can merge it.
> >=20
> > Benjamin =20
> > >
> > > William Breathitt Gray
> > >
> > > _______________________________________________
> > > linux-arm-kernel mailing list
> > > linux-arm-kernel@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel =20
>=20
> Yes, Jonathan please merge this if you have no objections, I hadn't
> realized I was delaying it.
>=20
> Thank you,
>=20
> William Breathitt Gray
One last thing...  This seems to be a userspace ABI change.  What
are our potential issues with users of this ABI?

It's not that costly to keep the code, though dropping the docs or
putting a depreciated note in them is probably a good idea.  Hence
I'm not totally convinced the risk of a regression is worth it.

If we think it's the sort of change no one will notice, then
fair enough we'll give it a go and cross our fingers.

Thanks,

Jonathan


