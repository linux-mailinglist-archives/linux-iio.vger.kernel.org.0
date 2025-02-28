Return-Path: <linux-iio+bounces-16171-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22465A49406
	for <lists+linux-iio@lfdr.de>; Fri, 28 Feb 2025 09:52:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EF0816DDC6
	for <lists+linux-iio@lfdr.de>; Fri, 28 Feb 2025 08:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D37F254847;
	Fri, 28 Feb 2025 08:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oqv88IH0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B312512C3
	for <linux-iio@vger.kernel.org>; Fri, 28 Feb 2025 08:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740732750; cv=none; b=VXUaw7ttXWOYBlFuIPbvLX1Gco7KZ2EAtRcNnllQovre+qnTA0mNfe7HWn1KDFV9A9rGndI66rU6k7sbFYBQNq1VPncU673VwonEcASczSu06mBWEaoLyQGuNm0dGdXnWCMEJ0n9TKNVDIaB2PAKvr0Zw6XOPTEi84ucqLRgLpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740732750; c=relaxed/simple;
	bh=QAZ1XbH09v7b1zWZ0hsXWTy0W7e9HTzyQ7n3BOJSdIM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tVw0mmkwr19WCGdwciPjT3M10yu6CluzLkynQn4ZU9sQc+1sebPFhiDMamp7irMSAC1jrV2FE07K6zEqryoHv6gnyMAgL2Hc6vpBeklPVlTWNW8t5P5bws051wSd2iW1wnVqN0+CB2LF75JbflZCVHCI9oI9tcS4Hk0RpqAUqgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oqv88IH0; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5494bc4d741so945171e87.2
        for <linux-iio@vger.kernel.org>; Fri, 28 Feb 2025 00:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740732746; x=1741337546; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QAZ1XbH09v7b1zWZ0hsXWTy0W7e9HTzyQ7n3BOJSdIM=;
        b=oqv88IH0Fu58PpsE4em94prhjTzhdw48VwmrFHg7CdbdAwbavnegV9HfWzT0PJ3Bt2
         +l1qTW6k/q7VXv2w7wSW5Ru5PK6aM8LUSQUEBFtQ8qPnaynrKg+d08WypuBImcDgrOC8
         de+itt/MuoHgovngNLlaU1nKVOrLOXwC7O6OmR1JLEWL/5K/NQQvMw+BmxeYwZmT3yyS
         arWmpvCXyXb4FmZIdutQYQCRWa5Xluz9xB5BsnuApoq004rt3T/bnidEHGyoKA45EUOA
         wgXXRg7AHVt+vTLk38T90zT4x7LLETREkmz33fs1qHoMnyEEGNA5I05ubjFbYTWJoPaZ
         qyWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740732746; x=1741337546;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QAZ1XbH09v7b1zWZ0hsXWTy0W7e9HTzyQ7n3BOJSdIM=;
        b=bT6GCWYIKT/VDQYD2qPaVtWI4NCI03VbVKaUkWUQmd9wGybr5xdJWQUdfUaPWxaEZc
         wr8oGu02OIX+Kw8uHcPCRO+4xQc4ILOXC7FClEte2ccClbu3nD6YJpFnzwqPfrOylksQ
         HMoSDGperdtJIJjKqDQSmhcjc6iwjKd0DXHZvgTKtFIfqMGm2fytiwBW7uMnLlZVtpo/
         iSitI0U84Ya0j7Tph/6fP4qoCpgr24YnofevoKykez6WPi1SCHlka7ty7yctvjKzqQGl
         tAqpfCX+S3zR9IjeLo7iBixV4Zn5My4A0EuepWLItfHc8aP1yt1hyrDPhfHiXjgSN1wc
         /Dpg==
X-Forwarded-Encrypted: i=1; AJvYcCWU4aKjFI/Xi6ZaRKrgUpvVdUYPcRchy7VhImEgNKwTmGTFIbheA4rjPOug+quQX5IsLGx69vTPfh4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7uEOTtyKOhLwOs0L2Mio41Ne1crLcluJovzqRWbcxZzEKTsFj
	DH1++iGyb9MhGsM8oiak1qe+2WAlkKRn2t70Plxs4Zagh9ry9eTUV/G4+qi3XMYSXajdyvf795a
	XMjNX2UZPfQzQZByC4UeYHt7OD4aaAP0NpX94Sg==
X-Gm-Gg: ASbGncvIUPuShg6lw3RMNx4BmonMUT2NOOgWjLBsvZuTFuPgtYImuoNlNkAPqyhGOk6
	nxsAKgvXZFKnaBoeTh8IyEcuyUaTrGLCA70g5aoTR6YcL8V93zEN04WG+c/ROJLkdaV6Jtcc7On
	D1U6j9QF0=
X-Google-Smtp-Source: AGHT+IFLrniw5jq4oWKYdbCJ1jDPnBqcD2jK1p8/hj2hMot5ls33gsWydkV0WZlBpXGLTrBYBZ2pqZLZjbYdrfBpayU=
X-Received: by 2002:ac2:4c4f:0:b0:546:2f6f:83d7 with SMTP id
 2adb3069b0e04-5494c352318mr1042433e87.46.1740732746436; Fri, 28 Feb 2025
 00:52:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1739368121.git.Jonathan.Santos@analog.com>
 <62cb9786b02adde118db9349617cb796585ceb02.1739368121.git.Jonathan.Santos@analog.com>
 <CACRpkdaSY7WH191makzPcZqLd-vBsC_f6yagWzBa65MrC+pjKA@mail.gmail.com> <7c5e2364-038b-48a8-ad67-3cf0f2fd2be3@baylibre.com>
In-Reply-To: <7c5e2364-038b-48a8-ad67-3cf0f2fd2be3@baylibre.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 28 Feb 2025 09:52:15 +0100
X-Gm-Features: AQ5f1Jrkm-kow3OXmnSJltTmG8QrhANbAwgPagCFyAFP-qUYHz9z9ilWano5H4U
Message-ID: <CACRpkdbw3BkpzPQp2PdV8M61V2XXaLcmuOpGTsxSoiQTH7wZXw@mail.gmail.com>
Subject: Re: [PATCH RESEND v3 12/17] iio: adc: ad7768-1: Add GPIO controller support
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sergiu Cuciurean <sergiu.cuciurean@analog.com>, lars@metafoo.de, Michael.Hennerich@analog.com, 
	marcelo.schmitt@analog.com, jic23@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, jonath4nns@gmail.com, 
	marcelo.schmitt1@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 11:27=E2=80=AFPM David Lechner <dlechner@baylibre.c=
om> wrote:
> On 2/19/25 2:34 PM, Linus Walleij wrote:

> > Is it not possible to use the gpio regmap library in this driver
> > like we do in drivers/iio/addac/stx104.c?
> >
> > It cuts down the code size of simple GPIO chips on random
> > chips quite a lot.
>
> I think the answer is "no" since we need to hold a conditional lock
> while accessing registers. Namely: iio_device_claim_direct_mode()/
> iio_device_release_direct_mode().

Sorry for potentially dumb question, but if this is required to access
the registers, why is it not done in the regmap abstraction itself?
It's kind of that stuff regmap is supposed to hide.

Yours,
Linus Walleij

