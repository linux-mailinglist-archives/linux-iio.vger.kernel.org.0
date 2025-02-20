Return-Path: <linux-iio+bounces-15846-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB4BAA3D97F
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 13:07:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1646D1899A73
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 12:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5D61F4701;
	Thu, 20 Feb 2025 12:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LCSu2F9O"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851C91F150B;
	Thu, 20 Feb 2025 12:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740053253; cv=none; b=gBIJC8Rir9znVgvA9YS53C8b1B3+xUG/9QbOQoO8QJ8gJ4K1QTEFy/qIRFixvKJ0K4twcLRfiSg1jXpyAInNU5hOz11osM4CcsF2O4ehRh9pAmfAlzSPRcd3YFdkOCOhR1jG5m7MIAIoakqdv1byFeDCqwtaDkQiKhQfhPXOHz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740053253; c=relaxed/simple;
	bh=6fyjQgnkxrUl+Ka3bJwwVFK7VfyzlEEXB35xRfVSrGo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gjCNVF8OfAhySnubwPFWsVtX7Xe6GN8h9tAZmchRBOSOPvZ7zlJx3F0v3fIDfz+yuF7Ki6MGJldTzHtsELuHzMMiOX/Mj9qNDFjuu0VmzHosHlIfx4hi+6BdwLlOV5jmiBQRDLqTT4CbljDnE8zlicUHk34RXocm0Tep/emjkvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LCSu2F9O; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5dee1626093so3713714a12.1;
        Thu, 20 Feb 2025 04:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740053250; x=1740658050; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P4HA3a476hov3ntftaoBig8lyt8y4gBvXJgT/JzvNpg=;
        b=LCSu2F9OolRHigxDsl0CgSXaZYWSarrOSA0kBKze5kRzpMrKdvZzppUtV2d9VbR8f7
         mj6deFpbJka6/wfiH+Bz89rdvmdmuqRBRQR86rETQAymz1b5sUVPr+e7dPV2uSa20ndV
         jhgUDfDJPoLhvgBhGj/7R8ytKHNoB6wFSAUhQR6uzY/t5R9EDi42jt9Vwuf4LdSw+AfO
         DjNy5/HPKGQ4t+ZWvmi1ONNlb2YsO5Ytil1r0zaQf2QaniSaKqINce3m4Fn1mMjY4/Za
         s2TY4xL3dgyZ8R3xgVLN10KNQk1peUwIgL6ht6uuM1hgSV7muDabkq6UpfRK6eGDP7ee
         MrTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740053250; x=1740658050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P4HA3a476hov3ntftaoBig8lyt8y4gBvXJgT/JzvNpg=;
        b=HntWc7dU6q+UuvCLxbGyE2+FzXkP3VABSRdknkQXP8rECKmvUn29/Wl2qU5rD2LKkA
         oZ91g5kaD6XdBv4EY8bjsGcHv6/kvdYtSz87D1wyHGBVulcn7mcl8hkcWpqyJXSgoNVr
         kID4FhQNaTT+4Mr7ZE7VuoKhzpkd80N7CA6EHIkM07iQjWuY/9Rvum7T//vcapcpi3R/
         O7Qo6VtKOpav+JwLmUTMJjPhvY5aj3gXkpPCJVLwHpBKhvmhHm0PrEhtQyj0R4Xyj0B6
         GrJd4wGj7zXKp6N351RsJB++Ir9vHtID5Amih7hoGjSCzyQzs09tKr3LqHGLHHVHEoT3
         grFw==
