Return-Path: <linux-iio+bounces-14925-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07255A25BA9
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 15:02:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E335318834E1
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 14:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521062080DD;
	Mon,  3 Feb 2025 13:59:55 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C10207657;
	Mon,  3 Feb 2025 13:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738591195; cv=none; b=Kj17U+yz09k+61xVkK/SGSRNwYvaeyRxN3/03jvKck7wTAWkx53zz6zTeWtE2P/d5/it7n86YZnCGUSFoXMZvCgzy8xLszpHtpTVZdn/UsOubvFXNu42mXZ3NNZJWcxh8ygeJYnl96zAL9m1x35AT4oXC4pzP/mZgjMqX3pzSpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738591195; c=relaxed/simple;
	bh=qCz9jE3C8/DH/rIVWt5Lk605SNimvvlqaYiePQLwTYI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HcUxfy/1A2rPjECDqAHZxymKB3sQFB/6mi5CeaxZXWcRnP4x2iQ9tHk9DtHdhJT2LxuZ/mJjmQn72CSqtrMRJMoEBNZQvjit2uJw2BVjpKFdcJXPBXRlh/hYCsZbOJazncobKpdNqQL8s314lPgZlZa0dcytECsBezxCnenlyPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-85bafa89d73so853284241.2;
        Mon, 03 Feb 2025 05:59:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738591189; x=1739195989;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2e3vrd26snuR7BBCNgEi1ltS7NqcxsA/B6t8vBEFYDs=;
        b=RrSJ7HsTNrk2Y2+yINGbXd4woA4DPGMh7QRuj8mqrP20+ajPA8e6MpvQ7GxX/KQ3zh
         WvKluSGDbFyX1GRu3zEvOWoTt5J+cqjTuVAOtzrtqOQ1dcrOImOpHyLvXXsMqmpyatG2
         JUHtA3ay3zt0XIZrOF2d7zmfrF2ZYkxGSHgqLGi6vMaY3aMLstwIgqbWKQtAi0fNErn/
         DqpHUZqbvE07OfKX8pt74juxHJpE+6fW4/JJekrfNQDUZ2j9UY7TMj3fq+RtsRMqf0pC
         lXLfz/7gsOHlW+rY8VqmqzlAH+JJDeOawa4+EFdHfW4CpYaQmN10RMhhzEo1gIIeORGx
         fWtg==
X-Forwarded-Encrypted: i=1; AJvYcCUWu+DXUSSrRSa6+Hqtyo0y7nhY9UMm+6sG8XD/SEtGpKvCkxmG3kNkihjvYll8I4AwaATkArzmwe4goKqJ@vger.kernel.org, AJvYcCVEd+Pu9L0qWO1CkiA/SkZFwJOSpAQyGJzTt9NMtCmnCwXlbw4aD2Uxet8jHhSqqAeA2g52PLKq6B7srA==@vger.kernel.org, AJvYcCWEF4jRaDt7yz/ySGq2fodwVJ1qVvYz5/5WLmCMF/jAWIvuAsjV8vXMwVu33BykDTYMYUSG4O/v4P/1vhspOUgnbBI=@vger.kernel.org, AJvYcCWS42oxkz0pAYv24KgpTgR1mGtCp73L/CHZK7cW+8Hxgst7H5OXOdQ1u0eQvy8dz2lQtw7Cy8m1jgzEon+F@vger.kernel.org, AJvYcCWcQPp3/rzV0d/CGHy45eKjYcXOy/SP1C7snfUMKpoq6hEzfgY93E00S1hhfF2tYHk6TtY0wOIPsKBP@vger.kernel.org, AJvYcCWzCNd+9B/jsBjcPuvZMlBwWO0kWihwtG5xjI7tfYabDEh1Zu/V5zndlJeeUQOmUHng2yUBQy3hlQ8=@vger.kernel.org, AJvYcCX+rPQS2WZZQL0AXZwX0qju9nL7sJIJlZ5VjyJ6/7CVjoX257PrBK7pOrv5XxE2KJod2j31K45JSeRnpd8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNpOoVfu8Xag1CBkLrD1k5OseCYAjIwWamxeChMx3eFdpI7fmA
	Clko2tcXB2YwPNm/fteWLtm0ZEWOSy46UW3sAAZ96kGNRniQ7cJ89OP0NIcQ
X-Gm-Gg: ASbGnctF+3pp8eA7vXgQ3Nci835IRu3PFHGKOqLIqfZ7mDUu4pb5jCzT6a/Xzdke86k
	sx8hzFRttc15blaZb7sKmb9/Hc1fHwGM8iOw1IfAHUrsQ6AlV0DxOFpUyWRPd20j+WhEp4NhvE+
	8oUL5QhV2Y+gStZAhfl/50qvSOXmGoP5PzjR9pE+ad8EuIRYz2pAlkMSBQ1lrmi16kRCVo80J3v
	7e3UL7CoFH8YLpMsaRC2VxhSyVLGkigcGod4np9xiWLHOI6o2wB+D9u/T1B//JGQtPAcJH0xfB/
	38/TrX/YX3w4fl6LArH1R577K13XRjnfVH8rOld3vIn0isr6o3SDVe7NbA==
