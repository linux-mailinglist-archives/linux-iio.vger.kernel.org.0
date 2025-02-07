Return-Path: <linux-iio+bounces-15111-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A38A0A2C26D
	for <lists+linux-iio@lfdr.de>; Fri,  7 Feb 2025 13:17:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19B3416AA31
	for <lists+linux-iio@lfdr.de>; Fri,  7 Feb 2025 12:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70FF1F868F;
	Fri,  7 Feb 2025 12:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A48hSoYg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CFE1EEA31;
	Fri,  7 Feb 2025 12:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738930572; cv=none; b=kMZYcVrgU/74/hdpVjLEBulzQEcMAtG9B31KuK0801ityO7go0UJtV9iHqGtNJsZ/Lut/s3fNEkeeu6Qla9Q1pFmyKGp26/Xlt5wOKfSOQSa0IjJL6dpmj3UBwVDORFmEjij8/ochfSTmYvn4ZIANRqRFgQY0Jk+2VX+D9R49YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738930572; c=relaxed/simple;
	bh=JlB9XCGsIfAuQG6oPM8hPbAuSsvLUl++6wUNiU+N9BE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IA8ETHqF2cLnB3cNJhw15/m7C5b396R2HFqBCf6Lv6qEMurMq1hNO870bD2/EhrPYfl3K45cnHe9zqwm2biBQHKwE/wKD1GXPPBgnBs+CjJtJpLY0vhK8Sc/HhepmZIAOjyvSu7qi8Hx8+w7qXCkZeBp8NBk9+j0PstrUdCvBlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A48hSoYg; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aaec111762bso475783466b.2;
        Fri, 07 Feb 2025 04:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738930568; x=1739535368; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+t7YbbTGCWBeY8Yz9MUpE9tRyJq8TnnQgwbUuUnBgUU=;
        b=A48hSoYgzXXN9x81/xnUSvaStwMRwrr9K5euAbIZQM4CBr804Rg2PZfsb1YMiOItl/
         L5AWy/VyIhidq+dzVoWRSuMeAwmU0A9SDeGeU79YgSHAbNeUPE9sT0x8YoKBUcQux5VY
         uJhk1bCYZrnUv97wocSR5rtgbLQVAcm2O/yZ3sotQpEJ6q6Tkw1Nai2TkrrRrn0ONqC4
         ZwB7tKxigHa6wrC1Xec7+rtM4Usqzi3tq1F/fJbzkZV+QPLQFk+YmBZdvSeOxBAEqZSW
         iU6O5DHvmpe95HnyqG+/KNOUeqdeXC6Tlo3T0/ytSqYsuC4nu+kxxY5OvzzIhABqQ1T6
         vGlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738930568; x=1739535368;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+t7YbbTGCWBeY8Yz9MUpE9tRyJq8TnnQgwbUuUnBgUU=;
        b=G987gV2R+vfsjqGlBOTP+CpwDoYeR0x2oM04RGvhQ38kxruP6rrGA26tYe3tRn10hP
         z4s7l9ngNDcUaiaJmoz+LWuch5vilj6VFAF63xukQjFwaTDaoStt3UeLtTF5We/hmH6F
         B1q0sKVKzc1bv1btQmpZQZz+HIcuAtSZBEsxIkBYq7hdsZPUIJAb98UlvY2Hvbz1XClg
         8xv4dNmxXSgOxTp4cnn0JSKAbmq1OItsDbSgJDDkMAAfFCFOC9LntEDLBhmuff9fQH6R
         JNovipjWpHJejSyOin3rS9ofT8RwMoICk6Ceq/rllZOJa6C++qm69N3d5erH+zod100D
         /S0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUPx8CcMWkksKPfKWfQt34p2EfEWp3GOLaY06eIAQ4WrrnFH4jL+7kZ0bvMRl+nyWtBaQOD76P5RJRTheyh@vger.kernel.org, AJvYcCUSPaRvTFyZEOsxUk4c73H6Ux4WKDCOWPkZI47uzxbMFVcByuEt2Yje3KRoqK8fw8V3kdxMxjxcy71IwCk=@vger.kernel.org, AJvYcCWI/rWhXo+UIQMNSOaZfLDEDLqQFuSANfVK4CgDroi1XWt4YsHymQY5o4WNzOCIin7bv22OOWcUwYT2@vger.kernel.org, AJvYcCWkGVGVvpBDB6PavS6br6h5Qx1VIS8/qwKGbfpwUeDfs3wJBeAssvFU36LksLFoAd91Q6oX8pZMz487@vger.kernel.org, AJvYcCX/J7juq5YwrEicUYoa3l1U7TXva9QwUubTtu40xnALnShpj6A/TfhhjDHZSz2Oaf6HkX1kGsZI@vger.kernel.org, AJvYcCXXLNARs4EOu2t/0VI56s/NZ4bPDa423EmrIluPMSjE60fr73WmBxbbE/jxcOh9KtgtUDHB8wcuE7HO@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ11ZilniV3jtddr9boPbed+km7ZBkK0SSPefY5zLrhpjnTYQ6
	o+/JqN43EDW5JYN1dqrpoL3SKuSqRVAU7tGPCj3JkJLgPsf0RWditmq+RTtdnJz+IPRNJ360l+5
	m0zBFrUjnx93y8VvYo+akyPtw6wc=
