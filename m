Return-Path: <linux-iio+bounces-25663-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 237AAC1FB20
	for <lists+linux-iio@lfdr.de>; Thu, 30 Oct 2025 12:04:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D29B54E3DFB
	for <lists+linux-iio@lfdr.de>; Thu, 30 Oct 2025 11:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3237126F2BF;
	Thu, 30 Oct 2025 11:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="zTPfs4F/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DBD2135AD
	for <linux-iio@vger.kernel.org>; Thu, 30 Oct 2025 11:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761822245; cv=none; b=WVNKEYQpecLVBlYZnSonPVT2sncEyM2xdmcN4jv2XoOVcupzFaHABLziCJXOJhB7cjOPXFcj1GZ5fkCmUpASspvuLiZgzcBkKbRhZ7Uc+UTJf5GBAUdgliefZxue2x55ST8umWcBwY/OJBMzdTEbGEaIpCWfHThiMi7Rh+RxC+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761822245; c=relaxed/simple;
	bh=opKl6kmBemfDcUkCGVEI46l4JB65Z8o+cIBF8NIHkvU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e3vV6Q8Pg4iCw/4ALsOzBmCU0d5cm3iP38B8gculcnMmpl7Rnm3RnxjNX1JpPxJI7THns/A+ib7D/FXK4ZLmmjGNpr7LTBQd8egDQEwI+t/9auF/FzR6UdBJoOF6xorJONKnVKkp/a4OeFuLplIqY+0Fi+NLaTII/nxPAkUwRTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=zTPfs4F/; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-63bf76fc9faso1941417a12.2
        for <linux-iio@vger.kernel.org>; Thu, 30 Oct 2025 04:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1761822241; x=1762427041; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=opKl6kmBemfDcUkCGVEI46l4JB65Z8o+cIBF8NIHkvU=;
        b=zTPfs4F//zwTDWAdhNl4v9jxPlKOZ1xJMbZERh4Y8DY6J5U6cS/YoqrzFz+s4UiCQq
         byZT5xfujIJXlwCuVlNOJEdYb9oc7irg4358yqySVInrNoSTcYAfU8bxikHTklpNUs0v
         wdhV5daofa5lKO/BGgMegJjegVL+Ztr8AsFOQ2F5NC4m7GA1j63VsvFyKgo3D3WPB2Py
         A7cJFs4oiBoaQ/b1aquKVYVlAGVFga/mi5+t09RLeZEJ4RmLtM2MkLz4WCCREawoCIEp
         JnnYAFygYio8j8QnwkDRqAlvdwbMdlJMoiQbI04+/M/Ho/lxp0siroqsoCv5i4s0AVVA
         P6aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761822241; x=1762427041;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=opKl6kmBemfDcUkCGVEI46l4JB65Z8o+cIBF8NIHkvU=;
        b=dxpbQaGhtBv6QRZSbOHRypvNVjGI+xYbMe0Jil9y4KXOf7xUsvGFlvHWx8MANZwalG
         3cAaR+sGD+FIuV9BWDQ3t6fw0GCC96ooORlRIEe2jBddoOyOSZY8n+3hB1064Q8ku1kl
         N9vUN6d6RDb8jx1VNLO7V43TxQdSVjIM3mnEilbFmcXpdp3iF+KLceybYcpDpsywsUDH
         x/8qMKgBy9b3TzVDybTTmefSkD8eU68DrpVYd89HCBJWw7UlND3xn+twu+QR4NVMTrzL
         J54TZJ0tFhWtMY4MtJdZHe3zJO0heCKLXGJIWe5agS7ZJyZD5MwerSG31xJxzyJY3RfS
         BKGg==
X-Forwarded-Encrypted: i=1; AJvYcCVUCEm+3OnkGGM7QYi9ncV/2PyclOB5QvqPO3il/pMfrmuXqxgXACA5LrfANWEdOiYej6QSZSfiBY4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7dMUejaSUe9O3VDAzSHtOBJwVpWnaXwVCf2Sep9jWZpoqY6+Y
	67M0yxvXOaPka+n74BSQWmZdkVSSoyb45wgomeRt/Iy2PKwiRU/0/8yajsVfYDiIEag=
