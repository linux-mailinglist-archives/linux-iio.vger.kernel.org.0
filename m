Return-Path: <linux-iio+bounces-26760-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A0ACA4F5C
	for <lists+linux-iio@lfdr.de>; Thu, 04 Dec 2025 19:37:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C33531354FD
	for <lists+linux-iio@lfdr.de>; Thu,  4 Dec 2025 18:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B2034D4F3;
	Thu,  4 Dec 2025 17:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQFfsABn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BC72F2619
	for <linux-iio@vger.kernel.org>; Thu,  4 Dec 2025 17:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764869829; cv=none; b=nVBF0hJFtvFcJ+c1hDbZ0YMlgYHr8zKrS+MqEtPyC2Lr1rLM3TQT/SStogfNjLPpYVAa3uAQBqFQLFT43qmqC+iNofCZYOifBx1M69gG1qP9g9ZPDbgcn52XZD80T5ZSXiuOHy6yEAITYz0vFx6YSAg4aqYOoSr9U5kP76VFe8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764869829; c=relaxed/simple;
	bh=ZgzmBZqMJAawpCjkwWCCg/nGsPnAcX76cb7EUrDgojk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m2+02tmaxnqM95uHzjHZef38CbhsDS4Zz4rG5FB08qoAAq5nXDQYfrM9xKAypk7tvdMvJNb9ZXxsu7X0KkzDO+y+YqsTTVe+WUDbvzI92HwS8+o4uz2jJZGX4OWisnVQOfEg407Aa6dMmL43v3d43e0kTNpvjEjdU8DIbRkyl8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gQFfsABn; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-644fcafdce9so2020315a12.1
        for <linux-iio@vger.kernel.org>; Thu, 04 Dec 2025 09:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764869825; x=1765474625; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8BQLbcjgKsilNfqOn6X43Rt+4x0ozo8KOBEnJ5KW640=;
        b=gQFfsABnpK4bFBTRsa/b5eVWJEs9tOAwYLx/+Ds4AR8KsY2cfi7RYZX9+1AMUXNkVV
         JIQoK8jCfWKV6TD2jpVqiJMWyNzVs/oa2wQlZ8y/adW6xMp2ZNu1DULQ5crHVBXmR/D0
         /9+ZMPTsNURyAuJbcy4Ps4hhNjrttnAL1RxjLOY1PbozdOjhyPKE9Nnwe9rWCwGH6YtF
         gwzTDSbN33pMoz4U6BWxIgGqERABNkjbAR1AbRGeSrIpCLIC1b7fVrHQ/Edyl5nZKsLp
         NOexfg3yMtalo4rkd0weVuh0+xjmU/LxH5WisW1W3ZhDzysdfq4fw+jdf38YfSrsvi2e
         Rbsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764869825; x=1765474625;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8BQLbcjgKsilNfqOn6X43Rt+4x0ozo8KOBEnJ5KW640=;
        b=RpBV6oUyhhskms/93YToyINNYAgyY1ijJDPI8w2hp6vdMQ8nKVc7Q2xSFp1yOTmj/U
         qoZuxHr3tDT7zlrqmde9j+YgP9wTKRa+KlKeMYkRzvHhLF3pJ4oFjZ7+nR6GIEg/70E7
         HragKUEl1Det9u725u7VrP/oE/Dy6gsz++tkpKe3StTS7GHveRNKe2lu2KcrVukidOBt
         B22dLS3OO6zUmyHZY3CU5+E0BJIIBrYspXOhcrVvFZFfvfY4r10i3NYGFnKDEy1x6az1
         RHE4UAiu1XjAOM/QQvdlKmavzGIizohOlUtdpJEkOS09OcCnJaoK4kUl8frIjXcnSr++
         EInQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVauzuacNnHiRw1xFtVDIitXitixHangp42oIuIuCtPpNAaSnym9OKt9Ajj6TFypSXPxIA3JSmdvA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIHehZNi1CNOF0Mygkjq9yw6yCf2ZGuL7Cxvvb7e4tZeR68Y5P
	TKara6S1pK1LH6xjbc/MtfmV1ZgZGNLeVdYa5BH2xFJEwQ4JhSjv3OQtPAHPk3tDwMUhVaqJTz/
	OZ4Jm3yRE+b5lk8lS8IkHEvmDXoKoxZo=
