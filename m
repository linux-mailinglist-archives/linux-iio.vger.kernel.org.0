Return-Path: <linux-iio+bounces-22950-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2F9B2B0C7
	for <lists+linux-iio@lfdr.de>; Mon, 18 Aug 2025 20:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 973F31B63E56
	for <lists+linux-iio@lfdr.de>; Mon, 18 Aug 2025 18:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B75272E53;
	Mon, 18 Aug 2025 18:47:27 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CA238F9C
	for <linux-iio@vger.kernel.org>; Mon, 18 Aug 2025 18:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755542847; cv=none; b=gAshj7DRv+zPtrrV5rWPieRSPVuDjzcBirSY7KR27eiKcqNk5gy72xaoQfSvhwwgffjv6j1Ph9recXFmFWgfG2p2YGZRytq8Ai2YHoSZsv8LaRmtFU6t6dRxJKM9CQsLTZDkdAQ+KWl7WtS5WruB+NBtPNvnqB1utJMugAACIPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755542847; c=relaxed/simple;
	bh=r2CefY/lj2hjOWdojrVaInlMsn6aTSwlapbYYCs0Jic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iXOh4iOSyZvSRApYLEpoFsfc1cWBaoyXOMhV9/c275Wq4BWgW9dN3J7+m9NUy0xoSozbdiqiErQSNu2+5USY9/VLD1/nGLkIe5tYVbaNAr39n0WmkXKKAfPCY+04LG8WskVQdV4Lz8P5TXEznSl2OqPkGgU+mPPbh6kFBuIzGVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 18 Aug 2025 14:47:16 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ben Collins <bcollins@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 5/5] iio: mcp9600: Add support for IIR filter
Message-ID: <2025081814-grumpy-prawn-ef1a0e@boujee-and-buff>
Mail-Followup-To: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250818035953.35216-1-bcollins@kernel.org>
 <20250818035953.35216-6-bcollins@kernel.org>
 <20250818191539.69e1882a@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kevhub3t54u3vofu"
Content-Disposition: inline
In-Reply-To: <20250818191539.69e1882a@jic23-huawei>
X-Migadu-Flow: FLOW_OUT


--kevhub3t54u3vofu
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5 5/5] iio: mcp9600: Add support for IIR filter
MIME-Version: 1.0

On Mon, Aug 18, 2025 at 07:15:39PM -0500, Jonathan Cameron wrote:
> On Sun, 17 Aug 2025 23:59:53 -0400
> Ben Collins <bcollins@kernel.org> wrote:
>=20
> > From: Ben Collins <bcollins@watter.com>
> >=20
> > MCP9600 supports an IIR filter with 7 levels. Add IIR attribute
> > to allow get/set of this value.
> >=20
> > Use a filter_type[none, ema] for enabling the IIR filter.
> Hi Ben,
>=20
> A few comments inline. You also need to send an additional patch to update
> the filter_type docs in Documentation/ABI/testing/sysfs-bus-iio

Hi Jonathan,

I just sent a v6 because I was getting too many comments on the
dt-bindings patch.

I'll send a v7 with these changes and anything else that comes up.

More comments below.

> >=20
> > Signed-off-by: Ben Collins <bcollins@watter.com>
> > ---
> > @@ -134,6 +160,26 @@ static const struct iio_event_spec mcp9600_events[=
] =3D {
> >  		},							       \
> >  	}
> > =20
> > +static int mcp9600_get_filter(struct iio_dev *indio_dev,
> > +			      struct iio_chan_spec const *chan);
> > +static int mcp9600_set_filter(struct iio_dev *indio_dev,
> > +			      struct iio_chan_spec const *chan,
> > +			      unsigned int mode);
>=20
> shuffle the code around so you don't need a forward definition..
> There is no particular reason I can see to have get and set later.

The set function, for one, calls mcp9600_config, which comes after the
use of the get/set in the ext_info. I'll see if I can shuffle that
around in the prior patch to avoid this.

