Return-Path: <linux-iio+bounces-12564-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A219D6BB5
	for <lists+linux-iio@lfdr.de>; Sat, 23 Nov 2024 23:05:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3034D161AC9
	for <lists+linux-iio@lfdr.de>; Sat, 23 Nov 2024 22:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD4D19CC21;
	Sat, 23 Nov 2024 22:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aaCcLPWQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2932905;
	Sat, 23 Nov 2024 22:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732399508; cv=none; b=RRfiw7/LeY52zDtETLgEpI7vGinpSzGym25XuEOkQZGAdwkCaPZrsTMTAm+CvSfQgMwsO/U8Mnc7JyeiR5IE2PWxuzGcWn18f/4Lnh6reMt3j3dv9MWaqR5M5aHioW57m8oMa8Qv1A7znHVsS8zR4XOUGtXoEMLo4M6e1RfAHE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732399508; c=relaxed/simple;
	bh=J7CgrHpaT0nZsv9H0LNACO/CoZCUz8w11Hc1fC836IM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DnFDNWaDLTuS9d4MY9Xn66BCRBzw5by61rHOIqCtKIGvNEYgu7NdVsHHN3JtYBePboPTEX0gDn+oP86SDm56BfLCRX9lBKqvgrGvpn+oSQUm5owD9dJ1HOdz2TmAqIburpmO0cPfZ/9pFeT/uZUvMcyWHWAX/NmwyOOXUcma7G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aaCcLPWQ; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-460ad98b031so23668911cf.0;
        Sat, 23 Nov 2024 14:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732399505; x=1733004305; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EkSO0ae1qgqzPLe+fBXvhHl1eDnIeDZzwTeg6SCFQSc=;
        b=aaCcLPWQkm3mngHDhwS0k67KQnMaqZh7qA6QgpAf7OyXpBdxsqB2zyyw76R4R5mRNK
         wP/BCOTccaWInODga4/Q52T7CMvfqnPvAw5vx8s7MkWRx4URK5dGD0abEivlsZ3hu74x
         eUjINVVyXKAqI7XGoEvxnM7AFXqUROCyYTtGO+B2TjGAQezlza8WM7vQPumEvgOwTDTq
         pobHDJqajpJYnwHLyUXl46UiWhod0lWz9MUc2PctnQEEFVdHKPgfBUINrYE6GdI5mulc
         TgYEZ6M86IllvKRGc6OBU2kyIXEJ13dkDDlgwlMorQlG71t0lXCHTb5ZM1pTlp7ZnbaJ
         q03A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732399505; x=1733004305;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EkSO0ae1qgqzPLe+fBXvhHl1eDnIeDZzwTeg6SCFQSc=;
        b=GJLb9TFufcD7T7xWfps2Lrz9aSxzI3QsmCzSarPJpZBYUskC0kQ2upA95Y3OPJRUB/
         mM9/gOpwAeUaIJ2o38TU70kFQN6ZpPWjDaydBc/HMb3RGP2RvdTZI7FD9qZlMuYa11I4
         tOzAPCV6B1X9aRZbCn0u0WcCRofnrsNGp/0PGFcdNVKDXYFiiuKM2lJ5grVoOpUCBZF+
         Pdn8SqJlrD22l7bql2AQsoySv9DJaN3u7cxA9tKrKIz2YLBKkgsp7095xFbNXVIZv5o1
         IfN+fibT4ULpkUefTRAjRW5mCkefx+YKlR43Bq+N/suS/geIrSbGLp9aYHl/IEW31lSk
         lVxQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3DYPdOH4lBOz4ax5cPdoeYyAKM8VFhw6HuetbNbLxN02C8l048JeCbSKg+q2qouXElySqGeYlYJQ=@vger.kernel.org, AJvYcCX8y3JbO1C7Xjp57m1Yl+ZIrT/9AA83vd0XpCIEjBsjPLzYqwL3Vh6E9i79mViqNB8dyDlpUzuRmKamub9c@vger.kernel.org
X-Gm-Message-State: AOJu0YxHv60+quoaB7tbocHD1Z+O6oOblJPBIT4Oj2ERGlMkIv4ciQnZ
	PZa2BGtRSeHRXF+468vPf3p6wOqIfZsW3pzg0xGZMOjlpixEF4JbyP22tLVtlFQyzCUBrFJMtmh
	mBSpXA02MzjQsOxeGY0RFNj7JFLuuQcEe
