Return-Path: <linux-iio+bounces-17499-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3099A77478
	for <lists+linux-iio@lfdr.de>; Tue,  1 Apr 2025 08:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 216563A9143
	for <lists+linux-iio@lfdr.de>; Tue,  1 Apr 2025 06:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B471E1041;
	Tue,  1 Apr 2025 06:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BkMyRPMq"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E2416C684
	for <linux-iio@vger.kernel.org>; Tue,  1 Apr 2025 06:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743488917; cv=none; b=fBm1QBwETm6VRbqstybsOELXWe6+tgp9aoqWw/mmHWpRaCPFcqAA1qlx3BGEavExy5DoZqKwv5LzW4g/KkvGFeDIAyyq2PxX9KxyrMTblYAAa5Pw2vaSG2DgZHvjn1laPfxZjloXc2mzMFTbtKVEP49H8ioqF4iIKyRU39wbAI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743488917; c=relaxed/simple;
	bh=C+xzmlC2J2eEFiaRTw+dZublEKqmWJNqa3+ZHXL0U0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u2kVo3kEonvGI6NTZHDqw5nXmavKFFpzQfvWOAlsIQtVxll4IXQauQ0H4B6ZxoMugRL/Go8uID7cqrEIuduGNUX//jmMdfhalLp8dI6oGZkOzadvxGU7KKXdOcBfcaMSCw1lsLsLqzb+5r7WVhgWpm0zc00F7efpJwnNa2T4I2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BkMyRPMq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45BDDC4CEE8;
	Tue,  1 Apr 2025 06:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743488916;
	bh=C+xzmlC2J2eEFiaRTw+dZublEKqmWJNqa3+ZHXL0U0E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BkMyRPMqJXfkJDEAzzrHZ4lzPzq822OliGSqP4dtSi4QJcZ4rekXJ+Son2kM7QHwu
	 40WUTazeJ5uwEFziu3owRi5c8EbBF2z8keW8DTOwnaGCLaWKMTPor5J2pDkpvl9dwG
	 uGhg8Nv+Z2t3tSxeY1uFCfQikpdVO/J51Yxsr5NL72jkz6Juis4yNA0mZUrbypmYpY
	 7zKeY3cKXQPwArK542iXEkCPBCJxT0v7j14y16ztM8uFV3Lz7goGtv3mja+2mttudq
	 X8C+b3JZmom9dYu5O72srPyh3BVL5kuh1eIAHfpbJjflMqZah1W5yPyjNTaiy7E18A
	 JAqwJqVc9f1oQ==
Date: Tue, 1 Apr 2025 08:28:34 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Cosmin Tanislav <demonsingur@gmail.com>,
	Roan van Dijk <roan@protonic.nl>,
	Jyoti Bhayana <jbhayana@google.com>,
	Nishant Malpani <nish.malpani25@gmail.com>,
	Eugene Zaikonnikov <ez@norphonic.com>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Shen Jianping <Jianping.Shen@de.bosch.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Yasin Lee <yasin.lee.x@gmail.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 18/37] iio: imu: st_lsm6dsx: Factor out parts of
 st_lsm6dsx_shub_write_raw() to allow direct returns
Message-ID: <Z-uHkmGOXu1venxl@lore-desk>
References: <20250331121317.1694135-1-jic23@kernel.org>
 <20250331121317.1694135-19-jic23@kernel.org>
 <4ad0f22c-fdb9-47cb-b5a1-2802f47124d4@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FW151l2sZ93UvbGT"
Content-Disposition: inline
In-Reply-To: <4ad0f22c-fdb9-47cb-b5a1-2802f47124d4@baylibre.com>


--FW151l2sZ93UvbGT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On 3/31/25 7:12 AM, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >=20
> > By factoring out all the code that occurs with direct mode claimed
> > to a helper function, that helper function can directly return simplify=
ing
> > code flow.
> >=20
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c | 65 +++++++++++---------
> >  1 file changed, 35 insertions(+), 30 deletions(-)
> >=20
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c b/drivers/iio=
/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> > index c1b444520d2a..17a74f5adfc0 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> > @@ -614,53 +614,58 @@ st_lsm6dsx_shub_set_full_scale(struct st_lsm6dsx_=
sensor *sensor,
> >  }
> > =20
> >  static int
> > -st_lsm6dsx_shub_write_raw(struct iio_dev *iio_dev,
> > -			  struct iio_chan_spec const *chan,
> > -			  int val, int val2, long mask)
> > +__st_lsm6dsx_shub_write_raw(struct iio_dev *iio_dev,
> > +			    struct iio_chan_spec const *chan,
> > +			    int val, int val2, long mask)
> >  {
> >  	struct st_lsm6dsx_sensor *sensor =3D iio_priv(iio_dev);
> >  	int err;
> > =20
> > -	err =3D iio_device_claim_direct_mode(iio_dev);
> > -	if (err)
> > -		return err;
> > -
> >  	switch (mask) {
> >  	case IIO_CHAN_INFO_SAMP_FREQ: {
> > +		struct st_lsm6dsx_hw *hw =3D sensor->hw;
> > +		struct st_lsm6dsx_sensor *ref_sensor;
> > +		u8 odr_val;
> >  		u16 data;
> > +		int odr;
> > =20
> I would be tempted to rename `err` to `ret` so we don't have to introduce
> a new `odr` variable.

I guess keeping odr variable makes the code more readable.

Regards,
Lorenzo


--FW151l2sZ93UvbGT
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZ+uHkgAKCRA6cBh0uS2t
rH6nAQC/5jf/kEzhRNKTZkZo3VOdpPDNzhypogKD7FO0WjVRpAEAjRm3/OBt7Qko
7X2nHt3mPlAsntDO1HqsllQ4EunEoQU=
=4nQZ
-----END PGP SIGNATURE-----

--FW151l2sZ93UvbGT--

