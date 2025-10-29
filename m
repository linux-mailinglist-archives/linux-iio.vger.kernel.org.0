Return-Path: <linux-iio+bounces-25616-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3FBAC1BA73
	for <lists+linux-iio@lfdr.de>; Wed, 29 Oct 2025 16:29:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A262C621D9D
	for <lists+linux-iio@lfdr.de>; Wed, 29 Oct 2025 14:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E3B34F480;
	Wed, 29 Oct 2025 14:38:06 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D44C2DC79E
	for <linux-iio@vger.kernel.org>; Wed, 29 Oct 2025 14:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761748685; cv=none; b=BxtzpAuE2GlYds3TM4EGWWw1ZWWFwtFghjEGRska5DAQhp73JFj0LyMDJFmQojYRDVr554B2InjfE97hAp9Mi6G3JkrdGb05JOnUzQEw8wiTJKKuP15sR6/UpCNscgURCm8G/hsWlL53fivsggcvMy+oIKbo+6DFFw+PR4+efTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761748685; c=relaxed/simple;
	bh=RiCdWEkCDNsJiKATmU0RbHd3Kb5B/0yb//UgjVnVdPE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HSDAih7WIZ3PfSBGVAMxZoC8dnfQfKYaNZWUTx8I7QGqvG5WYFh7fRrk9U+51kZZQJSiUriTurbHHjvQxUps4oWDe1dsnR7cZ1IBRhjxJlQDz91dvdROajoO0LtutK2/vnwjifRtrviRQhSX3oOMy8QbDgg8eDoEc/ZYSPtgBuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-81efcad9c90so85984056d6.0
        for <linux-iio@vger.kernel.org>; Wed, 29 Oct 2025 07:38:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761748682; x=1762353482;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UmTxX9Lp/E6iQMSfd9sSFodFiE1yd68ZDUJdx86zE5s=;
        b=YQ4hBSbbMNiC2L9NTJyGUDPbMAr278vB7d7DQIYDvAJScxl7IT8bXODoH/L0T3vxh3
         hVbskJIdVcS5RJ7YJBkPa7YS42ylL13ERboxu8nzpzqLvQ8q3J4G3zS23oaN2VATKjuo
         0ibOsrkJEp6qj2Kx5Q+VzlJ5VRrcosLa5BZ3MGOFgifnoxbfkBYPJBhFdS2rEo4o4DQE
         5nuFLW1Q3iLueXXfULEBo3mrcOzphoIRdjTOXvZriGOZ6ewbbWVsMOMH/zjYXAiBodNq
         hRwjsqnE3//GPP6fugqUr+8JB2ogbfdiN29ioojK2lnwOnJ5Pnjw2IY2BVnmzyMv47UA
         DmOg==
X-Forwarded-Encrypted: i=1; AJvYcCUel1xqXmIJu6Y9WXZyfmnS59/VIOQfPUYsWwYXInyQDWZZvBwu7znSNM4HlUIe5+I+QNXX1xUjgGk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTyfPuYOYO2kpBsYmH6YpSCZxMdQm0frX+AjZgbr7pCTVyqcOu
	c8kKF0vYEuRyvQgx15nHQ/uagA67Ucbzs4rkHjoCp1Qgj9Ckj3Vj2bJXWcJRJOXX
X-Gm-Gg: ASbGnctGO9kwuwDnSdcefAOWX8vOdINeRe2J+WsNVGpTfTHiNpLJguPhoUBvssU/xgP
	CY6qOrqsoaZHEiMzM0kZRYAqXiP9JtPv5hu0eEY837GvIlduTy7h1j186cfvGqgOQQ6QzEpU9D7
	uT82t3fAwblRuE9FF+PoxLidjzlBTkUZzBq6M7VlCOAtdTwpKPFFboUe5dZwAs36xKmV3G1daAR
	Hyb4k+Dbr1wxZWUl5+GxApDQIkk7YZeHMEuxe99RJSSX3p17kKFMBdjL2YevYy6dDbhhrga1/xL
	BMIfdH/Gr32t9qGWtUckW9q7tx9kX7hWyHUisQnX4EL9RtqFn5r/NJRsfSd4jeaclq1ApNgld53
	cY2CmV5rFei26cKOYZ5cBG4rB8SvbNziwd/AENVZzbN0A/JSF7jEyYc/2CuQiSUrY4y0wySwbhz
	UYe1tgRcqAVENdJFuF8BvE1reHHPcSRwcp6pqI5If191/3DoFdOSUNxc+l
X-Google-Smtp-Source: AGHT+IFQdWifYP7OdOgWeRZi7cqcYsjIaaVzGYc1yK67zY6FG5LDVYPJo6+9YhZrNHILT8x8/R83jA==
X-Received: by 2002:a05:6214:d62:b0:87c:28ed:c65f with SMTP id 6a1803df08f44-88009c345a3mr41824236d6.67.1761748682080;
        Wed, 29 Oct 2025 07:38:02 -0700 (PDT)
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com. [209.85.222.174])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87fc48ea92fsm99003786d6.24.2025.10.29.07.38.01
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 07:38:01 -0700 (PDT)
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-89ead335959so541972185a.2
        for <linux-iio@vger.kernel.org>; Wed, 29 Oct 2025 07:38:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVPGjpmRcatVPfyVP87KaWPOricWJIMqI5uRWMExG9HMbXlNgmCZybC9lvs17CwqQj/3Wdu4EuSiYc=@vger.kernel.org
X-Received: by 2002:a05:6102:3e95:b0:5db:38a1:213b with SMTP id
 ada2fe7eead31-5db90656011mr932905137.27.1761748238614; Wed, 29 Oct 2025
 07:30:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1761588465.git.geert+renesas@glider.be> <03a492c8af84a41e47b33c9a974559805d070d8d.1761588465.git.geert+renesas@glider.be>
 <CACRpkda6ykSZ0k9q4ChBW5NuPZvmjVjH2LPxyp3RB-=fJLBPFg@mail.gmail.com>
In-Reply-To: <CACRpkda6ykSZ0k9q4ChBW5NuPZvmjVjH2LPxyp3RB-=fJLBPFg@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 29 Oct 2025 15:30:27 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWriu9eUHMSKcv7ojSqbquP3=z2oaquQZLx5nmN0EcGaA@mail.gmail.com>
X-Gm-Features: AWmQ_blleyKJMjc4oETFxToQhJJ0bdzSdD1fdMmRWAHt71coVgn8wIHcAFgDdM8
Message-ID: <CAMuHMdWriu9eUHMSKcv7ojSqbquP3=z2oaquQZLx5nmN0EcGaA@mail.gmail.com>
Subject: Re: [PATCH v5 07/23] pinctrl: ma35: #undef field_{get,prep}() before
 local definition
To: Linus Walleij <linus.walleij@linaro.org>
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

Hi Linus,

On Wed, 29 Oct 2025 at 15:20, Linus Walleij <linus.walleij@linaro.org> wrot=
e:
> On Mon, Oct 27, 2025 at 7:43=E2=80=AFPM Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
>
> > Prepare for the advent of globally available common field_get() and
> > field_prep() macros by undefining the symbols before defining local
> > variants.  This prevents redefinition warnings from the C preprocessor
> > when introducing the common macros later.
> >
> > Suggested-by: Yury Norov <yury.norov@gmail.com>
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> Do you want me to just merge this patch to the pinctrl tree or do
> you have other plans?

My plan (cfr. cover letter) was to take it myself, as this is a hard
dependency for 11/23.
Thanks!

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

