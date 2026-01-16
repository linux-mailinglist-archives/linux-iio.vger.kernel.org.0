Return-Path: <linux-iio+bounces-27876-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C6011D385C4
	for <lists+linux-iio@lfdr.de>; Fri, 16 Jan 2026 20:27:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BF1C3302CDCF
	for <lists+linux-iio@lfdr.de>; Fri, 16 Jan 2026 19:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E57734CFB4;
	Fri, 16 Jan 2026 19:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="sv8/WRfU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4B02F6179
	for <linux-iio@vger.kernel.org>; Fri, 16 Jan 2026 19:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768591630; cv=none; b=QBLDgz6r+Zi7AUTZDh+xP4vR7Z8d/bQMqyjBTxB6gx8woHH4nG9YhL+aksGF3gAeer+3aXVfQ6+eg2VqsefhvsDcDJ96KRuRNFHnS/R7oVISGgJ0xhvCyelCdKaRe1XH2YB3zwN8fbMdf9oHK6MXkjHrPmN5UsCkGkGVEaaQpLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768591630; c=relaxed/simple;
	bh=05pbaXg3cASMRFyUvy9m8uJF/8TnPa2mWOaokKT8+Mo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=stzwPStU1sTADryYTUdKJ4SJBfCnUY/jHGbMdFatTu0FTXY1L3xDJmixw9PBZZOwykWHjTBBkADJGNLVE6eqsm0MIygFo5wyLTQ/kQD1PDFwYxauKggPWW68TA+G009uzTQ8eV+IPa+HrWZKwObCBEOwmv5RWd0+pa6wNqz9a78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=sv8/WRfU; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6505d141d02so3958230a12.3
        for <linux-iio@vger.kernel.org>; Fri, 16 Jan 2026 11:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1768591626; x=1769196426; darn=vger.kernel.org;
        h=mime-version:user-agent:organization:references:in-reply-to:date:cc
         :to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=05pbaXg3cASMRFyUvy9m8uJF/8TnPa2mWOaokKT8+Mo=;
        b=sv8/WRfUpXMtPcBG3xEA7dWA99zQGzpyHY2+JJGQC71kDOvfFdBtM2k/sSqpde89ww
         /0qWON1/RyvNObS/luDKk8SmDPfWRW+dmYsL54V+L6FOOQsXZKzjn3YzJi1J+kqHgnys
         d32GAGpibNy6oT+XzJNrJVdy7DgYAli+QqXNHxK4SVZqvMmNXAL5DWJY2d8CRCM586P+
         fIiS8pSZ0qAxeX9R4lILjMTcumjfAIkQ6GsJ1lihnb8XZLASBVGxpyzDVXZRll/9h4x5
         Hr4BqDGUNtF0LUu9YAW6/5OvPfqWUVjwxTikVw3H7QV34DOUmxjtvSlxT3x7fB2HXZ85
         c8iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768591626; x=1769196426;
        h=mime-version:user-agent:organization:references:in-reply-to:date:cc
         :to:from:subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=05pbaXg3cASMRFyUvy9m8uJF/8TnPa2mWOaokKT8+Mo=;
        b=LXjm4ynCaIUuRMFoFNeSFqjweCwVpmyUA/zTtbGzwf0/dtLYwT7Az+pm4mMOm+gOhD
         V3AIoo/zkcPb9Wd2SpI0IsJbirUDbEXqYQkOOHuJ0zWRaKFsf4ZJ/zB8dEpoMkmbUm3E
         9FNhYQLCF7cD8XEJjtHtoYtiBs++YPsd99KrhB+DuV9SnB9mMUAI94qpUlHH/FIgpSqQ
         4es81aaqdtPgdLuXrSpo7onPhlGaGBXCKFjQklbM0xZpwJjcitgCBU7fVlxaf0I14MP+
         TcBN0/QSYtjw1tt/u3V7EV69krPI88kUkqti53Q9WHveMWQmGs2EiSNziwNqbOn5iHxV
         o/GA==
X-Forwarded-Encrypted: i=1; AJvYcCWWXmd64dmODI9OxnAhYCOtI4GEowNbBZ3yGudWlbTwwYb6TmWaELP2J3QdLzJA4L3IAr/EtLuIRyw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxcqz7blKvnFZm6Obw5oHLiJ7rIctQmM3+4mv0INc5ET1x+uBQS
	RYegah2Uo+6PnP9T38jCpV3CMux/pHxk6SmqKZHNRXfDznRgNeMeLQ7lTpZOrqRcAtk7AzUeZbN
	zdeZ+ICWuaw==
