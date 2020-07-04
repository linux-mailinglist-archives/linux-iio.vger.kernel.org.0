Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66B51214797
	for <lists+linux-iio@lfdr.de>; Sat,  4 Jul 2020 18:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbgGDQ6k (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Jul 2020 12:58:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:37528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726643AbgGDQ6k (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 4 Jul 2020 12:58:40 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5815720723;
        Sat,  4 Jul 2020 16:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593881920;
        bh=S4Vtkk7hqOdMamEw6xJhux/pYg6QkFMPFZyt1p2Q0O8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KTDTjlRMyxInzlYszTcBkysoo8Ex0nJznPeKjSYBXF65eY7zP1r+9qM7hfuNdgdTc
         ChQB09Te3pj0JaSHH1ox6u6gePYRY2UEWRN41rWNgnG3IQaaBGxyUNMclybDDrUGYy
         CQTKHbMJ0/wCJHDVWuNc0LFn8EyP8K/L4bwk88IY=
Date:   Sat, 4 Jul 2020 17:58:35 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-iio@vger.kernel.org, alexandru.Ardelean@analog.com,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 07/23] iio:adc:ltc2496: Drop of_match_ptr and use
 mod_devicetable.h
Message-ID: <20200704175835.1b995322@archlinux>
In-Reply-To: <20200628155221.jujln4b24jlorpbk@pengutronix.de>
References: <20200628123654.32830-1-jic23@kernel.org>
        <20200628123654.32830-8-jic23@kernel.org>
        <20200628155221.jujln4b24jlorpbk@pengutronix.de>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 28 Jun 2020 17:52:21 +0200
Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> wrote:

> Hallo Jonathan,
>=20
> On Sun, Jun 28, 2020 at 01:36:38PM +0100, Jonathan Cameron wrote:
> > @@ -96,7 +96,7 @@ MODULE_DEVICE_TABLE(of, ltc2496_of_match);
> >  static struct spi_driver ltc2496_driver =3D {
> >  	.driver =3D {
> >  		.name =3D "ltc2496",
> > -		.of_match_table =3D of_match_ptr(ltc2496_of_match),
> > +		.of_match_table =3D ltc2496_of_match, =20
>=20
> The usage of of_match_ptr would only make sense here if ltc2496_of_match
> was defined conditionally. As this isn't the case:
>=20
> Reviewed-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
Thanks,=20

Applied to the togreg branch of iio.git and pushed out as testing to
see if we missed anything.

Thanks,

Jonathan

>=20
> Thanks
> Uwe
>=20

