Return-Path: <linux-iio+bounces-21594-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48976B02BFF
	for <lists+linux-iio@lfdr.de>; Sat, 12 Jul 2025 18:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59E06A47E77
	for <lists+linux-iio@lfdr.de>; Sat, 12 Jul 2025 16:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA982882B7;
	Sat, 12 Jul 2025 16:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aTq2glZq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E335286435
	for <linux-iio@vger.kernel.org>; Sat, 12 Jul 2025 16:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752339148; cv=none; b=sz/ivo7Je8DD+DWQdC+U+kWCOQlOiLb5hHHCAuF6VhEMnWFchh7Ag7F+GHEy9r8uws+6Sd3t2XYZxc69nl4rjVCSNVT3Fc52cDwnoOwsisTdSudWoEaelDmBtz1TCMy7wOVInB7RBCVPI92OzTKUUoxxusy/wVpYiIH6FHQef70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752339148; c=relaxed/simple;
	bh=QwQmX6+AG7nWGJh3RUQNDyU5Ju2/NoQSHNqsZKRfwPg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BvwbM8MvF/mKL3RhJfyYHabhQG1wm+BpElYjLC+fDWceNyY/EYPMYAK3AKnucbeflV6r8hnJEEau9MrMXegPEAwyayO9/sfQMczXKbCChXt4eFlAqDfXCLoajjLlv6SCgTES9c3Q1ZQRNAOhw3UA6fm0Sf0Zb7Z3BHxxFm5ZnmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aTq2glZq; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-55511c3e203so2971272e87.3
        for <linux-iio@vger.kernel.org>; Sat, 12 Jul 2025 09:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752339144; x=1752943944; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t5cEbaljT/9E8afYqR1GvXP7meWetaCzf54VFce+FQ4=;
        b=aTq2glZqI/tZpad3rV0olWO0gufCYMQ2RjLBf5HgtodNgtlPfd+Z2g7dtg7+wh9ymI
         xf41OHiFpY0hhIZS/d+xinuZ8wFXA75hg7jV3R3S+/W1ILgSEdpXgrOIyDsINW/gA7uN
         TrKuieQYDx2ybprZZAN/Ofw1wZHYw8flvOt/Dm/e6iFYqCq+1MpsaYiZB8Yt5nujh9yh
         7yTQ8LclVHCrwzm2RVqXR31h8GvwVl3IxDwNqKgF897JZPFemsm0/GMJD0F37qJXb9FO
         JSAz6c2b38PmSMWvkBpj47VwJ5mE8+JRCKFUAjDrImZ4JTBYz87njzDZjE6AkbuDgFhK
         AG0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752339144; x=1752943944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t5cEbaljT/9E8afYqR1GvXP7meWetaCzf54VFce+FQ4=;
        b=GG18OtLridbmybLChca8F9PBHYR+iElmBjuGlcD6HUnbSf8o3IbSBxe6azrN/v9IQc
         bZ708i575E7JJ3Z5BbYwnPB3WUeJogSlfxO5sxcmgdxxEBfynw7hOphHaPkMbpGKfvRf
         HOzp98jZc950gClTdupHkArS0KwcWOgKl5dEeoS0ZpfHySjLOlLi2OspnO099/t46Hbi
         hQLaxBVvCiir0K0gEO5PEpn2UCI5dvEdEDLCbuxyKbajJxPnqIcmpPAGwN/OGeo+fw4B
         1IqqlfYaRSazt7zubIs6bGLedJ2QpPnhI0KXxHL19Yyb6BThm0r/I/sqnSpRTe5AIQ8l
         UV9w==
X-Forwarded-Encrypted: i=1; AJvYcCVcRoYE6Hryh+SH0isT7Het3kOjolB4g35BNDy1aigm9BlrY6TKoMih3PdmMd1+DlQ6Euno1KR8WIk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyJSANMWmcBoY1LPrjEFavlgZFy+QFwKyG+fW67TFKvXzW+5FE
	f07ms/eTD0Br12fsXHZw5gRniZpzxUGmgD6zCpkhUias9wqepB+FIGGHcFnn7xErmPrKUDQsHVr
	+83gQvJhApB6/rkTr7UmH+vh2ddUt9flLX3qaNAY=
