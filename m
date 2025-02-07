Return-Path: <linux-iio+bounces-15107-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3FB4A2BF09
	for <lists+linux-iio@lfdr.de>; Fri,  7 Feb 2025 10:17:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DE7216A75B
	for <lists+linux-iio@lfdr.de>; Fri,  7 Feb 2025 09:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24061DDA34;
	Fri,  7 Feb 2025 09:17:20 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7621D5AD8;
	Fri,  7 Feb 2025 09:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738919840; cv=none; b=C6gAQLfzR8sVOnmNE9ynzbRVuEoohS6IGxjpUdx+WlnKs1PvVaJTZoWWH/VVc2rF224k1gS5naHO3kB2mq/B6NEnrj4MjSVKuJgTH3o94MEkzAn1EymUboS7aK9ry1tb43gS9WocBfid47RQdZa/beGeoljCEnVW2mgm1U5J5x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738919840; c=relaxed/simple;
	bh=gZaXz7XL6hd/UGWpNon4f9PYF3b0mzV4TxHZOcz4Sak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QZ3plTTDndS84yz4CkwbScFetHCdaKSff+AsZXIPJuQyQIYxO1zrkfenOELMSEe5oSyLYdVk5tLnaqqX9wz10xjtUKhrYeoeShFXxvhl0TCPcehBc0KuB5HQGeYt/nztfgC2bkSDLzHJNH2ERbkyuA2/W4eDkPB8zMxcwC1ZTKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3ce873818a3so15935775ab.1;
        Fri, 07 Feb 2025 01:17:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738919837; x=1739524637;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o4kJhOPtCECyINUZkXDqpO81cp9u410vUEkFnMeAGRE=;
        b=psVmUxRbc7tPvjHIlZY9iE1kQfF2KVBfNj1bHv+Dw5tbAlmHLIPUpXEwJjoYdxllNG
         mhQU/KiKPAzqtPmVhHjUDWcEIxVMlE0Yp3qnNyGTE92DrnzlT4/3jWCN4PtSTWQaWmG1
         7uuGsr3ZHJfL3d8livOkBfu8KxH8VqxxfTJqkLxQOTaNI4wnSrIk7QVVxFnNFUZdmIwI
         RQdoaoGgMPlZqERuQgJRjwWpbOeyKJYUha+uKUJzpRUIPygCJLKPoe2TD8TquRGoS2ZS
         n69qg9p4NY0uz8aekY83rPacoBlI+kfq5ekbKgFJhJndH08WzILBi3JvRwi+EtY+wHmu
         TTvQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7aV51ddKRCrXKtzObRnPgOlCuoWEPKfzLw12VWkuXUP3Z0o5Zm3VVn6ymOLB/vuiIUVjMELGcavsL@vger.kernel.org, AJvYcCVtjtVaaFLkRoQPdcGaoloBn2RbxGtgKYfNMzQDxFn026UwUhXZ3oXBoCrJCwdjw3ut2Hsp7N4WxWrMRKrt@vger.kernel.org, AJvYcCVwHuRta5+BpcmmbUyqmnIYLF4BlcfLEYR/jQJIfYKuTqnyD+Nlbvwg1kiqqZTYmySx3W5LrW4XJa3Y@vger.kernel.org, AJvYcCX+vy/T2iO+hOeWf3pSYXepiPluQ4x1zp2Sj1tGhPJy1KhJplXrWeASZNgH6cAVieg1vwIeqicS7Lfz@vger.kernel.org, AJvYcCXdTZAW8YRE7pv9dsNbSqyf22zW/F/RN460WObUCULaAeF2oWP673EkDB95EclwPLpXh0na/SGcVKniil4=@vger.kernel.org, AJvYcCXwxOj8zyWmWutsyWjU5VgFrekoEgFVA7nPQU4I3ZOY0Zs3tLIE+Z54cV1ccHv7RzMd13GESPF/@vger.kernel.org
X-Gm-Message-State: AOJu0YwE5ubkR5bOmMhuK4aEcs0gxBnNnkFpEL8Obb2ukt0OcSJuX/Q6
	whpiZcshV1uZy3ezOSrLrODGqOcHntfBnj/15q/ldBU+kcmEE3/dgxcPexBC
X-Gm-Gg: ASbGnct6GMwQzXLSjcBjT3RR2fW1DaZxkCSajpGuDAbIcGKwOwDsoihfs4KPmXmMlF6
	dywMSH2WcNqHJYP/c/FlWVdU1oeiutdBRgmC5Wr6F8kWCC+2FKwxVS5blKk7Km0YLFDUZXtNXTG
	1EqyoBsZeTBAqjzgBwj1/GbAn1ntQpxDYJ5GX8upGdC+PaOC+sM8+F5SguwtQwp+ep2D+Q7/VSR
	Kt516lK2DhsuU1G7MXxpfkTjdfDSJmC6ob3fpwpTU0QRC06R/dMigB322zl9jhFYDPiPhwIf5s9
	AnrIJGpDV6oay9GKvKyNI1zXby5icsijzjhM8X3i08imWdmWWIo3qg==
