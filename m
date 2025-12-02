Return-Path: <linux-iio+bounces-26625-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A79C9BADE
	for <lists+linux-iio@lfdr.de>; Tue, 02 Dec 2025 14:55:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 234743482AC
	for <lists+linux-iio@lfdr.de>; Tue,  2 Dec 2025 13:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2557331ED7C;
	Tue,  2 Dec 2025 13:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q7vZyEKD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCFB31D723
	for <linux-iio@vger.kernel.org>; Tue,  2 Dec 2025 13:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764683702; cv=none; b=ZwCuwnnjVLd/yQFx/AzRyzzs9t5J4lwurERUqQ39Hj6wGfQlbY6Aa1XBNYislq4oGf5x0Py97sM0hZXIgcFlDpqbBGwmDgqq6K2rnbAvqmDplQ2oulCMo9A+aO8xVf18tzJ08SQz6PNeklPCIMk9GO6iKoTrcGr5LsphuGpLESM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764683702; c=relaxed/simple;
	bh=rYPu9wGVMJD3qxc3VrFM1hzhlwplY+KT749qc7N7eLY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q9tF6/YSy7AdvDD8bXmpPO9pq8hydvCdiRNGHkuMKCuu+nX9AVRRugXGnZLAm8s041Khq1O/cNjGSvi5eLceeiqVkZJ1ckxkJewvfvIdEbPySBvyQsrs1ahDWO+G7qtGcVRmTgXWX+xALNqk9tdLwElwdIv/9mvLSLN123upMuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q7vZyEKD; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-42e2e671521so1694300f8f.1
        for <linux-iio@vger.kernel.org>; Tue, 02 Dec 2025 05:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764683699; x=1765288499; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=q/lyaGrD1zYP4nMnrlel1vvhznbrPEiq90hsTruO97U=;
        b=Q7vZyEKDfm59WErxIVSixBiIbejhXbXD+0VVl67Q9/LClrUcYFlurwIabFR+9sJnw1
         LQAEtqKxGzq4AU+3wqlVmHCMzOWh1sM7MvwN54hVdpOO34eHqss/FVDmhH02BVvs1WXh
         lS5SSS/ayPSHd7NAbkfw+mST9rtMUy7d4X4Pgxkvycqpid8FumJ+/w+jQ3lkLcPoesL7
         SsnUZov8dmJQqvEPX3Ir5R71k6w6PdFSIYnJZhk+KycsV7xch1La5Pqq0YDUS1mcoKXF
         jWx7qpfGi4SKIQN6EFPg40DDGCF+qm/xGi+o/x8hgBqFSAhFKyw8yy5hapff6rBWgscN
         5S9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764683699; x=1765288499;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q/lyaGrD1zYP4nMnrlel1vvhznbrPEiq90hsTruO97U=;
        b=hQo4c1ma3QaAgnAhzXT+11/bIRFCP5koOYKqoWq124FWUzqWcblsuxh2HMYJAzBN+V
         HuIBe7RCjhG2zr++d4WzAl+yPvDfJHoehWwtXJuVahU1FIzdLRJrCHxYfTiMRg2RaQrU
         PQkhsm4qzKzJpS6aqm+hihFW5tl0vrvNeh5nlPI0sIUcF38Gj+jl/ehWK8ncJ+AcodNt
         qqsMIIjNl694HHKyJKFnlQ0mfD3NaMLBlmFESvZRyTeBj2IcgMpn7YT/s1j9Xs59TNVJ
         7zDCwQnj5Am/lQPoIZKmhzWGfUfSBkH3jXKKWdCeWLNqsuFzaNjumGpO6FUisEwlv5nS
         SSbg==
X-Forwarded-Encrypted: i=1; AJvYcCXE/B3hVVWMIem36hlhb3tXFIiIXFncnHt/8TiOIURqez0hWAMQLoIXnfXR49GMsciBCHL6wOXnCH4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB0GdDXfJcZDnnJUQjUdobm0ZOVKeQ0OUVrvGsBnEKiJF5ZGE0
	JOD56hTU+3inzwd8+l6c0uE9+Y6RKLezIcitbm2iNAejtGwJFlmrjpZ9
X-Gm-Gg: ASbGncvUdYWNP+khC66YdByBjJ+0NzM+NH5DEmtD+j3ciicl5jKRDUgYqStN7yvwY7b
	s+ggzE7ZMkNTgUbsFmYAYYfFGQ1zmPw2+81Mgp5DtJVpMzNUTqRIJuhP/MBNgEcfBA082kHy+VB
	oxVVY2c12M2D1qqFGFU70eGFy3Y84sWDC5OfJ4bieGb7Z/AaIBuRa8vtC+ryPcjAdM/+Ol17aF/
	ESTTWwJRM2M+WFPePR26g8FiGKe+OOu4ckbyPb3h4SQeYziFVh54vzOdwdQ3bX+37pn8ua97YMK
	7K+xX69hqt0NsB2mYy7TO/wSG7bz2rl1Y9iBy/FAP343qw8AhY1gMNZsNNqDCcpfHp4qU9P6Fb+
	5dvyUyNWWczzhWgX1m61grgDBNnD2GpJjvyY2FTDZeZMWZfbtdvtyLx73pI5JKHfcHvhHPbJsKF
	hxKoYsHfrdlpuBlttvlWQ=
