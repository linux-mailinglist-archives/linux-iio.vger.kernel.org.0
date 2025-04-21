Return-Path: <linux-iio+bounces-18466-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB936A954AA
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 18:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A21BF7A30F8
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 16:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1951E0DF5;
	Mon, 21 Apr 2025 16:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RzLCtRo2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F411A238A;
	Mon, 21 Apr 2025 16:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745253746; cv=none; b=erUNdJL6imQ1v0+1l6TxZ29sfhgxOmH64q0UZGhcfFflPeJSsYj5O0OAnGMS9Kki14BoU+R9icHz6pOWuHl1jCkRf84wddxHyRex1UEIOmeQ8pkesaUioH81tPwoJj1gTtldF/CSxdI+FBgajfPJW4211cmEQng+JFcHPRjtkw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745253746; c=relaxed/simple;
	bh=0fsyOStHwhC1v88XvZ4Ac0nuPUuFtHM5xo1t68kAtVk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uFsit2Q5f/pF3ytvaJEqGGIiP3j3M+yVZ7l0T+4LbFyLS9X/vnWLSEEyfzuBwZpD08r1UED2KEKLjmzyssph8wOxopN7DNSzHL5YgXHj2pF/z4U5fpv1S0UPmNpTT2qefb/rZcdyqHIKdxyVnMeMlnjN98ogbsqaXcCBINgryhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RzLCtRo2; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ac2963dc379so615488566b.2;
        Mon, 21 Apr 2025 09:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745253743; x=1745858543; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L1I3cbwltjOGElOuVsLVlgvPqjddyD9qAtM+fs2VWpA=;
        b=RzLCtRo2dGtqt56ZLaZoVyWLpqxb1ZjzQBk3p2Amr9jUiFSzaBJF6ZET8P+XnmEzBw
         RqxytAn/4V0qqExxsmIlMUZmCQHDtBU0gChsy9fAHY59x/QAxuK8NW8VWhrj7BX1hOWm
         RYhcHrQa9vuAiJY5ragTG4+RLjQpWNhoKh6mfUlTkuSXg0deYdyyVW+SDVrTMWl83FYe
         fGYIWe8O9qbECOpBiK1XR06WQ362VAKijwXtXIadEwJ+97mX1zTKnpzi5p9u5KkbnkzR
         TuHOp3V1symBe5K5NtOExu4z2NhStAXD9dpVcuzAvQ8ExfagwAGW9tk4KIjoPpBZqbU3
         N1NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745253743; x=1745858543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L1I3cbwltjOGElOuVsLVlgvPqjddyD9qAtM+fs2VWpA=;
        b=unyuSKpTQ24s1AlBvKDhkK2J9+rponRV9shllgaNjxJe8/enP1cqR4C72Tm+HudEZs
         vdltRFTJWgC/H1YXV5UVAvGS6ryIIIe3zJvbz7BZOzwvZig4venwEybMo0JK5jlUivcp
         WtRu+h0WyVcU5cbc0X+Wlk/TbooSG6hEkJN3yUFDYcBlbaoLC8xbURWHSa+NeXh82WoM
         HQAOxMeQwsnMTNtZKlhmU/v6j9xpUGgHNYwsXyo74ZAPFJU3TWD9EbheS9PtM1+My3Fe
         axM12myY1Sopy6DPbFreN9XoYh4VGt33J9RySILtZZ2foeLEaPgXAqeqZrQoiysp7+PJ
         1u0A==
X-Forwarded-Encrypted: i=1; AJvYcCU63D7vOJoG1m1rz5YPgre51OTe1i3m/YUJ7XtP4hAqLzShQUpqwDH6OhrDMWZyAOEIKk0ZfP2QkTY=@vger.kernel.org, AJvYcCViAkxYpmB0+NyvbGCPr3QvL4RBCoK/4uf6KXhC+cN84OdKPOyxZ6mhrUZw3vtTx2eEzCvOCpiqYmHJfiVq@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3EU4R4Dw6gJ5vqB7ZstVbA+8wAt8NOMJe74fmWOPfErFDfXn1
	TGha8MaqK/rCM36lrpZR2KHjM18v7QAome1GvdD2jntyAZQr/dY5W1BcU1CKi5rCaFG7YqPKsd+
	bYFBS3m3zQKCO964vvlr/4/4aaKI=
X-Gm-Gg: ASbGncuz5pF5tu6Zj8wJOt9oK9iMcAjZsTk/PQajnTFZr524RMC+bBNJ6QPEfSAoqrr
	1XZfOsDl6TT+d4RofinT0xoDU5oEG50FS+JcpbKU6T9RhMNdE1w6iVlN/ibgc49kLjZzNbDAOds
	JogEVBX4SAKdbnZhQiKtnZuQ==
X-Google-Smtp-Source: AGHT+IGOkY/7PisAD2oLp8QqIo0O9LumO+tYusSVEov8PZqxdtzgsegmull0yalfq2NuFZ5JO7zCd3FO9FZrDniI0y8=
X-Received: by 2002:a17:907:1b1f:b0:ac1:f19a:c0a0 with SMTP id
 a640c23a62f3a-acb74b1ca7cmr1191466066b.20.1745253743466; Mon, 21 Apr 2025
 09:42:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250418-iio-prefer-aligned_s64-timestamp-v1-0-4c6080710516@baylibre.com>
 <20250418-iio-prefer-aligned_s64-timestamp-v1-4-4c6080710516@baylibre.com> <20250421121341.49e28ddf@jic23-huawei>
In-Reply-To: <20250421121341.49e28ddf@jic23-huawei>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 21 Apr 2025 19:41:46 +0300
X-Gm-Features: ATxdqUH5lMC16PsOqzsa5gclyWSAtg59GNIHcNrRLuTnmqVLHUh5EH6DsroQl_c
Message-ID: <CAHp75VcAHZV4zGMvR-xVuVhhBJMCmo7A0w0fnwASw3iAWU5wdw@mail.gmail.com>
Subject: Re: [PATCH 04/10] iio: adc: mxs-lradc-adc: use struct with
 aligned_s64 timestamp
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Eugen Hristev <eugen.hristev@linaro.org>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Andreas Klinger <ak@it-klinger.de>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	imx@lists.linux.dev, linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 21, 2025 at 2:13=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
> On Fri, 18 Apr 2025 14:58:23 -0500
> David Lechner <dlechner@baylibre.com> wrote:

...

> > +             aligned_u64 ts;
> aligned_s64
>
> I've not idea why timestamps are signed, but they always have been!

Because 0 (center point) was chosen as 1970-01-01?

--=20
With Best Regards,
Andy Shevchenko

