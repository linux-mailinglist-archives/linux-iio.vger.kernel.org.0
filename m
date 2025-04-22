Return-Path: <linux-iio+bounces-18515-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB4BA9724D
	for <lists+linux-iio@lfdr.de>; Tue, 22 Apr 2025 18:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A0741B641C0
	for <lists+linux-iio@lfdr.de>; Tue, 22 Apr 2025 16:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ADAE293B6B;
	Tue, 22 Apr 2025 16:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aSOKqJ8A"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62D6293B55;
	Tue, 22 Apr 2025 16:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745338493; cv=none; b=h97L0JAHhVYiWLb4wHhnblImMKXQATGqYMNWs2VF1Emtxfruqov30kELJ+I7njyisUaKK5JGxJT0vRf6YEEUvIRRNXXv+m28Hp2UdZ23tzFp256x3vo0Hvu7mZwVWBVoNpNPX6m+Qlf5tPuAJ/ioF+MdxGaLDe1AHvQzvF0+4T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745338493; c=relaxed/simple;
	bh=7laejMG3Z8D6gx1OrpZO40uSH8I9rUZIXpN2yMxaO4k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=stK8/RHAr5GRMHvTEnPBzjuo9iOagm9O1CkiCeL8P+XqoK6jKeBCm6gNFGPCzV+AkBGFN7qD9I/odvfd9MDCzYk0F+bHt0Pse3l8SUGZRk6atZJzSBS4OmYFnBNuohlwuq6i5fU2brjIRMFj2Dhf0D9Z2vaBQLebewJSQWVUUOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aSOKqJ8A; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4769f3e19a9so36437481cf.0;
        Tue, 22 Apr 2025 09:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745338490; x=1745943290; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5v+4lTQ3xb7CRwbB20c/aB6VOxfSp733arfrC9AeWZM=;
        b=aSOKqJ8A0PT3vqCvjXV2GaTPAQ28uelSKbnf1UBt6bq8HVD28PPzV+fVttOPDatdI2
         diazi2RDOKOm3Z81zPzEWLaP8zVXMEwm/tE24cYSQyQORP4FH/IclJvFtevtRjWfkMMS
         4xuHGA5SubwnJY8nRbotqJS3HaE464t+j4V9oz6ciYYkLqfM1HLzpOiW15Vws/HLiPAY
         J90OO/jwvqjIgrddE4MhG7DCuHczu0jLP6i30XYK3ok4YYfVev0jy67DHMs3erHZ60ML
         Hp2S7JL4MFCcI4fRIhq+j3WVAnon+8l1nmbluum1+ssn+ng3SgIMmLFOvp5BxnH9Rfcp
         zFuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745338490; x=1745943290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5v+4lTQ3xb7CRwbB20c/aB6VOxfSp733arfrC9AeWZM=;
        b=WMaDi8c6z8l/7ms2Z2Daje1ALzITeLHBwbUIyWuTrD/O5JUS6vcM76iOkRzftof1q7
         sAURZTa+scPxlmzAFYw0iRORkBNeyuqMPJsxSHV27GrQ4hwrcPZesjadj9NUPh44n88f
         ExTOPPY+OMNTZY7KYcG8S3eNnHo5nrl7i716mCJibeQgPNMXlaJ8FC5gVQ3+xdh0pYFg
         Ks1j0DURBmNF5vlB/Qk4WShIuWTfL2djHHUVBG/D7IWnDGEPw5dgg/PtIPmLWTgLwlRS
         lRoekvKVK6wr7a64RkWdAP8lpSig/xvcVBVzz1sEdkP7v3ohJ5Hb8LAdE5QHAf55MFOL
         AEJg==
X-Forwarded-Encrypted: i=1; AJvYcCU9aHfhxuv5cSMvHEA7w6uyDRpzQ6/VinvzVzrKsTLVvObsWJaJ41TtnYKWeQ2BrGzifLJqpbQjiR4=@vger.kernel.org, AJvYcCWT6Up3bOY5TB00n5D2oPOmR1l4HqxyigZKMNjBpy+9QWZ8FdkLwEdXCQSEAQ5CcUMeefiyCu8bDrfY55+a@vger.kernel.org
X-Gm-Message-State: AOJu0YyZYoHNZutHMIWXcURoMyPZLSyVsmMADHsLd5M2ZyoS8R5RHws5
	eyH1a0INWHAFMrDAGHzvuCR/02fnFgMpoRZvgCQo1ppNJXHOs5sP/5k7sH5ir5YXTRKgKvuDUKq
	s78WReGp4VJlso3e02SPFB4UctUI=
X-Gm-Gg: ASbGncugMnjxOO+GDuBU1pcabIpWqlZ5Mh8rgAcLb0GZ2LEvbxh4jyDheQ1J3zCUtIu
	b8X0EMlcjVHMvhOOjWjAUGljK1LKE8xbGGjap28IkSeG5adwZqq13nL74VPKLB+YrfgxI2rGZcQ
	eYhmGHg5kh9BMgwWNcUozDzntZvwFswEol7BoCAkgKrBpqVuvqTEhhKQ==
X-Google-Smtp-Source: AGHT+IFSXJh2tdSxxK3VzXuealELuBy1Wg2zNkg+nGmd99bFkaPZuTvsadoWKMJ/nwV8ag8f+tXhA8TE7xfY82MkTU0=
X-Received: by 2002:ac8:5711:0:b0:476:9b40:c2cd with SMTP id
 d75a77b69052e-47aec4dbc82mr280279011cf.47.1745338490265; Tue, 22 Apr 2025
 09:14:50 -0700 (PDT)
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
Date: Tue, 22 Apr 2025 12:14:39 -0400
X-Gm-Features: ATxdqUEXOYk7EcH1kwDC_9Cf9kzdnkH9WSeioP2PttTUhJwEoQfKE1Vatacff8g
Message-ID: <CAKUZ0zKJftqyiMDS1kPrqQYPMserCH7+UWt=v85UD4Jq7GdNKg@mail.gmail.com>
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
Ah right, the return from the spi_sync. Thanks.
>
> regards,
> dan carpenter
>

