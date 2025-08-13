Return-Path: <linux-iio+bounces-22654-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC2B4B246FF
	for <lists+linux-iio@lfdr.de>; Wed, 13 Aug 2025 12:18:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EF011882CF6
	for <lists+linux-iio@lfdr.de>; Wed, 13 Aug 2025 10:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A222F3C21;
	Wed, 13 Aug 2025 10:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fGRLKJQR"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16BF2F2912;
	Wed, 13 Aug 2025 10:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755080022; cv=none; b=ef8vaK2uKEKpfV44D5I1z3IM6RyI8mzePfXEdpOzuK2MmNdjIwVDqCvuw+AzurbMZOVyJhk9hkrhGP6LOXjGZJuDgY7WMqFSThUxk8YxyQA+e2JknKPUhDHyjgh9nlM+VUbAfmZSHVgaCl55ICxrE3HkaDqcgwsCkI5eUlcFk88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755080022; c=relaxed/simple;
	bh=thsBLOQirP9wL6/Ks3ioce6aQ9TbWFoSdll2cAVk/L4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D3L8X8bNRXkqmqKjk6xfnHHzd6fZ7UmoBdD8EtCaloR6O8DzlOfBu0SKlAwGiO0b71cITYk4MFNGVHOKjkNMYRjoWNdGAWBMRTM76yMCYNtWrdaVCihml9rwkkoPZr0JSr2+JKQlyMb8kGL+sH0+zMyS+u/JaFTa/0kHCRS5StU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fGRLKJQR; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-afca523e810so91270666b.1;
        Wed, 13 Aug 2025 03:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755080019; x=1755684819; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tjYjnf2fuX+3VMHJAYD7iG9oAQNrcJfG3PgnKn920PQ=;
        b=fGRLKJQR/YTGr8VkCwRWiK6pSOCxf03OaMs1mYAkXXkJmmwfvQkOdykEQ8WWqzNqOw
         5P+KryTFQS97xTtYMolgAsWpVqf+KdmuXsfE+TSUkT5R6RDlwuVOf9H+7XTuIuqqHSWp
         +KQbaQjzC/BaH2wyRBcnDIyH4oaFh5lfA9kSm46OK4TaGZ+xt3MLgcG12qgU7aIUjtvW
         8z7+f73dXEBWjBnf7b/sLm31DW47ZGgCsfl//akwTjhw5c+VxIFjpVnbqkSSPmR7xlI6
         ZegVl7d5pjYyJbTmk94VTEENc+tMkIyGvNrkf9bcfVaL89aD7ZqCiE0SG16beeFs8S2A
         MYQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755080019; x=1755684819;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tjYjnf2fuX+3VMHJAYD7iG9oAQNrcJfG3PgnKn920PQ=;
        b=fox9Z/WyGdLAWnF5cyHOF52qtemgcNAk4iDjzIerERXOz1gALu7DjHmJCof8cr9BbO
         4N9jV+6bEy6v7wQu663YC6nO8Nj8TYoMypYnQW6n0yRq+qjpk/l6jt2GcJaCoo/2OQaG
         PAtvk/SZPULyu0rEHslfGVVpTSqBYbm6ZPRCI8PFRsi4kRMr8mIQNIdsj/m+ipEUWfhx
         Ta1Ufwf8GkgRuh/sPWO1a2ddss/6+cpTI6GK/7rLEl41h0wzLUuybyor6sYZZGxhdCmH
         aUbGw2OU7nigt87RWH4x0zpISuwF3Be0lyIyCTfW1CVKjHh+shNvqL4atd+IAqxP8lp7
         w/FQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBPEO3FPD0DJnFyzpFg3J2LVBPctJKJG6sO0b3DumX3ZKWPhTEI9bZSHNCFr3LlVFWeUPq73XhB3L1soV5@vger.kernel.org, AJvYcCWYcHybY+f/i6jvq4Q4aJvWlur5H8zY8j8Ckr+NTkceKtav3DAj3Ji1Fm8OHz4C468Gr+oNPjZytAs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcSkywFDVlbDdFkVXyL+a7lo7bKJY7VKpR+RViIOjY8TS2CGb5
	A2gWiqorX2F1YEPKmYAkqWL9kL6ytD7fbmTO3N7hvMUnbi8RN3DFWB/WrbHolORrYi4npvxFJpA
	AjQipNSJ7soYs5vuMJcsNCYEf+S2iG08=
