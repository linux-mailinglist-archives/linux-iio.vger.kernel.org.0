Return-Path: <linux-iio+bounces-23185-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A677B33466
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 05:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25F8A1712AC
	for <lists+linux-iio@lfdr.de>; Mon, 25 Aug 2025 03:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A90C226CF0;
	Mon, 25 Aug 2025 03:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fFpsJJo+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DAD92AC17;
	Mon, 25 Aug 2025 03:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756091002; cv=none; b=ZyP+GupjpoN4S32wiu8S1ah6PiE/BzY2jtvZJ9uicWnh9Ml3sMHsWrMmBra5a3pvuxevcIPWnCTDmivv9fikZK6aUcK6pC7MhUWotK6mlG15yt1/NbxyCD2UaszEe6pawVWy++qtwFerkZUFx2U4EnD1Bm4HeALt/ytKWoTbmSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756091002; c=relaxed/simple;
	bh=L+YG8ZIiGO46gNNpEJPdjTGtiTb5VapUZKUwrMIfvPs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nSEC9GrbkHvmR10M1GPnE9loBAJqP6Oa6r/9jHpgC6I/D06oKUGleQMIliQ0iQekmZTha7T9u2V3gsqrQrdYuXFGVsLQSgW/ixOJvAKeC2yFCFBiVmW/Bd+JMqwilZ1VFR8AgTlkjfwsDL/m27kMkwRSw0nSnnSAWMMyYA4MpfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fFpsJJo+; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-435de702f1fso2461074b6e.1;
        Sun, 24 Aug 2025 20:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756090999; x=1756695799; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kIfF/bUBS2PRy5s8bH2c65DdiYIuLHlslVTvH4qD7YY=;
        b=fFpsJJo+okulOUUh1yuVMuYHLhtYY/OomjL6bt/+XEWIp1S7+gAxnpFtvaVT/3CB19
         Z/M1rPOqTvFcgkWHUFVo7Q3fMcbzXe0rwe41knx7eodBBd19sMPc15F55PL/Yl5nFLVL
         95MAR1ipOQdP6ECXDjbBkb1ZeFSYW8AHlAZpicYS7pWLfTAHORXCIpUNzYphM/A9cBOF
         CpiL0gvac9kzAvcDsC/J77IJkD0BAw/63Q6cQC8XSiQQ4gC8Eo/D7I6+PZSZ6o1n7PPb
         Sjm63sGp6Pb6rmzV8cI4xvZY5Bu+qUC9ZyhDObTQwNalTMIuYtJO5rgtL0XPqb4rDXLE
         vOoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756090999; x=1756695799;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kIfF/bUBS2PRy5s8bH2c65DdiYIuLHlslVTvH4qD7YY=;
        b=CLxz+yQF99pqtdtLulISLHFwdZn+5sGfFyoBZeRD1D+1hi7zKWB4H38grrWzouOvBo
         plLlicq56BFIHUWsLCZ6lcQXqZSWsk9SMqcS7ax2n8sabm08xhBIg7/oMP4WDKLaKMUk
         r7tCzJ2KH4w3/cqpEM4FM0W1sf/f0CJqXFz6zHPHuGO+86z9ziNitsfNwuwWXIMN1v6w
         yIhgWBmQUoacs2kWGtP7IzzvxOCwTUP9F52rmfPoJlzBY9xqHBF/No6sNjQTubw5zXch
         KR/b+4XkG92D5jXqA2OoX8JMGABXNqBECN6d1xmE0fzxkMvbVfrTRzcp+aOujGVhM+eL
         h2FQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8TIGNApj8Bauuk9JNVkefNtsCGKWmb0ww0eLAjQOeR4gnsQmg5fmxSjIhBm6FP3O2Jl3kx1d7OXud@vger.kernel.org, AJvYcCVVTbGDnJaVJiunQrhDWv1bQQCss/VsAjP/QJ3X0+ISlJHL9jmKPEO/O/T8ETh5b1yIrN9npzEk0HiC@vger.kernel.org, AJvYcCWsNdTrVqyCsY70PA1BuCEmbJ9u1IepqFPdQh/jHPK+UhuZ854mPvCiLy3ZmbHy8FWQ+vYiU12NmGiDe2IN@vger.kernel.org
X-Gm-Message-State: AOJu0Yxybi+QhWNXXuf+zV/zFX3gnsDIsXl5RSBjMb0DnO8PEzMAjbpP
	iKHxPBo1tjpPRsF/h/6WLcO6ideji+8HJNc3VB1WLLJ2Z0mFCQFmrY+Y/QPlWPl0U+ZCmRT8P+Q
	v80npkVymD40LrOKMSfhsoWh11h1NGfA=
