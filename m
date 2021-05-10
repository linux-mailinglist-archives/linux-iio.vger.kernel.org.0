Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD1A377C40
	for <lists+linux-iio@lfdr.de>; Mon, 10 May 2021 08:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbhEJG3X (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 10 May 2021 02:29:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:38656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229863AbhEJG3X (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 10 May 2021 02:29:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 64D9661421;
        Mon, 10 May 2021 06:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620628098;
        bh=ug7hwsf87lvwJZrUnGVaqan0cUHL52VHb9C7Ig2Cc/E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hjEAql57CfjwCSOae00sg9S+/5jnIiYQDCbD3Jgp2Z5hy7p48AmZRbNeSNH5B7Ngp
         Vf3a0gvVm4h0qRN5iHbMKaWK0rUBuK7Oe4A11QkltWFM7uEOPPwIw7al8t4yg58hCb
         r3CCLG3MKj3WEEtbLRTV9xYzhpGbjelqq76phaGkdoTswvxBxTH3jcMhRMACrJi6P0
         Jyjw/mDiS5fudw78k7Tccos4pZlZhJOFwvtD0CHjf2dsyUc5yXe7OytHbL7k+Cm3G+
         xYw6oM9NtaKEiHXC0SfhAiE0Gbb26eHtU7Rq5kpCLhdZbNfS5AsQH1I5MQ3Cv7hH4d
         DYstu3ugtUQfw==
Date:   Mon, 10 May 2021 08:28:14 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     lorenzo.bianconi83@gmail.com, jic23@kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: do not roundup set samplerate
Message-ID: <YJjSfpTfSMqf3w0v@lore-desk>
References: <20210507103220.2194009-1-sean@geanix.com>
 <YJUeKhjooi8lAN1Q@lore-desk>
 <d0b62523-dcc9-ff14-aeaf-db24915f7aeb@geanix.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qFPZh405bz3SE+eJ"
Content-Disposition: inline
In-Reply-To: <d0b62523-dcc9-ff14-aeaf-db24915f7aeb@geanix.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--qFPZh405bz3SE+eJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On 07/05/2021 13.02, Lorenzo Bianconi wrote:
> >> The correct way to set the sampling rate to 12.5 Hz before
> >> commit f8710f0357bc ("iio: imu: st_lsm6dsx: express odr in mHZ")
> >> was to write 13 Hz to sampling_frequency.
> >> Before this patch writing 13 to samplerate results in sample rate set
> >> to 26 Hz.
> >> Now we return EINVAL if the sampling rate is not in table.
> >>
> >> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> >=20
> > I think this patch is breaking i2c-master support available in st_lsm6d=
sx, have you tested it?
> >=20
> I have not tested with i2c-master.
> But it's not nice to round up sample rate from user space without any not=
ice.

the point is accel odr is used as trigger for i2c-slave sampling. Connected
i2c slave devices have different sample rates (e.g. LIS2MDL), so we need to
select the lower accel odr greather than slave device one.

Regards,
Lorenzo

>=20
> /Sean
>=20

--qFPZh405bz3SE+eJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYJjSewAKCRA6cBh0uS2t
rPo1APsFydMpV2IMyR52A7MkA4f7FgCenwrRsO+jafD+D1V0VwEAx9qrv9cTjBFy
HJ0M2VwFXqmC4SpNjPNb20Ox8aZT8QQ=
=jjJ3
-----END PGP SIGNATURE-----

--qFPZh405bz3SE+eJ--
