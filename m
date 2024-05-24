Return-Path: <linux-iio+bounces-5266-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3234A8CE497
	for <lists+linux-iio@lfdr.de>; Fri, 24 May 2024 12:59:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3F851F221EB
	for <lists+linux-iio@lfdr.de>; Fri, 24 May 2024 10:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EFD286255;
	Fri, 24 May 2024 10:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fJy4wcfY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDD085C70;
	Fri, 24 May 2024 10:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716548357; cv=none; b=BruVjXL0YWzy60ECD1IU4/LbHn+Y38mhhA26fqDHMOj8bs2xUeVIzueYdGIPvMjd8C2QtHvK+4m9ReuFC053/jKzfD6UcSZXUAKiItPQl+74eaJzjgv+KH4mIZF4sgKV9KsGXOsXvihmZE5vk/NwsTGsRG3tz5NQNJcolKHISzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716548357; c=relaxed/simple;
	bh=QduSwC3o+NUpXVJeE4N0fli99wFPcGFKRYACTS8slHM=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NAeoQ5CoaF1REHskCZcHe+n+rP9kWlGiy0sxFaIM6YdoBZrT505Ts1q8b3Y4IzjHyESdhgzSaQ+mftpxgsbDJGmc0f7QRP86eolg75ajp0Kf8uHGJsXPUdT+SkZBtlrrvxzjTGfoQuHqo1Jt4r0E4ffdqwsozgI6zcC4wrhHLmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fJy4wcfY; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42017f8de7aso64414435e9.1;
        Fri, 24 May 2024 03:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716548354; x=1717153154; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WQwqXnfXieAdfBpts/Rfm3B1N7XI2m8BMWVC3RyR8j4=;
        b=fJy4wcfYJY4GdcVTav0/+sW06pM8g2hDycH90frjjAGbYbDMF8lmP+kqH5kZ4y3S9E
         7Ouw6gcE+j8QJ2fO46oCVNRRfBvsUymEVPEnqbh1NQ/41loJ3NaY5U92M/9I/7+MG3hb
         fmXWjYwyJgJBWNGcr5/kcAVJz3oWLXPOO2jd4n/RSShpZQ/I35U91WtYrOM6pcMslCft
         W4H1P4jsFZ5kY3EZqMvgzBI7yoSZ/lmPeQdqxtc3PvJwol+X+SfK/5L3sYyLrxbGSs2A
         +av0mGZRRyeX3Jq7lWYlpU5KUXN/BQrnNcYwj2fQo1cZkGPnsqXBwHDatr08DeFzMWmh
         seGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716548354; x=1717153154;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WQwqXnfXieAdfBpts/Rfm3B1N7XI2m8BMWVC3RyR8j4=;
        b=lT6J4n9nVRwcCCZzHkH1sFADfu8eMY2QRlH29HBR0PUru6yfMP/ADrVFX6UcBOBWIq
         nvD+TTPruGtKT9Ucoo/jZEDGEAmkXb1D946st5on9xhBFU//RmSiAdR8iaR1e8lCcMsh
         Bk1Z6Eq5vImOj8kJlW+sHhQjhqYibf8NlMuP1CwwIO0FSz8AixEwUxVOJ8mCYQcKt6MQ
         gioR8Qr3TCb4e1sGgRQtDwqwGB3A1bWCM8Pt+u4z54LW4rIcB6GcCYgmDelwCj9BTrLP
         9EG3bIwBgQZoy6gfvZxB/8eiv+vGgFyXQS/4vu5UP4MTILiWhM3OWDHfzi8efNjynKMA
         pd7w==
X-Forwarded-Encrypted: i=1; AJvYcCUJZSkcU+lvi65+4zS0wsohvwh5LMp6/F+8qMvaJ6B28LvxfY4gOMIPuM5J+weqm9Tn9ERVv5i+Nd8oEnqHsisJA+g3objOKhyiAuahG0YerhulV4PMZpftSSlHWcNwFNJ4iKoT9cwTgpa+yml6AKyHWJSDrmXCJq+mF659uer4yXfZGA==
X-Gm-Message-State: AOJu0Yw9qKC3kcS34VXEfFWJOGAPZXIaKySnuFna/ZkmHV11q1vdHmLI
	dVODtNb5uFgn7HLsTTERh/4YFSyWSOnChp/+61mLcIW7bkr3XXftLLyfiWuV
