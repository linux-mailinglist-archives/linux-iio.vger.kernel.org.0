Return-Path: <linux-iio+bounces-2545-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 33809854944
	for <lists+linux-iio@lfdr.de>; Wed, 14 Feb 2024 13:35:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 734DDB21234
	for <lists+linux-iio@lfdr.de>; Wed, 14 Feb 2024 12:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E8E524CF;
	Wed, 14 Feb 2024 12:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f1IRQrOT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9733F495EC;
	Wed, 14 Feb 2024 12:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707914134; cv=none; b=d2wN02Iv4jGQPf6vW+5bFhwvsB7Z8LTwR0bjBvjfWf0ypmWMmqf+uUDE/R0YhhhgS0aQ3nfqorKjtR5q2lZYmi7qkrvJ6Ic3/pFBH4olpAeqZ8jR0c+CtVkqYeX0ZuTko6vPWBJ+IL6QbdNl0S+jSQ287Pfqwzt/AKACAU2pUFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707914134; c=relaxed/simple;
	bh=5zNDn6G2uyRxzkWQucDsRV9a6GOPLLMXXgkfQonthms=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cytrhj8946G8RSmemNSJUS2sWQkU9BrxPA/99u4y9AOhB06AGE640DoC4/QmEzI5t4xhdZkoXFDtXNL6yavyJ2/ToGPDjQVxZCCgY57JohH2DhzXeWmDzbQSnv1yrwjYbk70Qzn2dBQptSEgMlXfHMjX4c/52gMw314ULiAXHX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f1IRQrOT; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a3d002bc6f7so190632666b.3;
        Wed, 14 Feb 2024 04:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707914130; x=1708518930; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5zNDn6G2uyRxzkWQucDsRV9a6GOPLLMXXgkfQonthms=;
        b=f1IRQrOT+gBXwMJ4DXEbK57s6oENWJq+HooetoA7Z7dy6fO3J4AxUnTPJ06yBiJKeK
         lmyvUGbQmUInGjDaAD57t2cdDaFsTA38xQy9dJS/X5gmaqYt/U3eIBmS2NReVBTwmYB7
         Z4jWvEGlxB5AmrWZHFTPy8JV5DpK9T2uYzWwrjUqW+S0GuKZbQGZSqOpp/Q97SepsjVd
         iuMxdFGGsrSg+qxZyCPL7a6gV9wE1I7iQ+xZ9mvQIGYYqTN2cWGjsna52Kw/ur7RTEMS
         xvasZ065JSACyo7/iX8EbPki5xES1xFD8L0GMq4wChngX/5eC4wsqqbRfJgJPpA/rqLH
         c9eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707914130; x=1708518930;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5zNDn6G2uyRxzkWQucDsRV9a6GOPLLMXXgkfQonthms=;
        b=ajYjjmOsW/oAEAaHu8TWf2CeJ+D8m239qKxmvOgXscDhGbLa1gS6j5JNC7DYZe0/xL
         3n0m4B9tL8sPJftbcowBrU+NS6FaoJIkwwaL0HkWYiH6SYyNEhkOeMlQE2JuuPnHKdTK
         NGAio2mSphLGsAOcW9CqCOwzLXVn30MDXGg/ZmUZNVupaO7XHwpln0IF0qjPenJ4XdRi
         s1jyFYkzbT5r+7MH5DGePG5sLZepQmA15KVwYt82ARIQ6kDDNCY+pSbmXSMZglEhj9HF
         LoE5JNcfjgELWwHmfMrBGgUno6DlFVwyJBFfsbd990Xf7mdAcsGRW4hm8nvBDhcfnEsV
         u8jA==
X-Forwarded-Encrypted: i=1; AJvYcCVCkOtrfRNYUMN9GLigu6L5vog1BqPaKbpYd5U1HU9LzXN2DR9RN3tkF+W8CT8M7MpxflgoPE9p0iz1XzE95LH+bsXzKi4yI5QezQ==
X-Gm-Message-State: AOJu0YymfzcPXSnezGjkWfWD8ImSJW0eda9BXavXvv/A4rW88o9SyMi7
	b38PzbXFU+57W8HSfcGCz0JuVOGSFg+apkCrMEfo2EgqcUsyxoNS
