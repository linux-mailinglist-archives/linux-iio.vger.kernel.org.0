Return-Path: <linux-iio+bounces-15774-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F56BA3BC5E
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2025 12:05:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B96B87A1B2F
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2025 11:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2995B1DDA20;
	Wed, 19 Feb 2025 11:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SbLSVcpl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3C8286291
	for <linux-iio@vger.kernel.org>; Wed, 19 Feb 2025 11:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739963077; cv=none; b=gJ96BS4KFznPYrfqiEFl894K4lMPmpchdVTd7DAzJUgl+JCdsOzS4NV2RBEwGesKyFAlhWh+nTOwq+7D7JNB/H4IXtOvOub8Vk/jfKXoRICscVUjeg/0RQhG+spcC3Q4z106Qci1FBkLXNKkz1Ypu0iuYKgiS1vnk8OxG71kMMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739963077; c=relaxed/simple;
	bh=keFVlAhYDX/YwFQbpWwgJzaB+9Tmcs1Z4cX6WcED2tY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aHxzSU/vBv18YKjMgjqTYc/MD80MzIYQd4clfEPV7xUpXEWZbnbzM4l5pIZD6dHh6LE59moyLbwO+C6/uIABTF/GrX5IDRVkryfEy//FcxSVTrtolh/Y3Ur/C+KsfiFkVUDSRD8fWHvJuex23lbpWTY+hmA8WQHCe9hzzsa2WcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SbLSVcpl; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-38f31f7732dso435085f8f.1
        for <linux-iio@vger.kernel.org>; Wed, 19 Feb 2025 03:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739963074; x=1740567874; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5PqA9hzKf678lsCvjEc6thmheBv6pq4mroli4npmfKo=;
        b=SbLSVcplGzKFeNm1OLjpw4jZ7AwTC8YKOqZfijY08NTCpWEAHH3OFaWqFfpRrrQ5FX
         d3IbqUfDo9pN9EhRTAJyvjJ2NbGW+Y5Sw3MjL/koEk5JrSyhqoD/a5RjA0Xfp3DZvTcp
         TZppYPcmRKWrMvvVsuwVGF8yR+Nen/lfkuu6tkEEkpwOuWB2S5932zV30slaO+0q3Q0G
         ag/+PVqlpTbdckS042EJC8QH97RGB0J0495LqVKVb8PWO4wxB/dATXmYC7P++Gc6RXBt
         5FL/vxunMYcBahBmm6MjNK5iK3k7iWy4KyTwn8pDotNF0tWyDA0hyabdP3NC806KNydi
         q4Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739963074; x=1740567874;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5PqA9hzKf678lsCvjEc6thmheBv6pq4mroli4npmfKo=;
        b=OxPj8Zw+2QeuEtbOy7lnts5pTfqaK5ltykD3fbTMlxH9LkW4RDp458thcj7vInYdIo
         CkMfb2ZSpwkPVIHWS3hzbgxRv0pkt/GeG7ZNEDtrz3F+FErT9x8ZP3Hz+zfvLcXD+LRR
         sJxKYkKYQgmo6f6Hj6NKWP40nB4sD8sSUUCSdX2d7RhSjif0P5eqsWr0IlcZvJoxunw4
         HCFVzmIoVFZYc10hq4vJf705urXkFwq6f0q0d3KrrYaFCk0VGDYa9HOTjEnsAGa5ezNe
         P5UQdbHv8YsSBSebBwh/sUmIQGlhFiYD5DHtcBudx+YeRroROSv8Mmi+PiQlXJKgO3Jr
         q0Kg==
X-Forwarded-Encrypted: i=1; AJvYcCWSCcgof7sQRS7TVlDfZEVhwrcmiD77OspLAIvhcWrArXvZOoOfkCDnQggdRiH4nC+n3rTutRDwRYo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5xhBVPcIuYrR157UFk2OsVBZFNbhvrFuIIXkb+aOa5Y7YYZwg
	3MSmyqlccTHiK5aCTTEFsOZ5ZKJXb/AMZmZF7go5NSpQmzZclBCF
X-Gm-Gg: ASbGncuCUUTwd6bYjusQSgTNNBkBCuUVTFIz592cKTxxUpiVkCpaAVQDHSYc+n4WJVT
	2ZQw6PzJ2QcVqz0HoJ72sToR98YpbJxllFwA7OiHmdo+RvFj8OOXomKGksdAS7aC/Jh3qeXgG2k
	oLQfy5O0bnSs0WZyrAPH7mo2dihHUMX3HEr+Vf7WD4c2FAdUm2rXyalAyCH8AkCDxNjS5e6AfG4
	3muw2Dqx6QmP/Vrr/XmSTcrQA48d8V2DFnkpJ8pKlJPC3ZzE0ixvQ7skHyZEYAYsRL3iFx86KlH
	jA29nJdZ5ZPAJexv2Uf+PBCQ7VAlVsVnUf0lA5Y5LW7KaLcUtoV+pkMdA+bBQzM=
