Return-Path: <linux-iio+bounces-18533-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB90EA97826
	for <lists+linux-iio@lfdr.de>; Tue, 22 Apr 2025 23:04:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A63283BE05F
	for <lists+linux-iio@lfdr.de>; Tue, 22 Apr 2025 21:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2859C2D3222;
	Tue, 22 Apr 2025 21:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E8GcYro+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6E7223DE0;
	Tue, 22 Apr 2025 21:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745355859; cv=none; b=Cj8U42fI+NvYOOalK/DtcfVLtjR7nLc0HpfLN5uCqfTzuHSknl3pb4lw/X/8ieRn2m0bZGF4iYIZ22VDxx+pRmBHyOEgLBebrK4Nc9+mIrEQhsVUsUFUIu557Qj+c65dj50P6/ofXM0T/yOUrp2p8RNOXK/d8T6tvqoajhSmJ0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745355859; c=relaxed/simple;
	bh=anKj+Knteg6KR1waU1JJYT4VF5OSNwAWooPMmoAz21k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qzh5+mjLsyfTGCcbxqCizs9zHiuYTb56W2bhtdKIy5NdnLfgGhgvmBfcWdasc9eAtNC4UvNk9b+Z3+7hQXirhBraw5KEm9U3H0SeerQvHDaiDHRM2H2fvp5hVJxEGs8EgtRFxTmvzFF+KsFMWPK7KS51MAeKq6LkrudgoEQdHyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E8GcYro+; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ac2aeada833so59374966b.0;
        Tue, 22 Apr 2025 14:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745355854; x=1745960654; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=anKj+Knteg6KR1waU1JJYT4VF5OSNwAWooPMmoAz21k=;
        b=E8GcYro+JgHwWE4KnmOdUMv95GKhggWjpS/Z84C2ndSqBWRRXwANxYAq/rXbGv9Pdy
         nvWM7ubJSmaFZmCj/Ofx+H3LyQUw6N3EGF8uhZDGNYbcw/3wD2M2P1LHZ05afpcRwLHI
         bS5k5MZGhx860YVpXA8ymg4SxhTe+AxOgHge552Ot1nCmKD0ZTQW06a/ycZe36x2P9Go
         xx5R8ZkQwD5ep6Bwmdiwjy4v2dx/emrDUG1fIWWDn2hnMr6ok/EmgwcjbM7xjyinyYHZ
         CyEQXgq7BCoPJDAgBorXguB/5CwNLDuXNBpCYUtw5qYjbhdegaZ6jOYdx2+3zzdJHt8y
         HaCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745355854; x=1745960654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=anKj+Knteg6KR1waU1JJYT4VF5OSNwAWooPMmoAz21k=;
        b=mJ99merX2W51VV0r0sISqv8/8JSZk232fPuZk+dzM7BYOlm0urnCfYl8fKAbFCHDoe
         qC1TQbJlq27lxrR2OOTxBu+MkCemVsMwpfBpCV4FwgRrXhZq7vaA6IWvOciYPjXLt5S2
         V1p5gQwWHyOJcg1/4AcDllCCdSsKneKQBK11xSEPWdvf6ZWoNyloJAkLCCGC6IbGqE1X
         IblfRXrAyot/x7W58TdR/YJbew6Gm4rg26VezMXmuppNMQ5DZVa7fCF5zzfg/4pAQIAs
         9Hc99yAsWnHkZ4FUpTPlclhjNRSfUvJpWBESiAjPtR1vfXMsWy/niRpY3+X9kBg8+1vp
         ImPw==
