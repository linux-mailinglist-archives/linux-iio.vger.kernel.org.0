Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FFB042885A
	for <lists+linux-iio@lfdr.de>; Mon, 11 Oct 2021 10:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234762AbhJKILn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 11 Oct 2021 04:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbhJKILl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 11 Oct 2021 04:11:41 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4538EC061570;
        Mon, 11 Oct 2021 01:09:42 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id v20so3675860plo.7;
        Mon, 11 Oct 2021 01:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=p+EWDMXRHCR4WGXjxAd95fZ6s4jh2V1mf44zmXuKSp4=;
        b=RhcpOsyLfoDKcvvB9HTR++Zz7bBBpHZ1qCWaxNK5+JMGPyrKofBhMpNa5sty37CXY2
         gRYqlskDd6byUsaPR79pyExqCfAxeCtYHhFP4wLgvXIvDKjuUFX4Ky2146S39nBTKT9v
         tyUoY8IpRmKBOFjDJmmOSYa9A1EGsyEFYGPBHaGdaf1upJBLjCJI5wcmd3WyPtygXO62
         3ZVyW+amRMC0hQB4siVRSO80LebfyNs0Fs8jMA4hiBgKIFhfDBcP8sfOHBbwBvS9W001
         1uj9PidBJVv+a/qlfB657Uf6pEnTiLr02j6Ohqz7kAqq75ClCnGAmMzElxVRH+Ne1qHB
         5EDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=p+EWDMXRHCR4WGXjxAd95fZ6s4jh2V1mf44zmXuKSp4=;
        b=CC0D/FRjSoAksY4xaLLjNJ3+oK81bIix57m/u9EPFRIigSPFasNuPiHSIEzUHrXCKv
         sUNiPsYBiJzodE4SRxpl6PWUoIwaNbShJwyt8tOehZL9fbKCLG4385TNdmQXjK2FDtUl
         tfKiJb/fWUUApC28ejWKMQY68nrzSj70rpQrBaDER3UY+NwYfCePUyKDYD8QbWIO6dOl
         TaLD4Z2MLLaSBmRO3ZoZvLOKvOBWYeOK4IX2tG/Ts/EgSGKZxrMah0zeSQpyLgyC4XP9
         tHH1vZ03yIuJaA8ipt138henc4ClHf/Glg+kKN3bM0jMZxWNqFKe5SvSwwuMIVxkr3y+
         BVcg==
X-Gm-Message-State: AOAM532w+rADnBdR7mBMx9y4In1WnF6p+4ZSZyQ3XVnrIhcaz0QXO1sq
        9fCT4f9fMg53ZdBu1jifrppmFkmWco8zcP7w6GI=
X-Google-Smtp-Source: ABdhPJzo4b4SgBYpn9lapK69SuxGZP2yQKnbwrp5SnVQArRNk+LCJI039cLdZvGX2fNSUarYvjvWX0I0raRHLOSaSPM=
X-Received: by 2002:a17:90a:cd:: with SMTP id v13mr29235031pjd.81.1633939781673;
 Mon, 11 Oct 2021 01:09:41 -0700 (PDT)
MIME-Version: 1.0
References: <YWCOERbPXRrvaRN8@Andryuu.br>
In-Reply-To: <YWCOERbPXRrvaRN8@Andryuu.br>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Mon, 11 Oct 2021 11:09:30 +0300
Message-ID: <CA+U=Dsrovvtd=iG=pYm53eM0GiOaoMgWPPan2rCLbpiP0PVjOQ@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: lpc18xx_adc: Convert probe to device managed version
To:     =?UTF-8?Q?Andr=C3=A9_Gustavo_Nakagomi_Lopez?= <andregnl@usp.br>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, vz@mleia.com,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Oct 8, 2021 at 9:31 PM Andr=C3=A9 Gustavo Nakagomi Lopez
<andregnl@usp.br> wrote:
>
> The remove function and the goto sections are not necessary if devm
> functions are used.
>
> Convert device register to devm version. Add hook functions to release
> device resources, and use them inside probe with devm_add_action,
> which will release resources on driver detach.
>
> To maintain the order of which device resources were released/reseted,
> register the hook functions as soon as resources are obtained/initialized=
.
> Since devres actions are called on driver detach, the remove
> function and the error-handling goto sections are no longer necessary.
>

Hey,

Patch looks good overall.

A few notes:
1. you can now remove the "platform_set_drvdata(....)" call. The
private data is no longer needed.

