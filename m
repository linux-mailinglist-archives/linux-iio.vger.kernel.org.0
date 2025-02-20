Return-Path: <linux-iio+bounces-15824-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 35189A3D303
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 09:22:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD50C7A40EB
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 08:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50BE01EB191;
	Thu, 20 Feb 2025 08:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bDyeySPp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5275B1E991B;
	Thu, 20 Feb 2025 08:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740039718; cv=none; b=q4g4pz5TsS9yyUF4s5ZnxUOplU3GJuwf9DRZrthFIvY2STc+/zB7c8/Zm5dFamAn1rsNJWjOUCZv3hs5gkW5UgNYyUuQoGAEQUwxivKxhfixw4Y4vhIDkkcwtO6QTWSgSEyb5kxsL6nph1No6hyblOhbKeUggFSvtzXGfutyeyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740039718; c=relaxed/simple;
	bh=SsMajwfrGg3VJCJ6ZPr26vGAegzi7N89NtDYAbZx0IQ=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Bb9DV5xBTMco6lgTwjpgvKYdCBS2c6JoCTryNmHGBDJhjQd6CyhAvK3GRTQuTV1v0q5OScAKy0iYhNVuTWAHIrnO61QcJBginluqYXmFBVAG2/yQwm/EmaR5xom1nARKQlJUr1ngxAW7dw4eCSNk7wPS68pBwmja/2Lx+aHbWuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bDyeySPp; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5dedd4782c6so1205033a12.3;
        Thu, 20 Feb 2025 00:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740039714; x=1740644514; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lrrXspfQLmbYxP8R0lXUq4D1w3aPsGzOwm5WY8qSB74=;
        b=bDyeySPpQHyrwePeh501nuDlvBWXE5ikP8VzZ0jHxqrUcxWSOVe6dS0BCPwI6bQO6K
         vtBx3Pwv5mYpRXJEIczA0fVlBuWqJIR4j5qPQJ58KZ0kWJI+cguj5KNB5m580WGJva3E
         mF79L7Yg7a4GmMWBrC8coyKP3BQiviO8FJFUgWkNusUHPjDUg9+EyDD8belC4Uhz6AAm
         BdpBZ/exrl8qRkY+b99VT+LJtodbxcj4VFeLakkKnTvbDZ2c6pjEL5BAiZRRkQwMNrxU
         L9KXuypjD2WgwH7MiLsUbJbJdAtYTPhuo3Pfxiax08bVUM9pvNgawKt6J0pHUvfPymcv
         669Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740039714; x=1740644514;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lrrXspfQLmbYxP8R0lXUq4D1w3aPsGzOwm5WY8qSB74=;
        b=neDOWuYJAsp9JfkKEany5igUFWK2zUVVEyGIOsNdid3c1Tup8RvFs6yctcQXM7OmIb
         ojJTisU8/4uWYFlkPovxR/z0HBsM+/kzkt+E6itn0DfFyGVVjV4Wl7O3mXT5loX+LoD4
         fY0oRz0RJu6BwV5VOwej8zWGCCeXkT0c8bia0RJpiJntKyNI9BNiwf0WpyVaGZydmHB8
         YoDVRlOidkSEv8Wvl6UKzG/2Y3KiR5oqaL9+FY/2VAM/ndwoMlR9x02ZnBBCqp03GtRy
         LyCPuTIGdg/U3JJKL2+NV/lxRY8nij1I3DpFhXhvSOBo0L2Hcr5Wsq3N5pjzJoYyCOiE
         iuJA==
X-Forwarded-Encrypted: i=1; AJvYcCUTgqQ66o4sDg4T0tE0cToDsnzjo7bg0YsyAuCtZg13rdo3wlnLeqACLAeL57IS2MkvNSYf63Yi+zLdmXFH@vger.kernel.org, AJvYcCV1teXEXV3JldVxMhCwQw4VPS/4NmbKN9CXgt88VIAfaGrBqFmAX1oPRe8g8W13awtJXz8ZX0I5XOpE@vger.kernel.org, AJvYcCVPVUvmsGmhSJ70yimvaLiKE4JrRmIovYJHZGOCCDdZIkh9N++DE6FIQs7+dYQC+NwHxafC4LRH1ZFM@vger.kernel.org, AJvYcCWKbGyBHQcOV+TEnyHogWmQ37k4Pi8QYuX8Xc9DkWFGtY6GZaqy5qkqSqFaKMqyXf6bCldRz+p8r88a@vger.kernel.org
X-Gm-Message-State: AOJu0YwGsLfRYTkkk6F6HCzYTmj9rjPKHlH8D82Bwn+6ScB6pZLxVmsV
	u22EUOkq7Dby0TSWI9AgqRoeSjdHSg0467F/nybSa3IpmOoGkbhl