X-Gm-Gg: ASbGncv4JqVL8S/9DGTyVcCdn/u8kFN65I1bQxP0aAn8GHC2WDi7XdrolyN1F9Z9pS0
	QjEQslIbso6BaD2z/R1dXR0iHwNlppeuL
X-Google-Smtp-Source: AGHT+IEDHw6BpJXxtWPVqade1NgtWHuCJEZszqIDMX8X2Z8ZsSkxcHVPRBOEeAJKY7783cobYOMI6sXBGxrZqXJvc10=
X-Received: by 2002:a05:622a:1a1b:b0:461:1c54:5bd5 with SMTP id
 d75a77b69052e-4653d52276emr93948991cf.9.1732399505536; Sat, 23 Nov 2024
 14:05:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241111222310.12339-1-jiashengjiangcool@gmail.com> <20241123150808.1426c6f8@jic23-huawei>
In-Reply-To: <20241123150808.1426c6f8@jic23-huawei>
From: Jiasheng Jiang <jiashengjiangcool@gmail.com>
Date: Sat, 23 Nov 2024 17:04:55 -0500
Message-ID: <CANeGvZUZw3hxVGAUDhWjbWwVgfDnB33KfzitYwQ73YjLQYeqng@mail.gmail.com>
Subject: Re: [PATCH v4] iio: trigger: stm32-timer-trigger: Add check for clk_enable()
To: Jonathan Cameron <jic23@kernel.org>
Cc: dlechner@baylibre.com, lars@metafoo.de, mcoquelin.stm32@gmail.com, 
	alexandre.torgue@foss.st.com, u.kleine-koenig@baylibre.com, 
	tgamblin@baylibre.com, fabrice.gasnier@st.com, benjamin.gaignard@linaro.org, 
	lee@kernel.org, linux-iio@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonathan,

On Sat, Nov 23, 2024 at 10:08=E2=80=AFAM Jonathan Cameron <jic23@kernel.org=
> wrote:
>
> On Mon, 11 Nov 2024 22:23:10 +0000
> Jiasheng Jiang <jiashengjiangcool@gmail.com> wrote:
>
> > Add check for the return value of clk_enable() in order to catch the
> > potential exception.
> >
> > Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
> Hi Jiasheng,
>
>
> Should definitely mention the changes to use guard() to simplify
> the resulting code.

Thanks, I have revised the "v2 -> v3" in the Changelog to clarify the chang=
es.

> One minor comment on the code inline. Otherwise looks good to me.
>
> Thanks,
>
> Jonathan
>
> > ---
> > Changelog:
> >
> > v3 -> v4:
> >
> > 1. Place braces around the case body.
> >
> > v2 -> v3:
> >
> > 1. Simplify code with cleanup helpers.
> >
> > v1 -> v2:
> >
> > 1. Remove unsuitable dev_err_probe().
>
> > @@ -482,6 +484,7 @@ static int stm32_counter_write_raw(struct iio_dev *=
indio_dev,
> >                                  int val, int val2, long mask)
> >  {
> >       struct stm32_timer_trigger *priv =3D iio_priv(indio_dev);
> > +     int ret;
> >
> >       switch (mask) {
> >       case IIO_CHAN_INFO_RAW:
> > @@ -491,12 +494,14 @@ static int stm32_counter_write_raw(struct iio_dev=
 *indio_dev,
> >               /* fixed scale */
> >               return -EINVAL;
> >
> > -     case IIO_CHAN_INFO_ENABLE:
> > -             mutex_lock(&priv->lock);
> > +     case IIO_CHAN_INFO_ENABLE: {
> > +             guard(mutex)(&priv->lock);
> >               if (val) {
> >                       if (!priv->enabled) {
> >                               priv->enabled =3D true;
> > -                             clk_enable(priv->clk);
> > +                             ret =3D clk_enable(priv->clk);
> > +                             if (ret)
> > +                                     return ret;
> >                       }
> >                       regmap_set_bits(priv->regmap, TIM_CR1, TIM_CR1_CE=
N);
> >               } else {
> > @@ -506,9 +511,10 @@ static int stm32_counter_write_raw(struct iio_dev =
*indio_dev,
> >                               clk_disable(priv->clk);
> >                       }
> >               }
> > -             mutex_unlock(&priv->lock);
> > +
> >               return 0;
> >       }
> Add a default for reasons David mentioned and it also makes it visually c=
lear
> that we expect to get in here for other cases but they are all errors.
>         default:
>                 return -EINVAL;
> > +     }
> >
> And drop this return as unreachable.
>
> >       return -EINVAL;
> >  }

Thanks, I have submitted v5 to include a default and remove the return.

-Jiasheng

