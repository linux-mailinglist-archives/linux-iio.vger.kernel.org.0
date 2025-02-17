Return-Path: <linux-iio+bounces-15629-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E01AA380B2
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 11:51:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF81F3A9E50
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 10:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23268212FBA;
	Mon, 17 Feb 2025 10:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H9DhGkub"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3087615C0
	for <linux-iio@vger.kernel.org>; Mon, 17 Feb 2025 10:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739789455; cv=none; b=EbiGXQO87oBDdGE8yt1aff9q2EJPrm8chtir6MXSNRBi8SHVqS3fKYZ9Mbe451jCPazy2bjD8vwfCneLTdD9LRb51RPH1FR/4zwqOOu5XxPdTPRQZUdI6d7m8sIdrZwAzpacl7vI7PMfgKWELSIYF1/+HKYt9N5e4rW3mdc196U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739789455; c=relaxed/simple;
	bh=hb5/udW1XvwoqyOAndjvN/Xwz0r8mwCzTg3PPBcgQAo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R3OwFO/+dJakEChQCu1J5NT278N+hU1nza6+VWv6lSAYW1bzjoabr6eQx/AFtgaKmgT1dHsv0GB6PXHulc9LW7yHWSC5qdDIAKwLntK5V6AGIwYfbA0RwmIw9Jj0+TAlmVbkpXXMluX6NpxRDg2K0Z//C/T+vsFWJ++sJINmbZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H9DhGkub; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-abb90c20baeso150578066b.1
        for <linux-iio@vger.kernel.org>; Mon, 17 Feb 2025 02:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739789452; x=1740394252; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OsLS6ZNqAoTkmCgptM7f/t7nvYtXoE2usZb4X1md4J0=;
        b=H9DhGkub0hMmhvSGc3Blpy9vvgfDnHzMHw8iMZfpYjBcL9d2bSFY5sDfii+c0bYv/K
         rglG8k2Uv1bqZ6wyWy3oS3XPANWf/h1kTm6+cq0pgq9qR/ItTnJjtAhYpoGgNQz+1xiA
         U9l45WoGmSlnm0TTSYBf5T2n1i+0jR06CcfmH9nSd+dpXLhLR6P+0bzO2LU5HkKHxCBJ
         /78Qit1PsQxkmbQsV9NYnkUbJzLNh00c2bdoLnMeFz12/uO8vMEyUM7Beun3VHlxPgAI
         D+TJc5hF9GmGLbOHuJkHeeqQiCi18y9zkyZ92bOWIm+15s1GgxC0nKRL25l6Jd/kWKj+
         zXpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739789452; x=1740394252;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OsLS6ZNqAoTkmCgptM7f/t7nvYtXoE2usZb4X1md4J0=;
        b=eY/Fk0SONSbyN7e/LlMY89P4dj9ejOEPU2gVhgs4kgjl12RTOVFD3Go9AervlM5x7Y
         Qq6jprgwc9phk/7dRnkYZUnYaTsaWUMaXZJfsr5MSbbrEbUekei0zWLkvniQlInmZHbX
         U9VQve3hI7skkc6YQ+6mDy7JjIvv9IMKGD529fRoJCudbDMCWq+8ezPgtSKHYIGfulWA
         zGV4wGypWp0H0dlkRRDqhxzlpycJNHd3oyHHAlO2KH1Qlhfw0p+Aa3OqtBwsnVm5+vv7
         vbywGopWh5lRLUMx8G+DJJ2fzsiurfZr2j1Vx+Cglrh4VMCCylSfLs/Z52uEdA0ogM3X
         DOug==
X-Forwarded-Encrypted: i=1; AJvYcCXJSGokoShclpWC/q9kf+Nb0yoauJojlrR5ZyLRK6xf9sSdKVAg4zFn3MwDfT+N4XOmTu76zL/h1Qg=@vger.kernel.org
X-Gm-Message-State: AOJu0YytY372l1xXIn8mY7BS+erPArrfYsJqEnGsAlovyPrISx1x+UMn
	pcwD3iezHUtS5L/hcUpK3v6r/8gHwLc/diGrqp9JZQ5n3vNooEcG
X-Gm-Gg: ASbGnctUf/P4zYYbfyeDWaHeNPcivdJxe1VVexKFUxLtAIVJNk7wIC3kSeDmJqmlRxN
	Qya3v7MD6IkpQglAI+G+58gEYSf7w3itZdQ2e6NqIL0n66+Xwvy2fs0v90c3PGzMxIL9f0XzOVH
	5fZj4cBdvO3TNn827c4f9RCsGGyFih8mgupj7fRzUuuJnQKLwQGfXd1zQSbs2taeWnLBoVr//q/
	GsiSVUZKLYiKVVPMznpQ6xbXH9RRPfx8Esbe678+1Jy0JvDZ+hL/EV22MkISCYr/kOXyRO6qBO9
	uVDKuJOYw++ayjLap+CnKDQTheJipIhEVDGM/0tGvOPJ+sF7HLWtOG0ruHhBiZ0=
