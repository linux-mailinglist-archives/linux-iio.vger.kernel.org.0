Return-Path: <linux-iio+bounces-23934-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 121D4B5171D
	for <lists+linux-iio@lfdr.de>; Wed, 10 Sep 2025 14:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 384AE4E7883
	for <lists+linux-iio@lfdr.de>; Wed, 10 Sep 2025 12:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F2331D729;
	Wed, 10 Sep 2025 12:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DXwSE5kd"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E9B31B105;
	Wed, 10 Sep 2025 12:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757507808; cv=none; b=Bhr6dHHAv7skB1NJ7NCpZExrIeYl5jPbIKmEB0O7wVyxvH8pTMM7AK41/ER1T8nsOAy4GfF6f0NHQOf7Pm8Xvts4CrFzke7QOAWTpbP2/JJrawki1DBhc/wA7Bq9Rw3r/Syu4h9S2YReXWGh4nAahrjh+0mvGnYhJRl4MQ70+5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757507808; c=relaxed/simple;
	bh=nYObKXqubG1o7WaB8kLrAOqXQfHhVbURHrbID/rZ9U0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ab2+BSkmyMyuNkhdgn70tpORqoPFiWt79NPHvGTmnJPbOsmAcpDiljQ3G9Lr/E2xEOFP1idVLrEY3bj1c1rnFQdIEMqxWJge/N8hGnQruYfg7dLlgao6Sl5Lv0pVlfxofG/42RR0Ht2+6Il7SWTQeN6DfsjpJtGWN4Ob3kPCVDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DXwSE5kd; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-336c79c89daso60896601fa.2;
        Wed, 10 Sep 2025 05:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757507804; x=1758112604; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TKeVve1qQF013KWR2SZL4eaFR6YY0yjtRQqoC8mgkuw=;
        b=DXwSE5kdeHoFe86bHQuZMsmvmnrVDAFxumHfrEM8zzrtHMx8yqYSJbSHRa0dvvfsM8
         4Rw2+UUCJaXRRrJGJKjDCl7UIao89/UbOj5KBUW9rGrD5W6D6wGao50hwHQ12Q2ttJdF
         DRvzMfb/ZWVruvcfHEm8hJy98G5CuFCLwGryePmYGVUiP5sDEE8YEc/yz4shR/MoFPij
         gVa0DGfCUEOlAaBoS8oMQ3ZgqNct6An08jX6qN4/zjUb9cL65THLbZYRyS9c+g+Rddtv
         vCWSVMZwBh4g1h93pWQTUnrbW0XiotSic25xuMk66RUNNJD2I3+L9gBESymllEvRyIvq
         pXOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757507804; x=1758112604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TKeVve1qQF013KWR2SZL4eaFR6YY0yjtRQqoC8mgkuw=;
        b=LD+ZCD7Ph5nlrEFlOFwNLJTBB9K6VaMDGMVuodXdocf65ZM9crmsVP8wZGW8YaSmrI
         61V2wjva5PD87+oFFtOma3FK/9kMT5AJpubWPyJMn/6AocB2fweDdQuWmEGOeLRKlCDX
         u0f3txQEcyHwbErYjBbbe/SvBWalYCnaiFh3TCm+zzzPK5+qU1/YZj+hMmYwFKWxXRyQ
         cTDu2nSDUedFMZJ6+aZmavofTp7PTAlMJbHABJWzYzHdbNi4GK2j2XWZRc2RkaYv9js8
         cDorYZP7Ya3zUpHnUfoXUMPlBvZiozsfyLONZKmDK/9NTS/kbO6vbfHYFpbTxFJXwoVq
         z0qA==
X-Forwarded-Encrypted: i=1; AJvYcCUIO/zwueJMAHUsVXkrMSv9n5M+rbCeVBeIv1xYWJZ05aDJc9bcjS9LO4pVDuw0Mk4ctiU5U+/RApE=@vger.kernel.org, AJvYcCX5shPRNAQoggjN+T6/Wgy+MQYqtNq3It4/bkzMWQrhIEtHhIZMKf3vrcbN5xigQ6TzH3yk2M1wvDvnQHnO@vger.kernel.org
X-Gm-Message-State: AOJu0YxTlYPVKR1IIrz+JkdKpGDaZdWH3+XY/nXjBl3/AckKFCkZoRKl
	yo5pvU4jM0HW6l9OaYlCUWfNTTIkKABd3lShYF7KE3NFkPT0+WOVd0wxE1lCyxeKfIaRBzKlTZ9
	k+g/gvl67lBE7mpwW17EbjdSZIS13oRE=
