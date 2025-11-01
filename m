Return-Path: <linux-iio+bounces-25779-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4B9C27936
	for <lists+linux-iio@lfdr.de>; Sat, 01 Nov 2025 08:57:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A127A188C3B1
	for <lists+linux-iio@lfdr.de>; Sat,  1 Nov 2025 07:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3128725C80E;
	Sat,  1 Nov 2025 07:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="40Sb7gp3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9C4242925;
	Sat,  1 Nov 2025 07:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761983817; cv=none; b=iitYb2cfw486R5pQy35wotqq1w1l0BpGuxnAOVmghhCCkd7yVaFQ7w8l4YYP/H9Ro3eObvUpx94Q5MzxH7Xx1B9wz8ApchgIWcWTJ7g1MCLtMvxMTJ/m9gIBbr/nVE8gQYFAVyzZd+blbNT+fnug+3fqKGVGRLu2vK+wLBxj7DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761983817; c=relaxed/simple;
	bh=tWn4ufTyuQGOgYCyH47Q/VRlm9ousGUJIlvtzVgbvfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WdwCOWduelaGKqtQZMYusBAZ9RGgrs69BDwCt7a1VcwNFeO7mQAoVAl+Pj/771whIBWBnHRONvhjugyHj2h1MuKdaIEGj+GG98SH4uP+NYfVufkw1DW5bKBAIZp5VhLuhaY7a6kVZf0yjxUOxJJn0p2op1OQzAADNEzG8DlzURc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=40Sb7gp3; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from lipo.home.arpa (unknown [IPv6:2a02:2f0e:3e0c:5b00:f1e0:3f4b:286c:9ddb])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 377D1160209;
	Sat, 01 Nov 2025 09:56:45 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1761983805;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DvZurcr82awvHEfrspbknKnStLnDMBRHjfUAZq2hRoY=;
	b=40Sb7gp3oImKShQiUrrrSV/kqAqScd12/c5lk7eOTB5PO5uGQfCKLoMqeGjRhnrX8Cv1Fj
	fMtNwvTRsJqSNjqa6ML3AxoEg1gsYHNVBzOQ7jxwNA3aUvdcmvmDmHbSV4LG0o8X9Rb7Dr
	TKTIRGX1Ucmf+MyuE7sGLIGFyrw1O3Y1tl07Ng0euHqu+xe/hnfJY/sH/tsJVQi/8mk6zs
	XYMP+n7QpktRy5Mk2i+y6ZwGWKWGBRdO+hKWMmr7F3Sm/bnAxwdUbJRn8rgdDPRTUBVf2d
	itGsCbNYlVHVufMVtCva+0iXAGjJw/+D5Ozb/gQ9/1IEcFyjA+njFu5Pw1yTuQ==
Date: Sat, 1 Nov 2025 09:56:42 +0200
From: Petre Rodan <petre.rodan@subdimension.ro>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jagath Jog J <jagathjog1996@gmail.com>
Subject: Re: [PATCH 3/6] iio: accel: bma220: add tap detection
Message-ID: <aQW9OnJSrOzn_Sws@lipo.home.arpa>
References: <20251014-bma220_events-v1-0-153424d7ea08@subdimension.ro>
 <20251014-bma220_events-v1-3-153424d7ea08@subdimension.ro>
 <20251018181632.76851d4e@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5yEGpi0/vFzggbYN"
Content-Disposition: inline
In-Reply-To: <20251018181632.76851d4e@jic23-huawei>


--5yEGpi0/vFzggbYN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hello Jonathan,

thank you for the review.

On Sat, Oct 18, 2025 at 06:16:32PM +0100, Jonathan Cameron wrote:
> > +			ret =3D regmap_read(data->regmap, BMA220_REG_CONF3, &reg_val);
> > +			if (ret)
> > +				return ret;
> > +			*val =3D FIELD_GET(BMA220_TT_DUR_MSK, reg_val);
>=20
> This needs to be in second if you are using duration. Is the register rea=
lly in seconds?

this IC has a very small number of bits that configure duration/hysteresis/=
threshold levels. it's between 2 and 6 for each of them. in the case of hig=
h and low G events the duration is not even directly defined as a time inte=
rval, but as a count of samples that are over a threshold value.

I was hoping that simply passing along a unitless value between 0 and param=
eter_max would be enough to customize all the event parameters. this does m=
ean that the driver makes the assumption that the user is familiar with the=
 device datasheet and knows the number of bits every parameter has been all=
