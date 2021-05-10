Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9A9378E46
	for <lists+linux-iio@lfdr.de>; Mon, 10 May 2021 15:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239669AbhEJNHt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 10 May 2021 09:07:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:51482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237344AbhEJMIP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 10 May 2021 08:08:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EF850616EB;
        Mon, 10 May 2021 12:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620648430;
        bh=JFvztv+62rYTxeWoco1Hf3l63jPlIUe2mvnkHrM1Uzg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M3REdn79uDKpELdyuzGZWCWU+cH96rjG3w7jr+t5rri5HJ5rAI7FKnDFLbm2ujFW8
         5dgo3asOxkckXk1NkPfYAYgmHSlb944x9Lci4Pu/Q+nFKyyqLTIZRBk9cZU6X+RjlK
         1a3ujMb33jwWRHguC90f9Zw9EgHOZGFN9TUVHtLwjmAoqhZ4lyjh61fMa9Ri2lWwNn
         9WSqv6/j692b5j810Sr/fXyOHZq23qgqDm96jAjiWxkVM7rYzvkqZAQ0mXbx1mE9Vu
         8cTZwJCkgmXhISpV3I/gauFGS76WTMc8YLat2uUSrmOxj03JqkPHXDTKrggsFpQO5w
         5Vjd0a6koKwew==
Date:   Mon, 10 May 2021 14:07:05 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     lorenzo.bianconi83@gmail.com, jic23@kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: do not roundup set samplerate
Message-ID: <YJkh6c297Msx0Xwn@lore-desk>
References: <20210507103220.2194009-1-sean@geanix.com>
 <YJUeKhjooi8lAN1Q@lore-desk>
 <d0b62523-dcc9-ff14-aeaf-db24915f7aeb@geanix.com>
 <YJjSfpTfSMqf3w0v@lore-desk>
 <303a2899-2aff-410f-3bce-e40a7d7637e9@geanix.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ivgeTGt1gkFsJAYR"
Content-Disposition: inline
In-Reply-To: <303a2899-2aff-410f-3bce-e40a7d7637e9@geanix.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--ivgeTGt1gkFsJAYR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On 10/05/2021 08.28, Lorenzo Bianconi wrote:
> >> On 07/05/2021 13.02, Lorenzo Bianconi wrote:
> >>>> The correct way to set the sampling rate to 12.5 Hz before
> >>>> commit f8710f0357bc ("iio: imu: st_lsm6dsx: express odr in mHZ")
> >>>> was to write 13 Hz to sampling_frequency.
> >>>> Before this patch writing 13 to samplerate results in sample rate set
> >>>> to 26 Hz.
> >>>> Now we return EINVAL if the sampling rate is not in table.
> >>>>
> >>>> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> >>>
> >>> I think this patch is breaking i2c-master support available in st_lsm=
6dsx, have you tested it?
> >>>
> >> I have not tested with i2c-master.
> >> But it's not nice to round up sample rate from user space without any =
notice.
> >=20
> > the point is accel odr is used as trigger for i2c-slave sampling. Conne=
cted
> > i2c slave devices have different sample rates (e.g. LIS2MDL), so we nee=
d to
> > select the lower accel odr greather than slave device one.
> >=20
> > Regards,
> > Lorenzo
> >=20
>=20
> We could open up for custom sample rates if i2c-slaves are enabled?

can you please explain what you mean?

> /Sean

--ivgeTGt1gkFsJAYR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYJkh5wAKCRA6cBh0uS2t
rK9/AQDIsSyfK4tMnI3SfQWsu0LsYx2du4+QBOAK5vvBEOs6IgD/YKYNgEBAvBkF
nrfbuZJfYwE5kINzRlMHbUfTcGjUFgc=
=8ZYE
-----END PGP SIGNATURE-----

--ivgeTGt1gkFsJAYR--
