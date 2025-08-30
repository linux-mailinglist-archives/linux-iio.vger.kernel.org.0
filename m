Return-Path: <linux-iio+bounces-23432-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA9EB3C8DE
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 09:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EB5C5E8280
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 07:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 743A827D77B;
	Sat, 30 Aug 2025 07:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X76d7ux0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8C5277CB8;
	Sat, 30 Aug 2025 07:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756539800; cv=none; b=lVEPony13CUoUMBsfSeCTllPVZQ2vYp6Qm2fZ59FbhgVfdL5vhr1ZHnNghuRLNazCxxISQIzRl2TH7Ur6Rro4G9ryNEIlmI0228+dn4dzcu0jGuOk9EOybi3OwqI4siJlsW++MqdNDwxi/51bor1i5o84IPomSX6vb3fTj3QMos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756539800; c=relaxed/simple;
	bh=/GUcf1mnnRLd1XbhLCrasAZm5Jsw+M7OVdREvx4qwgs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YuC8PCuuTqJb3Kjd9+FWXzEFzV2jm3D7j9jWwkwchsPcjdFrD6ipXoDyTRRii2t848A9AGZSZ2IXoffAelpeWKhKh0DY4HvAgis0Z+ATAW9Kqtj168/PtsQLNwxq53lcqTAJDmMiYiXwg+uXDexo0D8TuZQ4ZSCwc5IJ9P4gU4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X76d7ux0; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-afcb7a16441so418741566b.2;
        Sat, 30 Aug 2025 00:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756539797; x=1757144597; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gURzqUmGeKrmX4dhppb9QlLLCg/dh2IS2zWou5cVXvQ=;
        b=X76d7ux06nU954FVrBm62GSW5P031d12wnSYX8xyceBKM9JhmvHjlMwhw9iECXlfxN
         cBPmzbdkhJj2gz4f3LLwlnQhKX1ugDmNnyqPNTgefUc2jzK3eMpEqOJABR44Pj4CIxXW
         7d3YDCJgMYM6Qjg0DuLR3uyMomO75iCmPywlPoqvBwXHiCE9PupoxH3QuMu8Bxnq6Z+C
         TYslIjOzXLnY4bHUK2O+oNfE7TPNTcuxuB7QmVa/b1ne59267n6llHHSU0BReI/UD9C2
         KpNj2ZZCzKExIHD7rDVrkuZhd6z1dpb7mPAt7qA9zyMF4oy81JTr5CjiIamveVdJGmnR
         UQ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756539797; x=1757144597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gURzqUmGeKrmX4dhppb9QlLLCg/dh2IS2zWou5cVXvQ=;
        b=CH/P8UhaMiVGhQvrqCp3/6EknGVWvFKmk2WnYz8dPgv0VgdCMt9K24ykx8NXPYoxIb
         C/Ezue2qCpnMk6kJMV1eCKHaMt1D7q4JJ7AzoNrWwxFIyj2OqjOM7ZKgh2Nc7L10DzEA
         8fnNIHFLFtGGXz8Op96uvAJKvDXgH5ScBnFLCrWzQ3c+aYTVnCtVG98jZPWVfL6ZBREC
         pFLDX9RpVOfqEYvVKfXp8Fdc5yJ1uUAGaMj3b9//C48xecCM2/M3RsjjW3yTfoNdU69e
         Kcqjc4AMJMBu3t87tGHqVOf1t0i+iTqfFomJm/XIkfgQ8OVLulpm2m5LrBOBx9p8HTGg
         +tBg==
X-Forwarded-Encrypted: i=1; AJvYcCUDcbDtNjOA7vu5AeJlqR1ttbGzet+kDKYvmDUCQ1o2FJXeFGaxqqZByy27ZglRmU2vHZ00yuQSUid3@vger.kernel.org, AJvYcCV4PPQ3ESM5cxV3LTkrB1400raNOtdE6kafge6mDE8Ncp9WDF8kBYhv8CSLMLQaVxLT/o+uuw+tAcwz@vger.kernel.org, AJvYcCWccT+WdpBBLEdoILCkRsKmEw/bz5nCdfaN5uu1uR2SpAw4ZCskA533YkgZMKMhXoGgMpcuTV1yLYnu@vger.kernel.org, AJvYcCXq2GHh4httP7OK4xlIJpLYuHcmFDk723m77zwq6gd0ihq4LZmp7B54mceg8z9BwOe9IfG7T/LUPWCbI/kC@vger.kernel.org
X-Gm-Message-State: AOJu0YxiG+9PWvFE2eK6bkITjvroYWp69COEu+/nRWsIWx1FWpF4KjDr
	IfY6CrBQ97J2xEiOrTTup8F9VOlNZEWVEqHOWiu3k6bgziJneZc2kjeKtYV/bqPdkO0MSSY0Zy1
	6S5S4cmukP5u224bFGL4cqrQ+vi3jWF4=
