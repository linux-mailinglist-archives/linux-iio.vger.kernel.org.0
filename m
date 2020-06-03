Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 619E01ECDD0
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jun 2020 12:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725855AbgFCKvL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 3 Jun 2020 06:51:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:51726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725828AbgFCKvL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 3 Jun 2020 06:51:11 -0400
Received: from localhost (unknown [151.48.128.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B1312067B;
        Wed,  3 Jun 2020 10:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591181470;
        bh=j0qIzqJzilwp6oO+/XMKF2k5hrhgYS82J8xsby+JeCM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FEmOMQs950ZDNdI9m4SU8jouFFfvZqpP3Re29uf1d3Fv57lNI9qIw4JyRJwsCnRkI
         Wn4jvaDsrlHPeHu2ceiZ00dd0q6Gr/Ib176COB9X+wq7BTRCC1DdeVKGonuyxw38AZ
         dsjI93oeafOc2ZLTBvUNOi8+viCu77G2S5AYHe1M=
Date:   Wed, 3 Jun 2020 12:51:05 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: IIO timestamp get skewed when suspending (st_lsm6dsx)
Message-ID: <20200603105105.GD544784@lore-desk.lan>
References: <20200529085052.GC3198@localhost.localdomain>
 <08c824c2-dfb2-7a5c-b6fd-8258d6ce3808@geanix.com>
 <20200529121616.GD3198@localhost.localdomain>
 <26401237-5e3b-faf7-35c7-9d6e22f6d239@geanix.com>
 <b3363da1-033b-4afa-59cd-28328ec32066@geanix.com>
 <e9964fda-3b83-2e23-299a-7ab7d50529af@geanix.com>
 <20200603080619.GA544784@lore-desk.lan>
 <91165f5d-8cba-3ea2-67dc-99d65bce3d19@geanix.com>
 <20200603102841.GC544784@lore-desk.lan>
 <d3288925-0891-8c72-b0e7-2b71ff50e1d3@geanix.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="KdquIMZPjGJQvRdI"
Content-Disposition: inline
In-Reply-To: <d3288925-0891-8c72-b0e7-2b71ff50e1d3@geanix.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--KdquIMZPjGJQvRdI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > >=20
> > > Hmm, suspend again for 15s.
> > >=20
> > > https://gist.github.com/sknsean/911ae4ae2e74ebe1e7eca1405c645ff1
> > >=20
> > > [  105.520634] PM: suspend exit
> > > [  105.540206] ts_ref 1591097307780181385, ts 2861700000, sample_time
> > > 1591097310641881385
> > >=20
> > > [  105.548416] ktime_get_real_ns: 1591097322928175385
> > >=20
> > > CLOCK_REALTIME isn't ready in the resume function. I think we need to=
 link
> > > it to CLOCK_BOOTTIME (Which ticking under suspend) instead.
> >=20
> > With latest patch it seems to me the time reported is now monotonic so =
it seems
> > correct. What is the clocktype you set? you can check it in:
> > /sys/bus/iio/devices/iio:device<x>/current_timestamp_clock
>=20
> default: realtime
>=20
> In the dump above the ktime_get_real_ns(first fifo dump after suspend) -
> ts_ref + ts is =3D 12,286294 sec...
>=20
> /Sean

right. Could you please add to the dump log the ts_ref value in st_lsm6dsx_=
resume()
just after iio_get_time_ns()?

Regards,
Lorenzo

--KdquIMZPjGJQvRdI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXteAlwAKCRA6cBh0uS2t
rGV/AP9fF3r/jn4241InUZWZPd3H8o7rsnXcroZfAGrdOICDjQEAgMTEYmnFHwMu
rZqMSvQ4kwmo3Y5IYI912GYTdFLxnwQ=
=oRfT
-----END PGP SIGNATURE-----

--KdquIMZPjGJQvRdI--
