Return-Path: <linux-iio+bounces-25748-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDEBBC2514C
	for <lists+linux-iio@lfdr.de>; Fri, 31 Oct 2025 13:47:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 593F43BC917
	for <lists+linux-iio@lfdr.de>; Fri, 31 Oct 2025 12:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6AC634888C;
	Fri, 31 Oct 2025 12:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SKTc/vLY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE0D19ABC6
	for <linux-iio@vger.kernel.org>; Fri, 31 Oct 2025 12:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761914735; cv=none; b=Z1cmyujoiCCkU6BR4mtkhPnmyM9Bn4f8XiR7CJI9mHYj74dCVT0G/o+/eJV4xMXMfwGoFMnh4SPE9fb9ovmFoXDGp+vkPETx+24xQsEphwrkB472NMGFoN3PohYqs9Bax+op4h9BKbMjWfVkReOrI/6SFR02uiwvSDId1DL0D9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761914735; c=relaxed/simple;
	bh=YEJFofn4dJHm/7g/MnUrRU8zirCPi/m2VRyPXl529WI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nsGgpBc8HZX5D3ZCnCYpZ4cg2P5Mn6wYD7vGmGRoOBgMy0EiAulGFZ5g9o5FTL14WlxCY2iCDuaMldvBIj8vG5GXQMTV+Ll74eoQyevVnNOfXeMSU0mU6+P0pWP32ydbrof0j+88dzXcDwpRAnkPOaX9QhzCAnywyvqwaGmljoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SKTc/vLY; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-426f1574a14so1464599f8f.3
        for <linux-iio@vger.kernel.org>; Fri, 31 Oct 2025 05:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761914732; x=1762519532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=htLfTgaGj6SXyo+gY+C4RM9cQYSpr8e9dgfcpC46jhA=;
        b=SKTc/vLYhamnfomqqqDSBQM3XSkYb8cQPUdYv/tzGvjNLc84NDF+N3MfONpqDMbvFN
         ZaYOHDTr7erTHV8vTRzrxxahAwEbV8Z45Dc8d1orsJrA3KbsONJj6K9zLpKoE8rkr24s
         nPTJWGsDAL8heGdasVxisIydjsTISXLLPiFitnXlek0iYHMRwsmAKQIEzKaldVNLKNJ2
         VRW1L2IkndqEGDjDjodM3xgnjaGIJtMGjYwALif4wE5X1NIY+5iMrSWeLrQasL8zmjGG
         bgHMcAr9Ef89TlkeadNGVu7Q050czjfjQEUPEET4tk5+WlEUrOpsHdAvXdJ0sdDKMQVY
         qDMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761914732; x=1762519532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=htLfTgaGj6SXyo+gY+C4RM9cQYSpr8e9dgfcpC46jhA=;
        b=diKYaYxJ7zSl2Xs+YbL+Wods7B+8MPKjxHcm0aBu/JctNOksHvEQR2dV8Cqy2i0vaU
         pyLwe/vGETuDb3RecRDsoYaa+59qWznDU5mSLHaQjv7touatyU/xnElrX9TyNW3y4ahD
         Ovd9aSO7JEH6ZKWuDtJit/wrJYLBbm6VLTF+XrylpRajluudx2VpWDVjmVWEvO3UatUx
         LciWCw8wZiW3LcdJZEDApnVj4fhxsTI+jEmEVSSThP7T9O3lDDq9p/Sd/vQHBDSebNj7
         V2ovpM0E873BhSrQ51PAzp7yyaq9df2RmokehCNnkw3nS1bpS0zGGDJbaRFJbwvXKVeo
         smog==
X-Forwarded-Encrypted: i=1; AJvYcCUX4n/W9kJlJUFXCQyPH1O9y2QcBeryXgGChum6fWHTgEL/nwJoMFC2RFAHoZFTnUdJSaxc+3/o644=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6y7V0LQ0khBme2GOy0XBrqDH+Wel5mOCXWQI6e8izHqeTBMhy
	x938rOLjvOPIEBkLTUYZxsPdbu5cr1Urgq4gNrPGpTVyZq/3g5zj91Hw