> > +
> > +static const struct iio_enum mcp9600_filter_enum =3D {
> > +	.items =3D mcp9600_filter_type,
> > +	.num_items =3D ARRAY_SIZE(mcp9600_filter_type),
> > +	.get =3D mcp9600_get_filter,
> > +	.set =3D mcp9600_set_filter,
> > +};
>=20
> >  static int mcp9600_read(struct mcp9600_data *data,
> > @@ -191,13 +239,45 @@ static int mcp9600_read_raw(struct iio_dev *indio=
_dev,
> >  		if (ret)
> >  			return ret;
> >  		return IIO_VAL_INT;
> > +
>=20
> Unrelated changes. White space changes should not be mixed in a patch
> doing anything significant.  If you want to do this, extra patch needed.

Noted.

> >  	case IIO_CHAN_INFO_SCALE:
> >  		*val =3D 62;
> >  		*val2 =3D 500000;
> >  		return IIO_VAL_INT_PLUS_MICRO;
> > +
> If you want the extra space put it in previous patch.
>=20
> >  	case IIO_CHAN_INFO_THERMOCOUPLE_TYPE:
> >  		*val =3D mcp9600_tc_types[data->thermocouple_type];
> >  		return IIO_VAL_CHAR;
> > +
> > +	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> > +		if (data->filter_level =3D=3D 0)
>=20
> Return the current requested value. An error is just going to confuse
> someone who tried to write this before enabling the filter and then
> checked to see if the write was successful.

I could not get a concensus on this. On the one hand, if a user sets a
value here, would they not assume that the filter was enabled? What
about cases where a filter_type can be more than one valid type with
different available coefficients for each? What should it show then?

> > +			return -EINVAL;
> > +
> > +		*val =3D mcp_iir_coefficients_avail[data->filter_level - 1][0];
> > +		*val2 =3D mcp_iir_coefficients_avail[data->filter_level - 1][1];
> > +		return IIO_VAL_INT_PLUS_MICRO;
> > +
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> > +static int mcp9600_read_avail(struct iio_dev *indio_dev,
> > +			      struct iio_chan_spec const *chan,
> > +			      const int **vals, int *type, int *length,
> > +			      long mask)
> > +{
> > +	struct mcp9600_data *data =3D iio_priv(indio_dev);
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> > +		if (data->filter_level =3D=3D 0)
> > +			return -EINVAL;
> Don't block this.  It makes for a confusing interface.
> > +
> > +		*vals =3D (int *)mcp_iir_coefficients_avail;
> > +		*type =3D IIO_VAL_INT_PLUS_MICRO;
> > +		*length =3D 2 * ARRAY_SIZE(mcp_iir_coefficients_avail);
> > +		return IIO_AVAIL_LIST;
> >  	default:
> >  		return -EINVAL;
> >  	}
> > @@ -211,6 +291,7 @@ static int mcp9600_config(struct mcp9600_data *data)
> > =20
> >  	cfg  =3D FIELD_PREP(MCP9600_SENSOR_TYPE_MASK,
> >  			  mcp9600_type_map[data->thermocouple_type]);
> > +	FIELD_MODIFY(MCP9600_FILTER_MASK, &cfg, data->filter_level);
> > =20
> >  	ret =3D i2c_smbus_write_byte_data(client, MCP9600_SENSOR_CFG, cfg);
> >  	if (ret < 0) {
> > @@ -221,6 +302,79 @@ static int mcp9600_config(struct mcp9600_data *dat=
a)
> >  	return 0;
> >  }
> > =20
> > +static int mcp9600_write_raw_get_fmt(struct iio_dev *indio_dev,
> > +				     struct iio_chan_spec const *chan,
> > +				     long mask)
> > +{
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> > +		return IIO_VAL_INT_PLUS_MICRO;
>=20
> That's the default so you shouldn't need a write_raw_get_fmt for this.

Ok.

> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> > +static int mcp9600_write_raw(struct iio_dev *indio_dev,
> > +			     struct iio_chan_spec const *chan,
> > +			     int val, int val2, long mask)
> > +{
> > +	struct mcp9600_data *data =3D iio_priv(indio_dev);
> > +	int i;
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> > +		for (i =3D 0; i < ARRAY_SIZE(mcp_iir_coefficients_avail); i++) {
> > +			if (mcp_iir_coefficients_avail[i][0] =3D=3D val &&
> > +			    mcp_iir_coefficients_avail[i][1] =3D=3D val2)
> > +				break;
> > +		}
> > +
> > +		if (i =3D=3D ARRAY_SIZE(mcp_iir_coefficients_avail))
> > +			return -EINVAL;
> > +
> > +		data->filter_level =3D i + 1;
> > +		return mcp9600_config(data);
> > +
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> > +static int mcp9600_get_filter(struct iio_dev *indio_dev,
> > +			      struct iio_chan_spec const *chan)
> > +{
> > +	struct mcp9600_data *data =3D iio_priv(indio_dev);
> > +
> > +	if (data->filter_level =3D=3D 0)
> I'd use a separate enable flag for this.
>=20
> > +		return MCP9600_FILTER_TYPE_NONE;
> > +
> > +	return MCP9600_FILTER_TYPE_EMA;
> > +}
> > +
> > +static int mcp9600_set_filter(struct iio_dev *indio_dev,
> > +			      struct iio_chan_spec const *chan,
> > +			      unsigned int mode)
> > +{
> > +	struct mcp9600_data *data =3D iio_priv(indio_dev);
> > +
> > +	switch (mode) {
> > +	case MCP9600_FILTER_TYPE_NONE:
> > +		data->filter_level =3D 0;
> > +		return mcp9600_config(data);
> > +
> > +	case MCP9600_FILTER_TYPE_EMA:
> > +		if (data->filter_level =3D=3D 0) {
> > +			/* Minimum filter by default */
> > +			data->filter_level =3D 1;
> As above, I'd just let the user write it whenever they like
> (default to 1 on boot) and then they have to see if it is
> set to none to see whether it has an effect.
>=20
> > +			return mcp9600_config(data);
> > +		}
> > +		return 0;
> > +
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> >  static int mcp9600_get_alert_index(int channel2, enum iio_event_direct=
ion dir)
> >  {
> >  	if (channel2 =3D=3D IIO_MOD_TEMP_AMBIENT) {
> > @@ -358,6 +512,9 @@ static int mcp9600_write_thresh(struct iio_dev *ind=
io_dev,
> > =20
> >  static const struct iio_info mcp9600_info =3D {
> >  	.read_raw =3D mcp9600_read_raw,
> > +	.read_avail =3D mcp9600_read_avail,
> > +	.write_raw =3D mcp9600_write_raw,
> > +	.write_raw_get_fmt =3D mcp9600_write_raw_get_fmt,
> >  	.read_event_config =3D mcp9600_read_event_config,
> >  	.write_event_config =3D mcp9600_write_event_config,
> >  	.read_event_value =3D mcp9600_read_thresh,
>=20

--=20
 Ben Collins
 https://libjwt.io
 https://github.com/benmcollins
 --
 3EC9 7598 1672 961A 1139  173A 5D5A 57C7 242B 22CF

--kevhub3t54u3vofu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEPsl1mBZylhoRORc6XVpXxyQrIs8FAmijdTQACgkQXVpXxyQr
Is+Kug/+NLbv3TYCBGyDDEYIgFjybk0ds/XmavuwzGLANk0G8y93EWnpxXWhxH+h
BtRjhCqF8wIYNsrXRoXw1pLBVNoB1oFEm8r8m9TJHGDWP1ykv1PN9kpJL1CcR44C
0GLCXnu5eG8Q7OT/Rg/MvkSc4flpRwlyZSdGs09I6wn9faAvedyhMkGXB0YJSOU7
YZ72br8Znj6RwZDZu4RrWL3evUQmRlBPPcC2C8EDI7ZxEDVVUXNRMeFRjNXQ5PiL
mo29AwYk5dMlh9l9jarf5dKo5dloc3cf661EYZhKdsV1tdd7p5xpbeZrBE6zNpwM
MXpq7gcOyk1pm8dCh4pX+AgJQc29fAL2EFSUJLDDzuo/2C5woUCRLt3hBnnGw5hd
XQMPlwJqvNYe+Sr95vqxqklBBMRJB5/afp2f63vq1kt3OASg1GPSAUdwLhNEdNZG
EcelBVs4KTI9aCAMpR5/LFWbvawECd2c7/ZiMBbYckNOgyf4AkCMr0WX8LCYGi0C
+s7A75VmtBIcq8hximKq9n64HSPzS4X9JhBwBeH6ee9sdZPad+5+HFharBY8Lrwb
bTJt17zelGpDcZXRyqZgHCIArUGVotLidC9ek4lsMBY1pO7DpNzn9+NtUhzClezc
afIGBRBhy0DHFZ4hlv/bfLjdLXRVPqZYx9Lq2h2cNIIAnloAgYI=
=IjRR
-----END PGP SIGNATURE-----

--kevhub3t54u3vofu--