X-Google-Smtp-Source: AGHT+IEODovNz3YgM4G7w2Y7LVFzkmXyVdEnqoqUGZZgQpSHVPHjcbelMf15u536Z2a+igN4nq3iSg==
X-Received: by 2002:a17:906:f5a2:b0:ab6:d686:de7 with SMTP id a640c23a62f3a-abb70d96441mr801541366b.44.1739789452411;
        Mon, 17 Feb 2025 02:50:52 -0800 (PST)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb72b519c5sm474391366b.173.2025.02.17.02.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 02:50:52 -0800 (PST)
Message-ID: <d6f3dc7a36063a5f04f6d8855770eb28030238bb.camel@gmail.com>
Subject: Re: [PATCH v2 15/27] iio: adc: ad9467: Stop using
 iio_device_claim_direct_scoped()
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: Mudit Sharma <muditsharma.info@gmail.com>, Julien Stephan	
 <jstephan@baylibre.com>, Mariel Tinaco <Mariel.Tinaco@analog.com>, Angelo
 Dureghello <adureghello@baylibre.com>, Gustavo Silva
 <gustavograzs@gmail.com>, Nuno Sa	 <nuno.sa@analog.com>,
 =?ISO-8859-1?Q?Jo=E3o?= Paulo =?ISO-8859-1?Q?Gon=E7alves?=	
 <joao.goncalves@toradex.com>, ChiYuan Huang <cy_huang@richtek.com>, Ramona
 Alexandra Nechita <ramona.nechita@analog.com>, Trevor Gamblin
 <tgamblin@baylibre.com>, Guillaume Stols	 <gstols@baylibre.com>, David
 Lechner <dlechner@baylibre.com>, Cosmin Tanislav	 <demonsingur@gmail.com>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>,  Gwendal Grignou
 <gwendal@chromium.org>, Antoni Pokusinski <apokusinski01@gmail.com>, Tomasz
 Duszynski	 <tomasz.duszynski@octakon.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Date: Mon, 17 Feb 2025 10:50:55 +0000
In-Reply-To: <20250209180624.701140-16-jic23@kernel.org>
References: <20250209180624.701140-1-jic23@kernel.org>
	 <20250209180624.701140-16-jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2025-02-09 at 18:06 +0000, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20
> This complex cleanup.h use case of conditional guards has proved
> to be more trouble that it is worth in terms of false positive compiler
> warnings and hard to read code.
>=20
> Move directly to the new claim/release_direct() that allow sparse
> to check for unbalanced context. Also use guard() to simplify mutex
> unlock paths.
>=20
> Cc: Nuno Sa <nuno.sa@analog.com>
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

> =C2=A0drivers/iio/adc/ad9467.c | 23 ++++++++++++++++-------
> =C2=A01 file changed, 16 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
> index f30119b42ba0..f7a9f46ea0dc 100644
> --- a/drivers/iio/adc/ad9467.c
> +++ b/drivers/iio/adc/ad9467.c
> @@ -813,6 +813,18 @@ static int ad9467_read_raw(struct iio_dev *indio_dev=
,
> =C2=A0	}
> =C2=A0}
> =C2=A0
> +static int __ad9467_update_clock(struct ad9467_state *st, long r_clk)
> +{
> +	int ret;
> +
> +	ret =3D clk_set_rate(st->clk, r_clk);
> +	if (ret)
> +		return ret;
> +
> +	guard(mutex)(&st->lock);
> +	return ad9467_calibrate(st);
> +}
> +
> =C2=A0static int ad9467_write_raw(struct iio_dev *indio_dev,
> =C2=A0			=C2=A0=C2=A0=C2=A0 struct iio_chan_spec const *chan,
> =C2=A0			=C2=A0=C2=A0=C2=A0 int val, int val2, long mask)
> @@ -842,14 +854,11 @@ static int ad9467_write_raw(struct iio_dev *indio_d=
ev,
> =C2=A0		if (sample_rate =3D=3D r_clk)
> =C2=A0			return 0;
> =C2=A0
> -		iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
> -			ret =3D clk_set_rate(st->clk, r_clk);
> -			if (ret)
> -				return ret;
> +		if (!iio_device_claim_direct(indio_dev))
> +			return -EBUSY;
> =C2=A0
> -			guard(mutex)(&st->lock);
> -			ret =3D ad9467_calibrate(st);
> -		}
> +		ret =3D __ad9467_update_clock(st, r_clk);
> +		iio_device_release_direct(indio_dev);
> =C2=A0		return ret;
> =C2=A0	default:
> =C2=A0		return -EINVAL;


