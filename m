Return-Path: <linux-iio+bounces-23552-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56326B3D518
	for <lists+linux-iio@lfdr.de>; Sun, 31 Aug 2025 22:11:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 934DB189172D
	for <lists+linux-iio@lfdr.de>; Sun, 31 Aug 2025 20:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D5023BCF8;
	Sun, 31 Aug 2025 20:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NpUmktAf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7291BD035;
	Sun, 31 Aug 2025 20:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756671108; cv=none; b=Z1SpTW7S9a2dDlenSnDHFRrjX/srvamlgIt8gN0UIpxThAyFttCQVDGDuWHDRiQQY4ctSRMbjHhiMZHLzUenxBm0yhe9J+HC45CzkeD+FMGLb/y3ApkTjY90Q947tofxBm1lDYYPqY9zsoFwDH/d3WNB53llBIgPGR9e6w2jPxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756671108; c=relaxed/simple;
	bh=6H67u+4oxDFrdz412txcZZheZfZJZ2RLm4X2H2fmp80=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jckI/9F9boizVe4loYXQdGWE5gBlqtWdL2Fy31D20f526UzP4oAUu4+vS3qUHTVDw5yDGIdb6BzGLEeTKplv5ACLKHZBrvCGDvmtWF8crOE17gR2o01+zo7VnY5gwtEbtf5r6Mhhuq+5Zu9DRSx6YObJnIo0FLALZFcwz7Tzky4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NpUmktAf; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-33682342180so33030121fa.0;
        Sun, 31 Aug 2025 13:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756671105; x=1757275905; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S/rsJztFn2dQnriSdwYd7Xtxh6EMuS4sZlUErffZbNw=;
        b=NpUmktAfoHEwT5PBDa7+6FasSD9DhtgWfwQBwezt/8OVYZtuhwovpf9PHknidjwjoe
         G1Cjsn+VJB/s2M9WiabWe0lbB7Si29B8tBObnDe8HCjHTcflHDcwx/pePryQjbXQn8Um
         skopMqS5KsRUVxXsLql8Jm2NwvuzabuSdeVaBwSiQBMo31nLY78TXfdwTNZU5HumP+LA
         Dan2GpyAlLb9gUiS/QguLpjC8LAYsEGBtOvacKjCeZtiYwnf/qkYsg60OlA1s/LwcK9N
         vXzZFdUXSopX4f1wZVcRArKe2IC4+O8m4MzTbrLZkLWTTGMSQL121GrlmHNQ2Pcec9Cy
         So3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756671105; x=1757275905;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S/rsJztFn2dQnriSdwYd7Xtxh6EMuS4sZlUErffZbNw=;
        b=Kh+wFRj7+dp/qQyXnTNQuX2VH6FsOj6Hg/H+LrCvKXhPUE3RZ80McduMlc1efLKy4S
         5nSesoBen6H+Y1qsXunUptvgbly/eqxYunAHmS1TftEb14azZDQD/eDXp08KOJAUun6g
         4IrfUxcJ/jsURX/30Z5LINA8CqouFb1QQB/ekOAYI/Gbt+KywrqgzDBUZK6kYsW83Blw
         pzglXfPcDMneoOCnNxoF2g1NMxIbXIrl4HmkAOheKT1LSqEp4LSJTLgTqcOWNrtAfgiS
         KANnk2DyNahd8PEElwg42W812j9FbHhyCWtd04Te+q8rI3C4QSkxEw5BT53SsIZyhs2/
         RACw==
X-Forwarded-Encrypted: i=1; AJvYcCVkkFVLz0v2IdZmyoZWh5k1K9g0Jv7eS9ioxWdEtylyiXc1LRxeuDJg8BiTwQm09+hapuhIlZoYD8sSkV52@vger.kernel.org, AJvYcCVsB1FO4RNhWyGwDqy+jOVLb57qyNaeBR99wWRXl1tEg3T+Wc/d4pq+iwITVDjcz+XvLVu3k9wVgl0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywqhm3xFMGJfuUDEa5GXEvxZzDsC9sjSM9nINETMKz4NUeraH6x
	WZqUF4MIK/YeXDgNhCgvRs8RpFFR7B67eE9Yohuc/vn2rP5cVzuGu5tV6PHKI6nOC03zUPkWD3k
	y0B8Fz8tp9UxE3iFQTT4Ud/bUFaipWiDmV7sK