X-Gm-Gg: ASbGncvGol+eRBooHDdJPvSQk2kW/t2DGbdZLaiRy5j8e7ameeg15VBRJSbEtV0dGvt
	uGIMqCSZYMCSBlRRVQWDub8VYjk/1Kg59TLnTwwzTQl/cvOYS6pssyLRclK9hkS6HY0FZjTvzaz
	7srVXnwv83wOM/HGbmgGUbGT6Zp8GcWFBqWIyKUoE780FPDsFqJzRVGlBTCKFV1JQRMcIoHfTD5
	Hyl43YyHJIxJHIFtHXAMBkqQfzNPq29/nPlFppZew==
X-Google-Smtp-Source: AGHT+IFX53/kszwxRt1GhAgbINJJC/3ZV1X9ajkUooF/ir0imJBzt15fFyfp5Kdh/rslmxB6L5Tg4FR+MuMxXZdS/qQ=
X-Received: by 2002:a05:6808:3985:b0:41c:2a71:86e6 with SMTP id
 5614622812f47-437851dc8f0mr5795561b6e.10.1756090999405; Sun, 24 Aug 2025
 20:03:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814-tlv493d-sensor-v6_16-rc5-v4-0-81b82805aae0@gmail.com>
 <20250814-tlv493d-sensor-v6_16-rc5-v4-1-81b82805aae0@gmail.com>
 <aKXW5pGiN18DyIZ7@smile.fi.intel.com> <aKaMPMnGRyvKqTny@dixit>
 <CAHp75Vdw5X1Y057fpGjdvVGwKq0x0UBdm8py+m+55RbzXi1PJw@mail.gmail.com> <aKfYlP-yWdQi34db@dixit>
In-Reply-To: <aKfYlP-yWdQi34db@dixit>
From: Dixit Parmar <dixitparmar19@gmail.com>
Date: Mon, 25 Aug 2025 08:33:07 +0530
X-Gm-Features: Ac12FXxQWZrZa3bb-wdXQtG8WqmXlJ0TEPQu6HdbvGoJdXEg-xtC3turKV934ZA
Message-ID: <CAFmh=S0gAB93Gqnrt9NdtLA=cjOcYwy6+ECnwH-j9sN_sZYjZw@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] iio: magnetometer: add support for Infineon
 TLV493D 3D Magentic sensor
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025 at 8:10=E2=80=AFAM Dixit Parmar <dixitparmar19@gmail.c=
om> wrote:
>
> On Thu, Aug 21, 2025 at 10:41:03AM +0300, Andy Shevchenko wrote:
> > On Thu, Aug 21, 2025 at 6:02=E2=80=AFAM Dixit Parmar <dixitparmar19@gma=
il.com> wrote:
> > > On Wed, Aug 20, 2025 at 05:08:38PM +0300, Andy Shevchenko wrote:
> >
> > ...
> >
> > > > >  st_magn-$(CONFIG_IIO_BUFFER) +=3D st_magn_buffer.o
> > > > >  obj-$(CONFIG_IIO_ST_MAGN_I2C_3AXIS) +=3D st_magn_i2c.o
> > > > >  obj-$(CONFIG_IIO_ST_MAGN_SPI_3AXIS) +=3D st_magn_spi.o
> > > > >
> > > > > +obj-$(CONFIG_INFINEON_TLV493D)             +=3D tlv493d.o
> > > > > +
> > > > >  obj-$(CONFIG_SENSORS_HMC5843)              +=3D hmc5843_core.o
> > > > >  obj-$(CONFIG_SENSORS_HMC5843_I2C)  +=3D hmc5843_i2c.o
> > > > >  obj-$(CONFIG_SENSORS_HMC5843_SPI)  +=3D hmc5843_spi.o
> > > >
> > > > I haven't got the ordering rules here and in Kconfig. Can it be alp=
habetical?
> > > From what I can see, the order is alphabetical based on the CONFIG op=
tion in the
> > > Makefile and Kconfig, and I kept CONFIG_INFINEO_TLV493D after CONFIG_=
IIO_ST*.
> > > Isn't it in correct order? or my understanding is incorrect?
> >
> > I dunno, The file name there is with the vendor prefix, in many cases
> > the configuration option is with vendor prefix as well, but the file.
> Hi Jonathan, Can you please suggest best possible way here?
Hi Jonathan, When you get a chance, please share your thoughts on this.

