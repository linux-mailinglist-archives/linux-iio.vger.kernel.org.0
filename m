Return-Path: <linux-iio+bounces-25507-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 93509C0F9E1
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 18:24:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5C7FF4E2307
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 17:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26806313E18;
	Mon, 27 Oct 2025 17:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mWcABCHw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1982A2836A6
	for <linux-iio@vger.kernel.org>; Mon, 27 Oct 2025 17:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761585880; cv=none; b=o4tFGZhounCXWOohVaNhA3Iy5PJGLmc7YQuRgp+FSru/EYmcbfcMU/jkpK2hrblp5T1Wa1UALWJnIJG8DorRIyVYHlhAhZuGvn4RGnws+PiXseu9mCZgiJYayStOrVHmmNfIgTSqUc6nQ+bXcegaOUzOwOcdaoHBq1srESpCU5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761585880; c=relaxed/simple;
	bh=H+UsMyZ1D2M84IvFYt42sGLim/Wl8oj+lV+wL+yA5Wo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kNYUL0CDB6BV6XNg5MPD7SC/32LDIJCTq3DZISmt+Xzc0cz3Asm66o2ToYGX8/ww0adalFaoq5GvJeAev42IbUfCbIl+Ztz1Vrtj+jHVtM4x8xRI5nBXGuVOVRQObqi9x9qUMy5RxCV0uzrrdGNsYnMcFSqIfL3pw5NnIfhwjgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mWcABCHw; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-36bf096b092so48230081fa.1
        for <linux-iio@vger.kernel.org>; Mon, 27 Oct 2025 10:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761585877; x=1762190677; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KDcoxJRAlkXWqHdk/zGinMH8+PB5csG7SmxeUNdw1uo=;
        b=mWcABCHwriK+jyHnvx7AmQUpBlTGBi+QYXJfByagmDAat7AQIqnMSANzF+Qj7N07CC
         OBH6DB3IbMDdpY68UzpnQNt1Mau7Bjw2R6/y71Wb3QzRnpDjM3ZRAc8ROeeiX+24GLob
         OXXX0iyFY0wJU81ju8fTvEhWePlxSOsD7o3BYr2McMzZ/1RJmQVFW1P7U32P3DW1TA5k
         xn3aKVZ6BM1Xn6KecCINFTlP6zUgVgdg520V5D5f79lfHzUZBFkY02dHsXMgCMR9wxaT
         /6AzdCUYmXn/moQrhmxZxq5WX6X6IftcaoE3h3zLvG1VZg/iYvH57hB2HRYzXxemfipL
         ko4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761585877; x=1762190677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KDcoxJRAlkXWqHdk/zGinMH8+PB5csG7SmxeUNdw1uo=;
        b=gd/dKaCqQTLdXfYY+BT+d4vpUQ2i6kzXaQHKQUN4iv7NTVbQk+R7kbzwWwBAFVY1aA
         0JBQEC2qctj6BRdnB6ApraIIwhrWaF3rgiLfRKscWxejNvQNLVOiCHm2r6vwUS75dCvR
         f+WnfqE9rwk4N+nHSmh4PPQ5WPztegLct+Wxst0tjK0o8axeaZSMfV7OJOh5kA8joOls
         bDni12LXTqF84lDFo+mzQsMrEZiGXo452CZDlslIotGhMyT31z05U9+29OHPjHuwKfBe
         Q1+5JXfzU9++lm6kktuKf7VuY7CoDLqvXvmTop+2e7CS7aIrL2PZcuD2JPUVnx4qI5LN
         tURw==
X-Forwarded-Encrypted: i=1; AJvYcCXFXufQOeFF+lEb5wJkQ2BasaIEU50HIMcYh3VwbdwLEbxiMnWMDVTCedVynbO5OFRLibqhlL9GEY8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXblaSKLAveJpytjx1doXSBXOsGt41mwJlCCT6HY36QXpLpnjT
	26qS+aGo+mDkP7D6Om3dAYJGIgEZAZ/vBR/8eGIZskriaRha3J4sAIeKHY9AHWPuNXzw7C+CHl2
	p3u7u3SlHnCdILwn5exnOmce/Av9HO1du++e1haMlwwUj8xFrMbI/
X-Gm-Gg: ASbGnct7d6UWM79s6sTKhV6D0l/UEQkQC/nVfYZKM7MIFoBuzCAoPRFINO2LYtheXK6
	mtoW3PWB0pxgI54ArpJUCOkaEsgNdumj99jEvIIa2XBrVmwRFOrglg/5N3RevnnrKmX6SI25Ki1
	S1T0hOdygZeVY7s57YHDInMdHuBQXFgUyekMVBCFFa1dLljvJqmFpOuLdce3nPZbheJN4rHRPou
	zG2Q6RUNNjp02s+afNuty14SzbgNSuikcIVbwXxt2fD9Hp2NyQv9m3iNbqRKgrgjr6Qwm8=
X-Google-Smtp-Source: AGHT+IFX0e9200QyVm1MYTKHJt2ce7Ry/DwJ0Qe5QVYRIGSLkt+EL5l5w1SYOJQiqzaagm1IvJXnEkSjT3lx5zSSU0E=
X-Received: by 2002:a05:651c:4393:10b0:378:d690:5d85 with SMTP id
 38308e7fff4ca-3790773f5f0mr1179011fa.40.1761585877172; Mon, 27 Oct 2025
 10:24:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027-fix-bmc150-v1-1-ccdc968e8c37@linaro.org> <aP9dqnGb_tdWdr7y@smile.fi.intel.com>
In-Reply-To: <aP9dqnGb_tdWdr7y@smile.fi.intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 27 Oct 2025 18:24:25 +0100
X-Gm-Features: AWmQ_bka7Pw47NNaWKJfaR9a-GIXaKqJFr5gK3KIFi8TtV2j92v-PHbEnL_5aII
Message-ID: <CACRpkdb9GYL3dQzn28Q5E_-keJdLLA+TiXxTuNf1aaevKqHJYA@mail.gmail.com>
Subject: Re: [PATCH] iio: accel: bmc150: Fix irq assumption regression
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Matti Vaittinen <mazziesaccount@gmail.com>, 
	Stephan Gerhold <stephan@gerhold.net>, linux-iio@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 12:55=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
> On Mon, Oct 27, 2025 at 11:18:17AM +0100, Linus Walleij wrote:

> Hmm... Isn't this already being discussed somewhere? I have some d=C3=A9j=
=C3=A0-vu.

I brought it up on the PostmarkeOS IRC, otherwise I don't
know.

> > +     /* We do not always have an IRQ */
> > +     if (!data->has_irq)
>
> Wouldn't check for 0 be enough?
>
>         if (!data->irq)

But this driver does not store the IRQ number in the
instance struct because it isn't used outside of the probe()
function.

The information that needs to be stored is bool so that's
why I stored a bool.

Yours,
Linus Walleij