X-Gm-Gg: ASbGncvP1nA1NcW8FgmRz7kX3LTbtDEs+/R+yvZL7VTr0QPdD5PdOavCYXU5P1MeVlv
	yZiLCeVMh00bpoite/2G/ZHzoFnBPIU29i34DVqHx5wP8+ETCWUEAMmVCVvEBhuIx3l71z6NKIC
	h7R5YyYepx7LMZ5XIVR+nojEzHJ7/+6n55jLpD9y3PJWA1060sGke6YrJuZKa94aIgeiix9mpdm
	ShWL2JosRLYcTpl+0o0FRu4uqjQyAQSvC87xvqP8w==
X-Google-Smtp-Source: AGHT+IH+3pIySK60IUBXAkuCAZWQF5s7yFh6eRBwC3TFM6FFQCQTg4eF9l8n/MSJF+uOrOyEft3601rdT1V1OhJkN64=
X-Received: by 2002:a05:651c:1504:b0:336:e13b:d531 with SMTP id
 38308e7fff4ca-336e14b36d8mr5225331fa.8.1756671104623; Sun, 31 Aug 2025
 13:11:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250830113502.83102-1-akshayaj.lkd@gmail.com>
 <20250830192538.3b508c5c@jic23-huawei> <CAE3SzaSezCtZ24vz4_qSmLow_MfU3p7XgdVUBKD3Yj7LcAK-6g@mail.gmail.com>
 <20250831161149.27547d16@jic23-huawei>
In-Reply-To: <20250831161149.27547d16@jic23-huawei>
From: Akshay Jindal <akshayaj.lkd@gmail.com>
Date: Mon, 1 Sep 2025 01:41:33 +0530
X-Gm-Features: Ac12FXwWM7zo3O7p2itUBjykuWl4BV1pFREuDnwx42XUuRIE0mukXsG-abMu3a0
Message-ID: <CAE3SzaRncowQSu4DDT6020hBJiJs0GGkNkjzi8CPxJ5kukoFPw@mail.gmail.com>
Subject: Re: [PATCH v3] iio: light: ltr390: Implement runtime PM support
To: Jonathan Cameron <jic23@kernel.org>
Cc: anshulusr@gmail.com, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, shuah@kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 31, 2025 at 8:41=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Sun, 31 Aug 2025 11:09:26 +0530
> Akshay Jindal <akshayaj.lkd@gmail.com> wrote:
>
> > On Sat, Aug 30, 2025 at 11:55=E2=80=AFPM Jonathan Cameron <jic23@kernel=
.org> wrote:
> > >
> > > On Sat, 30 Aug 2025 17:05:00 +0530
> > > Akshay Jindal <akshayaj.lkd@gmail.com> wrote:
> > > >  static int ltr390_debugfs_reg_access(struct iio_dev *indio_dev,
> > > >                                               unsigned int reg, uns=
igned int writeval,
> > > >                                               unsigned int *readval=
)
> > > >  {
> > > >       struct ltr390_data *data =3D iio_priv(indio_dev);
> > > > +     struct device *dev =3D &data->client->dev;
> > > > +     int ret;
> > > >
> > > > -     guard(mutex)(&data->lock);
> > > > +     ret =3D pm_runtime_resume_and_get(dev);
> > >
> > > So this makes me wonder.  I'd been assuming our disable was only turn=
ing the
> > > sensor off, not register access?  Seeing as it's controlled by a regi=
ster
> > > we can clearly access at least some.
> > >
> > > If that's the case why do we need to runtime resume for debug registe=
r
> > > read/write?  We shouldn't care if the sensors are reading or not. In =
fact
> > > if we do turn the power on we changed the state we are debugging whic=
h is
> > > probably not a good plan.
> > Are you suggesting to remove pm_runtime_* calls from all the functions =
or
> > just the debugfs function?
>
> All the ones where it's not needed.  So as far as I can see it is only
> needed when actually grabbing date.

These are the functions where I have used it currently.
static const struct iio_info ltr390_info =3D {
        .read_raw =3D ltr390_read_raw,----> reads sensor data, scale,
int_time, samp_frequency from register
        .write_raw =3D ltr390_write_raw,-------> writes sampling
frequency, scale, int_time into register.
        .read_avail =3D ltr390_read_avail, ----------------> no reg read
        .read_event_value =3D ltr390_read_event_value,-----> reads
interrupt threshold value from register
        .read_event_config =3D ltr390_read_event_config,----> reads
INT_CFG register
        .write_event_value =3D ltr390_write_event_value,------> writes
threshold value into register
        .write_event_config =3D ltr390_write_event_config,-----> writes
into INT_CFG register
        .debugfs_reg_access =3D ltr390_debugfs_reg_access,-->
reads/writes into all registers
};

Going by your comment, I think I need it only in read_raw and
write_event_config.
There is a similar sensor, ltrf216a (same company, liteon). There only
read_raw has
these pm_runtime_* calls. Let me know your thoughts. I will make the change=
 and
include updated testing details.

Thanks,
Akshay

