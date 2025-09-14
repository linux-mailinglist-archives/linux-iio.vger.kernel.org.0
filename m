Return-Path: <linux-iio+bounces-24089-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D856B5684B
	for <lists+linux-iio@lfdr.de>; Sun, 14 Sep 2025 14:06:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A3543A7F8D
	for <lists+linux-iio@lfdr.de>; Sun, 14 Sep 2025 12:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDAA02580ED;
	Sun, 14 Sep 2025 12:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dl5FykkL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178171DFCB
	for <linux-iio@vger.kernel.org>; Sun, 14 Sep 2025 12:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757851586; cv=none; b=NnRrsH76WB4Gd/ZdxihRXDu/1n4dynsyT+d+6LznUfrriDCm4rIh9f5GnGJzbnGcnAD3wMSWbSiDcZnj1xBBxwADxhc5tFQhE2agmodRUt7OnhVAZ/B9ca+jgtcwGkYxLxEk1koskJU2vN3rsAQa2QMXJN6GqxkC+v/bcXYOL/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757851586; c=relaxed/simple;
	bh=U4ZwaARrhVJRhKGwMnmqzVABRhfraMrOEXvy3azq4WA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jkcs6uHhw0bI6prC+w3swUKzcVLaFCRD5gqi6iuXvZf1BBcbX1uACeUP7Oxqz/raP0mSlMtx9VLj3J50kaQJ0xch2r0yh9AwCSpsrtbOkFbC/IpMA+XZ3vuENNHVqFHsnihSQW8FfcqDYol7+EjKvuAfn5tCcmjtob2yra25UO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dl5FykkL; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-62f24b7be4fso1010415a12.0
        for <linux-iio@vger.kernel.org>; Sun, 14 Sep 2025 05:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757851583; x=1758456383; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0YLyZ8HqzpH0evIE3A2q6klrMOvuxtmz4l/kw0/w76g=;
        b=Dl5FykkLJH4NA3wlST1FaYCIX2DuJIs10rYIF+vF+Zc9NMXoF1dAtHwrA1LW6iD8gi
         8Jid2/J3U5fMY8DQ9HfG5pyQX2+fAvNLkcROkOMd/bi2UxJhzGSaaoXbLF9CMNFF8bEv
         VrcANhtHsfh2+yC/QNNkSTpj5864YNdP9LbL93klV5faEXB2m+21Vgvfjx2B30zdaQlk
         McyW+N+vtQMgaLCPPZilbFngop/f/eezWhyXU1lY8VUBpNA3hHuzIFbUBE3sAdBH429X
         flqZ98dJ+zOZ+FiBv0Vq0oEp8nHa1BtBpIUyyhBzOxFO3hOkAL7ENvlr0V9lhZsqWxMh
         lMAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757851583; x=1758456383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0YLyZ8HqzpH0evIE3A2q6klrMOvuxtmz4l/kw0/w76g=;
        b=N/2cfFZiZoeB6b77JAQngOmfl4/mIE2B3VQv41ntGPSZXoD96J2XWUz4lks0TuM7s7
         I0ubpD6QtoSUqUH/67Top1hgIhjJRHVUvAmyNNW5DuLW6O2mGjqGscl9AC8NubbBSU88
         Os3IgebkEijH0z61wzLPQScG4P+hKh4vULFy8sZpaMAJ3znYLuvhikAE9LdPofORSbwL
         sLfTf6JeWcbZK0kulZy4xVB4WNMi1qaXIGN7oV8K3LYTvS5kztEseA86ssC+JzPeouyK
         3r5gjzXTzwdtjmYnUlBsWHi8Kb6HswD4jEdvWW2BnjWTqyKx+SWsL4A2GJTbdvurN7od
         wuHg==
X-Forwarded-Encrypted: i=1; AJvYcCUP2lmllhZMiLq59F6yriq+h9rkfRrYihXe+VS8z4tkKalJ51ePvtb9nBZ+Rs0vE6hmdJjpglmvNno=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJMTbvMPdv5rLaqPFIP3ktD7JZ2sCS9AcJwucdXRkEDfDxfcsj
	YzBKrt1AGND3dSs2t5OcJLJ5VcLxHkUp5nsGrbYLz/Oe983impwdqJZUAfdyek091NLTE4NHPuR
	zPumh+IlORy7d1pa8//toVclirWCjBSg=
X-Gm-Gg: ASbGncv1CV1jD9gogwrdupm7b2gqNvU331cKTTtsFalAKi1uN1vq9Fps0v3Jg7aj+Vw
	9St2ZkRgjTWJqgv8Z+wHBUsklai5RucyOVEeoAaXR0MhFZo3jEErFsREERc/R+8b1IGNZ7VCYzj
	XyVWtIdPriN3Y31Wvk5RuoZp9IaRB985askhOmVpSw2lQwmbLS/nCdnp19VHFu9VBBdPkFsDDSn
	voz3do2Hu1kkE/Efw==
X-Google-Smtp-Source: AGHT+IE00u9Vz/nbU03onsaPBDXPOf9Sej8zP0eI2NU1Y77NBz90d/AzKuwkrkiv+XuudBZP445kgkSiTLMmVLwF81k=
X-Received: by 2002:a17:907:d28:b0:afe:93e2:3984 with SMTP id
 a640c23a62f3a-b07c354e9a9mr918694166b.8.1757851583397; Sun, 14 Sep 2025
 05:06:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250913-b4-bma220_improvements-v3-0-0b97279b4e45@subdimension.ro>
 <20250913-b4-bma220_improvements-v3-7-0b97279b4e45@subdimension.ro>
In-Reply-To: <20250913-b4-bma220_improvements-v3-7-0b97279b4e45@subdimension.ro>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 14 Sep 2025 15:05:47 +0300
X-Gm-Features: Ac12FXzlod_4HW5XsON8nSZC57Q9z1TIkzdx7fKnaT0YVraOiI4v2aOT5pPKdvY
Message-ID: <CAHp75Vc4TUu497JMuU0-bU0aqew9vUXLTDqDoqLMLkAC43Qv9g@mail.gmail.com>
Subject: Re: [PATCH v3 07/18] iio: accel: bma220: move bma220_power() fct
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 13, 2025 at 6:40=E2=80=AFPM Petre Rodan <petre.rodan@subdimensi=
on.ro> wrote:
>
> Move bma220_power() fct before bma220_init() since it will make the
> next patch cleaner.

...

> +static int bma220_power(struct spi_device *spi, bool up)
> +{
> +       int i, ret;
> +
> +       /**

It's not a kernel doc, do not inherit the mistakes from the past.

> +        * The chip can be suspended/woken up by a simple register read.
> +        * So, we need up to 2 register reads of the suspend register
> +        * to make sure that the device is in the desired state.
> +        */
> +       for (i =3D 0; i < 2; i++) {
> +               ret =3D bma220_read_reg(spi, BMA220_REG_SUSPEND);
> +               if (ret < 0)
> +                       return ret;
> +
> +               if (up && ret =3D=3D BMA220_SUSPEND_SLEEP)
> +                       return 0;
> +
> +               if (!up && ret =3D=3D BMA220_SUSPEND_WAKE)
> +                       return 0;
> +       }
> +
> +       return -EBUSY;
> +}


--=20
With Best Regards,
Andy Shevchenko

