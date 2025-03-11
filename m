Return-Path: <linux-iio+bounces-16727-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9175AA5BC42
	for <lists+linux-iio@lfdr.de>; Tue, 11 Mar 2025 10:28:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E35417264D
	for <lists+linux-iio@lfdr.de>; Tue, 11 Mar 2025 09:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863E722F169;
	Tue, 11 Mar 2025 09:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="duhg+zAr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92BD722B8BC;
	Tue, 11 Mar 2025 09:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741685228; cv=none; b=ra+GOGC8nYziAS3IgBf5FdI4/2m67I+tWUeWkGwzkiq07wJ/N0rkZCpMqiBo5sKGm1Oh0cOUXae77p7sHBbtNDMH4Vu8U+d3qtVbKVZ97XXDOyUiBbiOgMVvkEhgnvNRHIfKmiDXjrNw7US9vYxNqlUA99Sm5KemUGrOkzhzh20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741685228; c=relaxed/simple;
	bh=EvnP+NpALH0dMqJVmcHYNh1dZnH5T6zkg+/Oszsw+Po=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QwTFQ+LzlCqZMt9CPDTLlbf+6D5ReozJ8p3tbCRuwacFsaTz72PZFgj0Ga+bdQg8bY95byh+Os/bHw7eEYTlc4J3RVaBcN/c9VgJlcQtaqSp9oU/2vVovbEqaTPONRs9POBYq+GOhtcEQwH7rJOE/qpTlASIbOy0oRmcP6IV4Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=duhg+zAr; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43cef035a3bso15454745e9.1;
        Tue, 11 Mar 2025 02:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741685225; x=1742290025; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=N8dHIWMDFpQWTfO37xsQ+hoMEUhOTJDD8PZiKaCMXHI=;
        b=duhg+zArdSuB7na2xT0lsJ9lsEc9V9oMK3eLGaGyS2f9wNGmBf7Bcaf6oQ7ZtKqRm3
         UheFDYosMYbzKLYR2l1/phrlQZZkaopRb/H8Kw/17PXzbXZVasXXTYQ0zB58up5w7+qW
         LMOWfnkF+EI0bUASon92alg+aWLoh4DIpEYhGDXdcd2rIw1SSxSC/VpkvytXVFQixFbG
         7TTC/ALxJdZxtYUsYNNz4zYfwK4s6TxkVtUAOTmZsPKd4XCfR4kYDGg2jwu22PzM3eCl
         HoNSDM5ihiCUqKCWVqN7x3qYewVE6eOAzAVoas3CbTY0w5zkjrC3PNo5yBM5q3buyeGy
         +HOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741685225; x=1742290025;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N8dHIWMDFpQWTfO37xsQ+hoMEUhOTJDD8PZiKaCMXHI=;
        b=oUGa4c2KyZzkFKEyhs2/ZRp91Q95yNlK/44l9whvM+XAC2+Lgdxbg1QXt7j6MtBGXf
         0LTpOwEFREr8b9+6cSkXUxUzvKXWOzl6b/KDryPv3ql0yPXsUoQiqOu0FpmFYXi9lBX1
         Qy/G8+wGgTGLhtrBpi75gE+d4XlErMY5tHpfq3p0Ls7o96x4uTEg7Sywv49J+/+lz8r4
         WbgruE78mPb0aCIagSyYcIB2LngP8jzN3TJJUu+eJj6o+9YTzKPqO+utSgxSAFM/32Q1
         fsCrpU92QJkTC0x/OWLnBXyA88IpRyTwCpdO/CsP8R0MeqOVSLwn474XI8/sofqdGDd1
         XQ7w==
X-Forwarded-Encrypted: i=1; AJvYcCWR1GZFd4g49Yo2Za71DMH5AQvt4wUpEQ030iZa1a3oypHecKj+oQUDNJKlmEeomzt5kwygyXBo8x9VL4A=@vger.kernel.org
X-Gm-Message-State: AOJu0YykuP5e5Iz0szSRsQiqo9Kk3ToKMo5pK5MurvRV2LQoJkrRcm0M
	BuGR1BylC1GkiB4ef3D8tuCG0kGGpdg5pprxzqYRX1sl3ytKe5j+