X-Google-Smtp-Source: AGHT+IG043XEt5V/lr+jQskxWxCFLSi7BiNG4a20ljNVDAJMmu20cN9bDvLVgzdiBOpI7glFiTGhAA==
X-Received: by 2002:a05:6e02:160d:b0:3d0:618c:1b17 with SMTP id e9e14a558f8ab-3d13dd38108mr20902755ab.7.1738919837393;
        Fri, 07 Feb 2025 01:17:17 -0800 (PST)
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com. [209.85.166.53])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4eccfacfee0sm673185173.82.2025.02.07.01.17.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Feb 2025 01:17:16 -0800 (PST)
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-844e9b8b0b9so143334439f.0;
        Fri, 07 Feb 2025 01:17:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUEIPycsT2k50iQZgTDK8nsrVcE5vEIWJ2pL81Gp5Kghr9N/cSIPopfbQXUbqSqFxXk09irH9SST5v5@vger.kernel.org, AJvYcCUGjMfKX6bUWXjrzz8lMsj2LZZvsoqowBjF5bOSTDhppNIiw56OdEGNoDGQ8n00g/EloPUy1O0/7f3FabGu@vger.kernel.org, AJvYcCUUM/0e52LemMCo1O20BgFnDAn5IFEb6ot2DY8JxmnHHypZQk+MaA35gaPEGlZHnFfnmvaEgt8F3LSt@vger.kernel.org, AJvYcCUy8XA7RemWYcsi0p6GovRiCNH4UoRAZtgQR46Dprpcnv5ySWnewZml++KbhroXXiaE7XwqJ9ij@vger.kernel.org, AJvYcCW/SY1G7CH3gKqRSLlrWlK4UYw0QHETlMKBrP4ZjVmOLe7K1drfonFbQPcr477IYKHjVBHiQ1hjKOXh/Dg=@vger.kernel.org, AJvYcCWNUFvyaRae7OB0+yS/NL3qf2aZYIRftmwqPZBiCwoGKMXv3aRtDhS7fjSVtHvlgpeq0gwqKf8dFVVb@vger.kernel.org
X-Received: by 2002:a05:6102:41a0:b0:4b2:5d63:ff72 with SMTP id
 ada2fe7eead31-4ba85e7d7e5mr1354232137.13.1738919445022; Fri, 07 Feb 2025
 01:10:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250206-gpio-set-array-helper-v2-0-1c5f048f79c3@baylibre.com> <20250206-gpio-set-array-helper-v2-1-1c5f048f79c3@baylibre.com>
In-Reply-To: <20250206-gpio-set-array-helper-v2-1-1c5f048f79c3@baylibre.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 7 Feb 2025 10:10:33 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU5tt5_t2SfYO3OUsHenu_0PhpKeLHktNdCx-W6zCEymw@mail.gmail.com>
X-Gm-Features: AWEUYZmj9DYQSOmgGzGXyOkOE57CQ_wkxVouudAJc-ubVAUCMSn97Ipr2XIc-m4
Message-ID: <CAMuHMdU5tt5_t2SfYO3OUsHenu_0PhpKeLHktNdCx-W6zCEymw@mail.gmail.com>
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

On Thu, 6 Feb 2025 at 23:48, David Lechner <dlechner@baylibre.com> wrote:
> Add a new gpiod_multi_set_value_cansleep() helper function with fewer
> parameters than gpiod_set_array_value_cansleep().
>
> Calling gpiod_set_array_value_cansleep() can get quite verbose. In many
> cases, the first arguments all come from the same struct gpio_descs, so
> having a separate function where we can just pass that cuts down on the
> boilerplate.
>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: David Lechner <dlechner@baylibre.com>

Thanks for your patch!

> --- a/include/linux/gpio/consumer.h
> +++ b/include/linux/gpio/consumer.h
> @@ -655,4 +655,11 @@ static inline void gpiod_unexport(struct gpio_desc *desc)
>
>  #endif /* CONFIG_GPIOLIB && CONFIG_GPIO_SYSFS */
>
> +static inline int gpiod_multi_set_value_cansleep(struct gpio_descs *descs,
> +                                                unsigned long *value_bitmap)
> +{
> +       return gpiod_set_array_value_cansleep(descs->ndescs, descs->desc,
> +                                             descs->info, value_bitmap);

I am wondering whether this needs a check for !IS_ERR_OR_NULL(descs),
to handle the !CONFIG_GPIOLIB and gpiod_get_array_optional() cases?

Slightly related: shouldn't gpiod_put_array() (both the implementation
and the !CONFIG_GPIOLIB dummy) allow the caller to pass NULL, to
streamline the gpiod_get_array_optional() case?

> +}
> +
>  #endif

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