X-Google-Smtp-Source: AGHT+IE2sEK9rf23OCUlCJ1sCH83hLJIPoywNI20JDjKNhWMXvm4Zug5YnHVTeWZEwe/xYxhxn09wA==
X-Received: by 2002:a5d:47c6:0:b0:38d:b8fd:591f with SMTP id ffacd0b85a97d-38f57bce4demr2653818f8f.5.1739963074515;
        Wed, 19 Feb 2025 03:04:34 -0800 (PST)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d8e62sm17609430f8f.71.2025.02.19.03.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 03:04:34 -0800 (PST)
Message-ID: <6807f2c2e4f4f8a3cfe6a9638402a53008fb9330.camel@gmail.com>
Subject: Re: [PATCH 26/29] iio: adc: max11410: Switch to sparse friendly
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
Date: Wed, 19 Feb 2025 11:04:37 +0000
In-Reply-To: <20250217141630.897334-27-jic23@kernel.org>
References: <20250217141630.897334-1-jic23@kernel.org>
	 <20250217141630.897334-27-jic23@kernel.org>
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
> ---

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0drivers/iio/adc/max11410.c | 21 +++++++++------------
> =C2=A01 file changed, 9 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/iio/adc/max11410.c b/drivers/iio/adc/max11410.c
> index 6e06c62715a8..437d9f24b5a1 100644
> --- a/drivers/iio/adc/max11410.c
> +++ b/drivers/iio/adc/max11410.c
> @@ -471,9 +471,8 @@ static int max11410_read_raw(struct iio_dev *indio_de=
v,
> =C2=A0
> =C2=A0		return IIO_VAL_INT;
> =C2=A0	case IIO_CHAN_INFO_RAW:
> -		ret =3D iio_device_claim_direct_mode(indio_dev);
> -		if (ret)
> -			return ret;
> +		if (!iio_device_claim_direct(indio_dev))
> +			return -EBUSY;
> =C2=A0
> =C2=A0		mutex_lock(&state->lock);
> =C2=A0
> @@ -481,7 +480,7 @@ static int max11410_read_raw(struct iio_dev *indio_de=
v,
> =C2=A0
> =C2=A0		mutex_unlock(&state->lock);
> =C2=A0
> -		iio_device_release_direct_mode(indio_dev);
> +		iio_device_release_direct(indio_dev);
> =C2=A0
> =C2=A0		if (ret)
> =C2=A0			return ret;
> @@ -550,9 +549,8 @@ static int max11410_write_raw(struct iio_dev *indio_d=
ev,
> =C2=A0		if (val !=3D 0 || val2 =3D=3D 0)
> =C2=A0			return -EINVAL;
> =C2=A0
> -		ret =3D iio_device_claim_direct_mode(indio_dev);
> -		if (ret)
> -			return ret;
> +		if (!iio_device_claim_direct(indio_dev))
> +			return -EBUSY;
> =C2=A0
> =C2=A0		/* Convert from INT_PLUS_MICRO to FRACTIONAL_LOG2 */
> =C2=A0		val2 =3D val2 * DIV_ROUND_CLOSEST(BIT(24), 1000000);
> @@ -561,16 +559,15 @@ static int max11410_write_raw(struct iio_dev *indio=
_dev,
> =C2=A0
> =C2=A0		st->channels[chan->address].gain =3D clamp_val(gain, 0, 7);
> =C2=A0
> -		iio_device_release_direct_mode(indio_dev);
> +		iio_device_release_direct(indio_dev);
> =C2=A0
> =C2=A0		return 0;
> =C2=A0	case IIO_CHAN_INFO_SAMP_FREQ:
> -		ret =3D iio_device_claim_direct_mode(indio_dev);
> -		if (ret)
> -			return ret;
> +		if (!iio_device_claim_direct(indio_dev))
> +			return -EBUSY;
> =C2=A0
> =C2=A0		ret =3D __max11410_write_samp_freq(st, val, val2);
> -		iio_device_release_direct_mode(indio_dev);
> +		iio_device_release_direct(indio_dev);
> =C2=A0
> =C2=A0		return ret;
> =C2=A0	default:


