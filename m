Return-Path: <linux-iio+bounces-18519-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF19A972B6
	for <lists+linux-iio@lfdr.de>; Tue, 22 Apr 2025 18:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C2594057B6
	for <lists+linux-iio@lfdr.de>; Tue, 22 Apr 2025 16:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9206F29117D;
	Tue, 22 Apr 2025 16:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bCMpJQkH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DF628FFE0;
	Tue, 22 Apr 2025 16:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745339187; cv=none; b=PjNkUDWzkMmEGSTI5w2qv4XdQgLBvfdQq+fZKEWL9jl2QhmU2Ki0I+lFNjEWycJ3wSWT5xlnlAWfZGDTF7vptB07bjdCOwNxtUsglwY3rBNrcDFuSswQdrKrr/Oi90S5BGmEU278QVKpB9UzwX6dP1Hb+3KOjduwJLe7bU3ETO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745339187; c=relaxed/simple;
	bh=rAuJs8Us15DzSe1EQoberk3uqEajJCM7zxnOl8M2oFM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qbj2AYNI1L/+iqPV0QfQqZVEP6KVdPwfeyEPfQmND6hxWcPMXtZu9dgQEbnjqhvsRQUfYlRGiPyAGEuC0hh2IKHDr0LRlMtecoYvUZxVHRBuKmynADeA2F3bAzMrVN5IcxfZ39cUgRAAQP3+3Ze323sOmeGcnffYBkIcCwUzx6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bCMpJQkH; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4768f90bf36so54466631cf.0;
        Tue, 22 Apr 2025 09:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745339184; x=1745943984; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7tyJ37WkX8bjUBji2qqv/BJikIEPwtC8Nr6ME5ibd/o=;
        b=bCMpJQkHqyNd5HR+J4YIF85aqBmrkCEFPqb7HwIhXsUAfG8lHfNbY/a5VTHyY0Kozg
         h3RMrtMeDdlYyGZ5avWmdY98s4o+DSt6x2SBYxi4u6Yj65ctZA9e25t15cXZB9D1cDpx
         5T22ptMaFVUC4KgRwMqVzSLekr/To4rZxoJwqMwyOADFCvAQUoV6HrZK79LCkePND2QR
         VwFT2FB18AQXVNgcu3kG5n0hmK8l1ZSBrc97LZqakjrLuU38o0lol3yPMtmGP1HAngIj
         Wxf9wLjjqqSPzanexKQPU0I1/SRY2aZxy4xdHn7ZwJa7tkP61dFgiSFpiMaPnbHEPr0f
         s97A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745339184; x=1745943984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7tyJ37WkX8bjUBji2qqv/BJikIEPwtC8Nr6ME5ibd/o=;
        b=EhOqS/EhRQEj8l0QGURZheGuhc2ksaFn/qtgZE/h5ilBK/YiaMsvRY+NF/QtieYcJF
         67vi7t9bTZPQfbj+dH+5DIPeuBfbVBiyEuGGeubWS/MpLmtdKvQ0vzBXfMLjPUU5doQa
         SmzyvKxpqD5hzJLQ0CQzGGg5fCphrF9WjiTJxaVaVPK1d16dYegOibytjHEwHXtYlSFa
         p6iS/O5TunaZNqQVB0LX5OrLMPV5cbAMoq6Lnfq2ZttU3MtGfP2rrwZX63P5IORdrbcW
         zCF1P4SvRfP5pYsLytnD9DhrI9WsmiLDBGuYI5XQNyQP8lOasUwntvSKIxEQkCLtb4WN
         lAZA==
X-Forwarded-Encrypted: i=1; AJvYcCUDOghIySey+JIgcU+U1LHzmX9+FSDMXIRA+iYHaX6xDnxunzpyqzJxv4UD77mpFIUuN6uEKD9GM0LAHQ0T@vger.kernel.org, AJvYcCV5KvfpW7f0tt4BomWGsXfmX90eUhDyyf3WnYnLqn75c7T4oBGWjw4Te2zUNsjixGQPcNOVV4qMZEY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyzo7+SGH/uHDcuh1/a5vZea2YG887Kp374CiZeG+FZzNK4iEp7
	Q/Tu7TVMMmxXvZWArxT7KS+gloJirmAaf9RJggdg05dmmKv05C1svG7uJriMv1K1l8SjUzyza6e
	da/5WsIbX8iJJyTGrFhgPfHKEdNY=
