Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FBBF17CF0F
	for <lists+linux-iio@lfdr.de>; Sat,  7 Mar 2020 16:30:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbgCGPaG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 7 Mar 2020 10:30:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:56284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726174AbgCGPaF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 7 Mar 2020 10:30:05 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D377320656;
        Sat,  7 Mar 2020 15:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583595005;
        bh=ET+dIcC8U+H1cgo4LTQc3rW0ut0gu60CQqxHrhomVKc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bBdbyjEc3C69CrD/M7sxg/s75pzPy6npNrJFrHy8TXMR4m6vLzHv/xvbhnqFn5I75
         Vy2Fcvz1By+weuWdtXIoONTa0ZN8izUa9PzMZr5Tbcxeek+czZzcLitMikr6Ss3Iml
         0cqPjVVL4bCKE44LLjnPg7WytxfI07ny11vy+xmk=
Date:   Sat, 7 Mar 2020 15:30:00 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andreas Klinger <ak@it-klinger.de>
Cc:     YueHaibing <yuehaibing@huawei.com>, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, Jonathan.Cameron@huawei.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] iio: ping: set pa_laser_ping_cfg in of_ping_match
Message-ID: <20200307153000.3b6db32a@archlinux>
In-Reply-To: <20200304115546.GA8509@arbad>
References: <20200304113423.26920-1-yuehaibing@huawei.com>
        <20200304115546.GA8509@arbad>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 4 Mar 2020 12:55:46 +0100
Andreas Klinger <ak@it-klinger.de> wrote:

> Acked-by: Andreas Klinger <ak@it-klinger.de>
Applied to the fixes-togreg branch of iio.git.

Btw this is also in mainline I believe, so the -next is probably an
inappropriate marking.

Thanks,

Jonathan

>=20
> YueHaibing <yuehaibing@huawei.com> schrieb am Mi, 04. M=C3=A4r 19:34:
> > pa_laser_ping_cfg should be set in of_ping_match
> > instead of pa_ping_cfg.
> >=20
> > Fixes: 7bb501f49ddb ("iio: ping: add parallax ping sensors")
> > Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> > ---
> >  drivers/iio/proximity/ping.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/iio/proximity/ping.c b/drivers/iio/proximity/ping.c
> > index 34aff10..12b893c 100644
> > --- a/drivers/iio/proximity/ping.c
> > +++ b/drivers/iio/proximity/ping.c
> > @@ -269,7 +269,7 @@ static const struct iio_chan_spec ping_chan_spec[] =
=3D {
> > =20
> >  static const struct of_device_id of_ping_match[] =3D {
> >  	{ .compatible =3D "parallax,ping", .data =3D &pa_ping_cfg},
> > -	{ .compatible =3D "parallax,laserping", .data =3D &pa_ping_cfg},
> > +	{ .compatible =3D "parallax,laserping", .data =3D &pa_laser_ping_cfg},
> >  	{},
> >  };
> > =20
> > --=20
> > 2.7.4
> >=20
> >  =20

