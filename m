Return-Path: <linux-iio+bounces-15801-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A508A3C666
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2025 18:41:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C382189B042
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2025 17:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D232F214233;
	Wed, 19 Feb 2025 17:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KRfbf6be"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A891B415B;
	Wed, 19 Feb 2025 17:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739986785; cv=none; b=Y2+x5JmDvRoUywTX6jds0VUd4FF3SANhgu3ZJ4uoDy3D9PetWmUTikn+nKnDI7IHRNvyRMTHBMn36/lg7CajNZVphC5HVwI2ufh4XHVWR/vdOsxRT+R0NMxsoLQVwiFKAtbck6mVlJ96tfExPMF9TJSSBdn2hMkpyf9S81UF61U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739986785; c=relaxed/simple;
	bh=4It1PU+B7XFgMdBjKT9ybzSCLozjQhDNh/RBMIG7cEc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kh3rPvylTEbJ05WfLf43T3Hy4msBJPCKTAfTl/9sMz5EI4sGhcJr8oORnp8s0w/CvmKBGE6sth5UwvJjK58IxC2voqi23tY/pCaqqkmdHEbPzHAGIhrlJjLqElxKpc0eC+NXYgf2HSO9YME4GVoDl7CAIxz21XcV3BbKUyKhCBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KRfbf6be; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-38f378498c9so46975f8f.1;
        Wed, 19 Feb 2025 09:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739986782; x=1740591582; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k8wYliwl6UOtHCOysjfqNPSlzww+g9jxkMxRAdHQVyY=;
        b=KRfbf6besRefOmK5asTAPiQCBr8k6oyh86ge1SIOIQ3TUZCKWJRhbqvaC8vzS6bxMj
         GO+saxFmFdgHZAWNeIT7tFZd3ygXpd3KMvXSWYjyWr0W+HNdhZhS4BZ43bk9gVcVv5KE
         ZxpjdOhDaTEc1FBMLczsoBrg4DrbHI3MiK0OMVBfMtakSrpBRPN+MtRpruh0DGPhoWZL
         7vZd6uAP7CabyMvbGHzDqt6yHDIIjv59ETWch+3FRG4gxzaRrH4DnglZo1tmcrXsRTW3
         XvnNjCWrdY0MHan0mxtAOwuDraLoDmcZdhG0q8ccQRiu8YhgRT0QNIVKZc8UZP5sfbW8
         Axng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739986782; x=1740591582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k8wYliwl6UOtHCOysjfqNPSlzww+g9jxkMxRAdHQVyY=;
        b=A2yhDYMgC2mv7uwXbr3FnT3qHEVvaIOe42oZBehvcdSWvutYpN80ghsPNy/OnuxOKU
         xBlc8b+kZQairC6G5vM0S5E8e1W9yS0C1peV93kJ8J2V9N934tcf8Sy3a4S3LhiVDU0G
         hb83bepIKJdCWW7qNZDuagaMPQzSisxFsLUiNl4sGlaocjcRxKCQ4nqzQ1eUZtXA693x
         3/A1whKlHLxfkljI6hWXl1/0QRsTxqXbSoDFRurY7LrielCDf2IsjZwwmZOdFhfn32Gx
         /UCeixc4Rsr+OcowTavqWYXa9OAg+oLLrtsRXia4mIWvpaStuIKGpq6ZcAVkvD0ur8KZ
         0yrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzvVcn9RllD6x7G5BpG/b3se6C+Y0Xioiy5AbB/furio6+FSnA5h5opon8GCwYJoqOtmtPP/iOD0O5lbpj@vger.kernel.org, AJvYcCWJdd4JaVExH4PkDz/bi/vrxT4BMovmJ9Gi98pUlvScHhzuSEnZ/bqFokwAhpTGxpNgd8w3SX0l6hUv@vger.kernel.org, AJvYcCWTQL3FPICR1eSNuV/Q/5W5qeHDucexjtz9bZeSph+n0LTH/6yus0RzCAp+adwamlyM+/TGJWTgGAjDUcs=@vger.kernel.org, AJvYcCWfSfjTzSUGJ59dR1cgGnQMgv/GUPNudxWTjewqMYIlTptIpLePbQsC90IQmPhnoj6q0FYOsSYchh8lQg==@vger.kernel.org, AJvYcCXGrtWR+C6fJ6Tn7BgoDi7/kZIZKjsA8xc1IOsMJFtHU2b0VVEgRaCeoCUGibjPivZqoNGqzw6qfkxW@vger.kernel.org