X-Gm-Gg: ASbGnctKeCh4BYz+NWXTqsgMaK5kx3SJUxXqCmBH18adrm4j6/CxNdy2hL/Ak+3Oiyf
	msHCWLSZ3s3goU/MZx3zhR5acIEc/qV2iGBD5y/tlh0WLq0K5JhrFYW4YsTcTAALy2cqV59UxqA
	i/iYDRFcq/Xxgr/24fZC15+8aRFNTxWKeXQMeM9L4GWtuSPm5O5jjhA80HPM0ReTAyKdF842sSV
	g1JwAcFJfiGIKI+MUNzjsxrGlILhnBm6jZTDZiNLTDd72i5AKEusPa6SHa5I0x4PiQ/iwoUB+0W
	43JzDiDJUdQ893EBV9xkGOZ5I8jk0sFEOaa6ENqBJSPTIZqzPSY72U0H3p7PZcz/5Isj1YQ=
X-Google-Smtp-Source: AGHT+IGu4EhWdWebokvC6nyH0CrAw8ML5oSy75K4E2Z1KiQLpuJqOa707YRdV0x+bmhibN66hz9hlhgo0v5tYtZsaFQ=
X-Received: by 2002:a17:907:5cc:b0:b6d:7f84:633 with SMTP id
 a640c23a62f3a-b79ec471625mr414930766b.20.1764869825237; Thu, 04 Dec 2025
 09:37:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251203-lock-impr-v1-0-b4a1fd639423@gmail.com>
 <20251203-lock-impr-v1-3-b4a1fd639423@gmail.com> <3b80f8f3-c435-49f8-8c55-42568215bf0b@baylibre.com>
 <bf1c82f7-da25-47b6-846d-9f8427ee5790@baylibre.com> <DEPLQT84HBAO.2GAY5BHP05HNL@gmail.com>
In-Reply-To: <DEPLQT84HBAO.2GAY5BHP05HNL@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 4 Dec 2025 19:36:28 +0200
X-Gm-Features: AWmQ_bn8M8Heg2nz0ikwFrBiGyFDVL5TT406gr9AGLPt0PPLB8ojYWmxxwHQL8Y
Message-ID: <CAHp75VfpG4PAG6rC5aFYAPLgnOZZzfJcGP6bMzKPMkMjpuymoQ@mail.gmail.com>
Subject: Re: [PATCH RFC 3/6] iio: core: Add cleanup.h support for iio_device_claim_*()
To: Kurt Borja <kuurtb@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andriy.shevchenko@intel.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Benson Leung <bleung@chromium.org>, 
	Antoniu Miclaus <antoniu.miclaus@analog.com>, Gwendal Grignou <gwendal@chromium.org>, 
	Shrikant Raskar <raskar.shree97@gmail.com>, Per-Daniel Olsson <perdaniel.olsson@axis.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Guenter Roeck <groeck@chromium.org>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 4, 2025 at 7:18=E2=80=AFPM Kurt Borja <kuurtb@gmail.com> wrote:
> On Wed Dec 3, 2025 at 5:34 PM -05, David Lechner wrote:
> > On 12/3/25 3:50 PM, David Lechner wrote:
> >> On 12/3/25 1:18 PM, Kurt Borja wrote:

...

> > When I made the comments about keeping "mode" in the name, I forgot
> > that DEFINE_GUARD_COND() only extends a DEFINE_GUARD(). So I understand
> > if we need to make names that fit a certain pattern rather than what
> > I suggested.
> >
> > Still would be nice to have:
> >
> > iio_device_claim_mode()
> > iio_device_claim_mode_direct()
> > iio_device_claim_mode_buffer()
> > iio_device_release_mode()
> >
> > Just really annoying to rename iio_device_{claim,release}_direct()
> > everywhere since we just did that. We could keep both names around
> > for a while though to avoid the churn.
>
> If we rename iio_device_claim_direct() (which is huge), maybe we can
> pick shorter names and more descriptive names while at it? I was
> thinking something like:
>
>         iio_mode_lock()
>         iio_mode_lock_direct()
>         iio_mode_lock_buffer()
>         iio_mode_unlock()

The device context is important, so at least iio_dev_mode_lock() (and so on=
).

> Shorter names will also keep lines short when using guards.


--=20
With Best Regards,
Andy Shevchenko

