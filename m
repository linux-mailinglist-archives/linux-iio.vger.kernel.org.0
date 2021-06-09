Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7397A3A1F5B
	for <lists+linux-iio@lfdr.de>; Wed,  9 Jun 2021 23:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbhFIVuM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 9 Jun 2021 17:50:12 -0400
Received: from mail-qt1-f175.google.com ([209.85.160.175]:39689 "EHLO
        mail-qt1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbhFIVuL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 9 Jun 2021 17:50:11 -0400
Received: by mail-qt1-f175.google.com with SMTP id p21so7582746qtw.6;
        Wed, 09 Jun 2021 14:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:content-transfer-encoding:date:message-id:cc:subject
         :from:to:references:in-reply-to;
        bh=pBR5U/10bcnvewG9Pntj1qf0F6l1zpLrI1LdyLHqjWY=;
        b=vOpA7+wnaGUmqcvMLoY7T48tJZ1dG85cgXVEtnAx2U9TIZjjB1Jz+pLoPz7osA0x2v
         2iJdC49ajV3VJYaYPUEIqigv1wznRIman1rwfnvUUm2+Kjx+qlHeyZEFCgvjNvQB5bWB
         T/zE42Sir2O9D6wFtws4oXRMFCXb0cGf8Kx0TCqLPfJCpXQHu1vuiLZ3ziIoFBrtWWuJ
         X0AcccS93lphG0JBMSXch6oyLrW6NT6l1nm2TYMTRquhHToJS9Lm2gmBJJAciSypcaeu
         7mkXSlQDKKjCzFQwSFLjUoCVbH2Rj1mjkGR4yAJ+tKNcDZTEh3wAAesG8L6QXi4nZWJs
         7H2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:date
         :message-id:cc:subject:from:to:references:in-reply-to;
        bh=pBR5U/10bcnvewG9Pntj1qf0F6l1zpLrI1LdyLHqjWY=;
        b=IIkY7biOqXX2szeJ2sc7xZlTDL74PjPLg1JYOcL26sRg7z4k2EFaq+18MgWLq6+zSt
         AJrmiZVidFnvtNefuGK7bduXC5kNiPKnNfxiCGg/4V/Qw8LSXGnlH4Juq/3N2d5/li2s
         SwKlkDaaXnh0Kmdq67j79q15MgPus7KK8SGbcFpUZDTV7cSyJVLuVfXmT5S7wYk5nE4u
         HA/3MI90IC8JUCPvmDbS5NkNCHOElLZh6+6rTq0D7ddKaS1t0Z3sbp3n/YAPZAIY6wD/
         9gO/nbnccq1PSzra1FZ3hC4yTcGXCQ8R5F5+Dwq3mwh+hQHEdREwIcBMeRVTrt6jKEkS
         5lcQ==
X-Gm-Message-State: AOAM532ru6QV0536oOP17RkjsjJpLqR5Ad6Yr/6G7fi86YwvNUtW2WFT
        UOYzb2RAHz+HRsELruhrVOM=
X-Google-Smtp-Source: ABdhPJyHXu0xhsE/eujykYsIbwC4LxICvlReuxthRQQCUr6lAcEbQQtqp0CkiMZJqvbi4YyKRZezTA==
X-Received: by 2002:ac8:67d5:: with SMTP id r21mr2150256qtp.92.1623275219608;
        Wed, 09 Jun 2021 14:46:59 -0700 (PDT)
Received: from localhost (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id q12sm935640qtl.13.2021.06.09.14.46.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 14:46:59 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 09 Jun 2021 17:46:58 -0400
Message-Id: <CBZF1GGLRR7Y.2S244HIQOEERN@shaak>
Cc:     <peda@axentia.se>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>
Subject: Re: [PATCH v2 4/8] iio: inkern: return valid type on raw to
 processed conversion
From:   "Liam Beguin" <liambeguin@gmail.com>
To:     "Jonathan Cameron" <jic23@kernel.org>
References: <20210607144718.1724413-1-liambeguin@gmail.com>
 <20210607144718.1724413-5-liambeguin@gmail.com>
 <20210609213247.2ad09186@jic23-huawei>
In-Reply-To: <20210609213247.2ad09186@jic23-huawei>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed Jun 9, 2021 at 4:32 PM EDT, Jonathan Cameron wrote:
> On Mon, 7 Jun 2021 10:47:14 -0400
> Liam Beguin <liambeguin@gmail.com> wrote:
>
> > From: Liam Beguin <lvb@xiphos.com>
> >=20
> > iio_convert_raw_to_processed_unlocked() applies the offset and scale of
> > a channel on it's raw value.
> > The processed value returned is always an integer. Return IIO_VAL_INT s=
o
> > that consumers can use this return value directly.
> >=20
> > Signed-off-by: Liam Beguin <lvb@xiphos.com>
> This looks likely to cause breakage given that return value will go to
> consumers directly via iio_convert_raw_to_processed()
>
> Looks like this will break lmp91000 which checks for error as
>
> if (ret)
>

IIO_VAL_INT seems like a better return value here since the consumer
gets an integer. I can look at existing consumers and patch those too.
Or would you rather I drop this patch?

> > ---
> >  drivers/iio/inkern.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> > index 0b5667f22b1d..00d234e87234 100644
> > --- a/drivers/iio/inkern.c
> > +++ b/drivers/iio/inkern.c
> > @@ -618,7 +618,7 @@ static int iio_convert_raw_to_processed_unlocked(st=
ruct iio_channel *chan,
> >  		 * raw value and return.
> >  		 */
> >  		*processed =3D raw * scale;
> > -		return 0;
> > +		return IIO_VAL_INT;
> >  	}
> > =20
> >  	switch (scale_type) {
> > @@ -652,7 +652,7 @@ static int iio_convert_raw_to_processed_unlocked(st=
ruct iio_channel *chan,
> >  		return -EINVAL;
> >  	}
> > =20
> > -	return 0;
> > +	return IIO_VAL_INT;
> >  }
> > =20
> >  int iio_convert_raw_to_processed(struct iio_channel *chan, int raw,

