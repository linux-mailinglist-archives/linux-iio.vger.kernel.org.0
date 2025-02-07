Return-Path: <linux-iio+bounces-15129-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E9A4A2C951
	for <lists+linux-iio@lfdr.de>; Fri,  7 Feb 2025 17:53:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95C3818838A5
	for <lists+linux-iio@lfdr.de>; Fri,  7 Feb 2025 16:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB4C18FDAA;
	Fri,  7 Feb 2025 16:52:58 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF1E1802DD;
	Fri,  7 Feb 2025 16:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738947178; cv=none; b=QXnfzQ0KpoPjSJnBgsUq94RoiSf9TX6DbSZJFC5lz43qH5J/ioeqpiYL9h4x9InQi3xljpV/vuRlT0ZQQipkGyOwck+M9oZ+M0y1mKdZKvEYTnzhIQJmVz39VBX3WYp6h2RpnfUK9Xac4ufugksSFwJhZRca+oOcEtLtqyAGBZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738947178; c=relaxed/simple;
	bh=ecUYnd+W1q20dRwJBirTrue159dV174gldrH/T+f8q8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FW80jTR8fOjyriF2RNahW0mTXZ1918jzNSp5pstlpC4GsXWu0HJDo9gVeBP2MT6d1IUCpbH1uQlgyqgKic2vouVT1E3QCBZTX0aHBg6FOm4+2+SyjHXxR/XOzi6bJYUhKD/+IMAqa58aMiH9io4MwBNB0wDjV8JU4Z75GznJzLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6e4505134c4so177796d6.2;
        Fri, 07 Feb 2025 08:52:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738947175; x=1739551975;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yCWtJ2W7sBii9exDfBQy+ICa40xLBzxTz8+SCx213a0=;
        b=Wy15fqPSv7aRM94FdfxjEIG84zmvg6dlWvObC2B9CLj21Riik4X6QGAEK7eoycuDMR
         5rZEi98kySIzo1MxfoQPAyp4HilcUnBMGwDdMidt2p4W20xSVEhsVO/GSKyyz0vbbgdy
         P7pYWXChEZL9LZGzq8R8c3mqHeGRe0Rr/EZnQE3TfNCyE4/OtDl/6gOvsXLaSwLsIkzY
         7ugznnmdv4zd6dAL05SAPXcrHb5SbSlKAR+otQkzJFaJeitB/ohy2/9ZE/beuYXCFwa5
         lMvUuSkAOaO3PKsaQh3/JyUAB7dQr75/rjGsuB6Lrfn87IxkQfCPVdPvea6SVYa8pi/8
         YU+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUWWQi+Nt3hWV7BlgSmRKdA5ihhOkcQ2V5m/BmyFVefM/9j5HjmRvON8GXm+ObWPE1mbhVydiYL++3K@vger.kernel.org, AJvYcCVPw1W5PKKsi8StRutrfIjTgltrfbRVkZmocfqh1MRHJY+lSOrVvsNmA9AjNbolWGCGVWNtHgUlDHH04NsZ@vger.kernel.org, AJvYcCVRzXnpo66f1f13bG1m5wwz2fw2kBiHMBhw7n+FiZXQdCE0IakFTfBugx2Ounn57/Us9bWUJpcG@vger.kernel.org, AJvYcCVcABQK/mrRdRX8X9y+Zq5HpOx4Rp8zlv70PiZpkFHtjZFRZOaj1ZQ9wCP4jD6+Ht8m4TlnTt+w8I9r@vger.kernel.org, AJvYcCX2OQTk8DRd/RjcLzJppNQkxo95c3gn+bThu91uOH5oQipZ1xy2YX7y1S5geLIh/CthC27JdUmWsMD6EJw=@vger.kernel.org, AJvYcCXLraVlYdUXnuW0lfMKr2yCKV6goAXRnT+iahPcakpnHnwrgpoGiEBp+lxAIWRRm0IusHwxivyaQjGs@vger.kernel.org
X-Gm-Message-State: AOJu0YxRNXUw/z/9w3aKp4ZDFG8g3IOrqNa4Fp0Xk1KkQzaeRShc+dML
	H4Oq0Pi4CGytjl+U+kiYnFp2KrNLurFi3UWCLUisCI26Lc7bRqkah/IO1zgE
X-Gm-Gg: ASbGncsdRTeotgP5fqxpvRCsNglFnCJ3k/45gRLYwOY3rZwV1E738QKvYJ3kA/rrv5A
	VHxW8+y/9F7GxoJdqHpkNLCwHMjhKiUosvW0Uqmd91Z6z9eARYTAq4Tamfb5X/AqlNWIN7f6l+2
	CeHFcG6GLC2PeLscMGaS0blAK4k5gPjCRHLW2x+TQZBuphpUBguV0dlUMJXOQxjcUyN7AQmi0B5
	D1qEQmQQWm1pq5i9Y664EqVjhkHW5R5jnr3nRUyUVoARRcQ2TSq8Oh1VUpHr3XGR8Kw5vT+0Ffm
	wedrbKSFmTtPAjaPpft7Y9pLECKyMJn0A2baHL0PystoCPp7tw0Sx7g+HQ==
