Return-Path: <linux-iio+bounces-23385-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B64AB3C008
	for <lists+linux-iio@lfdr.de>; Fri, 29 Aug 2025 17:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89888161037
	for <lists+linux-iio@lfdr.de>; Fri, 29 Aug 2025 15:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF2C3334705;
	Fri, 29 Aug 2025 15:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jz96YVGF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFA9322C72;
	Fri, 29 Aug 2025 15:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756482826; cv=none; b=ormjvak0vrgz/8o1TzpC+3hJp7Uyy7KZOsZnnxY71CvD7PgkpDc0YwJvwOACD2897XWJxrrTEs/0AUMfJcWciq6zMdHdoOdsBFo1YNpSb5DRwJh6F/dS7OcccaRG+pIS6Ymc4MgxHL1q25JtiB8mMiv6ebBiatRX0S+VmmVqwmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756482826; c=relaxed/simple;
	bh=L+BUnyhPFgXQc3V7hCxEwlEVhbHqw8k+eGLkf2A0g3g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AKmAHpk85/YXKgZ5Mfkh7G4X+OkW5T7UfJqFxzz85r1RH6QIiybyT+7zJtl+F/D0RkrKciQ1+FtwGQVWrQ7O2/rcukR7K9Q3O2SYYaQVxVFXGAjViWDrfZV/q3Bhk4cLnHFEvd0RBxHyS1PpM/iinoqhQ6ntirADMRxQ4Dk2Dpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jz96YVGF; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-afcb7ae6ed0so318288766b.3;
        Fri, 29 Aug 2025 08:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756482823; x=1757087623; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZHLotxYLpLB+HIJgp+C7C4cykVUndwDRsak3JNVQh1s=;
        b=Jz96YVGFuqNuzq/cM9CAY/9l5KlF4TZlTXcYy/ZiPAF2jcpKw6R2b/rdPG8YUCb0w6
         R8ZjVQoKYQhYPgOqe4J6K+i4UTQARYeibZ3+lhZn6av+V0w4KfpbHGlBUWsG51WcrHYl
         N39y9M7Yzk34MgGYOmzdt8z7OlzX5X1uCsuAJCwPGtsCeuNpkpgQVyXS+6Fd3B8VKHWN
         KQL0iWh2KqYUHl6na9YwbgN6vFv9gpwqUmC+SygNuNAxetQKvPNImLnxYpQtJlw4cfGY
         3EaMrIQpiMzRIwPbyn+gsNB2LC6OdC4SkBv18b/Xlqizh+qPuSPrCs4PnAE9dSStWTJT
         tlXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756482823; x=1757087623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZHLotxYLpLB+HIJgp+C7C4cykVUndwDRsak3JNVQh1s=;
        b=BtfziYSG9XB6rVGCZlpJYSc4kAgEKmUItwt10OBiBeoD4gvrrzR2jM4akMbLmmLFAN
         6AurYYCOkc1WmBswuMwwKMKbMtktgoy+Ogg/jzcueLk+9mj0B6JYKi5kvETW4Gz8XyuC
         WAB7w+b/Qo2HSEsZDii2/s4uOQGS4D+infsAg4vj0Rhgj3lcgaylkicqR32rE8O5fFfQ
         i8+PbkgJmcfXhpa8NgJbqKcV46iLocQTlzqWMigRWjhIXcuK4xs0pNjgKPQlF1t8IzRM
         QaZ96Z1nVejYfTXzfW8ID9dgBBuahM1mwb3/W0jopU42vxK1yMDa1kpp5rIhIZa8hwra
         wv6g==
