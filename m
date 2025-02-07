Return-Path: <linux-iio+bounces-15127-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3852AA2C799
	for <lists+linux-iio@lfdr.de>; Fri,  7 Feb 2025 16:45:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8AE73AD2C3
	for <lists+linux-iio@lfdr.de>; Fri,  7 Feb 2025 15:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8069B2451D3;
	Fri,  7 Feb 2025 15:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jX6Z1EkM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D500E23F27E;
	Fri,  7 Feb 2025 15:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738942991; cv=none; b=PM/h/how+57tO1It0l9o7odv07eEUG0tsUKjx7hd8wv6pSXyfOGimA6zOU/nwp6ucn7B15eZBs5caB7JlByx9ynOHJSqPzqzTIyWevOOJiIifrck505wQ1t4RCHxfVXJIotDDNSxI3LPkErSZBXZFGOaEg1gGeYawLuAdTwWB+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738942991; c=relaxed/simple;
	bh=V/mJbsV2FpS/yrn+vg3Hob7Vj8vsVhpVXGKAdYRI+5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iQVFXIF+wvidEPLH50Wzxi+hDY3OZmAGrOGvjh5qk2L4RWWgIuYXbECV+rYX3ssnMZG4PC+SyYCiEUpDE81dUtETg1Tsdd3NUn0Gw0wppkAXxtSDaBpbS2G1cEHiqeoSUWQg8WxHxuFI+xk66M/U0tJ2qLvNkb9uDbN9kRvNcH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jX6Z1EkM; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21f5268cf50so13446825ad.1;
        Fri, 07 Feb 2025 07:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738942989; x=1739547789; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UxhLoK7XAPc7+07p+MzQjz273lZ6TnGYiS+xzwBXJJs=;
        b=jX6Z1EkM6hvx+zqfG4Jk8J4qv8Ahcwp3Qc6KaJf5Cr8DCYajF6YUT/pUVTnIObhkjH
         ljHB64kpEnwRU2dcOKm8WuinRBXAGji18YcPFkmmtWBeAAsCWROdbyHb7KIKUmOt26os
         gr/6IL3ZrCcagTXKd4FtfkgMIW3F63Kt2Jm9Vzn2K2DvGPBYGodmeQiOoY9n1/UFOzwz
         rcHjVXF4MRLMOXyUC/WM/djIIJEIMZqn1RYNnee0VKeE4PTo/5tg99ByoyOEjSw8Iiv6
         f67HLcLcOMEBOFVZcRutLL0uhf/otB8b8v7f9gQKdNHvdSuvnkKACKvfx/bKo4eAICsh
         A9og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738942989; x=1739547789;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UxhLoK7XAPc7+07p+MzQjz273lZ6TnGYiS+xzwBXJJs=;
        b=kqOQA5PW+tA2xQHDDT0qbljm74/nBi5tXFyRAEXCqhL2eSbG2GyxTgTC52DC72w+NX
         6QlEPUTVbuQE99tBH7pJoD/VipxoK/NgskBfGswtzCB6HS6jJFE8XxdLr7hhGdUzMqHI
         YR+asq3cdHCMzM3BORElwQjKn6JGP3qL3dFFLhrkH4vizlkdDwYeWt0M7sSgbmNmKZIC
         tWD51ZTdX+x3uAx/b4uI0y/+d/luA2l4AJugNKj7zU1S5pDwTIvGhZzJV93YIane1fAB
         aaW3hr2nTHVQ75vPH1s9magE04aEXxbME8dz6jA9NBEGip4qr3noGqFB4sf7fHZXWMWT
         I8og==
X-Forwarded-Encrypted: i=1; AJvYcCUv6X5YyW5AXTHhVEdLm+LA9ey99R6eZs1nGhIfNZPStcaGDUdrBCgjZojkFX+99RJ6eEloUev6bpQQUI8=@vger.kernel.org, AJvYcCV8YxcrmZldtl02mXnNsJAWGPVhhk/M8qLcL3+DIwSvD2FLrx8JUurp7x++6nOezOU06h40K81bzbih@vger.kernel.org, AJvYcCVWeTB/D8/ifaXQSK62Uj1Td8qNX+CGqMaDQpN01HxvtgDL1YqyBd1DPBP0NYzSdxUVa3/QN5n7Sczvi6WP@vger.kernel.org, AJvYcCWsOn9mldbwmvTJhK3O/m32CSggMm6sOuo+wA6T2GLv1ElmNhCkL3amiqHmWd1ZB36Zc7FtAeA0@vger.kernel.org, AJvYcCXhXqqJ9ZOxkw8FrUs6lQEIrzrZim9UGokFxqL0Kd5gmmgBQl5sGwZOGV+tMVaK4HnZW/SZnn9fJX5W@vger.kernel.org, AJvYcCXo2gvcNogiQe0Bw23U5E92Ki/SlFzzzVSB+3Yzc6Lj9iYqbrdQfzuI8ULdLyap9pyVuBhbsxnPyb/2@vger.kernel.org
X-Gm-Message-State: AOJu0YxHjjNm5PvJkSAd31vtLXiYY2MZiYbTu0GJfurJSkKRnb2WFE4T
	TUxvF1euBbRyB4ncBb/cKzy5ryPgtf+E0UlythUgLuMcvXMW7bJQpLpmytHX