X-Forwarded-Encrypted: i=1; AJvYcCWIYJidl5yAlb1N03Zewwu7Wn47YgVZcWeytFATXPp5XN3kGxDS5vsEt1zEGdcploX/OAuRvYDf16VX6aA=@vger.kernel.org, AJvYcCWJpX1/bT7MaAt9vAdpOatsyZpiQ5jSjze/HfXN0RsVQY83Ol7nf+nmsTizIDyi7FpfLCjzyiEXXbskPMBN@vger.kernel.org, AJvYcCWQ4ROJO6aNlK/voKErkNpdWeFP701rMzH7Jsok1NmqLHaQ9ElzwVb6YxdFZ3G7GmGS/M5EVZxYsdVd@vger.kernel.org, AJvYcCX+gCSlfU7pyd5IUdKNylQCfntOR1kqBNyxJ15ntzdgbgi/VrntsGPHAcXel2C7AVhPyYrFzL0pJk+i@vger.kernel.org, AJvYcCXKT84Bt00dPt5kYAEWRYTy2RA0Z/KWoDIbxeTAmN41TX0Uw+YnmKQGy8w57R2yfOlGLtpt5uE4o/hG@vger.kernel.org, AJvYcCXX9bPSImFCUuSNcZ8p/oXbPpfjC339WM3ztHqxmjyh+C6D37hyDkn6FFIqLExdRKpCNC58pudG@vger.kernel.org
X-Gm-Message-State: AOJu0Yz63dMcOF2hYiVJygSSBBlpp4qy8tFKf1LwbAs4h8FnoejnepEn
	H1Lm21lsphP5o6QALDiNgYzqkqvGA4Z8K53ZPWztVca3qmur54qq7pKClzU9FWf2Q9BKDOVqRSU
	H94b6tzODblZwqlay1Zy42/zceOAYY5eV6ibunQ==
X-Gm-Gg: ASbGncvhwYl6KQcspe5gJJNBNd+tq3dgccoB1K4gpMJ8k1hR93o0jekqDF8M62tE3HP
	fSuwFB+g5t8mSJC94KaVBFj8PphdaaF/ZkyFtXUl93bybIRfl94Zk4SDe98MKroC5n4S6iJkaXc
	0=
X-Google-Smtp-Source: AGHT+IF38ffD8uTfeWoyKkzdki0w4CBfO4Q6FCUj5jsP8brgHruKzyD5d/xowX78B7DkvMV9AG/yfe03E47wCYQDXFQ=
X-Received: by 2002:a17:906:3151:b0:abb:b24d:c63e with SMTP id
 a640c23a62f3a-abbede0d6ecmr282002266b.16.1740053249591; Thu, 20 Feb 2025
 04:07:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210-gpio-set-array-helper-v3-0-d6a673674da8@baylibre.com>
 <20250210-gpio-set-array-helper-v3-5-d6a673674da8@baylibre.com> <20250220101742.GR1615191@kernel.org>
In-Reply-To: <20250220101742.GR1615191@kernel.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 20 Feb 2025 14:06:53 +0200
X-Gm-Features: AWEUYZkVC_t70oKiz24rwP9NDoPkcZvzDwGyAQ3-jjaWOtmoZFsuzE5rifn5L5A
Message-ID: <CAHp75Vch7QKyT8Fbya3u=YrPR8z-2-mbWXjHyOwZ-fqcBjjm0A@mail.gmail.com>
Subject: Re: [PATCH v3 05/15] bus: ts-nbus: use bitmap_get_value8()
To: Simon Horman <horms@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Andy Shevchenko <andy@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Peter Rosin <peda@axentia.se>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-mmc@vger.kernel.org, netdev@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-sound@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 12:17=E2=80=AFPM Simon Horman <horms@kernel.org> wr=
ote:
> On Mon, Feb 10, 2025 at 04:33:31PM -0600, David Lechner wrote:

...

> But when compiling with GCC 14.2.0 I see warnings that values
> is used uninitialised - bitmap_set_value8() appears to rely on
> it being so.

> In file included from drivers/bus/ts-nbus.c:13:
> In function =E2=80=98bitmap_write=E2=80=99,
>     inlined from =E2=80=98ts_nbus_reset_bus=E2=80=99 at drivers/bus/ts-nb=
us.c:111:2:
> ./include/linux/bitmap.h:818:12: error: =E2=80=98values=E2=80=99 is used =
uninitialized [-Werror=3Duninitialized]
>   818 |         map[index] &=3D (fit ? (~(mask << offset)) : ~BITMAP_FIRS=
T_WORD_MASK(start));
>       |         ~~~^~~~~~~

Heh, the compiler is dumb. Even if it's not initialised we do not care.

...

Wondering if the bitmap_write() will work better...

--=20
With Best Regards,
Andy Shevchenko

