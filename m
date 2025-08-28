Return-Path: <linux-iio+bounces-23338-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 82165B3AA3F
	for <lists+linux-iio@lfdr.de>; Thu, 28 Aug 2025 20:47:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 053937BA8D3
	for <lists+linux-iio@lfdr.de>; Thu, 28 Aug 2025 18:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D67E4278761;
	Thu, 28 Aug 2025 18:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ajgD2e4h"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006B426F2AF;
	Thu, 28 Aug 2025 18:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756406823; cv=none; b=Cibalcw3452VPDzl+itEiu1TGsa2QQ42m5ZdjmG78CTeQseRHln7/L+3Wfb6R0a3ZowWRROjtHj7FHdN86dYGUvGoYHq7Z/jPKCdGeYY/WwNUbIBG4wDArDlg9Ip6eRi1+7jDBiF/ADp+NhLAtJWb85xqV2+Ru5jUamwRMKTOjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756406823; c=relaxed/simple;
	bh=vdhERKYfOY+T/pT2jzq6anWaCIeNTGYp5ND7/mID50U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WBwZ5GnpsZ7vmYwzwk8bPR5Xx/I4evkK/VDuquiqoBtVmtLB4h8fGi9mL6XVQXeWjg7UHvJw4I//iCcssJRjPTshOpD7xAKJeZ0MSRH12CoXgFT1dCPN3n8N2o+jMvNv0DzQYFm37MHSG37SmbjvAjx2rpuxFrE/OhIYFlSoGp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ajgD2e4h; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-336b0b3d753so5395151fa.1;
        Thu, 28 Aug 2025 11:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756406820; x=1757011620; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q1r+LpWaRtkOKvYchwIX0i0/lFLrHnDiOSxWU9T+LDA=;
        b=ajgD2e4h1fQoJtbFyPpi98jlM/zxALGcIa8QXmymqqloyx2FfXF3L1GSdgvAGJymQJ
         9qOGi3kdbjxN5ns6JtvHH5qE8Z715V2G61bXfeSYZfrmP0JRwiOLV+niy5FURllWaok9
         WrD6vZpuc/kVSzXj4qvCvWjCBzzh75EGxM92jGJDafcvuGIadkKs2L84zcHYDVawIUDd
         Cx43qxtBae14sZRoBOar7surLyTBiKsnbtxayP3bQizZv5mgTOepWC+dxxmAJC1QWcJr
         vMzYD6kOShwKFtQJXOfqnCmGj7h3T9RBVsgdr6A4eI88VcXDDl5m/VALcBivhVmoNZUC
         8Xww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756406820; x=1757011620;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q1r+LpWaRtkOKvYchwIX0i0/lFLrHnDiOSxWU9T+LDA=;
        b=TtkgpLVJpnd6UXsKwOPL1MWSk/FywvxSlXQ06g60gjUkA3L7A+NyvUkY8pS/2M+4+I
         kXi2+qORrYpG/Y5cmCuS5EkAgiMeMtroJaDM3pjz8DvfuzNU4IOWlw7I91yBL/p9YOnf
         70MbG7PDKnm8J0Lbifo3X8Xm+BLTOWrMeLfoCKUqwp4iesJulHxpzLN8gWRkx9QjMrio
         TA7It1TFi//1fD83y9PcmmTxCdGt93i7z8b4APrONhDlkczXEunI9iuGi7YKnviwPuJN
         qea5G6+ZU5+K9n/GsnbX0IBeIvmduIbhPXpl24ghhEwnLXTHgDcP0HeNJgq2bUKa6aR9
         rUOg==
X-Forwarded-Encrypted: i=1; AJvYcCVAYvVtX8nhVod0HeQCvQC3GC/oivC9ADGa4MCEAHwHuOXGZmaW4uX/aQ0sOWvVX3TSEEzrs6OysEc=@vger.kernel.org, AJvYcCWQeHyrhgUwM/yo4YOQGbWBl8ZCFtd1vmm2d6IsNIocjWqN7GIiClaeh1iXSYMFYB5jyw3dqi2kNk4rLLIA@vger.kernel.org
X-Gm-Message-State: AOJu0Yxxssu0b4WF5mwaYhsPUpy6Iyj5G41jUqLu8zus4KCZaHS+4iId
	1JsCLsj4lBARW4cJ42YNMPrdblxzoFIJzFfMtf8fWIWER+zgyrpjOH+4a6mzAjUvjt3UzPC/Wdq
	yy5pVfqfCkWGvTIYQ/ABtgzi65W9V/HU=