X-Gm-Gg: ASbGnctkxJt8NdDopNi94YQeJGAHTxJxBlPxvC+aLgl0gmBqeLRfnL5qORbMxEF5AS8
	SS4NNUarlGfGW/fwLX0klBY95y5izM3vCFTNVON6tcqMQKS5I6xOuaVdPXhbcwfvV+h1jE2HqMI
	xCqLP1wEO2rMOEfOJi1oVnPKveu6YOAamW0++1dWZFXnVQcoJXXPoxXW/ZdRN+KCNZ2mSe1gpeb
	/FmZ86d
X-Google-Smtp-Source: AGHT+IE/2G/mp5zZ75JmLOjnrEshVBrlfp8McG4gsXHQZknPRTl5Ln/Gv463jlltPhahVO2hs1JLjVUtqL7YGYchf5o=
X-Received: by 2002:a05:6512:238e:b0:553:50c9:c8a8 with SMTP id
 2adb3069b0e04-55a0460c4admr2321374e87.48.1752339144159; Sat, 12 Jul 2025
 09:52:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250629183649.184479-1-jic23@kernel.org> <20250629194336.34a03946@jic23-huawei>
 <aGJp-NYffceeX8bi@smile.fi.intel.com> <20250630150616.000053b1@huawei.com>
In-Reply-To: <20250630150616.000053b1@huawei.com>
From: Tanzir Hasan <tanzhasanwork@gmail.com>
Date: Sat, 12 Jul 2025 12:52:12 -0400
X-Gm-Features: Ac12FXzRNgD84_vBN3DNstY_Ez8Oj05QV-NjUluiEmVPTUlF7dwu-yBizxdCnos
Message-ID: <CAF-NGL_2Y2QCkhOY1uZb68BhkAA4HsAKgkSBaQJ9D9G1qhn+KA@mail.gmail.com>
Subject: Re: [PATCH] iio: accel: kionix-kx022a: Apply approximate iwyu
 principles to includes
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Jonathan Cameron <jic23@kernel.org>, 
	linux-iio@vger.kernel.org, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Matti Vaittinen <mazziesaccount@gmail.com>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 30, 2025 at 10:06=E2=80=AFAM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Mon, 30 Jun 2025 13:42:00 +0300
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
>
> > On Sun, Jun 29, 2025 at 07:43:36PM +0100, Jonathan Cameron wrote:
> > > On Sun, 29 Jun 2025 19:36:49 +0100
> > > Jonathan Cameron <jic23@kernel.org> wrote:
> > >
> > > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > >
> > > > Motivated by the W=3D1 warning about export.h that was introduced t=
his cycle
> > > > this is an attempt to apply an approximation of the principles of i=
ncluding
> > > > whatever is used in the file directly.
> > > >
> > > > Helped by the include-what-you-use tool.
> > > >
> > > > Reasoning:
> > > > - Drop linux/moduleparam.h as completely unused.
> > > > - linux/array_size.h for ARRAY_SIZE()
> > > > - linux/bitmap.h for for_each_set_bit
> > > > - linux/errno.h for error codes.
> > > > - linux/export.h for EXPORT_SYMBOL*()
> > > > - linux/math64.h for do_div - alternative would be asm/div64.h
> > > > - linux/minmax.h for min()
> > > > - linux/sysfs.h for sysfs_emit()
> > > > - linux/time64.h for USEC_PER_MSEC
> > > > - linux/iio/buffer.h for iio_push_to_buffers_with_timestamp()
> > > > - asm/byteorder.h for le16_to_cpu()
> > > >
> > > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > ---
> > > >
> > > > I picked this one fairly randomly as an example but longer term I'd=
 like
