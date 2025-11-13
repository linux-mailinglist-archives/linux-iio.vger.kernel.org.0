Return-Path: <linux-iio+bounces-26197-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CBBC2C5A048
	for <lists+linux-iio@lfdr.de>; Thu, 13 Nov 2025 21:53:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0C942351403
	for <lists+linux-iio@lfdr.de>; Thu, 13 Nov 2025 20:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CED63246E3;
	Thu, 13 Nov 2025 20:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q4IRIYiD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793BD320CD5
	for <linux-iio@vger.kernel.org>; Thu, 13 Nov 2025 20:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763067136; cv=none; b=XmzfrK2fdjyjXlLcZ/N/u52JnV2f4INnEBW+oaspOuVCkC7NaTeuULOLsG9GVvyJpO/nYvzNgwnEfdhhwFTcrpHzkx3wpKIllF9O/l0LAL2WWB46WB7x3Gz/OLksByFabUL/T1yHV28CSwVS5vHUR0gKDUzUUp6b1x9vOuhxo6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763067136; c=relaxed/simple;
	bh=xZmQNNMZsea2hQfm/jvzrIhTWGBHRJVU0auFRr/i++w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AGY6JhklOjsSfaJTTsYZO+i0yuvRRvpyuJwpmEk1Ow0L6JQRbJ2vx8BWIBfKwoMmwPEkW6Rq0lPuTA5ZlyrBDkbrAGkm4fguIPvZVrmW47qEFzB0JOleeaP16KpSXRspW5ldJe6bg4nfI0jSlrnTa3utwu+nZcLnMgwhGE9Om5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q4IRIYiD; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-640aa1445c3so2115340a12.1
        for <linux-iio@vger.kernel.org>; Thu, 13 Nov 2025 12:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763067133; x=1763671933; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/QpcgoIu2ks3DBOSGB3kqmMN9BZ4kGrvl73/ZFCUn84=;
        b=Q4IRIYiDVpIR2vFDOi18FX2pQNynSJ2XiIyXrX0KuMDhxakIkMvOVGGeJ6eht5zxIZ
         i7RMJhG53hEwk05JHWtO7zmh4MtknCJihPjRvIBJK9t0NfWSYNpUTv5tj3UpB6dFUtCR
         flkpXl5F37kZAYL20i5DubwRwBKgQuhZg1xuI48/mHTXXGbwztvqbnSe65cq+b5dabfe
         KEzV0SZd5E8ns8LO6qN8sf6Dm5LYplpJWu+Y1wEqZyCD340wjHK1q4wNqPkOLiS17ZZ+
         /7tpaF+7qNdCRZOZeuOfU3ENaiR1QBqL5KsW9Son2YOHpsp0/Gk1bejaPJ5Iwc0u1Hrz
         9hew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763067133; x=1763671933;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/QpcgoIu2ks3DBOSGB3kqmMN9BZ4kGrvl73/ZFCUn84=;
        b=LHrVpW8lipDiEBWapRlqapiHVHqjtRA/4GDYVOkdF9Gw1bMoUIezJAFPhqe/uaXu/z
         xuHl4sVnqAJexPa8dj1FXAWN2xKiNhAHCdsrDj9hig+mVqUZRIwnOh4iZ072XhDzQsF8
         yqhRByNRPu7N4gk7Kagiu0wQUj6EUGs+eZ4wVwkvY02403m4RQV8VOEEOR4LnzpZ9zH0
         MQ6YfUxQDMqC8/PSCYOyScN9uaYWVHwnfbw2Lg51CbZ07RsQwAPe1kCwcZ91Mw2DOb7b
         jkIyaVCEqBOdAC/MXl1Y9teM8TPMzgYbmLICRPzLG0Ogsd5Opifx/mNwN5s6+c5wBVv8
         lmdw==
