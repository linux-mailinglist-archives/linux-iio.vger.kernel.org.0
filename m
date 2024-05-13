Return-Path: <linux-iio+bounces-5022-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 856A68C4832
	for <lists+linux-iio@lfdr.de>; Mon, 13 May 2024 22:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 434151F220A3
	for <lists+linux-iio@lfdr.de>; Mon, 13 May 2024 20:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADCBB7E774;
	Mon, 13 May 2024 20:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=melexis.com header.i=@melexis.com header.b="KMVSlbKC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5F57AE5D
	for <linux-iio@vger.kernel.org>; Mon, 13 May 2024 20:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715632055; cv=none; b=T64yz1KabLC9BZt/dM9441uj0Oghr9MVuqLEK2AMuisJLbPfr/96P2iDB9nrhaCn5+KSz1vsb6ubZXhD9zMuJbAsQKcZApw+nXaExuxrCX4KNKni/zR9MMSlfayme7pOU5hQ3PuOdIfTM0uoxl+hxbWWdl/UZwCsxPAbjr77s/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715632055; c=relaxed/simple;
	bh=z9KO7ku6yvMz7x1mK14tqW2eKiUIAIQbx62bkD2qGs4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WuXUWdabCZMcqMhEfTSP0qOAPEeNI+AwwVCKQAsV4+MyxFgLDWceBeK732oN/i94QrTw1gVCbFKbG4gnbdHWBxarnOqXFp5tG3HeccaaLnZ/sNqvmSJ+UH/6uTtRFZVY1xtQlcGuRTNp59Hbb4MtKFdx1qC/clvtBQBsx6HF2bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=melexis.com; spf=pass smtp.mailfrom=melexis.com; dkim=pass (2048-bit key) header.d=melexis.com header.i=@melexis.com header.b=KMVSlbKC; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=melexis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=melexis.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-23ee34c33ceso3175309fac.3
        for <linux-iio@vger.kernel.org>; Mon, 13 May 2024 13:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google; t=1715632053; x=1716236853; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hf1RQRx8b6W3UeIlseZbddGJQzB0uZh+0KePHqIC66w=;
        b=KMVSlbKCdTsPG+N5tEg1Wx/qbF06piXBpL53ohRaGRPXuvseytp31a0n6YgXjsUXO8
         YMeRbqBsFQW52xoQ1Lh+uHLz1dgSKlHO+XqB1CrB+ADPUAB+S36Iq4+RFcY7KFIPmcTj
         q/UQrPeIG/YBGrmlhSfO38r5kLLBiI0DqlfEJ70+mYnf8CIytmLIyAZwWQPbStPvuVTn
         6CDajIVLhVN+VUm0Tvb5sC0ObSKWJ5Fl1T30Z+gQiLVQrkt8gTORw6K56DC/hJj8IrPd
         ah8xAUcehVNchhfiIPrOzWeV3d1yBVjwHhoJl9Znm+SkQ72H7JtLDKgoeD1DGbNsoOvW
         T0SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715632053; x=1716236853;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hf1RQRx8b6W3UeIlseZbddGJQzB0uZh+0KePHqIC66w=;
        b=MSK/UnHHtJjnYUtottMmbu+O3SnAr7+IGJy7tnCjQWXPV7fYG0ahADuPKfdyv0TyN4
         7gMA0l0Y17NuL8+X1sqGn+JFYgb1n8j3ukNWiTml/h14oFc8/j46P8TDQna+NN3IHLv0
         FQhgr5kvYhHmlia6LYxnFky13od2Ttu2LjtHHGALkonoV3GZ2XIe9mifqfamhQuz8hb4
         sY+nS19UJcPBWXIuzUHXtmhtwbxCjctqWSZDq6C+914++rCP/h5bBD0eywXlcFPK/rIu
         h8UzzQp+SlqdkdqevqEVMZATEj49GIMLEpofzdHWApQ1hjzR9M9HZtevCSlb8X2cNaPL
         kkXg==
X-Forwarded-Encrypted: i=1; AJvYcCUj4gceo+C2DaNwGdkSxrg2aeQCpP4rDGuecRUk9TdKpjJYvhbpox+7S3eGBg43e+8R0wIH/My7hj0v3GPgmhX3nsGFJpgHMduD
X-Gm-Message-State: AOJu0YxLzdzBIpRXe4YZ/w7uJPp2L/7TtG9UVQ3iaDbO6ANgXjADUt2i
	DGaEYuB5Meo7wjuBThOAshGB7tmPpCJylFuP60l9YfVr0iYxnzGgk2ScCc5L/uUX8oAm+J5HV1E
	I9/9MlMakTLcxb5pIrXFFeGfR/HPJBt/vFkiqQIbIA0bQEjc=
