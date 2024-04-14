Return-Path: <linux-iio+bounces-4259-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F8E8A3E30
	for <lists+linux-iio@lfdr.de>; Sat, 13 Apr 2024 21:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8D9E281FD9
	for <lists+linux-iio@lfdr.de>; Sat, 13 Apr 2024 19:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A8754668;
	Sat, 13 Apr 2024 19:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="qW+f+wZH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3253663C8
	for <linux-iio@vger.kernel.org>; Sat, 13 Apr 2024 19:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713035425; cv=none; b=ohDjrr64E/jBVdR4+o5Jqonay0NmR6eYqZNlVcYVUXaOBmnYmxGs0J5qkV7kDRO0FE4NJtxJO10RDB63Ua75xzkKUn3HTE7OY6if5zYopBSeiDzrQkvV5eX3vo2v347gmc8gRInC303eWx3bnh9oYzQMf9alL6GVaeHlXbjdKKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713035425; c=relaxed/simple;
	bh=NK36aVW0Q4AOfz3pKXy6wWqoZHB49yeleuvN/jCXBZc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SctMH4EDvIkEzYzBi6CgGgVvFf+Q7d8Q1C25UxigYMmCLz7PNl5IaQ6HrSrsn/+xhPVxF/Fw0f1qOj2/ScpoA//lozrhfDkd/9qjxFrYz8ZprcVbKap6Z64Pd1sIAuHfMmX0peENWbNMH7isXLcDghL+MdHzx/La/4qAjPSyrYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=qW+f+wZH; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-516cdb21b34so2507397e87.1
        for <linux-iio@vger.kernel.org>; Sat, 13 Apr 2024 12:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1713035420; x=1713640220; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ohhq94Hi9UA2u72f6b9WWlalORV6WhRgdHkGudBsR/4=;
        b=qW+f+wZHdV294KbUYAZmsOrJgspuWnKwhiq3ptjOzY5UPCTjEjoAmORKvR6Mpo9pAo
         Jc2aDLpRX8SyCj3LStaiTIwyqDbdZAAIRT4Lw5rZ9jrDME+GFyIFyRy5659NFx1FPoTD
         xLD+IUC+sdaACXhajNd6DjcepPIQ0Oa30/fHJJGZyib4aJvMfCYtGbPGQpD3BXV45Hx7
         dVUcnCTJbtlk3dW/JiTF9rcl2nR8Cxxn6LCW+7o3NLBZR6KotW/b6Q5cpeMEvtxEHqU9
         qDk3Zw7H+60G02yf0AUAKErhH85MgA3oPOf+ATHSMf11fBM0L6dIsGDGIrWdAgBP3S5P
         6PiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713035420; x=1713640220;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ohhq94Hi9UA2u72f6b9WWlalORV6WhRgdHkGudBsR/4=;
        b=wAjk2zeU6dyVSbqLAD4Q0BV5ML6W8QcacsVvHChLxgyZM1mRlquX4OjN4NBdFs7qoN
         7c3jz+vm70sFQRg7qFXch7vt+9KP3xUnlkJWMh9ly/VXlcfI/sXPqzLuNzv4Cq0w/rgW
         3a7rU/F6mMnfWIg35/8lmzR34lcBcd9wO0vBDkt9qLdFjHsoKUf0b33BfbxRK8Ju7evn
         LOFQ+B+Mu0TRc4zVnuz4HfbdKqQSSIgAwQ6IJi+nv0wYMfGScvYVc5eX9SF5E2fhZk0c
         O+Hwjwk1VUketEdct6wjN+nkjaSrygX6+wuY2o7a5IRsT7DAn2vNu0iDXhO0NWWoLiO/
         BQhA==
X-Forwarded-Encrypted: i=1; AJvYcCXwjbuCwhNv39AZ7e7b7h4pLX3zmVQK8NSzZdqNSICDnebmBDi8u8aqR9F0AB6sqGxN5oiNt9uGX9bwB+gHYcJhbZ4f6IQ58p/+
X-Gm-Message-State: AOJu0YxE931Vt+DLy/cNStiYxMf66v/X3jaTh9QdE/TfKbP27LBISbBf
	doIvem7km7x8Y98HzAjMavEYydgUJsr4FvvynZZBu/uYc6+yMyl73sPvunatd+4iLxiUmmS43pE
	YerMgRSlDi/12tm9m5pAH0OjKlzXNPMBxEKzobw==