X-Forwarded-Encrypted: i=1; AJvYcCXCkxKuok7hsKsalwaSmmv8KDYstM/CZsNmOnbdr6rArH44psPUlfoj1fcKHPEr7bdDJxsogTYFtVY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzQGobQ4teqqaxmS7bnLnwVBQNh0VeR3jf4uGB6jKsNPjcT2LJ
	R0SUwKYqTSgybvorLov/ortneap8ahaXCp2tstjwqZQrmUKzPb0V/tbGdy225jR6J3zNp7pexqK
	2SG6lqj+89apYsZN08BLlWAPiBpjmuI4=
X-Gm-Gg: ASbGncuzGVGN+iD2ayHqToHic5dTTcmOyynvdI6e3fRVBu3352K/yETEpt93RodNtCI
	Zgj9MdIhSnb++5xLQZ4WQ4rWMfAFK2LHKHYBb9chiPsGtLRLP1RyG+vAUk3ou7nr1D/h5Q6VnmZ
	ZLeBrSBkQLpoIqslpoDiD8to47lRaXHJg4z8aZbs4eaBJbcLKAF73v6+j8YfLYQj0LZDgIEkmgB
	SlOgnjD0bFk+uHka9fsXSIK7yMvGDzE0k9aWvHDCJNx5B8utF2MxmlZ/RZa3g==
X-Google-Smtp-Source: AGHT+IF76FljVgG5z/yMqwEMYVX8HeT7TsfOzksD8S8zuJmNS5uYTJqe0rSOdQD0tCK+gdLZla2Cl0YVH4sjvyOB6TM=
X-Received: by 2002:a17:907:3f0a:b0:b73:2299:b892 with SMTP id
 a640c23a62f3a-b736793d1b8mr63382766b.43.1763067132706; Thu, 13 Nov 2025
 12:52:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251110061409.726028-1-o.rempel@pengutronix.de>
 <20251110061409.726028-3-o.rempel@pengutronix.de> <CAHp75Vd9WCXR_QmefqPhWO1niMnESq7LAcN=eYvSiqkWfFrNhA@mail.gmail.com>
 <aRXnQZvyOLpYjg2i@pengutronix.de>
In-Reply-To: <aRXnQZvyOLpYjg2i@pengutronix.de>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 13 Nov 2025 22:51:36 +0200
X-Gm-Features: AWmQ_bnfzqzApDDqWpvBYYG6NkG5XHy1j8kKi1MuCfjcvQCMsTKPRy_ZN3bL9k0
Message-ID: <CAHp75Vc=90S2wedh2f+wxcLsGYZH_RSvjLasUP1SC-oSpt+nUw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] iio: adc: Add TI ADS131M0x ADC driver
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	David Jander <david@protonic.nl>, kernel@pengutronix.de, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 4:12=E2=80=AFPM Oleksij Rempel <o.rempel@pengutroni=
x.de> wrote:
> On Mon, Nov 10, 2025 at 10:46:02PM +0200, Andy Shevchenko wrote:

...

> > > - Handles both input and output CRC; uses a non-reflected CCITT (0x10=
21)
> > >   implementation because the generic crc_ccitt helper is incompatible=
.
>
> For the crc_ccitt() related part I wrote this comment ^^^ :) in the
> commit message.
>
> Anyways, after some more research, looks like crc_itu_t() should be used.=
 It
> seems to work.

I see, that's good news!

...

> > > +/* 24-bit resolution */
> > > +#define ADS131M_RESOLUTION_BITS                24
> > > +/* Divisor is 2^(Res - 1) for signed 2's complement */
> > > +#define ADS131M_SCALE_DIVISOR          (1UL << (ADS131M_RESOLUTION_B=
ITS - 1))
> >
> > Why not BIT() here?
>
> It's meant to signal an arithmetic calculation, BIT() is typically used
> for a hardware bitmask or a flag. Should i still use BIT() here or there
> is other way to describe it?

My understanding that the SCALE_DIVISOR is not a good name and here is
something like maximum resolution factor, and when MAX_ become in the
name, the (BIT($FOO) - 1) notation is a good  thing that shows
directly how many bits that MAX is based on the HW bitfield or so. But
also note that $FOO =3D=3D plain number, i.e. 24 is assumed here.


--=20
With Best Regards,
Andy Shevchenko