X-Gm-Gg: ASbGncvvMLg6zRD+PsZ1FeXPHGOAiEIDLu140Ibi8wxeOvIxgSAzJBY24hRIG+YWR8Y
	IDxQ0hX9oGs8gthjGZYGkCAbNBSi7WAnNzSVeeEJMU+UYaqJaswdVcWfgkEaDOMlbxVnCv4FRol
	YJRTYltYyuW7its5nyH7WMpR0e6ovGtZ+FNCt+KNAa81wr2DEKrUYvgg==
X-Google-Smtp-Source: AGHT+IEcYJ2/oybFGdU8VnxKA+y7blqNHbRLI/eEP0I5SpkFftBpU9T+C03FKxVVwvOENJgew8ZjEwrqtZtsjxC928M=
X-Received: by 2002:a05:622a:1343:b0:477:41fa:1120 with SMTP id
 d75a77b69052e-47aec3cc4a9mr274674531cf.12.1745339184595; Tue, 22 Apr 2025
 09:26:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250420174725.887242-1-gshahrouzi@gmail.com> <20250420174725.887242-4-gshahrouzi@gmail.com>
 <e712ec88-d925-4a73-8df4-ca3387a903fd@stanley.mountain>
In-Reply-To: <e712ec88-d925-4a73-8df4-ca3387a903fd@stanley.mountain>
From: Gabriel Shahrouzi <gshahrouzi@gmail.com>
Date: Tue, 22 Apr 2025 12:25:00 -0400
X-Gm-Features: ATxdqUEgvV_UQ6WqnrgikuXDxV3a_f2utlusbalE5VqAeZ7omZi6Cs0ce_HnGRc
Message-ID: <CAKUZ0zLjUOz1Gg129Dj01Vsa-jokTePggv=CAFOf=qzhE_Fezw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] staging: iio: ad9832: Add minor improvements to ad9832_write_powerdown
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: gregkh@linuxfoundation.org, jic23@kernel.org, lars@metafoo.de, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-staging@lists.linux.dev, Michael.Hennerich@analog.com, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 22, 2025 at 6:08=E2=80=AFAM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:
>
> On Sun, Apr 20, 2025 at 01:47:25PM -0400, Gabriel Shahrouzi wrote:
> > Minimize size of type that needs to be used by replacing unsigned long
> > with bool. Avoid redundancy by checking if cached power state is the
> > same as the one requested.
> >
> > Signed-off-by: Gabriel Shahrouzi <gshahrouzi@gmail.com>
> > ---
> >  drivers/staging/iio/frequency/ad9832.c | 18 ++++++++++++------
> >  1 file changed, 12 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/i=
io/frequency/ad9832.c
> > index a8fc20379efed..2ab6026d56b5c 100644
> > --- a/drivers/staging/iio/frequency/ad9832.c
> > +++ b/drivers/staging/iio/frequency/ad9832.c
> > @@ -173,13 +173,19 @@ static ssize_t ad9832_write_powerdown(struct devi=
ce *dev, struct device_attribut
> >       struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
> >       struct ad9832_state *st =3D iio_priv(indio_dev);
> >       int ret;
> > -     unsigned long val;
> > +     bool val;
> > +     bool cur;
> >
> > -     ret =3D kstrtoul(buf, 10, &val);
> > +     ret =3D kstrtobool(buf, &val);
> >       if (ret)
> > -             goto error_ret;
> > +             return ret;
>
> Fold this whole thing into patch 2.  Don't write something and then fix
> it in the next patch.
Ah, I forgot to respond to this part =E2=80=94 makes sense. I was initially
trying to mirror the original author=E2=80=99s style and build on top of it=
,
but I see now that all the changes should be folded into a single
patch.
>
> >
> >       mutex_lock(&st->lock);
> > +
> > +     cur =3D !!(st->ctrl_src & AD9832_SLEEP);
> > +     if (val =3D=3D cur)
> > +             goto unlock;
> > +
> >       if (val)
> >               st->ctrl_src |=3D AD9832_SLEEP;
> >       else
> > @@ -189,10 +195,10 @@ static ssize_t ad9832_write_powerdown(struct devi=
ce *dev, struct device_attribut
> >       st->data =3D cpu_to_be16((AD9832_CMD_SLEEPRESCLR << CMD_SHIFT) |
> >                               st->ctrl_src);
> >       ret =3D spi_sync(st->spi, &st->msg);
> > -     mutex_unlock(&st->lock);
> >
> > -error_ret:
> > -     return ret ? ret : len;
> > +unlock:
> > +     mutex_unlock(&st->lock);
> > +     return len;
>
> This should still be:
>
>         return ret ? ret : len;
>
> regards,
> dan carpenter
>