X-Google-Smtp-Source: AGHT+IG4sIFVH90t3xYwun8FzRhOe0y2/DWTYU85HT+qDZDjYG8cJWLsRWyyYcN6eqUjnnioXHf1HA==
X-Received: by 2002:a17:906:35c6:b0:a3c:31bd:e9c0 with SMTP id p6-20020a17090635c600b00a3c31bde9c0mr1818526ejb.9.1707914129867;
        Wed, 14 Feb 2024 04:35:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVrI3vjT36yv6e/1hDzoIjtqrlUhr3pE45jVE0/0/WAQEDhtjKzdi8WjgYg5450CWgkV2q569xw3cEFcJktlKLs+Gru1sGnQb6wej6ufB7BMuE2MdcW9rCoCjx/nvmNBpNCaQsDnZ+g9twHVA+CLdrUES6r387UcHGS0ZvuM8CJyEnwqYPmAN/Hz2r9eV534Hjsb4cEDOz+WctzATkKOBztPfR2Y2FcYD6OL+vAlfcnuZOBwn1wZcvVuemJsk0KrTEZr8tmNap/j6Cm7fCEAzy8i/sxWXu+dhciLlP+t2S85HWlPrazPt/ZiRfg5dyN215YGkxP2B0gSCPHYitOam+QkMJuSx0P14uLdP9pwNk/6/ISPuBPZIEQZj2BgW6AlFF6K7oqAtpn30XR/UwpjWLT
Received: from ?IPv6:2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47? (p200300f6ef1b2000944ccbc71e1c2c47.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47])
        by smtp.gmail.com with ESMTPSA id wb12-20020a170907d50c00b00a3cf7711d40sm1769353ejc.131.2024.02.14.04.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 04:35:29 -0800 (PST)
Message-ID: <8522d498f8ec65b4965aa04723f25f8e0e5a789a.camel@gmail.com>
Subject: Re: [PATCH v11 0/7] iio: add new backend framework
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>, nuno.sa@analog.com
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>,  Jonathan Cameron <jic23@kernel.org>, Rob
 Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
 Frank Rowand <frowand.list@gmail.com>, Olivier Moysan
 <olivier.moysan@foss.st.com>, Rob Herring <robh@kernel.org>
Date: Wed, 14 Feb 2024 13:38:48 +0100
In-Reply-To: <CAHp75VeYbZsfUi+VMMqJUXf6t18H0jY7Sh1tBCsUqxihkoBhoA@mail.gmail.com>
References: <20240210-iio-backend-v11-0-f5242a5fb42a@analog.com>
	 <CAHp75VeYbZsfUi+VMMqJUXf6t18H0jY7Sh1tBCsUqxihkoBhoA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2024-02-11 at 18:55 +0200, Andy Shevchenko wrote:
> On Sat, Feb 10, 2024 at 10:57=E2=80=AFPM Nuno Sa via B4 Relay
> <devnull+nuno.sa.analog.com@kernel.org> wrote:
>=20
> > Changes in v11:
> > =C2=A0- Patch 6
> > =C2=A0=C2=A0 * Directly use dev in devm_iio_backend_get();
> > =C2=A0=C2=A0 * Move comment above the proper place.
> > =C2=A0- Patch 7
> > =C2=A0=C2=A0 * Added blank line between includes (to logically separate=
 them);
> > =C2=A0=C2=A0 * Move back to 10 millisecond sleep;
> > =C2=A0=C2=A0 * Constify expected_ver and removed unneeded cast.
>=20
> Assuming that the fwnode vs. device reference count is fine (as we
> expect the backends to call respective APIs and hence have backend
> device pointer valid despote fwnode reference being dropped before
> getting the device) and timeout thingy had been reverted to the
> original value, FWIW,
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> for patches 4-7 (OF is not my area of interest at all :).
>=20

Thanks for the ack!

If I understood the above correctly, we should be fine. Unless the fwnode
refcount can reach 0 without unbinding the device from it's driver (which I
don't think it's possible). Note the backend will be freed on the unbind pa=
th
and through devlinks, we guarantee that all the consumers are unbound befor=
e
us...

- Nuno S=C3=A1
>=20

