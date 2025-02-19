Return-Path: <linux-iio+bounces-15763-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F693A3BC28
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2025 11:56:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BC811893AF9
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2025 10:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3E11DE891;
	Wed, 19 Feb 2025 10:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BRqiPq1d"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CFE1DE4FA
	for <linux-iio@vger.kernel.org>; Wed, 19 Feb 2025 10:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739962513; cv=none; b=VvSWy2/RuqMRppr6WjD9NySbhCgxuiiiUKddxyBYI/LJOD7U2mPpcjwRNQf3LRE1P05Q8br3973H/gLgpgrF9U9NQHdNnYl4fo1x3aFIjlwIVG3xbMqpkvz0i2j9KSuvtUPOH10DbZfGoapDniyauFNcWQ7YsHa2MA6PDldWXEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739962513; c=relaxed/simple;
	bh=unlosi5Y6BrZCmH+tQ0wBgeelbxN99PL1POWHjctkuU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XpaK4PaN7YzYo3OgRMLuEJ9Aj1VSvrEW0LqfJGQVGmncdE3rS1HkvrrQD9ppz15Ff9VTTUCfW5UpHs6ZuN/6KevRTJC51Jxayw9UON+ATjoxSDmvb9C72cO/dxig1niYelFdzM7ZUn5nay/WiTk/IwfzrOWjWED6P6o0gdxH6j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BRqiPq1d; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5deb956aa5eso9074921a12.2
        for <linux-iio@vger.kernel.org>; Wed, 19 Feb 2025 02:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739962509; x=1740567309; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vvdAqeBYYiNMXBhxrOPiHBXXlkz0+lAY8Lk5F4TuCdQ=;
        b=BRqiPq1d+BD0E606L3qjKYH90M/3aRsJBiXPc3/ktdupzVlRiUUZDJQw4FD44fkkI6
         B6ZXzMjcYYFa8DWlKFyzhQazAxSGAnF7GYdiDsKD+9yHt6ZfNJD9grASrzTvkYM6wfpk
         avPM4Uch84siVkTl1A+jId2PJqlfj+hJtyLjlCxMleFrs3TEvwPXd6XQAgBmvBaaZOqG
         tdQ1vdHYkk5bxP0Hnmnbz5fxK58e662c5VlTwSxV2kcovk3lOwNbttCGUW/rH9OxvoZE
         6LTjlar3N+YPMITc8iG7kxcRHuPwFOaIPpY6HuhtRXRrhcaRXCcgLwxgq33WtpwG7zK1
         Mgkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739962509; x=1740567309;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vvdAqeBYYiNMXBhxrOPiHBXXlkz0+lAY8Lk5F4TuCdQ=;
        b=oMsSwjZDjUWvOf8mrRZ3LM4Quu2U9nSfGDIK7XRCYCJOmI8p20XMypcX1IEP+Q1Fxp
         +GRBgRJMPKzVBqP/Untlr+y2neGoChHsUaWnvzxReWvle9aK5SMj5u6KNg3eIG1UFlzS
         NadycRJe/tCfk3YkcCPzaOeH4T65R+9jGggqUjuuO4SweeSlzKlzE2JbR5CqxIVce3lj
         T4Ottra0OA9phzff1ihOj73nbX1td+YJQzHiNhZ+3n9JclS0rrOZkDqkvwbcszK5XEeo
         /UHJVEfsIYhc3/R7dmsZYcOpvmqyos2TpIyTMmWpUWK0rXXvFmExTyShCt46zn1UWLLb
         FQPA==
X-Forwarded-Encrypted: i=1; AJvYcCU58CU76M0Fe5rRnrT199uXclQPW0LSJEei5EpO5BVAcDqPyKJ+GdN9DFL64NnBMEAJ/6s8zHIGNeE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw4KX85on8XPoSaQAUSfafkN5sHOAq1TqOfalq4Ot/4fX5Be3a
	9EOfUPWJgtBM7sPh5idUPzj9ogZMSiPUtvcTgMnvXwDn3Q2xIqD8