X-Gm-Gg: ASbGncsYaBSJ7hWNAdtZzhEKiLG1iUE+y2khdLaQQLw5PsSpwCGLV18cwqrugZXyrGu
	DxvQkrgT+qQlJoua5vvCqKZsGa0LPiy9ING9cQvGSAqIJPZYoWL7tQphhRDhmyx7l6Yzi0QX+eP
	j9cnIpJbGYSnE3D8qsgrAKDZerRuTK2a1RqODDOP7rOIfisUiGABG8Pz6M/b50TpRi9zBq1dRV1
	u6UsBSY/v4HhZ2xkcppGfUibB71SFF+dQqNHJxGZK/hkmPFybFr88zP1y0Jr+TTKiqA+Lv2/gVu
	8byCNdsDToZyG7LMXzOSBviTjp/BtBYdKMnKpdGBIit0+vKTZRYd4t2eSa4dVzU=
X-Google-Smtp-Source: AGHT+IFnAgs7LaeLetE3gQxqyKpSoHEV10DFP+3zBkEqkOfu+rvETWAhEz7oKNTkMmV3JRW0/TNHwA==
X-Received: by 2002:a05:6402:278a:b0:5db:f26d:fff8 with SMTP id 4fb4d7f45d1cf-5e0361cbe0amr19369313a12.22.1740039714170;
        Thu, 20 Feb 2025 00:21:54 -0800 (PST)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece2721d9sm11937261a12.56.2025.02.20.00.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 00:21:53 -0800 (PST)
Message-ID: <aee93ef96e71adf70a48ee5877bd75966d9c78c1.camel@gmail.com>
Subject: Re: [RESEND PATCH v8 5/6] iio: imu: adis16550: add adis16550 support
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Robert Budai <robert.budai@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>,  Michael Hennerich <Michael.Hennerich@analog.com>, Nuno
 Sa <nuno.sa@analog.com>, Ramona Gradinariu	 <ramona.gradinariu@analog.com>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>,  Jonathan Cameron	
 <jic23@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski	
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet	
 <corbet@lwn.net>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Date: Thu, 20 Feb 2025 08:21:56 +0000
In-Reply-To: <20250217105753.605465-6-robert.budai@analog.com>
References: <20250217105753.605465-1-robert.budai@analog.com>
	 <20250217105753.605465-6-robert.budai@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-02-17 at 12:57 +0200, Robert Budai wrote:
> The ADIS16550 is a complete inertial system that includes a triaxis
> gyroscope and a triaxis accelerometer. Each inertial sensor in the
> ADIS16550 combines industry leading MEMS only technology with signal
> conditioning that optimizes dynamic performance. The factory calibration
> characterizes each sensor for sensitivity, bias, and alignment. As a
> result, each sensor has its own dynamic compensation formulas that
> provide accurate sensor measurements.
>=20
> Co-developed-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
> Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
> Co-developed-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> Signed-off-by: Robert Budai <robert.budai@analog.com>
> ---
>=20

I guess it would make sense a Co-developed-by: for Robert?

Anyways, all looks good except for one thing that I just spotted...

> v8:
> - removed __aligned from struct adis16550, as suggested
> - crc buffer extraction into the crc check function
> - passed buffer into crc validation as original, __be32 and performed che=
ck
> using be32_to_cpu conversion of the buffer
> - added trailing comma to line 993
> - removed trailing comma from line 877
>=20
> =C2=A0drivers/iio/imu/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 13 +
> =C2=A0drivers/iio/imu/Makefile=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 1 +
> =C2=A0drivers/iio/imu/adis16550.c | 1149 ++++++++++++++++++++++++++++++++=
+++
> =C2=A03 files changed, 1163 insertions(+)
> =C2=A0create mode 100644 drivers/iio/imu/adis16550.c
>=20

...

>=20
> +static int adis16550_set_freq_hz(struct adis16550 *st, u32 freq_hz)
> +{
> +	u16 dec;
> +	int ret;
> +	u32 sample_rate =3D st->clk_freq_hz;
> +	/*
> +	 * The optimal sample rate for the supported IMUs is between
> +	 * int_clk - 1000 and int_clk + 500.
> +	 */
> +	u32 max_sample_rate =3D st->info->int_clk * 1000 + 500000;
> +	u32 min_sample_rate =3D st->info->int_clk * 1000 - 1000000;
> +
> +	if (!freq_hz)
> +		return -EINVAL;
> +
> +	adis_dev_auto_lock(&st->adis);
> +
> +	if (st->sync_mode =3D=3D ADIS16550_SYNC_MODE_SCALED) {
> +		unsigned long scaled_rate =3D lcm(st->clk_freq_hz, freq_hz);
> +		int sync_scale;
> +
> +		if (scaled_rate > max_sample_rate)
> +			scaled_rate =3D max_sample_rate / st->clk_freq_hz * st-
> >clk_freq_hz;
> +		else
> +			scaled_rate =3D max_sample_rate / scaled_rate *
> scaled_rate;
> +
> +		if (scaled_rate < min_sample_rate)
> +			scaled_rate =3D roundup(min_sample_rate, st-
> >clk_freq_hz);
> +

I would imagine the above is the same deal as in other devices [1] or do yo=
u
know for a fact this one is different? Maybe it's simple enough for Jonatha=
n to
tweak while applying...

[1]: https://elixir.bootlin.com/linux/v6.13.3/source/drivers/iio/imu/adis16=
475.c#L364

- Nuno S=C3=A1


