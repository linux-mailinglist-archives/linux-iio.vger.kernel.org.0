Return-Path: <linux-iio+bounces-28052-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E61ED3C582
	for <lists+linux-iio@lfdr.de>; Tue, 20 Jan 2026 11:38:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0ED4F5A1A17
	for <lists+linux-iio@lfdr.de>; Tue, 20 Jan 2026 10:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196523EDAD2;
	Tue, 20 Jan 2026 10:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YwRrJzEc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F373E3ED135
	for <linux-iio@vger.kernel.org>; Tue, 20 Jan 2026 10:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768904800; cv=pass; b=ClkmDyN1DVYpEUI2Fc2R/q0LI9SWy7ZwLgTuUzEv8/ak+9s7cQUzRphHUFYfh1vTOP2LGzTmx36lnlvz9VvBXUfoFYBwQXLNzcGjpuKeSe/XS+0A9ZPbh3GjbNTYB4yg3knBusV5rJbtIrM6oz7ssB8yE708uEEARQyz7gzpi3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768904800; c=relaxed/simple;
	bh=lGKdAEgbyrWTLa7Z0GosTyzzOFZoU++TZlxxz8w2ppc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I6PiEa50Lt98lpurtCIAHYiunbomgHxFVePVFSs1DGSYLaCMnAlVSx99gLQfzzkOO7AXp5aA7DQoovbcOkmqS+rc66dJ1w52ea4JfoubNm1mfu/DJT6IRynGXrbIOjlHnrN2UBKxID5cQrZTbb3cFOgzwHdW/oqhc+WcQ1qHNmM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YwRrJzEc; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6536e4d25e1so7730042a12.1
        for <linux-iio@vger.kernel.org>; Tue, 20 Jan 2026 02:26:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768904797; cv=none;
        d=google.com; s=arc-20240605;
        b=EZpQTx2JqJ698/5u8k56ee0Ih57dL2yuGO+wmHN1RSVdb5EZmF9LflebXnCKt6PAqD
         Pt7DKzlTuBgQBkBTo06LvRUB9Njxqq+4vrSNO2dIrQHoo2kysiPJJMpDVXgYJFH05XLN
         rZhPLnmUcb5y8skifBR7Cw1T0CvMjmi6ie89zxoMfQCcwqueodjxvOG5rKVYROhnc6WZ
         g0UM5u05rg1rfeQ5xBSJi/5RAhUVBj0Z6BUiORFjleGpXksekGr9OELOST3YAqcJX2WS
         KxroSgecac8mdnWHJbXk0guhTBXhUU8OeRGWF+wSCjUyaHIRICpTOPf/07VRphbXihuB
         FRjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XkVoLg2nHhq6viCxCcje+tKer2qx1tZoIxwwIxOdGfg=;
        fh=m/2Aca1LaLv6+Ql361oO9LaRORqfVraGIsYixixIStA=;
        b=ZAlTZSS0I413BRcJUTllVWaDXEpGXID1faCkXthJ4mt8+Cmk24W0h2Oy5WBqvsAzgb
         k6kJzlkUHo2Sb0qZTsbXVTM/MqNlzu5JDJV8lzx1ITEH0FeDKfx0gX/o2J7EaVuVBMZK
         SeZFVuA5nf011nuD9pYYJEXI7pRRzJANbxSISjnmmWWs8b4256VcDtzIghzVjxRF1QqG
         g71mTEq/v9IcqNu42X4IB6zF6GDAWkNUTxLuQ5g1Cdiu8AFv/FXjoYrud4mH/7H3eWxs
         d0MMXxZFUI/1FmX8QyIB+oY9/CxbDMcshUdu76NhpC8e5o/LYYyiE1PI3dijNJwL+l5q
         5evA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768904797; x=1769509597; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XkVoLg2nHhq6viCxCcje+tKer2qx1tZoIxwwIxOdGfg=;
        b=YwRrJzEclEgboQSTj90dxoCpSYm0iZUZhch9q/XR9ik/ivED6bNTKoICV+ooimpvtO
         DYjpi+h4pZG1zOBlvd5J2UfNG582Rld1UijOJQtFo67CD3UpQmr6hBnwM0PQK8hSgwpL
         Mj6nTseXb0GitqWfhE7FfhuLJE6iJxfexow3X51yi5mQSNPstwskGhsXrlwc+0gQksng
         /xmHPc7tXwzoN79IyYckF7xwcBz6GrEWdZ8TvMBsJ5bbLU4FCKpOCbc+Q1t2MLTp+vDj
         q7xbx7HrSDRrBcwtEJGNBFv5/6FfHvYypwJg9f/yGMXz/f0AczD8oLvuigG6HS268SwT
         mvMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768904797; x=1769509597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XkVoLg2nHhq6viCxCcje+tKer2qx1tZoIxwwIxOdGfg=;
        b=rjb+37eQn14jW8mpNMXoBeaxfJNxtRnvqtCupFq5zXDacCS4ami1yxfRHtrVmMpNbR
         Usuf2zYyOIt8iJV8aJ2p2GLf2tT+urMmd93fgw/mw7Pr/Sl/PhUZYIiD4Lp2unTZkKWa
         wWBrMuWF52eoViLf8IHIvX2wnxmJR5MNEcvmT68EsCxqBFNcoGP4fG6DMz16ktbYipov
         mEHh98pg8RenOq5v4Owkl0EgdaLun6siMQx65fktGNR0l+eCx1Hr43EmPEQPw/Bacxpr
         CyiksCDMhZXgtjxG58q17gkJEaudBD9RtgX0ElLHqN5zbZAOcQfFAix8IsP3D5q9tdcl
         dYpA==
