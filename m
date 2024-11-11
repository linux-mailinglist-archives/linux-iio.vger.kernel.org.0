Return-Path: <linux-iio+bounces-12162-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B43ED9C47F8
	for <lists+linux-iio@lfdr.de>; Mon, 11 Nov 2024 22:24:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FCBAB25D49
	for <lists+linux-iio@lfdr.de>; Mon, 11 Nov 2024 20:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F9C1AFB35;
	Mon, 11 Nov 2024 20:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mQcroFBp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF328468;
	Mon, 11 Nov 2024 20:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731357390; cv=none; b=kWGak2fO7YrbMPUbABAsxRDauZfk8ADQNq6N7xBo8EFiq5U2vqA6iJkLetfXVHQ3W5ol3yp6WiUYMGSXFrMB9iqkjM9MLEmNgtsJKvEDDcUgwoQvfLewBV0YEKSBJnRmS2CGUpUAjao6S4iKI1yXUySGaXnjehtt05Be3X5myu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731357390; c=relaxed/simple;
	bh=wOsTfIEPVAc/E+aP97g3sPbLJ98st9z35lDbZEtTEeM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ub4i+g+wJRZCMMYipDiNrjexRB/gQUi0X26oyKuq8s3YLV0IJbERd0XLjLBeMGfmdYgybMuoIGI6EQzKfKqfeclMRHays2F6TFQb2GMee0OpOzeyI4HoGD+3uyioAcvdg/cQdgjYsbc/elESEaGo4x88Riiwlv7NII1aKxKLsq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mQcroFBp; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-460c1ba306bso39802631cf.2;
        Mon, 11 Nov 2024 12:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731357387; x=1731962187; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h4HZ0ndgBSEIXVqSFh0OWbpXw2/Yq3xXYi8N9kbsxR4=;
        b=mQcroFBpV6E9sL6dIW1C0sbNTIL4jKeZS0HO3cE31N3h2aNgCBIMkhenOwoqzoKebl
         L5bwebtR4lBBAd5xoYGofFJpmDVZHxUTFr3hFUNrGKHQJKXAimN4HSqcfBVwDRiganav
         qvzzUEFWTe2uAHFKrAizj47/ksvDBmrDCFIEOt+7RDWVVocTvSWBquJDZJk0Mz/+v3LC
         6xyKkF1Vjz7Uz3iq2yiD7VVsml/nI4jEI3FAaQpAtnnDAbvArbkDV80XeUwhJQQL8pKk
         6k4qEUBNI+i2egikOzNKbBeS1UpE+hbblVXy4X9F4kJDIwSXIXkks52WK3A6oWXFhxjH
         bMAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731357387; x=1731962187;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h4HZ0ndgBSEIXVqSFh0OWbpXw2/Yq3xXYi8N9kbsxR4=;
        b=BxlP/AuqNdslSBz2Kr1BdCsiTNiLPupXMK2wQls3p0gOhn1lMSR1Gc4GhsjlQLU5xr
         UubgGhRfHgIqAO4SxJmAKzyjNXxBBelew8eWfbBUCOhqqgzEK/lA9BQ2Mb53IDj68ojB
         8hfDJNFFjn5bvPUtd9kfIMaYXEm2xOnD5iRV7qX9Ksu7uHgkua5kDRTL3uNY8gSdlTjS
         Km7LQjdJF+MBzeL0h1jKHYGSAQ/PvikYww+QxdHmw/1iJXCnL5xN+TE8AghQy4iiQm9n
         Y6rJ7iEP7+VUUa527xtII7PduEJkyz3Kg8att00rxzwdolUsu5l8BfrgHZuLIUOK8sAk
         xzuw==
X-Forwarded-Encrypted: i=1; AJvYcCVtZ15qUCT/1HQX7kgachjheswjdFIBoj1daGkz++vX1YfjnY0+K9YCAEs5pvl3M+si5JmlL+tA7Rk=@vger.kernel.org, AJvYcCWo9vU0DX8v6jz6PzCjUeJZ/gctbzfGokOCtz2Lvg/tPFzfQHTiz7Z7mmcLAr75UrVdstPserdICD9ORihH@vger.kernel.org
X-Gm-Message-State: AOJu0YwTPjl2mER7zWwHr1XRKOpBroRtd1vTABqzkwvoVmKf/vBS9hmu
	+Kp2e+rRPiD16wlksCb71bx+E+9Rtre2BNQ2F+2Hhb804tfo6d7LnA99oy/zBfgonMISQudgBLx
	lNDjbpWiN3/IBMrSSkDu7Dpewmss=
