Return-Path: <linux-iio+bounces-17643-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19184A7CA54
	for <lists+linux-iio@lfdr.de>; Sat,  5 Apr 2025 18:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15A2D1890DD6
	for <lists+linux-iio@lfdr.de>; Sat,  5 Apr 2025 16:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EBF886331;
	Sat,  5 Apr 2025 16:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gCFeC2vS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4855420330
	for <linux-iio@vger.kernel.org>; Sat,  5 Apr 2025 16:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743871614; cv=none; b=lVZd6I0YHKp+AbzwdWp9x3CSGcEkgM9JkqVMwIcow0xNc3R8Xpht+oZtr7tfnFL9GTgriCA+EscUavxEnG2lLtko6VfBmI+gEgiFZ7C6MEBMRrVZLh6wjO5hll02+t3eiDVL8BMTntWtJwMPxfazTHuzKfbYtHMsCl7LHcxRS84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743871614; c=relaxed/simple;
	bh=SyoSHC/ehgyoCY0S95rBxrQVjJPhkO1wKUiijwUG22U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Go1pynNZ16bBWP6bOKCtV41SdqF+nmwHHAZuOIDck3ETcJoVIsgrYgaZwKTQNeDaEeZkdU3hzPehYDeoTzZb15yqR5kiRXwQOFOr/OlGEm1PgZgOFzsQ+g5d2jAehoV1L1pos7v7jz7VqDxM7Mf3/jqSNT04lVTolXc3lbia9as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gCFeC2vS; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ac339f53df9so501258266b.1
        for <linux-iio@vger.kernel.org>; Sat, 05 Apr 2025 09:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743871610; x=1744476410; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kxy8SThqCuHF2pnECM8+JyuA0UOzkl+y8LnlAy2ysUE=;
        b=gCFeC2vSGiBb6Zb0EE0tYFiAy8KsbvYPtmOOPeRtSUxmUZJOresviU7Mac+3W3p47j
         5Zc0akEPpT5bxLWgBL+k4HrvSiblYQty9MiaLhqAmqPHsQs1sg5OQU4ifNoSHs1smNO9
         VeGprKFehKPVLSRBm0Sy0Usnu8OtsQ/gj0uRYYwmnjEgHyPzqpia02V3v9LTgxfy4SC6
         QhpU9U0fLKskR2Qq9UJF73Vwl2Vpvt7odHXW6L06075ApCF20RD2o1sAfNzIz9rZhepX
         PnQv2GxU7ykDSwR5BgXUKwqWd3i79LC/sKyKw1aEijEbCTdvjEwXEuBBieQaTvtupOrV
         fIjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743871610; x=1744476410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kxy8SThqCuHF2pnECM8+JyuA0UOzkl+y8LnlAy2ysUE=;
        b=dw0yMCSr3SCopPyoEaQt8HpSXnOyu71wY6DRaGoOMTa22CK8RxpLAx+JpCaF2xWaq5
         SZKQTDcjNa/YH8U1H4Mb4BdbVKIeXPyeqJmtAwEzIgCeTpAr9UNyvMX40dJDwvyW/MgW
         IdTSeGGBbfOQlX/feQZapDlsl8iyJKOqwVjGEmSxM/SJ7nGFmGQ0WIYydyVNpMG+CMMK
         aX3CWSIyquc/vJjNkI6TcK7NQ2FLRkpTFN7N5A8BHNhgONbx0+039lAsu6A4D5+gAOGB
         xbdIB7XTiBy65JZzDjUul7z1qRdm9hC/3fOi0INRFnkRHR9/cWa951GpzKGJiw2xlCPJ
         rIzw==
X-Gm-Message-State: AOJu0Yz739JnYBHZ+h070AyxSeLDzMTanskDqmFT3XA/uAJAPPTB1Xwo
	8EZ6gUipBDom4vpZ5KMGasW021GeBprzI8SXgfoAlPO9wRug5VBJWhkBgG7xDm8wnAyXbMprMz/
	+smFLjBNxOUkplSjTAJfCodUU3Gw=
