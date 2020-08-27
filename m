Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF712540C6
	for <lists+linux-iio@lfdr.de>; Thu, 27 Aug 2020 10:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbgH0I13 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 27 Aug 2020 04:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbgH0I13 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 27 Aug 2020 04:27:29 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A1B7C061264;
        Thu, 27 Aug 2020 01:27:29 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id z18so2250016pjr.2;
        Thu, 27 Aug 2020 01:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HZu39BmrS22KD4B9ZU5A9XCIkFWAsFL80Y7SUDG2qtE=;
        b=oqBSHp+HrXhPE9QUUx68UGa9/YcMBY4IZZmU8tQEHoL0eR6q+q9L3KJxyU+5smq+mh
         Qpb47EuOJNxtnzUze/6j+DruJ9FAig6k1cmSSVZe4HSNqO71XXMp0HWKvL//Jn/SrsVg
         XDbTdaVO9ZDB9BadUVb0EXv/8MSvaT+iNh4DUhmXqSPdRZA+FvIWaEBj0KvH7/jwmzlc
         kbK+AW0LRTkel5HNUFj1MK2DXbFfjbShHU7ash7Sspa9HWszpy9Gmt3BpJ8DPsAlNMxF
         /XJN/Pw5pnUN3rRoxjBCOhTrLosJSp8mDe6aGlHjEfTDwyJ7xlixtSkiGR3gw2hRCCMF
         7Bag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HZu39BmrS22KD4B9ZU5A9XCIkFWAsFL80Y7SUDG2qtE=;
        b=PPAJ4nAx9Z25LG6kCDAHrAc33AsyVyBLPw/emyofQ1ZH10OpFwJDOqlB8XkPS7PVnG
         5egFm+7vxXPxmDGG6H1y7hfhLeogk5bUisnpTOwuceTi0izFbUBslDNSAbuSFaBwbJrn
         QKEqD7sKPjUhAn/V4LnmRS6lS/MfBMGMs9yiQuZw0ojH9KqW/zFYYyYBj6ZNFa2eizF3
         rTd5OVobeRijL7MA9ciyhGhUJe59HeFzFOgzyikliHPcmZRhK6ryu9sqNFxbNgQtwrog
         lEEGz/bs77cj6X2AggPNI/JqxMLSvbVQZcbkqWXiJ9NvK4IPAb2S1WlfC8WG7c/7FaJs
         hzhA==
X-Gm-Message-State: AOAM530ylKPK2EXqCiJf7svK8FtR6RmD6up/tjjm5LZxNvYHjb/cFkJx
        fUxUKvSwAcwFUNyzdXAVUZXnLrehQCGIoG6D4gU=
X-Google-Smtp-Source: ABdhPJy7FFxyHMt/VY+0213GOuICfPnBcgRzlKo9w1yk5kPoOdyCc69OPZ9PWgEDp1GqqASWBQKX2axNN3k90TDpCTE=
X-Received: by 2002:a17:90a:2c06:: with SMTP id m6mr9988021pjd.129.1598516848820;
 Thu, 27 Aug 2020 01:27:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200826161818.20969-1-krzk@kernel.org>
In-Reply-To: <20200826161818.20969-1-krzk@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 27 Aug 2020 11:27:12 +0300
Message-ID: <CAHp75Vf3s0+RrHnBoO4y4+t4Egth4uyYwtO5iPt9DbLJcunL6g@mail.gmail.com>
Subject: Re: [PATCH v2] iio: adc: stm32: Simplify with dev_err_probe()
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Etienne Carriere <etienne.carriere@st.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Aug 26, 2020 at 7:19 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> Common pattern of handling deferred probe can be simplified with
> dev_err_probe().  Less code and also it prints the error value.






>         priv->aclk = devm_clk_get(&pdev->dev, "adc");
>         if (IS_ERR(priv->aclk)) {
>                 ret = PTR_ERR(priv->aclk);
> -               if (ret != -ENOENT) {
> -                       if (ret != -EPROBE_DEFER)
> -                               dev_err(&pdev->dev, "Can't get 'adc' clock\n");
> -                       return ret;
> -               }
> +               if (ret != -ENOENT)
> +                       return dev_err_probe(&pdev->dev, ret, "Can't get 'adc' clock\n");
> +
>                 priv->aclk = NULL;
>         }
>
>         priv->bclk = devm_clk_get(&pdev->dev, "bus");
>         if (IS_ERR(priv->bclk)) {
>                 ret = PTR_ERR(priv->bclk);
> -               if (ret != -ENOENT) {
> -                       if (ret != -EPROBE_DEFER)
> -                               dev_err(&pdev->dev, "Can't get 'bus' clock\n");
> -                       return ret;
> -               }
> +               if (ret != -ENOENT)
> +                       return dev_err_probe(&pdev->dev, ret, "Can't get 'bus' clock\n");
> +
>                 priv->bclk = NULL;
>         }

Again, devm_clk_get_optional() and even, if it exists,
devm_clk_bulk_get_optional().

Please, revisit all patches on this topic.

-- 
With Best Regards,
Andy Shevchenko
