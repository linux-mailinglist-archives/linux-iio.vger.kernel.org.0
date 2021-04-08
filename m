Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA8D7358408
	for <lists+linux-iio@lfdr.de>; Thu,  8 Apr 2021 15:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbhDHNAq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 8 Apr 2021 09:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbhDHNAq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 8 Apr 2021 09:00:46 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9699C061760
        for <linux-iio@vger.kernel.org>; Thu,  8 Apr 2021 06:00:33 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id a85so1313156pfa.0
        for <linux-iio@vger.kernel.org>; Thu, 08 Apr 2021 06:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1W92jypCvFAyDshYCDFo6gKTYfJQA+6yai+cZD/kXYo=;
        b=TRgY2UkH5y/n5QBiFwLx9ujV4WYaeYkyNFjInw9jxjNH0Yn02rbtxw/6NAzF85Fy+M
         X8MDQLQtLRyAeI0WA96u/FXE+RUr1Ou/+vGSVLDdG1olnPOC4mmSKbpd2+e+fAqxbWha
         zoKR8LBhaokbn16MhokGVqGNHxhHMzxcx9mW/Cj+pK83Al4LOABnq2J7jE0dLjgAxAv7
         Pr6EVEhpT0UzS41VFtzrd6T5jha+LJ3Sns1TTkSlSevkSdfDghMPpzupeBzdaOHu9u75
         nqa4bXAQl/D3PX14W0Gh5OlnFQNUU8OFGaXjDayeOHR9hPJH7s6ubSbcnEYLVymlrvt0
         mPhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1W92jypCvFAyDshYCDFo6gKTYfJQA+6yai+cZD/kXYo=;
        b=UogWhi4jX92x7XgXN3PAvy0u7E4j0DIU5xeAalisPFkSZ28RgtnPy41VrttcuF+v+t
         tJmd2KwqbGVJBsdGUY9DGxz4yQR29c2TmEXpFZSEXJIwN8IH5Ypdwv3NDSbKzXrlPxYH
         MmsIVP1dNlGKNLz570EtF9mchE4yNso49p2x1h1UUGTdnmFtkNbIag1PgbbHKjyTHxSe
         3qsTD01RWHOFMLoMfUbSkp/oIhe7ivO/ozuzfauUMQC8d4L2iP+ZVXkM4V/QZD287cbD
         5sIHJaMPqfaX2UYC+wjcZPiyEsepYYmEs6pz2KFXNEDzFqYAynAaGpZgIwHtDYJ5wE9j
         77kQ==
X-Gm-Message-State: AOAM5321Jh/9Hc1rLeHOn89jf/WZJHEWM9Xrt+tfKxeSxHauKESMQgpD
        JEW72tt7jQI0pzqdh4FeopvrVzeleH9iyj25P9aQFBNni4I=
X-Google-Smtp-Source: ABdhPJw4PaIf3v+PdaZ9WNvSEJrla+3lZItFv5gjz6R99S9gGqlmGnIW/Y5y7ONFpZBYl35/P14tv14MjLfn+IxQ1sg=
X-Received: by 2002:a05:6a00:22c6:b029:201:1166:fdad with SMTP id
 f6-20020a056a0022c6b02902011166fdadmr7562853pfj.58.1617886832926; Thu, 08 Apr
 2021 06:00:32 -0700 (PDT)
MIME-Version: 1.0
References: <1617881896-3164-1-git-send-email-yangyicong@hisilicon.com> <1617881896-3164-2-git-send-email-yangyicong@hisilicon.com>
In-Reply-To: <1617881896-3164-2-git-send-email-yangyicong@hisilicon.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Thu, 8 Apr 2021 16:00:21 +0300
Message-ID: <CA+U=Dsqxms_GmnG=-P6J-fh130ZUhi8OYp7rc-a_C4WrYYwxFQ@mail.gmail.com>
Subject: Re: [PATCH 1/7] iio: adc: adi-axi-adc: simplify devm_adi_axi_adc_conv_register
To:     Yicong Yang <yangyicong@hisilicon.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        prime.zeng@huawei.com, Tian Tao <tiantao6@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Apr 8, 2021 at 2:42 PM Yicong Yang <yangyicong@hisilicon.com> wrote:
>
> Use devm_add_action_or_reset() instead of devres_alloc() and
> devres_add(), which works the same. This will simplify the
> code. There is no functional changes.
>

Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>

> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> ---
>  drivers/iio/adc/adi-axi-adc.c | 22 +++++++++-------------
>  1 file changed, 9 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
> index 9109da2..575a63f 100644
> --- a/drivers/iio/adc/adi-axi-adc.c
> +++ b/drivers/iio/adc/adi-axi-adc.c
> @@ -210,29 +210,25 @@ static void adi_axi_adc_conv_unregister(struct adi_axi_adc_conv *conv)
>         kfree(cl);
>  }
>
> -static void devm_adi_axi_adc_conv_release(struct device *dev, void *res)
> +static void devm_adi_axi_adc_conv_release(void *conv)
>  {
> -       adi_axi_adc_conv_unregister(*(struct adi_axi_adc_conv **)res);
> +       adi_axi_adc_conv_unregister(conv);
>  }
>
>  struct adi_axi_adc_conv *devm_adi_axi_adc_conv_register(struct device *dev,
>                                                         size_t sizeof_priv)
>  {
> -       struct adi_axi_adc_conv **ptr, *conv;
> -
> -       ptr = devres_alloc(devm_adi_axi_adc_conv_release, sizeof(*ptr),
> -                          GFP_KERNEL);
> -       if (!ptr)
> -               return ERR_PTR(-ENOMEM);
> +       struct adi_axi_adc_conv *conv;
> +       int ret;
>
>         conv = adi_axi_adc_conv_register(dev, sizeof_priv);
> -       if (IS_ERR(conv)) {
> -               devres_free(ptr);
> +       if (IS_ERR(conv))
>                 return ERR_CAST(conv);
> -       }
>
> -       *ptr = conv;
> -       devres_add(dev, ptr);
> +       ret = devm_add_action_or_reset(dev, devm_adi_axi_adc_conv_release,
> +                                      conv);
> +       if (ret)
> +               return ERR_PTR(ret);
>
>         return conv;
>  }
> --
> 2.8.1
>
