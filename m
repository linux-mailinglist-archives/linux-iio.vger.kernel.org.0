Return-Path: <linux-iio+bounces-23666-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC5CB4156D
	for <lists+linux-iio@lfdr.de>; Wed,  3 Sep 2025 08:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 232A33BF448
	for <lists+linux-iio@lfdr.de>; Wed,  3 Sep 2025 06:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 785242D97A0;
	Wed,  3 Sep 2025 06:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fdzZTuYk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6916B2D9496
	for <linux-iio@vger.kernel.org>; Wed,  3 Sep 2025 06:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756882047; cv=none; b=eQihA1D7H7hVLXKpYFx5h0zVcODHk1i1M3FZQJt1IoqKEUrRISLMkfjeKE/AE03WjVz7uDI7i2MFswNkiEE05cga9mNW2aH5eKExpRvg3T3zz7UXBQQHQjcp8JNk6G7gg5DeO4kIR6xUUGJIa58ebaN0ZbABkKrrB6Als8qQUSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756882047; c=relaxed/simple;
	bh=JPf9MBwFsXDqpcdtjQzlVagg9Dgm72GKmuu+o+i6Jps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JzjJSa0wqb3W7IQJXmzibV6j9a4UZHVc8bqdpXxD7xSEyC6IiJhMOEAg+NwoCPxGqPyLp2mNnmAiRG6PjuP7aai/ESVD2M8DZ3otlDA6e6mrJGqBEAfQ+Na46zMaN4DVBKTzqSG2Zh4HnxCxB8HQ6VO+oWFWcDM4WHq+VloBUBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fdzZTuYk; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-55f74c6d316so3656171e87.0
        for <linux-iio@vger.kernel.org>; Tue, 02 Sep 2025 23:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756882043; x=1757486843; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JPf9MBwFsXDqpcdtjQzlVagg9Dgm72GKmuu+o+i6Jps=;
        b=fdzZTuYkF29QgBigJfqqWon5n83S460gZRV2f4jgqqMtXu/gzDeqg+NYLgPQ0RV38P
         Sk/Jako15oRICnUN33bJMaU1upbbGzl3acZCpyGWq1NP56J4hY38LB9F9wkMgJuv5bR5
         OOFIq3ZOdI3Hb4toCnPk9ls5Jt5jswt2WXIrFoRtz3i/ZvkQp0aKas+BS5k50Vc8XLvh
         MhUvkvcLieCyIPaaZvTUu9zsK0eaJxlocxMgEqvisIEgL1DfJXauJAislBcZbusE5JcC
         sGBwcDp/0bfqxQjB4ucerRbjw+pJJvi5YnVOqGjmbTfM4u0RQV33fizl8MW0mIYGRT+W
         surg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756882043; x=1757486843;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JPf9MBwFsXDqpcdtjQzlVagg9Dgm72GKmuu+o+i6Jps=;
        b=Y4dLvFKwkz02pLaq8HechwPgkni6/Su6+cg6n2YSBct/ylq66KOgFRwOvAYSBaQlyG
         Fis1oJzJoWXFJaAli1OhrHIpLid4djhxVlW1DlgjuLGzxloLlJ/mtiwWb4BwwEEf3FXH
         fGckEsyh0iT9ochbqSzTFxVVqdso1ibwOc3xHTcORtJdv6bJ/1/YH26QEExrG5pDwYT9
         K/RXGGzcRA5CivHVoCRBLGTDfErBqiKcK/uC48RywI2YGKdMRZaHQgCqju79VOAvc8Kr
         WyQyLm323QQYSG1/2kJyWZ+FEYUnOsa1Ywql5wdQsB0NRXGOJV5fa2r5i4J5VeJi/zmI
         7fAg==
