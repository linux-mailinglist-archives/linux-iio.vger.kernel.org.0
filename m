Return-Path: <linux-iio+bounces-24655-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A44BB3E00
	for <lists+linux-iio@lfdr.de>; Thu, 02 Oct 2025 14:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 835602A2177
	for <lists+linux-iio@lfdr.de>; Thu,  2 Oct 2025 12:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6224630FF28;
	Thu,  2 Oct 2025 12:23:06 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954D73101AB
	for <linux-iio@vger.kernel.org>; Thu,  2 Oct 2025 12:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759407786; cv=none; b=uyaI5/+7LIDmIjZ+gqUFNP1bGD4EgY7gvawBA3IWnmx6fae95xFGocsyskqEni4AL7YpfN6OZwTvZwr/YLqLcDBF0WjeuKRH04f3jHHFnOyNqfZDRq/ilx33u3bIIOKGzENNqS9oeIAUGimb+br9tt7ofc9z8h5c1/KNKy01X1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759407786; c=relaxed/simple;
	bh=Tqtk/3Mjh7EHlittC8esBGgOeAbCYg7iKT03peJmm8E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YAuwJp+vB8zaqY8fj7t7Wb0PJ3oRZO2hstlW/B9maxiJcnGXBOcMLkHWgEIRl29AcGT8kaPvEg0qvzcYh6V8HsuywaFWX3S49IdmufKaPNHwYLlqne0s8c91BWJj5CQzy5yh/9uD/sH81Mg27yYbyT6b9aA5snMc86JIhGs8M84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b3b3a6f4dd4so187257266b.0
        for <linux-iio@vger.kernel.org>; Thu, 02 Oct 2025 05:23:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759407780; x=1760012580;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Va9V2uUOhWQg20/22Fe+/4og8vX6tT9a0pItbdogQI=;
        b=bPUkRWZ9WB4ZLfFnev4Zy0TtfSWuE3lg7R9h54rnJUVLLuJNGWTxoudFn+KM+FW415
         DdMdnK4TrPdbGmsud7Fc/Bm+GTLDzv2QMmAI7ZA7q4veR8o1hZIjDpJQxaNouTDdiVlz
         iv1Ge3C+3Bt8FQvEcVmgkezaJKKl3spXJ2Ge9Wi7kLtENlSq6Tf4z/N+xzrZdwiYgmcO
         QD8oW8V4+qP/qlmTmVBowJv8uPJ5riITgFwYqoNIiajRgac/WzlHKB0TEgly1xkmElgY
         YGdrLz/yW53BNarXr3oxVH4CXO2hTnFuRJ/l6C/QuvzCOY0Cy8EcjjDnZB2LP1a+d9FF
         eSbw==
X-Forwarded-Encrypted: i=1; AJvYcCWoq8orN+qBPYec0rreVP+oNMdwzDbyXzkgWxhkgbImlkO5ksMi5zg185yZurc8eWdzROKo7JSRFn0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR++VAhgZ7ePgMWWNEdEho4q9gp9a/hhTPJlVYB4XDbICT7Ivk
	/5pijsEGKxI0TK1Pavq4ckkcv5R3hpJWr3ukrePvr25ZGW2o93MI7uXNEhzXIgGyq+k=
X-Gm-Gg: ASbGncuKlvn+z8sJpG83jiMKEfAg/68brsUK6sP/G+Vt38kFLv7O31/yQpatt1Tn1LC
	N0byFoTTNwBJ9hwWGUFdwGXxMWu5YrIpJrPtoULT7ob8Vs5ET+95+LYP1zuBCRsOtKrq53IXk6/
	uQJpPESPXfuEkytEUNmJsmHhomhnOyJ1qSiDdt6VVjZl4D3PQqDxYh5+ltbQi6XmqC2NXJQqpX3
	aG7t3CiR4heQm4cBb21PnYg3kr6O/I3Rc4hpd35yqt9AQZ318x8H8QTxY1vDO1BcnT+0ETJM9M2
	YsKU4T9zTgeu0GXh3hedQIviyjqaCs39iOJNIfkFtWe58v33Y0WTWij8KPM/c1Bu66ObfHeWTwF
	BhVXovUxOzooFD7eobr3vWwzQhSKccOu/sBDoFSZQucd1S5KRjnaXpKSuRpLz6yfHF1c1TfftAU
	dTnIKOCCrI
X-Google-Smtp-Source: AGHT+IEfFW5vCd6BkJchnTTkIhZBiPrVD04PZKE79Q0nuEoE8dWpYT0OeJDiFUBQDFivAzex4B0+jA==
X-Received: by 2002:a17:907:94d1:b0:b40:6e13:1a82 with SMTP id a640c23a62f3a-b46e622683fmr764301066b.26.1759407780457;
        Thu, 02 Oct 2025 05:23:00 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b48652a9ea1sm198454366b.16.2025.10.02.05.22.56
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Oct 2025 05:22:56 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-62ec5f750f7so1601376a12.3
        for <linux-iio@vger.kernel.org>; Thu, 02 Oct 2025 05:22:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWhQiTeqTNQNr2USlf83Dd/R0KRcGwZVI6Hau6boxRh4szypn9kvyQIr0U3wM4GWkr23IGJKDo8fko=@vger.kernel.org
X-Received: by 2002:a05:6402:518d:b0:62f:2b53:5f7c with SMTP id
 4fb4d7f45d1cf-63678c4d329mr7937739a12.19.1759407776512; Thu, 02 Oct 2025
 05:22:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001122326.4024391-1-cosmin-gabriel.tanislav.xa@renesas.com> <20251001122326.4024391-5-cosmin-gabriel.tanislav.xa@renesas.com>
In-Reply-To: <20251001122326.4024391-5-cosmin-gabriel.tanislav.xa@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 2 Oct 2025 14:22:39 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWF9ZLrUMrk0LvDqVTPPnm8bAvqf3-hvtobpZpL=S=XSw@mail.gmail.com>
X-Gm-Features: AS18NWBgQP_ruL9GwGLtrsdk2TQDw2PTGEAqKYNAvgwmaawF9Btroxq-FKYQXOI
Message-ID: <CAMuHMdWF9ZLrUMrk0LvDqVTPPnm8bAvqf3-hvtobpZpL=S=XSw@mail.gmail.com>
Subject: Re: [PATCH v3 4/7] arm64: dts: renesas: r9a09g077: Add ADCs support
To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-iio@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 1 Oct 2025 at 14:24, Cosmin Tanislav
<cosmin-gabriel.tanislav.xa@renesas.com> wrote:
> Renesas RZ/T2H (R9A09G077) includes three 12-Bit successive
> approximation A/D converters, two 4-channel ADCs, and one 6-channel ADC.
>
> Add support for all of them.
>
> Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