X-Gm-Gg: ASbGnctQINMG2rC4Rrsk0O2rjidkvtCVbuSRT/PLzXG0lGs6wLlMkLTSFbDxMGDrdZ8
	maKygUs2Q5my2O+oIKWAIOph1huWZ2QQMe4MffErS4+YJltdz0bRFAO+SKgw1AplOxUBTz1NU5I
	J5nhhet/OLkZ/TaZJ4NNCPC2Zt8FPt3wdGB7kNJUBsQXDISeGc9h0zLWVSzeYzz+gClJzB5Z0qP
	MUWyEwivtbln2CJY8H8A9HLEQ64fsIdI2M2DOm1MhzF53QJkKFNf1qsx197i7bkVbSYG9a4WRw4
	EEwHbnds7QIfV1b3nuRWGLue5WgFx5zoVN2S4hbJOSmlmStxa29991BTwALfr9g=
X-Google-Smtp-Source: AGHT+IG9ik0FoI9Z9+rXXrH+fo3JmXw0rNUNiWswIcx7/Wt35upYilSksKn76gIxIDxLMnfKYMINRw==
X-Received: by 2002:a05:6402:26d1:b0:5d0:c697:1f02 with SMTP id 4fb4d7f45d1cf-5e036063de6mr40141764a12.17.1739962509294;
        Wed, 19 Feb 2025 02:55:09 -0800 (PST)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb98ed07afsm588501766b.102.2025.02.19.02.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 02:55:08 -0800 (PST)
Message-ID: <4e73ef7c699e0b130b0d07cb2e2147c7c218e599.camel@gmail.com>
Subject: Re: [PATCH 11/29] iio: adc: ad7192: Switch to sparse friendly
 iio_device_claim/release_direct()
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>, Olivier Moysan	
 <olivier.moysan@foss.st.com>, Mike Looijmans <mike.looijmans@topic.nl>,
 Phil Reid <preid@electromag.com.au>, Marek Vasut
 <marek.vasut+renesas@gmail.com>, Miquel Raynal	
 <miquel.raynal@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, Uwe
 =?ISO-8859-1?Q?Kleine-K=F6nig?=	 <u.kleine-koenig@baylibre.com>,
 Alisa-Dariana Roman <alisa.roman@analog.com>,  Marek Vasut <marex@denx.de>,
 Frank Li <Frank.Li@nxp.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Date: Wed, 19 Feb 2025 10:55:12 +0000
In-Reply-To: <20250217141630.897334-12-jic23@kernel.org>
References: <20250217141630.897334-1-jic23@kernel.org>
	 <20250217141630.897334-12-jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-02-17 at 14:16 +0000, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20
> These new functions allow sparse to find failures to release
> direct mode reducing chances of bugs over the claim_direct_mode()
> functions that are deprecated.
>=20
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Alisa-Dariana Roman <alisa.roman@analog.com>
> ---

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0drivers/iio/adc/ad7192.c | 14 ++++++--------
> =C2=A01 file changed, 6 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
> index 785429900da8..f6150b905286 100644
> --- a/drivers/iio/adc/ad7192.c
> +++ b/drivers/iio/adc/ad7192.c
> @@ -694,9 +694,8 @@ static ssize_t ad7192_set(struct device *dev,
> =C2=A0	if (ret < 0)
> =C2=A0		return ret;
> =C2=A0
> -	ret =3D iio_device_claim_direct_mode(indio_dev);
> -	if (ret)
> -		return ret;
> +	if (!iio_device_claim_direct(indio_dev))
> +		return -EBUSY;
> =C2=A0
> =C2=A0	switch ((u32)this_attr->address) {
> =C2=A0	case AD7192_REG_GPOCON:
> @@ -719,7 +718,7 @@ static ssize_t ad7192_set(struct device *dev,
> =C2=A0		ret =3D -EINVAL;
> =C2=A0	}
> =C2=A0
> -	iio_device_release_direct_mode(indio_dev);
> +	iio_device_release_direct(indio_dev);
> =C2=A0
> =C2=A0	return ret ? ret : len;
> =C2=A0}
> @@ -1017,13 +1016,12 @@ static int ad7192_write_raw(struct iio_dev *indio=
_dev,
> =C2=A0{
> =C2=A0	int ret;
> =C2=A0
> -	ret =3D iio_device_claim_direct_mode(indio_dev);
> -	if (ret)
> -		return ret;
> +	if (!iio_device_claim_direct(indio_dev))
> +		return -EBUSY;
> =C2=A0
> =C2=A0	ret =3D __ad7192_write_raw(indio_dev, chan, val, val2, mask);
> =C2=A0
> -	iio_device_release_direct_mode(indio_dev);
> +	iio_device_release_direct(indio_dev);
> =C2=A0
> =C2=A0	return ret;
> =C2=A0}


