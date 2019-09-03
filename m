Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF745A71BF
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2019 19:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729945AbfICRfp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 Sep 2019 13:35:45 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44342 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729896AbfICRfp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 3 Sep 2019 13:35:45 -0400
Received: by mail-lf1-f67.google.com with SMTP id y4so6661713lfe.11;
        Tue, 03 Sep 2019 10:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=gr53IVc3JA5Sk/mGY8n9aToom0+MDmiEkX0rAFXg2Qs=;
        b=jThrnTI1adkHb2NnLZNGWoV5QmxQsAnWwmZ45pgUaNntyYwAsx4NHV9bZ91GtDbkgl
         PwzUyUtaL0F9z08NEkgdUBNgRGsHtfUWaqXPMxo0eknlSdxWR1HMq7m2wnN8A1022G3R
         G91UTEnJIWaUkZEGM4XhDN/5BsXP+9FTqgVszVlICNQEUWssprVkQmM+261I9eG4TzzA
         Vl4XjtFqorr8dRRkeKSxdJnMlMK4FYCVgkjK29B4rzyeHkWe3eRPPDe7/6/pGbc34lHh
         rzWzpV/XK3jEF8c5G2EeqHebqlfSRXprsrg3iuvCCo2WV9wS7RTye9LChKle5myUC4tQ
         EALw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=gr53IVc3JA5Sk/mGY8n9aToom0+MDmiEkX0rAFXg2Qs=;
        b=foysadCkI13U6laySrIqZDbKTw5zK/y/TAEEQUI6Lx/tALjVUtMCwUXYoEDavGf+7k
         JLTlnLS8nt09IAq8HptsDDTTb4dFN9Vi7roE8iMpW88uWbE31U9WpJcjnK5sHKeE0pzE
         ETcla9W4wnOcqlfJVIIe96A9MbcI7LllSEwV91PofaKC4ljUi5heB01IdtjhR2m6K1mF
         +HWCyN3NjQ8oYyvZNV/Gr7lzPdX2ZYP60ErWyPP47cVSdmRxvjsT8JjWzF7LsZEfLiTi
         UQ0lUkwiR4TB7FDaKsGkmdNLmz6yDGhU42+vYK4iGpOJA9tJ/Dc9VvJJGFK0yLJML2ZM
         /iIA==
X-Gm-Message-State: APjAAAVSxHYgRNy9cPq5yUFt3sozFQLb3J9p1jsashBGi4hLPU0n0z3r
        QA9beDRBs8EUA9wM6WS5xDHB0OvdWCg=
X-Google-Smtp-Source: APXvYqwH7bU30wEfiaQVJdZxvYV4akQH27Kz2AfD8aW5WKvwlXpbmNaN5HGo8SiOwgj4tGRHCYaLMQ==
X-Received: by 2002:ac2:4117:: with SMTP id b23mr6082542lfi.36.1567532142546;
        Tue, 03 Sep 2019 10:35:42 -0700 (PDT)
Received: from localhost (89-70-29-67.dynamic.chello.pl. [89.70.29.67])
        by smtp.gmail.com with ESMTPSA id q26sm2939275lfd.53.2019.09.03.10.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 10:35:41 -0700 (PDT)
Date:   Tue, 3 Sep 2019 19:35:10 +0200
From:   Tomasz Duszynski <tduszyns@gmail.com>
To:     Krzysztof Wilczynski <kw@linux.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: light: bh1750: Move static keyword to the front of
 declaration
Message-ID: <20190903173510.GA9674@arch>
References: <20190902113132.26658-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190902113132.26658-1-kw@linux.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Sep 02, 2019 at 01:31:32PM +0200, Krzysztof Wilczynski wrote:
> Move the static keyword to the front of declaration of
> bh1750_chip_info_tbl, and resolve the following compiler
> warning that can be seen when building with warnings
> enabled (W=3D1):

Looks okay.
Acked-by: Tomasz Duszynski <tduszyns@gmail.com>

>
> drivers/iio/light/bh1750.c:64:1: warning:
>   =E2=80=98static=E2=80=99 is not at beginning of declaration [-Wold-styl=
e-declaration]
>
> Signed-off-by: Krzysztof Wilczynski <kw@linux.com>
> ---
> Related: https://lore.kernel.org/r/20190827233017.GK9987@google.com
>
>  drivers/iio/light/bh1750.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/iio/light/bh1750.c b/drivers/iio/light/bh1750.c
> index 28347df78cff..460c0013f1a9 100644
> --- a/drivers/iio/light/bh1750.c
> +++ b/drivers/iio/light/bh1750.c
> @@ -42,7 +42,7 @@ struct bh1750_data {
>  	u16 mtreg;
>  };
>
> -struct bh1750_chip_info {
> +static const struct bh1750_chip_info {
>  	u16 mtreg_min;
>  	u16 mtreg_max;
>  	u16 mtreg_default;
> @@ -59,9 +59,7 @@ struct bh1750_chip_info {
>
>  	u16 int_time_low_mask;
>  	u16 int_time_high_mask;
> -}
> -
> -static const bh1750_chip_info_tbl[] =3D {
> +} bh1750_chip_info_tbl[] =3D {
>  	[BH1710] =3D { 140, 1022, 300, 400,  250000000, 2, 0x001F, 0x03E0 },
>  	[BH1721] =3D { 140, 1020, 300, 400,  250000000, 2, 0x0010, 0x03E0 },
>  	[BH1750] =3D { 31,  254,  69,  1740, 57500000,  1, 0x001F, 0x00E0 },
> --
> 2.22.1
>

