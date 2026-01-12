Return-Path: <linux-iio+bounces-27643-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 285E4D14524
	for <lists+linux-iio@lfdr.de>; Mon, 12 Jan 2026 18:23:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF397302048D
	for <lists+linux-iio@lfdr.de>; Mon, 12 Jan 2026 17:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6850B37416C;
	Mon, 12 Jan 2026 17:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="SEfTvB3x"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04872DFA5B
	for <linux-iio@vger.kernel.org>; Mon, 12 Jan 2026 17:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768237841; cv=none; b=rvBNSw6waIA+bVpTT7LZz0YwuI0GlDv8cjbSnD8CTM4cP4vYU/Eg2Kzcl+OBO9laJkoc36uTmijfuC1m56veUw4Qiv6usMtQNPrqjW+lxJbsoId7eO3WPGJuQvjn9tP3aUoWvdgRi7/Vy9FGnhXFntFU/SUWFXc73dL562MoCoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768237841; c=relaxed/simple;
	bh=MxclZFtCLQ8oKnBpzV/RHEud5nt0X9T5Lv3B6F2s1DA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q/BITX9TXuJlxtQipRfp5t0rwPEAoIS8JoZT3IU8PMggMAMq/NA4E+e+5CHsH9RR8MgXU5niPwAf9UASoUjG06paFTS00URkpLiOenGAo9cu0XSwkdmExzu0WlQupnX92MV60bz3hN8mohr22G1P3Ps6Lt6l8dUWCSCJuQvvG5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=SEfTvB3x; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-64ba74e6892so10966089a12.2
        for <linux-iio@vger.kernel.org>; Mon, 12 Jan 2026 09:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1768237838; x=1768842638; darn=vger.kernel.org;
        h=mime-version:user-agent:organization:references:in-reply-to:date:cc
         :to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MxclZFtCLQ8oKnBpzV/RHEud5nt0X9T5Lv3B6F2s1DA=;
        b=SEfTvB3xqLa+Dii285GT926/1+FEvKSa7P3EMEur8oyWse/Wmi4oSYStnjanDNonIb
         96HSnu9k0Iq0UjRmvAqx86ZCBFtY6sLUhfIPj+0z+MjZczA/PLglqZ1BiIb6GG9s8EVv
         rmb9rQ4jsUNVIZiohsDdogQZJ+bO7n4v7GoygC0hLXfW+XPwJAJVxFK5ChWV6vE6ePAm
         Eu8MIgDxUU83/9/v6IMISaWWPz1Tsb9rFUXNFJChnPWpTFxUgWe0Jgi0YwDqS1gakWct
         mBYcrG3gyYZxKYe1QnGhMOcvB0sVRdGvXvITUd9XFW31mrN/Bl8C33YGyS+Kotbaw/Er
         W4tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768237838; x=1768842638;
        h=mime-version:user-agent:organization:references:in-reply-to:date:cc
         :to:from:subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MxclZFtCLQ8oKnBpzV/RHEud5nt0X9T5Lv3B6F2s1DA=;
        b=bjaLAjFY5IWxEt3QbGYnxmLlyXNxbLm6AAsxwmaqXk350rx5aiIpMc5bZIJ8mQMacN
         hZmHLt2gBK7C54oQ9ch9PFBV2MYeiniyMB4RPudIPdidTtK1/ABeJoKWVgNkGVH3qak8
         VpP/AfGCnRexOWFQOJSq8oAuqIrZWUBJWtI2N+2+RkO/M4k7uuiIfley2nQXNafbdpF7
         OJfIRt/P9J0nUh5cruH3cD8MSkTboIs/wvhwPuBYSEcI19UTQ6JXgRrLY2qU5g8Y2IM0
         755Vh5lvaKk3liS53E8dukoqJW5/Bg8Tk6d6wmH+xT61WsWfcTJu+mLq73eC5MM8Hl/r
         894w==
X-Forwarded-Encrypted: i=1; AJvYcCUwTZcBUvl62GoEfg/4I8ag7HtK8MSVg9htBYrgQodYVvK8KNAoPHxQkruntj7DpXXzMR9h/P/+YJA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrAHqCbqFzdwJ489Ihep98qj6EB+18gTTExgKGNJB2S3AjD3FD
	NV1gCM7I7DGMQJoDKSgl7jthSZUFLL3MV/HQ3GFkr4nTEOsMieMItDxlQ931JhUZFsg=
X-Gm-Gg: AY/fxX5DwsQfriGM/osQhu93CD+ACVAuwC2Eb0vjdsvDIBPDfiBANgnJUdsBm9EmG4c
	3hj+XbqDNFo6xZpHgxJw7kXBlLWvvkRSZJ7ILdfWtGh6TL8mHH5PWrmw9MECc2NzIVleW1K4r8b
	LlcYcH9/2smZptw2jLyJhK6qJRAgA+PT/NxX1GdckVJvSLBoazK/HwwJ63wLJAWK8vgVp//UPMP
	RMo3qxyxuMBKYRqPJchijuMIty7oildbzY2GI22em1113Ndw6wckUIxx9T+AF8H23t09YI3g83j
	i5LICt42zowpWmXbbtyxJaA9BrbIXipSKeJ+KvDx+l95kFTSyPj22yrq56doaDfUqLT7P4ySgHS
	j4t48blyNVgdVRIX7UhPIOo8WZfLenDWLvLUAvjnAAcxFRG0ztdkFfxN+DDTJY/3kb2WJaKyhy4
	8yzTKN/ai+5DEtwg==
