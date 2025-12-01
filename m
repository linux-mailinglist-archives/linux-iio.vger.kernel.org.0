Return-Path: <linux-iio+bounces-26599-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F948C985C5
	for <lists+linux-iio@lfdr.de>; Mon, 01 Dec 2025 17:51:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 119FE4E1D75
	for <lists+linux-iio@lfdr.de>; Mon,  1 Dec 2025 16:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 264198460;
	Mon,  1 Dec 2025 16:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hjSoVsHB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7588623EAA5
	for <linux-iio@vger.kernel.org>; Mon,  1 Dec 2025 16:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764607813; cv=none; b=SH7uHFlNu7C4NUd79nuqfBPFiMC4FppQeXMQO/fmWRWIZVMVzfczS4kNtCobkvcvHi/yOFvbNanRs9UumdXH43FvAYaREhHhhB3SmQmVlT5zfVtYO0dAaIGDcsUYGh2T8DyFOxeTMjiOymn3Aj+l3ueU6fKjxZ4XCdCLjNfRAHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764607813; c=relaxed/simple;
	bh=IUlk0RiWKxSC9MBdv7RzX66VzV1ziNlZBBwLEjUPeGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hGQvhfZyUi9DZ3ZsaBU39ouTnM9ccWE00HjW2ZTeen5eV7mZX9box8eBbEAbc5KLsXlb1WIrldXkgyHCKNo0H3j819JGFlbSwOxBoOfpD4DvBXeqz+jo5kLxTeTXdB/b9/7ZQx8ewX4en3tsYFqTcPB7CUCLU4pkhFKLwuRssXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hjSoVsHB; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7b8e49d8b35so4876108b3a.3
        for <linux-iio@vger.kernel.org>; Mon, 01 Dec 2025 08:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764607812; x=1765212612; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AvcNEhDuLn+vatCl0I6V6UWZc4kOmAdKBr1H/K66C/s=;
        b=hjSoVsHBeUy2wUSG4oHh1Bh0XQtQrZFo/5AL6EVHbXaenhoqmLxFID9wqaAfQ3BmiL
         11Dzs7uFKA/hRDKQNW9jPuhIXwX1wcOaTGwVztyzRONWO7TBe4uhFy2zv4mligKSszU7
         zXwZ39yMzeFc5UsNBeaRCtHkdLbrMhySV/ke6EkN//M9Dg+5NkAoQ/wdWAh4F7ZxJBZZ
         OMMioVVryxm08c2kbMGLXcE/oV8OBMQUmAbDgiQk3pCI6eRP+P1mKGhAaGR8LRe61ivv
         ayBe9jYoTTmXNn/BkbD6Xuh9xflERp7GUK5tPYYJWRbf1Sy81okhnwtPuMR2qZ2SQXB1
         dLkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764607812; x=1765212612;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AvcNEhDuLn+vatCl0I6V6UWZc4kOmAdKBr1H/K66C/s=;
        b=XBqpBTOnWuJs8QlLZrIV/g03dMtOgWfjotdPhJ0aU1r/OpIbPbfZ3LoHLGqmljJWMC
         5U6y+ryogdUYv/NYuYhSDNgr5wCm44NQ6Cr+nlyswI6BX642Ch599hDkPnfuPm+ti3xw
         9/1XyTZqsBPn31pe3VYOv184+xEgD2FLZftOjMjmCva1xoWZpaGSjTqbNBAmg8bVetxR
         6byJT1KdOMSxtf8xfrueufOHFuDLH3OO5FwNoRog28sqBREx5EZs/GeqkI8C44KiHI76
         CbPvb7buM5LLkHPHLcf2mZgi5LOyiQRv3FAlKYsQk1eKeT6OIlF4gCtgq89SMk78I6qR
         BViQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgXSZqIpJHyhCkKKt3o5kyMCMTQOnSrVrXZW0BQIsrQl1PZjbdwOeWapbNcfI5I3qHywV6gM1ztOc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza7M3Ob5/5c43P8YHUdGKsVDqhP77oopxUgH66eIsAk6lImezd
	58covdleSMbcqBTg0EX2/pXllqfT71m13boowFhwtWcPn1AvlxgvG7aI
X-Gm-Gg: ASbGncsuRZs7M2X3+xRCI6x/9Zy4uJMLHhEcPAY1mhdJ6jM1OFqazc07zAYlE3T1JUQ
	kE7nva9rfcvtLco89BmyRX+kLXH4OuHArE0daiQjWXOQz3pqmR2NKZfN6ExYmgae93QWN865v7z
	WtVkWAXnfdVbbAzr3dIT5p7wgjI8YbQ2RcXy6OSsRn3qnI2j3xKTHUR0AziU9GylWtuLAYXyR4J
	xmfVvfvFv9n1miJOLwczY2QKAkEWFnLo7qudctXQs9EPb4r9kA5lKlBND4Q/yKzsRC/XhYqq/Lp
	Mrbq9uMSegfsHxnLq75KhS0NrMFLIeb6Eq8w2zaM9o+YW4WzHLl676hkmT/1YPzcWF+Sy+lYf9T
	D4LyqaPmmuvI6b09/BAFZarA5qjVC9uY3+MhFHECrODv4Iq9XU5nUjlo3yWHEgZOxv5vsYU8Di6
	gW9EHhdhl1hQSjzMNX7R8=