X-Forwarded-Encrypted: i=1; AJvYcCUHjcQtyZsNPek9ka0Rpu3Xdb2f+Vf3CGVITJUaqjCpgaO3GMCeqxFFfGCnEF944tXcj/WzfPrCHvk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmPxiGBMRz2y8yFoJ8Qd7XCFmOpHMgQgg6ag81SLalGGF5yLn5
	Ll0sTg1+pUXj542nwN6FNrMgmiirpBO1LTS0yxZKawJqoD2N5/ijPocTYLWBU7B8lZMLeYIaWQT
	TuAg+YOtQuKknJeFbrD6qpMeUCwZkGWWU3cIXEeoWWA==
X-Gm-Gg: ASbGncuFjcUYYSQPpGnxgxooReH/Zpo47yrrNVZb6wsrltTWLaTW1SLh2+ajcDnvh6C
	n537r8AqJ2BPC+AlvHQbkzRI9IfsIB3z+PyCeTvDr//QlCuD1nJ0R2QDJMSZvjHw7t4Ulr+2EmX
	UTZaQR7+ggA2om3yxGgmiO/tAn5OKMGDbBT5p/hucYL/dCngmA4HOl9URoTpD8Jh1QgTR1JKuKN
	GDbIYK0XHQjupy/TA==
X-Google-Smtp-Source: AGHT+IG4YC4WaIVhdE/SO0C9kkujplv36YQBR7QppVwWs93lEzjQRfRa2semDZGhdaQs2p7GqIs9i0ivFJhWbHX0Rek=
X-Received: by 2002:a05:6512:2508:b0:55f:4b53:6fc3 with SMTP id
 2adb3069b0e04-55f708b1a85mr4516238e87.16.1756882043464; Tue, 02 Sep 2025
 23:47:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1756813980.git.mazziesaccount@gmail.com>
 <08929460fe11dd0b749c50a72a634423f13f4104.1756813980.git.mazziesaccount@gmail.com>
 <CACRpkdbOhm4PawYZUxU1SMi8WGr-LxhR1jhSVPDvPh3TTp8SWQ@mail.gmail.com> <ffef0fa6-45e4-467b-b264-1df15754d213@gmail.com>
In-Reply-To: <ffef0fa6-45e4-467b-b264-1df15754d213@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 3 Sep 2025 08:47:11 +0200
X-Gm-Features: Ac12FXz2kUTuIK7Qu_UhO-ePUCmnG1GuzLVWHurE-uLTn1uN0blwAJJV5wrS6c4
Message-ID: <CACRpkdbPzq6yKMHJXaFmXZSsttUkt5OAKRTSc_pjLwZZiZr7Gw@mail.gmail.com>
Subject: Re: [PATCH 2/3] iio: adc: Support ROHM BD79112 ADC/GPIO
To: Matti Vaittinen <mazziesaccount@gmail.com>, Michael Walle <mwalle@kernel.org>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Marcelo Schmitt <marcelo.schmitt@analog.com>, 
	Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
	Tobias Sperling <tobias.sperling@softing.com>, Antoniu Miclaus <antoniu.miclaus@analog.com>, 
	Trevor Gamblin <tgamblin@baylibre.com>, Esteban Blanc <eblanc@baylibre.com>, 
	Ramona Alexandra Nechita <ramona.nechita@analog.com>, 
	Thomas Bonnefille <thomas.bonnefille@bootlin.com>, Hans de Goede <hansg@kernel.org>, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 7:23=E2=80=AFAM Matti Vaittinen <mazziesaccount@gmai=
l.com> wrote:

> Anyways, fast-forward to this day, I don't see it handling valid_mask. I
> think it is a must for this device/driver, where pins can be either
> GPIOs or ADC inputs.

Why not just add a .init_valid_mask() to
struct gpio_regmap_config so it can just pass that
down to its gpio_chip?

OK I don't want to load you with too much extra work for
the driver, but it seems such a small thing for a blocker,
and Michael who wrote the library is really helpful
with extending the code, so consider it!

Yours,
Linus Walleij