X-Forwarded-Encrypted: i=1; AJvYcCXGa1GoDFenZE9S2z0kivIou1PzBogKklaBlSodDZqsA7pSh0f8CkL0dP5wUNJcqMr4IQxfPr3DON0=@vger.kernel.org, AJvYcCXUZmN2LFJbhmPgJglqGkmEGEmqyOIQymJlYLpPSN/wbJOnfylj4mG7UEJ/3Vzi48UsQMjSxJ79wfL05nZD@vger.kernel.org
X-Gm-Message-State: AOJu0YyOJ/bQY0pFEzGY+Az9+42u0sKrDgwE6IT9njdaW/H2cezS1pAK
	vWB872fce00HHl6AeljU+kZ/p5b/RpDbyz6X8Vi4iu/eFrAIOqryQMLW6ftxplrW/m9GrcQ+Z/z
	C/CODKGnzi79qxmtMjGyGcynWGG4=
X-Gm-Gg: ASbGncsHi66HzJ1rn2u146hOe3m9lUzFXD9sgWeoh1xld6nvkKaqd9KeZkv4sU6OQzJ
	01cOhgR90E/2bTQrOXC0DdC7x1EvcK0bYQ64QrsHDWF4LHPE8ho16cTPu3ldZrPy9ERvYH/8UhM
	1kIGK8nUtaITbCt9uMWaLvuQ==
X-Google-Smtp-Source: AGHT+IFiZwqj/ilaVmFd+6rfD6FBY8RqKG6AurTQ2dwX8U67r7lQa/1goPB7Zh08t+GGLri7WHVJZ11DDIWwo1sKcnw=
X-Received: by 2002:a17:906:9fc8:b0:abf:742e:1fde with SMTP id
 a640c23a62f3a-ace3f4e87c1mr39726766b.14.1745355854290; Tue, 22 Apr 2025
 14:04:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250422-iio-adc-ad7173-fix-compile-without-gpiolib-v1-1-295f2c990754@baylibre.com>
In-Reply-To: <20250422-iio-adc-ad7173-fix-compile-without-gpiolib-v1-1-295f2c990754@baylibre.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 23 Apr 2025 00:03:38 +0300
X-Gm-Features: ATxdqUHmdzJyizCSkMvpXEfsHgU7NJCvEoyQfUXU_lgzjFeXBtZBBxwFtejceNI
Message-ID: <CAHp75VfHkKC81EinO+oN1b0=NRkwmNBLPky=HkrvPJCmt4njDQ@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: ad7173: fix compiling without gpiolib
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Guillaume Ranquet <granquet@baylibre.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 22, 2025 at 11:12=E2=80=AFPM David Lechner <dlechner@baylibre.c=
om> wrote:
>
> Fix compiling the ad7173 driver when CONFIG_GPIOLIB is not set by
> selecting GPIOLIB to be always enabled and remove the #if.

I'm not sure we need to select GPIOLIB. If you want it, depend on it.
GPIOLIB is not a hidden symbol, so why "select"?

> Commit 031bdc8aee01 ("iio: adc: ad7173: add calibration support") placed
> unrelated code in the middle of the #if IS_ENABLED(CONFIG_GPIOLIB) block
> which caused the reported compile error.
>
> However, later commit 7530ed2aaa3f ("iio: adc: ad7173: add openwire
> detection support for single conversions") makes use of the gpio regmap
> even when we aren't providing gpio controller support. So it makes more
> sense to always enable GPIOLIB rather than trying to make it optional.

...

> Not related to the fix, but I also question the use of the regmap here.
> This is one of the ad_sigma_delta drivers that does funny things with
> the SPI bus, like keeping it locked during the entire time a buffer is
> enabled. So, if someone tried to use a GPIO during a buffered read, the
> GPIO call could block (waiting for the SPI bus mutex) until the buffer
> is disabled, which could be an indefinitely long time. And to make it
> even worse, this is not an interruptible wait, so the GPIO consumer
> would effectively be deadlocked.

I would say either the entire buffer mode is broken (in software), or
hardware is broken and GPIO shouldn't be supported at all if the
buffer mode is enabled. I think the best solution here is to remove
the GPIO chip before enabling buffered mode. If GPIO is in use, fail
the buffer mode.

--=20
With Best Regards,
Andy Shevchenko

