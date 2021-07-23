Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9795D3D3F1E
	for <lists+linux-iio@lfdr.de>; Fri, 23 Jul 2021 19:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbhGWRH0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 23 Jul 2021 13:07:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:49674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230098AbhGWRHZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 23 Jul 2021 13:07:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 38CD660EFD;
        Fri, 23 Jul 2021 17:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627062478;
        bh=wAsX2Nk+nTgle1kPTUQiq6x5TqfTNwwyAmYsvPzwE04=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BDEQH6Bsm11H6Hc13n07saNw1FLi/zd00LorhzeUQdBEmBaLMk74maF3DPOsHYQNV
         r+5qo+rs18oU7qUOkCCRq0uY6UvHzqsu+Os/qyhLaYPKC4jwOf0rm4oChUYhDgOwCA
         WwWhMllOzR5tHwCJbAUbz2kVxkVi3b0zxGwCMYlblqUqQWIgE5waU/wH7CFgPky1l5
         07FVh0zdqgS4DowpOI24zZUGErIwHnnIunyY6DHIWXFwVHa1JiQgLRVKGXnb7lVBJb
         k2DuZOGAKPgrYLdKoAiCcD1pht4ac+xaEmqnjUQqSB3MJ0fnSbrPg0xvCFpfD34xfq
         5wunHoDJtxXUg==
Date:   Fri, 23 Jul 2021 18:47:51 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Puranjay Mohan <puranjay12@gmail.com>,
        Michael.Hennerich@analog.com, alexandru.ardelean@analog.com,
        jic23@kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        lars@metafoo.de, Dragos.Bogdan@analog.com, Darius.Berghe@analog.com
Subject: Re: [PATCH v2 2/2] iio: accel: Add driver support for ADXL355
Message-ID: <20210723174751.GL5221@sirena.org.uk>
References: <20210723184404.0000001d@Huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rfwNdt5cNUUjB/69"
Content-Disposition: inline
In-Reply-To: <20210723184404.0000001d@Huawei.com>
X-Cookie: Integrity has no need for rules.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--rfwNdt5cNUUjB/69
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 23, 2021 at 06:44:04PM +0100, Jonathan Cameron wrote:
> Mark Brown <broonie@kernel.org> wrote:

> > > @Mark.  This has come up a few times recently.  Are we now safe to as=
sume
> > > that regmap will always copy data when used with SPI and hence we no
> > > longer need to ensure DMA safe buffers?    =20

> > Only for single register I/O, I'd not assume that for things like raw
> > I/O.

> Thanks for the confirmation.  So in this driver that means we
> need DMA safe buffers for the regmap_bulk_ calls.  Easiest approach
> is probably to use a __cacheline_aligned buffer at the end of the
> iio_priv() structure.

Yeah, it might be fine depending on the bus/format type but it's not
something you can generally assume.

--rfwNdt5cNUUjB/69
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmD7AMcACgkQJNaLcl1U
h9CP+Qf+Lsc5GFkzeUzJpgvTvqmz/f+mVquFladiTHzq4Vd4lCSrD+l12g2lHQHQ
bOgOkoGRi0M/NOCwetKglIQNwyUY8WtGY+I8GNpZL53wN//EjBVF29EyM6/huRxt
W+tzv2euWk9Tzq6wKj9P8G7Sa0/kIune3KaxtXA8bmEheJ0OszZBLV3qkY3PYgTF
8GWsGQCGkysrve98sTfQcjWyFsPNFgKhMsBQ6SPYYebK8xtFy9qIezumGkXuWQBw
k0PFc9Lwz+X/ownmafloKIzZCmHkbpL87h+SBI6HS7BN6kLWFe1aVzuGDaqJy9HN
e64jWE5y4GtlufUNHTpbWH7cfXLeMg==
=PJ6s
-----END PGP SIGNATURE-----

--rfwNdt5cNUUjB/69--
