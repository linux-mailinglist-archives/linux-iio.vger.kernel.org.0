Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C34FA3C5BC4
	for <lists+linux-iio@lfdr.de>; Mon, 12 Jul 2021 14:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbhGLLwd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 12 Jul 2021 07:52:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:60450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229594AbhGLLwc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 12 Jul 2021 07:52:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 16E6F61006;
        Mon, 12 Jul 2021 11:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626090584;
        bh=SC+5U01yNpUqqr/bBeY1eDompES0pbDuc98+NKWl3bQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SyKs1JWoVFAo8D/LVvz0Lo2KGUCuYMZ5gS7UXcXscTkQKOYGkkzss2j/bbyYcIzZ8
         WYkn6mxukLM6Fjnlnui991+qn187DSsSw1Oq/pyuzWkogK/m5I0e8NqevuGDmtrT+k
         VqHKonrVHn6iuKYimDj1++fbyafU7O2ujDOBIcbdw4tlshlgKkqDMtXmcUtSxk5m5O
         W37ESN+6txUXz17t+b6ca8GthW0ipbICcKRxHFymePzizad7H3oVKU8/45ZJz8WZ1C
         egQJjHD//wHEtYVI95e4ZbkCm+mqOEXJnf/LCC+FASW4RjS4Yda7QEcg2cQO1b612e
         zvjtrhm3FPGdg==
Date:   Mon, 12 Jul 2021 12:49:09 +0100
From:   Mark Brown <broonie@kernel.org>
To:     David Lechner <david@lechnology.com>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>, linux-spi@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ti-ads7950: Ensure CS is deasserted after
 reading channels
Message-ID: <20210712114909.GA4435@sirena.org.uk>
References: <20210709101110.1814294-1-u.kleine-koenig@pengutronix.de>
 <00b3dd46-48ba-3d40-36dd-79372a956085@lechnology.com>
 <20210710121815.yxaylkhessvjbtkf@pengutronix.de>
 <d98603e7-3336-617a-0e2f-e964eb3c894c@lechnology.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zhXaljGHf11kAtnf"
Content-Disposition: inline
In-Reply-To: <d98603e7-3336-617a-0e2f-e964eb3c894c@lechnology.com>
X-Cookie: Hailing frequencies open, Captain.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 10, 2021 at 10:32:46AM -0500, David Lechner wrote:
> On 7/10/21 7:18 AM, Uwe Kleine-K=F6nig wrote:

> > If it's not broken for you without my patch, your spi bus driver doesn't
> > honor .cs_change in the last transfer. Out of interest: Which bus are
> > you using? I wonder if the driver should refuse the request if it cannot
> > honer .cs_change?! (spi-imx does honor it only if gpios are used as chip
> > select, the native chip selects cannot do that.)

> I'm using spi-davinci. It uses the standard spi_transfer_one_message()
> which handles cs_change. But I suspect when the SPI_CS_WORD flag is set,
> and the message is big enough to use DMA, the hardware is probably
> automatically toggling CS after the last transfer before the cs_change
> logic asserts it again.

> So unless there is a valid use case where we need both SPI_CS_WORD
> and cs_change, I don't think we need to fix spi-davinci.

In theory it does mean something, in practice the number of controllers
that can implement it must be approaching zero.

--zhXaljGHf11kAtnf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDsLDQACgkQJNaLcl1U
h9DQkwf/VeDCJNOHpII7ppALVNCndIap+Yelbu7GPBCzi5wpEblkdV9//Bua/GJP
sOd72Q2UBXQOJegEmekU2/oux1jpyIRCvuWjcobixB9lqahDNzw5o/ivCbj6hgB0
7ajpdo6kTy30SybHjPxJn3wcEOPdblKgwOdEewIqSlmFLyK/pPu87iFtIc92LZtl
uV15eteYwYuSte7IuCPD50wJiqK5BBZv3gCvf2FD196hBfwMJk9cRQcUPXs8uw1F
NOoih6VPHOYb2yqwyF5djqqI165GW0ooEswE23L0uq7xFhu1Qvb5d30EI/VRA4Ei
cgiHVqLeLpNNg5qKHc2r9shqDUeDZg==
=eYWi
-----END PGP SIGNATURE-----

--zhXaljGHf11kAtnf--
