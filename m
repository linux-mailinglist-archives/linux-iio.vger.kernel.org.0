Return-Path: <linux-iio+bounces-23755-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99FCFB450E7
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 10:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41FDB1BC0E60
	for <lists+linux-iio@lfdr.de>; Fri,  5 Sep 2025 08:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 068F42FD1D5;
	Fri,  5 Sep 2025 08:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bn5TQY4F"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BE7DF71
	for <linux-iio@vger.kernel.org>; Fri,  5 Sep 2025 08:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757059831; cv=none; b=Pp2cmVBJDc63RtJBZrBWISlX//ZsRnVOEpiZjjCYCEkim54xxGwZu44vd3oy0poIMJdLFORulOElnifmgYt6irNk391n6mNNl7lhSqi3ldB3BQGkjPAqKJh44Jeh2yoOwSu2Pga37yP1+8c2co8J9SE2N56vBuNq30YP2T8Jsto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757059831; c=relaxed/simple;
	bh=BtGTpK92RV2Z6TkeFuzCre6Mq/G4NqRshn0AGkTNf4M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J3wvip/zdSSjCiFEgKebBdE3pKCx4+Iq/ymytFCyuoL5byfhH1l5jD3Ls3DsiMoOIeGOSEHAslnLDY6DPSyCgCm2zxwA7ehYi5l+byTkPPxGuCNAjR942N4YlrD90q/0g7SaP4NrSVdWQJGmK3RTyoVK+p6Apbgm8BkjyhqUIxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Bn5TQY4F; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-336b5c44a5bso24035481fa.1
        for <linux-iio@vger.kernel.org>; Fri, 05 Sep 2025 01:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757059828; x=1757664628; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BtGTpK92RV2Z6TkeFuzCre6Mq/G4NqRshn0AGkTNf4M=;
        b=Bn5TQY4FBlGSlUcjEP+x3Di67lMAFi5yaMEi5qM+uA2mKdG79IcWxmnuhjx6zlGJws
         87CUAK4UH4zuWowgtNdTjNQfE6BX/p8oT93qCOZhSx2ygm2iRd+xnNRiqfHIY3edK4wp
         hrytwv8oKbIwmIYNPJmOhNraz05bJUQgJPdVu5AakjpJnhyv/PeXjVgQl/iCzRRf8nAZ
         Vc4To6kk/LcIngsy/Ryr9EMmlvw52hHfFHMNd7tXueiX3Jb8rTXTZyfPD/jFm05PpaxP
         x/MCZcK3qYafQ2wr1/qimNT8iv1hsopNK7dmAq5MuUJ3AD15BbYDtCX06sGg3M0quAjC
         ogeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757059828; x=1757664628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BtGTpK92RV2Z6TkeFuzCre6Mq/G4NqRshn0AGkTNf4M=;
        b=KcVjTZHEJ25YtTfbBMQNOWnQzzuNVoakrxL1iJ/M564XUw3+DhGy4qCTvh37FBKIRu
         u9zT3njmbLQkExiRFf/IGc/qOKASh3RoUF8ISPbNE1lQ+S1F/ShLSwzE+pi2CG+iow8L
         HFfG3EkYNQEVpIsaR744K1VPqDz8E8INIxhTCe0+nSFG/sUNxTO+JokQ2Hn6G97SMx4B
         aMHglkdkl4dVX4Nx4F/0oEZ4FrRlNdn/ypX//DZ1jToc8L5JYMjMk+jmqE2jDjpJppUx
         cFWb2zSGXJ4y2IIpvB3aJRtPe7C3hnLOKufH0iifApLnNHUzaiqI47FHuCMkzizY6DUO
         nq8w==
X-Forwarded-Encrypted: i=1; AJvYcCWptzLVQ+E1EXqfR6Y73SIczidcuD4B7Be3Srt4ySNOeioEPrZVrFwNSMoMCsmCtC5woYgv2c+Qjvk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLlism48PRH10oXkziWMsqScn7Rp7l3ldIaY43yZOyR2JnZVPO
	Ee8DiLkew3f0qojNc7N+ErKcdFN8ht7KtptKtisMca7YoxDXtSzkn/kmwYICE+f+G4Pxmr35b07
	EwGO7Wndxamcq49oDV8YP0VERsHTTIpzftzWNn2idig==
X-Gm-Gg: ASbGnctcIiIcxB7/oDKzbOYkeWBFrXW9Uj5tnoDomJcCAxeFr4z0BmmEm5DHaiZhh9A
	EEWINojz14KyGChFhM20xfhPLrXwHKgtbDqv3LMDTjST3YbIi1/e3x9vYaRyNyfpZFVDszO1i+2
	qQJmPDJVudi3kw0ExsdYRvRskvkxD/vPzTfiVB+P8Ze5iL1bEqOrKiX6c3eFvknJukSK9+nkrhh
	reSkLo=
X-Google-Smtp-Source: AGHT+IHGuueojXvcDw+IxXf2H0yV1IZv2l/On0WYvOmWs3UEZEA+8rzZONaAnBMOjzPj+g4/KV47tq/0JIxyMnlIPRA=
X-Received: by 2002:a05:651c:989:b0:337:f40b:ceff with SMTP id
 38308e7fff4ca-3381e2bd8bfmr6337601fa.0.1757059828213; Fri, 05 Sep 2025
 01:10:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1757053456.git.mazziesaccount@gmail.com> <fc3cffa3b75d1fcd19df0ff794e6ad75c8c87373.1757053456.git.mazziesaccount@gmail.com>
In-Reply-To: <fc3cffa3b75d1fcd19df0ff794e6ad75c8c87373.1757053456.git.mazziesaccount@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 5 Sep 2025 10:10:16 +0200
X-Gm-Features: Ac12FXwzrJgD4cqNVEMDwjcqLjGCJuYfaMNmrTkon9AkUOYZTyb9cMdwIMQNW6c
Message-ID: <CACRpkdaY3P7uj8dQfDbauvyJ_sSYPeUC7kK+DTMrkfT+BcLjCw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: iio: adc: ROHM BD79112 ADC/GPIO
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Marcelo Schmitt <marcelo.schmitt@analog.com>, 
	Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
	Tobias Sperling <tobias.sperling@softing.com>, Antoniu Miclaus <antoniu.miclaus@analog.com>, 
	Trevor Gamblin <tgamblin@baylibre.com>, Esteban Blanc <eblanc@baylibre.com>, 
	Ramona Alexandra Nechita <ramona.nechita@analog.com>, Hans de Goede <hansg@kernel.org>, 
	Herve Codina <herve.codina@bootlin.com>, Alisa-Dariana Roman <alisadariana@gmail.com>, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 8:42=E2=80=AFAM Matti Vaittinen <mazziesaccount@gmai=
l.com> wrote:

> The ROHM BD79112 is an ADC/GPIO with 32 channels. The channel inputs can
> be used as ADC or GPIO. Using the GPIOs as IRQ sources isn't supported.
>
> The ADC is 12-bit, supporting input voltages up to 5.7V, and separate I/O
> voltage supply. Maximum SPI clock rate is 20 MHz (10 MHz with
> daisy-chain configuration) and maximum sampling rate is 1MSPS.
>
> Add a device tree binding document for the ROHM BD79112.
>
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Looking good!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

