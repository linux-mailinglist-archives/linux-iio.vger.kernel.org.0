Return-Path: <linux-iio+bounces-12515-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2CA9D6482
	for <lists+linux-iio@lfdr.de>; Fri, 22 Nov 2024 20:17:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55527160E92
	for <lists+linux-iio@lfdr.de>; Fri, 22 Nov 2024 19:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895B91DDC24;
	Fri, 22 Nov 2024 19:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kM1SaagZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F82D64A8F;
	Fri, 22 Nov 2024 19:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732303024; cv=none; b=T/5lgPDlcWIAGgJz0qE7/r+OH8Jamw2m3IwDn15xxQoOuCiauY33BD0Q9vmmZpqKir8AHaLOZx49tJpln9/z14aAxzwFMtW94P1MIDuGLe73f/3YEaB2yfVmfJdLwOrnRO9RpRJ+aeGXA920aLpVi2s/Vud5ZrNMa2igLuRPPmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732303024; c=relaxed/simple;
	bh=E2l7Qz9NMNUP8iHIFfm+hdSYRDgZXHIgLyEPPMG3uR8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n8oicaemIP0BdMkNMt96jlvhm4NXZCQlECrGA4l+lNX9L6TanKmAYASoyESCa/mRL0oosPLdERHMGeRfvIU2DB3Ddh3qJenSr7OF0JBbvetC54gWjsNpPVghk3p18ri9yzr3qu2a7lGylCpU0dl967lfsqg9HH4994Lh3BzG0QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kM1SaagZ; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2fb5fa911aaso45696421fa.2;
        Fri, 22 Nov 2024 11:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732303021; x=1732907821; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DA5BQinA+K8E3Rs6rAmQsutDEAzcqPbYmFB2ne6yyRM=;
        b=kM1SaagZSrLZbnCoI1C4ZSitB+SyLfB3u0xE0zSP4EkqxUzrm7f3IJWhrMAdx+xBfR
         Vfe5W0EJUakJ8ez5FWehMy3XQG6+GJHhB9RNU0x1xX6eTUBf6mbzTKuMc1E6xWuV/Ki1
         0faJkRO9424Zf8laYIiJzOmbaNa/5FR30YEBrTTL2dVdpCdosrnY1Zz1WV92FRgKl7h8
         Wll/uZcYWdTDRoJKoK6AQegF40CL9TaKHjE28lSqiT9Igj+qzNVGFY/eK7P/pSEtmdiI
         fQB0DEhuZuhYQu5Ij7BHR/uJuV/IA5YI2WL4GqCIvqUDryp3u9jK3GY0s4BaeTDAaejO
         8DkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732303021; x=1732907821;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DA5BQinA+K8E3Rs6rAmQsutDEAzcqPbYmFB2ne6yyRM=;
        b=wRenklOeVbubJXbBNN/VK/sSzG0YJVzZsE+axklSDAvqkJHPHtu+ClNyi5V7iG0A5C
         Ud+fvQqtJ7SwRMc/ei73EIXYguO0J8E8M8e90RKTSxL+OVo3klh+iGlFLlzK3eMHKCaY
         PJaMzhYJI+ZY+hmDjgqqfbusQ2hoDfQrp+qUUzsryjUd5JQbx8WFsZf0MnZppC3Bujin
         YA8t+Eqa5hKJ20AGvzgsfSuiIMRvf8lrbx01T08YSLBwyX7JJeKxxhxmmk9NDHtPGxIk
         L7RJdILlvk/v5ReMcnVrXRPOf41lpy+sav26KxZqyqOfkjdm8wTilW/jH882FxN+PQZm
         qyNw==
X-Forwarded-Encrypted: i=1; AJvYcCW39a+jq/wygKDhKVyTWpHgaRX06RvCpYZuTpl9PNsLiu/rBstUKfDCgNeinLtdsqdnjfwPf3vVBSHM@vger.kernel.org, AJvYcCWJQGu/dDyhIF2iq6fo83hv3K3zHjUmB5vAtRoZ3W0mNFjsv98SdCYgr71qRqKINTQ+SOa9LnR1Javc@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/ZKAtlP4hSk4DtPEmD9AGyET8iIp4B5dlBghbkPFRR9UWJrJA
	Yd/pPSJ8wydnv9hTDQ+ty6lpWHL7ulO9ph0R4cRxJHjs4R101skkNpp46kFWu0D37Zf3fgQeNuZ
	aWj5aVJx1DmbufM1zEMcsrFyACRY=
