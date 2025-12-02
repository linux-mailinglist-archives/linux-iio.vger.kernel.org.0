Return-Path: <linux-iio+bounces-26647-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B1A6C9C8B6
	for <lists+linux-iio@lfdr.de>; Tue, 02 Dec 2025 19:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C2EA3AD4C6
	for <lists+linux-iio@lfdr.de>; Tue,  2 Dec 2025 18:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6666B2C2368;
	Tue,  2 Dec 2025 18:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cZeutiP0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6569729BDBF
	for <linux-iio@vger.kernel.org>; Tue,  2 Dec 2025 18:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764698698; cv=none; b=WfG26oaVCj0PY3jKLrmDmOhBJvScO4YgQ0XizNe4/3fruZspKOjMfbcWXlOeuCxUOuT+xQ2zneA1DMHME8q0IsLcBlZKleu1X/MLeOfjKJJaIb0JfixzEj66virIU9UQuqtisTFQX8uIIhgWBQH5WzM4x4EWYq56QfF+4d5eDHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764698698; c=relaxed/simple;
	bh=7IdDBvc9j0MZGnyaQRuZBfS23Huzt0J+rY4DE8IK1+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RTJsOixA7Ds147AMbx2AspHN5kyigTUljG85yu9vX20TbgCEro4g1owntqnyIdGUBMeXKyjhhhYZ0HM1dPFF66N+BAxDi0qf2hiNRtLvdOEIaG6hrR1158L3c13UOP3Dk14fWjkmIpzSzBIfy/MaWXuRKgH4QyNziOv3Bps5pZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cZeutiP0; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b73a9592fb8so26828966b.1
        for <linux-iio@vger.kernel.org>; Tue, 02 Dec 2025 10:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764698695; x=1765303495; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7IdDBvc9j0MZGnyaQRuZBfS23Huzt0J+rY4DE8IK1+A=;
        b=cZeutiP0dhOl2hhuOyJzH3SCgdKYVD6uHgYRAllzvaMVWxOpFcEa8pLS1LvjSIVyn0
         mrlAToBD7aGDR5+8x+lKMVMfzalU5UPTrnJKPmey1XQx6j7JlLRwZG1dfe/4L6ccWJ1n
         gBIozdfg64MMpOq2hWRpbHjaC0RFuiozXRIuYtdaHwOyzmYpXHmf5TBMBte/bDymUnF8
         chcfArjgUVdIPN3OAIb38rF+L9t93dNeGHhXGaEBo2WdsAcxLSwY40J4C/i37inxEv4t
         dAizcfA63XKE0puCiHj6FU1HA2d11kG+VJ5EqSIufsXlZ6+p/TtnnLp1z/8E3Hv8CIbh
         aajg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764698695; x=1765303495;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7IdDBvc9j0MZGnyaQRuZBfS23Huzt0J+rY4DE8IK1+A=;
        b=wXXljEhM4hVx5L1bPI2COBKOOpsQsedySF4nkxIMeS8EuFI+YOBEbGIzEavSA3Mtv7
         kX86agTvKmpCh1+2Sn2AIcLSj5D1C4OQK987s4wqVjplHmesM+zQ4ug9v49hLMgXrCUf
         dDHhKNkENho/JZBmibCHxhzTuE3oBEz0+nttbZGmG7pLCVG9WT15E/DUnQRPP4tohWSk
         HpXJNIaPOx+JrKu4GfOfZmLqEeTqEz6yQQ/H+rLXM19Eqdj2FabpxXvaqRSW55PNTBRv
         ZyYmW3IXoAxuE1SEuOy1vfjSybMREdecCykCVRyf1Rz2PblqqEHFMntthiK8Eao2G8PF
         Re9w==
X-Forwarded-Encrypted: i=1; AJvYcCWbIzeXgnGtw3VTox+QSYSVQkOF0EZ+TTJMUqqEIxFIEEtCHDW+zbAxiX0ppoX+m5YELb+n/Dj57cQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt1LXXeAWMhUJ80v0SF0OSY8lsccs5xtM3c4HhmQv41+7JuOMk
	qkyeVyRSplDF2NxVUar6+u+U82db4eqeojPh3XFiIHx16e3Kt3+/XY8B6sVAsfGqgFfqZt5DRDG
	qDtqBChrCLRGCFl9q4zYfvtWtvY6fQ+A=