X-Gm-Gg: ASbGncsoDJaYfaMMsSHyDBv5Bsx0s4c64kbo6l4nIBd8kAq8Qn6fRb4rG+lK8DMS6vg
	/trtsujU8tFPNSUU25cDCDokb0rogUD8l7edhZEXVrDO5083KDOGaAfcoxutKJnX7p5Ef+DliIb
	j47OBEKF1liYTZ0P+y9/6nLQjA1w==
X-Google-Smtp-Source: AGHT+IHkVqgQGUwQtTE3Hsuuk8Bj0Nvxz2lFwOM27dl4vlpr9zf9TgihgFBjZ6PVmvo7xF8opA0EwxTVk59aGme2LiQ=
X-Received: by 2002:a17:907:7daa:b0:ac3:97f4:9c08 with SMTP id
 a640c23a62f3a-ac7d191ac70mr656672966b.31.1743871610288; Sat, 05 Apr 2025
 09:46:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250331121317.1694135-1-jic23@kernel.org> <20250331121317.1694135-38-jic23@kernel.org>
 <CAHp75VdUU4p95+b31mP1-fb5ytBPeisi5e0gf4sAniLFYabE7A@mail.gmail.com> <20250405173439.5a6d7980@jic23-huawei>
In-Reply-To: <20250405173439.5a6d7980@jic23-huawei>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 5 Apr 2025 19:46:14 +0300
X-Gm-Features: ATxdqUGmp6Mqpnf9y9WdOXE2p9HZKXD8F9qYotS0QyAVORdmbT4Su8461O5NVkE
Message-ID: <CAHp75VfNG0w61xZ0__sis02ALiHsEAFmmj_4XAP7NP9szH4MUg@mail.gmail.com>
Subject: Re: [PATCH 37/37] iio: Adjust internals of handling of direct mode
 claiming to suit new API.
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Cosmin Tanislav <demonsingur@gmail.com>, Roan van Dijk <roan@protonic.nl>, 
	Jyoti Bhayana <jbhayana@google.com>, Nishant Malpani <nish.malpani25@gmail.com>, 
	Eugene Zaikonnikov <ez@norphonic.com>, Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, 
	Shen Jianping <Jianping.Shen@de.bosch.com>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Matti Vaittinen <mazziesaccount@gmail.com>, Yasin Lee <yasin.lee.x@gmail.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 5, 2025 at 7:34=E2=80=AFPM Jonathan Cameron <jic23@kernel.org> =
wrote:
> On Mon, 31 Mar 2025 16:41:42 +0300
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > On Mon, Mar 31, 2025 at 3:17=E2=80=AFPM Jonathan Cameron <jic23@kernel.=
org> wrote:

...

> > > -EXPORT_SYMBOL_GPL(iio_device_claim_direct_mode);
> > > +EXPORT_SYMBOL_GPL(__iio_device_claim_direct);
> >
> > Can we move it to the namespace while at it?
>
> I'm personally not convinced by the namespace defaults in headers
> thing pwm.h does.  So to namespace these is a massive patch
> adding the import to most drivers.

We are on the same page here! I even mentioned this disadvantage in
the comment below.

> So I'd rather deal with that later.

...

> > > -EXPORT_SYMBOL_GPL(iio_device_release_direct_mode);
> > > +EXPORT_SYMBOL_GPL(__iio_device_release_direct);
> >
> > Namespace?
> > Note, the good outcome of the namespace is that we can easily see who
> > (ab)uses these... OTOH, there are static inline functions in the
> > header, which provokes this to add MODULE_IMPORT_NS() into the header
> > as well. That said, perhaps also get rid of static inliners and have
> > them to be real functions?

> As David said. Unfortunately not :(

Yeah, that's a pity.

> Though static inlines using these is fine as any driver that
> doesn't import will still fail in the correct way. It will just
> be a bit 'weird' to fail like that.  The missing namespace
> warnings are pretty obvious though so that should be fine.

--=20
With Best Regards,
Andy Shevchenko

