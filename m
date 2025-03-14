Return-Path: <linux-iio+bounces-16816-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA538A60AA8
	for <lists+linux-iio@lfdr.de>; Fri, 14 Mar 2025 09:01:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2062B17F6C3
	for <lists+linux-iio@lfdr.de>; Fri, 14 Mar 2025 08:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C801C155A2F;
	Fri, 14 Mar 2025 08:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ze9VQeEF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A638635C
	for <linux-iio@vger.kernel.org>; Fri, 14 Mar 2025 08:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741939261; cv=none; b=dnG2N93kN40tFJUurK8asH84RQZU2Llx2NSsxVanTdF0fZb4i0k4uK8XyKP7UcxV1A0ZLLxvRlHU1DvhGiDT7qp8b9ZtN+UDgXbnSXUMNjP/SkG3kvgWYygFmPlKJ4TrsoIkXON9FMS3gUyEseMmG9TLSyBim+5MV+Yr9JnFRME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741939261; c=relaxed/simple;
	bh=BhK6GgI0FV/PGqxE/UYn9XlVLwyJbqNy+bgumO4LchM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dckS/bOO5I21VLVfm6R4Uq1YFYBUAw904eSiby3wqM3kjBcZ0L4eJ0h/LoHuB+gLP/V4pL+P43gSV7gbuPQ+eKe/V3DG8jNJXTWckm0GBhRRS+DQVbgrRZxh41lX/j2tRBW6LKF4nHMZQip2lFyVoNYO6f4H3PEiBAO/eemGzKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ze9VQeEF; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3914aba1ce4so1588242f8f.2
        for <linux-iio@vger.kernel.org>; Fri, 14 Mar 2025 01:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741939258; x=1742544058; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ehTQcTsV6Hsd6RKy0xoaogdXSKGU0Gm9uxMCkHv/kqM=;
        b=Ze9VQeEFwgiVHUDkuVLBQ+A9mfKFFfV24VeFmH35Xw+M8o/ozE3KoSpEBQpPfcgI56
         Un9tG8CV677YJKVmx85A4kdCcJZl9YTPx3R/+kglUsUw9WXSOIYzVC6DA6TCh8pBYxyM
         oRvgP1BYrRFxKIa9iBb07qpYxYSCAk7dgDR7ty/H5P1AQcWnxmv8TDHOiA+9FmvAUb0x
         lOFzSsxRjhuhGeS1G7J1Nzg4yYn1WAtEao5WFkLbFRYI17uBgY4ub5im3fBCAUfDvnN0
         ZriycyM9V0wYWsdJa2GhzCSsnN+5INuG563nRz4zUjxjxK/WFgpEM4mbiRo85kzvvwtx
         Lfuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741939258; x=1742544058;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ehTQcTsV6Hsd6RKy0xoaogdXSKGU0Gm9uxMCkHv/kqM=;
        b=CUCqHhXYStNZDBhM4dX6Kvz3fRB/kKqDADKgZZ5DYU7rFU9kpsoqoartglC0r4OLEN
         5H4wzN5zaJwUlif2zVpkTIQFYSe/R/ofsH4gxoY5iDk99J4OhwvxNG0NPUtVRGmnSDBY
         KCUWozmm0rzysGz33UqIWoZTx9B0VONCzwt/CtFVzmmvgPhJSOd1kOmUuZRmJ/9zDZWM
         mXgQnCQVq/Mia3Y3jF5KRS0xNdkS+Ma2uIFmJOjYnz+ZC+yiu0g3v2Tw+bI3RSucy7m2
         sNEiL7uBECbAPPhMFS/0B7X0puOtA9U82xhNzMDCBjeAd4htj6ivXfNhD00K9DM8fLpa
         Q1hA==
X-Gm-Message-State: AOJu0YyzkOXX/TKLk815gBlBAWiWqH05zglRlERuhLzrw4yJi869ePW4
	D63Il2bZ2uiV/UqntAp15YouGjsmrOFiF3zv9wn5bYeDe9m/lgxDu7xsu3dUFcw=