X-Google-Smtp-Source: AGHT+IGGFUQEIwnDUiJPFPcrC/oKvlw+uylOh5ATXUlyzXultio50WXUAADdwKWpkEa1W8MriQQZjOqXmZVZqAV7yKc=
X-Received: by 2002:ac8:7dc8:0:b0:461:29d9:e86 with SMTP id
 d75a77b69052e-4630921899amr212981011cf.0.1731357387457; Mon, 11 Nov 2024
 12:36:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241111191934.17231-1-jiashengjiangcool@gmail.com> <8505aa28-5f88-4fcd-b3bc-cb5db89d2a08@baylibre.com>
In-Reply-To: <8505aa28-5f88-4fcd-b3bc-cb5db89d2a08@baylibre.com>
From: Jiasheng Jiang <jiashengjiangcool@gmail.com>
Date: Mon, 11 Nov 2024 15:36:16 -0500
Message-ID: <CANeGvZVE6fX5hV-p1xXsGR=Z=pABzDtvV9wY_XBbLwJUWNVtyQ@mail.gmail.com>
Subject: Re: [PATCH v3] iio: trigger: stm32-timer-trigger: Add check for clk_enable()
To: David Lechner <dlechner@baylibre.com>
Cc: jic23@kernel.org, lars@metafoo.de, mcoquelin.stm32@gmail.com, 
	alexandre.torgue@foss.st.com, u.kleine-koenig@baylibre.com, 
	tgamblin@baylibre.com, fabrice.gasnier@st.com, benjamin.gaignard@linaro.org, 
	lee@kernel.org, linux-iio@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2024 at 2:45=E2=80=AFPM David Lechner <dlechner@baylibre.co=
m> wrote:
>
> On 11/11/24 1:19 PM, Jiasheng Jiang wrote:
> > Add check for the return value of clk_enable() in order to catch the
> > potential exception.
> >
> > Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
> > ---
> > Changelog:
> >
> > v2 -> v3:
> >
> > 1. Simplify code with cleanup helpers.
> >
> > v1 -> v2:
> >
> > 1. Remove unsuitable dev_err_probe().
> > ---
>
> ...
>
> > @@ -492,21 +495,25 @@ static int stm32_counter_write_raw(struct iio_dev=
 *indio_dev,
> >               return -EINVAL;
> >
> >       case IIO_CHAN_INFO_ENABLE:
> > -             mutex_lock(&priv->lock);
> > -             if (val) {
> > -                     if (!priv->enabled) {
> > -                             priv->enabled =3D true;
> > -                             clk_enable(priv->clk);
> > -                     }
> > -                     regmap_set_bits(priv->regmap, TIM_CR1, TIM_CR1_CE=
N);
> > -             } else {
> > -                     regmap_clear_bits(priv->regmap, TIM_CR1, TIM_CR1_=
CEN);
> > -                     if (priv->enabled) {
> > -                             priv->enabled =3D false;
> > -                             clk_disable(priv->clk);
> > +
> > +             scoped_guard(mutex, &priv->lock) {
> > +                     if (val) {
> > +                             if (!priv->enabled) {
> > +                                     priv->enabled =3D true;
> > +                                     ret =3D clk_enable(priv->clk);
> > +                                     if (ret)
> > +                                             return ret;
> > +                             }
> > +                             regmap_set_bits(priv->regmap, TIM_CR1, TI=
M_CR1_CEN);
> > +                     } else {
> > +                             regmap_clear_bits(priv->regmap, TIM_CR1, =
TIM_CR1_CEN);
> > +                             if (priv->enabled) {
> > +                                     priv->enabled =3D false;
> > +                                     clk_disable(priv->clk);
> > +                             }
> >                       }
> >               }
> > -             mutex_unlock(&priv->lock);
> > +
> >               return 0;
> >       }
>
>
> Another way to do this that avoids changing the indent
> so much is placing braces around the case body like this.
> This also avoids the compile error from using guard after
> case directly.
>
>
>         case IIO_CHAN_INFO_ENABLE: {
>                 guard(mutex)(&priv->lock);
>
>                 if (val) {
>                         if (!priv->enabled) {
>                                 priv->enabled =3D true;
>                                 ret =3D clk_enable(priv->clk);
>                                 if (ret)
>                                         return ret;
>                         }
>                         regmap_set_bits(priv->regmap, TIM_CR1, TIM_CR1_CE=
N);
>                 } else {
>                         regmap_clear_bits(priv->regmap, TIM_CR1, TIM_CR1_=
CEN);
>                         if (priv->enabled) {
>                                 priv->enabled =3D false;
>                                 clk_disable(priv->clk);
>                         }
>                 }
>
>                 return 0;
>         }
>

Looks great.
But there is no indentation between "switch" and "case".
As a result, the closing braces of "switch" and "case" will
be placed in the same column.

Like this:

switch(mask) {
case IIO_CHAN_INFO_ENABLE: {

}
}

-Jiasheng