X-Gm-Gg: ASbGncsheoZmfDxrLV8KFVEM3oXgpWzi/Ow8E6RSmeU5XBPhlPUOPqBp9OV10jRpVZf
	Il22C1TEnVXrCydJS4iDc8NV+DCm87kuA9xESpEqVkwX7yzUGTOQ1uY8x7bIBezhho52x9Nk5V9
	SGODhfIQ9plYRiBDkrwHFDSBrrxvBV4DEkqEn2nXVr5fuLNAiFl0X75r53SJdShbBlMZPqbJ5dm
	7gPcf01F28dFXweyy4FwyBdvpZFjcTkaRwpPrm1UN5WQzfUohLaHNQFI++pJiNuJ4fp/Js5P7dS
	3nwkBlDSvg8Mh4fa66HoIvDvT4cyvr4q5TlNjlYjPp8Z33r61ITKFiHpBE6Bs0cedXtVtYPSfTz
	PNvewJCDrdMeVjBZ8xm7cOfIk6Vc9VixRJY7uYNAo12xsthajtTtL7f/oJX1Ffp6/IiWARLsacW
	Xl2ef54rph5MKzOTaa5omOy93ql1xABtGtPvr+G1WZc5dFQJ29JUb3
X-Google-Smtp-Source: AGHT+IHSbBaoyJFzeN/27Rgp+5ix/nizQNjZB0dnWxKV1godF2Cu1it5Urb0qAv1OThr89VNsq/Rxg==
X-Received: by 2002:a05:6000:40ca:b0:429:b9bc:e81a with SMTP id ffacd0b85a97d-429bd5ef85bmr2376964f8f.0.1761914731839;
        Fri, 31 Oct 2025 05:45:31 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c1125ad0sm3503532f8f.13.2025.10.31.05.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 05:45:31 -0700 (PDT)
Date: Fri, 31 Oct 2025 12:45:30 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Jyoti Bhayana
 <jbhayana@google.com>, Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 1/1] iio: common: scmi_sensors: Replace const_ilog2()
 with ilog2()
Message-ID: <20251031124530.3db7805b@pumpkin>
In-Reply-To: <aQSHVsWGXzigTEMe@smile.fi.intel.com>
References: <20251031074500.3958667-1-andriy.shevchenko@linux.intel.com>
	<20251031094336.6f352b4f@pumpkin>
	<aQSHVsWGXzigTEMe@smile.fi.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 31 Oct 2025 11:54:30 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Fri, Oct 31, 2025 at 09:43:36AM +0000, David Laight wrote:
> > On Fri, 31 Oct 2025 08:45:00 +0100
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote: =20
>=20
> ...
>=20
> > >  		tstamp_scale =3D sensor->sensor_info->tstamp_scale +
> > > -			       const_ilog2(NSEC_PER_SEC) / const_ilog2(10);
> > > +			       ilog2(NSEC_PER_SEC) / ilog2(10); =20
> >=20
> > Is that just a strange way of writing 9 ? =20
>=20
> Why? It's correct way of writing log=C2=B9=E2=81=B0(NSEC_PER_SEC), the pr=
oblem here is that
> "i" people do not think about :-)

Even without the "i" the division could easily give 8.999999.
So you'd be relying on rounding to get the required integral value.

> But we have intlog10(), I completely forgot about it.

And it isn't the function the code is looking for.
(The result is shifted left 24 and it doesn't have an optimisation
for constants.)

>=20
> > Mathematically log2(x)/log2(10) is log10(x) - which would be 9.
> > The code does seem to be 'in luck' though.
> > NSEC_PER_SEC is 10^9 or 0x3b9aca00, so ilog2(NSEC_PER_SEC) is 29.
> > ilog2(10) is 3, and 29/3 is 9.
> >=20
> > Do the same for 10^10 and you get 11. =20
>=20
> That code looks like working by luck entirely, TBH. I just took the scope=
 of
> the patch to start dropping const_ilog2() usages.

Something always crawls out of the woodwork...

	David