> Signed-off-by: Andr=C3=A9 Gustavo Nakagomi Lopez <andregnl@usp.br>
> ---
> I was not able to test the patch due to the fact I do not have the necess=
ary hardware.
>  drivers/iio/adc/lpc18xx_adc.c | 60 +++++++++++++++++++----------------
>  1 file changed, 33 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/iio/adc/lpc18xx_adc.c b/drivers/iio/adc/lpc18xx_adc.=
c
> index 3566990ae87d..7b6ba5e4a003 100644
> --- a/drivers/iio/adc/lpc18xx_adc.c
> +++ b/drivers/iio/adc/lpc18xx_adc.c
> @@ -115,6 +115,23 @@ static const struct iio_info lpc18xx_adc_info =3D {
>         .read_raw =3D lpc18xx_adc_read_raw,
>  };
>
> +static void lpc18xx_writel(void *data)
> +{
> +       struct lpc18xx_adc *adc =3D data;
> +
> +       writel(0, adc->base + LPC18XX_ADC_CR);
> +}
> +
> +static void lpc18xx_clk_disable_unprepare(void *clk)
> +{
> +       clk_disable_unprepare(clk);
> +}
> +
> +static void lpc18xx_regulator_disable(void *vref)
> +{
> +       regulator_disable(vref);
> +}
> +
>  static int lpc18xx_adc_probe(struct platform_device *pdev)
>  {
>         struct iio_dev *indio_dev;
> @@ -163,46 +180,36 @@ static int lpc18xx_adc_probe(struct platform_device=
 *pdev)
>                 return ret;
>         }
>
> +       ret =3D devm_add_action_or_reset(&pdev->dev, lpc18xx_regulator_di=
sable, adc->vref);
> +       if (ret)
> +               return ret;
> +
>         ret =3D clk_prepare_enable(adc->clk);
>         if (ret) {
>                 dev_err(&pdev->dev, "unable to enable clock\n");
> -               goto dis_reg;
> +               return ret;
>         }
>
> +       ret =3D devm_add_action_or_reset(&pdev->dev, lpc18xx_clk_disable_=
unprepare,

You can leave this as-is.but   "lpc18xx_clk_disable" also works.
No strong opinion

> +                                      adc->clk);
> +       if (ret)
> +               return ret;
> +
>         adc->cr_reg =3D (clkdiv << LPC18XX_ADC_CR_CLKDIV_SHIFT) |
>                         LPC18XX_ADC_CR_PDN;
>         writel(adc->cr_reg, adc->base + LPC18XX_ADC_CR);
>
> -       ret =3D iio_device_register(indio_dev);
> -       if (ret) {
> -               dev_err(&pdev->dev, "unable to register device\n");
> -               goto dis_clk;
> -       }
> +       ret =3D devm_add_action_or_reset(&pdev->dev, lpc18xx_writel, adc)=
;

"lpc18xx_writel" is a little vague. Maybe "lpc18xx_clear_cr_reg()"
since this clears the control register.

> +       if (ret)
> +               return ret;
>
> -       return 0;
> +       ret =3D devm_iio_device_register(&pdev->dev, indio_dev);

You can directly do:
return devm_iio_device_register(&pdev->dev, indio_dev);

The kernel should print probe failure.

> +       if (ret)
> +               dev_err(&pdev->dev, "unable to register device\n");
>
> -dis_clk:
> -       writel(0, adc->base + LPC18XX_ADC_CR);
> -       clk_disable_unprepare(adc->clk);
> -dis_reg:
> -       regulator_disable(adc->vref);
>         return ret;
>  }
>
> -static int lpc18xx_adc_remove(struct platform_device *pdev)
> -{
> -       struct iio_dev *indio_dev =3D platform_get_drvdata(pdev);
> -       struct lpc18xx_adc *adc =3D iio_priv(indio_dev);
> -
> -       iio_device_unregister(indio_dev);
> -
> -       writel(0, adc->base + LPC18XX_ADC_CR);
> -       clk_disable_unprepare(adc->clk);
> -       regulator_disable(adc->vref);
> -
> -       return 0;
> -}
> -
>  static const struct of_device_id lpc18xx_adc_match[] =3D {
>         { .compatible =3D "nxp,lpc1850-adc" },
>         { /* sentinel */ }
> @@ -211,7 +218,6 @@ MODULE_DEVICE_TABLE(of, lpc18xx_adc_match);
>
>  static struct platform_driver lpc18xx_adc_driver =3D {
>         .probe  =3D lpc18xx_adc_probe,
> -       .remove =3D lpc18xx_adc_remove,
>         .driver =3D {
>                 .name =3D "lpc18xx-adc",
>                 .of_match_table =3D lpc18xx_adc_match,
> --
> 2.33.0
>