X-Google-Smtp-Source: AGHT+IGPIJAb6n7MVUXkK/sY1lEb6sUlZ2omnYjaBcbZhIBLn498o8u4JCPCZAwkTS4bxKhIRR7lfA==
X-Received: by 2002:a5d:64e5:0:b0:42b:3963:d08f with SMTP id ffacd0b85a97d-42e0f23179fmr33074672f8f.26.1764683699345;
        Tue, 02 Dec 2025 05:54:59 -0800 (PST)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1c5d618csm32462903f8f.14.2025.12.02.05.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 05:54:59 -0800 (PST)
Message-ID: <ac51767a823e71a4779beee246c50deb30b57db8.camel@gmail.com>
Subject: Re: [PATCH] staging: iio: adt7316: replace sprintf() with
 sysfs_emit()
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>, Andy Shevchenko
	 <andy.shevchenko@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Shi Hao <i.shihao.999@gmail.com>, 
	Michael.Hennerich@analog.com, lars@metafoo.de, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, gregkh@linuxfoundation.org, 
	linux-iio@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Date: Tue, 02 Dec 2025 13:55:39 +0000
In-Reply-To: <20251119145751.00003a9c@huawei.com>
References: <20251116101620.25277-1-i.shihao.999@gmail.com>
		<CAHp75VdY7W8EgOfKuxtTALj777aVatxV5dqsxm688JTy=iVW2Q@mail.gmail.com>
		<20251116152800.4c1849cc@jic23-huawei>
		<34a55901fe0729145097d287a98746f23eea13d8.camel@gmail.com>
		<CAHp75VejBvRX=5psgVgGPCsKk7gVgcDUd1q3Gn+4_jyzk=2pEw@mail.gmail.com>
	 <20251119145751.00003a9c@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-11-19 at 14:57 +0000, Jonathan Cameron wrote:
> On Tue, 18 Nov 2025 14:10:25 +0200
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>=20
> > On Tue, Nov 18, 2025 at 10:17=E2=80=AFAM Nuno S=C3=A1 <noname.nuno@gmai=
l.com> wrote:
> > > On Sun, 2025-11-16 at 15:28 +0000, Jonathan Cameron wrote:=C2=A0=20
> > > > On Sun, 16 Nov 2025 13:08:07 +0200
> > > > Andy Shevchenko <andy.shevchenko@gmail.com> wrote:=C2=A0=20
> >=20
> > ...
> >=20
> > > > Applied, but I will note that this driver is a long way from suitab=
le
> > > > for moving out of staging and I would be surprised if more than
> > > > one or two of the lines changed in this patch make it through the
> > > > necessary refactors (should anyone actually have another go at
> > > > doing them).=C2=A0 Anyhow, I still think this is worth taking just =
to
> > > > reduce the noise of remaining instances of this.
> > > >=20
> > > > I'd have deleted this long ago except I actually have one somewhere
> > > > and it one of the supported parts was still listed as suitable for
> > > > new designs when I checked not long ago.=C2=A0=20
> > >=20
> > > Seems to be now "just" in production. So no longer advised for new de=
signs. I gave a
> > > quick look and this is far from being a simple driver. It would requi=
re a fair amount
> > > of work to bring it out of staging. So, are there users relying on st=
aging drivers?=C2=A0=20
> >=20
> > If there is no choice, yes. For example FBTFT is famous for being used
> > by IoT / DIY _a lot_. Currently a bit less since we got tinyDRM
> > subsystem with most popular drivers reimplemented there.
> >=20
> > > But I would assume that for staging we are still free to drop support=
 it?=C2=A0=20
> >=20
> > At any level, we are still free to drop :-) Just different conditions
> > applied. For staging is basically an "effective immediately" case.
> >=20
>=20
> If no one replies to this thread in next few weeks to say otherwise, let =
us see
> if anyone objects to patches. I'll spin a series in a few weeks and they =
can sit
> in linux-next for most of the cycle to see anyone notices.=C2=A0 It is ea=
sy to bring
> drivers back if turns out anyone cares and then there is some motivation =
to
> finally clean them up.
>=20
> staging/iio/
> 	accel/adis16203 is production
> 	adc/ad7816 is production (7817, 7818) - the 7816 itself is obsolete.
> 	addac/adt7316 is production (what we are discussing here)

I checked internally and we still have customers actually buying some of th=
e chips supported by the
above driver. Not sure if it is being used with linux though... And more im=
portantly, I cannot also
commit that someone will jump in to clean it up.

- Nuno S=C3=A1