> > > > to look through at least all new drivers with this in mind + all th=
e ones
> > > > that are currently messing up my W=3D1 build logs.
> > > >
> > > > Note I've been very descriptive in this patch to allow people to su=
ggest
> > > > better alternatives for some of the ones that aren't entirely obvio=
us.
> > > >
> > > Helpfully I had a script lying around from 2021:
> > > https://lore.kernel.org/all/20211003153306.391766-1-jic23@kernel.org/
> > >
> > > Just for reference I used iwyu with:
> > >
> > > make LLVM=3D1 LOCALVERSION=3D W=3D1 -j12 C=3D1 CHECK=3Dinclude-what-y=
ou-use CHECKFLAGS=3D"-Xiwyu --no_default_mappings -Xiwyu --mapping_file=3Di=
io.imp"
> > >
> > > where iio.imp is from a few years ago and contains:
> > >     { include: ["\"linux/sizes.h\"", "private", <linux/sizes.h>, "pub=
lic"] },
> > >     { include: ["\"linux/slab.h\"", "private", <linux/slab.h>, "publi=
c"] },
> > >     { include: ["\"linux/spinlock.h\"", "private", <linux/spinlock.h>=
, "public"] },
> > >     { include: ["\"linux/spinlock_types.h\"", "private", <linux/spinl=
ock.h>, "public"] },
> > >     { include: ["\"linux/spi/spi.h\"", "private", <linux/spi/spi.h>, =
"public"] },
> > >     { include: ["\"linux/stat.h\"", "private", <linux/stat.h>, "publi=
c"] },
> > >     { include: ["\"linux/stdarg.h\"", "private", <linux/stdarg.h>, "p=
ublic"] },
> > >     { include: ["\"linux/stddef.h\"", "private", <linux/stddef.h>, "p=
ublic"] },
> > >     { include: ["\"linux/string.h\"", "private", <linux/string.h>, "p=
ublic"] },
> > >     { include: ["\"linux/stringify.h\"", "private", <linux/stringify.=
h>, "public"] },
> > >     { include: ["\"linux/sysfs.h\"", "private", <linux/sysfs.h>, "pub=
lic"] },
> > >     { include: ["\"linux/types.h\"", "private", <linux/types.h>, "pub=
lic"] },
> > >     { include: ["\"linux/uuid.h\"", "private", <linux/uuid.h>, "publi=
c"] },
> > >     { include: ["\"linux/sched.h\"", "private", <linux/sched.h>, "pub=
lic"] },
> > >     { include: ["\"linux/wait.h\"", "private", <linux/wait.h>, "publi=
c"] },
> > >     { include: ["\"linux/workqueue.h\"", "private", <linux/workqueue.=
h>, "public"] },
> > >     { include: ["\"asm-generic/int-ll64.h\"", "private", <linux/types=
.h>, "public"] },
> > >     { include: ["\"linux/device.h\"", "private", <linux/device.h>, "p=
ublic"] },
> > >     { include: ["\"linux/dev_printk.h\"", "private", <linux/device.h>=
, "public"] },
> > >     { include: ["\"linux/device/bus.h\"", "private", <linux/device.h>=
, "public"] },
> > >     { include: ["\"linux/device/driver.h\"", "private", <linux/device=
.h>, "public"] },
> > >     { include: ["\"linux/bits.h\"", "private", <linux/bits.h>, "publi=
c"] },
> > >     { include: ["\"vdso/bits.h\"", "private", <linux/bits.h>, "public=
"] },
> > >     { include: ["\"vdso/limits.h\"", "private", <linux/limits.h>, "pu=
blic"] },
> > >     { include: ["\"linux/limits.h\"", "private", <linux/limits.h>, "p=
ublic"] },
> > >     { include: ["\"vdso/ktime.h\"", "private", <linux/ktime.h>, "publ=
ic"] },
> > >     { include: ["\"linux/ktime.h\"", "private", <linux/ktime.h>, "pub=
lic"] },
> > >     { include: ["\"vdso/time64.h\"", "private", <linux/time64.h>, "pu=
blic"] },
> > >     { include: ["\"linux/time.h\"", "private", <linux/time.h>, "publi=
c"] },
> > >     { include: ["\"linux/timer.h\"", "private", <linux/timer.h>, "pub=
lic"] }
> > > ]
> > >
> > > Clear this needs a few upates, like mutex_types.h -> mutex.h and
> > > probably devres.h->device.h
> >
> > Right, we got a lot of new *_types.h headers.
> > This is a database (kind of) I was talking about in previous reply.
> > Can we actually start it as .iwyu or so in the kernel source tree?
>
> Nick and Tanzir talked about using iwyu at Plumbers 2023 and probably hav=
e
> a much better starting point that this (even more) ancient version.
> I missed the talk completely at the time, but came across it more recentl=
y.
>
> +CC them both
>
> Jonathan
>

Thanks for pinging. Here is a repository with some useful scripts.
https://github.com/ClangBuiltLinux/IWYUScripts. Forgive the code quality,
I was an intern at the time.

