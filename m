Return-Path: <linux-iio+bounces-25581-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4297C152CE
	for <lists+linux-iio@lfdr.de>; Tue, 28 Oct 2025 15:32:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D72801B229C4
	for <lists+linux-iio@lfdr.de>; Tue, 28 Oct 2025 14:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914181FECB0;
	Tue, 28 Oct 2025 14:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s2MjgxQ6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B479F1C6FE1
	for <linux-iio@vger.kernel.org>; Tue, 28 Oct 2025 14:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761661850; cv=none; b=rVRcYSaLOAUaLRc5z72NDvfcY2vbShxhRYfukEohfATBhdGF3aNGV3Qi3xigKVP2uvHGYDCsTk7u0OJsE7TfPP2TKqgsZS+VEoOzst7WHq3BwMEtIrfqPbqPi73luNmMOdNwUMMpyFyl/hzsRmfKDUdwX36zMyOGoHf15P1HklU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761661850; c=relaxed/simple;
	bh=/EnaIRg4we5FEW80Ou7ogsSNVQciSKk7T2iuyHX0uOI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mb1kpw/chdXL5KgU+iDooYfpIb1gybJ1IQFJC1NTxlwGZN78ZpWnMnJngJGpCqaebkppPFJ7goKsTexNhKnuZfNPP6Lm6v5WGveDWP/WE2cHyRYcjBW9VxRLrWefyINF6wyJdcw9MdIG74QOPNJliJ/UwWf8WM4rl3unHXqvoMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=s2MjgxQ6; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-378e8d10494so48525371fa.2
        for <linux-iio@vger.kernel.org>; Tue, 28 Oct 2025 07:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761661847; x=1762266647; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RVxwfZTDpc7M4pQsaPFzCx/W1h+13bfqb6IBb/Bsbhw=;
        b=s2MjgxQ6lTaK6dun6iIHp7vmhEed6zrkl9FD7AP7/pt8N3Nos53voI7c4s0JhMrIQK
         KftvX3G1+qbLqG0Ve4fo08Pg/FpSuaq7rtZynrv7eD6NWKBrjWLsiArPkheUp/91vKz3
         bNB3tWgt7Q4iSnpnZKSjB+uLcKONRZCkBIS+QnRt3KNxGoXrp8hb05ma96QaVUwKnYpd
         hkltdaGRBbgCCqVbVfQA+KOsR9la7PmqQ0zJYMoRucTqfO0NobO+etuO8i7053KCjLZ2
         kWMQLVqGMmrKKXBogFQqEOBJGkPuKtT78HBOh2wmXzdevwcnhWI7KnxN2j3ty4TVTlhk
         UVOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761661847; x=1762266647;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RVxwfZTDpc7M4pQsaPFzCx/W1h+13bfqb6IBb/Bsbhw=;
        b=XkZ08IWH2ffIdib0pcwduXonCFec3jE3RG9WDjapgSOz3aDjLpDzmFdczODPB/6gAU
         xWfXI7BC/tqJN+p3AJNjxsM02++JzVkiw8mWe3UNNCC8bGcOhNRrCyGTaCF4fgvTGi8e
         I79Qz17x2XAyYU5gg3C8UqgLe0M4xn+/eXGxkyokBjYh0cpztfV9E36LGzfvE6sJa9r6
         /0bWRIDocfUd23nH4PSQOxJ0js+SARKQfFTfwz+bwPh/PbbIdL6/r6V67cve/0M6vg+s
         AvCVBjNkqetUU0vzbf60FqrhsNGoSxOExI1YKLHOXV0T81fc+k8tkNWtVTYj7eqxgubq
         ohjA==