X-Gm-Gg: ASbGnctMi1mTW5FdY9vvzCJcdaGBgYWDt1uP4toiVpgHm/vR9doQyqf/98HzmkvgIEc
	5AccdhrUOHMPt3I+JFWwjhdFx7VioU7XWAKvTIunKgMdCKDj1TI47+clPHsaYviSGIr3uVtih++
	9Cr1j0XU8lxo8axPOWsW9Qw/RFJJSfnOpO4qkJFRUuzdz8QHYXOMvvCCPOlGWj4+rugbOBIuf8L
	nREVhWeR3Hf2+9z2A==
X-Google-Smtp-Source: AGHT+IEY2oLBKT6+HGAYixezZFibnn/igblSvV5V+/2cx5/ECPFYwYJW3hDUtnlycz99C1cnWWFo/bl1TA1+WzOwDLA=
X-Received: by 2002:a17:907:1c87:b0:aff:40f:491f with SMTP id
 a640c23a62f3a-b01f20ccc95mr122341566b.64.1756539796809; Sat, 30 Aug 2025
 00:43:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1756511030.git.marcelo.schmitt@analog.com> <344c3797fe8e5aa9177ef8c0633d1eedd32563fa.1756511030.git.marcelo.schmitt@analog.com>
In-Reply-To: <344c3797fe8e5aa9177ef8c0633d1eedd32563fa.1756511030.git.marcelo.schmitt@analog.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 30 Aug 2025 10:42:40 +0300
X-Gm-Features: Ac12FXysrcFjcTtPyekcpdB2bENednecYuAPaeyAdDUgvgGErGBxwhYuAYYiOrw
Message-ID: <CAHp75VeTqm+aAt47rSRznpZe5=wd_X24ZtvjXJNj=b3HGu5Sxw@mail.gmail.com>
Subject: Re: [PATCH 11/15] iio: adc: ad4030: Add clock mode option parse and setup
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-spi@vger.kernel.org, jic23@kernel.org, Michael.Hennerich@analog.com, 
	nuno.sa@analog.com, eblanc@baylibre.com, dlechner@baylibre.com, 
	andy@kernel.org, corbet@lwn.net, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, broonie@kernel.org, Jonathan.Cameron@huawei.com, 
	andriy.shevchenko@linux.intel.com, ahaslam@baylibre.com, 
	sergiu.cuciurean@analog.com, marcelo.schmitt1@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 30, 2025 at 3:44=E2=80=AFAM Marcelo Schmitt
<marcelo.schmitt@analog.com> wrote:
>
> AD4030 series of ADCs support three different options for the clock that
> frames data output. Since each clock option implies a different hardware
> setup, the clock mode to use is specified in firmware. Read the designate=
d
> clock option from firmware and configure the device to work accordingly.

...

> +       ret =3D device_property_match_property_string(dev, "adi,clock-mod=
e",
> +                                                   ad4030_clock_mode_str=
,
> +                                                   ARRAY_SIZE(ad4030_clo=
ck_mode_str));
> +       /* Default to SPI clock mode. */
> +       reg_modes |=3D FIELD_PREP(AD4030_REG_MODES_MASK_CLOCK_MODE,
> +                               ret >=3D 0 ? ret : AD4030_SPI_CLOCK_MODE)=
;

FIELD_MODIFY() ?

Also, I would rather put it as proper if

if (ret >=3D 0)
  FIELD_MODIFY(...)
else
  FIELD_MODIFY(...)

> +

I would not add this blank line as these are coupled.

>         ret =3D regmap_write(st->regmap, AD4030_REG_MODES, reg_modes);
>         if (ret)
>                 return ret;

--=20
With Best Regards,
Andy Shevchenko

