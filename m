Return-Path: <linux-iio+bounces-3177-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D607786B89E
	for <lists+linux-iio@lfdr.de>; Wed, 28 Feb 2024 20:52:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 918FE284F02
	for <lists+linux-iio@lfdr.de>; Wed, 28 Feb 2024 19:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5082A5E08E;
	Wed, 28 Feb 2024 19:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="FvhdjVb3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588A55E07F
	for <linux-iio@vger.kernel.org>; Wed, 28 Feb 2024 19:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709149937; cv=none; b=hEPjZlzReh2Y2ymq70er7CeAq6RQO+EHBP/ml/auiLKQgcWKpjlfUgJcID2lxlTW4SboscvPNQw5YLMcvKA55FzqwxBVhHDdOZhO6icRTrOpUSFn9MQH+fifOaaX4zqfHlcHwZm9D0I6XOjBt/sIPUHsqdsWeeJhEiVyCR0pZWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709149937; c=relaxed/simple;
	bh=PRdP2j04kxlBLPjXcsnuNmfbodBD9MgXPDZDAAM0Z+w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=opP+l/AFQjrK+aNimdY9nzLbzJWMoODWK+2AK63ayHI/H8ID2sfhdJwIcjSlXdnFP5zwCJuc4Sn7kFWaHQg7PvrrbHW84rT4HO/CDukIhJx9Bi/lP2IebgAYN9I/Emwc5uqmOpIJAaw1TzQ90Q1HZUG8GUBBE5j6v1Kx8vzENyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=FvhdjVb3; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d180d6bd32so1173241fa.1
        for <linux-iio@vger.kernel.org>; Wed, 28 Feb 2024 11:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1709149932; x=1709754732; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BMIx8saBxEDCNVvunMWep/UC7uGA5dpb1FEvqu7GpNY=;
        b=FvhdjVb3L9Gv+hSerTeQe4sm6Fax/LzdgjqzSIhJ3UijUWEvmKY1TIqqYu6t5VE/fa
         DV6BWyJUB/kZl8uWZPQnvfge8ZyKMS1swtv1+1lwwKKVBkb5oXFxIBRwPX3Lga3rON+x
         IkfbFrY/YxXoM6aKlxDgxc8J6ARA0fiqWULFHPHwqKw0irIZLM8p5eWSzndmU0TvoM/e
         j/cR4mcRNsitvCMV48+PYthYv2BRZMpq4fuF13ltTckw6YrAEHj8CH2khYpVzgfB1/k2
         jnSlMVDFFE++Yl9Bpqg4GpXBRlalvYM8OUlLbXGsWlsFBEq6hUbs/RaqY6Uk8JvoT5tT
         kNng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709149932; x=1709754732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BMIx8saBxEDCNVvunMWep/UC7uGA5dpb1FEvqu7GpNY=;
        b=b4sF0JlmGQ87ATWhgsunRjt/k2KLjJB547MjkcvmduaqMZyDcIGrhOpO3BirSfe8xS
         ++tfQbIJA5MBfFiKh3+pEILdcNDgsAGTlHu2Fw0gCHGt4EoiPFXNgIqFKQhxkgdUUzx0
         rze+ed0aJLYVLL7Qh+wLtr61QlM4hP88tYqxwhXg6jKSqiE59IwmK1mEiRs4UsHHlmyi
         hZQUV1DKo0S4JVvJ8F+a5hCVxCo75msy+7f6wik0ibQ4jpmDe11/O2Na1ttmRxglV9hc
         tWmKukGEXHlc8+HzcTF13GhbUFGrBHWcI2Xsul8VHcP10aoxEJOcfEBHhrX+zD3Ze5Td
         GJhw==
X-Forwarded-Encrypted: i=1; AJvYcCWY/dvkKOI3qFbuzg73yu6FfdXQNSaXnYON81YV8TptivqrENzWKw8SJdA0r7Mn8X4XhU7En7Jz3A6WTN7kQvzVwnEARpy2Ry0R
X-Gm-Message-State: AOJu0YxUgWhuFmvGHEDw1L7uoK6UMQoeyhGFoUkmDS+639qOCM5T+Hoo
	Y9lINvK4bD5wTYky1R9+kr+4W0S09guUQwt1EmdfKHlfDX/8nHjDVUu4lp7TJsb+kTzAKOdqC3i
	ep0T3QoY7Hqc2lr1MWS8w7RyIz4hjYjUCoBibEw==
X-Google-Smtp-Source: AGHT+IEeqc2DJL8bDtNuCdiE0hcB+g4u5E7DX7tnm+IIvm6tYVJh272iDAXQ62pVabMCSml+sylR0HxW4kAIFO/RVxo=
X-Received: by 2002:a2e:b8c3:0:b0:2d2:38b6:661b with SMTP id
 s3-20020a2eb8c3000000b002d238b6661bmr11809905ljp.33.1709149932500; Wed, 28
 Feb 2024 11:52:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228122617.185814-1-alisa.roman@analog.com> <20240228122617.185814-5-alisa.roman@analog.com>
