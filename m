Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9303F253473
	for <lists+linux-iio@lfdr.de>; Wed, 26 Aug 2020 18:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgHZQL5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 26 Aug 2020 12:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbgHZQLy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 26 Aug 2020 12:11:54 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2311C061574;
        Wed, 26 Aug 2020 09:11:54 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id v15so1265823pgh.6;
        Wed, 26 Aug 2020 09:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zsYZAfrXc5MeghLrjOcFJHSLrkET4/mbfNye+K52LEs=;
        b=ho7pR70PLK4pWYXy56s39sAMeCR8VnI49sdZXzQ8nM145F9YoyZCf+uIe4M7qlpvJa
         NIDtYdTEbfiYOokGLfTUUGCHInjvrvca2fkwJYF0Mc2W5znA22QhIGnrwD711e7JwPM3
         zq9kCdg8hFwUJYU7fsabfNPmM+wyehG6U8XzBauc/sjzJEvvpKotkH2/SogxM8Za7wfw
         XHQHt9RX2aX4jmmTA4O8KnIgjcMe96wG7JVinvUglxQB70njCjyEGO2T2QjBvWzAhSDr
         QzNoalb7+BDUOIyFY+s0dXR+C8Cd5vGJiYX5RHV6mq2d8Obtzx4HPfkCK/x1FZl4KjtJ
         ps1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zsYZAfrXc5MeghLrjOcFJHSLrkET4/mbfNye+K52LEs=;
        b=hoWbYw+ckaKdnPDM1ZldxmpbBMNWLVJeNHMsIaIZ8SlHwHynrOKYSrEYp2WrXW1NX/
         DFBRW1CLBBeXV8IqybrzPS+mdKDElKx991gj1MPFKX3mF75hS8qJS8QP9UVyvYeJ0Mva
         pvz3cSszpmd+a3D81GHHfRQusQk9FmvPaZEsNV/Q+Fhd4ZmR3oWAVdg16+zzsmY6L2sC
         OPmnbHABl9a1awbpOdaM3dddx/b0GVOjsGUUwnpV7ZbOIY3R4Q//p4s5wzj2wFGzv0AO
         Bre00yX0FmJGhkhtuFIdHZNFsNmiGRFwy5IiquFiB6qGODu2JSlc8NCud5yJ3y+VX7cQ
         Ogxw==
X-Gm-Message-State: AOAM5316rYKB8yhgEvdoclIokmaxX9Ct7CY9IflSq3vc9I5mnYflBecm
        ELS2eJ0qOQy7F9bQnedmRwy4MevkF6vang+kHFA=
X-Google-Smtp-Source: ABdhPJwvViCX/Q+1MORK3UVIYSoHDtdr3LFoUGJtmYBqlAFBcaoxy1m1GJQ3IlE/k8EJxz54maZnY3EoQb5939behlA=
X-Received: by 2002:a63:ec18:: with SMTP id j24mr10754089pgh.74.1598458313621;
 Wed, 26 Aug 2020 09:11:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200826095247.16368-1-ceggers@arri.de>
In-Reply-To: <20200826095247.16368-1-ceggers@arri.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 26 Aug 2020 19:11:37 +0300
Message-ID: <CAHp75VfBMXPyH80d0hrUqohC4wvgBNSSNp4N86JcfiWSfWHs+w@mail.gmail.com>
Subject: Re: [PATCH] iio: light: as73211: Fix AS73211_CREG1_GAIN_1
To:     Christian Eggers <ceggers@arri.de>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Aug 26, 2020 at 12:55 PM Christian Eggers <ceggers@arri.de> wrote:
>
> Wrong value was introduced during review process.

Ooops, long reviews have their outcomes...

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Christian Eggers <ceggers@arri.de>
> ---
> Patch against jic23/iio.git, branch testing
>
>  drivers/iio/light/as73211.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/iio/light/as73211.c b/drivers/iio/light/as73211.c
> index 3383aaacbf52..e76747b99b92 100644
> --- a/drivers/iio/light/as73211.c
> +++ b/drivers/iio/light/as73211.c
> @@ -56,7 +56,7 @@
>  #define AS73211_AGEN_MUT(x)       FIELD_PREP(AS73211_AGEN_MUT_MASK, (x))
>
>  #define AS73211_CREG1_GAIN_MASK   GENMASK(7, 4)
> -#define AS73211_CREG1_GAIN_1      13
> +#define AS73211_CREG1_GAIN_1      11
>  #define AS73211_CREG1_TIME_MASK   GENMASK(3, 0)
>
>  #define AS73211_CREG3_CCLK_MASK   GENMASK(1, 0)
> @@ -217,7 +217,7 @@ static void as73211_integration_time_calc_avail(struct as73211_data *data)
>
>  static unsigned int as73211_gain(struct as73211_data *data)
>  {
> -       /* gain can be calculated from CREG1 as 2^(13 - CREG1_GAIN) */
> +       /* gain can be calculated from CREG1 as 2^(11 - CREG1_GAIN) */
>         return BIT(AS73211_CREG1_GAIN_1 - FIELD_GET(AS73211_CREG1_GAIN_MASK, data->creg1));
>  }
>
> @@ -473,7 +473,7 @@ static int _as73211_write_raw(struct iio_dev *indio_dev,
>                 if (val < 0 || !is_power_of_2(val) || val2)
>                         return -EINVAL;
>
> -               /* gain can be calculated from CREG1 as 2^(13 - CREG1_GAIN) */
> +               /* gain can be calculated from CREG1 as 2^(11 - CREG1_GAIN) */
>                 reg_bits = AS73211_CREG1_GAIN_1 - ilog2(val);
>                 if (!FIELD_FIT(AS73211_CREG1_GAIN_MASK, reg_bits))
>                         return -EINVAL;
> --
> Christian Eggers
> Embedded software developer
>
> Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
> Sitz: Muenchen - Registergericht: Amtsgericht Muenchen - Handelsregisternummer: HRA 57918
> Persoenlich haftender Gesellschafter: Arnold & Richter Cine Technik GmbH
> Sitz: Muenchen - Registergericht: Amtsgericht Muenchen - Handelsregisternummer: HRB 54477
> Geschaeftsfuehrer: Dr. Michael Neuhaeuser; Stephan Schenk; Walter Trauninger; Markus Zeiler
>


-- 
With Best Regards,
Andy Shevchenko