X-Forwarded-Encrypted: i=1; AJvYcCUVXV3rXZCFZ9nQg8s/w5n+JScQ1nMH/EDLMMsLjoXnE1nvJtV9GcghyMeCVBKHhGs4mepvEvWLA0gE@vger.kernel.org, AJvYcCUjgSoH9jnvzl4BD27+PL7Csrf05bl+nyxEFeqPFuKa7shI9FYzIr22veADe5U2JldJDvuPvaNTDQ27HRDw@vger.kernel.org, AJvYcCXsgRfvDvSP+kSlXgsoAd8jgZi/g1Sglli44fLJ2aVVMJ0Jz7WiuFHh6ZKJ30X4D5NQhL95DK2XWFmH@vger.kernel.org
X-Gm-Message-State: AOJu0Yztn77ovJgNrgkbXLUCkiQTkY6bOeJUuWMiJvuEx0PWOg5lXBdV
	xxXncOWHePJNhOvqJoVyT0nrjzJoGz6BzNq257mylkVX+QeNtQfdBmefps3ps4OE96EqLNaCcjM
	K8j0wwAgIemeTxBuHk7Z2qhgOrfV9U7pVKutzDuo=
X-Gm-Gg: ASbGncsjNnldy9+lpHEYgbPxtxvcC5/jRSlwPF39Mr0bdkhItq9TS8J2Fefk1/BUFcA
	ODLjzhp5gVij2rRD/fZiSKPVy0QRLlhKjJNP4r0/K0Wt32MO3qRcsqL51o2Nq/nC/c5yLbyc4V7
	fGwl1CsHd9ujP15WhREY836ZqbMnHepD2mhUK0toxioCRBpsX2n6fHgvroRIngQAyG2ZidGXzRg
	h18h6EMVnsX3cndkA==
X-Google-Smtp-Source: AGHT+IH5QTLsYG8TGUnZZ2bd5tAwCv10yDcdICWw9dZ/g2XMa2bLjUryKSA9bygz9qTUl4JzuvpEaUDKCtP+UPuQWMY=
X-Received: by 2002:a17:907:c1f:b0:afe:e0f2:759 with SMTP id
 a640c23a62f3a-afee0f208f8mr703458166b.38.1756482823131; Fri, 29 Aug 2025
 08:53:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828-iio-adc-ad7124-proper-clock-support-v3-0-0b317b4605e5@baylibre.com>
 <20250828-iio-adc-ad7124-proper-clock-support-v3-3-0b317b4605e5@baylibre.com>
In-Reply-To: <20250828-iio-adc-ad7124-proper-clock-support-v3-3-0b317b4605e5@baylibre.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 29 Aug 2025 18:53:06 +0300
X-Gm-Features: Ac12FXyCiycxmXsmtTSntH0kziV5Tpp-WcN-mxLsyB6yWNH2RuTa1ep4f0HhUwo
Message-ID: <CAHp75VdtQ8vKULomgqPxwX=WZWUde7PC129BEznYqefd-U4DEQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] iio: adc: ad7124: add external clock support
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2025 at 12:55=E2=80=AFAM David Lechner <dlechner@baylibre.c=
om> wrote:
>
> Add support for an external clock source to the AD7124 ADC driver.
>
> Previously, the driver only supported using the internal clock and had
> bad devicetree bindings that used a fake clock to essentially select
> the power mode. This is preserved for backwards compatibility.
>
> If the clock is not named "mclk", then we know that the devicetree is
> using the correct bindings and we can configure the chip to use an
> external clock source rather than internal.
>
> Also drop a redundant comment when configuring the register fields
> instead of adding more.

...

> +                       if (clk_hz > MEGA) {

I read your answer, but maybe I missed something?  Can we use (1 *
HZ_PER_MHZ) here?

> +                               clk_sel =3D AD7124_ADC_CONTROL_CLK_SEL_EX=
T_DIV4;
> +                               st->clk_hz =3D clk_hz / 4;
> +                       } else {
> +                               clk_sel =3D AD7124_ADC_CONTROL_CLK_SEL_EX=
T;
> +                               st->clk_hz =3D clk_hz;
> +                       }


--=20
With Best Regards,
Andy Shevchenko