X-Google-Smtp-Source: AGHT+IFcfYv1UvAfJ30K/d1C60sHdw3nK5lXHBFrmebJunXpq41W40Vmml5aKdrUUQvWkwvikceKYg==
X-Received: by 2002:a05:7022:692:b0:119:e569:f60d with SMTP id a92af1059eb24-11c9d60e3ebmr23373511c88.6.1764607811566;
        Mon, 01 Dec 2025 08:50:11 -0800 (PST)
Received: from localhost ([2804:30c:941:4500:2e30:10b5:73b0:4b74])
        by smtp.gmail.com with UTF8SMTPSA id a92af1059eb24-11dcb04a07bsm61594077c88.7.2025.12.01.08.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 08:50:10 -0800 (PST)
Date: Mon, 1 Dec 2025 13:51:43 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Shi Hao <i.shihao.999@gmail.com>, Michael.Hennerich@analog.com,
	lars@metafoo.de, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, gregkh@linuxfoundation.org,
	linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: iio: adt7316: replace sprintf() with
 sysfs_emit()
Message-ID: <aS3HnzzrfgmerZ-m@debian-BULLSEYE-live-builder-AMD64>
References: <20251116101620.25277-1-i.shihao.999@gmail.com>
 <CAHp75VdY7W8EgOfKuxtTALj777aVatxV5dqsxm688JTy=iVW2Q@mail.gmail.com>
 <20251116152800.4c1849cc@jic23-huawei>
 <34a55901fe0729145097d287a98746f23eea13d8.camel@gmail.com>
 <CAHp75VejBvRX=5psgVgGPCsKk7gVgcDUd1q3Gn+4_jyzk=2pEw@mail.gmail.com>
 <20251119145751.00003a9c@huawei.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251119145751.00003a9c@huawei.com>

On 11/19, Jonathan Cameron wrote:
> On Tue, 18 Nov 2025 14:10:25 +0200
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> 
> > On Tue, Nov 18, 2025 at 10:17 AM Nuno Sá <noname.nuno@gmail.com> wrote:
> > > On Sun, 2025-11-16 at 15:28 +0000, Jonathan Cameron wrote:  
> > > > On Sun, 16 Nov 2025 13:08:07 +0200
> > > > Andy Shevchenko <andy.shevchenko@gmail.com> wrote:  
> > 
> > ...
> > 
> > > > Applied, but I will note that this driver is a long way from suitable
> > > > for moving out of staging and I would be surprised if more than
> > > > one or two of the lines changed in this patch make it through the
> > > > necessary refactors (should anyone actually have another go at
> > > > doing them).  Anyhow, I still think this is worth taking just to
> > > > reduce the noise of remaining instances of this.
> > > >
> > > > I'd have deleted this long ago except I actually have one somewhere
> > > > and it one of the supported parts was still listed as suitable for
> > > > new designs when I checked not long ago.  
> > >
> > > Seems to be now "just" in production. So no longer advised for new designs. I gave a
> > > quick look and this is far from being a simple driver. It would require a fair amount
> > > of work to bring it out of staging. So, are there users relying on staging drivers?  
> > 
> > If there is no choice, yes. For example FBTFT is famous for being used
> > by IoT / DIY _a lot_. Currently a bit less since we got tinyDRM
> > subsystem with most popular drivers reimplemented there.
> > 
> > > But I would assume that for staging we are still free to drop support it?  
> > 
> > At any level, we are still free to drop :-) Just different conditions
> > applied. For staging is basically an "effective immediately" case.
> > 
> 
> If no one replies to this thread in next few weeks to say otherwise, let us see
> if anyone objects to patches. I'll spin a series in a few weeks and they can sit
> in linux-next for most of the cycle to see anyone notices.  It is easy to bring
> drivers back if turns out anyone cares and then there is some motivation to
> finally clean them up.
> 
> staging/iio/
> 	accel/adis16203 is production
> 	adc/ad7816 is production (7817, 7818) - the 7816 itself is obsolete.
> 	addac/adt7316 is production (what we are discussing here)
> 	frequency/ad9832 + ad9835 are production
> 	frequency/ad9833 etc are production
> 	impedance/ad5933 + ad5934 are production
This one is an old pending task of mine. I want to finish that. IIRC, the only
thing holding that from graduation was lack of conclusive testing from my side.
I still have the eval board for that. Luckily, I shall have some vacation time
at the end of the year :)

Thanks,
Marcelo

