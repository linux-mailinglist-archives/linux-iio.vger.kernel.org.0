Return-Path: <linux-iio+bounces-16983-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB8FA65704
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 17:01:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 262E38831D9
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 15:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E211A3031;
	Mon, 17 Mar 2025 15:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nr3UWXX5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620BD18DB1C;
	Mon, 17 Mar 2025 15:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742226755; cv=none; b=ZkxNpCaMyXEtA4ZJlSWboNwy1H7D4IGrgpz4ikICk5H9UAJG+X3EJRk1AYX6uKtG1MQ+7DJyTKd7vzKpXJWVP3HXapq2zOnoButs0YCtLE/UwAHIeE0vrNeqNQTWranOEl+6t1AIkh1TbrIRqoApkZMRfnuUNQq+GHk/+xJ5kno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742226755; c=relaxed/simple;
	bh=nTORzG9zIpB1tuECSA+WgYve+Q1rlgWbd3htR+1wW5k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OuX/i09+Cin2cyTl/vv7He4LbRcmwlGtUr1YMGsoMF2RZgJJ0e0j129VtFsgdmmALL37gGGwLMhtG89ormUgfLojUX7Kgp0LrV2rkz+tJFUKoi1hecnyJoy4TiB1zFxIS9A6dy5ojd6oDXtYNbcySqWc0Ds6SakwhHFMqveczNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nr3UWXX5; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5e5cd420781so8872258a12.2;
        Mon, 17 Mar 2025 08:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742226752; x=1742831552; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JYzo6yCD6QJcusCjSnO6TtQIIlANc6aE2nAD2UNl8+4=;
        b=Nr3UWXX5+78hKS2tSkxpjjue0LV6ULVj1cLmdAdBYAOIVfYQ0q738xFgc3lGWOMuF1
         zvQHQ0WV9U5KwjcRjA4VHETvgXsIBJoQCFh0VJbsWt+Pq08rtySJ8iiFxmdEBj37IIwe
         cuP/4ua0Z/9tawAeIJxHns8wvB8DNyFOAAux56MYq4MHrgwGze3gSyBlziqouKcyadPL
         MxVK4wWQN8aL++8pJHd/bxWXuVqha2kH0C/gK+Cm5MTtw8DVqgqZInWw7ZOcH0DdwxBK
         sLRyGreNdVhENXki9yJvBQ1LobQxt0Tn7yuzfvYmamZTDFTSY9hDrybMVUzOvdaRrcDi
         pr4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742226752; x=1742831552;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JYzo6yCD6QJcusCjSnO6TtQIIlANc6aE2nAD2UNl8+4=;
        b=YbrRQCVUrmNABqdD1j9vi/eTCGl9WIA4ucMWSat7lv10NiyfVVMoTubs6Qrr/a4Dv+
         +tKLTa6A3j4YDqfu8IBsmvUlOE5PiHie5xp6pgD3IypXX6pFGlqMMp331Li3+Wey2/tq
         BO/C0clCUfomc5lRVC93HpWGFJtLRaVNz6WHo73sxEzxh656ROkR1xn7gIksXHeIlJKx
         zgStBKMchs0Cfg1CwBpRHrdrgR6pBNTHHsnJSc6RGs+EvccDrTulHdxlwjIPNDCWy//u
         UYb46WsjhRVwYRsoPM5NXmLmP+Pj92REEB8ngzf19nS9smQW3TxiVdI55ke5NT1Uugaq
         bM7g==
X-Forwarded-Encrypted: i=1; AJvYcCVIlaF1W3akouQbz368dovnVcRpsB9QzWuOJB1Bf18aXCFu54ilaNVq+xE5JiVhByA5PFJ1JSJ6nBTjIYoe@vger.kernel.org, AJvYcCX6Vl8yv7tODEAyDqso5ly/rL0kXZtOxO8C3hAnbRyqdTwkqSOuc7d0F72aPBW9ZDRIWcR3Lw2nBAI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg9VZGaEqGmwbYFaMr6McCB7lsi3+UqAaoWMZ9pmaMnRdWqcsv
	FyJMsyTljDjUFSn4Ye2x4le3kYq9JPDl/nkC7tNuIaKoszYRo6i3Iq3McPWGfQ7IQ2sj1hYeZTD
	4WeJVnLOEL0Z8KRswD2M2kpmgSHY=
