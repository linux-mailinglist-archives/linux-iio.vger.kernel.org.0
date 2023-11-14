Return-Path: <linux-iio+bounces-57-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A127EB080
	for <lists+linux-iio@lfdr.de>; Tue, 14 Nov 2023 14:05:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A2191F249A3
	for <lists+linux-iio@lfdr.de>; Tue, 14 Nov 2023 13:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 081C93FE42;
	Tue, 14 Nov 2023 13:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nMk4bjzW"
X-Original-To: linux-iio@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8D63FE2D
	for <linux-iio@vger.kernel.org>; Tue, 14 Nov 2023 13:05:13 +0000 (UTC)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B78196
	for <linux-iio@vger.kernel.org>; Tue, 14 Nov 2023 05:05:11 -0800 (PST)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5a822f96aedso66279157b3.2
        for <linux-iio@vger.kernel.org>; Tue, 14 Nov 2023 05:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699967110; x=1700571910; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y3kLet+ZFc4FiXhXyJTUcUEX1JsMDtWsRFc0PYkqxJM=;
        b=nMk4bjzWl2OH2sgI2kginq+JqGE7cwEcr+JGDejTGiX2niImmLs4RpluHd3H9DmyOX
         39NxMktLxD0KR/1jO0DVPvee/GYRKvdT0NGDyOOY9mugEYri1z7tPGOuN1UaDnDslMPM
         07KVGoolts85BnWYiBEeoDTKbfNmDvu5SMcH8fkerB/VCr7HRL3nOmT0dMFAw6psXo7L
         PQ/yETAMDp42UEMSaZHW8fDmMccfGZ99jpCF2zkYMbjDRmxmbKkkPuIGDPaJjXwpkPJN
         6YRQJ9NnpBeWQwKLA6iHGmEX2qiNv1VB3X4ejZsla3zyizgE0zAnjBWzAhmBMv96hrt4
         Sceg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699967110; x=1700571910;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y3kLet+ZFc4FiXhXyJTUcUEX1JsMDtWsRFc0PYkqxJM=;
        b=SZ0zX/kY2Vw6kS8FR0ehxUvWMa6E82cwDLVlF+HXGWNwgiyQ5MtnR4k9T/lNW9XjqZ
         4MR6ijPSvXYCGXuM7+l87RtGels2XP090P6D5pa67rcmp/7UkOxiuo84UM9LX6H+WC8j
         v0Gybu7xYZBhqZvqXw2O7HT0VrQjMoKzhjT2lIMAbq0hwemryEKLDi3WRhc0F+9AVhOw
         IERu4IHq4YTnEcT+NI8Njbq4KeJ8E16KcUxNFlbd1VvElWOatrvj2Y0rMaDQVswq3Oj5
         unKrK1+3t28AIHk0v1REOFZFhgfAyjOww1jX644chK3o08mtit7UVNP62h+qrels/2Vs
         PK0Q==
X-Gm-Message-State: AOJu0YxOQfspgS2kxsdOsT/TIWh+0BhLL1I6EstOaGv1RnHlyrwU7s0u
	pLsgFv3eTcKSGzXkk/WzaLgRxAMduk45hbjYa7d5Qw==
X-Google-Smtp-Source: AGHT+IHU/EMXoR/AsvwDR5tVM/hTfhag7Py4pB8zx2h4lfdu8R1hVWGA8wCYGXEvgGG4RCO6d/pEhnbc29+P4adFbGc=
X-Received: by 2002:a25:35d6:0:b0:daf:66f9:cfab with SMTP id
 c205-20020a2535d6000000b00daf66f9cfabmr8292993yba.9.1699967110411; Tue, 14
 Nov 2023 05:05:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231108104343.24192-1-krzysztof.kozlowski@linaro.org> <20231108104343.24192-6-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20231108104343.24192-6-krzysztof.kozlowski@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 14 Nov 2023 14:04:59 +0100
Message-ID: <CACRpkdaSPTjjPA=TS-WbOb3E=TabtP6MFEx6Q+Dar-Mh=EtknQ@mail.gmail.com>
Subject: Re: [PATCH 05/17] dt-bindings: pinctrl: samsung: add specific
 compatibles for existing SoC
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Andi Shyti <andi.shyti@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Lee Jones <lee@kernel.org>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, 
	Sylwester Nawrocki <s.nawrocki@samsung.com>, Thierry Reding <thierry.reding@gmail.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jaehoon Chung <jh80.chung@samsung.com>, Sam Protsenko <semen.protsenko@linaro.org>, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-mmc@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, 
	linux-rtc@vger.kernel.org, linux-serial@vger.kernel.org, 
	alsa-devel@alsa-project.org, linux-sound@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 8, 2023 at 11:44=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

> Samsung Exynos SoC reuses several devices from older designs, thus
> historically we kept the old (block's) compatible only.  This works fine
> and there is no bug here, however guidelines expressed in
> Documentation/devicetree/bindings/writing-bindings.rst state that:
> 1. Compatibles should be specific.
> 2. We should add new compatibles in case of bugs or features.
>
> Add compatibles specific to each SoC in front of all old-SoC-like
> compatibles.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

This is more formally correct indeed.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

