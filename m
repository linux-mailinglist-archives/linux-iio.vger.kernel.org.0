Return-Path: <linux-iio+bounces-25614-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC2AC1B37C
	for <lists+linux-iio@lfdr.de>; Wed, 29 Oct 2025 15:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB785566B42
	for <lists+linux-iio@lfdr.de>; Wed, 29 Oct 2025 14:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67D0266B67;
	Wed, 29 Oct 2025 14:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iPmuKBsz"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B1625179A
	for <linux-iio@vger.kernel.org>; Wed, 29 Oct 2025 14:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761747708; cv=none; b=ktWKoD1uFbf1Gp6iUuvygb7zdzcI1hHwUwDgOhfitr1OSTyWvVwVr14vnNvaAlc4zqIREt4y3b8GCbzpXSDs4klRdbUIuQrWruQ/7g0xZoj6GHmGcc/bwaq8W+0jTxWO31fyejSs3IfWDzSaRoym7qgdl7l3Fm2sgJG5qMu7USY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761747708; c=relaxed/simple;
	bh=W2MmcX2vCweI9Q0W0BLZEPy3CkT01KpRkvvdhb0j4RU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OfgSwpSlkEuvf7RrZXKHFC/kBtpFgF+iS/SdX8SPnv7xXO3EUiPprmISUQE9RHiKF6nmvQaXvd11hRQnMiwnYsBTa3IIlvRlchrUXWnMr7IspbywsdFt9g8Q4VFLcX7B3chTk9bCrnQMiKRz7QnjJb3nmsMBQUlkZKbjIAp0adk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iPmuKBsz; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-57f0aa38aadso9232257e87.2
        for <linux-iio@vger.kernel.org>; Wed, 29 Oct 2025 07:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761747705; x=1762352505; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LVuX2dWoAgb7QHLLOTB16BwhmwEzZ8jO6zQdan0Y+2I=;
        b=iPmuKBszqzRuJQbXmV7ZqrHkGQ7zzFPI5fCiy2pzoDtPjlRPUxn/iBGENRd/ptR9K7
         3VBKIZJP1O0yUFj7/fCcbOwJ6Jrfg+aPV8Qe6xEI+yJbt3zW5MFm2vbkHPWUEusZbsG9
         9pDt6yHUt7It5usEE7V6f8zm2g/wPOsuVhT8wJtzZZCpNR5pe56ZlKHI8y6UiF8K+aW0
         6QnQ2mRi0kkStXvJzZuY7GofiTxN0n9PLm4/uCs5Swf6Aq4grVIHoojnEHTsOwvkPK9h
         byUFAKzmTHWTLC+KE+CJwCtlAzXP6ZbY547Jy05lqxEPqw1USDxJedUjrktORkWq++Nc
         KPLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761747705; x=1762352505;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LVuX2dWoAgb7QHLLOTB16BwhmwEzZ8jO6zQdan0Y+2I=;
        b=SqKiOppMjsDucurSJe16eKbs00YsoLcFcVni9E31PLGEDI3aQCo9xwYcsiK2jW3UlN
         9jdLbtPH2jyIf07VI1s8JdHNjiro0L91U81oLAX8OHpNPNTvS8ZD0hlN6dZLDlKe1nVh
         KAV12pirn69O4MzPGAxviBPkJs/rVoxVMdqSp5RJHMKFaJRYYqIcQAFFCGfvmTMtYFPC
         QciJU2qwCWO3Wu+kpqsAFsMUiabff2BkY3KqbGqo3XIUCELMixX0TJ2+3pmeHP108P3S
         ibZWrYS3EHZVhRwWoH4NvDmX3b2QQZfgn93wO8vqrvOBJ/BjP9tfwHDaCDr2G15Kk5R8
         cPcw==