X-Gm-Gg: ASbGncupCFXaaHKJrU9jiJ+mF66Bigey/Juw/5IS2CPo+jkAP9seQbYbSy9mXaq4vxC
	EwbVaIUBcOyWCQhcjMgiKzZu373zkyqHoDDlcUc9j3IQJIyv9D21QKZujoPoDCukTLp+9Rf/mIg
	ehH+yvTjQ+yrT5+1fK8S7T0xm1mLCp0EDl3ihA32rQqv6J+avxGQJ9NHCxUxdLEgx3oqM0ktj99
	5+t5BWfYNvKpIxQV3sC/R1AlT1RrgLcuSGtIzCPIF51LBznNguH1CNUBjwkwB0=
X-Google-Smtp-Source: AGHT+IFMC2ZGxBrZONWeNUQkwu4jL1gVEuKk1uI3/qQorZ/4xBGHg45CV+Pe/z7N00ztH3Se81uNof8UDI1QNxE+3hw=
X-Received: by 2002:a05:651c:550:b0:32f:3e83:437d with SMTP id
 38308e7fff4ca-33695ac0e40mr15036911fa.17.1756406819698; Thu, 28 Aug 2025
 11:46:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827191919.1361787-1-akshayaj.lkd@gmail.com> <CAHp75VdQB673=qXBp0mPUHxQGxM=Z1CNSmEpP82OprVn++Y5uw@mail.gmail.com>
In-Reply-To: <CAHp75VdQB673=qXBp0mPUHxQGxM=Z1CNSmEpP82OprVn++Y5uw@mail.gmail.com>
From: Akshay Jindal <akshayaj.lkd@gmail.com>
Date: Fri, 29 Aug 2025 00:16:47 +0530
X-Gm-Features: Ac12FXxoQ5jjdCMvg5RcgTSxcd0BSKYFj3rzxUWDKhSKayf51bd0T1qeu9_8F9I
Message-ID: <CAE3SzaTJTi3bHnqNbAfQ3W2jHcmhQHqa2ZtKE7=2BnP+onJv-w@mail.gmail.com>
Subject: Re: [PATCH v2] iio: light: ltr390: Implement runtime PM support
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: anshulusr@gmail.com, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, shuah@kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 7:17=E2=80=AFAM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Wed, Aug 27, 2025 at 10:19=E2=80=AFPM Akshay Jindal <akshayaj.lkd@gmai=
l.com> wrote:
> >
>
> > +static int ltr390_read_raw(struct iio_dev *iio_device,
> > +                          struct iio_chan_spec const *chan, int *val,
> > +                          int *val2, long mask)
> > +{
> > +       int ret, retval;
> > +       struct ltr390_data *data =3D iio_priv(iio_device);
> > +       struct device *dev =3D &data->client->dev;
> > +
> > +       ret =3D pm_runtime_resume_and_get(dev);
> > +       if (ret < 0)
> > +               dev_err(dev, "runtime PM failed to resume: %d\n", ret);
>
> If it fails, there is no point to read the value, it will be garbage
> or even can make the bus stuck.
>
My rationale behind this approach is that earlier ltr390_read_raw()
had all the functionality
of the .read_raw callback so the return value whether success or
failure was of the core functionality.
But now, since the core functionality has been relocated into
__ltr390_read_raw(), I felt the return value
ltr390_read_raw should be the return value of __ltr390_read_raw().
Hence I thought, it will be better to
just print dev_err for runtime PM failures and return the retval of
__ltr390_read_raw only.
Let me know your thoughts on this. Will make the change accordingly in
the next version.

Thanks,
Akshay