ocated. should the driver provide a conversion table for tt_duration just l=
ike for _scale_table and _lpf_3dB_freq_Hz_table?

> > @@ -506,13 +777,36 @@ static irqreturn_t bma220_irq_handler(int irq, vo=
id *private)
> >  	struct bma220_data *data =3D iio_priv(indio_dev);
> >  	int ret;
> >  	unsigned int bma220_reg_if1;
> > +	s64 timestamp =3D iio_get_time_ns(indio_dev);
> > +
> > +	guard(mutex)(&data->lock);
> > =20
> >  	ret =3D regmap_read(data->regmap, BMA220_REG_IF1, &bma220_reg_if1);
> >  	if (ret)
> >  		return IRQ_NONE;
> > =20
> > -	if (FIELD_GET(BMA220_IF_DRDY, bma220_reg_if1))
> > +	if (FIELD_GET(BMA220_IF_DRDY, bma220_reg_if1)) {
>=20
> Is it an either / or case? I.e. we can only have buffered reads with
> the data ready interrupt or events?   That does happen in some devices
> but is fairly unusual.

the driver got an interrupt, so it checks the source - it's either a data r=
eady when the sensor is used to sample the environment or it's an event in =
which case it just sets the event.
now that you mention it I think I would miss events if both happened before=
 the kernel executes the _irq_handler(), so I will rewrite this bit. if you=
 ment something else please tell me.

best regards,
peter

>=20
> >  		iio_trigger_poll_nested(data->trig);
> > +		return IRQ_HANDLED;
> > +	}
> > +
> > +	if (FIELD_GET(BMA220_IF_TT, bma220_reg_if1)) {
> > +
> > +		if (data->tap_type =3D=3D BMA220_TAP_TYPE_SINGLE)
> > +			iio_push_event(indio_dev,
> > +				       IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
> > +							  IIO_MOD_X_OR_Y_OR_Z,
> > +							  IIO_EV_TYPE_GESTURE,
> > +							  IIO_EV_DIR_SINGLETAP),
> > +				       timestamp);
> > +		else
> > +			iio_push_event(indio_dev,
> > +				       IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
> > +							  IIO_MOD_X_OR_Y_OR_Z,
> > +							  IIO_EV_TYPE_GESTURE,
> > +							  IIO_EV_DIR_DOUBLETAP),
> > +				       timestamp);
> > +	}
> > =20
> >  	return IRQ_HANDLED;
> >  }
> >=20
>=20

--=20
petre rodan

--5yEGpi0/vFzggbYN
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEGiKYHD4NvFCkTqJ3dCsnp2M6SWMFAmkFvTUACgkQdCsnp2M6
SWOP6BAAmew3aKxXqOypw0w4ORqYbVBYrGw4kYSo/qQgxFNl4zGSmTB/5rccZQp9
drbnZc9CDHg2YptNZPxEjtpPE+NTM05SxLQ2ndWi/L12mDNElG/uRszRoxHE9M5m
KZCMiXzWFR5M84rPOLYvH0ghlQnOBIT+QSsatRhf8PQc2H5E1yFYR3/tYTBoAC+y
fPswJM7fRAnyo7h5f3XrtljLoDyjlDVnv3dZdd4qWu9d6wWgFIFIWMHOB4pDpIoQ
zzOx1f7yNMCZqCaYZOSQTxIMcojkB5qjsAJow1cuyJcW5tmyJTh926SNgv4G2CWn
8pkgZZyRPJrSUzxS/rTQgRlDrH0Ti050gs2SXdjnON3R68W65Txy+KQozvpNpOQw
vkDX0fzfrcn4T8waIDofBqzNSHEechRbfqzb5QAOzKZLBunot+aVgqxNSWJvUod/
EFJL7UpHnTxOQ5VUMRgDO16icYh1Q/jY2PBnI5vJvTGS4imdLkZKmHJKb5KCXJ16
9uW9FqzMNS9ysB44/pCe2CEEN+gWkMQtjJkCIOwN6YjDMk2Z4doY2KP4IfsOwcUu
DH0nKS7ndb23ZjBupXTbNy/qx2NVuxuiY+w+Vq/w0SCYgjH4Bw3nnvN0vFvwZ47S
fPBftOBs7D4ofLZKYbpDOyF+MAtkk6f6/33Sh34dpRDRfeOxdBU=
=EkOh
-----END PGP SIGNATURE-----

--5yEGpi0/vFzggbYN--

