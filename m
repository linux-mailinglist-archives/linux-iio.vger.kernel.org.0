Return-Path: <linux-iio+bounces-21339-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28560AF8C82
	for <lists+linux-iio@lfdr.de>; Fri,  4 Jul 2025 10:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45AE31616C3
	for <lists+linux-iio@lfdr.de>; Fri,  4 Jul 2025 08:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7542ED86C;
	Fri,  4 Jul 2025 08:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bNq7MvdZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EAA42ED852
	for <linux-iio@vger.kernel.org>; Fri,  4 Jul 2025 08:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751618578; cv=none; b=FgU6x1zihGVflePkgMMIGC5s0Ly46cN6C+wY3Iv9Zv4WOVYYjMHhAsF3iYSt8WfBU0bjhpM3+Vj1zjNZyh0d5at//iWIkOqO52BmLnbbc1OR1uafKW4e9rh6VZ9aieqfMFS1lPzp3nsmw7vR9mKLAlfJAtWj0Wx9IQZ3wg9MadE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751618578; c=relaxed/simple;
	bh=XWPuLH+r945MMXMKIDI54FYqxlY/reitRUTj8Ejgnuo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d8/c/LSPxPWUp6SIBMSgu0isvlw6X8Sb2+X0kXBtJMc14om3ZfCM1dZ7nvRxBEErjmU+yVh92t5wQFFaAIDbfCiAS5pRRFHJ/7R5COs2MfO2fFHKEJGGmGq9F96iQsdjbLxsZo7JDXHxLSQgqa79mu+2HBkR/jE9/nUHZssOfts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bNq7MvdZ; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-557e20222c3so166007e87.2
        for <linux-iio@vger.kernel.org>; Fri, 04 Jul 2025 01:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751618575; x=1752223375; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XWPuLH+r945MMXMKIDI54FYqxlY/reitRUTj8Ejgnuo=;
        b=bNq7MvdZBIJd8CTDAwciPST2c8+4Vyr9bEq3GuEPm6tbBd4FdaQ6Ye2NbTBPblO8Ft
         K7trkzOAHCqDvvyqOxMcWbgmeOqsWBGxCAUHQz2pnwIy245tegVxYQ1YNGOwWEkZdsvW
         LgJlKQDjDskrLrdBc7TTelcKv0M38wLEsgiyyKSIDm7FlDje6hElfFDWGxGPAvLP/MVc
         W8G+ZLtB+bBJYt/Eon3AgOcJSG2vkR2MaT9kN3F0/IwuhTatYKqQ/5OYZZB/lCwJO8jM
         AwEp/GwvbTH95/+DRCYi+yNNLPF/4G6fya4Cx2VFOMu1n56aU+jXDs1E5rBKz1oEvCJm
         uLtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751618575; x=1752223375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XWPuLH+r945MMXMKIDI54FYqxlY/reitRUTj8Ejgnuo=;
        b=pUBuhtTfpSp3AmcmCxXBVT7zOTCBKEeUZns6WWGqfmheszMtWXx2kel41JrN6u4wIs
         0BzqtOF/2AkaZ4HC98ke7LOrqPw8b5fIoHm+mEvfFuSlzA6U9/tMrh9DG0mC0T524xT5
         U0Ii5D1uShhBOz+Sz4qssivIJRsdk1aIycj/QJVrMnIG3RWT5I+QtxyBnGyb3J/PDz4d
         FcHJk2MXt8wl+hQrgih/2Pjce5N/DgMTMLfqZuTO5G/hu4f/vfgkE8hgr1l+uQuomzL0
         zZLBvhRoijn17CBSCkJk5rYkCYavt0CCbfYrrek05lnlVM8plzOk86ljF/6F2JTE2LIb
         ibqg==
X-Forwarded-Encrypted: i=1; AJvYcCWKeGDpFBa0eu0GijHpP7yaA4wCLvMotQGhJBI/iBmN448GMEKLqpJR5X8w7iQoFBXgZfC/R5u3hOE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWKcZXoxQMKP2d08Kt736FgSJU6+HamNaPV1n4xTONC7lAq630
	pC8clX7+/+QWSlEEyiITofgTrFOsJVAiDevEwIZ5xbkSxdD3H6Inje2vnX7zCN8MSZM+jWp9UAH
	vXdySKQDqH6p9KY6Eq373qryzOf8sKiSP8UJ2LhEEAg==
X-Gm-Gg: ASbGncuA/DPuTlyP1iFyW4VlnxQU2RCHPqlWWwPtd59qi7D5+xaRLrgV0LbMWw5kJ1a
	lkHtXl2rOfBCgwyxgVE3g+tUT8KO1j7vdUQ3cgnAG2rmZ7NPLilJlJpc8MR+5YsypxFCs8C1sc2
	w43BtVm/RMVea7KU12i5yKfMuVoZXczzYBnyl73nFkgM4=
X-Google-Smtp-Source: AGHT+IGodMjqDkDesQdG4Hjakhr0TOM9xUbyJgILsRTpZGqTHkPFTfySztIXo8nEvUZyWt2JWT7aRKctMeet0pwrsBw=
X-Received: by 2002:a05:6512:3e1b:b0:553:35e6:393b with SMTP id
 2adb3069b0e04-556e684bda8mr524787e87.45.1751618574621; Fri, 04 Jul 2025
 01:42:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250704075225.3212486-1-sakari.ailus@linux.intel.com> <20250704075420.3219092-1-sakari.ailus@linux.intel.com>
In-Reply-To: <20250704075420.3219092-1-sakari.ailus@linux.intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 4 Jul 2025 10:42:43 +0200
X-Gm-Features: Ac12FXznXJQ0ImElx8AS_65o16qEpHJnw8V0OHvMEe3Y5zyTtUuH2rGO4fQjXsY
Message-ID: <CACRpkdb8Z3oLwmB26q1xdHMwa2xTm1sz5g8_a0BHMK8oHsiF1g@mail.gmail.com>
Subject: Re: [PATCH 28/80] iio: adc: Remove redundant pm_runtime_mark_last_busy()
 calls
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Eugen Hristev <eugen.hristev@linaro.org>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Cai Huoqing <cai.huoqing@linux.dev>, Haibo Chen <haibo.chen@nxp.com>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Marek Vasut <marek.vasut@gmail.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Magnus Damm <magnus.damm@gmail.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Francesco Dolcini <francesco@dolcini.it>, 
	=?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>, 
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>, Fabrice Gasnier <fabrice.gasnier@foss.st.com>, 
	"Rob Herring (Arm)" <robh@kernel.org>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	Mike Looijmans <mike.looijmans@topic.nl>, Olivier Moysan <olivier.moysan@foss.st.com>, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Julien Stephan <jstephan@baylibre.com>, 
	linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
	linux-renesas-soc@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-sunxi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 4, 2025 at 9:54=E2=80=AFAM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:

> pm_runtime_put_autosuspend(), pm_runtime_put_sync_autosuspend(),
> pm_runtime_autosuspend() and pm_request_autosuspend() now include a call
> to pm_runtime_mark_last_busy(). Remove the now-reduntant explicit call to
> pm_runtime_mark_last_busy().
>
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

