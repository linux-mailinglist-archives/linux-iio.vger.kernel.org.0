Return-Path: <linux-iio+bounces-24416-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E88B9A42E
	for <lists+linux-iio@lfdr.de>; Wed, 24 Sep 2025 16:33:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED3FA1B25EAA
	for <lists+linux-iio@lfdr.de>; Wed, 24 Sep 2025 14:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC6E11A9FA7;
	Wed, 24 Sep 2025 14:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Ys1HtpVd"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D635306B04
	for <linux-iio@vger.kernel.org>; Wed, 24 Sep 2025 14:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758724404; cv=none; b=F56uAAKLYmvuV+lJ3AdY37knEtypHtvfVmWpW2zHkmR+L9+pwFDVmGxtZYZEJ0CxBbaMqxqjqqUl/7Y68iXlsadpN+cxvYhqGPZuF4GDz5bs/rYZXaSW9K0beT0VT6vM1iO4MayxpJLG7im7T2G5uLe0BlB0F9EPgNSlaKL17Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758724404; c=relaxed/simple;
	bh=HTk6unxpSlNsZnindmhsTv3IxjNC5xb2UJ9H7C5dmHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NcI7R1la7XmtF2NDZ1/01WzDYQ6aP7DZoafTelc0Q1m33IwM3X1yLglm8TNuIH/F6o8xNajXCgt+Odqg6XJldBfTImMZ2+vYjfV6ZhEXBPyNfAVoxVk1v5kAa7HVU/fjZzLwUU0XLHkjuwJ/vdRaE8ioIf7u0le/cDF+jNWgoGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Ys1HtpVd; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45df0cde41bso48710225e9.3
        for <linux-iio@vger.kernel.org>; Wed, 24 Sep 2025 07:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1758724398; x=1759329198; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VNhsWNt2kqqJEfmWFDpL/GmAKxMyQySWPvc8rdD+R0M=;
        b=Ys1HtpVd0oXNVmdlzPMV8HY8dRjqASW4CvCmnUca3tinMzgNgnc4OFQGTA9ktix1nX
         k6BLhCIW2c0gDC2fMZ0MjLgvf1T3/irPTOi+3ab4HWohf1L1NIAvOITZHpq62iKtdQaC
         +w4OCDfbGJg6SULC3Ae24rcYjLnTTDN1yPApH6Jy3DhTPVLRGp3A1V4hQJi8IHJZA4L3
         JMhQOOUTiiExYh6+w0K7YjWWxr8pyrOTz6S9W1UPGJpyD3dj0oC6eL7KaAz/LMmyr58j
         oQS0b9GIWbrjndIW00H9Aes/XPe0kiJjH8whkaXHo7NzLf3Q/df0k8YPY0LNG7UudPJL
         kEfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758724398; x=1759329198;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VNhsWNt2kqqJEfmWFDpL/GmAKxMyQySWPvc8rdD+R0M=;
        b=KzWus31/c47Ig8zIWhxRytdLU3jbPeukv4DHveNeH2B+Oa6AHAYKnVT8nepVTZ9BMr
         v5AVoBaSLNKz8QwMpUwkVhpscMVJWIxgIfaqzZMBgyf7UVNjjVPdwq8L2ed/A3JjJyzf
         eWB4aiGm0qaxN22ZgZn+T3Y2BKR42j1SfIzKieJgAgPd7KfKr4DGwBCswlE5KBFv46L2
         YxLqf2qRVQCq3vareLI+L74Glx8UPD8Z8Nhi79JP+y0AXE1O+yx1KeHiNNFpC26rTZIv
         xQ4rnEortS0DmRhRDTs/sDG7rZYU28NtsGynJr5sS5+1DNLj5cYxf/fT64rNZ6Ia4KQU
         xqqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLI430Yye0UE71hDzfgqB0qqP0L7tGQeu2PnT+d8Hta3V0cBCwyLOR4joFcjDGRLTKNgUEIX1X/pc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQDRbqNuAp5KF7pFBJo8yvpzUePoMfXQQi1HjdxclQTqSC+PHA
	JezTdg+pkFm+5vY0T2m7GJJcs60VKN3p+HchuU3/MtXoznpecdTotTNe0fpJFlY5r/4=
X-Gm-Gg: ASbGncvKHP/ytKl1lrRDWXdco2KrHCXBQqs6vBPwUjHORuVPqqhNv3OZuuL9vguBc1s
	dKYcZ/4AVmZ9xfZLqjWXtmrBRS4JC05+mWzxVr+cHV7g/PVju8L78Lk/w1dlv5/4aAVMIkJKlqQ
	kyTh+FN/yY6ktHCfKNqvPBOqBo1GrHOVSmdC9Yka0becQ/MiNrjKCPank3T23YJXAY6oiWVBIUt
	7QwYHh5zoNyKaM42auZovCI46lyZFxQPI2kD+ZryRyxZoYDhcTnl2iKPnPokSDxbpDF2SAiVH6m
	8YlXUm7IpMJjtak9b8NdBRkfg5UrQwfjIYfNOpO1dy8QwIOSzs5W5BJgsr2W5Z0m7h7nBc2mgxi
	27pYbrjCvg9CW4dhMyxZ2t9redgWZoHrhohcBJHtNlMHJBX8isO6qQXa9eDC+eVtYRbwf664ZVy
	E=
X-Google-Smtp-Source: AGHT+IFnpncVLFL1UMcg6F8+cSbmKY8VnmjZGbwTIIvXTNMjG9iP3giT0Hpu55FZrPYATzJylT2ncg==
X-Received: by 2002:a05:600c:1d22:b0:456:fc1:c26d with SMTP id 5b1f17b1804b1-46e329a7e49mr890755e9.2.1758724398478;
        Wed, 24 Sep 2025 07:33:18 -0700 (PDT)
