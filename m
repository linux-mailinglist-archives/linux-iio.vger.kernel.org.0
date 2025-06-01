Return-Path: <linux-iio+bounces-20114-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD1EACA03C
	for <lists+linux-iio@lfdr.de>; Sun,  1 Jun 2025 21:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B27523A9463
	for <lists+linux-iio@lfdr.de>; Sun,  1 Jun 2025 19:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE639238C12;
	Sun,  1 Jun 2025 19:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJiZXimD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D6A19048A;
	Sun,  1 Jun 2025 19:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748805708; cv=none; b=e2HbE2VhEE/TCPUF8pJ2DRBWCA24XTomHdMSalRsMV4sY2ay/pwiitjXCjvGOpYQkQOkZUDrm82d2y3urFS0eF7u+8v+w9jTMGCwi3/GSVXUiH+1Yq7bs46e8E2WjtUuG7SaqEBeS8INH2BqNnnRXWnud827uSxF870a3GHqah8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748805708; c=relaxed/simple;
	bh=rsqCzzJMgXL8ZZ9dC9slc0R30KWyZoHSKCDnz7jwGJQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uuYUnAIZkEPVdoXJTlvqbiITvhXnGJNk/9UTAVD8sPIQTWQE7ubabcOyH1leaU+FcOJNBKAmvQwGzffH3ciAwwp7sUYQaoHw6+cR71SDc8XeDmoMkhUW9WepTvlc329yDAlagpRfxgPRD3XFDdDos1s6/hvgXx4aDXe8CpRZURY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dJiZXimD; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-acbb85ce788so735103366b.3;
        Sun, 01 Jun 2025 12:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748805704; x=1749410504; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i6pH/dSBphSvbez16ROLo83hj6hHipKab1wirLdUxUY=;
        b=dJiZXimDFrRA0amco9TDVrJhNmysj7JtZo1kor4Y4fQVCQAgedfyUEpGcONnZVZLbW
         8VoNQ+ZEvIqLgGd2fS8AlGxEK3spDB7THFMo+NrJNEenu3BNkORry37zX6SzqtXA69FI
         B72+e8lgrFwyMQg3IBm1gOlAPJOERERQBgQpqZ0I1reiiI1D3q9qY4L6Ghvdxs2oF3Ut
         ndyYwxwGudxWU+BrKYbVSBGZkVQe8vGzPlIpoNWvWBCHmiDRhhZmQfbXF2mTLLbR83hQ
         M4j690oJ3f6FkydZS/G9lTHHMfyhzpoCe4t7hH66XIpdEk+fdqVe2IjNLmfE/6nqJzH/
         mIrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748805704; x=1749410504;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i6pH/dSBphSvbez16ROLo83hj6hHipKab1wirLdUxUY=;
        b=R/wjXox+BhRa0GdR7A/tY/lOdciw4/DLmTpyeDcO+7DIPBZMVfCWumSeCCrm2N+B+v
         cBlO6WyjG0hEMG5iEkfJt1c5jsEjN15rTQ5OvxNs7oY/KQzVaVekjqXKHLDCtdWUryRm
         9PrjqBGvPJF9NGqMUhKTKx/jK4XXR+fEHsl6CSI9RMnlnNGwHDbIDE5p3CNqBGSw1P2q
         mpSbKI+LTHvzjAQm9U9OWWBFNPPcDbiXAr/0M/2gGkJNHmWnSEIxIsjFh9IZr4maBcRI
         JQYqyuoQbAwlYI4FGrBmjVCO4Wn6zwOZ/iv8m2oEKH96ifeOEhsdszVCVrtzSG0g34Fm
         jg/w==
X-Forwarded-Encrypted: i=1; AJvYcCU9cZVkbZKIv38wQ7AJV0vCCsCNTS3M18VyhrrtKDXZllNVd6ZW2smaaALl13IOFLOHwLxoODMZI9pS@vger.kernel.org, AJvYcCUmHz8/QKt70wWzxvhna2htHO0OKLKUyV5rCvJBX7T2qd0pYT8wWvgwVt62HQ2RfZ4Ky2oFOE/dKFE=@vger.kernel.org, AJvYcCWhIrRxzqrUWZZy76V+uDUwsysZ/g7cGBgrF5ZAuFw7aqamR6ncvgtuqz5atD65p6/mtLas6E4FbnjQzmJm@vger.kernel.org
X-Gm-Message-State: AOJu0YwGsZBGuPA8bZo6edlpYoJwnBLvTCiyqvZtQ20LelEd/aORws9V
	Wqx1Q1oXJvhB+6PpQZF3rAKWedHp0Al8F2aSfBZQusGZITsYdxQNJ+s+XWf2yKoYIyRyQytm/nB
	+Cy6JBikQKB+RU0EQqmaO3D4zkig+dmM=
