Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51DAD10E17A
	for <lists+linux-iio@lfdr.de>; Sun,  1 Dec 2019 12:00:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbfLALAZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 1 Dec 2019 06:00:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:38742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725993AbfLALAZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 1 Dec 2019 06:00:25 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0608A215E5;
        Sun,  1 Dec 2019 11:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575198024;
        bh=LWBaFtT6IIDSQ5b2o9el1T7XQcj4F/VBmLdqMZTd+KY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KkT2QxHOddMyGfr+Sf6DtacmFVbjPwIJdG9dM7u9vwIBeo/FI7Hc/GhrbLYfLadnS
         jaT0H6r1J+Ya11D9nZ4+DGxGHcAw+SQUrZdD5nRPJDddCsyvGANp9y9FRP/AnL0ily
         uBLgaTGH7+nQ55zSj8XGu8XVG3txKAOWmQ8LCZH0=
Date:   Sun, 1 Dec 2019 11:00:19 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Alexandru Ardelean <alexandru.Ardelean@analog.com>,
        linux-iio@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH v3 3/3] iio: adc: new driver to support Linear
 technology's ltc2496
Message-ID: <20191201110019.7cac56ac@archlinux>
In-Reply-To: <20191124191101.duh646kbrlackget@pengutronix.de>
References: <20191121210007.25646-1-u.kleine-koenig@pengutronix.de>
        <20191121210007.25646-4-u.kleine-koenig@pengutronix.de>
        <20191123171204.3a714322@archlinux>
        <20191124191101.duh646kbrlackget@pengutronix.de>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 24 Nov 2019 20:11:01 +0100
Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> wrote:

> On Sat, Nov 23, 2019 at 05:12:04PM +0000, Jonathan Cameron wrote:
> > On Thu, 21 Nov 2019 22:00:07 +0100
> > Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> wrote:
> >  =20
> > > This chip is similar to the LTC2497 ADC, it just uses SPI instead of =
I2C
> > > and so has a slightly different protocol. Only the actual hardware
> > > access is different. The spi protocol is different enough to not be a=
ble
> > > to map the differences via a regmap.
> > >=20
> > > Also generalize the entry in MAINTAINER to cover the newly introduced
> > > file.
> > >=20
> > > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>=
 =20
> > looks good with the exception of the now overly protected DMA buffers.
> >=20
> > See inline.  As that's all I'm seeing that needs fixing I'll just
> > fix this up whilst applying.
> >=20
> > I'd like the series to sit a little longer on the list though to give
> > devicetree maintainers time to look at the bindings. =20
>=20
> ok.
>=20
> > > +struct ltc2496_driverdata {
> > > +	/* this must be the first member */
> > > +	struct ltc2497core_driverdata common_ddata;
> > > +	struct spi_device *spi;
> > > +
> > > +	/*
> > > +	 * DMA (thus cache coherency maintenance) requires the
> > > +	 * transfer buffers to live in their own cache lines.
> > > +	 */
> > > +	unsigned char rxbuf[3] ____cacheline_aligned;
> > > +	unsigned char txbuf[3] ____cacheline_aligned; =20
> > Ah.  I've not explained this clearly enough.  Upshot is you only need
> > to ensure that the buffers used for dma are not shared with any other
> > usage.  the __cacheline_aligned marker pads the structure to ensure
> > the element so marked is at the start of a new cacheline.  This means
> > there is no sharing with non DMA related elements which may be accident=
ally
> > reset when the DMA transfer ends.
> >=20
> > Imagine we had:
> > struct bob {
> > 	int a; //used for all sorts of fun things not related to dma and not
> >        	       //protected from happening concurrently with dma.
> > 	unsigned char rx_buf[3];
> > 	unsigned char tx_buf[3]
> > };
> >=20
> > The buffers are used for DMA.  The DMA engine takes a copy of the cache=
line
> > to start doing it's magic.
> >=20
> > Along comes other activity and writes to 'a'.
> >=20
> > DMA completes, then engine pushes the cacheline back to the memory incl=
uding
> > writing back what it had as a copy of a.  Thus the update to 'a' is los=
t.
> >=20
> > Now the guarantee we make use of is that DMA engines are not allowed to
> > copy cachelines that do not contain the buffers they are using (all sor=
ts
> > of things would break if they were).
> >=20
> > However, there is no need to separate rx_buf and tx_buf as they are bei=
ng
> > used by the same DMA engine and nothing else is going to update them wh=
ilst
> > they are in use. =20
>=20
> Yeah, I thought about that when adding the second annotation but then
> forgot to mention that in my cover letter.
>=20
> So I assume you will just drop the 2nd ____cacheline_aligned? That's
> fine for me; thanks.
Yup.

Jonathan

>=20
> Best regards
> Uwe
>=20