X-Gm-Gg: ASbGncuOjaPhu3zaT3aZZM1QpffCgXhCHNmW2a3lbDQaf8+BJRqagXRtHlF10ABVAfK
	B4iV48zvL6MNVB3S5009qptHTw38WHY8IBG2khP8qalsi1KHv5aDMlA9Ape9/4AjPGoffCuLrBG
	gBjIJsDE2UsolBWKfJpWC6IFU0JJrRWnuOFerba1PMXDRh3JAKAjfCo4feEiJXsMKa+y6guuvb1
	L+mhNpFK3HPV5k+14HWkDUUdkZq4nRJeb0t2RHEOwvw9gEkDB8B8k2ANPLsKElBZ3GqoM+FuZGC
	PSf4hR0YyPnwcesLE+QQ0B1TH47bng1L8taMaP+YO4FegcdVke9WUKHR+E6kSoUFG+itj05hG1l
	UynfKlABFNN6R5Rn2syRMz7IEJ9VEEoGagzY5Y5pa+mChLTCFlkqheTIiiizeyLTKX7VdxOUtCh
	+NfueHZRcFBuBeIAAyYiWKZYh42NhHAdjkOrnVMQ==
X-Google-Smtp-Source: AGHT+IGeQ2Ezm3o99pmcKhos9+4NPwwGz5pdokBVRuYPLAzu+QsHbjEWcixgW6rArMmx/CWNIJxFcA==
X-Received: by 2002:a17:906:fe45:b0:b3f:f207:b754 with SMTP id a640c23a62f3a-b703d4ae08dmr699500066b.30.1761822240780;
        Thu, 30 Oct 2025 04:04:00 -0700 (PDT)
Received: from [10.203.83.89] (mob-176-247-57-96.net.vodafone.it. [176.247.57.96])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d853e5138sm1725243566b.44.2025.10.30.04.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 04:04:00 -0700 (PDT)
Message-ID: <6ce5ba44403d2fddbcd35384ce6444f9719c788e.camel@baylibre.com>
Subject: Re: [PATCH 1/9] iio: imu: st_lsm6dsx: dynamically initialize
 iio_chan_spec data
From: Francesco Lavra <flavra@baylibre.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, Jonathan Cameron
 <jic23@kernel.org>,  David Lechner <dlechner@baylibre.com>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 30 Oct 2025 12:03:58 +0100
In-Reply-To: <aQMaaHWjgC2GMGmj@smile.fi.intel.com>
References: <20251030072752.349633-1-flavra@baylibre.com>
	 <20251030072752.349633-2-flavra@baylibre.com>
	 <aQMaaHWjgC2GMGmj@smile.fi.intel.com>
Organization: BayLibre
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-10-30 at 09:57 +0200, Andy Shevchenko wrote:
> On Thu, Oct 30, 2025 at 08:27:44AM +0100, Francesco Lavra wrote:
> > Using the ST_LSM6DSX_CHANNEL_ACC() macro as a static initializer
> > for the iio_chan_spec struct arrays makes all sensors advertise
> > channel event capabilities regardless of whether they actually
> > support event generation. And if userspace tries to configure
> > accelerometer wakeup events on a sensor device that does not
> > support them (e.g. LSM6DS0), st_lsm6dsx_write_event() dereferences
> > a NULL pointer when trying to write to the wakeup register.
> > Replace usage of the ST_LSM6DSX_CHANNEL_ACC() and
> > ST_LSM6DSX_CHANNEL() macros with dynamic allocation and
> > initialization of struct iio_chan_spec arrays, where the
> > st_lsm6dsx_event structure is only used for sensors that support
> > wakeup events; besides fixing the above bug, this serves as a
> > preliminary step for adding support for more event types.
>=20
>=20
> Sounds like a bug fix. Fixes tag?