X-Google-Smtp-Source: AGHT+IEqUFn2zV6/n21PVporJf34N/K7KLRCeFQnThNT/iIp3ZAdi3X7YAiPcT3jQB4g+3VQPWB5gQ==
X-Received: by 2002:a05:6214:c26:b0:6d8:898a:a508 with SMTP id 6a1803df08f44-6e4456160d4mr55375976d6.16.1738947175314;
        Fri, 07 Feb 2025 08:52:55 -0800 (PST)
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com. [209.85.160.174])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e43d378e3esm16781956d6.4.2025.02.07.08.52.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Feb 2025 08:52:54 -0800 (PST)
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-46788c32a69so29884951cf.2;
        Fri, 07 Feb 2025 08:52:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUrEG4VTrvnRMnaHV9sxEboDQ7EMagqOP8xtP9E38sdQSTnI3zxHJ666KMLAjjlaoYxLPiBcX1CiHW+LRU=@vger.kernel.org, AJvYcCVGAsD0CnpIJyortGKZf9+Q2PEX/ioWQzDw68LBpdVX0dEYG69fZ8QvbYsFA7n54tCpp4LIpBoY@vger.kernel.org, AJvYcCWVOX9Rsr1JKDsWhfeGsB7QAjRVH8qp06/hPJpzKwjjMwLCMSbTdUhsRQTOsAosPs0eWRiF/HYWxdyJ@vger.kernel.org, AJvYcCXDSs4DUC+owKlhad1vSblWN8xxSsXasaoky3VLLaqKSMN3BaasGOKD9+YuF3zib+gzrjhC1qO7gJtx@vger.kernel.org, AJvYcCXUXgvNPr/y8QP9/H+7XBYFV7YgoVvyq/0QEw727FsUaaLuJoAt1kVkKfQxKTR8FNZyiodZEP8HOdPOuumE@vger.kernel.org, AJvYcCXjv5Kq4G0IhZs7hiYpUy4VixT3jvCwtZZCrNyOaW2YkbqTD/tQb4M7o6xacsc0vHh0idUwlrkkV4fx@vger.kernel.org
X-Received: by 2002:a05:6122:794:b0:518:859e:87ae with SMTP id
 71dfb90a1353d-51f2e1ed315mr3362597e0c.7.1738946694014; Fri, 07 Feb 2025
 08:44:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250206-gpio-set-array-helper-v2-0-1c5f048f79c3@baylibre.com>
 <20250206-gpio-set-array-helper-v2-1-1c5f048f79c3@baylibre.com>
 <CAMuHMdU5tt5_t2SfYO3OUsHenu_0PhpKeLHktNdCx-W6zCEymw@mail.gmail.com> <74ec33db-6721-4b86-86a6-e18b0a01fc47@baylibre.com>
In-Reply-To: <74ec33db-6721-4b86-86a6-e18b0a01fc47@baylibre.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 7 Feb 2025 17:44:41 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX0Kp_Rj5iQODW3omEYimE+taf+cgbEiHqWo3=fG3Am0Q@mail.gmail.com>
X-Gm-Features: AWEUYZn5qJOQHPLw2LRF15YUSzvjDVeuWxyBTUf7OD7UgB93Hq8YufkWPyHtZXA
Message-ID: <CAMuHMdX0Kp_Rj5iQODW3omEYimE+taf+cgbEiHqWo3=fG3Am0Q@mail.gmail.com>
Subject: Re: [PATCH v2 01/13] gpiolib: add gpiod_multi_set_value_cansleep()
To: David Lechner <dlechner@baylibre.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Peter Rosin <peda@axentia.se>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-mmc@vger.kernel.org, netdev@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-sound@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi David,

On Fri, 7 Feb 2025 at 17:29, David Lechner <dlechner@baylibre.com> wrote:
> On 2/7/25 3:10 AM, Geert Uytterhoeven wrote:
> > On Thu, 6 Feb 2025 at 23:48, David Lechner <dlechner@baylibre.com> wrote:
> >> Add a new gpiod_multi_set_value_cansleep() helper function with fewer
> >> parameters than gpiod_set_array_value_cansleep().
> >>
> >> Calling gpiod_set_array_value_cansleep() can get quite verbose. In many
> >> cases, the first arguments all come from the same struct gpio_descs, so
> >> having a separate function where we can just pass that cuts down on the
> >> boilerplate.
> >>
> >> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> >> Signed-off-by: David Lechner <dlechner@baylibre.com>
> >
> > Thanks for your patch!
> >
> >> --- a/include/linux/gpio/consumer.h
> >> +++ b/include/linux/gpio/consumer.h
> >> @@ -655,4 +655,11 @@ static inline void gpiod_unexport(struct gpio_desc *desc)
> >>
> >>  #endif /* CONFIG_GPIOLIB && CONFIG_GPIO_SYSFS */
> >>
> >> +static inline int gpiod_multi_set_value_cansleep(struct gpio_descs *descs,
> >> +                                                unsigned long *value_bitmap)
> >> +{
> >> +       return gpiod_set_array_value_cansleep(descs->ndescs, descs->desc,
> >> +                                             descs->info, value_bitmap);
> >
> > I am wondering whether this needs a check for !IS_ERR_OR_NULL(descs),
> > to handle the !CONFIG_GPIOLIB and gpiod_get_array_optional() cases?
>
> I don't think it is strictly needed, but could be convenient for future use
> cases. If we add it, should it be:
>
>         if (IS_ERR_OR_NULL(descs))
>                 return PTR_ERR(descs);

return PTR_ERR_OR_ZERO(descs);

(the compiler should optimize away checks common to IS_ERR_OR_NULL()
 and PTR_ERR_OR_ZERO()).

> or:
>
>         if (!descs)
>                 return -EINVAL;
>
>         if (IS_ERR(descs))
>                 return PTR_ERR(descs);
>
> ?

The former.

> For comparison, gpiod_set_array_value_cansleep() will return -EINVAL if the
> first argument is NULL.

That function cannot take an argument returned by a *_optional() call,
if I'm not mistaken.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