X-Gm-Gg: ASbGncv9XzelL2fYJRvvTvfYjCf18kJheiaJ+pXyRtebLUSZRtI3wXZSp2dCQOtLVk5
	Wa96LYkOl1flmXxG+Q+kdCSiFCf25ytI4diejrWLbHlhE1X6/T3NL35QPcpyZtGnokJnC1mIpN+
	PVn7wQInDILENf7oHIhUMP7OSAFdNZhD2ABZq6KacpAzNLA59allqMK4rqPo2s6GD4GK1epUNd1
	AI965ENIZNb3Xj0SPTDPA5CZre6c64S8S5bHpkRR2qmwjh6/A==
X-Google-Smtp-Source: AGHT+IEwfn3j3xr2hwdm6er9BnDuuRo+yjJiLdV6kLnV+5fnmE3IurdHvAKdpHH3jrowbVkmyckbZ5Mkecbaaq5ZlkY=
X-Received: by 2002:a05:651c:1a0c:b0:336:c0b7:9546 with SMTP id
 38308e7fff4ca-33b5aac090dmr53414981fa.16.1757507804204; Wed, 10 Sep 2025
 05:36:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909194649.10512-1-akshayaj.lkd@gmail.com> <CAHp75VfpQ9c4cptnNGzFYakQxY7JjtUEMDsysS9KJ60xrzaE4g@mail.gmail.com>
In-Reply-To: <CAHp75VfpQ9c4cptnNGzFYakQxY7JjtUEMDsysS9KJ60xrzaE4g@mail.gmail.com>
From: Akshay Jindal <akshayaj.lkd@gmail.com>
Date: Wed, 10 Sep 2025 18:06:32 +0530
X-Gm-Features: Ac12FXwXn5dB9t5PJUHjD_S8k40gZTee9Apcl5X8ZWLU-V1zcWEwbYadNIjLB8Y
Message-ID: <CAE3SzaTZ8PXM_B8FBetOTSfz2myGZ=WzPp8h2d79Q95zKLq5hw@mail.gmail.com>
Subject: Re: [PATCH v7] iio: light: ltr390: Implement runtime PM support
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: anshulusr@gmail.com, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, shuah@kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andy,
Thank you very much for your valuable feedback.
I do have a small request regarding the review process. Over the past 3=E2=
=80=934
versions,most of the comments have been about fixing indentations and
improving code readability. I would kindly request if it would be possible
to consolidate such cosmetic comments into a single review round.

I completely understand that incremental feedback makes sense when the code
is actively changing, but if the changes are minimal, spreading out minor
suggestions over multiple review cycles tends to unnecessarily increase the
turnaround time.

Your support in this would help me address the comments more efficiently.

On Wed, Sep 10, 2025 at 12:47=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Tue, Sep 9, 2025 at 10:47=E2=80=AFPM Akshay Jindal <akshayaj.lkd@gmail=
.com> wrote:
> > +static int ltr390_read_raw(struct iio_dev *iio_device,
> > +                          struct iio_chan_spec const *chan, int *val,
> > +                          int *val2, long mask)
>
>
> Also logical split might be better, i.e. putting val and val2 on the
> same line. Then mask will be on the next one
Ok, will fix.

> >  static void ltr390_powerdown(void *priv)
> >  {
> >         struct ltr390_data *data =3D priv;
> > +       struct device *dev =3D &data->client->dev;
> > +       int ret;
> >
> >         guard(mutex)(&data->lock);
> >
> >         /* Ensure that power off and interrupts are disabled */
> > -       if (regmap_clear_bits(data->regmap, LTR390_INT_CFG,
> > -                               LTR390_LS_INT_EN) < 0)
> > -               dev_err(&data->client->dev, "failed to disable interrup=
ts\n");
> > +       if (data->irq_enabled) {
> > +               ret =3D regmap_clear_bits(data->regmap, LTR390_INT_CFG,=
 LTR390_LS_INT_EN);
> > +               if (ret < 0)
> > +                       dev_err(dev, "failed to disable interrupts\n");
>
> In event_config we assure that IRQ is enabled.
What do you mean here?
>
> > +               data->irq_enabled =3D false;
>
> Here we may lie about the facts. What will the driver do, if the IRQ
> is triggered just before this line?
I don't see why the device will trigger an IRQ, when we are disabling
the INT via
regmap_clear_bits before this.

>
> > +               pm_runtime_put_autosuspend(&data->client->dev);
>
> You have dev, use it.
Ok, will fix.

>
> But where is the symmetrical pm_runtime_get*()?

This is the fundamental approach of managing IRQ handling + runtime PM.
suggested by Jonathan in preliminary rounds and employed by many drivers.
"When enabling IRQ, increase the refcount, and decrease when disabling"
This is done because ltr390 does not have a wakeup functionality.

put_autosuspend is tied to disable which can happen in 2 places:
1. event_config.
2. powerdown (if irq enabled).

pm_runtime_get* is tied to enable which can happen only at 1 place:
1. event_config.

If IRQ was enabled before power down, that means in event_config
we had already called pm_runtime_get* and increased the refcount to 1.
This will come down to 0 as a result of either of disabling event_config
or powerdown.

Thanks,
Akshay.

