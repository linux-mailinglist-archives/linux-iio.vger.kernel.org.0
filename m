Return-Path: <linux-iio+bounces-25767-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3623EC262CD
	for <lists+linux-iio@lfdr.de>; Fri, 31 Oct 2025 17:42:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16A3F6200EE
	for <lists+linux-iio@lfdr.de>; Fri, 31 Oct 2025 16:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C285130BB9F;
	Fri, 31 Oct 2025 16:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D6dQgcF9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE10F2F3C2A
	for <linux-iio@vger.kernel.org>; Fri, 31 Oct 2025 16:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761927217; cv=none; b=ArWURJjtn6+LYNyqz4TVsMIWBY1JT6puLWfUlaWPio9kGRg9Ky9k5POwJC8yjQi2d6Mt8/D3ua5+EdbmnYBCtQUGfpYzdTneCzIgJaN6etlaxU7FzIvexvdK16SdRQ55SBDyItL4wSZ328CFLv1ro7JY6++xcHK8ioW5cN4A7Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761927217; c=relaxed/simple;
	bh=ndOEHZ3nWccRUrwdUMb0NZJPH9B3+tUoq0msaJX3oRU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gds1rxBJyPXL08nl3qZXePS9++kjvMvF5pPEqayKSOW7YINSSjLNdHxpPZEAEEHMheufjdHOo0tYdqQD9ERCjBVTgXRZLaK9lC4hap/GKsiCeaTX8ywDARO4vMW0LtI2j1GhvG0HpWtmzJYiwDv+dcn0mthot2nswuew6AaypZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D6dQgcF9; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-475dc6029b6so24552115e9.0
        for <linux-iio@vger.kernel.org>; Fri, 31 Oct 2025 09:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761927214; x=1762532014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0sN3X2Xwo6rgocUEV/FIBQzOQxPvDntamogTA2IKqR4=;
        b=D6dQgcF9lny/vFokxaWJdICvY0QTb4NTgCdgveyuLz5ugCUWpa2Ho0+fyFA8w8Q4pJ
         9pUPdx1224oqIqfxmEhAVonZbpasRW+xqdY0OPKE4bEEvLnpo6mdnGdaFuAn4KHDQzdW
         PBxzRwRhwRKa46di9YTZKOu9fawaorTpO3Yr+MnWAUZfJ/YV33TVVrdoS107siSl7Ut0
         xUa1bD7tgRIPrFw4aOy+1ht65SicGSMou3HeBL0BX8ewQroAVETC8Mjxfh8lxuj1X4UF
         wUFrEFhSj1qOkbbP8ZI4Tx+6MvYT9cbsWIlMOtLg1xyhRsh/tEAi0r2qLQj05Pj+S/IN
         rgOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761927214; x=1762532014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0sN3X2Xwo6rgocUEV/FIBQzOQxPvDntamogTA2IKqR4=;
        b=bTOgt+Gq5CSSTMcaj8U16WIiGunQ6SdpOiMvtUITYXeUJH4e6m57PVxHm0YsjBeD2R
         LP0rwNS0ojmAy+w1F2Ch2MZW91Xvck3QaV7T3JLgKlJQN9EEzd4689nknRzGX4phbTdE
         ptWFjq8ZVCDijaVQ55dfgr0250IrK99yHz7qKkgpULqT3pI2LLJtwmjGM4kQrGQ3Ajmf
         zTiORNjJvdMMlSSO+VK8JNe7/B31wdUSM39sPXyzbep3EvVAacx1bS5TZwJkG5e0HxNt
         jpf2dJgNgXMMBd5OFiZesZSsp2JY7X3BXOIwU4KS1hBB0v8KD4V4kS7VazhOw6h+BqvF
         jmMA==
X-Forwarded-Encrypted: i=1; AJvYcCVSeZj+63NAqWrDG0KLajSfy6vTg8NRn0HNNCVnXEm1IY+AhNRzJwgcIas1SwFOcI3huG13GAue8TU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxaucpp4kdbdtcsXYLJR3vsR8NTguSDMI6tNMQoSW5I4cHPBwkA
	W6Xfr0IgljxAHQ00XoMiJuBe9yvf8q9oe1vRgOAIFGL8E4Kl9EBW5oBc
