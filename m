Return-Path: <linux-iio+bounces-24982-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D923BD07F7
	for <lists+linux-iio@lfdr.de>; Sun, 12 Oct 2025 18:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8EEF3BABBF
	for <lists+linux-iio@lfdr.de>; Sun, 12 Oct 2025 16:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7242A21ABD0;
	Sun, 12 Oct 2025 16:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BR6XTV9T"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDA517BA1
	for <linux-iio@vger.kernel.org>; Sun, 12 Oct 2025 16:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760287981; cv=none; b=UdpMyR4LJC5Im8BqSmUoKDvlO+Kzy73ER7x5GZxozqELilJnhEUzesv5C/2KM9g+q5To/W1R7N+xhov5qrFQ0jA2b2Oukq+Ufl2ufCuS/f0E3vnyN4Xy4yUlI/Tj7MX0CPjsz4QaXBEFRmLV7wCPY8p7HpyrYX3TFgOeT3X7AmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760287981; c=relaxed/simple;
	bh=is6hqOlUkMzHTcnRZLMTBo5nWV2BPzV5Tey9TxfEm6U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YisALlH6T9kUo09ELctRjPPvrZK6I49IoYZPrTFXmbo6ZBI4yhSQ0j2v+iy8DCp5bjvSGH4l9DMDkK1ltfF65azA+gcCr8PPE1hHAqPwVP9nY00l1o26aFQMkYQaWcHYVSnF04onlMsB2QtDGlHaV4gWQ0QWf0fh79alqwpzxis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BR6XTV9T; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-b3d196b7eeeso549985466b.0
        for <linux-iio@vger.kernel.org>; Sun, 12 Oct 2025 09:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760287978; x=1760892778; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9JZxGJaBIG3WMNgOZk70IosVrcFGLTtGDI3zyIQtP54=;
        b=BR6XTV9TPGsCSsCXhUaHq2QW0sq08dFwDbXfd7zBz8v7PFy5s9Kq8fXSv5565AOn4Y
         5XT1yRKB7IYwmBtUOC97BjgfqeECAG3KWJ96JYaGUtyiLv6fSDIwYKhY+LR7DeoJjQeQ
         fNSYAgdLvjekMdhlULKceP3kCIbbYx1vc7VV3okYYHsNZPd/2qd5wZ3MakJwg1opjKBt
         D+JXY/YWFzXJO4G3LB17sjS5PFbwLiYB46aQQMMKXL7Gk8ZgZo6V/LnFWxBi+OTnpe06
         w1Vq4nRziatDjwJCmca1G+5niaNMATm5GRSwmZC6gfSrYi8XnpiL8jDdQL4cc5md+x1n
         Hxiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760287978; x=1760892778;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9JZxGJaBIG3WMNgOZk70IosVrcFGLTtGDI3zyIQtP54=;
        b=dBBr38ustlonltl77NEE4DVajjNHNBvjtHVzMa1umBr2nMZZzGe6lX8xssPz0I615+
         B+ACX6aezSr7PRgdxjtddbnMrSWoLSaZ7ijKWXP3Cf8BiI7Aqj/IySyksOHUWv23gHTJ
         xuqoZ+s+tazqcqUWqQwjmavF1pXJZYnLtkSQqkg033Bqjb9qCfUkb6A32uh8KdqsJGyt
         wSpdAsc6s/nBzVeGPcAboPSFSCQgjv/Q0qaT4uo4Ncil1oPjs6pubINMdKeYMXetsArk
         4G57+17WbLxymXg1AENoh9fSL7EcEN8AcCXH1Ldi/msK/ITw4MpVjan9FtjNzRx8Vfqz
         hEfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxi5lrlGhG8FMEfVotST2aG3lm/HRppL/7fc+D8UViMbQh2/FV5S11c6a8oR/zkWlv8/+LsqSE1HM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwusFmriOm+6QWc6eelNblBmXACq0jV8HIWUR/QrEc1I/gatyjR
	qWDnRwh82Wo380xeXL6CFIcnxOQpBXVt3FPSFPOPDYgjTwgOYwukNdhnOyeA4eDtC3bT6FYrbqy
	LOFdLrAOqAXAj9YRm57Neg0YQqDIgfic=
X-Gm-Gg: ASbGnctRwNhtTExRG1QidjxvO1flrvTOo1F3Poq7TJW9+hbVud/p47VBzv1Cdnnt2jf
	9NmCyeEj++r6eI29ErFAjsvf/AnOmaBwTn7Wrfi5PjG//gYBBK/H1hy529xsOWDKV3OxOQxQVME
	iPZOQ8jdBnKazygj91kY+x0GjGyZIscT6fy1UU9eo/Hmd1pzy9AsWMtDp0nxyjtAzBU8j5Z0QXW
	zZlnavTtP3SzkYBbaOjRbmVhVthBKWO6JOFE5QxfoZQjpU=
