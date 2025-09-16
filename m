Return-Path: <linux-iio+bounces-24130-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7AF6B58F67
	for <lists+linux-iio@lfdr.de>; Tue, 16 Sep 2025 09:42:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92D381BC0A4C
	for <lists+linux-iio@lfdr.de>; Tue, 16 Sep 2025 07:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B239D2EA74B;
	Tue, 16 Sep 2025 07:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HSVCqfFK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DAF275111
	for <linux-iio@vger.kernel.org>; Tue, 16 Sep 2025 07:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758008539; cv=none; b=G9D/sSU0jgsB+8POmEM7x+75UPf8oL8OzEHWH6Cpu6S/8WLrQbtRsGKej+VTeBY+1Ywg5he8PJ6FWM9IiWqwRQqQLaEd2qGqMXAqZ5YOBYNhR0kFn2EBUFQ7XpWOTGP4QnCBgVSAsKw8rX0qvUTeSA2WZG+QRHThbOIWE6x2Hlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758008539; c=relaxed/simple;
	bh=MajtWc/LSqmypF88GEgwsqo7vwQ0+GiL2Fw7fIStbIU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ko8+bOt078PUitULsLDiHksr0PFES61/VgABP/+6KU+eglYj7FqRQCbDeddumP4el7DnM8NiaoN7xgzDjXRCHubGI+MEKlMU8oGn2+XSfnQZ0hTX+LvvU9IJEJNb6iUPlj8HfYO88KdLtALInJHnFXlyqxPMmfS+WeRNV5PZTtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HSVCqfFK; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b00a9989633so984112266b.0
        for <linux-iio@vger.kernel.org>; Tue, 16 Sep 2025 00:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758008532; x=1758613332; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=seiaS3SE4RcxpYiplP1sTiZbmiKfUGBNakfZvP8oRTE=;
        b=HSVCqfFKUkYMNKW4S2JCKiOdRDkw5BhX6CAs1TvWI9o/8TZky1ungVKWsSiR9YXuV0
         6us8oMG43j4ynyh3hxh3IYieJ+zR+LlVV+VKb3YhWYgWC6lr89r/13/U4axt4LXFA0sU
         zF7FKZj2eLetHkIlGqN8sxWqLd8EcwdDCtYnbjeJdrAYBRmp+N0phmuvwCtf2u5k2THS
         03h6AkUxgdSHXzket1rxAn3+mHl+uqOkPltv7Ts2TszVWT9USICGq55U6p2r9eNQkAfs
         wSezk9eFhWuaoprubK55UrCMwAnnE3ADritSZRa7+4vDpbZJmfpetLav3XYr9cJYGpip
         2iiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758008532; x=1758613332;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=seiaS3SE4RcxpYiplP1sTiZbmiKfUGBNakfZvP8oRTE=;
        b=VrLWN4wnKg5d/gNy0rlcPCr/MUj6L5BPytulAD3jCuhxhqabOPXwE1Pl+O2dM2bK4q
         dpP6ZftcBGHz+tkFAXRZIbNsARjTNjrltetjlajcKnuX/DB7M/b+rm/NClYME35zMsQo
         88rPW3asgYWxHphLtY0nqika5JHEBeMtB8Z+EzmBzw36qcPP5Grj5BOHQgEx0jJQuYEw
         bwcWiAbIAYHzYr6dVBm51E4H6SnKoNfAo9wTibfy2hskaNbOM8gMO6Imsr6NLC+yERYn
         7LCkcU+x9ypLRygfsQgFOEEifgmuyCNpj3bRMuSREwA+H2NlRyJre4+VUoswqB/o/i28
         Nmpw==
X-Forwarded-Encrypted: i=1; AJvYcCX5KA2twJEGL2WtPtvocuhWrmrYbXOUxRSU/1zKNKKUY640d5NEk6sruFlDCJQXMzBKZ49AjDw16hA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjhYhd7w1GlgjiVT/819Zb3FX5T/8FCllpjo1zcZxoMEMbLFIf
	dxgoUJTutOwOTn/7ddcSGu7fPcsBuIp5EpwyDnx9y0W5RTYxIptQt4QDO2r5VwhJQC2XS6bYjrX
	CWEgJoj7weGWzI28qg8mTkqhwceeqmUY=
X-Gm-Gg: ASbGncuJQMwKGkgrs8oYJH9anK9KLH0d2vfZi8NoBEm7nXityQTqxDQeUlOjVJqAhak
	oHThBKb/tdCVyIiNpUzo9MM4AceZqL662BBy3tnJsfHdAJC93K1FDsafzAneAaTY8fba3MjiJQY
	Ado27AZl4k3W80IvX7T3ttu3+q91EBaCfXccLUBJlKBDe9DPJtagp7spTXrzA7Y8lHqYyMFLXLh
	r6Fiag=
X-Google-Smtp-Source: AGHT+IGZyHMyvgkDW6LuU35ofsRn0sZACfWWqhSLafHvGIMD3obwLIYTtrG+n/1NkzTnEp1u5/0DGgd/99ITtrLndkM=
X-Received: by 2002:a17:907:da8:b0:b07:dd5e:16be with SMTP id
 a640c23a62f3a-b167deddbdcmr160525866b.4.1758008532394; Tue, 16 Sep 2025
 00:42:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915-bd79112-v5-0-a74e011a0560@gmail.com> <20250915-bd79112-v5-2-a74e011a0560@gmail.com>
 <aMge0jYwYCiY72Yb@smile.fi.intel.com> <20250915211321.47865d3d@jic23-huawei> <c1d21e3c-b0a3-40a5-b693-a38673f8bf53@gmail.com>
In-Reply-To: <c1d21e3c-b0a3-40a5-b693-a38673f8bf53@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 16 Sep 2025 10:41:36 +0300
X-Gm-Features: AS18NWDftmIhKHIIy4Z72h2BuNDuK9l8wDcCPAp-uHKsQZJ2aCO3R_pGAN3uBKc
Message-ID: <CAHp75VeoN3JCpLKS0LZMP4p2xTz_Vpi9Jfb_2bqxX7wHtQKb-A@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] iio: adc: Support ROHM BD79112 ADC/GPIO
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andriy.shevchenko@intel.com>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 7:52=E2=80=AFAM Matti Vaittinen
<mazziesaccount@gmail.com> wrote:
> On 15/09/2025 23:13, Jonathan Cameron wrote:
> > On Mon, 15 Sep 2025 17:12:34 +0300
> > Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> >> On Mon, Sep 15, 2025 at 10:12:43AM +0300, Matti Vaittinen wrote:

...

> >>> +   data->vref_mv =3D ret / 1000;
> >>
> >> I still think moving to _mV is the right thing to do.
> >> There is no 'mv' in the physics for Volts.
> >
> > I'm not disagreeing with this review but I'm also not going to hold a
> > driver back for that given timing is pretty much such that I merge it
> > today or it sits a cycle and this one is very near...
> > I'll get fussier on this once we have written up some guidance and may
> > well send a patch to modify existing recent cases like this one!
>
> As I replied to Andy, I am disagreeing with this. I hope we won't start
> renaming variables with capital letters :(

Why not? In a new code would be nice to have the units properly spelled out=
.

It seems we have one of the strongest disagreements between us, but I
stand on my position from the angle of the scientific point of view.

--=20
With Best Regards,
Andy Shevchenko

