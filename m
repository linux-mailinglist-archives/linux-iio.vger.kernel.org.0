Return-Path: <linux-iio+bounces-18219-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D2CA923D6
	for <lists+linux-iio@lfdr.de>; Thu, 17 Apr 2025 19:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 998108A3F1F
	for <lists+linux-iio@lfdr.de>; Thu, 17 Apr 2025 17:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4111256C72;
	Thu, 17 Apr 2025 17:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gfmspfac"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1662561A9;
	Thu, 17 Apr 2025 17:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744910254; cv=none; b=MOKQz9KUirLYqhLoWIr7c3pzEoYVU/90nFKL6IdeHvt6P5XwDRVXUO9hCgvEy5WHW4q0NInmBUPSeeXubHnqOndRdxxRyi9U9ih/WubYHZKr1wYk3/AQ6EJRXUR1WIwpuQP20vBwYqLrvH7/m8MmtABJpiALlk5SNvMqKCOjfPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744910254; c=relaxed/simple;
	bh=wx499ycm9iMUeg9/XtG7M5uzQ8E1UILvPtuJmr0RsHA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VacDI64ORDFs7OSgABedGfjIWR6S30jjASvyLjl1PEbxUV0laDGZ682hbB+Otauyz63pNPbFjYct60rZ7yEPM/d9aS+y7LhajdKvtFejO7p3fXUt+Y0xel1LUxpsnar+8HpQnCJgSY4GjH0dQebOZB1+lQB3WXMzZu9fLtQRlGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gfmspfac; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-477296dce8dso9592631cf.3;
        Thu, 17 Apr 2025 10:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744910252; x=1745515052; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JHZpLc6rfjTxqfskBHqOLWs86EpAqWAQaDT3lSIQ988=;
        b=gfmspfacoz10zubrTrB4yM4aHmeD202KU2sL6HOcRPjvkmTardMzP/BOqRqKgl1sYx
         3WgWMASarxF7G32Bp4Sakknf+j92CxIT4mE7UEvRPt4x+RSMuy4j8HviaGYJN+yICm3S
         g5TLKAT+m6MZLZ23NVzOG8jx39lQQHj+GzsAMc9wER5IfICsbaBgzow8JlAI1ka68QF9
         soTX9EvdJFdprs6R5ztHC4haBUTq0rAGGexY8sJxXsGu73dhFpiqv9yN8QAbNkvrFg38
         xGSJ4lHf38xnwLe1FVxWFhFc5ZZK1qWdUHGYG2/qjNiJ0ondDyS7I88DPxBcUr7lfa5V
         Y/yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744910252; x=1745515052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JHZpLc6rfjTxqfskBHqOLWs86EpAqWAQaDT3lSIQ988=;
        b=b9CvYNS3JOXZ5XaHr5/US+eQJw7IlbsvwBcgU1cp2mJPKQj7Ot6MkMTAiZFOX6RQxB
         lM+wSLWfRpsmFFfOtvIGbg6D2MlpT2IE0CPaz23evzmC8P7IQ99J8hxfaWLOc/kNQ3RK
         jzlbDS05ka9q+GRp2ZodPaB+8FWuQMKYiaVP9kSCkZN6XGsQLXo1zl67EA/23fvNVetZ
         rTzYtLzGl9JUlHh+ugagjM5Yu1PyUQkaSNhz/xNu2eVKSqmcOuYj4Y+Ip24ckezWSndw
         EYSOgyU6fqCTsUATo9/aOeDyHSeenVTGzCMDFr9n07c8pb3SLIycayhgBQJshbNc5CoP
         hadA==
X-Forwarded-Encrypted: i=1; AJvYcCVZhtiZpSuD3uH94JTizEirCUFJUSYTBH+LlH065b4vt7lPZoqAS5vE7+8JIT45j6hsOjUm+YLqqHDzsem8@vger.kernel.org, AJvYcCWzEbItyM9D5c5Amn+oBl5qxz6JXijuwK/nXwVfJMNRIngSzjnDgSR1wFY6gAX+8J1sxHHH2Ed6eF8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbzSBJ869krxKOH+Uut4lEUJyF6AJSXp9MlgnukiecFMfnIam2
	I+OD3QF+noAEZcyldftKWyvBWrgBTYul6iDK+1j0uvz2SAMgicLPqvZxySKHC7js8tTMtqijMt/
	eNWE6vFQOL/tm6COCuqdTTeCcVOI=