X-Gm-Gg: ASbGncunhVOp1lNgCsJEcS0lAPwFCfsp7cg4G29/uZG4BTLH2Yb/0P4/FPVna9+ywYi
	COLTQVTIKyq5358xjw9auf7+Ibg8nazBMA355tY8BktAlkOGVxg6D6KZICCuso7E3fNFDEFZ9Ty
	+h8ereWO5JBU47KvnFAQtNy1vVhM+BBQ/YEw5+a8wQhvXD2Zy03ue4w0JN44kXGcUz6hnrI2tP/
	WeOJ7FbHajvolt57hhpbZ+W41P84ElTqLifBnTQfIxio/yL+jNmpNhbGhcEba1pqJmEfn897l9e
	uozOpNryh1Lp+nI7HYrWMlxX8mAM0ipo2lV2oq6dQXvPXqMc0MznxyV0yl9SfWunGSdHms1pr+M
	Zbw/U8zUbdE0q1lYf
X-Google-Smtp-Source: AGHT+IHHcama5MQSI6Ibndt0gLfICFPFlRPZn6VkF+BdzyW56w3z0u/VBtYyCi8sHHLQgKb+MgSNag==
X-Received: by 2002:a5d:648f:0:b0:391:2d97:7d0e with SMTP id ffacd0b85a97d-39132da92f4mr12599470f8f.42.1741685224809;
        Tue, 11 Mar 2025 02:27:04 -0700 (PDT)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c0e2e89sm17653548f8f.71.2025.03.11.02.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 02:27:04 -0700 (PDT)
Message-ID: <2faccc64193c7a6e3585bfbd5a91a1968d0fe8da.camel@gmail.com>
Subject: Re: [PATCH 2/5] iio: adc: ad4030: remove some duplicate code
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Lars-Peter Clausen
 <lars@metafoo.de>,  Michael Hennerich <Michael.Hennerich@analog.com>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Esteban Blanc	
 <eblanc@baylibre.com>, Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 11 Mar 2025 09:27:10 +0000
In-Reply-To: <20250310-iio-adc-ad4030-check-scan-type-err-v1-2-589e4ebd9711@baylibre.com>
References: 
	<20250310-iio-adc-ad4030-check-scan-type-err-v1-0-589e4ebd9711@baylibre.com>
	 <20250310-iio-adc-ad4030-check-scan-type-err-v1-2-589e4ebd9711@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-03-10 at 15:43 -0500, David Lechner wrote:
> Remove some duplicate code in the ad4030_get_chan_scale() function by
> simplifying the if statement.
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0drivers/iio/adc/ad4030.c | 9 ++++-----
> =C2=A01 file changed, 4 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad4030.c b/drivers/iio/adc/ad4030.c
> index
> af7a817e8273496e8856a5ba1a9c2e66a11f0a84..f24b46164a477f9b6b5c93ffeba0a33=
5f7b3
> de5a 100644
> --- a/drivers/iio/adc/ad4030.c
> +++ b/drivers/iio/adc/ad4030.c
> @@ -394,14 +394,13 @@ static int ad4030_get_chan_scale(struct iio_dev
> *indio_dev,
> =C2=A0	if (IS_ERR(scan_type))
> =C2=A0		return PTR_ERR(scan_type);
> =C2=A0
> -	if (chan->differential) {
> +	if (chan->differential)
> =C2=A0		*val =3D (st->vref_uv * 2) / MILLI;
> -		*val2 =3D scan_type->realbits;
> -		return IIO_VAL_FRACTIONAL_LOG2;
> -	}
> +	else
> +		*val =3D st->vref_uv / MILLI;
> =C2=A0
> -	*val =3D st->vref_uv / MILLI;
> =C2=A0	*val2 =3D scan_type->realbits;
> +
> =C2=A0	return IIO_VAL_FRACTIONAL_LOG2;
> =C2=A0}
> =C2=A0
>=20


