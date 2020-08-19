Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B372F2497FD
	for <lists+linux-iio@lfdr.de>; Wed, 19 Aug 2020 10:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbgHSILE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 19 Aug 2020 04:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgHSILB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 19 Aug 2020 04:11:01 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B10E6C061389;
        Wed, 19 Aug 2020 01:11:01 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id 17so11281971pfw.9;
        Wed, 19 Aug 2020 01:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6eW4MwS4/ZcmscmxUur+7e24yfagUuECZt51JTFEZE4=;
        b=D/MN65gncpOrLHlDCcfAkW0iADTVpM/7zFielzmSOIAWfNHE+RrvFCgMEJrxaoSZBA
         o8kyMYhQwHRruVsVwkUNBsPIfSUQC1/Sw88nF/z2BWnH/z/gYLAru7h1dM3/JnClzf6A
         /o0gLjVtfHVaJjJQ1JqbD2hMDy2pK6Hij+FZqBNntOp3m33xxlurA1WsPDfKmxX+ZPai
         ho0CxHuDw3zWFrAukkTqBLoqdi6eK9MaRC6FOZYfXCHHNyW8wUGXf2IWt2RVgwQMF+PK
         +vMJzIMbRwJIGMAMQdqN1IF218r6XV2SunTk1xq+RDLcQ3hU1xyUlyh07AyWleZFHbTF
         Vr5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6eW4MwS4/ZcmscmxUur+7e24yfagUuECZt51JTFEZE4=;
        b=r0A8Uzp3Vky0sX4eV3sajObcHITRpcNI3jARNuJ4nVzi3C0jUq2dkmEPBqs6CCoo/w
         nfskknoDzGRiW4lRKu8xe2RlMOCrdwcWzw5mPfIThl+7ndCHGeZXc3Y3fqzMNVybiu1k
         8+bA9GfMX0NZljFtiSH/7TOsDh3aLBIxW5J2nAdUP1mlSrAbECNKPsdxxwWPCKsHiO/+
         mE7fjm2WHyZJ/A2qtImd+a2HUFIXp23ntD9W8a2xs5r7N8AXriyrlV5IZ9jsa7+W2He2
         ejmrk6VYYIgeJmRhF23AqXqHXPCxQS1fJ8HtlHra0gN5rD2eTc7slK5vNmOJX2wZHQzn
         njqw==
X-Gm-Message-State: AOAM530rcBocTDT0JDj562F5UHck3HHG2tKi0fi3T/qOMYWZQJI+a2xm
        e0E5hrurUTGgptiwKJhLctnxzdyZZjgdxNOVtRY=
X-Google-Smtp-Source: ABdhPJxfw9u8DV2Jegy85AeZ/eMFQYKwKGg0Vd29sLVV0cQA1YXNxbF9Z7KHZb3HqFVyWPkPBPT5zkenOHt4cwBsU8E=
X-Received: by 2002:a63:f24a:: with SMTP id d10mr15901942pgk.4.1597824660723;
 Wed, 19 Aug 2020 01:11:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200818213737.140613-1-cmo@melexis.com> <20200818213737.140613-6-cmo@melexis.com>
In-Reply-To: <20200818213737.140613-6-cmo@melexis.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 19 Aug 2020 11:10:44 +0300
Message-ID: <CAHp75VfYCR3Xkm=70_kY+Fp1xmCj_UvHNLB5h2Zs8myf2A8a=A@mail.gmail.com>
Subject: Re: [PATCH v6 5/5] iio:temperature:mlx90632: Some stylefixing leftovers
To:     Crt Mori <cmo@melexis.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Aug 19, 2020 at 12:38 AM Crt Mori <cmo@melexis.com> wrote:
>
> There is some inconsistency and whitespace cleanup performed in this
> patch. It was done on top of my other patches, but I can rebase to head
> of the togreg branch if it would go in sooner.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Crt Mori <cmo@melexis.com>
> ---
>  drivers/iio/temperature/mlx90632.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/iio/temperature/mlx90632.c b/drivers/iio/temperature/mlx90632.c
> index 94bca2b2866a..472a7fb20615 100644
> --- a/drivers/iio/temperature/mlx90632.c
> +++ b/drivers/iio/temperature/mlx90632.c
> @@ -112,10 +112,10 @@
>  #define MLX90632_DSP_VERSION   5 /* DSP version */
>  #define MLX90632_DSP_MASK      GENMASK(7, 0) /* DSP version in EE_VERSION */
>  #define MLX90632_RESET_CMD     0x0006 /* Reset sensor (address or global) */
> -#define MLX90632_REF_12                12LL /**< ResCtrlRef value of Ch 1 or Ch 2 */
> -#define MLX90632_REF_3         12LL /**< ResCtrlRef value of Channel 3 */
> -#define MLX90632_MAX_MEAS_NUM  31 /**< Maximum measurements in list */
> -#define MLX90632_SLEEP_DELAY_MS 3000 /**< Autosleep delay */
> +#define MLX90632_REF_12        12LL /* ResCtrlRef value of Ch 1 or Ch 2 */
> +#define MLX90632_REF_3         12LL /* ResCtrlRef value of Channel 3 */
> +#define MLX90632_MAX_MEAS_NUM  31 /* Maximum measurements in list */
> +#define MLX90632_SLEEP_DELAY_MS 3000 /* Autosleep delay */
>  #define MLX90632_EXTENDED_LIMIT 27000 /* Extended mode raw value limit */
>
>  /**
> @@ -889,7 +889,7 @@ static int mlx90632_probe(struct i2c_client *client,
>                 mlx90632->mtyp = MLX90632_MTYP_EXTENDED;
>         } else if ((read & MLX90632_DSP_MASK) == MLX90632_DSP_VERSION) {
>                 dev_dbg(&client->dev,
> -                       "Detected Unknown EEPROM calibration %x\n", read);
> +                       "Detected Unknown EEPROM calibration %x\n", read);
>         } else {
>                 dev_err(&client->dev,
>                         "Wrong DSP version %x (expected %x)\n",
> --
> 2.25.1
>


--
With Best Regards,
Andy Shevchenko
