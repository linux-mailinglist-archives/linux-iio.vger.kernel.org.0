Return-Path: <linux-iio+bounces-22262-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C2AB19DAE
	for <lists+linux-iio@lfdr.de>; Mon,  4 Aug 2025 10:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD7EE189A137
	for <lists+linux-iio@lfdr.de>; Mon,  4 Aug 2025 08:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F110424061F;
	Mon,  4 Aug 2025 08:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gbnTVP2p"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BFD239E7F;
	Mon,  4 Aug 2025 08:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754296457; cv=none; b=fvv2EqtNj0GsVGAeQa5995SecZ2rjmOyylqM67cYqMUthPs4p6lUuRbZSUU+r9Gj+wsIN68t5BmK6Vu0LgMQTHs9r/IHz/b4Jdt3SJvwmhmU7p6y5wap8Jre9U80HS/+wFavn6txI/AcYCVjuLd42sm2L1L5D+uPfWe5T5Dxdrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754296457; c=relaxed/simple;
	bh=dx2HpBOnPLsrb6oU+3Rzb9yQbsE1lsQjTTkyYt8N3jk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IqkUeWChE4bGE2F1my/Cc2rOUODgutWnvrjHbPDaQ5epCPQnCzpqjifJGrnqvR9JLTzTEdUw1O7PPy+ZcQpHuBnB9U54HU4t5wQ8AhjGM2d1YjpbPMTJzn45TBp3svA+aOcFDfNJblfJQJqhzfSWP08go282Nt64z/cu1uz0ZdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gbnTVP2p; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-af96d097df5so95946966b.3;
        Mon, 04 Aug 2025 01:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754296454; x=1754901254; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BVAaWRDfZ5hL4Va+pKEsiC3nSrkETUshGtURrIEYCSc=;
        b=gbnTVP2pIfa8pbJ+CV0T9Yn0Kvg1VEl7zgItpPscY8fIcyDuWAjTMrpRHSrj9ZVw9H
         f+mlAguefKk+cYatWrZt0RNx3mg1S4x2cYmN/V+HRkmL6l1r8G/ICI6nHcdnJn4jeJsS
         rTeYAOqVWFNFMAWKbpu0JaWbX+oLbzREaIDqDDf9HEZ+KyLnZUXBY5F0dCGPHbMOaQ02
         h4HhLgCbMxt9uMVblcqXZ02GjQXjAGKJqX/vDF+ll/XuSJEzIP6is8AEJ4Vxr9dm8ddd
         sXhhOSrRf+EfePMZIr/WWoYtSfBxKN+KrMrr4oAcvpma/cN2J8RIyTOG0V/g6jdPcFdU
         4hUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754296454; x=1754901254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BVAaWRDfZ5hL4Va+pKEsiC3nSrkETUshGtURrIEYCSc=;
        b=Yz1/1V+cB3bQ6M7dpGCh1xaj+YVURgXatIRnLSfA8/kvT9j6G4G4tOE840KImydUAI
         SsE7NCqxGIcgvMP7Ro6uVMktqrwDcqJfXjduwIwx6d5OlfFzkHrD0b8rFRPoUd6bm74J
         cp8BVEEQGk/runyVA9HYR0+egR5oDzkc4LX6SoK6rotAcJHZ0r4SHDsffRTcM7O606Kr
         kaNYGB4LvGenRP8PzhtG01O4OTLcpMntEa6YKKFleNX/iAkPIRlgTRJJh/7Vv5NXASBf
         ea3sutamm3QnuwVpjerwwfEChPQsw8g9jFKR8z1COtFvUOUi0WyEHyDsSDVG8f/L02qi
         GmkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJRwC2ceEGCbmMVvu3S6Rdv3YbJ8swqoqpQ7/sDxIyPnypOKpbHqwR8RLVkY4MhB9Mtr6yCRGkb/8=@vger.kernel.org, AJvYcCUxy3lNOasBLj3i+fWYylAMxh3SopjyHH7ceStkigcyDhFHeUcck8SLpkOwGgv9xtyf4ImyVpOGkWt3muhB@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5ehfy9qKX3s7SOtEEzqtMC/0fnIIH0ZDosxKmOYBliSuA+Cg2
	CVA4FcRd43A040a1rv8Zr1Yeh1iTO0dH4hFZpS6VO3AYxt4biyjvDP6V1IpIoRqrxgkuO47Ao6D
	HSRLpECljFvGgWTFGLXN3SyApzTRZXOs=
X-Gm-Gg: ASbGncsUycLbhNsCRsjMyLiiOZEn/X5COP+ECtOGSQa8aOQvjnWMiDk46C9XCLuqPLB
	7ciHICZvBwzk+8/F5gZo7CXpPM3vDcylFGo3/6+SXUTywmlnkV0rI9ACSF9oU3vLId9e1ZFLNJE
	CN79mv7C6uc3Ioz8aaYaJlTPlEx8MTVfUCMsbTjmY/M3r/kO7f4/5h9m937B6Lfm+utJd2sskHz
	P5Hf9mAag==
X-Google-Smtp-Source: AGHT+IE31LPTieeATPHB9TqfZ/rrNV8D2fuW9P6Ep8AruRk5dAs43xCQVMi8VZOonc4q/hIkzCr3X1rndXRHUQUdFyQ=
X-Received: by 2002:a17:906:f749:b0:af9:5b1f:b87a with SMTP id
 a640c23a62f3a-af95b1fbb03mr472319166b.20.1754296454132; Mon, 04 Aug 2025
 01:34:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1754041258.git.mazziesaccount@gmail.com>
 <0ed3a1e9346d84d20838e89a531e8d99f95bcb97.1754041258.git.mazziesaccount@gmail.com>
 <20250801120901.00004a67@huawei.com> <e91711f6-c943-402a-8502-52d8ed4c05a9@gmail.com>
In-Reply-To: <e91711f6-c943-402a-8502-52d8ed4c05a9@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 4 Aug 2025 10:33:37 +0200
X-Gm-Features: Ac12FXyJn5xlYsUNgP8wKbi3hxvmGp2X0QFbWIChLgEX-msCXhk1pwj4nZoU8mE
Message-ID: <CAHp75Vdyz6Pr1xm0LjhttVAO2GsLhWwb=OndvguSAqWqqhpMXg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] iio: adc: ad7476: Simplify chip type detection
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 4, 2025 at 7:57=E2=80=AFAM Matti Vaittinen <mazziesaccount@gmai=
l.com> wrote:
> On 01/08/2025 14:09, Jonathan Cameron wrote:
> > On Fri, 1 Aug 2025 13:07:13 +0300
> > Matti Vaittinen <mazziesaccount@gmail.com> wrote:

...

> >>      st =3D iio_priv(indio_dev);
> >>      st->chip_info =3D
> >> -            &ad7476_chip_info_tbl[spi_get_device_id(spi)->driver_data=
];
> >> +            (struct ad7476_chip_info *)spi_get_device_id(spi)->driver=
_data;
> >
> > Switch to spi_get_device_match_data()
> > which checks via generic firmware paths first (so DT here) and then the
> > old school tables.  Also returns a void * so gets rid of need to cast.
>
> Ah. Right! Thanks!

More importantly it returns _const_ void *. And qualifier makes a lot
of sense here.

> > Only works with all pointers (or a lot of care) because a value 0 is a
> > fail to match.  So kind of enabled by your patch.

--=20
With Best Regards,
Andy Shevchenko