X-Forwarded-Encrypted: i=1; AJvYcCU6cNGkZjQrMqrMpl2zgou7s+vSlDMd1Py724FyirXBaxxj2UhR6G/7XUa5lGDpxQUSsM5p5cccBAY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxyb4Q4gLoQep2+5jcfl8lDCz0ng+i/kpHgMMYJZVNNeej7A0zz
	zi8bFZgXoH+XNWumE0x0BT9UcYgd20XWmZsK/mWbj2gGJn+/D4d3qtAbBdilTB6G+YI6N0iL3Lo
	aA5ujby0nAdJlYMHSCZGY/V5LKrLn0RA=
X-Gm-Gg: AY/fxX56fJidID7g2nuDnQa+oJ3uR9e3HXT2/0r6gu46L0BAjiMxrcFrOt+cgsfZZqm
	lm8eC9hl8DNCUCLXcxL9JSfNiP2xgypfCd4GQRqoX91XqnsQR7juA04UhJx32lpmHH2H+LWcYFD
	g5AwuxQu0WJ0TerBg00sxIImJCTG4BsGdYgTZ0BuFsjmdqhWK7R0wV7268PMO/Y3oxSxpO1vEVS
	JWkQh5A/WJdUQCDoauj5jxgSfrWQzuiS8s0uWWzca/2smbUezR2JaHtxZPyvD4C9wriWEiz9fpM
	MdmSo31BW+FBfQ5geJffsmBNd8XGGHoioVJ1DwjoQ6O0Iq8eWBivNiUlCSfuQbC5ZKiQxCM=
X-Received: by 2002:a17:906:fe42:b0:b87:35f:fb4 with SMTP id
 a640c23a62f3a-b8800236e41mr136164266b.11.1768904796948; Tue, 20 Jan 2026
 02:26:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260119100449.1559624-1-flavra@baylibre.com> <20260119100449.1559624-4-flavra@baylibre.com>
 <aW4Ic5bUId3MG4em@smile.fi.intel.com> <851180c6f41f8c9cc79d6412eb97f381f0312f00.camel@baylibre.com>
 <aW9MhYO_xhlQXFn2@smile.fi.intel.com> <9149f9c75c9f961da29829577ba4476681f4e82c.camel@baylibre.com>
In-Reply-To: <9149f9c75c9f961da29829577ba4476681f4e82c.camel@baylibre.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 20 Jan 2026 12:25:59 +0200
X-Gm-Features: AZwV_Qg7yHm-IJJrUYtASR5Qd9SQyHBIsx6bETr-Y3efjsobxYtwqBkt5EUqEXw
Message-ID: <CAHp75VfacR7+cu88=+GMi6BEQxC=HLQbxEQkEnC9mWtFRC-YFw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] iio: imu: st_lsm6dsx: add support for rotation sensor
To: Francesco Lavra <flavra@baylibre.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 20, 2026 at 12:03=E2=80=AFPM Francesco Lavra <flavra@baylibre.c=
om> wrote:
> On Tue, 2026-01-20 at 11:36 +0200, Andy Shevchenko wrote:
> > On Tue, Jan 20, 2026 at 10:28:15AM +0100, Francesco Lavra wrote:
> > > On Mon, 2026-01-19 at 12:33 +0200, Andy Shevchenko wrote:
> > > > On Mon, Jan 19, 2026 at 11:04:49AM +0100, Francesco Lavra wrote:

...

> > > > > +       snprintf(sensor->name, sizeof(sensor->name), "%s_sf",
> > > > > name);
> > > >
> > > > Does GCC complain on this (`make W=3D1` build)?
> > > > Since this can cut the string and we don't check the return value,
> > > > the Q
> > > > is:
> > > > is this okay to have a reduced string?
> > >
> > > gcc does not complain with W=3D1. sensor->name is appropriately sized=
 to
> > > accommodate the longest possible name; if it wasn't, the string would
> > > be
> > > cut in the accel and gyro IIO devices too (which use a longer suffix
> > > than
> > > "_sf").
> >
> > Right, the question is if compiler can prove that or not.
> >
> > We have several patches in input subsystem to hide the warning by
> > switching
> > to scnprintf(), which I consider not the best approach, but still it
> > depends
> > if we care about cut or not. If we do, we should check for overflow.
>
> A truncated string would result in a corrupted value in
> /sys/bus/iio/devices/iio:deviceX/name, so I would say we do care if it's
> truncated. But I think the most appropriate check we could add in the cod=
e
> is a BUG_ON(); would that be acceptable?

No. BUG_ON() =3D=3D panic =3D=3D reboot (with "reboot_on_panic" or so). Mer=
e
drivers like this one should (almost) never use BUG() nor WARN(). Just
add an appropriate check.

--=20
With Best Regards,
Andy Shevchenko

