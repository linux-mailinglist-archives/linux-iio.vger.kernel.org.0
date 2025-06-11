Return-Path: <linux-iio+bounces-20403-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC09CAD4EEF
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 10:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B6F91792BF
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 08:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B1A0242927;
	Wed, 11 Jun 2025 08:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ypb5VC8M"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EC32405E4;
	Wed, 11 Jun 2025 08:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749632165; cv=none; b=q72Ft5LYgJ9M+BhwtPOb3uf7FS5jMKGUsb8Uy3cGWZBqV8OQZkqv+jMTEpsOjSn3JiY4NAeYZc4kwAFbEK74IR3ZsE+rKTm/XFZFUgEZ/eivs6LgBoUiBGOxy1snkK0SsWiQqcQ9WCcITENZ8EqPqRvN3Ms9w7ga7m0hb7sm6TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749632165; c=relaxed/simple;
	bh=0fXEzlKGR7uRK1gsrzE4/HNTgAhDwUJtxaGb1K0SYYs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LQH8YtclwKVte484RUp5rtYGPXUkzPK975a9pdCcuu9XRy5PYO3F9olAfw7z5mn9saKKoIDlCHcupiRV0CJrMajN8r4SIRg/Jz8t6axjo/l5uvdP9APkVPPcQBLl6hLCGtTS0Pv8cT+zY47bBfZuKv04pzt2OIyvsXm/CUrFjHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ypb5VC8M; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-70cb9ae5479so353287b3.2;
        Wed, 11 Jun 2025 01:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749632162; x=1750236962; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jr7af8u/djfaVEFtDVz1sFAL1KZvVfAMjhhIxlcv8Us=;
        b=Ypb5VC8MH95LAJz+WBdTW7hG2jDC3fjePE3L/tQL8mzp0lo7KPSy/98Ddpgnx8z7hA
         acNxxfvEvOwkwppYEYNUriGNddB+wx0tDqVxQ9mOFCJ4lcI1+CxCwHsoSy7qQAjvC56T
         EJz41U85IeSwWcV5y0qDYLMmEuxMWUoyGWr4rsxPV7B6ciogSVJxg3+IC8FFXWqKvOZP
         G5GXAmH5C5YA+OVaBMw+NXi1RM/cQZNOSC3KPo1MS9vX2dW6HuowBJ6POgivLyNy/0A+
         ygYCqzeEJlRggI1vb/vKs5Dvd3QIxzJ+zQye3sdb/0O95wlzBaFmXMFGVbIJCo4nmPS1
         ERpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749632162; x=1750236962;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jr7af8u/djfaVEFtDVz1sFAL1KZvVfAMjhhIxlcv8Us=;
        b=GMFGk8N6CPVJDcl1Tact/L2IUBu07POzJ78pIr+T7+nGTJJvZuc3DnJQMFEc8CrQit
         WQUUuKKkHrjKVRi4UNFmKEtVzKmgjG9Wbw5ZSjPnefYlmNZPXEP5pDjewj8NO22kIogN
         XdyxBQwyiIv+CqMTb7lODo+ITdKXAIDSnJABoOCXird/OuuRPFaEigEn14Y7FzIBlBx2
         SO30W0H8r1FDpwEw5YWSZkBgFb5p5eDSfQnzvVNCfqQmDur2oIMxh4bsFLUY1e0wVMK0
         kND2eKqln153kVsEAB5mIHTliX93hcFCu7cio8zx20PH/zdXKEdxuvhuC5NGy/XAgw7D
         RuRg==
X-Forwarded-Encrypted: i=1; AJvYcCUarD5coAMMQyu8KQpJETBkUTI/gGbgP8ALhr527Gy5HE7mrf2v+EKVyXkEs0BAKAOZIyAhnvs7kmVxTrY2@vger.kernel.org, AJvYcCUpF43ORCIC6l8JAljNbbOXI2nhIizmT6MyNclybGgR92NKgIf6ErkzazwkTtZ/7Un+0ZmYwOOuu5c=@vger.kernel.org, AJvYcCXEjRIwrm+d6nCgPwxmtXyrtKsj6llKf2uEy9tVgrtBGfpcWizIOLTOfuVSuBsu0F2iEDI1xWkp1vDC@vger.kernel.org
X-Gm-Message-State: AOJu0YwbN3c2X84u6upRfvjF/Ok0cMjOvMPsCfHAtbZC3sqkpipjIW0A
	88kgo5C7M5oIw+SnbIqlGmXeq8N5nerqf9UalD50IV28uxt8w4TM27owwo4RuWFocuKa0SfxH23
	ZSa7knaprgvTgog6lzK3Ye1qw9TxkmXU=
X-Gm-Gg: ASbGncuvCrG9gXOB5tO33j4HBjtM21sI/d12mJacV+4KIdjhngAjv4rpEbQexJ9tVfU
	YJaReNsgall1r/wfX9ePn94yrP0C9GyWGMpulV2B27NNsmWI678SFDa51ck+wrJ9i6Rp2rbxddK
	19KgfYSVLQXOQN5fbUHNen8xBx+J1FnfB7exfHHuMKVk8=
