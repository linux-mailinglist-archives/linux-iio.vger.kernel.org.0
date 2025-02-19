Return-Path: <linux-iio+bounces-15773-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62316A3BC5D
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2025 12:04:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F0E4164F14
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2025 11:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643FD1DE4F9;
	Wed, 19 Feb 2025 11:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ShB+n4Iz"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1FA1DDA20
	for <linux-iio@vger.kernel.org>; Wed, 19 Feb 2025 11:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739963036; cv=none; b=K+EAv8DEvA+aP2MEvbykqsFM/rxH7/6VGdjXj8NoSkphqDgak6o9kx7ecHBPkaTIvA3iNHn1uT5apA+gQW5tKHH1GMzaHWRmpQdTRDlNG50paEX/Qx8AQPXiOQgkSsWDPKE/aNsCzCASj5Bjxrl8gWq+YRJW8uaRRxyTM0j72+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739963036; c=relaxed/simple;
	bh=HPVbEEh8CDlR3kNGrwSQinicItfw5x+NT9HIyye6uzk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F2a34PC71WIDhMJcEUaGt+GMO/pdA95s6DJABPEWfkR6nBqdKTkRS4+8evhKbrgBlXIT0iRQkMZzzxHBsE99PPGbn35hIF5cKqPvIPRd9px2LIc/dc52rEOof8Jzj1tXEPBb0sq7wv9EP0Vf0UbVsDwc+oJJvMHGcxAdjgjgwEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ShB+n4Iz; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-38f3913569fso427846f8f.1
        for <linux-iio@vger.kernel.org>; Wed, 19 Feb 2025 03:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739963033; x=1740567833; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=y0Jk8a9jAxkgf3HE6nmlXxOnxRLuQVhTavFKfbEUE8Y=;
        b=ShB+n4IzZZRF/cqV29LHWaBDmq7I0+v2XgNA1BfYqRXdLmavWufbq9+XzbF56Bihhe
         1ldoAageCVGos3xFHcxyvLmYWCIfhMUcsha5M6TvZ6UWp2ejRju65Z19JiBqR/XHdtfz
         IquSaVcqNquowqeA3ekcEtMTb4tYGB7/+v0Dx/bNrJg+PmorMmc4HLkEuF5h3EPksez0
         cV/5RO2pMPzfdS51Ly7+HeFHdW1mutgsS+rxDBZAxpcOaYRVSC3JRUots8CG/WacmA72
         c7qWblD6Li+tlBg+dFnt3fInwF3NW2a4X+SHNety3c2FSyJUpH9/EqxIW+VH+JN39oLI
         1vqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739963033; x=1740567833;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y0Jk8a9jAxkgf3HE6nmlXxOnxRLuQVhTavFKfbEUE8Y=;
        b=NO5hGBAx70BMXtLEVAGee/Qr1eCaWX/cMp1bBpRhGH6Tb2srQ/sQLddVUgHNccpb2/
         17rxP8EGO+yRoX++rmiFpGiHzt+iuiKMFxxvdgz+tw3qs7rMwGubwrwMqoowDdgvTrq/
         xz3Ewa03YWJPqzGkvRhRuSP89l8agzdOf2689lwapR3ADR5myG1L8rnHjSqPnHptegQF
         lZ8nwOszwB44vi2iHeAQCil1ArKS+xcdMFPgLJwQ3deOwhI2L2Rp3oNpYGrLnhIk1uwA
         lI8LS1OYNlF2kqsQwPMQPm+16MKu1LEFXoCG8gDM6IytyOFbYUgDI6PAgHd5C8sFcjN0
         8EEw==
X-Forwarded-Encrypted: i=1; AJvYcCXzQIpIy1S361bbCLxbs90n7X8jqSz20OWEqvgewogHbCBvfNzqBL5ftG3GPEu9x5g29MGPKD9C6pU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvIN/Igb1Suv9oQf7rg61b7E1Cq/2K5qVNbuJsruTMM2md1IZW
	7oXcSBx8lGWsi8czfRQvcFwTgz22nz1lXq+cQ2wh9QfHLB/J+5kc
X-Gm-Gg: ASbGncuesXu9oT0wfXEj3RCx6jXNTzUzI/t5MHMMjW1TmcHg3iMpOiwNceaeveZLcLp
	jJnZV5gO5K/z4SiSiRrGJdw7PmNJuJcA5BIlgsSliMta/abG08ng3umaRbo2iKTWzrq+rKje9pZ
	B/CdFGR1OiF+Iz1OJZa4yb18wM67yWB3rgPaGUIqs1SYLlg5oOMUCQOO6/i66TEQuWm1AKKFpqB
	cyFQt6xGK1a2fyrD2wk8ZBFKfo6oLPTmTWZLtX2xpwE0Aj5VkHkqCB/8vWZZi5Sebm+1lXk/L0k
	I0WeqY5JZTFA/GRBZsi/KswNFdcvJZjdHigQS7+JsEM3v/xxELqE3KRGhqP05zw=