X-Gm-Gg: ASbGncs7jUPu31Ajx3paIDNnuCynMoLJqikWydFSLIZ0+nLMeAZwCJMLqe8dd/AIXNs
	7ibgybZQZHgZNg2s9vuWLAis/7ZvH8NgqYRPcD67SIkGmP6JB+/0s3UCLRbagR1ZsHXWXCD+mlY
	NSB2kNhyxZ1f5yqGhSEUHjter2Kh5B2DRmDBU+pjYHf7KOf7PcrRdgPzqZo18fNCoP9Ny7r6DwG
	e25HVTozzJ/XvRMeBqw2UyWo+3riwZ29ew1Z5bQeIygMcWZ3BMmF6jzqwAwxajw4kBQa7JK+SIe
	al/rM8nRChpz1Qhg1uKZzUKqFZDfVMjl70E/pVgKj4jogOfDSnybsF5FMR1QZYNr60fjakw=
X-Google-Smtp-Source: AGHT+IHP4ToFeKphSERT/KFNU0RoZBLP42cfjgsiJdcuNazRwbnl0UopuMT6JYnXokfjp8i/evl8TKuN0oxunXGaW3k=
X-Received: by 2002:a17:907:980a:b0:b76:52d0:3a0b with SMTP id
 a640c23a62f3a-b79c233e502mr359790066b.25.1764698694460; Tue, 02 Dec 2025
 10:04:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251128-ads1x18-v3-0-a6ebab815b2d@gmail.com> <20251128-ads1x18-v3-2-a6ebab815b2d@gmail.com>
 <a01f95ba-23c0-4c4b-a6bc-31b316bb04ef@baylibre.com> <DENT40NRKH0V.3UD0JBGRUSCDS@gmail.com>
 <aS7-yml5a2yjM28D@smile.fi.intel.com> <DENX5BPCUHZO.1H0XL6I8M5EJD@gmail.com>
In-Reply-To: <DENX5BPCUHZO.1H0XL6I8M5EJD@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 2 Dec 2025 20:04:18 +0200
X-Gm-Features: AWmQ_bkFQBihuYjqJ6hTYYDY_0ZcAcyxwfNa1mF0OmUsTVJNtQYFDxEG_dUChUI
Message-ID: <CAHp75Vc_ceCi1b4T3D7RK5S2vRW2Aat0XWEAuyTDF9j1fXGu7g@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] iio: adc: Add ti-ads1018 driver
To: Kurt Borja <kuurtb@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, David Lechner <dlechner@baylibre.com>, 
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Tobias Sperling <tobias.sperling@softing.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 2, 2025 at 7:49=E2=80=AFPM Kurt Borja <kuurtb@gmail.com> wrote:
> On Tue Dec 2, 2025 at 9:59 AM -05, Andy Shevchenko wrote:
> > On Tue, Dec 02, 2025 at 09:39:34AM -0500, Kurt Borja wrote:
> >> On Mon Dec 1, 2025 at 6:09 PM -05, David Lechner wrote:

...

> >> I agree, this naming is a bit confusing.
> >>
> >> Andy, are you okay if I revert this back to __ads1018_read_raw()? I ca=
n
> >> add a comment on context.
> >
> > Only if it doesn't start with __ (double underscore), just find the bes=
t suffix
> > (or prefix?) for it.
> >
> > TL;DR: I'm against functions without clear semantics to start with __. =
Usually
> > this means unlocked in terms of spinlock/mutex/etc. Is it the case here=
? IIRC
> > it is not.
>
> It is the unlocked (iio_device_claim_direct() mutex) version of
> ads1018_read_raw() which is the .read_raw callback passed to iio_info.
>
> You might be thinking of ads1018_read_locked() which is an
> spi_sync_locked() wrapper. I will rename it to ads1018_spi_read_locked()
> to avoid confussion.

Or maybe avoid the word "locked" at all and use something else?

--=20
With Best Regards,
Andy Shevchenko