X-Google-Smtp-Source: AGHT+IHQshvzaNfy3bNjdRFH2yuU1qV8IQJUoInmY8JcSy/11DFg74rdFUbgCEsdVvOxd36y+j03qwTnrUKK/Llr8YA=
X-Received: by 2002:a05:690c:620a:b0:70f:7bea:5dd with SMTP id
 00721157ae682-71140b18ed9mr14745547b3.9.1749632162358; Wed, 11 Jun 2025
 01:56:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250601172139.59156-1-l.rubusch@gmail.com> <20250601172139.59156-5-l.rubusch@gmail.com>
 <20250608162738.407c7d20@jic23-huawei>
In-Reply-To: <20250608162738.407c7d20@jic23-huawei>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Wed, 11 Jun 2025 10:55:26 +0200
X-Gm-Features: AX0GCFtErc9t4ORFe67lg4US4jiRG_9OYZGh8UYacK5QGDW6gTjheKx4y-gYpF4
Message-ID: <CAFXKEHZgvoHVigGcDOchkAsYcs_cpYzfXstRBa_OzS_LEkvNXg@mail.gmail.com>
Subject: Re: [PATCH v4 04/11] iio: accel: adxl313: add function to enable measurement
To: Jonathan Cameron <jic23@kernel.org>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, corbet@lwn.net, 
	lucas.p.stankus@gmail.com, lars@metafoo.de, Michael.Hennerich@analog.com, 
	bagasdotme@gmail.com, linux-iio@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 8, 2025 at 5:27=E2=80=AFPM Jonathan Cameron <jic23@kernel.org> =
wrote:
>
> On Sun,  1 Jun 2025 17:21:32 +0000
> Lothar Rubusch <l.rubusch@gmail.com> wrote:
>
> > Rework controlling measurement and standby of the sensor. Therefore,
> > replace writing the register directly by encapsulating this and dealing
> > with the return value in a separte function to enable and disable
> > measurement. This will help to avoid redundant code in all locations
> > where the sensor configuration needs to be adjusted, thus measurement w=
ill
> > be set to standby, in follow up patches.
> >
> > Further, reduce the control mask to only the measurement bit. The sleep=
 bit
> > actually controls a different behavior (not just putting the sensor to
> > standby for configuration, but turning it into sleep mode) and it is no=
t
> > used so far. In consequence, there is no need to cover sleep bit and
> > measurement with the same mask.
> >
> > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> This is a good bit to have as a precursor patch (as you have done)
> because it is refactoring the existing code.  It doesn't stand on it's
> own though given for now there is only one caller, so I won't pick it up
> until the patch that uses it is ready to go.
>

So, I'll leave this patch (in case I might refrase the commit message,
and I hope this is ok). I'm going to merge [v4 02/11] [v4 05/11] and
[v4 06/11] for a v5. Let me know if I got this wrong.

> Jonathan
>
> > ---
> >  drivers/iio/accel/adxl313.h      |  3 +--
> >  drivers/iio/accel/adxl313_core.c | 10 +++++++---
> >  2 files changed, 8 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/iio/accel/adxl313.h b/drivers/iio/accel/adxl313.h
> > index fc937bdf83b6..9bf2facdbf87 100644
> > --- a/drivers/iio/accel/adxl313.h
> > +++ b/drivers/iio/accel/adxl313.h
> > @@ -36,8 +36,7 @@
> >  #define ADXL313_RATE_MSK             GENMASK(3, 0)
> >  #define ADXL313_RATE_BASE            6
> >
> > -#define ADXL313_POWER_CTL_MSK                GENMASK(3, 2)
> > -#define ADXL313_MEASUREMENT_MODE     BIT(3)
> > +#define ADXL313_POWER_CTL_MSK                BIT(3)
> >
> >  #define ADXL313_RANGE_MSK            GENMASK(1, 0)
> >  #define ADXL313_RANGE_MAX            3
> > diff --git a/drivers/iio/accel/adxl313_core.c b/drivers/iio/accel/adxl3=
13_core.c
> > index 0c893c286017..6170c9daa30f 100644
> > --- a/drivers/iio/accel/adxl313_core.c
> > +++ b/drivers/iio/accel/adxl313_core.c
> > @@ -63,6 +63,12 @@ bool adxl313_is_volatile_reg(struct device *dev, uns=
igned int reg)
> >  }
> >  EXPORT_SYMBOL_NS_GPL(adxl313_is_volatile_reg, "IIO_ADXL313");
> >
> > +static int adxl313_set_measure_en(struct adxl313_data *data, bool en)
> > +{
> > +     return regmap_assign_bits(data->regmap, ADXL313_REG_POWER_CTL,
> > +                               ADXL313_POWER_CTL_MSK, en);
> > +}
> > +
> >  static int adxl312_check_id(struct device *dev,
> >                           struct adxl313_data *data)
> >  {
> > @@ -410,9 +416,7 @@ static int adxl313_setup(struct device *dev, struct=
 adxl313_data *data,
> >       }
> >
> >       /* Enables measurement mode */
> > -     return regmap_update_bits(data->regmap, ADXL313_REG_POWER_CTL,
> > -                               ADXL313_POWER_CTL_MSK,
> > -                               ADXL313_MEASUREMENT_MODE);
> > +     return adxl313_set_measure_en(data, true);
> >  }
> >
> >  /**
>