In-Reply-To: <20240228122617.185814-5-alisa.roman@analog.com>
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 28 Feb 2024 13:52:01 -0600
Message-ID: <CAMknhBESDhM2m=LqPH6XNGeDe+AwZ-38f+_Mja0xdSv5pXOoJQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] iio: adc: ad7192: Add AD7194 support
To: Alisa-Dariana Roman <alisadariana@gmail.com>
Cc: michael.hennerich@analog.com, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, lars@metafoo.de, 
	jic23@kernel.org, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	conor+dt@kernel.org, andriy.shevchenko@linux.intel.com, nuno.sa@analog.com, 
	alisa.roman@analog.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 6:26=E2=80=AFAM Alisa-Dariana Roman
<alisadariana@gmail.com> wrote:
>

...

> @@ -1012,6 +1052,73 @@ static const struct iio_chan_spec ad7193_channels[=
] =3D {
>         IIO_CHAN_SOFT_TIMESTAMP(14),
>  };
>
> +static struct iio_chan_spec ad7194_channels[] =3D {
> +       AD7193_DIFF_CHANNEL(0, 1, 0, AD7194_CH_AIN1),
> +       AD7193_DIFF_CHANNEL(1, 2, 0, AD7194_CH_AIN2),
> +       AD7193_DIFF_CHANNEL(2, 3, 0, AD7194_CH_AIN3),
> +       AD7193_DIFF_CHANNEL(3, 4, 0, AD7194_CH_AIN4),
> +       AD7193_DIFF_CHANNEL(4, 5, 0, AD7194_CH_AIN5),
> +       AD7193_DIFF_CHANNEL(5, 6, 0, AD7194_CH_AIN6),
> +       AD7193_DIFF_CHANNEL(6, 7, 0, AD7194_CH_AIN7),
> +       AD7193_DIFF_CHANNEL(7, 8, 0, AD7194_CH_AIN8),
> +       AD7193_DIFF_CHANNEL(8, 9, 0, AD7194_CH_AIN9),
> +       AD7193_DIFF_CHANNEL(9, 10, 0, AD7194_CH_AIN10),
> +       AD7193_DIFF_CHANNEL(10, 11, 0, AD7194_CH_AIN11),
> +       AD7193_DIFF_CHANNEL(11, 12, 0, AD7194_CH_AIN12),
> +       AD7193_DIFF_CHANNEL(12, 13, 0, AD7194_CH_AIN13),
> +       AD7193_DIFF_CHANNEL(13, 14, 0, AD7194_CH_AIN14),
> +       AD7193_DIFF_CHANNEL(14, 15, 0, AD7194_CH_AIN15),
> +       AD7193_DIFF_CHANNEL(15, 16, 0, AD7194_CH_AIN16),
> +       AD719x_TEMP_CHANNEL(16, AD7194_CH_TEMP),
> +       IIO_CHAN_SOFT_TIMESTAMP(17),
> +};

Based on the discussion on the v3 patch I was expecting this to be
fully dynamic rather than having a fixed number of channels since
there are so many possible combinations and the fact that
pseudo-differential channels should be using AD7193_CHANNEL() rather
than AD7193_DIFF_CHANNEL().

> +
> +static int ad7192_parse_channel(struct fwnode_handle *child)
> +{
> +       u32 reg, ain[2];
> +       int ret;
> +
> +       ret =3D fwnode_property_read_u32(child, "reg", &reg);
> +       if (ret)
> +               return ret;
> +
> +       if (!in_range(reg, AD7194_CH_DIFF_START, AD7194_CH_DIFF_NR))
> +               return -EINVAL;
> +
> +       ret =3D fwnode_property_read_u32_array(child, "diff-channels", ai=
n,
> +                                            ARRAY_SIZE(ain));
> +       if (ret)
> +               return ret;
> +
> +       if (!in_range(ain[0], AD7194_CH_AIN0_START, AD7194_CH_AIN0_NR) ||
> +           !in_range(ain[1], AD7194_CH_AIN1_START, AD7194_CH_AIN1_NR))
> +               return -EINVAL;
> +
> +       reg--;
> +       ad7194_channels[reg].channel =3D ain[0];
> +       ad7194_channels[reg].channel2 =3D ain[1];

Needs to set ad7194_channels[reg].differential =3D ain[1] !=3D 0.

> +       ad7194_channels[reg].address =3D AD7194_CH_DIFF(ain[0], ain[1]);
> +
> +       return 0;
> +}
> +

