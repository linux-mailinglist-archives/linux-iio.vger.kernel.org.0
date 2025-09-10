Return-Path: <linux-iio+bounces-23911-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21458B50F18
	for <lists+linux-iio@lfdr.de>; Wed, 10 Sep 2025 09:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 322777AE75E
	for <lists+linux-iio@lfdr.de>; Wed, 10 Sep 2025 07:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A7973019A3;
	Wed, 10 Sep 2025 07:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FBl2+Ml+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DA63064A7;
	Wed, 10 Sep 2025 07:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757488660; cv=none; b=UWiBM/zdEYINGGGlJurYp7J5jtM9INyrMqXDcZK2SERQ1HFvZKaxdKpU5ybY319M/lXk1WGt78jhKcXwMccHRIo07vbw9LvW8hGKw1haCJUDxnHrhtOctFrNedL1KLx+oqEF/mue49OfV0O0Rgnl2oWm6VUDdz3ZRPIYbyCHRho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757488660; c=relaxed/simple;
	bh=RD+ejP2DRVXZ85LACgZFOSDfXE4k9uCkCsPw/n1YMU8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r+kxeVcg/HVGb8xHKUiNGKy8DY47ShTyQ1v3k/y3oHqHbw93cx9pJ8AUr6cyLdxPk/Rg4Zjx75Rsbk6ZDqIUvjOF5GHLJ36rIT3X+43zJGCxS3tiJhW8Zoc1zIlCKdxCWA6UjkEd2jtGqRFopx6KFwh/f7Odqje37YCdjh6LVTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FBl2+Ml+; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b0475ce7f41so1108115866b.1;
        Wed, 10 Sep 2025 00:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757488657; x=1758093457; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9+1B/YopLFcMGKImqMNM24Ggg91wHiWBxhOvkg18u7Y=;
        b=FBl2+Ml+lrkJIJIRCcVQ4YEymqMMWDbhrV3mG4NEdkgHBnk/YmphXdOZfruXmTQmjP
         3kpWArXdxhzo+mN0s7/FpyUbVYQlGwfyMRWtn+Tt6jnh8oL2kPKDMcRiwoEsJ2yoYNRo
         gTK5Kk+KkGabmWTNhRhcqhhhvoqGBqlVAfNZBLWnWahSmKu9xUAZVVxlG/BHWRpK62dF
         NnbtQOxfIG91PrAjT27hIZoNbQ8y/Qt87kB1gf9kxEwr2JmZa2MN279/ncjYBdep/0lf
         l/4e7479SDA8drNE52F3kE1FbCu6awD5SpKV0jaR5g6SO6v5jqZIZMJmyqFX704aQWOF
         eGMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757488657; x=1758093457;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9+1B/YopLFcMGKImqMNM24Ggg91wHiWBxhOvkg18u7Y=;
        b=jNfn/JKbsiZjSvygyMyg04iyjnirQr6GQcpABrzrIb4X0rmYmKYQF4Rqin7T1XiCFF
         qkpkRWu7oHZwsDWfzoKWFPf4pF0J2bbgJDOaeF48kJXIUhguZ/lLuJvGKzao3qc3FRah
         ABbRVOMfU2jn0t+NOd/NiX/YjUkNZo0PvIeZumIMTx8YZwtXPyzQKdVBcpN2kqPfMt7I
         NSnEX9sZDFz5RPUYsoX0WvY0RRrui9I4U8MbBz0mwlNHrKfiPb3oz7Co8eweHXtAWi/q
         EtZ0O5CuBG8L6sDsMBfk+ea7+M/XJLp95DkIeOjgStMQ7LlTEtNFxIKqrZrRAnnXzL/A
         6Eyg==
X-Forwarded-Encrypted: i=1; AJvYcCUvQFjTtuQz2cBxuc0hr6WxXSaoE4gRHC4Sru0JIUAwLokkJR9FJdMsSP/4ai+Y9zdGyaUIRE0aDS0=@vger.kernel.org, AJvYcCV2hcwQEO+OXAGUCGBBg837t5OR9en3RXcwOsK0CNqXq6S2v39DF1exuKSDAkEYC2ML936AIHBd00xmmmpA@vger.kernel.org
X-Gm-Message-State: AOJu0YzgaqhV8R7Bv9/pZN1NX5MySmenu4wMnEjpAQ5AvmU3pYeASs5P
	rbloLTM3tQFsriljzsjxw3G+v+a44tyiZj39WRDKUnM+dpzBR3lxZLQuCX1fSiIIGEkPjV7Ss4v
	Sc0QrYtFx6YeyQwPuJSHR0Psdid/E1Bk=