X-Gm-Gg: ASbGncsoIWL6RFnNQqkzoIQ9Rv3uOdB8QUHnqANB0YMq99wW1mOiaj6r3HV8IsZqidA
	OkIu6pjz8wAWMR/TUe5UojxWwLnF8AdmcC4RSbhVpaN7NInyDwQzy8IZNkrNvh1x8jz2LdM4++Z
	F7OpJdDW+hTT1WGtohzOOVd18mjVj5BNkxNejQZKI=
X-Google-Smtp-Source: AGHT+IEh7DkFsRuAVv2KyN5MtgSxRJ4NQrsA3c47jwlweh18VSkMzy1dJzBk6IMEOnaId3BCHwWsZJR5sXFi+i/1akY=
X-Received: by 2002:a17:907:d22:b0:abf:607b:d0d with SMTP id
 a640c23a62f3a-ac38d3fa372mr14844966b.16.1742226751422; Mon, 17 Mar 2025
 08:52:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313165049.48305-1-l.rubusch@gmail.com> <20250313165049.48305-5-l.rubusch@gmail.com>
 <Z9ctSODRTxI53jAY@surfacebook.localdomain> <20250317105540.4b4a586f@jic23-huawei>
In-Reply-To: <20250317105540.4b4a586f@jic23-huawei>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 17 Mar 2025 17:51:54 +0200
X-Gm-Features: AQ5f1Jof8H3EqpVxqJbk3ApXVYR6SEdjKIanV9oN2tFiDkE9bkkagRpS598m2UI
Message-ID: <CAHp75Vc=c=0yhtaKuiE4mZTTzQdrPywt89E7A1GuHha9=V=GUQ@mail.gmail.com>
Subject: Re: [PATCH v4 04/14] iio: accel: adxl345: introduce
 adxl345_push_event function
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lothar Rubusch <l.rubusch@gmail.com>, lars@metafoo.de, Michael.Hennerich@analog.com, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, eraretuya@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17, 2025 at 12:56=E2=80=AFPM Jonathan Cameron <jic23@kernel.org=
> wrote:
> On Sun, 16 Mar 2025 21:58:00 +0200
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > Thu, Mar 13, 2025 at 04:50:39PM +0000, Lothar Rubusch kirjoitti:

...

> > > +static int adxl345_push_event(struct iio_dev *indio_dev, int int_sta=
t)
> > > +{
> > > +   struct adxl345_state *st =3D iio_priv(indio_dev);
> > > +   int samples;

> > > +   int ret =3D -ENOENT;

Also note, this variable is redundant as far as I can see, just return
the error code directly.

> > > +
> > > +   if (FIELD_GET(ADXL345_INT_WATERMARK, int_stat)) {
> > > +           samples =3D adxl345_get_samples(st);
> > > +           if (samples < 0)
> >
> > > +                   return -EINVAL;
> >
> > In the original code it makes no difference, but if you are going to sh=
are
> > this, I would expect to see
> >
> >                       return samples;
> >
> > here. Why the error code is shadowed? If it's trully needed, it has to =
be
> > explained in the comment.
> >
> >
> > > +           if (adxl345_fifo_push(indio_dev, samples) < 0)
> > > +                   return -EINVAL;
> > > +   }
> > > +
> > > +   return ret;
> > > +}

...

> > Jonathan, I saw that you had applied it, but I guess the above needs
> > a clarification.
> Was right at the top of a tree I don't mind rebasing. So dropped
> this patch (kept 1-3)

Thank you!

--=20
With Best Regards,
Andy Shevchenko