Will add

>=20
> > +static int st_lsm6dsx_chan_init(struct iio_chan_spec *channels, struct
> > st_lsm6dsx_hw *hw,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0enum st_lsm6dsx_sensor_id id, int
> > index)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct iio_chan_spec *chan =
=3D &channels[index];
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0chan->type =3D (id =3D=3D ST=
_LSM6DSX_ID_ACC) ? IIO_ACCEL :
> > IIO_ANGL_VEL;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0chan->address =3D hw->settin=
gs->chan_addr_base[id] + index *
> > ST_LSM6DSX_CHAN_SIZE;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0chan->modified =3D 1;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0chan->channel2 =3D IIO_MOD_X=
 + index;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0chan->info_mask_separate =3D=
 BIT(IIO_CHAN_INFO_RAW);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0chan->info_mask_shared_by_ty=
pe =3D BIT(IIO_CHAN_INFO_SCALE);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0chan->info_mask_shared_by_al=
l =3D BIT(IIO_CHAN_INFO_SAMP_FREQ);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0chan->scan_index =3D index;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0chan->scan_type.sign =3D 's'=
;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0chan->scan_type.realbits =3D=
 16;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0chan->scan_type.storagebits =
=3D 16;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0chan->scan_type.endianness =
=3D IIO_LE;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0chan->ext_info =3D st_lsm6ds=
x_ext_info;
>=20
> + blank line
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (id =3D=3D ST_LSM6DSX_ID_=
ACC) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0if (hw->settings->event_settings.wakeup_reg.addr) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0chan->=
event_spec =3D &st_lsm6dsx_event;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0chan->=
num_event_specs =3D 1;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0}
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>=20
> if (foo) { if (bar) {}=C2=A0 } =3D=3D if (foo && bar).
>=20
> Based on this I'm in doubt what to suggest here as to me sounds like
> those
> couple of lines might deserve for a helper.
>=20
> Hence two options:
> 1) do an equivalent conditional and reduce indentation level;
> 2) do a helper with the inner conditional.

Will do a helper with the inner conditional.

> + blank line
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
> > +}
>=20
> ...
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0channels =3D devm_kzalloc(hw=
->dev, sizeof(*channels) *
> > ST_LSM6DSX_CHAN_COUNT, GFP_KERNEL);
>=20
> devm_kcalloc()
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!channels)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return NULL;
>=20
> I would expect comment here...

This function returns a pointer to the struct iio_dev it allocates and
initializes; if there are any errors, it returns NULL. What kind of comment
do you expect here? It seems obvious that it's returning NULL because of an
allocation error.

>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0for (i =3D 0; i < 3; i++) {
>=20
> 3 might need to be defined.

Will make an enum to replace the ST_LSM6DSX_CHAN_COUNT #define, and use an
enum value instead of 3.

>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0if (st_lsm6dsx_chan_init(channels, hw, id, i) < 0)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return=
 NULL;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>=20
> + blank line
>=20
> ...and perhaps here to explain what's going on here.

Same here, what comment do you expect?

> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0channels[3].type =3D IIO_TIM=
ESTAMP;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0channels[3].channel =3D -1;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0channels[3].scan_index =3D 3=
;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0channels[3].scan_type.sign =
=3D 's';
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0channels[3].scan_type.realbi=
ts =3D 64;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0channels[3].scan_type.storag=
ebits =3D 64;
>=20
> + blank line.
>=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0iio_dev->modes =3D INDI=
O_DIRECT_MODE;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0iio_dev->available_scan=
_masks =3D
> > st_lsm6dsx_available_scan_masks;
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0iio_dev->channels =3D hw->se=
ttings->channels[id].chan;
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0iio_dev->num_channels =3D hw=
->settings->channels[id].len;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0iio_dev->channels =3D channe=
ls;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0iio_dev->num_channels =3D ST=
_LSM6DSX_CHAN_COUNT;
>=20