X-Gm-Gg: AY/fxX56fB9HizCoRcRrrFaay+UtpA7TIBhrktSb1tHqTPIcgnp3R7XjNstDEDo7yNO
	4I1+Ss+V5HKVpRCSny0TTAEd8RjEZBRoatWnQu/b6f0wOGOZv3hTXa5ccxj6S/Pk8kEU4uHxGwT
	GFTt/ZYzJzS1C5O4Gqml5AZdByk4fkGD6M+dRLx2Ef5RYsSp5ddafpKDRl5XlUQSkEOhGife5S1
	tfvhSUmjUD4K2Q5gzxKvPgWpoOMk5YBRO4s58Yq0tglPwGX/PwPv1LojNkqcYL0YX1Ci1tF/keZ
	YP6bKA9yX8P2kh2aW4hgr3bp9Kgdt0Akh6sDRfvh/d58LLSWfl2xzfLdjB/OxoBGTIis8mdESRo
	07ZKJCK03hFYKCqVMFtvXHDGtiAK6BiAErnA4edE5uHy3M+kaN49mt3+g/I/X0UI+anDP8ve2Tb
	IBIh+x
X-Received: by 2002:a17:907:1b06:b0:b7a:72bd:ac65 with SMTP id a640c23a62f3a-b8792d6cf43mr390275866b.9.1768591626456;
        Fri, 16 Jan 2026 11:27:06 -0800 (PST)
Received: from [10.203.83.189] ([151.47.40.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b87959c9763sm291434966b.35.2026.01.16.11.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 11:27:05 -0800 (PST)
Message-ID: <43a8feadc9326c35bde8da12d4045ba61be97051.camel@baylibre.com>
Subject: Re: [PATCH 3/3] iio: imu: st_lsm6dsx: add support for rotation
 sensor
From: Francesco Lavra <flavra@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, David Lechner
 <dlechner@baylibre.com>,  Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>,  linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Fri, 16 Jan 2026 20:26:56 +0100
In-Reply-To: <20260116182716.2ff8925f@jic23-huawei>
References: <20260109181528.154127-1-flavra@baylibre.com>
	 <20260109181528.154127-4-flavra@baylibre.com>
	 <20260111164651.56a0cf14@jic23-huawei>
	 <d09ca6f843f75be5c5726eeab95063ea0e7c99cc.camel@baylibre.com>
	 <20260116182716.2ff8925f@jic23-huawei>
Organization: BayLibre
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-jkBQ1DquNMSj7Q+VRiU/"
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-jkBQ1DquNMSj7Q+VRiU/
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2026-01-16 at 18:27 +0000, Jonathan Cameron wrote:
>=20
> >=20
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0const struct st_lsm6dsx_=
reg *mux;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int err;
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mux =3D &hw->settings->s=
f_settings.page_mux;=C2=A0=20
> > >=20
> > > Just to check, can you use regmaps support for paging instead of
> > > doing
> > > this by hand?
> > > That would avoid future problems with enabling caching or similar=C2=
=A0=20
> >=20
> > No, the chip has multiple register sets with overlapping addresses, and
> > struct regmap_range_cfg is not usable here.
>=20
> Paged addressing always has overlapping addresses, so I'm not following.
> The trick this does is to map those higher pages to a fake set of
> addresses.

I thought having a fake set of addresses in the driver would be frowned
upon since it would create a mismatch between the code and the device
datasheet. But I guess it wouldn't be so bad if appropriate offsets between
register pages are chosen.
Anyway, as you noted in this case the different pages cannot be selected
via a simple bank selector register.

> An example is the ICM42600:
> https://invensense.tdk.com/wp-content/uploads/2020/04/ds-000347_icm-42688=
-p-datasheet.pdf
> for a suitable datasheet (some of the newer parts have a much more
> complex scheme)
>=20
> I took a look at the datasheet and seems there are multiple types of
> paging
> going on and effectively ends up with two nested paging controls. So fair
> enough it
> doesn't fit here.


--=-jkBQ1DquNMSj7Q+VRiU/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEhleFT5U73KMewxTm7fE7c86UNl8FAmlqkQAACgkQ7fE7c86U
Nl8Ccwv9HfKeLdC6Xs6g6/SaZHmxb0rdPjFz42eQBr8/MvVGooXlErXlcaYOq64C
fSt093nuTxsKZJPUUURl02yGuamY/C55mTAUmx2KXweCXNnV1bax4XmX20RcfSRS
VS3VisegKJd3BN1TgaZJU85icA3fYbbkBIRE+6Moc27rJ51TdExGDsPm+8V4cNh9
n21LjOKHJE644lreMsOhD8x18bBEerUbBDnL8UM/sRg1yV1nxnRYZwSkUzT/sri7
BWTasrS1vPfLGPymoQ2moPcdMrtamto3v+AjstDQVVK29g8CyrEqbUpjc0DMgTlx
+XbLJRDSJIw7nPHguYPFh5ArL1dKV5QfAKwxv2Y0f3PktwhgmlK6y05mCphD0zD0
SUkEtsGfMqpl1RdbI/oJoLZioEHXSINMQziaRpy+X/O++uWa5B76e6Qz+6+rNrzm
/2AakmSQQxnNQXRXBU8gHzIywJGYn9983CTn7ozmAz23zI198WvnX6cR6gRFKpcK
7mVNLue2
=NlLK
-----END PGP SIGNATURE-----

--=-jkBQ1DquNMSj7Q+VRiU/--