Received: from localhost (p200300f65f06ab0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f06:ab04::1b9])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-46e2a9982fdsm44359335e9.2.2025.09.24.07.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 07:33:17 -0700 (PDT)
Date: Wed, 24 Sep 2025 16:33:16 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad7124: fix temperature channel
Message-ID: <apfh25e3k7dpho7dcjayl7g5dpq5lnsuhnc7xhbjlqtfw5lyql@lopr22johw5z>
References: <20250923-iio-adc-ad7124-fix-temperature-channel-v1-1-e421c98c0d72@baylibre.com>
 <h2rof27omrhv4l6pjisdsnvkpb35ovy7e6m4soeltfun5rafk5@oriv7e3egh3p>
 <9e20ce95-a401-46ca-94aa-bd4488b45025@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="orpui3etjel2edtj"
Content-Disposition: inline
In-Reply-To: <9e20ce95-a401-46ca-94aa-bd4488b45025@baylibre.com>


--orpui3etjel2edtj
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] iio: adc: ad7124: fix temperature channel
MIME-Version: 1.0

Hello David,

On Wed, Sep 24, 2025 at 08:17:21AM -0500, David Lechner wrote:
> On 9/24/25 6:03 AM, Uwe Kleine-K=F6nig wrote:
> > On Tue, Sep 23, 2025 at 03:18:02PM -0500, David Lechner wrote:
> >> Fix temperature channel not working due to gain and offset not being
> >> initialized. This was causing the raw temperature readings to be always
> >> 8388608 (0x800000).
> >>
> >> To fix it, we just make sure the gain and offset values are set to the
> >> default values and still return early without doing an internal
> >> calibration.
> >>
> >> While here, add a comment explaining why we don't bother calibrating
> >> the temperature channel.
> >>
> >> Fixes: 47036a03a303 ("iio: adc: ad7124: Implement internal calibration=
 at probe time")
> >> Signed-off-by: David Lechner <dlechner@baylibre.com>
> >> ---
> >>  drivers/iio/adc/ad7124.c | 11 +++++++----
> >>  1 file changed, 7 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
> >> index 374e39736584f55c1290db3e257dff2c60f884d2..94d90a63987c0f9886586d=
b0c4bc1690855be2c1 100644
> >> --- a/drivers/iio/adc/ad7124.c
> >> +++ b/drivers/iio/adc/ad7124.c
> >> @@ -1518,10 +1518,6 @@ static int __ad7124_calibrate_all(struct ad7124=
_state *st, struct iio_dev *indio
> >>  	int ret, i;
> >> =20
> >>  	for (i =3D 0; i < st->num_channels; i++) {
> >> -
> >> -		if (indio_dev->channels[i].type !=3D IIO_VOLTAGE)
> >> -			continue;
> >> -
> >>  		/*
> >>  		 * For calibration the OFFSET register should hold its reset default
> >>  		 * value. For the GAIN register there is no such requirement but
> >> @@ -1531,6 +1527,13 @@ static int __ad7124_calibrate_all(struct ad7124=
_state *st, struct iio_dev *indio
> >>  		st->channels[i].cfg.calibration_offset =3D 0x800000;
> >>  		st->channels[i].cfg.calibration_gain =3D st->gain_default;
> >> =20
> >> +		/*
> >> +		 * Only the main voltage input channels are important enough
> >> +		 * to be automatically calibrated here.
> >> +		 */
> >> +		if (indio_dev->channels[i].type !=3D IIO_VOLTAGE)
> >> +			continue;
> >> +
> >=20
> > I don't understand a detail of the problem. The commit log suggests that
> > there is a general problem, but looking at the patch I suspect there is
> > only a problem if at probe time the OFFSET and GAIN register for the
> > temperature channel are different from their reset default setting.
>=20
> What I failed to mention is that st->channels[i].cfg.calibration_offset
> and st->channels[i].cfg.calibration_gain are zero-initialized. And that
> these values are later programmed into the ADC. Programming these to
> zero is what caused reading the raw value value to always return a fixed
> value because the real value got multiplied by 0 in the ADC.
>=20
> Is that enough to clear it up?

Yes, got the whole picture now. Thanks for explaining.

So maybe:

	For channels other than the voltage ones calibration is skipped (which
	is OK). However that results in the calibration register values
	tracked in st->channels[i].cfg all being zero. These zeros are
	then written to hardware before a measurement and thus resulting
	in temperature readings to be always 8388608 (0x800000). This is
	easily fixed by postponing the channel type check until
	st->channels[i].cfg is initialized with the uncalibrated default
	values.

Best regards
Uwe


--orpui3etjel2edtj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmjUASkACgkQj4D7WH0S
/k45UwgAiR+/IwqtkNLvDlWTqkhljV24kmmMlrL8zqR713AH7noGbRsPExJCgWMh
yDWolydpKHMNPvDeNmj+jwX/QlVeaaVPbhseK3MVApin3c25RTXqf6+rdOOMW9sK
g8cqiHOYrO+opxcGX09n3q0V/W4MCiOsxlclsytmUu9YhpeIu4seqTM2EccZcWh6
mDgMGMmU28F9wSPIDyhf0e7gFlMzV/l+ehzt4dkGp7GrvcW47rVNzDrooLLrg6iV
QZ3W4QTt2q0TM2pk7vlOTPiA7NbPfPlTd5yrLLKfdXRvzzzJS3uR8DuS2z1SEOs1
ZJzQjHoME//szwP5H/SD6O7CSQODAg==
=lKiv
-----END PGP SIGNATURE-----

--orpui3etjel2edtj--

