Return-Path: <linux-iio+bounces-15050-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA0C6A299A6
	for <lists+linux-iio@lfdr.de>; Wed,  5 Feb 2025 20:02:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E4C43A9A89
	for <lists+linux-iio@lfdr.de>; Wed,  5 Feb 2025 19:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CAFE1FF5FF;
	Wed,  5 Feb 2025 19:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VdrCr6sw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADFC14884F
	for <linux-iio@vger.kernel.org>; Wed,  5 Feb 2025 19:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738782112; cv=none; b=OFMbE7DIet9dxJXBRsfZyu74NhUcFfAEZ5+sLDJ/UTx0Hf2L60rvoW/GapuTIpqrxWX8qPbw4IRLZlFJ3+UjOhqzNkvMxq08NFDEd8g3zkx0/cUJ2TgaIdDPZO06BrB1FHjrHxqPDc1mYQj6AqKdlUSA95MFUhx0tpOePO00uYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738782112; c=relaxed/simple;
	bh=3M+mDJFPYBPh6hB3r5N+r44u2rGaR1f2+3ydc/hALOY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j0cjyhTGODb2D9tgwEuZtLLnU8ZYWa2DaYi34klY1leAnDPy+9KZxzz+X5CLVcgli2uQTjXgJ/iJAUPtz5zIslsdgpsn1JZlF2FWjT6od/KzFkdxxAaHg4pSoGT1/nY60MNNrvS5m0CkgnEBZDM8XesrLGzGCdUpA90UPSXO0tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VdrCr6sw; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-467a63f5d1cso1507991cf.0
        for <linux-iio@vger.kernel.org>; Wed, 05 Feb 2025 11:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1738782109; x=1739386909; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TcHpiV6/78CwSGaIMGZVgW8T8w0LoEPMnjIg3WTdpO8=;
        b=VdrCr6swQNcXKw7h0cfNvVhTJ3cA7/DF8FmFxSRx8pcAeoNfC3kcot8XGHYBNDlODN
         K1vhpjvSVbf8jZK6WbLZNGW0a84d2+wekg19P9WboCresU/Jrzb6lD92qobCjThjfTeP
         1qci/VOf+ogOMqf7tcsntabZAxTqtkEOQXP7s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738782109; x=1739386909;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TcHpiV6/78CwSGaIMGZVgW8T8w0LoEPMnjIg3WTdpO8=;
        b=XORgFh67ymwSYYPUmSQoZ7VGT3XGg1BnWYzdc+mhzsij8XZT5V5uXHlfWKlpLu/Sx2
         81XihoJ1fA+CCwytxihB0F9weXuBPbC5vu1Cv1svSnQgw6H+GhKcLOdXG8pqxlHC5Tyo
         rViWTM6BILKV0VTnlDTTUSSMhCCJypBodBIfGlAPodsNqvZztv8senUi3h+kVL2roXdq
         +a8K1gGHNisnmCH+ofD98hYEdD/1uA1wyEcvIPzgSFQfU6JOpTnX3zHbmgemw8GHq6/b
         SOuE9KzuBXt7dEyZEql0wK2RiADk17rrcPJ2mqBIF4ODGQfzWl9HDjggQCV/nHqwOxuB
         8pHQ==
X-Gm-Message-State: AOJu0YxS56cDr5zxr148TGiMQXppZob3WbzNsjR1ZjwkOAKPePg6nq4Y
	G5vDZiomVAb9Sd0zOI4FHcN+OErFQaZhsKLyzBdsThhm7dRwG68P0npE5SFXIfq6TPs26ebTGnD
	SIi/TKeWu3MFW61o3xrB2I8snIj5y8bvWumID9jANrxw2ADa7y/iU
X-Gm-Gg: ASbGnct1KZHhV23PIo8wDiHDshxoTtINzwPS3hdGLuBQu0f4eWIrGXPzRNZgxB6GyeQ
	Y6H54HGrW010lT9ix/LmC+MaTB/Pp79vW4JylKLFTSLr5jaGMKDn/ySKZPlDLPUH6XbSJMEQng6
	pqtnOeNU/k4HrQzgHOmkuxL/k=
X-Google-Smtp-Source: AGHT+IEbs8Drtcc8JpAwTOWINPNPbOFlL0AKADlrxcYUdqJuzfPYM72l7Gdb7qCArIyNkd2MXj5qGhxMjZhTmS+6Ug0=
X-Received: by 2002:a05:6122:a19:b0:51c:baa4:122a with SMTP id
 71dfb90a1353d-51f0c3ba28dmr2889701e0c.5.1738782098555; Wed, 05 Feb 2025
 11:01:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250204200250.636721-1-jic23@kernel.org> <20250204200250.636721-8-jic23@kernel.org>
In-Reply-To: <20250204200250.636721-8-jic23@kernel.org>
From: Gwendal Grignou <gwendal@chromium.org>
Date: Wed, 5 Feb 2025 11:01:27 -0800
X-Gm-Features: AWEUYZnVB_vIiLKsKpnJO1a2vleA29gx_4OPkuWDuuGSphxXQTh0kndN_V0Wh6M
Message-ID: <CAPUE2uuaPhW==oA_5a=M4jfS-ORRtcoGhLmWrewRFtP2KVQHfw@mail.gmail.com>
Subject: Re: [PATCH 07/27] iio: proximity: sx9360: Stop using iio_device_claim_direct_scoped()
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 4, 2025 at 12:03=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> This complex cleanup.h use case of conditional guards has proved
> to be more trouble that it is worth in terms of false positive compiler
> warnings and hard to read code.
>
> Move directly to the new claim/release_direct() that allow sparse
> to check for unbalanced context
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Gwendal Grignou <gwendal@chromium.org>
Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
> ---
>  drivers/iio/proximity/sx9360.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/iio/proximity/sx9360.c b/drivers/iio/proximity/sx936=
0.c
> index a6ff16e33c1e..4448988d4e7e 100644
> --- a/drivers/iio/proximity/sx9360.c
> +++ b/drivers/iio/proximity/sx9360.c
> @@ -321,16 +321,23 @@ static int sx9360_read_raw(struct iio_dev *indio_de=
v,
>                            int *val, int *val2, long mask)
>  {
>         struct sx_common_data *data =3D iio_priv(indio_dev);
> +       int ret;
>
>         switch (mask) {
>         case IIO_CHAN_INFO_RAW:
> -               iio_device_claim_direct_scoped(return -EBUSY, indio_dev)
> -                       return sx_common_read_proximity(data, chan, val);
> -               unreachable();
> +               if (!iio_device_claim_direct(indio_dev))
> +                       return -EBUSY;
> +
> +               ret =3D sx_common_read_proximity(data, chan, val);
> +               iio_device_release_direct(indio_dev);
> +               return ret;
>         case IIO_CHAN_INFO_HARDWAREGAIN:
> -               iio_device_claim_direct_scoped(return -EBUSY, indio_dev)
> -                       return sx9360_read_gain(data, chan, val);
> -               unreachable();
> +               if (!iio_device_claim_direct(indio_dev))
> +                       return -EBUSY;
> +
> +               ret =3D sx9360_read_gain(data, chan, val);
> +               iio_device_release_direct(indio_dev);
> +               return ret;
>         case IIO_CHAN_INFO_SAMP_FREQ:
>                 return sx9360_read_samp_freq(data, val, val2);
>         default:
> --
> 2.48.1
>

