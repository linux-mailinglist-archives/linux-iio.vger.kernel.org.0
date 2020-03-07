Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA5CE17CDC4
	for <lists+linux-iio@lfdr.de>; Sat,  7 Mar 2020 12:18:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726086AbgCGLSB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 7 Mar 2020 06:18:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:44608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726043AbgCGLSB (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 7 Mar 2020 06:18:01 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA9012070A;
        Sat,  7 Mar 2020 11:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583579880;
        bh=QeKrgZWQsF8BR879RoE7mv+2V8z/uldqq7Jp8VbRClA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FPGUd7DT8vA5HlsQmf5T05eb6wSw/yoTNH1raSO4+l5d1tAWO6jI4dWcgYrvEDGNk
         D4f5XJ7r34GXqNY2xGA3PPMy+JOMMYFTdB/wruZsWFw+KOL/KUNv9wUlRkrn6G9ZwO
         4GyY+fQdU3LSJgLn0f92bs7xb47aAjeg4KacbUA4=
Date:   Sat, 7 Mar 2020 11:17:55 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Silvan Murer <silvan.murer@gmail.com>,
        linux-iio@vger.kernel.org,
        Maxime Roussin-Belanger <maxime.roussinbelanger@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hartmut Knaack <knaack.h@gmx.de>, kernel@pengutronix.de
Subject: Re: [PATCH 4/3] iio: dac: ltc2632: remove some unused defines
Message-ID: <20200307111755.51d1a4d9@archlinux>
In-Reply-To: <20200225093259.rx34tfu4yscfbmwq@pengutronix.de>
References: <20200130131549.1170-1-u.kleine-koenig@pengutronix.de>
        <20200203203126.7003-1-u.kleine-koenig@pengutronix.de>
        <20200206102915.2e32cb5e@archlinux>
        <20200206103443.hki3hxeiigowjlxj@pengutronix.de>
        <20200206104418.2272c18c@archlinux>
        <20200225093259.rx34tfu4yscfbmwq@pengutronix.de>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 25 Feb 2020 10:32:59 +0100
Uwe Kleine-K=C3=B6nig         <u.kleine-koenig@pengutronix.de> wrote:

> On Thu, Feb 06, 2020 at 10:44:18AM +0000, Jonathan Cameron wrote:
> > On Thu, 6 Feb 2020 11:34:43 +0100
> > Uwe Kleine-K=C3=B6nig         <u.kleine-koenig@pengutronix.de> wrote:
> >  =20
> > > On Thu, Feb 06, 2020 at 10:29:15AM +0000, Jonathan Cameron wrote: =20
> > > > On Mon,  3 Feb 2020 21:31:26 +0100
> > > > Uwe Kleine-K=C3=B6nig         <u.kleine-koenig@pengutronix.de> wrot=
e:
> > > >    =20
> > > > > These two defines are unused since the driver was introduced in c=
ommit
> > > > > 02b829f9e11f ("iio: dac: Add support for ltc2632 DACs").
> > > > >=20
> > > > > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix=
.de>   =20
> > > > A bit of fuzz and the mysterious bit of this being patch 4 of 3 asi=
de all good.
> > > >=20
> > > > Applied to the togreg branch of iio.git and pushed out as testing. =
  =20
> > >=20
> > > If you applied patches 2 and 3 of the series before, the fuzz should
> > > disappear. I assume the threading didn't work as intended for you and
> > > you don't have the original patch series grouped with my patch 4/3? =
=20
> > Yup.  Just realised that after sending :) =20
> >=20
> > I'll apply them in the right order. =20
>=20
> Last time I already wondered why patches you applied don't appear in
> next. This had something to do with the workflow how patches go from you
> over Greg to Linus.
>=20
> Given that next is different and in my experience it is possible to get
> a tree into next even as a "second-level" maintainer, I wonder if adding
> your tree would be beneficial. You applied the patch more than two weeks
> ago and there is still no exposure to next. :-|

Ideally things would normally move quicker. I've been fighting off a
nasty and very persistent cold so running rather behind.

Agreed in theory it would make sense to take IIO directly into next,
but to do that the issue is that my availability can be rather intermittent
so I try to time pull requests to Greg for times when I can deal with any
fall out the over the next few days.  It's not uncommon for there to be
problems and I hate to annoy people by not being able to sort them in
a timely fashion.

Anyhow, I'll look at it again sometime soon.

Jonathan

>=20
> Best regards
> Uwe
>=20

