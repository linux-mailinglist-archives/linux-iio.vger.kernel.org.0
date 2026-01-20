Return-Path: <linux-iio+bounces-28050-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 109D0D3C4F0
	for <lists+linux-iio@lfdr.de>; Tue, 20 Jan 2026 11:19:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DA241586030
	for <lists+linux-iio@lfdr.de>; Tue, 20 Jan 2026 10:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B073E959D;
	Tue, 20 Jan 2026 10:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iFAXFMzl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517FA29A9E9
	for <linux-iio@vger.kernel.org>; Tue, 20 Jan 2026 10:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768903478; cv=pass; b=KNOMvm+1HLZuDBIst7LRso8BtoQFdNI3eRk9d/X5dM/GYM9fEGD2HVWwP/AHALesFLKx+tTzAeLFVr73LIT3tbU2+DkZ5URO/qcTVFcazKSy3Vi/5D12pXmHcBjWAG7sGNhZye0Ktg89YmyGNjiMroSgpFWrakhFDDnCxyHaUfc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768903478; c=relaxed/simple;
	bh=JwuyinSElkxcDvuE2BZjDTtjkxlLVnc5F9ZJDD8DL7M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fb4O1mOaAqC7RGa4402YoTPDV+TRkIl936sglHKMckgWv7jdkVazK9kB4UcFh6JldVaRYQb2JIUOx++4lSy2sGwf5kL/AbbJqygFBI74kUCtr/BUahWJ2b1AaHDQUwWp/Pk29A9suXnP4nvh/Baq69QeUvWX1o2tSjhcRwS5E74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iFAXFMzl; arc=pass smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b8010b8f078so850147866b.0
        for <linux-iio@vger.kernel.org>; Tue, 20 Jan 2026 02:04:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768903474; cv=none;
        d=google.com; s=arc-20240605;
        b=b8QtWc+0pjb9RYERshSjpqMiq6y1iKcPpTwb03fRoRyqvj+Es+3o9njtl+J/MU+sbH
         1jvXQmzbVLjxAKbCyu5yOAbTtqmZmu+WS7SXSZwxgIEuyO2DnCtrX+fIn1STaCTbb6yH
         N3zoixfxy3KU6VRFDJHQRhFpEtXLmlYc7HCJTAzpHnEs/JLAVvIttKUWIDsHVIivvybK
         40iAvU9wFxm+4Dybn/rmOUwABdRROgRJoVP4Q+7gS34NxIJYlGVB3xBdqP/6Kde7SDLe
         VJiNGMOGzW937MLF47LmxmKyUpAN+dHW8Mwa/hZ4mA6LRuPDDm2QM7X3/nGf2WG4mLaI
         1bRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JwuyinSElkxcDvuE2BZjDTtjkxlLVnc5F9ZJDD8DL7M=;
        fh=XPEHVz+bloniU/PzijqWfDVLgzpcFga0F5QrzrahefI=;
        b=RZGBh0R9SmQzqk47LQw8p78yDWCoHQwJ6k8JlUvwXS0MAonNC+a5V+EMzY9Y3I1FnH
         1zoewjBLHJVl0drkZya5IPoKndW2FrCGJV64q0sTzCchvAqIu4YCWVyIJR4k6XXcQ/da
         XiOcYrGa7/sjpEbK9hdtzbyqr5EWFc40Tm73OeSzuT8Lt6yTd8qPVJHFmc+Qe3mM8+a5
         FGDciaX7v7tv391XNFVwrTdcMPt3w7iBUrG2UYNgy1vi0YaOfZoe2sVh8mshsLnfarAz
         4LxV1l/kn/Kg2ieesmyYhlhGKhtIxXn9wHmg20tc1VXG5bw3t+DaH7qCEa5ZnzRtOvU1
         5Ogg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768903474; x=1769508274; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JwuyinSElkxcDvuE2BZjDTtjkxlLVnc5F9ZJDD8DL7M=;
        b=iFAXFMzl/ZEyWZc66XEWn3wEjR0bpw4Tyc2pN1AmeFddETm7UN4cBPfvMJn6i5Dfim
         S8vRXFuCfc8qMuB3uYn4m0m10HwLgaPj+lkOxp/l2NsnKzlAqNu9RJ9HzjDj5xyajxdg
         dVLNgI2Wx9He3q0nYsNwJnwLlZytV+6eaLJX/1SNznxB/9cH2VfXjeyPK1XPJM3LGnpl
         5zidONFXGvMHWMmKK8X47+XF6V3o9Rg/A7GusrjRCaIIM1TR9RzqQQOdc2Dqm4J4ktgu
         9mdfgNr3WDGcS74Zx12PzrhuXP5g75J+Rc6NSVVVmkDf/KtP23OoqyhNp7cIi2rNOvpk
         eQew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768903474; x=1769508274;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JwuyinSElkxcDvuE2BZjDTtjkxlLVnc5F9ZJDD8DL7M=;
        b=KrzkWCIbXIG58QLQPSQKj2EvbxNMcYIk/gqPWJGoGLJz1FzMWMgeoXoYvu2nuJSAUc
         ZaiORO5/3uMwwZjoX+/DGfQJPpmGx365dWhNwKOnJ/bKTJGJCy3XSGbZmh88AZNGwVYN
         oKKU9vAmAfEhnWDkLFDOagx2qlaTDX8t/AGoIfmD9F/RkMisC0khiFTqfJ3F97r90snR
         lhMlKONyI+E6RlIlwtdvDqu6746KZWDLDesFKeifkNnHbVYRXAjeP/Ojm34BSWVSkp+u
         xD3KliD5yElqLa72+dt/CLC6w0LDMdlK7BknkrfcrSGjkyyCVPeX/KR2EJLg4VGLdDmf
         2m/g==