X-Gm-Gg: ASbGncsyaFazJVTwVL03mlfnq8L22tM3Eqi5ADevJm4SLcCKwfLSn384o9/KEb0MyDM
	zQgj70IOMkil/smqWSQk3UGcDcdIcFE/cv+l6hIoGvArIR224x8I1ZdNqDtUderaAN+Ginob6zR
	NFlTlKcbDkJjyw3qofLq7UsgJFMzL//EvxOHU8ftVkUcQkhEVqGP1oCzTRLFmNUP7HyUIwdNk7t
	eDr2SjjxUJHROBl6HzXMixrYuTq3uktyE31UdPaFM2x6F9UJDvK9o2vcFXgrDc6uEJ3AnTdIq2m
	20kFJevC2uL6nxs=
X-Google-Smtp-Source: AGHT+IHksggvra53OzUJzI4zoRynwjPKZIRBW8flE8pNvut2OPynffqKQreS+fTXcRUSXiaAn6xL3A==
X-Received: by 2002:a17:902:ce8c:b0:215:4a4e:9262 with SMTP id d9443c01a7336-21f4e1cc2e9mr47245225ad.8.1738942987478;
        Fri, 07 Feb 2025 07:43:07 -0800 (PST)
Received: from localhost ([216.228.125.131])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f368ce622sm31799335ad.241.2025.02.07.07.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 07:43:06 -0800 (PST)
Date: Fri, 7 Feb 2025 10:43:04 -0500
From: Yury Norov <yury.norov@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andy Shevchenko <andy@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>, Peter Rosin <peda@axentia.se>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-mmc@vger.kernel.org, netdev@vger.kernel.org,
	linux-phy@lists.infradead.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH v2 04/13] bus: ts-nbus: use gpiod_multi_set_value_cansleep
Message-ID: <Z6YqCOP2lVseW-i4@thinkpad>
References: <20250206-gpio-set-array-helper-v2-0-1c5f048f79c3@baylibre.com>
 <20250206-gpio-set-array-helper-v2-4-1c5f048f79c3@baylibre.com>
 <CAHp75Vf+3pc84vV-900Ls64hM1M7Ji6Dmy8FPwL=n0=sJFSuVA@mail.gmail.com>
 <CAHp75Vdt5EU83mJrB7Sb_pgRNbhvCQ=F2Lyq7mQLAvV-w6cqEA@mail.gmail.com>
 <b1459947-18ec-4835-8891-5251d8f8c95e@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b1459947-18ec-4835-8891-5251d8f8c95e@baylibre.com>

On Fri, Feb 07, 2025 at 09:23:56AM -0600, David Lechner wrote:
> On 2/7/25 6:17 AM, Andy Shevchenko wrote:
> > +Yury.
> > 
> > On Fri, Feb 7, 2025 at 2:15 PM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> >> On Fri, Feb 7, 2025 at 12:48 AM David Lechner <dlechner@baylibre.com> wrote:
> > 
> > ...
> > 
> >>>  static void ts_nbus_write_byte(struct ts_nbus *ts_nbus, u8 byte)
> >>>  {
> >>> -       struct gpio_descs *gpios = ts_nbus->data;
> >>>         DECLARE_BITMAP(values, 8);
> >>>
> >>>         values[0] = byte;
> >>>
> >>> -       gpiod_set_array_value_cansleep(8, gpios->desc, gpios->info, values);
> >>> +       gpiod_multi_set_value_cansleep(ts_nbus->data, values);
> >>
> >> As I said before, this is buggy code on BE64. Needs to be fixed.
> > 
> > Or isn't? Do we have a test case in bitmap for such a case?
> > 
> >>>  }
> > 
> > 
> 
> Maybe not the best style, but I don't think it is buggy. Bitmaps are always
> handled in long-sized chunks and not cast to bytes so endianness doesn't affect
> it. I didn't see an explicit test, but bitmap_read() and bitmap_write() use
> array access like this so indirectly it is being tested.

Not a bug, but direct addressing to bitmap elements is discouraged.
I'd suggest using bitmap_write(values, byte, 0, 8) instead.

Thanks,
Yury

