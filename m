Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED09E35841B
	for <lists+linux-iio@lfdr.de>; Thu,  8 Apr 2021 15:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbhDHNFH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 8 Apr 2021 09:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbhDHNFH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 8 Apr 2021 09:05:07 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F404CC061760
        for <linux-iio@vger.kernel.org>; Thu,  8 Apr 2021 06:04:55 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id mj7-20020a17090b3687b029014d162a65b6so3146134pjb.2
        for <linux-iio@vger.kernel.org>; Thu, 08 Apr 2021 06:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8pKY/H8rhgGynfA3oYtpjksXb+dIMQTOagzLP+mHp3c=;
        b=LRAozj9qYUstDlD/GhcWCZnRVKCZCvhLay9uxJyS1tHsEZg3+QeMimoHjHsQXiiUJ9
         Jc1CoGtCJQAbpGf3UmOT0PcvL5ZlRym95leH9nTut3Cy9nwUtasCQ/7yzAUVah2deVx8
         qq9374jSJibu8eWtsX6L7KAi7I3U92XZei1iO4VAN9hdITCQYRnM6GANK2F4KNJIOQqV
         WrRaIeaQBwpJv76TpZt0e3M1jbPQaLXan6d9aiViSe5E8H+NVQGpkgGYkOhrqiZHiBFi
         B7cwfXj5ne7hoJsUMEIerdvNBl/wJV9I0lYaXa0siDsqTFehfxhJad0y9X4R71Qw6yKK
         bwRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8pKY/H8rhgGynfA3oYtpjksXb+dIMQTOagzLP+mHp3c=;
        b=nLlreHLPm5IJ4IV4r1PqaDShKqT+8qsa6UE7PaREpaf/Vayt2UqWB6JJMhXZc0wyui
         09BN6HlPbZKPQl9KGVXpka2D+k/c+Lki/pLn9G6OFI47zFlYalX2ZdNmDra8RG3iIiFx
         dzhVGqolVLjV9dyKqdO9dsJDk1MfKiEuIj4dp75dx4+ZUcrGxuaOOa6BZJJB8LZ/+BRV
         OABnvXwG/1qJXHq/cnjNtzBJDTRHxdL9cvjMpS8v8PQs58ezj2mpQsszZK8v+bZr4Z+8
         6MktpwZowu3SmJBAwwiK6GCLcgATfJVa2NZBRyW6A4Ka7Wyq8jcMf+KfrF8kGmwvZQAA
         i9WA==
X-Gm-Message-State: AOAM530J5oOKOHS8gyYMnjSXvL9fd43ongL4v2q8FYIo1g1z2d0Rfpfa
        8Fvhbrsb1GHK0lkxGMVMu8k2m4WZxr7/YbyOh+U=
X-Google-Smtp-Source: ABdhPJz2ZpLCKEIbjaJYUMPVnpcu4xscTK6E0g6epDCZUiOWBPTPk1qaVAn9ERYosYcy40wvOgFzQ+t741CHpYxaLd4=
X-Received: by 2002:a17:902:c641:b029:e9:4226:beca with SMTP id
 s1-20020a170902c641b02900e94226becamr7899468pls.38.1617887095476; Thu, 08 Apr
 2021 06:04:55 -0700 (PDT)
MIME-Version: 1.0
References: <1617881896-3164-1-git-send-email-yangyicong@hisilicon.com> <1617881896-3164-2-git-send-email-yangyicong@hisilicon.com>
In-Reply-To: <1617881896-3164-2-git-send-email-yangyicong@hisilicon.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Thu, 8 Apr 2021 16:04:44 +0300
Message-ID: <CA+U=Dsqia_QVcgJTWo_3s07H-FeZ3xmoE2XVCROFMdrP7iNsiw@mail.gmail.com>
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

On a second pass, I'm wondering if this requires a cast like

static void devm_adi_axi_adc_conv_release(void *data)
{
       struct adi_axi_adc_conv *conv = data;

If the compiler doesn't complain, that I'm fine

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