X-Gm-Gg: ASbGnct95JyXWTzaCxBpMRDkMnAPDHDMUq0f9li0D1MOw1lzDZx0A2503ZIHV+apfFp
	aRcmgIEV/P/GVux77BgLB9tdYKel5r+OrBgym2+4Qn0vzDW+L2h4ojwdYTEion/PXWHPMFq0hV4
	11RKe552PZ7WxD+f7w3C/FmySm6uY3sN5UxiuWks/dS8WAkBN7mEGtewU6nLuqMYqZMDLv2HhOS
	Bzej7tb3g==
X-Google-Smtp-Source: AGHT+IH9xaJP4XAID/Z3bbXkFtCnolBhpSbXg7PBsVuI+q6aZK/FJ2vls42yjpRhMLyiAXL28NxOmcDGoF2/HLOvtD4=
X-Received: by 2002:a17:907:86a2:b0:ae3:60fb:1b3b with SMTP id
 a640c23a62f3a-afca4ea01cfmr240038466b.58.1755080018525; Wed, 13 Aug 2025
 03:13:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812170723.51639-1-akshayaj.lkd@gmail.com>
In-Reply-To: <20250812170723.51639-1-akshayaj.lkd@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 13 Aug 2025 12:13:02 +0200
X-Gm-Features: Ac12FXyTkkbKzJf7vV0cX8xD6E3qt0fhFM545c6AAzp-9eXMrj3oxHTNzwcK3i0
Message-ID: <CAHp75VfPNDzvxu8znHn45iS9Db_=E7A9nf2xmtVnY8cAi1HnfA@mail.gmail.com>
Subject: Re: [PATCH v2] iio: light: ltr390: Add device powerdown functionality
 via devm api
To: Akshay Jindal <akshayaj.lkd@gmail.com>
Cc: anshulusr@gmail.com, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, shuah@kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 7:07=E2=80=AFPM Akshay Jindal <akshayaj.lkd@gmail.c=
om> wrote:
>
> Use devm_add_action_or_reset to do cleanup when the device is removed.

devm_add_action_or_reset()

> Set client data with i2c_set_clientdata() to ensure indio_dev is accessib=
le
> in powerdown function.

...

> +static void ltr390_powerdown(void *client)
> +{
> +       struct i2c_client *i2c_clnt =3D client;
> +       struct iio_dev *indio_dev =3D i2c_get_clientdata(i2c_clnt);

Why? I mean why can't you simply provide a data pointer directly as a
parameter to this function?

> +       struct ltr390_data *data =3D iio_priv(indio_dev);
> +
> +       guard(mutex)(&data->lock);
> +
> +       /* Ensure that power off and interrupts are disabled */
> +       if (regmap_clear_bits(data->regmap, LTR390_INT_CFG,
> +                               LTR390_LS_INT_EN) < 0)
> +               dev_err(&i2c_clnt->dev, "failed to disable interrupts\n")=
;
> +
> +       if (regmap_clear_bits(data->regmap, LTR390_MAIN_CTRL,
> +                       LTR390_SENSOR_ENABLE) < 0)
> +               dev_err(&i2c_clnt->dev, "failed to disable sensor\n");
> +}

...

> @@ -693,7 +711,7 @@ static int ltr390_probe(struct i2c_client *client)
>                 return -ENOMEM;
>
>         data =3D iio_priv(indio_dev);

> -

Stray change.

> +       i2c_set_clientdata(client, indio_dev);

I would suggest moving this to be before data =3D ... line above. And
add a blank line after it. BUT, read above first.

>         data->regmap =3D devm_regmap_init_i2c(client, &ltr390_regmap_conf=
ig);
>         if (IS_ERR(data->regmap))
>                 return dev_err_probe(dev, PTR_ERR(data->regmap),

--=20
With Best Regards,
Andy Shevchenko