X-Google-Smtp-Source: AGHT+IHYC6gZQ7sVGps73WqhA1pssx5WiOdWA9NawCEncOKl23yyV6N76hIZIr600VGaUVKRCSjt6piNcz8DHQRfwsg=
X-Received: by 2002:a17:907:7f8a:b0:b46:897b:d759 with SMTP id
 a640c23a62f3a-b50abaa3309mr2018683466b.40.1760287977711; Sun, 12 Oct 2025
 09:52:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251004015623.7019-1-raskar.shree97@gmail.com>
 <20251004015623.7019-2-raskar.shree97@gmail.com> <20251004141231.632c311d@jic23-huawei>
 <CAHc1_P7MU=BYf_8sbZqikpXpfuvAtLNJ2E_hmi-50ohoh+gQcg@mail.gmail.com> <20251012151130.797450e3@jic23-huawei>
In-Reply-To: <20251012151130.797450e3@jic23-huawei>
From: Shrikant <raskar.shree97@gmail.com>
Date: Sun, 12 Oct 2025 22:22:46 +0530
X-Gm-Features: AS18NWB6k3kWKKLVTx0bu_UemQDkCkAOaqI3qRe-tlwz4EjAekbo6ZOk5wZIcpw
Message-ID: <CAHc1_P7heCXwgH1tnqKTPAg0RpTPEM9Q4NUsGoOJMk6gqyXnmA@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: iio: max30100: Add pulse-width property
To: Jonathan Cameron <jic23@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, matt@ranostay.sg, 
	skhan@linuxfoundation.org, david.hunter.linux@gmail.com, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 12, 2025 at 7:41=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Mon, 6 Oct 2025 08:34:03 +0530
> Shrikant <raskar.shree97@gmail.com> wrote:
>
> > On Sat, Oct 4, 2025 at 6:42=E2=80=AFPM Jonathan Cameron <jic23@kernel.o=
rg> wrote:
> > >
> > > On Sat,  4 Oct 2025 07:26:22 +0530
> > > Shrikant Raskar <raskar.shree97@gmail.com> wrote:
> > >
> > > > The MAX30100 sensor supports multiple LED pulse widths (200us, 400u=
s,
> > > > 800us, 1600us). These settings affect measurement resolution and po=
wer
> > > > consumption. Until now, the driver always defaulted to 1600us.
> > > >
> > > > Introduce a new device tree property `maxim,pulse-width` that allow=
s
> > > > users to select the desired pulse width in microseconds from device
> > > > tree.
> > > >
> > > > Valid values are: 200, 400, 800, 1600.
> > > >
> > > > This prepares for driver changes that read this property and config=
ure
> > > > the SPO2 register accordingly.
> > > >
> > > > Signed-off-by: Shrikant Raskar <raskar.shree97@gmail.com>
> > > Hi Shrikant,
> > >
> > > Explain why this is in some way related to characteristics of how the
> > > system containing this chip is built (wiring, lenses etc).  Otherwise
> > > this might instead be something that should be controlled from usersp=
ace
> > > not firmware.
> > >
> > > Also, give a little more on why we care about controlling it at all.
> > > Is there a usecase where power use of this chip matters?  Mostly I'd =
expect
> > > it to be in measurement equipment with relatively short measuring per=
iods.
> > >
> > > Jonathan
> > Hi Jonathan,
> >
> > Thanks for the feedback.
> >
> > The pulse width configuration is indeed dependent on the hardware integ=
ration
> > of the MAX30100. It affects how much optical energy the LEDs emit per s=
ample,
> > which in turn depends on physical factors such as:
> >
> >  - The type and thickness of the optical window or lens covering the se=
nsor
> >  - The distance between the LED and photodiode
> >  - The reflectivity of the skin/contact surface
> >
> > For example:
> >  - A smartwatch/wearable ring with a thin glass window can operate
> > with 200=E2=80=93400 =C2=B5s pulses to
> >    save power, while
> >  - A medical-grade pulse oximeter or a sensor mounted behind a thicker
> >    protective layer may require 800=E2=80=931600 =C2=B5s for reliable s=
ignal amplitude.
> >
> > I believe it would be appropriate to describe these fixed,
> > board-specific characteristics in the Device Tree,
> > since they are determined by the hardware design rather than being
> > runtime or user-controlled parameters.
> >
> > Would it be okay if I send v2 of the patch with the above explanation
> > included in the commit message?
> Hi Shrikant,
>
> I'd have this excellent detail + examples summarised in the patch descrip=
tion
> and also a small amount of description in the actual binding even if that=
 just says
> something like
>    Description:
>      Pulse width in... . Appropriate pulse width is dependant on factors
>      such as optical window absorption, distances and expected reflectivi=
ty
>      of skin / contact surface.
> That's just a quick mash up of what you have above, feel free to not use =
this
> particular text!
>
Thanks for your response. Sure, I will update the description in the
binding and will
update the commit message describing the details and examples. I will share=
 the
updated version of the patch shortly.
> The inclusion of target surface reflectivity in there makes me thing that
> for some applications we may also need userspace tweaking or some algorit=
hmic
> way to increase or decrease the value according to skin characteristics. =
However
> I guess maybe it isn't that sensitive.
Need to check on this point.

Thanks and regards,
 Shrikant