X-Forwarded-Encrypted: i=1; AJvYcCVJzolGgGEhO+vEUqaUmukkisU64Ga4Hk/KdtG6wFPbSVaRvpCkA1Rb5s3tEQuA2LGh3CNHgTN4Klg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt8MV//rwmIJTw+EznLjk0KaI7tuGNRTKvVRSJ6rywHKkrg9H6
	FBYgTmMlBhU+acq0zdY3VAJWKFiTCWTvvWOQsLbcmPAUEVjezz0RwIZY5biapIyhuoyCgBKn92L
	+cfQrSEvNPWTJDTEsDQYfoCs3kHnYq5uK2tHGTwA+Fg==
X-Gm-Gg: ASbGncuhTRBIFfQ2YXkdvJDBuuw7oBM7S85Zk2v2ZHJpOPGEPMR/ada9xN4LfqkeVfJ
	4J42tfFvIjo00IePzhQZqYe1lkOEs+AvJWNDwAWTzeeLtHXNzN0YK2iJJqDtMkvcn/mqKwbU785
	0K4hZwnb0jyzeN80KB6e4/5hIvFRifdqUfrJTxlNBIRY0Llsi9S2zzUlQQg0e865SKn3LTgu+ON
	pLWSoa6zF6dDhvXETA4EsqAguE8uGwQxrdAX482Jh78YbZmAnDhnIqKoAF/
X-Google-Smtp-Source: AGHT+IH/WV9TTRDue/YlQPKqZJ/rOmSLCumqELYgQ//HXfU7luOPdKKEVQrj3vn51BUY/zZkRojEs9B5VMPxZwJpOnE=
X-Received: by 2002:a05:6512:238f:b0:592:f814:3852 with SMTP id
 2adb3069b0e04-594128b7bd8mr1157709e87.20.1761747703432; Wed, 29 Oct 2025
 07:21:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1761588465.git.geert+renesas@glider.be> <ac3e718c5de6a23375055dd3c2e4ed6daf7542d5.1761588465.git.geert+renesas@glider.be>
In-Reply-To: <ac3e718c5de6a23375055dd3c2e4ed6daf7542d5.1761588465.git.geert+renesas@glider.be>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 29 Oct 2025 15:21:32 +0100
X-Gm-Features: AWmQ_bn0qj1HdhGI-E5owVSGvqmNxBgXc48MF5-9CHRtkVWKXcvNelNuCdps5kE
Message-ID: <CACRpkdYMv+R-NJ5R4+UyhK1+DJia0z72kZgt45+0eubXMuGpEw@mail.gmail.com>
Subject: Re: [PATCH v5 18/23] pinctrl: ma35: Convert to common
 field_{get,prep}() helpers
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	David Miller <davem@davemloft.net>, Bartosz Golaszewski <brgl@bgdev.pl>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, Crt Mori <cmo@melexis.com>, 
	Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Jacky Huang <ychuang3@nuvoton.com>, 
	Shan-Chun Hung <schung@nuvoton.com>, Yury Norov <yury.norov@gmail.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Jakub Kicinski <kuba@kernel.org>, Alex Elder <elder@ieee.org>, 
	David Laight <david.laight.linux@gmail.com>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Jason Baron <jbaron@akamai.com>, Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Kim Seer Paller <kimseer.paller@analog.com>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Richard Genoud <richard.genoud@bootlin.com>, 
	Cosmin Tanislav <demonsingur@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
	Jianping Shen <Jianping.Shen@de.bosch.com>, linux-clk@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-renesas-soc@vger.kernel.org, 
	linux-crypto@vger.kernel.org, linux-edac@vger.kernel.org, qat-linux@intel.com, 
	linux-gpio@vger.kernel.org, linux-aspeed@lists.ozlabs.org, 
	linux-iio@vger.kernel.org, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 7:44=E2=80=AFPM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> Drop the driver-specific field_get() and field_prep() macros, in favor
> of the globally available variants from <linux/bitfield.h>.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v5:
>   - Extracted from "bitfield: Add non-constant field_{prep,get}()
>     helpers".

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

I guess this needs to go with the rest of the patches?

Yours,
Linus Walleij