X-Google-Smtp-Source: AGHT+IFZ61CLtlKx+6t+2r4LMkWK35iBrdV1m9CAT6C95MDrN/FlE2r8wm0PoBjtlbc6Hql+vhi05w==
X-Received: by 2002:a17:907:9727:b0:b87:6ce:1267 with SMTP id a640c23a62f3a-b8706ce1943mr528688566b.64.1768237837955;
        Mon, 12 Jan 2026 09:10:37 -0800 (PST)
Received: from [10.203.83.61] ([151.35.240.230])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a4d1c6csm1920266766b.39.2026.01.12.09.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 09:10:37 -0800 (PST)
Message-ID: <2ba028f8a6239c821da80ff487b9df5536e58169.camel@baylibre.com>
Subject: Re: [PATCH 1/3] iio: imu: st_lsm6dsx: set buffer sampling frequency
 for accelerometer only
From: Francesco Lavra <flavra@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, David Lechner
 <dlechner@baylibre.com>,  Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>,  linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Mon, 12 Jan 2026 18:10:32 +0100
In-Reply-To: <20260111161857.4f8b4c35@jic23-huawei>
References: <20260109181528.154127-1-flavra@baylibre.com>
	 <20260109181528.154127-2-flavra@baylibre.com>
	 <20260111161857.4f8b4c35@jic23-huawei>
Organization: BayLibre
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-2KKlrEBEWnroWDDuj9kx"
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-2KKlrEBEWnroWDDuj9kx
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2026-01-11 at 16:18 +0000, Jonathan Cameron wrote:
> On Fri,=C2=A0 9 Jan 2026 19:15:26 +0100
> Francesco Lavra <flavra@baylibre.com> wrote:
>=20
> > The st_lsm6dsx_hwfifo_odr_store() function, which is called when
> > userspace
> > writes the buffer sampling frequency sysfs attribute, calls
> > st_lsm6dsx_check_odr(), which accesses the odr_table array at index
> > `sensor->id`; since this array is only 2 entries long, an access for
> > any
> > sensor type other than accelerometer or gyroscope is an out-of-bounds
> > access.
> >=20
> > To prevent userspace from triggering an out-of-bounds array access, and
> > to
> > support the only use case for which FIFO sampling frequency values
> > different from the sensor sampling frequency may be needed (which is
> > for
> > keeping FIFO data rate low while sampling acceleration data at high
> > rates
> > for accurate event detection), do not create the buffer sampling
> > frequency
> > attribute for sensor types other than the accelerometer.
>=20
> I'm not following why we need to drop this attribute for the gyroscope.
> Perhaps lay out what the combinations of controls are and the attributes
> we end up with.

It's not like we need to drop this attribute, it's just that I don't see a
need for it. The only reason I added this attribute was to be able to
control (e.g. lower) the rate of data coming from the sensor while
maintaining a high accuracy for event detection; and accurate event
detection requires a high sampling rate for the accelerometer. So the
gyroscope is not involved here, and the attribute is only needed for the
accelerometer.

Before this change, we have:
- accel IIO device with separate samp_freq and buffer/samp_freq
- gyro IIO device with separate samp_freq and buffer/samp_freq
- (optionally) external sensor IIO devices with separate samp_freq and
buffer/samp_freq (and trying to set buffer/samp_freq for these triggers an
out-of-bounds array access)

After this change, we have the accel IIO device with separate samp_freq and
buffer/samp_freq, while the other IIO devices have only a single samp_freq
attribute.

> As you note in the cover letter we can change this now with ABI issues as
> it is just in my tree, so I don't mind the change, just want to
> understand
> it a little better than I currently do!

It's not just in your tree, it has been pulled into Linus's tree for 6.19.


--=-2KKlrEBEWnroWDDuj9kx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEhleFT5U73KMewxTm7fE7c86UNl8FAmllKwgACgkQ7fE7c86U
Nl+8+gv/ckaeQq4gLr6VfDjajfKeu5qZ8ZsIVLUa3eVjsrAtjYuWI11IJptAF+U7
oUiMNW88iWR09fwU7Lfe+Y9eSmw+RCSt+nOj3jaR0+GATiKm54FPxm7w46/Vw9hV
MtIipPWQfauDQw3LMyQuEGFekWYMn+JHPZxrhAbZSh+yv6FgC1GrjG7m0VcR9Dg5
0pgZAT28jQRuIftC/QSeC6bO54a3A9o3SuJ/NpT8hJHa1eCVfPAENaV7zsytv+iP
KdknWy/r2Owo0xDJUGKU5cf0QsFgauxqT5LydM0nRO7ly8SmZtqSe8A0Tv64Ug1f
3u8l2FhDPKc+Qikxx8ARodVfutwIXQHPCQ4ydgd2ZCaaTKjq5MWd5ROyDOpg24O2
Ln4WHCV/TCYLpEJP9WX4PCUCXFm3dpix3EAG/nvcaJta/I31HywMoiCP7FcX8mxw
zF2uWfe1uqe3axzt+nHTTEMc9xROltBZGBACSHc1gtDSMUCAM4+sIeYFKoNLXJ2w
dfYS+C9y
=krIH
-----END PGP SIGNATURE-----

--=-2KKlrEBEWnroWDDuj9kx--

