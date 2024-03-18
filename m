Return-Path: <linux-iio+bounces-3590-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 276BA87E9E8
	for <lists+linux-iio@lfdr.de>; Mon, 18 Mar 2024 14:13:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A31A4B20BC7
	for <lists+linux-iio@lfdr.de>; Mon, 18 Mar 2024 13:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F140383BC;
	Mon, 18 Mar 2024 13:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xsp5mz4e"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560F5383B0
	for <linux-iio@vger.kernel.org>; Mon, 18 Mar 2024 13:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710767579; cv=none; b=b6eBgnpmbeQ2LnTSFZKt5hOf5d7qBWrFBfqrL7jQD54sSTQrjjNYNPCiM/QFzSyf1kGYoCQTvgv1n3oZrPotD+pnEN/c801j3v+iAs0GlHQ/pUTmU6+rT2HR8gC9uADVnUDLcVDKbm4mJ8YCvBpd8HiM06NFap2qf2sTITVRpvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710767579; c=relaxed/simple;
	bh=jYkAnM8eppUrlws4R1s9jQ/Qf2vFnNIaiWtULiZknqA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t+DSgw+rrFEHYM4mfcoBQWcWUZA1t+Lrw3g+uLHGh5qmK5Z0owwblBNKUr2cBDoJg/Wc+X6iwMv/Wzn+lxeJOOhGw4NY3UZU0xgZrYgRgIEtsUEM6kWS7WCAIFTQd9IUHjNcWfJyXR9m+/eqm+YXQvQkINNcF7Tc8KKTm8Vm3nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xsp5mz4e; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a2f22bfb4e6so599856366b.0
        for <linux-iio@vger.kernel.org>; Mon, 18 Mar 2024 06:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710767577; x=1711372377; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1AEFB2IpgBJ6bFRDSJcxBXudQWTfz8m0gY8E3WDEBVo=;
        b=Xsp5mz4eG+lgwjhUxGwH7cCESAwRlDyXaROVJrhoMaJoYLNltALoxj76bcWSVfMir/
         cXzMNYFW/L19oZnBZN3eAPfldruekbiRdS2BIu23RO6fzmZZXXQc2edtASIH0P0nstgD
         uqMrNwA+xFQQ2BkWOkRIZSbr7RjCKeQeSupsv4ute7QesnuyEq0Sv/6cCX1LwSJNds2V
         nwovidP6ZCrlZiF24yKOjlJ1z8gu8UbfHUQCc+4DVu+BUb0ydhk5sLDPwSTaojp2l1nH
         /Pk5nOvWOzaZj7Q8AtX+aOCKPm9yPtkt6rusW0RCXGcfSYPqLHjaqM0Lk3z8UePYYnYx
         U+jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710767577; x=1711372377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1AEFB2IpgBJ6bFRDSJcxBXudQWTfz8m0gY8E3WDEBVo=;
        b=LbbKv2UAiQBlAm5kDvQZe3wJx0xjTjjIbUTy2A4VvnJGGkCmUarUF9tF6yQkG5qwWv
         G30+zFWdu/Xc1iujOibFMkV3Mn53PpnoyqRLVcsnxi0KRJqF0tLqczHEhckVXcKM9p5R
         WSbsaESW2+4BZNxl7LU6v8bIayYJnfIjszgh5JXS/k3U00X68kXnCFajmYHwoG4ghbVn
         5Kt93RRP7Vb21sUTPAq61CLKp0K9dJDVHBEtvEC0Z9s3gJgSnOWaUqGPM8NULrOOZjOi
         ME5Fx6i64KcjI+xnEL2n4rptdYDB7p3P+zl6YZDQ4H3F1TuEZ5t53BYrWFzll5cBOYmJ
         Vsug==
X-Forwarded-Encrypted: i=1; AJvYcCWi+uLHL71MEBhPsMU7NsONHUmNlKMcq4Y6rMN06I5G4DRBa2l/ZrD247Z1BHDJ5aHDOZQqcD1EJP6LTN4o8hBbVjQzB/bTZkGu
X-Gm-Message-State: AOJu0YzY/0P7WnjYS+htoCIzuftEHfR59aQu0I6Vz9vm4dkuOMTOLlTz
	ALWkHDPaBmArIUQ76BUcLtFr/3Jwxa7wNTrv/uZOxUcGvXD1DL0YDMh308CrYafGXh7eSgNWX5r
	EavoTbAMtj2kNFTm83TpFzVGZLH0=
X-Google-Smtp-Source: AGHT+IGp7UX1tWSXOwRvYjAqzlKuzFX/aChngQ95vGb5seeK8MLrLkdbOJJCXakEDeeSEzxsxXQRbV+vjhxj6L0Segs=
X-Received: by 2002:a17:906:27d1:b0:a46:1e:d199 with SMTP id
 k17-20020a17090627d100b00a46001ed199mr7214337ejc.39.1710767576586; Mon, 18
 Mar 2024 06:12:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229-iio-use-cleanup-magic-v3-0-c3d34889ae3c@analog.com>
 <20240229-iio-use-cleanup-magic-v3-2-c3d34889ae3c@analog.com>
 <ZfXz6E086KPWUn8Q@surfacebook.localdomain> <20240318123320.000030d3@Huawei.com>
In-Reply-To: <20240318123320.000030d3@Huawei.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 18 Mar 2024 15:12:20 +0200
Message-ID: <CAHp75VcQbjSqvtDxcoAFkC84560UuZ1xwDu+kdpXHu9MKXuHWA@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] iio: trigger: move to the cleanup.h magic
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Nuno Sa <nuno.sa@analog.com>, linux-iio@vger.kernel.org, 
	Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 2:33=E2=80=AFPM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
> On Sat, 16 Mar 2024 21:32:56 +0200
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > Thu, Feb 29, 2024 at 04:10:26PM +0100, Nuno Sa kirjoitti:

...

> > > -   ret =3D bitmap_find_free_region(trig->pool,
> > > -                                 CONFIG_IIO_CONSUMERS_PER_TRIGGER,
> > > -                                 ilog2(1));
> >
> > > +           ret =3D bitmap_find_free_region(trig->pool,
> > > +                                         CONFIG_IIO_CONSUMERS_PER_TR=
IGGER,
> > > +                                         ilog2(1));
> >
> > Despite being in the original code, this is funny magic constant...
>
> Not that magic, build time config variable to avoid adding complexity
> of dynamic expansion of various structures. We could have picked a big
> number but someone will always want a bigger one and from what I recall
> actually make it expandable was nasty to do.  Been a long time, though
> so I'm open to patches that get rid of this in favor of a dynamic solutio=
n.

I didn't get you, sorry. Logarithm (by any base) from 1 is 0. Writing
it as arithmetic expression seems funny to me.

--=20
With Best Regards,
Andy Shevchenko