X-Google-Smtp-Source: AGHT+IFR8N5IYXFWob+zRch61N8BiaVJTq7N9z6xSculvkewWfVNMsAZwPELhMWeYYvUXXrdbEdF3t/ywjHDs/Lkcfs=
X-Received: by 2002:a05:6870:b9a:b0:240:62bb:ec01 with SMTP id
 586e51a60fabf-24172fcde6emr12466027fac.56.1715632053134; Mon, 13 May 2024
 13:27:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240513184514.3200222-1-harshit.m.mogalapalli@oracle.com>
 <CAKv63uvAe=RkZ6ytWfNkM5exy5ys5n2NwcJER=VMVAP+61-+rw@mail.gmail.com> <b83a3b5a-884e-4b9b-b962-3a625b3072b5@oracle.com>
In-Reply-To: <b83a3b5a-884e-4b9b-b962-3a625b3072b5@oracle.com>
From: Crt Mori <cmo@melexis.com>
Date: Mon, 13 May 2024 22:26:57 +0200
Message-ID: <CAKv63uumotFnisr9Z8JDF+UFL_cH7-iaDiTs9Vp1PVtbo-8jSg@mail.gmail.com>
Subject: Re: [PATCH] iio: temperature: mlx90635: Fix ERR_PTR dereference in mlx90635_probe()
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dan.carpenter@linaro.org, 
	kernel-janitors@vger.kernel.org, error27@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 13 May 2024 at 22:24, Harshit Mogalapalli
<harshit.m.mogalapalli@oracle.com> wrote:
>
> Hi Crt,
>
> On 14/05/24 01:32, Crt Mori wrote:
> > Hi,
> > I agree it is is copy-paste error. Minor remark below and a few typo
> > fixes in commit message. Thanks for your contribution.
> >
> > Reviewed-by: Crt Mori<cmo@melexis.com>
> >
>
> Thanks for the review.
>
>
> > On Mon, 13 May 2024 at 20:47, Harshit Mogalapalli
> > <harshit.m.mogalapalli@oracle.com> wrote:
> >>
> >> When devm_regmap_init_i2c() fails, ragmap_ee could be error pointer,
> > When devm_regmap_init_i2c() fails, regmap_ee could be error pointer,
> >
>
> Oops, sorry for the typo, I will fix it in V2.
>
> >> instead of checking for IS_ERR(ragmap_ee), regmap is checked which looks
> > instead of checking for IS_ERR(regmap_ee), regmap is checked which looks

There is another typo here in case you missed it.

> >> like a copy paste error.
> >>
> >> Fixes: a1d1ba5e1c28 ("iio: temperature: mlx90635 MLX90635 IR Temperature sensor")
> >> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> >> ---
> >> This is found using smatch, only compile tested.
> >> ---
> >>   drivers/iio/temperature/mlx90635.c | 4 ++--
> >>   1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/iio/temperature/mlx90635.c b/drivers/iio/temperature/mlx90635.c
> >> index 1f5c962c1818..2b61489d5ee0 100644
> >> --- a/drivers/iio/temperature/mlx90635.c
> >> +++ b/drivers/iio/temperature/mlx90635.c
> >> @@ -947,8 +947,8 @@ static int mlx90635_probe(struct i2c_client *client)
> >>                                       "failed to allocate regmap\n");
> >>
> >>          regmap_ee = devm_regmap_init_i2c(client, &mlx90635_regmap_ee);
> >> -       if (IS_ERR(regmap))
> >> -               return dev_err_probe(&client->dev, PTR_ERR(regmap),
> >> +       if (IS_ERR(regmap_ee))
> >> +               return dev_err_probe(&client->dev, PTR_ERR(regmap_ee),
> >>                                       "failed to allocate regmap\n");
> >
> > Maybe fix her would also be to this regmap error message to include
> > regmap EEPROM?
> >
> Should we make it like:
>
> "failed to allocate EEPROM regmap\n" ?
>

Sure, we can change it to that. Descriptive enough.

> Thanks,
> Harshit
>
>
> >>
> >>          mlx90635 = iio_priv(indio_dev);
> >> --
> >> 2.39.3
> >>
>

