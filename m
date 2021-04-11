Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35EF935B462
	for <lists+linux-iio@lfdr.de>; Sun, 11 Apr 2021 15:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235127AbhDKM4w (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 11 Apr 2021 08:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232223AbhDKM4v (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 11 Apr 2021 08:56:51 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A71BFC061574;
        Sun, 11 Apr 2021 05:56:35 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id u17so15787923ejk.2;
        Sun, 11 Apr 2021 05:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oynzuJfbEuJy5CAi4BYsSwCXKoAbx8chkskNNbIaZUc=;
        b=dYSca6rnYbBivsWCz89w9cmwPA+/gQbdvnRkH3LP3Xt2PG8vA1nrwTlWSgtiHVp54y
         MuBnlmeDmAPYAxsSyYXkF5qP1pm44CXfehQ7rq5ISNpGeAfHAyiUOMijiySqRbNihyoz
         jpi49GGstN9GOQD/2DoU6tDk73dv288XLHVbHJEYGxr7BLcHSl6gC4whCBg8n3ZmAjKf
         9bzVEP2sSqfxPtNx34Pe3DO1haBVbWCvZZBKhXQbyWH3pZq4ubMWix4hn/V+qfmPk4lJ
         /+2EPirL3RzucUsgpgh8yp0W5fOUvPoYcnaWNy8tMDLRcHgZkN0nCB2ozFnyp+N4sp4/
         QfMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oynzuJfbEuJy5CAi4BYsSwCXKoAbx8chkskNNbIaZUc=;
        b=PaP475A2FOIDZV5PeTvYUiqmlz7x4AGpiV+awnGcRSWQ9U/5zH6KFp1MrmCEBAzeTs
         1BOdTLu0eT/wazySED3t94rUnb5Ei3W/SF7+T1nVU24qwH10AXAfdQMo59dcwMvh6kl1
         EQzIy5tsuMBHU9jtR7ZgkPfKKwCqqDcJMB77u3SgC9fJso16ix2HYAMbYBdmW6HxAjz2
         65r9wAvrNRZ+Z9RFKCPpARY+iOTcCddKx5s7ahlJaCXKikaNkJcAEH2o6d48aVow5I42
         zwear2+lmQqlD/HlTSOXGPC4/Pu85Io/CCymEEVj3Le9nBOhwMrq9fewCXoVgmn+NdB+
         t1gw==
X-Gm-Message-State: AOAM533p7uh0uiFsFpAD0aKcEtg/Mhxk/0jQMoiwvlapL7n5YizFk0Yc
        yksMyjpOUA+t9jvW5Bk/AxBHKFCM7n4J+VX4dKg=
X-Google-Smtp-Source: ABdhPJyCOx9h49w/ftcNHVbJ1EjPrtcZALSk0GTjju9d0oD0Y7686M5S3XPPhhPuxC/hhK2BNPGaA3pratg46098AMs=
X-Received: by 2002:a17:906:b104:: with SMTP id u4mr23214266ejy.211.1618145794324;
 Sun, 11 Apr 2021 05:56:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210410164728.8096-1-krzysztof.kozlowski@canonical.com>
In-Reply-To: <20210410164728.8096-1-krzysztof.kozlowski@canonical.com>
From:   Alim Akhtar <alim.akhtar@gmail.com>
Date:   Sun, 11 Apr 2021 18:25:58 +0530
Message-ID: <CAGOxZ51PKMZoPyk-kidGRr7zNvADfjAJG8LtMMBOi0vn-KBsLA@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: exynos: drop unneeded variable assignment
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Apr 10, 2021 at 10:18 PM Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> The initialization of 'ret' variable in probe function is shortly after
> overwritten.  This initialization is simply not used.
>
> Addresses-Coverity: Unused value
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
Thanks Krzysztof,
Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>

>  drivers/iio/adc/exynos_adc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/adc/exynos_adc.c b/drivers/iio/adc/exynos_adc.c
> index 784c10deeb1a..2d8e36408f0e 100644
> --- a/drivers/iio/adc/exynos_adc.c
> +++ b/drivers/iio/adc/exynos_adc.c
> @@ -794,7 +794,7 @@ static int exynos_adc_probe(struct platform_device *pdev)
>         struct s3c2410_ts_mach_info *pdata = dev_get_platdata(&pdev->dev);
>         struct iio_dev *indio_dev = NULL;
>         bool has_ts = false;
> -       int ret = -ENODEV;
> +       int ret;
>         int irq;
>
>         indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(struct exynos_adc));
> --
> 2.25.1
>


-- 
Regards,
Alim
