Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC612D8E39
	for <lists+linux-iio@lfdr.de>; Sun, 13 Dec 2020 16:17:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729972AbgLMPRR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 13 Dec 2020 10:17:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405653AbgLMPRG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 13 Dec 2020 10:17:06 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E7FC0613CF
        for <linux-iio@vger.kernel.org>; Sun, 13 Dec 2020 07:16:26 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id w4so10705237pgg.13
        for <linux-iio@vger.kernel.org>; Sun, 13 Dec 2020 07:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vveAvkmmL5jQUVWD2QCzz/yshnEQLaPVC0MMPZy7p28=;
        b=WHaSDuj5gDtrs3rzitNVcQv1rEasiX4qzCoi5HRkJlWSADqjqvcrtWjh1JNKWycy78
         cPWwGU/APd+l6vXakAc1tajxGFL9yejVYWyZ1z9vdRdtPjnYPwkteSu8mQDSwmj+SkIu
         dPx0SQqECNLdZV0b9TINBUq8bC3OjLsRlG6Z5FPOqn+Vv6frIWPILaKsYkapmNeQqXV6
         UF6znVbY9YGRSHOevmVSHnNg3z1mUipoEFN/2CnEIcasDMQKrZ7/b54spT80aVtgxW83
         qLZ0Y64o6nuGHqYYwe8kdVYVlalj14Ga43Lo0LLZaVgzabWapCkWUhou+fq5yUpQHs5F
         dIbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vveAvkmmL5jQUVWD2QCzz/yshnEQLaPVC0MMPZy7p28=;
        b=ZJR/PS3PYv0gFV4BARH2oNj/ouZ9MZy6N1Bd6IbD12IM7ffz9of3KE5CDA9MAPDAqT
         HismqaDOX8nX88fiDCQqT8ToaRPzx90KwWJ5G7b565pf5xk6uVd2pKU2+7xshQS8KKCZ
         XJuXKivAu2ySvyokK08zclY1hHjbRypyoL+R9Pp/SpUk/4hOe27ET9yc+waw0ad8sVm/
         RD3smy/g1n4CX++68cJlTZ0GwQaQh+SisJi6D4zYTxajxkurGr932khSviDQmKKy0G2f
         IGd+gjgGAIv8z6QpVctuMe/Poo3JnKDyN+oFDScxCmwp7r5+F014xGFDFVvtsbCrwLif
         EFag==
X-Gm-Message-State: AOAM530WEKsGmFAvA/dxM8WnlHHgTu3Fndhjxm7/DUNTNqDN8ZkF/7id
        SgL6BnTokZRN6D8BbXuOS7Y+6DFOBCH/QufgEcA=
X-Google-Smtp-Source: ABdhPJxdRZ1fKZCQIWtJTlqXl/ow9Kxu2ANM9EWZ+N9ZHGu/DG/SihAWWL2HotAYfZrdmI428JMqY544y9mSKHkwLr8=
X-Received: by 2002:a05:6a00:170a:b029:19d:afca:4704 with SMTP id
 h10-20020a056a00170ab029019dafca4704mr19784529pfc.7.1607872585687; Sun, 13
 Dec 2020 07:16:25 -0800 (PST)
MIME-Version: 1.0
References: <20201101232211.1194304-1-linus.walleij@linaro.org>
In-Reply-To: <20201101232211.1194304-1-linus.walleij@linaro.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 13 Dec 2020 17:16:09 +0200
Message-ID: <CAHp75VefNu2geAM928HrJbpd8YV54WetNnjt0iVj-RRZ4F-DnA@mail.gmail.com>
Subject: Re: [PATCH] iio: afe: iio-rescale: Support processed channels
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Peter Rosin <peda@axentia.se>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Nov 2, 2020 at 1:23 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> It happens that an ADC will only provide raw or processed
> voltage conversion channels. (adc/ab8500-gpadc.c).
> On the Samsung GT-I9070 this is used for a light sensor
> and current sense amplifier so we need to think of something.
>
> The idea is to allow processed channels and scale them
> with 1/1 and then the rescaler can modify the result
> on top.

...

>         case IIO_CHAN_INFO_SCALE:
> -               ret = iio_read_channel_scale(rescale->source, val, val2);
> +               if (rescale->chan_processed) {
> +                       /*
> +                        * Processed channels are scaled 1-to-1
> +                        */

> +                       ret = IIO_VAL_FRACTIONAL;

A nit: Move this to the end of the branch, so in both branches the ret
= will be the last code line (for better readability).

> +                       *val = 1;
> +                       *val2 = 1;
> +               } else {
> +                       ret = iio_read_channel_scale(rescale->source, val, val2);
> +               }

-- 
With Best Regards,
Andy Shevchenko