X-Gm-Gg: ASbGncuumYBvBq4N1GTFPptDxsjhSzHAQANawoLg6TA2yJQ6modUXx0T9dlFjKn+++/
	y4iNye4VYW/LlW7q8GGdI/K6c256LmgeY75rW0+1XSMNb+e14wgN6h13vbInZCflNeJ11kktAla
	drsu6IlzbOUv/kHWd3Fb4IxLrOe/xeil5pzIojm4RAGOq6kjijNVRYyg==
X-Google-Smtp-Source: AGHT+IHrN1LAyEaWz4RcHr4w32yDhY2iO7WSexBVoxKjujo9K/rZ/NeNuZdLD3gLh+PjbY6xZ/zuCbgGubE4rAQomjI=
X-Received: by 2002:ac8:7d4b:0:b0:475:16db:b911 with SMTP id
 d75a77b69052e-47ae9ef2e3cmr6254201cf.52.1744910251706; Thu, 17 Apr 2025
 10:17:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250417143220.572261-1-gshahrouzi@gmail.com> <56edfb88d3f31939fb343149bfad436f24671f9d.camel@posteo.net>
 <2cc70f19c1b001ea7f2cf0632618d060f69faef0.camel@posteo.net>
In-Reply-To: <2cc70f19c1b001ea7f2cf0632618d060f69faef0.camel@posteo.net>
From: Gabriel Shahrouzi <gshahrouzi@gmail.com>
Date: Thu, 17 Apr 2025 13:17:21 -0400
X-Gm-Features: ATxdqUFI_-gN5dJMaRrIIgFMyeycwmxLkVpzAmG56fSWNPKwN0smSUOrphU_NmU
Message-ID: <CAKUZ0zK58DgEN6C9U34dyxrVuoq3PoQFQ1_O0ve4GQYy+bUJOA@mail.gmail.com>
Subject: Re: [PATCH] iio: frequency:: Remove unused parameter from data documentation
To: Charalampos Mitrodimas <charmitro@posteo.net>
Cc: skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev, 
	gregkh@linuxfoundation.org, jic23@kernel.org, lars@metafoo.de, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-staging@lists.linux.dev, Michael.Hennerich@analog.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 17, 2025 at 11:57=E2=80=AFAM Charalampos Mitrodimas
<charmitro@posteo.net> wrote:
>
> On Thu, 2025-04-17 at 15:53 +0000, Charalampos Mitrodimas wrote:
> > On Thu, 2025-04-17 at 10:32 -0400, Gabriel Shahrouzi wrote:
> > > The AD9832 driver uses the Common Clock Framework (CCF) to obtain
> > > the
> > > master clock (MCLK) frequency rather than relying on a frequency
> > > value
> > > passed from platform data.
> > >
> > > Signed-off-by: Gabriel Shahrouzi <gshahrouzi@gmail.com>
> > > ---
> > >  drivers/staging/iio/frequency/ad9832.h | 1 -
> > >  1 file changed, 1 deletion(-)
> > >
> > > diff --git a/drivers/staging/iio/frequency/ad9832.h
> > > b/drivers/staging/iio/frequency/ad9832.h
> > > index 98dfbd9289ab8..d0d840edb8d27 100644
> > > --- a/drivers/staging/iio/frequency/ad9832.h
> > > +++ b/drivers/staging/iio/frequency/ad9832.h
> > > @@ -13,7 +13,6 @@
> > >
> > >  /**
> > >   * struct ad9832_platform_data - platform specific information
> > > - * @mclk:              master clock in Hz
> >
> > Hi Gabriel,
> >
> > This seems to be a leftover from
> > 566564e80b0ed23ffa4c40f7ad4224bf3327053a ("staging: iio: ad9832: use
> > clock framework for clock reference")
Ah ok. I will include this in the body as a reference. I guess for
small clean up patches like this, they would have been most likely to
be included in a larger patch that covered other changes but
forgotten. In this case, should they be referenced?
>
> That said, a Fixes: tag might be helpful?
>
> >
> >
> >
> > >   * @freq0:             power up freq0 tuning word in Hz
> > >   * @freq1:             power up freq1 tuning word in Hz
> > >   * @phase0:            power up phase0 value [0..4095] correlates
> > > with 0..2PI
> >
> >
>