X-Gm-Gg: ASbGncsach70kZqivu/nFhrhk01HjGKM09y38vv9ULMsReR+5YqsNfkR6n8F4hTwWQl
	SA/Fp1a9xO+YxiGfqADyxkf07yBjShUUMg8kcKaKtmklUTMutufIjeDv+OqEY7iBav5liYiU6W2
	vdQlGiHdAlOxuXdrHzsZDu77NiEQSD3rFptSNSYf0GTuc0AfR0xpHbkVMOudXzt84K/SKpZoXof
	CRc0v+a0qcMgG2+AqOhsgnO/3FekOPd+G3ae4bw4vi8DnD8tUi8X3a5ENilRVsLLM7X3nm/3TH/
	avZ0gKpSKGwDxYfPgtHCi6K2A6lL1smru1LVnY7sjTt/1ZjNW04K85645N7YaYG8Mb0cI3jxMW+
	KDkpbj5802UC0cTLxITM=
X-Google-Smtp-Source: AGHT+IHq6YddAHwbXkU0lVXshInbMCfED8SIs1HvMQ1j1ZK5ltgd9iy/C3a2pI7navkGJYX9GEh+rA==
X-Received: by 2002:a5d:64e7:0:b0:391:ba6:c069 with SMTP id ffacd0b85a97d-3971f033c1bmr1739280f8f.44.1741939257985;
        Fri, 14 Mar 2025 01:00:57 -0700 (PDT)
Received: from ?IPv6:2001:818:ea56:d000:56e0:ceba:7da4:6673? ([2001:818:ea56:d000:56e0:ceba:7da4:6673])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c7df413esm4646098f8f.20.2025.03.14.01.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 01:00:57 -0700 (PDT)
Message-ID: <4d3e77deab4741112d7ef45ba331177bbc3879ca.camel@gmail.com>
Subject: Re: [PATCH 2/2] iio: adc: ad7124: Fix 3dB filter frequency reading
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>, 
 Lars-Peter Clausen
	 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron
	 <jic23@kernel.org>, Alexandru Tachici <alexandru.tachici@analog.com>
Cc: linux-iio@vger.kernel.org
Date: Fri, 14 Mar 2025 08:01:13 +0000
In-Reply-To: <6d31f9559939ec04066bec612a59bc7ace2ca548.1741801853.git.u.kleine-koenig@baylibre.com>
References: <cover.1741801853.git.u.kleine-koenig@baylibre.com>
	 <6d31f9559939ec04066bec612a59bc7ace2ca548.1741801853.git.u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-03-12 at 19:38 +0100, Uwe Kleine-K=C3=B6nig wrote:
> The sinc4 filter has a factor 0.23 between Output Data Rate and f_{3dB}
> and for sinc3 the factor is 0.272 according to the data sheets for
> ad7124-4 (Rev. E.) and ad7124-8 (Rev. F).
>=20
> Fixes: cef2760954cf ("iio: adc: ad7124: add 3db filter")
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
> ---
> =C2=A0drivers/iio/adc/ad7124.c | 4 ++--
> =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
> index 67d49e6184f7..a3cb47ca3901 100644
> --- a/drivers/iio/adc/ad7124.c
> +++ b/drivers/iio/adc/ad7124.c
> @@ -291,9 +291,9 @@ static int ad7124_get_3db_filter_freq(struct ad7124_s=
tate *st,
> =C2=A0
> =C2=A0	switch (st->channels[channel].cfg.filter_type) {
> =C2=A0	case AD7124_FILTER_FILTER_SINC3:
> -		return DIV_ROUND_CLOSEST(fadc * 230, 1000);
> -	case AD7124_FILTER_FILTER_SINC4:
> =C2=A0		return DIV_ROUND_CLOSEST(fadc * 262, 1000);

I wonder if we shouldn't fix the sinc3 factor as well? Or at the very least=
 mention
in the commit message why we're not doing it now. Otherwise it's confusing =
and raises
questions to state the proper factor in the commit and then look at this di=
ff.

- Nuno S=C3=A1

> +	case AD7124_FILTER_FILTER_SINC4:
> +		return DIV_ROUND_CLOSEST(fadc * 230, 1000);
> =C2=A0	default:
> =C2=A0		return -EINVAL;
> =C2=A0	}