X-Gm-Gg: ASbGnctkztp7jYiRfLMQWBK9pJi1/m7buJ7xsmdu9bga7yMr5qK684AXu1w5ch0YMrf
	j+8BaYar31c8ADbDP8T4UNfNnyiU91G/fTvKaa0eM8aSK1//1tjoDffOiMc1D+1/KG3b0SyLysG
	sIWojlfiREhNJZLRHU37JrisLXNv8TEl91EhhvoO81iyUj4KjJV1TUjow9h5UxB62+cE5FHKylF
	amPcJI=
X-Google-Smtp-Source: AGHT+IGOvfiKOgl+OMuYPMkwp8kMVb4c6yw6Aslo5PIFvsmiAjEKdocdzelDDsg4mzevPWEJCMjNFM8XdK8aKsXETsU=
X-Received: by 2002:a17:907:3ea2:b0:b04:1b90:8d7a with SMTP id
 a640c23a62f3a-b04b1463381mr1601906166b.27.1757488656750; Wed, 10 Sep 2025
 00:17:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909194649.10512-1-akshayaj.lkd@gmail.com>
In-Reply-To: <20250909194649.10512-1-akshayaj.lkd@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 10 Sep 2025 10:17:00 +0300
X-Gm-Features: Ac12FXzrFnYlv_Q9q9Uh2hOybm60ceznfeP7mS3dxr5sUyffXjXoEwdttGO5i7g
Message-ID: <CAHp75VfpQ9c4cptnNGzFYakQxY7JjtUEMDsysS9KJ60xrzaE4g@mail.gmail.com>
Subject: Re: [PATCH v7] iio: light: ltr390: Implement runtime PM support
To: Akshay Jindal <akshayaj.lkd@gmail.com>
Cc: anshulusr@gmail.com, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, shuah@kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 10:47=E2=80=AFPM Akshay Jindal <akshayaj.lkd@gmail.c=
om> wrote:
>
> Implement runtime power management for the LTR390 sensor. The device
> autosuspends after 1s of idle time, reducing current consumption from
> 100 =C2=B5A in active mode to 1 =C2=B5A in standby mode as per the datash=
eet.
>
> Ensure that interrupts continue to be delivered with runtime PM.
> Since the LTR390 cannot be used as a wakeup source during runtime
> suspend, therefore increment the runtime PM refcount when enabling
> events and decrement it when disabling events or powering down.
> This prevents event loss while still allowing power savings when IRQs
> are unused.

...

> +static int ltr390_read_raw(struct iio_dev *iio_device,
> +                          struct iio_chan_spec const *chan, int *val,
> +                          int *val2, long mask)

Isn't the mask unsigned long? Jonathan, do we get this fixed already?

Also logical split might be better, i.e. putting val and val2 on the
same line. Then mask will be on the next one

...

>  static void ltr390_powerdown(void *priv)
>  {
>         struct ltr390_data *data =3D priv;
> +       struct device *dev =3D &data->client->dev;
> +       int ret;
>
>         guard(mutex)(&data->lock);
>
>         /* Ensure that power off and interrupts are disabled */
> -       if (regmap_clear_bits(data->regmap, LTR390_INT_CFG,
> -                               LTR390_LS_INT_EN) < 0)
> -               dev_err(&data->client->dev, "failed to disable interrupts=
\n");
> +       if (data->irq_enabled) {
> +               ret =3D regmap_clear_bits(data->regmap, LTR390_INT_CFG, L=
TR390_LS_INT_EN);
> +               if (ret < 0)
> +                       dev_err(dev, "failed to disable interrupts\n");

In event_config we assure that IRQ is enabled.

> +               data->irq_enabled =3D false;

Here we may lie about the facts. What will the driver do, if the IRQ
is triggered just before this line?

> +               pm_runtime_put_autosuspend(&data->client->dev);

You have dev, use it.

But where is the symmetrical pm_runtime_get*()?

> +       }
> +
> +       ret =3D regmap_clear_bits(data->regmap, LTR390_MAIN_CTRL, LTR390_=
SENSOR_ENABLE);
> +       if (ret < 0)
> +               dev_err(dev, "failed to disable sensor\n");
> +}


--=20
With Best Regards,
Andy Shevchenko

