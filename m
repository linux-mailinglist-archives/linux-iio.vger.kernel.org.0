Return-Path: <linux-iio+bounces-12516-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 847F49D6489
	for <lists+linux-iio@lfdr.de>; Fri, 22 Nov 2024 20:22:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A116281ADE
	for <lists+linux-iio@lfdr.de>; Fri, 22 Nov 2024 19:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E8F1DF24D;
	Fri, 22 Nov 2024 19:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QVyUzqkE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86DA64A8F;
	Fri, 22 Nov 2024 19:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732303329; cv=none; b=ZUSoSERIsHCZFG88KMgrG8ooZinFIRuiW4qJJPOlVJDAYBkMMpd5l09uJvfurdOTfHRbN/zk0CIH1bJLIRi5TnsdxdkudPvxUm370HBw8pOK6swFg7yD2p4tJMGgBwoOspBWYZ2d/mAv1MDrH+mcvvd1High80z+uCFR/hDv+O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732303329; c=relaxed/simple;
	bh=C/7BTv6rS81MdecBY7aqMXyw80A0kORais1KOM8G0PQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g4gQ0oBdbytFOhBUJ/XSfD137y2ZA9XsZ64w13EI7wNsKjwO7T9NVm5uhfPWSuhkqo9oglUI3dyLJv4rfjeliD8ehIJOwxjakWXXv/uukg+1Mwp6jVOhzljg0ctr1mkdmg8O0LICZWAdOPkC1+Leiq5smmj94fALinR/z82Fe4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QVyUzqkE; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-53da353eb2eso4264779e87.3;
        Fri, 22 Nov 2024 11:22:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732303326; x=1732908126; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MnMdI/o12MiHxPUZ0FBSwd/17EDwf71M1mCtNry1PU8=;
        b=QVyUzqkELhWg3MoDglcWZ9a9ZymXHQgClkoKsjKis94ih6S56KOIYttNs3TNXyS7xz
         F5KFkh5VEBgJTGTuHaiTN9zMC/+WLTtvCIbOGmKH6ZPnevKYe5qHUk9oThX/iXFdfhYO
         F3mPww3RCalLuCKbrHSKvLJyaM5dZDgvZTR9/8gS9OGVRou8Rx3nWpljaHbsCWR/TE+6
         TjYqEoBrBg4LYybU56Nmxa5OS3WRydeY4vxDQbHZLzL5oPm2XdLRVWNxZO2YmwsBNp8G
         CD8HB0JJjizw9PgqbvvECmNh+eDsu/7V33Z6Kn9Dwmf33nSZ7WhT31CblPhgE3OFkHVo
         BVEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732303326; x=1732908126;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MnMdI/o12MiHxPUZ0FBSwd/17EDwf71M1mCtNry1PU8=;
        b=t/ugjLa8R/L1qjQn8fi9t74nHlL2Q4HWo8o9uFHCTQIkXPZbRyB2/dTu0E03vwvdeE
         rHhtaG4d55237SDP3gKZE6n3pomaqVAdXUqV2wixxvG3Pm+tEkrXaTK4Se6sj64lossK
         odJXtX5AhhfCt3nCNz4SalL9oTtvSYycQ0qTnpV+2u+GNDoT1MhTLlYRe2iXl4cqbfdH
         Mr9jqNIWYBu7IrmPkbD4UOz7EbbUdokAzVkER08x49laASdoqr3RGASttn0vsqfqt010
         jmwq4b7gALZyizDUiqJ10NM2dzgCtNyON+v3tOFLiWmu4eNEktmbP5rbwebq7+1uE3C0
         l8mw==
X-Forwarded-Encrypted: i=1; AJvYcCVwX8wjZIIDouEtM7GVIi6pIsbbozeppW2P6gRkvq/OmyHC2twEoJuUhDuXKuxmEGPJux3K4Q3BxaLe@vger.kernel.org, AJvYcCWZWDValb4gfASvhY3Qtnge0XIxWwYGwOlaLSeTZOwOmYoPN21012ZnSvHunNXsaqFIpAlLbkE4OP0H@vger.kernel.org
X-Gm-Message-State: AOJu0YxUifdlhxf+yX6umBYsJpTf+LLYC2oFxXGw7qav2sHc8bWv4euh
	2G5YW6IFvsYJ7GF1Wu9RCL79qe1o16NWc1hMjRaRYZmC+z+rk4Y6wRwTcWo6hZwGC/Y9v066h0h
	IFw/y2u7u7Szvda1DbmTpELXsCrc=
X-Gm-Gg: ASbGnctOUeHZd0PETYxVfYhDwzSDLstbTpd851EbKWaXhffFPtMtdAamsWq+GXwwv8D
	VbL6aKTtjwsG8DnD53+z+doGEz1PaIdk=
X-Google-Smtp-Source: AGHT+IHvRbpGmFfp3zz3bE9+EGCw+FzjrQP4g9kfZ+8R47hxgVOY1KSrLEttboGpl5SizgKh2wKRPORFXSLKJ2zox5Q=
X-Received: by 2002:a05:6512:230b:b0:539:f10b:ff97 with SMTP id
 2adb3069b0e04-53dd39b4c39mr3240832e87.49.1732303325675; Fri, 22 Nov 2024
 11:22:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241122113322.242875-12-u.kleine-koenig@baylibre.com> <20241122113322.242875-18-u.kleine-koenig@baylibre.com>
In-Reply-To: <20241122113322.242875-18-u.kleine-koenig@baylibre.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 22 Nov 2024 21:21:29 +0200
Message-ID: <CAHp75VfCV28o_69VB3EXQZJks34Z7er0v2q4=qPp2=KjWVo7Sw@mail.gmail.com>
Subject: Re: [PATCH v3 06/10] iio: adc: ad_sigma_delta: Fix a race condition
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Alexandru Ardelean <aardelean@baylibre.com>, 
	Alisa-Dariana Roman <alisa.roman@analog.com>, Conor Dooley <conor+dt@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Dumitru Ceclan <dumitru.ceclan@analog.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>, Rob Herring <robh@kernel.org>, 
	devicetree@vger.kernel.org, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 22, 2024 at 1:34=E2=80=AFPM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@baylibre.com> wrote:
>
> The ad_sigma_delta driver helper uses irq_disable_nosync(). With that
> one it is possible that the irq handler still runs after the
> irq_disable_nosync() function call returns. Also to properly synchronize
> irq disabling in the different threads proper locking is needed and
> because it's unclear if the irq handler's irq_disable_nosync() call
> comes first or the one in the enabler's error path, all code locations
> that disable the irq must check for .irq_dis first to ensure there is
> exactly one disable per enable.

"...exactly one disable call per one enable call."

> So add a spinlock to the struct ad_sigma_delta and use it to synchronize
> irq enabling and disabling. Also only act in the irq handler if the irq
> is still enabled.

...

> +static bool ad_sd_disable_irq(struct ad_sigma_delta *sigma_delta)
> +{
> +       guard(spinlock_irqsave)(&sigma_delta->irq_lock);
> +
> +       if (!sigma_delta->irq_dis) {

Why not positive conditional?

  if (->irq_dis)
    return false;
  ...
  return true;

> +               sigma_delta->irq_dis =3D true;
> +               disable_irq_nosync(sigma_delta->irq_line);
> +               return true;
> +       } else {
> +               return false;
> +       }
> +}

...

>  /* private: */

Consider at some point marking the below members with __private.

>         struct completion       completion;
> +       spinlock_t              irq_lock; /* protects .irq_dis and irq en=
/disable state */
>         bool                    irq_dis;

--=20
With Best Regards,
Andy Shevchenko