X-Google-Smtp-Source: AGHT+IEevveWBjU7TZWnqjnm1VFpx0byQntZkv6S4ruBzyz3GDRxKVsXcuxEw66rLcFbF41a5ngZ+AFzGlSD4I+mW5o=
X-Received: by 2002:a2e:3509:0:b0:2d8:3dc7:e302 with SMTP id
 z9-20020a2e3509000000b002d83dc7e302mr3607781ljz.2.1713035420280; Sat, 13 Apr
 2024 12:10:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240413151152.165682-1-alisa.roman@analog.com> <20240413151152.165682-4-alisa.roman@analog.com>
In-Reply-To: <20240413151152.165682-4-alisa.roman@analog.com>
From: David Lechner <dlechner@baylibre.com>
Date: Sat, 13 Apr 2024 14:10:08 -0500
Message-ID: <CAMknhBFk9e=VDYFVUhKmabHKwhJKbVVA4tRz758QszjHLGUEpg@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] iio: adc: ad7192: Add aincom supply
To: Alisa-Dariana Roman <alisadariana@gmail.com>
Cc: michael.hennerich@analog.com, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	alexandru.tachici@analog.com, lars@metafoo.de, jic23@kernel.org, 
	robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	lgirdwood@gmail.com, broonie@kernel.org, andy@kernel.org, nuno.sa@analog.com, 
	marcelo.schmitt@analog.com, bigunclemax@gmail.com, okan.sahin@analog.com, 
	fr0st61te@gmail.com, alisa.roman@analog.com, marcus.folkesson@gmail.com, 
	schnelle@linux.ibm.com, liambeguin@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 13, 2024 at 10:12=E2=80=AFAM Alisa-Dariana Roman
<alisadariana@gmail.com> wrote:
>
> AINCOM should actually be a supply. If present and it has a non-zero
> voltage, the pseudo-differential channels are configured as single-ended
> with an offset. Otherwise, they are configured as differential channels
> between AINx and AINCOM pins.
>
> Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
> ---
>  drivers/iio/adc/ad7192.c | 53 +++++++++++++++++++++++++++++++++++++---
>  1 file changed, 49 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
> index ac737221beae..a9eb4fab39ca 100644
> --- a/drivers/iio/adc/ad7192.c
> +++ b/drivers/iio/adc/ad7192.c
> @@ -175,7 +175,7 @@ enum {
>  struct ad7192_chip_info {
>         unsigned int                    chip_id;
>         const char                      *name;
> -       const struct iio_chan_spec      *channels;
> +       struct iio_chan_spec            *channels;
>         u8                              num_channels;
>         const struct iio_info           *info;
>  };
> @@ -186,6 +186,7 @@ struct ad7192_state {
>         struct regulator                *vref;
>         struct clk                      *mclk;
>         u16                             int_vref_mv;
> +       u16                             aincom_mv;

u32? (In case we have a future chip that can go above 6.5535V?

>         u32                             fclk;
>         u32                             mode;
>         u32                             conf;
> @@ -745,6 +746,9 @@ static int ad7192_read_raw(struct iio_dev *indio_dev,
>                 /* Kelvin to Celsius */

Not related to this patch, but I'm not a fan of the way the
temperature case writes over *val (maybe clean that up using a switch
statement instead in another patch while we are working on this?).
Adding the else if to this makes it even harder to follow.

>                 if (chan->type =3D=3D IIO_TEMP)
>                         *val -=3D 273 * ad7192_get_temp_scale(unipolar);
> +               else if (st->aincom_mv && chan->channel2 =3D=3D -1)

I think the logic should be !chan->differential instead of
chan->channel2 =3D -1 (more explanation on this below).

> +                       *val +=3D DIV_ROUND_CLOSEST_ULL((u64)st->aincom_m=
v * 1000000000,
> +                                                     st->scale_avail[gai=
n][1]);
>                 return IIO_VAL_INT;
>         case IIO_CHAN_INFO_SAMP_FREQ:
>                 *val =3D DIV_ROUND_CLOSEST(ad7192_get_f_adc(st), 1024);

...

>
> +static int ad7192_config_channels(struct ad7192_state *st)
> +{
> +       struct iio_chan_spec *channels =3D st->chip_info->channels;
> +       int i;
> +
> +       if (!st->aincom_mv)

As mentioned in my reply to the DT bindings patch, I don't think this
logic is correct. AINx/AINCOM input pairs are always
pseudo-differential regardless if AINCOM is tied to GND or is a
non-zero voltage.

Also, to be clear, for pseudo-differential inputs, we want
.differential =3D 0, so the existing channel specs look correct to me
and therefore we don't need any changes like this.

> +               for (i =3D 0; i < st->chip_info->num_channels; i++)
> +                       if (channels[i].channel2 =3D=3D -1) {
> +                               channels[i].differential =3D 1;
> +                               channels[i].channel2 =3D 0;
> +                       }
> +
> +       return 0;
> +}
> +