X-Gm-Gg: ASbGncu1KIN/lwpczasoDgcSCI+PH9CgloLswhHX1oTB7Sd46lZZK/3tdeavQTy+4rU
	Z4omagLwvijuWWNaRXNCqxBMYIGsdDb8=
X-Google-Smtp-Source: AGHT+IETHPVbTdLJgmSiRZ3qgENUPco3qGAB3fAKFgzhDoEjDadpU4p0bTj95k6oRnjTurPFJFNUX5xx1/X+yc0bRTQ=
X-Received: by 2002:a05:6512:4016:b0:53d:d60e:fc2e with SMTP id
 2adb3069b0e04-53dd60efc32mr2762642e87.5.1732303020416; Fri, 22 Nov 2024
 11:17:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241122113322.242875-12-u.kleine-koenig@baylibre.com> <20241122113322.242875-16-u.kleine-koenig@baylibre.com>
In-Reply-To: <20241122113322.242875-16-u.kleine-koenig@baylibre.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 22 Nov 2024 21:16:24 +0200
Message-ID: <CAHp75VewsWJ-R+7Uf7hVdj5B4LsfGwR+NDPCFW4=FQF1dJwwbA@mail.gmail.com>
Subject: Re: [PATCH v3 04/10] iio: adc: ad_sigma_delta: Add support for
 reading irq status using a GPIO
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Alexandru Ardelean <aardelean@baylibre.com>, 
	Alisa-Dariana Roman <alisa.roman@analog.com>, Conor Dooley <conor+dt@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Dumitru Ceclan <dumitru.ceclan@analog.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>, Rob Herring <robh@kernel.org>, 
	devicetree@vger.kernel.org, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 22, 2024 at 1:34=E2=80=AFPM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@baylibre.com> wrote:
>
> Some of the ADCs by Analog signal their irq condition on the MISO line.
> So typically that line is connected to an SPI controller and a GPIO. The
> GPIO is used as input and the respective interrupt is enabled when the
> last SPI transfer is completed.
>
> Depending on the GPIO controller the toggling MISO line might make the
> interrupt pending even while it's masked. In that case the irq handler
> is called immediately after irq_enable() and so before the device
> actually pulls that line low which results in non-sense values being
> reported to the upper layers.
>
> The only way to find out if the line was actually pulled low is to read
> the GPIO. (There is a flag in AD7124's status register that also signals
> if an interrupt was asserted, but reading that register toggles the MISO
> line and so might trigger another spurious interrupt.)
>
> Add the possibility to specify an interrupt GPIO in the machine
> description in addition to the plain interrupt. This GPIO is used then
> to check if the irq line is actually active in the irq handler.

...

> +       if (!sigma_delta->rdy_gpiod || gpiod_get_value(sigma_delta->rdy_g=
piod)) {
> +               complete(&sigma_delta->completion);
> +               disable_irq_nosync(irq);
> +               sigma_delta->irq_dis =3D true;
> +               iio_trigger_poll(sigma_delta->trig);
> +
> +               return IRQ_HANDLED;

> +       } else {

Redundant 'else'.

> +               return IRQ_NONE;
> +       }

Can we actually invert the conditional?

>  }

...

> +       if (sigma_delta->rdy_gpiod && !sigma_delta->irq_line)

Do you need the first check? (I haven't remember what gpiod_to_irq()
will return on NULL, though)

> +               sigma_delta->irq_line =3D gpiod_to_irq(sigma_delta->rdy_g=
piod);

...

> --- a/include/linux/iio/adc/ad_sigma_delta.h
> +++ b/include/linux/iio/adc/ad_sigma_delta.h
> @@ -96,6 +96,7 @@ struct ad_sigma_delta {
>         unsigned int            active_slots;
>         unsigned int            current_slot;
>         unsigned int            num_slots;
> +       struct gpio_desc        *rdy_gpiod;

Do you need a type forward declaration?

>         int             irq_line;
>         bool                    status_appended;


--=20
With Best Regards,
Andy Shevchenko

