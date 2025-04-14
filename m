Return-Path: <linux-iio+bounces-18097-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90EE9A889B7
	for <lists+linux-iio@lfdr.de>; Mon, 14 Apr 2025 19:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD43D1897F0A
	for <lists+linux-iio@lfdr.de>; Mon, 14 Apr 2025 17:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D9828A1CC;
	Mon, 14 Apr 2025 17:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SyZsVgCG"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBAFD289363;
	Mon, 14 Apr 2025 17:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744651508; cv=none; b=GG21PAEAl1e0DqHcJF9g/3eWhWg5ZDi7L+Av7VbfeQo+apv3AjGb0RzeA+mQvfIsh7EqsUghCvAro3CrIyrMSQ6cL/TF/zOvg19GBjHdFtXvPiJS1B4WCSxOdKYp8W9kt6AO9r4Yt08kyj/xNOE6kBR/uy3uvNmWgHgEEguWYBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744651508; c=relaxed/simple;
	bh=S5MMPIqTPH2JEdSYmd02G+GREAZMQM2lkUVv1l0JNB0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GjfGch1l975HGYUL2Phxpnn2W0YaWmIz+PfK3ASQXYqr+x4C1eHKBM5DX6Otj4bru0xpkoUWt4D42Pbi/VoSVCY1ZZEGVRG7EHg4NAlpkRIXIMCYJMBvZU9M2/5oakepB9vQMpK2OjkqmjjrPdlN6bPr2wQrRUaON6iJkHbDyQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SyZsVgCG; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5ec9d24acfbso10210644a12.0;
        Mon, 14 Apr 2025 10:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744651505; x=1745256305; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S5MMPIqTPH2JEdSYmd02G+GREAZMQM2lkUVv1l0JNB0=;
        b=SyZsVgCG73R2Ot3rWm9GwGhmy5Y0OdlthDLwtAgHp0qkD7BvDMZom6oN3UgSuuwFuR
         kf3BuCkjs4V8J1Xwwd9o2CU3VyNbjCjZw/6+2HzJWOQtIJ8j3nV0UhtCDwp4ZG2C1L0i
         Bbk111iJ9UB0COxXcun6qxkUvGpLT5V9xXMlL7S9KhRtEzqKFAEac/sIuKcqX5pTa0/T
         zxzAS0Cr9KzPJ4BNuNcOpT8vbgcNIh00Qmjf/s5l8j/O7j5/i0S00X7og4Z5/56LTKHp
         Bimxdnc4pAMpYmHDmS/ZGJZZvjPUZkBdCUeEm278rCBnpTVaNw0LIUbeGont9i1Kn0tv
         lDCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744651505; x=1745256305;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S5MMPIqTPH2JEdSYmd02G+GREAZMQM2lkUVv1l0JNB0=;
        b=Aebec+MeCtv0v9MWX1ZQvjBChLlCHz/UBNmZS3JeRJBy2x/HMKTExu56EbRBd3py17
         xdYNO2kqmjEyaQdr+D1EEGsK/vEa/f9ymD86a5jVLQ57+RLzte0Mhjy868hGPClePfYh
         cmL5LJSyUjMpT9Rgu3bViBE4+A8i7g8sS3hxdelxPfo82HuNMvgMrDce6qmuRgY9+Z2C
         fwQDL1+Ut7g1BE9uPobox4j0RJaWFhwc9ONnnSOUfRpNqnqxWukYMnvSp3eYU7GGAujt
         TsKFx/IuudWYyUXEoYFaxjZWXiofOArCb2eWtih2xDS+9Htp7s1ke76XlvJgM24rnpxp
         N2Pg==
X-Forwarded-Encrypted: i=1; AJvYcCVPKpeBa1A0rAoSEEfF77iNsCE9lgf+mZGxVe0m10G5RFw7IFnKzoycGvNOYwBmxooZ9pVVmmPTZa9ouAOO@vger.kernel.org, AJvYcCVh+q8Yy01100QGohc0U080SR3oSYS4dKnYszmj8zHHEr2SLfYpgN0wUnitakZzMeWrnmsT3JBYWgNT@vger.kernel.org, AJvYcCXXCWJr8akZrzDnHOQV1dttk9AAVbi0NrVoC2Rkx7p4eEk7+Mi6/uz0peW2u40EjKlJdZQl4TBKdzty@vger.kernel.org
X-Gm-Message-State: AOJu0YyHJPcRn0q+8+HYhh4NORQCTRKFWbKOd+ZUkJ/JCqIA/HAw8GYu
	MtUlUfB2OX1cePpllS72Afx6CHVL8ylODt+mV+3xZMW6FbUeYPz2u9lHa33PUIorH1XQvoePjnm
	ThI2pxdmV/96aEV9TgaKkhKCmNWI=
X-Gm-Gg: ASbGncsXezHVlfXYs3v2Axj366Y2Hb6i4Cr1kgEDpMol5RsfbvYigEAL20j90eIEHdb
	ddcPmQmpnbRuYFCt/emudwCfqi7vNuQ4EBUH/zV+a62tcF2sbKNpLI3kRRZbKmMFFmraSu6OeZq
	y0eksw1pE9paIkUBEJLt+AhA==
X-Google-Smtp-Source: AGHT+IG2QcYojr21rG5cPrm4BVHO4RvMT0edy/7fHe6WGPbezY/teacJD34am1KrFosC8vc8ScReIjIFuaIELXr3GDE=
X-Received: by 2002:a17:907:3f0f:b0:ac3:ed4d:c9a1 with SMTP id
 a640c23a62f3a-acb16810139mr33459766b.17.1744651504714; Mon, 14 Apr 2025
 10:25:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1744200264.git.marcelo.schmitt@analog.com>
 <56e76070b72d15950bf1fb01e68e94c42e79905b.1744200264.git.marcelo.schmitt@analog.com>
 <149672e84f09fb178c90856920e3cfd4f140529d.camel@gmail.com> <Z_0sBomGtMKXysgJ@debian-BULLSEYE-live-builder-AMD64>
In-Reply-To: <Z_0sBomGtMKXysgJ@debian-BULLSEYE-live-builder-AMD64>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 14 Apr 2025 20:24:27 +0300
X-Gm-Features: ATxdqUGXWe4I2RP946LA264Mds0nTZUdAW-UzXxJ-zQ5D0aLP69VaMKKmJfCPVA
Message-ID: <CAHp75VdxwKrqhvKAzZmbh+NsUOi2bsdCj7MdnLEP2gK7sY8PRw@mail.gmail.com>
Subject: Re: [PATCH v1 7/7] iio: adc: ad4170: Add support for weigh scale and
 RTD sensors
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: =?UTF-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>, 
	Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, jic23@kernel.org, 
	lars@metafoo.de, Michael.Hennerich@analog.com, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 14, 2025 at 6:37=E2=80=AFPM Marcelo Schmitt
<marcelo.schmitt1@gmail.com> wrote:

...

> > I think you could improve this... You're taking an all or nothing appro=
ach.
> > IIUC, we can have cases where only two GPIOs are in use which means we =
could use
> > the other 2? There the gpiochio init_valid_mask() call that you could
> > potentially use.
>
> Isn't gpiochio init_valid_mask() only to distinguish between GPIOs that c=
an
> (or cannot) be used as interrupts? Not sure AD4170 GPIOs can be used for
> interrupts at all (think they can't) so didn't implement init_valid_mask(=
).

There are two masks, one per GPIO, and one per GPIO-as-IRQ. I agree
that it's better to use valid mask and not reinvent a wheel.

--=20
With Best Regards,
Andy Shevchenko