X-Gm-Gg: ASbGncv14MBfXfMDj+40/27i+rv6RJCvMj/UapQj+PocqGWLFnSWumBYktq8nZ5tBiG
	3XpKdF2V0k94FviniRShj/iRTaU+bj5LsAhc358pMMHDYNEVNkDd8inwA9gVM+xKclRi2bNeuQK
	P5Kt54RPxDlsimjK7jkD3zZCidfTfwp9BvJaBbCyCxa3A=
X-Google-Smtp-Source: AGHT+IG7+akghDlh+Bgs8B07YkvvcgcTdQ1VWPkk0b/F/1tGDZIsK4CTiYUaqqko2bn6geJ1mqKjsh7Bq9K84oFIXaM=
X-Received: by 2002:a17:907:9721:b0:ad2:4c38:5a22 with SMTP id
 a640c23a62f3a-adb3243dd27mr958847466b.51.1748805703934; Sun, 01 Jun 2025
 12:21:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250601172139.59156-1-l.rubusch@gmail.com> <20250601172139.59156-6-l.rubusch@gmail.com>
In-Reply-To: <20250601172139.59156-6-l.rubusch@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 1 Jun 2025 22:21:07 +0300
X-Gm-Features: AX0GCFuaRhdPoVYp8CxAxz3huqyHRch8cOrG1pA2w-h93tLH5z2oPyvecfEBmas
Message-ID: <CAHp75VdCMSzQt9bY0y84yndPWUmFXD+KJeu4YxvQxk9pnfgWCA@mail.gmail.com>
Subject: Re: [PATCH v4 05/11] iio: accel: adxl313: prepare interrupt handling
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, corbet@lwn.net, lucas.p.stankus@gmail.com, lars@metafoo.de, 
	Michael.Hennerich@analog.com, bagasdotme@gmail.com, linux-iio@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 1, 2025 at 8:21=E2=80=AFPM Lothar Rubusch <l.rubusch@gmail.com>=
 wrote:
>
> Evaluate the devicetree property for an optional interrupt line, and
> configure the interrupt mapping accordingly. When no interrupt line
> is defined in the devicetree, keep the FIFO in bypass mode as before.

...

>         struct adxl313_data *data;
>         struct iio_dev *indio_dev;
> -       int ret;
> +       u8 int_line;
> +       u8 int_map_msk;
> +       int irq, ret;

Why do you need a specific irq variable?

...

> +       int_line =3D ADXL313_INT1;

Assign this when we are sure that the INT1 is defined. Current
approach is not robust.

> +       irq =3D fwnode_irq_get_byname(dev_fwnode(dev), "INT1");
> +       if (irq < 0) {
> +               int_line =3D ADXL313_INT2;
> +               irq =3D fwnode_irq_get_byname(dev_fwnode(dev), "INT2");
> +               if (irq < 0)
> +                       int_line =3D ADXL313_INT_NONE;
> +       }

So, the below code does not use the returned vIRQ, moreover, the above
code actually does the IRQ mapping. Why do you need that if the code
doesn't use it?

> +       if (int_line !=3D ADXL313_INT_NONE) {

Why not positive conditional? But see below...

> +               /* FIFO_STREAM mode */
> +               int_map_msk =3D ADXL313_INT_DREADY | ADXL313_INT_ACTIVITY=
 |
> +                       ADXL313_INT_INACTIVITY | ADXL313_INT_WATERMARK |
> +                       ADXL313_INT_OVERRUN;
> +               ret =3D regmap_assign_bits(data->regmap, ADXL313_REG_INT_=
MAP,
> +                                        int_map_msk, int_line =3D=3D ADX=
L313_INT2);

This is fragile. It heavily relies on the existence of exactly three
IRQ variants. Instead of defining special case (NONE) simply use
whatever is undefined as the default case

  switch (IRQ type) {
  case 'INT1':
    ...
    break;
  case 'INT2':
    ...
    break;
  default:
    // FIFO bypass mode
    ...
    break;
  }

But still, the main question and confusion here is the absence of the
users of 'irq'.

> +               if (ret)
> +                       return ret;
> +       } else {
> +               /*
> +                * FIFO_BYPASSED mode
> +                *
> +                * When no interrupt lines are specified, the driver fall=
s back
> +                * to use the sensor in FIFO_BYPASS mode. This means turn=
ing off
> +                * internal FIFO and interrupt generation (since there is=
 no
> +                * line specified). Unmaskable interrupts such as overrun=
 or
> +                * data ready won't interfere. Even that a FIFO_STREAM mo=
de w/o
> +                * connected interrupt line might allow for obtaining raw
> +                * measurements, a fallback to disable interrupts when no
> +                * interrupt lines are connected seems to be the cleaner
> +                * solution.
> +                */
> +               ret =3D regmap_write(data->regmap, ADXL313_REG_FIFO_CTL,
> +                                  FIELD_PREP(ADXL313_REG_FIFO_CTL_MODE_M=
SK,
> +                                             ADXL313_FIFO_BYPASS));
> +               if (ret)
> +                       return ret;
> +       }
> +
>         return devm_iio_device_register(dev, indio_dev);
>  }

--=20
With Best Regards,
Andy Shevchenko