X-Gm-Message-State: AOJu0YxBPLo98pnyiUXTTMRcLD6o5KqWLrnNHVMhwczdSC23jtfLhyG9
	Ofykl9tj4UzYdeYd9LTGV33UnI4r+HrU5qXueAfq3p9PywK/zA58hxah5+vna1c1BXu82KX5vXs
	arEqbMYAmKPOnJNMyME8MLYdMEPc=
X-Gm-Gg: ASbGncvW67Ix4sQq7P+BUvdm3sPQ/gTVc475mLRs4QsQR01GW907a/WMT75YeO2jDoA
	zonpY6j2jnXAmgf6TQrBHym0OYS518bpuGIHR/2qhK1MqZc14IL3wOpl5k8ikTXt7f8gfk9LX8g
	==
X-Google-Smtp-Source: AGHT+IEyS3n7gqj0ex4KbPOptDtwVLwjsOmfhhv3WWfLv9zPiV55DmsbGLPpAuqV+3ItRvWlkBKbfteXPmxuNkeSagE=
X-Received: by 2002:a05:6000:2c1:b0:38f:474f:f3f3 with SMTP id
 ffacd0b85a97d-38f474ff5bdmr13969667f8f.13.1739986781750; Wed, 19 Feb 2025
 09:39:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250218132702.114669-1-clamor95@gmail.com> <20250218132702.114669-3-clamor95@gmail.com>
 <Z7XqKcOUt5niXzpv@smile.fi.intel.com> <CAPVz0n1_WQyOHhtEVAh53uhEUhZvqqZSEJh6XALtSrVfkMSLYw@mail.gmail.com>
 <Z7XzgfHcjyK_UZKv@smile.fi.intel.com> <CAPVz0n2WwAOb1UU7J7aDTdhXXCaAZkCpYjW_nc_CBRgkGWdEOw@mail.gmail.com>
 <Z7X3ZvQbSe75U-AR@smile.fi.intel.com>
In-Reply-To: <Z7X3ZvQbSe75U-AR@smile.fi.intel.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Wed, 19 Feb 2025 19:39:29 +0200
X-Gm-Features: AWEUYZlErtPnGBIjsmHfQD2f3-JQKBhMt1WzPgDf8uSaX-tKvCIgiy9477XzETE
Message-ID: <CAPVz0n19D1mS_prvMo-HD3m7U9+iknm49JSj5ydNUHoqjK7gZw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mfd: lm3533: convert to use OF
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Pavel Machek <pavel@ucw.cz>, 
	Daniel Thompson <danielt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-leds@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=81=D1=80, 19 =D0=BB=D1=8E=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 17:56 Andy=
 Shevchenko
<andriy.shevchenko@linux.intel.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Wed, Feb 19, 2025 at 05:13:15PM +0200, Svyatoslav Ryhel wrote:
> > =D1=81=D1=80, 19 =D0=BB=D1=8E=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 17:07 =
Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> =D0=BF=D0=B8=D1=88=D0=B5:
> > > On Wed, Feb 19, 2025 at 04:36:38PM +0200, Svyatoslav Ryhel wrote:
> > > > =D1=81=D1=80, 19 =D0=BB=D1=8E=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 16=
:27 Andy Shevchenko
> > > > <andriy.shevchenko@linux.intel.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> ...
>
> > > > MFD part is removed since MFD cells binding is unconditional, while
> > > > the device supports any amount of children grater then one. For
> > > > example, my  device uses only backlight at bank A, while all other
> > > > subdevices are not present and used. This patch switches to dynamic
> > > > bind of children.
> > >
> > > MFD does the same. Please, take your time and get familiar with how M=
FD works.
> >
> > It does not. I have tried. If mfd cell binding is missing, driver will
> > complain and fail.
>
> I really don't know what exactly is going on here, you can check it later=
, but
> I'm 100% sure that MFD works for only driver that are present. What you a=
re
> describing is how component framework is designed.
>
> To proove my words you can check drivers/mfd/intel_soc_pmic_*.c and find =
listed
> cells that never had a driver in the Linux kernel. They are just placehol=
ders.
>

This example is not valid since those drivers do not use device tree.

> ...
>
> > > --
> > > With Best Regards,
> > > Andy Shevchenko
>
> Please, when answering, remove unrelated context from the replies.
>
> ...
>
> > Let this driver rot for now, I might return to it. At some point
>
> Up to you. But thanks for trying!
>

Thank you for suggestions. Once I complete more urgent tasks, I might
do some tinkering with this driver.

> --
> With Best Regards,
> Andy Shevchenko
>
>