X-Gm-Gg: ASbGncvpSfkUBNd1UX/yiLyJn1Z9graFDzxnBkDEq7gIcJD6dr/+HIYMtIvUp4YR+N9
	W8pR5jXr40hxEL8rny7o81+Svcsxqv/bNnrqH/j96MlSRJ4FVcocqNgwqzwAjfDHE14Edju/gPQ
	k=
X-Google-Smtp-Source: AGHT+IGY8znJApXKyzNb+yL9ibPgJG8qFDYxsiWeqr7W6flQ5pAjwP3vanOtbgv+SGqsPEwWi8YSAChgGT8YNAOWEow=
X-Received: by 2002:a17:907:c285:b0:aaf:ab71:67b6 with SMTP id
 a640c23a62f3a-ab789ba4ff8mr319772166b.31.1738930568122; Fri, 07 Feb 2025
 04:16:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250206-gpio-set-array-helper-v2-0-1c5f048f79c3@baylibre.com> <20250206-gpio-set-array-helper-v2-4-1c5f048f79c3@baylibre.com>
In-Reply-To: <20250206-gpio-set-array-helper-v2-4-1c5f048f79c3@baylibre.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 7 Feb 2025 14:15:32 +0200
X-Gm-Features: AWEUYZkm6IxNZqqUJoiO-KsN95M7hZUbEuaDl83yrJ0VJFqM30bkmEisJ4jKvJE
Message-ID: <CAHp75Vf+3pc84vV-900Ls64hM1M7Ji6Dmy8FPwL=n0=sJFSuVA@mail.gmail.com>
Subject: Re: [PATCH v2 04/13] bus: ts-nbus: use gpiod_multi_set_value_cansleep
To: David Lechner <dlechner@baylibre.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Andy Shevchenko <andy@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Peter Rosin <peda@axentia.se>, 
	Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-mmc@vger.kernel.org, netdev@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-sound@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 7, 2025 at 12:48=E2=80=AFAM David Lechner <dlechner@baylibre.co=
m> wrote:
>
> Reduce verbosity by using gpiod_multi_set_value_cansleep() instead of
> gpiod_set_array_value_cansleep().
>
> ts_nbus->data->ndescs is validated to be 8 during probe, so will have
> the same value as the hard-coded 8 that is removed by this change.

...

>  static void ts_nbus_reset_bus(struct ts_nbus *ts_nbus)

>         values[0] =3D 0;
> +       gpiod_multi_set_value_cansleep(ts_nbus->data, values);

...

>  static void ts_nbus_write_byte(struct ts_nbus *ts_nbus, u8 byte)
>  {
> -       struct gpio_descs *gpios =3D ts_nbus->data;
>         DECLARE_BITMAP(values, 8);
>
>         values[0] =3D byte;
>
> -       gpiod_set_array_value_cansleep(8, gpios->desc, gpios->info, value=
s);
> +       gpiod_multi_set_value_cansleep(ts_nbus->data, values);

As I said before, this is buggy code on BE64. Needs to be fixed.

>  }


--=20
With Best Regards,
Andy Shevchenko