X-Forwarded-Encrypted: i=1; AJvYcCVljack+zmxvkSyXDDAy8EJuueQqiKB1S8AUqo9irfkmuFidpCpI24aVpaOdYzGoSsMzNnd6z8/hDw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQuT/aUuWtH6BPRA5jK4sAHonaMZwu9Psu59I8tDhY4714ZOzb
	unLoN2VaO+6saE7vhy1VeQMPekGBuo0B0Nilmb7zZSlXlCOLu3bDd86zRwW2NNPj9JZA8EQBaAe
	5SUVJt03XQwG7OPO/kX3ze7v5L6wGq2naVlGEaqH5Rg==
X-Gm-Gg: ASbGncvQFK6QVFZ3Z5qjNtkSnPGF/Rb6kwT1n6xahSHOGjMW2wErEVPxLCNkFSbk/5L
	YLZ2RDJinqshxortXZ3TvWKaR42a8fgVbc8Tyh1nO3ZiFW+Hj7aMzWS22TfuXNTnuPXSJeAX5Qq
	bKJVAZyueY1bObcZsPe6iY2PdhEFC0leUo4b+b5vGpELOJxDxSyO2I0f1/TF6vIPw2qhPxzkh4D
	sPQ4rz7iHJqZF+Y0Wd/9lKA4SixgUW3vqE0A9Rza/pGnqQwH4AvH4MmKrptLmS6LkRjxAA=
X-Google-Smtp-Source: AGHT+IGfUDzyVfhtzulYZCc6iSfT211wGg2uBIly7fuTRZ7yuQGh9plAyDcmAhZ0TpLkRKajO5Ig9eKhL0B7O+boJMQ=
X-Received: by 2002:a05:651c:23d2:20b0:378:e0e0:3b3a with SMTP id
 38308e7fff4ca-379076be317mr9148741fa.14.1761661846757; Tue, 28 Oct 2025
 07:30:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027-fix-bmc150-v1-1-ccdc968e8c37@linaro.org>
 <aP9dqnGb_tdWdr7y@smile.fi.intel.com> <CACRpkdb9GYL3dQzn28Q5E_-keJdLLA+TiXxTuNf1aaevKqHJYA@mail.gmail.com>
 <aQCqOJWQpvgI1o1q@smile.fi.intel.com>
In-Reply-To: <aQCqOJWQpvgI1o1q@smile.fi.intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 28 Oct 2025 15:30:35 +0100
X-Gm-Features: AWmQ_blj3ecUmJnRC1MKqgYg_3nbYbn6QScF7hxV1R6JPg_7pa3_fIhb0qICMdE
Message-ID: <CACRpkda6HFnFPHELYAPbco7x4Kr1Ri9PxM4rePOGfihV0mef0Q@mail.gmail.com>
Subject: Re: [PATCH] iio: accel: bmc150: Fix irq assumption regression
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Matti Vaittinen <mazziesaccount@gmail.com>, 
	Stephan Gerhold <stephan@gerhold.net>, linux-iio@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 12:34=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
> On Mon, Oct 27, 2025 at 06:24:25PM +0100, Linus Walleij wrote:
> > On Mon, Oct 27, 2025 at 12:55=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@intel.com> wrote:
> > > On Mon, Oct 27, 2025 at 11:18:17AM +0100, Linus Walleij wrote:
> >
> > > Hmm... Isn't this already being discussed somewhere? I have some d=C3=
=A9j=C3=A0-vu.
> >
> > I brought it up on the PostmarkeOS IRC, otherwise I don't
> > know.
>
> It might be that it was a cross-mail that describes the same issue in ano=
ther
> IIO driver.

Hm, I'm a bit worried that this may be a generic problem
in several drivers that now think they can be used without
IRQ but actually crash if you try to do that :/

> > > Wouldn't check for 0 be enough?
> > >
> > >         if (!data->irq)
> >
> > But this driver does not store the IRQ number in the
> > instance struct because it isn't used outside of the probe()
> > function.
> >
> > The information that needs to be stored is bool so that's
> > why I stored a bool.
>
> I understand this, but I think storing the IRQ number is tiny better
> as we might have a chance to need it in the future.

Fair enough, it's a common pattern so I'll rewrite the patch
like this!

Yours,
Linus Walleij