X-Forwarded-Encrypted: i=1; AJvYcCXU/wSztcBrsJUWD2s0DaSU4bj6w13vdG/XRjJIKx3n/PoFJZtKOCUpjn9esoF2xeuu+QVPB3mstB0=@vger.kernel.org
X-Gm-Message-State: AOJu0YywCBuV8C+uZ6AsQTiWtt19KtugNTh1lI/5uBN7DqfZ0C87qLyo
	dQA4eQuR8tbDA2A9HnHhld1ACBU7c26lYOTlaWkVv0y6XZwhSiEW2HVfg7bRW24HGUxDKe2Sq9Y
	aka1o7nhnezycaTed5aUvAPpGehg8Qf8=
X-Gm-Gg: AY/fxX7yZW8iel20XNny0b0vF+G5ILz8AJl4b/BCYzlveghumVJI4TjWxEkM9y/Ly05
	gmLYxFg8hqMkNRs34kEw+5Pd0330+T+lFnRRYU0Bjv967cQ+cDiq4NCd5mD7FQVL2+rE7VCCiyT
	hnh3qrsOVCa0jcgA0KstIaBIehXDR3s0eFAxjFLu4sr1KgxCRuXXp9yi0V0dQqjlxc22tiaNO0c
	AwkrrsPDT+0bceC5hUiJXRnBbCgqhlMaB5T8g1Y/uaVwBkw91N+ZWiRAsxS9jx+pYqwmbcMl3Zk
	1YYkNwC3jwOQWiLedmyo6bSLcWCuE0uHTfT8ulIG0bqsV3qUAO2p8p8KKXkfXncLvY9SaNY=
X-Received: by 2002:a17:907:6ea3:b0:b79:f4e4:b544 with SMTP id
 a640c23a62f3a-b87968e56a6mr1234744866b.21.1768903474093; Tue, 20 Jan 2026
 02:04:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260119213617.745603-1-jic23@kernel.org> <aW8sk9mD-dOHeJZg@smile.fi.intel.com>
 <20260120095041.0000705f@huawei.com>
In-Reply-To: <20260120095041.0000705f@huawei.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 20 Jan 2026 12:03:57 +0200
X-Gm-Features: AZwV_QjNy5cSm9oanWTTHlZN2FqCm-b5LfavipR53P8Yp7D4ZRM1OXEFv9yklU4
Message-ID: <CAHp75VckpV8JWmJ7rwmSAVk71isd=d9J0JAOCjDjmsTH_3s4bQ@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: ad4062: Switch from struct i3c_priv_xfer to
 struct i3c_xfer
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Jonathan Cameron <jic23@kernel.org>, 
	linux-iio@vger.kernel.org, Andy Shevchenko <andy@kernel.org>, 
	Sasha Levin <sashal@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, jorge.marques@analog.com, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Frank Li <Frank.Li@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 20, 2026 at 11:50=E2=80=AFAM Jonathan Cameron
<jonathan.cameron@huawei.com> wrote:
> On Tue, 20 Jan 2026 09:19:47 +0200
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > On Mon, Jan 19, 2026 at 09:36:17PM +0000, Jonathan Cameron wrote:

...

> > > Cc: jorge.marques@analog.com
> >
> > Can we move this to be after the '---' cutter line?
>
> When I really want someone to review / test I tend to put them above the =
---
> so that I remember to poke them if they don't and I want them to be
> included in any follow on threads.
>
> More FYI type +CC below the line. Mostly I just add them to the send
> list however rather than having a Cc at all.

The trick is that you can add

---
Cc: ...
Cc: ...

to the commit message in your local tree. It will be kept and
represented in `git format-patch`.

--=20
With Best Regards,
Andy Shevchenko