X-Google-Smtp-Source: AGHT+IHMxI/2v0SfcLwteoxT8STy991q5j8vL75bqZcV4zbtOIYaHRNiw16arLwHeEOR+aNooAZEMQ==
X-Received: by 2002:a05:6102:330b:b0:4b6:d600:a35f with SMTP id ada2fe7eead31-4b9a4eb3fe8mr14586189137.4.1738591189660;
        Mon, 03 Feb 2025 05:59:49 -0800 (PST)
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com. [209.85.221.182])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-866941da3fdsm1549787241.25.2025.02.03.05.59.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Feb 2025 05:59:49 -0800 (PST)
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-518ae5060d4so1388081e0c.0;
        Mon, 03 Feb 2025 05:59:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUCSxPdtewQcOQ0VqH6KbxR4AJHf9AWvwOdRbLTbvQjRiAZ4FpuZD5vIUmLA1S5L+pEJdteSv/vOmkN@vger.kernel.org, AJvYcCUHuzVuJTMpt0LQKeVDHJ1VtblVA/jQAqbWjUWIRKIAuAyMlzBNOZ/n6K0qxfK3H0yghOkGUzfpxLj+nA==@vger.kernel.org, AJvYcCUZWFTVihvApMJKLl3n2E9mazFs5hQcdPJnyLYEnO0kTePafT0VDFcesNs+EowedR+CcfkxEFzF4dg=@vger.kernel.org, AJvYcCUl+wcql7GU+jy8A7Dvt2aY/XyP/TwLPAXwO9xOPEQ/OFOMj8i3HBHDoMKuZDAnPGp2HKUaKVISae34fkFw@vger.kernel.org, AJvYcCV/NESNNuh7EgpaWW3U7NQXZ8TenqvtEB3nzQdJP0gppFbLr7BKmXebhvwfM1xasbU1m7lxPWX5uxaf4K+y@vger.kernel.org, AJvYcCWC0XUNHF1VlrFHkUNsacVF3cs7Ach9FCtZrUL+/sL865CKb7gH5rsQRDTFY2MrD+KjCMJAulaNj4aUiVM=@vger.kernel.org, AJvYcCWWdCymXHv2toYAg5XNDIfLqTNh8zJ8w2ClBk1asRJsOYRuIbavqezhrOlfMYhCYUSWlReR4F0bs1YGMfCqAGy3SHI=@vger.kernel.org
X-Received: by 2002:a05:6122:1990:b0:51c:aa1a:2b5b with SMTP id
 71dfb90a1353d-51e9e3fdc44mr15881808e0c.4.1738591188554; Mon, 03 Feb 2025
 05:59:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1738329458.git.geert+renesas@glider.be> <1824412519cb8791ab428065116927ee7b77cf35.1738329459.git.geert+renesas@glider.be>
 <e20a177a-30cd-4088-89e1-b479aba1356c@wanadoo.fr> <Z5-xMUqrDuaE8Eo_@thinkpad>
 <74cab7d1ec31e7531cdda0f1eb47acdebd5c8d3f.camel@sipsolutions.net> <45920591-e1d6-4337-a906-35bb5319836c@wanadoo.fr>
In-Reply-To: <45920591-e1d6-4337-a906-35bb5319836c@wanadoo.fr>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 3 Feb 2025 14:59:36 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXZKNtAmiMP8uuSngZMsDLGcYwrLS0xNWzN4UfLaccdyA@mail.gmail.com>
X-Gm-Features: AWEUYZkxzrXQCnvoDXR55r9qIi7LTjZDYDZYK_OEJibEwCDu5alOHeJTYjGkvIg
Message-ID: <CAMuHMdXZKNtAmiMP8uuSngZMsDLGcYwrLS0xNWzN4UfLaccdyA@mail.gmail.com>
Subject: Re: [PATCH treewide v2 1/3] bitfield: Add non-constant
 field_{prep,get}() helpers
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: Johannes Berg <johannes@sipsolutions.net>, Yury Norov <yury.norov@gmail.com>, 
	linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-renesas-soc@vger.kernel.org, linux-crypto@vger.kernel.org, 
	qat-linux@intel.com, linux-gpio@vger.kernel.org, 
	linux-aspeed@lists.ozlabs.org, linux-iio@vger.kernel.org, 
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S . Miller" <davem@davemloft.net>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, Crt Mori <cmo@melexis.com>, 
	Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Jacky Huang <ychuang3@nuvoton.com>, 
	Shan-Chun Hung <schung@nuvoton.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Jakub Kicinski <kuba@kernel.org>, 
	Alex Elder <elder@ieee.org>
Content-Type: text/plain; charset="UTF-8"

Hi Vincent,

On Mon, 3 Feb 2025 at 14:37, Vincent Mailhol <mailhol.vincent@wanadoo.fr> wrote:
> On 03/02/2025 at 16:44, Johannes Berg wrote:
> > On Sun, 2025-02-02 at 12:53 -0500, Yury Norov wrote:
> >>> Instead of creating another variant for
> >>> non-constant bitfields, wouldn't it be better to make the existing macro
> >>> accept both?
> >>
> >> Yes, it would definitely be better IMO.
> >
> > On the flip side, there have been discussions in the past (though I
> > think not all, if any, on the list(s)) about the argument order. Since
> > the value is typically not a constant, requiring the mask to be a
> > constant has ensured that the argument order isn't as easily mixed up as
> > otherwise.
>
> If this is a concern, then it can be checked with:
>
>   BUILD_BUG_ON_MSG(!__builtin_constant_p(_mask) &&
>                    __builtin_constant_p(_val),
>                    _pfx "mask is not constant");
>
> It means that we forbid FIELD_PREP(non_const_mask, const_val) but allow
> any other combination.

Even that case looks valid to me. Actually there is already such a user
in drivers/iio/temperature/mlx90614.c:

    ret |= field_prep(chip_info->fir_config_mask, MLX90614_CONST_FIR);

So if you want enhanced safety, having both the safer/const upper-case
variants and the less-safe/non-const lower-case variants makes sense.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