X-Google-Smtp-Source: AGHT+IEoo4qm5YNpz8babu1usQsH3R8xJef/sLC57ocU8M9hNTMEyx1Bln1ko6h76MnF8in9S+DFBQ==
X-Received: by 2002:adf:c00b:0:b0:38f:3aae:830b with SMTP id ffacd0b85a97d-38f57d95935mr2035722f8f.26.1739963032567;
        Wed, 19 Feb 2025 03:03:52 -0800 (PST)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258b439dsm17376130f8f.8.2025.02.19.03.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 03:03:52 -0800 (PST)
Message-ID: <5d081d6cf9f707dd91f4a800776230d1d35b35d7.camel@gmail.com>
Subject: Re: [PATCH 25/29] iio: adc: max11410: Factor out writing of
 sampling frequency to simplify errro paths.
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
Date: Wed, 19 Feb 2025 11:03:55 +0000
In-Reply-To: <20250217141630.897334-26-jic23@kernel.org>
References: <20250217141630.897334-1-jic23@kernel.org>
	 <20250217141630.897334-26-jic23@kernel.org>
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
> Introduce __max11410_write_samp_freq() helper and use guard() to avoid
> need for manual unlock of the mutex. This allows direct returns and
> simplifies the resulting error handling.
>=20
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0drivers/iio/adc/max11410.c | 51 ++++++++++++++++++++---------------=
---
> =C2=A01 file changed, 27 insertions(+), 24 deletions(-)
>=20
> diff --git a/drivers/iio/adc/max11410.c b/drivers/iio/adc/max11410.c
> index 76abafd47404..6e06c62715a8 100644
> --- a/drivers/iio/adc/max11410.c
> +++ b/drivers/iio/adc/max11410.c
> @@ -507,12 +507,37 @@ static int max11410_read_raw(struct iio_dev *indio_=
dev,
> =C2=A0	return -EINVAL;
> =C2=A0}
> =C2=A0
> +static int __max11410_write_samp_freq(struct max11410_state *st,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int val, int val2)
> +{
> +	int ret, i, reg_val, filter;
> +
> +	guard(mutex)(&st->lock);
> +
> +	ret =3D regmap_read(st->regmap, MAX11410_REG_FILTER, &reg_val);
> +	if (ret)
> +		return ret;
> +
> +	filter =3D FIELD_GET(MAX11410_FILTER_LINEF_MASK, reg_val);
> +
> +	for (i =3D 0; i < max11410_sampling_len[filter]; ++i) {
> +		if (val =3D=3D max11410_sampling_rates[filter][i][0] &&
> +		=C2=A0=C2=A0=C2=A0 val2 =3D=3D max11410_sampling_rates[filter][i][1])
> +			break;
> +	}
> +	if (i =3D=3D max11410_sampling_len[filter])
> +		return -EINVAL;
> +
> +	return regmap_write_bits(st->regmap, MAX11410_REG_FILTER,
> +				 MAX11410_FILTER_RATE_MASK, i);
> +}
> +
> =C2=A0static int max11410_write_raw(struct iio_dev *indio_dev,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct iio_chan_spec const *chan,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int val, int val2, long mask)
> =C2=A0{
> =C2=A0	struct max11410_state *st =3D iio_priv(indio_dev);
> -	int i, ret, reg_val, filter, gain;
> +	int ret, gain;
> =C2=A0	u32 *scale_avail;
> =C2=A0
> =C2=A0	switch (mask) {
> @@ -544,29 +569,7 @@ static int max11410_write_raw(struct iio_dev *indio_=
dev,
> =C2=A0		if (ret)
> =C2=A0			return ret;
> =C2=A0
> -		mutex_lock(&st->lock);
> -
> -		ret =3D regmap_read(st->regmap, MAX11410_REG_FILTER, &reg_val);
> -		if (ret)
> -			goto out;
> -
> -		filter =3D FIELD_GET(MAX11410_FILTER_LINEF_MASK, reg_val);
> -
> -		for (i =3D 0; i < max11410_sampling_len[filter]; ++i) {
> -			if (val =3D=3D max11410_sampling_rates[filter][i][0] &&
> -			=C2=A0=C2=A0=C2=A0 val2 =3D=3D max11410_sampling_rates[filter][i][1])
> -				break;
> -		}
> -		if (i =3D=3D max11410_sampling_len[filter]) {
> -			ret =3D -EINVAL;
> -			goto out;
> -		}
> -
> -		ret =3D regmap_write_bits(st->regmap, MAX11410_REG_FILTER,
> -					MAX11410_FILTER_RATE_MASK, i);
> -
> -out:
> -		mutex_unlock(&st->lock);
> +		ret =3D __max11410_write_samp_freq(st, val, val2);
> =C2=A0		iio_device_release_direct_mode(indio_dev);
> =C2=A0
> =C2=A0		return ret;


