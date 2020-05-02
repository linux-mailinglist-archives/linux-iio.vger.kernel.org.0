Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D503A1C2777
	for <lists+linux-iio@lfdr.de>; Sat,  2 May 2020 20:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbgEBSHz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 2 May 2020 14:07:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:49808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727997AbgEBSHz (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 2 May 2020 14:07:55 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4AB4D206CD;
        Sat,  2 May 2020 18:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588442875;
        bh=LFBiura8oNYbLlkJUPEOFowICXKprYZOh30K36bcOSU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fBo/wCDucspKSG2NxBCAnBdG3xho3Ao662M4INjZkm1tkEoFQu/6nvX9i8GtrerWc
         SozKVmeOzXdzi8MOvQeW/iG9CWDdIg6FTKrFHSDIafGlLJtd79WJMEr/1lJm8Scl0g
         G/+EAs4HPZLOGRDBTMqK6Xsf3qEFQ1wVYx6j3vrc=
Date:   Sat, 2 May 2020 19:07:51 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Bastien Nocera <hadess@hadess.net>
Cc:     =?UTF-8?B?R2HDq3RhbiBBbmRyw6k=?= <rvlander@gaetanandre.eu>,
        linux-iio@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Denis Ciocca <denis.ciocca@st.com>
Subject: Re: [PATCH v2] iio: st_sensors: make scale channels also shared by
 type
Message-ID: <20200502190751.53123be3@archlinux>
In-Reply-To: <faf0bf3315c93fddee4f4cdb890bc5e80701c8fd.camel@hadess.net>
References: <20200423121714.607262-1-rvlander@gaetanandre.eu>
        <20200425181359.1e30e315@archlinux>
        <faf0bf3315c93fddee4f4cdb890bc5e80701c8fd.camel@hadess.net>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 26 Apr 2020 13:19:09 +0200
Bastien Nocera <hadess@hadess.net> wrote:

> On Sat, 2020-04-25 at 18:13 +0100, Jonathan Cameron wrote:
> > On Thu, 23 Apr 2020 14:17:15 +0200
> > Ga=C3=ABtan Andr=C3=A9 <rvlander@gaetanandre.eu> wrote:
> >  =20
> > > Scale channels are available by axis. For example for
> > > accelerometers,
> > > in_accel_x_scale, in_accel_y_scale and in_accel_z_scale are
> > > available.
> > >=20
> > > However, they should be shared by type as documented in
> > > Documentation/ABI/testing/sysfs-bus-iio.
> > >=20
> > > For each sensor (acceleros, gyros and magnetos) only one value is
> > > specified
> > > for all the axes.
> > >=20
> > > Existing, by axis, entries are preserved in order to to leave the
> > > old ABI
> > > untouched. =20
> > As I mentioned in v1, there isn't a strict ABI rule that says that we
> > must
> > do the shared form
> >=20
> > +CC'd Bastien for comment on what userspace is assuming and whether
> > we should
> > push this back to stable or not. =20
>=20
> I have no idea what the effects of this would be on the ABI, and how
> this would impact iio-sensor-proxy.

There goes me being lazy ;)

>=20
> Code is here though, so it might be best to test it:
> https://gitlab.freedesktop.org/hadess/iio-sensor-proxy/-/tree/master/src
>=20
> And we accept merge requests :)

Only looks at scale and in_accel_scale

Easy enough to fix...

Note that for some older accelerometers it has to do per channel scales btw.
It used to be hard to have the same range out of the plane of the silicon
than within it, so was common to have sensors with different ranges and hen=
ce
scales in z direction from x and y.

I'll apply the kernel patch but good to fix up iio-sensor-proxy as well.

I would ideally like Denis to give this a quick sanity check though as I'd
like to give it a stable tag and don't want any unexpected breakage.

Thanks,

Jonathan

>=20