X-Google-Smtp-Source: AGHT+IGoLQGCTM5o0mF98oW16j07IdWwd3+Xwz0c4cZ2dmOFzl2hUFZC9qyYayeXxqk0EcIcT1VEIw==
X-Received: by 2002:a1c:7717:0:b0:420:2df0:1a9b with SMTP id 5b1f17b1804b1-421089ffaf2mr15236605e9.18.1716548353571;
        Fri, 24 May 2024 03:59:13 -0700 (PDT)
Received: from ?IPv6:2001:a61:35f9:9001:40df:88bb:5090:7ab6? ([2001:a61:35f9:9001:40df:88bb:5090:7ab6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4210896fc8asm17600465e9.13.2024.05.24.03.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 03:59:13 -0700 (PDT)
Message-ID: <7be63d9ed78848cb1ee43edae0d97720641daf44.camel@gmail.com>
Subject: Re: [PATCH v4 06/10] drivers: iio: imu: adis16475: generic
 computation for sample rate
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Ramona Gradinariu <ramona.bolboaca13@gmail.com>, 
	linux-kernel@vger.kernel.org, jic23@kernel.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, conor+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, robh@kernel.org, nuno.sa@analog.com
Date: Fri, 24 May 2024 12:59:12 +0200
In-Reply-To: <20240524090030.336427-7-ramona.bolboaca13@gmail.com>
References: <20240524090030.336427-1-ramona.bolboaca13@gmail.com>
	 <20240524090030.336427-7-ramona.bolboaca13@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 (3.52.1-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-05-24 at 12:00 +0300, Ramona Gradinariu wrote:
> Currently adis16475 supports a sample rate between 1900 and 2100 Hz.
> This patch changes the setting of sample rate from hardcoded values to
> a generic computation based on the internal clock frequency.
> This is a preparatory patch for adding support for adis1657x family
> devices which allow sample rates between 3900 and 4100 Hz.
>=20
> Signed-off-by: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
> ---

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

> no changes in v4
> =C2=A0drivers/iio/imu/adis16475.c | 39 +++++++++++++++++++++-------------=
---
> =C2=A01 file changed, 22 insertions(+), 17 deletions(-)
>=20
> diff --git a/drivers/iio/imu/adis16475.c b/drivers/iio/imu/adis16475.c
> index ab955efdad92..c589f214259b 100644
> --- a/drivers/iio/imu/adis16475.c
> +++ b/drivers/iio/imu/adis16475.c
> @@ -310,6 +310,9 @@ static int adis16475_set_freq(struct adis16475 *st, c=
onst u32
> freq)
> =C2=A0	u16 dec;
> =C2=A0	int ret;
> =C2=A0	u32 sample_rate =3D st->clk_freq;
> +	/* The optimal sample rate for the supported IMUs is between int_clk - =
100
> and int_clk + 100. */
> +	u32 max_sample_rate =3D=C2=A0 st->info->int_clk * 1000 + 100000;
> +	u32 min_sample_rate =3D=C2=A0 st->info->int_clk * 1000 - 100000;
>=20
> =C2=A0	if (!freq)
> =C2=A0		return -EINVAL;
> @@ -317,8 +320,9 @@ static int adis16475_set_freq(struct adis16475 *st, c=
onst u32
> freq)
> =C2=A0	adis_dev_lock(&st->adis);
> =C2=A0	/*
> =C2=A0	 * When using sync scaled mode, the input clock needs to be scaled=
 so that
> we have
> -	 * an IMU sample rate between (optimally) 1900 and 2100. After this, we
> can use the
> -	 * decimation filter to lower the sampling rate in order to get what th=
e
> user wants.
> +	 * an IMU sample rate between (optimally) int_clk - 100 and int_clk + 1=
00.
> +	 * After this, we can use the decimation filter to lower the sampling r=
ate
> in order
> +	 * to get what the user wants.
> =C2=A0	 * Optimally, the user sample rate is a multiple of both the IMU s=
ample
> rate and
> =C2=A0	 * the input clock. Hence, calculating the sync_scale dynamically =
gives us
> better
> =C2=A0	 * chances of achieving a perfect/integer value for DEC_RATE. The =
math
> here is:
> @@ -336,23 +340,24 @@ static int adis16475_set_freq(struct adis16475 *st,=
 const u32
> freq)
> =C2=A0		 * solution. In this case, we get the highest multiple of the
> input clock
> =C2=A0		 * lower than the IMU max sample rate.
> =C2=A0		 */
> -		if (scaled_rate > 2100000)
> -			scaled_rate =3D 2100000 / st->clk_freq * st->clk_freq;
> +		if (scaled_rate > max_sample_rate)
> +			scaled_rate =3D max_sample_rate / st->clk_freq * st-
> >clk_freq;
> =C2=A0		else
> -			scaled_rate =3D 2100000 / scaled_rate * scaled_rate;
> +			scaled_rate =3D max_sample_rate / scaled_rate * scaled_rate;
>=20
> =C2=A0		/*
> =C2=A0		 * This is not an hard requirement but it's not advised to run th=
e
> IMU
> -		 * with a sample rate lower than 1900Hz due to possible
> undersampling
> -		 * issues. However, there are users that might really want to take
> the risk.
> -		 * Hence, we provide a module parameter for them. If set, we allow
> sample
> -		 * rates lower than 1.9KHz. By default, we won't allow this and we
> just roundup
> -		 * the rate to the next multiple of the input clock bigger than
> 1.9KHz. This
> -		 * is done like this as in some cases (when DEC_RATE is 0) might
> give
> -		 * us the closest value to the one desired by the user...
> +		 * with a sample rate lower than internal clock frequency, due to
> possible
> +		 * undersampling issues. However, there are users that might
> really want
> +		 * to take the risk. Hence, we provide a module parameter for
> them. If set,
> +		 * we allow sample rates lower than internal clock frequency.
> +		 * By default, we won't allow this and we just roundup the rate to
> the next
> +		 *=C2=A0 multiple of the input clock. This is done like this as in som=
e
> cases
> +		 * (when DEC_RATE is 0) might give us the closest value to the one
> desired
> +		 * by the user...
> =C2=A0		 */
> -		if (scaled_rate < 1900000 && !low_rate_allow)
> -			scaled_rate =3D roundup(1900000, st->clk_freq);
> +		if (scaled_rate < min_sample_rate && !low_rate_allow)
> +			scaled_rate =3D roundup(min_sample_rate, st->clk_freq);
>=20
> =C2=A0		sync_scale =3D scaled_rate / st->clk_freq;
> =C2=A0		ret =3D __adis_write_reg_16(&st->adis, ADIS16475_REG_UP_SCALE,
> sync_scale);
> @@ -1359,6 +1364,7 @@ static int adis16475_config_sync_mode(struct adis16=
475 *st)
> =C2=A0	struct device *dev =3D &st->adis.spi->dev;
> =C2=A0	const struct adis16475_sync *sync;
> =C2=A0	u32 sync_mode;
> +	u16 max_sample_rate =3D st->info->int_clk + 100;
>=20
> =C2=A0	/* default to internal clk */
> =C2=A0	st->clk_freq =3D st->info->int_clk * 1000;
> @@ -1398,10 +1404,9 @@ static int adis16475_config_sync_mode(struct adis1=
6475 *st)
> =C2=A0			/*
> =C2=A0			 * In sync scaled mode, the IMU sample rate is the
> clk_freq * sync_scale.
> =C2=A0			 * Hence, default the IMU sample rate to the highest
> multiple of the input
> -			 * clock lower than the IMU max sample rate. The optimal
> range is
> -			 * 1900-2100 sps...
> +			 * clock lower than the IMU max sample rate.
> =C2=A0			 */
> -			up_scale =3D 2100 / st->clk_freq;
> +			up_scale =3D max_sample_rate / st->clk_freq;
>=20
> =C2=A0			ret =3D __adis_write_reg_16(&st->adis,
> =C2=A0						=C2=A0 ADIS16475_REG_UP_SCALE,
> --
> 2.34.1
>=20