X-Gm-Gg: ASbGnctnr5C9RoEPaCAnZTQQW6SPaqBBlRexrPYdM4HaQkfDudq0axAhx6xcIT0W7zr
	Ee88lF8j6JvxL8GTADWBRQlD1fmaY0Sg6PmXxp2w1wL7aaLvWEbpes4Bq/Arxsw8UDajNoncvDG
	xIVGtt4yjFRjt9cSVGQRljK9Z07Vtt+I1gX4leG7O4CQ4K5iQIXaX0oBkesiK39tg24W6932Fy2
	qHxVzl6QgH0vgyJNdnXD2l5eRVzGpTumg2bWEBcK9cN3AdMBeWxjashK3UJkteHs0zpUG3w240x
	yNi18zyKnK9JFaTh2+JgSmtgtHzugpJl2QuC69Ye+eNwjrrr0uoWrHaV6fHzN/FteIWaStpe9vk
	iKmNurXc6bw8/Vu2d7g91PM+0Halt3SbRLmTJ+EYxUgJjS2vEksvb5jqoZrpTVjCE4TOVDGJ7iC
	sWD6gwAOqn7E14gv3W8sTp1sE39LYWERmq9Fd0B3BaPmrpxO070KD3
X-Google-Smtp-Source: AGHT+IHVP72QSGXFkR2pGkrGQk5WvUtITPWOK+QFA8hZ2bNsTY9AyXA5gNFkfS4+KdvMg01Jb8B6bA==
X-Received: by 2002:a05:600c:a0b:b0:476:57b4:72b6 with SMTP id 5b1f17b1804b1-477305a6db5mr44531025e9.8.1761927213600;
        Fri, 31 Oct 2025 09:13:33 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c13f2b5asm4250397f8f.40.2025.10.31.09.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 09:13:33 -0700 (PDT)
Date: Fri, 31 Oct 2025 16:13:31 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Jyoti Bhayana
 <jbhayana@google.com>, Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 1/1] iio: common: scmi_sensors: Replace const_ilog2()
 with ilog2()
Message-ID: <20251031161331.0f0ef347@pumpkin>
In-Reply-To: <aQSw7V7tYjBOtJ7k@smile.fi.intel.com>
References: <20251031074500.3958667-1-andriy.shevchenko@linux.intel.com>
	<20251031094336.6f352b4f@pumpkin>
	<aQSHVsWGXzigTEMe@smile.fi.intel.com>
	<20251031124530.3db7805b@pumpkin>
	<aQSw7V7tYjBOtJ7k@smile.fi.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 31 Oct 2025 14:51:57 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Fri, Oct 31, 2025 at 12:45:30PM +0000, David Laight wrote:
> > On Fri, 31 Oct 2025 11:54:30 +0200
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote: =20
> > > On Fri, Oct 31, 2025 at 09:43:36AM +0000, David Laight wrote: =20
> > > > On Fri, 31 Oct 2025 08:45:00 +0100
> > > > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:   =20
>=20
> ...
>=20
> > > > >  		tstamp_scale =3D sensor->sensor_info->tstamp_scale +
> > > > > -			       const_ilog2(NSEC_PER_SEC) / const_ilog2(10);
> > > > > +			       ilog2(NSEC_PER_SEC) / ilog2(10);   =20
> > > >=20
> > > > Is that just a strange way of writing 9 ?   =20
> > >=20
> > > Why? It's correct way of writing log=C2=B9=E2=81=B0(NSEC_PER_SEC), th=
e problem here is that
> > > "i" people do not think about :-) =20
> >=20
> > Even without the "i" the division could easily give 8.999999.
> > So you'd be relying on rounding to get the required integral value.
> >  =20
> > > But we have intlog10(), I completely forgot about it. =20
> >=20
> > And it isn't the function the code is looking for.
> > (The result is shifted left 24 and it doesn't have an optimisation
> > for constants.) =20
>=20
> Do you have an idea how to improve that?

Not sure I'd want to get cpp to generate a high-precision log.
It if definitely doable, but will be a mind-blowing mess.
(and I'm not sure how many MB the expanded line would be).
An ilog10() would be easier (probably looking like const_ilog2()).

But for this code just use '+ 9' and add a suitable comment :-)

	David



